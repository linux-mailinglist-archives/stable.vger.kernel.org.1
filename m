Return-Path: <stable+bounces-5045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3437480AA29
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 18:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83F5AB20AFD
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 17:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772CE374FB;
	Fri,  8 Dec 2023 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="HbB7fAkl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3C510E3
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 09:09:26 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6cea5548eb2so1883103b3a.0
        for <stable@vger.kernel.org>; Fri, 08 Dec 2023 09:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702055366; x=1702660166; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C9mNqFnJ6R8JlEoS7uT5eiENMVGc1IPBfUI0XjeRyis=;
        b=HbB7fAklE6rLdMs/lff9DucOJIjey/42uJDcj53Cjz/lWNoEs9Aq+S1sZRhqWVCsBu
         BhpxrA8u4AFYyzqdSjT7Ky2CBmntz/dvMz23iUtTlcs8RQZf1CdHrY5fWUuGdrkzf5V9
         8ApYleqxjCqi6ZbwavGaHejghji5MLzbBvCnUqRKLT3NBCOQsCbp3QqQUZiGrTUqYDd3
         8Fg6MrZ6Vx7hAiw3MmCuvYYMliow3+dU1YMNe9GJwKR0AyAQ8fMQUM9B9IetpBOXeikj
         NLtup0u6dtDB+CU/aZ2ysABRqysiAm+Ti2sCWTbOujlQYDb96FNSBIEKS6/8uh1Z/FfG
         Lt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702055366; x=1702660166;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9mNqFnJ6R8JlEoS7uT5eiENMVGc1IPBfUI0XjeRyis=;
        b=GTaFCQ4cXKDd+U1VWblkkFu5l4LAf4LS8S6z6sQ5NheQZJaQiICN+bz11a7+txtdp0
         yovR91tl/kRwabOw+8s5GL1N+9IB4oCY/mPErMh4FtzxAoMftPe7ZClMHcMalDBkTcO/
         fyjJQ97BTBw9qPdULViULDb149DAJlrI2xalH0mPaHrtP9QUlYNljrKIspAVZ+4bbGAI
         PvCjPOLDi0iAfUFomYGj6gWgoRP+zPsjVbjGA7hGCcqEJpoPdzoqncMRIy943wcAPRHd
         o3LyBiueOnS43IAsdSxq69z+TMEc3xvz+jD9RWOukeJ54kHJiiIteJJi6WYwe1PkUsMa
         D0sA==
X-Gm-Message-State: AOJu0Ywea4KwK1QnfXAYQ+UgT9DJ0Wpl2OATnQb8mXdwRE+CBRvWE2Z8
	NKtt2k9zBBi9H6ic+B158W+mEz/tVT0zxuXm0KEnCQ==
X-Google-Smtp-Source: AGHT+IGfpKdrB3JxKKqPWvKIObJ+zd2I8tMnGk/jjJQrtBbsqWAJkM49tT3i/6kgnqiJuHi+VdprRQ==
X-Received: by 2002:a05:6a00:2394:b0:6cb:a2f7:83d with SMTP id f20-20020a056a00239400b006cba2f7083dmr413503pfc.19.1702055365647;
        Fri, 08 Dec 2023 09:09:25 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k21-20020aa788d5000000b006ce79876f9csm1811872pff.82.2023.12.08.09.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:09:25 -0800 (PST)
Message-ID: <65734dc5.a70a0220.54065.5e81@mx.google.com>
Date: Fri, 08 Dec 2023 09:09:25 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.203-7-gce575ec88a51a
Subject: stable-rc/queue/5.10 baseline: 106 runs,
 6 regressions (v5.10.203-7-gce575ec88a51a)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 106 runs, 6 regressions (v5.10.203-7-gce575e=
c88a51a)

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
nel/v5.10.203-7-gce575ec88a51a/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.203-7-gce575ec88a51a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      ce575ec88a51a60900cd0995928711df8258820a =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
beaglebone-black   | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig=
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65732463647766027ae1347c

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-7-gce575ec88a51a/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beagl=
ebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-7-gce575ec88a51a/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beagl=
ebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65732463647766027ae134b5
        failing since 297 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-08T14:12:32.054053  <8>[   18.748573] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 325014_1.5.2.4.1>
    2023-12-08T14:12:32.163495  / # #
    2023-12-08T14:12:32.265615  export SHELL=3D/bin/sh
    2023-12-08T14:12:32.266309  #
    2023-12-08T14:12:32.368251  / # export SHELL=3D/bin/sh. /lava-325014/en=
