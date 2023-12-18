Return-Path: <stable+bounces-7620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06074817397
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BF441C24023
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C1518E03;
	Mon, 18 Dec 2023 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="C8Sd9VoD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15446622
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d39afa1eecso17242665ad.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 06:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702909954; x=1703514754; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NUYbXPSo+bKJ0xjDOj/19KXnGNsQzgu5fxhoWrHoXgM=;
        b=C8Sd9VoD6WLKwereVGBT121eyHe/MhHbtLEOYoJNhCvfKmBVWCCqX/ZUraMP9/9+/0
         AGjUXCLMMAcB27BTAGPENqSh2+s09PF56YJQXrJ/GjYdXL8DGpJ82fLqEZ8HCUFjB96o
         MZtisApcDiDRNWyVVwiMI0E+BXHG6QjVU8f+mAIF39NOw45gjqLes9PHnqU1gWHwBJDY
         pFx8KtWQqPwFgX0qVNvEu1n8Cae4sIDtIk2/yatBg9kvmwjsk0/JsnDSXPOZwmMD/Vhr
         5+ErfQEQ/cwolvo+2GRz35I0ssSHuFtlcUuGDOC3x/Gfc91w3qrO7o6iVYDvu5Q6NZP8
         lqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702909954; x=1703514754;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NUYbXPSo+bKJ0xjDOj/19KXnGNsQzgu5fxhoWrHoXgM=;
        b=aR+n0iOVwSd85/39Y8X+sj0ZI8+TopaZ+nqpFUAacsxcq5GV69tsPjfeUOE7BlGeMj
         yBzkFB7etr5Z7JCegA+c7WJXhDGxRurUQY/hIbOcKfL2T3xBkpBPFC30W2cJUZqVbwf1
         5TE6lypOmBscUa/q/zsdMNCFjZUvvUMdZkw7RbnvFjLvFA0K6zZ/DE61008K+x9BFa7r
         a0MF+JQcYCxU+78Z/3sAuLm9o3JyLi3ZkRnbbtj+6Lo+wE6nZxf/0uwivg/7yZsywGS5
         UGOIVY7iwGI5RX44taEJvEmvZ72zj5frMq1DWdNhxUOed0KFJ+SK5BcqyND8Yp89iC0C
         HMBw==
X-Gm-Message-State: AOJu0YwbsvCgqtJNDTZYB9mHK8QNf0d8g9hETgZ35Dfy/HRTpS/aqiOi
	GcS3PRnVEOtaNEo7w9hZ70gwaTp/HMuDonWxH+E=
X-Google-Smtp-Source: AGHT+IElvRtBf+fKEkNoe1roAk/YVWSb+4d0dEYsUoe1DFW1FkAF70P5fTsMU1IsupPNzwsgi0RzJw==
X-Received: by 2002:a17:903:2604:b0:1d3:d3a6:1578 with SMTP id jd4-20020a170903260400b001d3d3a61578mr238515plb.14.1702909953889;
        Mon, 18 Dec 2023 06:32:33 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x7-20020a1709029a4700b001cf7bd9ade5sm19055228plv.3.2023.12.18.06.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 06:32:33 -0800 (PST)
Message-ID: <65805801.170a0220.fdd91.8d41@mx.google.com>
Date: Mon, 18 Dec 2023 06:32:33 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.68-105-g2656a04354e11
Subject: stable-rc/queue/6.1 baseline: 113 runs,
 4 regressions (v6.1.68-105-g2656a04354e11)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 113 runs, 4 regressions (v6.1.68-105-g2656a04=
354e11)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
odroid-xu3         | arm   | lab-collabora | gcc-10   | multi_v7_defconfig =
| 1          =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
| 1          =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
| 1          =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
| 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.68-105-g2656a04354e11/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.68-105-g2656a04354e11
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      2656a04354e114a239cf9897aa3f4f4a1efddd80 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
odroid-xu3         | arm   | lab-collabora | gcc-10   | multi_v7_defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/65802780e7c0dc7b5de13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
5-g2656a04354e11/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-odroi=
d-xu3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
5-g2656a04354e11/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-odroi=
d-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65802780e7c0dc7b5de13=
476
        new failure (last pass: v6.1.68-79-gcd84d41e714d8) =

 =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/658026a4bf88a66699e134fb

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
5-g2656a04354e11/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
5-g2656a04354e11/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658026a4bf88a66699e13500
        failing since 25 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-18T11:09:16.940559  / # #

    2023-12-18T11:09:17.041241  export SHELL=3D/bin/sh

    2023-12-18T11:09:17.041481  #

    2023-12-18T11:09:17.141946  / # export SHELL=3D/bin/sh. /lava-12301976/=
environment

    2023-12-18T11:09:17.142161  =


    2023-12-18T11:09:17.242736  / # . /lava-12301976/environment/lava-12301=
976/bin/lava-test-runner /lava-12301976/1

    2023-12-18T11:09:17.243708  =


    2023-12-18T11:09:17.249420  / # /lava-12301976/bin/lava-test-runner /la=
va-12301976/1

    2023-12-18T11:09:17.308325  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-18T11:09:17.308483  + cd /lav<8>[   19.070215] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12301976_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/658026a6bf88a66699e13508

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
5-g2656a04354e11/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
5-g2656a04354e11/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658026a6bf88a66699e1350d
        failing since 25 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-18T11:01:39.331382  <8>[   18.091096] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 448698_1.5.2.4.1>
    2023-12-18T11:01:39.436391  / # #
    2023-12-18T11:01:39.538091  export SHELL=3D/bin/sh
    2023-12-18T11:01:39.538669  #
    2023-12-18T11:01:39.639656  / # export SHELL=3D/bin/sh. /lava-448698/en=
vironment
    2023-12-18T11:01:39.640273  =

    2023-12-18T11:01:39.741312  / # . /lava-448698/environment/lava-448698/=
bin/lava-test-runner /lava-448698/1
    2023-12-18T11:01:39.742212  =

    2023-12-18T11:01:39.746578  / # /lava-448698/bin/lava-test-runner /lava=
-448698/1
    2023-12-18T11:01:39.825514  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/658026b86bb2beeac7e134e5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
5-g2656a04354e11/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
5-g2656a04354e11/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658026b86bb2beeac7e134ea
        failing since 25 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-18T11:09:32.608507  / # #

    2023-12-18T11:09:32.709011  export SHELL=3D/bin/sh

    2023-12-18T11:09:32.709168  #

    2023-12-18T11:09:32.809614  / # export SHELL=3D/bin/sh. /lava-12301972/=
environment

    2023-12-18T11:09:32.809734  =


    2023-12-18T11:09:32.910181  / # . /lava-12301972/environment/lava-12301=
972/bin/lava-test-runner /lava-12301972/1

    2023-12-18T11:09:32.910384  =


    2023-12-18T11:09:32.922185  / # /lava-12301972/bin/lava-test-runner /la=
va-12301972/1

    2023-12-18T11:09:32.992168  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-18T11:09:32.992236  + cd /lava-1230197<8>[   19.144786] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12301972_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

