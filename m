Return-Path: <stable+bounces-3898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222ED80393C
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 16:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90582810E4
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 15:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBB32D039;
	Mon,  4 Dec 2023 15:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ezkRN3ui"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390AFA4
	for <stable@vger.kernel.org>; Mon,  4 Dec 2023 07:54:05 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cfc2bcffc7so18800085ad.1
        for <stable@vger.kernel.org>; Mon, 04 Dec 2023 07:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701705244; x=1702310044; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4SiuJ2rvwhrGvOPWA5GkoNNxNblkqaV57Ex2xClBJoo=;
        b=ezkRN3uiKWT0THV7ysn4ETvfK/kpHb41A0Cpa0f73e+raO3VHq2cBn3nnat+TcYyky
         tZAE8D2ASQunN3oVLaBR0nG+xEmVn54y3w6c+Vx85tyrxucj+kXBOOZ+gsVkT7BunhXx
         OYgl81D1W/Piwv8RCzuxFVc3b6MI4Fc1g96WSwwzsCwjKNZ8CTAGAIJyqrh149dDk3rJ
         RjZ319bdT7IKmqxUle05FPnfcAzfiGRwQJHTS/wQjthzVFRDZ2NvyL3ZoGTzSkmwC3Pb
         DEXA/TREXXbOypgMrnDGYjm1qbxCQJrVKYrsyg8ews42YOL0pWAhoGhx5aTXAQoNVkf8
         fyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701705244; x=1702310044;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4SiuJ2rvwhrGvOPWA5GkoNNxNblkqaV57Ex2xClBJoo=;
        b=tXQsb7vWW2X+t5pZuJHKY1fxhXY9WYG/ZuwEHuAg9wyGJ6LiC1/1K52j+Utni8S/6l
         cF1B6IdoT5hlD8QBYPmLEGFjaktQ2DAPWNz6GHDJdsBSGdUhROyYummtsaf7/iArKq8l
         vUP5l0OrQTxJ+pwA4kBt5I+iHyMryGKjODjYJu+grAztmM40YOYefoboK6EOUpw1y1kV
         22jrck1rLZNRNL1h589YIyB0fnaR6Chivdd6rnZ7Zi2x+mU3PdZSFyJKIdDnwA2r31aO
         gAaeVrIrvNPeIYmUmdX8wRmZFacfc0dA6h7fuDxujh8Y8kJ+6LePEvIas8oKdX+1yKEo
         bIcA==
X-Gm-Message-State: AOJu0Yy7QALt0byiVkQUOuegjALBlVCbtSvlKrc4SZiHV7j8iybdKIhY
	xNCugrefzETDcwPFc89baUT5VgskqaMfjR0sjP/HUg==
X-Google-Smtp-Source: AGHT+IEtMrxp00b6w+O+HiwqbCQA6zcQ0rPVEMehL0WhVe7CPatTPyW/8UUIS978uGOyrvW1GtU8Lw==
X-Received: by 2002:a17:902:bf49:b0:1d0:6ffe:1e6d with SMTP id u9-20020a170902bf4900b001d06ffe1e6dmr2074008pls.80.1701705244070;
        Mon, 04 Dec 2023 07:54:04 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c15-20020a170902d48f00b001cfb52ebfdcsm8528432plg.179.2023.12.04.07.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 07:54:03 -0800 (PST)
Message-ID: <656df61b.170a0220.b3df.7a6b@mx.google.com>
Date: Mon, 04 Dec 2023 07:54:03 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.202-137-gc7b177feb6f93
Subject: stable-rc/queue/5.10 baseline: 136 runs,
 7 regressions (v5.10.202-137-gc7b177feb6f93)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 136 runs, 7 regressions (v5.10.202-137-gc7b1=
77feb6f93)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
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
nel/v5.10.202-137-gc7b177feb6f93/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.202-137-gc7b177feb6f93
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      c7b177feb6f9336342e8b40121d985056e782d5c =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656dc5bf2115741cf8e134ae

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-137-gc7b177feb6f93/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.=
txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-137-gc7b177feb6f93/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656dc5bf2115741cf8e134e7
        failing since 0 day (last pass: v5.10.202-69-g560a93e9d1ce3, first =
fail: v5.10.202-78-ga6f1d8d78e2ed)

    2023-12-04T12:27:18.500063  <8>[   14.742824] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 305249_1.5.2.4.1>
    2023-12-04T12:27:18.609588  / # #
    2023-12-04T12:27:18.713085  export SHELL=3D/bin/sh
    2023-12-04T12:27:18.713822  #
    2023-12-04T12:27:18.815697  / # export SHELL=3D/bin/sh. /lava-305249/en=
vironment
    2023-12-04T12:27:18.816498  =

    2023-12-04T12:27:18.918428  / # . /lava-305249/environment/lava-305249/=
