CREATE TABLE `base` (
  `num` int,
  `word` varchar(20)
) ;


INSERT INTO base (num,word) values (1,"One");
INSERT INTO base (num,word) values (2,"Two");
INSERT INTO base (num,word) values (3,"Three");
INSERT INTO base (num,word) values (4,"Four");
INSERT INTO base (num,word) values (5,"Five");
INSERT INTO base (num,word) values (6,"Six");
INSERT INTO base (num,word) values (7,"Seven");
INSERT INTO base (num,word) values (8,"Eight");
INSERT INTO base (num,word) values (9,"Nine");
INSERT INTO base (num,word) values (10,"Ten");
INSERT INTO base (num,word) values (11,"Eleven");
INSERT INTO base (num,word) values (12,"Twelve");
INSERT INTO base (num,word) values (13,"Thirteen");
INSERT INTO base (num,word) values (14,"Forteen");
INSERT INTO base (num,word) values (15,"Fifteen");
INSERT INTO base (num,word) values (16,"Sixteen");
INSERT INTO base (num,word) values (17,"Seventeen");
INSERT INTO base (num,word) values (18,"Eighteen");
INSERT INTO base (num,word) values (19,"Nineteen");
INSERT INTO base (num,word) values (20,"Twenty");
INSERT INTO base (num,word) values (30,"Thirty");
INSERT INTO base (num,word) values (40,"Forty");
INSERT INTO base (num,word) values (50,"Fifty");
INSERT INTO base (num,word) values (60,"Sixty");
INSERT INTO base (num,word) values (70,"Seventy");
INSERT INTO base (num,word) values (80,"Eighty");
INSERT INTO base (num,word) values (90,"Ninety");
INSERT INTO base (num,word) values (0,"");

DELIMITER $$
CREATE FUNCTION `words`(number bigint) RETURNS varchar(200)
    DETERMINISTIC
BEGIN
declare result varchar(200);
	if number < 0 
    then
		set result = "Entered number is Negative";
    
    elseif number > 99999999
    then
		set result = "Entered number contains more than 8 digit";
        
	elseif number = 0
    then
		set result = "zero";
        
    elseif number >= 1 && number <=9
    then
		set result = sub1(number); 
        
	 elseif number >= 10 && number <=99
    then
		set result = sub2(number); 
        
	 elseif number >= 100 && number <=999
    then
		set result = sub3(number); 
        
	 elseif number >= 1000 && number <=9999
    then
		set result = sub4(number); 
        
	 elseif number >= 10000 && number <=99999
    then
		set result = sub5(number); 
    
     elseif number >= 100000 && number <=999999
    then
		set result = sub6(number); 
	
     elseif number >= 1000000 && number <=9999999
    then
		set result = sub7(number); 
        
	 elseif number >= 10000000 && number <=99999999
    then
		set result = sub8(number); 
	
    end if;
RETURN result;
END$$
DELIMITER ;


DELIMITER $$
CREATE FUNCTION `sub2`(num2 bigint) RETURNS varchar(200)
    DETERMINISTIC
BEGIN
declare result2 varchar(200);
declare var1 bigint;
declare var2 bigint;
declare char1 varchar(100);
declare char2 varchar(100);
	
    if num2<10
    then 
    set result2 = sub1(num2);
	elseif num2 >= 10 && num2 <= 19
    then
    set result2 = (select word from base where num=num2);
    
    elseif num2 >= 20 && num2 <=99
    then
		set var1 = (floor(num2/10))*10;
        set var2 = mod(num2,10);
        set char1 = (select word from base where num=var1);
        set char2 = (select word from base where num=var2);
        set result2 = concat(char1," ",char2);
    end if;
RETURN result2;
END$$
DELIMITER ;


DELIMITER $$
CREATE FUNCTION `sub3`(num3 bigint) RETURNS varchar(200)
    DETERMINISTIC
BEGIN
	declare result3 varchar(100);
    
    declare char1 varchar(100);
    declare var1 bigint;
    declare char2 varchar(100);
    declare var2 bigint;
    
    set var1 = floor(num3/100);
    set char1 = (select word from base where num=var1);
    set var2 = mod(num3,100);
    
    if num3 < 100
    then
    set result3 = sub2(num3);
    else
    
    if mod(num3,100)=0
    then
		set result3 = concat(char1," ","Hundred");
	
    elseif mod(num3,100) >= 10
    then
		set result3 = concat(char1," ","Hundred"," ","And"," ",sub2(var2));
        
	elseif mod(num3,100) < 10
    then
		set result3 = concat(char1," ","Hundred"," ","And"," ",sub1(var2));
    end if;
    end if;
    
RETURN result3;
END$$
DELIMITER ;


