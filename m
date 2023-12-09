Return-Path: <stable+bounces-5108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1722E80B3CA
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 11:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3825A1C209A2
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 10:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3E6134CB;
	Sat,  9 Dec 2023 10:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="p0xNYANb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F349D1
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 02:53:39 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d05e4a94c3so25731575ad.1
        for <stable@vger.kernel.org>; Sat, 09 Dec 2023 02:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702119218; x=1702724018; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bivB3o5IrP5fLrAcnZUN1zIl8qgiBvMb7rXsdZeWEiU=;
        b=p0xNYANb2/dqielePfd9f+9Z6/yhHZ3IVahRtiOFuDD7wD2lJsOrdncvDNmCR+7I54
         Vp4jCMTGAjdxsWLcNuXYPlN7WqbrkEcegYyXQyIfTDS/YUbpv6hey9ugGSN/NKhD5RAc
         8//AnyLVGtxWbM1Hqhk08CWd706dlQ8Mhl1amjlEmlJqfV0kFVxEM8BFRPZ8wC+U/ELZ
         iTl3/36UpopDpvcIMMb2jY9stC01Q59efdy24kEJenL5OcKEiZoKcOcpzRQTbspiqBnU
         eVTIlkoSet4sDQruzUDdIZa3O9Oc/+BnATJbsxJWilLlg+kSMQls6WYtHRYQFLCEGVgM
         UGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702119218; x=1702724018;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bivB3o5IrP5fLrAcnZUN1zIl8qgiBvMb7rXsdZeWEiU=;
        b=s+jMRJwb9KHFjIRVWirU68EgBLcPpXGjZH8ZHJxAb0/4j3AEtUi4Ly1GhPJFY8a6hO
         TWlJvjQl9cRyIzBoUcMlSsdpyZLzEWsHlmvn5Eue3d505N/NllKW9lGtYUPqlbLLMTw8
         pEFdsWBOK6odHQty9s54WJNnjnsJSq3IAvL2Px8d6B3B3BtAhXhhOZSk3bT0ElYcnBsu
         j8/su3YCQZfMRyPLogsEVL6nap7IQrThW+dHiV8ndCGpf5wahz4Vk2SF8Y0yUp1BKWlk
         jPSFf/AJkHfxcOZO1nHZIlX72icy2W38ASulAE48+Gfy7BQG1PI7tEUzW2cAQ7gohd8o
         ruRg==
X-Gm-Message-State: AOJu0YyWgznfzwJZf5oH49VdGuu9Z/NkA7ALsbqn+ZSgqBMihHRi1dMg
	7co44jxDUqD5FIBOhLxsH8L1Mn5FrpO0DFFKDTOs/w==
X-Google-Smtp-Source: AGHT+IHFfxhwRrWIjQB2wZnf9H7cpov7I0W1qoHt5UzRvxkYOLpKp4FzMjngNOyvqEIsPPMuz4lBfA==
X-Received: by 2002:a17:902:e789:b0:1d0:6ffe:9f5 with SMTP id cp9-20020a170902e78900b001d06ffe09f5mr1703107plb.83.1702119218379;
        Sat, 09 Dec 2023 02:53:38 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y12-20020a170902700c00b001bbb8d5166bsm3124523plk.123.2023.12.09.02.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 02:53:37 -0800 (PST)
Message-ID: <65744731.170a0220.fd8fb.a67f@mx.google.com>
Date: Sat, 09 Dec 2023 02:53:37 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.142-77-ga64dd884b1d57
Subject: stable-rc/queue/5.15 baseline: 143 runs,
 7 regressions (v5.15.142-77-ga64dd884b1d57)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 143 runs, 7 regressions (v5.15.142-77-ga64dd=
884b1d57)

Regressions Summary
-------------------

platform              | arch  | lab           | compiler | defconfig       =
    | regressions
