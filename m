Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBB4713C52
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjE1TOU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjE1TOT (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:14:19 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379F0E3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:14:10 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64d41d8bc63so2087060b3a.0
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685301249; x=1687893249;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A+T2Bq/qurBdLq9qvjOinO7xTD+I/iEa1Od77PTXBbQ=;
        b=aXHqmgJXuMFxz1uJtHbtX6tXPONbVXt1P7dhMQ2yHVKppibQq6xUW9/7cWruJLKz4o
         IHOvUDhy4NgyO9fpmOuojqwi5vs8cEXG3uUUgNcI2H0rCfsK5mx+SIRbfRDZy2K8l54R
         hSiOZDPgqNukhO/fQzfsxTojXfQW6z+Nqfy4/0njA4ELJzm9KSQLXM3Ag+dvgylEx0IJ
         zpn4Z+9gTeoQ7p0xFcXUXX1t6P2rYfTMlGO6QhH3obNao3CdWcDicKBMUy71DNg5fpGL
         +mCepeCiKzsLI9NEQFCX6Uzluu/tkZYVgE2ImxyjhxiBSQ3b97ZiVqEkbRJoR921F0e4
         fCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685301249; x=1687893249;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+T2Bq/qurBdLq9qvjOinO7xTD+I/iEa1Od77PTXBbQ=;
        b=Mw4SlUxypViad5c38vfvs32hRdxI+5y77ogvHOuQ+IrQN+GVLy0LJIlwm95gn+nYK4
         9Wu10H+mGekWOfOMc4cn6pdUFZXpGlABXV/CrLt9PN0bkmwV5YxiHo4Ltchmz0evXhVX
         SZEysV1ulNj0hRIdjKDmcwHsPqUmyA7Gl4KkoZULpxCbbCH08wC9WXSHJxksCxaMNkq+
         e1ncqUiP6xHk20hCnQ/IOdWKnMa/Jm2k+zwoYqbuvd/GpQ+eNW7wshi0YO8MYlLoJmSw
         3R6qq7GyDc9KWVFVdM4UuUNoAUx1uxEdxoHxUzesga7D715zLIGzFefAltkKpKfXKVP0
         pR3A==
X-Gm-Message-State: AC+VfDwPxV2aSgwF8C5nQOaN/2qJwyudBTM16TBD18/i5Ky33jKMFwkX
        W/gvxl61VlZM7rtLLKDsKajJKPU59E/H2Cgb6Pjl4A==
X-Google-Smtp-Source: ACHHUZ7SQWvAw4y51tEVM5Uajvxls+Zw2J38+48kVKd29wWkiPOLD3IGpnEPZp/+dKn6CiuyTKyNmg==
X-Received: by 2002:a05:6a00:1595:b0:64f:a023:622d with SMTP id u21-20020a056a00159500b0064fa023622dmr14610364pfk.9.1685301249073;
        Sun, 28 May 2023 12:14:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u17-20020aa78491000000b0064cca73d911sm5485694pfn.103.2023.05.28.12.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 12:14:08 -0700 (PDT)
Message-ID: <6473a800.a70a0220.e3615.a52c@mx.google.com>
Date:   Sun, 28 May 2023 12:14:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.180-180-g09aae5ea7469
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 129 runs,
 7 regressions (v5.10.180-180-g09aae5ea7469)
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

stable-rc/queue/5.10 baseline: 129 runs, 7 regressions (v5.10.180-180-g09aa=
e5ea7469)

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
nel/v5.10.180-180-g09aae5ea7469/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.180-180-g09aae5ea7469
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      09aae5ea746998d966701c6044254b705351c6eb =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647371e8d5d660ad422e8607

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-180-g09aae5ea7469/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-180-g09aae5ea7469/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647371e8d5d660ad422e8639
        failing since 103 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-05-28T15:23:03.933157  <8>[   21.192849] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 525603_1.5.2.4.1>
    2023-05-28T15:23:04.040590  / # #
    2023-05-28T15:23:04.143379  export SHELL=3D/bin/sh
    2023-05-28T15:23:04.144129  #
    2023-05-28T15:23:04.245974  / # export SHELL=3D/bin/sh. /lava-525603/en=
vironment
    2023-05-28T15:23:04.246994  =

    2023-05-28T15:23:04.349100  / # . /lava-525603/environment/lava-525603/=
bin/lava-test-runner /lava-525603/1
    2023-05-28T15:23:04.350107  =

    2023-05-28T15:23:04.354556  / # /lava-525603/bin/lava-test-runner /lava=
-525603/1
    2023-05-28T15:23:04.452258  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6473721f65f52e53992e8686

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-180-g09aae5ea7469/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-180-g09aae5ea7469/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473721f65f52e53992e868b
        failing since 122 days (last pass: v5.10.165-76-g5c2e982fcf18, firs=
t fail: v5.10.165-77-g4600242c13ed)

    2023-05-28T15:23:55.075996  <8>[   11.037432] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3626691_1.5.2.4.1>
    2023-05-28T15:23:55.182932  / # #
    2023-05-28T15:23:55.284588  export SHELL=3D/bin/sh
    2023-05-28T15:23:55.285047  #
    2023-05-28T15:23:55.386328  / # export SHELL=3D/bin/sh. /lava-3626691/e=
nvironment
    2023-05-28T15:23:55.386817  =

    2023-05-28T15:23:55.387030  / # <3>[   11.291534] Bluetooth: hci0: comm=
and 0x0c03 tx timeout
    2023-05-28T15:23:55.488282  . /lava-3626691/environment/lava-3626691/bi=
n/lava-test-runner /lava-3626691/1
    2023-05-28T15:23:55.489001  =

    2023-05-28T15:23:55.493857  / # /lava-3626691/bin/lava-test-runner /lav=
a-3626691/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647370faafd5c771892e8601

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-180-g09aae5ea7469/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-180-g09aae5ea7469/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647370faafd5c771892e8606
        failing since 59 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-28T15:19:03.786359  + set +x

    2023-05-28T15:19:03.792828  <8>[   10.249239] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10494617_1.4.2.3.1>

    2023-05-28T15:19:03.897227  / # #

    2023-05-28T15:19:03.997859  export SHELL=3D/bin/sh

    2023-05-28T15:19:03.998040  #

    2023-05-28T15:19:04.098581  / # export SHELL=3D/bin/sh. /lava-10494617/=
environment

    2023-05-28T15:19:04.098764  =


    2023-05-28T15:19:04.199314  / # . /lava-10494617/environment/lava-10494=
617/bin/lava-test-runner /lava-10494617/1

    2023-05-28T15:19:04.199589  =


    2023-05-28T15:19:04.204421  / # /lava-10494617/bin/lava-test-runner /la=
va-10494617/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64737080bbb618cb072e85f7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-180-g09aae5ea7469/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-180-g09aae5ea7469/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64737080bbb618cb072e85fc
        failing since 59 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-28T15:17:02.888835  <8>[   13.350595] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10494613_1.4.2.3.1>

    2023-05-28T15:17:02.891744  + set +x

    2023-05-28T15:17:02.993949  =


    2023-05-28T15:17:03.094710  / # #export SHELL=3D/bin/sh

    2023-05-28T15:17:03.095020  =


    2023-05-28T15:17:03.195684  / # export SHELL=3D/bin/sh. /lava-10494613/=
environment

    2023-05-28T15:17:03.195992  =


    2023-05-28T15:17:03.296863  / # . /lava-10494613/environment/lava-10494=
613/bin/lava-test-runner /lava-10494613/1

    2023-05-28T15:17:03.297335  =


    2023-05-28T15:17:03.302640  / # /lava-10494613/bin/lava-test-runner /la=
va-10494613/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6473745813fe89921a2e8601

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-180-g09aae5ea7469/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-180-g09aae5ea7469/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6473745813fe89921a2e8607
        failing since 75 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-28T15:33:39.966883  /lava-10494719/1/../bin/lava-test-case

    2023-05-28T15:33:39.977826  <8>[   62.107941] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6473745813fe89921a2e8608
        failing since 75 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-28T15:33:37.909291  <8>[   60.037811] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-05-28T15:33:38.929503  /lava-10494719/1/../bin/lava-test-case

    2023-05-28T15:33:38.941275  <8>[   61.071160] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64737207c0f0d0b7e42e85e8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-180-g09aae5ea7469/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-180-g09aae5ea7469/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64737207c0f0d0b7e42e85ed
        failing since 115 days (last pass: v5.10.165-139-gefb57ce0f880, fir=
st fail: v5.10.165-149-ge30e8271d674)

    2023-05-28T15:23:26.629429  / # #
    2023-05-28T15:23:26.731132  export SHELL=3D/bin/sh
    2023-05-28T15:23:26.731495  #
    2023-05-28T15:23:26.832817  / # export SHELL=3D/bin/sh. /lava-3626683/e=
nvironment
    2023-05-28T15:23:26.833203  =

    2023-05-28T15:23:26.934546  / # . /lava-3626683/environment/lava-362668=
3/bin/lava-test-runner /lava-3626683/1
    2023-05-28T15:23:26.935291  =

    2023-05-28T15:23:26.940622  / # /lava-3626683/bin/lava-test-runner /lav=
a-3626683/1
    2023-05-28T15:23:27.004748  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-28T15:23:27.052502  + cd /lava-3626683/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
