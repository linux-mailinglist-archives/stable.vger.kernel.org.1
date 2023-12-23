Return-Path: <stable+bounces-8368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C8F81D220
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 05:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D52285E1A
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 04:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875651373;
	Sat, 23 Dec 2023 04:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="IGH9nhwt"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB2C1368
	for <stable@vger.kernel.org>; Sat, 23 Dec 2023 04:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bb6fc61ce7so1798762b6e.3
        for <stable@vger.kernel.org>; Fri, 22 Dec 2023 20:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703305086; x=1703909886; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qPcZZsTQgIAZgyQCIE4mTbCYkClb3LRRlV67YqCHdkM=;
        b=IGH9nhwtYIWtul9z7SbMT7rELhnoZhwXx5djlOTQYn1A70uzV8uLG3RDLA7EhG5433
         jTkC4IC8CkYjPkKHfSsBPwXrOVEvoHyEDEi71Gkmk28zHYJcJo2CM4l+pmzZ7u/byxDE
         cHL0uiFQ4/goz3tOyXmKRLjocKgL8k9ZNCjNoARSRJWeMsbjRiPSDaSpARdXg8OPjAhx
         6vzDWkS4cTv7mdKdfSE7/+5KDVlFDKXyJHJ/uh4ZLBHT2L48w3zTT1p0fDbh1GR3EoC6
         qvBTC79UwHgFyggT3rY3cdd7P5FI6rTMOX1PLIF0L0lLGMBa8p3zJFZ5vLyQZ9EDq5MX
         Lqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703305086; x=1703909886;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qPcZZsTQgIAZgyQCIE4mTbCYkClb3LRRlV67YqCHdkM=;
        b=JFjFEDdDrWmcT5HuMWbeLJYoiLDRKc9GMtZs6tea7nbF5RkZ1TmZOPs5o0gH9LvkO3
         qgUYFaD6m9MhWvsNTi7aVrnjRHMICv4G9ldpUCNl8CkRfPQzzESjEJbiw3XGhV3FK9ms
         Z807Md1FvEdD2phn3QUwDos5Glc/Q/EXweJFHydl4XmfbHQcJulSFkCFRWUeUJSJbj+a
         cwtxXN7uxDCvTZddRubihHUgIW+wnbGTtYFmOUAaaQxnYt5L1dQvz+OArA6a6xEA8EZi
         uQGvl+v4ssL1GjtLStTvnHZxiBTomW6g7Cn1eowgJY+PCfqDQrLaaZsYcRP/xiN0BVJp
         Gjlg==
X-Gm-Message-State: AOJu0Yyav3qnPIMJ6s7bmLGlcSdx296Bki5YP9heqzqRT8nP9ukdg4Oi
	Bprax/0EDPq81/pjNRXJIrcS/3kvYidesXcEStTdQW+jeC4=
X-Google-Smtp-Source: AGHT+IHjG+bElgwfWm8HCnf6dWnCwsSe2UkFiTN7vgG2Uhwrjt5PZvL+qNMiqoc7OX8iOeVEcQ3Jig==
X-Received: by 2002:a05:6808:1415:b0:3bb:6d9b:845 with SMTP id w21-20020a056808141500b003bb6d9b0845mr2754635oiv.44.1703305086093;
        Fri, 22 Dec 2023 20:18:06 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f26-20020aa78b1a000000b006d97f80c4absm2846828pfd.41.2023.12.22.20.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 20:18:05 -0800 (PST)
Message-ID: <65865f7d.a70a0220.f9cd3.b149@mx.google.com>
Date: Fri, 22 Dec 2023 20:18:05 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.204-81-g2f0a8da2e07a3
Subject: stable-rc/queue/5.10 baseline: 100 runs,
 7 regressions (v5.10.204-81-g2f0a8da2e07a3)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 100 runs, 7 regressions (v5.10.204-81-g2f0a8=
da2e07a3)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
beaglebone-black   | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig=
        | 1          =

juno-uboot         | arm64 | lab-broonie   | gcc-10   | defconfig          =
        | 1          =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =

rk3399-gru-kevin   | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chr=
omebook | 2          =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
        | 1          =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.204-81-g2f0a8da2e07a3/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.204-81-g2f0a8da2e07a3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      2f0a8da2e07a36c499ad11dd70ee3d8828b56aaa =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
beaglebone-black   | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig=
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65862d8b82374b5434e13477

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-81-g2f0a8da2e07a3/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-81-g2f0a8da2e07a3/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65862d8b82374b5434e134ab
        failing since 312 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-23T00:44:42.396726  <8>[   20.228879] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 387986_1.5.2.4.1>
    2023-12-23T00:44:42.505469  / # #
    2023-12-23T00:44:42.607313  export SHELL=3D/bin/sh
    2023-12-23T00:44:42.607795  #
    2023-12-23T00:44:42.709174  / # export SHELL=3D/bin/sh. /lava-387986/en=
vironment
    2023-12-23T00:44:42.709688  =

    2023-12-23T00:44:42.811074  / # . /lava-387986/environment/lava-387986/=
