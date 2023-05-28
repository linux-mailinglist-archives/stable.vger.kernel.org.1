Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAD6713966
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 14:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjE1MNP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 08:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1MNO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 08:13:14 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C959B6
        for <stable@vger.kernel.org>; Sun, 28 May 2023 05:13:12 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5289ce6be53so2531639a12.0
        for <stable@vger.kernel.org>; Sun, 28 May 2023 05:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685275991; x=1687867991;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dfov670GHFmjTaGtC/WzoRNuWiwysiuC0isXTxW+Fq8=;
        b=yEoWO00SOnUE2WXb9AHB4R/2WpyCeJGtzBH2M8/Ot5VUsROVB7fuIeVPLlPQwDeDGY
         M+VdPK393uvMGf7ajSm6cf3mra79PCj3CgCJNVhlJJOgk3275RrCizhep6gYJedcdinA
         rhDSdRzuMEKba+R37DZgU9CdXOde80ZyM2qT8xng7qLF3NpovDgSMNUQb4FH7QIjP2sn
         Vkz1Jg/MeQomu4sCN+YP1iowRqE+RflEZghldnA1Is9Rg/JetA9M7t8KcMDio8tlC2pB
         vVPrStaVQZ8fQbFvohJ/otnlFrSqvSUsWsJy4f9oqfNiXt7QoL3WxRCtIpZ5ak2AV8oB
         9GcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685275991; x=1687867991;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dfov670GHFmjTaGtC/WzoRNuWiwysiuC0isXTxW+Fq8=;
        b=gMBYllBGk6wKwAChc0ElR8pbkByUfPZqe/50wAoyRWGh6IUylk/w8vCBAnKaGsGMd3
         FupzolNrcJTr/jdBRzG3Qu2al7pLTHoURuDQrcKsBgVY6FQryjJwEm4RRAShyw7Wp30O
         lRsp8eZ53NOwZ1oiLi3+HCyvGcoeOpe0U/2qLvWuGhibSdiTVj6LUiubTPwtdUrM0r4V
         Ms+5KrZyNfIESQVgEIub2DkflqgRRsV+YJGJdlviA7gDXuxnuA2aJQw1mc8vfI1C7kPC
         BsADCzgeQhem3MKV6Dle/F7vAQtCenZCZgaNuhL1vTjnesgvYDo8ErkZjfmD3ub2zgcC
         WBtg==
X-Gm-Message-State: AC+VfDzGYz+NeWWlh3/BIotNEkBYMZLpeROO5dAlMqtE7JSeeHTK68cF
        uLmYgirSiXNHwHGrt/+FnELbR4cGxZAaJwDjSJw=
X-Google-Smtp-Source: ACHHUZ7TEUcr/pVltvxIHcBjsPFpA5x8Kkc/avJ68YluXhB3ersLo9tIMPj/dxORq057ZLY9KgCD+g==
X-Received: by 2002:a17:902:e850:b0:1ae:89a:a4 with SMTP id t16-20020a170902e85000b001ae089a00a4mr5788846plg.8.1685275991329;
        Sun, 28 May 2023 05:13:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n5-20020a170902d2c500b001ac68a87255sm2679331plc.93.2023.05.28.05.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 05:13:10 -0700 (PDT)
Message-ID: <64734556.170a0220.f46e9.4910@mx.google.com>
Date:   Sun, 28 May 2023 05:13:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.180-174-g7654555b7d34
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 170 runs,
 7 regressions (v5.10.180-174-g7654555b7d34)
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

stable-rc/queue/5.10 baseline: 170 runs, 7 regressions (v5.10.180-174-g7654=
555b7d34)

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
nel/v5.10.180-174-g7654555b7d34/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.180-174-g7654555b7d34
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      7654555b7d3475b893fb19dbd7fff9fcb23bd8e6 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64730f3a6a70a2bb152e85f6

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-174-g7654555b7d34/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-174-g7654555b7d34/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64730f3a6a70a2bb152e862b
        failing since 103 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-05-28T08:22:00.772536  <8>[   19.066180] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 523970_1.5.2.4.1>
    2023-05-28T08:22:00.883344  / # #
    2023-05-28T08:22:00.986623  export SHELL=3D/bin/sh
    2023-05-28T08:22:00.987251  #
    2023-05-28T08:22:01.089210  / # export SHELL=3D/bin/sh. /lava-523970/en=
vironment
    2023-05-28T08:22:01.090106  =

    2023-05-28T08:22:01.192186  / # . /lava-523970/environment/lava-523970/=
bin/lava-test-runner /lava-523970/1
    2023-05-28T08:22:01.193413  =

    2023-05-28T08:22:01.197721  / # /lava-523970/bin/lava-test-runner /lava=
