-- Creating the users table
CREATE TABLE IF NOT EXISTS first_list (
    id SERIAL PRIMARY KEY,
    item TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS second_list (
    id SERIAL PRIMARY KEY,
    item TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS third_list (
    id SERIAL PRIMARY KEY,
    item TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS fourth_list (
    id SERIAL PRIMARY KEY,
    item TEXT NOT NULL
);

-- Okay... yes, this took more than five minutes for me to copy...
INSERT INTO first_list (id, item)
VALUES
    (1, 'Champ,'),
    (2, 'Fact:'),
    (3, 'Everybody says'),
    (4, 'Dang...'),
    (5, 'Check it:'),
    (6, 'Just saying...'),
    (7, 'Superstar,'),
    (8, 'Tiger,'),
    (9, 'Self,'),
    (10, 'Know this:'),
    (11, 'News alert:'),
    (12, 'Girl,'),
    (13, 'Ace,'),
    (14, 'Excuse me but'),
    (15, 'Experts agree:'),
    (16, 'In my opinion,'),
    (17, 'Hear ye, hear ye:'),
    (18, 'Okay, listen up:')
ON CONFLICT (id) DO UPDATE
    SET item = excluded.item;

INSERT INTO second_list (id, item)
VALUES
    (1, 'the mere idea of you'),
    (2, 'your soul'),
    (3, 'your hair today'),
    (4, 'everything you do'),
    (5, 'your personal style'),
    (6, 'every thought you have'),
    (7, 'that sparkle in your eye'),
    (8, 'your presence here'),
    (9, 'what you got going on'),
    (10, 'the essential you'),
    (11, 'your life''s journey'),
    (12, 'that saucy personality'),
    (13, 'your DNA'),
    (14, 'that brain of yours'),
    (15, 'your choice of attire'),
    (16, 'the way you roll'),
    (17, 'whatever your secret is'),
    (18, 'all of y''all')
ON CONFLICT (id) DO UPDATE
    SET item = excluded.item;

INSERT INTO third_list (id, item)
VALUES
    (1, 'has serious game,'),
    (2, 'rains magic,'),
    (3, 'deserves the Nobel Prize,'),
    (4, 'raises the roof,'),
    (5, 'breeds miracles,'),
    (6, 'is paying off big time,'),
    (7, 'shows mad skills,'),
    (8, 'just shimmers,'),
    (9, 'is a national treasure,'),
    (10, 'gets the party hopping,'),
    (11, 'is the next big thing,'),
    (12, 'roars like a lion,'),
    (13, 'is a rainbow factory,'),
    (14, 'is made of diamonds,'),
    (15, 'makes birds sing,'),
    (16, 'should be taught in school,'),
    (17, 'makes my world go ''round,'),
    (18, 'is 100% legit,')
ON CONFLICT (id) DO UPDATE
    SET item = excluded.item;

INSERT INTO fourth_list (id, item)
VALUES
    (1, '24/7.'),
    (2, 'can I get an amen?'),
    (3, 'and that''s a fact.'),
    (4, 'so treat yourself.'),
    (5, 'you feel me?'),
    (6, 'that''s just science.'),
    (7, 'would I lie?'),
    (8, 'for reals.'),
    (9, 'mic drop.'),
    (10, 'you hidden gem.'),
    (11, 'snuggle bear.'),
    (12, 'period.'),
    (13, 'can I get an amen?'),
    (14, 'now lets dance.'),
    (15, 'high five.'),
    (16, 'say it again!'),
    (17, 'according to CNN.'),
    (18, 'so get used to it.')
ON CONFLICT (id) DO UPDATE
    SET item = excluded.item;
