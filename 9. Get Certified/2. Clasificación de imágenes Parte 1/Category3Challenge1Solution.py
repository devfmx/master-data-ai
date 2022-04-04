import tensorflow as tf
import urllib
import zipfile
from tensorflow.keras.preprocessing.image import ImageDataGenerator
import os
from tensorflow.keras.optimizers import RMSprop
from tensorflow.keras import Model

class myCallback(tf.keras.callbacks.Callback):
  def on_epoch_end(self, epoch, logs={}):
    if(logs.get('val_accuracy')>0.95):
      print("\nReached 95.0% accuracy so cancelling training!")
      self.model.stop_training = True

def get_data():
    _TRAIN_URL = "https://storage.googleapis.com/download.tensorflow.org/data/horse-or-human.zip"
    _TEST_URL = "https://storage.googleapis.com/download.tensorflow.org/data/validation-horse-or-human.zip"
    urllib.request.urlretrieve(_TRAIN_URL, 'horse-or-human.zip')
    local_zip = 'horse-or-human.zip'
    zip_ref = zipfile.ZipFile(local_zip, 'r')
    zip_ref.extractall('data/horse-or-human/')
    zip_ref.close()
    urllib.request.urlretrieve(_TEST_URL, 'testdata.zip')
    local_zip = 'testdata.zip'
    zip_ref = zipfile.ZipFile(local_zip, 'r')
    zip_ref.extractall('data/testdata/')
    zip_ref.close()

def solution_model():
    train_dir = 'data/horse-or-human'
    validation_dir = 'data/testdata'

    print('total training horses images :', len(os.listdir(os.path.join(train_dir, 'horses'))))
    print('total training humans images :', len(os.listdir(os.path.join(train_dir, 'humans'))))
    print('total validation horses images :', len(os.listdir(os.path.join(validation_dir, 'horses'))))
    print('total validation humans images :', len(os.listdir(os.path.join(validation_dir, 'humans'))))

    train_datagen = ImageDataGenerator(rescale=1/255)
    validation_datagen = ImageDataGenerator(rescale=1/255)

    train_generator = train_datagen.flow_from_directory(directory=train_dir,
                                                        batch_size=50,
                                                        class_mode='binary',
                                                        target_size=(300, 300))

    validation_generator = validation_datagen.flow_from_directory(directory=validation_dir,
                                                        batch_size=25,
                                                        class_mode='binary',
                                                        target_size=(300, 300))

    model = tf.keras.models.Sequential([
        # Note the input shape specified on your first layer must be (300,300,3)
        # Your Code here
        tf.keras.layers.Conv2D(filters=32, kernel_size=5, activation='relu', input_shape=(300, 300, 3)),
        tf.keras.layers.MaxPooling2D(2, 2),
        tf.keras.layers.Conv2D(filters=64, kernel_size=3, activation='relu'),
        tf.keras.layers.MaxPooling2D(2, 2),
        tf.keras.layers.Conv2D(filters=128, kernel_size=3, activation='relu'),
        tf.keras.layers.MaxPooling2D(2, 2),
        tf.keras.layers.Conv2D(filters=32, kernel_size=3, activation='relu'),
        tf.keras.layers.MaxPooling2D(2, 2),
        tf.keras.layers.Conv2D(filters=16, kernel_size=3, activation='relu'),  # 16
        tf.keras.layers.MaxPooling2D(2, 2),
        # tf.keras.layers.Conv2D(filters=32, kernel_size=3, activation='relu'), #nueva
        tf.keras.layers.Flatten(),
        tf.keras.layers.Dense(512, activation='relu'),
        # tf.keras.layers.Dense(256, activation='relu'),
        # This is the last layer. You should not change this code.
        tf.keras.layers.Dropout(0.3),
        tf.keras.layers.Dense(1, activation='sigmoid')
    ])

    # print(model.summary())

    model.compile(loss='binary_crossentropy',
                  optimizer=RMSprop(lr=1e-4),
                  # optimizer=RMSprop(learning_rate=1e-4),
                  metrics=['accuracy'])

    callbacks = myCallback()
    model.fit(train_generator,
              epochs=10,
              steps_per_epoch=20,
              validation_data=validation_generator,
              verbose=1,
              validation_steps=10,
              callbacks=[callbacks])

    return model

if __name__ == '__main__':
    #get_data()
    model = solution_model()
    #model.save("mymodel.h5")