library('jpeg')


imagejpg <- readJPEG('4.2.03.jpg')

# Convert data to matrix form
img.matrix = matrix(imagejpg, nrow = nrow(imagejpg), ncol = ncol(imagejpg))

# Calcualte SV Decomposition
img.matrix.svd = svd(img.matrix)

# SVD returns 3 things d u and v, d is our sigma with eigenvalues in decreasing order, u and v are combined with diagonal
#matrix to give out to give original input matrix
d = img.matrix.svd$d
u = img.matrix.svd$u
v = img.matrix.svd$v


# check whether matrix multiplication really works

matrix.reconstruction <- u %*% diag(d) %*% t(v) # taking the transpose of v as in SVD, its u sigma v Transpose

mean(img.matrix - matrix.reconstruction)

i <- 2
matrix.compressed <- u[,1:i] %*% diag(d[1:i]) %*% t(v[,1:i])
image.default(matrix.compressed)

image(matrix.compressed, col = heat.colors(255))

i <- 20
matrix.compressed <- u[,1:i] %*% diag(d[1:i]) %*% t(v[,1:i])
image.default(matrix.compressed)

i <- 50
matrix.compressed <- u[,1:i] %*% diag(d[1:i]) %*% t(v[,1:i])
image.default(matrix.compressed)

plot(1:length(d), d)

for (i in c(3, 4, 5, 10, 20, 30, 50, 70, 80, 100, 200))
{
  matrix.compressed <- u[,1:i] %*% diag(d[1:i]) %*% t(v[,1:i])
  writeJPEG(matrix.compressed, target = paste("svd",i,".jpg", sep=''),quality = 1)
  image.default(matrix.compressed)
  dev.off()
}

