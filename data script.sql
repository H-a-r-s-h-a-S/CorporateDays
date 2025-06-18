drop table if exists data ;

create table data (
	name varchar(100),
	organisation varchar(100),
	title varchar(100),
	"start date" date,
	"end date" date default NULL
);

-- SELECT * FROM sqlite_master WHERE type='table';

insert into data (name, organisation, title, "start date") values ('Harsha S', 'ConcertAI', 'Data Analyst', '2023-01-04') ;

drop view if exists "days" ;

create view "days" as 
with cte as (
select
	*,
	julianday(ifnull("end date", date('now'))) - julianday("start date") as "days in role"
from
	data)
select
	*,
	(
	select
		sum("days in role") as n
	from
		cte b
	where
		b.name = a.name) as "corporate days"
from
	cte a ;

select * from days ;