DELIMITER $$
CREATE FUNCTION `sub4`(num4 bigint) RETURNS varchar(200) 
    DETERMINISTIC
BEGIN
declare result4 varchar(200);
declare var1 bigint;
declare var2 bigint;
declare char1 varchar(200);
set var1 = floor(num4/1000);
set char1 = (select word from base where num=var1);
set result4 = concat(char1," Thousand ");
set var2 = mod(num4,1000);

if var2 < 10 && var2>0 then
set result4 = concat(result4,"And"," ",sub1(var2));

elseif var2>=10 && var2 <=99 then
set result4 = concat(result4,"And"," ",sub2(var2));

else
set result4 = concat(result4," ",sub3(var2));
end if;
RETURN result4;
END$$
DELIMITER ;


DELIMITER $$
CREATE FUNCTION `sub5`(num5 bigint) RETURNS varchar(200)
    DETERMINISTIC
BEGIN
declare result5 varchar(200);
declare var1 bigint;
declare char1 varchar(200);
declare var2 bigint;
declare char2 varchar(200);

set var1 = floor(num5/1000);
set char1 = sub2(var1); 
set result5 = concat(char1," Thousand ");
set var2 = mod(num5,1000);

if var2 < 10 && var2>0 then
set result5 = concat(result5,"And"," ",sub1(var2));

elseif var2>=10 && var2 <=99 then
set result5 = concat(result5,"And"," ",sub2(var2));

else
set result5 = concat(result5,sub3(var2));

end if;

RETURN result5;
END$$
DELIMITER ;


DELIMITER $$
CREATE FUNCTION `sub6`(num6 bigint) RETURNS varchar(200)
    DETERMINISTIC
BEGIN
declare result6 varchar(200);

declare var1 bigint;
declare var2 bigint;
declare char1 varchar(200);
set var1 = floor(num6/100000);
set char1 = (select word from base where num=var1);
set result6 = concat(char1," Lakh ");
set var2 = mod(num6,100000);

if var2 < 10 && var2>0 then
set result6 = concat(result6,"And"," ",sub1(var2));

elseif var2>=10 && var2 <=99 then
set result6 = concat(result6,"And"," ",sub2(var2));

elseif var2 >=100 && var2 <= 999 then
set result6 = concat(result6,sub3(var2));

elseif var2 >=1000 && var2 <= 9999 then
set result6 = concat(result6,sub4(var2));

elseif var2>=10000 then
set result6 = concat(result6,sub5(var2));

end if;

RETURN result6;
END$$
DELIMITER ;


DELIMITER $$
CREATE FUNCTION `sub7`(num7 bigint) RETURNS varchar(200)
    DETERMINISTIC
BEGIN
declare result7 varchar(200);

declare var1 bigint;
declare char1 varchar(200);
declare var2 bigint;
declare char2 varchar(200);

set var1 = floor(num7/100000);
set char1 = sub2(var1); 
set result7 = concat(char1," Lakh ");

set var2 = mod(num7,100000);

if var2 < 10 && var2 >0 then
set result7 = concat(result7,"And"," ",sub1(var2));

elseif var2>=10 && var2 <=99 then
set result7 = concat(result7,"And"," ",sub2(var2));

elseif var2 >=100 && var2 <= 999 then
set result7 = concat(result7,sub3(var2));

elseif var2 >= 1000 then
set result7 = concat(result7,sub5(var2));

end if;

RETURN result7;
END$$
DELIMITER ;



DELIMITER $$
CREATE FUNCTION `sub8`(num8 bigint) RETURNS varchar(200) 
    DETERMINISTIC
BEGIN
declare result8 varchar(200);

declare var1 bigint;
declare var2 bigint;
declare char1 varchar(200);
set var1 = floor(num8/10000000);
set char1 = (select word from base where num=var1);
set result8 = concat(char1," Crore ");
set var2 = mod(num8,10000000);

if var2 < 10 && var2>0 then
set result8 = concat(result8,"And"," ",sub1(var2));

elseif var2>=10 && var2 <=99 then
set result8 = concat(result8,"And"," ",sub2(var2));

elseif var2 >=100 && var2 <= 999 then
set result8 = concat(result8,sub3(var2));

elseif var2 >=1000 && var2 <= 9999 then
set result8 = concat(result8,sub4(var2));

elseif var2 >=10000 && var2 <= 99999 then
set result8 = concat(result8,sub5(var2));

elseif var2 >=100000 && var2 <= 999999 then
set result8 = concat(result8,sub6(var2));

elseif var2 >= 1000000 then
set result8 = concat(result8,sub7(var2));

end if;

RETURN result8;
END$$
DELIMITER ;





