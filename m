Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E64701947
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 20:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjEMSjd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 14:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjEMSjc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 14:39:32 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC692680
        for <stable@vger.kernel.org>; Sat, 13 May 2023 11:39:30 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6439b410679so7409714b3a.0
        for <stable@vger.kernel.org>; Sat, 13 May 2023 11:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684003169; x=1686595169;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HBXf/gJlGbmWYjW93jmPUrt/UW+42r2yV38DlnqlMbQ=;
        b=XMFu5dZbNAoHkjpGdxcb8cPLP2P/SuvhKp+uojv3S5NzdWJjhjD+In7TOeFpd43EXj
         8CAb1/PUhSGDBHsX9XYm/75wzZhv4wRmsqA+qQPetcUlUQdAQOYZv17bDCvOPrjq6gV9
         SUOvykwjaYrstE+V4KU520gQMxcOhO+cW3pHZyYr5vdQpMy+LHTeMOTff0CkE+78aHry
         rdedliHu67cXdLoND2Vwzh0pVuJNR1uBBKXcs2chUphzc08QSG/aGn7/ygV1QKWvL2kv
         dc6tRqRhUgm9xqnlnYR5EFZllU3B4bOGKfYxOXVXtmwGcWg6f+UQBC1fPLPbZme7WE+m
         0+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684003169; x=1686595169;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBXf/gJlGbmWYjW93jmPUrt/UW+42r2yV38DlnqlMbQ=;
        b=jmrdngvddIPAukOrJJ/mOiI9R6So8ZFjYnl4i24f296zgkKLmPPQ8MssVQOIgIHXNm
         NjY/OyAkILcBLVNdvmWKp9srsohzqbzpeAH8U84l3AxNeDAN9ee3zrFDXxsGJcXO/xgT
         ktPrGX3/KWuxdQGHQ6r4dbcbr0RnjbN9aFgn2aYvxs0Y0RwaZ1uHc+e6AJUWv00qkN0e
         UPf8UqjZOLSqV7spu3b9XEi1hqNv8jGSvXKK5clMbwx0hlZsBldr22EfkuvR+SxLp9tv
         S/kt79f0CFfalq1dQR9nF8WLlETyYDbLLdVXBmDJY/nwpZ+TerMCjaM33VaXJlw+atAF
         7iVQ==
X-Gm-Message-State: AC+VfDxST2JmSGc3vcW82Q9glRlF3CbuXvWnrYDEcQ33tLhDYFXxHuTk
        /Fga5WRnGBwn7sqWx0MJpP56qfxKqo5YzG2jW4I=
X-Google-Smtp-Source: ACHHUZ7KeK5eaA0zym6RhMaIeVJfnbVOzxDGfmuB6diUbQIcPcz3LjUuRUsPcAev1zrsgIjhgdz9gQ==
X-Received: by 2002:a05:6a00:c82:b0:64a:a1ba:50fd with SMTP id a2-20020a056a000c8200b0064aa1ba50fdmr8647422pfv.22.1684003169499;
        Sat, 13 May 2023 11:39:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u20-20020a62ed14000000b0063d24fcc2besm8901270pfh.125.2023.05.13.11.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 11:39:28 -0700 (PDT)
Message-ID: <645fd960.620a0220.0387.2f75@mx.google.com>
Date:   Sat, 13 May 2023 11:39:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.179-361-g5fe530e4a72ff
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 178 runs,
 7 regressions (v5.10.179-361-g5fe530e4a72ff)
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

stable-rc/queue/5.10 baseline: 178 runs, 7 regressions (v5.10.179-361-g5fe5=
30e4a72ff)

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
nel/v5.10.179-361-g5fe530e4a72ff/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.179-361-g5fe530e4a72ff
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      5fe530e4a72fff931586ef3dd0bcfc090192879b =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/645fa44736ad95c9c82e85fc

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-361-g5fe530e4a72ff/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-361-g5fe530e4a72ff/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645fa44736ad95c9c82e861a
        failing since 88 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-05-13T14:52:42.322888  <8>[   20.638006] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 457307_1.5.2.4.1>
    2023-05-13T14:52:42.431822  / # #
    2023-05-13T14:52:42.535300  export SHELL=3D/bin/sh
    2023-05-13T14:52:42.535943  #
    2023-05-13T14:52:42.637776  / # export SHELL=3D/bin/sh. /lava-457307/en=
vironment
    2023-05-13T14:52:42.638368  =

    2023-05-13T14:52:42.740014  / # . /lava-457307/environment/lava-457307/=
bin/lava-test-runner /lava-457307/1
    2023-05-13T14:52:42.741238  =

    2023-05-13T14:52:42.745585  / # /lava-457307/bin/lava-test-runner /lava=
