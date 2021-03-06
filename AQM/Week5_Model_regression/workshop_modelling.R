########### Introduction ###############
Hubble <- read.table("Hubble.txt")

plot(y ~ x, data = Hubble)

mod <- lm(y ~ x, data = Hubble)
# print(mod)
# summary(mod)
# coef(mod)
# resid(mod)
# anova(mod)

x.test <- data.frame(x = seq(min(Hubble$x), max(Hubble$x), by = 1))

pred <- data.frame(predict(mod, newdata = x.test))
# str(pred)

lines(pred, lwd = 2, col = "red")


########## Activity #################

# read data
ret <- read.table("Portfolio_Return.txt")

# plot data
plot(stock_rate ~ portfolio_ret, data = ret)

# fit model
mod <- lm(stock_rate ~ portfolio_ret, data = ret)

# test set
x.test <- data.frame(portfolio_ret = seq(min(ret$portfolio_ret), max(ret$portfolio_ret), by = 0.1))

# predict from test set
pred <- data.frame(predict = predict(mod, newdata = x.test))

# combine test and predictions
dat <- cbind(x.test, pred)

# plot fitted line
lines(dat, lwd = 2, col = "red")

# diagnostics

# constant variance *****************
plot(fitted(mod), residuals(mod), xlab="Fitted", ylab="Residuals")
abline(h= c(-2,0,2), lwd = c(2,2,2), col=c("red", "red", "red"), lty = c(2,1,2))

plot(fitted(mod), abs(residuals(mod)), xlab="Fitted", main ="|Residuals|")

summary(lm(abs(residuals(mod)) ~ fitted(mod)))

# normality *******************

par(mfrow=c(1,1))
# qqplot
qqnorm(residuals(mod), ylab="Residuals")
qqline(residuals(mod))

# histogram
hist(residuals(mod))
boxplot(residuals(mod))

# correlated errors *****************
plot(ret$quarter, residuals(mod), ylab="Residuals")
abline(h=0, col = "red")


# example plots: nonconstant variance
par(mfrow=c(2,2))

plot(1:50,rnorm(50), main = "constant var")
# constant variance
plot(1:50,(1:50)*rnorm(50), main = "strong heterogeneity")
# strong heterogeneity
plot(1:50,sqrt((1:50))*rnorm(50), main = "mild heterogeneity")
# mild heterogeneity
plot(1:50,cos((1:50)*pi/25)+rnorm(50), main = " non-linearity")
# non-linearity

# example plots: normality of errors
par(mfrow=c(2,2))
x = rnorm(50); qqnorm(x, main = "std normal"); qqline(x)
# standard normal distribution
x = rlnorm(50); qqnorm(x, main = "right skew"); qqline(x)
# lognormal distribution - skew to right
x = rt(50,1); qqnorm(x, main = "heavy tails"); qqline(x)
# Student t-distribution with one df (heavy tails)
x = runif(50); qqnorm(x, main = "short tails"); qqline(x)
# uniform (0,1) distribution (short tails)
