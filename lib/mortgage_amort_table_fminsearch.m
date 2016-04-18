function table_ = mortgage_amort_table_fminsearch(r, y, p, i, n) 
% table = mortgage_amort_table(r, y, p, i, n) 
%r: repayment amount
%y:duration of repayment in year
%p: principal amount borrowed
%i: interest rate, .e.g, 6 for 6%
%n: number of payment per year

if nargin<5,
  n=12;
end;


% Let's define some starting values
i = i/100;
balance(1) = p;
acc_interest(1) = 0; 

% Calculate every monthly payment (except the last one)
for pnr =  2 : y*n,
    interest(pnr) = (balance(pnr-1) * i/n);
    amortized(pnr) = (r - interest(pnr));
    balance(pnr) = (balance(pnr-1) - amortized(pnr));
end 

% Calculate the final payment differently, to terminate the debt
%interest(pnr+1) = (balance(pnr) * i/n);
%amortized(pnr+1) = balance(pnr);
%balance(pnr+1) = balance(pnr) - amortized(pnr+1); 

% Deliver results in table form
table_ = table( ...
  (0 : pnr-1)', interest', amortized', balance', cumsum(interest'), ...
  'VariableNames', { 'Month', 'Interest', 'Amortz', 'Balance', 'Acc_Int'});

