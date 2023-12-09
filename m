Return-Path: <stable+bounces-5081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C70580B1E0
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 04:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E2741C20C37
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 03:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF2410F6;
	Sat,  9 Dec 2023 03:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="JvG7M78S"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5F2ED
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 19:16:51 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7b6fa79b547so104898739f.1
        for <stable@vger.kernel.org>; Fri, 08 Dec 2023 19:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702091810; x=1702696610; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DxjFzip0NXD41qs7GcvnAXvgjQUQwBnADoUl60tOztQ=;
        b=JvG7M78SPd6pDurxqjR7BgZIbIQe2/SGtgrBcmkXaAeqj9G/Lv8Zg58fIMMByA1b6t
         nSE3sAlKwa8F6SEI7LlF7uiFcRncQ9ZGk7OZ8do8OIwFp+KWiP0krrB3l6sM8xE5sBAO
         Ay8IEw8ZHWdJ01z9s8OwXTw09G+UkHb5SXvleUBB6dmGDfO2h/XfAvrql2zAHvXrKQVu
         XvqkGnVO+A4cHJ194W6Q0+NJH2XGuex0dygDPf9cTN+3LicNhya85hdWmb0P8bqD98X0
         qUtQUDsY169XMoSpYXY0+k8rzsM8I/lS23r5lSsYLXyVjZh6gMdFtGremFqK+w0yTvyO
         9vLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702091810; x=1702696610;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DxjFzip0NXD41qs7GcvnAXvgjQUQwBnADoUl60tOztQ=;
        b=KWsRN1xfWiQxcD5pOej8LZ/H7Fj7sFTGubOvBIDHttJ4kGkP/Y0d3LjGkKC2bH/Y41
         7EGMoQcP5OT3+VjMUIl+lXPEYZnQetn6JD0SjDXjiUXdyseye/9dr44pZaQb8Bgcux/1
         zrHZlBXBdUs4sNVG7xjFbA5KE4anIuhZV9+DXv/Ky/eoesPWpYCXMGfjvW01F1GqJGSE
         4ujBwjNKg2cUaS8u+/2uvE4zTCl2MXTAOaeO62zwh7pPvlsogIGvuuYPFQ7qNCRs8Nwf
         ms1k+QiGsR+sPOPhx+vO0Vxm+Y3S37vkyoSPDYovkwSFGfE2LZweI1SrX8doWvwyRCU6
         cXxQ==
X-Gm-Message-State: AOJu0YzgxCTDDTHMAbZkPYKLm7pSRVuRhazjMDvvaPu9K6iTV+1QcQio
	FiOu46oyXRySPmKdsngD1wLhfdyAdt5xkwDf/4c8+g==
X-Google-Smtp-Source: AGHT+IHz4i7RPct9rpibhV9fRW4v7HRTUsIwNrS/mqrzAbjL/y39Ev7HrP1oP+EfhzquEbPIZDw72Q==
X-Received: by 2002:a05:6e02:1d84:b0:35d:5995:7993 with SMTP id h4-20020a056e021d8400b0035d59957993mr1260628ila.45.1702091809975;
        Fri, 08 Dec 2023 19:16:49 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902e74c00b001d0b32ec81esm2421231plf.79.2023.12.08.19.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 19:16:49 -0800 (PST)
Message-ID: <6573dc21.170a0220.b5304.8f6a@mx.google.com>
Date: Fri, 08 Dec 2023 19:16:49 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.203-7-g904bbd534ce44
Subject: stable-rc/queue/5.10 baseline: 154 runs,
 10 regressions (v5.10.203-7-g904bbd534ce44)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 154 runs, 10 regressions (v5.10.203-7-g904bb=
d534ce44)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =

juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =

meson-gxbb-p200              | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =

panda                        | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =

r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =

sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
                  | 1          =

sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =

sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.203-7-g904bbd534ce44/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.203-7-g904bbd534ce44
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      904bbd534ce44314b4a8c56baeac6090a8c6a598 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/6573abbfe6551e516fe13475

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-7-g904bbd534ce44/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beagl=
ebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-7-g904bbd534ce44/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beagl=
ebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573abbfe6551e516fe134a5
        failing since 298 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-08T23:50:01.735037  <8>[   19.111850] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 327883_1.5.2.4.1>
    2023-12-08T23:50:01.841570  / # #
    2023-12-08T23:50:01.943225  export SHELL=3D/bin/sh
    2023-12-08T23:50:01.943671  #
    2023-12-08T23:50:02.044887  / # export SHELL=3D/bin/sh. /lava-327883/en=
vironment
    2023-12-08T23:50:02.045423  =

    2023-12-08T23:50:02.146801  / # . /lava-327883/environment/lava-327883/=
bin/lava-test-runner /lava-327883/1
    2023-12-08T23:50:02.147519  =

    2023-12-08T23:50:02.151969  / # /lava-327883/bin/lava-test-runner /lava=
-327883/1
    2023-12-08T23:50:02.258171  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6573a96c18da2c315ce134c8

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-7-g904bbd534ce44/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-7-g904bbd534ce44/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573a96c18da2c315ce13508
        new failure (last pass: v5.10.203-7-gce575ec88a51a)

    2023-12-08T23:39:57.973616  / # #
    2023-12-08T23:39:58.076591  export SHELL=3D/bin/sh
    2023-12-08T23:39:58.077350  #
    2023-12-08T23:39:58.179305  / # export SHELL=3D/bin/sh. /lava-327768/en=
vironment
    2023-12-08T23:39:58.180072  =

    2023-12-08T23:39:58.282064  / # . /lava-327768/environment/lava-327768/=
bin/lava-test-runner /lava-327768/1
    2023-12-08T23:39:58.283380  =

    2023-12-08T23:39:58.296482  / # /lava-327768/bin/lava-test-runner /lava=
-327768/1
    2023-12-08T23:39:58.356367  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-08T23:39:58.356872  + cd /lava-327768/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxbb-p200              | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6573a9176837e8de9fe13492

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-7-g904bbd534ce44/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p=
200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-7-g904bbd534ce44/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p=
200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6573a9176837e8de9fe13=
493
        new failure (last pass: v5.10.203-7-gce575ec88a51a) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
panda                        | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6573a879d7adfcc058e134b1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-7-g904bbd534ce44/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-panda=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-7-g904bbd534ce44/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-panda=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573a879d7adfcc058e134ba
        failing since 2 days (last pass: v5.10.148-91-g23f89880f93d, first =
fail: v5.10.202-131-g761b9c32d3c8b)

    2023-12-08T23:36:05.873609  <8>[   24.490814] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3868185_1.5.2.4.1>
    2023-12-08T23:36:05.978710  =

    2023-12-08T23:36:06.079777  / # #export SHELL=3D/bin/sh
    2023-12-08T23:36:06.080220  =

    2023-12-08T23:36:06.181005  / # export SHELL=3D/bin/sh. /lava-3868185/e=
nvironment
    2023-12-08T23:36:06.181403  =

    2023-12-08T23:36:06.282230  / # . /lava-3868185/environment/lava-386818=
5/bin/lava-test-runner /lava-3868185/1
    2023-12-08T23:36:06.282931  =

    2023-12-08T23:36:06.288092  / # /lava-3868185/bin/lava-test-runner /lav=
a-3868185/1
    2023-12-08T23:36:06.346107  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6573a826600d0b91f2e134bb

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-7-g904bbd534ce44/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-7-g904bbd534ce44/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573a826600d0b91f2e134c4
        failing since 16 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-08T23:42:29.591304  / # #

    2023-12-08T23:42:29.693028  export SHELL=3D/bin/sh

    2023-12-08T23:42:29.693738  #

    2023-12-08T23:42:29.794992  / # export SHELL=3D/bin/sh. /lava-12222934/=
environment

    2023-12-08T23:42:29.795752  =


    2023-12-08T23:42:29.897200  / # . /lava-12222934/environment/lava-12222=
