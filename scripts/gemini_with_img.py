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
mime_type = sys.argv[6]
img_file = sys.argv[7]


print ('\nmodel=', model_name)
print ('\nprompt_file=', prompt_file)
print ('\nimg_file=', img_file)
print ('\nout_file=', out_file)

API_KEY = os.environ['API_KEY']
genai.configure(api_key=API_KEY)

model = genai.GenerativeModel(model_name)


img_spec = {
    'mime_type': mime_type,
    'data': pathlib.Path(img_file).read_bytes()
}

prompt = pathlib.Path(prompt_file).read_text()

print("\nPrompt:\n", prompt)

response = model.generate_content([prompt, img_spec])

print("\nresponse.text:\n")
print(response.text)

pathlib.Path(out_file).write_text(response.text)
