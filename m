Return-Path: <stable+bounces-5212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5C180BCDC
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 21:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F04BB20838
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 20:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23351C6B3;
	Sun, 10 Dec 2023 20:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="kSLNQALR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DDEE1
	for <stable@vger.kernel.org>; Sun, 10 Dec 2023 12:06:53 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d0b2752dc6so33063645ad.3
        for <stable@vger.kernel.org>; Sun, 10 Dec 2023 12:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702238812; x=1702843612; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v6B1p9vDh92rPramkNW3AMDAjRKHMnaV4QCeBfqL4SM=;
        b=kSLNQALRmGUjPafzCdhwOSj6F2Ev/znJjHDzHyo5MQy3n7MrazhQ1PivDtphzB0WaS
         rLZlyHtd18ZceXn7fnEY3lgq+tWFXAzw6+gIFTdjyGAbUyabdvnd0tAAEgyvExDDDD4u
         iKX6oZr3vHNN4mRJktKPkWsIhirzOflBRQgQw+YM3mH5M/yyaV/T1q9ahU4WXIapo3rx
         bZNq9Cq47scKIAVtMiWtig83LmjaHtL21RpenRDsoaGWjyjYtX/YVWMl3YgJkCCv0HUi
         mpq5l1I8JzHK60LBW5u3kFqhbhYpNxXWNLZFOZCllK1baNpepwwnc/2WNJJoyNyStsDk
         kvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702238812; x=1702843612;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v6B1p9vDh92rPramkNW3AMDAjRKHMnaV4QCeBfqL4SM=;
        b=AyA0ZW8u9k6ljz1lU978/EB09RKob/ZZJYfIUtAMCR1zWA7xvBywe87zDOPpjfSWmk
         uoWdKetefR90CYpez5iYl2w/22peR+Jvw3Rgl13VRhzwtW+oKdSByLHNsW0ZyujuIv6M
         QSFI++oGwAGAZ8yTrr9pSdkeRxmNPkt5v4LKkbTgt6FXL6LpXT1cW4oXPxG39lCBkrrV
         KzbIiGYzjHvs18ECptoTL9d6ZLZe9LXwfwRoHoBvJTrwlB9J0VATlhSHvifTneafcQJY
         pc4AHwRss6Ua9X3bIoSPtLXMMUso4k++ZkhwaMIlT30/WXBfiXdiDisdGgIPReQ+wOTQ
         owSA==
X-Gm-Message-State: AOJu0YyA6nDJC3KKEIDY8j3/DDViszQveN+jpmw00GToILI6k2SK9Td+
	Y1NVK+DBjPd0oGnTNCR5KS345r6yEXjHFD00GPLxDQ==
X-Google-Smtp-Source: AGHT+IEugi7nhhjEGr0OCh24yLo+nroKxHyx/2+eZQ3N+u81H46wKIeNTLS1QNASsprZjaH2oCpV/g==
X-Received: by 2002:a17:902:ab4e:b0:1d0:6ffd:9e0a with SMTP id ij14-20020a170902ab4e00b001d06ffd9e0amr3153928plb.92.1702238812324;
        Sun, 10 Dec 2023 12:06:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i5-20020a170902eb4500b001cfc618d76csm5123103pli.70.2023.12.10.12.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 12:06:51 -0800 (PST)
Message-ID: <65761a5b.170a0220.6f981.e667@mx.google.com>
Date: Sun, 10 Dec 2023 12:06:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.142-98-g1a1d8f874fa7b
Subject: stable-rc/queue/5.15 baseline: 96 runs,
 5 regressions (v5.15.142-98-g1a1d8f874fa7b)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 96 runs, 5 regressions (v5.15.142-98-g1a1d8f=
874fa7b)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
meson-gxbb-p200    | arm64 | lab-baylibre  | gcc-10   | defconfig          =
| 1          =

panda              | arm   | lab-baylibre  | gcc-10   | multi_v7_defconfig =
| 1          =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
| 1          =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
| 1          =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
| 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.142-98-g1a1d8f874fa7b/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.142-98-g1a1d8f874fa7b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      1a1d8f874fa7b29529608697cce86b6bc1036860 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
meson-gxbb-p200    | arm64 | lab-baylibre  | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/6575eabe72eb7d8b90e135a6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-98-g1a1d8f874fa7b/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-=
p200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-98-g1a1d8f874fa7b/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-=
p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6575eabe72eb7d8b90e13=
5a7
        failing since 1 day (last pass: v5.15.142-48-gdbed703bb51c2, first =
fail: v5.15.142-77-ga64dd884b1d57) =

 =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
