* Encoding: UTF-8.
****FINAL ANALYSES REPORTED IN MANUSCRIPT*****.

***exclusions and sample demographics.

DO IF  (Attencheck1=1 and Attencheck2=1).
RECODE ResponseID (ELSE=1) INTO Pass_both_att.
END IF.
VARIABLE LABELS  Pass_both_att '1 = passed both attention checks'.
EXECUTE.

FREQUENCIES VARIABLES=checkfails Attencheck1 Attencheck2 offsexcheck offracecheck Pass_both_att 
  /ORDER=ANALYSIS.

*demographics.

USE ALL.
COMPUTE filter_$=(checkfails=1).
VARIABLE LABELS filter_$ 'checkfails=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

FREQUENCIES VARIABLES=ethnicity partage Partgender
  /STATISTICS=STDDEV RANGE MINIMUM MAXIMUM MEAN MEDIAN MODE
  /ORDER=ANALYSIS.

**Scale reliability.


*PoLTRUST scale*

RELIABILITY 
  /VARIABLES=Q209_1 Q305_1 Q306_1 Q343_1 Q345_1
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE CORR
  /SUMMARY=TOTAL.

*emo react scale*

RELIABILITY 
  /VARIABLES=Q132_1 Q135_1 Q136_1 Q349_1
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE CORR
  /SUMMARY=TOTAL.

*internal and external attributions.


*internal attributions*

RELIABILITY 
  /VARIABLES=Q358_1 Q359_1 Q362_1
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE CORR
  /SUMMARY=TOTAL.

*external attributions*

RELIABILITY 
  /VARIABLES=Q448_1 Q449_1 Q450_1
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE CORR
  /SUMMARY=TOTAL.


*officer perceptions*

RELIABILITY 
  /VARIABLES=Q168_1 Q169_1 Q170 Q171 Q172_1
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE CORR
  /SUMMARY=TOTAL.

*preliminary analyses.

**participant gender.


USE ALL.
COMPUTE filter_$=(checkfails=1 and partgender~=9).
VARIABLE LABELS filter_$ 'checkfails=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

UNIANOVA poltrust BY offsex partGender UseForce
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PLOT=PROFILE(offsex*partGender*UseForce)
  /EMMEANS=TABLES(UseForce*offsex) COMPARE(offsex)ADJ(LSD)
  /PRINT=DESCRIPTIVE ETASQ
  /CRITERIA=ALPHA(.05)
  /DESIGN=offsex partGender UseForce offsex*partGender offsex*UseForce partGender*UseForce 
    offsex*partGender*UseForce.

UNIANOVA offperc BY offsex partGender UseForce
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PLOT=PROFILE(offsex*partGender*UseForce)
  /EMMEANS=TABLES(UseForce*offsex) COMPARE(offsex)ADJ(LSD)
  /PRINT=DESCRIPTIVE ETASQ
  /CRITERIA=ALPHA(.05)
  /DESIGN=offsex partGender UseForce offsex*partGender offsex*UseForce partGender*UseForce 
    offsex*partGender*UseForce.


**participant race.

USE ALL.
COMPUTE filter_$=(checkfails=1).
VARIABLE LABELS filter_$ 'checkfails=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

UNIANOVA poltrust BY OffRace partrace UseForce
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PLOT=PROFILE(OffRace*partrace*UseForce)
  /EMMEANS=TABLES(UseForce*OffRace) COMPARE(OffRace)ADJ(LSD)
  /PRINT=DESCRIPTIVE ETASQ
  /CRITERIA=ALPHA(.05)
  /DESIGN=OffRace partrace UseForce OffRace*partrace OffRace*UseForce partrace*UseForce 
    OffRace*partrace*UseForce.

UNIANOVA offperc BY OffRace partrace UseForce
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PLOT=PROFILE(OffRace*partrace*UseForce)
  /EMMEANS=TABLES(UseForce*OffRace) COMPARE(OffRace)ADJ(LSD)
  /PRINT=DESCRIPTIVE ETASQ
  /CRITERIA=ALPHA(.05)
  /DESIGN=OffRace partrace UseForce OffRace*partrace OffRace*UseForce partrace*UseForce 
    OffRace*partrace*UseForce.

*Table 1 - correlations.

CORRELATIONS
  /VARIABLES= OffPerc PolTrust internal external Agress EmoScale
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

*********************ANOAVs for Table 2 and 2 main dependent DV ANOVAs reported in text************.

*Police Trust ANOVA.

