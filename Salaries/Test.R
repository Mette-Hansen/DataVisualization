#Practice 1 
((2022-2019)/(2022-1998))*100

#Practice 2
diff_study <- 2022-2019
diff_born <- 2022-1998
diff_study/diff_born*100

#Practice 3
#sum(4,5,8,11)
x<-c(4,5,8,11)
sum(x)
x

#Practice 4
y<-rnorm(1000,10,1.4)

#Practice 5
plot(y)
library(ggplot2)
#ggplot(data = y, mapping = aes())

#Practice 6
?sqrt

#Practice 7
#See firstscript.R

#Practice 8
p <- c(31:60)
#p<-seq(31,60,by=2)
q <- matrix(p, nrow = 6, ncol = 5, byrow = TRUE)
q

#Practice 9
v1<-rexp(100,2)
v2<-sample(1:10,100,replace = TRUE)
v3<-rgamma(100,2,3)

t<-data.frame(a=v1, b=v1+v2, c=v1+v2+v3)
plot(t)
sd(t)
View(t)

#Practice 10
plot(t$a, type="l", ylim=range(t),lwd=3, col=rgb(1,0,0,0.3))
lines(t$b, type="s", lwd=2,col=rgb(0.3,0.4,0.3,0.9))
points(t$c, pch=20, cex=4,col=rgb(0,0,1,0.3))
# rgb = red/green/blue (colors)
# lwd = line width
# pch = Plotting symbols
# cex = number indicating the amount

#Practice 11
v_1<-c(1,2,3)
v_2<-c(2,4,8)
plot(v_1,v_2,xlab="Christmas 2022", ylab="Number of presents")

x<-c(today<-Sys.Date(),christmas<-as.Date("2022-12-25"),
     MyBirthday<-as.Date("1998-04-08"))
y<-sample(10:20,3)
plot(x,y,type="l")
