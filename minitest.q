price: {[ra;r;np;p;y] (((r-ra)*np*p)%(1*y)) *(1%(1+r*(p%y))) };

feed: ([] RA: `int$(); R:`int$(); NP:`int$(); P:`int$(); Y:`int$(); batchId:`int$(); executionTime:`int$(); accountRef:`int$(); uniqueId:`int$(); marketName:`$(); instrumentType:`$(); insPrice: `float$());
feed1: ([] RA: `int$(); R:`int$(); NP:`int$(); P:`int$(); Y:`int$();accountRef:`int$();clientName:`$();modifiedDate:`date$();billingCurrency:`$();accountGroup:`$();insPrice:`float$());

system "t 1000"
.z.ts:{a:(1?3; 1?(5 + til 5);1?100000000 + til 50000000; 1?365;1?365;1?10000;1?100;1?10000;1?10000;`$"London";`$"Legacy" );
 c:(string first a[0]; string first a[1];string first a[2]; string first a[3];string first a[4];string first 1?100;string first 1?10000;string first 1?10000;1?.Q.A;"London";"Legacy" );
 insPrice: price[a[0];a[1];a[2];a[3];a[4]];
 `feed insert a,insPrice;
 `:feed set feed

 a2:(1?5; 1?(5 + til 5);1?100000000 + til 50000000; 1?365;1?365);
 c1:"," sv (string first a2[0]; string first a2[1];string first a2[2]; string first a2[3];string first a2[4];string first 1?10000;1?.Q.A;string first `date$.z.p;string first 1?`eur`gbp`usd;string first 1?`grX`grY`grZ);
 insPrice: price[a2[0];a2[1];a2[2];a2[3];a2[4]];
 cparse:("iiiiiisdss";",")0:c1;
 `feed1 insert cparse,insPrice;
 `:feed1 set feed1

 totalavg::select avg insPrice by accountGroup from feed1;
 rollavg::select avg insPrice by accountGroup from -300#feed1;
 }

`:feed1 set feed1