----------------------+-------+---------------+----------+-----------------=
----+------------
at91-sama5d4_xplained | arm   | lab-baylibre  | gcc-10   | multi_v7_defconf=
ig  | 1          =

beagle-xm             | arm   | lab-baylibre  | gcc-10   | omap2plus_defcon=
fig | 1          =

meson-gxbb-p200       | arm64 | lab-baylibre  | gcc-10   | defconfig       =
    | 1          =

panda                 | arm   | lab-baylibre  | gcc-10   | multi_v7_defconf=
ig  | 1          =

r8a77960-ulcb         | arm64 | lab-collabora | gcc-10   | defconfig       =
    | 1          =

sun50i-h6-pine-h64    | arm64 | lab-clabbe    | gcc-10   | defconfig       =
    | 1          =

sun50i-h6-pine-h64    | arm64 | lab-collabora | gcc-10   | defconfig       =
    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.142-77-ga64dd884b1d57/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.142-77-ga64dd884b1d57
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      a64dd884b1d579d1a2868483676b8f63cf7efe28 =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig       =
    | regressions
----------------------+-------+---------------+----------+-----------------=
----+------------
at91-sama5d4_xplained | arm   | lab-baylibre  | gcc-10   | multi_v7_defconf=
ig  | 1          =


  Details:     https://kernelci.org/test/plan/id/657416e7e233a7c4e1e1347c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-77-ga64dd884b1d57/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91=
-sama5d4_xplained.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-77-ga64dd884b1d57/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91=
-sama5d4_xplained.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/657416e7e233a7c4e1e13=
47d
        failing since 0 day (last pass: v5.15.142-8-g5d3692481649b, first f=
ail: v5.15.142-48-gdbed703bb51c2) =

 =



platform              | arch  | lab           | compiler | defconfig       =
    | regressions
