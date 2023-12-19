Return-Path: <stable+bounces-7913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B698187A7
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 13:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B12A1F238CD
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 12:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883C018036;
	Tue, 19 Dec 2023 12:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="xc/YtkFO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F4918E0C
	for <stable@vger.kernel.org>; Tue, 19 Dec 2023 12:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6da5278c6fbso3381998a34.3
        for <stable@vger.kernel.org>; Tue, 19 Dec 2023 04:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702989638; x=1703594438; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WZ8lVqoIUYOer7Pgf/5wVX6pDvK/F/dVFwK3X1TfkfY=;
        b=xc/YtkFOn1ab1D3ccCRrZn1c8F/Kj1MbSo5OlxIp8LqSCPBy3JCPhXak9+Lstur9e4
         pk3AW68iUq1ayaLer1PIWY6Mz8pD+hfRAtvt3WklgjtJG5XGMC1oT5LWbeYWa6rQ0iL+
         zqWx50yFk29k52IlWj7Mv/pAxVj+Pq4I10TSWNKhPKxVdYhjkrRnCJ3AExyIa419PI7U
         9XDTtaFe48NuPg/X6vNUxSeQjJY+XD89IfV55JT8mOlTLEtky1ezyD1pe94NbCwCmkKn
         aApMUyMXf/rr+K1k83sJ8ogtKa6zLroM3fRmYhee448RKsFsIU21Jn/O3IFAz6HG9Zy6
         RqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702989638; x=1703594438;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WZ8lVqoIUYOer7Pgf/5wVX6pDvK/F/dVFwK3X1TfkfY=;
        b=ttlDEP5/zaTl4GBuRYeP+/l+YQbAGQh5IAXJxl8vxCCGfM9LSMeQPp1FTkQEKOIQPy
         stMJdCciHoQbXwb3rsMCt3fXXMo11Mw+ZeR5U61a3G5ex3igN9xydbG12qsJNduOHyYo
         GwkEwZsrwKa8AeCAcSR0WJJVeZPGzHPRbmu2F7qyjxBLhLF0QlQMzb0l1PLHqPQCZdcO
         KeHEDwPAcgxzS5sdCrBxTHB1eVM/x/GFgSOH48fAHHPndXkMoB2+y9/ivQs5ESM5i+Vt
         yunoooLF4xjHThsmB6eWnRjQobmxk5sNdDESWAj6Z7fVomzUOQh9dexNGIIJip58vejF
         XcPw==
X-Gm-Message-State: AOJu0YwWsYBgpNYjnBKpGqRdY1miaLvV6pZzxcW4ebuIrNxLXssoxNzl
	zA1JB8QKWVAiBP+MgM2Fd/P9sVmxhKktNuU8YSI=
X-Google-Smtp-Source: AGHT+IFVsxvFy1nrd5YawhCdm5iJ0gKGFnQWqOPa0+esw0g4/PTbtTknxkmIMrBrcnH4n+IDegcVVQ==
X-Received: by 2002:a05:6358:419f:b0:172:ac48:eb04 with SMTP id w31-20020a056358419f00b00172ac48eb04mr5589928rwc.64.1702989638025;
        Tue, 19 Dec 2023 04:40:38 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s2-20020a056a00178200b006ce9d2471c0sm3234837pfg.60.2023.12.19.04.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 04:40:37 -0800 (PST)
Message-ID: <65818f45.050a0220.673c7.8317@mx.google.com>
Date: Tue, 19 Dec 2023 04:40:37 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.204-60-g55a7662a657f
Subject: stable-rc/queue/5.10 baseline: 104 runs,
 6 regressions (v5.10.204-60-g55a7662a657f)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 104 runs, 6 regressions (v5.10.204-60-g55a76=
62a657f)

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
nel/v5.10.204-60-g55a7662a657f/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.204-60-g55a7662a657f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      55a7662a657ff853af91cde3dd39e2200d958ac9 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
beaglebone-black   | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig=
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65815ad5251a53aa64e13480

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-60-g55a7662a657f/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beagl=
ebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-60-g55a7662a657f/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beagl=
ebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65815ad5251a53aa64e134b6
        failing since 308 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-19T08:56:35.341182  <8>[   18.699307] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 372893_1.5.2.4.1>
    2023-12-19T08:56:35.452826  / # #
    2023-12-19T08:56:35.555838  export SHELL=3D/bin/sh
    2023-12-19T08:56:35.556730  #
    2023-12-19T08:56:35.658843  / # export SHELL=3D/bin/sh. /lava-372893/en=
