import pathlib
import textwrap

import google.generativeai as genai
import os

import sys

# main
model_name = sys.argv[1]
json_mode = sys.argv[2]
temperature = sys.argv[3]
prompt_file = sys.argv[4]
mime_type = sys.argv[5]
img_file = sys.argv[6]

print ('model=', model_name)
print ('prompt_file=', prompt_file)


API_KEY = os.environ['API_KEY']
genai.configure(api_key=API_KEY)

model = genai.GenerativeModel(model_name)


img_spec = {
    'mime_type': mime_type,
    'data': pathlib.Path(img_file).read_bytes()
}
prompt = "Do these look store-bought or homemade?"

response = model.generate_content([prompt, img_spec])
print(response.text)
