Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3050D717468
	for <lists+stable@lfdr.de>; Wed, 31 May 2023 05:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjEaDdH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 23:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbjEaDdB (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 23:33:01 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA4D133
        for <stable@vger.kernel.org>; Tue, 30 May 2023 20:32:54 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b065154b79so3751085ad.1
        for <stable@vger.kernel.org>; Tue, 30 May 2023 20:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685503974; x=1688095974;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G4cRlk1v2Hzz1OmOPSuyn57GLYCT8uCKQPmdkIaYFh4=;
        b=Sgja823tX/tGL138RRz2V26SXZd1+fqAEUPgnCcu9fgrJaGovN8T80fBdN0NFUTPrH
         859BMmcfJgATBssbxqEihr0h+Tp6U/NURcSWdU4k1umBFaSUd/nuMspB1gqzlk8i4lIw
         YUz998VcJlCj2xeAYTy30TDnkISFPKxjENtjwm5oOj+UV36w9INfdzMy1sOGRQTyMI8a
         JGbpu7mgX4JGc+jrakpd7y0DyECvvGNpzdogqhsljkJen0dPX9LrtzJDsw9yckcmjWch
         xQMsAIO/3Xlz/nXX74o+/VOfUEB3AsjYH+0E6CSkkTcbl9byQQMOpIYMczs5WB9/+2V3
         SB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685503974; x=1688095974;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G4cRlk1v2Hzz1OmOPSuyn57GLYCT8uCKQPmdkIaYFh4=;
        b=YyPZNAx3bXnE0me3uUOBcr8IYqJwBLMOJwxxLnT7RjydD7usEoI4DsnhU6cpi9nlJK
         EtHdGhQrBmDeN6UbZiSN9tlz1dnEG5vxGO8TFy46ygGjVsAnTN9/7lsxrQVwFiYU+Xpr
         zkOPtlFGgbRobNj9PIL0jMA/0yjlmcidskYeZ0XD4kkb8KJGjk2+uyPTEcQFAxyr3phD
         /0p4tZZblP1MLVIHTbw0YJqR1spberFSXo05RFmSIc2uIaZmagr8Y3+MgnHeuWh+Lyjq
         kAgvVA6BotaCIvrusmos4MQtDw7PAoS86i3ViHqIPmuKsgaLJ5TotktoYIJhhTtYmCuK
         Kkhw==
X-Gm-Message-State: AC+VfDx6EC4W1JgPn2y+3E6TKVL59uud/42zKBdF6vhLEX+KGzKtDEKS
        6KdmGc8QicfFPDaQ4nOJ5xqXxavgj1H7w7EICF+SoQ==
X-Google-Smtp-Source: ACHHUZ7WN4wBJSob5NsI5Td8EJ91d+GleWUDWMqQqlNKTgteH7nn6FY8kSmVI0aulln1onrQksQg0g==
X-Received: by 2002:a17:902:daca:b0:1ad:d542:6e14 with SMTP id q10-20020a170902daca00b001add5426e14mr5200068plx.12.1685503973533;
        Tue, 30 May 2023 20:32:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id iy21-20020a170903131500b001ae365072cfsm76420plb.219.2023.05.30.20.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 20:32:52 -0700 (PDT)
Message-ID: <6476bfe4.170a0220.ca2f4.02b3@mx.google.com>
Date:   Tue, 30 May 2023 20:32:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.181-18-g1622068b57a4
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 160 runs,
 7 regressions (v5.10.181-18-g1622068b57a4)
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

stable-rc/queue/5.10 baseline: 160 runs, 7 regressions (v5.10.181-18-g16220=
68b57a4)

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
nel/v5.10.181-18-g1622068b57a4/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.181-18-g1622068b57a4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      1622068b57a485063ebaed5f8c83a95c0950887b =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64768d5a34a82ee8172e8605

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.181=
-18-g1622068b57a4/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beagl=
ebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.181=
-18-g1622068b57a4/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beagl=
ebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64768d5a34a82ee8172e863b
        failing since 106 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-05-30T23:56:54.814568  <8>[   20.175084] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 540760_1.5.2.4.1>
    2023-05-30T23:56:54.924792  / # #
    2023-05-30T23:56:55.027338  export SHELL=3D/bin/sh
    2023-05-30T23:56:55.028080  #
    2023-05-30T23:56:55.130121  / # export SHELL=3D/bin/sh. /lava-540760/en=
vironment
    2023-05-30T23:56:55.130812  =

    2023-05-30T23:56:55.233238  / # . /lava-540760/environment/lava-540760/=
bin/lava-test-runner /lava-540760/1
    2023-05-30T23:56:55.234385  =

    2023-05-30T23:56:55.239060  / # /lava-540760/bin/lava-test-runner /lava=
-540760/1
    2023-05-30T23:56:55.338930  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64768f1f31de1a22842e85e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.181=
-18-g1622068b57a4/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubie=
truck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.181=
-18-g1622068b57a4/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubie=
truck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64768f1f31de1a22842e85eb
        failing since 124 days (last pass: v5.10.165-76-g5c2e982fcf18, firs=
t fail: v5.10.165-77-g4600242c13ed)

    2023-05-31T00:04:38.160340  <8>[   11.193433] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3632775_1.5.2.4.1>
    2023-05-31T00:04:38.270850  / # #
    2023-05-31T00:04:38.374696  export SHELL=3D/bin/sh
    2023-05-31T00:04:38.375912  #
    2023-05-31T00:04:38.478559  / # export SHELL=3D/bin/sh. /lava-3632775/e=
nvironment
    2023-05-31T00:04:38.479768  =

    2023-05-31T00:04:38.582636  / # . /lava-3632775/environment/lava-363277=
5/bin/lava-test-runner /lava-3632775/1
    2023-05-31T00:04:38.584587  =

    2023-05-31T00:04:38.585116  / # /lava-3632775/bin/lava-test-runner /lav=
a-3632775/1<3>[   11.611359] Bluetooth: hci0: command 0x0c03 tx timeout
    2023-05-31T00:04:38.588934   =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647689e4651b88b33a2e85fd

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.181=
-18-g1622068b57a4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.181=
-18-g1622068b57a4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647689e4651b88b33a2e8602
        failing since 61 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-30T23:42:20.723089  + <8>[   14.902700] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10534354_1.4.2.3.1>

    2023-05-30T23:42:20.723172  set +x

    2023-05-30T23:42:20.825102  =


    2023-05-30T23:42:20.925661  / # #export SHELL=3D/bin/sh

    2023-05-30T23:42:20.925874  =


    2023-05-30T23:42:21.026358  / # export SHELL=3D/bin/sh. /lava-10534354/=
environment

    2023-05-30T23:42:21.026588  =


    2023-05-30T23:42:21.127079  / # . /lava-10534354/environment/lava-10534=
354/bin/lava-test-runner /lava-10534354/1

    2023-05-30T23:42:21.127423  =


    2023-05-30T23:42:21.131980  / # /lava-10534354/bin/lava-test-runner /la=
va-10534354/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647689e6bcd6d8e4cd2e8623

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.181=
-18-g1622068b57a4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.181=
-18-g1622068b57a4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647689e6bcd6d8e4cd2e8628
        failing since 61 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-30T23:42:09.545245  <8>[   13.615874] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10534389_1.4.2.3.1>

    2023-05-30T23:42:09.548466  + set +x

    2023-05-30T23:42:09.650019  #

    2023-05-30T23:42:09.650335  =


    2023-05-30T23:42:09.750995  / # #export SHELL=3D/bin/sh

    2023-05-30T23:42:09.751243  =


    2023-05-30T23:42:09.851751  / # export SHELL=3D/bin/sh. /lava-10534389/=
environment

    2023-05-30T23:42:09.852031  =


    2023-05-30T23:42:09.952702  / # . /lava-10534389/environment/lava-10534=
389/bin/lava-test-runner /lava-10534389/1

    2023-05-30T23:42:09.953147  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64768e5a8ce17346052e85fb

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.181=
-18-g1622068b57a4/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.181=
-18-g1622068b57a4/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64768e5a8ce17346052e8601
        failing since 77 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-31T00:01:10.083501  /lava-10534489/1/../bin/lava-test-case

    2023-05-31T00:01:10.093788  <8>[   34.909834] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64768e5a8ce17346052e8602
        failing since 77 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-31T00:01:08.021923  <8>[   32.836327] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-05-31T00:01:09.046937  /lava-10534489/1/../bin/lava-test-case

    2023-05-31T00:01:09.058645  <8>[   33.874551] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64768f05d3b17ae36b2e868b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.181=
-18-g1622068b57a4/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i=
-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.181=
-18-g1622068b57a4/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i=
-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64768f05d3b17ae36b2e8690
        failing since 118 days (last pass: v5.10.165-139-gefb57ce0f880, fir=
st fail: v5.10.165-149-ge30e8271d674)

    2023-05-31T00:04:07.766955  / # #
    2023-05-31T00:04:07.868927  export SHELL=3D/bin/sh
    2023-05-31T00:04:07.869492  #
    2023-05-31T00:04:07.970866  / # export SHELL=3D/bin/sh. /lava-3632761/e=
nvironment
    2023-05-31T00:04:07.971447  =

    2023-05-31T00:04:08.072887  / # . /lava-3632761/environment/lava-363276=
1/bin/lava-test-runner /lava-3632761/1
    2023-05-31T00:04:08.073724  =

    2023-05-31T00:04:08.094246  / # /lava-3632761/bin/lava-test-runner /lav=
a-3632761/1
    2023-05-31T00:04:08.142281  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-31T00:04:08.189150  + cd /lava-3632761/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
