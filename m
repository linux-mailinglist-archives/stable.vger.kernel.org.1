Return-Path: <stable+bounces-86-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52587F6727
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 20:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA26281D33
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 19:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A344C3A4;
	Thu, 23 Nov 2023 19:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="pdpvW7t4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F84BD59
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 11:33:50 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso882686a12.3
        for <stable@vger.kernel.org>; Thu, 23 Nov 2023 11:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700768029; x=1701372829; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fSOHkzNctBxqFMhLIeF/+SulhS90WOXTdlxCth80cw0=;
        b=pdpvW7t4xtv4lW2Yf0tzf25wpodJGVVziFHia1CuoJgtisfKI5c/BC0ePltwmT01wX
         b2JPK1LNH/m2Rmb4s5DLPjtfeV2RQOzCjrw03LgspoeoTp3665bwLVQUUfRLxlUakF2v
         SkyTwaFcz8AAIKTjqqaezPIM+KwKujliJlU1FHIWnBowT0mfkKJDCG1+FkEnv5KxMnq8
         IksPhFsFTopDYH6z4r+6jgPDZWvtya7Eeb7liYRLJm+VbF2tBLvtNRuozoioxNVIb4+b
         0RDrKMwn++0baka8Q7PaMlqT3lpnE8Fm94GQwNMMBhQEe9A9WTNM2/61FzAlxL5JpEa0
         cb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700768029; x=1701372829;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSOHkzNctBxqFMhLIeF/+SulhS90WOXTdlxCth80cw0=;
        b=O86PAHKJxfNtIHStVKi5/rk3w4676iTT+nuFXm7Pvj2/A1oo7WClzojlH8FVgBBhYO
         AAo5LpE1AdHCgujIvpbbPKq2IErWa4kd6R6zW2FmiziXpXh72FR4N2BB+mT6t5rIs+wz
         kA1TuGCXaDtAKWlUcqB3Mk8iDmhSh/4HtuRG4n9ByBZsTayrj/qZWTbFE9VuxJMPX7mr
         0icWbWttGmj91CLWUqqnwabQMMqoSriBbw4jxDH+AKrQZi/y6eayuxryaMa3zx9fLhnv
         y7r5wBKZOnJcVEFgGv0hwEV1DkZeH2PmUZKSLd3beTUu4OWZMyumUyCrNmSvK3QKrPWE
         ISiA==
X-Gm-Message-State: AOJu0Ywkvcg9XjawVo3ddI4NcbuqbRYE4iRchcqfmkVY6i+nQcYvh+YP
	lLap5HHmNkXIwsUU7/CKhBGYGmUUJBZTHwqqrCo=
X-Google-Smtp-Source: AGHT+IG2iAz1xABGaGs2rDZt1oWCsEXZeLeP1c9HA/NTG9oc6uJbREbQ75bDcMYponZkLreadz1LYg==
X-Received: by 2002:a17:90b:1809:b0:27d:b244:cd28 with SMTP id lw9-20020a17090b180900b0027db244cd28mr400586pjb.42.1700768028753;
        Thu, 23 Nov 2023 11:33:48 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id pj4-20020a17090b4f4400b0028514bf911asm1840150pjb.43.2023.11.23.11.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 11:33:48 -0800 (PST)
Message-ID: <655fa91c.170a0220.8f7f1.57ba@mx.google.com>
Date: Thu, 23 Nov 2023 11:33:48 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.201-140-g682e7cb9e7b7
Subject: stable-rc/queue/5.10 baseline: 124 runs,
 8 regressions (v5.10.201-140-g682e7cb9e7b7)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 124 runs, 8 regressions (v5.10.201-140-g682e=
7cb9e7b7)

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

