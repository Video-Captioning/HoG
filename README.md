# Project Overview
## Video-Captioning
--------

To illustrate the concepts, let's focus on this specific application:

* The sport of Ultimate Frisbee, specifically women's ultimate
* Interesting moments: 
  - During Play: Pulls, Catches, Layouts
  - Between Plays: Scoreboard, High-Fives, Fans in Stands, Miscellaneous

--------

## Inspiration
During MLConf Seattle May 19, 2017, Serena Yeung's presentation, 'Towards Scaling Video Understanding' piqued my curiosity.
Soon after the conference, I read a paper she co-authored, 'End-to-end learning of action detection from frame glimpses in videos'.

The main idea is
  an observation network encodes visual representations of video frames
  a recurrent network sequentially processes these observations and decides both which frame to observe next and when to emit a prediction.

  Beginning at an arbitrarily selected point in the video, repeat the following:
    examine a few frames to find out which actions are occurring at that point in time
    decide where to look next, i.e., ahead or behind, and by how far
  Once the prediction confidence has improved sufficiently, output the prediction
  
--------
A few techniques will be needed in order to achieve our goal: 
* [Video Excerpting](Techniques-Excerpt.md)
* [Feature Extraction](Techniques-Feature-Extract.md)
* [Image Classification](Techniques-Image-Classify.md)
* Learning Where to Look
* Captioning

See [Experiments](Experiment-List.md)
# HoG
