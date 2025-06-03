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
#iris veri kümesinin "Türler" sütununu bir karakter veya sayısal vektörden bir faktöre dönüştürüyor. 
#Bu genellikle bir model oluşturmaya veya veriler üzerinde başka türde analizler yapmaya hazırlanırken yapılır.
#Faktör, sınırlı sayıda olası değer alabilen kategorik bir değişkendir. 
#Faktörler, kategoriler halinde gruplandırılabilen verileri depolamak için kullanılır. 
#Örneğin, meyve türlerini temsil eden bir sütun içeren bir veri kümeniz varsa, o sütun için olası değerler "elma", "muz", "portakal" vb. olabilir. 
#Bu değerler bir faktör olarak saklanabilir.


# Verileri eğitim ve test setlerine ayırın
set.seed(123)  # Tekrar üretilebilirlik için çekirdeği ayarlayın. (Sözde rasgele sayı üreteci için rasgele çekirdeği ayarlayın.)
#rasgele çekirdeği 123'e ayarlarsanız ve ardından sample()'ı çağırırsanız, işlev belirtilen boyutta rastgele bir örnek döndürür, 
#ancak rasgele tohum 123'e ayarlı olarak kodu her çalıştırdığınızda örnek aynı olur.
split <- createDataPartition(iris$Species, p=0.8, list=FALSE) #Bir veri setini eğitim ve test setlerine bölmek için kullanılır.
#iris$Species: Bölümleme için kullanmak istediğiniz veri kümesinin sütunu.
#Eğitim setine dahil etmek istediğiniz verilerin oranı. Kalan veriler test setine dahil edilecektir.
#list=FALSE :İşlevin bir dizin listesi mi yoksa bir değerler vektörü mü döndürmesini istediğinizi gösteren mantıksal bir değer. 
#Bu durumda, liste bağımsız değişkeni FALSE olarak ayarlanır, bu da işlevin bir değerler vektörü döndüreceği anlamına gelir.
train <- iris[split, ]
test <- iris[-split, ]


# Gini impurity ölçüsünü kullanarak CART modelini oluşturun
model <- rpart(Species ~ ., data=train, method="class", parms=list(split="gini"))
#formula: Yanıt değişkenini ve öngörücü değişkenleri belirten bir formül. Bu durumda, formül Tür ~ . şeklindedir, 
#bu da "Türler" sütununun yanıt değişkeni olduğu ve diğer tüm sütunların öngörücü değişkenler olduğu anlamına gelir.
#data: Karar ağacını oluşturmak için kullanmak istediğiniz verileri içeren veri çerçevesi veya matris. 
#Bu durumda, train nesnesi veri bağımsız değişkeni olarak iletilmektedir.
#method: Oluşturmak istediğiniz modelin türü. Bu durumda, yöntem bağımsız değişkeni "sınıf" olarak ayarlanır, 
#bu da rpart() işlevinin bir sınıflandırma ağacı oluşturacağı anlamına gelir.
#parms: rpart() işlevine iletmek istediğiniz parametrelerin listesi. Bu durumda parms bağımsız değişkeni, 
#karar ağacının her bir düğümündeki verileri bölmek için "gini" bölme kuralının kullanılması gerektiğini belirten 
#list(split="gini") olarak ayarlanır.


# Sınıflandırma ağacını çiz
rpart.plot(model, type=4, extra=4, clip.right.labs=FALSE, cex=0.8, branch=0.3, box.palette="blue")
#model: Çizmek istediğiniz karar ağacı modeli nesnesi. Bu genellikle rpart() işlevinin sonucudur.
#type: Oluşturmak istediğiniz çizimin türü. Tür bağımsız değişkeni, 
#1 (dikdörtgen), 2 (elmas), 3 (gerileme çizgileri olan dikdörtgen) ve 4 (iç içe efekt grafikleri olan dikdörtgen) 
#dahil olmak üzere birkaç farklı değer alabilir. Bu durumda, tür bağımsız değişkeni 4'e ayarlanır, 
#bu da çizimin iç içe efekt grafikleri olan bir dikdörtgen olacağı anlamına gelir.
#ekstra: Çizimde görüntülenen bilgi miktarını kontrol eder. Ekstra bağımsız değişken, 1 (düğüm numarasını göster), 
#2 (düğüm numarasını ve gözlem sayısını göster), 3 (düğüm numarasını, gözlem sayısını ve tahmin edilen değeri göster) ve 
#4 (düğüm sayısını, gözlem sayısını, tahmin edilen değeri ve sapmayı görüntüleyin). Bu durumda, ekstra bağımsız değişken 4'e ayarlanır, 
#bu da çizimin tüm bu bilgileri göstereceği anlamına gelir.
#clip.right.labs: Çizimin sağ tarafındaki etiketlerin kırpılıp kırpılmayacağını gösteren mantıksal bir değer. 
#clip.right.labs DOĞRU olarak ayarlanırsa, arsaya sığamayacak kadar uzunsa etiketler kesilecektir. 
#clip.right.labs YANLIŞ olarak ayarlanırsa, etiketler kesilmez ve çizimin sağ kenarının dışına taşabilir. 
#Bu durumda, clip.right.labs bağımsız değişkeni FALSE olarak ayarlanır, bu da etiketlerin kesilmeyeceği anlamına gelir.
#cex: Çizimdeki etiketlerin boyutunu kontrol eder. Cex bağımsız değişkeni, varsayılan boyuta göre etiketlerin 
#boyutunu belirten sayısal bir değerdir.
#Branch: Çizimdeki dalların uzunluğunu kontrol eder.
#box.palette: Çizimdeki kutuların rengini kontrol eder.


# Test setinde tahminler yapın
predictions <- predict(model, newdata=test, type="class") #eğitilmiş bir model kullanarak tahminler yapmak için kullanılır.
#model: Tahmin yapmak için kullanmak istediğiniz eğitilmiş model nesnesi.
#yeni veri: Tahmin yapmak için kullanmak istediğiniz verileri içeren veri çerçevesi veya matris.
#type: Yapmak istediğiniz tahminlerin türü. Bu bağımsız değişken, kullandığınız modelin türüne bağlı olarak birkaç farklı değer alabilir.

# Model performansını değerlendirin
confusion_matrix <- confusionMatrix(predictions, test$Species) #bir model tarafından yapılan doğru ve yanlış tahminlerin sayısını gösteren bir tablo 
#olan bir karışıklık matrisi oluşturmak için kullanılır. Bir sınıflandırma modelinin performansını değerlendirmek için genellikle 
#bir karışıklık matrisi kullanılır.
#modelin performansını değerlendirmek için kullanılabilecek birkaç farklı istatistik içeren bir karışıklık matrisi nesnesi döndürür. 
#Bu istatistikler, modelin genel doğruluğunu, duyarlılığı (gerçek pozitif oran), özgüllüğü (gerçek negatif oran), 
#kesinliği (pozitif tahmin değeri) ve F1 puanını içerir.
#data: Yanıt değişkeninin gerçek değerleri. Bu durumda, veri bağımsız değişkeni olarak test$Species nesnesi iletilmektedir.

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