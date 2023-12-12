Return-Path: <stable+bounces-6404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE96580E432
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 07:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163EC1C21AB9
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 06:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638DC156FE;
	Tue, 12 Dec 2023 06:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="slMP4mSx"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD5EBF
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 22:20:57 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-35d72bc5cf2so22093555ab.1
        for <stable@vger.kernel.org>; Mon, 11 Dec 2023 22:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702362057; x=1702966857; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D/SquZZ/ySPoislPMnd2BK+a/DeYN8605b/sGN5kwhI=;
        b=slMP4mSxCn95532iMAIHXSdm053IW28dg9R3MH7KkC2GJwcoJCZGvf4m/fskzIau3Q
         X+Q7AHcqAL420pNxQZmmEm960sWsMnza4/ZDM91hiCMSS69XmO/4+ySKxeVcqXtXcOXV
         pFblgX/VyIeA+P3OIe062lMEKTzkUs8QPBrZ2l+hMmy4iRyjZiwJH5nS+Uyf0vJgfe/u
         IOdUt5bbkOLcWUjrvXEWcYwe6YqhgUh5JNOci4pulaDX90k+/AlxD8Pxfu/1YKuVYAyr
         Iq+auEdWi4hxeMLuW7yO3GcmL/sDLRGz+YqpXUc/LNFuV6PDQ7SYND3Z80VPGwjCtJAu
         Wtzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702362057; x=1702966857;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D/SquZZ/ySPoislPMnd2BK+a/DeYN8605b/sGN5kwhI=;
        b=D0gzIwz5DIND0iT1TyNo5UI7wN1GuTve6zmjQzuyPJ4gXW9BxprNrTvYgMJPjhLG9y
         ioVDGpVGwv00vWDYk/i0ElmVi+LKe90phTi0BrlFbMO5JXGx7a9XGZFFPy4f0/z4q8nI
         9Z9L53uAJhpMg0dmVXvX3VHkhIwZMWcb5cV8inQ9EDjej/tkoOfIiQp3K0f1lRtMj4ch
         2mPu27m2z7kb4tBqFbjNIFdak6tyRfIkQ8LgW3PHz3bCmd3iJZ5u4CKy9sC6QxWyZPEW
         Ae/sTZw7H+T0NlIEvpLoTgd15aQhovcPcHWLMqXTqeDa9pxOWMRmN84KQSaH70aQBtDQ
         HvyA==
X-Gm-Message-State: AOJu0YyKpqHKvJL/cQVxKmgwZ7dyw2cDYRur20Lr575usADnWZTsteMk
	BhprTNaCyv/lKcdNgAZntJSb28KhJVz9IBOGTFlolw==
X-Google-Smtp-Source: AGHT+IGjm29PNZuuqcJYcJCT3hMXzZtsqPCA7BpFo22ApKPhlbzGBAV/5zZ6HGttoXJbYkaF8IFsRQ==
X-Received: by 2002:a05:6e02:144d:b0:35d:5f75:3651 with SMTP id p13-20020a056e02144d00b0035d5f753651mr9766293ilo.51.1702362056781;
        Mon, 11 Dec 2023 22:20:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c10-20020a170903234a00b001d043588122sm7726334plh.142.2023.12.11.22.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 22:20:56 -0800 (PST)
Message-ID: <6577fbc8.170a0220.eae17.6b90@mx.google.com>
Date: Mon, 11 Dec 2023 22:20:56 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.203-97-gf29fb63a5a8b3
Subject: stable-rc/queue/5.10 baseline: 101 runs,
 7 regressions (v5.10.203-97-gf29fb63a5a8b3)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 101 runs, 7 regressions (v5.10.203-97-gf29fb=
63a5a8b3)

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
nel/v5.10.203-97-gf29fb63a5a8b3/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.203-97-gf29fb63a5a8b3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      f29fb63a5a8b3b8a5e2f77a6ad6b2f6c60f78b5b =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
beaglebone-black   | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig=
        | 1          =


  Details:     https://kernelci.org/test/plan/id/6577c839ad2f681b3de1347a

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-gf29fb63a5a8b3/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-gf29fb63a5a8b3/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6577c839ad2f681b3de134b4
        failing since 301 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-12T02:40:36.592571  <8>[   19.746384] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 342045_1.5.2.4.1>
    2023-12-12T02:40:36.699437  / # #
    2023-12-12T02:40:36.801037  export SHELL=3D/bin/sh
    2023-12-12T02:40:36.801416  #
    2023-12-12T02:40:36.902771  / # export SHELL=3D/bin/sh. /lava-342045/en=
vironment
    2023-12-12T02:40:36.903173  =

    2023-12-12T02:40:37.004364  / # . /lava-342045/environment/lava-342045/=
