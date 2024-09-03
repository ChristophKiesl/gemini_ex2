#run Code
if (!FALSE) {
  source("~/scripts/py_gemini.R")
  setwd("~/scripts")

  res = run_gemini_with_py(prompt_file = "/root/prompts/prompt.txt", json_mode=TRUE, temperature=0,out_dir = "/root/temp_out")

  cat("\nResults in R:\n")
  print(res)
  
  saveRDS(res, "/root/output/result.Rds")


}

#as in gemini_ex
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
