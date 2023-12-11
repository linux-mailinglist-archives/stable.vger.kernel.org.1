Return-Path: <stable+bounces-5271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C516B80C4B9
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 10:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6C511C20A5E
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 09:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBD521367;
	Mon, 11 Dec 2023 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="rUhACjqc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABB2CE
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 01:33:38 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6ce32821a53so2204228b3a.0
        for <stable@vger.kernel.org>; Mon, 11 Dec 2023 01:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702287217; x=1702892017; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sYiVZQi3PwcZ/ApQjeYArEyjUgAbiVcdnuhZd4r1m7M=;
        b=rUhACjqcoTjuPrMHfazO3Xi8+GS6m1O1XX8tv6jPhlPWywJvmQJMXQYeZEqW4BRt4F
         xdo9siEFPctoGjaf/pEgE9GfpoWfq0m9KoLieWhc97lKlHE4LqDzmAPM4J/77jGySAqG
         iqicarE+dTYeodFGODvO9e6fSTiklVtJAFzX2lMJl5KsqRSmGWSY8Wp/cCyUUQtIfhLd
         fxSK0hyNpPvkPMjxdTXvVT7UZEB35qJyVRB8R+5axJ6XWXdO5Aelv8k5UHw9hcvQD/R5
         iaWeZqz9srHRy6NzEuwtb+te+2EjXPHBorEGxZQbJ68t7Sx79fcp3+O606Dq5dDWZhuH
         2GiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702287217; x=1702892017;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sYiVZQi3PwcZ/ApQjeYArEyjUgAbiVcdnuhZd4r1m7M=;
        b=sf1oHOkhAwnvMqHLAjNgYK9SAIdE0Nmq7cOGntRLKSHHHZx8wwBJSb3nFqT6HHTWzy
         R1eRc1lZokt+iaLEN6zRXLz4C8LYEhxi02ALfVNfVB81FGtsLlb9ONHtHMtXylQz6Dji
         kgkHiVviVWDE0Af8hHTO7OArAKh+c6ll3iuvPvD9kxY9q/hxzq/J0zvR+06iSxQqToa1
         LbakRsLV2Wh9OtyPBckjAUkWJNrmJdP+TyNk0eQcfoZQNW1pldo2ZolFEB2Fc81p/ZJS
         fgEq13zdvr8xZlhlQGDEhyHP4eKgAYNKUzTfw4oZHuKRJkX2uYTl0XiA4w81gPaTCVxM
         jKeQ==
X-Gm-Message-State: AOJu0Ywc86pgRTmXCsUtssl40xSV6/oeXdXbk2EfvCifdc3lI9huiDt8
	ZjfqauaRu/Vq/V63FAjREJnI7Uq56SJWbbgHHlxUHA==
X-Google-Smtp-Source: AGHT+IEGtj9GzsLH891p9NOoLwVMY0QT0LhNXj6gJnZHV9niT2wG5WnUBboVsyN0Y/44kf2LONt7eg==
X-Received: by 2002:a05:6a20:7b29:b0:18b:386a:46a5 with SMTP id s41-20020a056a207b2900b0018b386a46a5mr1357272pzh.17.1702287216989;
        Mon, 11 Dec 2023 01:33:36 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id qa6-20020a17090b4fc600b0028613dcb810sm6548152pjb.23.2023.12.11.01.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 01:33:36 -0800 (PST)
