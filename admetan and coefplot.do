/*Do-file for how to use the admetan user-written command to do a combined
table + forestplot graph of your regression results. The command is actually written to do 
meta-analysis -- analyzing the results of multiple studies. We can simply repurpose
it to create a table/graph of a single model, substituting our variables for what
would normally be distinct studies.*/

/*If it's not already installed, type: ssc install admetan    */

/*First, you need to open a new Stata session (separate from your other Stata
session where you have your results. You'll be creating a new data set that is 
comprised of your actual results, not the data. Below, variable will be the names
of the variables in your model. est refers to the regression coefficient.
lci and uci refer to the lower and upper CI values and pvalue refers to the p-value
for each variable.*/

. gen Variable=.
. gen est=.
. gen lci=.
. gen uci=.
. gen pvalue=.

/*Then, go into data editor and type in the values you see in your Stata results.
NOTE: I recommend typing in the variables names as you would like them to appear in the table.
If you have a categorical variable, I recommend inputting the broader variable name (e.g., Race (Ref: White))
and putting in estimate and lci and uci values that are at or very near the null (e.g., for 
logistic regression, the estimate will be 1, the lci would be .99999 and the uci would be 1.00001.
The admetan command won't run without estimate and lci/uci values for each observation.
Then, for the other categories of the categorical variable (e.g, Black, Latinx), I recommend using "" and spaces
to indent them a bit. E.g., "   Black"*/

/*Now we can use the admetan command to create a combined table/graph of the estimates,
their CIs, and p-values.*/

/*Note: You will have to adapt the "effect" portion depending on whether you're reporting logistic or OLS results.
Additionally, your xlabel values are deterimined */

*For Logistic Regression Results (change x-axis range as needed)
. admetan est lci uci, study(Variable) effect(Odds Ratio) nowt nooverall rcol(pvalue) ///
forestplot(xlabel(0 0.5 1 1.5 2 2.5 3 3.5, force) boxopt(mcolor(none)) ///
pointopt(msymbol(diamond) mcolor(gray) msize(small)) ciopt(lcolor(gray) lwidth(medium)) null(1))

*For OLS Regression Results (**change x-axis range as needed**)
. admetan est lci uci, study(Variable) effect(Estimate) nowt nooverall rcol(pvalue) ///
forestplot(xlabel(-1.5 -1 -.5 0 .5 1 1.5, force) boxopt(mcolor(none)) ///
pointopt(msymbol(diamond) mcolor(gray) msize(small)) ciopt(lcolor(gray) lwidth(medium)))

/*Now you can go into the graph editor and fix things up and add elements as needed. I recommend the following:

MORE THAN ONE MODEL? You can do multiple models in the same figure, along much the same lines as the coefplot command,
which is run in conjection with the actual data. The admetan command requires that you construct a "data set" from 
your results. It's a little more work, but results in a nice table/graph hybrid.*/

. admetan est lci uci, study(Variable) effect(Odds Ratio) nowt nooverall rcol(pvalue) ///
forestplot(xlabel(0 1 2 3 4, force) boxopt(mcolor(none)) pointopt(msymbol(diamond) mcolor(gray) ///
msize(small)) ciopt(lcolor(gray) lwidth(medium)) null(1))

/*
Increase the marker label size as desired.

Add text below the table/graph to indicate your N, R-square (if OLS), and any relevant reference groups.

Add text for the p-value column to indicate they are p-values (set to same size as everything else).

Consider turning the light blue/gray color to white. Or more, generally, alter the color scheme as desired.

Consider adding a title for the figure (e.g., Figure 1: Logistic Regression Results).

Consider adding a horizontal line at the top and bottom of the graph to help set it apart
from the text that will surround it.

When done editing, save the graph and copy it into your Word document. There, you can "crop"
the picture (bring the top/bottom boundaries to just around the table/graph). That way your
text wraps neatly above and below the figure.

You're done! */

/*An alternative way you can graph multiple model results in the same coefplot graph (no table).
For this, you'd use these commands in conjunction with the actual data set.

. reg dv iv1 iv2 iv3
. estimates store m1
. reg dv iv1 iv2 iv3 iv4 
. estimates store m2
. coefplot m1 m2, drop(_cons) xline(0)

/*If doing logistic, then a similar series of commands but notice the coefplot command.*/
. logistic dv iv1 iv2 iv3
. estimates store m1
. logistic dv iv1 iv2 iv3 iv4 
. estimates store m2
. coefplot m1 m2, drop(_cons) xline(1) eform

*/
