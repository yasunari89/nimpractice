import os
import sequtils
import strutils
import strformat
import autocorrelate2d


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

block:
    let f: File = open(outputFileName, fmWrite)
    defer: close(f)
    proc generateContinuousX(stop: float, len: int): seq[float] = 
        var res: seq[float] = @[]
        let unit: float = stop / float(len)
        for i in 0..(len-1):
            let v: float = float(i) * unit
            add(res, v)
        return res

    let x: seq[float] = generateContinuousX(8.0, 1201)
    let y: seq[float] = toSeq(fasterAutoCorrelate2D1201x1201(velocity))

    for i in 0..1200:
        writeLine(f, fmt"{x[i]} {y[i]}")