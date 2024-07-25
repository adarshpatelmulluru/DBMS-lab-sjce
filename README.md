# DBMS-lab-sjce
Program 1. Consider the database schemas given below. 
Write ER diagram and schema diagram. The primary keys are underlined and the data types
are specified. <br>
Create tables for the following schema listed below by properly specifying the primary keys 
and foreign keys. <br>
Enter at least five tuples for each relation. <br>
Sailors database <br>
SAILORS (sid, sname, rating, age) <br>
BOAT(bid, bname, color) <br>
RSERVERS (sid, bid, date) <br>
Queries, View and Trigger <br>
1. Find the colours of boats reserved by Albert <br>
2. Find all sailor id’s of sailors who have a rating of at least 8 or reserved boat 103 <br>
3.  Find the names of sailors who have not reserved a boat whose name contains the string 
  “storm”. Order the names in ascending order. <br>
4. Find the names of sailors who have reserved all boats.<br>
5. Find the name and age of the oldest sailor. <br>
6. For each boat which was reserved by at least 5 sailors with age >= 40, find the boat id and 
  the average age of such sailors. <br>
7. Create a view that shows the names and colours of all the boats that have been reserved by
   a sailor with a specific rating. <br>
8. A trigger that prevents boats from being deleted If they have active reservations.<br>

Program 2. Consider the database schemas given below. 
Write ER diagram and schema diagram. The primary keys are underlined and the data types are 
specified.<br>
Create tables for the following schema listed below by properly specifying the primary keys and 
foreign keys. <br>
Enter at least five tuples for each relation. <br>
Insurance database <br>
PERSON (driver id#: string, name: string, address: string) <br>
CAR (regno: string, model: string, year: int) <br>
ACCIDENT (report_ number: int, acc_date: date, location: string) <br>
OWNS (driver id#: string, regno: string) <br>
PARTICIPATED(driver id#:string, regno:string, report_ number: int,damage_amount: int) <br>
1. Find the total number of people who owned cars that were involved in accidents in 2021.  <br>
2. Find the number of accidents in which the cars belonging to “Smith” were involved.<br>
3. Add a new accident to the database; assume any values for required attributes. <br>
4. Delete the Mazda belonging to “Smith”.   <br>
5. Update the damage amount for the car with license number “KA09MA1234” in the accident 
with report.<br>
6. A view that shows models and year of cars that are involved in accident.<br>
7. A trigger that prevents a driver from participating in more than 3 accidents in a given year.<br>


     

  
  
  
   


