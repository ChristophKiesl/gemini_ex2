example = function() {
  setwd("~/repbox/gemini/gemini_py")
  #pip_install("-q -U google-generativeai")
  py_run_script("gemini.py")
}

get_py_bin = function() {
  "python3"
}

pip_install = function(args, py_bin = get_py_bin()) {
  cmd = paste0(py_bin, ' -m pip install ', args)
  system(cmd)
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
