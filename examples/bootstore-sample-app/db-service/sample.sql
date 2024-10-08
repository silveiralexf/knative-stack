CREATE DATABASE bookstore;
CREATE TABLE IF NOT EXISTS book_reviews(
                                           id SERIAL PRIMARY KEY,
                                           post_time timestamp NOT NULL,
                                           content TEXT NOT NULL,
                                           sentiment TEXT,
                                           CONSTRAINT sentiment_check CHECK (sentiment IN ('positive', 'negative', 'neutral'))
);

INSERT INTO book_reviews (post_time, content, sentiment) VALUES
                                                             ('2020-01-01 00:00:00', 'This book is great!', 'positive'),
                                                             ('2020-01-02 00:02:00', 'This book is terrible!', 'negative'),
                                                             ('2020-01-03 00:01:30', 'This book is okay.', 'neutral'),
                                                             ('2020-01-04 00:00:00', 'Meh', 'neutral');
