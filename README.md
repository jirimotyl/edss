<h1>EDSScalculator: EDSS Calculator for R</h1>

R Package EDSScalculator that calculates total EDSS score from functional subsystem subscores 

Expanded Disability Status Scale (EDSS) is the most common scoring system to evaluate the clinical neurological status of patients with Multiple Sclerosis (MS). This package is intended for calculation of the total EDSS score from functional subsystem scores. Calculations are based on the Neurostatus adaptation of the scoring system (Kappos et al.): https://www.neurostatus.net/scoring/index.php

The functioning of the calculator was validated on a large dataset of almost 11000 unique real-life EDSS observations. Conditions that do not follow rigorous Neurostatus criteria but appear in the real-life data were incorporated. 

<h2>Install</h2>
You can install the package by using devtools library. Simply run this code:


```R
library(devtools) #make sure that the library is installed
install_github("jirimotyl/edss")
```

<h2>How to cite</h2>
<li>Motyl, J. (2024). EDSScalculator. <i>GitHub</i>. <a href = "https://github.com/jirimotyl/edss/">https://github.com/jirimotyl/edss</a></li>

<h2>Description</h2>
<h3>Usage</h3>

```R
edss_calculation(
  score_pyramidal,
  score_cerebellar,
  score_brain_stem,
  score_sensory,
  score_bowel_bladder,
  score_visual,
  score_mental,
  score_ambulation,
  imed = F
)
```

<h3>Arguments</h3>
<li>score_pyramidal = Pyramidal functional subsystem ranges 0 - 6</li>
<li>score_cerebellar = Cerebellar functional subsystem ranges 0 - 5</li>
<li>score_brain_stem = Brain Stem functional subsystem ranges 0 - 5</li>
<li>score_sensory = Sensory functional subsystem ranges 0 - 6</li>
<li>score_bowel_bladder = Bowel and Bladder functional subsystem ranges 0 - 6</li>
<li>score_visual = Visual functional subsystem ranges 0 - 6</li>
<li>score_mental = Cerebral functional subsystem ranges 0 - 5</li>
<li>score_ambulation = Ambulation score that ranges 0 - 16 (for imed = F) or 0 - 13 (for imed = T)</li>
<li>imed = This parameter allows to choose whether to use original Neurostatus range 0 - 16 for ambulation score (default; imed = F). By setting imed = T you can use shortened version with range 0 - 13 in ambulation score. In this cace the original ambulation subscores of 5-7 and 8-9 are merged into scores 5 and 6 respectively.</li>

<h3>Value</h3>
EDSS total score (ranging between 0 and 10)

<h3>Examples</h3>

```R
edss_total_01 <- edss_calculation(3, 1, 2, 3, 2, 1, 1, 6)
edss_total_02 <- edss_calculation(3, 1, 2, 3, 2, 1, 1, 6, imed = T)
```

<h2>Acknowledgements</h2>
I would like to thank <a href = "https://github.com/adobrasinovic">Aleksandar Dobrašinovic</a> for the inspiration to write this script and for the clear overview of the EDSS conditions that made it much easier to write this package. Also I would like to thank AI tools for final debugging of the code.
