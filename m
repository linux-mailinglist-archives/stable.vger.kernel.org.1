Return-Path: <stable+bounces-4810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 031E78066B6
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 06:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62DEF281FFE
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 05:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBB5107A2;
	Wed,  6 Dec 2023 05:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="CpmWvXLv"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105B918F
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 21:52:48 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5d7692542beso41375137b3.3
        for <stable@vger.kernel.org>; Tue, 05 Dec 2023 21:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701841967; x=1702446767; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b/ZZoVQNP1fAPMvCdjqzE1YhD6gQkclRwPQ7AZzkc+w=;
        b=CpmWvXLv7NgzuFgU6vBLhN14ewqVxmfBNM00b+GFRr9TXEC/siJMuNFI0N8ejvcOin
         fy1+5EULl8VpE0oxMDtKwH0JZ2EwMYeNkZmxSunwfchCm+gE81aBE7hWyvhdAFb+lUMv
         8msoDokdTJpeA8c0wdYN8tpGirpTw7ZMIpaU3VT4Bi+BwubMnll/nZvAS0uulMdk4xry
         7tsv6gt6FjkDsv5PF8Ja2AuxWDqbdhU6M+fIfy5RlkgagNkjROaizGCdYKYVCNyL0iSq
         md21KWOkhMguOGzbrh8z9QBO9B0MwsShdi50M1XRIxk5cMvONnWEdMnJE/19rDZFN5se
         9ISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701841967; x=1702446767;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/ZZoVQNP1fAPMvCdjqzE1YhD6gQkclRwPQ7AZzkc+w=;
        b=Vpl0IQkCAyRnZC8/nIjqWo4THjPnGTDa/iWxaqQtRPlrHXxreMp6wFGMP645zJ5MXt
         pvpqFYOVWrc4orZ9jpIMa7mQ+bNxYBvLXN1xwJeicnK31Ki+mlSsq8vrLuVqj2ds/xbY
         gTDpmYBPDMoiDGrxRE/daWq/j2MjL2gWS8hRR9gGlFK/7MOs+IurZDyVIEw/3J17MI4L
         P8gZSG+L1wqYKQtr9nbtycd90lFg0EkQPHRUi3YlhbH7oxSEhdjzRlYTWB+xTfcHDfda
         z2mzNIfl6lhg3Ec3cFQkfWK53z8lmBk60KViF6lhAjLyH84/giNWAUJo8T2a5uSZ+Jw4
         Zytg==
X-Gm-Message-State: AOJu0YwAmOcMHS0xgspDuC77VrqyCijgz5kFTTqbH8tCxyaKh122WHxq
	tqOrhGg7NQaw7RpF402ymMsxn4fal8oYBxwqD8olLQ==
X-Google-Smtp-Source: AGHT+IG4OVt/tXCBORh+u42UwqtE8FkKoDlJsFzrRrz3m1AkMPXhvtjIBn5/WBXjV2TiOuP/szZLNA==
X-Received: by 2002:a81:af56:0:b0:5d7:b137:60ff with SMTP id x22-20020a81af56000000b005d7b13760ffmr268989ywj.66.1701841966725;
        Tue, 05 Dec 2023 21:52:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902e54f00b001c407fac227sm7965823plf.41.2023.12.05.21.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 21:52:46 -0800 (PST)
Message-ID: <65700c2e.170a0220.239d1.68e3@mx.google.com>
Date: Tue, 05 Dec 2023 21:52:46 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.202-131-ged17b556b8e2
Subject: stable-rc/queue/5.10 baseline: 149 runs,
 7 regressions (v5.10.202-131-ged17b556b8e2)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 149 runs, 7 regressions (v5.10.202-131-ged17=
b556b8e2)

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

sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
                  | 1          =

sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =

sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.202-131-ged17b556b8e2/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.202-131-ged17b556b8e2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      ed17b556b8e2a85197c57bb67e79456914af2ec3 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/656fda00ee507cce53e13496

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-131-ged17b556b8e2/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-131-ged17b556b8e2/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656fda00ee507cce53e134cc
        failing since 295 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-06T02:18:12.329570  <8>[   19.333447] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 312433_1.5.2.4.1>
    2023-12-06T02:18:12.435333  / # #
    2023-12-06T02:18:12.537461  export SHELL=3D/bin/sh
    2023-12-06T02:18:12.538326  #
    2023-12-06T02:18:12.639825  / # export SHELL=3D/bin/sh. /lava-312433/en=
vironment
    2023-12-06T02:18:12.640589  =

    2023-12-06T02:18:12.742076  / # . /lava-312433/environment/lava-312433/=
