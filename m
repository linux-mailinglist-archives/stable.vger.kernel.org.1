Return-Path: <stable+bounces-118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B61B7F72F1
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 12:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A162819C3
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 11:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A82A1EB39;
	Fri, 24 Nov 2023 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="jrSwBFBW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1462A10FB
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 03:41:59 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc5fa0e4d5so14484475ad.0
        for <stable@vger.kernel.org>; Fri, 24 Nov 2023 03:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700826118; x=1701430918; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zeVRNJ48yBzQsfmpYqKEXNxds3G4A7zm27nXIm1FIvw=;
        b=jrSwBFBWostCC5B4p8m0RlNPpNYhwhjVPHlF9NtrI2QB8IXiJXZXBJjracKs/H4nSZ
         uFqTuxz7N7tvrdKo6upSKJ9AcNZz0GPHoVI78J7MEHOllGmFfmvawIk7ZarqldQQYaPH
         btNeJ9Nk4h7pmwIldTUGBPoHyJdV+PPUPcO5MHwv+Q70pB+9jwO6QerdNGMoSiqyVMDq
         xlEf6nyl0sSURwoYRK+3qqsEPxEP5n59F6XQk8oa+9U316p6dkOvLV3pbbo6X4zEPbNq
         8eHbF05zumAjJ4FNirb7RBhHzAx5bXEQ1yhupFVNdgOImaaeyrWITy3Q6ER73UteB0Ha
         I09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700826118; x=1701430918;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zeVRNJ48yBzQsfmpYqKEXNxds3G4A7zm27nXIm1FIvw=;
        b=tiykOPqB2cIO1eXry/ZOs2X6881nTuvF36nU8VreLurimMX2wnmbN334/jY4ari8VF
         hqB13aot6XEamAPyOcuE7/YeQVQQY3tDarNhTDDrpxtZp6VcSU2J9W38lNvMiJsq98Ko
         NPd+zqycW2ai18FqtbNw1uXTFePDnUi+wPq9PJWnn5wysrndsPyD9YHxCu7F0e9eazCF
         MEKSxUzHrt2/k46sWrUY+mSKBy+5lv9nCO7CR4rd8spf+orefOjgyU3kIEPctGLRSPC1
         043VWj+k6ntNm92QrpWBdGPhoV6m1nATn7OMSRtuCENNTeDYRZUbcqr0abxb1DctkB5I
         LdVQ==
X-Gm-Message-State: AOJu0Ywoe4DYFVcRFxLb7foeB/HI4iTAaz0AEnY602ZahHps3jmSXzlI
	HjvT5+Qm4p16Yc3FmYhy0As7M4tm8ysw5enAJdo=
X-Google-Smtp-Source: AGHT+IFe090FEs0NqNQIYm1eEzp4OYNRXqJQmW71Oe2uu+PXqA48l6f9tl6WOz007d2gbsxoZHOE2g==
X-Received: by 2002:a17:902:7483:b0:1cf:7df0:667f with SMTP id h3-20020a170902748300b001cf7df0667fmr2819054pll.44.1700826117919;
        Fri, 24 Nov 2023 03:41:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902654800b001c61acd5bd2sm3057215pln.112.2023.11.24.03.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 03:41:57 -0800 (PST)
Message-ID: <65608c05.170a0220.f37e6.7238@mx.google.com>
Date: Fri, 24 Nov 2023 03:41:57 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.201-162-gad3ccce275e56
Subject: stable-rc/queue/5.10 baseline: 122 runs,
 7 regressions (v5.10.201-162-gad3ccce275e56)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 122 runs, 7 regressions (v5.10.201-162-gad3c=
cce275e56)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig | 1          =

juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
           | 1          =

r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
           | 1          =

rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
           | 1          =

sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
           | 1          =

sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
           | 1          =

sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig  | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.201-162-gad3ccce275e56/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.201-162-gad3ccce275e56
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      ad3ccce275e568ab0a24ca6c0f4a20b7d35d392e =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/656055b3c7487813267e4a8c

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-162-gad3ccce275e56/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-162-gad3ccce275e56/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656055b4c7487813267e4abf
        failing since 283 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-11-24T07:49:51.846970  <8>[   19.261263] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 268657_1.5.2.4.1>
    2023-11-24T07:49:51.956033  / # #
    2023-11-24T07:49:52.057936  export SHELL=3D/bin/sh
    2023-11-24T07:49:52.058397  #
    2023-11-24T07:49:52.160077  / # export SHELL=3D/bin/sh. /lava-268657/en=
vironment
    2023-11-24T07:49:52.160503  =

    2023-11-24T07:49:52.261952  / # . /lava-268657/environment/lava-268657/=
bin/lava-test-runner /lava-268657/1
    2023-11-24T07:49:52.262594  =

    2023-11-24T07:49:52.267121  / # /lava-268657/bin/lava-test-runner /lava=
-268657/1
    2023-11-24T07:49:52.374641  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/65605880e894efc0a47e4aa0

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-162-gad3ccce275e56/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.=
txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-162-gad3ccce275e56/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65605881e894efc0a47e4adf
        failing since 1 day (last pass: v5.10.181-18-g1622068b57a4, first f=
ail: v5.10.201-98-g6f84b6dba25c)

    2023-11-24T08:01:41.634159  / # #
    2023-11-24T08:01:41.737040  export SHELL=3D/bin/sh
    2023-11-24T08:01:41.737894  #
    2023-11-24T08:01:41.839948  / # export SHELL=3D/bin/sh. /lava-268672/en=
vironment
    2023-11-24T08:01:41.840744  =

    2023-11-24T08:01:41.942754  / # . /lava-268672/environment/lava-268672/=
