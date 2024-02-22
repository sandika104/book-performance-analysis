# DAX Power BI
The DAXs that I used in this project include:

1. Creating a measure cnt_book_title. To be used as a filter to get the book with the highest number of copies:  
cnt_book_title =   
VAR cnt_book =  
&ensp;&ensp;&ensp;&ensp;COUNTX(books, books[book_title])  
VAR top_pick =  
&ensp;&ensp;MAXX(  
&ensp;&ensp;&ensp;TOPN(1,books, cnt_book, desc),   
&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;cnt_book)  
RETURN  
top_pick

2. Create measure to summarize ratings by country:   
(before that) create a country column from the location column through "edit query".
sum_rating_country =   
SUMX(  
&ensp;&ensp;&ensp;&ensp;VALUES(users[user_id]),  
&ensp;&ensp;&ensp;&ensp;CALCULATE(  
&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;SUM(ratings[book_rating]),  
&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;NOT(ISBLANK(users[country]))  
&ensp;&ensp;)  
)

4. Create an age category column in the rating table:  
age_group_cnt =   
SWITCH(  
&ensp;&ensp;&ensp;&ensp;TRUE(),  
&ensp;&ensp;&ensp;&ensp;users[age] >= 1 && users[age] <= 20, "Young",  
&ensp;&ensp;&ensp;&ensp;users[age] >= 21 && users[age] <= 60, "Adult",  
&ensp;&ensp;&ensp;&ensp;users[age] >= 61 && users[age] <= 100, "Old",  
&ensp;&ensp;&ensp;&ensp;BLANK()  
)

5. Create additional measures such as DISTINCTCOUNT, SUM, COUNT, etc.
