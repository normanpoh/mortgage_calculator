function final_payment = mortgage_amort_table_fminsearch_feval(r, y, p, i, n) 

table_ = mortgage_amort_table_fminsearch(r, y, p, i, n); 
final_payment = table_.Balance(end);