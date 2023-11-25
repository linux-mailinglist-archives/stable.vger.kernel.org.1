Return-Path: <stable+bounces-2567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DEF7F8761
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 01:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7582B21444
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 00:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADD7631;
	Sat, 25 Nov 2023 00:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="KnF/o3O1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7A61985
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 16:52:15 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2859966cf81so569586a91.3
        for <stable@vger.kernel.org>; Fri, 24 Nov 2023 16:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700873534; x=1701478334; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ULVFSGkhMFCeYUX5EDoM/pIzWT5abn6NwA3UNEkwwOA=;
        b=KnF/o3O1j6cOxYeBvPMd4c06p20T6lPp39LyabSnuLCmJqT8KF3uA/i33/bwXRcmYu
         LXrQcvTQb2+nOSWIfbZmgFVtdCvyGN5SRmEiLRwcDglgUsNycV2JcrGUmj+3KiuZFfCJ
         xJMvVMzWkj3lnYC0fvkjBbUKQ4FDGqFLck0G6+W/vObKEBiioMERjEm0mgoxvXe4lunU
         OipjjOXkF+SiNQ29mItBy1YAiPQHBl8OmfARTijZ5dpoLXWEN+3IHJZMXam1P0BnUpKA
         t+CUli8a7jNFIt1pcLVk4t2vdzMa/NF0XHKGrQ1sesFo6NgQmLJLw5cGXsiv/gyxWfm3
         CN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700873534; x=1701478334;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ULVFSGkhMFCeYUX5EDoM/pIzWT5abn6NwA3UNEkwwOA=;
        b=MJBaNClBSDv/zaMnDrCDYj430M01s5wQUWZxVsGkA2p0UXPMb1shQ/rnWyHk7o3QRo
         pFV+nQNnljwcmtVkpW2cXvotDwCUzRlqfZz+58stN7xRlgMkk8z6qXsgZdWZOyjcaM/R
         lFhgPNRbyIvtxze0pIwOdDt18QLo/PwaQxWuaHTIyNEO2N2Ix+w532pDZqnRHY5w2/aC
         QxW4zJY9O31Q/WKYuHJqOfxCBjvZmQYyVf+zmud2W8bABfNN+Y9bB9M7Lc4BD79DVroU
         S2JlUkc+0M93IdXgIwM3qdeH+f0u4SWJvKRHveRFR+kAje37gTjfWZUxiTV/75oYI8I/
         1c8Q==
X-Gm-Message-State: AOJu0YyfP46OTK36phByNYPj0BbQl96irZQoNvdr2u8GbVfuyKmaSXKj
	vx+zMjfD1lIy7NZ/8LRVREqXweHYcibuxF0br/E=
X-Google-Smtp-Source: AGHT+IE7KWVmZsg7frvvizSqNfx/d3n4gXan2WOeC7nhY3RCBWUccTWSe0lvQI/OTcN3YTtz3Hxmww==
X-Received: by 2002:a17:90b:224f:b0:27e:1ea0:c6fc with SMTP id hk15-20020a17090b224f00b0027e1ea0c6fcmr4542221pjb.6.1700873534446;
        Fri, 24 Nov 2023 16:52:14 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ee8900b001ca86a9caccsm3768877pld.228.2023.11.24.16.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 16:52:14 -0800 (PST)
Message-ID: <6561453e.170a0220.60bc3.9a98@mx.google.com>
Date: Fri, 24 Nov 2023 16:52:14 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.201-193-ge62bfc5f33f27
Subject: stable-rc/queue/5.10 baseline: 123 runs,
 8 regressions (v5.10.201-193-ge62bfc5f33f27)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 123 runs, 8 regressions (v5.10.201-193-ge62b=
fc5f33f27)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 1          =

hp-14-db0003na-grunt         | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                  | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                  | 1          =

sun50i-h6-pine-h64           | arm64  | lab-clabbe    | gcc-10   | defconfi=
g                  | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                  | 1          =

sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig         | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.201-193-ge62bfc5f33f27/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.201-193-ge62bfc5f33f27
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      e62bfc5f33f27d28a42a549b9999c8ebe5d52db6 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/656114b062435a25b57e4a6f

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-193-ge62bfc5f33f27/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-193-ge62bfc5f33f27/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656114b162435a25b57e4aa4
        failing since 283 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-11-24T21:24:41.389410  <8>[   19.426299] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 270811_1.5.2.4.1>
    2023-11-24T21:24:41.498469  / # #
    2023-11-24T21:24:41.600488  export SHELL=3D/bin/sh
    2023-11-24T21:24:41.600981  #
    2023-11-24T21:24:41.702572  / # export SHELL=3D/bin/sh. /lava-270811/en=
vironment
    2023-11-24T21:24:41.703162  =

    2023-11-24T21:24:41.805031  / # . /lava-270811/environment/lava-270811/=
bin/lava-test-runner /lava-270811/1
    2023-11-24T21:24:41.805840  =

    2023-11-24T21:24:41.810684  / # /lava-270811/bin/lava-test-runner /lava=
-270811/1
    2023-11-24T21:24:41.918098  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-14-db0003na-grunt         | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/656113b056de7721b77e4a7a

  Results:     17 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-193-ge62bfc5f33f27/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/=
baseline-hp-14-db0003na-grunt.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-193-ge62bfc5f33f27/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/=
baseline-hp-14-db0003na-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/656113b056de772=
1b77e4a7d
        new failure (last pass: v5.10.201-162-gad3ccce275e56)
        1 lines

    2023-11-24T21:20:44.567166  kern  :emerg : __common_interrupt: 1.55 No =
