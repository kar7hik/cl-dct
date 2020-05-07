# Implementation of DCT and iDCT:

## Usage:
    
```common-lisp    
(defparameter *input-vector* #(5 8 3 7 2))

(dct *input-vector*)
;; #(11.18034 2.176251 -1.2472882 0.51374316 -4.409566)

(idct *input-vector*)
;; #(11.576193 -0.61010736 1.6036125 1.8629377 -3.2522953)
```

For more details on the equation and the references, look into the [doc](./doc/) folder.

## License

MIT

