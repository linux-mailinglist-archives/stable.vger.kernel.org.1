Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A2A77EEA9
	for <lists+stable@lfdr.de>; Thu, 17 Aug 2023 03:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347486AbjHQBVz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 16 Aug 2023 21:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347544AbjHQBVl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 16 Aug 2023 21:21:41 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90712727
        for <stable@vger.kernel.org>; Wed, 16 Aug 2023 18:21:35 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68878ca7ca0so1459347b3a.0
        for <stable@vger.kernel.org>; Wed, 16 Aug 2023 18:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692235294; x=1692840094;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b8XOlMCpF/2KJVUsTUEjQAUFU0QdXTYHAjJrq04HFRU=;
        b=w59Sb0OII8V9Tim7ohjoHaWcjL6fcjw3lENcyOIMIvrXWYDrViONlwKKl5v+0SmYQl
         rtMr/4g95GXlEhtluhfccthsLGFcbpt8dd2Wp/aZRyFUZ7yKQIQBk0kHetOHuatTHbOr
         TZdbMqe7DYq4CYSI1LVRAROVgajlUbfIBhZTR+RHUyjba9gAq58CY5SPKJbwblUa4ODV
         p8Ft02IpHJPKjedJeW4v17uh1cTPeFXYKfRSDmJsTDMU5BIu5061OXiY+lznJRWJr1YY
         mXuqCzS24K55bGN5wnj58igVYfC8IdzNo709H6N8mGFhMAjOHW29lScjbWpnRCI/hNcN
         RCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692235294; x=1692840094;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8XOlMCpF/2KJVUsTUEjQAUFU0QdXTYHAjJrq04HFRU=;
        b=W21qFiSc78d4IoTPCSAAdBOYZXAql6prfQg06Bb3YHniXJ0D2oVT4SYsyLyKmzUL7o
         VKYk5HxiiGnyD1GF6E9X2g6XMcMmk7M3YVG/kJ5S5uC4EsGxOetV9ce1m3H6x2ucT7pk
         lNn3aproUmhG5zwaxa2ksISTd/A5xGG0Y6uQQviiTH/xCISDhakZspds9WhfEfMGN2UJ
         QfqEJUP6pdiXmYLhaTF53L+DStB5YNzlN+EP/p4tN15+JfIP/U4bBKAcC6fTRSlq4Kdv
         xcc4xpWvEidzlDEyYV2FU88JPTgaqMIHqJPJkXI1Zp1I770ZKx2ZSC1Wka0UTH2Qvquu
         zQRw==
X-Gm-Message-State: AOJu0YxpeXdeUistpbBvzuaLmHvFH8fqce1nKqIrNDSHF29bh6BbRBSv
        OJUdNJ4Ag5d6IhqSac1WJjHjcKJSi2SuOO5e3PZ1bA==
X-Google-Smtp-Source: AGHT+IHDQ+GVF3DDctraR9GvbnK9yUOoEVgT5YVRfOzvyIODbVmhS5pDMJrItfWQztvjsSdxLZvIVw==
X-Received: by 2002:a05:6a00:1991:b0:64d:5b4b:8429 with SMTP id d17-20020a056a00199100b0064d5b4b8429mr3466812pfl.18.1692235294597;
        Wed, 16 Aug 2023 18:21:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i12-20020aa78b4c000000b00678cb337353sm11641455pfd.208.2023.08.16.18.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 18:21:34 -0700 (PDT)
Message-ID: <64dd761e.a70a0220.56e31.60d0@mx.google.com>
Date:   Wed, 16 Aug 2023 18:21:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.191
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.10.y
Subject: stable-rc/linux-5.10.y baseline: 119 runs, 8 regressions (v5.10.191)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y baseline: 119 runs, 8 regressions (v5.10.191)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
at91-sama5d4_xplained    | arm    | lab-baylibre  | gcc-10   | multi_v7_def=
config           | 1          =

