Return-Path: <stable+bounces-6853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8499815650
	for <lists+stable@lfdr.de>; Sat, 16 Dec 2023 03:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9BF1C230F8
	for <lists+stable@lfdr.de>; Sat, 16 Dec 2023 02:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C231C15B9;
	Sat, 16 Dec 2023 02:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="x+I4RNny"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B9718EA0
	for <stable@vger.kernel.org>; Sat, 16 Dec 2023 02:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-35d77fb7d94so5710155ab.0
        for <stable@vger.kernel.org>; Fri, 15 Dec 2023 18:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702692819; x=1703297619; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=octkl2G9rF+A60RXtKQRZDj0bY4m8TRytFWmrsV9NhE=;
        b=x+I4RNnyJeZo7ZDgXOuO6440x0/VQLLs20MKqw9AOTChJ0oTBn/YNm3gsFCKhOr5zM
         ljU/JxGI7IjwqeXtj1WVFgWPqLhmBH88AmpcC6C4QnqT/hqve9kVcbxchE+CQOWwcObk
         hO9yK8T8qYcSqaDdN+2sKLv8DmJVva1MihfdGVg6f+Ijo6Fi0hoqZ+82k4KAgDSdDYSR
         I39hfFLejE5l7fmkKMnEL6ZrLfhq8DJUZat+PWqw01egy1Ob87vHnwXAljBe1VjpC9ev
         zKQwv4hJ9qyAG19jqv1BhqXC+BGDW41PrUEzlGy/ro/aaT4lgRmpVcC2NyrfCfXp1HUH
         BOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702692819; x=1703297619;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=octkl2G9rF+A60RXtKQRZDj0bY4m8TRytFWmrsV9NhE=;
        b=f2sQqh+BeYHogP4FwucGlhB8pHcJ4hliQhUjuMNUZoV4uIfGdkz/bgDSvKU0bC5YqX
         DC9sFxh52HI7Q0QiNe/Fh7QIBEyM90CN1Dz1NgzPPgKLCI/yPQeaZymfdViBcvdX0h+l
         /sunyLAGgm3sfAJsnyaq0ZcKFcA4ovLoL2Y9r3LvNvLbVzYOOvTD7xP1PvhooHs15o37
         1QeXW0Btyz/Pny8NLfvO43KOji0CyGeDylpxsJKb95Zvr6FnyUY4do3NB1mO+nbcRhRK
         1O/RIn2gqfAx0N3PjywmopFJSr5UjQY/kJiLUhe14NFn3Ar0Mv4MNf9hnJubFq729TMn
         kG6g==
X-Gm-Message-State: AOJu0YwOLEt3o7lO2kxN4XMu6YEqHqLW44vVaMR5hBP70ML2qJLb9rTt
	IZ3iqkY27frbC5vS7LrHN1Hcqea/kWnr9fYNjqU=
X-Google-Smtp-Source: AGHT+IH0a4wBR6vPcjdVrfZldHNGswycUnW70KnLb4uw3823Ctfb6xtErWM6+oMwsbv//9h2lLn1/A==
X-Received: by 2002:a05:6e02:2189:b0:35f:7674:5a1b with SMTP id j9-20020a056e02218900b0035f76745a1bmr6623229ila.3.1702692819047;
        Fri, 15 Dec 2023 18:13:39 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bh12-20020a170902a98c00b001cfc3f73927sm14784310plb.9.2023.12.15.18.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 18:13:38 -0800 (PST)
Message-ID: <657d07d2.170a0220.8c325.f03e@mx.google.com>
Date: Fri, 15 Dec 2023 18:13:38 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.204-13-g361190381c8fa
Subject: stable-rc/queue/5.10 baseline: 102 runs,
 7 regressions (v5.10.204-13-g361190381c8fa)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 102 runs, 7 regressions (v5.10.204-13-g36119=
0381c8fa)

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
nel/v5.10.204-13-g361190381c8fa/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.204-13-g361190381c8fa
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      361190381c8fa74758ecd626e1ccc71bfa4e45d9 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
beaglebone-black   | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig=
        | 1          =


  Details:     https://kernelci.org/test/plan/id/657cd4f4d4c52f3135e135c5

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-13-g361190381c8fa/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-13-g361190381c8fa/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657cd4f5d4c52f3135e135f9
        failing since 305 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-15T22:36:09.017783  <8>[   21.078629] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 359575_1.5.2.4.1>
    2023-12-15T22:36:09.126784  / # #
    2023-12-15T22:36:09.228729  export SHELL=3D/bin/sh
    2023-12-15T22:36:09.229246  #
    2023-12-15T22:36:09.330953  / # export SHELL=3D/bin/sh. /lava-359575/en=
vironment
    2023-12-15T22:36:09.331539  =

    2023-12-15T22:36:09.432835  / # . /lava-359575/environment/lava-359575/=
