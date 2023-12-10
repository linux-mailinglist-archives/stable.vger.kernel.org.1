Return-Path: <stable+bounces-5209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E01F680BCBA
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 20:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F5B3280C6A
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 19:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7FE1B269;
	Sun, 10 Dec 2023 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="FJ6XH2xL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A7BE7
	for <stable@vger.kernel.org>; Sun, 10 Dec 2023 11:34:07 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6ceb93fb381so2415761b3a.0
        for <stable@vger.kernel.org>; Sun, 10 Dec 2023 11:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702236846; x=1702841646; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LsGoesLLhQ0C1jUDB7ftdB9iI1zPwvGaOz/w6iSTHOU=;
        b=FJ6XH2xLMI3K8NnVNBLPnIxU1plRVsbqMPK2h9o+buNudm3YXj3X6kmBllW1OapFyQ
         Rj+Zq3/UA682yhYZeBRd9DuAOR1x2Tv08FgawWr/8CRyQV8EcajHhR8lheW0Z7Lkw6m1
         qUZR/IlBs72447sa4ocjPDgFnWrFe3bu5tSQZpCgruKBEfHs0xmJw+h9yPa9n0RWnywl
         rPv6L843fWdS8aQRc5WCm0EKS7bR4shKW34GJ8kNoEjB1gOpfvzpqcKBrYYNXuqWfUAv
         iDo4sy+DOBbzY/O28mVmT+yxIDN0tyZwxlBDOZrc6OBY5ZCmOzLBhm3Bc7RM4G3ZWci2
         klGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702236846; x=1702841646;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LsGoesLLhQ0C1jUDB7ftdB9iI1zPwvGaOz/w6iSTHOU=;
        b=MHRUpyEZ27jzaGhCkMEt8GP6u0OW0yukIQVxzML0GFyoaD2a0isMRguMB9yoORfljm
         0MXVKuokirJjp6eCjQp8Nc9HDFv//XLiepi5uANNAst1YGjTIR330NXc02ZSoHC/syTh
         ze6Vjdpx1pbb1uM/28qL6Ax0JcDKKgTLMXMaMqo1W6JXFIwQHuplTR627nsNKmIEJgO5
         FYhcy4JNuaQ9ORg2xp85e2OhUoi2wFjbCERDQSGDHEn0qjEGfLB2gjEjkpY5Bq0XWenf
         OpUAq4erjpvcmDQqpqpfvbrgOu6jnIfikXBRkBBZcFsc4lHabNpofdykPINl7n3W5VH/
         FIsg==
X-Gm-Message-State: AOJu0Yz1VMdMVqQp8IKdhXqUQZ++i3xyfAzfw0u0Vm/hpc4TSm1VoMcI
	++XPPlc6w8D1J4eBog6dHsaH1DCkVYJy5/1zym/TrQ==
X-Google-Smtp-Source: AGHT+IHlsEJ/mdyfSumL/G1ilmh7iOXik9jYwG/UIv3mOejdeT37E/1qx+mFQNdsbDhOk1WchDV+iw==
X-Received: by 2002:a05:6a00:b51:b0:6cb:cd66:2102 with SMTP id p17-20020a056a000b5100b006cbcd662102mr4119750pfo.4.1702236846491;
        Sun, 10 Dec 2023 11:34:06 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z17-20020aa78891000000b006cdcfe985f2sm4996674pfe.145.2023.12.10.11.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 11:34:06 -0800 (PST)
Message-ID: <657612ae.a70a0220.ff5d1.de80@mx.google.com>
Date: Sun, 10 Dec 2023 11:34:06 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.203-59-gd6656e065a9a5
Subject: stable-rc/queue/5.10 baseline: 137 runs,
 10 regressions (v5.10.203-59-gd6656e065a9a5)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 137 runs, 10 regressions (v5.10.203-59-gd665=
6e065a9a5)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =

juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =

meson-gxbb-p200              | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =

panda                        | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =

r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =

sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
                  | 1          =

sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =

sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.203-59-gd6656e065a9a5/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.203-59-gd6656e065a9a5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      d6656e065a9a52c761a83874e2234e0b067393fb =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/6575df41bdd49b0f13e134a9

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gd6656e065a9a5/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gd6656e065a9a5/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6575df41bdd49b0f13e134dc
        failing since 299 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-10T15:54:31.758814  <8>[   16.053407] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 334632_1.5.2.4.1>
    2023-12-10T15:54:31.867944  / # #
    2023-12-10T15:54:31.970754  export SHELL=3D/bin/sh
    2023-12-10T15:54:31.971712  #
    2023-12-10T15:54:32.073932  / # export SHELL=3D/bin/sh. /lava-334632/en=
vironment
    2023-12-10T15:54:32.074844  =

    2023-12-10T15:54:32.176850  / # . /lava-334632/environment/lava-334632/=
bin/lava-test-runner /lava-334632/1
    2023-12-10T15:54:32.177908  =

    2023-12-10T15:54:32.181535  / # /lava-334632/bin/lava-test-runner /lava=
-334632/1
    2023-12-10T15:54:32.284509  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6575e0b9e4a9bd19e9e1353a

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gd6656e065a9a5/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.t=
xt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gd6656e065a9a5/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6575e0b9e4a9bd19e9e13576
        failing since 0 day (last pass: v5.10.203-59-gaffef748422f6, first =
fail: v5.10.203-59-ge7f08cc8d6a32)

    2023-12-10T16:00:24.848939  / # #
    2023-12-10T16:00:24.950617  export SHELL=3D/bin/sh
    2023-12-10T16:00:24.951189  #
    2023-12-10T16:00:25.052391  / # export SHELL=3D/bin/sh. /lava-334697/en=
vironment
    2023-12-10T16:00:25.052761  =

    2023-12-10T16:00:25.153910  / # . /lava-334697/environment/lava-334697/=
bin/lava-test-runner /lava-334697/1
    2023-12-10T16:00:25.154622  =

    2023-12-10T16:00:25.162122  / # /lava-334697/bin/lava-test-runner /lava=
-334697/1
    2023-12-10T16:00:25.194206  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-10T16:00:25.228020  + cd /lava-334697/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxbb-p200              | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6575e16f1bf64531ece134e4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gd6656e065a9a5/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-=
p200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gd6656e065a9a5/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-=
p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6575e16f1bf64531ece13=
4e5
        failing since 1 day (last pass: v5.10.203-46-g46c237c8ed938, first =
fail: v5.10.203-59-gaffef748422f6) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
panda                        | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6575dfcf03f74bf627e134b1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gd6656e065a9a5/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pand=
a.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gd6656e065a9a5/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pand=
a.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6575dfcf03f74bf627e134b6
        failing since 3 days (last pass: v5.10.148-91-g23f89880f93d, first =
fail: v5.10.202-131-g761b9c32d3c8b)

    2023-12-10T15:56:35.322294  <8>[   24.518646] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3872866_1.5.2.4.1>
    2023-12-10T15:56:35.429228  / # #
    2023-12-10T15:56:35.530645  export SHELL=3D/bin/sh
    2023-12-10T15:56:35.531107  #
    2023-12-10T15:56:35.631953  / # export SHELL=3D/bin/sh. /lava-3872866/e=
nvironment
    2023-12-10T15:56:35.632447  =

    2023-12-10T15:56:35.733314  / # . /lava-3872866/environment/lava-387286=
6/bin/lava-test-runner /lava-3872866/1
    2023-12-10T15:56:35.734060  =

    2023-12-10T15:56:35.739195  / # /lava-3872866/bin/lava-test-runner /lav=
a-3872866/1
    2023-12-10T15:56:35.797477  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6575dfdb49bf49db6fe134cc

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gd6656e065a9a5/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gd6656e065a9a5/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6575dfdc49bf49db6fe134d1
        failing since 18 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-10T16:04:42.111759  / # #

    2023-12-10T16:04:42.212233  export SHELL=3D/bin/sh

    2023-12-10T16:04:42.212385  #

    2023-12-10T16:04:42.312873  / # export SHELL=3D/bin/sh. /lava-12236417/=
