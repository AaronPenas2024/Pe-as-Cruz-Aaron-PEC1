library(SummarizedExperiment)

data_values <- read.csv("2018-MetabotypingPaper/DataValues_S013.csv", row.names = 1)
meta_data <- data_values[, 1:5]
meta_data <- as.data.frame(meta_data)
grupo <- data_values$Group

data_values <- data_values[, -(1:5)]
data_values <- as.data.frame(t(data_values))

se <- SummarizedExperiment(
       assays = list(counts = as.matrix(data_values)),
       colData = meta_data
)

save(se, file = "contenedor_summarized.Rda")

# Matrix
assay_se <-  assay(se, "counts")
print(assay_se)

# Boxplot
boxplot(assay_se[98, ], main="", ylab="Value")

# Heatmap
pheatmap(na.omit(assay_se), main="Heatmap Metabolitos", 
         scale="row", show_rownames=FALSE, show_colnames=TRUE)

# PCA
pca_result <- prcomp(t(na.omit(assay_se)), scale. = TRUE)

plot(pca_result$x[, 1], pca_result$x[, 2], col=grupo, pch=16, 
     main="PCA de Muestras", xlab="PC1", ylab="PC2")
legend("topright", legend=unique(grupo), col=unique(grupo), pch=16)














































