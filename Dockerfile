# FROM python:3.7.11-slim-bullseye
FROM python:3.8.13-slim-bullseye
RUN apt-get update && apt-get install wget git gcc g++ libgl1 libglib2.0-0 libsm6 libxrender1 libxext6 libtinfo5 -y
WORKDIR /app
COPY requirements.txt /app/requirements.txt
RUN python3.8 -m venv /home/myuser/venv
ENV PATH="/home/myuser/venv/bin:$PATH"
RUN /home/myuser/venv/bin/python3.8 -m pip install --upgrade pip
RUN pip3 install --no-cache-dir wheel
RUN pip3 install numpy==1.19.5
RUN echo lol

RUN pip3 install --no-cache-dir -r requirements.txt
RUN pip3 install mmcv-full==1.1.5
RUN python -c "import mmcv; print(mmcv.__file__)"

ENV PYTHONUNBUFFERED 1

RUN wget https://www.dropbox.com/scl/fi/zmtmdu1eu45brhcmqfy70/faster_rcnn_r50_fpn_1x_coco_20200130-047c8118.pth?rlkey=qz7vdmb4rk7u6cz8fuguzsvub&dl=0 -O faster_rcnn_r50_fpn_1x_coco_20200130-047c8118.pth

RUN wget https://www.dropbox.com/scl/fi/ntyhn8jf3uuifhg6144uz/hrnet_w32_coco_wholebody_256x192_dark-469327ef_20200922.pth?rlkey=q8gmntqnt0rw9w0miedub0cgb&dl=0 -O hrnet_w32_coco_wholebody_256x192_dark-469327ef_20200922.pth



COPY . /app

RUN mv faster_rcnn_r50_fpn_1x_coco_20200130-047c8118.pth /app/pose/mmdet-files/faster_rcnn_r50_fpn_1x_coco_20200130-047c8118.pth

RUN mv hrnet_w32_coco_wholebody_256x192_dark-469327ef_20200922.pth /app/pose/mmpose-files/hrnet_w32_coco_wholebody_256x192_dark-469327ef_20200922.pth



