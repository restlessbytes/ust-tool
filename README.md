# Umsatzsteuer CLI Tool

A small and simple CLI tool that helps with VAT calculations. 

It's written in Racket and can be compiled using the build.sh file.

## Usage

The tool does 3 things:

1. Calculate VAT and gross amount for a given net value (default VAT is 19% btw):

`$ ./ust 1000`

2. Calculate VAT and net value for a gross amount:

`$ ./ust -b 1000`

(_"-b" is short for "--brutto" and means "gross amount"_)

3. Calculates VAT and (a) gross sum from net value or (b) net value from gross amount with custom VAT (i.e. VAT other than 19):

`$ ./ust 1000 14`

(_"Calculate gross amount from net value 1000 and a 14% VAT"_)

`$ ./ust --brutto 1190`

(_"Calculate net value for a gross value of 1190 (and 19% default VAT)"_)

The output format is the same for all 3 cases and looks like this:

```shell
$ ./ust 1000
Net Value:     1000.00 EUR
VAT amount:    190.00 EUR
VAT:           19%
Gross amount:  1190.00 EUR
```

_(Currency is in Euro per default; I may make this configurable in the future)_

## FAQ

### "Umsatzsteuer"?

It's the German word for VAT :)

### Does it run on Linux / MacOS / Windows?

The script was written and tested on Ubuntu and should run just fine on all Linux variants, and probably also on macOS. No clue about Windows though.

