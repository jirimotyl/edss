<h1>EDSScalculator: EDSS Calculator for R</h1>

R Package EDSScalculator that calculates total EDSS score from functional subsystem subscores 

Expanded Disability Status Scale (EDSS) is the most common scoring system to evaluate the clinical neurological status of patients with Multiple Sclerosis (MS). This package is intended for calculation of the total EDSS score from functional subsystem scores. Calculations are based on the Neurostatus adaptation of the scoring system (Kappos et al.): https://www.neurostatus.net/scoring/index.php
The functioning of the calculator was validated on a large dataset of almost 11000 EDSS observations. 

<h2>Install</h2>
You can install the package by using devtools library. Simply run this code:


```R
library(devtools) #make sure that the library is installed
install_github("jirimotyl/edss")
```

<h2>How to cite</h2>
<li>Motyl, J. (2024) EDSScalculator. <i>GitHub</i> <a href = "https://github.com/jirimotyl/edss/">https://github.com/jirimotyl/edss</a></li>

<h2>Acknowledgements</h2>
I would like to thank <a href = "https://github.com/adobrasinovic">Aleksandar Dobrašinovic</a> for the inspiration to write this script and for the clear overview of the EDSS conditions that made it much easier to write this package. Also I would like to thank AI tools for final debugging of the code.
