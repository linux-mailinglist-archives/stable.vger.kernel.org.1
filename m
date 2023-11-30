Return-Path: <stable+bounces-3575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C427FFD45
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 22:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F600B210A8
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 21:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E0455C10;
	Thu, 30 Nov 2023 21:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="pdqiLrtj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F766C4
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 13:08:54 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ce3084c2d1so12980925ad.3
        for <stable@vger.kernel.org>; Thu, 30 Nov 2023 13:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701378533; x=1701983333; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bIoZDxDgd+jThRYKB2retZdRywxvXwLRBdhqpQDIH3E=;
        b=pdqiLrtjxOSlYkws7GP9Ot2ClK2aJZ+jfCl01BYliV4kZGNxmsUJj8DEmpGMv1192s
         JaveR1VmOdUGEzFqgDMOuGFzvNd2PMDa5bhqaNPCg7cSSrburUAKLIbDtm4ZiOuS3wC2
         c93hxiXlm+CvazVVDuc2aBMjaK6GwjYMwUqo4WOdvjH+i6daWCTrSiGdqlTArt7q9aGM
         9LQDnRxrLD3PfSGKUTQS2fiJD7Z4eX493AyMojvf1ViBldpuQN6iMF2Oa98Bix9bzFZS
         vmVfgEkz6wCdX2mSkL8cSSIiCklM8XaS22CmAKjlq3C3li+5RHNf8ewBHNZ8SjlsWA0x
         JL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701378533; x=1701983333;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bIoZDxDgd+jThRYKB2retZdRywxvXwLRBdhqpQDIH3E=;
        b=UH2Xg4UXE3kwrcLK96KpfdmQfb42FnBYBns0vicg098/8XJRqzy37lJWT7qDVDAJ/G
         brl4PkMn2fvT6gyO6xtC1tW1H9rhDgX5CM+kQytVXrvncl0lPPyR+WMw+Hc4gEv5uu1I
         +ncVdjuk3dPXFkxmMIoOJonqXchOdl4UtoZSrh7/34QzKG4aas8RF4gt9hIL86r3+AnX
         uuFvfnxPXdnSSxul9oxXCAsfX9oy9dGLRmsOK10d/zPXHuNBB6l8sWQ0sYVk3P+yBRVh
         gEUaa2QjjnAdLcQmgn7aK3lsm1G24tz/IBZZfBhhrGCXJ3urbFguubqH/PK9ri8tS1F9
         JCjQ==
X-Gm-Message-State: AOJu0Ywlh/I3nToY8UOrshJ70Uio7R8nDGFA4yDW0TJu130ejt2c3KYH
	kAb7yvs7ZcZmjb3dEWakpfk87YEROBYOzmRAdadtNA==
X-Google-Smtp-Source: AGHT+IFT8PenNwNG4HttG7r9YcWEb6Us0Wr2kAidnONNCmQwjQ+0OmOtLu72PZkgmEs270V8sb8K5w==
X-Received: by 2002:a17:902:c086:b0:1cd:fbff:211f with SMTP id j6-20020a170902c08600b001cdfbff211fmr21021687pld.66.1701378533189;
        Thu, 30 Nov 2023 13:08:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u6-20020a170903124600b001d01c970119sm1843238plh.275.2023.11.30.13.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 13:08:52 -0800 (PST)
Message-ID: <6568f9e4.170a0220.cf883.5d52@mx.google.com>
Date: Thu, 30 Nov 2023 13:08:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.64-82-g2d2fb90f0a9f2
Subject: stable-rc/queue/6.1 baseline: 148 runs,
 4 regressions (v6.1.64-82-g2d2fb90f0a9f2)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 148 runs, 4 regressions (v6.1.64-82-g2d2fb90f=
0a9f2)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beaglebone-black   | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig=
 | 1          =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
 | 1          =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.64-82-g2d2fb90f0a9f2/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.64-82-g2d2fb90f0a9f2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      2d2fb90f0a9f293af6d831c0afc257763b073529 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beaglebone-black   | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6568c5d13ae39babc27e4b63

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.64-82=
-g2d2fb90f0a9f2/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beagleb=
one-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.64-82=
-g2d2fb90f0a9f2/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beagleb=
one-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6568c5d13ae39babc27e4=
b64
        failing since 0 day (last pass: v6.1.64-54-g93cdac04ac8ae, first fa=
il: v6.1.64-52-gf4eda5c29509d) =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6568c62a83061c232f7e4a75

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.64-82=
-g2d2fb90f0a9f2/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.64-82=
-g2d2fb90f0a9f2/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6568c62a83061c232f7e4a7e
        failing since 8 days (last pass: v6.1.31-26-gef50524405c2, first fa=
il: v6.1.63-176-gecc0fed1ffa4)

    2023-11-30T17:34:31.960591  / # #

    2023-11-30T17:34:32.061101  export SHELL=3D/bin/sh

    2023-11-30T17:34:32.061236  #

    2023-11-30T17:34:32.161726  / # export SHELL=3D/bin/sh. /lava-12137919/=
environment

    2023-11-30T17:34:32.161835  =


    2023-11-30T17:34:32.262332  / # . /lava-12137919/environment/lava-12137=
919/bin/lava-test-runner /lava-12137919/1

    2023-11-30T17:34:32.262508  =


    2023-11-30T17:34:32.273861  / # /lava-12137919/bin/lava-test-runner /la=
va-12137919/1

    2023-11-30T17:34:32.327412  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-30T17:34:32.327492  + cd /lav<8>[   19.047626] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12137919_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6568c62961e982ed927e4a7a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.64-82=
-g2d2fb90f0a9f2/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.64-82=
-g2d2fb90f0a9f2/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6568c62961e982ed927e4a83
        failing since 8 days (last pass: v6.1.22-372-g971903477e72, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-11-30T17:28:03.618348  <8>[   18.098571] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 445930_1.5.2.4.1>
    2023-11-30T17:28:03.723518  / # #
    2023-11-30T17:28:03.825262  export SHELL=3D/bin/sh
    2023-11-30T17:28:03.825849  #
    2023-11-30T17:28:03.926884  / # export SHELL=3D/bin/sh. /lava-445930/en=
vironment
    2023-11-30T17:28:03.927519  =

    2023-11-30T17:28:04.028509  / # . /lava-445930/environment/lava-445930/=
bin/lava-test-runner /lava-445930/1
    2023-11-30T17:28:04.029379  =

    2023-11-30T17:28:04.033671  / # /lava-445930/bin/lava-test-runner /lava=
-445930/1
    2023-11-30T17:28:04.112681  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6568c641d04853ce1e7e4a6e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.64-82=
-g2d2fb90f0a9f2/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.64-82=
-g2d2fb90f0a9f2/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6568c641d04853ce1e7e4a77
        failing since 8 days (last pass: v6.1.22-372-g971903477e72, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-11-30T17:34:55.937479  / # #

    2023-11-30T17:34:56.039480  export SHELL=3D/bin/sh

    2023-11-30T17:34:56.040183  #

    2023-11-30T17:34:56.141582  / # export SHELL=3D/bin/sh. /lava-12137932/=
environment

    2023-11-30T17:34:56.142290  =


    2023-11-30T17:34:56.243707  / # . /lava-12137932/environment/lava-12137=
932/bin/lava-test-runner /lava-12137932/1

    2023-11-30T17:34:56.244708  =


    2023-11-30T17:34:56.247430  / # /lava-12137932/bin/lava-test-runner /la=
va-12137932/1

    2023-11-30T17:34:56.327251  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-30T17:34:56.327745  + cd /lava-1213793<8>[   19.191059] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12137932_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

