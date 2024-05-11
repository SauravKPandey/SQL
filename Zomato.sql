CREATE Database	Bank_Performance
drop zomato

Select * from Bank_Performance.dbo.zomato
EXPLAIN PLAN FOR SELECT * FROM Bank_Performance.dbo.zomato WHERE Restaurant_ID = 66;

Select Avg(Cast(Average_Cost_For_two As float))  as A2 from Bank_Performance.dbo.zomato

Select Avg(Convert(float, Average_Cost_For_two))  as A2 from Bank_Performance.dbo.zomato

Select * from Bank_Performance.dbo.zomato Where Convert(float, Average_Cost_For_two) >  (Select Avg(Convert(float, Average_Cost_For_two))  as A2 from Bank_Performance.dbo.zomato
With Avg_Cost_for_2(Avg_cost) As 
	(Select Avg(Cast(Average_Cost_For_two As float))  from Bank_Performance.dbo.zomato)
	select * from Bank_Performance.dbo.zomato z, Avg_Cost_for_2 a where z.Average_Cost_for_two> a.Avg_cost

Exec sp_columns 'Bank_Performance.dbo.zomato'

With Resturant_locality(locality,Average_cost_for_two) As 
	(Select Locality,Avg(Cast(Average_Cost_For_two As float)) from Bank_Performance.dbo.zomato group by Locality),
	 Average_Cost(avg_cost_for_two) As (Select Avg(Cast(Average_Cost_For_two As float)) from Bank_Performance.dbo.zomato)
	Select r.locality, r.Average_cost_for_two from Resturant_locality r,Average_Cost a group by r.locality,r.Average_cost_for_two, a.avg_cost_for_two having r.Average_cost_for_two>a.avg_cost_for_two

	CREATE TABLE student (
  name VARCHAR(50),
  year INT,
  subject VARCHAR(50)
);
INSERT INTO student (name, year, subject) VALUES
('Alice', 1, 'Mathematics'),
('Bob', 2, 'English'),
('Charlie', 3, 'Science'),
('David', 1, 'History'),
('Emily', 2, 'Art'),
('Frank', 3, 'Computer Science');

select * from student
SELECT SUBJECT, YEAR, Count(*)
FROM Student
GROUP BY SUBJECT, YEAR;
CREATE TABLE emp (
  emp_no INT PRIMARY KEY,
  name VARCHAR(50),
  sal DECIMAL(10,2),
  age INT
);

INSERT INTO emp (emp_no, name, sal, age) VALUES
(1, 'Aarav', 50000.00, 25),
(2, 'Aditi', 60000.50, 30),
(3, 'Amit', 75000.75, 35),
(4, 'Anjali', 45000.25, 28),
(5, 'Chetan', 80000.00, 32),
(6, 'Divya', 65000.00, 27),
(7, 'Gaurav', 55000.50, 29),
(8, 'Isha', 72000.75, 31),
(9, 'Kavita', 48000.25, 26),
(10, 'Mohan', 83000.00, 33);

SELECT NAME, SUM(sal) FROM Emp
GROUP BY name
HAVING SUM(sal)>3000; 

	SELECT
		Department,
		SUM(CASE WHEN Salary > 50000 THEN 1 ELSE 0 END) AS High_Salary_Count,
		SUM(CASE WHEN Salary <= 50000 THEN 1 ELSE 0 END) AS Low_Salary_Count
	FROM (
		VALUES ('HR', 60000), ('IT', 45000), ('HR', 55000), ('IT', 70000)
	) AS Employees(Department, Salary)
	GROUP BY Department;

	SELECT  Restaurant_Name,Locality,Votes,Avg(CAST(Average_Cost_for_two AS float))  OVER( PARTITION BY Locality) AS Avg_Cost_for_two
 FROM Bank_Performance.dbo.zomato