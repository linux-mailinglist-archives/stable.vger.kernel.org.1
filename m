Return-Path: <stable+bounces-3895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAD3803908
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 16:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41B181F210D0
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 15:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AAE2C870;
	Mon,  4 Dec 2023 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="RfVeVhvY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D46B0
	for <stable@vger.kernel.org>; Mon,  4 Dec 2023 07:41:12 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-28647f4ebd9so2800713a91.3
        for <stable@vger.kernel.org>; Mon, 04 Dec 2023 07:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701704471; x=1702309271; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SokId88jukRLfCTxk8ctMAtCOLyveKtRsKr3LrV/dt0=;
        b=RfVeVhvYohOpMup5QYlsavG24ev0yNuE2iMEq/6HTM0X2Oij3NwFOHrgUgSLfjXyGD
         /ts2ljXdnPqWUd8lHzGXFkjJmxvYtnRT/XLkgysgOhWusCMNMcNLN8/TVvVHB/bFeiar
         4V9n2CFZFWKzMhCL4OUtpKl49yS92BnwGKyrvtf9PPH4rkw2faf4/5bKqXymMo5gw2Hr
         wC9PUDBW7oFfOozWLfgEhdmsfq3R90oPeEhUgJ4AhT0JUf/behyKKON4sFurM9/k5UIh
         KXG+drEA70Ep0lOL7rk/ET94stoY6JQGhARQkV0mg4lxZ8oxlN3embIhwpEr0Nn9GRjG
         6YYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701704471; x=1702309271;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SokId88jukRLfCTxk8ctMAtCOLyveKtRsKr3LrV/dt0=;
        b=ja58YDqQYZ5e6vzSgf2B3F6IvU9m/qL7arUqLJecLkmlMvkVU1ElXaQvEG4k4U2EZF
         l+JMvHPgUs266y/x+oXXYnnIRYhHdrlspDCx6r7qqDSj/slCEil2iIByhnbYZiuzzDTP
         SR+gw+VdMAJCHKhmk+MO5Vaih7T0uhXDk0vf+H/6eSgVdeFJ20kD+5KNfVVk266lrI3c
         pQr+G9OFzaswtB5nhORJD7Cb5NE2acuysxq1nAqE7J2/RyxmqLbcD8AtDv2twQQo+oP2
         +7wXs7Lgw0Yf5FslzChN+3v8AF1nF9s8ihY/WYc6v409hktiuFQH7pHp9rMtvXhE41YJ
         AdiA==
X-Gm-Message-State: AOJu0YznZPRMktbYHEGv1RpdnGVqBT/VczGcjaen3Wj/RnUEVV+vAabi
	IuxHNlmjgUCYMEbVUtk3FO9gZHr79r1bCJLbIOjBvg==
X-Google-Smtp-Source: AGHT+IFDYfv/XHrM0LPhSFbFoAa3LOjswZ/fFiJzkMSN5wYoJHAwuuuza4EEn+1YwQ0nYR1akvMqjw==
X-Received: by 2002:a17:90a:fe86:b0:286:6cc1:5fdd with SMTP id co6-20020a17090afe8600b002866cc15fddmr1573694pjb.96.1701704471194;
        Mon, 04 Dec 2023 07:41:11 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b6-20020a17090a7ac600b002868635df0asm3329890pjl.37.2023.12.04.07.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 07:41:10 -0800 (PST)
Message-ID: <656df316.170a0220.832d5.7164@mx.google.com>
Date: Mon, 04 Dec 2023 07:41:10 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.65-95-g9ea643fb97f9d
Subject: stable-rc/queue/6.1 baseline: 140 runs,
 5 regressions (v6.1.65-95-g9ea643fb97f9d)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 140 runs, 5 regressions (v6.1.65-95-g9ea643fb=
97f9d)

Regressions Summary
-------------------

platform           | arch  | lab             | compiler | defconfig        =
   | regressions
-------------------+-------+-----------------+----------+------------------=
---+------------
beaglebone-black   | arm   | lab-broonie     | gcc-10   | omap2plus_defconf=
ig | 1          =

imx6dl-riotboard   | arm   | lab-pengutronix | gcc-10   | multi_v7_defconfi=
g  | 1          =

r8a77960-ulcb      | arm64 | lab-collabora   | gcc-10   | defconfig        =
   | 1          =

sun50i-h6-pine-h64 | arm64 | lab-clabbe      | gcc-10   | defconfig        =
   | 1          =

sun50i-h6-pine-h64 | arm64 | lab-collabora   | gcc-10   | defconfig        =
   | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.65-95-g9ea643fb97f9d/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.65-95-g9ea643fb97f9d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      9ea643fb97f9d02c5de515a8f66a8207ebd53596 =



Test Regressions
---------------- =



platform           | arch  | lab             | compiler | defconfig        =
   | regressions
-------------------+-------+-----------------+----------+------------------=
---+------------
beaglebone-black   | arm   | lab-broonie     | gcc-10   | omap2plus_defconf=
ig | 1          =


  Details:     https://kernelci.org/test/plan/id/656dc092bfde6d9d0be13493

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-95=
-g9ea643fb97f9d/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beagleb=
one-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-95=
-g9ea643fb97f9d/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beagleb=
one-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656dc092bfde6d9d0be13=
494
        new failure (last pass: v6.1.65-53-gab9d7fb08abaf) =

 =



