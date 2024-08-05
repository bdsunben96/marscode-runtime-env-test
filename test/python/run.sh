#!/usr/bin/env bash
set -e

script_path=$(readlink -f $(dirname "$0"))
source $script_path/../../util.sh

loginfo "=== start basic env ==="
assert_regex '.conda/bin' 'echo $PATH'
assert_regex '.conda/lib/mariadb' 'echo $CLOUDIDE_LD_LIBRARY_PATH'
assert_regex '.conda/lib/mariadb' 'echo $CLOUDIDE_LD_LIBRARY_PATH'
assert_regex '.conda/lib' 'echo $CLOUDIDE_LD_LIBRARY_PATH'
assert which python
assert "bash -c 'source ~/.bashrc && type conda'"
assert which pip
assert which poetry
assert 'test -e /cloudide/workspace/.cloudide/extensions/ms-pyright.pyright-*'
assert 'test -e /cloudide/workspace/.cloudide/extensions/ms-python.python-*'
assert 'test -e /cloudide/workspace/.cloudide/extensions/ms-python.debugpy-*'
assert 'test -e /cloudide/workspace/.cloudide/extensions/ms-toolsai.jupyter-20*'
assert 'test -e /cloudide/workspace/.cloudide/extensions/ms-toolsai.vscode-jupyter-cell-tags-*'
assert 'test -e /cloudide/workspace/.cloudide/extensions/ms-toolsai.jupyter-keymap-*'
assert 'test -e /cloudide/workspace/.cloudide/extensions/ms-toolsai.jupyter-renderers-*'
assert 'test -e /cloudide/workspace/.cloudide/extensions/ms-toolsai.vscode-jupyter-slideshow-*'
assert_regex 'python.languageServer.*Default' 'cat /cloudide/workspace/.cloudide/data/Machine/settings.json'
assert_regex 'python.analysis.typeCheckingMode.*off' 'cat /cloudide/workspace/.cloudide/data/Machine/settings.json'
assert_regex 'python.analysis.useLibraryCodeForTypes.*true' 'cat /cloudide/workspace/.cloudide/data/Machine/settings.json'

loginfo "=== test hello project ==="
cd $script_path/../../data/python/hello
assert_regex '"hello world"' python main.py

loginfo "=== test pip ==="
# TODO 测试 pip 安装
# fixme: _add_to_path_if_not_exist $HOME/.local/bin 应该在 /etc/cloudide_profile 末位加！
# assert '测试 upgrade pip 后 pip 能否正常工作' -- "pip install --upgrade pip && pip install -y requests"
assert '测试 mysqlclient 安装' -- "nix-env -iA nixpkgs.libmysqlclient && pip install mariadb && python -c 'import mariadb'"
assert '测试 top100 库安装' -- pip install boto3 urllib3 botocore requests certifi typing-extensions idna charset-normalizer python-dateutil setuptools packaging s3transfer aiobotocore wheel pyyaml six grpcio-status pip numpy s3fs fsspec cryptography cffi google-api-core pycparser pandas importlib-metadata pyasn1 rsa zipp click pydantic attrs protobuf jmespath platformdirs pytz jinja2 awscli colorama markupsafe pyjwt tomli googleapis-common-protos wrapt filelock cachetools google-auth pluggy requests-oauthlib virtualenv pytest oauthlib pyarrow docutils exceptiongroup pyasn1-modules jsonschema iniconfig scipy pyparsing aiohttp isodate soupsieve sqlalchemy beautifulsoup4 psutil pydantic-core pygments multidict pyopenssl yarl decorator tzdata async-timeout tqdm grpcio frozenlist pillow aiosignal greenlet openpyxl et-xmlfile requests-toolbelt annotated-types lxml tomlkit werkzeug proto-plus pynacl deprecated azure-core asn1crypto distlib importlib-resources coverage more-itertools google-cloud-storage websocket-client
assert '测试 top100 库导入' -- "python -c 'import boto3; import urllib3; import botocore; import requests; import certifi; import typing_extensions; import idna; import charset_normalizer; import dateutil; import packaging; import s3transfer; import aiobotocore; import yaml; import six; import numpy; import s3fs; import fsspec; import cryptography; import cffi; import pycparser; import pandas; import importlib_metadata; import pyasn1; import rsa; import zipp; import click; import pydantic; import attrs; import jmespath; import platformdirs; import pytz; import jinja2; import awscli; import colorama; import markupsafe; import jwt; import tomli; import wrapt; import filelock; import cachetools; import pluggy; import requests_oauthlib; import virtualenv; import pytest; import oauthlib; import pyarrow; import docutils; import exceptiongroup; import pyasn1_modules; import jsonschema; import iniconfig; import scipy; import pyparsing; import aiohttp; import isodate; import soupsieve; import sqlalchemy; import bs4; import psutil; import pydantic_core; import pygments; import multidict; import OpenSSL; import yarl; import decorator; import tzdata; import async_timeout; import tqdm; import frozenlist; import PIL; import aiosignal; import greenlet; import openpyxl; import et_xmlfile; import requests_toolbelt; import annotated_types; import lxml; import tomlkit; import werkzeug; import nacl; import deprecated; import azure; import asn1crypto; import distlib; import importlib_resources; import coverage; import more_itertools; import websocket;'"
# rm -rf ~/.local/bin/pip ~/.local/bin/pip3 ~/.local/bin/pip3.12 
# rm -rf ~/.local/lib/python3.12/site-packages

loginfo "=== test venv ==="
# TODO 创建
# TODO pip 安装

loginfo "=== test conda ==="
# TODO conda
# TODO conda

loginfo "=== test poerty project ==="
# TODO poerty
