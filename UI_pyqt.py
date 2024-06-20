import sys
from PyQt5.QtWidgets import QApplication, QMainWindow, QMessageBox, QInputDialog
import os
from main_window import Ui_MainWindow  # 导入 UI 类
from face_detection import capture_face
from face_recognition import main as recognize_faces
from face_recognition_cnn_v1 import main as train_model


class MyApp(QMainWindow, Ui_MainWindow):
    def __init__(self):
        super().__init__()
        self.setupUi(self)

        # Connect buttons to imported functions
        self.trainButton.clicked.connect(self.train_model)
        self.recognizeButton.clicked.connect(self.recognize_faces)
        self.captureButton.clicked.connect(self.capture_faces)


    def train_model(self):
        directory, ok = QInputDialog.getText(self, "Input", "Enter the dataset directory:")
        if ok and directory:
            if os.path.exists(directory):
                try:
                    train_model(directory)  # 假设 train_main 是你的模型训练函数
                    QMessageBox.information(self, "Info", "Model training complete.")
                except Exception as e:
                    QMessageBox.critical(self, "Error", f"An error occurred: {str(e)}")
            else:
                QMessageBox.critical(self, "Error", "Invalid directory.")
        else:
            QMessageBox.warning(self, "Warning", "Operation cancelled.")

    def recognize_faces(self):
        recognize_faces()  # 同上

    def capture_faces(self):
        identifier, ok = QInputDialog.getText(self, "Input Identifier", "Enter identifier for face capture:")
        if ok and identifier:
            max_images, ok = QInputDialog.getInt(self, "Input", "Enter max number of images to capture:", 10, 1,
                                                     100)
            if ok:
                capture_face(identifier, max_images)


if __name__ == '__main__':
    app = QApplication(sys.argv)
    window = MyApp()
    window.show()
    sys.exit(app.exec_())
