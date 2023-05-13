Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA9C701801
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 17:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbjEMPP6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 11:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjEMPP5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 11:15:57 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24BD1997
        for <stable@vger.kernel.org>; Sat, 13 May 2023 08:15:55 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-643b7b8f8ceso6123584b3a.1
        for <stable@vger.kernel.org>; Sat, 13 May 2023 08:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683990955; x=1686582955;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wwKGoz86PlyGAFTRijJ/IpZBHIR1rC9HKYNdBkUFDh0=;
        b=5lbTiDjkEMMQcc2nXydjqgHIGIzIVLNNXIl1WlyHueYlvo4tXBi6UscGsPI7Lp5/c9
         mWd/+OYY2u48xzXQRktJhmcL4nZcp/V8QZAj6yQ8SwJtKfEGycrmWT8KODanboAu8koj
         LTwx78hTKHXRGcm4o0YrPmM9ZwXMP5Vtx88LJHrX+miaMqhRBobeng/dgpSn0MMWxV0m
         P0SYQ0HoMJpzVzUsMtGNZVPg8PwHNv+ZHLqy1ZSRzG5p4ys15GC4xSX1mex3YTQSgR/3
         cuofvZy4V+2l4MTncxmRmyesIWNrN1gY9wuU0A2B+ZlVz6f6OmwyVNb7FafI/ymF0Wbf
         BZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683990955; x=1686582955;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wwKGoz86PlyGAFTRijJ/IpZBHIR1rC9HKYNdBkUFDh0=;
        b=hul9LZ7J3wv1j5zP0w6HcUD9MBYvUS3DjTC9n49P/u271yFJHeCks7skEtAGejGMKm
         TBhx5TSbjNOngdjHQUFOZkdFrH9p51psKdjUnE9+ca/QW2Vzh5ygt75zi6XlXmH9e80Z
         MFpIElmWQdfRaIQIdGELPZyj/kNftqmwIQOatbiF6jjlYS/3m8U5P6eItuh+BnApCrDz
         q0dsZ671/nXK3od/B0XSQiKb7YqA28mmpOKdEMBKkdUvDp5imzdBb1vfp9qVUBuD5Db3
         xhV/yvyfm5eygrBnnCC6N3XiXWeO3WA6KvVdVelezjssHfFLbf3qjHo5Y64HV5/9KaVm
         +kZw==
X-Gm-Message-State: AC+VfDyTKXM3uoRTidwtV3wjOfpkz3MmLnZEKr7w3Z4EWDY0TL24nVuO
        0g/iaF0hSuIMAxPQ42us8axgT5AZoN81I9Lk6jM=
X-Google-Smtp-Source: ACHHUZ4UkKnQmkGu0ky3kGjwIZhjakp9yLwrBlL1qT4DA+1j0vE4BjS7XyZL1LXMiY8B3OitWGYdvA==
X-Received: by 2002:a05:6a00:ace:b0:63b:89a2:d624 with SMTP id c14-20020a056a000ace00b0063b89a2d624mr37438125pfl.12.1683990954923;
        Sat, 13 May 2023 08:15:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h5-20020a62b405000000b0063f33e216dasm9052658pfn.96.2023.05.13.08.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 08:15:54 -0700 (PDT)
Message-ID: <645fa9aa.620a0220.45745.276c@mx.google.com>
Date:   Sat, 13 May 2023 08:15:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.179-361-g95806ce7a0b61
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 179 runs,
 8 regressions (v5.10.179-361-g95806ce7a0b61)
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

stable-rc/queue/5.10 baseline: 179 runs, 8 regressions (v5.10.179-361-g9580=
6ce7a0b61)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

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
nel/v5.10.179-361-g95806ce7a0b61/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.179-361-g95806ce7a0b61
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      95806ce7a0b61c119b0b2e3d2e6b4a4706a2599d =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645f77c645a87f96c02e862f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-361-g95806ce7a0b61/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at9=
1-sama5d4_xplained.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-361-g95806ce7a0b61/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at9=
1-sama5d4_xplained.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645f77c645a87f96c02e8=
630
        failing since 1 day (last pass: v5.10.176-650-gfaca4b1ce4622, first=
 fail: v5.10.179-311-g06ff0d7f066c2) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/645f77a134aa504afa2e8660

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-361-g95806ce7a0b61/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-361-g95806ce7a0b61/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f77a134aa504afa2e8695
        failing since 88 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-05-13T11:42:04.064596  <8>[   19.063827] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 456163_1.5.2.4.1>
    2023-05-13T11:42:04.173887  / # #
    2023-05-13T11:42:04.276183  export SHELL=3D/bin/sh
    2023-05-13T11:42:04.276855  #
    2023-05-13T11:42:04.378628  / # export SHELL=3D/bin/sh. /lava-456163/en=
vironment
    2023-05-13T11:42:04.379287  =

    2023-05-13T11:42:04.481140  / # . /lava-456163/environment/lava-456163/=