bin/lava-test-runner /lava-387986/1
    2023-12-23T00:44:42.811824  =

    2023-12-23T00:44:42.815257  / # /lava-387986/bin/lava-test-runner /lava=
-387986/1
    2023-12-23T00:44:42.925724  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
juno-uboot         | arm64 | lab-broonie   | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65862e77dc329e7a86e134a6

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-81-g2f0a8da2e07a3/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.t=
xt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-81-g2f0a8da2e07a3/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65862e77dc329e7a86e134e2
        new failure (last pass: v5.10.204-63-g5105b172a5e05)

    2023-12-23T00:48:26.764650  / # #
    2023-12-23T00:48:26.867461  export SHELL=3D/bin/sh
    2023-12-23T00:48:26.868213  #
    2023-12-23T00:48:26.970163  / # export SHELL=3D/bin/sh. /lava-388056/en=
vironment
    2023-12-23T00:48:26.970917  =

    2023-12-23T00:48:27.072840  / # . /lava-388056/environment/lava-388056/=
bin/lava-test-runner /lava-388056/1
    2023-12-23T00:48:27.074087  =

    2023-12-23T00:48:27.088959  / # /lava-388056/bin/lava-test-runner /lava=
-388056/1
    2023-12-23T00:48:27.147797  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-23T00:48:27.148292  + cd /lava-388056/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65862dc0304612144ce1348f

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-81-g2f0a8da2e07a3/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-81-g2f0a8da2e07a3/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65862dc0304612144ce13494
        failing since 30 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-23T00:53:09.775007  / # #

    2023-12-23T00:53:09.876802  export SHELL=3D/bin/sh

    2023-12-23T00:53:09.877466  #

    2023-12-23T00:53:09.978679  / # export SHELL=3D/bin/sh. /lava-12357091/=
environment

    2023-12-23T00:53:09.979315  =


    2023-12-23T00:53:10.080492  / # . /lava-12357091/environment/lava-12357=
091/bin/lava-test-runner /lava-12357091/1

    2023-12-23T00:53:10.081387  =


    2023-12-23T00:53:10.083241  / # /lava-12357091/bin/lava-test-runner /la=
va-12357091/1

    2023-12-23T00:53:10.147325  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-23T00:53:10.147840  + cd /lav<8>[   16.433354] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12357091_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
rk3399-gru-kevin   | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chr=
omebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65862eace5e80c4b94e1348c

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-81-g2f0a8da2e07a3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-81-g2f0a8da2e07a3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/65862eace5e80c4b94e13492
        failing since 283 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-23T00:50:08.035321  /lava-12357250/1/../bin/lava-test-case

    2023-12-23T00:50:08.045835  <8>[   35.196991] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/65862eace5e80c4b94e13493
        failing since 283 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-23T00:50:05.975330  <8>[   33.125019] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-12-23T00:50:06.997784  /lava-12357250/1/../bin/lava-test-case

    2023-12-23T00:50:07.009185  <8>[   34.159970] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65862db682374b5434e134ca

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-81-g2f0a8da2e07a3/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-81-g2f0a8da2e07a3/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65862db682374b5434e134cf
        failing since 30 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-23T00:45:32.985153  <8>[   16.983260] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 449586_1.5.2.4.1>
    2023-12-23T00:45:33.090116  / # #
    2023-12-23T00:45:33.191769  export SHELL=3D/bin/sh
    2023-12-23T00:45:33.192342  #
    2023-12-23T00:45:33.293320  / # export SHELL=3D/bin/sh. /lava-449586/en=
vironment
    2023-12-23T00:45:33.293961  =

    2023-12-23T00:45:33.394955  / # . /lava-449586/environment/lava-449586/=
bin/lava-test-runner /lava-449586/1
    2023-12-23T00:45:33.395799  =

    2023-12-23T00:45:33.400520  / # /lava-449586/bin/lava-test-runner /lava=
-449586/1
    2023-12-23T00:45:33.467562  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65862dd74cf9facda6e1347b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-81-g2f0a8da2e07a3/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-81-g2f0a8da2e07a3/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65862dd74cf9facda6e13480
        failing since 30 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-23T00:53:23.992845  / # #

    2023-12-23T00:53:24.094845  export SHELL=3D/bin/sh

    2023-12-23T00:53:24.095478  #

    2023-12-23T00:53:24.196589  / # export SHELL=3D/bin/sh. /lava-12357094/=
environment

    2023-12-23T00:53:24.196799  =


    2023-12-23T00:53:24.297396  / # . /lava-12357094/environment/lava-12357=
094/bin/lava-test-runner /lava-12357094/1

    2023-12-23T00:53:24.297741  =


    2023-12-23T00:53:24.300647  / # /lava-12357094/bin/lava-test-runner /la=
va-12357094/1

    2023-12-23T00:53:24.369425  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-23T00:53:24.369593  + cd /lava-1235709<8>[   18.167193] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12357094_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

