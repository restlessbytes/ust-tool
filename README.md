# Umsatzsteuer CLI Tool

A small and simple CLI tool that helps with VAT calculations. 

It's written in Racket and can be compiled using the build.sh file.

_"Umsatzsteuer?"_

It's the German word for VAT :)

## Usage

The tool does 3 things:

1. Calculate VAT and gross amount for a given net value (default VAT is 19% btw):

`$ ./ust 1000`

2. Calculate VAT and net value for a gross amount:

`$ ./ust -b 1000`

3. Calculates VAT and (a) gross sum from net value or (b) net value from gross amount with custom VAT (i.e. VAT other than 19):

`$ ./ust 1000 14`

(_"Calculate gross amount from net value 1000 and a 14% VAT"_)

The output format is the same for all 3 cases and looks like this:

```shell
$ ./ust 1000
Net Value:     1000.00 EUR
VAT amount:    190.00 EUR
VAT:           19%
Gross amount:  1190.00 EUR
```

_(Currency is in Euro per default; I may make this configurable in the future)_

