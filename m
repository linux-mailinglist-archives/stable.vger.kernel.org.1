Return-Path: <stable+bounces-8406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0793581D698
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 22:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5D81F211E5
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 21:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C36A15EBD;
	Sat, 23 Dec 2023 21:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Xedz5awK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3F416402
	for <stable@vger.kernel.org>; Sat, 23 Dec 2023 21:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3e6c86868so23153505ad.1
        for <stable@vger.kernel.org>; Sat, 23 Dec 2023 13:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703366230; x=1703971030; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+Fo8VNtK7c30LFQUsD6esp8uxW0yLqJEcZzdVTfc/ng=;
        b=Xedz5awK1R+bgpFNMQfZ0Nou4Uq6trcv7BGP0uSadCzTdvV17FA/It2LNSvSbU9ETu
         0ES7VMyQHTfWy+9VkAb1X6ZI8vhtC99cfppsoyQNj2g9YO7i5TEkyG/ptubMvdrf2Cgk
         PHoD/Ll+Z+TQSDgSQnGqSH2L74dPde7YCy1b8J3k+2wnzk2U2TzAAf489H1inUkMNYEg
         C6mAKE3ku78HDwgNUDB7LqnJZnvkArEpzYH3GR49y1KpqLq2z9kor12JY6PrL9fyebdq
         0LcBVAEfZfXWu5JWMITS7SekA5z2VEM7sn9qNTvF3iguPJv70nBdozKp+wlWI895umvG
         w9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703366230; x=1703971030;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Fo8VNtK7c30LFQUsD6esp8uxW0yLqJEcZzdVTfc/ng=;
        b=OiIvU7XNsLGaWyc5tbkjp5TNrOtiUSs5YyemdG0aZoKSKxmiGPsHbgJRLh7R0Ya+hk
         UX8mHbqe3XNUS9PX9BD2PO7t+BAIZxdwDolK9UIJ+nPi8t8ouTxuQF5ogmXe0ei6m8Ue
         +cOq3zElDXhyT60J+xL936jxKvRjnKNxmMHkxcCqpU6Ih4nRvkGnE7h8wt/NBJOknqsR
         R72A8IjjESeyZG8P8OGycMzmNGW3Nq6yJxMF/XeytK8omZI38iR9a9p+2d5tTXGfLyxl
         R/L+mHViZs+agxubk5y4fqP61m4T0kVRPc+nWm63s/EjfDwKtFYHjhEsv8lBOPRdGQG2
         7flw==
X-Gm-Message-State: AOJu0YxL9MuCU1aOahxrk/EIqPPaudnK2Tip0wKctZwMdjt4WEAFGcCJ
	fE4RGAZVMR1pSv+laEyPngxpe87b7MTXQz11Z1PsGe1+ukk=
X-Google-Smtp-Source: AGHT+IElIkABRG25xgdBmggL/F3BjTAa6BLMShkSHul8kjM3u2+yOr7wrInapAbW1yWCW1oQk/nNUQ==
X-Received: by 2002:a17:902:da8f:b0:1d3:e06d:6d8 with SMTP id j15-20020a170902da8f00b001d3e06d06d8mr4472811plx.4.1703366230131;
        Sat, 23 Dec 2023 13:17:10 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090264c800b001d1cd7e4ad2sm5628103pli.125.2023.12.23.13.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 13:17:09 -0800 (PST)
Message-ID: <65874e55.170a0220.e654f.0a81@mx.google.com>
Date: Sat, 23 Dec 2023 13:17:09 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.204-83-gffa73e802298
Subject: stable-rc/queue/5.10 baseline: 100 runs,
 6 regressions (v5.10.204-83-gffa73e802298)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 100 runs, 6 regressions (v5.10.204-83-gffa73=
e802298)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
beaglebone-black   | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig=
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
nel/v5.10.204-83-gffa73e802298/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.204-83-gffa73e802298
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      ffa73e802298edf71ee779f07b74f3a838e8352c =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
beaglebone-black   | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig=
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65871db64234cfc180e1347f

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-83-gffa73e802298/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beagl=
ebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-83-gffa73e802298/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beagl=
ebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65871db64234cfc180e134b3
        failing since 312 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-23T17:49:28.046063  <8>[   19.290007] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 391039_1.5.2.4.1>
    2023-12-23T17:49:28.157272  / # #
    2023-12-23T17:49:28.260621  export SHELL=3D/bin/sh
    2023-12-23T17:49:28.261605  #
    2023-12-23T17:49:28.363480  / # export SHELL=3D/bin/sh. /lava-391039/en=
