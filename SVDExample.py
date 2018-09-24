from PIL import Image
import numpy as np
from scipy.linalg import svd
import matplotlib.pyplot as plt

img = Image.open("4.2.03.jpg")
img.load()
img_matrix = np.asarray( img, dtype="int32")

print (np.shape(img_matrix))

U, S, V = svd(img_matrix)

for i in [3,4,5,10,20,30,50,70,80,100,200]:
    reconstructed_matrix = np.dot(U[:,:i],np.dot(np.diag(S[:i]),V[:i,:]))
    plt.imshow(reconstructed_matrix)
    #plt.show()
    fig = plt.gcf()
    fig.savefig('svd_{0:03d}.jpg'.format(i))


