Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085E8713182
	for <lists+stable@lfdr.de>; Sat, 27 May 2023 03:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237570AbjE0BaA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 26 May 2023 21:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238174AbjE0B35 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 26 May 2023 21:29:57 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD04A7
        for <stable@vger.kernel.org>; Fri, 26 May 2023 18:29:54 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b0236ee816so3512405ad.1
        for <stable@vger.kernel.org>; Fri, 26 May 2023 18:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685150994; x=1687742994;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ApIz7ZNtIXCQttYqJ9v73KrImpFnxjUELrq+u6F+T/M=;
        b=GDe0pf200nPT8mnZwVLY30J8E6o+rr+P7U3xVQc501njTX89XOzuhNtmhBbYsExyoj
         9Bg+0ipOhxiZ9vBbu66HFkxBz+mpF1n9QNlBQ0x12geCWT8X8uIEpQTiAqdkTbfO5WGt
         EUgXxeN5ITV61ySaviIDceZERYXenv7eMnt/cQ/TjLqn7SB6eS8cMxqE5UEjrykYSzEK
         EvtAzRoVLRmwjdEEBR2OasjCiLaYfoZnEyr3FilRz6CdmWekH6bpJfMmrBC7LSrCl0rI
         XiC1USUAfmP8/nbaVPZbhKjLOyizBbgCNw6qE1lfqWu9gOXenlP/T50t2pxrUPe5EMSD
         QOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685150994; x=1687742994;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ApIz7ZNtIXCQttYqJ9v73KrImpFnxjUELrq+u6F+T/M=;
        b=A3lNdJ0VD1acPvN+T/UsoA57l9q4YVDgxlUvezKXAlF+kj+LTt6L5CtsgUu7pl2u5j
         akqs4RjqiimG1yTekuKqGOpfrGH+BY3ozMgixS5w4GwVyVddiWHt1O3l9QF1FynB81JV
         hEgEUYmqOU/NoKyOlijUAm7gdTTGUp/HZw9A6AE6a4SGigJb4eDSYqHDGCni8P9J668p
         bH6tN8wm2dt+9AWJHHULeOrm3iP5LGBYY/qTqX+FDihORM/X2v1Kkd1GDPTZ7ZVVhL9d
         wLHsMomuXy50677m9Im9xquW/d6mM65BtPYref8MNCqeHLyUABWbqWz5E808u+WG/Sd7
         i7uQ==
X-Gm-Message-State: AC+VfDyqoXUfFnEBbKCYJs6bPQa6v7IYpPYtA4HEy4+N6KTWy1w7qGkd
        iu1p54krhOP0p0wX0xciEwqxtvJC+fIKFIaSnvhv8A==
X-Google-Smtp-Source: ACHHUZ6t5b0uixsDc05QYqVJ49vrRNbMethuW6Er5UPsHDupZogR4TvAUTQtsUakn4cbafscJpmXlg==
X-Received: by 2002:a17:902:c94f:b0:1af:b5af:367b with SMTP id i15-20020a170902c94f00b001afb5af367bmr919166pla.29.1685150993685;
        Fri, 26 May 2023 18:29:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a18-20020a170902ecd200b001ac38343438sm3812736plh.176.2023.05.26.18.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 18:29:53 -0700 (PDT)
Message-ID: <64715d11.170a0220.c1c35.84b5@mx.google.com>
Date:   Fri, 26 May 2023 18:29:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.180-174-gdb0d2064ef6a
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 171 runs,
 7 regressions (v5.10.180-174-gdb0d2064ef6a)
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

stable-rc/queue/5.10 baseline: 171 runs, 7 regressions (v5.10.180-174-gdb0d=
2064ef6a)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.180-174-gdb0d2064ef6a/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.180-174-gdb0d2064ef6a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      db0d2064ef6aea97f7e071c9b4fdc4e7820709eb =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647126a0d93dd01b302e8628

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-174-gdb0d2064ef6a/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-174-gdb0d2064ef6a/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647126a0d93dd01b302e865e
        failing since 101 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-05-26T21:37:17.042961  <8>[   19.988250] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 519212_1.5.2.4.1>
    2023-05-26T21:37:17.155132  / # #
    2023-05-26T21:37:17.258277  export SHELL=3D/bin/sh
    2023-05-26T21:37:17.259181  #
    2023-05-26T21:37:17.361245  / # export SHELL=3D/bin/sh. /lava-519212/en=
vironment
    2023-05-26T21:37:17.362155  =

    2023-05-26T21:37:17.464270  / # . /lava-519212/environment/lava-519212/=
bin/lava-test-runner /lava-519212/1
    2023-05-26T21:37:17.465729  =

    2023-05-26T21:37:17.469692  / # /lava-519212/bin/lava-test-runner /lava=
