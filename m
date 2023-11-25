Return-Path: <stable+bounces-2655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569357F8FE3
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 23:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80691B20F67
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 22:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52592F84B;
	Sat, 25 Nov 2023 22:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="U6eil1S6"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BB1129
	for <stable@vger.kernel.org>; Sat, 25 Nov 2023 14:57:03 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b83c4c5aefso1959260b6e.1
        for <stable@vger.kernel.org>; Sat, 25 Nov 2023 14:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700953022; x=1701557822; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qTtcz73Stk7c+d1LazKAaibtkx1yb3MramCo3oLrOxg=;
        b=U6eil1S6iO+X1e2riyAr0HWuOUnei8rQ57xmfkR/rtO3ibvoPhBDoe0CuKuCPljwPJ
         Vl7lgGFLsAMM20Z/fYn9ul8VRuyld1MGCQXB6yvDTr0Q2FpKwz2hf+4U4l3gFp4V+9C6
         WOKFd+i93PG5ngeB0wrO/7yy8bdJuTNUDmbKESqWBo2rAQ4tOrN/DRKdrzlDbmuNhFeG
         8dPrBMFH9y3AxoOYgNDoBmVJFIIe3mD8sXCXJymzn8ud/hGFzzxAyT6TY97d2m6y9pol
         sDAO0TO1dyEWd0+Wbc04eGdzYfQ8TCH14RQm1jU7C2Sw8Jl56is3TF4bJ4R9AEp0Llbq
         4VJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700953022; x=1701557822;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qTtcz73Stk7c+d1LazKAaibtkx1yb3MramCo3oLrOxg=;
        b=j2B5CL9JI/BWuqXnqYBEJdoVfs+XvPDiV4J8cHxzrIhePwglrma3KOABCwep4yVjyK
         VAwFyLoiVIQLR0qyfHDP3ZzcOtELA+JTKMtWdB0M5gzJMaVE0P2iVfibQ4pzSh+0IJhl
         YMINZg0SBqHy9iLo82aYrFG06pB8+akznO7O2Srl9W8LATOxDnbfZdqKQseP9gVn1dE8
         CmcUwwH52+HKvV0/zAA/FQtFJfZVav5j2r5VlkCxWlkIyYbNPpqWn8yp6yM+iR+HH9VE
         hoPh457yxHQpIP5UmpOGWXtR5KdikTJBESqaN5w20dNteviISYHOgvgewWmh9swiL3eN
         ctnA==
X-Gm-Message-State: AOJu0Yz4Kxs1VF5yKFniy3Nd7OsuOHqyr9/INIuPlcbJkn7WLQEidXpK
	OKpw9BMwyAZGyAQ8uvu9lMYIuCI5qyZpjkpdqj4=
X-Google-Smtp-Source: AGHT+IGrq1DFwbOUl6cgwPepzRg0Y1a3llF9Ruymc3ILxHrILMLh4vfi/M+SIjt+16siNO5/LJ83jw==
X-Received: by 2002:a05:6808:1395:b0:3b8:6057:b08a with SMTP id c21-20020a056808139500b003b86057b08amr2782529oiw.6.1700953022194;
        Sat, 25 Nov 2023 14:57:02 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j7-20020aa78007000000b006900cb919b8sm4690881pfi.53.2023.11.25.14.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 14:57:01 -0800 (PST)
Message-ID: <65627bbd.a70a0220.691f5.acf4@mx.google.com>
Date: Sat, 25 Nov 2023 14:57:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.201-188-g5a5257c03949d
Subject: stable-rc/queue/5.10 baseline: 109 runs,
 7 regressions (v5.10.201-188-g5a5257c03949d)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 109 runs, 7 regressions (v5.10.201-188-g5a52=
57c03949d)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig | 1          =

juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
           | 1          =

r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
           | 1          =

rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
           | 1          =

sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
           | 1          =

sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
           | 1          =

sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig  | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.201-188-g5a5257c03949d/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.201-188-g5a5257c03949d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      5a5257c03949d90b7ae5ad67b73b882270d1ee24 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65624a9d186983395a7e4aab

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-188-g5a5257c03949d/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-188-g5a5257c03949d/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65624a9d186983395a7e4ae5
        failing since 284 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-11-25T19:27:08.510726  <8>[   19.211647] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 272937_1.5.2.4.1>
    2023-11-25T19:27:08.620906  / # #
    2023-11-25T19:27:08.724119  export SHELL=3D/bin/sh
    2023-11-25T19:27:08.725075  #
    2023-11-25T19:27:08.827114  / # export SHELL=3D/bin/sh. /lava-272937/en=
vironment
    2023-11-25T19:27:08.827980  =

    2023-11-25T19:27:08.930119  / # . /lava-272937/environment/lava-272937/=
bin/lava-test-runner /lava-272937/1
    2023-11-25T19:27:08.931535  =

    2023-11-25T19:27:08.936039  / # /lava-272937/bin/lava-test-runner /lava=
