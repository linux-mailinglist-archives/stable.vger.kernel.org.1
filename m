Return-Path: <stable+bounces-5042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2170E80A952
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 17:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ADCEB20B30
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 16:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FF920334;
	Fri,  8 Dec 2023 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Ro/ycpMu"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAA41987
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 08:38:07 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7b6f2dd5633so86724439f.2
        for <stable@vger.kernel.org>; Fri, 08 Dec 2023 08:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702053487; x=1702658287; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v9ogm2P7/HpxlmqgQv7xU24T8+TP/KBtZb7sVvEbSgU=;
        b=Ro/ycpMuRDmWcVDHHrx03hf9hymgRR4K+ztmAIKSfFCKnICRKbfkLvSEToEfYeA7BJ
         xOi7K6Dk7EB+2HvG86HZqNq8qjDSpMOf7yRgGNxW9WCwzS/ET4NyO02FKhBnH8N8cj+S
         vC+GMRSKh+5asYvbRhtjpq+ATCM1bOAifYlcYmlqBvXoLGuk3H+d54D40rlMs4DXQbVX
         DHlXYa49LbeTtbW26Wyj2boFYPEybcnwwp7saYsJmdz4S5CgUhPx8pJ1WxZFyWYdKDtN
         WWHuemnYae/o4K/ovxTxVKsxYED39YQosoFq/TbafE9CwE7PZpI7z4igDIgyAJ2XnFSX
         RY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702053487; x=1702658287;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v9ogm2P7/HpxlmqgQv7xU24T8+TP/KBtZb7sVvEbSgU=;
        b=tyntYkX9Uy1uXQWcre1w/Uiad6OBCoDn0PWZZH2XjPELZUJjI0FAwvjGXtAJgHBIF4
         waLbvS1pXCv3K2nP0Nqt2pecWmDCizxPy1CApVb3FzXsyF2+f/szWA7R4h0aGdzo09YV
         9gmuNszJoDL860ipNgBIcZxIPO3obqTGERd9IXz9TANybhOi9D4Sjr+j6AiZGH32+aHD
         Gghv5aPOXCWFEBb+W1EjJU1P9w01K0m472FDUR0Eiv4NwI+3WXSs0suQY/D5/stVWneH
         cwwXwwsEw2qmei3Cy8mrBskkyO/MEnG1XdWl8R5yZQixhTodQ22pQ58HyrN5Fz/6cbrd
         A0Sg==
X-Gm-Message-State: AOJu0Yw7WfhI1Qpx4TSRe53MRKc1EWXVDtfHJoNyaOEtOhKo/W9bFQ9k
	ZbfBcTRKMVjAf7IJ0KWUBXsaToY9IMEERMa5z8J+Bg==
X-Google-Smtp-Source: AGHT+IFFs4tE0JFnSnNNNnRJd9zc6Nkr0jOJmOdLgiAUUZWbWEoJC+m7Lxb51EKWLkP6vyeqO9oFSw==
X-Received: by 2002:a05:6e02:1a6a:b0:35d:59a2:2cd with SMTP id w10-20020a056e021a6a00b0035d59a202cdmr441146ilv.109.1702053486658;
        Fri, 08 Dec 2023 08:38:06 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u19-20020a63ef13000000b005c661a432d7sm1747951pgh.75.2023.12.08.08.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 08:38:06 -0800 (PST)
