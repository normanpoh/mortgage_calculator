function [table_, r] = mortgage_amort_table_auto(y, p, i, n) 
% table = mortgage_amort_table_auto(y, p, i, n) 
% This function is similar to mortgage_amort_table except the the monthy
% repayment is set automatically
% IN:
% y:duration of repayment in year
% p: principal amount borrowed
% i: interest rate, .e.g, 6 for 6%
% n: number of payment per year
% OUT
% r: monthly repyament amount

if nargin<5,
  n=12;
end;

initial_r = 800;
r = fminsearch(@(x) abs(mortgage_amort_table_fminsearch_feval(x, y, p, i, n)),[initial_r]);

table_ = mortgage_amort_table(r, y, p, i, n); 
