Return-Path: <stable+bounces-6877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448648158A9
	for <lists+stable@lfdr.de>; Sat, 16 Dec 2023 11:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58FE91C24A70
	for <lists+stable@lfdr.de>; Sat, 16 Dec 2023 10:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D434E14287;
	Sat, 16 Dec 2023 10:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="sYLGDcf1"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88F614A91
	for <stable@vger.kernel.org>; Sat, 16 Dec 2023 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-35d67870032so10261395ab.2
        for <stable@vger.kernel.org>; Sat, 16 Dec 2023 02:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702723059; x=1703327859; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1up1ii2txLODYdS8YvpzCDB/eQFQ5hSJSPZWhhDXvRI=;
        b=sYLGDcf1TxX3NnK0gTDVB3JwUdgwlaKUuLqS1x65csFDvw3Embvtu+EU0Nfe8xrAka
         dGs6BmUofC5Z4aFfOnPkIvvbEGrml/9xldUCfXpxFXrUh9nwTHz69CjTpXBJj0JljbJM
         5HsgRc8aVLKpP56sHkgnBvx59gs694FsT1xYTlUL0GMtpYFLzUElBBvg+qAIrc9jK5TX
         FQSiPay9F+UoueOE7oSq/2G+M20LB5nVJFtxZvFkPMB6mebyhSk/rwC6i9LeSyDtKxG5
         IcDbp2wqk8c2+tjVxyK1flgw+zdJ+6ZO7XmhM4+LsQJnEsBjBsGjUo95Lsa8KT3G+Z9J
         qVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702723059; x=1703327859;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1up1ii2txLODYdS8YvpzCDB/eQFQ5hSJSPZWhhDXvRI=;
        b=QrwmZiNPq5SycMR5dcdP8ukt0Zz9pSVS3YbicgYH1u/fJ1D+Enqrc/J5GuKbYxtRCi
         uTKS1QoIxZ2DChteW4nxWAEWsn16PrgCGAk26f6dGxIUMgKtKFiOd6QlNGC/Uz4pny8v
         nHyHRXPuYKTw1f0hoaqDHAX+cAW10baok2X8v9SWfEhefa4iRULgcMAxxmlZwxCy0xst
         VwVCsXs0+9mO+zhDZYF4XkNPctIJIe8xMfQVjmpzaRVxghE3AJXBC52KfzmvPm0CicuW
         0ROJ9a0fVavzqDi9+qCGIZJsm2zz/KnGVlVLueHFyp1ZTxN2Lbh5Xaty2RHLaRT2me81
         6Ysg==
X-Gm-Message-State: AOJu0YxMQL5NvwqCC+SatV+x4WX4bese3lRP9jMqNWVqlqr1dzcIbylS
	uHut0QN7LUy9dB30hd+eKo5zIi49XEf7tFTeJtc=
X-Google-Smtp-Source: AGHT+IEn0pf4n+ld1tQe58VVSQ4I3pihsJ71PtJBGP4RVLofTKStTDkO/Glf6Jvig4YahGPQmlPtOw==
X-Received: by 2002:a05:6e02:18cc:b0:35d:a75b:6109 with SMTP id s12-20020a056e0218cc00b0035da75b6109mr19623747ilu.43.1702723059412;
        Sat, 16 Dec 2023 02:37:39 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g13-20020a170902d5cd00b001d1d6f6b67dsm15666494plh.147.2023.12.16.02.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 02:37:33 -0800 (PST)