UNIANOVA Poltrust BY UseForce OffRace Offsex
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PLOT=PROFILE(offsex*OffRace*UseForce)
  /EMMEANS=TABLES(UseForce*offsex) COMPARE(offsex)ADJ(LSD)
  /PRINT=DESCRIPTIVE ETASQ
  /CRITERIA=ALPHA(.05)
  /DESIGN=offsex OffRace UseForce offsex*OffRace offsex*UseForce OffRace*UseForce 
    offsex*OffRace*UseForce.


*officer effectiveness ANOVA.

UNIANOVA OffPerc BY UseForce OffRace Offsex
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PLOT=PROFILE(offsex*OffRace*UseForce)
  /EMMEANS=TABLES(UseForce*offsex) COMPARE(offsex)ADJ(LSD)
  /PRINT=DESCRIPTIVE ETASQ
  /CRITERIA=ALPHA(.05)
  /DESIGN=offsex OffRace UseForce offsex*OffRace offsex*UseForce OffRace*UseForce 
    offsex*OffRace*UseForce.


*replicate main findings while covarying participant gender.

UNIANOVA Offperc BY offsex UseForce OffRace WITH PartGender 
  /METHOD=SSTYPE(3) 
  /INTERCEPT=INCLUDE 
  /CRITERIA=ALPHA(.05) 
  /DESIGN=PartGender offsex UseForce OffRace offsex*UseForce offsex*OffRace UseForce*OffRace 
    offsex*UseForce*OffRace.

UNIANOVA Poltrust BY offsex UseForce OffRace WITH PartGender 
  /METHOD=SSTYPE(3) 
  /INTERCEPT=INCLUDE 
  /CRITERIA=ALPHA(.05) 
  /DESIGN=PartGender offsex UseForce OffRace offsex*UseForce offsex*OffRace UseForce*OffRace 
    offsex*UseForce*OffRace.

*Aggression ANOVA.

UNIANOVA agress BY UseForce OffRace Offsex
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PLOT=PROFILE(offsex*OffRace*UseForce)
  /EMMEANS=TABLES(UseForce*offsex) COMPARE(offsex)ADJ(LSD)
  /PRINT=DESCRIPTIVE ETASQ
  /CRITERIA=ALPHA(.05)
  /DESIGN=offsex OffRace UseForce offsex*OffRace offsex*UseForce OffRace*UseForce 
    offsex*OffRace*UseForce.

*Emo reactivity ANOVA.


UNIANOVA EmoScale BY UseForce OffRace Offsex
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PLOT=PROFILE(offsex*OffRace*UseForce)
  /EMMEANS=TABLES(UseForce*offsex) COMPARE(offsex)ADJ(LSD)
  /PRINT=DESCRIPTIVE ETASQ
  /CRITERIA=ALPHA(.05)
  /DESIGN=offsex OffRace UseForce offsex*OffRace offsex*UseForce OffRace*UseForce 
    offsex*OffRace*UseForce.

**internal. 

UNIANOVA internal BY UseForce OffRace Offsex
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PLOT=PROFILE(offsex*OffRace*UseForce)
  /EMMEANS=TABLES(UseForce*offsex) COMPARE(offsex)ADJ(LSD)
  /PRINT=DESCRIPTIVE ETASQ
  /CRITERIA=ALPHA(.05)
  /DESIGN=offsex OffRace UseForce offsex*OffRace offsex*UseForce OffRace*UseForce 
    offsex*OffRace*UseForce.

**external.


UNIANOVA external BY UseForce OffRace Offsex
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PLOT=PROFILE(offsex*OffRace*UseForce)
  /EMMEANS=TABLES(UseForce*offsex) COMPARE(offsex)ADJ(LSD)
  /PRINT=DESCRIPTIVE ETASQ
  /CRITERIA=ALPHA(.05)
  /DESIGN=offsex OffRace UseForce offsex*OffRace offsex*UseForce OffRace*UseForce 
    offsex*OffRace*UseForce.

**moderated mediation syntax.

COMPUTE ForceFactor=Susresist -OffForce.
COMPUTE ForceFactor_our=Susresist_our -OffForce_our.
execute.

PROCESS vars = Offsex agress EmoScale internal external poltrust UseForce/y=poltrust/x=Offsex/m=agress EmoScale internal external/w=UseForce/model=8/longname=1.
PROCESS vars = Offsex agress EmoScale internal external Offperc UseForce/y=Offperc/x=Offsex/m=agress EmoScale internal external/w=UseForce/model=8/longname=1.