platform           | arch  | lab             | compiler | defconfig        =
   | regressions
-------------------+-------+-----------------+----------+------------------=
---+------------
imx6dl-riotboard   | arm   | lab-pengutronix | gcc-10   | multi_v7_defconfi=
g  | 1          =


  Details:     https://kernelci.org/test/plan/id/656dbf4fd1985db645e1347c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-95=
-g9ea643fb97f9d/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
dl-riotboard.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-95=
-g9ea643fb97f9d/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
dl-riotboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656dbf4fd1985db645e13485
        new failure (last pass: v6.1.65-53-gab9d7fb08abaf)

    2023-12-04T11:59:50.968240  + set[   14.988710] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1014147_1.5.2.3.1>
    2023-12-04T11:59:50.968508   +x
    2023-12-04T11:59:51.074093  / # #
    2023-12-04T11:59:51.175219  export SHELL=3D/bin/sh
    2023-12-04T11:59:51.175664  #
    2023-12-04T11:59:51.276420  / # export SHELL=3D/bin/sh. /lava-1014147/e=
nvironment
    2023-12-04T11:59:51.276784  =

    2023-12-04T11:59:51.377496  / # . /lava-1014147/environment/lava-101414=
7/bin/lava-test-runner /lava-1014147/1
    2023-12-04T11:59:51.378335  =

    2023-12-04T11:59:51.381081  / # /lava-1014147/bin/lava-test-runner /lav=
a-1014147/1 =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab             | compiler | defconfig        =
   | regressions
-------------------+-------+-----------------+----------+------------------=
---+------------
r8a77960-ulcb      | arm64 | lab-collabora   | gcc-10   | defconfig        =
   | 1          =


  Details:     https://kernelci.org/test/plan/id/656dbc0b72244563fae13567

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-95=
-g9ea643fb97f9d/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-95=
-g9ea643fb97f9d/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656dbc0b72244563fae13570
        failing since 11 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-04T11:53:45.074401  / # #

    2023-12-04T11:53:45.176640  export SHELL=3D/bin/sh

    2023-12-04T11:53:45.177352  #

    2023-12-04T11:53:45.278748  / # export SHELL=3D/bin/sh. /lava-12177032/=
environment

    2023-12-04T11:53:45.279469  =


    2023-12-04T11:53:45.380956  / # . /lava-12177032/environment/lava-12177=
032/bin/lava-test-runner /lava-12177032/1

    2023-12-04T11:53:45.382058  =


    2023-12-04T11:53:45.398395  / # /lava-12177032/bin/lava-test-runner /la=
va-12177032/1

    2023-12-04T11:53:45.447397  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-04T11:53:45.447908  + cd /lav<8>[   19.113909] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12177032_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab             | compiler | defconfig        =
   | regressions
-------------------+-------+-----------------+----------+------------------=
---+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe      | gcc-10   | defconfig        =
   | 1          =


  Details:     https://kernelci.org/test/plan/id/656dbbfd72244563fae13516

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-95=
-g9ea643fb97f9d/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-95=
-g9ea643fb97f9d/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656dbbfd72244563fae1351f
        failing since 11 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-04T11:46:00.803342  / # #
    2023-12-04T11:46:00.904960  export SHELL=3D/bin/sh
    2023-12-04T11:46:00.905557  #
    2023-12-04T11:46:01.006529  / # export SHELL=3D/bin/sh. /lava-446492/en=
vironment
    2023-12-04T11:46:01.007130  =

    2023-12-04T11:46:01.108139  / # . /lava-446492/environment/lava-446492/=
bin/lava-test-runner /lava-446492/1
    2023-12-04T11:46:01.108974  =

    2023-12-04T11:46:01.114721  / # /lava-446492/bin/lava-test-runner /lava=
-446492/1
    2023-12-04T11:46:01.187991  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-04T11:46:01.188291  + cd /lava-446492/<8>[   18.575246] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 446492_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab             | compiler | defconfig        =
   | regressions
-------------------+-------+-----------------+----------+------------------=
---+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora   | gcc-10   | defconfig        =
   | 1          =


  Details:     https://kernelci.org/test/plan/id/656dbc1f604a9a8a29e13479

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-95=
-g9ea643fb97f9d/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-95=
-g9ea643fb97f9d/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656dbc1f604a9a8a29e13482
        failing since 11 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-04T11:53:58.567460  / # #

    2023-12-04T11:53:58.669694  export SHELL=3D/bin/sh

    2023-12-04T11:53:58.670376  #

    2023-12-04T11:53:58.771695  / # export SHELL=3D/bin/sh. /lava-12177030/=
environment

    2023-12-04T11:53:58.772443  =


    2023-12-04T11:53:58.873930  / # . /lava-12177030/environment/lava-12177=
030/bin/lava-test-runner /lava-12177030/1

    2023-12-04T11:53:58.875021  =


    2023-12-04T11:53:58.891855  / # /lava-12177030/bin/lava-test-runner /la=
va-12177030/1

    2023-12-04T11:53:58.958869  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-04T11:53:58.959371  + cd /lava-1217703<8>[   19.419986] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12177030_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