-457307/1
    2023-05-13T14:52:42.848373  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645fa71ccc10020b922e860d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-361-g5fe530e4a72ff/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-361-g5fe530e4a72ff/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645fa71ccc10020b922e8612
        failing since 107 days (last pass: v5.10.165-76-g5c2e982fcf18, firs=
t fail: v5.10.165-77-g4600242c13ed)

    2023-05-13T15:04:51.832582  <8>[   11.141495] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3584952_1.5.2.4.1>
    2023-05-13T15:04:51.943427  / # #
    2023-05-13T15:04:52.046463  export SHELL=3D/bin/sh
    2023-05-13T15:04:52.047325  #
    2023-05-13T15:04:52.150000  / # export SHELL=3D/bin/sh. /lava-3584952/e=
nvironment
    2023-05-13T15:04:52.150943  =

    2023-05-13T15:04:52.253093  / # . /lava-3584952/environment/lava-358495=
2/bin/lava-test-runner /lava-3584952/1
    2023-05-13T15:04:52.254549  =

    2023-05-13T15:04:52.260852  / # /lava-3584952/bin/lava-test-runner /lav=
a-3584952/1
    2023-05-13T15:04:52.350024  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645fa67d5fd85eab802e8614

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-361-g5fe530e4a72ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-361-g5fe530e4a72ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645fa67d5fd85eab802e8619
        failing since 44 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-13T15:02:13.263412  + set +x

    2023-05-13T15:02:13.269705  <8>[   14.190794] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10306243_1.4.2.3.1>

    2023-05-13T15:02:13.378943  / # #

    2023-05-13T15:02:13.481455  export SHELL=3D/bin/sh

    2023-05-13T15:02:13.481628  #

    2023-05-13T15:02:13.582185  / # export SHELL=3D/bin/sh. /lava-10306243/=
environment

    2023-05-13T15:02:13.582369  =


    2023-05-13T15:02:13.683076  / # . /lava-10306243/environment/lava-10306=
243/bin/lava-test-runner /lava-10306243/1

    2023-05-13T15:02:13.684345  =


    2023-05-13T15:02:13.689104  / # /lava-10306243/bin/lava-test-runner /la=
va-10306243/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645fa67e495e6692bc2e8606

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-361-g5fe530e4a72ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-361-g5fe530e4a72ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645fa67e495e6692bc2e860b
        failing since 44 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-13T15:02:07.950801  + set +x

    2023-05-13T15:02:07.957346  <8>[   13.516082] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10306208_1.4.2.3.1>

    2023-05-13T15:02:08.062391  / # #

    2023-05-13T15:02:08.163190  export SHELL=3D/bin/sh

    2023-05-13T15:02:08.163435  #

    2023-05-13T15:02:08.264050  / # export SHELL=3D/bin/sh. /lava-10306208/=
environment

    2023-05-13T15:02:08.264280  =


    2023-05-13T15:02:08.364919  / # . /lava-10306208/environment/lava-10306=
208/bin/lava-test-runner /lava-10306208/1

    2023-05-13T15:02:08.365310  =


    2023-05-13T15:02:08.370072  / # /lava-10306208/bin/lava-test-runner /la=
va-10306208/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/645fa8c0bacc3f6bdd2e85f5

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-361-g5fe530e4a72ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-361-g5fe530e4a72ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/645fa8c0bacc3f6bdd2e85fb
        failing since 60 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-13T15:11:44.239660  /lava-10306305/1/../bin/lava-test-case

    2023-05-13T15:11:44.250659  <8>[   62.100781] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/645fa8c0bacc3f6bdd2e85fc
        failing since 60 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-13T15:11:42.177941  <8>[   60.027327] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-05-13T15:11:43.202529  /lava-10306305/1/../bin/lava-test-case

    2023-05-13T15:11:43.213364  <8>[   61.063647] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645fa5a1f54140fb2d2e8690

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-361-g5fe530e4a72ff/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-361-g5fe530e4a72ff/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645fa5a1f54140fb2d2e8695
        failing since 100 days (last pass: v5.10.165-139-gefb57ce0f880, fir=
st fail: v5.10.165-149-ge30e8271d674)

    2023-05-13T14:58:16.945348  / # #
    2023-05-13T14:58:17.047371  export SHELL=3D/bin/sh
    2023-05-13T14:58:17.047802  #
    2023-05-13T14:58:17.149154  / # export SHELL=3D/bin/sh. /lava-3584942/e=
nvironment
    2023-05-13T14:58:17.149679  =

    2023-05-13T14:58:17.251069  / # . /lava-3584942/environment/lava-358494=
2/bin/lava-test-runner /lava-3584942/1
    2023-05-13T14:58:17.251836  =

    2023-05-13T14:58:17.256489  / # /lava-3584942/bin/lava-test-runner /lav=
a-3584942/1
    2023-05-13T14:58:17.320591  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-13T14:58:17.368315  + cd /lava-3584942/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
