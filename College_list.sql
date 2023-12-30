create table college
(sl number,
collegename varchar2(125),
cse number,
ise number,
ec number);

select collegename,ec,dense_rank() over(order by ec) ec_rank,code  from (
select collegename, cse,dense_rank() over(order by cse) cse_rank,
ise,dense_rank() over(order by ise) ise_rank,
ec, dense_rank() over(order by ec) ec_rank,code
from college)
order by ec_rank;


select * from (
    select collegename, cse,dense_rank() over(order by cse) cse_rank,
    ise,dense_rank() over(order by ise) ise_rank,
    ec, dense_rank() over(order by ec) ec_rank,code
    from college)
order by ec_rank;





select COLLEGENAME,code,col_rank,dense_rank() over(order by col_rank) as rank_list from(
select COLLEGENAME,CSE as col_rank,code from college
union all
select COLLEGENAME,ise as col_rank, code from college
union all
select COLLEGENAME,ec as col_rank, code from college);





select * from college
order by collegename;

select * from college
order by code;



