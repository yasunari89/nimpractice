import os
import sequtils
import strutils
import strformat
import auto_correlate_2d


let velocityFileName: string = commandLineParams()[0]
let outputFileName: string = commandLineParams()[1]
var velocity: array[1201, array[1201, float]]

block:
    let f: File = open(velocityFileName)
    defer: close(f)
    for i in 0..<1201:
        let line: TaintedString = readLine(f)
        let values = map(split(line), parseFloat)
        for j in 0..<1201:
            velocity[i][j] = values[j]

const heightGridNum: int = 1201
const widthGridNum: int = 1201

echo fmt"GRIDS: {heightGridNum} x {widthGridNum}"
echo "NOW CALCULATING..."

var output: string = ""
block:
    let f: File = open(outputFileName, fmWrite)
    defer: close(f)
    for v in fasterAutoCorrelate2D1201x1201(velocity):
        add(output, fmt"{v} ")
    writeLine(f, output)