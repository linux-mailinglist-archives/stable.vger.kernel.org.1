Return-Path: <stable+bounces-4758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A88805E59
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 20:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A0881C21091
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 19:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B1768EBE;
	Tue,  5 Dec 2023 19:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="C5mY7qUz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D99B0
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 11:08:24 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d0c4d84bf6so8678965ad.1
        for <stable@vger.kernel.org>; Tue, 05 Dec 2023 11:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701803304; x=1702408104; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w/so7nM0kejmk/tx7kTzVnrPiKVG/vw1avD+np/dU7I=;
        b=C5mY7qUz68mJ0W4am8u0az7bgZXPJ4aGFy4meYlAMfpGiocL/oxZE00FmL45Vymd1y
         Eyc6TvhI6pXiz77/JyByOmh85iDU3ddKc06eDYiMponpJ54dkddilMv97zXj69bnxRab
         /Z1vn4u9Zg9Sy8oXmhmRmYV6g1TfNach7Hl/r17EbI7MV1U0bUGFfdVBCJHuaMcq2dwe
         X0O+X0NFmhG/i4gqpNVK+t4qd7vJayNvzJFQf9te5pX1YlLQyzGDHOh2cMS0Bge9jqnn
         kAUxWoCIM4j+gd+sgGR3AYU+WZJthVFtjVYGgMIHgG325F9+adAMZwz/wZ8/nSBoqCNb
         s1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701803304; x=1702408104;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w/so7nM0kejmk/tx7kTzVnrPiKVG/vw1avD+np/dU7I=;
        b=TVv8yg9WRq/TV27zNpf0D4q/pOMwCxGbYGNiT4V2XLEADFH9tkSFexNEJamNcKV8tQ
         Lm2EvhN+/lP+u/tJkhsJUoV3UXp05X+IxYJfWmwjqLwWAlw+A1DYGSDgGK2e28NhCL/w
         xvMYjg0yxEkLvZhE2iVEBdhOhtVCCbtYRc8TdnRTYpcQkbkCbWah7Ezp4lBNhUNbh/6f
         sCFxMuWSx1CqHG2caXJV39MnTzcf0ZtdzGLb0FsJnVqHX5uyOto6ferGFUDJ3omNC3W5
         70m4a3gZvLiqfqMvHPwvNWqTznxdqvUYhJaYCgb1TU7fO/PTFnR2ex9S4f5MISJtjoYQ
         986w==
X-Gm-Message-State: AOJu0YzH3k816BahvwkasMG0Fpm86MNW8jyt4g8DxRWXWppja6Wc6m1S
	AqoxkHQTMJyz7JHsxnZHXiImfRy4XUCVm4/HGizk/w==
X-Google-Smtp-Source: AGHT+IHQBF5gDbH1x1TLLHyw882zZb2B21mwHsEzikn/+n0BC0FaiC1+Z2NXWQkDtywEyVjQ4liieQ==
X-Received: by 2002:a17:902:c1c6:b0:1d0:7051:ccc8 with SMTP id c6-20020a170902c1c600b001d07051ccc8mr3574866plc.119.1701803303804;
        Tue, 05 Dec 2023 11:08:23 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v1-20020a1709029a0100b001cfb573674fsm10575420plp.30.2023.12.05.11.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 11:08:23 -0800 (PST)
Message-ID: <656f7527.170a0220.f7bbe.e7c0@mx.google.com>
Date: Tue, 05 Dec 2023 11:08:23 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.202-134-gb8afb76acc05
Subject: stable-rc/queue/5.10 baseline: 129 runs,
 7 regressions (v5.10.202-134-gb8afb76acc05)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 129 runs, 7 regressions (v5.10.202-134-gb8af=
b76acc05)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =

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
nel/v5.10.202-134-gb8afb76acc05/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.202-134-gb8afb76acc05
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b8afb76acc05bf9e983382e534fb58e7a85ab79a =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/656f41a54960bb767ce1348c

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-134-gb8afb76acc05/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-134-gb8afb76acc05/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656f41a54960bb767ce134c2
        failing since 294 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-05T15:28:08.777743  <8>[   16.058390] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 309660_1.5.2.4.1>
    2023-12-05T15:28:08.882597  / # #
    2023-12-05T15:28:08.984221  export SHELL=3D/bin/sh
    2023-12-05T15:28:08.984713  #
    2023-12-05T15:28:09.085868  / # export SHELL=3D/bin/sh. /lava-309660/en=
vironment
    2023-12-05T15:28:09.086439  =

    2023-12-05T15:28:09.187965  / # . /lava-309660/environment/lava-309660/=
