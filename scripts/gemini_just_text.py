import pathlib
import textwrap

import google.generativeai as genai
import os

import sys

# main
model_name = sys.argv[1]
json_mode = sys.argv[2]
temperature = sys.argv[3]
out_file = sys.argv[4]
prompt_file = sys.argv[5]


print ('\nmodel=', model_name)
print ('\nprompt_file=', prompt_file)
print ('\nout_file=', out_file)

API_KEY = os.environ['API_KEY']
genai.configure(api_key=API_KEY)

model = genai.GenerativeModel(model_name)

prompt = pathlib.Path(prompt_file).read_text()

print("\nPrompt:\n", prompt)

response = model.generate_content([prompt])

print("\nresponse.text:\n")
print(response.text)

pathlib.Path(out_file).write_text(response.text)
