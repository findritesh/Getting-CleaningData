setwd('C:/Users/Ritesh/Desktop/projects/R Working Dir/Getting and Cleaning Data/Project/UCI HAR Dataset')
unzip('dataset.zip')
#Read Features & Activity Labels
features=read.table("features.txt")
features=t(features)
actLabels=read.table("activity_labels.txt")
#Read test data & enrich with Features & Activity information
setwd('C:/Users/Ritesh/Desktop/projects/R Working Dir/Getting and Cleaning Data/Project/UCI HAR Dataset/test')
nwd=paste(getwd(),"/test",sep="")
testSubject=read.table("subject_test.txt")
testActivity=read.table("y_test.txt")
testResults=read.table("X_test.txt")
testDataset=cbind(testSubject,testActivity,testResults)
colnames(testDataset)=c("Subject","Activity",features[2,])
testdsfull=merge(actLabels,testDataset,by.x="row.names",by.y="Activity",all.x=TRUE)
testdsfull=cbind("Test",testdsfull)
colnames(testdsfull)[1]="ActivityType"
#Read training data & enrich with Features & Activity information
setwd('C:/Users/Ritesh/Desktop/projects/R Working Dir/Getting and Cleaning Data/Project/UCI HAR Dataset/train')
trainingSubject=read.table("subject_train.txt")
trainingActivity=read.table("y_train.txt")
trainingResults=read.table("X_train.txt")
trainingDataset=cbind(trainingSubject,trainingActivity,trainingResults)
colnames(trainingDataset)=c("Subject","Activity",features[2,])
trainingdsfull=merge(actLabels,trainingDataset,by.x="row.names",by.y="Activity",all.x=TRUE)
trainingdsfull=cbind("training",trainingdsfull)
colnames(trainingdsfull)[1]="ActivityType"
#Combining Training & Test data
fullDataset=rbind(testdsfull,trainingdsfull)
fullDataset$Row.names=NULL
View(fullDataset)
temp=colnames(fullDataset)
#Keeping only the mean & std columns
temp1=c(1:4,grep("mean\\()",temp),grep("std\\()",temp))
temp1=sort(temp1)
meanstddata=fullDataset[,temp1]
View(meanstddata)
modified=as.vector(meanstddata[,4:10])
# Creating tidy data with Averages only
AvgTidy=aggregate(meanstddata[,5:70],by=list(meanstddata$V2,meanstddata$Subject),FUN=mean)
colnames(AvgTidy)[1:2]=c("Activity","Subject")

#Write Complete Dataset & Tidy Average dataset into txt files
write.table(meanstddata,"MeanStd.txt")
write.table(AvgTidy,"Summary.txt")











