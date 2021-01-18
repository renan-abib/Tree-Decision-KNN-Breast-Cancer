#Importando datasets e bibliotecas
breast_cancer_wisconsin <-read.csv("C:\\Users\\pasto\\Documents\\Engenharia de Software\\Graduação PUCC\\6o sem\\IA e Sistemas Inteligentes\\Projetos\\Projeto1_IA\\breast-cancer-wisconsin.data", sep = ",", header = FALSE, na.strings = '?')
wdbc <-read.csv("C:\\Users\\pasto\\Documents\\Engenharia de Software\\Graduação PUCC\\6o sem\\IA e Sistemas Inteligentes\\Projetos\\Projeto1_IA\\wdbc.data", sep = ",", header = FALSE, na.strings = '?')
wpbc <-read.csv("C:\\Users\\pasto\\Documents\\Engenharia de Software\\Graduação PUCC\\6o sem\\IA e Sistemas Inteligentes\\Projetos\\Projeto1_IA\\wpbc.data", sep = ",", header = FALSE, na.strings = '?')
library(dplyr)
library(ggplot2)
library(class)
library(rpart)
library(rpart.plot)


# Remoção de possíveis elementos ou linhas duplicadas 
breast_cancer_wisconsin <- unique(breast_cancer_wisconsin)
wdbc <- unique(wdbc)
wpbc <- unique(wpbc)

# Removendo instâncias (linhas) com valores iguais a "?"
breast_cancer_wisconsin_novo <- breast_cancer_wisconsin[complete.cases(breast_cancer_wisconsin),]
wdbc_novo <- wdbc[complete.cases(wdbc),]
wpbc_novo <- wpbc[complete.cases(wpbc),]

# Pegando apenas os valores médios dos 10 atributos para os datasets WBDC e WPBC

wdbc_medias <- wdbc_novo[,1:12]

colunas_wpbc_medias <- c(1:13,34,35)
wpbc_medias <- wpbc_novo[,colunas_wpbc_medias]


#Ajustando os nomes de colunas dos datasets

# dataset breast_cancer_wisconsin
nomes_colunas_dataset1 <- c("Sample code number", "Clump Thickness", "Uniformity of Cell Size", "Uniformity of Cell Shape", "Marginal Adhesion", "Single Epithelial Cell Size", "Bare Nuclei", "Bland Chromatin", "Normal Nucleoli", "Mitoses", "Class")
colnames(breast_cancer_wisconsin_novo)<- nomes_colunas_dataset1

# dataset wdbc
nomes_colunas_dataset2 <- c("ID number", "Diagnosis", "Radius", "Texture", "Perimeter", "Area", "Smoothness", "Compactness", "Concavity", "Concave Points", "Symmetry", "Fractal Dimension")
colnames(wdbc_medias)<- nomes_colunas_dataset2


# dataset wpbc
nomes_colunas_dataset3 <- c("ID number", "Outcome", "Time", "Radius", "Texture", "Perimeter", "Area", "Smoothness", "Compactness", "Concavity", "Concave Points", "Symmetry", "Fractal Dimension", "Tumor size", "Lymph node status")
colnames(wpbc_medias)<- nomes_colunas_dataset3


# Garantindo que as simulações sejam reproduzíveis para uma mesma sequência de números aleatórios 
set.seed(231)

# ---------- 1) Dividindo o dataset BREAST_CANCER_WINCOSIN em treino e teste -------------

# Selecionando 75% da base original
smp_size1 <- floor(0.75*nrow(breast_cancer_wisconsin_novo))

# Dessa amostragem de 75% (smp_size1), armazena os índices do primeiro até a última instância (seq_len)
train1_ind <- sample(seq_len(nrow(breast_cancer_wisconsin_novo)), size = smp_size1)

# Conjunto de treino correspondendo a 75% da base original
train1 <- breast_cancer_wisconsin_novo[train1_ind,]
# Conjunto de teste correspondendo ao resto, ou 25% da base original (pega os índices restantes)
test1 <- breast_cancer_wisconsin_novo[-train1_ind,]


# ---------- 2) Dividindo o dataset WDBC em treino e teste ----------

# Selecionando 75% da base original 
smp_size2 <- floor(0.75*nrow(wdbc_medias))

# Dessa amostragem de 75% (smp_size2), armazena os índices do primeiro até a última instância (seq_len)
train_ind2 <- sample(seq_len(nrow(wdbc_medias)), size = smp_size2)

# Conjunto de treino correspondendo a 75% da base original
train2 <- wdbc_medias[train_ind2,]
# Conjunto de teste correspondendo ao resto, ou 25% da base original (pega os índices restantes)
test2 <- wdbc_medias[-train_ind2,]


# ---------- 3) Dividindo o dataset WPBC em treino e teste ----------

# Selecionando 75% da base original 
smp_size3 <- floor(0.75*nrow(wpbc_medias))

# Dessa amostragem de 75% (smp_size3), armazena os índices do primeiro até a última instância (seq_len)
train_ind3 <- sample(seq_len(nrow(wpbc_medias)), size = smp_size3)

# Conjunto de treino correspondendo a 75% da base original
train3 <- wpbc_medias[train_ind3,]
# Conjunto de teste correspondendo ao resto, ou 25% da base original (pega os índices restantes)
test3 <- wpbc_medias[-train_ind3,]

# Gráficos com os dados de treino para verificar se visualmente os dados são classificáveis

# grafico WBC

group <- NA
group[train1$Class == "2"] <- 1 # 2 - benigno
group[train1$Class == "4"] <- 2 # 4 - maligno

