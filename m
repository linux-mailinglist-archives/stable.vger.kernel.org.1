Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BEC6F35C1
	for <lists+stable@lfdr.de>; Mon,  1 May 2023 20:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjEASUk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 1 May 2023 14:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjEASUj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 1 May 2023 14:20:39 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409B21997
        for <stable@vger.kernel.org>; Mon,  1 May 2023 11:20:37 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1aaebed5bd6so12282105ad.1
        for <stable@vger.kernel.org>; Mon, 01 May 2023 11:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682965236; x=1685557236;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dIEfLjsmO9LfPU6+4FdzNS92Rg1q8m9UwcOdU10e9G8=;
        b=23U9zDrzQo8HDEqMHQeJMLCKi5DvKACUQpTLVP3lXn+ydO+QJJqoOMCE+4oQSkeDjb
         HbJRkCxhFPzGACYUWV3ecBN3pcDpZtO3PNxixfN4rcALlzFuvepBmSi7nY9Czvg4TkGE
         R/dCsJqcGSjNHyw2zfmM7jtgErWsiPsNh18SIzLuc1B/OkS3IO773gmDOu5NGHgAGJT5
         z9MV83YvxdIB9E+a0brCeQH89FObcfrkclbERL90o1/R6i6dv7BxI3Sc34UJ5GYLed8Y
         tkTWsZprzvfdIf2hxe1hq3CwnwzrQgTiMhq8ioRGSDPr7CQqVLqyMKTUdeX6QuO6Pg4a
         C9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682965236; x=1685557236;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dIEfLjsmO9LfPU6+4FdzNS92Rg1q8m9UwcOdU10e9G8=;
        b=XiIfWtu2NMKn0Qbxz3ogmuktWFbfuoVoH6w3+vArBhK+ZaUmanlnLrFnj7BjEkagUI
         R6CZDUFNu6notyAOXAKDmumf4BhDQQCXzl/TR3wV3OKpEG/d7B9f3/irBuoARgptQLQF
         STKx0syl4uPWQk8l8tUu/PmDK4uBFAQLYFU0GairiWzYhhMp9ApG46npMjIoeDk08xxc
         EOedfVYXSms6dwFsp2rH1aG5F5OhbCKpE45jLUzEAS5oOM1B1GvIHR7X+uS+T6VpVzW5
         6WAHKGDNm4vYJiUnw3aTscXqpJs1DwBVaWHnMxhL74iySnMyEplm3RlKfpME7C1/cAsJ
         x0Kw==
X-Gm-Message-State: AC+VfDxmWaMHWRZcfQENYZ8Gm++ZlZGWXEYRX9HAoLok6+Hd6QaZuyZA
        YmuOQTsa2xqKhS+MQnAKYSGRFajysMw1j8nOjQk=
X-Google-Smtp-Source: ACHHUZ4QwNVa8ZdhEiy2xpBtJPbFCbFXZGGaaCQAlCeX1nD7aJ3fb2bXlIR6qkXnLI5htvOGok05qQ==
X-Received: by 2002:a17:902:b210:b0:1a6:a8dd:4aeb with SMTP id t16-20020a170902b21000b001a6a8dd4aebmr14835197plr.23.1682965236035;
        Mon, 01 May 2023 11:20:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902b19200b001a96e24e487sm13902505plr.163.2023.05.01.11.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 11:20:35 -0700 (PDT)
Message-ID: <645002f3.170a0220.c3085.b123@mx.google.com>
Date:   Mon, 01 May 2023 11:20:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.176-376-g09ef89800103
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 166 runs,
 8 regressions (v5.10.176-376-g09ef89800103)
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

stable-rc/queue/5.10 baseline: 166 runs, 8 regressions (v5.10.176-376-g09ef=
89800103)

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

rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.176-376-g09ef89800103/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.176-376-g09ef89800103
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      09ef898001032cc2cce3eab8c276ca66d5d28831 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/644fcf322f11bed2c42e85f3

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-376-g09ef89800103/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-376-g09ef89800103/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644fcf322f11bed2c42e8614
        failing since 76 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-05-01T14:39:26.737090  <8>[   19.402874] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 403919_1.5.2.4.1>
    2023-05-01T14:39:26.845420  / # #
    2023-05-01T14:39:26.948290  export SHELL=3D/bin/sh
    2023-05-01T14:39:26.949083  #
    2023-05-01T14:39:27.051377  / # export SHELL=3D/bin/sh. /lava-403919/en=
vironment
    2023-05-01T14:39:27.052103  =

    2023-05-01T14:39:27.154438  / # . /lava-403919/environment/lava-403919/=
bin/lava-test-runner /lava-403919/1
    2023-05-01T14:39:27.155579  =

    2023-05-01T14:39:27.160507  / # /lava-403919/bin/lava-test-runner /lava=
-403919/1
    2023-05-01T14:39:27.268128  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644fd0a8685b4437522e8623

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-376-g09ef89800103/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-376-g09ef89800103/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644fd0a8685b4437522e8628
        failing since 95 days (last pass: v5.10.165-76-g5c2e982fcf18, first=
 fail: v5.10.165-77-g4600242c13ed)

    2023-05-01T14:45:48.965676  <8>[   11.034972] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3545827_1.5.2.4.1>
    2023-05-01T14:45:49.075619  / # #
    2023-05-01T14:45:49.179261  export SHELL=3D/bin/sh
    2023-05-01T14:45:49.179615  #
    2023-05-01T14:45:49.280749  / # export SHELL=3D/bin/sh. /lava-3545827/e=
