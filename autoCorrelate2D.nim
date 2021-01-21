import sequtils


proc generalAutoCorrelate2D*(velocity: seq[seq[float]]): seq[float] = 
    let mainGridNum: int = len(velocity)
    let subGridNum: int = len(velocity[0])
    let maxR: int = mainGridNum
    var tmp: seq[seq[float]] = newSeqWith(2, newSeq[float](maxR))
    var autoCorrelation: seq[float] = newSeq[float](maxR)
    for r in 0..<maxR:
        for s in 0..<subGridNum:
            for m in 0..<mainGridNum:
                if m + r >= mainGridNum:
                    continue
                else:
                    tmp[0][r] += 1.0
                    tmp[1][r] += velocity[m + r][s] * velocity[m][s]
        autoCorrelation[r] = tmp[1][r] / tmp[0][r]
    let autoCorrelation0: float = autoCorrelation[0]
    var standardAutoCorrelation: seq[float] = newSeq[float](maxR)
    for i in 0..<maxR:
        standardAutoCorrelation[i] = autoCorrelation[i] / autoCorrelation0
    return standardAutoCorrelation
    
proc fasterAutoCorrelate2D1201x1201*(velocity: array[1201, array[1201, float]]): array[1201, float] = 
    const mainGridNum: int = 1201
    const subGridNum: int = 1201
    const maxR: int = mainGridNum
    var tmp: array[2, array[1201, float]]
    var autoCorrelation: array[1201, float]
    for r in 0..<maxR:
        for s in 0..<subGridNum:
            for m in 0..<mainGridNum:
                if m + r >= mainGridNum:
                    continue
                else:
                    tmp[0][r] += 1.0
                    tmp[1][r] += velocity[m + r][s] * velocity[m][s]
        autoCorrelation[r] = tmp[1][r] / tmp[0][r]
    let autoCorrelation0: float = autoCorrelation[0]
    var standardAutoCorrelation: array[1201, float]
    for i in 0..<maxR:
        standardAutoCorrelation[i] = autoCorrelation[i] / autoCorrelation0
    return standardAutoCorrelation
