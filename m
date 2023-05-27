Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5198C7131E2
	for <lists+stable@lfdr.de>; Sat, 27 May 2023 04:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjE0CRT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 26 May 2023 22:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjE0CRS (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 26 May 2023 22:17:18 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468C112A
        for <stable@vger.kernel.org>; Fri, 26 May 2023 19:17:16 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b00f9c4699so9838775ad.3
        for <stable@vger.kernel.org>; Fri, 26 May 2023 19:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685153835; x=1687745835;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqKtlWiBF4RULgH2Se/z7qvNn9Azu1h/GGw/Y5hx+pI=;
        b=ANlx+YX6LqFLUrGjXD3qKCnzvf7YYRe9qHzTDzu+mDIIIdHWT7iGDhvg33/GekFKA1
         18U5B4UWgBfP56DlbkWy9mB1JIYNYjGxLWCHtkRN2igoF6Gd8Nb60V3ccGH0rbGkrsMt
         ADOrJ6uOPpG+znobRF8kpJIXZie2YwsEx7fY+YkVVQ1JvAKvdloWlY5JIR+A7iegrD3R
         clj6/27vslVAMTRdf3z0itso9uWW3HxYgyarFSXPiAdtZ2Mav3Ac3kBzl6hzWke/STdL
         EYdihlqbppvdDOrrJmFlT+OYSyxfIkYwvZUkNvgLujBHTVlN5pcp4nblIbINOKBE6AOt
         asKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685153835; x=1687745835;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZqKtlWiBF4RULgH2Se/z7qvNn9Azu1h/GGw/Y5hx+pI=;
        b=eGi2j58RjkyuOHS2Zf7PUAaf77gvvR9GvWRf6ISwGTBggGFHoighYn1VbFtsi7p7bD
         GNIWer7xRCg5k4nf341dvwe7FCqh1Vp0QfeGc83AG4bptdDDoH6bLyJD2X3X7JgCvKWI
         i1+1y4rKHikIaVxDXfLNcupEesIrxhMelC0ZXcA6uU1qKBZHnFNWwqxqGv/ZaHGQA4ch
         ayIF44Q+sjMk+S2xm2dZ6wFMTPn0S67ylxOIX3aWWI4hogtYNNwk/Y8kwCXMz0tXCxFL
         kFriewe/OrSjhjdBGTJSs1VlpggxZn76zWozho+0+IKVBVqIWwB0t+LAXlVvKVQCg0UD
         KcZw==
X-Gm-Message-State: AC+VfDwQLG9qYuajAHo7AUjcwpCjlOCI9hjxabgyfSsywvY0rZFZuzu/
        Pezr/4+08Wm1gF+fB4FId6wRQeS+rrM0yZpXUqDydg==
X-Google-Smtp-Source: ACHHUZ7XEaDOm3JFakgbLjg5AIU9eOz5d7H3VcbssDoEnsEtapxg7WVZP8TcbWVjjGs1KxV/ubgy9A==
X-Received: by 2002:a17:903:41d0:b0:1ae:6cf0:94eb with SMTP id u16-20020a17090341d000b001ae6cf094ebmr6021004ple.5.1685153835077;
        Fri, 26 May 2023 19:17:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ja17-20020a170902efd100b001a2b79db755sm3849470plb.140.2023.05.26.19.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 19:17:14 -0700 (PDT)
Message-ID: <6471682a.170a0220.6844.8c0b@mx.google.com>
Date:   Fri, 26 May 2023 19:17:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.29-330-g5e3e9f8e6af9
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 172 runs,
 9 regressions (v6.1.29-330-g5e3e9f8e6af9)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/queue/6.1 baseline: 172 runs, 9 regressions (v6.1.29-330-g5e3e9f8=
e6af9)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.29-330-g5e3e9f8e6af9/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.29-330-g5e3e9f8e6af9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      5e3e9f8e6af9b0bb30cc75540ac9f612449b0682 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6471357d400698e4342e86ca

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g5e3e9f8e6af9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g5e3e9f8e6af9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6471357e400698e4342e86cf
        failing since 59 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-26T22:40:47.588113  <8>[   10.176038] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10474148_1.4.2.3.1>

    2023-05-26T22:40:47.591720  + set +x

    2023-05-26T22:40:47.693136  =


    2023-05-26T22:40:47.793742  / # #export SHELL=3D/bin/sh

    2023-05-26T22:40:47.793963  =


    2023-05-26T22:40:47.894463  / # export SHELL=3D/bin/sh. /lava-10474148/=
environment

    2023-05-26T22:40:47.894683  =


    2023-05-26T22:40:47.995185  / # . /lava-10474148/environment/lava-10474=
148/bin/lava-test-runner /lava-10474148/1

    2023-05-26T22:40:47.995544  =


    2023-05-26T22:40:48.001435  / # /lava-10474148/bin/lava-test-runner /la=
va-10474148/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6471357edabbcbb4132e86b6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g5e3e9f8e6af9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g5e3e9f8e6af9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6471357edabbcbb4132e86bb
        failing since 59 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-26T22:40:41.768212  + set<8>[   11.729950] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10474186_1.4.2.3.1>

    2023-05-26T22:40:41.768321   +x

    2023-05-26T22:40:41.873033  / # #

    2023-05-26T22:40:41.973670  export SHELL=3D/bin/sh

    2023-05-26T22:40:41.973869  #

    2023-05-26T22:40:42.074444  / # export SHELL=3D/bin/sh. /lava-10474186/=
environment

    2023-05-26T22:40:42.074659  =


    2023-05-26T22:40:42.175261  / # . /lava-10474186/environment/lava-10474=
186/bin/lava-test-runner /lava-10474186/1

    2023-05-26T22:40:42.175543  =


    2023-05-26T22:40:42.180632  / # /lava-10474186/bin/lava-test-runner /la=
va-10474186/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6471357b1253c9bb4e2e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g5e3e9f8e6af9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g5e3e9f8e6af9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6471357b1253c9bb4e2e85eb
        failing since 59 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-26T22:40:42.095493  <8>[   11.216257] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10474149_1.4.2.3.1>

    2023-05-26T22:40:42.098466  + set +x

    2023-05-26T22:40:42.199878  =


    2023-05-26T22:40:42.300466  / # #export SHELL=3D/bin/sh

    2023-05-26T22:40:42.300693  =


    2023-05-26T22:40:42.401212  / # export SHELL=3D/bin/sh. /lava-10474149/=
environment

    2023-05-26T22:40:42.401446  =


    2023-05-26T22:40:42.501996  / # . /lava-10474149/environment/lava-10474=
149/bin/lava-test-runner /lava-10474149/1

    2023-05-26T22:40:42.502314  =


    2023-05-26T22:40:42.507236  / # /lava-10474149/bin/lava-test-runner /la=
va-10474149/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647137c2b49b896f1b2e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g5e3e9f8e6af9/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g5e3e9f8e6af9/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647137c2b49b896f1b2e8=
5e7
        failing since 36 days (last pass: v6.1.22-477-g2128d4458cbc, first =
fail: v6.1.22-474-gecc61872327e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6471356edabbcbb4132e8685

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g5e3e9f8e6af9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g5e3e9f8e6af9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6471356edabbcbb4132e868a
        failing since 59 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-26T22:40:40.023567  + set +x

    2023-05-26T22:40:40.030399  <8>[   11.002172] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10474137_1.4.2.3.1>

    2023-05-26T22:40:40.134928  / # #

    2023-05-26T22:40:40.235666  export SHELL=3D/bin/sh

    2023-05-26T22:40:40.235878  #

    2023-05-26T22:40:40.336473  / # export SHELL=3D/bin/sh. /lava-10474137/=
environment

    2023-05-26T22:40:40.336687  =


    2023-05-26T22:40:40.437215  / # . /lava-10474137/environment/lava-10474=
137/bin/lava-test-runner /lava-10474137/1

    2023-05-26T22:40:40.437509  =


    2023-05-26T22:40:40.442203  / # /lava-10474137/bin/lava-test-runner /la=
va-10474137/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64713571400698e4342e861d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g5e3e9f8e6af9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g5e3e9f8e6af9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64713571400698e4342e8622
        failing since 59 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-26T22:40:33.478597  + set +x

    2023-05-26T22:40:33.485098  <8>[    7.913657] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10474131_1.4.2.3.1>

    2023-05-26T22:40:33.587104  #

    2023-05-26T22:40:33.587369  =


    2023-05-26T22:40:33.687921  / # #export SHELL=3D/bin/sh

    2023-05-26T22:40:33.688106  =


    2023-05-26T22:40:33.788628  / # export SHELL=3D/bin/sh. /lava-10474131/=
environment

    2023-05-26T22:40:33.788811  =


    2023-05-26T22:40:33.889366  / # . /lava-10474131/environment/lava-10474=
131/bin/lava-test-runner /lava-10474131/1

    2023-05-26T22:40:33.889638  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6471357d181ce598fa2e85ec

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g5e3e9f8e6af9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g5e3e9f8e6af9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6471357d181ce598fa2e85f1
        failing since 59 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-26T22:40:37.891728  + set<8>[    8.625158] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10474156_1.4.2.3.1>

    2023-05-26T22:40:37.891825   +x

    2023-05-26T22:40:37.996136  / # #

    2023-05-26T22:40:38.096910  export SHELL=3D/bin/sh

    2023-05-26T22:40:38.097153  #

    2023-05-26T22:40:38.197706  / # export SHELL=3D/bin/sh. /lava-10474156/=
environment

    2023-05-26T22:40:38.197948  =


    2023-05-26T22:40:38.298524  / # . /lava-10474156/environment/lava-10474=
156/bin/lava-test-runner /lava-10474156/1

    2023-05-26T22:40:38.298839  =


    2023-05-26T22:40:38.302966  / # /lava-10474156/bin/lava-test-runner /la=
va-10474156/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6471356bdc5a0a738f2e8612

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g5e3e9f8e6af9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g5e3e9f8e6af9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6471356bdc5a0a738f2e8617
        failing since 59 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-26T22:40:30.504204  <8>[   11.918083] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10474180_1.4.2.3.1>

    2023-05-26T22:40:30.608963  / # #

    2023-05-26T22:40:30.709823  export SHELL=3D/bin/sh

    2023-05-26T22:40:30.710032  #

    2023-05-26T22:40:30.810525  / # export SHELL=3D/bin/sh. /lava-10474180/=
environment

    2023-05-26T22:40:30.810718  =


    2023-05-26T22:40:30.911299  / # . /lava-10474180/environment/lava-10474=
180/bin/lava-test-runner /lava-10474180/1

    2023-05-26T22:40:30.911554  =


    2023-05-26T22:40:30.916463  / # /lava-10474180/bin/lava-test-runner /la=
va-10474180/1

    2023-05-26T22:40:30.923039  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/647133eed64def09aa2e85f2

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g5e3e9f8e6af9/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mip=
s-malta.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-33=
0-g5e3e9f8e6af9/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mip=
s-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/mipsel/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/647133eed64def0=
9aa2e85fa
        new failure (last pass: v6.1.29-305-ga4121db79070f)
        1 lines

    2023-05-26T22:34:15.983371  kern  :alert : CPU 0 Unable to handle kerne=
l paging request at virtual address 00000000, epc =3D=3D 00000000, ra =3D=
=3D 8023f99c
    2023-05-26T22:34:15.983527  =


    2023-05-26T22:34:15.998036  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dale=
rt RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D1>
    2023-05-26T22:34:15.998187  =

   =

 =20
