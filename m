Return-Path: <stable+bounces-5191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5774580B968
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 07:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1B12B20A37
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 06:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7DC23BF;
	Sun, 10 Dec 2023 06:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="1NY8/Oe4"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6392B8
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 22:49:47 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6d9e756cf32so1733300a34.2
        for <stable@vger.kernel.org>; Sat, 09 Dec 2023 22:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702190986; x=1702795786; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ps4c4d2UTB73SGVexfdmCtV91/UzENw2J1OimuWb5zw=;
        b=1NY8/Oe4vNtuf93KgVmCASubGGsUCBE8WJZWchT3A4o969BjAHVgDeUtTju9JZRvGa
         Uqi0XD0HwycWmOuKHviy+vGWWG3SjdPGO0uUbBWYTbUavqXeofIsnAABEvVsBTKX9srB
         h2Sobc4GvoKgzX6vj45YytyeN4nX7CcMfHSUhpLPA6doYfxidKgRMFioRVux0lxFhyH+
         ah0B/ZszpoQ2/k4uCRLRo7yKU96pIR9VgXVzcdd9bOwJ/swBIBXFjBhCITmBtJpr800H
         WlnnMmVpKYEFVaQ30ROAWun0kMZROQq6saGasZGDttNzz8ZvlBlLEm+lx0sq5BbLs1If
         fTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702190986; x=1702795786;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ps4c4d2UTB73SGVexfdmCtV91/UzENw2J1OimuWb5zw=;
        b=KLeazRcSyppxqKsskO5EGRuC6BlvfGCLNJrw+F9DU/QmILFICCynRFzpyU92/+yNIG
         FeVHaoyX2Isf9Lgs84WtH+ydDAk9Bf59tJt0VneQsmw8lyBGrNgdb+C0R1X3llhT0xfi
         L91hqbnEyk7xQ67S9mBmub1aWBtAP/K95fMN4ReXUcoBkv4CoQeY6j8Co+bi1efhawCn
         Q+RihdlWczFNqNfFTj4g2qCmbepMn1oGVRoscHXTTu7x9dzUd7BLITt5rOvAuQo3dql5
         e6ZjwoHWxnxacT1lox1hSG1pBS6SRSRJXdZyJyPA5VxDVWCc7tGt38zH2MzvHgsQBwgn
         0R7g==
X-Gm-Message-State: AOJu0YzscyLRGPY7jvBv1o7I8djgD4/tCfD5youM2NdC7E/nItU/T+m4
	qA5XGFZmUs6lPCL7dHzPqylZRKONFCAYeZoUcbNKYg==
X-Google-Smtp-Source: AGHT+IEl2Um4WadpGILkR1JukKteAOYLOmMS5H/npNg51AO2MkEV8L0cGEmc7T1zFdtebXKGjViawA==
X-Received: by 2002:a05:6808:f12:b0:3b9:ffae:abfd with SMTP id m18-20020a0568080f1200b003b9ffaeabfdmr1558141oiw.61.1702190986624;
        Sat, 09 Dec 2023 22:49:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j12-20020a056a00234c00b006ce461447f5sm4133124pfj.67.2023.12.09.22.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 22:49:46 -0800 (PST)
Message-ID: <65755f8a.050a0220.469e5.c568@mx.google.com>
Date: Sat, 09 Dec 2023 22:49:46 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.142-100-g260ab6cf1c061
Subject: stable-rc/queue/5.15 baseline: 95 runs,
 6 regressions (v5.15.142-100-g260ab6cf1c061)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 95 runs, 6 regressions (v5.15.142-100-g260ab=
6cf1c061)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
meson-gxbb-p200    | arm64 | lab-baylibre  | gcc-10   | defconfig          =
| 1          =

odroid-xu3         | arm   | lab-collabora | gcc-10   | multi_v7_defconfig =
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
nel/v5.15.142-100-g260ab6cf1c061/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.142-100-g260ab6cf1c061
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      260ab6cf1c061b6e3840d7823672857bc777aa04 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
meson-gxbb-p200    | arm64 | lab-baylibre  | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/65752fa6636187cc6ae13495

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-100-g260ab6cf1c061/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb=
-p200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-100-g260ab6cf1c061/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb=
-p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65752fa6636187cc6ae13=
496
        failing since 0 day (last pass: v5.15.142-48-gdbed703bb51c2, first =
fail: v5.15.142-77-ga64dd884b1d57) =

 =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