cubietruck               | arm    | lab-baylibre  | gcc-10   | multi_v7_def=
config           | 1          =

fsl-ls2088a-rdb          | arm64  | lab-nxp       | gcc-10   | defconfig   =
                 | 1          =

fsl-lx2160a-rdb          | arm64  | lab-nxp       | gcc-10   | defconfig   =
                 | 1          =

hp-x360-14-G1-sona       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =

r8a77960-ulcb            | arm64  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =

sun50i-h6-pine-h64       | arm64  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.191/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.191
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      da742ebfa00c3add4a358dd79ec92161c07e1435 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
at91-sama5d4_xplained    | arm    | lab-baylibre  | gcc-10   | multi_v7_def=
config           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd426a9af31c896035b1e0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sama5d4_xplaine=
d.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sama5d4_xplaine=
d.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd426a9af31c896035b=
1e1
        new failure (last pass: v5.10.190-69-g5b1776cc14bf8) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
cubietruck               | arm    | lab-baylibre  | gcc-10   | multi_v7_def=
config           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd418d5f3751648035b215

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd418d5f3751648035b21a
        failing since 210 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-08-16T21:37:08.315258  <8>[   11.149507] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3744026_1.5.2.4.1>
    2023-08-16T21:37:08.428915  / # #
    2023-08-16T21:37:08.532510  export SHELL=3D/bin/sh
    2023-08-16T21:37:08.533501  #
    2023-08-16T21:37:08.635746  / # export SHELL=3D/bin/sh. /lava-3744026/e=
nvironment
    2023-08-16T21:37:08.636710  =

    2023-08-16T21:37:08.637183  / # . /lava-3744026/environment<3>[   11.45=
2689] Bluetooth: hci0: command 0xfc18 tx timeout
    2023-08-16T21:37:08.739141  /lava-3744026/bin/lava-test-runner /lava-37=
44026/1
    2023-08-16T21:37:08.740583  =

    2023-08-16T21:37:08.745112  / # /lava-3744026/bin/lava-test-runner /lav=
a-3744026/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
fsl-ls2088a-rdb          | arm64  | lab-nxp       | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd424bf776fbfd0235b253

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd424bf776fbfd0235b256
        failing since 29 days (last pass: v5.10.142, first fail: v5.10.186-=
332-gf98a4d3a5cec)

    2023-08-16T21:40:04.914090  + [    9.437463] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1244341_1.5.2.4.1>
    2023-08-16T21:40:04.914202  set +x
    2023-08-16T21:40:05.016952  =

    2023-08-16T21:40:05.117746  / # #export SHELL=3D/bin/sh
    2023-08-16T21:40:05.118062  =

    2023-08-16T21:40:05.218655  / # export SHELL=3D/bin/sh. /lava-1244341/e=
nvironment
    2023-08-16T21:40:05.218933  =

    2023-08-16T21:40:05.319555  / # . /lava-1244341/environment/lava-124434=
1/bin/lava-test-runner /lava-1244341/1
    2023-08-16T21:40:05.319938  =

    2023-08-16T21:40:05.324095  / # /lava-1244341/bin/lava-test-runner /lav=
a-1244341/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
fsl-lx2160a-rdb          | arm64  | lab-nxp       | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd429cd39fe2704135b1d9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd429cd39fe2704135b1dc
        failing since 166 days (last pass: v5.10.155, first fail: v5.10.172)

    2023-08-16T21:41:36.542510  [   15.325552] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1244342_1.5.2.4.1>
    2023-08-16T21:41:36.647781  =

    2023-08-16T21:41:36.749012  / # #export SHELL=3D/bin/sh
    2023-08-16T21:41:36.749453  =

    2023-08-16T21:41:36.850444  / # export SHELL=3D/bin/sh. /lava-1244342/e=
nvironment
    2023-08-16T21:41:36.850908  =

    2023-08-16T21:41:36.951945  / # . /lava-1244342/environment/lava-124434=
