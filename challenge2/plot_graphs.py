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
    if len(sys.argv) < 3:
        sys.exit(1)

    lwd_file = sys.argv[1]
    new_lwd_file = sys.argv[2]

    x1, y1 = read_xy_from_csv(lwd_file)
    x2, y2 = read_xy_from_csv(new_lwd_file)

    plt.plot(x1, y1, marker='o', label=lwd_file)
    plt.plot(x2, y2, marker='s', label=new_lwd_file)

    plt.xlabel("Size")
    plt.ylabel("Time")
    plt.title("Speed comparsion")
    plt.grid(True)
    plt.legend()
    plt.show()

main()