----------------------+-------+---------------+----------+-----------------=
----+------------
beagle-xm             | arm   | lab-baylibre  | gcc-10   | omap2plus_defcon=
fig | 1          =


  Details:     https://kernelci.org/test/plan/id/657414c4228123b736e13559

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-77-ga64dd884b1d57/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-77-ga64dd884b1d57/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/657414c4228123b736e13=
55a
        failing since 308 days (last pass: v5.15.91-12-g3290f78df1ab, first=
 fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform              | arch  | lab           | compiler | defconfig       =
    | regressions
----------------------+-------+---------------+----------+-----------------=
----+------------
meson-gxbb-p200       | arm64 | lab-baylibre  | gcc-10   | defconfig       =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/657415190e5ee59c74e134c6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-77-ga64dd884b1d57/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-=
p200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-77-ga64dd884b1d57/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-=
p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/657415190e5ee59c74e13=
4c7
        new failure (last pass: v5.15.142-48-gdbed703bb51c2) =

 =



platform              | arch  | lab           | compiler | defconfig       =
    | regressions
----------------------+-------+---------------+----------+-----------------=
----+------------
panda                 | arm   | lab-baylibre  | gcc-10   | multi_v7_defconf=
ig  | 1          =


  Details:     https://kernelci.org/test/plan/id/657415cd0fb72d26eee134c5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-77-ga64dd884b1d57/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pand=
a.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-77-ga64dd884b1d57/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pand=
a.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657415cd0fb72d26eee134ce
        failing since 2 days (last pass: v5.15.74-135-g19e8e8e20e2b, first =
fail: v5.15.141-64-g41591b7f348c5)

    2023-12-09T07:22:39.519264  <8>[   11.796081] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3870281_1.5.2.4.1>
    2023-12-09T07:22:39.626169  / # #
    2023-12-09T07:22:39.727351  export SHELL=3D/bin/sh
    2023-12-09T07:22:39.727715  #
    2023-12-09T07:22:39.828540  / # export SHELL=3D/bin/sh. /lava-3870281/e=
nvironment
    2023-12-09T07:22:39.828903  =

    2023-12-09T07:22:39.929721  / # . /lava-3870281/environment/lava-387028=
1/bin/lava-test-runner /lava-3870281/1
    2023-12-09T07:22:39.930324  =

    2023-12-09T07:22:39.934484  / # /lava-3870281/bin/lava-test-runner /lav=
a-3870281/1
    2023-12-09T07:22:39.992443  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform              | arch  | lab           | compiler | defconfig       =
    | regressions
----------------------+-------+---------------+----------+-----------------=
----+------------
r8a77960-ulcb         | arm64 | lab-collabora | gcc-10   | defconfig       =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/657421649ef66df775e13475

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-77-ga64dd884b1d57/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-77-ga64dd884b1d57/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657421649ef66df775e1347e
        failing since 16 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-09T08:19:34.688479  / # #

    2023-12-09T08:19:34.790644  export SHELL=3D/bin/sh

    2023-12-09T08:19:34.791369  #

    2023-12-09T08:19:34.892732  / # export SHELL=3D/bin/sh. /lava-12227998/=
environment

    2023-12-09T08:19:34.893461  =


    2023-12-09T08:19:34.994918  / # . /lava-12227998/environment/lava-12227=
998/bin/lava-test-runner /lava-12227998/1

    2023-12-09T08:19:34.996030  =


    2023-12-09T08:19:35.012900  / # /lava-12227998/bin/lava-test-runner /la=
va-12227998/1

    2023-12-09T08:19:35.062225  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-09T08:19:35.062745  + cd /lav<8>[   15.978586] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12227998_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform              | arch  | lab           | compiler | defconfig       =
    | regressions
----------------------+-------+---------------+----------+-----------------=
----+------------
sun50i-h6-pine-h64    | arm64 | lab-clabbe    | gcc-10   | defconfig       =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/657413ff4d533776f0e13477

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-77-ga64dd884b1d57/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-77-ga64dd884b1d57/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657413ff4d533776f0e13480
        failing since 16 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-09T07:15:02.606194  <8>[   16.113111] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447251_1.5.2.4.1>
    2023-12-09T07:15:02.711215  / # #
    2023-12-09T07:15:02.812905  export SHELL=3D/bin/sh
    2023-12-09T07:15:02.813604  #
    2023-12-09T07:15:02.914620  / # export SHELL=3D/bin/sh. /lava-447251/en=
vironment
    2023-12-09T07:15:02.915268  =

    2023-12-09T07:15:03.016291  / # . /lava-447251/environment/lava-447251/=
bin/lava-test-runner /lava-447251/1
    2023-12-09T07:15:03.017258  =

    2023-12-09T07:15:03.021538  / # /lava-447251/bin/lava-test-runner /lava=
-447251/1
    2023-12-09T07:15:03.053537  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform              | arch  | lab           | compiler | defconfig       =
    | regressions
----------------------+-------+---------------+----------+-----------------=
----+------------
sun50i-h6-pine-h64    | arm64 | lab-collabora | gcc-10   | defconfig       =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/657414064d533776f0e13487

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-77-ga64dd884b1d57/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-77-ga64dd884b1d57/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657414064d533776f0e13490
        failing since 16 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-09T07:22:39.508815  / # #

    2023-12-09T07:22:39.610969  export SHELL=3D/bin/sh

    2023-12-09T07:22:39.611690  #

    2023-12-09T07:22:39.712945  / # export SHELL=3D/bin/sh. /lava-12227989/=
environment

    2023-12-09T07:22:39.713162  =


    2023-12-09T07:22:39.813788  / # . /lava-12227989/environment/lava-12227=
989/bin/lava-test-runner /lava-12227989/1

    2023-12-09T07:22:39.814146  =


    2023-12-09T07:22:39.816457  / # /lava-12227989/bin/lava-test-runner /la=
va-12227989/1

    2023-12-09T07:22:39.860527  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-09T07:22:39.891369  + cd /lava-1222798<8>[   16.836411] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12227989_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

