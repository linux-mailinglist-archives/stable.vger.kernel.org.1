Return-Path: <stable+bounces-8393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 637D581D4F1
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 17:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77961F21CD2
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 16:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A12FE56C;
	Sat, 23 Dec 2023 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="g850+r3o"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3813FE56B
	for <stable@vger.kernel.org>; Sat, 23 Dec 2023 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3ba14203a34so2533159b6e.1
        for <stable@vger.kernel.org>; Sat, 23 Dec 2023 08:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703347603; x=1703952403; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EGoXW4uloKJQg7B/UjYO7RQQlELdFZrsjZ8OGpvJyx0=;
        b=g850+r3o3UJiR8TNISv3nQ+2KDaphLNX3FA9j/XogMFkHjLXM1GB1BjXALCAcs4/E0
         iTTWMKpREJGxWvEAXPBFAPRXKW5I6c0fGFrS25KN6fEpl9MaEPAch0/1QPm1Ny4Y0j7t
         Qr8XpxqSOoUaUj78XWCqTatICwLLnlpoXs+RVyOp87xHU3JnNg6fBae6rvQdJp+ZPrVz
         M9diGpOqUkIleXCwNPnfuWe3u0MJTpi6wQwOnKVbv1LvZt2AhBrz4Y5OFnB6DN3ah1qt
         kfTqNNmpypWTvVEF5e3WEGZZgd62pHvJ0GUKzIW1BLVeMSKV7QZBzgrjawUiOPMZHQhk
         KP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703347603; x=1703952403;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EGoXW4uloKJQg7B/UjYO7RQQlELdFZrsjZ8OGpvJyx0=;
        b=lBg7y00sB24SZVWu/zfzKMjYtEkl1syrRaWl4WCGOQhChje5Ahe8Ob5JrJknuU3Lc0
         YbC3yNyZaAYV59oKik0n5bZL+b8FkHxxSzjeQCR3ewguF2uGQzvUL8BkJFHf+CEzm830
         3Wu0Yi/hjNbCBWm2AaVuVGC7ssDIxM7E+qPfSTJQtbz//PUda/BhijoRWIqOucTKb9xo
         g4fAXk0tuNIP3xB06hVL3rq2teh5igxF5IKOOz2RK45DtuMAqXvXtTu2xBiFS2TeT4R+
         1ZH7ZT1g3ECM2Z3NlCesBr5l7MBAfxjjUlzMd3pxGyOyg/EkZ13T6c5LdMFx6XbaRIHT
         SX4A==
X-Gm-Message-State: AOJu0Yzj3b0hj7FZFILC5pQpVgXZo9u5WF5xOgXGUpb1C8agu/L2emIE
	I1tG2+EzDGvUO/b2wNNwZlqy6NM1+cGnTsxVnVGi7z/3Fns=
X-Google-Smtp-Source: AGHT+IG1avOxJjKgN5taurjBk2mVjCQ3qd6AM+BEdnkOwWbYdCv9kYvWrG3fVuz4MQ0KZ9S/0LjzmA==
X-Received: by 2002:a05:6358:907:b0:172:da39:4424 with SMTP id r7-20020a056358090700b00172da394424mr3940843rwi.50.1703347603624;
        Sat, 23 Dec 2023 08:06:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id st16-20020a17090b1fd000b0028a4c85a55csm9270803pjb.27.2023.12.23.08.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 08:06:43 -0800 (PST)
Message-ID: <65870593.170a0220.c7cb8.c2f0@mx.google.com>
Date: Sat, 23 Dec 2023 08:06:43 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.204-81-g4f4182acc8f5a
Subject: stable-rc/queue/5.10 baseline: 98 runs,
 6 regressions (v5.10.204-81-g4f4182acc8f5a)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 98 runs, 6 regressions (v5.10.204-81-g4f4182=
acc8f5a)

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
nel/v5.10.204-81-g4f4182acc8f5a/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.204-81-g4f4182acc8f5a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      4f4182acc8f5a0e65f8737442cf948eb6a7ec2a4 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
beaglebone-black   | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig=
        | 1          =


  Details:     https://kernelci.org/test/plan/id/6586d1a5bf1fd3da49e13475

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-81-g4f4182acc8f5a/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-81-g4f4182acc8f5a/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6586d1a5bf1fd3da49e134af
        failing since 312 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-23T12:24:53.395729  <8>[   19.056104] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 390323_1.5.2.4.1>
    2023-12-23T12:24:53.502291  / # #
    2023-12-23T12:24:53.604028  export SHELL=3D/bin/sh
    2023-12-23T12:24:53.604563  #
    2023-12-23T12:24:53.705818  / # export SHELL=3D/bin/sh. /lava-390323/en=
