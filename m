Return-Path: <stable+bounces-5247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1959380C15A
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 07:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF191F20EFE
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 06:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21021BDD6;
	Mon, 11 Dec 2023 06:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="GxKeENS9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A9BE9
	for <stable@vger.kernel.org>; Sun, 10 Dec 2023 22:31:41 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cfabcbda7bso37884055ad.0
        for <stable@vger.kernel.org>; Sun, 10 Dec 2023 22:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702276300; x=1702881100; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tDSu8NOCH1wDp7SPMsiotZfji4uaB+BfihUzOFeBMtA=;
        b=GxKeENS9zQ6EPuY0TzzJhQ8OH/9KTKlb+NzPyZDov1qUj0qHmBdnbUPTjihH8jn8yd
         xQovzZipWsubGEUBriWsB4UG/sF5Fngeac1TFFLipgKSuNx64DY6mg57NfCcexJH97N2
         1fSMaj+2OKnlSLHcZLsNxVBBtluqebgQhkNVTCXoPH4AhdpZ8hhpcKsN4upM1a6nvCzQ
         Wd5/gKEKRwSCVu+0rqNu6CPRSTxFaGBhdeMfbMpNYsLzdAwS6gtg43JgetqMGCgUzJD6
         VB2WOCf/MX3zdBVOc6OOtmcQ0UvlujjLH7IW8fMbLAnT5Z5R6HfQY4TaQKjzusPjV/hz
         aZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702276300; x=1702881100;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDSu8NOCH1wDp7SPMsiotZfji4uaB+BfihUzOFeBMtA=;
        b=ZxgRVM06dSXeymCK3eboxM1AF1L6g5aZkEIbwZ2CFs6G8FlbBqgIB9t/N8CflQcLpn
         RKd8DupKz6ye/NtE3tv7pXBcXsCtq0l3arGHva5sdtxkyYWBnAJVI8OpiNJ50eShRiis
         kovRhBXkZycI/Rxo4ssSiw/ETiE7GjQDvG/FGfd0oVwdLJKkkZwDID58/uSB3t54yMxi
         CclKe46BS8KvTkN2APjX72Io2mhAB9bSto6LPdHG8bGlPF0GFdYlgusp6BfpFk82/Ub0
         nGr/77t2sRuo6aUDWbNesU7IRy1dRi+1DKWcK7diOWZds7lOOzh7spZwCtxbzh1qOnhr
         eaIQ==
X-Gm-Message-State: AOJu0YxomnRuxXhDrQV5IFq+axW3NIfw6eSvXXWT940VsQDP+aTpvwAX
	Fbwx6R/BFHab/OFRLBLsGkObQeEt7TDPyUE7Fh0cHQ==
X-Google-Smtp-Source: AGHT+IF90Erj5QaQXd/5EsOx02rErQW/klwDa8DT/SXGddYoe0s5CfaoSBZxLqrKAtJfKvZbKv+Rpw==
X-Received: by 2002:a17:902:a3cd:b0:1d0:9675:7ae5 with SMTP id q13-20020a170902a3cd00b001d096757ae5mr3462854plb.11.1702276300143;
        Sun, 10 Dec 2023 22:31:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902c08300b001bf52834696sm5771487pld.207.2023.12.10.22.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 22:31:39 -0800 (PST)
Message-ID: <6576accb.170a0220.48e5a.fe29@mx.google.com>
Date: Sun, 10 Dec 2023 22:31:39 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.142-111-gec7ac8d402eb1
Subject: stable-rc/queue/5.15 baseline: 133 runs,
 6 regressions (v5.15.142-111-gec7ac8d402eb1)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 133 runs, 6 regressions (v5.15.142-111-gec7a=
c8d402eb1)

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

rk3288-veyron-jaq  | arm   | lab-collabora | gcc-10   | multi_v7_defconfig =
 | 1          =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
 | 1          =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.142-111-gec7ac8d402eb1/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.142-111-gec7ac8d402eb1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      ec7ac8d402eb18ec99f59a94dba42ddaed0782e9 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beagle-xm          | arm   | lab-baylibre  | gcc-10   | omap2plus_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65767c95c30162d763e1348b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-111-gec7ac8d402eb1/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-111-gec7ac8d402eb1/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65767c95c30162d763e13=
