Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FE86F9BBB
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 23:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjEGVQD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 17:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjEGVQD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 17:16:03 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94925E1
        for <stable@vger.kernel.org>; Sun,  7 May 2023 14:16:00 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1aaed87d8bdso25838765ad.3
        for <stable@vger.kernel.org>; Sun, 07 May 2023 14:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683494159; x=1686086159;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=65QhGFpG1qJYfjkEDz0H2mHFxAdZ5KrndfJrYJjRztk=;
        b=nfiEy6jJP3NaYHQ3c4sh0JJ6EgfUoStJSUQd2Abs8F7Sn4Bc5W7S3mV7DHNXVI7FHd
         HhWr1C8G0L84f1uRt91aiIq9F+VMeERwNnJW4hOM09FI+w4it/8DZFOnWBEPnrUI5iIL
         0O0o71atXassR3O6wiggR20nJR2b4wDUuS6s2bzhXlU6QLBKQmNyMgm/CC+NrA2p3sKX
         7Fb1GnYTklnvg4FFzOgsHsmLmal6y1U1FjFvOGoT0+GFO18miLBkvkMPxRW1KJgT8caM
         fSi+MV+4cf0KTedkwp6BFvCKOvgG0WqSL4Pl/pqg+isPW4C/btWkjvHGY1JbKX4myfCD
         GkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683494159; x=1686086159;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=65QhGFpG1qJYfjkEDz0H2mHFxAdZ5KrndfJrYJjRztk=;
        b=PHFM+BEvuYjWg61lyNk8FrybGYjoBtu/4Icvv2FC4SfXRmLhDENzc2FeIVOyATZbPg
         LA1I0xsK+FFXGTdM/UfLiu8Nmu1VjY4qgsRZasuZFwG5t/8YvI5pYkUUoS5xJr+EPhEw
         UVol4l89E28hNCaSq3Gdyw/z1g7amuU2Ax/pBjhJ+GIOM51No7ugAD/xMV8FWwa/YHzL
         jqt0rc0gBR2bQ9OVfFu+EgU/dJmy6x/MmDb3t/09RUITNzPg6y8gTbYJRcj1K2rgQUeI
         qJwfyCg7VygSOw1APBGEmLDJxfdrG7YCjIpfIGJ8E5cEIoVeNkzw9eB7NO2GRlImX4Z4
         bDzQ==
X-Gm-Message-State: AC+VfDySsV/tnczoBrE84UbLQxVFF+xkhbRteqdr2RzwRF1CTW0Dh+iW
        FBR3f1DhNHS/FPOyqy0HSS1CXHWomExlSlgYWlbvJg==
X-Google-Smtp-Source: ACHHUZ7uw7PKaXdmnaGwlHHVNzEbefWYyxAH1rRTlpjgnxu3xRDd6/g88NEXPtPzxo/6Oypdvr1FBg==
X-Received: by 2002:a17:902:d2c4:b0:1ac:5717:fd2 with SMTP id n4-20020a170902d2c400b001ac57170fd2mr5575782plc.47.1683494159302;
        Sun, 07 May 2023 14:15:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bc6-20020a170902930600b001a9884c02e3sm5585540plb.10.2023.05.07.14.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 14:15:58 -0700 (PDT)
Message-ID: <6458150e.170a0220.cc5ac.9846@mx.google.com>
Date:   Sun, 07 May 2023 14:15:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.105-737-g87be1bf502eda
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 157 runs,
 8 regressions (v5.15.105-737-g87be1bf502eda)
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

stable-rc/queue/5.15 baseline: 157 runs, 8 regressions (v5.15.105-737-g87be=
1bf502eda)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.105-737-g87be1bf502eda/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.105-737-g87be1bf502eda
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      87be1bf502edaac5c96e2f3b3724a545817de7ed =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457debdb9b587d71f2e862d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g87be1bf502eda/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g87be1bf502eda/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457debdb9b587d71f2e8632
        failing since 40 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T17:23:51.711513  + <8>[   11.241529] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10230680_1.4.2.3.1>

    2023-05-07T17:23:51.711989  set +x

    2023-05-07T17:23:51.819372  / # #

    2023-05-07T17:23:51.921923  export SHELL=3D/bin/sh

    2023-05-07T17:23:51.922719  #

    2023-05-07T17:23:52.024443  / # export SHELL=3D/bin/sh. /lava-10230680/=
