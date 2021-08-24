library(stringr)
# Load strokes data
data <- read.csv("rtk1-v6-strokes.csv")
data <- as.vector(data$flds)
# Load koohii stories data
koo.v4 <- readRDS("rtk1-v6-koohii.rds")
koo.v4 <- as.data.frame(koo.v4)
# Combine two data in each Jekyll post
n <- length(data)
l.nav <- matrix(rep("",2*n), ncol=2,
								dimnames=list(1:n,c("no6","ka")))
for (i in 1:n) {
	line <- data[i]
	line <- str_split(line, "\037")
	l <- line[[1]]
	l.nav[i,1] <- l[3]
	k.ka <- l[5]
	if (str_detect(k.ka,"・")) {
		k.ka <- str_sub(k.ka,1,1)
	}
	l.nav[i,2] <- k.ka
}
l.nav <- as.data.frame(l.nav, stringsAsFactors = FALSE)
for (i in 1:n) {
	line <- data[i]
	line <- str_split(line, "\037")
	l <- line[[1]]
  l.no <- l[2]
	l.no6 <- l[3]
	l.key <- l[4]
	l.ka <- l[5]
	l.img <- str_replace(l[6],
												 "<img src=\"([[:alnum:]]{6,}).png\" />", 
												 "\\1")
	l.ele <- l[8]
	l.sks <- l[9]
	l.hei <- l[11]
	l.hei <- str_replace_all(l.hei, "\"", "&quot;")
	l.hei <- str_replace_all(l.hei, "<div>", "\n")
	l.hei <- str_replace_all(l.hei, "</div>", "")
	l.com <- l[12]
	l.com <- str_replace_all(l.com, "\"", "&quot;")
	l.com <- str_replace_all(l.com, "<div>", "\n")
	l.com <- str_replace_all(l.com, "</div>", "")
	l.on <- l[17]
	l.kun <- l[18]
	l.word <- l[19]
	l.word <- str_replace_all(l.word, "<br[ ]*[/]?>", "\n\n")
	l.example <- l[20]
	l.na <- paste0(str_dup("0",4-str_length(l.no6)),l.no6)
	l.pri <- koo.v4[koo.v4$no==l.no,2]
	l.koo <- koo.v4[koo.v4$no==l.no,3]
	content <- paste0("---",
										"\nlayout: kanji",
										"\nv4: ", l.no,
										"\nv6: ", l.no6,
										"\nkanji: ", l.ka,
										"\nkeyword: ",l.key,
										"\nelements: ", l.ele,
										"\nstrokes: ", l.sks,
										"\nimage: ", l.img,
										"\non-yomi: ", l.on,
										"\nredirect_to: ", paste0("https://hochanh.github.io/rtk/",l.ka),
										ifelse(l.kun=="","",paste0("\nkun-yomi: ", l.kun)),
										"\npermalink: /", 
										ifelse(str_detect(l.ka,"・"),str_sub(l.ka,1,1),l.ka),"/",
										"\nredirect_from:",
										"\n - /", l.no6, "/",
										#"\n - /v4/", l.no, "/",
										#ifelse(str_detect(l.ka,"・"),
										#			 paste0("\n - /", str_sub(l.ka,1,1), "/",
										#			 "\n - /", str_sub(l.ka,3,3), "/"),""),
										"\nprev: ", l.nav[l.nav$no6==(as.numeric(l.no6)-1),2],
										"\nnext: ", l.nav[l.nav$no6==(as.numeric(l.no6)+1),2],
										"\n---",
										"\n\n", l.koo,
										"\n")
	l.path <- paste0("../rtk1-v6/",l.na,".md")
	writeLines(content, l.path)
}