panda              | arm   | lab-baylibre  | gcc-10   | multi_v7_defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/6575e804c9656f2293e13475

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-98-g1a1d8f874fa7b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pand=
a.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-98-g1a1d8f874fa7b/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pand=
a.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6575e804c9656f2293e1347a
        failing since 3 days (last pass: v5.15.74-135-g19e8e8e20e2b, first =
fail: v5.15.141-64-g41591b7f348c5)

    2023-12-10T16:31:49.076470  <8>[   11.722656] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3873021_1.5.2.4.1>
    2023-12-10T16:31:49.183122  / # #
    2023-12-10T16:31:49.284499  export SHELL=3D/bin/sh
    2023-12-10T16:31:49.284959  #
    2023-12-10T16:31:49.385767  / # export SHELL=3D/bin/sh. /lava-3873021/e=
nvironment
    2023-12-10T16:31:49.386238  =

    2023-12-10T16:31:49.487080  / # . /lava-3873021/environment/lava-387302=
1/bin/lava-test-runner /lava-3873021/1
    2023-12-10T16:31:49.487761  =

    2023-12-10T16:31:49.492605  / # /lava-3873021/bin/lava-test-runner /lav=
a-3873021/1
    2023-12-10T16:31:49.549237  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/6575e94f61c052dbcde135b7

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-98-g1a1d8f874fa7b/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-98-g1a1d8f874fa7b/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6575e94f61c052dbcde135bc
        failing since 18 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-10T16:45:02.425232  / # #

    2023-12-10T16:45:02.525771  export SHELL=3D/bin/sh

    2023-12-10T16:45:02.525891  #

    2023-12-10T16:45:02.626369  / # export SHELL=3D/bin/sh. /lava-12236811/=
environment

    2023-12-10T16:45:02.626497  =


    2023-12-10T16:45:02.727019  / # . /lava-12236811/environment/lava-12236=
811/bin/lava-test-runner /lava-12236811/1

    2023-12-10T16:45:02.727233  =


    2023-12-10T16:45:02.738993  / # /lava-12236811/bin/lava-test-runner /la=
va-12236811/1

    2023-12-10T16:45:02.792374  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-10T16:45:02.792454  + cd /lav<8>[   16.045361] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12236811_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/6575e977a604d490cfe13476

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-98-g1a1d8f874fa7b/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-98-g1a1d8f874fa7b/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6575e977a604d490cfe1347b
        failing since 18 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-10T16:38:06.198423  <8>[   16.126698] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447424_1.5.2.4.1>
    2023-12-10T16:38:06.303438  / # #
    2023-12-10T16:38:06.405108  export SHELL=3D/bin/sh
    2023-12-10T16:38:06.405711  #
    2023-12-10T16:38:06.506718  / # export SHELL=3D/bin/sh. /lava-447424/en=
vironment
    2023-12-10T16:38:06.507393  =

    2023-12-10T16:38:06.608412  / # . /lava-447424/environment/lava-447424/=
bin/lava-test-runner /lava-447424/1
    2023-12-10T16:38:06.609291  =

    2023-12-10T16:38:06.613809  / # /lava-447424/bin/lava-test-runner /lava=
-447424/1
    2023-12-10T16:38:06.645845  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/6575e9637a2ac52f81e13484

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-98-g1a1d8f874fa7b/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-98-g1a1d8f874fa7b/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6575e9637a2ac52f81e13489
        failing since 18 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-10T16:45:23.341942  / # #

    2023-12-10T16:45:23.444043  export SHELL=3D/bin/sh

    2023-12-10T16:45:23.444716  #

    2023-12-10T16:45:23.546034  / # export SHELL=3D/bin/sh. /lava-12236810/=
environment

    2023-12-10T16:45:23.546731  =


    2023-12-10T16:45:23.648158  / # . /lava-12236810/environment/lava-12236=
810/bin/lava-test-runner /lava-12236810/1

    2023-12-10T16:45:23.649319  =


    2023-12-10T16:45:23.665829  / # /lava-12236810/bin/lava-test-runner /la=
va-12236810/1

    2023-12-10T16:45:23.723610  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-10T16:45:23.724144  + cd /lava-1223681<8>[   16.780629] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12236810_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

