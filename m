Return-Path: <stable+bounces-5100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE60F80B307
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 09:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CE751C209DF
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 08:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4939D6FC8;
	Sat,  9 Dec 2023 08:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="BiEkD185"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE0E10FC
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 00:03:03 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6d9dbe224bbso1766606a34.2
        for <stable@vger.kernel.org>; Sat, 09 Dec 2023 00:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702108983; x=1702713783; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0yb9mxgh+lfWMca0ZvAHFwF2CpSaDAjGrABsValZ5E=;
        b=BiEkD185YOI1qBj0GEFy/0VL9/u8GrQJUgfWqr06Y1KCNkPL98SAk4QRV3xKc4HC8U
         D218RVnmPcfMcn91q1XDmEwiQMYrIzXVKQ1X+X17mfyO8P2RdFMJVhsPbG3qy5ImRUAi
         nxYm82/AUvO6ag3BfWgShcMh1SRvfnmjDRrt5jIKbMgkSEnK/4J3akZH+epplsNiDYPp
         XIdJKsCaw0d/aBwvloKro076ZuW4b/QxeoYCwbLilmG//x7xuPVYly88N4k09TgJvjR8
         sH2WoRTk0U9esKRubUGNRiQukf5loRhdV9o8t2Fe0dErWYUuS/XsNKE1lbyWBdAsoQ7F
         uqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702108983; x=1702713783;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q0yb9mxgh+lfWMca0ZvAHFwF2CpSaDAjGrABsValZ5E=;
        b=Jc0y5+w2ZzV7MGJIhPn3cDVrDjjXEmlywh7JEM6aL3SAmA9DnGC4GhUjn4fSZeEjap
         dyf1jRB4HSZ0NbUBNsFNduyjr+20qpBwy25PqRIQBF/3eZYpLikOXjft7etynBblA61g
         LTk0K2lpVbOkSihkG7hZAcKTgLMd/xMicbCbcBdINDITe3hZRbNdldBrCjiVwG/huvsC
         r368orv+PjwCgSGLC5pvFJ5f1g5hAxvKd99t7snq8aOZmilkAeRsQIS/8wjuNdksjeCR
         1YhIsM7vuY0qp8rdRJlADbizIVz6XDJi6kYh2fx/G6pYdabgiQM+71SFV5xcO/n3dsRS
         3MHw==
X-Gm-Message-State: AOJu0YzJWYGPb+/4I1DV1OvYeJ6cTFz68DTYTahLBIfZu10BKcE2pTIj
	suXuXrAK8OPSH6zHu3TLtuTvOxJfyZ67OtbOfKbuiA==
X-Google-Smtp-Source: AGHT+IE5NLq0GVT3Frz9l/1Z5bnpZfsYUmMX14qQDbFoFY2tXG3uq9jGfIvLi/S7ROQ/KvU93Rre6g==
X-Received: by 2002:a9d:7dd8:0:b0:6d9:d2ef:f923 with SMTP id k24-20020a9d7dd8000000b006d9d2eff923mr1425617otn.74.1702108982607;
        Sat, 09 Dec 2023 00:03:02 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s16-20020a62e710000000b006cb4fa1174dsm2728718pfh.124.2023.12.09.00.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 00:03:02 -0800 (PST)
Message-ID: <65741f36.620a0220.1c5e6.94a2@mx.google.com>
Date: Sat, 09 Dec 2023 00:03:02 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.203-35-g338b25578b878
Subject: stable-rc/queue/5.10 baseline: 154 runs,
 10 regressions (v5.10.203-35-g338b25578b878)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 154 runs, 10 regressions (v5.10.203-35-g338b=
25578b878)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
at91-sama5d4_xplained        | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =

beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =

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
nel/v5.10.203-35-g338b25578b878/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.203-35-g338b25578b878
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      338b25578b878186d3756a4648d44e224aabf9af =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
at91-sama5d4_xplained        | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6573ed2fb603a7111ce1353f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-35-g338b25578b878/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91=
-sama5d4_xplained.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-35-g338b25578b878/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91=
-sama5d4_xplained.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6573ed2fb603a7111ce13=
540
        new failure (last pass: v5.10.203-7-g904bbd534ce44) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/6573ed4af48a3765ace134a2

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-35-g338b25578b878/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-35-g338b25578b878/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573ed4af48a3765ace134dc
        failing since 298 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-09T04:29:50.120682  + set +x
    2023-12-09T04:29:50.123528  <8>[   21.022338] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 329632_1.5.2.4.1>
    2023-12-09T04:29:50.233311  / # #
    2023-12-09T04:29:50.335660  export SHELL=3D/bin/sh
    2023-12-09T04:29:50.336173  #
    2023-12-09T04:29:50.437894  / # export SHELL=3D/bin/sh. /lava-329632/en=
vironment
    2023-12-09T04:29:50.438544  =

    2023-12-09T04:29:50.540276  / # . /lava-329632/environment/lava-329632/=
bin/lava-test-runner /lava-329632/1
    2023-12-09T04:29:50.541019  =

    2023-12-09T04:29:50.544927  / # /lava-329632/bin/lava-test-runner /lava=