vironment
    2023-12-19T08:56:35.659735  =

    2023-12-19T08:56:35.761910  / # . /lava-372893/environment/lava-372893/=
bin/lava-test-runner /lava-372893/1
    2023-12-19T08:56:35.763257  =

    2023-12-19T08:56:35.767348  / # /lava-372893/bin/lava-test-runner /lava=
-372893/1
    2023-12-19T08:56:35.864735  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65815aba626e75a84de1347e

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-60-g55a7662a657f/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-60-g55a7662a657f/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65815aba626e75a84de13483
        failing since 26 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-19T09:03:52.342872  / # #

    2023-12-19T09:03:52.445054  export SHELL=3D/bin/sh

    2023-12-19T09:03:52.445772  #

    2023-12-19T09:03:52.547177  / # export SHELL=3D/bin/sh. /lava-12311888/=
environment

    2023-12-19T09:03:52.547892  =


    2023-12-19T09:03:52.649385  / # . /lava-12311888/environment/lava-12311=
888/bin/lava-test-runner /lava-12311888/1

    2023-12-19T09:03:52.650481  =


    2023-12-19T09:03:52.667167  / # /lava-12311888/bin/lava-test-runner /la=
va-12311888/1

    2023-12-19T09:03:52.715918  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-19T09:03:52.716447  + cd /lav<8>[   16.495124] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12311888_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
rk3399-gru-kevin   | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chr=
omebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65815bf8e5ec8c3522e13487

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-60-g55a7662a657f/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-60-g55a7662a657f/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/65815bf8e5ec8c3522e1348d
        failing since 280 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-19T09:01:28.689834  /lava-12312008/1/../bin/lava-test-case

    2023-12-19T09:01:28.700993  <8>[   62.105120] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/65815bf8e5ec8c3522e1348e
        failing since 280 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-19T09:01:27.653879  /lava-12312008/1/../bin/lava-test-case

    2023-12-19T09:01:27.664471  <8>[   61.068527] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65815ad08ec4296377e134df

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-60-g55a7662a657f/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine=
-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-60-g55a7662a657f/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine=
-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65815ad08ec4296377e134e4
        failing since 26 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-19T08:56:23.404112  <8>[   16.954925] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 448910_1.5.2.4.1>
    2023-12-19T08:56:23.509170  / # #
    2023-12-19T08:56:23.610750  export SHELL=3D/bin/sh
    2023-12-19T08:56:23.611358  #
    2023-12-19T08:56:23.712340  / # export SHELL=3D/bin/sh. /lava-448910/en=
vironment
    2023-12-19T08:56:23.712919  =

    2023-12-19T08:56:23.813918  / # . /lava-448910/environment/lava-448910/=
bin/lava-test-runner /lava-448910/1
    2023-12-19T08:56:23.814811  =

    2023-12-19T08:56:23.819433  / # /lava-448910/bin/lava-test-runner /lava=
-448910/1
    2023-12-19T08:56:23.885452  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65815ace4c16ffdef3e134f6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-60-g55a7662a657f/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-60-g55a7662a657f/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65815ace4c16ffdef3e134fb
        failing since 26 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-19T09:04:07.804413  / # #

    2023-12-19T09:04:07.906484  export SHELL=3D/bin/sh

    2023-12-19T09:04:07.907175  #

    2023-12-19T09:04:08.008563  / # export SHELL=3D/bin/sh. /lava-12311889/=
environment

    2023-12-19T09:04:08.009261  =


    2023-12-19T09:04:08.110683  / # . /lava-12311889/environment/lava-12311=
889/bin/lava-test-runner /lava-12311889/1

    2023-12-19T09:04:08.111739  =


    2023-12-19T09:04:08.128790  / # /lava-12311889/bin/lava-test-runner /la=
va-12311889/1

    2023-12-19T09:04:08.172845  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-19T09:04:08.188027  + cd /lava-1231188<8>[   18.241804] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12311889_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