bin/lava-test-runner /lava-456163/1
    2023-05-13T11:42:04.482329  =

    2023-05-13T11:42:04.486400  / # /lava-456163/bin/lava-test-runner /lava=
-456163/1
    2023-05-13T11:42:04.588607  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645f762dd7977806442e8637

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-361-g95806ce7a0b61/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-361-g95806ce7a0b61/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f762dd7977806442e863a
        failing since 106 days (last pass: v5.10.165-76-g5c2e982fcf18, firs=
t fail: v5.10.165-77-g4600242c13ed)

    2023-05-13T11:36:04.027269  + set +x<8>[   11.118498] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3583771_1.5.2.4.1>
    2023-05-13T11:36:04.027511  =

    2023-05-13T11:36:04.134227  / # #
    2023-05-13T11:36:04.235702  export SHELL=3D/bin/sh
    2023-05-13T11:36:04.236176  #
    2023-05-13T11:36:04.337362  / # export SHELL=3D/bin/sh. /lava-3583771/e=
nvironment
    2023-05-13T11:36:04.337862  =

    2023-05-13T11:36:04.439191  / # . /lava-3583771/environment/lava-358377=
1/bin/lava-test-runner /lava-3583771/1
    2023-05-13T11:36:04.439999  =

    2023-05-13T11:36:04.441193  / # /lava-3583771/bin/lava-test-runner /lav=
a-3583771/1<3>[   11.535340] Bluetooth: hci0: command 0x0c03 tx timeout =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f76dd7fbb2236502e85f4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-361-g95806ce7a0b61/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-361-g95806ce7a0b61/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f76dd7fbb2236502e85f9
        failing since 44 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-13T11:38:57.710950  + set +x

    2023-05-13T11:38:57.717412  <8>[   10.789553] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10304179_1.4.2.3.1>

    2023-05-13T11:38:57.821638  / # #

    2023-05-13T11:38:57.922222  export SHELL=3D/bin/sh

    2023-05-13T11:38:57.922404  #

    2023-05-13T11:38:58.022915  / # export SHELL=3D/bin/sh. /lava-10304179/=
environment

    2023-05-13T11:38:58.023092  =


    2023-05-13T11:38:58.123552  / # . /lava-10304179/environment/lava-10304=
179/bin/lava-test-runner /lava-10304179/1

    2023-05-13T11:38:58.123797  =


    2023-05-13T11:38:58.128467  / # /lava-10304179/bin/lava-test-runner /la=
va-10304179/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f76dbae28cc50742e85ef

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-361-g95806ce7a0b61/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-361-g95806ce7a0b61/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f76dbae28cc50742e85f4
        failing since 44 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-13T11:38:53.653125  + set +x

    2023-05-13T11:38:53.660023  <8>[   12.677080] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10304166_1.4.2.3.1>

    2023-05-13T11:38:53.761714  #

    2023-05-13T11:38:53.761981  =


    2023-05-13T11:38:53.862559  / # #export SHELL=3D/bin/sh

    2023-05-13T11:38:53.862745  =


    2023-05-13T11:38:53.963300  / # export SHELL=3D/bin/sh. /lava-10304166/=
environment

    2023-05-13T11:38:53.963539  =


    2023-05-13T11:38:54.064096  / # . /lava-10304166/environment/lava-10304=
166/bin/lava-test-runner /lava-10304166/1

    2023-05-13T11:38:54.064415  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/645f7852301a8847fa2e8614

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-361-g95806ce7a0b61/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-361-g95806ce7a0b61/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/645f7852301a8847fa2e861a
        failing since 60 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-13T11:45:17.740239  <8>[   32.737853] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-05-13T11:45:18.763641  /lava-10304284/1/../bin/lava-test-case

    2023-05-13T11:45:18.774896  <8>[   33.773204] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/645f7852301a8847fa2e861b
        failing since 60 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-13T11:45:17.727851  /lava-10304284/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645f7619c8c0cd49882e862e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-361-g95806ce7a0b61/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-361-g95806ce7a0b61/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f7619c8c0cd49882e8633
        failing since 100 days (last pass: v5.10.165-139-gefb57ce0f880, fir=
st fail: v5.10.165-149-ge30e8271d674)

    2023-05-13T11:35:22.962680  <8>[    8.515321] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3583776_1.5.2.4.1>
    2023-05-13T11:35:23.068005  / # #
    2023-05-13T11:35:23.169712  export SHELL=3D/bin/sh
    2023-05-13T11:35:23.170068  #
    2023-05-13T11:35:23.271386  / # export SHELL=3D/bin/sh. /lava-3583776/e=
nvironment
    2023-05-13T11:35:23.271741  =

    2023-05-13T11:35:23.373075  / # . /lava-3583776/environment/lava-358377=
6/bin/lava-test-runner /lava-3583776/1
    2023-05-13T11:35:23.373685  =

    2023-05-13T11:35:23.380208  / # /lava-3583776/bin/lava-test-runner /lav=
a-3583776/1
    2023-05-13T11:35:23.444275  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
