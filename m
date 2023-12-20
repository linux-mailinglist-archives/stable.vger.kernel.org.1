Return-Path: <stable+bounces-8202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DE081A942
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 23:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59C51F23D0E
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 22:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A514C22066;
	Wed, 20 Dec 2023 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="yVHPDk1a"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EFD4A988
	for <stable@vger.kernel.org>; Wed, 20 Dec 2023 22:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-35fc5f0f9c0so690795ab.0
        for <stable@vger.kernel.org>; Wed, 20 Dec 2023 14:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703112019; x=1703716819; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DDbKcN4z+MnRrLWWTJK1tCrTKeYITlmkNcQVRcrCP20=;
        b=yVHPDk1aPz9Eh1OqmLUBuv+5KcGJB2i/JGoyYUkmmDZO+F4mRA7ncsR/xUKEdtfWUa
         8YM1+F5waLjkZ0bJBxUKx/KoCjK1BrL+PIddS48K5X2lWOLWv6c3mQvz0bFSGgg+6yyT
         ZWNgiHYIh+zb47nkhNPokKrRo+caGIph4trk25+JfM3ghU7a7aGMBewnC6FaGbIdV0qx
         3gNNYP7i5En4mhCnKgiZzN0X9XX3ismwqRFkcuN+0ZPPc0szVAV5nEtjGgAxSPmU6KI0
         dVcRZUjaT2IH+SU0U0RqcyTca8hxFUrltUUw9kIcjUVcySdZCeLoer6gnuMOUnv8wcVG
         cJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703112019; x=1703716819;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DDbKcN4z+MnRrLWWTJK1tCrTKeYITlmkNcQVRcrCP20=;
        b=mcg0JmwUFJmR10pCvEABKz5psnqsgvDshE/xv+BzghFVZfxFctxPOUr4rJIviAKMPP
         gt8AvABz/hJEVbxRGMdsZQawcCkEhDALAcnw4FmjJSz55LKEce933xYuoTAkdMPI9tAc
         9gW7a2OdDCPSL1lGoC4XXPa4Udrn618/5wb0gRWg4AWc+2aveZZ7KXMmSQxPfEPPwjke
         qsz9bwId2RvVrz69p2eL91GaFqJtmL68spcA9110Y4O05DSnNFkNFI5yMSkvjFmab0rQ
         6Yf1gWBYk+kXLdWpdL8dTywVRk64KmB+MAdAaS5mRwynVJz7Usp83QJsGA6QJsd0Y668
         WNOg==
X-Gm-Message-State: AOJu0Yw3yGkBAAtJW9uQ/KARoe1obJiPebtzonyo1763Ov88cmeeW4mI
	WVnDgswmYqr1X9tbkCcWTBj+adHkjO32Ppvibos=
X-Google-Smtp-Source: AGHT+IEyCpbPX5FMxHtGXNiTMha799uL5OJwB5vQfn/2x3BMR9wk0/FpIhnI/OQ5/mszJB1mDAylMQ==
X-Received: by 2002:a05:6e02:b24:b0:35f:ceba:d524 with SMTP id e4-20020a056e020b2400b0035fcebad524mr1384830ilu.17.1703112019253;
        Wed, 20 Dec 2023 14:40:19 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f3-20020a17090274c300b001cf6453b237sm227379plt.236.2023.12.20.14.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 14:40:18 -0800 (PST)
Message-ID: <65836d52.170a0220.eeafd.136e@mx.google.com>
Date: Wed, 20 Dec 2023 14:40:18 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.204-60-gbd6aa237ba9cb
Subject: stable-rc/queue/5.10 baseline: 100 runs,
 6 regressions (v5.10.204-60-gbd6aa237ba9cb)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 100 runs, 6 regressions (v5.10.204-60-gbd6aa=
237ba9cb)

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
nel/v5.10.204-60-gbd6aa237ba9cb/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.204-60-gbd6aa237ba9cb
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      bd6aa237ba9cb1c1e2f50a97b8eb6b36b11bbbaf =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
beaglebone-black   | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig=
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65833c8eb1cc80421ee13501

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-60-gbd6aa237ba9cb/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-60-gbd6aa237ba9cb/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65833c8eb1cc80421ee13536
        failing since 309 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-20T19:11:53.172563  <8>[   15.768259] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 378784_1.5.2.4.1>
    2023-12-20T19:11:53.281732  / # #
    2023-12-20T19:11:53.383903  export SHELL=3D/bin/sh
    2023-12-20T19:11:53.384542  #
    2023-12-20T19:11:53.485879  / # export SHELL=3D/bin/sh. /lava-378784/en=