-272937/1
    2023-11-25T19:27:09.037578  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/65624b7a3edabb4e017e4ad0

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-188-g5a5257c03949d/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.=
txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-188-g5a5257c03949d/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65624b7a3edabb4e017e4b10
        failing since 3 days (last pass: v5.10.181-18-g1622068b57a4, first =
fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-25T19:30:36.307990  / # #
    2023-11-25T19:30:36.410964  export SHELL=3D/bin/sh
    2023-11-25T19:30:36.411785  #
    2023-11-25T19:30:36.513754  / # export SHELL=3D/bin/sh. /lava-272976/en=
vironment
    2023-11-25T19:30:36.514596  =

    2023-11-25T19:30:36.616555  / # . /lava-272976/environment/lava-272976/=
bin/lava-test-runner /lava-272976/1
    2023-11-25T19:30:36.617920  =

    2023-11-25T19:30:36.630936  / # /lava-272976/bin/lava-test-runner /lava=
-272976/1
    2023-11-25T19:30:36.691741  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-25T19:30:36.692247  + cd /lava-272976/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/65624ad53b53fcbda97e4a78

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-188-g5a5257c03949d/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-188-g5a5257c03949d/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65624ad63b53fcbda97e4a81
        failing since 3 days (last pass: v5.10.181-18-g1622068b57a4, first =
fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-25T19:34:28.439506  / # #

    2023-11-25T19:34:28.541683  export SHELL=3D/bin/sh

    2023-11-25T19:34:28.542395  #

    2023-11-25T19:34:28.643824  / # export SHELL=3D/bin/sh. /lava-12084024/=
environment

    2023-11-25T19:34:28.644542  =


    2023-11-25T19:34:28.745946  / # . /lava-12084024/environment/lava-12084=
024/bin/lava-test-runner /lava-12084024/1

    2023-11-25T19:34:28.746987  =


    2023-11-25T19:34:28.763524  / # /lava-12084024/bin/lava-test-runner /la=
va-12084024/1

    2023-11-25T19:34:28.812846  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-25T19:34:28.813403  + cd /lav<8>[   16.499214] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12084024_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/65624b005eb71e33617e4a95

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-188-g5a5257c03949d/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-ro=
ck-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-188-g5a5257c03949d/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-ro=
ck-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65624b005eb71e33617e4a9e
        failing since 3 days (last pass: v5.10.181-18-g1622068b57a4, first =
fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-25T19:29:09.283724  / # #

    2023-11-25T19:29:10.544411  export SHELL=3D/bin/sh

    2023-11-25T19:29:10.555375  #

    2023-11-25T19:29:10.555846  / # export SHELL=3D/bin/sh

    2023-11-25T19:29:12.299449  / # . /lava-12084028/environment

    2023-11-25T19:29:15.504361  /lava-12084028/bin/lava-test-runner /lava-1=
2084028/1

    2023-11-25T19:29:15.515786  . /lava-12084028/environment

    2023-11-25T19:29:15.518039  / # /lava-12084028/bin/lava-test-runner /la=
va-12084028/1

    2023-11-25T19:29:15.571084  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-25T19:29:15.571573  + cd /lava-12084028/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/65624ac0186983395a7e4af0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-188-g5a5257c03949d/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-188-g5a5257c03949d/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65624ac0186983395a7e4af9
        failing since 3 days (last pass: v5.10.176-241-ga0049fd9c865, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-25T19:27:52.167561  <8>[   16.954336] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 445278_1.5.2.4.1>
    2023-11-25T19:27:52.272604  / # #
    2023-11-25T19:27:52.374344  export SHELL=3D/bin/sh
    2023-11-25T19:27:52.374959  #
    2023-11-25T19:27:52.475946  / # export SHELL=3D/bin/sh. /lava-445278/en=
vironment
    2023-11-25T19:27:52.476558  =

    2023-11-25T19:27:52.577570  / # . /lava-445278/environment/lava-445278/=
bin/lava-test-runner /lava-445278/1
    2023-11-25T19:27:52.578455  =

    2023-11-25T19:27:52.582875  / # /lava-445278/bin/lava-test-runner /lava=
-445278/1
    2023-11-25T19:27:52.649888  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/65624ad43b53fcbda97e4a6d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-188-g5a5257c03949d/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-188-g5a5257c03949d/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65624ad43b53fcbda97e4a76
        failing since 3 days (last pass: v5.10.176-241-ga0049fd9c865, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-25T19:34:41.690511  / # #

    2023-11-25T19:34:41.792809  export SHELL=3D/bin/sh

    2023-11-25T19:34:41.793554  #

    2023-11-25T19:34:41.895057  / # export SHELL=3D/bin/sh. /lava-12084016/=
environment

    2023-11-25T19:34:41.895811  =


    2023-11-25T19:34:41.997272  / # . /lava-12084016/environment/lava-12084=
016/bin/lava-test-runner /lava-12084016/1

    2023-11-25T19:34:41.998355  =


    2023-11-25T19:34:42.014891  / # /lava-12084016/bin/lava-test-runner /la=
va-12084016/1

    2023-11-25T19:34:42.057728  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-25T19:34:42.073996  + cd /lava-1208401<8>[   18.254248] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12084016_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/65624998418d7ba9b57e4a9d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-188-g5a5257c03949d/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.201=
-188-g5a5257c03949d/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun=
8i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65624998418d7ba9b57e4aa6
        failing since 3 days (last pass: v5.10.165-77-g4600242c13ed, first =
fail: v5.10.201-98-g6f84b6dba25c)

    2023-11-25T19:22:37.147726  / # #
    2023-11-25T19:22:37.248773  export SHELL=3D/bin/sh
    2023-11-25T19:22:37.249089  #
    2023-11-25T19:22:37.349818  / # export SHELL=3D/bin/sh. /lava-3847026/e=
nvironment
    2023-11-25T19:22:37.350143  =

    2023-11-25T19:22:37.450887  / # . /lava-3847026/environment/lava-384702=
6/bin/lava-test-runner /lava-3847026/1
    2023-11-25T19:22:37.451417  =

    2023-11-25T19:22:37.459874  / # /lava-3847026/bin/lava-test-runner /lav=
a-3847026/1
    2023-11-25T19:22:37.555901  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-25T19:22:37.556298  + cd /lava-3847026/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

