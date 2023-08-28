greeting:
	echo "Hello World"
math:
	expr 2 + 2
all: greeting math
directories:
	-mkdir tmp
	-mkdir data