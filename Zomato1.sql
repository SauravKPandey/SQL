With Avg_Cost_for_2(Avg_cost) As 
	(Select Avg(Cast(Average_Cost_For_two As float))  from Bank_Performance.dbo.zomato)
	select * from Bank_Performance.dbo.zomato z, Avg_Cost_for_2 a where z.Average_Cost_for_two> a.Avg_cost
	/* select localities where average cost for two of all the resturants is greater than the average cost for 2 of all the resturants*/

With Resturant_locality(locality,Average_cost_for_two) as 
	(Select Locality,Avg(Cast(Average_Cost_For_two As float)) from zomato group by Locality),
	 Average_Cost(avg_cost_for_two) as (Select Avg(Cast(Average_Cost_For_two As float)) from zomato)
	Select Resturant_locality r,Average_Cost a where r.Average_cost_for_two>a.avg_cost_for_two

	Select Locality,Avg(Cast(Average_Cost_For_two As float)) from zomato group by Locality

	With Resturant_locality(locality,Average_cost_for_two) As 
	(Select Locality,Avg(Cast(Average_Cost_For_two As float)) from Bank_Performance.dbo.zomato group by Locality),
	 Average_Cost(avg_cost_for_two) As (Select Avg(Cast(Average_Cost_For_two As float)) from Bank_Performance.dbo.zomato)
	Select r.locality, r.Average_cost_for_two from Resturant_locality r,Average_Cost a WHERE r.Average_cost_for_two>a.avg_cost_for_two

Select * from Bank_Performance.dbo.zomato

With Average_cost_table(Locality, Resturant_Count, Average_cost_for_2) As
		(Select Locality,COUNT(Restaurant_ID) ,Avg(CAST(Average_Cost_for_two AS float)) FROM zomato group by Locality)
		Select ACT.Locality, ACT.Resturant_Count,ACT.Average_cost_for_2,
		CASE
			When ACT.Average_cost_for_2 <500 Then 'Pocket Friendly'
			When ACT.Average_cost_for_2 <1000 Then 'Affordable'
			When ACT.Average_cost_for_2 <1500 Then 'Costly'
			Else 'Luxury'
		END AS Budget
		FROM Average_cost_table ACT order by ACT.Locality ASC

Select Restaurant_Name,Locality,Avg(CAST(Average_Cost_for_two AS float)) As Avg_Cost_for_2, Avg(Votes) As Votes FROM Bank_Performance.dbo.zomato group by Locality, Restaurant_Name

Select Restaurant_Name, Locality, Avg(CAST(Average_Cost_for_two AS float)) over( Partition by Locality) as Avg_Cost_for_2,Votes from Bank_Performance.dbo.zomato

Select 
	Row_Number() over(Partition by Locality order by CAST(Average_Cost_for_two AS float) Desc) As Row__Number,
	Restaurant_Name, Locality, Avg(CAST(Average_Cost_for_two AS float)) as Avg_Cost_for_2,Votes,
	Rank() over(Partition by Locality order by CAST(Average_Cost_for_two AS float) Desc) As Rank_,
	Dense_Rank() over(Partition by Locality order by CAST(Average_Cost_for_two AS float) Desc) As DenseRank
from Bank_Performance.dbo.zomato GROUP BY Locality,Average_Cost_for_two ,Restaurant_Name, Votes;
SELECT 
	Row_Number() over(Partition by Locality order by CAST(Average_Cost_for_two AS float) Desc) As Row_Number,
	Restaurant_Name, 
	Locality, 
	Avg(CAST(Average_Cost_for_two AS float)) as Avg_Cost_for_2,
	Votes,
	Rank() over(Partition by Locality order by CAST(Average_Cost_for_two AS float) Desc) As Rank_,
	Dense_Rank() over(Partition by Locality order by CAST(Average_Cost_for_two AS float) Desc) As DenseRank
FROM Bank_Performance.dbo.zomato;