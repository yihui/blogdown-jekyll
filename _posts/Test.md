---
title: "Test"
author: "TZ"
date: "1 November, 2015"
---

### 3. p270 Problem 3 (Bonus, not required)

#### (a)

Notice that $(I_n - H)Y = (I_n - H)(X \beta + \epsilon) = (I_n - H)\epsilon$, if $e_i = c_i^T (I_n - H)\epsilon$, then we have $c_i^T = (0, 0, ..., 1, 0, 0)$, that is, only the $i_{th}$ element of $c_i$ is 1, others are 0.

#### (b)

$$(n - p)^{-1}r_i^2 = \frac{(n - p)^{-1}e_i^2}{S^2 (1 - h_i)} = \frac{(c_i^T (I_n - H)\epsilon)^2}{\epsilon^T (I_n - H) \epsilon (1 - h_i)}$$

Let $Z = \frac{\epsilon}{\sigma}$, then the above equation can be written as $\frac{Z^TQZ}{Z^T(I_n - H)Z}$

#### (c)

Plug in $c_i^T(I_n - H)c_i = 1 - h_i$ and notice that $(I_n - H)$ is idenpotent, we have

$$Q^2 = (1 - h_i)^{-1}(I_n - H)c_i c_i^T (I_n - H)$$

which is exactly $Q$

#### (d)

Since $(I_n - H)$ is indenpotent and $(I_n - H)Q = Q$, we have

$$(I_n - H - Q)^2 = (I_n - H)^2 - 2(I_n - H)Q + Q^2 = I_n - H - 2Q + Q = I_n - H - Q$$

It's easy to verify that $I_n - H - Q$ is symmetric, thus it is projection matrix.

Since $Q(I_n - H - Q) = 0$ we know that $Z^TQZ \perp Z^T(I_n - H - Q)Z$

$rank(Q) = trace(Q) = 1$, $rank(I_n - H - Q) = trace(I_n - H - Q) = n - p - 1$, thus $\frac{Z^TQZ}{Z^T(I_n - H)Z}$ can be seen as $\frac{\chi_1^2}{\chi_1^2 + \chi_{n-p-1}^2}$, thus follows $B(\frac{1}{2}, \frac{(n-p-1)}{2})$

### 4. p270 Problem 4 (Bonus, not required)

Since $(I_n - H)$ is idenpotent we have $(I_n - H)_{ii}^2 = (1 - h_i)$, thus

$$(1 - h_i) = (I_n - H)_{ii}^2 = \sum_{j = 1}^{n} (\delta_{ij} - h_{ij})^2 = (1 - h_i)^2 + \sum_{j \neq i} h_{ij}$$
