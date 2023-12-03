Return-Path: <stable+bounces-3798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4279C8025F4
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 18:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53A361C208DB
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 17:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0723A171A4;
	Sun,  3 Dec 2023 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="BQ00so5T"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FB9B6
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 09:29:00 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6ce32821a53so203753b3a.0
        for <stable@vger.kernel.org>; Sun, 03 Dec 2023 09:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701624539; x=1702229339; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eL+4bl6sYF/k895w9TazElT/Tvs2rF1ZRtgwu4KsPVw=;
        b=BQ00so5T8X/JWRfuz5d5Lgg9SilPgSKbgIwNIb6qF7JVZiuHNo5J7sfh9bgEuP8iGM
         i5PRfplwbuczWyzGjhOOqdH+rbbN9vo8cF19IKzP1cDI1v8MizBpLDC1IcXQh7Ie1Dg+
         XrB8VUWtSKmTgUpHNAijH+S+V0sXSBKLMPMMSEN616Se+88q6NZiYX3FdQRTVS2KH4fw
         oPbxu4Oh4/rOYALy9qHuQNZK40RWiYHTW+gqHjNpq1JtUYWfjIKkSDYVC8p8xh9oVJYS
         9RPgQFHLC15nk3JmbiqdpTdkepsnJC6NHErk7t2/tsfiIDshtVgTrYjV6wMrMAq+EY1y
         F98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701624539; x=1702229339;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eL+4bl6sYF/k895w9TazElT/Tvs2rF1ZRtgwu4KsPVw=;
        b=tjAjcx8E4GecszJSRhYCYyFa05yuQnJXe+fQ2CSB0/Dk7xI4GSAsX3QZo7aXfBxuFl
         GbcG9y0OshuhJ4LvmH+cbgylep4ZNC3xvSstExcCw5m4w9ZJGzuSjCPbPmjAlg3C5k3R
         NlN4pWvG1BcY26SP1/sqGljTqWqDimL3K5SubIMSfH0ETG9k4/sgLhwYMHa2C20YanfE
         Nomnw/2+KHKGK3Kbq2f/ntxhM3ER+JGeu4F+Vt1SxZF/wAw3GjG13HwA7wi3zMcKAXOq
         1vJpaGgYZDqJZbS5+QS2jZx8Awquu88eQP2QsfEx4qLG4Jw9CXrULQ19cf/J+fH+pzwS
         09+A==
X-Gm-Message-State: AOJu0YxEN3ebFDLjb9YAALp3NNnzd9KiLRPOQxTROztkQF72kwwRzTHc
	sBBS18s9/Dc/Gmg+p5MBVe/A21UyAIYlz1Gc99qS4Q==
X-Google-Smtp-Source: AGHT+IG850BaaVsSBieLbcrcPAlvtSLdS63rFbfZ5XL2HMYtKndJtzoyLkV6zTLXHmdxIOsC/XeZAA==
X-Received: by 2002:a17:902:b188:b0:1d0:8abd:4e30 with SMTP id s8-20020a170902b18800b001d08abd4e30mr317768plr.87.1701624539367;
        Sun, 03 Dec 2023 09:28:59 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id be7-20020a170902aa0700b001d09c5424d4sm668049plb.297.2023.12.03.09.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 09:28:58 -0800 (PST)
Message-ID: <656cbada.170a0220.1a40a.10c0@mx.google.com>
Date: Sun, 03 Dec 2023 09:28:58 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.202-78-ga6f1d8d78e2ed
Subject: stable-rc/queue/5.10 baseline: 136 runs,
 8 regressions (v5.10.202-78-ga6f1d8d78e2ed)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 136 runs, 8 regressions (v5.10.202-78-ga6f1d=
8d78e2ed)

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
nel/v5.10.202-78-ga6f1d8d78e2ed/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.202-78-ga6f1d8d78e2ed
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      a6f1d8d78e2ed722ce350ab7ed3b18745d5d52d8 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/656c892a8be8e81a3ce13475

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-78-ga6f1d8d78e2ed/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-78-ga6f1d8d78e2ed/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656c892b8be8e81a3ce134a7
        failing since 292 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-03T13:56:42.790406  <8>[   19.386949] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 301433_1.5.2.4.1>
    2023-12-03T13:56:42.900459  / # #
    2023-12-03T13:56:43.002501  export SHELL=3D/bin/sh
    2023-12-03T13:56:43.002941  #
    2023-12-03T13:56:43.104472  / # export SHELL=3D/bin/sh. /lava-301433/en=
vironment
    2023-12-03T13:56:43.105043  =

    2023-12-03T13:56:43.206831  / # . /lava-301433/environment/lava-301433/=
bin/lava-test-runner /lava-301433/1
    2023-12-03T13:56:43.207764  =

    2023-12-03T13:56:43.211991  / # /lava-301433/bin/lava-test-runner /lava=
-301433/1
    2023-12-03T13:56:43.316324  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656c8a8e28d56ad312e13484

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-78-ga6f1d8d78e2ed/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.t=
xt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-78-ga6f1d8d78e2ed/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656c8a8e28d56ad312e134be
        new failure (last pass: v5.10.202-69-g560a93e9d1ce3)

    2023-12-03T14:02:25.721424  / # #
    2023-12-03T14:02:25.823300  export SHELL=3D/bin/sh
    2023-12-03T14:02:25.823779  #
    2023-12-03T14:02:25.925141  / # export SHELL=3D/bin/sh. /lava-301496/en=
