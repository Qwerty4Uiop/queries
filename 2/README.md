# Desription
There is a water tap, a drain pipe and two empty containers of 3 liters and 5 liters.  
Water can be poured into a container from the water tap. The water in the water tap never ends. Water can not be poured back in the water tap.  
Water from any container can be poured into another container.  
From any container, water can be poured into the drain pipe. It is impossible to fill the drain pipe. From the drain pipe you can not pour water.  
By successive actions it is necessary to fill one of the containers with exactly 4 liters of water.  
In this case, you can not return to the state in which the containers have already been located.  
Script displays all possible solutions.  
Each variant is a sequence of states of containers in this format:  
0-0, X1-Y1, ..., Xi-Yi, ..., Xn-Yn  
Xi is the number of liters of water in the first container at the i-th step, Yi is the number of liters of water in the second container at the i-th step.  
0-0 is the initial state: two empty containers.  

Example, one of the solutions:  
0-0, 0-5, 3-2, 0-2, 2-0, 2-5, 3-4