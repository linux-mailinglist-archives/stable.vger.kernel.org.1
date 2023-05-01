Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185C66F2EA2
	for <lists+stable@lfdr.de>; Mon,  1 May 2023 07:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjEAFt6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 1 May 2023 01:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjEAFt4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 1 May 2023 01:49:56 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00224E55
        for <stable@vger.kernel.org>; Sun, 30 Apr 2023 22:49:54 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b733fd00bso1550727b3a.0
        for <stable@vger.kernel.org>; Sun, 30 Apr 2023 22:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682920194; x=1685512194;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IVOElu+/8n2IedZoSmmwhVz4vyjcEMXoAnbuetZd6ko=;
        b=g1p4qMd8CcNvSO+nu+hprkC95wMww/oiU2X2dX/xZAjxD6xnnl/OA/mPmBu23poa+t
         RGq2HmNxph17Y4mgQvPLmnGTBvPQCBAf5OkJFajxCyuuStNUv8mqNXo4CSODIgDkndE/
         ahrmkUcCu/owWyi0y76rMB7P21BC5hsISgJVtt807yz+vTD4gp3RrIpBLmVgcI+HxwkR
         cFO84yBW5Op4K1VbTbK15W+8Qyzfr5LVfiekSDn0NKDgrpnpZyZPcbQE0QWPoWbaoaO3
         xE2nW5c+n+xZSTwmOjPSVwF1NVIk1x/dLmKOauWQQ+ai1eRiK+uTLJopjY4Z6FXzbiGN
         c6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682920194; x=1685512194;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVOElu+/8n2IedZoSmmwhVz4vyjcEMXoAnbuetZd6ko=;
        b=TXWcBJGRLtld0tQyeKbF8RuDjjaDSEIEAop9osiYH0L0Cpj6V1IeKvO0Lq9lUJmckP
         a/aCs9/rOuy1ctk5xYT7W8ahmq+1nHvncKVbssfc6em8y5/+Ms2yXR6+FXRgwl28WRyh
         NnNrprgpRFd/TzHZYZpm5myomykeNmBHqdRkCBg+i2rrl7ka8L5ACwponH0Pe41+SQMo
         HyHuEZkFBpyEm3ninfw1ryhJzrvqweJ/3b5SeTuW/0Kdj864MVFF2g6Y2aC7A4ziYWYg
         QibAhyWo9NkS6LfCgsRnJYLyeHV22RymYKTvkj1KPje2iIexk9Y8iny5yECLg2+9S806
         CAgw==
X-Gm-Message-State: AC+VfDwurekmanu0JbzSvYcFTv7BUmIrD9CMJOKHaLZypPfhARGrViHh
        XZkVjwTc/+xMb2IRMqjR3zpDeEw8NqtlL08lq1M=
X-Google-Smtp-Source: ACHHUZ7W/EAeoI6+Usz14bmaW6a6DFi2+DwfL1MkSnFXMbk+rygjSXInhsD+YtTaaMlWMZwF5kCkRQ==
X-Received: by 2002:a05:6a00:13aa:b0:636:f899:4696 with SMTP id t42-20020a056a0013aa00b00636f8994696mr18107919pfg.24.1682920193802;
        Sun, 30 Apr 2023 22:49:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g5-20020aa78185000000b006410d9ab405sm8068788pfi.120.2023.04.30.22.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 22:49:52 -0700 (PDT)
Message-ID: <644f5300.a70a0220.fbd81.0e6b@mx.google.com>
Date:   Sun, 30 Apr 2023 22:49:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.176-372-g0629ac4f81a42
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 166 runs,
 8 regressions (v5.10.176-372-g0629ac4f81a42)
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

stable-rc/queue/5.10 baseline: 166 runs, 8 regressions (v5.10.176-372-g0629=
ac4f81a42)

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
nel/v5.10.176-372-g0629ac4f81a42/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.176-372-g0629ac4f81a42
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      0629ac4f81a42b6cd7123e4a929536be7cf057ee =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/644f21d5b7a2247b612e864c

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-g0629ac4f81a42/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-g0629ac4f81a42/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f21d5b7a2247b612e8681
        failing since 76 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-05-01T02:19:44.402631  <8>[   17.142400] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 403226_1.5.2.4.1>
    2023-05-01T02:19:44.514161  / # #
    2023-05-01T02:19:44.617134  export SHELL=3D/bin/sh
    2023-05-01T02:19:44.618019  #
    2023-05-01T02:19:44.720082  / # export SHELL=3D/bin/sh. /lava-403226/en=
vironment
    2023-05-01T02:19:44.721008  =

    2023-05-01T02:19:44.823112  / # . /lava-403226/environment/lava-403226/=
bin/lava-test-runner /lava-403226/1
    2023-05-01T02:19:44.824440  =

    2023-05-01T02:19:44.827946  / # /lava-403226/bin/lava-test-runner /lava=
-403226/1
    2023-05-01T02:19:44.926322  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644f222cbd0d81d8e02e86a4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-g0629ac4f81a42/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-g0629ac4f81a42/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f222cbd0d81d8e02e86a9
        failing since 94 days (last pass: v5.10.165-76-g5c2e982fcf18, first=
 fail: v5.10.165-77-g4600242c13ed)

    2023-05-01T02:21:15.967283  <8>[   11.137542] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3545299_1.5.2.4.1>
    2023-05-01T02:21:16.077082  / # #
    2023-05-01T02:21:16.180168  export SHELL=3D/bin/sh
    2023-05-01T02:21:16.180989  #
    2023-05-01T02:21:16.283079  / # export SHELL=3D/bin/sh. /lava-3545299/e=
