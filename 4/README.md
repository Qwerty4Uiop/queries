# Description
The script displays a list of employees which includes the following data:
1. Employee ID  
2. The year when the employee was recruited  
3. Employee's name  
4. Employee's surname 
5. Salary  
6. "Place" of the employee in the group taken to work in the same year, ordered in descending salary, and in case of equality of wages as the employee's ID increases. 

The result is ordered:
1. By the year of employment in ascending order.
2. By employee's ID in ascending order.
# Example
In 1987, 3 employees were employed by the company:  
| Employee ID | Last name | Salary |  
|:-----------:|-----------|:------:|  
| 100 | King | 24000 |  
| 200 | Whalen | 4400 |  
| 207 | Smith | 4400 |  
King is given the first place, because he has the largest salary.  
Whalen and Smith have the same salaries, less than King's. But, the Whalen's ID is less than the Smith's, so Whalen is assigned the second place, and Smith is the third.  
