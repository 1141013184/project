import cv2
import numpy as np
import pickle
import datetime
from collections import defaultdict
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Input, Conv2D, MaxPooling2D, Flatten, Dense
from tensorflow.keras.models import load_model
from tensorflow.keras.optimizers import Adam


# 假设模型已经加载并准备好了
def build_cnn_model(num_classes):  # 默认为二分类，可根据需要调整
    model = Sequential([
        Input(shape=(200, 200, 1)),  # 显式定义输入形状
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
        Dense(num_classes if num_classes > 1 else 1, activation='softmax' if num_classes > 1 else 'sigmoid')
    ])
    model.compile(optimizer= Adam(),
                  loss='categorical_crossentropy' if num_classes > 1 else 'binary_crossentropy',
                  metrics=['accuracy'])
    return model


def detect_faces(image):
    """使用OpenCV检测人脸"""
    cascade_path = 'D:/OpenCV/opencv/sources/data/haarcascades/haarcascade_frontalface_default.xml'
    face_cascade = cv2.CascadeClassifier(cascade_path)
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    faces = face_cascade.detectMultiScale(gray, 1.1, 4)
    return faces


def load_label_map(filename='label_map.pkl'):
    """从磁盘加载 label_map"""
    with open(filename, 'rb') as f:
        return pickle.load(f)


# 加载 label_map 并自动获取类别数
label_map = load_label_map()
num_classes = len(label_map)  # 自动获取类别数
class_labels = {v: k for k, v in label_map.items()}  # 反转映射
model = build_cnn_model(num_classes)
# 尝试加载权重，忽略不匹配的层
model.load_weights('face_recognition_model.keras')


threshold = 0.5


def recognize_faces(image, faces, model, class_labels, threshold):
    """识别检测到的人脸使用CNN模型"""
    face_images = []
    results = []
    for (x, y, w, h) in faces:
        # 提取人脸区域，并调整大小以匹配CNN输入
        face = image[y:y + h, x:x + w]
        face = cv2.resize(face, (200, 200))
        face = cv2.cvtColor(face, cv2.COLOR_BGR2GRAY)  # 如果模型训练于灰度图像
        face = np.expand_dims(face, axis=-1)  # 添加单通道维度
        face_images.append(face)

    if face_images:
        face_images = np.array(face_images)
        face_images = face_images / 255.0   # 归一化，如果在训练时使用了归一化
        predictions = model.predict(face_images)
        for pred in predictions:
            max_prob = np.max(pred)
            print(f"Prediction: {pred}, Max Probability: {max_prob}")  # 调试信息
            if max_prob < threshold:
                label = "unknown"
            else:
                    label = class_labels[np.argmax(pred)]
            now = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')  # 生成当前时间戳
            results.append((label, now))  # 存储类别和时间戳 # 获取最可能的类别索引
    return results, faces


last_recorded_time = defaultdict(lambda: datetime.datetime.min)


def save_recognition_results(results):
    #将识别结果保存到文件，但同一人物在短时间内只记录一次
    min_time_delta = datetime.timedelta(minutes=10)  # 设置时间间隔为10分钟
    now = datetime.datetime.now()
    with open("识别日志.csv", "a", encoding='utf-8') as file:
        for name, timestamp in results:
            last_time = last_recorded_time[name]
            if now - last_time > min_time_delta:
                file.write(f"{timestamp}, {name}\n")
                last_recorded_time[name] = now  # 更新记录时间

def main():
    cap = cv2.VideoCapture(0)  # 打开摄像头
    if not cap.isOpened():
        print("Error: Camera is not accessible")
        return

    # 加载 label_map
    try:
        with open('label_map.pkl', 'rb') as f:
            label_map = pickle.load(f)
        class_labels = {v: k for k, v in label_map.items()}
    except Exception as e:
        print(f"Failed to load label map: {e}")
        return# 创建从数字标签到人名的映射

    while True:
        ret, frame = cap.read()
        if not ret:
            break

        faces = detect_faces(frame)
        recognition_results, detected_faces = recognize_faces(frame, faces, model, class_labels, threshold)

        # 保存识别结果
        save_recognition_results(recognition_results)

        for (name, timestamp), (x, y, w, h) in zip(recognition_results, detected_faces):
            name_str = str(name)
            cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 2)
            cv2.putText(frame, name_str, (x, y - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.9, (36, 255, 12), 2)

        cv2.imshow('Face Recognition', frame)
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    cap.release()
    cv2.destroyAllWindows()

if __name__ == "__main__":
    main()
