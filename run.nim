import os
import sequtils
import strutils
import strformat
import autoCorrelate2D


let velocityFileName: string = commandLineParams()[0]
let outputFileName: string = commandLineParams()[1]
var velocity: seq[seq[float]] = newSeqWith(0, newSeq[float]())

block:
    let f: File = open(velocityFileName)
    defer: close(f)
    while not endOfFile(f):
        let line: TaintedString = readLine(f)
        add(velocity, map(split(line), parseFloat))

let heightGridNum: int = len(velocity)
let widthGridNum: int = len(velocity[0])

echo fmt"GRIDS: {heightGridNum} x {widthGridNum}"
echo "NOW CALCULATING..."

var output: string = ""
block:
    let f: File = open(outputFileName, fmWrite)
    defer: close(f)
    for v in generalAutoCorrelate2D(velocity):
        add(output, fmt"{v} ")
    writeLine(f, output)