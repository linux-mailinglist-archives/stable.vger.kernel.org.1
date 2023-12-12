Return-Path: <stable+bounces-6504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1594180F782
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 21:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 969191F212B1
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 20:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FA052776;
	Tue, 12 Dec 2023 20:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="B4dLvnqx"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507BEB7
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 12:08:10 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-35f7093c180so511455ab.1
        for <stable@vger.kernel.org>; Tue, 12 Dec 2023 12:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702411689; x=1703016489; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vy0xqH0SRA1TVwkD1O0FEySaLrHnuVYzI70nhf/Kv2A=;
        b=B4dLvnqx+1eXCu69J0cxrYNpFfrGKyuzbUGmXJ6P3EkdLBXv1W6qGKkS/RnLYhf8iI
         44zGBaSEcHivU+mT/vrTazsXsh0bR4QrKrYXvhFuQQMb/alupjCuLUzXzfR+INY1lB65
         0SIUSkd2MgVF4y7huYD1P3k6xm1K7Xk+RFv5jc6BzvkWedPc4oB3V22eC2e6j0AzJ8m+
         aoB6JTxmnX+8ex47QR8h4foxkrcOqm/cIMr2HEYhztmH1bi3S1RsyrFXQQUsuTQvuAyE
         fygiOO7Bg7XuerP3D9dQw5y2UrapUUNs3w8zTREKzj04XeT1v66wjaxtLs19R+orjdVg
         ZkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702411689; x=1703016489;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vy0xqH0SRA1TVwkD1O0FEySaLrHnuVYzI70nhf/Kv2A=;
        b=IHavGsbjHxf6oVzt1iaYmvfwsMlcKd+Ei7Lvt9CFr+Gh1UUuKlmaHTxHJFeUeIJb6p
         3FH0PzIvZxL6nqKH0wzELclB+Hb0MsswBR2OOCtbEWScZyL3L+VpgEIqHv0zPopdbZYu
         Sp3Nf0uq0IqgRnQluWXTR0efRrXsR8R1u7S058v2LPUzw72Ed+cSBVswOhqr5AhOTxeo
         QccGdnq9isjettJxpC6PV4nazz1cIOLDgC/4JBlCRJ9WJavtTUzHgyv2m2yWMwoe5Xn1
         +TW+6ZU36zN3G8fMl5LbX6py92JHK3CNl67sKGSueKLtqfXeUtyund+MSdrSWp1AhziV
         BDiA==
X-Gm-Message-State: AOJu0YwtdQtJ4NVIkATI1Kmdum0cFrGGEaQQDiBy+qe4j07IfNaxvb/c
	OG33X/G6ZF0dikBhLrqA7Gftp+7Y8iMEkvGxLBt42A==
X-Google-Smtp-Source: AGHT+IGjRL+77RzSvjWEdn7i0TCetVsBffUeH323LhnfkIDxDr3U5wjgos9jaqREoDV5x2g00OR3uQ==
X-Received: by 2002:a05:6e02:1c89:b0:35d:6553:cf78 with SMTP id w9-20020a056e021c8900b0035d6553cf78mr9675089ill.24.1702411689186;
        Tue, 12 Dec 2023 12:08:09 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x20-20020a631714000000b0058988954686sm8235732pgl.90.2023.12.12.12.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 12:08:08 -0800 (PST)
Message-ID: <6578bda8.630a0220.f7589.8a74@mx.google.com>
Date: Tue, 12 Dec 2023 12:08:08 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.203-97-g43162d9d816b3
Subject: stable-rc/queue/5.10 baseline: 99 runs,
 7 regressions (v5.10.203-97-g43162d9d816b3)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 99 runs, 7 regressions (v5.10.203-97-g43162d=
9d816b3)

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
nel/v5.10.203-97-g43162d9d816b3/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.203-97-g43162d9d816b3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      43162d9d816b3442700eb0e971e9ae52e2d8b807 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
beaglebone-black   | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig=
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65788b9c2974f99f9ae1348e

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-g43162d9d816b3/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-g43162d9d816b3/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65788b9c2974f99f9ae134c7
        failing since 301 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-12T16:34:18.321878  <8>[   20.987659] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 345670_1.5.2.4.1>
    2023-12-12T16:34:18.430595  / # #
    2023-12-12T16:34:18.532890  export SHELL=3D/bin/sh
    2023-12-12T16:34:18.533461  #
    2023-12-12T16:34:18.635172  / # export SHELL=3D/bin/sh. /lava-345670/en=
vironment
    2023-12-12T16:34:18.635698  =

    2023-12-12T16:34:18.737440  / # . /lava-345670/environment/lava-345670/=
bin/lava-test-runner /lava-345670/1
    2023-12-12T16:34:18.738207  =

    2023-12-12T16:34:18.742139  / # /lava-345670/bin/lava-test-runner /lava=
