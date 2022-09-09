select* from covid_19_india

select  Date, [State/UnionTerritory], Cured ,Deaths, Confirmed from covid_19_india

Alter table covid_19_india
add DateNew Date;

Update covid_19_india
set DateNew = convert(Date,Date)

select* from covid_19_india

alter table covid_19_india
drop column Sno, Date, Time, ConfirmedIndianNational, ConfirmedForeignNational;

select* from covid_19_india

--Findout the activecases
alter table covid_19_india
add ActiveCases as Confirmed-Cured+Deaths

select* from covid_19_india

--Top 5 Locations with Highest Confirmed Cases
select Distinct top 6
Max(Confirmed) as TotalConfirmed, [State/UnionTerritory]
from portolioproject..covid_19_india
where [State/UnionTerritory] not like '%***'
group by [State/UnionTerritory]
order by 1 desc


--Top 5 Location in India with highest Active cases
select Distinct top 5
Max(ActiveCases) as TotalActiveCases,[State/UnionTerritory]
from portolioproject..covid_19_india
where [State/UnionTerritory] not like '%***'
group by [State/UnionTerritory]
order by 1 desc

--Top 5 Location in India with highest Deaths reported
select Distinct top 6
Max(Deaths) as Totaldeaths, [State/UnionTerritory]
from portolioproject..covid_19_india
where [State/UnionTerritory] not like '%***'
group by [State/UnionTerritory]
order by 1 desc

--top 5 RecoveryRate
select top 6
Max (Confirmed),
Max(Cured/Confirmed)*100 as RecoveryRate,
[State/UnionTerritory]
from portolioproject..covid_19_india
where (Confirmed<>0 or Cured<> 0) And (([State/UnionTerritory] not like '%***'))
group by [State/UnionTerritory]
order by 1 desc

--Top 5 Mortalility Rate
select top 6
Max (Confirmed)as TotalConfirmed,
Max(Deaths/Confirmed)*100 as MortalityRate,
[State/UnionTerritory]
from portolioproject..covid_19_india
where (Confirmed<>0 or Deaths <> 0) And (([State/UnionTerritory] not like '%***'))
group by [State/UnionTerritory]
order by 1 desc

--vaccination analysis

select * from covid_vaccine_statewise 

-- As many null values in Different coumns 
-- Find out coulmns which we need have how many NULL values 
select count (*) from covid_vaccine_statewise 

SELECT COUNT(*)-COUNT([Male (Doses Administered)]) As A,
COUNT(*)-COUNT([Female (Doses Administered)]) As B, 
COUNT(*)-COUNT([Transgender (Doses Administered)]) As C,
COUNT(*)-COUNT([Total Doses Administered]) As D
FROM covid_vaccine_statewise
-- null vales are very less so carry on with analysis


--total no.of males vs female vs Transgender vaccinated in India
select
Sum([Male(Individuals Vaccinated)]) as TotalMaleVacc , 
SUM([Female(Individuals Vaccinated)]) as TotalFemaleVacc,
SUM([Transgender(Individuals Vaccinated)]) as TotalTransVacc
from covid_vaccine_statewise 

--Top 5 vaccinated states in terms of number of Individuals vaccinated
select Distinct top 5
MAX([Total Individuals Vaccinated]), State 
from portolioproject.dbo.covid_vaccine_statewise
where State <> 'India' 
group by State
order by 1 desc

--Least vaccinated states in terms of number of Individuals vaccinated
select Distinct top 5
MAX([Total Individuals Vaccinated]), State 
from portolioproject.dbo.covid_vaccine_statewise
group by State
order by 1

--Establish relationship between vaccination an deaths
select Distinct top 10
MAX(b.[Total Individuals Vaccinated])  as "Vaccination", Max(a.Deaths) as "TotalDeaths", b.State
from portolioproject..covid_19_india a inner join  portolioproject..covid_vaccine_statewise  b on a.[State/UnionTerritory] = b.State
group by b.State
order by 1 desc, 2 desc

--hence more vaccination did not mean less deaths but we cannot be sure of this analysis as population has been not taken into consideration.
