; ---- Rectangle-like hotkeys ----
; Alt+Shift+W: Fullscreen (maximize)
!+w::WinMaximize("A")

; Arrays for sizes
global centerSizes := [0.20, 0.30, 0.5]
global leftSizes   := [0.20, 0.30, 0.5]
global rightSizes  := [0.20, 0.30, 0.5]

; Index trackers
global centerIndex := 1
global leftIndex   := 1
global rightIndex  := 1

; ---- Hotkeys ----
; Left cycle
!+a::
{
    global leftSizes, leftIndex
    sideResize("left", leftSizes[leftIndex])
    leftIndex := leftIndex + 1
    if (leftIndex > leftSizes.Length)
        leftIndex := 1
}

; Right cycle
!+d::
{
    global rightSizes, rightIndex
    sideResize("right", rightSizes[rightIndex])
    rightIndex := rightIndex + 1
    if (rightIndex > rightSizes.Length)
        rightIndex := 1
}

; Center cycle
!+s::
{
    global centerSizes, centerIndex
    centerResize(centerSizes[centerIndex])
    centerIndex := centerIndex + 1
    if (centerIndex > centerSizes.Length)
        centerIndex := 1
}

; ---- Helpers ----
sideResize(side, frac) {
    l:=0, t:=0, r:=0, b:=0
    getWorkAreaForActiveWindow(&l,&t,&r,&b)
    workW := (r - l), workH := (b - t)
    w := workW * frac
    if (side = "left") {
        x := l
    } else {
        x := r - w
    }
    WinRestore("A")
    WinMove(Round(x), Round(t), Round(w), Round(workH), "A")
}

centerResize(frac) {
    l:=0, t:=0, r:=0, b:=0
    getWorkAreaForActiveWindow(&l,&t,&r,&b)
    workW := (r - l), workH := (b - t)
    w := workW * frac, x := l + (workW - w) / 2
    WinRestore("A")
    WinMove(Round(x), Round(t), Round(w), Round(workH), "A")
}

getWorkAreaForActiveWindow(&l, &t, &r, &b) {
    wx:=0, wy:=0, ww:=0, wh:=0
    WinGetPos(&wx, &wy, &ww, &wh, "A")
    cx := wx + ww/2, cy := wy + wh/2

    count := MonitorGetCount()
    found := false
    Loop count {
        i := A_Index
        ml:=0, mt:=0, mr:=0, mb:=0
        MonitorGetWorkArea(i, &ml, &mt, &mr, &mb)
        if (cx >= ml && cx <= mr && cy >= mt && cy <= mb) {
            l := ml, t := mt, r := mr, b := mb
            found := true
            break
        }
    }
    if (!found) {
        MonitorGetWorkArea(1, &l, &t, &r, &b)
    }
}