pairs(train1[,2:10],
      oma=c(4,4,8,18),
      col = c("purple", "red")[group],   # Change color by group
      pch = c(8, 18)[group],         # Change points by group
      main = "Correlação entre os dados de treino de WBC")
legend(0.85,0.6, as.vector(unique(train1$Class)), legend = c("Benigno","Maligno"), fill=c("purple", "red"))


# grafico WDBC
group <- NA
group[train2$Diagnosis == "B"] <- 1
group[train2$Diagnosis == "M"] <- 2

#x11()
pairs(train2[,3:12],
      oma=c(4,4,8,18),
      col = c("purple", "red")[group],   # Change color by group
      pch = c(8, 18)[group],         # Change points by group
      main = "Correlação entre os dados de treino de WDBC")
legend(0.85,0.6, as.vector(unique(train2$Diagnosis)), legend = c("Benigno","Maligno"), fill=c("purple", "red"))

# grafico WPBC
group <- NA
group[train3$Outcome == "N"] <- 1
group[train3$Outcome == "R"] <- 2

colunas_train3 <- c(3:15)

pairs(train3[,colunas_train3],
      oma=c(4,4,6,24),
      col = c("red", "black")[group],   # Change color by group
      pch = c(8, 18)[group],         # Change points by group
      main = "Correlação entre os dados de treino de WPBC")
legend(0.85,0.6, as.vector(unique(train3$Outcome)), legend = c("Não recorrente","Recorrente"), fill=c("red", "black"))

# ---------- Algoritmo KNN ----------

# ---- dataset 1 (breast_cancer_wincosin) ----#

# Separando a coluna da classe (se é benigno ou maligno) para a criação da matriz de confusão
classesTrain1 <- train1[,11]
train1_knn <- train1[,-11]

classesTest1 <- test1[,11]
test1_knn <- test1[,-11]

# Aplicação do knn para o dataset 1 (breast_cancer_wincosin)
result1_1 <- knn(train1_knn, test1_knn, classesTrain1, 1)  
table(result1_1)
table(classesTest1)
table(classesTest1, result1_1)

result1_3 <- knn(train1_knn, test1_knn, classesTrain1, 3)  
table(result1_3)
table(classesTest1)
table(classesTest1, result1_3)

result1_5 <- knn(train1_knn, test1_knn, classesTrain1, 5)  
table(result1_5)
table(classesTest1)
table(classesTest1, result1_5)

result1_11 <- knn(train1_knn, test1_knn, classesTrain1, 11)  
table(result1_11)
table(classesTest1)
table(classesTest1, result1_11)

# ---- dataset 2 (WDBC) ----#

# Separando a coluna da classe (se é benigno ou maligno) para a criação da matriz de confusão

classesTrain2 <- train2[,2]
train2_knn <-train2[,-2]

classesTest2 <-test2[,2]
test2_knn <-test2[,-2]

# Aplicação do knn para o dataset 2 (wdbc)

result2_1 <- knn(train2_knn, test2_knn, classesTrain2, 1)  
table(result2_1)
table(classesTest2)
table(classesTest2, result2_1)

result2_3 <- knn(train2_knn, test2_knn, classesTrain2, 3)  
table(result2_3)
table(classesTest2)
table(classesTest2, result2_3)

result2_5 <- knn(train2_knn, test2_knn, classesTrain2, 5)  
table(result2_5)
table(classesTest2)
table(classesTest2, result2_5)

result2_11 <- knn(train2_knn, test2_knn, classesTrain2, 11)  
table(result2_11)
table(classesTest2)
table(classesTest2, result2_11)

# ---- dataset 3 (WPBC) ----#

# Separando a coluna da classe (se é benigno ou maligno) para a criação da matriz de confusão

classesTrain3 <- train3[,2]
train3_knn <- train3[,-2]

classesTest3 <- test3[,2]
test3_knn <- test3[,-2]

# Aplicação do knn para o dataset 3 (wpbc)

result3_1 <- knn(train3_knn, test3_knn, classesTrain3, 1)  
table(result3_1)
table(classesTest3)
table(classesTest3, result3_1)

result3_3 <- knn(train3_knn, test3_knn, classesTrain3, 3)  
table(result3_3)
table(classesTest3)
table(classesTest3, result3_3)

result3_5 <- knn(train3_knn, test3_knn, classesTrain3, 5)  
table(result3_5)
table(classesTest3)
table(classesTest3, result3_5)

result3_11 <- knn(train3_knn, test3_knn, classesTrain3, 11)  
table(result3_11)
table(classesTest3)
table(classesTest3, result3_11)

# Classificação usando árvores

# ---- dataset 1 (breast_cancer_wincosin) ----#
modelo1 <- rpart(Class~. , train1, method = "class", control = rpart.control(minsplit = 1))
plot<-rpart.plot(modelo1, type = 3)
pred<-predict(modelo1, test1, type = "class")
table(classesTest1, pred)

# ---- dataset 2 (WDBC) ----#
modelo2 <- rpart(Diagnosis~. , train2, method = "class", control = rpart.control(minsplit = 1))
plot <- rpart.plot(modelo2, type = 3)
pred <- predict(modelo2, test2, type = "class")
table(classesTest2, pred)

# ---- dataset 3 (WPBC) ----#
train3 <- train3[,-1]
modelo3 <- rpart(Outcome~. , train3, method = "class", control = rpart.control(minsplit = 1))
plot <- rpart.plot(modelo3, type = 3)
pred <- predict(modelo3, test3, type = "class")
table(classesTest3, pred)

