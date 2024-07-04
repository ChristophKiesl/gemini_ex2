example = function() {
  setwd("~/repbox/gemini/gemini_py")
  #pip_install("-q -U google-generativeai")
  py_run_script("gemini.py")
}

get_py_bin = function() {
  "~/.pyenv/versions/3.12.4/bin/python"
}

pip_install = function(args, py_bin = get_py_bin()) {
  cmd = paste0(py_bin, ' -m pip install ', args)
  system(cmd)
}



py_run_script = function(file, dir = getwd(),py_bin = get_py_bin()) {
  restorepoint::restore.point("py_run_script")
  if (basename(file)==file) {
    file = file.path(dir, file)
  }
  cmd = paste0(py_bin, ' "',file,'"')
  cat(cmd)
  system(cmd)
}
