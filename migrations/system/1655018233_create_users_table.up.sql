-- +migrate Up
-- +migrate StatementBegin

-- USERS TABLE
CREATE TABLE IF NOT EXISTS articles (
    article_id serial NOT NULL primary key,
    name varchar(50) NOT NULL,
    created_date timestamptz default now(),
    updated_date timestamptz
);

create unique index article_article_id_uindex
    on articles (article_id);
-- +migrate StatementEnd

-- +migrate Down
DROP TABLE IF EXISTS articles;