library(stringr)
# Load koohii data
s.v4 <- readRDS("rtk3-remain.rds")
s.v4 <- as.data.frame(s.v4, stringsAsFactors = FALSE)
for (i in 1:830) {
	s.no <- s.v4[i,1]
	s.ka <- s.v4[s.v4$no==s.no,2]
	s.key <- s.v4[s.v4$no==s.no,3]
	s.sks <- s.v4[s.v4$no==s.no,4]
	s.koo <- s.v4[s.v4$no==s.no,5]
	s.on <- s.v4[s.v4$no==s.no,6]
	# File name
	# File content
	content <- paste0("---",
										"\nlayout: kanji-remain",
										"\nv4: ", s.no,
										"\nkanji: ", s.ka,
										"\nkeyword: ", s.key,
										"\nstrokes: ", s.sks,
										"\non-yomi: ", s.on,
										"\npermalink: /", s.ka,"/",
										"\nredirect_to: ", paste0("https://hochanh.github.io/rtk/",s.ka),
										#"\nredirect_from:",
										#"\n - /v4/", s.no, "/",
										"\n---",
										"\n\n", ifelse(s.koo=="","","## Koohii stories: "),
										"\n\n",s.koo,
										"\n")
	s.path <- paste0("../rtk3-remain/",s.no,".md")
	writeLines(content, s.path)
}