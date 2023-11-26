Return-Path: <stable+bounces-2670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B8C7F9120
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 04:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BB7B1C20AD3
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 03:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1601870;
	Sun, 26 Nov 2023 03:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="NEe5XatZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF47A9
	for <stable@vger.kernel.org>; Sat, 25 Nov 2023 19:34:35 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b20577ef7bso2620432b3a.3
        for <stable@vger.kernel.org>; Sat, 25 Nov 2023 19:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700969675; x=1701574475; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C5sqA045pPX4SEXn81ePn3v1XdPZVj2CSBtUUqmUZH8=;
        b=NEe5XatZFBsb1ku+zkn1X3syFjcI9/77tTYbP+VXJl0qYCq5evxiUDzLmdSPKouFeX
         NSbNlOzna+tDP6ZXfrInvOsp5vg5th1Pa9RpgJ0eSwUFaokU/8Jq4k3F+PAbMoy894lw
         iCgX+B+L0uS436ruBaet8BqU9wygUSpDkMOFvXZrBbaIeIZWOJgaNjc///gJt1JrMoj0
         xgE2YJ8FKq5CiISn3Z7pAdxxMYu+0pT6pyrp19yd7U01PIYzkfjLvalxU50vqEz6gJ5Q
         4ZriCoyet75dAfHG9oO4J2xAq20TKpQei5FgbwPJHyNUAAOT6FAwlo/Q88k/d6ewUis+
         FTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700969675; x=1701574475;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5sqA045pPX4SEXn81ePn3v1XdPZVj2CSBtUUqmUZH8=;
        b=evJmDFvkt7JR64wLX//jcOKbeO0/b7qEv9rKOCQN0EXy8F4LtqDBoYg9Kvr5UeknqC
         aUmPHQhkayCmbaWMERhxToaU1Mt9LDQFLTaiFwWBlr51qq2VvOwFjOnmbBvyWiL/dGvp
         nMC2kYGrZtsjRkOmJkeYoqc00appICtqg829OOoYrsuGNuLke4zx/75rKH/aMxIPif/W
         BMdudRn9EhixPDLbH+M7Sdd5mBxjejV/fC+w2OL5eUkohG9HIfKC50XWZBapjnAkbHZ0
         ej0xQryLRXcXV1c94XcNh2hSbrXWJiixFljnPQUrUuQRMeY7eeCJGCG7fA0KY9eg06/v
         WDOQ==
X-Gm-Message-State: AOJu0YzviLchjajUrzpno3d+hnb0qYYvPphLwyvEVi9Ak5UY53G5L9Wn
	AZOgpvy5JwktsTZs4oPi+T7tliKbA93NPr2AEcc=
X-Google-Smtp-Source: AGHT+IHE0VGZBhxKQwgBjd2cztTubzsxC661aVihJUDAJAC691C5Md4sUv5Sz+s8IuoA3NkmbBdmIQ==
X-Received: by 2002:a05:6a00:1d88:b0:6cb:d24b:878a with SMTP id z8-20020a056a001d8800b006cbd24b878amr8085511pfw.25.1700969674641;
        Sat, 25 Nov 2023 19:34:34 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w66-20020a636245000000b005ab46970aaasm5394585pgb.17.2023.11.25.19.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 19:34:34 -0800 (PST)
Message-ID: <6562bcca.630a0220.2ded9.cba5@mx.google.com>
Date: Sat, 25 Nov 2023 19:34:34 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.201-188-g4d68658fe2c97
Subject: stable-rc/queue/5.10 baseline: 98 runs,
 7 regressions (v5.10.201-188-g4d68658fe2c97)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 98 runs, 7 regressions (v5.10.201-188-g4d686=
58fe2c97)

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
nel/v5.10.201-188-g4d68658fe2c97/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.201-188-g4d68658fe2c97
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      4d68658fe2c97983cdc603e08cfaf5a06380db5a =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65628c21da96a25e317e4a6d

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-188-g4d68658fe2c97/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-188-g4d68658fe2c97/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65628c21da96a25e317e4aa6
        failing since 285 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-11-26T00:06:26.523043  <8>[   20.691949] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 273956_1.5.2.4.1>
    2023-11-26T00:06:26.630136  / # #
    2023-11-26T00:06:26.731861  export SHELL=3D/bin/sh
    2023-11-26T00:06:26.732291  #
    2023-11-26T00:06:26.833845  / # export SHELL=3D/bin/sh. /lava-273956/en=
vironment
    2023-11-26T00:06:26.834392  =

    2023-11-26T00:06:26.935856  / # . /lava-273956/environment/lava-273956/=
bin/lava-test-runner /lava-273956/1
    2023-11-26T00:06:26.936521  =

    2023-11-26T00:06:26.941262  / # /lava-273956/bin/lava-test-runner /lava=
