FROM pytorch/pytorch:2.1.0-cuda12.1-cudnn8-runtime

# Устанавливаем зависимости
RUN apt-get update --fix-missing && apt-get install git libgl1-mesa-glx wget -y
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y libglib2.0-0 -qq

# Клонируем репозиторий
RUN git clone https://github.com/xinntao/Real-ESRGAN.git
WORKDIR Real-ESRGAN

# Устанавливаем зависимости Python
RUN pip install -r requirements.txt \
    && pip install basicsr facexlib gfpgan \
    && python setup.py develop

RUN wget -O /workspace/Real-ESRGAN/weights/realesr-general-x4v3.pth https://github.com/xinntao/Real-ESRGAN/releases/download/v0.2.5.0/realesr-general-x4v3.pth
RUN mkdir -p /workspace/Real-ESRGAN/gfpgan/weights/ && \
    wget -O /workspace/Real-ESRGAN/gfpgan/weights/detection_Resnet50_Final.pth https://github.com/xinntao/facexlib/releases/download/v0.1.0/detection_Resnet50_Final.pth
RUN wget -O /workspace/Real-ESRGAN/gfpgan/weights/parsing_parsenet.pth https://github.com/xinntao/facexlib/releases/download/v0.2.2/parsing_parsenet.pth
RUN wget -O /workspace/Real-ESRGAN/gfpgan/weights/GFPGANv1.4.pth https://github.com/TencentARC/GFPGAN/releases/download/v1.3.0/GFPGANv1.4.pth
RUN wget -O /workspace/Real-ESRGAN/weights/realesr-general-wdn-x4v3.pth https://github.com/xinntao/Real-ESRGAN/releases/download/v0.2.5.0/realesr-general-wdn-x4v3.pth

COPY inference_realesrgan.py .
RUN pip install torch>=1.15
RUN pip install psutil

CMD ["python", "inference_realesrgan.py", "-n", "realesr-general-x4v3", "-i", "inputs", "-o", "results", "--fp32", "--face_enhance", "-dn", "0", "-s", "4"]