qemu_riscv64                 | riscv | lab-baylibre  | gcc-10   | defconfig=
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
nel/v5.10.201-140-g682e7cb9e7b7/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.201-140-g682e7cb9e7b7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      682e7cb9e7b7be647b4c476e48478cec9c43eee7 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/655f72dfe2407848427e4ac2

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-140-g682e7cb9e7b7/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-140-g682e7cb9e7b7/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655f72dfe2407848427e4afb
        failing since 282 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-11-23T15:42:08.346061  <8>[   20.649796] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 266084_1.5.2.4.1>
    2023-11-23T15:42:08.464636  / # #
    2023-11-23T15:42:08.569279  export SHELL=3D/bin/sh
    2023-11-23T15:42:08.570191  #
    2023-11-23T15:42:08.672136  / # export SHELL=3D/bin/sh. /lava-266084/en=
vironment
    2023-11-23T15:42:08.673099  =

    2023-11-23T15:42:08.775106  / # . /lava-266084/environment/lava-266084/=
bin/lava-test-runner /lava-266084/1
    2023-11-23T15:42:08.776539  =

    2023-11-23T15:42:08.780922  / # /lava-266084/bin/lava-test-runner /lava=
-266084/1
    2023-11-23T15:42:08.888751  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/655f73c58a217cc69e7e4b3a

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-140-g682e7cb9e7b7/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.t=
xt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-140-g682e7cb9e7b7/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655f73c58a217cc69e7e4b79
        failing since 1 day (last pass: v5.10.181-18-g1622068b57a4, first f=
ail: v5.10.201-98-g6f84b6dba25c)

    2023-11-23T15:45:49.567004  / # #
    2023-11-23T15:45:49.669785  export SHELL=3D/bin/sh
    2023-11-23T15:45:49.670563  #
    2023-11-23T15:45:49.772489  / # export SHELL=3D/bin/sh. /lava-266098/en=
vironment
    2023-11-23T15:45:49.773258  =

    2023-11-23T15:45:49.875249  / # . /lava-266098/environment/lava-266098/=
bin/lava-test-runner /lava-266098/1
    2023-11-23T15:45:49.876486  =

    2023-11-23T15:45:49.891313  / # /lava-266098/bin/lava-test-runner /lava=
-266098/1
    2023-11-23T15:45:49.949182  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-23T15:45:49.949695  + cd /lava-266098/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
qemu_riscv64                 | riscv | lab-baylibre  | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/655f700feb3241062c7e4a85

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-140-g682e7cb9e7b7/riscv/defconfig/gcc-10/lab-baylibre/baseline-qemu_riscv6=
4.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-140-g682e7cb9e7b7/riscv/defconfig/gcc-10/lab-baylibre/baseline-qemu_riscv6=
4.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/riscv/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/655f700feb3241062c7e4=
a86
        new failure (last pass: v5.10.201-98-g6f84b6dba25c) =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/655f732c35c2e905837e4ae6

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-140-g682e7cb9e7b7/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-140-g682e7cb9e7b7/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655f732c35c2e905837e4aef
        failing since 1 day (last pass: v5.10.181-18-g1622068b57a4, first f=
ail: v5.10.201-98-g6f84b6dba25c)

    2023-11-23T15:50:01.857836  / # #

    2023-11-23T15:50:01.960008  export SHELL=3D/bin/sh

    2023-11-23T15:50:01.960742  #

    2023-11-23T15:50:02.062260  / # export SHELL=3D/bin/sh. /lava-12068200/=
environment

    2023-11-23T15:50:02.062987  =


    2023-11-23T15:50:02.164385  / # . /lava-12068200/environment/lava-12068=
200/bin/lava-test-runner /lava-12068200/1

    2023-11-23T15:50:02.165434  =


    2023-11-23T15:50:02.181775  / # /lava-12068200/bin/lava-test-runner /la=
va-12068200/1

    2023-11-23T15:50:02.231245  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-23T15:50:02.231750  + cd /lav<8>[   16.467495] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12068200_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/655f7362936c45781b7e4a8a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-140-g682e7cb9e7b7/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-roc=
