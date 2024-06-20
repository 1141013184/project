import cv2
import os
import datetime

def detect_faces(image):
    """使用指定的Haar级联分类器检测图像中的人脸"""
    cascade_path = 'D:/OpenCV/opencv/sources/data/haarcascades/haarcascade_frontalface_default.xml'
    face_cascade = cv2.CascadeClassifier(cascade_path)
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    faces = face_cascade.detectMultiScale(gray, 1.1, 4)
    return faces

def capture_face(name, max_images=20):
    cap = cv2.VideoCapture(0)
    if not cap.isOpened():
        print("Error: Camera is not available")
        return

    save_path = os.path.join('face', name)
    if not os.path.exists(save_path):
        os.makedirs(save_path)

    image_count = 0
    while image_count < max_images:
        ret, frame = cap.read()
        if not ret:

            print("Error: Cannot capture frame from camera")
            break

        faces = detect_faces(frame)
        print(f"Detected {len(faces)} faces in this frame.")  # 调试语句

        for (x, y, w, h) in faces:
            cv2.rectangle(frame, (x, y), (x + w, y + h), (255, 0, 0), 2)
            face_img = frame[y:y + h, x:x + w]
            face_img = cv2.resize(face_img, (200, 200))
            timestamp = datetime.datetime.now().strftime('%Y%m%d%H%M%S')
            filename = f"{name}_{timestamp}.jpg"
            cv2.imwrite(os.path.join(save_path, filename), face_img)
            image_count += 1
            print(f"Saved {image_count} of {max_images} images")  # 调试语句

            if image_count >= max_images:
                print("Reached the maximum number of images saved.")
                break

        cv2.imshow('Face Capture', frame)
        if cv2.waitKey(1) & 0xFF == ord('q'):
            print("Quit by user.")
            break

    cap.release()
    cv2.destroyAllWindows()


# Example usage
if __name__ == "__main__":
    capture_face('name', max_images=30)  # 设置最大捕获图片数为30