odroid-xu3         | arm   | lab-collabora | gcc-10   | multi_v7_defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/65752dc56acccc534ae134b9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-100-g260ab6cf1c061/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-od=
roid-xu3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-100-g260ab6cf1c061/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-od=
roid-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65752dc56acccc534ae13=
4ba
        new failure (last pass: v5.15.142-77-ga64dd884b1d57) =

 =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
panda              | arm   | lab-baylibre  | gcc-10   | multi_v7_defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/65752d8ba9bc06e658e13495

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-100-g260ab6cf1c061/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pan=
da.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-100-g260ab6cf1c061/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pan=
da.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65752d8ba9bc06e658e1349a
        failing since 3 days (last pass: v5.15.74-135-g19e8e8e20e2b, first =
fail: v5.15.141-64-g41591b7f348c5)

    2023-12-10T03:15:58.684159  <8>[   11.595733] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3872200_1.5.2.4.1>
    2023-12-10T03:15:58.789293  / # #
    2023-12-10T03:15:58.890768  export SHELL=3D/bin/sh
    2023-12-10T03:15:58.891452  #
    2023-12-10T03:15:58.992557  / # export SHELL=3D/bin/sh. /lava-3872200/e=
nvironment
    2023-12-10T03:15:58.993117  =

    2023-12-10T03:15:59.094008  / # . /lava-3872200/environment/lava-387220=
0/bin/lava-test-runner /lava-3872200/1
    2023-12-10T03:15:59.094761  =

    2023-12-10T03:15:59.099937  / # /lava-3872200/bin/lava-test-runner /lav=
a-3872200/1
    2023-12-10T03:15:59.159964  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/65752ea29f7b85bc4fe134ad

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-100-g260ab6cf1c061/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-100-g260ab6cf1c061/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65752ea29f7b85bc4fe134b2
        failing since 17 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-10T03:28:29.951396  / # #

    2023-12-10T03:28:30.051850  export SHELL=3D/bin/sh

    2023-12-10T03:28:30.051965  #

    2023-12-10T03:28:30.152402  / # export SHELL=3D/bin/sh. /lava-12233167/=
environment

    2023-12-10T03:28:30.152562  =


    2023-12-10T03:28:30.253015  / # . /lava-12233167/environment/lava-12233=
167/bin/lava-test-runner /lava-12233167/1

    2023-12-10T03:28:30.253304  =


    2023-12-10T03:28:30.264988  / # /lava-12233167/bin/lava-test-runner /la=
va-12233167/1

    2023-12-10T03:28:30.319036  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-10T03:28:30.319112  + cd /lav<8>[   16.003078] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12233167_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/65752e85cd407662bde13476

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-100-g260ab6cf1c061/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-100-g260ab6cf1c061/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65752e85cd407662bde1347b
        failing since 17 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-10T03:20:28.295529  <8>[   16.075191] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447363_1.5.2.4.1>
    2023-12-10T03:20:28.400465  / # #
    2023-12-10T03:20:28.502082  export SHELL=3D/bin/sh
    2023-12-10T03:20:28.502767  #
    2023-12-10T03:20:28.603747  / # export SHELL=3D/bin/sh. /lava-447363/en=
vironment
    2023-12-10T03:20:28.604417  =

    2023-12-10T03:20:28.705429  / # . /lava-447363/environment/lava-447363/=
bin/lava-test-runner /lava-447363/1
    2023-12-10T03:20:28.706306  =

    2023-12-10T03:20:28.710864  / # /lava-447363/bin/lava-test-runner /lava=
-447363/1
    2023-12-10T03:20:28.742891  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/65752eb5b212cc1758e1348e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-100-g260ab6cf1c061/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-100-g260ab6cf1c061/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65752eb5b212cc1758e13493
        failing since 17 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-10T03:28:44.631230  / # #

    2023-12-10T03:28:44.733393  export SHELL=3D/bin/sh

    2023-12-10T03:28:44.734088  #

    2023-12-10T03:28:44.835472  / # export SHELL=3D/bin/sh. /lava-12233163/=
environment

    2023-12-10T03:28:44.836180  =


    2023-12-10T03:28:44.937650  / # . /lava-12233163/environment/lava-12233=
163/bin/lava-test-runner /lava-12233163/1

    2023-12-10T03:28:44.938736  =


    2023-12-10T03:28:44.955636  / # /lava-12233163/bin/lava-test-runner /la=
va-12233163/1

    2023-12-10T03:28:45.013506  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-10T03:28:45.014010  + cd /lava-1223316<8>[   16.827713] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12233163_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

