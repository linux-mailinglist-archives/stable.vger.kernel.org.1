Return-Path: <stable+bounces-5173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CFC80B581
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 18:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 139D61F21116
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 17:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E547F18648;
	Sat,  9 Dec 2023 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="hHB4uUFB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4552D10DF
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 09:29:06 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2865742e256so2456503a91.0
        for <stable@vger.kernel.org>; Sat, 09 Dec 2023 09:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702142945; x=1702747745; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z8I36Rdfv3l3FQLNihPEVA2FWd+ZlW1CrQBUHGul9OU=;
        b=hHB4uUFBqmJF8YZ+rESRXfBI2VybJ90TRFzzXtbDPXjcY2W1WjskjEzJj3i7lacZ6o
         g0iPn0BK08ragkppvKl94aNUwXve2O1EbF7v/JL36gvyW+D/9QZVdceoqrdianuEwkkR
         uHJOvEwyAxg2phzPQ4vBSp1MDUa4wI+pOrr67A5gu7II1FxQAQjsBqqBKEnUL9HLP4M6
         0oQ0LJtSjqBC8aDSijSAWDaTA8GBWyoc43eqi/Q9ExaI9o+hgxTNi+5AK6e4GpELYyNN
         yG625utlK80wka+N4NqzQuLRASBdYirGo4EmM1FWWvgJurdJKWqC4kERkwkUaK3JdaF4
         3VUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702142945; x=1702747745;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8I36Rdfv3l3FQLNihPEVA2FWd+ZlW1CrQBUHGul9OU=;
        b=vTvcy3lftj2RHAede1JTGucwy4XHtRpa1PxypZVOwJM9VNYKt9Ikghqxjjr8TBJgws
         evvIhkIj7tIw4kSBM49YUQYSkcDyLvcAHOl+kVKfUDyz25q7N8kunMY4a/ZC+73PE/66
         Vhqo6oOfFo6ruKq781tVMfE6OLEG5yP97hA92zExBqa4SgO34ypiQDr3e308x9bgIyKl
         NxSPdyUOFA7yVMOg4M/njxU8CoIyrmghgaM2Wyi8HvnDQ+ntIl0rwSAyYNb1rR2a8BPd
         Tcp9h7pvX7k05JN5OLvE57WujfEM88GYw5eq7LnkzILFG0DCs0fiej1pI4cDYBTeBEUZ
         GD7Q==
X-Gm-Message-State: AOJu0Yy3fQqDbRpJV6GsdV7dw+jbpYq45mbBu1rYQ/7ba6RqJAWr5teE
	d7cCwUCBK0yLrE6hd+YeQw/P75x59mg0ebTkDPj9ZA==
X-Google-Smtp-Source: AGHT+IEkgBZrCKeJIE1zt1tkPvQgsU9dS0J2u1Tz5C+Wmv7KCNRAjQlGy2JHRztFBWiDl2j1elB/xQ==
X-Received: by 2002:a17:90a:db51:b0:286:dae6:2d0d with SMTP id u17-20020a17090adb5100b00286dae62d0dmr921818pjx.7.1702142945091;
        Sat, 09 Dec 2023 09:29:05 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a18-20020a170902ecd200b001cfc1b931a9sm3635158plh.249.2023.12.09.09.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 09:29:04 -0800 (PST)
Message-ID: <6574a3e0.170a0220.59f64.b6f0@mx.google.com>
Date: Sat, 09 Dec 2023 09:29:04 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.203-59-gaffef748422f6
Subject: stable-rc/queue/5.10 baseline: 135 runs,
 10 regressions (v5.10.203-59-gaffef748422f6)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 135 runs, 10 regressions (v5.10.203-59-gaffe=
f748422f6)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =

meson-gxbb-p200              | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =

meson-gxm-khadas-vim2        | arm64 | lab-baylibre  | gcc-10   | defconfig=
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
nel/v5.10.203-59-gaffef748422f6/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.203-59-gaffef748422f6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      affef748422f648a1a40bac8a5711a552955ad19 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/6574717a02a90959f3e13489

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gaffef748422f6/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gaffef748422f6/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6574717a02a90959f3e134bf
        failing since 298 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-09T13:53:44.975027  <8>[   19.082754] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 331224_1.5.2.4.1>
    2023-12-09T13:53:45.088882  / # #
    2023-12-09T13:53:45.191957  export SHELL=3D/bin/sh
    2023-12-09T13:53:45.192917  #
    2023-12-09T13:53:45.294997  / # export SHELL=3D/bin/sh. /lava-331224/en=
vironment
    2023-12-09T13:53:45.295913  =

    2023-12-09T13:53:45.398007  / # . /lava-331224/environment/lava-331224/=
bin/lava-test-runner /lava-331224/1
    2023-12-09T13:53:45.399471  =

    2023-12-09T13:53:45.404022  / # /lava-331224/bin/lava-test-runner /lava=
-331224/1
    2023-12-09T13:53:45.510064  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxbb-p200              | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6574738c0e99c0db71e134cb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gaffef748422f6/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-=
p200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gaffef748422f6/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-=
p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6574738c0e99c0db71e13=
4cc
        new failure (last pass: v5.10.203-46-g46c237c8ed938) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxm-khadas-vim2        | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6574738bb3e20998c5e13478

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gaffef748422f6/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-k=
hadas-vim2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gaffef748422f6/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-k=
hadas-vim2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6574738bb3e20998c5e13=
479
        new failure (last pass: v5.10.203-46-g46c237c8ed938) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
