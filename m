Return-Path: <stable+bounces-5254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B257080C19D
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 08:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32663B20851
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 07:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14C11F602;
	Mon, 11 Dec 2023 07:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="oo4a58Sc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76990E9
	for <stable@vger.kernel.org>; Sun, 10 Dec 2023 23:01:01 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6ceb2501f1bso3312223b3a.0
        for <stable@vger.kernel.org>; Sun, 10 Dec 2023 23:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702278060; x=1702882860; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=stn8N+Y62/T8yvLt5OYkMSgqh1I6JXdL/LZ3pLrR5Z0=;
        b=oo4a58ScGtbAHBklduAmLk8zlCL+DQH91bC/DfjFA4VuGRwnmnFJEkeKxd2grop3Zb
         bAr6eL/Z82Pk8ndqf86maLkS8T5BCe1EjJ34kpcRL0N+4UVjPTDAba9qyQq67Zj//HEX
         R204dS7ti3IdSr+N9uQ2QYWVlGm918fth6eGO1IHvyiMRqUerkU+jcN9LWcaW+DoHlxe
         6Hk2799Yc54PlCswiIIohhcQ1SJMUeOD32+feDo9eezZ2+k1sbTK9UXm/A26evlyExSG
         Oz9eG6x5wO05w6+KCUg54Y/6WsJpT2gSkxlPB+JD40nPUWZyg4KqKXJUR+HjSNpOZrJv
         PRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702278060; x=1702882860;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stn8N+Y62/T8yvLt5OYkMSgqh1I6JXdL/LZ3pLrR5Z0=;
        b=evvj81r6qFlCw9JD8jvZ8jNsNMOec1Vgrfe7cxg3UlYT2uO3GYbWXPCx7b+O466ESB
         69ozYLTq1IQ7PELhUKcv5JExONYB4DsAvrBzSpYrdEznuo2g3qGZ1FUt8XY5Rp2IS2zh
         qVCuPi+FYMQGuqnDvmMWUCeJDKiuEkhsQishz/MZ3yry2ZNmbrJA8yLTUPcG9tSj9GEO
         CJSQdbjZlkI5G9mTc204Q4pgrJEIghUQVs/Hd2I7g6E+y23a4o8mW4EqQQy33NXPG55T
         j0VkkFNU6QHehmYBoWrb0y9OfhYpQnlwOuZg6hj6Hop6f/H+jtkYy5kt8nmG5Rz94lOS
         LA7w==
X-Gm-Message-State: AOJu0YwjAq0+fGjnn4ybXViHq1/54xTlmnn9lIl3y4xy1mEWKABmGWjR
	i8eQC9QNtwMfzrc0TFpVN1PpRakXzCMmfp27CDftYw==
X-Google-Smtp-Source: AGHT+IHLPgNf4U/Uorlw+cNZVWoEUu76tpHWfqBu1u9lUcFrx5Yx2XhCVSA37LXqvePA3O3+duHr+A==
X-Received: by 2002:a05:6a00:398c:b0:6cd:df27:9519 with SMTP id fi12-20020a056a00398c00b006cddf279519mr4657629pfb.34.1702278060412;
        Sun, 10 Dec 2023 23:01:00 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 64-20020a630043000000b005c65d432119sm5551781pga.67.2023.12.10.23.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 23:00:59 -0800 (PST)
Message-ID: <6576b3ab.630a0220.27c7d.eafe@mx.google.com>
Date: Sun, 10 Dec 2023 23:00:59 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.203-64-g1e733f0ca3a85
Subject: stable-rc/queue/5.10 baseline: 128 runs,
 8 regressions (v5.10.203-64-g1e733f0ca3a85)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 128 runs, 8 regressions (v5.10.203-64-g1e733=
f0ca3a85)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =

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
nel/v5.10.203-64-g1e733f0ca3a85/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.203-64-g1e733f0ca3a85
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      1e733f0ca3a85e35e63c9accc64152985e23d62c =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65767fbb8a9c695278e13483

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-64-g1e733f0ca3a85/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-64-g1e733f0ca3a85/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65767fbb8a9c695278e134b6
        failing since 300 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-11T03:19:04.914470  <8>[   20.122336] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 338073_1.5.2.4.1>
    2023-12-11T03:19:05.023758  / # #
    2023-12-11T03:19:05.125779  export SHELL=3D/bin/sh
    2023-12-11T03:19:05.126257  #
    2023-12-11T03:19:05.227560  / # export SHELL=3D/bin/sh. /lava-338073/en=
vironment
    2023-12-11T03:19:05.228034  =

    2023-12-11T03:19:05.329258  / # . /lava-338073/environment/lava-338073/=
bin/lava-test-runner /lava-338073/1
    2023-12-11T03:19:05.329609  =

    2023-12-11T03:19:05.333424  / # /lava-338073/bin/lava-test-runner /lava=
-338073/1
    2023-12-11T03:19:05.427390  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