-345670/1
    2023-12-12T16:34:18.851315  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
juno-uboot         | arm64 | lab-broonie   | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65788c62650fd005b9e1355c

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-g43162d9d816b3/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.t=
xt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-g43162d9d816b3/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65788c62650fd005b9e1359b
        failing since 1 day (last pass: v5.10.203-64-g1e733f0ca3a85, first =
fail: v5.10.203-68-g1957c51c03d64)

    2023-12-12T16:37:26.463769  / # #
    2023-12-12T16:37:26.566596  export SHELL=3D/bin/sh
    2023-12-12T16:37:26.567378  #
    2023-12-12T16:37:26.669354  / # export SHELL=3D/bin/sh. /lava-345693/en=
vironment
    2023-12-12T16:37:26.670126  =

    2023-12-12T16:37:26.772118  / # . /lava-345693/environment/lava-345693/=
bin/lava-test-runner /lava-345693/1
    2023-12-12T16:37:26.773364  =

    2023-12-12T16:37:26.787380  / # /lava-345693/bin/lava-test-runner /lava=
-345693/1
    2023-12-12T16:37:26.846268  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-12T16:37:26.846771  + cd /lava-345693/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65788ba52974f99f9ae134cb

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-g43162d9d816b3/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-g43162d9d816b3/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65788ba52974f99f9ae134d4
        failing since 20 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-12T16:42:03.989149  / # #

    2023-12-12T16:42:04.089660  export SHELL=3D/bin/sh

    2023-12-12T16:42:04.089782  #

    2023-12-12T16:42:04.190279  / # export SHELL=3D/bin/sh. /lava-12255297/=
environment

    2023-12-12T16:42:04.190425  =


    2023-12-12T16:42:04.290911  / # . /lava-12255297/environment/lava-12255=
297/bin/lava-test-runner /lava-12255297/1

    2023-12-12T16:42:04.291101  =


    2023-12-12T16:42:04.302898  / # /lava-12255297/bin/lava-test-runner /la=
va-12255297/1

    2023-12-12T16:42:04.356431  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-12T16:42:04.356508  + cd /lav<8>[   16.414000] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12255297_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
rk3399-gru-kevin   | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chr=
omebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65788cd9cfc378f614e134d0

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-g43162d9d816b3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-g43162d9d816b3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/65788cd9cfc378f614e134da
        failing since 273 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-12T16:42:21.240616  /lava-12255334/1/../bin/lava-test-case

    2023-12-12T16:42:21.251432  <8>[   35.008343] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/65788cd9cfc378f614e134db
        failing since 273 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-12T16:42:19.181545  <8>[   32.936878] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-12-12T16:42:20.205093  /lava-12255334/1/../bin/lava-test-case

    2023-12-12T16:42:20.215668  <8>[   33.973094] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65788b892974f99f9ae1347a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-g43162d9d816b3/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-g43162d9d816b3/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65788b892974f99f9ae13483
        failing since 20 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-12T16:34:07.930535  <8>[   16.958453] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447771_1.5.2.4.1>
    2023-12-12T16:34:08.035515  / # #
    2023-12-12T16:34:08.137205  export SHELL=3D/bin/sh
    2023-12-12T16:34:08.137821  #
    2023-12-12T16:34:08.238801  / # export SHELL=3D/bin/sh. /lava-447771/en=
vironment
    2023-12-12T16:34:08.239419  =

    2023-12-12T16:34:08.340435  / # . /lava-447771/environment/lava-447771/=
bin/lava-test-runner /lava-447771/1
    2023-12-12T16:34:08.341323  =

    2023-12-12T16:34:08.345827  / # /lava-447771/bin/lava-test-runner /lava=
-447771/1
    2023-12-12T16:34:08.412858  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65788bba2974f99f9ae1353e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-g43162d9d816b3/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-97-g43162d9d816b3/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65788bba2974f99f9ae13547
        failing since 20 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-12T16:42:16.937743  / # #

    2023-12-12T16:42:17.039704  export SHELL=3D/bin/sh

    2023-12-12T16:42:17.039909  #

    2023-12-12T16:42:17.140410  / # export SHELL=3D/bin/sh. /lava-12255301/=
environment

    2023-12-12T16:42:17.140639  =


    2023-12-12T16:42:17.241180  / # . /lava-12255301/environment/lava-12255=
301/bin/lava-test-runner /lava-12255301/1

    2023-12-12T16:42:17.241493  =


    2023-12-12T16:42:17.288447  / # /lava-12255301/bin/lava-test-runner /la=
va-12255301/1

    2023-12-12T16:42:17.312147  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-12T16:42:17.312234  + cd /lava-1225530<8>[   18.246235] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12255301_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

