# Object recognition and computer vision 2017/2018

ENS Paris-Saclay, MSc MVA

[Webpage of the lecture](http://www.di.ens.fr/willow/teaching/recvis17/)

Jean Ponce, Ivan Laptev, Cordelia Schmid and Josef Sivic

Teaching assistants:  Gul Varol and Ignacio Rocco

## Course description

Automated  object  recognition -- and  more  generally  scene  analysis -- from  photographs  and videos  is  the  grand  challenge  of  computer  vision.  This  course  presents  the  image,  object,  and scene models, as well as the methods and algorithms, used today to address this challenge.

## [Homework 1](http://www.di.ens.fr/willow/teaching/recvis17/assignment1/)

The goal of instance-level recognition is to match (recognize) a specific object or scene.  Examples include recognizing a specific building, such as Notre Dame, or a specific painting, such as 'Starry Night' by Van Gogh. The object is recognized despite changes in scale, camera viewpoint, illumination conditions and partial occlusion. An important application is image retrieval - starting from an image of an object of interest (the query), search  through an image dataset to obtain (or retrieve) those images that contain the target object.

The goal of this assignment is to experiment and get basic practical experience with the methods that enable specific object recognition. It includes: (i) using SIFT features to obtain sparse matches between two images; (ii) using affine co-variant detectors to cover changes in viewpoint; (iii) vector quantizing the SIFT descriptors into visual words to enable large scale retrieval; and (iv) constructing and using an image retrieval system to identify objects.

![alt text](/hw1/images/geo_verif.png)


<!-- ![alt text][hw1/images/geo_verif.png]

[logo]: hw1/images/geo_verif.png "Logo Title Text 2" -->

## [Homework 2](http://www.di.ens.fr/willow/teaching/recvis17/assignment2/)

In image classification, an image is classified according to its visual content. For example, does it contain an airplane or not. An important application is image retrieval - searching through an image dataset to obtain (or retrieve) those images with particular visual content.

The goal of this exercise is to get basic practical experience with image classification. It includes: (i) training a visual classifier for five different image classes (aeroplanes, motorbikes, people, horses and cars); (ii) assessing the performance of the classifier by computing a precision-recall curve; (iii) varying the visual representation used for the feature vector, and the feature map used for the classifier; and (iv) obtaining training data for new classifiers using Google / Bing image search.