nvironment
    2023-05-01T02:21:16.283988  =

    2023-05-01T02:21:16.386024  / # . /lava-3545299/environment/lava-354529=
9/bin/lava-test-runner /lava-3545299/1
    2023-05-01T02:21:16.387614  =

    2023-05-01T02:21:16.388039  / # /lava-3545299/bin/lava-test-runner /lav=
a-3545299/1<3>[   11.531617] Bluetooth: hci0: command 0x0c03 tx timeout
    2023-05-01T02:21:16.391877   =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644f1fbbc60da24a992e85e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-g0629ac4f81a42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-g0629ac4f81a42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f1fbbc60da24a992e85ec
        failing since 31 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-01T02:11:01.870102  + set +x

    2023-05-01T02:11:01.876709  <8>[   14.733620] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10164908_1.4.2.3.1>

    2023-05-01T02:11:01.980834  / # #

    2023-05-01T02:11:02.081497  export SHELL=3D/bin/sh

    2023-05-01T02:11:02.081718  #

    2023-05-01T02:11:02.182320  / # export SHELL=3D/bin/sh. /lava-10164908/=
environment

    2023-05-01T02:11:02.182522  =


    2023-05-01T02:11:02.283050  / # . /lava-10164908/environment/lava-10164=
908/bin/lava-test-runner /lava-10164908/1

    2023-05-01T02:11:02.283373  =


    2023-05-01T02:11:02.287316  / # /lava-10164908/bin/lava-test-runner /la=
va-10164908/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644f1fc20f8541bb812e865b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-g0629ac4f81a42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-g0629ac4f81a42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f1fc20f8541bb812e8660
        failing since 31 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-01T02:11:01.798642  <8>[   12.982889] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10164896_1.4.2.3.1>

    2023-05-01T02:11:01.802044  + set +x

    2023-05-01T02:11:01.907535  #

    2023-05-01T02:11:02.008426  / # #export SHELL=3D/bin/sh

    2023-05-01T02:11:02.008739  =


    2023-05-01T02:11:02.109577  / # export SHELL=3D/bin/sh. /lava-10164896/=
environment

    2023-05-01T02:11:02.110340  =


    2023-05-01T02:11:02.211819  / # . /lava-10164896/environment/lava-10164=
896/bin/lava-test-runner /lava-10164896/1

    2023-05-01T02:11:02.213022  =


    2023-05-01T02:11:02.218437  / # /lava-10164896/bin/lava-test-runner /la=
va-10164896/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644f2138a314cad4342e85ff

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-g0629ac4f81a42/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-roc=
k64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-g0629ac4f81a42/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-roc=
k64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f2138a314cad4342e8604
        failing since 89 days (last pass: v5.10.155-149-g63e308de12c9, firs=
t fail: v5.10.165-142-gc53eb88edf7e)

    2023-05-01T02:17:17.684904  [   15.994371] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3545245_1.5.2.4.1>
    2023-05-01T02:17:17.789397  =

    2023-05-01T02:17:17.789591  / # [   16.033504] rockchip-drm display-sub=
system: [drm] Cannot find any crtc or sizes
    2023-05-01T02:17:17.891005  #export SHELL=3D/bin/sh
    2023-05-01T02:17:17.891800  =

    2023-05-01T02:17:17.993608  / # export SHELL=3D/bin/sh. /lava-3545245/e=
nvironment
    2023-05-01T02:17:17.994028  =

    2023-05-01T02:17:18.095340  / # . /lava-3545245/environment/lava-354524=
5/bin/lava-test-runner /lava-3545245/1
    2023-05-01T02:17:18.095863  =

    2023-05-01T02:17:18.099270  / # /lava-3545245/bin/lava-test-runner /lav=
a-3545245/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/644f217d678911e7df2e8601

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-g0629ac4f81a42/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-g0629ac4f81a42/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/644f217d678911e7df2e8607
        failing since 48 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-01T02:18:23.861262  /lava-10164975/1/../bin/lava-test-case

    2023-05-01T02:18:23.871814  <8>[   62.137148] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/644f217d678911e7df2e8608
        failing since 48 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-01T02:18:21.803228  <8>[   60.066043] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-05-01T02:18:22.824875  /lava-10164975/1/../bin/lava-test-case

    2023-05-01T02:18:22.835016  <8>[   61.100256] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644f2217d43d4250102e8664

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-g0629ac4f81a42/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-g0629ac4f81a42/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f2217d43d4250102e8669
        failing since 88 days (last pass: v5.10.165-139-gefb57ce0f880, firs=
t fail: v5.10.165-149-ge30e8271d674)

    2023-05-01T02:20:37.932818  / # #
    2023-05-01T02:20:38.034574  export SHELL=3D/bin/sh
    2023-05-01T02:20:38.034950  #
    2023-05-01T02:20:38.136263  / # export SHELL=3D/bin/sh. /lava-3545302/e=
nvironment
    2023-05-01T02:20:38.136626  =

    2023-05-01T02:20:38.237963  / # . /lava-3545302/environment/lava-354530=
2/bin/lava-test-runner /lava-3545302/1
    2023-05-01T02:20:38.238588  =

    2023-05-01T02:20:38.244157  / # /lava-3545302/bin/lava-test-runner /lav=
a-3545302/1
    2023-05-01T02:20:38.342803  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-01T02:20:38.343320  + cd /lava-3545302/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
