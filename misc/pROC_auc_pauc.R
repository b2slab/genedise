library(pROC)
library(PRROC)

local({
  set.seed(1)
  x <- rnorm(100)
  y <- x + rnorm(100, sd = 1.3) > 2
  
  mean(y)
  
  plot(x, y)
  
  roc <- pROC::roc(predictor = x, response = y)
  roc
  plot(roc)
  pROC::auc(predictor = x, response = y, partial.auc = c(1, .9))
  pROC::auc(predictor = x, response = y, partial.auc = c(0, .1))
  
  PRROC::roc.curve(scores.class0 = x, weights.class0 = y)
  PRROC::pr.curve(scores.class0 = x, weights.class0 = y)
})


