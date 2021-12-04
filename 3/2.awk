BEGIN {
    columns = 12;
    #columns = 5;
    for(i=1; i<=columns; i++) {
        common[i] = 0;
        num[i] = ""
    }
    rows = 0
}

{
    total++;
    rows++;
    for(i=1; i<=columns; i++) {
        num[rows] = num[rows] $i
    }
}


END {
    for(i=1; i<=rows; i++) {
        test[i] = i;
    }

    found = 0;
    totest = rows;
    for(i=1; i<=columns; i++) {
        # recomp common
        common[i] = 0;
        for(j=1; j<=totest; j++) {
            rn = substr(num[test[j]], i, 1);
            if (rn == "1") {
                common[i]++;
            }
        }
        c = (common[i] >= (totest / 2));
        tt = 0
        for(j=1; j<=totest; j++) {
            rn = substr(num[test[j]], i, 1);
            if (c &&  rn == "1") {
                # overrides used values so it doesn't matter
                test[++tt] = test[j];
            } else if(!c && rn == "0") {
                test[++tt] = test[j];
            }
        }
        totest = tt;
        if(totest <= 1) {
            res = num[test[1]]
            break;
        }
    }
    o2 = 0
    for(i=1; i<=columns; i++) {
        rn = substr(res, i, 1);
        if (rn == "1") {
            o2 += 2 ^ (columns - i)
        }
    }
    print "solution o2: " o2

    for(i=1; i<=rows; i++) {
        test[i] = i;
    }

    totest = rows;
    for(i=1; i<=columns; i++) {
        # recomp common
        common[i] = 0;
        for(j=1; j<=totest; j++) {
            rn = substr(num[test[j]], i, 1);
            if (rn == "1") {
                common[i]++;
            }
        }
        c = (common[i] >= (totest / 2));
        tt = 0
        for(j=1; j<=totest; j++) {
            rn = substr(num[test[j]], i, 1);
            if (c &&  rn == "0") {
                # overrides used values so it doesn't matter
                test[++tt] = test[j];
            } else if(!c && rn == "1") {
                test[++tt] = test[j];
            }
        }
        totest = tt;
        if(totest <= 1) {
            res = num[test[1]]
            break;
        }
    }
    co2 = 0
    for(i=1; i<=columns; i++) {
        rn = substr(res, i, 1);
        if (rn == "1") {
            co2 += 2 ^ (columns - i)
        }
    }
    print "solution co2: " co2
    print o2 * co2
}
