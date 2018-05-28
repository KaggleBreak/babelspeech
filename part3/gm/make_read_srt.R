
getwd()
setwd('/Users/syleeie/Desktop/babelspeech/part3/gm')
directory <- './youtube/data/'
filenames <- list.files(directory, pattern = "*.*", full.names = TRUE)
filenames

length(filenames)
close(con)

lines1 <- readLines(file(filenames[9], "r"), n=10000) 
lines2 <- readLines(file(filenames[4], "r"), n=10000) 
lines3 <- readLines(file(filenames[2], "r"), n=10000) 
lines4 <- readLines(file(filenames[1], "r"), n=10000) 
lines5 <- readLines(file(filenames[5], "r"), n=10000) 
lines6 <- readLines(file(filenames[7], "r"), n=10000) 
lines7 <- readLines(file(filenames[11], "r"), n=10000) 
lines8 <- readLines(file(filenames[3], "r"), n=10000) 
lines9 <- readLines(file(filenames[6], "r"), n=10000) 
lines10 <- readLines(file(filenames[8], "r"), n=10000) 
lines11 <- readLines(file(filenames[10], "r"), n=10000) 

lines <- c(lines1, lines2, lines3, lines4, lines5, lines6, lines7, lines8, lines9, lines10, lines11)
lines
# the previous lines of code are just to replicate you case, and
# they should be replaced by the following single line in the real case
# lines <- readLines(srtFileName)
listOfEntries <- 
  lapply(split(1:length(lines),cumsum(grepl("^\\s*$",lines))),function(blockIdx){
    block <- lines[blockIdx]
    block <- block[!grepl("^\\s*$",block)]
    if(length(block) == 0){
      return(NULL)
    }
    if(length(block) < 3){
      warning("a block not respecting srt standards has been found")
    }
    return(data.frame(id=block[1], 
                      times=block[2], 
                      textString=paste0(block[3:length(block)],collapse="\n"),
                      stringsAsFactors = FALSE))
  })

m1 <- do.call(rbind,listOfEntries)
m2 <- as.vector(m1$textString)
m3 <- paste0(m2, collapse=" ")
write(m3, "srt_all.txt", sep = "\t")
