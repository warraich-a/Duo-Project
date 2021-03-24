import socket
from threading import Thread
import cv2
from fer import FER
import pickle

serversocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
host = ""
port = 5204
print(host)
print(port)
serversocket.bind((host, port))


class client(Thread):
    def __init__(self, socket, address):
        Thread.__init__(self)
        self.sock = socket
        self.addr = address
        self.start()

    # def run(self):
    #
    #     while 1:


serversocket.listen(5)
print('server started and listening')

detector = FER(mtcnn=True)
cap = cv2.VideoCapture(0)
# it will wait here for the client and when the client is connected then it will enter the loop
clientsocket, address = serversocket.accept()
client(clientsocket, address)
while True:

    # Read the frame
    _, img = cap.read()
    # Convert to grayscale
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    result = detector.detect_emotions(img)
    if result:

        bounding_box = result[0]["box"]
        emotions = result[0]["emotions"]

        # Bounding around face is drawn
        cv2.rectangle(img, (bounding_box[0], bounding_box[1]),
                      (bounding_box[0] + bounding_box[2], bounding_box[1] + bounding_box[3]), (0, 155, 255), 2 )
        for idx, (emotion, score) in enumerate(emotions.items()):
            color = (211, 211, 211) if score < 0.40 else (255, 0, 0)
            emotion_score = "{}: {}".format(
                  emotion, "{:.2f}".format(score)
                if score > 0.01
                else ""
            )
            if score > 0.40:
                #  to send a list as bytes.
                s = str(bounding_box)
                d2 = eval(s)
                data = pickle.dumps(s)

                # data = bounding_box.encode()
                clientsocket.sendall(data)
            cv2.putText(img,emotion_score,
                    (bounding_box[0], bounding_box[1] + bounding_box[3] + 30 + idx * 15),cv2.FONT_HERSHEY_SIMPLEX,0.5,color,1,cv2.LINE_AA,)

    # Display
    cv2.imshow('img', img)
    # Stop if escape key is pressed
    k = cv2.waitKey(30) & 0xff
    if k == 27:
        break
    print('Client sent:', clientsocket.recv(1024).decode())
    # clientsocket.send(b'Oi you sent something to me')

