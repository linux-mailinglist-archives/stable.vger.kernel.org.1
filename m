Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3786F9744
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 09:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjEGHKD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 03:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEGHKC (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 03:10:02 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928A614357
        for <stable@vger.kernel.org>; Sun,  7 May 2023 00:10:00 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ab13da70a3so33308935ad.1
        for <stable@vger.kernel.org>; Sun, 07 May 2023 00:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683443399; x=1686035399;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n3IJNwC3GNRCaYtlDmJoC5zLiVFu1HLhhY4Y3XhfRv4=;
        b=Gm2xOJ0CE/Sv+wPuMMh9UxhQy1h7Sb89wKdKIobmXoVkV72c1K4V8JYUGmIRTDQCGy
         rLJS5pqgTDXuAWnTrJTjRzDcbS2APvcK3UpZ0oFGTqT8NFcKgPvCSa0ZZEVxtZSlPGUl
         dNf7OY4f580s8ii71mgeVDJNIsL3J9RnOu+OfffjthwtEEwv7g1h9EK22rhp97MAiC/W
         RrCDWye/sbmh/KVdWkWPTjMNM8bNhJP/L9DE6Wa3wDHqO88RvzUHY5ik/tHn3GmH6Rc8
         Db9sgbOYHL9GoU0EBZQ3CO/xGL69dHDrnC/0F+oi4UsAkeCS/wKH/Y+96jQFhmCvLAtf
         wSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683443399; x=1686035399;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3IJNwC3GNRCaYtlDmJoC5zLiVFu1HLhhY4Y3XhfRv4=;
        b=BecgmgWaBA3gMrKy+rQ3WdpwptQGtbTQpCeE6OIwBEyrgaiVL/GjVCRuzr73Cad+61
         WnKoRGhFs4m2d/qPNLl9n92x+r38AiXiIeIEXba501+EBhG/xTHa8YRjhkgqay2XmGpv
         zCMUotyX39/gNSc6Hh3eueHHWBg5HErYgD+EhDrm6lWRl72zCn85YJiT0Cjmlsz1itpw
         +29FyEunNhz3HO4sEMKXIWAH9CHMDQYMs2N0JxzvpUKfjfSuDxi1FW8POyBFMPoO9W3g
         me4tRcWzjRUH7cvTwCKMETDSKJrGuMfGQ3hOvp+sMtmz/FA5U3ZK7DKk6TuN9WDXuFlR
         gXdg==
X-Gm-Message-State: AC+VfDwm7Ean71qgnQfwMPcaEn1apNJRnxF9quSHpGGpuzMgOljl2eMs
        V01fDDZACKGc8uIO4Pfd8tMm7Om8R6jlQzYM/i2Xzg==
X-Google-Smtp-Source: ACHHUZ5sv5LWD8llLMbrkAMs/h/DCuhu4OehvIWtoi0Nv+C4557fVHfEp/lbaWwK2N2vpJEvAT09Og==
X-Received: by 2002:a17:903:338e:b0:1a6:6fe3:df8d with SMTP id kb14-20020a170903338e00b001a66fe3df8dmr5743796plb.8.1683443399268;
        Sun, 07 May 2023 00:09:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902740500b001ab09f5ca61sm4634005pll.55.2023.05.07.00.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 00:09:58 -0700 (PDT)
Message-ID: <64574ec6.170a0220.574a6.89cc@mx.google.com>
Date:   Sun, 07 May 2023 00:09:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.176-634-gf5f2590456bc
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 158 runs,
 6 regressions (v5.10.176-634-gf5f2590456bc)
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

stable-rc/queue/5.10 baseline: 158 runs, 6 regressions (v5.10.176-634-gf5f2=
590456bc)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.176-634-gf5f2590456bc/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.176-634-gf5f2590456bc
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      f5f2590456bc6c672ed553f1e2c37c607fddda94 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6457170473101f54e92e86aa

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-634-gf5f2590456bc/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-634-gf5f2590456bc/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457170473101f54e92e86c8
        failing since 82 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-05-07T03:11:47.471446  <8>[   20.452623] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 420043_1.5.2.4.1>
    2023-05-07T03:11:47.581987  / # #
    2023-05-07T03:11:47.685008  export SHELL=3D/bin/sh
    2023-05-07T03:11:47.685915  #
    2023-05-07T03:11:47.787937  / # export SHELL=3D/bin/sh. /lava-420043/en=
vironment
    2023-05-07T03:11:47.788900  =

    2023-05-07T03:11:47.891039  / # . /lava-420043/environment/lava-420043/=
bin/lava-test-runner /lava-420043/1
    2023-05-07T03:11:47.892470  =

    2023-05-07T03:11:47.897171  / # /lava-420043/bin/lava-test-runner /lava=
-420043/1
    2023-05-07T03:11:48.005899  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64571870fae59959522e8612

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-634-gf5f2590456bc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-634-gf5f2590456bc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64571870fae59959522e8617
        failing since 37 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-07T03:17:56.046401  + set +x

    2023-05-07T03:17:56.052792  <8>[   15.087255] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10221835_1.4.2.3.1>

    2023-05-07T03:17:56.160655  / # #

    2023-05-07T03:17:56.263164  export SHELL=3D/bin/sh

    2023-05-07T03:17:56.263955  #

    2023-05-07T03:17:56.365497  / # export SHELL=3D/bin/sh. /lava-10221835/=
environment

    2023-05-07T03:17:56.366307  =


    2023-05-07T03:17:56.467932  / # . /lava-10221835/environment/lava-10221=
835/bin/lava-test-runner /lava-10221835/1

    2023-05-07T03:17:56.469236  =


    2023-05-07T03:17:56.474455  / # /lava-10221835/bin/lava-test-runner /la=
va-10221835/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64571833497008b87e2e8679

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-634-gf5f2590456bc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-634-gf5f2590456bc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64571833497008b87e2e867e
        failing since 37 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-07T03:16:50.243798  <8>[   10.120782] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10221813_1.4.2.3.1>

    2023-05-07T03:16:50.246713  + set +x

    2023-05-07T03:16:50.348640  /#

    2023-05-07T03:16:50.449693   # #export SHELL=3D/bin/sh

    2023-05-07T03:16:50.449979  =


    2023-05-07T03:16:50.550613  / # export SHELL=3D/bin/sh. /lava-10221813/=
environment

    2023-05-07T03:16:50.550895  =


    2023-05-07T03:16:50.651550  / # . /lava-10221813/environment/lava-10221=
813/bin/lava-test-runner /lava-10221813/1

    2023-05-07T03:16:50.652004  =


    2023-05-07T03:16:50.656679  / # /lava-10221813/bin/lava-test-runner /la=
va-10221813/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/645718ad746f660f7e2e8639

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-634-gf5f2590456bc/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-634-gf5f2590456bc/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/645718ad746f660f7e2e863f
        failing since 54 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-07T03:19:01.414908  /lava-10221879/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/645718ad746f660f7e2e8640
        failing since 54 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-07T03:18:59.355491  <8>[   33.088193] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-05-07T03:19:00.378127  /lava-10221879/1/../bin/lava-test-case

    2023-05-07T03:19:00.389093  <8>[   34.122547] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64571dd104c093804c2e85fe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-634-gf5f2590456bc/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-634-gf5f2590456bc/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64571dd104c093804c2e8603
        failing since 94 days (last pass: v5.10.165-139-gefb57ce0f880, firs=
t fail: v5.10.165-149-ge30e8271d674)

    2023-05-07T03:40:57.769994  / # #
    2023-05-07T03:40:57.871648  export SHELL=3D/bin/sh
    2023-05-07T03:40:57.872001  #
    2023-05-07T03:40:57.973359  / # export SHELL=3D/bin/sh. /lava-3558090/e=
nvironment
    2023-05-07T03:40:57.973711  =

    2023-05-07T03:40:58.075019  / # . /lava-3558090/environment/lava-355809=
0/bin/lava-test-runner /lava-3558090/1
    2023-05-07T03:40:58.075626  =

    2023-05-07T03:40:58.081363  / # /lava-3558090/bin/lava-test-runner /lav=
a-3558090/1
    2023-05-07T03:40:58.170232  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-07T03:40:58.170493  + cd /lava-3558090/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
