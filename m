Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79ECC6F9A37
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 18:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjEGQth (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 12:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEGQtg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 12:49:36 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D4D3C1B
        for <stable@vger.kernel.org>; Sun,  7 May 2023 09:49:34 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-51f1b6e8179so2436954a12.3
        for <stable@vger.kernel.org>; Sun, 07 May 2023 09:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683478174; x=1686070174;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OcgPrZ6D4+eR/jmNfPapgOBweaLq4RA61vodxmz1F94=;
        b=DXMKCnzhLkg7+/jIEZYUkdqp3QtjpP+GemevpXbk/49XvAAieDb2ZYfFIvtxMSd9W8
         PY9fPVMgJRyWNR2ERr119MnCrFMSmpHWf1XKdzDw8vlpL4kOmNwxtcQzn0VnFQVvS1lL
         nIaNM5UVVCyQGvwM63mcAJAYoU587aF5MSch/1jhTEwTkj1R6kU7UIDh+N30x2Q+zgC3
         DMvzI8R6th1QMyg7d0n7zkYqqfJaiDhIFdRT7vnZ3y6cnUM6CoxALK3lx7eOr8EPiBL/
         jkKZGXAX5tYdZB3DjmlpAV5g32bmBYPO47S6M17VqOCk4cQvk4f7u656c+aayid2NCEE
         I/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683478174; x=1686070174;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OcgPrZ6D4+eR/jmNfPapgOBweaLq4RA61vodxmz1F94=;
        b=UflSP3BubVjTkdgq/ygz4G62iirD4WYFy7Rl02iFOSUQtOruSR7M+3VxLcHHzhT+JZ
         kpuDAFLm9H5oIXSNR4SbM4HVC99VzuvIVuEgvu3z5JDytEZdJv0VuPoKsSIL/B2XXSvz
         s5mp8xxGnLv/j6vo0yFtm+e31r5ZORTHNeFkciwBjEpJ71lR7UWQ2Iwg6OcIfx/x7hc6
         3chHad4+aCWh46NB0NFMTGpjyH0UOkWoJVm8D1X6nrprrhv57xdgvMeMbnEnRDtT5MgZ
         3f0AgLYhRxnm4dhHo9d2XJdm6+CijPyMsCybHvExRf0ss21VsncH4zRafkVtdTyTFVo3
         xrag==
X-Gm-Message-State: AC+VfDwHeH3k0K0Rqv3DfXUNyF75BVRsUC+bQEVnWjNbeAZuWLY4I8DN
        Z7caFZlPV0kVYWwxBeReT1PMs3bT9DjiJHSNA1o7Vg==
X-Google-Smtp-Source: ACHHUZ41vBx8EJx8kXFitHaWA8crmSmaDalyAUEK5NgVmB5Tz4a+j5c6JjJ5Ll2GgMlD/qqlFjD4pw==
X-Received: by 2002:a05:6a20:2450:b0:f2:14f7:c1db with SMTP id t16-20020a056a20245000b000f214f7c1dbmr10366397pzc.59.1683478173718;
        Sun, 07 May 2023 09:49:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78e59000000b0063799398eaesm4601316pfr.51.2023.05.07.09.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 09:49:33 -0700 (PDT)
Message-ID: <6457d69d.a70a0220.610de.866f@mx.google.com>
Date:   Sun, 07 May 2023 09:49:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.176-642-gf5012685b6367
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 159 runs,
 5 regressions (v5.10.176-642-gf5012685b6367)
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

stable-rc/queue/5.10 baseline: 159 runs, 5 regressions (v5.10.176-642-gf501=
2685b6367)

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

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.176-642-gf5012685b6367/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.176-642-gf5012685b6367
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      f5012685b636710b612a43d3f7b9df64f9c7b57a =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6457a46659ae3817a12e85e7

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-642-gf5012685b6367/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-642-gf5012685b6367/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457a46659ae3817a12e861d
        failing since 82 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-05-07T13:14:51.926613  <8>[   19.991112] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 422873_1.5.2.4.1>
    2023-05-07T13:14:52.036204  / # #
    2023-05-07T13:14:52.139227  export SHELL=3D/bin/sh
    2023-05-07T13:14:52.139971  #
    2023-05-07T13:14:52.242071  / # export SHELL=3D/bin/sh. /lava-422873/en=
vironment
    2023-05-07T13:14:52.243148  =

    2023-05-07T13:14:52.345843  / # . /lava-422873/environment/lava-422873/=
bin/lava-test-runner /lava-422873/1
    2023-05-07T13:14:52.346978  =

    2023-05-07T13:14:52.351585  / # /lava-422873/bin/lava-test-runner /lava=
-422873/1
    2023-05-07T13:14:52.455672  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457a31e766df9db672e861e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-642-gf5012685b6367/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-642-gf5012685b6367/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457a31e766df9db672e8623
        failing since 38 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-07T13:09:40.013578  + set +x

    2023-05-07T13:09:40.019749  <8>[   10.346794] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10227311_1.4.2.3.1>

    2023-05-07T13:09:40.124721  / # #

    2023-05-07T13:09:40.225417  export SHELL=3D/bin/sh

    2023-05-07T13:09:40.225647  #

    2023-05-07T13:09:40.326189  / # export SHELL=3D/bin/sh. /lava-10227311/=
environment

    2023-05-07T13:09:40.326419  =


    2023-05-07T13:09:40.426985  / # . /lava-10227311/environment/lava-10227=
311/bin/lava-test-runner /lava-10227311/1

    2023-05-07T13:09:40.427323  =


    2023-05-07T13:09:40.431679  / # /lava-10227311/bin/lava-test-runner /la=
va-10227311/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6457a80a7728248d3a2e85f7

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-642-gf5012685b6367/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-642-gf5012685b6367/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6457a80a7728248d3a2e85fd
        failing since 54 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-07T13:30:43.037036  /lava-10227480/1/../bin/lava-test-case

    2023-05-07T13:30:43.048216  <8>[   35.071786] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6457a80a7728248d3a2e85fe
        failing since 54 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-07T13:30:40.975103  <8>[   32.998350] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-05-07T13:30:42.001362  /lava-10227480/1/../bin/lava-test-case

    2023-05-07T13:30:42.011799  <8>[   34.036069] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6457a18b4b4c36e9582e85f1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-642-gf5012685b6367/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-642-gf5012685b6367/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457a18b4b4c36e9582e85f6
        failing since 94 days (last pass: v5.10.165-139-gefb57ce0f880, firs=
t fail: v5.10.165-149-ge30e8271d674)

    2023-05-07T13:02:52.769342  =

    2023-05-07T13:02:52.870891  / # #export SHELL=3D/bin/sh
    2023-05-07T13:02:52.871421  =

    2023-05-07T13:02:52.972755  / # export SHELL=3D/bin/sh. /lava-3560493/e=
nvironment
    2023-05-07T13:02:52.973250  =

    2023-05-07T13:02:53.074660  / # . /lava-3560493/environment/lava-356049=
3/bin/lava-test-runner /lava-3560493/1
    2023-05-07T13:02:53.075477  =

    2023-05-07T13:02:53.080175  / # /lava-3560493/bin/lava-test-runner /lav=
a-3560493/1
    2023-05-07T13:02:53.183964  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-07T13:02:53.184370  + cd /lava-3560493/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