2/bin/lava-test-runner /lava-1244342/1
    2023-08-16T21:41:36.952685  =

    2023-08-16T21:41:36.956583  / # /lava-1244342/bin/lava-test-runner /lav=
a-1244342/1
    2023-08-16T21:41:36.971577  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-x360-14-G1-sona       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd405c074ff3c0b935b1e5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd405c074ff3c0b935b1ea
        failing since 141 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-16T21:32:14.494284  + set +x

    2023-08-16T21:32:14.500888  <8>[   13.117903] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11303177_1.4.2.3.1>

    2023-08-16T21:32:14.602585  #

    2023-08-16T21:32:14.603030  =


    2023-08-16T21:32:14.703728  / # #export SHELL=3D/bin/sh

    2023-08-16T21:32:14.703963  =


    2023-08-16T21:32:14.804548  / # export SHELL=3D/bin/sh. /lava-11303177/=
environment

    2023-08-16T21:32:14.804761  =


    2023-08-16T21:32:14.905266  / # . /lava-11303177/environment/lava-11303=
177/bin/lava-test-runner /lava-11303177/1

    2023-08-16T21:32:14.905698  =

 =

    ... (13 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd4a9bbd26d1074535b1e2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope=
-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope=
-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd4a9bbd26d1074535b1e5
        failing since 29 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-16T22:15:25.174552  + set +x
    2023-08-16T22:15:25.174784  <8>[   83.683381] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 998316_1.5.2.4.1>
    2023-08-16T22:15:25.280947  / # #
    2023-08-16T22:15:26.741699  export SHELL=3D/bin/sh
    2023-08-16T22:15:26.762240  #
    2023-08-16T22:15:26.762451  / # export SHELL=3D/bin/sh
    2023-08-16T22:15:28.645902  / # . /lava-998316/environment
    2023-08-16T22:15:32.099577  /lava-998316/bin/lava-test-runner /lava-998=
316/1
    2023-08-16T22:15:32.120179  . /lava-998316/environment
    2023-08-16T22:15:32.120300  / # /lava-998316/bin/lava-test-runner /lava=
-998316/1 =

    ... (28 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a77960-ulcb            | arm64  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd4218a2a8982ac835b1dc

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd4218a2a8982ac835b1e1
        failing since 29 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-16T21:40:54.429215  / # #

    2023-08-16T21:40:54.530934  export SHELL=3D/bin/sh

    2023-08-16T21:40:54.531594  #

    2023-08-16T21:40:54.632756  / # export SHELL=3D/bin/sh. /lava-11303317/=
environment

    2023-08-16T21:40:54.633449  =


    2023-08-16T21:40:54.734704  / # . /lava-11303317/environment/lava-11303=
317/bin/lava-test-runner /lava-11303317/1

    2023-08-16T21:40:54.735735  =


    2023-08-16T21:40:54.737990  / # /lava-11303317/bin/lava-test-runner /la=
va-11303317/1

    2023-08-16T21:40:54.801174  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-16T21:40:54.801649  + cd /lav<8>[   16.425842] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11303317_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
sun50i-h6-pine-h64       | arm64  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd421a461736367d35b27b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
91/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd421a461736367d35b280
        failing since 29 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-16T21:41:08.445230  / # #

    2023-08-16T21:41:08.547346  export SHELL=3D/bin/sh

    2023-08-16T21:41:08.548069  #

    2023-08-16T21:41:08.649483  / # export SHELL=3D/bin/sh. /lava-11303322/=
environment

    2023-08-16T21:41:08.650238  =


    2023-08-16T21:41:08.751686  / # . /lava-11303322/environment/lava-11303=
322/bin/lava-test-runner /lava-11303322/1

    2023-08-16T21:41:08.752684  =


    2023-08-16T21:41:08.769673  / # /lava-11303322/bin/lava-test-runner /la=
va-11303322/1

    2023-08-16T21:41:08.827705  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-16T21:41:08.828196  + cd /lava-1130332<8>[   18.323384] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11303322_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
