Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562EF716890
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 18:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjE3QDJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 12:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbjE3QDI (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 12:03:08 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CAF10E
        for <stable@vger.kernel.org>; Tue, 30 May 2023 09:02:30 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b0314f057cso20641655ad.1
        for <stable@vger.kernel.org>; Tue, 30 May 2023 09:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685462543; x=1688054543;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6WakNBGU4fauwcIqmc+KfaJ8kPhqeuA2UTDF9/1umU=;
        b=klOHCUyO+kkZzBYXLYBsFNVO2mt4EtE15/MGmWCgiU5NOyGSjCseAy7mLm0Unwcacm
         L35UHbwCXhVNR7fb95th7dDHpR1VsD1oGkq3r1QxOjMNHR5odzAs/We/Hpnmu1TDfW8o
         0GwbE70Vp0DY80IQcvnEawgBt6n5/2Mgnu9ciiRhEsUMgk0sg6PBxFdTjETwNBFdqQFs
         ZA41t0qAtbwhBA/mbXaiHQ5B5o1DANfm8OKO0d+iIHH/MKwDRhbFfv7wVPFGSwT/b2bc
         GbAhVgDKqkymp8thsbNh7epc0VtrXqVnJ5HcKX9llgC3W3vz2C+VKA9DC/hAnX5rpu4i
         jpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685462543; x=1688054543;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z6WakNBGU4fauwcIqmc+KfaJ8kPhqeuA2UTDF9/1umU=;
        b=NAbtlHUktRbafL/JPyJUUgQ9czfOCHyR6/lOPnmlj/8vnCPLyYL/HWkXag9bDXaGnn
         5MfC2xWj5b57ojmaXUzWpUsryw5gJ1NHA502h8JeyTZN/ppuPUejtyYvqUt09LpN+ggG
         DCajHCrt77xGKYlN1k5h3hVU4hMTjF4o1HNNRInsLs/H0CCCQSs6MFG0Xc0Dsy+qnt+c
         Dm7aqld5axLwWEOJ26zGb7tFKF5R/R39gjSdnGcSu5pj+i3xfRDT/+6Vi9dWGeVh+5GG
         r0fUXagdqKA3500jfZz9mXEIJ7VEx8xkHhpriq4IT748dTWaiDquEt/59vL2sfK5uL9m
         EnSA==
X-Gm-Message-State: AC+VfDz6xemAINDDK+vkytSVl3CpCWfkUp6XFqkgGVRBWtUC3joDalO+
        c/MuIwdR0hiV5FF0f09A+3k5qVmndXvxobr27KFi9g==
X-Google-Smtp-Source: ACHHUZ41YAt/zOGel6zNmsILFTDzS2JNkjeD5DSdpCGlsBPOgvEMRl6k4xwuFJZTf10x+NDu5H0x5A==
X-Received: by 2002:a17:903:245:b0:1ae:6290:26d with SMTP id j5-20020a170903024500b001ae6290026dmr2983582plh.7.1685462542931;
        Tue, 30 May 2023 09:02:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902d30500b001b04a6707d3sm3582964plc.141.2023.05.30.09.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 09:02:22 -0700 (PDT)
Message-ID: <64761e0e.170a0220.28e72.6381@mx.google.com>
Date:   Tue, 30 May 2023 09:02:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.180-211-gbaf33ae31f24
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 154 runs,
 7 regressions (v5.10.180-211-gbaf33ae31f24)
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

stable-rc/queue/5.10 baseline: 154 runs, 7 regressions (v5.10.180-211-gbaf3=
3ae31f24)

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
nel/v5.10.180-211-gbaf33ae31f24/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.180-211-gbaf33ae31f24
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      baf33ae31f24130f76be1e1a88779b216f58143e =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6475ea0af0af91bf7c2e85fa

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-gbaf33ae31f24/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-gbaf33ae31f24/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6475ea0af0af91bf7c2e8625
        failing since 105 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-05-30T12:20:04.752875  + set +x
    2023-05-30T12:20:04.756036  <8>[   19.563869] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 534806_1.5.2.4.1>
    2023-05-30T12:20:04.866229  / # #
    2023-05-30T12:20:04.967998  export SHELL=3D/bin/sh
    2023-05-30T12:20:04.968756  #
    2023-05-30T12:20:05.070745  / # export SHELL=3D/bin/sh. /lava-534806/en=
vironment
    2023-05-30T12:20:05.071405  =

    2023-05-30T12:20:05.173629  / # . /lava-534806/environment/lava-534806/=
bin/lava-test-runner /lava-534806/1
    2023-05-30T12:20:05.174543  =

    2023-05-30T12:20:05.178067  / # /lava-534806/bin/lava-test-runner /lava=
-534806/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6475ec4ee27e17195c2e85ed

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-gbaf33ae31f24/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-gbaf33ae31f24/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6475ec4ee27e17195c2e85f2
        failing since 124 days (last pass: v5.10.165-76-g5c2e982fcf18, firs=
t fail: v5.10.165-77-g4600242c13ed)

    2023-05-30T12:29:52.715077  + set +x
    2023-05-30T12:29:52.723856  <8>[   11.023154] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3631090_1.5.2.4.1>
    2023-05-30T12:29:52.835327  / # #
    2023-05-30T12:29:52.939777  export SHELL=3D/bin/sh
    2023-05-30T12:29:52.941086  #
    2023-05-30T12:29:53.043802  / # export SHELL=3D/bin/sh. /lava-3631090/e=
nvironment
    2023-05-30T12:29:53.045147  =

    2023-05-30T12:29:53.045773  / # <3>[   11.291949] Bluetooth: hci0: comm=
and 0xfc18 tx timeout
    2023-05-30T12:29:53.148499  . /lava-3631090/environment/lava-3631090/bi=
n/lava-test-runner /lava-3631090/1
    2023-05-30T12:29:53.150496   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6475eb9004d7395ed22e85e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-gbaf33ae31f24/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-gbaf33ae31f24/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6475eb9004d7395ed22e85ec
        failing since 61 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-30T12:26:42.468026  + <8>[   14.683309] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10523853_1.4.2.3.1>

    2023-05-30T12:26:42.468431  set +x

    2023-05-30T12:26:42.573512  =


    2023-05-30T12:26:42.674383  / # #export SHELL=3D/bin/sh

    2023-05-30T12:26:42.675017  =


    2023-05-30T12:26:42.776382  / # export SHELL=3D/bin/sh. /lava-10523853/=
environment

    2023-05-30T12:26:42.777040  =


    2023-05-30T12:26:42.878436  / # . /lava-10523853/environment/lava-10523=
853/bin/lava-test-runner /lava-10523853/1

    2023-05-30T12:26:42.879554  =


    2023-05-30T12:26:42.884162  / # /lava-10523853/bin/lava-test-runner /la=
va-10523853/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6475eb7a5f3042c0352e8601

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-gbaf33ae31f24/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-gbaf33ae31f24/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6475eb7a5f3042c0352e8606
        failing since 61 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-30T12:26:21.691328  + set +x<8>[   12.721609] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10523825_1.4.2.3.1>

    2023-05-30T12:26:21.691414  =


    2023-05-30T12:26:21.793192  /#

    2023-05-30T12:26:21.894199   # #export SHELL=3D/bin/sh

    2023-05-30T12:26:21.894548  =


    2023-05-30T12:26:21.995304  / # export SHELL=3D/bin/sh. /lava-10523825/=
environment

    2023-05-30T12:26:21.995525  =


    2023-05-30T12:26:22.096055  / # . /lava-10523825/environment/lava-10523=
825/bin/lava-test-runner /lava-10523825/1

    2023-05-30T12:26:22.096378  =


    2023-05-30T12:26:22.101671  / # /lava-10523825/bin/lava-test-runner /la=
va-10523825/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6475ec0e85d5e29ca42e85e6

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-gbaf33ae31f24/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-gbaf33ae31f24/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6475ec0e85d5e29ca42e85ec
        failing since 77 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-30T12:28:53.763623  /lava-10523916/1/../bin/lava-test-case

    2023-05-30T12:28:53.774879  <8>[   33.227695] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6475ec0e85d5e29ca42e85ed
        failing since 77 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-30T12:28:52.727407  /lava-10523916/1/../bin/lava-test-case

    2023-05-30T12:28:52.738311  <8>[   32.192294] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6475ec3bf034ca4ea12e8610

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-gbaf33ae31f24/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-211-gbaf33ae31f24/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6475ec3bf034ca4ea12e8615
        failing since 117 days (last pass: v5.10.165-139-gefb57ce0f880, fir=
st fail: v5.10.165-149-ge30e8271d674)

    2023-05-30T12:29:25.913934  / # #
    2023-05-30T12:29:26.015582  export SHELL=3D/bin/sh
    2023-05-30T12:29:26.015935  #
    2023-05-30T12:29:26.117263  / # export SHELL=3D/bin/sh. /lava-3631096/e=
nvironment
    2023-05-30T12:29:26.117616  =

    2023-05-30T12:29:26.218949  / # . /lava-3631096/environment/lava-363109=
6/bin/lava-test-runner /lava-3631096/1
    2023-05-30T12:29:26.219552  =

    2023-05-30T12:29:26.225405  / # /lava-3631096/bin/lava-test-runner /lav=
a-3631096/1
    2023-05-30T12:29:26.324363  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-30T12:29:26.324864  + cd /lava-3631096/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
