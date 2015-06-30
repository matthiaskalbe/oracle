CREATE TABLE T_DIM_DATE(
	DateKey Integer NOT NULL,
	DateValue Date NOT NULL,
	Day Char(10 ),
	DayOfWeek Integer,
	DayOfMonth Integer,
	DayOfYear Integer,
	PreviousDay date,
	NextDay date,
	WeekOfYear Integer,
	Month Char(10 ),
	MonthOfYear Integer,
	QuarterOfYear Integer,
	Year Integer
);
commit;

INSERT INTO T_DIM_DATE
SELECT
to_number(to_char(CurrDate, 'YYYYMMDD')) as DateKey,
CurrDate AS DateValue,
TO_CHAR(CurrDate,'Day') as Day,
to_number(TO_CHAR(CurrDate,'D')) AS DayOfWeek,
to_number(TO_CHAR(CurrDate,'DD')) AS DayOfMonth,
to_number(TO_CHAR(CurrDate,'DDD')) AS DayOfYear,
CurrDate - 1 as PreviousDay,
CurrDate + 1 as NextDay,
to_number(TO_CHAR(CurrDate+1,'IW')) AS WeekOfYear,
TO_CHAR(CurrDate,'Month') AS Month,
to_number(TO_CHAR(CurrDate,'MM')) AS MonthofYear,
to_number((TO_CHAR(CurrDate,'Q'))) AS QuarterOfYear,
to_number(TO_CHAR(CurrDate,'YYYY')) AS Year
FROM (
select level n, TO_DATE('31/12/2013','DD/MM/YYYY') + NUMTODSINTERVAL(level,'day') CurrDate
from dual
connect by level <= 21000)
order by 1;
commit;