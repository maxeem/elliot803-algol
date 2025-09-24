#!/bin/bash
# Usage: ./elliot.sh program.algol [input.txt]

ALGOL_SRC=$(realpath "$1")
INPUT_FILE=$2

if [ -z "$ALGOL_SRC" ]; then
    echo "Usage: $0 program.algol [input.txt]"
    exit 1
fi

CMD_ARGS="--cli --machine /elliott803/compiler_image.803"

# mount working dir
DOCKER_RUN="docker run --rm -v $(dirname $ALGOL_SRC):/work elliott803"

# convert Algol source to tape inside container (placeholder)
# assuming emulator tools can do this; otherwise bundle your own converter
$DOCKER_RUN java -jar /elliott803/tools/ascii2tape.jar /work/$(basename $ALGOL_SRC) /tmp/prog.tape

if [ -n "$INPUT_FILE" ]; then
    DOCKER_RUN_INPUT="-v $(realpath $INPUT_FILE):/input.txt"
    INPUT_OPT="--input-tape /input.txt"
else
    DOCKER_RUN_INPUT=""
    INPUT_OPT=""
fi

# now run the program
docker run --rm \
    -v $(dirname $ALGOL_SRC):/work \
    $DOCKER_RUN_INPUT \
    elliott803 \
    $CMD_ARGS \
    --input-tape /tmp/prog.tape \
    $INPUT_OPT \
    --printer - \
    --run
