import pathlib
import textwrap

import google.generativeai as genai
import os

import sys

# main
model_name = sys.argv[1]
json_mode = sys.argv[2]
temperature = float(sys.argv[3])
out_file = os.getenv('GITHUB_WORKSPACE', '')
prompt_file = sys.argv[5]
mime_type = "image/jpeg"


print('\nmodel=', model_name)
print('\nprompt_file=', prompt_file)
print('\nout_file=', out_file)

API_KEY = os.environ['API_KEY']
genai.configure(api_key=API_KEY)

if (json_mode == "TRUE"): 
  #config = GenerationConfig(temperature=temperature, response_mime_type="application/json")
  model = genai.GenerativeModel(model_name, generation_config={"response_mime_type": "application/json", "temperature": temperature})
else:
  model = genai.GenerativeModel(model_name, generation_config={ "temperature": temperature})


img_specs = []
for img_path in pathlib.Path('./prompts').glob('*.jpg'):
    img_spec = {
        'mime_type': mime_type,
        'data': img_path.read_bytes(),
        'name': img_path.name
    }
    img_specs.append(img_spec)

prompt = pathlib.Path(prompt_file).read_text()

print("\nPrompt:\n", prompt)

response = model.generate_content([prompt] + img_specs)

print("\nresponse.text:\n")
print(response.text)

pathlib.Path(out_file).write_text(response.text)