vironment
    2023-12-08T14:12:32.368900  =

    2023-12-08T14:12:32.470862  / # . /lava-325014/environment/lava-325014/=
bin/lava-test-runner /lava-325014/1
    2023-12-08T14:12:32.471729  =

    2023-12-08T14:12:32.476041  / # /lava-325014/bin/lava-test-runner /lava=
-325014/1
    2023-12-08T14:12:32.572999  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65731c5f3324cccbd0e13501

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-7-gce575ec88a51a/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-7-gce575ec88a51a/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65731c5f3324cccbd0e1350a
        failing since 15 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-08T13:45:56.924215  / # #

    2023-12-08T13:45:57.026484  export SHELL=3D/bin/sh

    2023-12-08T13:45:57.027201  #

    2023-12-08T13:45:57.128585  / # export SHELL=3D/bin/sh. /lava-12219075/=
environment

    2023-12-08T13:45:57.129320  =


    2023-12-08T13:45:57.230760  / # . /lava-12219075/environment/lava-12219=
075/bin/lava-test-runner /lava-12219075/1

    2023-12-08T13:45:57.231709  =


    2023-12-08T13:45:57.248669  / # /lava-12219075/bin/lava-test-runner /la=
va-12219075/1

    2023-12-08T13:45:57.297105  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-08T13:45:57.297612  + cd /lav<8>[   16.365698] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12219075_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
rk3399-gru-kevin   | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chr=
omebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65731d7a6fcf0427e4e13475

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-7-gce575ec88a51a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-7-gce575ec88a51a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/65731d7a6fcf0427e4e1347f
        failing since 269 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-08T13:43:46.428123  /lava-12219107/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/65731d7a6fcf0427e4e13480
        failing since 269 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-08T13:43:44.367394  <8>[   33.275613] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-12-08T13:43:45.390947  /lava-12219107/1/../bin/lava-test-case

    2023-12-08T13:43:45.402825  <8>[   34.311523] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65731c55a1999048dde134e3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-7-gce575ec88a51a/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine=
-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-7-gce575ec88a51a/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine=
-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65731c55a1999048dde134ec
        failing since 15 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-08T13:38:19.900262  <8>[   16.937632] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447099_1.5.2.4.1>
    2023-12-08T13:38:20.005329  / # #
    2023-12-08T13:38:20.107023  export SHELL=3D/bin/sh
    2023-12-08T13:38:20.107606  #
    2023-12-08T13:38:20.208584  / # export SHELL=3D/bin/sh. /lava-447099/en=
vironment
    2023-12-08T13:38:20.209179  =

    2023-12-08T13:38:20.310198  / # . /lava-447099/environment/lava-447099/=
bin/lava-test-runner /lava-447099/1
    2023-12-08T13:38:20.311131  =

    2023-12-08T13:38:20.315603  / # /lava-447099/bin/lava-test-runner /lava=
-447099/1
    2023-12-08T13:38:20.382620  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65731c723324cccbd0e1351c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-7-gce575ec88a51a/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-7-gce575ec88a51a/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65731c723324cccbd0e13525
        failing since 15 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-08T13:46:13.317471  / # #

    2023-12-08T13:46:13.419538  export SHELL=3D/bin/sh

    2023-12-08T13:46:13.420241  #

    2023-12-08T13:46:13.521710  / # export SHELL=3D/bin/sh. /lava-12219069/=
environment

    2023-12-08T13:46:13.522428  =


    2023-12-08T13:46:13.623882  / # . /lava-12219069/environment/lava-12219=
069/bin/lava-test-runner /lava-12219069/1

    2023-12-08T13:46:13.625027  =


    2023-12-08T13:46:13.641734  / # /lava-12219069/bin/lava-test-runner /la=
va-12219069/1

    2023-12-08T13:46:13.700712  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-08T13:46:13.701218  + cd /lava-1221906<8>[   18.180879] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12219069_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