k-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-140-g682e7cb9e7b7/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-roc=
k-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655f7362936c45781b7e4a93
        failing since 1 day (last pass: v5.10.181-18-g1622068b57a4, first f=
ail: v5.10.201-98-g6f84b6dba25c)

    2023-11-23T15:44:21.385381  / # #

    2023-11-23T15:44:22.639485  export SHELL=3D/bin/sh

    2023-11-23T15:44:22.649756  #

    2023-11-23T15:44:24.384292  / # export SHELL=3D/bin/sh. /lava-12068199/=
environment

    2023-11-23T15:44:24.394620  =


    2023-11-23T15:44:27.579604  / # . /lava-12068199/environment/lava-12068=
199/bin/lava-test-runner /lava-12068199/1

    2023-11-23T15:44:27.591088  =


    2023-11-23T15:44:27.591568  / # /lava-12068199/bin/lava-test-runner /la=
va-12068199/1

    2023-11-23T15:44:27.646792  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-23T15:44:27.647289  + cd /lava-12068199/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/655f73255286eb809f7e4a9d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-140-g682e7cb9e7b7/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-140-g682e7cb9e7b7/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655f73255286eb809f7e4aa6
        failing since 1 day (last pass: v5.10.176-241-ga0049fd9c865, first =
fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-23T15:43:24.334313  <8>[   17.027695] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 445046_1.5.2.4.1>
    2023-11-23T15:43:24.439322  / # #
    2023-11-23T15:43:24.540963  export SHELL=3D/bin/sh
    2023-11-23T15:43:24.541645  #
    2023-11-23T15:43:24.642631  / # export SHELL=3D/bin/sh. /lava-445046/en=
vironment
    2023-11-23T15:43:24.643201  =

    2023-11-23T15:43:24.744246  / # . /lava-445046/environment/lava-445046/=
bin/lava-test-runner /lava-445046/1
    2023-11-23T15:43:24.745149  =

    2023-11-23T15:43:24.749396  / # /lava-445046/bin/lava-test-runner /lava=
-445046/1
    2023-11-23T15:43:24.816494  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/655f734035c2e905837e4b37

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-140-g682e7cb9e7b7/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-140-g682e7cb9e7b7/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655f734035c2e905837e4b40
        failing since 1 day (last pass: v5.10.176-241-ga0049fd9c865, first =
fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-23T15:50:17.666150  / # #

    2023-11-23T15:50:17.768153  export SHELL=3D/bin/sh

    2023-11-23T15:50:17.768847  #

    2023-11-23T15:50:17.870276  / # export SHELL=3D/bin/sh. /lava-12068206/=
environment

    2023-11-23T15:50:17.870978  =


    2023-11-23T15:50:17.972397  / # . /lava-12068206/environment/lava-12068=
206/bin/lava-test-runner /lava-12068206/1

    2023-11-23T15:50:17.973509  =


    2023-11-23T15:50:17.990551  / # /lava-12068206/bin/lava-test-runner /la=
va-12068206/1

    2023-11-23T15:50:18.033688  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-23T15:50:18.048536  + cd /lava-1206820<8>[   18.158437] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12068206_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/655f78325f73cf6c657e4a89

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-140-g682e7cb9e7b7/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-140-g682e7cb9e7b7/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655f78325f73cf6c657e4a92
        failing since 1 day (last pass: v5.10.165-77-g4600242c13ed, first f=
ail: v5.10.201-98-g6f84b6dba25c)

    2023-11-23T16:04:39.749395  / # #
    2023-11-23T16:04:39.850488  export SHELL=3D/bin/sh
    2023-11-23T16:04:39.850823  #
    2023-11-23T16:04:39.951570  / # export SHELL=3D/bin/sh. /lava-3844476/e=
nvironment
    2023-11-23T16:04:39.951903  =

    2023-11-23T16:04:40.052665  / # . /lava-3844476/environment/lava-384447=
6/bin/lava-test-runner /lava-3844476/1
    2023-11-23T16:04:40.053216  =

    2023-11-23T16:04:40.061194  / # /lava-3844476/bin/lava-test-runner /lav=
a-3844476/1
    2023-11-23T16:04:40.141269  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-23T16:04:40.176134  + cd /lava-3844476/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

