Return-Path: <stable+bounces-5229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5D880BED5
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 02:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A15501C20946
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 01:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C32C2C6;
	Mon, 11 Dec 2023 01:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="u2/+gbjD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82194D5
	for <stable@vger.kernel.org>; Sun, 10 Dec 2023 17:45:48 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2851a2b30a2so2747802a91.3
        for <stable@vger.kernel.org>; Sun, 10 Dec 2023 17:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702259147; x=1702863947; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uJP4EEIRJ93VrlAQ5k1mw4mAT9FNmPUIZINMSxcThlM=;
        b=u2/+gbjD/2dAjmfCojXkDz98I58de4ilvrnhr2lgks4nhpX1qOnUamfS4lzJnjKWYH
         RQyCB5SVCEWE3NwCOQQJizMbnk+sC00xkFwyW1RGkApJ3K8fyjnxWY+fpkYtzvMviqRD
         6bUWQoK1TIdlUMqWJ09aqxc88jl7QeWyqp86RFFYcwMATIS8b5jfckxSWUfZk2lYr3VT
         ZlbhUmWFqmPYZMDClzp3MR4dvqDvHs4qN2PqCyLYXdVNpy2x851zUZ79WQrdVp2YE2eb
         KslIBiA/PJC9rYG61oVKIqATV9rLuFVNB16VCHzUKA5iM0f842iMMDbQj53m4l9fM0nJ
         91sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702259147; x=1702863947;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJP4EEIRJ93VrlAQ5k1mw4mAT9FNmPUIZINMSxcThlM=;
        b=T+jVZGcNbUgR4p+lodomE3sANFL5lXDWG8HxQ5D379N3Z+CkLQYvO1vmZBrY83nR9Q
         7C2nL0+Da3uXnQQnvVvLVANnFSlzNIbIaCwNYy1m43tSCcgaqf/AzB/u5grMjnxtJSSC
         2Zy1VP2YS8F/k/wNON03vODaKEqHsJqIpRHM4WLQAqavn8skctWKaLs7wu3g1waLUcCx
         QhuvL0Nc/wg9l9DEChqpLHrlxzUGjDrMLlCim175ndjsF/Z1yewtAWdG2S1fUuLoK+Ly
         RXjsLua+C8c5zzJdBD+mFyOvQFw3fSCbEwKLnKLUjJCQqde2Ad0qgCuNLdjlRGyzeDza
         qx+Q==
X-Gm-Message-State: AOJu0YybpzhWHaipsRHkMfzm8FrNfbi2xYjF5Rvc8bDo6VsWhqGVANsn
	LK3E0Kjy7UY1k48RKvhaanoHl8fj9gi1dO2fBvC2VQ==
X-Google-Smtp-Source: AGHT+IEzagjK77A2WPJdgzuqaW0sA9x1h5LolcCEAhg7lYEcL1yyFbXo4Y+iRS9Jfaz69f6spDlEYQ==
X-Received: by 2002:a17:90a:c24d:b0:286:ab89:837d with SMTP id d13-20020a17090ac24d00b00286ab89837dmr1303572pjx.48.1702259147450;
        Sun, 10 Dec 2023 17:45:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id qj12-20020a17090b28cc00b0028672a85808sm5654181pjb.35.2023.12.10.17.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 17:45:46 -0800 (PST)
Message-ID: <657669ca.170a0220.95034.025b@mx.google.com>
Date: Sun, 10 Dec 2023 17:45:46 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.203-64-g453204030d159
Subject: stable-rc/queue/5.10 baseline: 128 runs,
 9 regressions (v5.10.203-64-g453204030d159)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 128 runs, 9 regressions (v5.10.203-64-g45320=
4030d159)

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
nel/v5.10.203-64-g453204030d159/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.203-64-g453204030d159
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      453204030d15953d4b2854a42d5c7ef0877ca8dd =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/657638c3c7a1d9fecbe134a6

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-64-g453204030d159/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-64-g453204030d159/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657638c3c7a1d9fecbe134da
        failing since 300 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-10T22:16:26.700812  <8>[   19.062878] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 336551_1.5.2.4.1>
    2023-12-10T22:16:26.812307  / # #
    2023-12-10T22:16:26.914295  export SHELL=3D/bin/sh
    2023-12-10T22:16:26.914874  #
    2023-12-10T22:16:27.016397  / # export SHELL=3D/bin/sh. /lava-336551/en=
vironment
    2023-12-10T22:16:27.017082  =

    2023-12-10T22:16:27.118436  / # . /lava-336551/environment/lava-336551/=
bin/lava-test-runner /lava-336551/1
    2023-12-10T22:16:27.119397  =

    2023-12-10T22:16:27.122785  / # /lava-336551/bin/lava-test-runner /lava=
-336551/1
    2023-12-10T22:16:27.220142  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6576394c5fe5e0d528e13518

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-64-g453204030d159/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.t=
xt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-64-g453204030d159/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6576394c5fe5e0d528e13554
        failing since 0 day (last pass: v5.10.203-59-gaffef748422f6, first =
fail: v5.10.203-59-ge7f08cc8d6a32)

    2023-12-10T22:18:27.110039  <8>[   15.546096] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 336585_1.5.2.4.1>
    2023-12-10T22:18:27.218141  / # #
    2023-12-10T22:18:27.320990  export SHELL=3D/bin/sh
    2023-12-10T22:18:27.321774  #
    2023-12-10T22:18:27.423757  / # export SHELL=3D/bin/sh. /lava-336585/en=
vironment
    2023-12-10T22:18:27.424558  =

    2023-12-10T22:18:27.526537  / # . /lava-336585/environment/lava-336585/=
