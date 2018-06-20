#!/bin/sh

#FROM: https://github.com/longsleep/build-pine64-image/blob/master/simpleimage/platform-scripts/resize_rootfs.sh

#The MIT License (MIT)
#Copyright (c) 2016 Simon Eisenmann <simon@longsleep.org>
#Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

set -e

if [ "$(id -u)" -ne "0" ]; then
	echo "This script requires root."
	exit 1
fi

set -x

DEVICE="/dev/mmcblk0"
PART="2"

resize() {
	start=$(fdisk -l ${DEVICE}|grep ${DEVICE}p${PART}|awk '{print $2}')
	echo $start

	set +e
	fdisk ${DEVICE} <<EOF
p
d
2
n
p
2
$start

w
EOF
	set -e

	partx -u ${DEVICE}
	resize2fs ${DEVICE}p${PART}
}

resize

echo "Done!"
