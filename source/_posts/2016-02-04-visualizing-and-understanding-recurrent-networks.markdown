---
layout: post
title: "Visualizing and Understanding Recurrent Networks"
date: 2016-02-04 16:21:02 -0500
comments: true
categories: reading
published: true
---
Third reading of the semester is from Karpathy et. al. [Visualizing and Understanding Recurrent Networks
](http://arxiv.org/pdf/1311.2901v3.pdf).
I can't write [a blog post](http://karpathy.github.io/2015/05/21/rnn-effectiveness/) better than the first author. But, the paper is more than learning/having fun with RNNs, it provides valuable insights about how RNNs work.
[A follow-up post](http://nbviewer.jupyter.org/gist/yoavg/d76121dfde2618422139) from Goldberg is complementing the message conveyed in the paper.
If you would like to cover the basics about sequential modelling with RNN these three readings are good starting points. 

------

![fig1](https://dl.dropboxusercontent.com/u/13917601/pap3_f1.png)

**Deeper Models with Gating Mechanism are Better:**  They compare vanilla RNN, GRU, and LSTM on Linux Kernel (LK) and Tolstoy's War and Peace (WP) using character-level language modelling as a benchmark. In this **fair comparison**, gated models (I will refer LSTMs and GRUs as Gated RNNs from now on) are better than vanilla RNN. In addition, the depth of at least two is suggested. See above table.

![fig2](https://dl.dropboxusercontent.com/u/13917601/pap3_f2.png)

**Some Cells have Specific Roles:** As seen above,  for $tanh(c)$ where -1 is red and +1 is blue, some cells are specializing in capturing some phenomenon such as counting lines, detecting quotes etc.  **Question:** what are other cells doing? **Speculation:** My bet is on helping approximation the function we would like to learn. They are not serving as a memory they are helping the computation.

![fig3](https://dl.dropboxusercontent.com/u/13917601/pap3_f3.png)

**In a Deep Gated RNN Lower Layers Don't Employ Gating Mechanism:** Let's define left/right saturation for a gate. For a gate activation frequency, $0 \leq g_a \leq 1$, we say the gate is left saturated if $g_a < 0.1$ and right saturated $g_a > 0.9$. In English, if it's right saturated corresponding gate information flows in (gate is almost always closed). If it's left saturated gate often does not let information flow in (gate is open). Above figure show that in a deep net, lower layers do not employ gating mechanism. **Question** what if we train well a single layer gated RNN, do we see the same phenomenon? **Speculation** My bet is that we will not. The complexity of the model will change the characteristics of each layer. Thus, single layer gated RNN will have some gating cells.

![fig4](https://dl.dropboxusercontent.com/u/13917601/pap3_f5.png)

**Gated RNNs Learn To Generalize for Longer Sequences:** One of the best news from this paper, it is nice to see a verification of common knowledge. Neural Network-based n-gram model overfits and fails to beat traditional n-gram model. However, for sequences greater than n, n-gram fails to generalize unlike gated RNN. RNNs history help it utilize information beyond 20 characters (See also Table 2 and Figure I in paper).

![fig4](https://dl.dropboxusercontent.com/u/13917601/pap3_f4.png)

**Gated RNNs Learn Special Functions Hinted in Data:** When characters have special functions in data such as *"@,{,\r"*, gated RNN significantly better than n-gram model at predicting them. This hints that they probably learn to model their functionality. **Question:** What if each symbol has its own set of specific function? **Speculation:** We'll see an increase in number of saturated/specializes cells in the network. A synthetic task may help us prove/disprove this speculation.

![fig6](https://dl.dropboxusercontent.com/u/13917601/pap3_f6.png)

**Gated RNNs Learn to Deal With Short-range Dependencies First**: They use a brilliant way to show that Gated RNNs behave like a lower order n-gram NN first and generalize for higher orders later. Above graph shows the comparison of the similarity between a deep LSTM and the n-NN baselines over the early epochs of training. On the left the symmetric KL-divergence between models (how similar the loss distributions/predictions are) is shown. On the right, the difference in the mean loss is shown (positive loss means RNN outperforms). 

**Gated RNNs are not super efficient at utilizing the history:** Section 4.4 of the paper shows a nice Error Analysis of the model -- which is not common in DL community. They show how to breakdown errors types and conduct oracle experiments. My takeaway from that part is an n-gram help us eliminate 18% of errors. This shows that gated RNNs do not fully utilize the previous context. They fail to compress the history of seen characters even for the previous 9 characters. **Question:** Could there be a better memory-based model in addressing this? **Speculation:** Of course!


