Return-Path: <stable+bounces-3579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0308C7FFE5D
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 23:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F951C20CBA
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 22:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F270061682;
	Thu, 30 Nov 2023 22:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="d9V87jOB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8A810FA
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 14:13:43 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cfc34b6890so12510285ad.1
        for <stable@vger.kernel.org>; Thu, 30 Nov 2023 14:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701382423; x=1701987223; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zAYed6QJMgM69HyvMrelJaUtnL41xSv9sNgZ19O3b6g=;
        b=d9V87jOB8NzyLtonZOhghCUxqacXsWcuEXDId0430wlXuOBqgcNvlTf+zQMBi6+cBb
         MPkp8Znu3o1Ex3W8QQl6ewj8Wt4ggfJ50iqctCfBpMxusmDeEoOBaZU1phzjv5MfhlpZ
         E0npzjWWauEArBixB4GjZKBM27k+1mX90+f0uoS7CdZlZGDHAvDv52RMxj+e71b/JoPE
         YOJigwSIlGbFymYs5tK6wLV5TnAcm9xdC6WqI59+HJ793+rHG1nM/4m1Yt12NmRkUZow
         AOptVpXhxNPjBSFc/OfRr5xHRE/9aOrXayPYDpA3kXyG+QT1J7PmJBqJTgNUZJNWbvN+
         ul0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701382423; x=1701987223;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zAYed6QJMgM69HyvMrelJaUtnL41xSv9sNgZ19O3b6g=;
        b=CKgq6CI/r22oZDZvQW3PGL/FJJoh8K/lsuB+ovFOlllT7tkcyrM3/p6Yc6V4uww0bq
         uJjh0cAhT80qsZhQCfqe78o4h21Csc/zZwAHJJCP8FGSD6RN3Uu0ZI7TUkO8uLBAOsMr
         rBFEfnrv/T6iNiyr0SqO4T/E+r0W+UVwoHbh2mfPkhzhKGbsq3qbqU6uLXuoovEpeIT6
         Skqx+CChNlSw8maiYkh6ZScu3TVOofvwH3PHPbTB9FtvHeQxmPvl+PWf2nYffRxttQ72
         RJdxjIlzLDGeLnvOIChvMBpFPanypW+FJi8KFOHe9tnR07h7TWuKzoqvb1/2QmmPkj09
         LozQ==
X-Gm-Message-State: AOJu0Yy4jp2dBxRYbkahVUt724RoeeO9iiP1JDsxPtZFFHTIH0feaRIo
	4jQrL1db4B6qxF6QmG2CYDEl9S9b+G9msqxMJ8S0GA==
X-Google-Smtp-Source: AGHT+IHkCncyeKpYmCOMvfUORVj2izJGyOwuJ4mU25yoC4w0znZsMOTO+nxcH/vxDhWtT0IXF61zxQ==
X-Received: by 2002:a17:902:db0d:b0:1cf:cb80:3fa5 with SMTP id m13-20020a170902db0d00b001cfcb803fa5mr23015657plx.23.1701382422804;
        Thu, 30 Nov 2023 14:13:42 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h21-20020a170902f7d500b001cfb84c92dfsm1891325plw.276.2023.11.30.14.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 14:13:42 -0800 (PST)
Message-ID: <65690916.170a0220.1b2cd.632c@mx.google.com>
Date: Thu, 30 Nov 2023 14:13:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.140-69-g6578fee152e7b
Subject: stable-rc/queue/5.15 baseline: 99 runs,
 3 regressions (v5.15.140-69-g6578fee152e7b)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 99 runs, 3 regressions (v5.15.140-69-g6578fe=
e152e7b)

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
nel/v5.15.140-69-g6578fee152e7b/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.140-69-g6578fee152e7b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      6578fee152e7b208be3614569ef7c0b0e95bf592 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6568d401421b08ad097e4a74

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.140=
-69-g6578fee152e7b/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.140=
-69-g6578fee152e7b/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6568d401421b08ad097e4a7d
        failing since 8 days (last pass: v5.15.114-13-g095e387c3889, first =
fail: v5.15.139-172-gb60494a37c0c)

    2023-11-30T18:33:23.564219  / # #

    2023-11-30T18:33:23.664701  export SHELL=3D/bin/sh

    2023-11-30T18:33:23.664875  #

    2023-11-30T18:33:23.765317  / # export SHELL=3D/bin/sh. /lava-12138981/=
environment

    2023-11-30T18:33:23.765488  =


    2023-11-30T18:33:23.865942  / # . /lava-12138981/environment/lava-12138=
981/bin/lava-test-runner /lava-12138981/1

    2023-11-30T18:33:23.866184  =


    2023-11-30T18:33:23.878131  / # /lava-12138981/bin/lava-test-runner /la=
va-12138981/1

    2023-11-30T18:33:23.931480  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-30T18:33:23.931551  + cd /lav<8>[   15.900515] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12138981_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6568d3eb72b12f70c47e4aec

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.140=
-69-g6578fee152e7b/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.140=
-69-g6578fee152e7b/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6568d3eb72b12f70c47e4af5
        failing since 8 days (last pass: v5.15.105-206-g4548859116b8, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-11-30T18:26:42.816323  <8>[   16.101299] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 445952_1.5.2.4.1>
    2023-11-30T18:26:42.921528  / # #
    2023-11-30T18:26:43.023791  export SHELL=3D/bin/sh
    2023-11-30T18:26:43.024540  #
    2023-11-30T18:26:43.125795  / # export SHELL=3D/bin/sh. /lava-445952/en=
vironment
    2023-11-30T18:26:43.126547  =

    2023-11-30T18:26:43.227810  / # . /lava-445952/environment/lava-445952/=
bin/lava-test-runner /lava-445952/1
    2023-11-30T18:26:43.228805  =

    2023-11-30T18:26:43.231432  / # /lava-445952/bin/lava-test-runner /lava=
-445952/1
    2023-11-30T18:26:43.263553  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6568d415e26c0a9ff07e4a95

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.140=
-69-g6578fee152e7b/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.140=
-69-g6578fee152e7b/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6568d415e26c0a9ff07e4a9e
        failing since 8 days (last pass: v5.15.105-206-g4548859116b8, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-11-30T18:33:42.489906  / # #

    2023-11-30T18:33:42.591838  export SHELL=3D/bin/sh

    2023-11-30T18:33:42.592506  #

    2023-11-30T18:33:42.693899  / # export SHELL=3D/bin/sh. /lava-12138984/=
environment

    2023-11-30T18:33:42.694616  =


    2023-11-30T18:33:42.795972  / # . /lava-12138984/environment/lava-12138=
984/bin/lava-test-runner /lava-12138984/1

    2023-11-30T18:33:42.797105  =


    2023-11-30T18:33:42.798984  / # /lava-12138984/bin/lava-test-runner /la=
va-12138984/1

    2023-11-30T18:33:42.841614  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-30T18:33:42.872952  + cd /lava-1213898<8>[   16.821727] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12138984_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

