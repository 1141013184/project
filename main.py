import argparse
import sys

def train_model(directory):
    from face_recognition_cnn_v1 import main as train_main
    train_main(directory)

def face_recognition():
    from face_recognition import main as recognition_main
    recognition_main()

def face_capture(xh, max_images):
    from face_detection import capture_face
    capture_face(xh, int(max_images))

def main():
    parser = argparse.ArgumentParser(description="Face Recognition System")
    parser.add_argument('--train', type=str, help='Train the model. Provide the directory of the training data.', required=False)
    parser.add_argument('--recognize', action='store_true', help='Run face recognition.', required=False)
    parser.add_argument('--capture', type=str, nargs=2, metavar=('IDENTIFIER', 'MAX_IMAGES'), help='Capture faces. Provide an identifier and the max number of images to capture.', required=False)
    args = parser.parse_args()

    if args.train:
        train_model(args.train)
    elif args.recognize:
        face_recognition()
    elif args.capture:
        xh, max_images = args.capture
        face_capture(xh, int(max_images))
    else:
        print("No valid command specified. Use --help to see options.")
        sys.exit(1)

if __name__ == "__main__":
    main()