nvironment
    2023-05-01T14:45:49.281060  =

    2023-05-01T14:45:49.382212  / # . /lava-3545827/environment/lava-354582=
7/bin/lava-test-runner /lava-3545827/1
    2023-05-01T14:45:49.382729  =

    2023-05-01T14:45:49.382864  / # /lava-3545827/bin/lava-test-runner /lav=
a-3545827/1<3>[   11.451638] Bluetooth: hci0: command 0x0c03 tx timeout
    2023-05-01T14:45:49.387281   =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644fcdc0f6b55f781c2e8601

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-376-g09ef89800103/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-376-g09ef89800103/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644fcdc0f6b55f781c2e8606
        failing since 32 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-01T14:33:23.865710  + set +x

    2023-05-01T14:33:23.872411  <8>[   14.233968] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10169175_1.4.2.3.1>

    2023-05-01T14:33:23.976792  / # #

    2023-05-01T14:33:24.077415  export SHELL=3D/bin/sh

    2023-05-01T14:33:24.077654  #

    2023-05-01T14:33:24.178256  / # export SHELL=3D/bin/sh. /lava-10169175/=
environment

    2023-05-01T14:33:24.178464  =


    2023-05-01T14:33:24.278993  / # . /lava-10169175/environment/lava-10169=
175/bin/lava-test-runner /lava-10169175/1

    2023-05-01T14:33:24.279301  =


    2023-05-01T14:33:24.283500  / # /lava-10169175/bin/lava-test-runner /la=
va-10169175/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644fcd3f0dd2c02e652e862a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-376-g09ef89800103/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-376-g09ef89800103/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644fcd3f0dd2c02e652e862f
        failing since 32 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-01T14:31:07.896657  <8>[   12.419969] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10169168_1.4.2.3.1>

    2023-05-01T14:31:07.899985  + set +x

    2023-05-01T14:31:08.001518  =


    2023-05-01T14:31:08.102088  / # #export SHELL=3D/bin/sh

    2023-05-01T14:31:08.102292  =


    2023-05-01T14:31:08.202809  / # export SHELL=3D/bin/sh. /lava-10169168/=
environment

    2023-05-01T14:31:08.203013  =


    2023-05-01T14:31:08.303515  / # . /lava-10169168/environment/lava-10169=
168/bin/lava-test-runner /lava-10169168/1

    2023-05-01T14:31:08.303789  =


    2023-05-01T14:31:08.308605  / # /lava-10169168/bin/lava-test-runner /la=
va-10169168/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644fd20c39b7966d562e8673

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-376-g09ef89800103/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-376-g09ef89800103/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644fd20c39b7966d562e8678
        failing since 89 days (last pass: v5.10.155-149-g63e308de12c9, firs=
t fail: v5.10.165-142-gc53eb88edf7e)

    2023-05-01T14:51:37.115787  [   16.015869] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3545920_1.5.2.4.1>
    2023-05-01T14:51:37.220568  =

    2023-05-01T14:51:37.220811  / # [   16.030602] rockchip-drm display-sub=
system: [drm] Cannot find any crtc or sizes
    2023-05-01T14:51:37.322289  #export SHELL=3D/bin/sh
    2023-05-01T14:51:37.322715  =

    2023-05-01T14:51:37.424130  / # export SHELL=3D/bin/sh. /lava-3545920/e=
nvironment
    2023-05-01T14:51:37.424720  =

    2023-05-01T14:51:37.526188  / # . /lava-3545920/environment/lava-354592=
0/bin/lava-test-runner /lava-3545920/1
    2023-05-01T14:51:37.526877  =

    2023-05-01T14:51:37.530481  / # /lava-3545920/bin/lava-test-runner /lav=
a-3545920/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/644fd2a3e311ebaea92e8606

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-376-g09ef89800103/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-376-g09ef89800103/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/644fd2a3e311ebaea92e860c
        failing since 48 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-01T14:54:22.125902  /lava-10169511/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/644fd2a3e311ebaea92e860d
        failing since 48 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-01T14:54:20.065733  <8>[   33.017279] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-05-01T14:54:21.090610  /lava-10169511/1/../bin/lava-test-case

    2023-05-01T14:54:21.100653  <8>[   34.053188] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644fd09e685b4437522e85ff

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-376-g09ef89800103/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-376-g09ef89800103/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644fd09e685b4437522e8604
        failing since 88 days (last pass: v5.10.165-139-gefb57ce0f880, firs=
t fail: v5.10.165-149-ge30e8271d674)

    2023-05-01T14:45:14.785404  <8>[    7.390754] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3545824_1.5.2.4.1>
    2023-05-01T14:45:14.890681  / # #
    2023-05-01T14:45:14.992519  export SHELL=3D/bin/sh
    2023-05-01T14:45:14.992886  #
    2023-05-01T14:45:15.094202  / # export SHELL=3D/bin/sh. /lava-3545824/e=
nvironment
    2023-05-01T14:45:15.094568  =

    2023-05-01T14:45:15.195929  / # . /lava-3545824/environment/lava-354582=
4/bin/lava-test-runner /lava-3545824/1
    2023-05-01T14:45:15.196559  =

    2023-05-01T14:45:15.216178  / # /lava-3545824/bin/lava-test-runner /lav=
a-3545824/1
    2023-05-01T14:45:15.304034  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
