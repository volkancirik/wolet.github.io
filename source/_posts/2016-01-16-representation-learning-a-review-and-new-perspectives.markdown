---
layout: post
title: "Representation Learning: A Review and New Perspectives"
date: 2016-01-16 18:07:09 -0500
comments: true
categories: reading
---

The first reading of the semester is from Bengio et. al. ["Representation Learning: A Review and New
Perspectives"](http://arxiv.org/pdf/1206.5538.pdf). The paper's motivation is threefold : what are the 1) *right objectives* to learn *good representations*, 2) how do we compute these representations, 3) what is the connection between **representation learning**, **density estimation** and **manifold learning**.

------

How we represent the data to a Machine Learning (ML) model's determines its sense of domain, consequently, its success. For many domains, feature engineering is one of the earliers steps in a ML pipeline. This labor-intensive effort shows that the existing ML algorithms, or the setup, is not able to extract discrimative information from raw data. To make prograss towards Artificial Intelligence (AI), our solutions shout be able to **identify and disentagle the underlying explanatory hidden factors** of the raw data.

We observe the impact of Representation Learning (RL) and Deep Learning (DL) in different domains. Early success of these models are in Speech Recognition. Now, we have many solutions for masses (such as Siri, Cortana, Google Now and Echo). The resurgence of DL models happenned on Object Recognition [(Krizhevsky et al., 2012)](http://papers.nips.cc/paper/4824-imagenet-classification-with-deep-convolutional-neural-networks.pdf). One of the main focus of the DL community is Natural Language Processing (NLP) and [Bengio et. al. 2003](http://www.jmlr.org/papers/volume3/bengio03a/bengio03a.pdf) and [Collobert et al. 2011](http://www.jmlr.org/papers/volume12/collobert11a/collobert11a.pdf) are prominent examples of the success of DL. Most notably, the success of DL models on Multi-Task and Transfer Learning challenges shows that the RL algorithms resulting representations capture underlying factors which may be relevant to different tasks. I think any DL-based models using pre-trained word vectors (whether the model finetunes it or not) are supporting this claim of the paper.

A recipe for good representation is below. I'll shortly review each of the bullet points:

* Must satisfy some of the priors about the world around us
* Smoothness and the Curse Of Dimensionality
* Distributed Representations
* Depth and Abstraction
* Disentangling Factors of Variation
* Good Criteria For Learning Representations

**Priors for Representation Learning in AI**
Let's introduce some notation before explaining priors. Our aim to learn a function $f$ of input $X$ to output $Y$. $x$ is an instance of input $X$ and the value we want to learn with $f$ is $y$. A good representation should satisft some of the below priors:

- **smoothness** : for $x \approx y$ implies $f(x) \approx f(y)$.
- **multiple explanatory factors** : the distribution generating the data has a set of underlying factors.
- **a hierarchical organization of explanatory factors** : the abstract concepts explaining the world can be decomposed into less abstract ones.
- **semi-supervised learning** : things explaining $P(X)$ tend to be useful for learning $P(Y \mid X)$. (e.g word embeddings learned during Language Modelling (LM) in general useful for supervised tasks).
- **shared factors across tasks** : the factors explaining $P(Y \mid X,task)$, shared with other tasks (e.g multi-task learning)
- **manifolds** : there is a smaller space than original space where the probability mass is concentrated
- **natural clustering** : local variations on the manifold tend to preserve the category of the instances that live on that manifold
- **temporal & spacial coherence** : consecutive or spatially nearby observations tend to be in the same neighborhood on the manifold, thus preserving relevant categorical concepts
- **sparsity** : only a small subset of factors are *active* or relevant for an instance $x$.
- **simplicity of factor dependencies** : factors explaining the data, are related to each other through simple (e.g linear) dependencies.


**Smoothness and the Curse Of Dimensionality** : Non-parametric learners assume that $f$ is smooth enough and they can rely on examples to expilicityl map out the wrinkles (i.e how it behaves around instances) of the target function. But, the number of such wrinkles (i.e variance of $f$) may grow exponentially with the number of interacting factors when the represented data in raw space. Instead, they propose to use these non-parametric learners on top of learned representations. Learned representations will provide the similarity metric which is the core need of a non-parametric model such as kernel machines.

**Distributed Representations** : Distributed representations provide an exponential gain in learning the hyperplanes separating the data into regions. 

 ![distributed representations rox](https://dl.dropboxusercontent.com/s/p40jirtw49ecz7g/distributed_representations.png)

Let me elaborate using above example from [Bengio 2009](http://www.iro.umontreal.ca/~bengioy/papers/ftml_book.pdf). Using only 3 features, one can separate 7 regions. Unlike learners of one hot representations which all require $O(N)$ parameters to distinguish $O(N)$ input regions, learners of distributed representations e.g RBMs, can distinguish $O(2^k)$ input regions using only $O(N)$ parameters. The main reason is each unit/region separator benefits from many examples, even if these examples are not neighbors at all, for tuning the parameters. Another way to look at it : for a sample $x$, a subset of features/units/region separators will be activated thus will be used to learn their parameters. 

**Depth and Abstraction** : The depth, the length of the longest path from input node to output node, provides two advantages. First, feature re-use, which I don't fully understand. However, one remark is very important. Deep models learn exponantially more efficient than shallow counterparts which suggest that they require fewer parameters, consequently, can be learned with fewer examples. Second, in deep architectures, each level provides the ground for more abstract representations. More abstract concepts are usually sensitive to specific changes on the lower concepts (invariance).

**Disentangling Factors of Variation** : A good representation should disentangle as many factors as possible while discarding as little information about the data as useful. This smells a lot like allegedly [Einstein's simplicity quote](http://quoteinvestigator.com/2011/05/13/einstein-simple/) and the concept of Occam's Razor.

**Good Criteria For Learning Representations** : We hope a good representation satisfy many criteria but it is an open problem to turn these criteria into objectives in an ML model.

(to be continued)