Message-ID: <657d7ded.170a0220.e41cb.07ea@mx.google.com>
Date: Sat, 16 Dec 2023 02:37:33 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.204-33-g1ff0e69a5e9be
Subject: stable-rc/queue/5.10 baseline: 91 runs,
 4 regressions (v5.10.204-33-g1ff0e69a5e9be)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 91 runs, 4 regressions (v5.10.204-33-g1ff0e6=
9a5e9be)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beaglebone-black   | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig=
 | 1          =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
 | 1          =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.204-33-g1ff0e69a5e9be/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.204-33-g1ff0e69a5e9be
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      1ff0e69a5e9bee56f32bbbbec8c916c63579f7a6 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beaglebone-black   | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657d46b521d9596268e1347c

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-33-g1ff0e69a5e9be/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-33-g1ff0e69a5e9be/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657d46b521d9596268e134b4
        failing since 305 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-16T06:41:40.353459  <8>[   20.292115] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 361539_1.5.2.4.1>
    2023-12-16T06:41:40.461775  / # #
    2023-12-16T06:41:40.563431  export SHELL=3D/bin/sh
    2023-12-16T06:41:40.563904  #
    2023-12-16T06:41:40.665124  / # export SHELL=3D/bin/sh. /lava-361539/en=
vironment
    2023-12-16T06:41:40.665466  =

    2023-12-16T06:41:40.766740  / # . /lava-361539/environment/lava-361539/=
bin/lava-test-runner /lava-361539/1
    2023-12-16T06:41:40.767334  =

    2023-12-16T06:41:40.771773  / # /lava-361539/bin/lava-test-runner /lava=
-361539/1
    2023-12-16T06:41:40.873624  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657d57a9b0ad4f7b0fe134ad

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-33-g1ff0e69a5e9be/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-33-g1ff0e69a5e9be/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657d57a9b0ad4f7b0fe134b6
        failing since 23 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-16T08:01:29.881141  / # #

    2023-12-16T08:01:29.983227  export SHELL=3D/bin/sh

    2023-12-16T08:01:29.983986  #

    2023-12-16T08:01:30.085467  / # export SHELL=3D/bin/sh. /lava-12285702/=
environment

    2023-12-16T08:01:30.086212  =


    2023-12-16T08:01:30.187680  / # . /lava-12285702/environment/lava-12285=
702/bin/lava-test-runner /lava-12285702/1

    2023-12-16T08:01:30.188850  =


    2023-12-16T08:01:30.205914  / # /lava-12285702/bin/lava-test-runner /la=
va-12285702/1

    2023-12-16T08:01:30.254267  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-16T08:01:30.254793  + cd /lav<8>[   16.378274] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12285702_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657d483e4ffe8128c8e13506

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-33-g1ff0e69a5e9be/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-33-g1ff0e69a5e9be/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657d483e4ffe8128c8e1350f
        failing since 23 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-16T06:48:20.702151  <8>[   16.957879] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 448348_1.5.2.4.1>
    2023-12-16T06:48:20.807182  / # #
    2023-12-16T06:48:20.908800  export SHELL=3D/bin/sh
    2023-12-16T06:48:20.909387  #
    2023-12-16T06:48:21.010402  / # export SHELL=3D/bin/sh. /lava-448348/en=
vironment
    2023-12-16T06:48:21.011039  =

    2023-12-16T06:48:21.112020  / # . /lava-448348/environment/lava-448348/=
bin/lava-test-runner /lava-448348/1
    2023-12-16T06:48:21.112940  =

    2023-12-16T06:48:21.117527  / # /lava-448348/bin/lava-test-runner /lava=
-448348/1
    2023-12-16T06:48:21.183636  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657d48593477c646a8e134a6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-33-g1ff0e69a5e9be/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-33-g1ff0e69a5e9be/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657d48593477c646a8e134af
        failing since 23 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-16T06:56:17.923241  / # #

    2023-12-16T06:56:18.023845  export SHELL=3D/bin/sh

    2023-12-16T06:56:18.023965  #

    2023-12-16T06:56:18.124388  / # export SHELL=3D/bin/sh. /lava-12285691/=
environment

    2023-12-16T06:56:18.124483  =


    2023-12-16T06:56:18.224901  / # . /lava-12285691/environment/lava-12285=
691/bin/lava-test-runner /lava-12285691/1

    2023-12-16T06:56:18.225098  =


    2023-12-16T06:56:18.231463  / # /lava-12285691/bin/lava-test-runner /la=
va-12285691/1

    2023-12-16T06:56:18.296539  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-16T06:56:18.296622  + cd /lava-1228569<8>[   18.173055] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12285691_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

