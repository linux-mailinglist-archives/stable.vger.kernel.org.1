Return-Path: <stable+bounces-3830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7755802A83
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 04:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43BB1C2090E
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 03:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772FC20FB;
	Mon,  4 Dec 2023 03:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="NY7NM3Yz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C038F0
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 19:26:12 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6ce557298f6so105094b3a.3
        for <stable@vger.kernel.org>; Sun, 03 Dec 2023 19:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701660371; x=1702265171; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rPNal2oDpSsk72yFkYh5rRnIdGnczlTggPdbg0qVur8=;
        b=NY7NM3YzNk0sYZDnM6A1D093zzNO5N0+0+V/35t0WznYD1l6tjNoxhaukJ9AJL1jw3
         xdq8H/lT17SyKXLFAgNCSqejTRA29ZGYIsKQZC1sH4x/RVXlsOE5osTayzYcjBIeW0R2
         LXEtBfMOYCzTAICexmAR/Ij4JJSPxqWRF2YDv02s8QsJMK5fT/L9iJq7OTs73SOCej0q
         vTKJEahpknx+kXj+qXYFZCdELjGWNfnJDtxNpnd0NnTsuGdZm1z7A7CvJ2bjlKYJ7JP7
         Dt+COA7JiqdlBlNie30N20uLjX5tp50OXrCM2934h2wt2BuwznXdQ1vsOE7b8Hex7WJK
         YrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701660371; x=1702265171;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rPNal2oDpSsk72yFkYh5rRnIdGnczlTggPdbg0qVur8=;
        b=JTCHlK9fdlrG8Pt4jrg342gHVeKWvpLrG7RjMceMJUa/o/3QHmQUiIBBKMcyRU59XX
         LdZDvx8pQF7ISe8nT0zK8Tqtz1HX9qmYo0h4NBq3J2S7Yzh7VCuHAFoxnv/2QJ2wwOwX
         Spnyn2rU1WRxzfSKb7PI+KDo74nKMllc3Z5eg0TtLs+TGRbTu6P2vTuj30Dcq7sD0vYK
         c6Jz8fGBHvahbYFVW9vSbRzacOLAy8hUM/GcR4f8ok2a9j5CqOhpmxQUxwTwdfB7tSw9
         jNWRuNrwHRJ57gcGaBh7nfKB+r8gxezNw+rm6iaH/5zcWARb0a3skN2RaVvAkT2NKNth
         CnNQ==
X-Gm-Message-State: AOJu0YzbMhtzycWn4n9xpfuYJ6FmFOYX8zVXN6GFdPnf4b42eNubROcd
	pSb3Y2IWY+u1LrcU5eUn060GWEtQhTmAbBrRPEn/Mg==
X-Google-Smtp-Source: AGHT+IFQbwaZs0pBYH4p2J096Z8gm1fDItDLKSJzU2Q1X70D7JF3awdG2ZeqJGE00DkynLQGl6juIQ==
X-Received: by 2002:a05:6a00:1906:b0:6ce:2732:1dff with SMTP id y6-20020a056a00190600b006ce27321dffmr1534208pfi.57.1701660371391;
        Sun, 03 Dec 2023 19:26:11 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n48-20020a056a000d7000b006ce39a397b9sm2532824pfv.48.2023.12.03.19.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 19:26:10 -0800 (PST)
Message-ID: <656d46d2.050a0220.660b2.4e57@mx.google.com>
Date: Sun, 03 Dec 2023 19:26:10 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.202-128-g422323f36804e
Subject: stable-rc/queue/5.10 baseline: 136 runs,
 8 regressions (v5.10.202-128-g422323f36804e)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 136 runs, 8 regressions (v5.10.202-128-g4223=
23f36804e)

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
nel/v5.10.202-128-g422323f36804e/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.202-128-g422323f36804e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      422323f36804eec1bcba0ea3e9af2ba91eabcb58 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/656d1496004ee23e00e13476

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-128-g422323f36804e/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-128-g422323f36804e/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656d1496004ee23e00e134af
        failing since 293 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-03T23:51:30.541987  <8>[   15.690438] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 303509_1.5.2.4.1>
    2023-12-03T23:51:30.651127  / # #
    2023-12-03T23:51:30.752841  export SHELL=3D/bin/sh
    2023-12-03T23:51:30.753328  #
    2023-12-03T23:51:30.854664  / # export SHELL=3D/bin/sh. /lava-303509/en=
vironment
    2023-12-03T23:51:30.855158  =

    2023-12-03T23:51:30.956520  / # . /lava-303509/environment/lava-303509/=
bin/lava-test-runner /lava-303509/1
    2023-12-03T23:51:30.957247  =

    2023-12-03T23:51:30.961681  / # /lava-303509/bin/lava-test-runner /lava=
-303509/1
    2023-12-03T23:51:31.063530  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656d180c0eff7e5480e13478

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-128-g422323f36804e/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.=
txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-128-g422323f36804e/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656d180d0eff7e5480e134b2
        failing since 0 day (last pass: v5.10.202-69-g560a93e9d1ce3, first =
fail: v5.10.202-78-ga6f1d8d78e2ed)

    2023-12-04T00:06:07.875503  / # #
    2023-12-04T00:06:07.978242  export SHELL=3D/bin/sh
    2023-12-04T00:06:07.979012  #
    2023-12-04T00:06:08.080945  / # export SHELL=3D/bin/sh. /lava-303651/en=