48c
        failing since 310 days (last pass: v5.15.91-12-g3290f78df1ab, first=
 fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
panda              | arm   | lab-baylibre  | gcc-10   | multi_v7_defconfig =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65767c39973407f51ae13487

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-111-gec7ac8d402eb1/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pan=
da.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-111-gec7ac8d402eb1/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pan=
da.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65767c39973407f51ae1348c
        failing since 4 days (last pass: v5.15.74-135-g19e8e8e20e2b, first =
fail: v5.15.141-64-g41591b7f348c5)

    2023-12-11T03:04:02.183546  + <8>[   11.795288] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 3874641_1.5.2.4.1>
    2023-12-11T03:04:02.183755  set +x
    2023-12-11T03:04:02.288148  / # #
    2023-12-11T03:04:02.389202  export SHELL=3D/bin/sh
    2023-12-11T03:04:02.389527  #
    2023-12-11T03:04:02.490268  / # export SHELL=3D/bin/sh. /lava-3874641/e=
nvironment
    2023-12-11T03:04:02.490604  =

    2023-12-11T03:04:02.591343  / # . /lava-3874641/environment/lava-387464=
1/bin/lava-test-runner /lava-3874641/1
    2023-12-11T03:04:02.591875  =

    2023-12-11T03:04:02.597152  / # /lava-3874641/bin/lava-test-runner /lav=
a-3874641/1 =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65767b1b7aa07d3a15e1347d

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-111-gec7ac8d402eb1/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-111-gec7ac8d402eb1/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65767b1b7aa07d3a15e13482
        failing since 18 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-11T03:07:09.201421  / # #

    2023-12-11T03:07:09.302069  export SHELL=3D/bin/sh

    2023-12-11T03:07:09.302722  #

    2023-12-11T03:07:09.403743  / # export SHELL=3D/bin/sh. /lava-12240085/=
environment

    2023-12-11T03:07:09.403942  =


    2023-12-11T03:07:09.504392  / # . /lava-12240085/environment/lava-12240=
085/bin/lava-test-runner /lava-12240085/1

    2023-12-11T03:07:09.504576  =


    2023-12-11T03:07:09.515151  / # /lava-12240085/bin/lava-test-runner /la=
va-12240085/1

    2023-12-11T03:07:09.556393  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-11T03:07:09.574339  + cd /lav<8>[   15.922352] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12240085_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
rk3288-veyron-jaq  | arm   | lab-collabora | gcc-10   | multi_v7_defconfig =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65767bcf634c1eb2e0e13549

  Results:     65 PASS, 5 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-111-gec7ac8d402eb1/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk=
3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-111-gec7ac8d402eb1/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk=
3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cros-ec-keyb-probed: https://kernelci.org/test/case/id/=
65767bd0634c1eb2e0e13586
        new failure (last pass: v5.15.142-112-g6fca85622af22)

    2023-12-11T03:10:06.948264  <8>[   27.144610] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-keyb-driver-present RESULT=3Dpass>

    2023-12-11T03:10:07.963247  /lava-12240138/1/../bin/lava-test-case
   =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65767b257aa07d3a15e13491

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-111-gec7ac8d402eb1/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-111-gec7ac8d402eb1/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65767b257aa07d3a15e13496
        failing since 18 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-11T02:59:40.222043  <8>[   16.090248] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447535_1.5.2.4.1>
    2023-12-11T02:59:40.327063  / # #
    2023-12-11T02:59:40.428780  export SHELL=3D/bin/sh
    2023-12-11T02:59:40.429476  #
    2023-12-11T02:59:40.530470  / # export SHELL=3D/bin/sh. /lava-447535/en=
vironment
    2023-12-11T02:59:40.531090  =

    2023-12-11T02:59:40.632101  / # . /lava-447535/environment/lava-447535/=
bin/lava-test-runner /lava-447535/1
    2023-12-11T02:59:40.632994  =

    2023-12-11T02:59:40.637358  / # /lava-447535/bin/lava-test-runner /lava=
-447535/1
    2023-12-11T02:59:40.669336  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65767b31a33a93e5ade135ef

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-111-gec7ac8d402eb1/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-111-gec7ac8d402eb1/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65767b31a33a93e5ade135f4
        failing since 18 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-11T03:07:24.792376  / # #

    2023-12-11T03:07:24.894496  export SHELL=3D/bin/sh

    2023-12-11T03:07:24.895275  #

    2023-12-11T03:07:24.996628  / # export SHELL=3D/bin/sh. /lava-12240086/=
environment

    2023-12-11T03:07:24.997342  =


    2023-12-11T03:07:25.098723  / # . /lava-12240086/environment/lava-12240=
086/bin/lava-test-runner /lava-12240086/1

    2023-12-11T03:07:25.099890  =


    2023-12-11T03:07:25.140833  / # /lava-12240086/bin/lava-test-runner /la=
va-12240086/1

    2023-12-11T03:07:25.173435  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-11T03:07:25.173941  + cd /lava-1224008<8>[   16.813011] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12240086_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

