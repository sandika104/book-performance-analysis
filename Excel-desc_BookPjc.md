# Excel Rundown

## Inserting Data
- books.csv
- ratings.csv
- users.csv

## Data Cleaning
Books Table
- Delete "0" value from column "Year-Of-Publication (4618 rows founds)
- Delete the blank and errors value from all column on books table

Ratings Table
- In column "Book-Rating" from ratings table, delete the "0" value. because this value is less useful in analyzing book recommendations

Users Table
- Delete the errors value from USer-ID column on users table
- Delete "NULL" and "0" value from column Age

## Modify Format
Books Table
- ISBN                = TEXT
- Book-Title          = TEXT
- Book-Author         = TEXT
- Year-Of-Publication = NUMBER (This column cannot be changed to date format, or it will be an error)
- Publisher           = TEXT

Ratings Table
- User-ID             = NUMBER
- ISBN                = TEXT
- Book-Rating         = NUMBER

Users Table
- User-ID             = NUMBER
- Location            = TEXT
- Age                 = NUMBER

## Summary Statistics
### Books Table ---

![image](https://github.com/sandika104/book-recommend-analysis/assets/153609763/f29ccfdb-44d9-45c1-b90d-09211510e050)

<img src="https://github.com/sandika104/book-recommend-analysis/assets/153609763/98ab0b12-a2e9-4482-830d-63f284b4685f" width=45% height=45%>  
  
- There are very large outliers in the range of years <1400, we should remove them to maintain data quality

<img src="https://github.com/sandika104/book-recommend-analysis/assets/153609763/21fca8ee-0689-4264-a1c3-d0eeeca3afbb" width=45% height=45%>  

- Interpretation:

It is known that the most data distribution is between 1990 - 2000. The distribution in Q1 and Q2 looks quite balanced. But there is a big outlier in the numbers from 1970 and below. This is what causes the kurtosis value to be at 231.8 and far from a normal distribution.

It is also known that the average value is 1993.68 with the middle value being 1996 and the highest value being 2002. There is a standard deviation of 8.3, and there is a skewness of -4.5754, which means the data is skewed towards the left and most of the data has poor values. from the average value.

But because this is a year column, I think this data is still acceptable.


### Ratings Table ---

![image](https://github.com/sandika104/book-recommend-analysis/assets/153609763/d3dfcd52-173a-44ae-98ba-34b182575140)

<img src="https://github.com/sandika104/book-recommend-analysis/assets/153609763/3d87d196-3faf-4547-9919-eb71d84c73e8" width=45% height=45%>  

- Interpretation:

It can be seen that the most data distribution is between 7(Q1) and 9(Q2). 25% are rated below 7, with a rating below 4. The remaining 25% are between 9-10.

The average value is 7.6 with a middle value of 8 and the highest value is 8. There is a standard deviation of 1.8, which is very good and there is a skewness of -0.6556, which means the data is skewed towards the left and most of the data has the same value. less than the average value. Finally, there is kurtosis with a value of 0.134, which means the data distribution is good.


### Users Table ---

![image](https://github.com/sandika104/book-recommend-analysis/assets/153609763/8906d498-75c8-4777-85b5-d01565d53fd6)

<img src="https://github.com/sandika104/book-recommend-analysis/assets/153609763/b98fed5f-c67c-40f4-9f0b-3af8d8182b4d" width=45% height=45%>  

- Adjusting for data that doesn't make sense, I will filter the age in the range of 7-100 years only

<img src="https://github.com/sandika104/book-recommend-analysis/assets/153609763/9b74d7c0-2bf3-4bc4-a26d-b02ee7642707" width=45% height=45%>  

- Interpretation:

It can be seen that the largest distribution of data is in the number range 25 - 45. In this data there are quite a lot of values above 45, with several outliers after the number 75. This is because the age range of the outlier is far from the average age.

This data has an average value of 34.63 with the middle value being 32 and the highest value being 24. We can assume they are people who will or are currently working. There is a standard deviation of 14.02 which is quite high and there is a skewness of -0.9945 which means the data is skewed to the right and the majority have an age that is greater than the average value.