vironment
    2023-12-03T14:02:25.925666  =

    2023-12-03T14:02:26.027316  / # . /lava-301496/environment/lava-301496/=
bin/lava-test-runner /lava-301496/1
    2023-12-03T14:02:26.028139  =

    2023-12-03T14:02:26.034450  / # /lava-301496/bin/lava-test-runner /lava=
-301496/1
    2023-12-03T14:02:26.066421  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-03T14:02:26.105233  + cd /lava-301496/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656c89979a3098e2fde134e5

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-78-ga6f1d8d78e2ed/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-78-ga6f1d8d78e2ed/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656c89979a3098e2fde134ea
        failing since 10 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-03T14:05:08.106167  / # #

    2023-12-03T14:05:08.206710  export SHELL=3D/bin/sh

    2023-12-03T14:05:08.206831  #

    2023-12-03T14:05:08.307342  / # export SHELL=3D/bin/sh. /lava-12168489/=
environment

    2023-12-03T14:05:08.307470  =


    2023-12-03T14:05:08.407998  / # . /lava-12168489/environment/lava-12168=
489/bin/lava-test-runner /lava-12168489/1

    2023-12-03T14:05:08.408185  =


    2023-12-03T14:05:08.420122  / # /lava-12168489/bin/lava-test-runner /la=
va-12168489/1

    2023-12-03T14:05:08.473443  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-03T14:05:08.473520  + cd /lav<8>[   16.383342] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12168489_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/656c8a1070324ba999e134ab

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-78-ga6f1d8d78e2ed/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-78-ga6f1d8d78e2ed/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/656c8a1070324ba999e134b1
        failing since 264 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-03T14:02:54.583059  <8>[   33.962130] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-12-03T14:02:55.609260  /lava-12168539/1/../bin/lava-test-case

    2023-12-03T14:02:55.619911  <8>[   34.999364] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/656c8a1070324ba999e134b2
        failing since 264 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-03T14:02:54.572206  /lava-12168539/1/../bin/lava-test-case
   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656c89a1ac3459eb51e13510

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-78-ga6f1d8d78e2ed/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-78-ga6f1d8d78e2ed/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656c89a1ac3459eb51e13515
        failing since 10 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-03T13:58:47.538151  <8>[   16.963145] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 446372_1.5.2.4.1>
    2023-12-03T13:58:47.642496  / # #
    2023-12-03T13:58:47.743984  export SHELL=3D/bin/sh
    2023-12-03T13:58:47.744528  #
    2023-12-03T13:58:47.845469  / # export SHELL=3D/bin/sh. /lava-446372/en=
vironment
    2023-12-03T13:58:47.846010  =

    2023-12-03T13:58:47.946950  / # . /lava-446372/environment/lava-446372/=
bin/lava-test-runner /lava-446372/1
    2023-12-03T13:58:47.947758  =

    2023-12-03T13:58:47.953484  / # /lava-446372/bin/lava-test-runner /lava=
-446372/1
    2023-12-03T13:58:48.018646  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656c89ab44f82f9cf7e1349f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-78-ga6f1d8d78e2ed/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-78-ga6f1d8d78e2ed/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656c89ab44f82f9cf7e134a4
        failing since 10 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-03T14:05:24.044692  / # #

    2023-12-03T14:05:24.146900  export SHELL=3D/bin/sh

    2023-12-03T14:05:24.147597  #

    2023-12-03T14:05:24.248800  / # export SHELL=3D/bin/sh. /lava-12168488/=
environment

    2023-12-03T14:05:24.249020  =


    2023-12-03T14:05:24.349626  / # . /lava-12168488/environment/lava-12168=
488/bin/lava-test-runner /lava-12168488/1

    2023-12-03T14:05:24.349938  =


    2023-12-03T14:05:24.352427  / # /lava-12168488/bin/lava-test-runner /la=
va-12168488/1

    2023-12-03T14:05:24.393380  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-03T14:05:24.426618  + cd /lava-1216848<8>[   18.205779] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12168488_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/656c88aee1cecd6e0be134ba

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-78-ga6f1d8d78e2ed/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-78-ga6f1d8d78e2ed/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656c88aee1cecd6e0be134bf
        failing since 10 days (last pass: v5.10.165-77-g4600242c13ed, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-03T13:54:32.137452  / # #
    2023-12-03T13:54:32.238885  export SHELL=3D/bin/sh
    2023-12-03T13:54:32.239414  #
    2023-12-03T13:54:32.340327  / # export SHELL=3D/bin/sh. /lava-3858655/e=
nvironment
    2023-12-03T13:54:32.340840  =

    2023-12-03T13:54:32.441758  / # . /lava-3858655/environment/lava-385865=
5/bin/lava-test-runner /lava-3858655/1
    2023-12-03T13:54:32.442544  =

    2023-12-03T13:54:32.449013  / # /lava-3858655/bin/lava-test-runner /lav=
a-3858655/1
    2023-12-03T13:54:32.513163  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-03T13:54:32.560938  + cd /lava-3858655/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

