---
layout: post
title: "Visualizing and Understanding Convolutional Neural Networks"
date: 2016-01-27 11:56:18 -0500
comments: true
categories: reading
published: true
---
Second reading of the semester is from Ziler & Fergus ["Visualizing and Understanding Convolutional Networks"](http://arxiv.org/pdf/1311.2901v3.pdf). If you don't feel comfortable with Convolutional Networks I suggest to read following readings before this paper :  [Nielsen's Chapter on Conv Nets](http://neuralnetworksanddeeplearning.com/chap6.html), [Colah's Explanation of Convolution with Visualizations](http://colah.github.io/posts/2014-07-Understanding-Convolutions/), and [Britz's post on CNNs for NLP](http://www.wildml.com/2015/11/understanding-convolutional-neural-networks-for-nlp/).

The core idea of the paper is to use visualization of deeper layers in the ConvNet (i) to understand what's going on under the hood and (ii) to extend them for better performance. Unlike many papers in the field, it provides lots of insights useful for further research. 

------
It is common to visualize the feature maps of the first layer in a ConvNet, but it is not trivial for further layers because of pooling. They address this using **deconvnet**. The main idea is to go backward (Feed-Backward??) in ConvNet.  Moving from unpooled maps to previous filter layer is straightforward : just use the transposed filter. The tricky part is the unpooling layer. How would you go back from pooling layer? You keep track of the positions of the max value for each pooling region (they name them *switch*).  Trivially, unpooling would generate blurrier images if it were mean. See below image from the paper for unpooling. 

![unpooling](https://dl.dropboxusercontent.com/u/13917601/unpooling.png)

So, how would we use deconvnet for visualization? First we train a model. For a feature map learned in some layer, we pull the deconv trick and reconstruct an image that will show for which image that feature map is activated most. Let's see what's going on in a ConvNet when it is trained on ImageNet data.

![feature maps](https://dl.dropboxusercontent.com/u/13917601/vis_feature_map.png)

Above, for each layer some random feature maps, their top 9 activations and reconstructed images are visualized. I don't see anything surprising in the first layer. There is some abstraction in Layer 2. But layer 3 is surprising. On the upper left, we see that feature map is specialized in grid-like shapes for texture because *these are the top activations of the same feature map*. In the context of deep learning it is common knowledge that the model uses abstraction in higher layers, and here we observe this phenomenon. My another cherry-pick would be the one in row 2, column 4. That feature map is sensitive to things with a series of things with the same height and separated by similar distances such as text or windows in a building.

![4->5](https://dl.dropboxusercontent.com/u/13917601/layer4-5.png)

However, if we take a look at layer 4 & 5, the use of abstraction is not as evident as going from 2-3. I will argue that there could be a limit of abstraction in a ConvNet. It may be impossible to abstract away the spatial relationships between objects in a large image or address visual analogies with this classical model. That's enough for speculation, let's move on with another visualization.

![evolution of feature maps](https://dl.dropboxusercontent.com/u/13917601/evolution.png)

Above we see how 6 random feature maps for each layer are changing during training. Again, it is nice to see that, feature maps in lower layer converging faster and more abstract layers reach their final form later in training. This is a weak evidence that abstraction and feature re-using is happening in ConvNets. It would be great to show that feature maps in upper layers share some feature maps of below layer using the same deconvolution idea.

![invariance of feature maps](https://dl.dropboxusercontent.com/u/13917601/invariance.png)

Above is another useful visualization. Again, it is common knowledge that ConvNets learn invariant features. Here, they translate, scale, and rotate randomly picked 5 images (column 1). They show the distance between transformed and original feature vectors in different layers (column 2,3) and the probability of the true table for each transformation (column 4). There are too many interesting things going on here. For instance, in c4 we see random picks for some object categories but not for the lawn mower. I think it is because the model sees the lawn mowers and their handles with a certain angle during training. When it is rotated it is having difficulty to detect that it is a lawn mower. Another example is on b4. When the scale is increased too much, we are loosing the focus of tv + its context and it is hard for the model to classify it as an entertainment center. I invite you to spend some time on this graphs and images. 

![occlusion](https://dl.dropboxusercontent.com/u/13917601/occlusion.png)

Another question is whether a ConvNet is able to locate objects or their features in an image. As show in above, they cover up different parts of the image (a), visualize how much the strongest feature maps are activated (b), what are these feature maps (c) and how would these occlusions change models prediction power (d,e). Nothing surprising but it is nice to observe that the model is able to (i) locate the most discriminative location of the image (ii) use the most relevant feature maps -- feature maps in (c) are exactly what I use in my mind to predict the breed of this dog (iii) and it heavily depends on using this discriminative location. 

Another interesting analysis is to see whether the model implicitly computes a correspondence between object parts in *different* images. For instance, eyes and nose of dogs are always observed in similar distance and rotation. Their relative distances do not drastically change (we don't see any dog with one eye is terribly far away from the other). Interestingly, they pick only 5 dog images (not 5 types of dogs with many images) to see whether the deltas in feature calculations are moving in the same direction (clever to use Hamming distance) when left eye, right eye, and the nose is covered. They concluded that the model employs some sort of correspondence of these parts. As I speculated earlier, we may need a new layer to model these forms of spatial correspondence which can be learned from training data without extra annotation.

Finally, they use visualization of feature maps in different layers to see how efficient a model for learning useful feature maps. It turns out, Alexnet is wasting some of the parameters for learning non-discriminative feature maps. Visualization helps us choose hyperparameters of the model like the size of strides and feature maps to make it more accurate and more efficient in terms of parameters.

Using the insight they gain from visualization, they evaluate supervised pre-trained models in Caltech and Pascal benchmark. To be more explicit, they train their model on ImageNet, discard the softmax layer, and train the model with brand new softmax layer for the new dataset. It is like merging a bullet with a used shell for a new shot (terrible analogy). It turns out that the feature maps learned in ImageNet are discriminative enough to achieve great results on these benchmarks. 

They also investigate the use of a different number of hidden units in a fully connected layer, varying the depth of convnet etc. Although I agree the claims are true (the higher number of deep convolutional layers is crucial but not for a fully connected layer), they never mention the number of parameters of each compared model, doing gridsearch to learn width of layers, or any form of cross-validation; the reported numbers are not conclusive. (Interestingly *very very few* people fairly compare different models, I guess nobody cares about model complexity.)

tl;dr Great paper with lots of insights on how ConvNets work. A paper with a similar quest in the context of sequence modeling is["Visualizing and Understanding Recurrent Networks"](http://arxiv.org/pdf/1506.02078v2.pdf).

