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


run_py_gemini = function(prompt_file, img_file=NULL, model="gemini-1.5-flash", json_mode=FALSE, temperature=0, add_prompt=FALSE, verbose=TRUE) {
  library(httr)
  library(jsonlite)

  # Check the status code of the response
  status_code = status_code(response)

  # Output the content of the response
  json = content(response, "text")

  if (verbose) {
    cat("\n\nResult:\n",nchar(json), " characters:\n\n",json)
  }
  library(jsonlite)
  res = try(fromJSON(json),silent = TRUE)
  if (is(res, "try-error")) {
    res = list(status_code = status_code,parse_error=TRUE, json=json)
    return(res)
  }
  res$status_code = status_code
  res$parse_error = FALSE
  if (add_prompt) {
    res$prompt = prompt
  }
  res$model = model
  res$json_mode = json_mode
  res$temperature = temperature
  res

}

