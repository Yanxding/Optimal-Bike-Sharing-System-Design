$ontext
GAMS program
Project: Optimizing Shared Bike Placement in University City
By: DING, Yanxiang (MSE SE); OUIMETTE, Jeffrey (MSE SE)
OIDD 910 / ESE 504: Introduction to Optimization Theory
Fall 2017, Project 2
Professor Monique Guignard-Speilberg
University of Pennsylvania
$offtext

set i departure regions
    /d1*d6/
    j arrival regions
    /r1*r6/
    k time periods
    /t1*t6/;
parameters
    revenue per minute revenue
    /0.075/
    theta(i) maximum number of parking docks per station in region i
    /d1 15, d2 15, d3 20, d4 15, d5 15, d6 15/
    beta1(i) minimum number of stations in region i
    /d1 7, d2 7, d3 8, d4 6, d5 5, d6 13/
    beta2(i) maximum number of stations in region i
    /d1 12, d2 13, d3 12, d4 8, d5 9, d6 22/
    alpha demand satisfaction factor
    /0.9/
    c_bike cost per bike
    /600/
    c_dock cost per dock
    /500/
    c_op annual operation cost per bike
    /1400/
    c_station cost per station
    /6000/;
table demand(i,j,k) demand from region i to j in time period k
             t1        t2        t3        t4        t5       t6
d1.r1         9        12        15        15         6        3
d1.r2         3         6         9        12         9        9
d1.r3        12        21        15        21         6        6
d1.r4         3        12         9         6         0        0
d1.r5        15         9         6         9         9        3
d1.r6         9         9        12        15         3        3
d2.r1        12        12         6         9         3        3
d2.r2         3         9        12        18        12        9
d2.r3        12        21        12        15         9        3
d2.r4        12         6         9         9         3        6
d2.r5         3        18         6         9         6        6
d2.r6         9        18         9         9         9        3
d3.r1         3        12        18        24         9        6
d3.r2         9         6        12        30        18        6
d3.r3         6        24        33        45        27        9
d3.r4         6         9        12         6         3        9
d3.r5         9        18        24        24        15        3
d3.r6         9        30        45        75        18        3
d4.r1         9         9         9         3         6        3
d4.r2         6         6         3         9         9        3
d4.r3         9         6         9        12         9        6
d4.r4         6         6         9         9         3        3
d4.r5         3         6         6        15         6        6
d4.r6         9        12        18        48        15        3
d5.r1         3         3         9        15         9        9
d5.r2         6         3         6         6         9        6
d5.r3         9         9        18        18        12        9
d5.r4         6        12         6         6         6        3
d5.r5         3        15        15        21        12        3
d5.r6        18        27        42        93        24        3
d6.r1         3         6         9        18        12        3
d6.r2         9        12         9        18         9        6
d6.r3        18        57        42        48        18        9
d6.r4        33        33        15        12         9        3
d6.r5        69        48        33        36        15        6
d6.r6        27        66        93       120        42       12     ;

table duration(i,j,k) average duration from region i to j in time period k
              t1          t2          t3          t4          t5          t6
d1.r1        11.9        17.2        23.1        32.2        21.6        25.5
d1.r2        13.4        21.9        19.4        22.1        18.9        50.2
d1.r3         7.5         8.2        11.8        12.6        13.7       143.7
d1.r4         9.6        10.8        11.0        10.6         0.0         0.0
d1.r5        10.9        16.8        15.7        16.1        15.8         9.2
d1.r6        15.1        14.0        20.3        15.9        17.1        40.0
d2.r1         6.5         7.4        15.3        21.5        31.8       204.3
d2.r2        52.0        25.7        56.0        27.2        30.4        39.8
d2.r3         9.6        10.1        13.2        13.4        15.9        12.0
d2.r4        34.1         9.6        11.6         8.4        10.2        10.7
d2.r5        12.2        16.2        20.6        17.2        60.6        50.8
d2.r6        18.4        20.4        36.3        20.0        33.4        16.5
d3.r1        19.5        10.4        11.2         9.3        11.7         8.3
d3.r2        10.0        12.1        14.2        10.6        15.4        17.4
d3.r3        21.5        35.7        30.1        29.0        31.5        23.9
d3.r4         7.3         6.7         8.2        10.0        11.6         5.0
d3.r5         8.7        13.1        13.8        11.5        21.6        14.8
d3.r6        23.6        13.0        13.1        13.8        13.5        14.5
d4.r1        11.0        13.0        11.7        13.1        14.6        12.7
d4.r2        17.3        19.0         9.1        10.0        10.8        20.0
d4.r3         6.0        16.9         8.7         9.4        15.3         9.5
d4.r4         8.3        31.8        17.0        11.0        14.6        14.5
d4.r5         4.0        11.5         8.7         7.3        16.5         9.8
d4.r6        10.4         9.8        10.8        10.8        15.4         9.0
d5.r1        11.3        12.1        15.3        16.9        15.4        11.0
d5.r2        14.0        21.3        28.3        15.5        16.9         9.0
d5.r3         8.4        27.1        17.7        23.2        29.5        18.4
d5.r4         8.9        10.2        10.8        24.4         7.0         9.3
d5.r5        29.3        35.1        39.3        22.1        30.5        10.7
d5.r6         8.6        12.3         9.2         8.4        12.8        26.2
d6.r1        18.9        15.7        21.6        16.7        20.9        33.5
d6.r2        16.7        18.6        22.3        23.3        30.4        18.0
d6.r3         9.9        15.6        15.0        16.3        13.6        39.6
d6.r4         9.1         9.5        15.1        13.1        11.1         9.3
d6.r5         9.2         7.8        12.4         9.3        18.9        14.7
d6.r6        17.1        37.1        35.9        23.8        22.1        31.6  ;