-523970/1
    2023-05-28T08:22:01.294136  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64730ed2a1528f7afc2e861f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-174-g7654555b7d34/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-174-g7654555b7d34/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64730ed2a1528f7afc2e8624
        failing since 121 days (last pass: v5.10.165-76-g5c2e982fcf18, firs=
t fail: v5.10.165-77-g4600242c13ed)

    2023-05-28T08:20:10.496324  + set +x<8>[   11.110520] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3625374_1.5.2.4.1>
    2023-05-28T08:20:10.496826  =

    2023-05-28T08:20:10.606471  / # #
    2023-05-28T08:20:10.709582  export SHELL=3D/bin/sh
    2023-05-28T08:20:10.710475  #
    2023-05-28T08:20:10.812419  / # export SHELL=3D/bin/sh. /lava-3625374/e=
nvironment
    2023-05-28T08:20:10.813365  =

    2023-05-28T08:20:10.813817  / # <3>[   11.371586] Bluetooth: hci0: comm=
and 0x0c03 tx timeout
    2023-05-28T08:20:10.915840  . /lava-3625374/environment/lava-3625374/bi=
n/lava-test-runner /lava-3625374/1
    2023-05-28T08:20:10.917356   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64730ceb63f3411e442e8626

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-174-g7654555b7d34/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-174-g7654555b7d34/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64730ceb63f3411e442e862b
        failing since 58 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-28T08:12:14.323465  + <8>[   10.301812] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10490590_1.4.2.3.1>

    2023-05-28T08:12:14.323541  set +x

    2023-05-28T08:12:14.424696  #

    2023-05-28T08:12:14.424944  =


    2023-05-28T08:12:14.525494  / # #export SHELL=3D/bin/sh

    2023-05-28T08:12:14.525672  =


    2023-05-28T08:12:14.626129  / # export SHELL=3D/bin/sh. /lava-10490590/=
environment

    2023-05-28T08:12:14.626296  =


    2023-05-28T08:12:14.726790  / # . /lava-10490590/environment/lava-10490=
590/bin/lava-test-runner /lava-10490590/1

    2023-05-28T08:12:14.727041  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64730ce463f3411e442e860b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-174-g7654555b7d34/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-174-g7654555b7d34/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64730ce463f3411e442e8610
        failing since 58 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-28T08:12:08.432523  <8>[   15.833835] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10490650_1.4.2.3.1>

    2023-05-28T08:12:08.435608  + set +x

    2023-05-28T08:12:08.537573  #

    2023-05-28T08:12:08.537971  =


    2023-05-28T08:12:08.638723  / # #export SHELL=3D/bin/sh

    2023-05-28T08:12:08.638984  =


    2023-05-28T08:12:08.739603  / # export SHELL=3D/bin/sh. /lava-10490650/=
environment

    2023-05-28T08:12:08.739862  =


    2023-05-28T08:12:08.840509  / # . /lava-10490650/environment/lava-10490=
650/bin/lava-test-runner /lava-10490650/1

    2023-05-28T08:12:08.840949  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6473155c746e4b0c722e8668

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-174-g7654555b7d34/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-174-g7654555b7d34/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6473155c746e4b0c722e866e
        failing since 75 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-28T08:48:10.360606  /lava-10490933/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6473155c746e4b0c722e866f
        failing since 75 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-28T08:48:09.324788  /lava-10490933/1/../bin/lava-test-case

    2023-05-28T08:48:09.335181  <8>[   61.015666] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64730ea85d4dac92442e85fe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-174-g7654555b7d34/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-174-g7654555b7d34/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64730ea85d4dac92442e8603
        failing since 115 days (last pass: v5.10.165-139-gefb57ce0f880, fir=
st fail: v5.10.165-149-ge30e8271d674)

    2023-05-28T08:19:28.721324  / # #
    2023-05-28T08:19:28.823064  export SHELL=3D/bin/sh
    2023-05-28T08:19:28.823440  #
    2023-05-28T08:19:28.924773  / # export SHELL=3D/bin/sh. /lava-3625366/e=
nvironment
    2023-05-28T08:19:28.925155  =

    2023-05-28T08:19:29.026614  / # . /lava-3625366/environment/lava-362536=
6/bin/lava-test-runner /lava-3625366/1
    2023-05-28T08:19:29.027436  =

    2023-05-28T08:19:29.032282  / # /lava-3625366/bin/lava-test-runner /lav=
a-3625366/1
    2023-05-28T08:19:29.131316  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-28T08:19:29.131851  + cd /lava-3625366/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
