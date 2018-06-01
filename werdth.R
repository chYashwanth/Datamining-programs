library(RSNNS)
library(openxlsx)
library(neuralnet)
data=read.xlsx("ENB2012_data.xlsx")
data <- data[sample(1:nrow(data),length(1:nrow(data))),1:ncol(data)]
dataValues <- data[,1:4]
dataTargets <- decodeClassLabels(data[,5])
#dataTargets <- decodeClassLabels(data[,5], valTrue=0.9, valFalse=0.1)
data <- splitForTrainingAndTest(dataValues, dataTargets, ratio=0.15)
data <- normTrainingAndTestSet(data)
model <- mlp(data$inputsTrain, data$targetsTrain, size=5, learnFuncParams=c(0.1),maxit=50, inputsTest=data$inputsTest, targetsTest=data$targetsTest)
summary(model)
plotIterativeError(model)

confusionMatrix(data$targetsTrain, encodeClassLabels(fitted.values(model),method="402040", l=0.4, h=0.6))