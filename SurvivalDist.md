---
title: "SurvivalDist"
author: "Miao Cai"
date: "November 10, 2018"
output: html_document
---



# Exponential distribution

The probability density function of the exponential distribution is

$$f(t) = \frac{1}{\theta}\text{exp}(-t/\theta), \quad t > 0$$

The survival function is:

\[
S(t)  = 1 - P(X \leq t) = \exp(-t/\theta), \quad t >0
\]

The hazard function is:

\[
h(t) = \frac{f(t)}{S(t)} = \frac{1}{\theta}
\]

# Weibull distribution

The probability density function of the Weibull distribution is
\[
f(t|\kappa, \theta) = \begin{cases}
\frac{\kappa}{\theta}\Big(\frac{t}{\theta}\Big)^{\kappa - 1}e^{-(t/\theta)^\kappa}, & t>0 \\
0, & t\leq 0
\end{cases}
\]

Then the survival function is:
\[
S(t|\kappa, \theta) = P(T > t) = 1 - P(T \leq t) = e^{-(t/\theta)^\kappa}
\]

The hazard function is the probability density function divided by the survival function:
\[
h(t|\kappa, \theta) = \frac{f(t|\kappa, \theta)}{S(t|\kappa, \theta)} = \frac{\kappa}{\theta}\Big(\frac{t}{\theta}\Big)^{\kappa - 1}
\]



# Gamma distribution

The probability density function of the Gamma distribution is

$$f(x) = \frac{x^{\kappa - 1}}{\theta^\kappa\Gamma(\kappa)}\text{exp}(-x/\theta), \quad x > 0$$


There are no analytical solutions to cumulative probability function, survival function and hazard function of Gamma distribution.


$$F(x) = \int_0^x \frac{\lambda^\kappa\omega^{\kappa - 1}}{\Gamma(\kappa)}\text{exp}(-\lambda \omega)d\omega$$

Then the hazard function becomes:

\[
h(x) = \frac{f(x)}{1 - F(x)} = \frac{\frac{\lambda^\kappa x^{\kappa - 1}}{\Gamma(\kappa)}\text{exp}(-\lambda x)}{1 - \frac{1}{\Gamma(\kappa)}\int_0^{\lambda x}y^{\kappa - 1}e^{-y}dy}
\]