Message-ID: <6576d770.170a0220.afda8.11de@mx.google.com>
Date: Mon, 11 Dec 2023 01:33:36 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.203-68-g1957c51c03d64
Subject: stable-rc/queue/5.10 baseline: 130 runs,
 9 regressions (v5.10.203-68-g1957c51c03d64)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 130 runs, 9 regressions (v5.10.203-68-g1957c=
51c03d64)

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
nel/v5.10.203-68-g1957c51c03d64/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.203-68-g1957c51c03d64
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      1957c51c03d64ed3c89ad11b8c32f96b387c6a74 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/6576a6e4be742c23a6e134d6

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-68-g1957c51c03d64/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-68-g1957c51c03d64/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6576a6e5be742c23a6e13506
        failing since 300 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-11T06:06:09.110117  + set +x
    2023-12-11T06:06:09.118199  <8>[   15.717383] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 339057_1.5.2.4.1>
    2023-12-11T06:06:09.221541  / # #
    2023-12-11T06:06:09.322984  export SHELL=3D/bin/sh
    2023-12-11T06:06:09.323356  #
    2023-12-11T06:06:09.424491  / # export SHELL=3D/bin/sh. /lava-339057/en=
vironment
    2023-12-11T06:06:09.424875  =

    2023-12-11T06:06:09.526035  / # . /lava-339057/environment/lava-339057/=
bin/lava-test-runner /lava-339057/1
    2023-12-11T06:06:09.526583  =

    2023-12-11T06:06:09.529847  / # /lava-339057/bin/lava-test-runner /lava=
-339057/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6576a5fd6988458c68e13503

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-68-g1957c51c03d64/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.t=
xt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-68-g1957c51c03d64/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6576a5fe6988458c68e1353f
        new failure (last pass: v5.10.203-64-g1e733f0ca3a85)

    2023-12-11T06:02:12.794577  / # #
    2023-12-11T06:02:12.897396  export SHELL=3D/bin/sh
    2023-12-11T06:02:12.898185  #
    2023-12-11T06:02:13.000143  / # export SHELL=3D/bin/sh. /lava-339029/en=
vironment
    2023-12-11T06:02:13.000972  =

    2023-12-11T06:02:13.103071  / # . /lava-339029/environment/lava-339029/=
bin/lava-test-runner /lava-339029/1
    2023-12-11T06:02:13.104403  =

    2023-12-11T06:02:13.118579  / # /lava-339029/bin/lava-test-runner /lava=
-339029/1
    2023-12-11T06:02:13.177404  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-11T06:02:13.177924  + cd /lava-339029/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
panda                        | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6576a33bb36fe1a6cbe134b3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-68-g1957c51c03d64/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pand=
a.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-68-g1957c51c03d64/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pand=
a.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6576a33bb36fe1a6cbe134b8
        failing since 4 days (last pass: v5.10.148-91-g23f89880f93d, first =
fail: v5.10.202-131-g761b9c32d3c8b)

    2023-12-11T05:50:33.477370  + <8>[   24.581451] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 3875153_1.5.2.4.1>
    2023-12-11T05:50:33.477589  set +x
    2023-12-11T05:50:33.582031  / # #
    2023-12-11T05:50:33.683276  export SHELL=3D/bin/sh
    2023-12-11T05:50:33.683686  #
    2023-12-11T05:50:33.784522  / # export SHELL=3D/bin/sh. /lava-3875153/e=
nvironment
    2023-12-11T05:50:33.784976  =

    2023-12-11T05:50:33.885814  / # . /lava-3875153/environment/lava-387515=
3/bin/lava-test-runner /lava-3875153/1
    2023-12-11T05:50:33.886529  =

    2023-12-11T05:50:33.891424  / # /lava-3875153/bin/lava-test-runner /lav=
a-3875153/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6576c23e144f1e5767e13480

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-68-g1957c51c03d64/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-68-g1957c51c03d64/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6576c23f144f1e5767e13485
        failing since 18 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-11T08:10:24.764946  / # #

    2023-12-11T08:10:24.866644  export SHELL=3D/bin/sh

    2023-12-11T08:10:24.866873  #

    2023-12-11T08:10:24.967410  / # export SHELL=3D/bin/sh. /lava-12242705/=
environment

    2023-12-11T08:10:24.967620  =


    2023-12-11T08:10:25.068140  / # . /lava-12242705/environment/lava-12242=
