Return-Path: <stable+bounces-8294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9479581C3C6
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 05:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C0528743D
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 04:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609EC1C06;
	Fri, 22 Dec 2023 04:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="xXNDXwAB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513978F49
	for <stable@vger.kernel.org>; Fri, 22 Dec 2023 04:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6d9338bc11fso1397550b3a.1
        for <stable@vger.kernel.org>; Thu, 21 Dec 2023 20:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703218545; x=1703823345; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ulLwKQKRnzsmDUe5R5h/ISTG2ybM+GAgmMEGQDMsj6o=;
        b=xXNDXwAB/LrxbvUlTGXQmkRc85HlmGI0x6EU9zgfJoOeeyqAM46OTrIcm6UQmrVEi2
         /7mZv+FFnzgAiQV08TtLU4KEhRzM3jbVzGm91T6DM8wD5TxuGNP7wiJz7ulsrtdnQjJx
         6/eCp21836ZZhDqaKxxgknz5RTTg++RYer3sW92J7ClDbo/ymgD7dKZUwPY5CbGYsSlw
         qQ/cV6VnzSOaYtwwWkYNYsREZozHlzTqrT2NhfN12YDKXocYg3JS3amtrgQxV33/G2Jm
         3BkbyXM8CkD2cmWOe72g1YE4iM4tI7pQi/cov71w3mWLQa9IWIA+kqrBEognKyPNINbi
         xDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703218545; x=1703823345;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ulLwKQKRnzsmDUe5R5h/ISTG2ybM+GAgmMEGQDMsj6o=;
        b=vMAiMc/6kzbXubjVFiV/965mDkhcFm8zCWpX/5h9+KAGFQEjuIZoFMuuY7ZRRcijRw
         IXp5y48Z0h5sdDpYxlDDTjS2FkhAeTsrYm2hrb8/aw4qO/QFBgJ3Uw4sjGIWSNQE7awE
         rRD4a2ukIe2x/cI2nkW7vtR98seoXZqcoO8Xvjyt4Z8gEwihjQSaK95QnLSPEnHNuSM2
         FP6VZ68WVcvf9gCoM5ewN4LDZ83+204DH6o0v4PJY0Z2mBBZiD7AmCN3V2SKxg6PGcLq
         7ZsFUlRadt0C48Gq0lIM/iYgT/lcrJyl8TmKW2guq23NSmgbWMu/aokviYP6OlrCt44j
         FVJQ==
X-Gm-Message-State: AOJu0YwUcCtn6cMp2SundnVw2fHBnC4rEdx40KUI8sPdGg4qluhsiyWZ
	awa4qObUFJSG/zVV+HYpVx5mnqiuY68yxrdahAIKfqQtuNI=
X-Google-Smtp-Source: AGHT+IGNFFEmjtwBMWBFUz0uBzlMBoQnzS7PSnA7f6G7Bl6LOemv1u5S8qQoqU2IAOFrTXM6CtI7yw==
X-Received: by 2002:a05:6a20:6d16:b0:190:50ec:e2e4 with SMTP id fv22-20020a056a206d1600b0019050ece2e4mr743300pzb.45.1703218545110;
        Thu, 21 Dec 2023 20:15:45 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jb2-20020a170903258200b001cf6783fd41sm2455372plb.17.2023.12.21.20.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 20:15:44 -0800 (PST)
Message-ID: <65850d70.170a0220.5e5a8.83d2@mx.google.com>
Date: Thu, 21 Dec 2023 20:15:44 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.204-63-g5105b172a5e05
Subject: stable-rc/queue/5.10 baseline: 99 runs,
 7 regressions (v5.10.204-63-g5105b172a5e05)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 99 runs, 7 regressions (v5.10.204-63-g5105b1=
72a5e05)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
acer-R721T-grunt   | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig+x=
86-board | 1          =

beaglebone-black   | arm    | lab-broonie   | gcc-10   | omap2plus_defconfi=
g        | 1          =

r8a77960-ulcb      | arm64  | lab-collabora | gcc-10   | defconfig         =
         | 1          =

rk3399-gru-kevin   | arm64  | lab-collabora | gcc-10   | defconfig+arm64-ch=
romebook | 2          =

sun50i-h6-pine-h64 | arm64  | lab-clabbe    | gcc-10   | defconfig         =
         | 1          =

sun50i-h6-pine-h64 | arm64  | lab-collabora | gcc-10   | defconfig         =
         | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.204-63-g5105b172a5e05/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.204-63-g5105b172a5e05
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      5105b172a5e05ddaa2cc9e7489e5a755b94256de =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
acer-R721T-grunt   | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig+x=
86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/6584d938d977574d6ee135a7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-63-g5105b172a5e05/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/b=
aseline-acer-R721T-grunt.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-63-g5105b172a5e05/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/b=
aseline-acer-R721T-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6584d938d977574d6ee13=
5a8
        new failure (last pass: v5.10.204-60-gbd6aa237ba9cb) =

 =



platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
beaglebone-black   | arm    | lab-broonie   | gcc-10   | omap2plus_defconfi=
g        | 1          =


  Details:     https://kernelci.org/test/plan/id/6584d987198988900be13615

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-63-g5105b172a5e05/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-63-g5105b172a5e05/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6584d987198988900be1364a
        failing since 311 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-22T00:34:00.634141  <8>[   20.629202] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 383333_1.5.2.4.1>
    2023-12-22T00:34:00.742830  / # #
    2023-12-22T00:34:00.845135  export SHELL=3D/bin/sh
    2023-12-22T00:34:00.845759  #
    2023-12-22T00:34:00.947818  / # export SHELL=3D/bin/sh. /lava-383333/en=
vironment
    2023-12-22T00:34:00.948319  =

    2023-12-22T00:34:01.049702  / # . /lava-383333/environment/lava-383333/=
bin/lava-test-runner /lava-383333/1
    2023-12-22T00:34:01.050448  =

    2023-12-22T00:34:01.054374  / # /lava-383333/bin/lava-test-runner /lava=
-383333/1
    2023-12-22T00:34:01.161199  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
r8a77960-ulcb      | arm64  | lab-collabora | gcc-10   | defconfig         =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/6584da25573bf75a55e134f9

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-63-g5105b172a5e05/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-63-g5105b172a5e05/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6584da25573bf75a55e134fe
        failing since 29 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-22T00:44:17.536743  / # #

    2023-12-22T00:44:17.638851  export SHELL=3D/bin/sh

    2023-12-22T00:44:17.639626  #

    2023-12-22T00:44:17.741044  / # export SHELL=3D/bin/sh. /lava-12345030/=
environment

    2023-12-22T00:44:17.741798  =


    2023-12-22T00:44:17.843260  / # . /lava-12345030/environment/lava-12345=
030/bin/lava-test-runner /lava-12345030/1

    2023-12-22T00:44:17.844458  =


    2023-12-22T00:44:17.860799  / # /lava-12345030/bin/lava-test-runner /la=
va-12345030/1

    2023-12-22T00:44:17.909911  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-22T00:44:17.910420  + cd /lav<8>[   16.451451] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12345030_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
rk3399-gru-kevin   | arm64  | lab-collabora | gcc-10   | defconfig+arm64-ch=
romebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6584dad8d30dbce769e1356f

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-63-g5105b172a5e05/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-63-g5105b172a5e05/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6584dad8d30dbce769e13575
        failing since 282 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-22T00:40:06.821490  /lava-12345078/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6584dad8d30dbce769e13576
        failing since 282 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-22T00:40:04.759656  <8>[   33.190670] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-12-22T00:40:05.785229  /lava-12345078/1/../bin/lava-test-case

    2023-12-22T00:40:05.796412  <8>[   34.228089] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
sun50i-h6-pine-h64 | arm64  | lab-clabbe    | gcc-10   | defconfig         =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/6584da10c88ebdd67ce13484

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-63-g5105b172a5e05/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-63-g5105b172a5e05/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6584da10c88ebdd67ce13489
        failing since 29 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-22T00:36:22.320809  <8>[   17.005724] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 449354_1.5.2.4.1>
    2023-12-22T00:36:22.425745  / # #
    2023-12-22T00:36:22.527286  export SHELL=3D/bin/sh
    2023-12-22T00:36:22.527895  #
    2023-12-22T00:36:22.628868  / # export SHELL=3D/bin/sh. /lava-449354/en=
vironment
    2023-12-22T00:36:22.629473  =

    2023-12-22T00:36:22.730480  / # . /lava-449354/environment/lava-449354/=
bin/lava-test-runner /lava-449354/1
    2023-12-22T00:36:22.731309  =

    2023-12-22T00:36:22.736017  / # /lava-449354/bin/lava-test-runner /lava=
-449354/1
    2023-12-22T00:36:22.802065  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
sun50i-h6-pine-h64 | arm64  | lab-collabora | gcc-10   | defconfig         =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/6584da3a9a92ba8811e134d1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-63-g5105b172a5e05/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-63-g5105b172a5e05/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6584da3a9a92ba8811e134d6
        failing since 29 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-22T00:44:31.327088  / # #

    2023-12-22T00:44:31.429238  export SHELL=3D/bin/sh

    2023-12-22T00:44:31.429935  #

    2023-12-22T00:44:31.531317  / # export SHELL=3D/bin/sh. /lava-12345041/=
environment

    2023-12-22T00:44:31.532011  =


    2023-12-22T00:44:31.633475  / # . /lava-12345041/environment/lava-12345=
041/bin/lava-test-runner /lava-12345041/1

    2023-12-22T00:44:31.634537  =


    2023-12-22T00:44:31.651443  / # /lava-12345041/bin/lava-test-runner /la=
va-12345041/1

    2023-12-22T00:44:31.692924  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-22T00:44:31.710493  + cd /lava-1234504<8>[   18.169780] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12345041_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

