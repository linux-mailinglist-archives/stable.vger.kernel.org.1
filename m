Return-Path: <stable+bounces-5010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8C780A25D
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 12:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB0E8B209E6
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 11:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A66A1B28E;
	Fri,  8 Dec 2023 11:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="XrG5vAo4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E2A10F9
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 03:36:39 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d04dba2781so16230935ad.3
        for <stable@vger.kernel.org>; Fri, 08 Dec 2023 03:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702035398; x=1702640198; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gVfAj5zpfK7kPFDZzWRC6QvZLM42Xo2Me8dlweEqfQs=;
        b=XrG5vAo4DYy0gnm1fDb6bngx+OFZIjfM35bxYED3Ln7T8q3tbInSyViXyoaMYYMMXB
         qChX0z11qbVwus6sWH9kSLf4u5PRHR9iU7stAazOld9HZiA24EWZHL3jso/fzoOygG/r
         aSidepNqVdp8qMYEGH0anRof7P2VZ3a0gyFmEB83TtW90F7iwEN6CU6TL9FChZPJqS7G
         rho+Sj3XR8rW66UtaNyaXUPHhzmHmy3NNPFWVqCIrMfZVdTahefQZvQFeoQ79FM+4d96
         nPHhvmNaUXvfKRe+WNHcImQCpfQbmJjsHqr/cAbAfIf7hjtL40YbE+zO4JejN+VAWLs1
         gZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702035398; x=1702640198;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gVfAj5zpfK7kPFDZzWRC6QvZLM42Xo2Me8dlweEqfQs=;
        b=UMC6Jekc2HtvKaxjIRXJbXM5A1yJu7PH1y08ffqFdVORAM/R5GMWo1QjhSKrpEqVsC
         MGwDQ7gpDf+nqv0zk0FhuXF8vtYIy5OhtlnqG09qu/Ca2OM5ON/im8arYbbiOszElP+t
         4+h/L0U7aO113nOVOEjxqjz6+cs2K/D8wSxwJbzT6gFcZODLUF6U1+Ur/z4aPhQpEWjE
         o3rKfniPFWmJmpc726VMynBlv5Bi3WJKl+9g+ugRX1YBPfNAogZtQU4iP5OwKJcY7Yqz
         +eiLhVGrqDW4TIkCs0H5jG0h9sqB+oFmtakAZQUSG7NqAVYuLXrG0KTESaRjF0AJlnoG
         SLrg==
X-Gm-Message-State: AOJu0YzcXw9zfqG/20/yoHXRDTJ2jVRfkqMd6aw6Oq1qay4vMS1dAGlW
	UXtkMHbtxFb6KFymXlrTXdskH7C5OjGw6uE/vbyt6w==
X-Google-Smtp-Source: AGHT+IECyEuL5uzBQKy36xim4OMJ3X/m5vN/qV925Z0SRqCL4qAuf0VIIkBC3zRVnUcRQ0FtlcutJQ==
X-Received: by 2002:a17:902:e802:b0:1d0:94ed:f843 with SMTP id u2-20020a170902e80200b001d094edf843mr4261491plg.17.1702035398070;
        Fri, 08 Dec 2023 03:36:38 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001cfd0ed1604sm1519768pln.87.2023.12.08.03.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 03:36:37 -0800 (PST)
Message-ID: <6572ffc5.170a0220.21a69.438d@mx.google.com>
Date: Fri, 08 Dec 2023 03:36:37 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.141-64-gc23889a753891
Subject: stable-rc/queue/5.15 baseline: 150 runs,
 5 regressions (v5.15.141-64-gc23889a753891)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 150 runs, 5 regressions (v5.15.141-64-gc2388=
9a753891)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beagle-xm          | arm   | lab-baylibre  | gcc-10   | omap2plus_defconfig=
 | 1          =

