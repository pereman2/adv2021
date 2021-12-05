package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
)
func find (data []byte, f byte, start int) int {
	for i := start ; i < len(data); i++ {
		if data[i] == f {
			return i
		}
	}
	// err
	return -1
}

func Min(x int, y int) int {
    if x < y {
        return x
    }
    return y
}

func Max(x int, y int) int {
    if x < y {
        return y
    }
    return x
}

func main() {
	dat, err := ioutil.ReadFile("./inp")
	if err != nil {
		panic(err)
	}

	movs := make([]int, 0, 1000)
	x := 0
	max := 0
	maxy := 0
	for i := 0; i < len(dat);  {
		comma := find(dat, ',', i)
		space := find(dat, ' ', comma)
		x, _ = strconv.Atoi(string(dat[i:comma]))
		movs = append(movs, x)
		max = Max(max, x)
		x, _ = strconv.Atoi(string(dat[comma+1:space]))
		movs = append(movs, x)
		maxy = Max(maxy, x)

		g := find(dat, '>', space)
		comma = find(dat, ',', g+2)
		line := find(dat, '\n', comma)
		if line == -1 {
			line = len(dat)
		}
		x, _ = strconv.Atoi(string(dat[g+2:comma]))
		movs = append(movs, x)
		max = Max(max, x)
		x, _ = strconv.Atoi(string(dat[comma+1:line]))
		movs = append(movs, x)
		maxy = Max(maxy, x)
		i = line + 1
	}

	max++
	maxy++
	res := 0
	board := make([]int, max*maxy, max*maxy)

	for k:=0 ; k < len(movs); k += 4 {
		x := movs[k]
		y := movs[k + 1]
		xx := movs[k + 2]
		yy := movs[k + 3]
		if (x != xx && y != yy) {
			continue
		}
		if x > xx {
			x, xx = xx, x
			y, yy = yy, y
		}
		if y > yy {
			x, xx = xx, x
			y, yy = yy, y
		}
		if y == yy {
			for i:=x; i <= xx; i++ {
				board[(i*max) + y] += 1
				if board[(i*max) + y] == 2 {
					res++
				}
			}
		} else {
			for j:=y; j <= yy; j++ {
				board[(x*max) + j] += 1
				if board[(x*max) + j] == 2 {
					res++
				}
			}
		}
	}
	fmt.Println(res)
}