705/bin/lava-test-runner /lava-12242705/1

    2023-12-11T08:10:25.068455  =


    2023-12-11T08:10:25.078445  / # /lava-12242705/bin/lava-test-runner /la=
va-12242705/1

    2023-12-11T08:10:25.120354  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-11T08:10:25.137953  + cd /lav<8>[   16.478184] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12242705_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6576a4c80a3c48d99ae13476

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-68-g1957c51c03d64/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-68-g1957c51c03d64/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6576a4c80a3c48d99ae1347c
        failing since 272 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-11T05:57:11.850322  <8>[   32.351584] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-12-11T05:57:12.876285  /lava-12242692/1/../bin/lava-test-case

    2023-12-11T05:57:12.887624  <8>[   33.388678] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6576a4c80a3c48d99ae1347d
        failing since 272 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-11T05:57:10.815447  <8>[   31.315789] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-12-11T05:57:11.839344  /lava-12242692/1/../bin/lava-test-case
   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6576a47d8b75bc5ba6e13491

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-68-g1957c51c03d64/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-68-g1957c51c03d64/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6576a47d8b75bc5ba6e13496
        failing since 18 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-11T05:56:04.657518  <8>[   16.942375] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447569_1.5.2.4.1>
    2023-12-11T05:56:04.762493  / # #
    2023-12-11T05:56:04.864139  export SHELL=3D/bin/sh
    2023-12-11T05:56:04.864863  #
    2023-12-11T05:56:04.965869  / # export SHELL=3D/bin/sh. /lava-447569/en=
vironment
    2023-12-11T05:56:04.966491  =

    2023-12-11T05:56:05.067500  / # . /lava-447569/environment/lava-447569/=
bin/lava-test-runner /lava-447569/1
    2023-12-11T05:56:05.068427  =

    2023-12-11T05:56:05.072722  / # /lava-447569/bin/lava-test-runner /lava=
-447569/1
    2023-12-11T05:56:05.139852  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6576a49e44fa9c0a91e134dd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-68-g1957c51c03d64/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-68-g1957c51c03d64/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6576a49e44fa9c0a91e134e2
        failing since 18 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-11T06:04:13.962298  / # #

    2023-12-11T06:04:14.064368  export SHELL=3D/bin/sh

    2023-12-11T06:04:14.064955  #

    2023-12-11T06:04:14.166241  / # export SHELL=3D/bin/sh. /lava-12242707/=
environment

    2023-12-11T06:04:14.167009  =


    2023-12-11T06:04:14.268383  / # . /lava-12242707/environment/lava-12242=
707/bin/lava-test-runner /lava-12242707/1

    2023-12-11T06:04:14.269374  =


    2023-12-11T06:04:14.286039  / # /lava-12242707/bin/lava-test-runner /la=
va-12242707/1

    2023-12-11T06:04:14.328744  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-11T06:04:14.343835  + cd /lava-1224270<8>[   18.211231] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12242707_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6576a303c515895160e134c3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-68-g1957c51c03d64/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-68-g1957c51c03d64/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6576a303c515895160e134c8
        failing since 18 days (last pass: v5.10.165-77-g4600242c13ed, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-11T05:49:30.428210  / # #
    2023-12-11T05:49:30.529287  export SHELL=3D/bin/sh
    2023-12-11T05:49:30.529645  #
    2023-12-11T05:49:30.630412  / # export SHELL=3D/bin/sh. /lava-3875159/e=
nvironment
    2023-12-11T05:49:30.630767  =

    2023-12-11T05:49:30.731554  / # . /lava-3875159/environment/lava-387515=
9/bin/lava-test-runner /lava-3875159/1
    2023-12-11T05:49:30.732126  =

    2023-12-11T05:49:30.740300  / # /lava-3875159/bin/lava-test-runner /lav=
a-3875159/1
    2023-12-11T05:49:30.835184  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-11T05:49:30.835586  + cd /lava-3875159/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

