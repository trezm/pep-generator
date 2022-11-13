use askama::Template;
use log::{error, info};
use rand::Rng;
use shuttle_service::error::CustomError;
use sqlx::{Executor, FromRow, PgPool, Pool, Postgres};
use thruster::{
    context::{basic_hyper_context::HyperRequest, typed_hyper_context::TypedHyperContext},
    errors::{ErrorSet, ThrusterError},
    m, middleware_fn, App, Context, HyperServer, MiddlewareNext, MiddlewareResult, ThrusterServer,
};

pub type Ctx = TypedHyperContext<RequestConfig>;

pub struct ServerConfig {
    pub pool: Pool<Postgres>,
}

#[derive(Clone)]
pub struct RequestConfig {
    pub pool: Pool<Postgres>,
}

fn generate_context(request: HyperRequest, state: &ServerConfig, _path: &str) -> Ctx {
    Ctx::new(
        request,
        RequestConfig {
            pool: state.pool.clone(),
        },
    )
}

#[derive(Template)]
#[template(path = "home.html")]
pub struct Home<'a> {
    first: &'a str,
    second: &'a str,
    third: &'a str,
    fourth: &'a str,
}

#[derive(Debug, FromRow)]
pub struct Phrase {
    pub id: i32,
    pub item: String,
}

async fn fetch_phrase(pool: &Pool<Postgres>, table: &str) -> Result<Phrase, sqlx::Error> {
    sqlx::query_as(&format!("SELECT id, item FROM {} WHERE id = $1", table))
        .bind(rand::rngs::OsRng::default().gen_range(1..=18))
        .fetch_one(pool)
        .await
}

#[middleware_fn]
pub async fn hello(mut context: Ctx, _next: MiddlewareNext<Ctx>) -> MiddlewareResult<Ctx> {
    let phrase_1 = fetch_phrase(&context.extra.pool, "first_list")
        .await
        .map_err(|_e| {
            error!("_e: {:#?}", _e);
            ThrusterError::generic_error(Ctx::new_without_request(context.extra.clone()))
        })?;

    let phrase_2 = fetch_phrase(&context.extra.pool, "second_list")
        .await
        .map_err(|_e| {
            error!("_e: {:#?}", _e);
            ThrusterError::generic_error(Ctx::new_without_request(context.extra.clone()))
        })?;

    let phrase_3 = fetch_phrase(&context.extra.pool, "third_list")
        .await
        .map_err(|_e| {
            error!("_e: {:#?}", _e);
            ThrusterError::generic_error(Ctx::new_without_request(context.extra.clone()))
        })?;

    let phrase_4 = fetch_phrase(&context.extra.pool, "fourth_list")
        .await
        .map_err(|_e| {
            error!("_e: {:#?}", _e);
            ThrusterError::generic_error(Ctx::new_without_request(context.extra.clone()))
        })?;

    context.set("Content-Type", "text/html");
    context.body(
        &Home {
            first: &phrase_1.item,
            second: &phrase_2.item,
            third: &phrase_3.item,
            fourth: &phrase_4.item,
        }
        .render()
        .unwrap(),
    );

    Ok(context)
}

#[shuttle_service::main]
async fn thruster(
    #[shuttle_aws_rds::Postgres] pool: PgPool,
) -> shuttle_service::ShuttleThruster<HyperServer<Ctx, ServerConfig>> {
    info!("Starting server...");

    pool.execute(include_str!("../schema.sql"))
        .await
        .map_err(|e| CustomError::new(e))?;

    info!("Server started...");

    Ok(HyperServer::new(
        App::<HyperRequest, Ctx, ServerConfig>::create(generate_context, ServerConfig { pool })
            .get("/", m![hello]),
    ))
}
