if (!FALSE) {
  source("~/scripts/py_tools.R")
  print(normalizePath("~/scripts"))
  setwd("~/scripts")
  py_run_script("gemini.py",args=list(model="gemini-1.5-flash", json_mode=FALSE, temperature=0, prompt_file = "/root/prompts/prompt.txt",mime_type="image/png", img_file = "/root/prompts/cookie.png"))
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