-273956/1
    2023-11-26T00:06:27.045096  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/656289a2c19c63c94b7e4ad6

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-188-g4d68658fe2c97/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.=
txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-188-g4d68658fe2c97/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656289a2c19c63c94b7e4b15
        failing since 3 days (last pass: v5.10.181-18-g1622068b57a4, first =
fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-25T23:55:56.035233  <8>[   15.504784] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 273890_1.5.2.4.1>
    2023-11-25T23:55:56.143472  / # #
    2023-11-25T23:55:56.246194  export SHELL=3D/bin/sh
    2023-11-25T23:55:56.246943  #
    2023-11-25T23:55:56.348873  / # export SHELL=3D/bin/sh. /lava-273890/en=
vironment
    2023-11-25T23:55:56.349645  =

    2023-11-25T23:55:56.451736  / # . /lava-273890/environment/lava-273890/=
bin/lava-test-runner /lava-273890/1
    2023-11-25T23:55:56.453087  =

    2023-11-25T23:55:56.467471  / # /lava-273890/bin/lava-test-runner /lava=
-273890/1
    2023-11-25T23:55:56.525280  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/6562890feaf4dbc0b07e4a87

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-188-g4d68658fe2c97/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-188-g4d68658fe2c97/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6562890feaf4dbc0b07e4a90
        failing since 3 days (last pass: v5.10.181-18-g1622068b57a4, first =
fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-25T23:59:59.586174  / # #

    2023-11-25T23:59:59.686708  export SHELL=3D/bin/sh

    2023-11-25T23:59:59.686833  #

    2023-11-25T23:59:59.787278  / # export SHELL=3D/bin/sh. /lava-12085411/=
environment

    2023-11-25T23:59:59.787427  =


    2023-11-25T23:59:59.887956  / # . /lava-12085411/environment/lava-12085=
411/bin/lava-test-runner /lava-12085411/1

    2023-11-25T23:59:59.888157  =


    2023-11-25T23:59:59.899651  / # /lava-12085411/bin/lava-test-runner /la=
va-12085411/1

    2023-11-25T23:59:59.953063  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-25T23:59:59.953148  + cd /lav<8>[   16.480223] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12085411_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/65628947ca8662e1a27e4aa6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-188-g4d68658fe2c97/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-ro=
ck-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-188-g4d68658fe2c97/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-ro=
ck-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65628947ca8662e1a27e4aaf
        failing since 3 days (last pass: v5.10.181-18-g1622068b57a4, first =
fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-25T23:58:17.066593  / # #

    2023-11-25T23:58:18.327634  export SHELL=3D/bin/sh

    2023-11-25T23:58:18.338571  #

    2023-11-25T23:58:18.339026  / # export SHELL=3D/bin/sh

    2023-11-25T23:58:20.082698  / # . /lava-12085398/environment

    2023-11-25T23:58:23.287179  /lava-12085398/bin/lava-test-runner /lava-1=
2085398/1

    2023-11-25T23:58:23.298710  . /lava-12085398/environment

    2023-11-25T23:58:23.300928  / # /lava-12085398/bin/lava-test-runner /la=
va-12085398/1

    2023-11-25T23:58:23.353838  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-25T23:58:23.354388  + cd /lava-12085398/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/6562890ac52ca002727e4a79

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-188-g4d68658fe2c97/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-188-g4d68658fe2c97/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6562890ac52ca002727e4a82
        failing since 3 days (last pass: v5.10.176-241-ga0049fd9c865, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-25T23:53:36.893040  <8>[   16.966090] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 445315_1.5.2.4.1>
    2023-11-25T23:53:36.998097  / # #
    2023-11-25T23:53:37.099733  export SHELL=3D/bin/sh
    2023-11-25T23:53:37.100335  #
    2023-11-25T23:53:37.201332  / # export SHELL=3D/bin/sh. /lava-445315/en=
vironment
    2023-11-25T23:53:37.201957  =

    2023-11-25T23:53:37.302969  / # . /lava-445315/environment/lava-445315/=
bin/lava-test-runner /lava-445315/1
    2023-11-25T23:53:37.303838  =

    2023-11-25T23:53:37.308315  / # /lava-445315/bin/lava-test-runner /lava=
-445315/1
    2023-11-25T23:53:37.374360  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/6562890ec52ca002727e4ae3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-188-g4d68658fe2c97/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-188-g4d68658fe2c97/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6562890ec52ca002727e4aec
        failing since 3 days (last pass: v5.10.176-241-ga0049fd9c865, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-26T00:00:13.915395  / # #

    2023-11-26T00:00:14.017552  export SHELL=3D/bin/sh

    2023-11-26T00:00:14.018264  #

    2023-11-26T00:00:14.119538  / # export SHELL=3D/bin/sh. /lava-12085408/=
environment

    2023-11-26T00:00:14.120241  =


    2023-11-26T00:00:14.221751  / # . /lava-12085408/environment/lava-12085=
408/bin/lava-test-runner /lava-12085408/1

    2023-11-26T00:00:14.222874  =


    2023-11-26T00:00:14.224307  / # /lava-12085408/bin/lava-test-runner /la=
va-12085408/1

    2023-11-26T00:00:14.265480  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-26T00:00:14.298897  + cd /lava-1208540<8>[   18.296528] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12085408_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/656289dbd9d2c885e67e4aa7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-188-g4d68658fe2c97/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-188-g4d68658fe2c97/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656289dcd9d2c885e67e4ab0
        failing since 3 days (last pass: v5.10.165-77-g4600242c13ed, first =
fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-25T23:56:51.134708  / # #
    2023-11-25T23:56:51.235823  export SHELL=3D/bin/sh
    2023-11-25T23:56:51.236190  #
    2023-11-25T23:56:51.336988  / # export SHELL=3D/bin/sh. /lava-3847697/e=
nvironment
    2023-11-25T23:56:51.337482  =

    2023-11-25T23:56:51.438289  / # . /lava-3847697/environment/lava-384769=
7/bin/lava-test-runner /lava-3847697/1
    2023-11-25T23:56:51.438980  =

    2023-11-25T23:56:51.446667  / # /lava-3847697/bin/lava-test-runner /lav=
a-3847697/1
    2023-11-25T23:56:51.541572  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-25T23:56:51.542071  + cd /lava-3847697/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

