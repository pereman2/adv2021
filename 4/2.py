import pdb
with open('input') as f:
    r = f.readlines()


COLS = 5
ROWS = 5
nums = r[0].split(',')
b = r[2:]

i = 0
boards = []
bo = []
for line in b:
    line = line.strip()
    if line == '':
        boards.append(bo)
        bo = []
        i += 1
        continue
    bl = []
    for v in line.split():
        bl.append([v, 0])

    bo.append(bl)

# last board
boards.append(bo)

def mark(n, board):
    for i in range(len(board)):
        for j in range(len(board[i])):
            if board[i][j][0] == n:
                board[i][j][1] = 1

def check(board):
    # rows
    for i in range(ROWS):
        win = 1
        for j in range(COLS):
            if board[i][j][1] == 1:
                continue
            else:
                win = 0
                break
        if win:
            return 1
            
    # cols
    for j in range(COLS):
        win = 1
        for i in range(ROWS):
            if board[i][j][1] == 1:
                continue
            else:
                win = 0
                break
        if win:
            return 1
    return 0

def points(n, board):
    point = 0
    for i in range(ROWS):
        for j in range(COLS):
            if board[i][j][1] == 0:
                point += int(board[i][j][0])
    return point

def printb(board):
    point = 0
    for i in range(ROWS):
        row = ''
        for j in range(COLS):
            point = board[i][j]
            row += str(point) + ' '
        print(row)
    return point

res = 0
nboards = len(boards)
c = 0
bwin = {}
for n in nums:
    for i, board in enumerate(boards):
        mark(n, board)
        win = check(board)
        if win and i not in bwin:
            c +=1 
            bwin[i] = 1
            if c == nboards:
                res = points(n, board)
                res = res * int(n)
    if res:
        break
print(res)
