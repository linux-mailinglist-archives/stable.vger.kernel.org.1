Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD79702C33
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 14:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241485AbjEOMDu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 08:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241753AbjEOMD1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 08:03:27 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C47F189
        for <stable@vger.kernel.org>; Mon, 15 May 2023 05:02:16 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1addac3de73so28570545ad.1
        for <stable@vger.kernel.org>; Mon, 15 May 2023 05:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684152135; x=1686744135;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lMwcj5PMlhqYQGWX8QR3Zw6r2HfT34no9fBPI8gku8w=;
        b=UBrCO/GzwBKbQxAkKegkPi7YY+zKLS1H1DRfpi+IskjWt8MeLs4Rm3CitWINP1k0zz
         TAcWt1/XBOyuMr1lZZMfWcfL3AJtPV7iJj9rLRFJ16otC1h+X19QVGjwi7ZuqGH9wgtL
         QkVG3YGyuINpd/2ZE3ScNLe0oN5my5afDFPKAUGgSfskwZ7i7aVKr2ukeOJsC8yP+L/+
         8rayhinQxUUVfQThdH/sUiudKS7sz0E1ii75dcKBdTJYBvVdaRjbIq1dOTT4x5QjY6mM
         epKoNaBy0CWwoN6LnIfVMrhkrQacW1DjTVU/nAPk84uQyTbV1kkdZEQbqZeJfwsx3SI4
         l/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684152135; x=1686744135;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMwcj5PMlhqYQGWX8QR3Zw6r2HfT34no9fBPI8gku8w=;
        b=S6OSmjliP5aiqP0hCJzDFjltKezkF1R5kyw9A9wThf8G2FsMrGErs1igKZEGlay2xF
         j5S/VThJbfIZTFnuXuCwTAqRatzQzI4G0N+EMPyKU6cRrKGRYAwcIQU2GsXbfS1XI9So
         lwBFiZiD46bylQqxefSOLvG5+HDqh/f9fn9vbBv9TCcpsDTut08qZ4UdyjgbpWbueVj8
         G8iIR8Q0tEzzng8GzboB0ehKJWDFIWDkgwmcMIDA98zNG9eHL+4Y27ZwmA6DWWXU9nUn
         c851s2EDUhG4N/WFeIsMAeW1kNO3BeDA1E+VGgEs3E9Nz0CGWAxpEgho2PvhByEI71+B
         /rRA==
X-Gm-Message-State: AC+VfDwwRglHETCYlfmwZJ9ZHtvh5cgoXCcQ9OnVCSwee8xxmQFX2ILx
        SLkn4/tVt1JOdmyuOUugX+K3nXS5OKwGTkdh6k3YsQ==
X-Google-Smtp-Source: ACHHUZ4/N7y/IioWWEkrvkB3a9M5FPIUsvciOTHROA1zBdnn3kR31dmZh3TnTIpvK1ebrpMm1X/Gig==
X-Received: by 2002:a17:902:c40a:b0:1ab:1624:38cf with SMTP id k10-20020a170902c40a00b001ab162438cfmr51660088plk.60.1684152135208;
        Mon, 15 May 2023 05:02:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d2-20020a170903230200b001ac896ff667sm13332687plh.204.2023.05.15.05.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 05:02:14 -0700 (PDT)
Message-ID: <64621f46.170a0220.97830.9662@mx.google.com>
Date:   Mon, 15 May 2023 05:02:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.179-367-g5e75c5f5c701
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 169 runs,
 7 regressions (v5.10.179-367-g5e75c5f5c701)
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

stable-rc/queue/5.10 baseline: 169 runs, 7 regressions (v5.10.179-367-g5e75=
c5f5c701)

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
nel/v5.10.179-367-g5e75c5f5c701/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.179-367-g5e75c5f5c701
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      5e75c5f5c701f82251c4589ae64461b75a85d8a7 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6461ec195241097d8a2e85e6

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-367-g5e75c5f5c701/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-367-g5e75c5f5c701/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461ec195241097d8a2e8603
        failing since 90 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-05-15T08:23:34.408287  <8>[   20.388848] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 460433_1.5.2.4.1>
    2023-05-15T08:23:34.517372  / # #
    2023-05-15T08:23:34.619552  export SHELL=3D/bin/sh
    2023-05-15T08:23:34.620318  #
    2023-05-15T08:23:34.722098  / # export SHELL=3D/bin/sh. /lava-460433/en=
vironment
    2023-05-15T08:23:34.722890  =

    2023-05-15T08:23:34.824185  / # . /lava-460433/environment/lava-460433/=
bin/lava-test-runner /lava-460433/1
    2023-05-15T08:23:34.825001  =

    2023-05-15T08:23:34.828377  / # /lava-460433/bin/lava-test-runner /lava=
