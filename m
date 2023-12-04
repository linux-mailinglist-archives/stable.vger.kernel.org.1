Return-Path: <stable+bounces-3832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE52802AA7
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 05:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A2A1F20F6D
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 04:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75794435;
	Mon,  4 Dec 2023 04:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="gNfJcCLH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828FED5
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 20:01:32 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so1196211a12.0
        for <stable@vger.kernel.org>; Sun, 03 Dec 2023 20:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701662491; x=1702267291; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XFuqsbQyNwcGaK2sz41M2O/yt4+nAFb+ijpLoDN6xkc=;
        b=gNfJcCLHctkufN1FhCfLjca1uZdO9IH4NcyrKlf5p4vGo0gZuXS8vRl7d+J27i8ZYh
         nS/q3J/4f24rN0G6v1HRaFOHxWz+fMliC8HRuPyjmzu+IU3SqnEJa80Pnb74bONcl//d
         MDpOkNmVvTlDWJQ8mHMg+bdxkg3aGbEP3ostD6fL/6IA2vCwcGRZyzB0/+uPk985ncfe
         giFO4PrlAMLKAU+C0fsHuKb9JhekRkY7tfuM2p6QRtzLHeNsF9eXImGa9+ORBUb1Q9GS
         RdIrOy2uFntsl/CcnyyC9wI2textW72NGkYusQlR5/Jm4p5KuU4Bh8a2NVuos9llJ6XV
         eZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701662491; x=1702267291;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XFuqsbQyNwcGaK2sz41M2O/yt4+nAFb+ijpLoDN6xkc=;
        b=vJXXFFR4aA3J/c+UeYQXeJMN/4TeV9VzVoWx0+LrjQwksad6PeiwOjV+b55PIG/mi/
         OC4zFx9Fx4cg/T0P0QboZhFqDKJFzlmiNds2iH8Ircx3WKbpkEEETCJ2Qccb1IgCwsIN
         0gnnr7mZoPSDlsE455NvTcYwGPXcYZvalCUXbFmZ/PJESvZlNNm9rRblu7xyBrNlZqqG
         vgEfaHUmZzHhKWtUc+7xrZ4eFMOHQlYsbbxV/3RT8ADL+PNFvxvFKx9YHG51BCdkyYi4
         a5bLoaXkTneRAHeHpzb63Sj1Oip/xAZSELjIgPbj9ipwHDRGgBvKqYMs4T+nOOsT9CP8
         Xgnw==
X-Gm-Message-State: AOJu0YwmzFLsKzHxqyDnt4GmTeRJtFzUuagD8qxkIgkFF2oH5eeaAkLX
	rajEI/++9ohbBDRkYiRn7z4BHP8w7T4BBbPH6b4m8g==
X-Google-Smtp-Source: AGHT+IGh196s8605HXsk/6HJNx7awi6LOjVOyajVdB+TxeoR+/BdfRSm48PltiL5xd8196E40QV3wg==
X-Received: by 2002:a05:6a20:8412:b0:18f:1274:efa7 with SMTP id c18-20020a056a20841200b0018f1274efa7mr1974332pzd.113.1701662491518;
        Sun, 03 Dec 2023 20:01:31 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b12-20020a170902bd4c00b001cf69c8ef8asm4092191plx.95.2023.12.03.20.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 20:01:31 -0800 (PST)
Message-ID: <656d4f1b.170a0220.cf709.a393@mx.google.com>
Date: Sun, 03 Dec 2023 20:01:31 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.141-66-gec1ddec22d5c4
Subject: stable-rc/queue/5.15 baseline: 138 runs,
 3 regressions (v5.15.141-66-gec1ddec22d5c4)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 138 runs, 3 regressions (v5.15.141-66-gec1dd=
ec22d5c4)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.141-66-gec1ddec22d5c4/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.141-66-gec1ddec22d5c4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      ec1ddec22d5c4980bfdbbd0325ecc9fa1a899fed =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656d1d57fd15086dc8e134b1

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-66-gec1ddec22d5c4/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-66-gec1ddec22d5c4/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656d1d57fd15086dc8e134ba
        failing since 11 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-04T00:35:21.583669  / # #

    2023-12-04T00:35:21.685869  export SHELL=3D/bin/sh

    2023-12-04T00:35:21.686617  #

    2023-12-04T00:35:21.788079  / # export SHELL=3D/bin/sh. /lava-12173443/=
environment

    2023-12-04T00:35:21.788829  =


    2023-12-04T00:35:21.890217  / # . /lava-12173443/environment/lava-12173=
443/bin/lava-test-runner /lava-12173443/1

    2023-12-04T00:35:21.890542  =


    2023-12-04T00:35:21.907340  / # /lava-12173443/bin/lava-test-runner /la=
va-12173443/1

    2023-12-04T00:35:21.956309  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-04T00:35:21.956425  + cd /lav<8>[   16.010874] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12173443_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656d1d42fd15086dc8e1347d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-66-gec1ddec22d5c4/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-66-gec1ddec22d5c4/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656d1d42fd15086dc8e13486
        failing since 11 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-04T00:28:41.258432  <8>[   16.189618] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 446451_1.5.2.4.1>
    2023-12-04T00:28:41.363475  / # #
    2023-12-04T00:28:41.465116  export SHELL=3D/bin/sh
    2023-12-04T00:28:41.465694  #
    2023-12-04T00:28:41.566721  / # export SHELL=3D/bin/sh. /lava-446451/en=
vironment
    2023-12-04T00:28:41.567385  =

    2023-12-04T00:28:41.668411  / # . /lava-446451/environment/lava-446451/=
bin/lava-test-runner /lava-446451/1
    2023-12-04T00:28:41.669300  =

    2023-12-04T00:28:41.673599  / # /lava-446451/bin/lava-test-runner /lava=
-446451/1
    2023-12-04T00:28:41.705828  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656d1d6bf87cd470efe13479

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-66-gec1ddec22d5c4/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-66-gec1ddec22d5c4/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656d1d6bf87cd470efe13482
        failing since 11 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-04T00:35:37.449879  / # #

    2023-12-04T00:35:37.551821  export SHELL=3D/bin/sh

    2023-12-04T00:35:37.552530  #

    2023-12-04T00:35:37.654085  / # export SHELL=3D/bin/sh. /lava-12173457/=
environment

    2023-12-04T00:35:37.654786  =


    2023-12-04T00:35:37.756213  / # . /lava-12173457/environment/lava-12173=
457/bin/lava-test-runner /lava-12173457/1

    2023-12-04T00:35:37.757339  =


    2023-12-04T00:35:37.758631  / # /lava-12173457/bin/lava-test-runner /la=
va-12173457/1

    2023-12-04T00:35:37.832730  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-04T00:35:37.833277  + cd /lava-1217345<8>[   16.820260] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12173457_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