environment

    2023-12-10T16:04:42.313048  =


    2023-12-10T16:04:42.413592  / # . /lava-12236417/environment/lava-12236=
417/bin/lava-test-runner /lava-12236417/1

    2023-12-10T16:04:42.413842  =


    2023-12-10T16:04:42.425646  / # /lava-12236417/bin/lava-test-runner /la=
va-12236417/1

    2023-12-10T16:04:42.478742  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-10T16:04:42.478829  + cd /lav<8>[   16.415932] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12236417_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6575e11ccc801b41ace1348e

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gd6656e065a9a5/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gd6656e065a9a5/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6575e11ccc801b41ace13494
        failing since 271 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-10T16:02:28.234559  <8>[   32.656310] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-12-10T16:02:29.258191  /lava-12236449/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6575e11ccc801b41ace13495
        failing since 271 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-10T16:02:28.221779  /lava-12236449/1/../bin/lava-test-case
   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6575dfc692ac8ea75ae1347c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gd6656e065a9a5/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gd6656e065a9a5/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6575dfc692ac8ea75ae13481
        failing since 18 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-10T15:56:44.956305  <8>[   16.961211] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447412_1.5.2.4.1>
    2023-12-10T15:56:45.061269  / # #
    2023-12-10T15:56:45.162879  export SHELL=3D/bin/sh
    2023-12-10T15:56:45.163458  #
    2023-12-10T15:56:45.264429  / # export SHELL=3D/bin/sh. /lava-447412/en=
vironment
    2023-12-10T15:56:45.265013  =

    2023-12-10T15:56:45.366012  / # . /lava-447412/environment/lava-447412/=
bin/lava-test-runner /lava-447412/1
    2023-12-10T15:56:45.366915  =

    2023-12-10T15:56:45.371431  / # /lava-447412/bin/lava-test-runner /lava=
-447412/1
    2023-12-10T15:56:45.437643  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6575dfee488ef81b47e13482

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gd6656e065a9a5/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gd6656e065a9a5/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6575dfee488ef81b47e13487
        failing since 18 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-10T16:04:58.507693  / # #

    2023-12-10T16:04:58.609844  export SHELL=3D/bin/sh

    2023-12-10T16:04:58.610560  #

    2023-12-10T16:04:58.711872  / # export SHELL=3D/bin/sh. /lava-12236416/=
environment

    2023-12-10T16:04:58.712678  =


    2023-12-10T16:04:58.814171  / # . /lava-12236416/environment/lava-12236=
416/bin/lava-test-runner /lava-12236416/1

    2023-12-10T16:04:58.815321  =


    2023-12-10T16:04:58.832130  / # /lava-12236416/bin/lava-test-runner /la=
va-12236416/1

    2023-12-10T16:04:58.872830  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-10T16:04:58.891714  + cd /lava-1223641<8>[   18.189182] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12236416_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6575df971457503ad2e13480

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gd6656e065a9a5/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gd6656e065a9a5/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6575df971457503ad2e13485
        failing since 18 days (last pass: v5.10.165-77-g4600242c13ed, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-10T15:55:55.687263  / # #
    2023-12-10T15:55:55.788487  export SHELL=3D/bin/sh
    2023-12-10T15:55:55.788860  #
    2023-12-10T15:55:55.889664  / # export SHELL=3D/bin/sh. /lava-3872869/e=
nvironment
    2023-12-10T15:55:55.890060  =

    2023-12-10T15:55:55.990889  / # . /lava-3872869/environment/lava-387286=
9/bin/lava-test-runner /lava-3872869/1
    2023-12-10T15:55:55.991529  =

    2023-12-10T15:55:55.998603  / # /lava-3872869/bin/lava-test-runner /lav=
a-3872869/1
    2023-12-10T15:55:56.092496  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-10T15:55:56.092976  + cd /lava-3872869/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

