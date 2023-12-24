Return-Path: <stable+bounces-8432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDAB81DCD1
	for <lists+stable@lfdr.de>; Sun, 24 Dec 2023 22:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CA481F2157A
	for <lists+stable@lfdr.de>; Sun, 24 Dec 2023 21:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DE8F4F4;
	Sun, 24 Dec 2023 21:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="K8VBNxnW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE1DFBEF
	for <stable@vger.kernel.org>; Sun, 24 Dec 2023 21:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cdfbd4e8caso1361501a12.0
        for <stable@vger.kernel.org>; Sun, 24 Dec 2023 13:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703454896; x=1704059696; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EnicyHw3rpdmipoYo0G8QrgQiXlluVh70QmajP5qQPk=;
        b=K8VBNxnWd2jIkt6j1ZZoMIzNRjVgNKxLE8gzv8a6gLLgyt8lfEsFGoeAWiLzvH11vR
         ArdLwZDmpd53om1/P+2XitWq1JGA7RDWHGQ8aRB9wp+LUrtdaQqwp1doEaJ6t6a+fC/O
         JcoP+imM0Ma+Ow9r1ecGG7ja2iIuUQqip9einX2fyKxmOe/1JRus60mnwk5JbknWe7RN
         7XiqD203zh6yovlkSX2akoZZN0KYx32x+5P5jOrEPCOxV/Sod4E6lgIqa4GS6PLpTHXB
         d7p73JS9vrTbf12yY2kEOfz2g0Hm44hcWm4XwnkhNeBSaSNazH9piVhX8s8NAO2rrLUe
         uIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703454896; x=1704059696;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EnicyHw3rpdmipoYo0G8QrgQiXlluVh70QmajP5qQPk=;
        b=JGJ4H+VmNSxvUSV0ZWi4VY9JXt9kPhVn/KkOtcRw2I20AMvi9Di8m1dntODFIZAUBx
         NQZvQVyzx/tA/Vt3ru2lPewfgKOUTWkqsl7masJ10G45mR1dkxnhdb1d++KRT9/7OMp9
         Dw3xWfRWjPwpIBMqTi0h/3zR626KJqPry/bT5jYl51HIa47Ny//kcjUQezy2H/LIpQIF
         M1iW8Ms0b2FX1AyXhJL0lb0v7dQCBhjLQ9uG68bprH5bDFCHHW3kBDihkyuSMaaIS2pW
         b0OhER+IUwIoeZ120P2Ne/bRQnfjm5hEnAhQrCYUH/N0Zzkmopz1Iy5Xlh0Czn4DVCdt
         p38g==
X-Gm-Message-State: AOJu0YyYSKETNBkKN0/bArZjgf+OIEQLDo9LSOltEP7Ljt0BRAiNLSuz
	5hgXIdLBSWDI8ziB7bgkZCnx9cYN0IZYLhQx3dUZYE2A3b0=
X-Google-Smtp-Source: AGHT+IGhXYJ7jmJoPKNG6Bu/YzcpIY/PPI0XQxzCDGHlAZXkypp198NdKXG8lt2qgs4QGbM1VDhWsA==
X-Received: by 2002:a05:6a20:914f:b0:190:1246:7d23 with SMTP id x15-20020a056a20914f00b0019012467d23mr6219944pzc.55.1703454895950;
        Sun, 24 Dec 2023 13:54:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v5-20020a632f05000000b005c259cef481sm6773459pgv.59.2023.12.24.13.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 13:54:55 -0800 (PST)
Message-ID: <6588a8af.630a0220.86d4.1976@mx.google.com>
Date: Sun, 24 Dec 2023 13:54:55 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.204-87-ge476129b1875a
Subject: stable-rc/queue/5.10 baseline: 97 runs,
 7 regressions (v5.10.204-87-ge476129b1875a)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 97 runs, 7 regressions (v5.10.204-87-ge47612=
9b1875a)

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
nel/v5.10.204-87-ge476129b1875a/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.204-87-ge476129b1875a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      e476129b1875a26912e4075dadf0462246a8c135 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
beaglebone-black   | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig=
        | 1          =


  Details:     https://kernelci.org/test/plan/id/6588734e6e0d8b70e7e13475

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-87-ge476129b1875a/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-87-ge476129b1875a/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6588734e6e0d8b70e7e134ab
        failing since 313 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-24T18:06:49.918083  <8>[   19.982670] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 392984_1.5.2.4.1>
    2023-12-24T18:06:50.027870  / # #
    2023-12-24T18:06:50.130353  export SHELL=3D/bin/sh
    2023-12-24T18:06:50.131017  #
    2023-12-24T18:06:50.232873  / # export SHELL=3D/bin/sh. /lava-392984/en=
vironment
    2023-12-24T18:06:50.233531  =

    2023-12-24T18:06:50.335406  / # . /lava-392984/environment/lava-392984/=