934/bin/lava-test-runner /lava-12222934/1

    2023-12-08T23:42:29.898200  =


    2023-12-08T23:42:29.940765  / # /lava-12222934/bin/lava-test-runner /la=
va-12222934/1

    2023-12-08T23:42:29.963549  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-08T23:42:29.963965  + cd /lav<8>[   16.388134] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12222934_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6573a875f7b17655b1e134e7

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-7-g904bbd534ce44/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-7-g904bbd534ce44/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6573a875f7b17655b1e134f1
        failing since 269 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-08T23:38:44.325328  <8>[   34.451278] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-12-08T23:38:45.350435  /lava-12222966/1/../bin/lava-test-case

    2023-12-08T23:38:45.361209  <8>[   35.488703] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6573a875f7b17655b1e134f2
        failing since 269 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-08T23:38:44.312892  /lava-12222966/1/../bin/lava-test-case
   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6573a813600d0b91f2e13484

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-7-g904bbd534ce44/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine=
-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-7-g904bbd534ce44/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine=
-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573a813600d0b91f2e1348d
        failing since 16 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-08T23:34:33.150519  <8>[   17.009333] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447158_1.5.2.4.1>
    2023-12-08T23:34:33.255503  / # #
    2023-12-08T23:34:33.357178  export SHELL=3D/bin/sh
    2023-12-08T23:34:33.358060  #
    2023-12-08T23:34:33.459213  / # export SHELL=3D/bin/sh. /lava-447158/en=
vironment
    2023-12-08T23:34:33.459948  =

    2023-12-08T23:34:33.560994  / # . /lava-447158/environment/lava-447158/=
bin/lava-test-runner /lava-447158/1
    2023-12-08T23:34:33.562013  =

    2023-12-08T23:34:33.565856  / # /lava-447158/bin/lava-test-runner /lava=
-447158/1
    2023-12-08T23:34:33.632894  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6573a839c2de847257e13479

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-7-g904bbd534ce44/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-7-g904bbd534ce44/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573a839c2de847257e13482
        failing since 16 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-08T23:42:43.093264  / # #

    2023-12-08T23:42:43.195072  export SHELL=3D/bin/sh

    2023-12-08T23:42:43.195807  #

    2023-12-08T23:42:43.297134  / # export SHELL=3D/bin/sh. /lava-12222938/=
environment

    2023-12-08T23:42:43.297776  =


    2023-12-08T23:42:43.398940  / # . /lava-12222938/environment/lava-12222=
938/bin/lava-test-runner /lava-12222938/1

    2023-12-08T23:42:43.399966  =


    2023-12-08T23:42:43.401658  / # /lava-12222938/bin/lava-test-runner /la=
va-12222938/1

    2023-12-08T23:42:43.448654  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-08T23:42:43.475724  + cd /lava-1222293<8>[   18.285027] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12222938_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6573a83fa50fa013a7e134b0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-7-g904bbd534ce44/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i=
-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-7-g904bbd534ce44/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i=
-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573a83fa50fa013a7e134b9
        failing since 16 days (last pass: v5.10.165-77-g4600242c13ed, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-08T23:35:03.885627  + set +x
    2023-12-08T23:35:03.888885  <8>[    8.510522] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3868181_1.5.2.4.1>
    2023-12-08T23:35:03.992919  / # #
    2023-12-08T23:35:04.093980  export SHELL=3D/bin/sh
    2023-12-08T23:35:04.094322  #
    2023-12-08T23:35:04.195098  / # export SHELL=3D/bin/sh. /lava-3868181/e=
nvironment
    2023-12-08T23:35:04.195542  =

    2023-12-08T23:35:04.296419  / # . /lava-3868181/environment/lava-386818=
1/bin/lava-test-runner /lava-3868181/1
    2023-12-08T23:35:04.297116  =

    2023-12-08T23:35:04.303894  / # /lava-3868181/bin/lava-test-runner /lav=
a-3868181/1 =

    ... (12 line(s) more)  =

 =20