bin/lava-test-runner /lava-268672/1
    2023-11-24T08:01:41.944180  =

    2023-11-24T08:01:41.956734  / # /lava-268672/bin/lava-test-runner /lava=
-268672/1
    2023-11-24T08:01:42.016630  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-24T08:01:42.017183  + cd /lava-268672/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/6560597a8e8f9713937e4a6d

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-162-gad3ccce275e56/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-162-gad3ccce275e56/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6560597a8e8f9713937e4a76
        failing since 1 day (last pass: v5.10.181-18-g1622068b57a4, first f=
ail: v5.10.201-98-g6f84b6dba25c)

    2023-11-24T08:12:24.769225  / # #

    2023-11-24T08:12:24.871319  export SHELL=3D/bin/sh

    2023-11-24T08:12:24.872042  #

    2023-11-24T08:12:24.973481  / # export SHELL=3D/bin/sh. /lava-12072865/=
environment

    2023-11-24T08:12:24.974211  =


    2023-11-24T08:12:25.075573  / # . /lava-12072865/environment/lava-12072=
865/bin/lava-test-runner /lava-12072865/1

    2023-11-24T08:12:25.076582  =


    2023-11-24T08:12:25.078583  / # /lava-12072865/bin/lava-test-runner /la=
va-12072865/1

    2023-11-24T08:12:25.142328  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-24T08:12:25.142846  + cd /lav<8>[   16.500936] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12072865_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/656056cbc8fc4fcea07e4ac2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-162-gad3ccce275e56/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-ro=
ck-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-162-gad3ccce275e56/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-ro=
ck-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656056cbc8fc4fcea07e4acb
        failing since 1 day (last pass: v5.10.181-18-g1622068b57a4, first f=
ail: v5.10.201-98-g6f84b6dba25c)

    2023-11-24T07:54:24.372757  / # #

    2023-11-24T07:54:25.633761  export SHELL=3D/bin/sh

    2023-11-24T07:54:25.644744  #

    2023-11-24T07:54:25.645238  / # export SHELL=3D/bin/sh

    2023-11-24T07:54:27.386915  / # . /lava-12072860/environment

    2023-11-24T07:54:30.584379  /lava-12072860/bin/lava-test-runner /lava-1=
2072860/1

    2023-11-24T07:54:30.595917  . /lava-12072860/environment

    2023-11-24T07:54:30.596295  / # /lava-12072860/bin/lava-test-runner /la=
va-12072860/1

    2023-11-24T07:54:30.648476  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-24T07:54:30.648977  + cd /lava-12072860/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/65605693878d09e4f67e4a7f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-162-gad3ccce275e56/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-162-gad3ccce275e56/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65605693878d09e4f67e4a88
        failing since 1 day (last pass: v5.10.176-241-ga0049fd9c865, first =
fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-24T07:53:45.226369  <8>[   16.948662] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 445142_1.5.2.4.1>
    2023-11-24T07:53:45.331409  / # #
    2023-11-24T07:53:45.433054  export SHELL=3D/bin/sh
    2023-11-24T07:53:45.433611  #
    2023-11-24T07:53:45.534605  / # export SHELL=3D/bin/sh. /lava-445142/en=
vironment
    2023-11-24T07:53:45.535181  =

    2023-11-24T07:53:45.636182  / # . /lava-445142/environment/lava-445142/=
bin/lava-test-runner /lava-445142/1
    2023-11-24T07:53:45.637044  =

    2023-11-24T07:53:45.641726  / # /lava-445142/bin/lava-test-runner /lava=
-445142/1
    2023-11-24T07:53:45.708794  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/65605696f588700e1f7e4a79

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-162-gad3ccce275e56/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-162-gad3ccce275e56/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65605696f588700e1f7e4a82
        failing since 1 day (last pass: v5.10.176-241-ga0049fd9c865, first =
fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-24T08:00:14.362408  / # #

    2023-11-24T08:00:14.464495  export SHELL=3D/bin/sh

    2023-11-24T08:00:14.465234  #

    2023-11-24T08:00:14.566572  / # export SHELL=3D/bin/sh. /lava-12072864/=
environment

    2023-11-24T08:00:14.567312  =


    2023-11-24T08:00:14.668711  / # . /lava-12072864/environment/lava-12072=
864/bin/lava-test-runner /lava-12072864/1

    2023-11-24T08:00:14.669881  =


    2023-11-24T08:00:14.686933  / # /lava-12072864/bin/lava-test-runner /la=
va-12072864/1

    2023-11-24T08:00:14.729675  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-24T08:00:14.745664  + cd /lava-1207286<8>[   18.245944] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12072864_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/65605b1dcf0fc5ada97e4ae5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-162-gad3ccce275e56/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-162-gad3ccce275e56/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65605b1dcf0fc5ada97e4aee
        failing since 1 day (last pass: v5.10.165-77-g4600242c13ed, first f=
ail: v5.10.201-98-g6f84b6dba25c)

    2023-11-24T08:12:55.720548  / # #
    2023-11-24T08:12:55.821904  export SHELL=3D/bin/sh
    2023-11-24T08:12:55.822429  #
    2023-11-24T08:12:55.923284  / # export SHELL=3D/bin/sh. /lava-3845604/e=
nvironment
    2023-11-24T08:12:55.923822  =

    2023-11-24T08:12:56.024738  / # . /lava-3845604/environment/lava-384560=
4/bin/lava-test-runner /lava-3845604/1
    2023-11-24T08:12:56.025516  =

    2023-11-24T08:12:56.032602  / # /lava-3845604/bin/lava-test-runner /lav=
a-3845604/1
    2023-11-24T08:12:56.080953  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-24T08:12:56.120518  + cd /lava-3845604/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