vironment
    2023-12-20T19:11:53.486319  =

    2023-12-20T19:11:53.587611  / # . /lava-378784/environment/lava-378784/=
bin/lava-test-runner /lava-378784/1
    2023-12-20T19:11:53.588203  =

    2023-12-20T19:11:53.592460  / # /lava-378784/bin/lava-test-runner /lava=
-378784/1
    2023-12-20T19:11:53.694915  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65833b6e4acd049308e134b1

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-60-gbd6aa237ba9cb/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-60-gbd6aa237ba9cb/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65833b6e4acd049308e134b6
        failing since 28 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-20T19:14:52.130984  / # #

    2023-12-20T19:14:52.231431  export SHELL=3D/bin/sh

    2023-12-20T19:14:52.231528  #

    2023-12-20T19:14:52.331954  / # export SHELL=3D/bin/sh. /lava-12329443/=
environment

    2023-12-20T19:14:52.332052  =


    2023-12-20T19:14:52.432479  / # . /lava-12329443/environment/lava-12329=
443/bin/lava-test-runner /lava-12329443/1

    2023-12-20T19:14:52.432665  =


    2023-12-20T19:14:52.444918  / # /lava-12329443/bin/lava-test-runner /la=
va-12329443/1

    2023-12-20T19:14:52.498423  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-20T19:14:52.498488  + cd /lav<8>[   16.415291] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12329443_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
rk3399-gru-kevin   | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chr=
omebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65833c0c8a42f1e257e13637

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-60-gbd6aa237ba9cb/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-60-gbd6aa237ba9cb/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/65833c0c8a42f1e257e1363d
        failing since 281 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-20T19:09:50.666363  /lava-12329579/1/../bin/lava-test-case

    2023-12-20T19:09:50.677114  <8>[   62.203813] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/65833c0c8a42f1e257e1363e
        failing since 281 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-20T19:09:48.607885  <8>[   60.133939] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-12-20T19:09:49.629470  /lava-12329579/1/../bin/lava-test-case

    2023-12-20T19:09:49.640401  <8>[   61.167166] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65833b74286e47fbdce13518

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-60-gbd6aa237ba9cb/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-60-gbd6aa237ba9cb/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65833b74286e47fbdce1351d
        failing since 28 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-20T19:07:28.256771  <8>[   16.946240] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 449191_1.5.2.4.1>
    2023-12-20T19:07:28.361727  / # #
    2023-12-20T19:07:28.463463  export SHELL=3D/bin/sh
    2023-12-20T19:07:28.464161  #
    2023-12-20T19:07:28.565159  / # export SHELL=3D/bin/sh. /lava-449191/en=
vironment
    2023-12-20T19:07:28.565759  =

    2023-12-20T19:07:28.666838  / # . /lava-449191/environment/lava-449191/=
bin/lava-test-runner /lava-449191/1
    2023-12-20T19:07:28.667775  =

    2023-12-20T19:07:28.671935  / # /lava-449191/bin/lava-test-runner /lava=
-449191/1
    2023-12-20T19:07:28.738955  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65833b81ae971be2c4e1349d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-60-gbd6aa237ba9cb/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-60-gbd6aa237ba9cb/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65833b81ae971be2c4e134a2
        failing since 28 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-20T19:15:12.559677  / # #

    2023-12-20T19:15:12.661697  export SHELL=3D/bin/sh

    2023-12-20T19:15:12.661956  #

    2023-12-20T19:15:12.762737  / # export SHELL=3D/bin/sh. /lava-12329455/=
environment

    2023-12-20T19:15:12.763438  =


    2023-12-20T19:15:12.864972  / # . /lava-12329455/environment/lava-12329=
455/bin/lava-test-runner /lava-12329455/1

    2023-12-20T19:15:12.866014  =


    2023-12-20T19:15:12.873551  / # /lava-12329455/bin/lava-test-runner /la=
va-12329455/1

    2023-12-20T19:15:12.938310  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-20T19:15:12.938805  + cd /lava-1232945<8>[   18.187735] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12329455_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

