if (!FALSE) {
  source("~/scripts/py_tools.R")
  print(normalizePath("~/scripts"))
  dir.create("~/gemini_temp")
  out_file = file.path("~/gemini_temp/gemini_out.txt")
  setwd("~/scripts")

  py_run_script("gemini_with_img.py",args=list(model="gemini-1.5-flash", json_mode=FALSE, temperature=0,out_file=out_file, prompt_file = "/root/prompts/prompt.txt",mime_type="image/png", img_file = "/root/prompts/cookie.png", out_file=out_file))

  if (!file.exists(out_file)) {
    cat("\nPython did not generate an output file")
  } else {
    txt = readLines(out_file,warn=FALSE)
    cat("\nRetrieved output from python:\n")
    cat(paste0(txt, collapse="\n"))
  }

}


if (FALSE) {
  source("~/scripts/gemini_analysis.R")
  perform_analysis()
}

if (FALSE) {
API_KEY = Sys.getenv("API_KEY")

#cat("API_KEY:", substr(API_KEY,1,4))

#system("curl -h")

cat("\n\nSTART TEST ANALYS\n\n")
source("~/scripts/gemini_tools.R")


res = run_gemini("Create a short JSON output about colors.", API_KEY, json_mode=TRUE)

saveRDS(res, "/root/output/result.Rds")
try(writeLines(toJSON(res), "/root/output/result.json"))


cat("\n\nEND TEST ANALYS\n\n")

}