irq handler for vector

    2023-11-24T21:20:44.577290  <8>[   10.320725] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D1>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656113064ce2ab1f977e4b3d

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-193-ge62bfc5f33f27/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.=
txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-193-ge62bfc5f33f27/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656113064ce2ab1f977e4b7c
        failing since 2 days (last pass: v5.10.181-18-g1622068b57a4, first =
fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-24T21:17:35.634731  / # #
    2023-11-24T21:17:35.737734  export SHELL=3D/bin/sh
    2023-11-24T21:17:35.738573  #
    2023-11-24T21:17:35.841002  / # export SHELL=3D/bin/sh. /lava-270782/en=
vironment
    2023-11-24T21:17:35.841864  =

    2023-11-24T21:17:35.943954  / # . /lava-270782/environment/lava-270782/=
bin/lava-test-runner /lava-270782/1
    2023-11-24T21:17:35.945304  =

    2023-11-24T21:17:35.956902  / # /lava-270782/bin/lava-test-runner /lava=
-270782/1
    2023-11-24T21:17:36.018718  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-24T21:17:36.019236  + cd /lava-270782/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656112711bdf144a387e4a8a

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-193-ge62bfc5f33f27/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-193-ge62bfc5f33f27/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656112711bdf144a387e4a93
        failing since 2 days (last pass: v5.10.181-18-g1622068b57a4, first =
fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-24T21:21:47.688172  / # #

    2023-11-24T21:21:47.789030  export SHELL=3D/bin/sh

    2023-11-24T21:21:47.789844  #

    2023-11-24T21:21:47.891242  / # export SHELL=3D/bin/sh. /lava-12078695/=
environment

    2023-11-24T21:21:47.892031  =


    2023-11-24T21:21:47.993340  / # . /lava-12078695/environment/lava-12078=
695/bin/lava-test-runner /lava-12078695/1

    2023-11-24T21:21:47.994587  =


    2023-11-24T21:21:48.002168  / # /lava-12078695/bin/lava-test-runner /la=
va-12078695/1

    2023-11-24T21:21:48.061450  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-24T21:21:48.061959  + cd /lav<8>[   16.467770] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12078695_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656112a66da25ce2e17e4a8f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-193-ge62bfc5f33f27/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-ro=
ck-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-193-ge62bfc5f33f27/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-ro=
ck-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656112a66da25ce2e17e4a98
        failing since 2 days (last pass: v5.10.181-18-g1622068b57a4, first =
fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-24T21:19:51.922736  / # #

    2023-11-24T21:19:53.183447  export SHELL=3D/bin/sh

    2023-11-24T21:19:53.194421  #

    2023-11-24T21:19:53.194956  / # export SHELL=3D/bin/sh

    2023-11-24T21:19:54.938021  / # . /lava-12078708/environment

    2023-11-24T21:19:58.142353  /lava-12078708/bin/lava-test-runner /lava-1=
2078708/1

    2023-11-24T21:19:58.153875  . /lava-12078708/environment

    2023-11-24T21:19:58.156444  / # /lava-12078708/bin/lava-test-runner /la=
va-12078708/1

    2023-11-24T21:19:58.208418  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-24T21:19:58.208917  + cd /lava-12078708/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-clabbe    | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65611273e19798dabe7e4a88

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-193-ge62bfc5f33f27/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-193-ge62bfc5f33f27/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65611273e19798dabe7e4a91
        failing since 2 days (last pass: v5.10.176-241-ga0049fd9c865, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-24T21:15:22.135919  / # #
    2023-11-24T21:15:22.237367  export SHELL=3D/bin/sh
    2023-11-24T21:15:22.238031  #
    2023-11-24T21:15:22.339028  / # export SHELL=3D/bin/sh. /lava-445184/en=
vironment
    2023-11-24T21:15:22.339726  =

    2023-11-24T21:15:22.440827  / # . /lava-445184/environment/lava-445184/=
bin/lava-test-runner /lava-445184/1
    2023-11-24T21:15:22.441654  =

    2023-11-24T21:15:22.446341  / # /lava-445184/bin/lava-test-runner /lava=
-445184/1
    2023-11-24T21:15:22.513768  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-24T21:15:22.514204  + cd /lava-445184/<8>[   17.529975] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 445184_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65611284175847c4047e4a83

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-193-ge62bfc5f33f27/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-193-ge62bfc5f33f27/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65611284175847c4047e4a8c
        failing since 2 days (last pass: v5.10.176-241-ga0049fd9c865, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-24T21:22:03.210006  / # #

    2023-11-24T21:22:03.312013  export SHELL=3D/bin/sh

    2023-11-24T21:22:03.312242  #

    2023-11-24T21:22:03.413015  / # export SHELL=3D/bin/sh. /lava-12078700/=
environment

    2023-11-24T21:22:03.413243  =


    2023-11-24T21:22:03.513853  / # . /lava-12078700/environment/lava-12078=
700/bin/lava-test-runner /lava-12078700/1

    2023-11-24T21:22:03.514184  =


    2023-11-24T21:22:03.520740  / # /lava-12078700/bin/lava-test-runner /la=
va-12078700/1

    2023-11-24T21:22:03.585798  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-24T21:22:03.585965  + cd /lava-1207870<8>[   18.143609] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12078700_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/656111531b67d8fa667e4a6f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-193-ge62bfc5f33f27/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-193-ge62bfc5f33f27/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656111531b67d8fa667e4a78
        failing since 2 days (last pass: v5.10.165-77-g4600242c13ed, first =
fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-24T21:10:22.895331  <8>[    8.506246] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3845959_1.5.2.4.1>
    2023-11-24T21:10:23.013598  / # #
    2023-11-24T21:10:23.114700  export SHELL=3D/bin/sh
    2023-11-24T21:10:23.115036  #
    2023-11-24T21:10:23.215800  / # export SHELL=3D/bin/sh. /lava-3845959/e=
nvironment
    2023-11-24T21:10:23.216179  =

    2023-11-24T21:10:23.316981  / # . /lava-3845959/environment/lava-384595=
9/bin/lava-test-runner /lava-3845959/1
    2023-11-24T21:10:23.317564  =

    2023-11-24T21:10:23.326885  / # /lava-3845959/bin/lava-test-runner /lav=
a-3845959/1
    2023-11-24T21:10:23.423917  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20

