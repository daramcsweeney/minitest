price: {[ra;r;np;p;y] (((r-ra)*np*p)%(1*y)) *(1%(1+r*(p%y))) }; /price formula

feed: ([] RA: `int$(); R:`int$(); NP:`int$(); P:`int$(); Y:`int$(); batchId:`int$(); executionTime:`int$(); accountRef:`int$(); uniqueId:`int$(); marketName:`$(); instrumentType:`$(); insPrice: `float$()); /feed 1 table schema
feed1: ([] RA: `int$(); R:`int$(); NP:`int$(); P:`int$(); Y:`int$();accountRef:`int$();clientName:`$();modifiedDate:`date$();billingCurrency:`$();accountGroup:`$();insPrice:`float$()); /feed 3 table schema

system "t 1000" /set system timer to tick every second
.z.ts:{a:(1?3; 1?(5 + til 5);1?100000000 + til 50000000; 1?365;1?365;1?10000;1?100;1?10000;1?10000;`$"London";`$"Legacy" ); 
 c:(string first a[0]; string first a[1];string first a[2]; string first a[3];string first a[4];string first a[5];string first a[6];string first a[7];a[8];"London";"Legacy"); /random feed 1 fixed width
 insPrice: price[a[0];a[1];a[2];a[3];a[4]]; /instrument price
 `feed insert a,insPrice; /insert feed joined with instrument price to feed 1 table
 `:feed set feed /save feed 1 table to home directory

 a2:(1?5; 1?(5 + til 5);1?100000000 + til 50000000; 1?365;1?365); /variables to calculate price
 c1:"," sv (string first a2[0]; string first a2[1];string first a2[2]; string first a2[3];string first a2[4];string first 1?10000;1?.Q.A;string first `date$.z.p;string first 1?`eur`gbp`usd;string first 1?`grX`grY`grZ); /random feed 3 csv
 insPrice: price[a2[0];a2[1];a2[2];a2[3];a2[4]]; /instrument price
 cparse:("iiiiiisdss";",")0:c1; /parse csv feed to add to table
 `feed1 insert cparse,insPrice; /insert row into feed 3 table
 `:feed1 set feed1 /save feed 3 table 

 totalavg::select avg insPrice by accountGroup from feed1; /total avg per accountGroup
 rollavg::select avg insPrice by accountGroup from -300#feed1; /rolling average for last five minutes per accountGroup, timer ticks every second so takes the last 300 rows for calculation
 }