panda              | arm   | lab-baylibre  | gcc-10   | multi_v7_defconfig =
 | 1          =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
 | 1          =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.141-64-gc23889a753891/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.141-64-gc23889a753891
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      c23889a753891dcac6a2b7065773f0973169d753 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beagle-xm          | arm   | lab-baylibre  | gcc-10   | omap2plus_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6572cd42c84d33c57be13498

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-64-gc23889a753891/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-64-gc23889a753891/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6572cd42c84d33c57be13=
499
        failing since 307 days (last pass: v5.15.91-12-g3290f78df1ab, first=
 fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
panda              | arm   | lab-baylibre  | gcc-10   | multi_v7_defconfig =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6572cce32fc18d3b7de134c0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-64-gc23889a753891/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pand=
a.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-64-gc23889a753891/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pand=
a.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6572cce32fc18d3b7de134c9
        failing since 1 day (last pass: v5.15.74-135-g19e8e8e20e2b, first f=
ail: v5.15.141-64-g41591b7f348c5)

    2023-12-08T07:59:08.550519  <8>[   11.766845] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3865780_1.5.2.4.1>
    2023-12-08T07:59:08.656244  / #
    2023-12-08T07:59:08.758161  # #export SHELL=3D/bin/sh
    2023-12-08T07:59:08.758661  =

    2023-12-08T07:59:08.859547  / # export SHELL=3D/bin/sh. /lava-3865780/e=
nvironment
    2023-12-08T07:59:08.860200  =

    2023-12-08T07:59:08.961205  / # . /lava-3865780/environment/lava-386578=
0/bin/lava-test-runner /lava-3865780/1
    2023-12-08T07:59:08.962120  =

    2023-12-08T07:59:08.967135  / # /lava-3865780/bin/lava-test-runner /lav=
a-3865780/1
    2023-12-08T07:59:09.030174  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6572cdf57e9d7c0f1ce13475

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-64-gc23889a753891/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-64-gc23889a753891/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6572cdf57e9d7c0f1ce1347e
        failing since 15 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-08T08:11:18.240201  / # #

    2023-12-08T08:11:18.342373  export SHELL=3D/bin/sh

    2023-12-08T08:11:18.343086  #

    2023-12-08T08:11:18.444501  / # export SHELL=3D/bin/sh. /lava-12214483/=
environment

    2023-12-08T08:11:18.445223  =


    2023-12-08T08:11:18.546679  / # . /lava-12214483/environment/lava-12214=
483/bin/lava-test-runner /lava-12214483/1

    2023-12-08T08:11:18.547769  =


    2023-12-08T08:11:18.564769  / # /lava-12214483/bin/lava-test-runner /la=
va-12214483/1

    2023-12-08T08:11:18.613974  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-08T08:11:18.614487  + cd /lav<8>[   16.054464] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12214483_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6572ca5a2d5a919eefe1351d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-64-gc23889a753891/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-64-gc23889a753891/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6572ca5a2d5a919eefe13526
        failing since 15 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-08T07:48:33.645693  <8>[   16.173393] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447009_1.5.2.4.1>
    2023-12-08T07:48:33.750624  / # #
    2023-12-08T07:48:33.852254  export SHELL=3D/bin/sh
    2023-12-08T07:48:33.852815  #
    2023-12-08T07:48:33.953831  / # export SHELL=3D/bin/sh. /lava-447009/en=
vironment
    2023-12-08T07:48:33.954428  =

    2023-12-08T07:48:34.055440  / # . /lava-447009/environment/lava-447009/=
bin/lava-test-runner /lava-447009/1
    2023-12-08T07:48:34.056357  =

    2023-12-08T07:48:34.061056  / # /lava-447009/bin/lava-test-runner /lava=
-447009/1
    2023-12-08T07:48:34.129072  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6572ca726381fd7a37e1348c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-64-gc23889a753891/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-64-gc23889a753891/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6572ca726381fd7a37e13495
        failing since 15 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-08T07:56:26.571917  / # #

    2023-12-08T07:56:26.672749  export SHELL=3D/bin/sh

    2023-12-08T07:56:26.673143  #

    2023-12-08T07:56:26.774186  / # export SHELL=3D/bin/sh. /lava-12214476/=
environment

    2023-12-08T07:56:26.774904  =


    2023-12-08T07:56:26.876346  / # . /lava-12214476/environment/lava-12214=
476/bin/lava-test-runner /lava-12214476/1

    2023-12-08T07:56:26.877348  =


    2023-12-08T07:56:26.885532  / # /lava-12214476/bin/lava-test-runner /la=
va-12214476/1

    2023-12-08T07:56:26.950502  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-08T07:56:26.950997  + cd /lava-1221447<8>[   16.774200] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12214476_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

