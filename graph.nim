import plotly
import os
import strutils
import sequtils


let dataFileName: string = commandLineParams()[0]
let graphFileName: string = commandLineParams()[1]

var x: seq[float] = @[]
var y: seq[float] = @[]

block:
    let f: File = open(dataFileName)
    defer: close(f)

    while not endOfFile(f):
        let line: TaintedString = readLine(f)
        let values: seq[float] = map(split(line), parseFloat)
        add(x, values[0])
        add(y, values[1])

var d = Trace[float](mode: PlotMode.LinesMarkers, `type`: PlotType.Scatter)
d.xs = x
d.ys = y
d.marker =Marker[float]()
var p = Plot[float](traces: @[d])

discard p.save(graphFileName)