bin/lava-test-runner /lava-342045/1
    2023-12-12T02:40:37.005101  =

    2023-12-12T02:40:37.009740  / # /lava-342045/bin/lava-test-runner /lava=
-342045/1
    2023-12-12T02:40:37.113588  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
juno-uboot         | arm64 | lab-broonie   | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/6577cb88c85f265a1de1347a

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-gf29fb63a5a8b3/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.t=
xt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-gf29fb63a5a8b3/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6577cb88c85f265a1de134ba
        failing since 0 day (last pass: v5.10.203-64-g1e733f0ca3a85, first =
fail: v5.10.203-68-g1957c51c03d64)

    2023-12-12T02:54:33.955763  / # #
    2023-12-12T02:54:34.058514  export SHELL=3D/bin/sh
    2023-12-12T02:54:34.059295  #
    2023-12-12T02:54:34.161346  / # export SHELL=3D/bin/sh. /lava-342148/en=
vironment
    2023-12-12T02:54:34.162130  =

    2023-12-12T02:54:34.264154  / # . /lava-342148/environment/lava-342148/=
bin/lava-test-runner /lava-342148/1
    2023-12-12T02:54:34.265453  =

    2023-12-12T02:54:34.279592  / # /lava-342148/bin/lava-test-runner /lava=
-342148/1
    2023-12-12T02:54:34.338446  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-12T02:54:34.338944  + cd /lava-342148/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/6577caca695ac16e3ce134db

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-gf29fb63a5a8b3/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-gf29fb63a5a8b3/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6577caca695ac16e3ce134e4
        failing since 19 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-12T02:59:21.155093  / # #

    2023-12-12T02:59:21.255643  export SHELL=3D/bin/sh

    2023-12-12T02:59:21.255868  #

    2023-12-12T02:59:21.356318  / # export SHELL=3D/bin/sh. /lava-12248415/=
environment

    2023-12-12T02:59:21.356456  =


    2023-12-12T02:59:21.456955  / # . /lava-12248415/environment/lava-12248=
415/bin/lava-test-runner /lava-12248415/1

    2023-12-12T02:59:21.457188  =


    2023-12-12T02:59:21.468397  / # /lava-12248415/bin/lava-test-runner /la=
va-12248415/1

    2023-12-12T02:59:21.522164  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-12T02:59:21.522272  + cd /lav<8>[   16.447428] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12248415_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
rk3399-gru-kevin   | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chr=
omebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6577c9c82f47ab803ce13483

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-gf29fb63a5a8b3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-gf29fb63a5a8b3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6577c9c82f47ab803ce1348d
        failing since 273 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-12T02:47:33.054892  /lava-12248397/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6577c9c82f47ab803ce1348e
        failing since 273 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-12T02:47:32.019070  /lava-12248397/1/../bin/lava-test-case

    2023-12-12T02:47:32.029742  <8>[   32.561598] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/6577cad0695ac16e3ce134e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-gf29fb63a5a8b3/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-gf29fb63a5a8b3/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6577cad0695ac16e3ce134ef
        failing since 19 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-12T02:51:50.514283  <8>[   16.986251] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447660_1.5.2.4.1>
    2023-12-12T02:51:50.619234  / # #
    2023-12-12T02:51:50.720864  export SHELL=3D/bin/sh
    2023-12-12T02:51:50.721509  #
    2023-12-12T02:51:50.822485  / # export SHELL=3D/bin/sh. /lava-447660/en=
vironment
    2023-12-12T02:51:50.823062  =

    2023-12-12T02:51:50.924151  / # . /lava-447660/environment/lava-447660/=
bin/lava-test-runner /lava-447660/1
    2023-12-12T02:51:50.925175  =

    2023-12-12T02:51:50.929372  / # /lava-447660/bin/lava-test-runner /lava=
-447660/1
    2023-12-12T02:51:50.996363  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/6577cadf172b168d63e1348c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-gf29fb63a5a8b3/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-gf29fb63a5a8b3/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6577cadf172b168d63e13495
        failing since 19 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-12T02:59:37.442257  / # #

    2023-12-12T02:59:37.542805  export SHELL=3D/bin/sh

    2023-12-12T02:59:37.542970  #

    2023-12-12T02:59:37.643467  / # export SHELL=3D/bin/sh. /lava-12248407/=
environment

    2023-12-12T02:59:37.643596  =


    2023-12-12T02:59:37.744097  / # . /lava-12248407/environment/lava-12248=
407/bin/lava-test-runner /lava-12248407/1

    2023-12-12T02:59:37.744355  =


    2023-12-12T02:59:37.755841  / # /lava-12248407/bin/lava-test-runner /la=
va-12248407/1

    2023-12-12T02:59:37.815867  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-12T02:59:37.815945  + cd /lava-1224840<8>[   18.145766] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12248407_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

