# MATLAB-Adaptive-filter-toolbox-extended

I recently added an LMS MCC module to the toolbox.


<img width="785" alt="image" src="https://user-images.githubusercontent.com/89211293/164516608-16197db6-e9d1-4f04-80f9-131c1de30599.png">




Added various features for more accessible in-depth analysis to this Matlab Toolbox code for LMS, KLMS, KMEE (QIP and Shannon), QKLMS (MSE, MEE, and MCC), and RLS. 

**I will be adding QKRLS for MSE, MEE, and MCC in the near future.

'''
Original code found here: https://github.com/slichtenheld/MATLAB-Adaptive-Filter-Toolbox
'''

Algorithms are described extensively here with credit to my ML Time Series professor Jose Principe:

'''
S. Zhao, B. Che, and J. Principe, “Kernel Adaptive Filtering with Maximum Correntropy Criterion,” Proceedings of International Joint Conference on Neural Networks, pp. 2012–2017.
'''

# Features added

Various KLMS, KLMEE, QKLMS functions for analysis added such as filter output history

This is in order to compare the desired signals with the output of the predictive filter.
For example, using either

```
plot(klms.y_hist)
```

```
klms.plotPred()
```

(Also plot the desired signal for comparison and set x limits)


<img width="334" alt="image" src="https://user-images.githubusercontent.com/89211293/163630640-b6e4dd80-12be-4fe0-8568-b25f0ebce267.png">



Plot the PDF of the error history

```
kmeeq.plotPdf()
```


<img width="454" alt="image" src="https://user-images.githubusercontent.com/89211293/163632353-0723ec3c-662d-45e1-9a8b-82ba3a3115c9.png">


# Examples

I provide examples of performing analysis in the file analyze_example.m


