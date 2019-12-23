--View Dimensions: Max Weight by Country, State, and WeekDay
select	d.[Name (CountryRegion)], 
		d.[Name (StateProvince)],
		FORMAT(d.OrderDate, 'dddd') 'WeekDay', 
		FORMAT(max(d.Weight),'#') 'Max Weight' 
from dbo.vTableauAdventureWorksDemo d
where d.OnlineOrderFlag = 0 and d.[Name (CountryRegion)] = 'Germany'
group by	d.[Name (CountryRegion)], 
			d.[Name (StateProvince)],			
			FORMAT(d.OrderDate, 'dddd'),
			datePart(dw,d.OrderDate)
order by	d.[Name (CountryRegion)], 
			d.[Name (StateProvince)],			
			datePart(dw,d.OrderDate)

--LOD Dimensions: Fixed and Exclude: Max Weight by Country, State
select	d.[Name (CountryRegion)], 
		d.[Name (StateProvince)],		
		FORMAT(max(d.Weight),'#') 'Max Weight' 
from dbo.vTableauAdventureWorksDemo d
where d.OnlineOrderFlag = 0 and d.[Name (CountryRegion)] = 'Germany'
group by	d.[Name (CountryRegion)], 
			d.[Name (StateProvince)]			
order by	d.[Name (CountryRegion)], 
			d.[Name (StateProvince)]
			

--LOD Dimensions: Include: Min Weight by Category
select	d.[Name (CountryRegion)], 
		d.[Name (StateProvince)],
		FORMAT(d.OrderDate, 'dddd') 'WeekDay', 
		d.[Name (ProductCategory)],
		FORMAT(min(d.Weight),'#.#') 'Min Weight' 
from dbo.vTableauAdventureWorksDemo d
where d.OnlineOrderFlag = 0 and d.[Name (CountryRegion)] = 'Germany'
group by	d.[Name (CountryRegion)], 
			d.[Name (StateProvince)],			
			FORMAT(d.OrderDate, 'dddd'),
			datePart(dw,d.OrderDate),
			[Name (ProductCategory)]
order by	d.[Name (CountryRegion)], 
			d.[Name (StateProvince)],			
			datePart(dw,d.OrderDate),
			[Name (ProductCategory)]


--View Dimensions: plus aggregation from previous LOD Include of Category
select	d.[Name (CountryRegion)], 
		d.[Name (StateProvince)],
		FORMAT(d.OrderDate, 'dddd') 'WeekDay', 		
		FORMAT(max(d.Weight),'#') 'Max Weight',
		FORMAT(avg(t2.MinWeight),'#.#') 'Avg of Min Weight By Cat'
from dbo.vTableauAdventureWorksDemo d
inner join (
	select	d2.[Name (CountryRegion)], 
			d2.[Name (StateProvince)],
			FORMAT(d2.OrderDate, 'dddd') 'WeekDay', 
			d2.[Name (ProductCategory)],
			min(d2.Weight) 'Min Weight' 
	from dbo.vTableauAdventureWorksDemo d2
	group by	d2.[Name (CountryRegion)], 
				d2.[Name (StateProvince)],			
				FORMAT(d2.OrderDate, 'dddd'),
				d2.[Name (ProductCategory)]
) 
--alias the subquery table
as t2 ( Country, 
		[State],
		[WeekDay], 
		[Category],
		[MinWeight])
on	d.[Name (CountryRegion)] = t2.Country and 
	d.[Name (StateProvince)] = t2.[State] and
	FORMAT(d.OrderDate, 'dddd') = t2.[WeekDay]

where	d.OnlineOrderFlag = 0 and 
		d.[Name (CountryRegion)] = 'Germany'
group by	d.[Name (CountryRegion)], 
			d.[Name (StateProvince)],			
			FORMAT(d.OrderDate, 'dddd'),
			datePart(dw,d.OrderDate)
order by	d.[Name (CountryRegion)], 
			d.[Name (StateProvince)],
			datePart(dw,d.OrderDate)
	
	