bin/lava-test-runner /lava-392984/1
    2023-12-24T18:06:50.336392  =

    2023-12-24T18:06:50.341405  / # /lava-392984/bin/lava-test-runner /lava=
-392984/1
    2023-12-24T18:06:50.440524  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
juno-uboot         | arm64 | lab-broonie   | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65887494c1e8a32848e13478

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-87-ge476129b1875a/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.t=
xt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-87-ge476129b1875a/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65887494c1e8a32848e134b4
        new failure (last pass: v5.10.204-83-gffa73e802298)

    2023-12-24T18:12:11.147193  <8>[   14.390638] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 393011_1.5.2.4.1>
    2023-12-24T18:12:11.255482  / # #
    2023-12-24T18:12:11.358202  export SHELL=3D/bin/sh
    2023-12-24T18:12:11.358922  #
    2023-12-24T18:12:11.460804  / # export SHELL=3D/bin/sh. /lava-393011/en=
vironment
    2023-12-24T18:12:11.461525  =

    2023-12-24T18:12:11.563432  / # . /lava-393011/environment/lava-393011/=
bin/lava-test-runner /lava-393011/1
    2023-12-24T18:12:11.564706  =

    2023-12-24T18:12:11.579515  / # /lava-393011/bin/lava-test-runner /lava=
-393011/1
    2023-12-24T18:12:11.637416  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/658873ef672212b8f7e1355b

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-87-ge476129b1875a/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-87-ge476129b1875a/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658873ef672212b8f7e13560
        failing since 32 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-24T18:17:02.526423  / # #

    2023-12-24T18:17:02.626935  export SHELL=3D/bin/sh

    2023-12-24T18:17:02.627067  #

    2023-12-24T18:17:02.727554  / # export SHELL=3D/bin/sh. /lava-12375098/=
environment

    2023-12-24T18:17:02.727677  =


    2023-12-24T18:17:02.828141  / # . /lava-12375098/environment/lava-12375=
098/bin/lava-test-runner /lava-12375098/1

    2023-12-24T18:17:02.828356  =


    2023-12-24T18:17:02.839957  / # /lava-12375098/bin/lava-test-runner /la=
va-12375098/1

    2023-12-24T18:17:02.880364  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-24T18:17:02.898960  + cd /lav<8>[   16.403551] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12375098_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
rk3399-gru-kevin   | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chr=
omebook | 2          =


  Details:     https://kernelci.org/test/plan/id/658874ed77ae824e70e1348d

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-87-ge476129b1875a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-87-ge476129b1875a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/658874ed77ae824e70e13493
        failing since 285 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-24T18:16:35.944902  /lava-12375130/1/../bin/lava-test-case

    2023-12-24T18:16:35.956758  <8>[   35.010399] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/658874ed77ae824e70e13494
        failing since 285 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-24T18:16:34.908384  /lava-12375130/1/../bin/lava-test-case

    2023-12-24T18:16:34.919663  <8>[   33.973262] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/658873f4672212b8f7e13566

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-87-ge476129b1875a/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-87-ge476129b1875a/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658873f4672212b8f7e1356b
        failing since 32 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-24T18:09:46.624779  <8>[   17.006334] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 449823_1.5.2.4.1>
    2023-12-24T18:09:46.729862  / # #
    2023-12-24T18:09:46.831598  export SHELL=3D/bin/sh
    2023-12-24T18:09:46.832165  #
    2023-12-24T18:09:46.933142  / # export SHELL=3D/bin/sh. /lava-449823/en=
vironment
    2023-12-24T18:09:46.933756  =

    2023-12-24T18:09:47.034779  / # . /lava-449823/environment/lava-449823/=
bin/lava-test-runner /lava-449823/1
    2023-12-24T18:09:47.035648  =

    2023-12-24T18:09:47.040018  / # /lava-449823/bin/lava-test-runner /lava=
-449823/1
    2023-12-24T18:09:47.107159  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/658873ee672212b8f7e13550

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-87-ge476129b1875a/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-87-ge476129b1875a/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658873ee672212b8f7e13555
        failing since 32 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-24T18:17:17.734918  / # #

    2023-12-24T18:17:17.835411  export SHELL=3D/bin/sh

    2023-12-24T18:17:17.835532  #

    2023-12-24T18:17:17.935939  / # export SHELL=3D/bin/sh. /lava-12375090/=
environment

    2023-12-24T18:17:17.936069  =


    2023-12-24T18:17:18.036503  / # . /lava-12375090/environment/lava-12375=
090/bin/lava-test-runner /lava-12375090/1

    2023-12-24T18:17:18.036688  =


    2023-12-24T18:17:18.048787  / # /lava-12375090/bin/lava-test-runner /la=
va-12375090/1

    2023-12-24T18:17:18.107771  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-24T18:17:18.107850  + cd /lava-1237509<8>[   18.234979] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12375090_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