vironment
    2023-12-23T12:24:53.706238  =

    2023-12-23T12:24:53.807470  / # . /lava-390323/environment/lava-390323/=
bin/lava-test-runner /lava-390323/1
    2023-12-23T12:24:53.808090  =

    2023-12-23T12:24:53.811692  / # /lava-390323/bin/lava-test-runner /lava=
-390323/1
    2023-12-23T12:24:53.918035  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/6586d097522862ad6ce134a2

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-81-g4f4182acc8f5a/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-81-g4f4182acc8f5a/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6586d097522862ad6ce134ab
        failing since 30 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-23T12:27:51.404349  / # #

    2023-12-23T12:27:51.504975  export SHELL=3D/bin/sh

    2023-12-23T12:27:51.505111  #

    2023-12-23T12:27:51.605644  / # export SHELL=3D/bin/sh. /lava-12363425/=
environment

    2023-12-23T12:27:51.605854  =


    2023-12-23T12:27:51.706376  / # . /lava-12363425/environment/lava-12363=
425/bin/lava-test-runner /lava-12363425/1

    2023-12-23T12:27:51.706611  =


    2023-12-23T12:27:51.717783  / # /lava-12363425/bin/lava-test-runner /la=
va-12363425/1

    2023-12-23T12:27:51.771674  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-23T12:27:51.771752  + cd /lav<8>[   16.429139] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12363425_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
rk3399-gru-kevin   | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chr=
omebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6586d4ba9103774062e13480

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-81-g4f4182acc8f5a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-81-g4f4182acc8f5a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6586d4ba9103774062e1348c
        failing since 284 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-23T12:40:32.086018  /lava-12363606/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6586d4ba9103774062e1348d
        failing since 284 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-23T12:40:30.025769  <8>[   33.010495] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-12-23T12:40:31.051563  /lava-12363606/1/../bin/lava-test-case

    2023-12-23T12:40:31.062378  <8>[   34.048016] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/6586d0952c9ea08947e13477

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-81-g4f4182acc8f5a/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-81-g4f4182acc8f5a/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6586d0952c9ea08947e13480
        failing since 30 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-23T12:20:30.645460  / # #
    2023-12-23T12:20:30.747096  export SHELL=3D/bin/sh
    2023-12-23T12:20:30.747753  #
    2023-12-23T12:20:30.848785  / # export SHELL=3D/bin/sh. /lava-449702/en=
vironment
    2023-12-23T12:20:30.849383  =

    2023-12-23T12:20:30.950405  / # . /lava-449702/environment/lava-449702/=
bin/lava-test-runner /lava-449702/1
    2023-12-23T12:20:30.951352  =

    2023-12-23T12:20:30.955157  / # /lava-449702/bin/lava-test-runner /lava=
-449702/1
    2023-12-23T12:20:31.022245  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-23T12:20:31.022888  + cd /lava-449702/<8>[   17.412453] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 449702_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/6586d0991780ef28c9e13531

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-81-g4f4182acc8f5a/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-81-g4f4182acc8f5a/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6586d0991780ef28c9e1353a
        failing since 30 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-23T12:28:00.210776  / # #

    2023-12-23T12:28:00.312878  export SHELL=3D/bin/sh

    2023-12-23T12:28:00.313520  #

    2023-12-23T12:28:00.414741  / # export SHELL=3D/bin/sh. /lava-12363427/=
environment

    2023-12-23T12:28:00.415402  =


    2023-12-23T12:28:00.516815  / # . /lava-12363427/environment/lava-12363=
427/bin/lava-test-runner /lava-12363427/1

    2023-12-23T12:28:00.517764  =


    2023-12-23T12:28:00.560854  / # /lava-12363427/bin/lava-test-runner /la=
va-12363427/1

    2023-12-23T12:28:00.561354  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-23T12:28:00.593681  + cd /lava-1236342<8>[   18.177574] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12363427_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

