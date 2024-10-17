<h1>EDSScalculator: EDSS Calculator for R</h1>

R Package EDSScalculator that calculates total EDSS score from functional subsystem subscores 

Expanded Disability Status Scale (EDSS) is the most common scoring system to evaluate the clinical neurological status of patients with Multiple Sclerosis (MS). This package is intended for calculation of the total EDSS score from functional subsystem scores. Calculations are based both on the Neurostatus adaptation of the scoring system (Kappos et al.): https://www.neurostatus.net/scoring/index.php, and on the original as proposed by John F. Kurtzke. You can choose the scoring system you wish to apply. For Neurostatus it is possible to calculate total EDSS both for ambulation with 12(13) grades and also with 16 grades. 

The functioning of the calculator was validated on a large dataset of almost 11000 unique real-life EDSS observations. Conditions that do not follow rigorous Neurostatus criteria but appear in the real-life data were incorporated.

<h2>Install</h2>
You can install the package by using devtools library. Simply run this code:


```R
library(devtools) #make sure that the library is installed
install_github("jirimotyl/edss")
```

<h2>How to cite</h2>
<li>Motyl, J. (2024). EDSScalculator: EDSS Calculator for R (version 0.3.0) [R package]. <i>GitHub</i>. <a href = "https://github.com/jirimotyl/edss/">https://github.com/jirimotyl/edss</a></li>

<h2>Description</h2>
<h3>Usage</h3>

```R
library(EDSScalculator)

edss_calculation(
  score_pyramidal,
  score_cerebellar,
  score_brain_stem,
  score_sensory,
  score_bowel_bladder,
  score_visual,
  score_mental,
  score_ambulation,
  edss_method = "kurtzke"
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
<li>score_ambulation = Ambulation score that ranges 0 - 16 (for edss_method = "neurostatus_16") or 0 - 12(13) (for edss_method = "neurostatus_12" or "kurtzke")</li>
<li>edss_method = This parameter allows to choose the method of EDSS calculation. There are three possible parameters: 1) "kurtzke" (default): The original procedure by Kurtzke; 2) "neurostatus_12" Neurostatus evaluation, in this case with 12(13) grades for ambulation scale; 3) "neurostatus_16" Same Neurostatus evaluation but in this case with 16 grades for ambulation scale.</li>

<h3>Value</h3>
EDSS total score (ranging between 0 and 10)

<h3>Examples</h3>

```R
edss_total_01 <- edss_calculation(3, 1, 2, 3, 2, 1, 1, 6)
edss_total_02 <- edss_calculation(3, 1, 2, 3, 2, 1, 1, 6, edss_method = "neurostatus_12")
edss_total_03 <- edss_calculation(3, 1, 2, 3, 2, 1, 1, 6, edss_method = "neurostatus_16")
edss_total_04 <- edss_calculation(3, 1, 2, 3, 2, 1, 1, 6, edss_method = "kurtzke")
```

<h2>Acknowledgements</h2>
I would like to thank <a href = "https://github.com/adobrasinovic">Aleksandar Dobrašinovic</a> for the inspiration to write this script and for the clear overview of the EDSS Neurostatus conditions that made it much easier to write this package. Also I would like to thank AI tools for final debugging of the code.

<h2>References</h2>
<li>Kurtzke, J. F. (1983). Rating neurologic impairment in multiple sclerosis: an expanded disability status scale (EDSS). Neurology, 33(11), 1444-1444.
</li>
<li>Kappos, L. (2011). Neurostatus scoring. <i>University hospital Basel</i>. <a href = "https://www.neurostatus.net/media/specimen/Definitions_0410-2_s.pdf">www.neurostatus.net/media/specimen/Definitions_0410-2_s.pdf</a></li>
<li>Dobrašinovic, A. (2020). EDSS Calculator. <i>GitHub</i>. <a href = "https://github.com/adobrasinovic/edss">github.com/adobrasinovic/edss</a></li>
