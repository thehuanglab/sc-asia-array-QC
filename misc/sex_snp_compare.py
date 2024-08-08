import sys

def main():
    if len(sys.argv) != 4:
        print("Usage: <input of male bim file> <input of female bim file> <output of un-shared SNPs>")
        sys.exit(1)

    male_file = sys.argv[1]
    female_file = sys.argv[2]
    output_file = sys.argv[3]

    snp_counts = {}

    try:
        with open(male_file, 'r') as f:
            for line in f:
                snp = line.split()[1]
                if snp in snp_counts:
                    snp_counts[snp] += 1
                else:
                    snp_counts[snp] = 1
    except IOError as e:
        print(f"Can't open {male_file}: {e}")
        sys.exit(1)

    try:
        with open(female_file, 'r') as f:
            for line in f:
                snp = line.split()[1]
                if snp in snp_counts:
                    snp_counts[snp] += 1
                else:
                    snp_counts[snp] = 1
    except IOError as e:
        print(f"Can't open {female_file}: {e}")
        sys.exit(1)

    try:
        with open(output_file, 'w') as f:
            for snp, count in snp_counts.items():
                if count == 1:
                    f.write(f"{snp}\n")
                elif count != 2:
                    print(f"{snp}\t{count}")
                    sys.exit(1)
    except IOError as e:
        print(f"Can't open {output_file}: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
