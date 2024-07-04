import pathlib
import textwrap

import google.generativeai as genai
import os

API_KEY = os.environ['API_KEY']
genai.configure(api_key=API_KEY)

model = genai.GenerativeModel('gemini-1.5-flash')

cookie_picture = {
    'mime_type': 'image/png',
    'data': pathlib.Path('/home/rstudio/repbox/gemini/gemini_py/cookie.png').read_bytes()
}
prompt = "Do these look store-bought or homemade?"

response = model.generate_content([prompt, cookie_picture])
print(response.text)
