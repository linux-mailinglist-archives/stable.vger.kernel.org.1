Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684F77898B4
	for <lists+stable@lfdr.de>; Sat, 26 Aug 2023 20:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjHZSiu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 14:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjHZSit (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 14:38:49 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0BA114
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 11:38:45 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68a529e1974so1463108b3a.3
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 11:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693075125; x=1693679925;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HI99fROuwfzpNP25X0m2bD0946sokLqhKysQ9/Uia7c=;
        b=WpKRgNTCnSvuv6K/ikmNl5vu1RF4cvZDGzp7RCmYu5X1Bp/rvdMrKkjaJttMIqbNwH
         yzDfrjIXZm+SLd3ztk/zvXIWpv48h/Hos6eEX/lWc20mTsCbiJKfomw9laqF1wRE0/8g
         s0+tPWXff114AYbmoswm6tg1xTcHclnvKDvc+IJOIN1chf6FPGb+gyEgwXTY3/y7l+rp
         bZmGDrPzxMUYYb/sjbue+cQogkeay7GLI8qhLCHniU1vv//QGRVJIoRbcPtCuLUu4n87
         1niz9ZWeNIjG7rL8JgNJ8XFSbWUVycT8yrPD0XcIpUfgJbPAu0zdW6eMmWqAvcGbXMsw
         VRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693075125; x=1693679925;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HI99fROuwfzpNP25X0m2bD0946sokLqhKysQ9/Uia7c=;
        b=cLBdIsXzcaXjsy46cwNY3uu9eOWZfpTdWeQKQaokIR7/k5ZSrw7d/UZkkgtWqYs0J6
         PGae9DkBrAAhPHSOAqfTUPyN9NBnN4DMkC7nrVRYuQQAppNDpHPEHtxt+4AmNf6QSaEW
         DcrH2q2oCZLwTaOAEh9hSGW6VX7tEYCQwZjCdIN1GrjwhNKMmb67+X38ZFXBKWi82W6K
         VQrxKlPwHEqryLZ63LtK4TJUay+lunQqYY9DYl8mIh+7qAz2n8O56QlkV0sKqJH8sPgS
         7XEYyveLs0AxtvAiwFqxWxTCpUZ/s36301XFkYMYj4PTs67z1UPiFbr1bCYoKE4XX0U/
         pvgg==
X-Gm-Message-State: AOJu0YzNcNRV58tf0BfSOQV+DmRqVfuS5DVLYFYz9MDziWdhufw/TFXq
        YgnEklsRvv4qiwT5FZYDSXPOoc598APPdufyIY8=
X-Google-Smtp-Source: AGHT+IH1NVNtnNN4Lj6qSA7CLNBWCBuU/X8Ye2fINGY6xkTBLPw1mHkI6YnF5DOJtwzgeVQIwarnww==
X-Received: by 2002:a05:6a00:cc9:b0:68a:4e72:943c with SMTP id b9-20020a056a000cc900b0068a4e72943cmr18612517pfv.11.1693075124545;
        Sat, 26 Aug 2023 11:38:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v19-20020aa78513000000b00686fe7b7b48sm3601308pfn.121.2023.08.26.11.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 11:38:43 -0700 (PDT)
Message-ID: <64ea46b3.a70a0220.c9a6c.60db@mx.google.com>
Date:   Sat, 26 Aug 2023 11:38:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.192
Subject: stable-rc/linux-5.10.y baseline: 124 runs, 13 regressions (v5.10.192)
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

stable-rc/linux-5.10.y baseline: 124 runs, 13 regressions (v5.10.192)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.192/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.192
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      1599cb60bace881ce05fa520e5251be341e380d2 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea1203de36ba2df6286d9f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea1203de36ba2df6286da4
        failing since 220 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-08-26T14:53:35.759578  <8>[   11.080200] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3751034_1.5.2.4.1>
    2023-08-26T14:53:35.869335  / # #
    2023-08-26T14:53:35.973231  export SHELL=3D/bin/sh
    2023-08-26T14:53:35.974393  #
    2023-08-26T14:53:36.076802  / # export SHELL=3D/bin/sh. /lava-3751034/e=
nvironment
    2023-08-26T14:53:36.077956  =

    2023-08-26T14:53:36.180304  / # . /lava-3751034/environment/lava-375103=
4/bin/lava-test-runner /lava-3751034/1
    2023-08-26T14:53:36.181969  =

    2023-08-26T14:53:36.186999  / # /lava-3751034/bin/lava-test-runner /lav=
a-3751034/1
    2023-08-26T14:53:36.209283  <3>[   11.531872] Bluetooth: hci0: command =
0x0c03 tx timeout =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea132bd4116e5879286d9c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea132bd4116e5879286da3
        failing since 39 days (last pass: v5.10.142, first fail: v5.10.186-=
332-gf98a4d3a5cec)

    2023-08-26T14:58:36.038063  + [   14.860412] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1246725_1.5.2.4.1>
    2023-08-26T14:58:36.038377  set +x
    2023-08-26T14:58:36.144188  =

    2023-08-26T14:58:36.245429  / # #export SHELL=3D/bin/sh
    2023-08-26T14:58:36.245866  =

    2023-08-26T14:58:36.346833  / # export SHELL=3D/bin/sh. /lava-1246725/e=
nvironment
    2023-08-26T14:58:36.347374  =

    2023-08-26T14:58:36.448385  / # . /lava-1246725/environment/lava-124672=
5/bin/lava-test-runner /lava-1246725/1
    2023-08-26T14:58:36.449139  =

    2023-08-26T14:58:36.453100  / # /lava-1246725/bin/lava-test-runner /lav=
a-1246725/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea132ee8d23c808d286d71

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea132ee8d23c808d286d78
        failing since 175 days (last pass: v5.10.155, first fail: v5.10.172)

    2023-08-26T14:58:37.532171  [   11.015579] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1246726_1.5.2.4.1>
    2023-08-26T14:58:37.638732  =

    2023-08-26T14:58:37.739960  / # #export SHELL=3D/bin/sh
    2023-08-26T14:58:37.740535  =

    2023-08-26T14:58:37.841515  / # export SHELL=3D/bin/sh. /lava-1246726/e=
nvironment
    2023-08-26T14:58:37.841944  =

    2023-08-26T14:58:37.942921  / # . /lava-1246726/environment/lava-124672=
6/bin/lava-test-runner /lava-1246726/1
    2023-08-26T14:58:37.943663  =

    2023-08-26T14:58:37.947630  / # /lava-1246726/bin/lava-test-runner /lav=
a-1246726/1
    2023-08-26T14:58:37.961021  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea12ebbe3db7eda8286da8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea12ebbe3db7eda8286dad
        failing since 150 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-26T14:58:42.155303  + set +x

    2023-08-26T14:58:42.161869  <8>[   14.518003] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11362818_1.4.2.3.1>

    2023-08-26T14:58:42.266233  / # #

    2023-08-26T14:58:42.366926  export SHELL=3D/bin/sh

    2023-08-26T14:58:42.367147  #

    2023-08-26T14:58:42.467659  / # export SHELL=3D/bin/sh. /lava-11362818/=
environment

    2023-08-26T14:58:42.467844  =


    2023-08-26T14:58:42.568412  / # . /lava-11362818/environment/lava-11362=
818/bin/lava-test-runner /lava-11362818/1

    2023-08-26T14:58:42.568707  =


    2023-08-26T14:58:42.573593  / # /lava-11362818/bin/lava-test-runner /la=
va-11362818/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea12615218f0e5d2286d8a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea12615218f0e5d2286d8f
        failing since 150 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-26T14:55:12.222009  <8>[    9.393984] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11362793_1.4.2.3.1>

    2023-08-26T14:55:12.225070  + set +x

    2023-08-26T14:55:12.326673  #

    2023-08-26T14:55:12.327029  =


    2023-08-26T14:55:12.427722  / # #export SHELL=3D/bin/sh

    2023-08-26T14:55:12.427954  =


    2023-08-26T14:55:12.528529  / # export SHELL=3D/bin/sh. /lava-11362793/=
environment

    2023-08-26T14:55:12.528778  =


    2023-08-26T14:55:12.629401  / # . /lava-11362793/environment/lava-11362=
793/bin/lava-test-runner /lava-11362793/1

    2023-08-26T14:55:12.629710  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea13754fe9ef1ed8286ef5

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea13754fe9ef1ed8286f31
        failing since 4 days (last pass: v5.10.191, first fail: v5.10.190-1=
23-gec001faa2c729)

    2023-08-26T14:59:29.609550  / # #
    2023-08-26T14:59:29.712641  export SHELL=3D/bin/sh
    2023-08-26T14:59:29.713460  #
    2023-08-26T14:59:29.815319  / # export SHELL=3D/bin/sh. /lava-71882/env=
ironment
    2023-08-26T14:59:29.816078  =

    2023-08-26T14:59:29.918086  / # . /lava-71882/environment/lava-71882/bi=
n/lava-test-runner /lava-71882/1
    2023-08-26T14:59:29.919572  =

    2023-08-26T14:59:29.933902  / # /lava-71882/bin/lava-test-runner /lava-=
71882/1
    2023-08-26T14:59:29.992679  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-26T14:59:29.993297  + cd /lava-71882/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea1396e8163ec941286daf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea1397e8163ec941286db6
        failing since 25 days (last pass: v5.10.186-10-g5f99a36aeb1c, first=
 fail: v5.10.188-107-gc262f74329e1)

    2023-08-26T15:00:21.125791  + set +x
    2023-08-26T15:00:21.126361  <8>[   83.987756] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1001124_1.5.2.4.1>
    2023-08-26T15:00:21.235396  / # #
    2023-08-26T15:00:22.706018  export SHELL=3D/bin/sh
    2023-08-26T15:00:22.727311  #
    2023-08-26T15:00:22.727877  / # export SHELL=3D/bin/sh
    2023-08-26T15:00:24.693845  / # . /lava-1001124/environment
    2023-08-26T15:00:28.310511  /lava-1001124/bin/lava-test-runner /lava-10=
01124/1
    2023-08-26T15:00:28.332384  . /lava-1001124/environment
    2023-08-26T15:00:28.332890  / # /lava-1001124/bin/lava-test-runner /lav=
a-1001124/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea14dd762374cfd728783e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope=
-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope=
-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea14dd762374cfd7287845
        failing since 39 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-26T15:05:43.000929  + set +x
    2023-08-26T15:05:43.001051  <8>[   83.932527] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1001131_1.5.2.4.1>
    2023-08-26T15:05:43.107069  / # #
    2023-08-26T15:05:44.565662  export SHELL=3D/bin/sh
    2023-08-26T15:05:44.586122  #
    2023-08-26T15:05:44.586311  / # export SHELL=3D/bin/sh
    2023-08-26T15:05:46.537858  / # . /lava-1001131/environment
    2023-08-26T15:05:50.129189  /lava-1001131/bin/lava-test-runner /lava-10=
01131/1
    2023-08-26T15:05:50.149869  . /lava-1001131/environment
    2023-08-26T15:05:50.150016  / # /lava-1001131/bin/lava-test-runner /lav=
a-1001131/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea135145ae1878ad286d8f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea135145ae1878ad286d96
        failing since 39 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-26T14:59:08.520014  / # #
    2023-08-26T14:59:09.979531  export SHELL=3D/bin/sh
    2023-08-26T14:59:09.999961  #
    2023-08-26T14:59:10.000098  / # export SHELL=3D/bin/sh
    2023-08-26T14:59:11.953824  / # . /lava-1001120/environment
    2023-08-26T14:59:15.550005  /lava-1001120/bin/lava-test-runner /lava-10=
01120/1
    2023-08-26T14:59:15.570586  . /lava-1001120/environment
    2023-08-26T14:59:15.570683  / # /lava-1001120/bin/lava-test-runner /lav=
a-1001120/1
    2023-08-26T14:59:15.649163  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-26T14:59:15.649362  + cd /lava-1001120/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea14514becd687ec286d76

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.=
txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea14514becd687ec286d7d
        failing since 39 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-26T15:02:49.013775  / # #
    2023-08-26T15:02:50.472727  export SHELL=3D/bin/sh
    2023-08-26T15:02:50.493193  #
    2023-08-26T15:02:50.493334  / # export SHELL=3D/bin/sh
    2023-08-26T15:02:52.444888  / # . /lava-1001127/environment
    2023-08-26T15:02:56.040886  /lava-1001127/bin/lava-test-runner /lava-10=
01127/1
    2023-08-26T15:02:56.061672  . /lava-1001127/environment
    2023-08-26T15:02:56.061782  / # /lava-1001127/bin/lava-test-runner /lav=
a-1001127/1
    2023-08-26T15:02:56.140289  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-26T15:02:56.140505  + cd /lava-1001127/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea12b8f7de78382c286dd3

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea12b8f7de78382c286dd8
        failing since 39 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-26T14:58:24.631126  / # #

    2023-08-26T14:58:24.733076  export SHELL=3D/bin/sh

    2023-08-26T14:58:24.733799  #

    2023-08-26T14:58:24.835093  / # export SHELL=3D/bin/sh. /lava-11362929/=
environment

    2023-08-26T14:58:24.835747  =


    2023-08-26T14:58:24.936774  / # . /lava-11362929/environment/lava-11362=
929/bin/lava-test-runner /lava-11362929/1

    2023-08-26T14:58:24.937024  =


    2023-08-26T14:58:24.938437  / # /lava-11362929/bin/lava-test-runner /la=
va-11362929/1

    2023-08-26T14:58:25.002850  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-26T14:58:25.003441  + cd /lav<8>[   16.355862] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11362929_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea12fee1b0c4e730286d6c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea12fee1b0c4e730286d71
        failing since 1 day (last pass: v5.10.191, first fail: v5.10.190-13=
6-gda59b7b5c515e)

    2023-08-26T14:57:39.317172  / # #

    2023-08-26T14:57:40.578193  export SHELL=3D/bin/sh

    2023-08-26T14:57:40.589195  #

    2023-08-26T14:57:40.589664  / # export SHELL=3D/bin/sh

    2023-08-26T14:57:42.333572  / # . /lava-11362930/environment

    2023-08-26T14:57:45.539359  /lava-11362930/bin/lava-test-runner /lava-1=
1362930/1

    2023-08-26T14:57:45.550846  . /lava-11362930/environment

    2023-08-26T14:57:45.556228  / # /lava-11362930/bin/lava-test-runner /la=
va-11362930/1

    2023-08-26T14:57:45.606206  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-26T14:57:45.606727  + cd /lava-11362930/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea12cc90ca257751286efd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
92/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea12cc90ca257751286f02
        failing since 39 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-26T14:58:40.880927  / # #

    2023-08-26T14:58:40.983210  export SHELL=3D/bin/sh

    2023-08-26T14:58:40.983915  #

    2023-08-26T14:58:41.085401  / # export SHELL=3D/bin/sh. /lava-11362926/=
environment

    2023-08-26T14:58:41.086175  =


    2023-08-26T14:58:41.187637  / # . /lava-11362926/environment/lava-11362=
926/bin/lava-test-runner /lava-11362926/1

    2023-08-26T14:58:41.188807  =


    2023-08-26T14:58:41.204708  / # /lava-11362926/bin/lava-test-runner /la=
va-11362926/1

    2023-08-26T14:58:41.262640  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-26T14:58:41.263137  + cd /lava-1136292<8>[   18.236410] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11362926_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