bin/lava-test-runner /lava-359575/1
    2023-12-15T22:36:09.433563  =

    2023-12-15T22:36:09.438163  / # /lava-359575/bin/lava-test-runner /lava=
-359575/1
    2023-12-15T22:36:09.544706  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
juno-uboot         | arm64 | lab-broonie   | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/657cd36da742598eb9e13490

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-13-g361190381c8fa/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.t=
xt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-13-g361190381c8fa/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657cd36da742598eb9e134c9
        new failure (last pass: v5.10.203-97-g284f46c131b10)

    2023-12-15T22:29:34.243177  / # #
    2023-12-15T22:29:34.346125  export SHELL=3D/bin/sh
    2023-12-15T22:29:34.346925  #
    2023-12-15T22:29:34.448917  / # export SHELL=3D/bin/sh. /lava-359517/en=
vironment
    2023-12-15T22:29:34.449787  =

    2023-12-15T22:29:34.551809  / # . /lava-359517/environment/lava-359517/=
bin/lava-test-runner /lava-359517/1
    2023-12-15T22:29:34.553549  =

    2023-12-15T22:29:34.564881  / # /lava-359517/bin/lava-test-runner /lava=
-359517/1
    2023-12-15T22:29:34.627860  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-15T22:29:34.628435  + cd /lava-359517/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/657cd20fe10352636be1348c

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-13-g361190381c8fa/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-13-g361190381c8fa/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657cd20fe10352636be13491
        failing since 23 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-15T22:31:26.932104  / # #

    2023-12-15T22:31:27.034320  export SHELL=3D/bin/sh

    2023-12-15T22:31:27.035017  #

    2023-12-15T22:31:27.136476  / # export SHELL=3D/bin/sh. /lava-12282536/=
environment

    2023-12-15T22:31:27.137180  =


    2023-12-15T22:31:27.238690  / # . /lava-12282536/environment/lava-12282=
536/bin/lava-test-runner /lava-12282536/1

    2023-12-15T22:31:27.239798  =


    2023-12-15T22:31:27.284900  / # /lava-12282536/bin/lava-test-runner /la=
va-12282536/1

    2023-12-15T22:31:27.305337  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-15T22:31:27.305838  + cd /lav<8>[   16.445239] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12282536_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
rk3399-gru-kevin   | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chr=
omebook | 2          =


  Details:     https://kernelci.org/test/plan/id/657cd713ae53f238dce13512

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-13-g361190381c8fa/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-13-g361190381c8fa/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/657cd713ae53f238dce13518
        failing since 276 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-15T22:48:01.875762  <8>[   34.129341] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-12-15T22:48:02.899297  /lava-12282654/1/../bin/lava-test-case

    2023-12-15T22:48:02.909772  <8>[   35.164712] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/657cd713ae53f238dce13519
        failing since 276 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-15T22:48:00.842476  <8>[   33.094655] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-12-15T22:48:01.863557  /lava-12282654/1/../bin/lava-test-case
   =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/657cd1ff0f0bd6dbbce13484

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-13-g361190381c8fa/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-13-g361190381c8fa/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657cd1ff0f0bd6dbbce13489
        failing since 23 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-15T22:23:50.227607  <8>[   17.054936] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 448268_1.5.2.4.1>
    2023-12-15T22:23:50.332569  / # #
    2023-12-15T22:23:50.434211  export SHELL=3D/bin/sh
    2023-12-15T22:23:50.434793  #
    2023-12-15T22:23:50.535778  / # export SHELL=3D/bin/sh. /lava-448268/en=
vironment
    2023-12-15T22:23:50.536342  =

    2023-12-15T22:23:50.637368  / # . /lava-448268/environment/lava-448268/=
bin/lava-test-runner /lava-448268/1
    2023-12-15T22:23:50.638263  =

    2023-12-15T22:23:50.642885  / # /lava-448268/bin/lava-test-runner /lava=
-448268/1
    2023-12-15T22:23:50.709994  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/657cd211d296298903e1347d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-13-g361190381c8fa/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-13-g361190381c8fa/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657cd211d296298903e13482
        failing since 23 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-15T22:31:42.183391  / # #

    2023-12-15T22:31:42.285391  export SHELL=3D/bin/sh

    2023-12-15T22:31:42.286099  #

    2023-12-15T22:31:42.387431  / # export SHELL=3D/bin/sh. /lava-12282540/=
environment

    2023-12-15T22:31:42.388145  =


    2023-12-15T22:31:42.489623  / # . /lava-12282540/environment/lava-12282=
540/bin/lava-test-runner /lava-12282540/1

    2023-12-15T22:31:42.490715  =


    2023-12-15T22:31:42.507894  / # /lava-12282540/bin/lava-test-runner /la=
va-12282540/1

    2023-12-15T22:31:42.548861  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-15T22:31:42.566002  + cd /lava-1228254<8>[   18.236705] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12282540_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