bin/lava-test-runner /lava-305249/1
    2023-12-04T12:27:18.919708  =

    2023-12-04T12:27:18.932071  / # /lava-305249/bin/lava-test-runner /lava=
-305249/1
    2023-12-04T12:27:18.992867  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656dc44036661fc797e134d6

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-137-gc7b177feb6f93/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-137-gc7b177feb6f93/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656dc44136661fc797e134db
        failing since 11 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-04T12:28:45.220058  / # #

    2023-12-04T12:28:45.320475  export SHELL=3D/bin/sh

    2023-12-04T12:28:45.320572  #

    2023-12-04T12:28:45.421015  / # export SHELL=3D/bin/sh. /lava-12177570/=
environment

    2023-12-04T12:28:45.421136  =


    2023-12-04T12:28:45.521553  / # . /lava-12177570/environment/lava-12177=
570/bin/lava-test-runner /lava-12177570/1

    2023-12-04T12:28:45.521725  =


    2023-12-04T12:28:45.533782  / # /lava-12177570/bin/lava-test-runner /la=
va-12177570/1

    2023-12-04T12:28:45.586952  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-04T12:28:45.587016  + cd /lav<8>[   16.418231] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12177570_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/656dc44239facfecd4e13475

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-137-gc7b177feb6f93/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-137-gc7b177feb6f93/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/656dc44239facfecd4e1347b
        failing since 265 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-04T12:21:29.255347  <8>[   33.735541] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-12-04T12:21:30.281739  /lava-12177508/1/../bin/lava-test-case

    2023-12-04T12:21:30.292416  <8>[   34.772526] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/656dc44239facfecd4e1347c
        failing since 265 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-04T12:21:29.245125  /lava-12177508/1/../bin/lava-test-case
   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656dc446dd25824234e1348e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-137-gc7b177feb6f93/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-137-gc7b177feb6f93/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656dc446dd25824234e13493
        failing since 11 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-04T12:21:16.641129  <8>[   16.954665] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 446502_1.5.2.4.1>
    2023-12-04T12:21:16.746063  / # #
    2023-12-04T12:21:16.847669  export SHELL=3D/bin/sh
    2023-12-04T12:21:16.848329  #
    2023-12-04T12:21:16.949341  / # export SHELL=3D/bin/sh. /lava-446502/en=
vironment
    2023-12-04T12:21:16.950045  =

    2023-12-04T12:21:17.051026  / # . /lava-446502/environment/lava-446502/=
bin/lava-test-runner /lava-446502/1
    2023-12-04T12:21:17.051930  =

    2023-12-04T12:21:17.056511  / # /lava-446502/bin/lava-test-runner /lava=
-446502/1
    2023-12-04T12:21:17.123526  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656dc45539facfecd4e134f3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-137-gc7b177feb6f93/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-137-gc7b177feb6f93/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656dc45539facfecd4e134f8
        failing since 11 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-04T12:29:02.920601  / # #

    2023-12-04T12:29:03.022610  export SHELL=3D/bin/sh

    2023-12-04T12:29:03.022887  #

    2023-12-04T12:29:03.123503  / # export SHELL=3D/bin/sh. /lava-12177582/=
environment

    2023-12-04T12:29:03.123752  =


    2023-12-04T12:29:03.224385  / # . /lava-12177582/environment/lava-12177=
582/bin/lava-test-runner /lava-12177582/1

    2023-12-04T12:29:03.224803  =


    2023-12-04T12:29:03.228282  / # /lava-12177582/bin/lava-test-runner /la=
va-12177582/1

    2023-12-04T12:29:03.296933  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-04T12:29:03.297434  + cd /lava-1217758<8>[   18.199090] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12177582_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/656dc537e5a0d4d8b9e134f4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-137-gc7b177feb6f93/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-137-gc7b177feb6f93/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656dc537e5a0d4d8b9e134f9
        failing since 11 days (last pass: v5.10.165-77-g4600242c13ed, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-04T12:25:03.370497  / # #
    2023-12-04T12:25:03.471935  export SHELL=3D/bin/sh
    2023-12-04T12:25:03.472485  #
    2023-12-04T12:25:03.573347  / # export SHELL=3D/bin/sh. /lava-3860322/e=
nvironment
    2023-12-04T12:25:03.573858  =

    2023-12-04T12:25:03.674800  / # . /lava-3860322/environment/lava-386032=
2/bin/lava-test-runner /lava-3860322/1
    2023-12-04T12:25:03.675652  =

    2023-12-04T12:25:03.683761  / # /lava-3860322/bin/lava-test-runner /lav=
a-3860322/1
    2023-12-04T12:25:03.795739  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-04T12:25:03.796321  + cd /lava-3860322/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