bin/lava-test-runner /lava-309660/1
    2023-12-05T15:28:09.188784  =

    2023-12-05T15:28:09.192886  / # /lava-309660/bin/lava-test-runner /lava=
-309660/1
    2023-12-05T15:28:09.300191  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656f4224a4be10c3b4e134b4

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-134-gb8afb76acc05/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-134-gb8afb76acc05/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656f4224a4be10c3b4e134b9
        failing since 13 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-05T15:37:58.272592  / # #

    2023-12-05T15:37:58.374736  export SHELL=3D/bin/sh

    2023-12-05T15:37:58.375468  #

    2023-12-05T15:37:58.476714  / # export SHELL=3D/bin/sh. /lava-12187787/=
environment

    2023-12-05T15:37:58.476981  =


    2023-12-05T15:37:58.577612  / # . /lava-12187787/environment/lava-12187=
787/bin/lava-test-runner /lava-12187787/1

    2023-12-05T15:37:58.577980  =


    2023-12-05T15:37:58.620593  / # /lava-12187787/bin/lava-test-runner /la=
va-12187787/1

    2023-12-05T15:37:58.643791  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-05T15:37:58.643932  + cd /lav<8>[   16.424628] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12187787_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/656f4728c6a71c9412e1347b

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-134-gb8afb76acc05/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-134-gb8afb76acc05/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/656f4728c6a71c9412e13481
        failing since 266 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-05T15:52:03.226366  /lava-12187977/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/656f4728c6a71c9412e13482
        failing since 266 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-05T15:52:02.190342  /lava-12187977/1/../bin/lava-test-case

    2023-12-05T15:52:02.201218  <8>[   32.280564] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656f42836b6cb49a1de13483

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-134-gb8afb76acc05/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-134-gb8afb76acc05/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656f42836b6cb49a1de13488
        failing since 13 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-05T15:32:09.904225  <8>[   16.983316] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 446626_1.5.2.4.1>
    2023-12-05T15:32:10.009325  / # #
    2023-12-05T15:32:10.110961  export SHELL=3D/bin/sh
    2023-12-05T15:32:10.111555  #
    2023-12-05T15:32:10.212577  / # export SHELL=3D/bin/sh. /lava-446626/en=
vironment
    2023-12-05T15:32:10.213224  =

    2023-12-05T15:32:10.314271  / # . /lava-446626/environment/lava-446626/=
bin/lava-test-runner /lava-446626/1
    2023-12-05T15:32:10.315174  =

    2023-12-05T15:32:10.319498  / # /lava-446626/bin/lava-test-runner /lava=
-446626/1
    2023-12-05T15:32:10.386622  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656f4225a6500a1701e13494

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-134-gb8afb76acc05/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-134-gb8afb76acc05/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656f4225a6500a1701e13499
        failing since 13 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-05T15:38:11.390492  / # #

    2023-12-05T15:38:11.492542  export SHELL=3D/bin/sh

    2023-12-05T15:38:11.493178  #

    2023-12-05T15:38:11.594204  / # export SHELL=3D/bin/sh. /lava-12187789/=
environment

    2023-12-05T15:38:11.594428  =


    2023-12-05T15:38:11.694865  / # . /lava-12187789/environment/lava-12187=
789/bin/lava-test-runner /lava-12187789/1

    2023-12-05T15:38:11.695048  =


    2023-12-05T15:38:11.736443  / # /lava-12187789/bin/lava-test-runner /la=
va-12187789/1

    2023-12-05T15:38:11.766385  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-05T15:38:11.766467  + cd /lava-1218778<8>[   18.153757] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12187789_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/656f4139b19a014dbce1347b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-134-gb8afb76acc05/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-134-gb8afb76acc05/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656f4139b19a014dbce13480
        failing since 13 days (last pass: v5.10.165-77-g4600242c13ed, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-05T15:26:20.876728  / # #
    2023-12-05T15:26:20.978103  export SHELL=3D/bin/sh
    2023-12-05T15:26:20.978767  #
    2023-12-05T15:26:21.079737  / # export SHELL=3D/bin/sh. /lava-3861364/e=
nvironment
    2023-12-05T15:26:21.080237  =

    2023-12-05T15:26:21.181127  / # . /lava-3861364/environment/lava-386136=
4/bin/lava-test-runner /lava-3861364/1
    2023-12-05T15:26:21.182044  =

    2023-12-05T15:26:21.188642  / # /lava-3861364/bin/lava-test-runner /lav=
a-3861364/1
    2023-12-05T15:26:21.285633  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-05T15:26:21.286186  + cd /lava-3861364/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

