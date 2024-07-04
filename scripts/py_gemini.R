example = function() {
  setwd("~/repbox/gemini/gemini_py")
  #pip_install("-q -U google-generativeai")
  py_run_script("gemini.py")
}

get_py_bin = function() {
  "python3"
}


py_run_script = function(file, args=list(), dir = getwd(),py_bin = get_py_bin()) {
  if (basename(file)==file) {
    file = file.path(dir, file)
  }

  cmd = paste0(py_bin, ' "',file,'"')
  if (length(args)>0) {
    cmd = paste0(cmd," ", paste0(unlist(args), collapse=" "))
  }
  cat(cmd)
  system(cmd)
}


run_gemini_with_py = function(prompt_file, img_file=NULL, model="gemini-1.5-flash", json_mode=FALSE, temperature=0, add_prompt=FALSE, verbose=TRUE, out_dir = "~/gemini_temp") {
  library(jsonlite)


  if (!dir.exists(out_dir)) dir.create(out_dir)
  out_file = file.path("~/gemini_temp/gemini_out.txt")

  if (file.exists(out_file)) file.remove(out_file)

  has_image = !is.null(img_file)
  if (has_image) {
    mime = tolower(tools::file_ext(img_file))
    if (mime == "jpg") mime="jpeg"
    mime_type = paste0("image/",mime)

    py_run_script("gemini_with_img.py",args=list(model=model, json_mode=json_mode, temperature=temperature,out_file=out_file, prompt_file = prompt_file,mime_type=mime_type, img_file = img_file))
  } else {
    py_run_script("gemini_just_text.py",args=list(model=model, json_mode=json_mode, temperature=temperature,out_file=out_file, prompt_file = prompt_file))
  }
  res = list(model=model, json_mode=json_mode, temperature = temperature, parse_error=TRUE, content="")
  if (!file.exists(out_file)) {
    return(res)
  }

  res$parse_error = FALSE
  res$content = paste0(readLines(out_file, warn=FALSE), collapse="\n")
  if (add_prompt) {
    res$prompt = prompt
  }
  res

}