panda                        | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6574716fb48a9ca18be13557

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gaffef748422f6/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pand=
a.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gaffef748422f6/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pand=
a.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6574716fb48a9ca18be1355c
        failing since 2 days (last pass: v5.10.148-91-g23f89880f93d, first =
fail: v5.10.202-131-g761b9c32d3c8b)

    2023-12-09T13:53:42.593203  + <8>[   24.463500] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 3870835_1.5.2.4.1>
    2023-12-09T13:53:42.593419  set +x
    2023-12-09T13:53:42.697880  / # #
    2023-12-09T13:53:42.799113  export SHELL=3D/bin/sh
    2023-12-09T13:53:42.799482  #
    2023-12-09T13:53:42.900254  / # export SHELL=3D/bin/sh. /lava-3870835/e=
nvironment
    2023-12-09T13:53:42.900759  =

    2023-12-09T13:53:43.001592  / # . /lava-3870835/environment/lava-387083=
5/bin/lava-test-runner /lava-3870835/1
    2023-12-09T13:53:43.002236  =

    2023-12-09T13:53:43.007152  / # /lava-3870835/bin/lava-test-runner /lav=
a-3870835/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65747265c0f1c4654be13482

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gaffef748422f6/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gaffef748422f6/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65747265c0f1c4654be13487
        failing since 16 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-09T14:05:22.977008  / # #

    2023-12-09T14:05:23.077467  export SHELL=3D/bin/sh

    2023-12-09T14:05:23.077599  #

    2023-12-09T14:05:23.178043  / # export SHELL=3D/bin/sh. /lava-12229731/=
environment

    2023-12-09T14:05:23.178175  =


    2023-12-09T14:05:23.278636  / # . /lava-12229731/environment/lava-12229=
731/bin/lava-test-runner /lava-12229731/1

    2023-12-09T14:05:23.278904  =


    2023-12-09T14:05:23.290472  / # /lava-12229731/bin/lava-test-runner /la=
va-12229731/1

    2023-12-09T14:05:23.344238  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-09T14:05:23.344323  + cd /lav<8>[   16.399270] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12229731_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65747344eacb8a6356e1359a

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gaffef748422f6/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gaffef748422f6/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/65747344eacb8a6356e135a0
        failing since 270 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-09T14:01:48.163363  /lava-12229756/1/../bin/lava-test-case

    2023-12-09T14:01:48.173970  <8>[   34.912606] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/65747344eacb8a6356e135a1
        failing since 270 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-09T14:01:47.128762  /lava-12229756/1/../bin/lava-test-case

    2023-12-09T14:01:47.139723  <8>[   33.877470] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65747254ad3b4640afe13479

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gaffef748422f6/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gaffef748422f6/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65747254ad3b4640afe1347e
        failing since 16 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-09T13:57:30.920141  <8>[   17.017688] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447286_1.5.2.4.1>
    2023-12-09T13:57:31.025144  / # #
    2023-12-09T13:57:31.126784  export SHELL=3D/bin/sh
    2023-12-09T13:57:31.127351  #
    2023-12-09T13:57:31.228354  / # export SHELL=3D/bin/sh. /lava-447286/en=
vironment
    2023-12-09T13:57:31.228960  =

    2023-12-09T13:57:31.329967  / # . /lava-447286/environment/lava-447286/=
bin/lava-test-runner /lava-447286/1
    2023-12-09T13:57:31.330863  =

    2023-12-09T13:57:31.335241  / # /lava-447286/bin/lava-test-runner /lava=
-447286/1
    2023-12-09T13:57:31.402276  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65747276aa50d9dd79e13479

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gaffef748422f6/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gaffef748422f6/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65747276aa50d9dd79e1347e
        failing since 16 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-09T14:05:38.743729  / # #

    2023-12-09T14:05:38.845783  export SHELL=3D/bin/sh

    2023-12-09T14:05:38.846449  #

    2023-12-09T14:05:38.947758  / # export SHELL=3D/bin/sh. /lava-12229727/=
environment

    2023-12-09T14:05:38.948517  =


    2023-12-09T14:05:39.049806  / # . /lava-12229727/environment/lava-12229=
727/bin/lava-test-runner /lava-12229727/1

    2023-12-09T14:05:39.050800  =


    2023-12-09T14:05:39.067798  / # /lava-12229727/bin/lava-test-runner /la=
va-12229727/1

    2023-12-09T14:05:39.108525  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-09T14:05:39.125595  + cd /lava-1222972<8>[   18.204710] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12229727_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6574714a6b806e626ce13495

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gaffef748422f6/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-gaffef748422f6/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6574714a6b806e626ce1349a
        failing since 16 days (last pass: v5.10.165-77-g4600242c13ed, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-09T13:52:45.058938  / # #
    2023-12-09T13:52:45.160281  export SHELL=3D/bin/sh
    2023-12-09T13:52:45.160869  #
    2023-12-09T13:52:45.261912  / # export SHELL=3D/bin/sh. /lava-3870833/e=
nvironment
    2023-12-09T13:52:45.262499  =

    2023-12-09T13:52:45.363579  / # . /lava-3870833/environment/lava-387083=
3/bin/lava-test-runner /lava-3870833/1
    2023-12-09T13:52:45.364540  =

    2023-12-09T13:52:45.370758  / # /lava-3870833/bin/lava-test-runner /lav=
a-3870833/1
    2023-12-09T13:52:45.468659  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-09T13:52:45.469375  + cd /lava-3870833/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

