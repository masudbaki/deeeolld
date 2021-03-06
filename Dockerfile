From pytorch/pytorch:1.4-cuda10.1-cudnn7-devel

RUN apt-get -y update

RUN apt-get install -y python3-pip software-properties-common wget ffmpeg

RUN add-apt-repository ppa:git-core/ppa

RUN apt-get -y update

RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash

RUN apt-get install -y git-lfs --allow-unauthenticated

RUN git lfs install

ENV GIT_WORK_TREE=/data

RUN mkdir -p /root/.torch/models

RUN mkdir -p /data/models

RUN wget -O /root/.torch/models/vgg16_bn-6c64b313.pth https://download.pytorch.org/models/vgg16_bn-6c64b313.pth

RUN wget -O /root/.torch/models/resnet34-333f7ec4.pth https://download.pytorch.org/models/resnet34-333f7ec4.pth

RUN wget -O /data/models/ColorizeArtistic_gen.pth https://data.deepai.org/deoldify/ColorizeArtistic_gen.pth

ADD . /data/

WORKDIR /data

RUN pip install -r requirements.txt


EXPOSE 8888
EXPOSE 5000

CMD ["python3", "app.py"]

# ENTRYPOINT ["sh", "/data/run_notebook.sh"]