-329632/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxbb-p200              | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6573ecc432a98e3302e13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-35-g338b25578b878/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-=
p200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-35-g338b25578b878/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-=
p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6573ecc432a98e3302e13=
476
        failing since 0 day (last pass: v5.10.203-7-gce575ec88a51a, first f=
ail: v5.10.203-7-g904bbd534ce44) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
panda                        | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6573ec0ef8f0d1f643e134aa

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-35-g338b25578b878/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pand=
a.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-35-g338b25578b878/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pand=
a.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573ec0ff8f0d1f643e134b3
        failing since 2 days (last pass: v5.10.148-91-g23f89880f93d, first =
fail: v5.10.202-131-g761b9c32d3c8b)

    2023-12-09T04:24:34.690419  <8>[   24.560089] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3869741_1.5.2.4.1>
    2023-12-09T04:24:34.795146  / # #
    2023-12-09T04:24:34.896525  export SHELL=3D/bin/sh
    2023-12-09T04:24:34.897035  #
    2023-12-09T04:24:34.997898  / # export SHELL=3D/bin/sh. /lava-3869741/e=
nvironment
    2023-12-09T04:24:34.998398  =

    2023-12-09T04:24:35.099269  / # . /lava-3869741/environment/lava-386974=
1/bin/lava-test-runner /lava-3869741/1
    2023-12-09T04:24:35.100020  =

    2023-12-09T04:24:35.104180  / # /lava-3869741/bin/lava-test-runner /lav=
a-3869741/1
    2023-12-09T04:24:35.163131  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6573ebb0313ed061bae13498

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-35-g338b25578b878/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-35-g338b25578b878/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573ebb0313ed061bae134a1
        failing since 16 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-09T04:30:42.939660  / # #

    2023-12-09T04:30:43.040230  export SHELL=3D/bin/sh

    2023-12-09T04:30:43.040357  #

    2023-12-09T04:30:43.140855  / # export SHELL=3D/bin/sh. /lava-12226136/=
environment

    2023-12-09T04:30:43.140979  =


    2023-12-09T04:30:43.241496  / # . /lava-12226136/environment/lava-12226=
136/bin/lava-test-runner /lava-12226136/1

    2023-12-09T04:30:43.241685  =


    2023-12-09T04:30:43.247852  / # /lava-12226136/bin/lava-test-runner /la=
va-12226136/1

    2023-12-09T04:30:43.307174  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-09T04:30:43.307258  + cd /lav<8>[   16.401969] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12226136_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6573ee8af0ab7790b4e13480

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-35-g338b25578b878/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-35-g338b25578b878/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6573ee8af0ab7790b4e1348a
        failing since 270 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-09T04:35:18.708576  /lava-12226348/1/../bin/lava-test-case

    2023-12-09T04:35:18.719051  <8>[   33.576227] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6573ee8af0ab7790b4e1348b
        failing since 270 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-09T04:35:17.672829  /lava-12226348/1/../bin/lava-test-case

    2023-12-09T04:35:17.684413  <8>[   32.540809] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6573ebac313ed061bae1348b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-35-g338b25578b878/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-35-g338b25578b878/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573ebac313ed061bae13494
        failing since 16 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-09T04:22:58.710725  <8>[   16.937280] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447222_1.5.2.4.1>
    2023-12-09T04:22:58.815782  / # #
    2023-12-09T04:22:58.917426  export SHELL=3D/bin/sh
    2023-12-09T04:22:58.918036  #
    2023-12-09T04:22:59.019030  / # export SHELL=3D/bin/sh. /lava-447222/en=
vironment
    2023-12-09T04:22:59.019738  =

    2023-12-09T04:22:59.120771  / # . /lava-447222/environment/lava-447222/=
bin/lava-test-runner /lava-447222/1
    2023-12-09T04:22:59.121750  =

    2023-12-09T04:22:59.126071  / # /lava-447222/bin/lava-test-runner /lava=
-447222/1
    2023-12-09T04:22:59.193028  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6573ebc4313ed061bae13573

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-35-g338b25578b878/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-35-g338b25578b878/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573ebc4313ed061bae1357c
        failing since 16 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-09T04:30:58.892903  / # #

    2023-12-09T04:30:58.993510  export SHELL=3D/bin/sh

    2023-12-09T04:30:58.993694  #

    2023-12-09T04:30:59.094490  / # export SHELL=3D/bin/sh. /lava-12226134/=
environment

    2023-12-09T04:30:59.095200  =


    2023-12-09T04:30:59.196356  / # . /lava-12226134/environment/lava-12226=
134/bin/lava-test-runner /lava-12226134/1

    2023-12-09T04:30:59.196618  =


    2023-12-09T04:30:59.206676  / # /lava-12226134/bin/lava-test-runner /la=
va-12226134/1

    2023-12-09T04:30:59.267710  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-09T04:30:59.267794  + cd /lava-1222613<8>[   18.193045] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12226134_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6573ec07f8f0d1f643e1349d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-35-g338b25578b878/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-35-g338b25578b878/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573ec07f8f0d1f643e134a6
        failing since 16 days (last pass: v5.10.165-77-g4600242c13ed, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-09T04:24:07.748596  / # #
    2023-12-09T04:24:07.850412  export SHELL=3D/bin/sh
    2023-12-09T04:24:07.850905  #
    2023-12-09T04:24:07.951789  / # export SHELL=3D/bin/sh. /lava-3869740/e=
nvironment
    2023-12-09T04:24:07.952306  =

    2023-12-09T04:24:08.053178  / # . /lava-3869740/environment/lava-386974=
0/bin/lava-test-runner /lava-3869740/1
    2023-12-09T04:24:08.053934  =

    2023-12-09T04:24:08.061678  / # /lava-3869740/bin/lava-test-runner /lav=
a-3869740/1
    2023-12-09T04:24:08.109749  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-09T04:24:08.148605  + cd /lava-3869740/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

