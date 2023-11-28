Return-Path: <stable+bounces-2860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 378297FB291
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 08:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A13C1C20ABF
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 07:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F2112E46;
	Tue, 28 Nov 2023 07:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="gRI5vnPY"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6500182
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 23:21:04 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-35cc5e74849so8684915ab.1
        for <stable@vger.kernel.org>; Mon, 27 Nov 2023 23:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701156064; x=1701760864; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QZooGJGKe9FIOvyts9WW4bdRrfApu4I2o8G/0KEcQAk=;
        b=gRI5vnPYsBIdRpdzkbWPUKYFgfZvummhPFVZ+njYCCqsZI1NUIqVRY0fx/MOIIjucP
         xXNGLIOewzg1IhnlJvDg/BiaqTqGm1XRb0M8AIBWre2prI+uKBPMRDnGHoF7+ZU4QTmk
         43q1/87TqJBGjAAnyrS4xA5QzYzj5/zUReP7RiyprnIIYrPnpbbO6cKITBrLTOTO4AgO
         6+ulLwjmtK80mU1XsOx1QDr1UyYHkdNdZp2ueooHzuqE8l70wO/mads5XlPm0yYEZmEA
         NH59WL6jeRQUCOVaoUrdoVSG86nIuS6N39CS/1r/uMZnf6aYayMP07qKoQNX9wVuFPdO
         AiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701156064; x=1701760864;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZooGJGKe9FIOvyts9WW4bdRrfApu4I2o8G/0KEcQAk=;
        b=MB7CV8MmGFIIWNxtGURbDk0skrkb3+Vwu10mQWmnEaMLnVZi8O21TSfQpyXygdXwrf
         yV8UtBTlRH0mA1mLqndDmo0kijNAD9ZAnHGM72md2BgAfE/+TyBrbswN4ysqZK2zyElo
         dFfYNNQVYMtFG5wQbC2zWFi5zVztLgTTIpU8k7AwD6W2C7YIkNbbSXFunpp+Orw0rSgS
         gdWQEEM/KpWL+U03iUR7XiRwApmriAqvLZs0R4imcuf96G+uql0YqQm6jGr7h64Lc2qm
         n+rMetVrEh0pNDG5J6xPjQUpj0CKOOigSJtZvAzpCIHKAHXIbKvGGSwL2XJ7fqaxd7VT
         GouQ==
X-Gm-Message-State: AOJu0YynDNYomSM/wVC4ooe5wAgu6XzQYf7b9l7PM1/N1+kGhAQoQNlt
	SmHEQLtWZz6awrnkXHxNgF2kYerctWwiLFH1Tgs=
X-Google-Smtp-Source: AGHT+IFxZGigqM9F2Te3hHGhQ59tfQW2eh32WTOe4y/70Hqti3XxyJsm/aAXL8f9UWV7Q9PxtOgAyw==
X-Received: by 2002:a05:6e02:1788:b0:35c:789a:ccc7 with SMTP id y8-20020a056e02178800b0035c789accc7mr17448958ilu.2.1701156063726;
        Mon, 27 Nov 2023 23:21:03 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x3-20020a056a000bc300b006cbb818c7fdsm8569969pfu.179.2023.11.27.23.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:21:03 -0800 (PST)
Message-ID: <656594df.050a0220.d4c4b.4f62@mx.google.com>
Date: Mon, 27 Nov 2023 23:21:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.201-187-g58b8fec6bec58
Subject: stable-rc/queue/5.10 baseline: 140 runs,
 8 regressions (v5.10.201-187-g58b8fec6bec58)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 140 runs, 8 regressions (v5.10.201-187-g58b8=
fec6bec58)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =

r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =

rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =

sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
                  | 1          =

sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =

sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.201-187-g58b8fec6bec58/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.201-187-g58b8fec6bec58
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      58b8fec6bec58fbe43df6b8f3d5a9fd2082396c7 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65655e932ade5c89187e4a6d

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-187-g58b8fec6bec58/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-187-g58b8fec6bec58/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65655e932ade5c89187e4aa7
        failing since 287 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-11-28T03:29:07.841355  <8>[   20.842335] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 280522_1.5.2.4.1>
    2023-11-28T03:29:07.948959  / # #
    2023-11-28T03:29:08.051119  export SHELL=3D/bin/sh
    2023-11-28T03:29:08.051760  #
    2023-11-28T03:29:08.153629  / # export SHELL=3D/bin/sh. /lava-280522/en=
vironment
    2023-11-28T03:29:08.154267  =

    2023-11-28T03:29:08.256168  / # . /lava-280522/environment/lava-280522/=
bin/lava-test-runner /lava-280522/1
    2023-11-28T03:29:08.257030  =

    2023-11-28T03:29:08.260930  / # /lava-280522/bin/lava-test-runner /lava=
