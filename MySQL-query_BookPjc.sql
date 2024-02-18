# create new database 
CREATE DATABASE book_recommendation;

# select database 
USE book_recommendation;

CREATE TABLE books (
    isbn VARCHAR(20) NOT NULL,
    book_title VARCHAR(200) NOT NULL,
    book_author VARCHAR(100) NOT NULL,
    year_of_publication INT NOT NULL,
    publisher VARCHAR(100) NOT NULL,
    PRIMARY KEY (isbn),
    FULLTEXT book_search ( book_title )
);

CREATE TABLE ratings (
    user_id INT NOT NULL,
    isbn VARCHAR(20) NOT NULL,
    book_rating INT NOT NULL
);

CREATE TABLE users (
    user_id INT NOT NULL,
    location VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    PRIMARY KEY (user_id)
);

# insert file data
LOAD DATA INFILE "file_path.csv"
INTO TABLE books  #--books/ratings/users
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

# Questions
-- 1. What are the most sold books in this dataset? --
SELECT 
    book_title AS best_seller, COUNT(book_title) AS copies
FROM
    books
GROUP BY book_title
ORDER BY copies DESC
LIMIT 3;

-- 2. Who is the author with the most number of books? --
SELECT 
    book_author AS Author_Name,
    COUNT(DISTINCT book_title) AS total_books
FROM
    books
GROUP BY author_name
ORDER BY total_books DESC
LIMIT 3;

-- 3. Which authors use the same publisher the most for their books? --
SELECT 
    book_author AS Author_Name,
    publisher,
    COUNT(DISTINCT book_title) AS cnt
FROM
    books
GROUP BY author_name , publisher
ORDER BY cnt DESC
LIMIT 3;

-- 4. Is there a relationship between a book's rating and its publication year? --
SELECT 
    SUM(CASE
        WHEN year_of_publication BETWEEN '1900' AND '1950' THEN book_rating
        ELSE 0
    END) AS OldBooks,
    SUM(CASE
        WHEN year_of_publication BETWEEN '1951' AND '2000' THEN book_rating
        ELSE 0
    END) AS MiddleAgeBooks,
    SUM(CASE
        WHEN year_of_publication BETWEEN '2001' AND '2050' THEN book_rating
        ELSE 0
    END) AS NewBooks,
    SUM(book_rating) AS total_ratings
FROM
    books
        JOIN
    ratings ON (books.isbn = ratings.isbn);

-- 5. Which publisher gets the highest number of ratings? --
SELECT 
    publisher, SUM(book_rating) AS total_ratings
FROM
    books
        JOIN
    ratings ON (books.isbn = ratings.isbn)
GROUP BY publisher
ORDER BY total_ratings DESC
LIMIT 3;

-- 6. Who are the publishers with the most books in this dataset? --
SELECT 
    publisher, COUNT(DISTINCT book_title) AS cnt
FROM
    books
GROUP BY publisher
ORDER BY cnt DESC
LIMIT 3;

-- 7. Which location has the most users? --
SELECT 
    location, COUNT(user_id) AS total_users
FROM
    users
GROUP BY location
ORDER BY total_users DESC
LIMIT 3;

-- 8. How does user age affect book ratings? --
SELECT 
    SUM(CASE
        WHEN age >= 1 AND age <= 20 THEN book_rating
        ELSE 0
    END) AS young,
    SUM(CASE
        WHEN age >= 21 AND age <= 60 THEN book_rating
        ELSE 0
    END) AS adult,
    SUM(CASE
        WHEN age >= 61 AND age <= 100 THEN book_rating
        ELSE 0
    END) AS old
FROM
    users
        JOIN
    ratings ON (users.user_id = ratings.user_id);

-- 9. Is there a difference in the rating of the book between different country? --
SELECT DISTINCT
    SUBSTRING_INDEX(location, ',', - 1) AS country,
    SUM(book_rating) AS total_ratings
FROM
    users
        JOIN
    ratings ON (users.user_id = ratings.user_id)
WHERE
    TRIM(SUBSTRING_INDEX(location, ',', - 1)) != ''
GROUP BY country
ORDER BY total_ratings DESC;

-- 10. Is there a relationship between the book's rating and other factors such as author, publisher, or publication year? --
SELECT 
    'OldBooks' AS Category,
    SUM(CASE
        WHEN year_of_publication BETWEEN 1900 AND 1950 THEN book_rating
        ELSE 0
    END) AS total_ratings,
    (SELECT 
            COUNT(DISTINCT book_author)
        FROM
            books
        WHERE
            year_of_publication BETWEEN 1900 AND 1950) AS cnt_author,
    (SELECT 
            COUNT(DISTINCT publisher)
        FROM
            books
        WHERE
            year_of_publication BETWEEN 1900 AND 1950) AS cnt_publisher
FROM
    ratings
        JOIN
    books ON (books.isbn = ratings.isbn) 
UNION ALL SELECT 
    'MiddleAgeBooks' AS Category,
    SUM(CASE
        WHEN year_of_publication BETWEEN 1951 AND 2000 THEN book_rating
        ELSE 0
    END) AS total_ratings,
    (SELECT 
            COUNT(DISTINCT book_author)
        FROM
            books
        WHERE
            year_of_publication BETWEEN 1951 AND 2000) AS cnt_author,
    (SELECT 
            COUNT(DISTINCT publisher)
        FROM
            books
        WHERE
            year_of_publication BETWEEN 1951 AND 2000) AS cnt_publisher
FROM
    ratings
        JOIN
    books ON (books.isbn = ratings.isbn) 
UNION ALL SELECT 
    'NewBooks' AS Category,
    SUM(CASE
        WHEN year_of_publication BETWEEN 2001 AND 2050 THEN book_rating
        ELSE 0
    END) AS total_ratings,
    (SELECT 
            COUNT(DISTINCT book_author)
        FROM
            books
        WHERE
            year_of_publication BETWEEN 2001 AND 2050) AS cnt_author,
    (SELECT 
            COUNT(DISTINCT publisher)
        FROM
            books
        WHERE
            year_of_publication BETWEEN 2001 AND 2050) AS cnt_publisher
FROM
    ratings
        JOIN
    books ON (books.isbn = ratings.isbn);