environment

    2023-05-07T17:23:52.025253  =


    2023-05-07T17:23:52.126771  / # . /lava-10230680/environment/lava-10230=
680/bin/lava-test-runner /lava-10230680/1

    2023-05-07T17:23:52.128204  =


    2023-05-07T17:23:52.132731  / # /lava-10230680/bin/lava-test-runner /la=
va-10230680/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457deb3a5a22739412e8607

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g87be1bf502eda/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g87be1bf502eda/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457deb3a5a22739412e860c
        failing since 40 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T17:23:41.095716  <8>[   10.664196] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10230712_1.4.2.3.1>

    2023-05-07T17:23:41.099252  + set +x

    2023-05-07T17:23:41.200672  =


    2023-05-07T17:23:41.301235  / # #export SHELL=3D/bin/sh

    2023-05-07T17:23:41.301388  =


    2023-05-07T17:23:41.401923  / # export SHELL=3D/bin/sh. /lava-10230712/=
environment

    2023-05-07T17:23:41.402067  =


    2023-05-07T17:23:41.502606  / # . /lava-10230712/environment/lava-10230=
712/bin/lava-test-runner /lava-10230712/1

    2023-05-07T17:23:41.502887  =


    2023-05-07T17:23:41.507907  / # /lava-10230712/bin/lava-test-runner /la=
va-10230712/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457dea946a03422a12e8610

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g87be1bf502eda/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g87be1bf502eda/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457dea946a03422a12e8615
        failing since 40 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T17:23:42.138829  + set +x

    2023-05-07T17:23:42.144871  <8>[   10.915328] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10230640_1.4.2.3.1>

    2023-05-07T17:23:42.250000  / # #

    2023-05-07T17:23:42.350585  export SHELL=3D/bin/sh

    2023-05-07T17:23:42.350773  #

    2023-05-07T17:23:42.451360  / # export SHELL=3D/bin/sh. /lava-10230640/=
environment

    2023-05-07T17:23:42.452090  =


    2023-05-07T17:23:42.553552  / # . /lava-10230640/environment/lava-10230=
640/bin/lava-test-runner /lava-10230640/1

    2023-05-07T17:23:42.553861  =


    2023-05-07T17:23:42.558770  / # /lava-10230640/bin/lava-test-runner /la=
va-10230640/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457deabb9b587d71f2e85f6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g87be1bf502eda/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g87be1bf502eda/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457deabb9b587d71f2e85fb
        failing since 40 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T17:23:44.741142  + set +x<8>[   11.037044] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10230700_1.4.2.3.1>

    2023-05-07T17:23:44.741227  =


    2023-05-07T17:23:44.842784  #

    2023-05-07T17:23:44.943621  / # #export SHELL=3D/bin/sh

    2023-05-07T17:23:44.943767  =


    2023-05-07T17:23:45.044424  / # export SHELL=3D/bin/sh. /lava-10230700/=
environment

    2023-05-07T17:23:45.044602  =


    2023-05-07T17:23:45.145181  / # . /lava-10230700/environment/lava-10230=
700/bin/lava-test-runner /lava-10230700/1

    2023-05-07T17:23:45.145410  =


    2023-05-07T17:23:45.150615  / # /lava-10230700/bin/lava-test-runner /la=
