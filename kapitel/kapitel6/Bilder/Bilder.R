setwd("C:/Users/MV_2/Documents/GitHub/WT1-Skript/kapitel/Kapitel2/Bilder")
### Example 2.3
## i
library(tikzDevice)
library(ggplot2)
options(tz="CA")# Time zone ??????
x <- 1:7
y <- c(3,1,4,3,1,3.5,5)

tikz(file="ex_2_3_iid_seq.tex",width = 2.5,height = 2.5)

 plot <- ggplot(data.frame(x=x,y=y))+
   aes(x=x,y=y)+
   geom_point()+
   theme_bw()

print(plot)

dev.off()

tikz(file="ex_2_3_BM.tex",width = 2.5,height = 2.5)
x<-c(0,rnorm(3500))
n=length(x)
B = (1/sqrt(n))*cumsum(x)
s <- seq(0,1,le=n)
df_data <- data.frame(x=seq(0,1,le=n),y=B)

library(ggplot2)

plot<-ggplot(df_data)+
  aes(x=x,y=y)+
  geom_line(size=0.1)+
  theme_bw()

print(plot)

dev.off()



tikz(file="ex_2_3_pois.tex",width = 2.5,height = 2.5)
lambda <- 0.5
tMax <- 100
library(ggplot2)
## find the number 'n' of exponential r.vs required by imposing that
## Pr{N(t) <= n} <= 1 - eps for a small 'eps'
n <- qpois(1 - 1e-8, lambda = lambda * tMax)

## simulate exponential interarrivals the
X <- rexp(n = n, rate = lambda)
S <- c(0, cumsum(X))
## several paths?
nSamp <- 5
## simulate exponential interarrivals
X <- matrix(rexp(n * nSamp, rate = lambda), ncol = nSamp,
            dimnames = list(paste("S", 1:n, sep = ""), paste("samp", 1:nSamp)))
## compute arrivals, and add a fictive arrival 'T0' for t = 0
S <- apply(X, 2, cumsum)
S <- rbind("T0" = rep(0, nSamp), S)
head(S)
## plot using steps
S_plot <- S[,5]
rm(S)
p <- ggplot(data = data.frame(x=0:n,y=S_plot))+aes(x=x,y=y)+geom_step()+theme_bw()

print(p)
dev.off()