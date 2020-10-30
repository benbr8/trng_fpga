# trng_fpga

True random number generator for use in an FPGA based on ["A Highly Flexible Lightweight and High Speed True Random Number Generator on FPGA" by Faqiang Mei](https://pure.qub.ac.uk/en/publications/a-highly-flexible-lightweight-and-high-speed-true-random-number-g).

Generic `n_order_g` specifies the number of interleaved ring oscillators used. The module output is tested to pass [NIST SP800-22](https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-22r1a.pdf) and [dieharder tests](https://webhome.phy.duke.edu/~rgb/General/dieharder.php) (few "weak") on an Xilinx Artix-7 at 125 Mbit/s with `n_order_g=4`. 
