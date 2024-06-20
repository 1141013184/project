import os
import cv2
import numpy as np
import argparse
import logging
import pickle
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Conv2D, MaxPooling2D, Flatten, Dense, Input
from tensorflow.keras.utils import to_categorical
from tensorflow.keras.optimizers import Adam


# 设置日志记录
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def generate_label_map(directory):
    if not os.path.exists(directory):
        logging.error(f"Directory does not exist: {directory}")
        return {}
    folders = [f for f in os.listdir(directory) if os.path.isdir(os.path.join(directory, f))]
    label_map = {folder: i for i, folder in enumerate(folders)}
    return label_map

def load_and_preprocess_data(directory, image_size=(200, 200)):
    if not os.path.exists(directory):
        logging.error(f"Directory does not exist: {directory}")
        return None, None, 0, None
    images = []
    labels = []
    label_map = generate_label_map(directory)
    num_classes = len(label_map)

    for folder_name in os.listdir(directory):
        folder_path = os.path.join(directory, folder_name)
        if os.path.isdir(folder_path):
            for image_filename in os.listdir(folder_path):
                image_path = os.path.join(folder_path, image_filename)
                image = cv2.imread(image_path)
                if image is None:
                    logging.warning(f"Image not readable or does not exist: {image_path}")
                    continue
                image = cv2.resize(image, image_size)
                image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
                image = image / 255.0
                images.append(image)
                labels.append(label_map[folder_name])

    images = np.array(images).reshape(-1, 200, 200, 1)
    labels = np.array(labels)
    labels = to_categorical(labels, num_classes=num_classes)
    return images, labels, num_classes, label_map

def build_cnn_model(num_classes):
    model = Sequential([
        Input(shape=(200, 200, 1)),
        Conv2D(32, (3, 3), activation='relu'),
        MaxPooling2D(2, 2),
        Conv2D(64, (3, 3), activation='relu'),
        MaxPooling2D(2, 2),
        Conv2D(128, (3, 3), activation='relu'),
        MaxPooling2D(2, 2),
        Conv2D(128, (3, 3), activation='relu'),
        MaxPooling2D(2, 2),
        Flatten(),
        Dense(512, activation='relu'),
        Dense(num_classes, activation='softmax')
    ])
    model.compile(optimizer=Adam(), loss='categorical_crossentropy', metrics=['accuracy'])
    return model


# 在训练完成后保存 label_map
def main(directory):
    if directory is None:
        directory = 'D:/python/CNN/face'  # 设置默认路径
    X_train, y_train, num_classes, label_map = load_and_preprocess_data(directory)
    if X_train is None or y_train is None or label_map is None:
        logging.error("Failed to load data.")
        return
    model = build_cnn_model(num_classes)
    model.fit(X_train, y_train, epochs=10, batch_size=32)
    model.save('face_recognition_model.keras', save_format='tf')

    # 保存 label_map
    with open('label_map.pkl', 'wb') as f:
        pickle.dump(label_map, f)

    logging.info("Model trained and saved successfully.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Train a CNN on a set of images for face recognition.')
    parser.add_argument('directory', type=str, nargs='?', help='Path to the dataset directory.', default=None)
    args = parser.parse_args()

    main(args.directory)