-519212/1
    2023-05-26T21:37:17.578592  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647125edc5853b5cdf2e860a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-174-gdb0d2064ef6a/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-174-gdb0d2064ef6a/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647125edc5853b5cdf2e860f
        failing since 120 days (last pass: v5.10.165-76-g5c2e982fcf18, firs=
t fail: v5.10.165-77-g4600242c13ed)

    2023-05-26T21:34:18.601182  <8>[   11.039196] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3621196_1.5.2.4.1>
    2023-05-26T21:34:18.708079  / # #
    2023-05-26T21:34:18.809745  export SHELL=3D/bin/sh
    2023-05-26T21:34:18.810264  #
    2023-05-26T21:34:18.911514  / # export SHELL=3D/bin/sh. /lava-3621196/e=
nvironment
    2023-05-26T21:34:18.911964  =

    2023-05-26T21:34:19.013268  / # . /lava-3621196/environment/lava-362119=
6/bin/lava-test-runner /lava-3621196/1
    2023-05-26T21:34:19.013943  =

    2023-05-26T21:34:19.014137  / # <3>[   11.371766] Bluetooth: hci0: comm=
and 0x0c03 tx timeout
    2023-05-26T21:34:19.018832  /lava-3621196/bin/lava-test-runner /lava-36=
21196/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647123b04ed10684992e85f6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-174-gdb0d2064ef6a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-174-gdb0d2064ef6a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647123b04ed10684992e85fb
        failing since 57 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-26T21:24:45.523694  + set +x

    2023-05-26T21:24:45.530382  <8>[    8.274330] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10473175_1.4.2.3.1>

    2023-05-26T21:24:45.637796  / # #

    2023-05-26T21:24:45.740092  export SHELL=3D/bin/sh

    2023-05-26T21:24:45.740875  #

    2023-05-26T21:24:45.842240  / # export SHELL=3D/bin/sh. /lava-10473175/=
environment

    2023-05-26T21:24:45.842878  =


    2023-05-26T21:24:45.944244  / # . /lava-10473175/environment/lava-10473=
175/bin/lava-test-runner /lava-10473175/1

    2023-05-26T21:24:45.945317  =


    2023-05-26T21:24:45.950233  / # /lava-10473175/bin/lava-test-runner /la=
va-10473175/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647122fe084e813aea2e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-174-gdb0d2064ef6a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-174-gdb0d2064ef6a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647122fe084e813aea2e85eb
        failing since 57 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-26T21:21:45.784193  <8>[   13.483607] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10473210_1.4.2.3.1>

    2023-05-26T21:21:45.787093  + set +x

    2023-05-26T21:21:45.888465  =


    2023-05-26T21:21:45.989035  / # #export SHELL=3D/bin/sh

    2023-05-26T21:21:45.989240  =


    2023-05-26T21:21:46.089810  / # export SHELL=3D/bin/sh. /lava-10473210/=
environment

    2023-05-26T21:21:46.090017  =


    2023-05-26T21:21:46.190589  / # . /lava-10473210/environment/lava-10473=
210/bin/lava-test-runner /lava-10473210/1

    2023-05-26T21:21:46.190924  =


    2023-05-26T21:21:46.195817  / # /lava-10473210/bin/lava-test-runner /la=
va-10473210/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/647123d9ec94b9284b2e85fe

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-174-gdb0d2064ef6a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-174-gdb0d2064ef6a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/647123d9ec94b9284b2e8604
        failing since 73 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-26T21:25:38.585637  <8>[   34.036935] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-05-26T21:25:39.610268  /lava-10473280/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/647123d9ec94b9284b2e8605
        failing since 73 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-26T21:25:38.574541  /lava-10473280/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6471253a8d7eea7ac92e85f8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-174-gdb0d2064ef6a/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-174-gdb0d2064ef6a/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6471253a8d7eea7ac92e85fd
        failing since 114 days (last pass: v5.10.165-139-gefb57ce0f880, fir=
st fail: v5.10.165-149-ge30e8271d674)

    2023-05-26T21:31:10.596890  / # #
    2023-05-26T21:31:10.698622  export SHELL=3D/bin/sh
    2023-05-26T21:31:10.698985  #
    2023-05-26T21:31:10.800330  / # export SHELL=3D/bin/sh. /lava-3621193/e=
nvironment
    2023-05-26T21:31:10.800798  =

    2023-05-26T21:31:10.902220  / # . /lava-3621193/environment/lava-362119=
3/bin/lava-test-runner /lava-3621193/1
    2023-05-26T21:31:10.903012  =

    2023-05-26T21:31:10.918955  / # /lava-3621193/bin/lava-test-runner /lav=
a-3621193/1
    2023-05-26T21:31:11.008877  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-26T21:31:11.009609  + cd /lava-3621193/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
