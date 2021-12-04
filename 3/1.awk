BEGIN {
    total = 0
    columns = 12;
    # columns = 5;
    for(i=1; i<=columns; i++) {
        common[i] = 0;
    }
}
{
    total++;
    for(i=1; i<=columns; i++) {
        if($i == 1) {
            common[i] += 1
        }
    }
}

function binary_str_to_decimal(binary_str) {
    res = 0
    for(i=1;i<=length(binary_str);i++) {
        bit = substr(binary_str, i, 1)
        if (bit == "1") {
            ex = (length(binary_str) - i)
            res += (2 ^ ex)
        }
    }
    return res
}

END {
    gamma = 0
    epsilon = 0
    for(i=1; i<=columns; i++) {
        print "common is " common[i]
        ex = (columns - i)
        if ( common[i] > total / 2 ) {
            gamma += (2 ^ ex)
        } else {
            epsilon += (2 ^ ex)
        }
        print common[i] 
    }
    print "res"
    print "col " columns
    print gamma
    print epsilon
    print gamma * epsilon
    print "end"
}