panda                        | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65768307916fe4e4a8e13494

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-64-g1e733f0ca3a85/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pand=
a.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-64-g1e733f0ca3a85/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pand=
a.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65768307916fe4e4a8e13499
        failing since 4 days (last pass: v5.10.148-91-g23f89880f93d, first =
fail: v5.10.202-131-g761b9c32d3c8b)

    2023-12-11T03:33:07.326950  + <8>[   24.545867] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 3874765_1.5.2.4.1>
    2023-12-11T03:33:07.327163  set +x
    2023-12-11T03:33:07.431466  / # #
    2023-12-11T03:33:07.532556  export SHELL=3D/bin/sh
    2023-12-11T03:33:07.532887  #
    2023-12-11T03:33:07.633626  / # export SHELL=3D/bin/sh. /lava-3874765/e=
nvironment
    2023-12-11T03:33:07.633954  =

    2023-12-11T03:33:07.734711  / # . /lava-3874765/environment/lava-387476=
5/bin/lava-test-runner /lava-3874765/1
    2023-12-11T03:33:07.735269  =

    2023-12-11T03:33:07.740518  / # /lava-3874765/bin/lava-test-runner /lav=
a-3874765/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6576824cdc6298134fe134d7

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-64-g1e733f0ca3a85/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-64-g1e733f0ca3a85/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6576824cdc6298134fe134dc
        failing since 18 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-11T03:37:48.508415  / # #

    2023-12-11T03:37:48.610450  export SHELL=3D/bin/sh

    2023-12-11T03:37:48.611172  #

    2023-12-11T03:37:48.712638  / # export SHELL=3D/bin/sh. /lava-12240666/=
environment

    2023-12-11T03:37:48.713366  =


    2023-12-11T03:37:48.814946  / # . /lava-12240666/environment/lava-12240=
666/bin/lava-test-runner /lava-12240666/1

    2023-12-11T03:37:48.816068  =


    2023-12-11T03:37:48.817166  / # /lava-12240666/bin/lava-test-runner /la=
va-12240666/1

    2023-12-11T03:37:48.881994  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-11T03:37:48.882513  + cd /lav<8>[   16.393189] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12240666_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6576812aeb094fcf9fe134c1

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-64-g1e733f0ca3a85/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-64-g1e733f0ca3a85/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6576812aeb094fcf9fe134c7
        failing since 272 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-11T03:27:40.830673  /lava-12240455/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6576812aeb094fcf9fe134c8
        failing since 272 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-11T03:27:39.794634  /lava-12240455/1/../bin/lava-test-case

    2023-12-11T03:27:39.805285  <8>[   32.678714] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6576825edc6298134fe13528

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-64-g1e733f0ca3a85/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-64-g1e733f0ca3a85/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6576825edc6298134fe1352d
        failing since 18 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-11T03:30:20.797021  / # #
    2023-12-11T03:30:20.898714  export SHELL=3D/bin/sh
    2023-12-11T03:30:20.899264  #
    2023-12-11T03:30:21.000354  / # export SHELL=3D/bin/sh. /lava-447543/en=
vironment
    2023-12-11T03:30:21.001115  =

    2023-12-11T03:30:21.102539  / # . /lava-447543/environment/lava-447543/=
bin/lava-test-runner /lava-447543/1
    2023-12-11T03:30:21.103373  =

    2023-12-11T03:30:21.107473  / # /lava-447543/bin/lava-test-runner /lava=
-447543/1
    2023-12-11T03:30:21.175029  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-11T03:30:21.175433  + cd /lava-447543/<8>[   17.413990] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 447543_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65768260e1452a2d51e13493

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-64-g1e733f0ca3a85/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-64-g1e733f0ca3a85/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65768260e1452a2d51e13498
        failing since 18 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-11T03:38:02.315811  / # #

    2023-12-11T03:38:02.417892  export SHELL=3D/bin/sh

    2023-12-11T03:38:02.418515  #

    2023-12-11T03:38:02.519732  / # export SHELL=3D/bin/sh. /lava-12240681/=
environment

    2023-12-11T03:38:02.520397  =


    2023-12-11T03:38:02.621752  / # . /lava-12240681/environment/lava-12240=
681/bin/lava-test-runner /lava-12240681/1

    2023-12-11T03:38:02.622867  =


    2023-12-11T03:38:02.624243  / # /lava-12240681/bin/lava-test-runner /la=
va-12240681/1

    2023-12-11T03:38:02.668743  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-11T03:38:02.699391  + cd /lava-1224068<8>[   18.260643] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12240681_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/657682cf8bd1196c39e134da

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-64-g1e733f0ca3a85/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-64-g1e733f0ca3a85/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657682cf8bd1196c39e134df
        failing since 18 days (last pass: v5.10.165-77-g4600242c13ed, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-11T03:32:03.614031  / # #
    2023-12-11T03:32:03.715313  export SHELL=3D/bin/sh
    2023-12-11T03:32:03.715773  #
    2023-12-11T03:32:03.816564  / # export SHELL=3D/bin/sh. /lava-3874780/e=
nvironment
    2023-12-11T03:32:03.817028  =

    2023-12-11T03:32:03.917869  / # . /lava-3874780/environment/lava-387478=
0/bin/lava-test-runner /lava-3874780/1
    2023-12-11T03:32:03.918671  =

    2023-12-11T03:32:03.926141  / # /lava-3874780/bin/lava-test-runner /lav=
a-3874780/1
    2023-12-11T03:32:04.043130  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-11T03:32:04.043654  + cd /lava-3874780/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

