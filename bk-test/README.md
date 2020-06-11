# bk-test

[![build status](https://badge.buildkite.com/7795934ce045db5887889a48e5b3d87bfa03fb5e2a87f1b08b.svg?branch=master&theme=00aa65,ce2554,2b74df,8241aa,fff,fff)](https://buildkite.com/myob/bk-test)

> it's pipes all the way down

this repo tests a buildkite queue (stack)

create a pipeline that points to this repo using the `voltron` team and set
an environ `QUEUE` to the name of the buildkite queue to test.

the scripts in [tests/*](tests/*) are executed in default order

invoke this pipeline with an environ QUEUE set to the queue name to test

default queue is `dnp-lab`

```bash
pipe mk -t dont-panic -env 'QUEUE=blep' bk-test queue=blep bk-test-blep
pipe run !$
pipe wait !$
pipe rm !$
```
