for file in `find .themes/linkedlist -name \*`
do
    grep modernizr-2.0.6.min.js $file
    echo $file
done
