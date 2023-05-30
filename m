Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE447170CF
	for <lists+stable@lfdr.de>; Wed, 31 May 2023 00:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbjE3Whm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 18:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjE3Whj (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 18:37:39 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F9993
        for <stable@vger.kernel.org>; Tue, 30 May 2023 15:37:36 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d4e4598f0so5641363b3a.2
        for <stable@vger.kernel.org>; Tue, 30 May 2023 15:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685486256; x=1688078256;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I/r2PTSLyszPZ0feSnCLberipXu5UIQ7ZeHLoZAHwuE=;
        b=5leq+O0HiVhelAduPucHl1BhTMVnRXeWYhDQe59HZBIKve5Bg8CXrmAyEirWotoZ3c
         b/eFrFgrhmEMS2Fr297cqhT19LdfRhoNVqhyqPoi3Ie8QcXs96RrUvQTd2c3Fqx78wK3
         XcrKYWSsXnsA2M0Cz2Pcij9IrS8zGhutU+gLKCpt0prC4AxMyjhLcKOJNhGWSyI/KxNz
         YOZEHfk8VlWzeVf964kJq5wGIlKRwLXx4EA2oeIDSF63klq1pr5W6PVtONDe9RiDgNVf
         XaJiIEJrxaI2LbiUxhL+YXPRACv1znuUFnsdAJKBbyv+bD/LUz/miCU9k+dBdrk+nLVz
         +cHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685486256; x=1688078256;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/r2PTSLyszPZ0feSnCLberipXu5UIQ7ZeHLoZAHwuE=;
        b=JoUs/EQ+Vhma0gzS7KN8jqEYcduWPj1n3fzn5cM4NMTSHge8slp4MmlSTW3w9ytQ9z
         7tvZe36dZD4MMNgqNAvmU/5A/oSd0pjM5Boc2CPHkK6nOk8qVQHkCWdAgT51SONxcrp8
         CtQfg1py8xwC3Wq3enKNtiEbqO/R+e1pumVGUcIGn4uNbED+KlReVRN/3wVSN6AxtcJJ
         1Qn7SxaIAmYbtYTzuL3wtqmAi453qNwtX5n8FFpsGKVAj6cyOZMRLcuWGl0aLmVobGOg
         ruJ7KKZYq8be4Qos2t3ER9zuJd2ctI322AMbjPonffjUyTFXp27dmtWdjWiwmQhrLiQL
         yHpQ==
X-Gm-Message-State: AC+VfDz7LYhHpEeMzB2Q2MtIts4axS1OCkF2uuLO4nJYbrUDsUX5iico
        qyd70TCbLK5mOqMyKjBtyywRDIV5XJ6j2aA7h1O77Q==
X-Google-Smtp-Source: ACHHUZ7NfGiSie9ReOUwM2iKnwhxr+XCwnUgsGZD55KS7Pjyg91ydALSRemNz3uhW3MXNXeU2Dav4w==
X-Received: by 2002:a05:6a00:c82:b0:649:dd0d:69d1 with SMTP id a2-20020a056a000c8200b00649dd0d69d1mr4363165pfv.31.1685486255625;
        Tue, 30 May 2023 15:37:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p18-20020aa78612000000b0064d2c7ac49fsm2145409pfn.31.2023.05.30.15.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 15:37:35 -0700 (PDT)
Message-ID: <64767aaf.a70a0220.6bd34.4f81@mx.google.com>
Date:   Tue, 30 May 2023 15:37:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.114
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.15.y baseline: 162 runs, 13 regressions (v5.15.114)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.15.y baseline: 162 runs, 13 regressions (v5.15.114)

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

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 4          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.114/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.114
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      0ab06468cbd149aac0d7f216ec00452ff8c74e0b =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6476473e71cd0d07382e861f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6476473e71cd0d07382e8624
        failing since 62 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-30T18:57:47.900212  + set +x

    2023-05-30T18:57:47.906707  <8>[   12.921559] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10529604_1.4.2.3.1>

    2023-05-30T18:57:48.010876  / # #

    2023-05-30T18:57:48.111530  export SHELL=3D/bin/sh

    2023-05-30T18:57:48.111816  #

    2023-05-30T18:57:48.212421  / # export SHELL=3D/bin/sh. /lava-10529604/=
environment

    2023-05-30T18:57:48.212637  =


    2023-05-30T18:57:48.313271  / # . /lava-10529604/environment/lava-10529=
604/bin/lava-test-runner /lava-10529604/1

    2023-05-30T18:57:48.313567  =


    2023-05-30T18:57:48.319538  / # /lava-10529604/bin/lava-test-runner /la=
va-10529604/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647647413f1939e5882e85f2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647647413f1939e5882e85f7
        failing since 62 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-30T18:57:56.265435  + set +x<8>[   11.485808] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10529650_1.4.2.3.1>

    2023-05-30T18:57:56.266054  =


    2023-05-30T18:57:56.374014  / # #

    2023-05-30T18:57:56.476543  export SHELL=3D/bin/sh

    2023-05-30T18:57:56.477345  #

    2023-05-30T18:57:56.578951  / # export SHELL=3D/bin/sh. /lava-10529650/=
environment

    2023-05-30T18:57:56.579830  =


    2023-05-30T18:57:56.681350  / # . /lava-10529650/environment/lava-10529=
650/bin/lava-test-runner /lava-10529650/1

    2023-05-30T18:57:56.682697  =


    2023-05-30T18:57:56.687483  / # /lava-10529650/bin/lava-test-runner /la=
va-10529650/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6476474bd553ff29ba2e860a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6476474bd553ff29ba2e860f
        failing since 62 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-30T18:58:01.815579  <8>[   10.747397] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10529656_1.4.2.3.1>

    2023-05-30T18:58:01.819060  + set +x

    2023-05-30T18:58:01.920353  =


    2023-05-30T18:58:02.020928  / # #export SHELL=3D/bin/sh

    2023-05-30T18:58:02.021089  =


    2023-05-30T18:58:02.121599  / # export SHELL=3D/bin/sh. /lava-10529656/=
environment

    2023-05-30T18:58:02.121758  =


    2023-05-30T18:58:02.222254  / # . /lava-10529656/environment/lava-10529=
656/bin/lava-test-runner /lava-10529656/1

    2023-05-30T18:58:02.222497  =


    2023-05-30T18:58:02.227268  / # /lava-10529656/bin/lava-test-runner /la=
va-10529656/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64764a70bae4f4b6a22e8601

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64764a70bae4f4b6a22e8=
602
        failing since 383 days (last pass: v5.15.37-259-gab77581473a3, firs=
t fail: v5.15.39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647648a5e8759b6ee02e86a6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647648a5e8759b6ee02e86ab
        failing since 133 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-05-30T19:03:53.560140  <8>[   10.061319] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3632320_1.5.2.4.1>
    2023-05-30T19:03:53.672277  / # #
    2023-05-30T19:03:53.775649  export SHELL=3D/bin/sh
    2023-05-30T19:03:53.776756  #
    2023-05-30T19:03:53.879148  / # export SHELL=3D/bin/sh. /lava-3632320/e=
nvironment
    2023-05-30T19:03:53.880419  =

    2023-05-30T19:03:53.881046  / # . /lava-3632320/environment<3>[   10.35=
3145] Bluetooth: hci0: command 0x0c03 tx timeout
    2023-05-30T19:03:53.983534  /lava-3632320/bin/lava-test-runner /lava-36=
32320/1
    2023-05-30T19:03:53.985211  =

    2023-05-30T19:03:53.990692  / # /lava-3632320/bin/lava-test-runner /lav=
a-3632320/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6476473a2d4fa186cf2e8600

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6476473a2d4fa186cf2e8605
        failing since 62 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-30T18:57:52.584533  + <8>[   10.625115] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10529657_1.4.2.3.1>

    2023-05-30T18:57:52.584618  set +x

    2023-05-30T18:57:52.685741  #

    2023-05-30T18:57:52.786454  / # #export SHELL=3D/bin/sh

    2023-05-30T18:57:52.786625  =


    2023-05-30T18:57:52.887136  / # export SHELL=3D/bin/sh. /lava-10529657/=
environment

    2023-05-30T18:57:52.887307  =


    2023-05-30T18:57:52.987849  / # . /lava-10529657/environment/lava-10529=
657/bin/lava-test-runner /lava-10529657/1

    2023-05-30T18:57:52.988137  =


    2023-05-30T18:57:52.993730  / # /lava-10529657/bin/lava-test-runner /la=
va-10529657/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6476473ab9798c130b2e8616

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6476473ab9798c130b2e861b
        failing since 62 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-30T18:57:43.711087  + set +x

    2023-05-30T18:57:43.717504  <8>[   11.893835] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10529665_1.4.2.3.1>

    2023-05-30T18:57:43.824901  / # #

    2023-05-30T18:57:43.925699  export SHELL=3D/bin/sh

    2023-05-30T18:57:43.926336  #

    2023-05-30T18:57:44.027712  / # export SHELL=3D/bin/sh. /lava-10529665/=
environment

    2023-05-30T18:57:44.028264  =


    2023-05-30T18:57:44.129159  / # . /lava-10529665/environment/lava-10529=
665/bin/lava-test-runner /lava-10529665/1

    2023-05-30T18:57:44.129915  =


    2023-05-30T18:57:44.134874  / # /lava-10529665/bin/lava-test-runner /la=
va-10529665/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6476473971cd0d07382e8603

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6476473a71cd0d07382e8608
        failing since 62 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-30T18:57:56.695352  + set<8>[   10.993220] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10529616_1.4.2.3.1>

    2023-05-30T18:57:56.695781   +x

    2023-05-30T18:57:56.802893  / # #

    2023-05-30T18:57:56.905173  export SHELL=3D/bin/sh

    2023-05-30T18:57:56.905925  #

    2023-05-30T18:57:57.007249  / # export SHELL=3D/bin/sh. /lava-10529616/=
environment

    2023-05-30T18:57:57.007925  =


    2023-05-30T18:57:57.109263  / # . /lava-10529616/environment/lava-10529=
616/bin/lava-test-runner /lava-10529616/1

    2023-05-30T18:57:57.110341  =


    2023-05-30T18:57:57.115396  / # /lava-10529616/bin/lava-test-runner /la=
va-10529616/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6476472ae1191872592e863a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6476472ae1191872592e863f
        failing since 62 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-30T18:57:37.031442  <8>[    9.632753] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10529640_1.4.2.3.1>

    2023-05-30T18:57:37.139877  / # #

    2023-05-30T18:57:37.242470  export SHELL=3D/bin/sh

    2023-05-30T18:57:37.243495  #

    2023-05-30T18:57:37.345120  / # export SHELL=3D/bin/sh. /lava-10529640/=
environment

    2023-05-30T18:57:37.345908  =


    2023-05-30T18:57:37.447628  / # . /lava-10529640/environment/lava-10529=
640/bin/lava-test-runner /lava-10529640/1

    2023-05-30T18:57:37.448859  =


    2023-05-30T18:57:37.454510  / # /lava-10529640/bin/lava-test-runner /la=
va-10529640/1

    2023-05-30T18:57:37.459995  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/64764a06177d9e4f1d2e8692

  Results:     153 PASS, 14 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-ku=
kui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-ku=
kui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/64764a06177d9e4f1d2e869f
        failing since 15 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-05-30T19:09:38.437247  /lava-10529768/1/../bin/lava-test-case

    2023-05-30T19:09:38.443398  <8>[   60.513050] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64764a06177d9e4f1d2e8727
        failing since 15 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-05-30T19:09:24.275956  + set +x

    2023-05-30T19:09:24.282104  <8>[   46.351430] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10529768_1.5.2.3.1>

    2023-05-30T19:09:24.387387  / # #

    2023-05-30T19:09:24.488207  export SHELL=3D/bin/sh

    2023-05-30T19:09:24.488456  #

    2023-05-30T19:09:24.589078  / # export SHELL=3D/bin/sh. /lava-10529768/=
environment

    2023-05-30T19:09:24.589324  =


    2023-05-30T19:09:24.689971  / # . /lava-10529768/environment/lava-10529=
768/bin/lava-test-runner /lava-10529768/1

    2023-05-30T19:09:24.690382  =


    2023-05-30T19:09:24.695475  / # /lava-10529768/bin/lava-test-runner /la=
va-10529768/1
 =

    ... (13 line(s) more)  =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/64764a06177d9e4f1d2e8736
        failing since 15 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-05-30T19:09:39.479355  /lava-10529768/1/../bin/lava-test-case

    2023-05-30T19:09:39.485444  <8>[   61.554750] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/64764a06177d9e4f1d2e8736
        failing since 15 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-05-30T19:09:39.479355  /lava-10529768/1/../bin/lava-test-case

    2023-05-30T19:09:39.485444  <8>[   61.554750] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =

 =20
