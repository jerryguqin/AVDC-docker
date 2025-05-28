import sys
from PyQt5.QtWidgets import QApplication, QWidget, QPushButton, QVBoxLayout
from PyQt5.QtCore import Qt

class RestartWindow(QWidget):
    def __init__(self):
        super().__init__()
        self.initUI()

    def initUI(self):
        # -------------------------------
        # 窗口基础设置：透明 + 无边框 + 置顶
        # -------------------------------
        self.setWindowFlags(
            Qt.FramelessWindowHint |
            Qt.WindowStaysOnTopHint |
            Qt.WA_TranslucentBackground
        )
        self.setAttribute(Qt.WA_TranslucentBackground)
        self.setStyleSheet("background: transparent;")  # 强制透明

        # -------------------------------
        # 窗口尺寸与位置居中
        # -------------------------------
        self.setFixedSize(300, 150)
        self.center_window()

        # -------------------------------
        # 布局配置（去边距）
        # -------------------------------
        layout = QVBoxLayout()
        layout.setContentsMargins(0, 0, 0, 0)
        layout.setSpacing(0)

        # -------------------------------
        # 按钮样式与尺寸
        # -------------------------------
        btn_restart = QPushButton('重启', self)
        btn_restart.setFixedSize(200, 80)
        btn_restart.clicked.connect(self.on_restart_clicked)

        btn_style = """
            QPushButton {
                background-color: rgba(50, 150, 250, 230);
                border: 3px solid white;
                border-radius: 15px;
                color: white;
                font-size: 24px;
                font-weight: bold;
            }
            QPushButton:hover {
                background-color: rgba(70, 170, 270, 255);
            }
        """
        btn_restart.setStyleSheet(btn_style)

        layout.addWidget(btn_restart)
        self.setLayout(layout)

    def center_window(self):
        # 计算屏幕中心并移动窗口
        screen = QApplication.primaryScreen().geometry()
        window_geo = self.frameGeometry()
        window_geo.moveCenter(screen.center())
        self.move(window_geo.topLeft())

    def on_restart_clicked(self):
        self.close()
        sys.exit(0)

if __name__ == '__main__':
    app = QApplication(sys.argv)
    app.setAttribute(Qt.AA_UseDesktopOpenGL)
    app.setAttribute(Qt.AA_EnableHighDpiScaling)
    window = RestartWindow()
    window.show()
    sys.exit(app.exec_())

