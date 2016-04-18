%% This is a demo software for calculating mortgage
% The original function mortgage_amort_table.m was copied from
% http://www.matrixlab-examples.com/mortgage-amortization-table.html
% However, this function requires you to key in the monthly repayment
% amount. I want to have the monthly repayment amount calculated
% automatically so that the user only needs to key in the mortgage term in
% years, the mortgage amount, the interest, and how many payments per year.
%
%% Example 1
%
% In the following example, assuming an 25-year term contract for a
% mortgage of 264K and an interest year of 4 percent to be paid 12 times
% per year, you key in:
display('Property 1 - borrow 264K (20% of 330K)')
clc
[table_,r] = mortgage_amort_table_auto( 25, 264000, 4, 12);
fprintf(1,'Monthly repayment amount: %1.2f\n', r);
% we print the table out at the end of every year
table_(mod(table_.Month,12)==0,:) 
% we calculate the percentage of money we borrow that goes to the banker as
% interest. This is the bank's yield.
table_.Acc_Int(end) / table_.Balance(1) * 100

%% Example 2
% Similar to the above, but for 202.5K mortgage instead
display('Property 2 - borrow 202.5K (25% of 270K)')
clc
[table_,r] = mortgage_amort_table_auto( 25, 202500, 4, 12);
fprintf(1,'Monthly repayment amount: %1.2f\n', r);
table_(mod(table_.Month,12)==0,:) 
table_.Acc_Int(end) / table_.Balance(1) * 100

%% Time to do some ploting here

close all;
figure(1);
hold on;
plot(table_.Month, table_.Balance);
plot(table_.Month, table_.Acc_Int);
legend('Balance', 'Accumulated Interest');
%%
figure(2);
hold on;
plot(table_.Month, table_.Interest);
plot(table_.Month, table_.Amortz);
legend('Interest paid', 'Ammortized amount');


%% For development use
% If you want to learn about fminresearch, check out
% mortgage_amort_table_fminsearch.m  and its helper function
% mortgage_amort_table_fminsearch_feval.m

% initial solutation is 800, pay once a year but 12 times the x values
r = fminsearch(@(x) abs(mortgage_amort_table_fminsearch_feval(x*12, 25, 202500, 4, 1)),[800])

% we have found the optimal monthly repayment, r
table_ = mortgage_amort_table_fminsearch(r*12, 25, 202500, 4, 1)