variable
    cost total cost of the system
    revenue_total total revenue of 3 years;
positive variables
    si(i)     number of bikes placed in each region in the beginning

    p(i)      amount of parking docks in region i
    s(i,k)    amount of bike in region i at the beginning of time period k
    x(i,j,k)  number of bikes travelling from region i to region j during time period k
    dep(i,k)  number of departure bikes
    arr(j,k)  number of arrival bikes;
integer variable
    b(i)      amount of stations in region i
;

equations  cost_ttl                    the total cost of the system (o.f.)
           revenue_ttl                 revenue generated in 3 years according to demand prediction
           demand_satisfaction(i,j,k)  the system must satisfy a certain level of demand
           trip_upper(i,j,k)           number of trips cannot exceed demand (assume at most 10% increase in demand)
           bike_dock(i,k)              the number of bikes must not exceed the number of parking docks
           departure(i,k)              the amount of arrival bikes of region i in time period k
           arrival(j,k)                the amount of arrival bikes of region j in time period k
           supply(i,j,k)               bike usage must not exceed bike supply
           supply_period_ini(i,k)      number of bikes in initial time periods
           supply_period(i,j,k)        relation between number of bikes in adjacent time periods
           stations1(i)                minimum number of stations in each region
           stations2(i)                maximum number of stations in each region
           docks(i)                    maximum number of parking docks per station in each region ;

cost_ttl..
    cost =e= (c_bike + 3*c_op)*sum(i,si(i)) + c_dock*sum(i,p(i)) + c_station*sum(i,b(i))
               - revenue_total;
revenue_ttl..
    revenue_total =e= 260*3*revenue*sum((i,j,k),x(i,j,k)*duration(i,j,k));
demand_satisfaction(i,j,k)..
    x(i,j,k) =g= alpha*demand(i,j,k);
trip_upper(i,j,k)..
    x(i,j,k) =l= 1.1*demand(i,j,k);
bike_dock(i,k)..
    p(i) =g= 1.3*s(i,k);
departure(i,k)..
    dep(i,k) =e= sum(j,x(i,j,k));
arrival(j,k)..
    arr(j,k) =e= sum(i,x(i,j,k));
supply(i,j,k)$(ord(i)=ord(j))..
    dep(i,k) =l= s(i,k) + 0.5*arr(j,k);
supply_period_ini(i,k)$(ord(k)=1)..
    s(i,k) =e= si(i);
supply_period(i,j,k)$((ord(k)>1) and (ord(i)=ord(j)))..
    s(i,k) =e= s(i,k-1) + arr(j,k-1) - dep(i,k-1);
stations1(i)..
    b(i) =g= beta1(i);
stations2(i)..
    b(i) =l= beta2(i);
docks(i)..
    p(i) =l= theta(i)*b(i);


model CPLEX /all/;
option MIP = CPLEX;
solve CPLEX using MIP minimizing cost;

variable farebox_recovery farebox recovery rate
         sta_capacity(i)  docks per station
         bike_num
         dock_num
         station_num;
farebox_recovery.l = revenue_total.l/((c_bike + 3*c_op)*sum(i,si.l(i)) + c_dock*sum(i,p.l(i)) + c_station*sum(i,b.l(i)));
sta_capacity.l(i) = p.l(i)/b.l(i);
bike_num.l = sum(i,si.l(i));
dock_num.l = sum(i,p.l(i));
station_num.l = sum(i,b.l(i));

display cost.l, bike_num.l, dock_num.l, station_num.l,farebox_recovery.l, si.l, p.l, b.l, demand_satisfaction.l, demand_satisfaction.m,
        stations1.l, stations1.m, stations2.l, stations2.m, sta_capacity.l, docks.m, revenue_total.l ;

*display cost.l, demand_satisfaction.l, demand_satisfaction.m, trip_upper.m ;