vironment
    2023-12-04T00:06:08.081704  =

    2023-12-04T00:06:08.183712  / # . /lava-303651/environment/lava-303651/=
bin/lava-test-runner /lava-303651/1
    2023-12-04T00:06:08.185022  =

    2023-12-04T00:06:08.199221  / # /lava-303651/bin/lava-test-runner /lava=
-303651/1
    2023-12-04T00:06:08.258153  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-04T00:06:08.258655  + cd /lava-303651/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656d15363936183f72e134dc

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-128-g422323f36804e/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-128-g422323f36804e/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656d15363936183f72e134e5
        failing since 11 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-04T00:00:49.384704  / # #

    2023-12-04T00:00:49.486772  export SHELL=3D/bin/sh

    2023-12-04T00:00:49.487492  #

    2023-12-04T00:00:49.588906  / # export SHELL=3D/bin/sh. /lava-12172958/=
environment

    2023-12-04T00:00:49.589649  =


    2023-12-04T00:00:49.690953  / # . /lava-12172958/environment/lava-12172=
958/bin/lava-test-runner /lava-12172958/1

    2023-12-04T00:00:49.691932  =


    2023-12-04T00:00:49.709010  / # /lava-12172958/bin/lava-test-runner /la=
va-12172958/1

    2023-12-04T00:00:49.757663  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-04T00:00:49.758142  + cd /lav<8>[   16.391290] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12172958_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/656d161b00686724abe13565

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-128-g422323f36804e/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-128-g422323f36804e/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/656d161b00686724abe1356f
        failing since 264 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-03T23:58:25.175197  <8>[   34.108226] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-12-03T23:58:26.199749  /lava-12172994/1/../bin/lava-test-case

    2023-12-03T23:58:26.210840  <8>[   35.145329] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/656d161b00686724abe13570
        failing since 264 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-03T23:58:25.163736  /lava-12172994/1/../bin/lava-test-case
   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656d1522c28c219c62e13479

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-128-g422323f36804e/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-128-g422323f36804e/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656d1522c28c219c62e13482
        failing since 11 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-03T23:53:59.269685  / # #
    2023-12-03T23:53:59.371381  export SHELL=3D/bin/sh
    2023-12-03T23:53:59.372258  #
    2023-12-03T23:53:59.473350  / # export SHELL=3D/bin/sh. /lava-446445/en=
vironment
    2023-12-03T23:53:59.474159  =

    2023-12-03T23:53:59.575522  / # . /lava-446445/environment/lava-446445/=
bin/lava-test-runner /lava-446445/1
    2023-12-03T23:53:59.576526  =

    2023-12-03T23:53:59.579690  / # /lava-446445/bin/lava-test-runner /lava=
-446445/1
    2023-12-03T23:53:59.611721  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-03T23:53:59.648009  + cd /lava-446445/<8>[   17.415685] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 446445_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656d154bd727f78fbbe13480

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-128-g422323f36804e/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-128-g422323f36804e/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656d154bd727f78fbbe13489
        failing since 11 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-04T00:01:06.377339  / # #

    2023-12-04T00:01:06.479536  export SHELL=3D/bin/sh

    2023-12-04T00:01:06.480379  #

    2023-12-04T00:01:06.581705  / # export SHELL=3D/bin/sh. /lava-12172965/=
environment

    2023-12-04T00:01:06.582391  =


    2023-12-04T00:01:06.683754  / # . /lava-12172965/environment/lava-12172=
965/bin/lava-test-runner /lava-12172965/1

    2023-12-04T00:01:06.684852  =


    2023-12-04T00:01:06.701602  / # /lava-12172965/bin/lava-test-runner /la=
va-12172965/1

    2023-12-04T00:01:06.745671  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-04T00:01:06.759643  + cd /lava-1217296<8>[   18.196598] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12172965_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/656d148a78e0968d76e13491

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-128-g422323f36804e/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-128-g422323f36804e/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656d148a78e0968d76e1349a
        failing since 11 days (last pass: v5.10.165-77-g4600242c13ed, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-03T23:51:26.505104  / # #
    2023-12-03T23:51:26.606424  export SHELL=3D/bin/sh
    2023-12-03T23:51:26.606846  #
    2023-12-03T23:51:26.707746  / # export SHELL=3D/bin/sh. /lava-3859542/e=
nvironment
    2023-12-03T23:51:26.708715  =

    2023-12-03T23:51:26.810110  / # . /lava-3859542/environment/lava-385954=
2/bin/lava-test-runner /lava-3859542/1
    2023-12-03T23:51:26.810904  =

    2023-12-03T23:51:26.817238  / # /lava-3859542/bin/lava-test-runner /lav=
a-3859542/1
    2023-12-03T23:51:26.905192  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-03T23:51:26.905557  + cd /lava-3859542/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