-460433/1
    2023-05-15T08:23:34.936382  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6461e8d21cb55f1dc62e8612

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-367-g5e75c5f5c701/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-367-g5e75c5f5c701/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461e8d21cb55f1dc62e8617
        failing since 108 days (last pass: v5.10.165-76-g5c2e982fcf18, firs=
t fail: v5.10.165-77-g4600242c13ed)

    2023-05-15T08:09:29.459942  #
    2023-05-15T08:09:29.563683  export SHELL=3D/bin/sh
    2023-05-15T08:09:29.564410  #
    2023-05-15T08:09:29.666166  / # export SHELL=3D/bin/sh. /lava-3591253/e=
nvironment
    2023-05-15T08:09:29.667131  =

    2023-05-15T08:09:29.769322  / # . /lava-3591253/environment/lava-359125=
3/bin/lava-test-runner /lava-3591253/1
    2023-05-15T08:09:29.770970  =

    2023-05-15T08:09:29.776335  / # /lava-3591253/bin/lava-test-runner /lav=
a-3591253/1
    2023-05-15T08:09:29.859753  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-15T08:09:29.865188  + cd /lava-3591253/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461eb90a8553406a32e8600

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-367-g5e75c5f5c701/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-367-g5e75c5f5c701/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461eb90a8553406a32e8605
        failing since 45 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-15T08:21:26.837798  + set +x

    2023-05-15T08:21:26.844185  <8>[   14.919727] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10319508_1.4.2.3.1>

    2023-05-15T08:21:26.948985  / # #

    2023-05-15T08:21:27.049535  export SHELL=3D/bin/sh

    2023-05-15T08:21:27.049697  #

    2023-05-15T08:21:27.150213  / # export SHELL=3D/bin/sh. /lava-10319508/=
environment

    2023-05-15T08:21:27.150386  =


    2023-05-15T08:21:27.250887  / # . /lava-10319508/environment/lava-10319=
508/bin/lava-test-runner /lava-10319508/1

    2023-05-15T08:21:27.251125  =


    2023-05-15T08:21:27.255870  / # /lava-10319508/bin/lava-test-runner /la=
va-10319508/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461eb8535ae6a954c2e8606

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-367-g5e75c5f5c701/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-367-g5e75c5f5c701/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461eb8535ae6a954c2e860b
        failing since 45 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-15T08:21:08.848592  + set +x

    2023-05-15T08:21:08.855324  <8>[   12.676879] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10319563_1.4.2.3.1>

    2023-05-15T08:21:08.960621  / # #

    2023-05-15T08:21:09.062767  export SHELL=3D/bin/sh

    2023-05-15T08:21:09.063426  #

    2023-05-15T08:21:09.164715  / # export SHELL=3D/bin/sh. /lava-10319563/=
environment

    2023-05-15T08:21:09.165404  =


    2023-05-15T08:21:09.266873  / # . /lava-10319563/environment/lava-10319=
563/bin/lava-test-runner /lava-10319563/1

    2023-05-15T08:21:09.267998  =


    2023-05-15T08:21:09.273044  / # /lava-10319563/bin/lava-test-runner /la=
va-10319563/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6461edbfa514ae30d82e85fe

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-367-g5e75c5f5c701/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-367-g5e75c5f5c701/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6461edbfa514ae30d82e8604
        failing since 62 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-15T08:30:35.481111  /lava-10319620/1/../bin/lava-test-case

    2023-05-15T08:30:35.492074  <8>[   62.103841] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6461edbfa514ae30d82e8605
        failing since 62 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-15T08:30:33.421759  <8>[   60.032666] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-05-15T08:30:34.444237  /lava-10319620/1/../bin/lava-test-case

    2023-05-15T08:30:34.455306  <8>[   61.066883] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6461e7fa261c47244d2e8671

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-367-g5e75c5f5c701/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-367-g5e75c5f5c701/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461e7fa261c47244d2e8676
        failing since 102 days (last pass: v5.10.165-139-gefb57ce0f880, fir=
st fail: v5.10.165-149-ge30e8271d674)

    2023-05-15T08:06:01.781368  / # #
    2023-05-15T08:06:01.883235  export SHELL=3D/bin/sh
    2023-05-15T08:06:01.883775  #
    2023-05-15T08:06:01.985181  / # export SHELL=3D/bin/sh. /lava-3591246/e=
nvironment
    2023-05-15T08:06:01.985736  =

    2023-05-15T08:06:02.086938  / # . /lava-3591246/environment/lava-359124=
6/bin/lava-test-runner /lava-3591246/1
    2023-05-15T08:06:02.087728  =

    2023-05-15T08:06:02.093046  / # /lava-3591246/bin/lava-test-runner /lav=
a-3591246/1
    2023-05-15T08:06:02.157225  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-15T08:06:02.191007  + cd /lava-3591246/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
