import sys
import csv
import matplotlib.pyplot as plt

def read_xy_from_csv(filename):
    x = []
    y = []
    with open(filename, "r") as f:
        reader = csv.reader(f, delimiter=';')
        for row in reader:
            if len(row) < 2 or row[0] == '' or row[1] == '':
                continue
            try:
                x.append(int(row[0]))
                y.append(float(row[1]))
            except ValueError:
                continue

    return x, y

def main():
    if len(sys.argv) < 2:
        sys.exit(1)

    nof = int(sys.argv[1])
    file1 = sys.argv[2]
    x1, y1 = read_xy_from_csv(file1)
    plt.plot(x1, y1, marker='o', label=file1)
    if(nof > 1):
        file2 = sys.argv[3]
        x2, y2 = read_xy_from_csv(file2)
        plt.plot(x2, y2, marker='s', label=file2)
        if(nof > 2):
            file3 = sys.argv[4]
            x3, y3 = read_xy_from_csv(file3)
            plt.plot(x3, y3, marker='*', label=file3)

    plt.xlabel("Size/Steps")
    plt.ylabel("Time")
    plt.title("")
    plt.grid(True)
    plt.legend()
    plt.show()

main()