bin/lava-test-runner /lava-336585/1
    2023-12-10T22:18:27.527810  =

    2023-12-10T22:18:27.542329  / # /lava-336585/bin/lava-test-runner /lava=
-336585/1
    2023-12-10T22:18:27.601116  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
panda                        | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/657638f2d60ec93a25e134c3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-64-g453204030d159/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pand=
a.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-64-g453204030d159/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pand=
a.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657638f2d60ec93a25e134c8
        failing since 4 days (last pass: v5.10.148-91-g23f89880f93d, first =
fail: v5.10.202-131-g761b9c32d3c8b)

    2023-12-10T22:17:05.437417  <8>[   24.470245] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3874038_1.5.2.4.1>
    2023-12-10T22:17:05.544048  / # #
    2023-12-10T22:17:05.645365  export SHELL=3D/bin/sh
    2023-12-10T22:17:05.645722  #
    2023-12-10T22:17:05.746484  / # export SHELL=3D/bin/sh. /lava-3874038/e=
nvironment
    2023-12-10T22:17:05.746830  =

    2023-12-10T22:17:05.847624  / # . /lava-3874038/environment/lava-387403=
8/bin/lava-test-runner /lava-3874038/1
    2023-12-10T22:17:05.848441  =

    2023-12-10T22:17:05.853741  / # /lava-3874038/bin/lava-test-runner /lav=
a-3874038/1
    2023-12-10T22:17:05.911991  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/657638a8337891f02ee1357a

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-64-g453204030d159/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-64-g453204030d159/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657638a8337891f02ee1357f
        failing since 18 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-10T22:23:20.489608  / # #

    2023-12-10T22:23:20.590159  export SHELL=3D/bin/sh

    2023-12-10T22:23:20.590329  #

    2023-12-10T22:23:20.690870  / # export SHELL=3D/bin/sh. /lava-12238632/=
environment

    2023-12-10T22:23:20.691060  =


    2023-12-10T22:23:20.791550  / # . /lava-12238632/environment/lava-12238=
632/bin/lava-test-runner /lava-12238632/1

    2023-12-10T22:23:20.791800  =


    2023-12-10T22:23:20.802990  / # /lava-12238632/bin/lava-test-runner /la=
va-12238632/1

    2023-12-10T22:23:20.844448  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-10T22:23:20.862160  + cd /lav<8>[   16.424354] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12238632_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/657638eb72c95e958ae13476

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-64-g453204030d159/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-64-g453204030d159/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/657638eb72c95e958ae1347c
        failing since 271 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-10T22:17:26.740649  /lava-12238659/1/../bin/lava-test-case

    2023-12-10T22:17:26.752362  <8>[   34.948993] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/657638eb72c95e958ae1347d
        failing since 271 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-10T22:17:25.703917  /lava-12238659/1/../bin/lava-test-case

    2023-12-10T22:17:25.714821  <8>[   33.912025] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/657638a4ac01d0f254e134e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-64-g453204030d159/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-64-g453204030d159/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657638a4ac01d0f254e134eb
        failing since 18 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-10T22:15:54.274494  <8>[   16.952824] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447488_1.5.2.4.1>
    2023-12-10T22:15:54.379469  / # #
    2023-12-10T22:15:54.481204  export SHELL=3D/bin/sh
    2023-12-10T22:15:54.481813  #
    2023-12-10T22:15:54.582838  / # export SHELL=3D/bin/sh. /lava-447488/en=
vironment
    2023-12-10T22:15:54.583648  =

    2023-12-10T22:15:54.684685  / # . /lava-447488/environment/lava-447488/=
bin/lava-test-runner /lava-447488/1
    2023-12-10T22:15:54.685663  =

    2023-12-10T22:15:54.689841  / # /lava-447488/bin/lava-test-runner /lava=
-447488/1
    2023-12-10T22:15:54.756839  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/657638aa337891f02ee13585

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-64-g453204030d159/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-64-g453204030d159/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657638aa337891f02ee1358a
        failing since 18 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-10T22:23:35.985631  / # #

    2023-12-10T22:23:36.087734  export SHELL=3D/bin/sh

    2023-12-10T22:23:36.088473  #

    2023-12-10T22:23:36.189990  / # export SHELL=3D/bin/sh. /lava-12238638/=
environment

    2023-12-10T22:23:36.190690  =


    2023-12-10T22:23:36.292040  / # . /lava-12238638/environment/lava-12238=
638/bin/lava-test-runner /lava-12238638/1

    2023-12-10T22:23:36.293112  =


    2023-12-10T22:23:36.309639  / # /lava-12238638/bin/lava-test-runner /la=
va-12238638/1

    2023-12-10T22:23:36.352873  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-10T22:23:36.367769  + cd /lava-1223863<8>[   18.225559] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12238638_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/657638e0800b8d2690e134b0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-64-g453204030d159/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-64-g453204030d159/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657638e0800b8d2690e134b5
        failing since 18 days (last pass: v5.10.165-77-g4600242c13ed, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-10T22:16:33.477898  / # #
    2023-12-10T22:16:33.579279  export SHELL=3D/bin/sh
    2023-12-10T22:16:33.579781  #
    2023-12-10T22:16:33.680693  / # export SHELL=3D/bin/sh. /lava-3874041/e=
nvironment
    2023-12-10T22:16:33.681232  =

    2023-12-10T22:16:33.782089  / # . /lava-3874041/environment/lava-387404=
1/bin/lava-test-runner /lava-3874041/1
    2023-12-10T22:16:33.782806  =

    2023-12-10T22:16:33.786384  / # /lava-3874041/bin/lava-test-runner /lav=
a-3874041/1
    2023-12-10T22:16:33.850516  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-10T22:16:33.890391  + cd /lava-3874041/1/tests/1_bootrr =

    ... (9 line(s) more)  =

 =20

