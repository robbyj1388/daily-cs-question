import requests, random, html 

choices = {}

# Make the API call
response = requests.get('https://opentdb.com/api.php?amount=1')

# Check if the request was successful
if response.status_code == 200:
    data = response.json()['results'][0]
    question = html.unescape(data['question'])
    correct_answer = data['correct_answer']
    raw_answer_choices = [data['correct_answer']] + data['incorrect_answers']
else:
    print(f"Error: {response.status_code}")


def format_answer_choices():
    global choices
    # Randomize raw answer choices order
    random.shuffle(raw_answer_choices)
    for i in range(0, len(raw_answer_choices)):
        choices[chr(97 + i)] = raw_answer_choices[i] # 97 = 'a' + i for next ascii char
    # Print out answer choices
    keys = choices.keys()
    values = choices.values()
    for key, value in choices.items():
        print(f'{key}: {value}')

# --- MAIN PRINT OUTS ---  
if (data['type'] == 'boolean'):
    print("True or False: ")
    print(question)
    # Get and parse user input
    user_answer = input("T or F? ").lower()[0] # Get first letter of answer
    if user_answer == 't' and correct_answer == 'True':
        print("CORRECT!")
    else:
        print("WRONG.")
else:
    print(question)
    format_answer_choices()
    # Get and parse user input
    user_answer = input("a, b, c, or d? ").lower()[0] # Get first letter of answer
    if choices[user_answer] == correct_answer:
        print("CORRECT!")
    else:
        print("WRONG.")
print(f'Answer is {correct_answer}')