Message-ID: <6573466e.630a0220.2d53a.605c@mx.google.com>
Date: Fri, 08 Dec 2023 08:38:06 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.142-8-ge5a5d1af708ec
Subject: stable-rc/queue/5.15 baseline: 148 runs,
 6 regressions (v5.15.142-8-ge5a5d1af708ec)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 148 runs, 6 regressions (v5.15.142-8-ge5a5d1=
af708ec)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beagle-xm          | arm   | lab-baylibre  | gcc-10   | omap2plus_defconfig=
 | 1          =

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
nel/v5.15.142-8-ge5a5d1af708ec/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.142-8-ge5a5d1af708ec
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      e5a5d1af708eced93db167ad55998166e9d893e1 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beagle-xm          | arm   | lab-baylibre  | gcc-10   | omap2plus_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65731497a61261ab19e134a3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-8-ge5a5d1af708ec/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-8-ge5a5d1af708ec/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65731497a61261ab19e13=
4a4
        failing since 308 days (last pass: v5.15.91-12-g3290f78df1ab, first=
 fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
meson-gxbb-p200    | arm64 | lab-baylibre  | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657315f0c8c27699e5e13482

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-8-ge5a5d1af708ec/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p=
200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-8-ge5a5d1af708ec/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p=
200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/657315f0c8c27699e5e13=
483
        new failure (last pass: v5.15.112-273-gd9a33ebea341) =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
panda              | arm   | lab-baylibre  | gcc-10   | multi_v7_defconfig =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657315d857890cfc3ee13656

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-8-ge5a5d1af708ec/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-panda=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-8-ge5a5d1af708ec/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-panda=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657315d857890cfc3ee1365f
        failing since 1 day (last pass: v5.15.74-135-g19e8e8e20e2b, first f=
ail: v5.15.141-64-g41591b7f348c5)

    2023-12-08T13:10:26.880104  <8>[   11.681518] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3866828_1.5.2.4.1>
    2023-12-08T13:10:26.986694  / # #
    2023-12-08T13:10:27.087997  export SHELL=3D/bin/sh
    2023-12-08T13:10:27.088506  #
    2023-12-08T13:10:27.189314  / # export SHELL=3D/bin/sh. /lava-3866828/e=
nvironment
    2023-12-08T13:10:27.189807  =

    2023-12-08T13:10:27.290657  / # . /lava-3866828/environment/lava-386682=
8/bin/lava-test-runner /lava-3866828/1
    2023-12-08T13:10:27.291392  =

    2023-12-08T13:10:27.295595  / # /lava-3866828/bin/lava-test-runner /lav=
a-3866828/1
    2023-12-08T13:10:27.351611  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657314c994625c186ee134a5

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-8-ge5a5d1af708ec/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-8-ge5a5d1af708ec/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657314c994625c186ee134ae
        failing since 15 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-08T13:13:45.944219  / # #

    2023-12-08T13:13:46.046216  export SHELL=3D/bin/sh

    2023-12-08T13:13:46.046925  #

    2023-12-08T13:13:46.148412  / # export SHELL=3D/bin/sh. /lava-12218698/=
environment

    2023-12-08T13:13:46.149113  =


    2023-12-08T13:13:46.250395  / # . /lava-12218698/environment/lava-12218=
698/bin/lava-test-runner /lava-12218698/1

    2023-12-08T13:13:46.250746  =


    2023-12-08T13:13:46.252041  / # /lava-12218698/bin/lava-test-runner /la=
va-12218698/1

    2023-12-08T13:13:46.317136  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-08T13:13:46.317608  + cd /lav<8>[   15.990575] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12218698_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657314d5f45e5c2f10e134da

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-8-ge5a5d1af708ec/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine=
-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-8-ge5a5d1af708ec/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine=
-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657314d5f45e5c2f10e134e3
        failing since 15 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-08T13:06:20.708961  <8>[   16.055266] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447087_1.5.2.4.1>
    2023-12-08T13:06:20.814055  / # #
    2023-12-08T13:06:20.915740  export SHELL=3D/bin/sh
    2023-12-08T13:06:20.916355  #
    2023-12-08T13:06:21.017355  / # export SHELL=3D/bin/sh. /lava-447087/en=
vironment
    2023-12-08T13:06:21.017968  =

    2023-12-08T13:06:21.118982  / # . /lava-447087/environment/lava-447087/=
bin/lava-test-runner /lava-447087/1
    2023-12-08T13:06:21.119878  =

    2023-12-08T13:06:21.124268  / # /lava-447087/bin/lava-test-runner /lava=
-447087/1
    2023-12-08T13:06:21.156415  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657314e38f7124778fe13475

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-8-ge5a5d1af708ec/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-8-ge5a5d1af708ec/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657314e38f7124778fe1347e
        failing since 15 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-08T13:14:01.717438  / # #

    2023-12-08T13:14:01.818092  export SHELL=3D/bin/sh

    2023-12-08T13:14:01.818326  #

    2023-12-08T13:14:01.918815  / # export SHELL=3D/bin/sh. /lava-12218694/=
environment

    2023-12-08T13:14:01.919004  =


    2023-12-08T13:14:02.019511  / # . /lava-12218694/environment/lava-12218=
694/bin/lava-test-runner /lava-12218694/1

    2023-12-08T13:14:02.019715  =


    2023-12-08T13:14:02.031062  / # /lava-12218694/bin/lava-test-runner /la=
va-12218694/1

    2023-12-08T13:14:02.094124  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-08T13:14:02.094288  + cd /lava-1221869<8>[   16.892589] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12218694_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

