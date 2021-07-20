ARG PYTHON_SHORT_VERSION=3.8
ARG NUMPY_VERSION=1.21.1
ARG PANDAS_VERSION=1.3.0

FROM python:${PYTHON_SHORT_VERSION}-slim-buster as builder

ARG NUMPY_VERSION
ARG PANDAS_VERSION

# Install runtime dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential

# Install NumPy
RUN CFLAGS="-g0" pip install numpy==${NUMPY_VERSION} --no-cache-dir --compile --global-option=build_ext
# Install Pandas
RUN CFLAGS="-g0" pip install pandas==${PANDAS_VERSION} --no-cache-dir --compile --global-option=build_ext

FROM python:${PYTHON_SHORT_VERSION}-slim-buster as final

ARG PYTHON_SHORT_VERSION
COPY --from=builder /usr/local/lib/python${PYTHON_SHORT_VERSION}/site-packages/ /usr/local/lib/python${PYTHON_SHORT_VERSION}/site-packages/

