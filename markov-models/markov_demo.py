# Markov model demo (Python 3)
# 
# This is a simulation based on the "English lad" example in chapter 10
# of the book _Performance by Design: Computer Capacity Planning by Example_
# by Daniel A. Menasce, et al (Prentice Hall).
# See https://learnstats.io/tutorials/r/solve-markov-model-r
#
# Analytic result:
# 0.2644231   0.1586538 0.3461538 0.2307692
import random

# Markov model
states = [ 'Drinking', 'Sightseeing', 'Hiking', 'Kayaking' ]
transitions = [
    [ 0.4, 0.6, 0.0, 0.0 ],
    [ 0.2, 0.0, 0.8, 0.0 ],
    [ 0.3, 0.0, 0.5, 0.2 ],
    [ 0.1, 0.0, 0.2, 0.7 ]
]
counts = [ 0 ] * len(states)

def run_simulation(steps):
    print('Running the simulation for', steps, 'steps...')
    curr_state = 0
    for i in range(1, steps + 1):
        counts[curr_state] += 1
        if i % 500 == 0:
            print_counts(i)
        curr_transitions = transitions[curr_state]
        cum_prob = 0.0
        r = random.uniform(0.0, 1.0)
        for j in range(0, len(curr_transitions)):
            cum_prob += curr_transitions[j]
            if r <= cum_prob:
                curr_state = j
                break

def print_counts(step):
    line = '[Step ' + str(step) + '] '
    for i in range(0, len(states)):
        if i > 0:
            line = line + ', '
        rate = counts[i] / step
        line = line + states[i] + ': ' + str(counts[i]) + ' (' + "{:.4f}".format(rate) + ')'
    print(line)

run_simulation(10000)