vironment
    2023-12-23T17:49:28.364423  =

    2023-12-23T17:49:28.466642  / # . /lava-391039/environment/lava-391039/=
bin/lava-test-runner /lava-391039/1
    2023-12-23T17:49:28.468187  =

    2023-12-23T17:49:28.472697  / # /lava-391039/bin/lava-test-runner /lava=
-391039/1
    2023-12-23T17:49:28.578786  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65871b036e110fda5ae134bc

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-83-gffa73e802298/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-83-gffa73e802298/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65871b036e110fda5ae134c5
        failing since 31 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-23T17:45:27.099978  / # #

    2023-12-23T17:45:27.200619  export SHELL=3D/bin/sh

    2023-12-23T17:45:27.200758  #

    2023-12-23T17:45:27.301266  / # export SHELL=3D/bin/sh. /lava-12366272/=
environment

    2023-12-23T17:45:27.301463  =


    2023-12-23T17:45:27.402006  / # . /lava-12366272/environment/lava-12366=
272/bin/lava-test-runner /lava-12366272/1

    2023-12-23T17:45:27.402350  =


    2023-12-23T17:45:27.408010  / # /lava-12366272/bin/lava-test-runner /la=
va-12366272/1

    2023-12-23T17:45:27.467907  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-23T17:45:27.468059  + cd /lav<8>[   16.400851] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12366272_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
rk3399-gru-kevin   | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chr=
omebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65871ad67b4f9c6c81e13487

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-83-gffa73e802298/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-83-gffa73e802298/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/65871ad67b4f9c6c81e13491
        failing since 284 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-23T17:37:41.763426  /lava-12366236/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/65871ad67b4f9c6c81e13492
        failing since 284 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-23T17:37:39.700430  <8>[   33.223722] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-12-23T17:37:40.725186  /lava-12366236/1/../bin/lava-test-case

    2023-12-23T17:37:40.736494  <8>[   34.260184] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65871ae9f3d8ae1d9be1347a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-83-gffa73e802298/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine=
-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-83-gffa73e802298/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine=
-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65871ae9f3d8ae1d9be13483
        failing since 31 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-23T17:37:33.505521  / # #
    2023-12-23T17:37:33.607318  export SHELL=3D/bin/sh
    2023-12-23T17:37:33.608143  #
    2023-12-23T17:37:33.709360  / # export SHELL=3D/bin/sh. /lava-449722/en=
vironment
    2023-12-23T17:37:33.710057  =

    2023-12-23T17:37:33.811074  / # . /lava-449722/environment/lava-449722/=
bin/lava-test-runner /lava-449722/1
    2023-12-23T17:37:33.811991  =

    2023-12-23T17:37:33.815494  / # /lava-449722/bin/lava-test-runner /lava=
-449722/1
    2023-12-23T17:37:33.883660  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-23T17:37:33.884047  + cd /lava-449722/<8>[   17.402946] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 449722_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65871b19a0e7f37451e134b0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-83-gffa73e802298/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-83-gffa73e802298/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65871b19a0e7f37451e134b9
        failing since 31 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-23T17:45:43.682345  / # #

    2023-12-23T17:45:43.782892  export SHELL=3D/bin/sh

    2023-12-23T17:45:43.783050  #

    2023-12-23T17:45:43.883536  / # export SHELL=3D/bin/sh. /lava-12366270/=
environment

    2023-12-23T17:45:43.883653  =


    2023-12-23T17:45:43.984153  / # . /lava-12366270/environment/lava-12366=
270/bin/lava-test-runner /lava-12366270/1

    2023-12-23T17:45:43.984358  =


    2023-12-23T17:45:43.996082  / # /lava-12366270/bin/lava-test-runner /la=
va-12366270/1

    2023-12-23T17:45:44.056197  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-23T17:45:44.056277  + cd /lava-1236627<8>[   18.179299] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12366270_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