va-10230700/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457dec33a0e76dc742e85fd

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g87be1bf502eda/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g87be1bf502eda/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457dec33a0e76dc742e8602
        failing since 40 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T17:23:54.046217  + <8>[   11.233035] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10230656_1.4.2.3.1>

    2023-05-07T17:23:54.046319  set +x

    2023-05-07T17:23:54.150652  / # #

    2023-05-07T17:23:54.251273  export SHELL=3D/bin/sh

    2023-05-07T17:23:54.251483  #

    2023-05-07T17:23:54.352082  / # export SHELL=3D/bin/sh. /lava-10230656/=
environment

    2023-05-07T17:23:54.352261  =


    2023-05-07T17:23:54.452798  / # . /lava-10230656/environment/lava-10230=
656/bin/lava-test-runner /lava-10230656/1

    2023-05-07T17:23:54.453090  =


    2023-05-07T17:23:54.457660  / # /lava-10230656/bin/lava-test-runner /la=
va-10230656/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6457e012e5a0bef8022e85e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g87be1bf502eda/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-=
imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g87be1bf502eda/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-=
imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457e012e5a0bef8022e85eb
        failing since 100 days (last pass: v5.15.81-121-gcb14018a85f6, firs=
t fail: v5.15.90-146-gbf7101723cc0)

    2023-05-07T17:29:29.943441  + set +x
    2023-05-07T17:29:29.943611  [    9.377929] <LAVA_SIGNAL_ENDRUN 0_dmesg =
943008_1.5.2.3.1>
    2023-05-07T17:29:30.051543  / # #
    2023-05-07T17:29:30.153673  export SHELL=3D/bin/sh
    2023-05-07T17:29:30.154179  #
    2023-05-07T17:29:30.255444  / # export SHELL=3D/bin/sh. /lava-943008/en=
vironment
    2023-05-07T17:29:30.255917  =

    2023-05-07T17:29:30.357173  / # . /lava-943008/environment/lava-943008/=
bin/lava-test-runner /lava-943008/1
    2023-05-07T17:29:30.357810  =

    2023-05-07T17:29:30.360127  / # /lava-943008/bin/lava-test-runner /lava=
-943008/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457deaeb9b587d71f2e861d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g87be1bf502eda/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g87be1bf502eda/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457deaeb9b587d71f2e8622
        failing since 40 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T17:23:44.632827  <8>[   10.807627] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10230713_1.4.2.3.1>

    2023-05-07T17:23:44.737238  / # #

    2023-05-07T17:23:44.837841  export SHELL=3D/bin/sh

    2023-05-07T17:23:44.838009  #

    2023-05-07T17:23:44.938496  / # export SHELL=3D/bin/sh. /lava-10230713/=
environment

    2023-05-07T17:23:44.938678  =


    2023-05-07T17:23:45.039240  / # . /lava-10230713/environment/lava-10230=
713/bin/lava-test-runner /lava-10230713/1

    2023-05-07T17:23:45.039517  =


    2023-05-07T17:23:45.043681  / # /lava-10230713/bin/lava-test-runner /la=
va-10230713/1

    2023-05-07T17:23:45.049489  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6457e4e7b37bb7fdac2e8608

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g87be1bf502eda/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64=
-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-737-g87be1bf502eda/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64=
-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457e4e7b37bb7fdac2e8634
        failing since 109 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-07T17:50:14.682279  + set +x
    2023-05-07T17:50:14.685196  <8>[   16.130994] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3561543_1.5.2.4.1>
    2023-05-07T17:50:14.807338  / # #
    2023-05-07T17:50:14.913328  export SHELL=3D/bin/sh
    2023-05-07T17:50:14.914931  #
    2023-05-07T17:50:15.018748  / # export SHELL=3D/bin/sh. /lava-3561543/e=
nvironment
    2023-05-07T17:50:15.022075  =

    2023-05-07T17:50:15.128896  / # . /lava-3561543/environment/lava-356154=
3/bin/lava-test-runner /lava-3561543/1
    2023-05-07T17:50:15.134711  =

    2023-05-07T17:50:15.137352  / # /lava-3561543/bin/lava-test-runner /lav=
a-3561543/1 =

    ... (12 line(s) more)  =

 =20
