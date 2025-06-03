# Gerekli paketleri yükleyin
library(rpart) #regresyon ve sınıflandırma problemleri için karar ağaçları oluşturmaya yarayan bir araç olan rpart paketini yükler.
library(rpart.plot) #rpart paketi kullanılarak oluşturulan karar ağaçlarını görselleştirmek için bir araç olan rpart.plot paketini yükler.
library(caret) #tahmine dayalı modelleri eğitmek ve değerlendirmek için bir araç setidir. Ön işleme, özellik seçimi, model ayarı ve model değerlendirmesi için işlevler sağlar.

# İris veri setini yükleyin
data(iris)

# Verileri gösterin
head(iris)

# Hedef değişkeni bir faktöre dönüştürün
iris$Species <- as.factor(iris$Species)

# Verileri eğitim ve test setlerine ayırın
set.seed(123)
split <- createDataPartition(iris$Species, p=0.8, list=FALSE) #Bir veri setini eğitim ve test setlerine bölmek için kullanılır.
train <- iris[split, ]
test <- iris[-split, ]

# Gini impurity ölçüsünü kullanarak CART modelini oluşturun
model <- rpart(Species ~ ., data=train, method="class", parms=list(split="gini"))

# Sınıflandırma ağacını çiz
rpart.plot(model, type=4, extra=4, clip.right.labs=FALSE, cex=0.8, branch=0.3, box.palette="blue")

# Test setinde tahminler yapın
predictions <- predict(model, newdata=test, type="class") #eğitilmiş bir model kullanarak tahminler yapmak için kullanılır.

# Model performansını değerlendirin
confusion_matrix <- confusionMatrix(predictions, test$Species) #bir model tarafından yapılan doğru ve yanlış tahminlerin sayısını gösteren bir tablo 

# View the confusion matrix
confusion_matrix

# Tahminleri gerçek sonuçlarla karşılaştırın
results <- data.frame(Actual = test$Species, Predicted = predictions) #"Gerçek" sütunu, orijinal iris veri seti tarafından belirlendiği şekliyle, 
#test verilerindeki her numune için türleri içerir. "Öngörülen" sütunu, test verilerindeki her numune için model tarafından tahmin edilen türleri içerir.
results

# Test örneği için bir veri çerçevesi oluşturun
test_instance <- data.frame(Sepal.Length=5, Sepal.Width=3, Petal.Length=4, Petal.Width=2)

# Test örneğinde bir tahminde bulunun
prediction <- predict(model, newdata=test_instance, type="class")

# Tahmini yazdır
prediction