bin/lava-test-runner /lava-312433/1
    2023-12-06T02:18:12.742840  =

    2023-12-06T02:18:12.747589  / # /lava-312433/bin/lava-test-runner /lava=
-312433/1
    2023-12-06T02:18:12.849132  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656fdabca597d0ea35e13475

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-131-ged17b556b8e2/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-131-ged17b556b8e2/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656fdabca597d0ea35e1347a
        failing since 13 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-06T02:29:15.304409  / # #

    2023-12-06T02:29:15.406561  export SHELL=3D/bin/sh

    2023-12-06T02:29:15.407161  #

    2023-12-06T02:29:15.508430  / # export SHELL=3D/bin/sh. /lava-12193082/=
environment

    2023-12-06T02:29:15.509146  =


    2023-12-06T02:29:15.610478  / # . /lava-12193082/environment/lava-12193=
082/bin/lava-test-runner /lava-12193082/1

    2023-12-06T02:29:15.611816  =


    2023-12-06T02:29:15.628826  / # /lava-12193082/bin/lava-test-runner /la=
va-12193082/1

    2023-12-06T02:29:15.676729  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-06T02:29:15.676876  + cd /lav<8>[   16.452682] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12193082_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/656fdb7fee3c9499d1e13476

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-131-ged17b556b8e2/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-131-ged17b556b8e2/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/656fdb7fee3c9499d1e1347c
        failing since 267 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-06T02:27:30.418336  /lava-12193140/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/656fdb7fee3c9499d1e1347d
        failing since 267 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-06T02:27:29.381527  /lava-12193140/1/../bin/lava-test-case

    2023-12-06T02:27:29.393220  <8>[   33.925126] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656fdac2ae97edb338e134a6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-131-ged17b556b8e2/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-131-ged17b556b8e2/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656fdac2ae97edb338e134ab
        failing since 13 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-06T02:21:45.253481  <8>[   16.995228] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 446719_1.5.2.4.1>
    2023-12-06T02:21:45.358407  / # #
    2023-12-06T02:21:45.460069  export SHELL=3D/bin/sh
    2023-12-06T02:21:45.460671  #
    2023-12-06T02:21:45.561644  / # export SHELL=3D/bin/sh. /lava-446719/en=
vironment
    2023-12-06T02:21:45.562167  =

    2023-12-06T02:21:45.663168  / # . /lava-446719/environment/lava-446719/=
bin/lava-test-runner /lava-446719/1
    2023-12-06T02:21:45.664052  =

    2023-12-06T02:21:45.668799  / # /lava-446719/bin/lava-test-runner /lava=
-446719/1
    2023-12-06T02:21:45.734771  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656fdad1a597d0ea35e1348d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-131-ged17b556b8e2/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-131-ged17b556b8e2/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656fdad1a597d0ea35e13492
        failing since 13 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-06T02:29:31.092011  / # #

    2023-12-06T02:29:31.193825  export SHELL=3D/bin/sh

    2023-12-06T02:29:31.194613  #

    2023-12-06T02:29:31.295777  / # export SHELL=3D/bin/sh. /lava-12193083/=
environment

    2023-12-06T02:29:31.296384  =


    2023-12-06T02:29:31.397564  / # . /lava-12193083/environment/lava-12193=
083/bin/lava-test-runner /lava-12193083/1

    2023-12-06T02:29:31.397834  =


    2023-12-06T02:29:31.400379  / # /lava-12193083/bin/lava-test-runner /la=
va-12193083/1

    2023-12-06T02:29:31.444364  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-06T02:29:31.469344  + cd /lava-1219308<8>[   18.227111] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12193083_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/656fda23bb8334ad14e134b5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-131-ged17b556b8e2/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.202=
-131-ged17b556b8e2/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656fda23bb8334ad14e134ba
        failing since 13 days (last pass: v5.10.165-77-g4600242c13ed, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-06T02:18:44.092710  / # #
    2023-12-06T02:18:44.193918  export SHELL=3D/bin/sh
    2023-12-06T02:18:44.194291  #
    2023-12-06T02:18:44.295061  / # export SHELL=3D/bin/sh. /lava-3862390/e=
nvironment
    2023-12-06T02:18:44.295436  =

    2023-12-06T02:18:44.396289  / # . /lava-3862390/environment/lava-386239=
0/bin/lava-test-runner /lava-3862390/1
    2023-12-06T02:18:44.397019  =

    2023-12-06T02:18:44.404582  / # /lava-3862390/bin/lava-test-runner /lav=
a-3862390/1
    2023-12-06T02:18:44.498518  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-06T02:18:44.498952  + cd /lava-3862390/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