-280522/1
    2023-11-28T03:29:08.365080  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656560ddd19d44add77e4a79

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-187-g58b8fec6bec58/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-187-g58b8fec6bec58/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656560ddd19d44add77e4a82
        failing since 5 days (last pass: v5.10.181-18-g1622068b57a4, first =
fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-28T03:45:17.003038  / # #

    2023-11-28T03:45:17.103518  export SHELL=3D/bin/sh

    2023-11-28T03:45:17.103679  #

    2023-11-28T03:45:17.204108  / # export SHELL=3D/bin/sh. /lava-12101204/=
environment

    2023-11-28T03:45:17.204237  =


    2023-11-28T03:45:17.304660  / # . /lava-12101204/environment/lava-12101=
204/bin/lava-test-runner /lava-12101204/1

    2023-11-28T03:45:17.304854  =


    2023-11-28T03:45:17.317104  / # /lava-12101204/bin/lava-test-runner /la=
va-12101204/1

    2023-11-28T03:45:17.370395  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-28T03:45:17.370488  + cd /lav<8>[   16.462915] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12101204_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6565617c56e1fdbf4a7e4b1d

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-187-g58b8fec6bec58/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-187-g58b8fec6bec58/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6565617c56e1fdbf4a7e4b27
        failing since 259 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-11-28T03:41:56.645535  /lava-12101385/1/../bin/lava-test-case

    2023-11-28T03:41:56.656684  <8>[   35.198084] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6565617c56e1fdbf4a7e4b28
        failing since 259 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-11-28T03:41:55.610522  /lava-12101385/1/../bin/lava-test-case

    2023-11-28T03:41:55.621698  <8>[   34.162636] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6565610625f19e678c7e4ac5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-187-g58b8fec6bec58/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-ro=
ck-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-187-g58b8fec6bec58/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-ro=
ck-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6565610625f19e678c7e4ace
        failing since 5 days (last pass: v5.10.181-18-g1622068b57a4, first =
fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-28T03:39:23.717803  / # #

    2023-11-28T03:39:24.977074  export SHELL=3D/bin/sh

    2023-11-28T03:39:24.988037  #

    2023-11-28T03:39:24.988516  / # export SHELL=3D/bin/sh

    2023-11-28T03:39:26.732299  / # . /lava-12101199/environment

    2023-11-28T03:39:29.936515  /lava-12101199/bin/lava-test-runner /lava-1=
2101199/1

    2023-11-28T03:39:29.947913  . /lava-12101199/environment

    2023-11-28T03:39:29.948238  / # /lava-12101199/bin/lava-test-runner /la=
va-12101199/1

    2023-11-28T03:39:30.002964  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-28T03:39:30.003479  + cd /lava-12101199/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656560cb5cadafec797e4aa6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-187-g58b8fec6bec58/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-187-g58b8fec6bec58/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656560cb5cadafec797e4aaf
        failing since 5 days (last pass: v5.10.176-241-ga0049fd9c865, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-28T03:38:42.011416  <8>[   16.992020] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 445561_1.5.2.4.1>
    2023-11-28T03:38:42.116438  / # #
    2023-11-28T03:38:42.218066  export SHELL=3D/bin/sh
    2023-11-28T03:38:42.218646  #
    2023-11-28T03:38:42.319637  / # export SHELL=3D/bin/sh. /lava-445561/en=
vironment
    2023-11-28T03:38:42.320225  =

    2023-11-28T03:38:42.421244  / # . /lava-445561/environment/lava-445561/=
bin/lava-test-runner /lava-445561/1
    2023-11-28T03:38:42.422104  =

    2023-11-28T03:38:42.426729  / # /lava-445561/bin/lava-test-runner /lava=
-445561/1
    2023-11-28T03:38:42.493797  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656560f1a81f9fa9e97e4a7f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-187-g58b8fec6bec58/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-187-g58b8fec6bec58/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656560f1a81f9fa9e97e4a88
        failing since 5 days (last pass: v5.10.176-241-ga0049fd9c865, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-28T03:45:35.669770  / # #

    2023-11-28T03:45:35.771797  export SHELL=3D/bin/sh

    2023-11-28T03:45:35.772487  #

    2023-11-28T03:45:35.873914  / # export SHELL=3D/bin/sh. /lava-12101194/=
environment

    2023-11-28T03:45:35.874611  =


    2023-11-28T03:45:35.976003  / # . /lava-12101194/environment/lava-12101=
194/bin/lava-test-runner /lava-12101194/1

    2023-11-28T03:45:35.977067  =


    2023-11-28T03:45:35.994224  / # /lava-12101194/bin/lava-test-runner /la=
va-12101194/1

    2023-11-28T03:45:36.037668  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-28T03:45:36.051975  + cd /lava-1210119<8>[   18.265444] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12101194_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/656563fc997b8fb0647e4a9a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-187-g58b8fec6bec58/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-187-g58b8fec6bec58/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656563fc997b8fb0647e4aa3
        failing since 5 days (last pass: v5.10.165-77-g4600242c13ed, first =
fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-28T03:52:02.197258  + set +x
    2023-11-28T03:52:02.199509  <8>[    8.439866] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3850498_1.5.2.4.1>
    2023-11-28T03:52:02.303667  / # #
    2023-11-28T03:52:02.405027  export SHELL=3D/bin/sh
    2023-11-28T03:52:02.405509  #
    2023-11-28T03:52:02.506347  / # export SHELL=3D/bin/sh. /lava-3850498/e=
nvironment
    2023-11-28T03:52:02.506740  =

    2023-11-28T03:52:02.607573  / # . /lava-3850498/environment/lava-385049=
8/bin/lava-test-runner /lava-3850498/1
    2023-11-28T03:52:02.608160  =

    2023-11-28T03:52:02.614208  / # /lava-3850498/bin/lava-test-runner /lav=
a-3850498/1 =

    ... (12 line(s) more)  =

 =20

