Return-Path: <stable+bounces-4814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 775728067CD
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 07:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94EA1F211FF
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 06:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83C2125CF;
	Wed,  6 Dec 2023 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="g0tlBcup"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27CED40
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 22:54:00 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5c66988c2eeso420529a12.1
        for <stable@vger.kernel.org>; Tue, 05 Dec 2023 22:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701845639; x=1702450439; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jQQH2/svfG+MS0kZ5T2QESKAdVESnn6tYL9pzb1Dp+k=;
        b=g0tlBcupBercA4Tu8k5zX0t3usBAlf7rHszY9Y2O+CW7rZL3rRwzXAvZPzyaE9m3qL
         1nVOf4THB9uUR7koxs8tHogXQvXPcZZa/ADa9hMB2p7TUp9mBVBMw5zTNdsTA3sa9LjM
         i9FSOxIs3MFv5Y6rE/bC/8d2LwbnbpAdBGyVZhKBo/fiULWA1B3enZ9gnpsXvGSYbMAa
         kqTRWTwHXelcyPujwIVPRvNNFEr4YGWouVX778AhBVbZ6QYT3kvIe2GgY2U4x3HVQaly
         JJ/d2L3HTP0j1GRCjWZtnsNQjCW8SXVyI23J04ToLvpjUCwb18rHz+if8/RgGxC6agHq
         TkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701845639; x=1702450439;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQQH2/svfG+MS0kZ5T2QESKAdVESnn6tYL9pzb1Dp+k=;
        b=S8+XGy9fcSiog/6vm3+8knA802A/n+sL3Id98Q8/apShtC72sq69OFnzfYyun4RB+3
         ibtbDS0O/ucaUZL06JVTJFMeuTWKzZYK158mferamfdmyisKR7oFDYPiZGFYe98sGq5D
         QAaponqoqdi0kE3JvFkYua34+9KH0Yu3Qurk+hFUgej2AtlNMwAHXGy5xsIvQZByDIIF
         sou+JxYEHHwwZllkDvOfEmBphNao0SHSax0Nm1za17YCsMC65Ck6am4FjA8rZPqQ+xEA
         9rmJHIZSeahbZpoA7cWoN4yHWkgMVCtvJsGNgSROf1Z2VUt4fD9bFRoiut1SJvAVF4PI
         5F4A==
X-Gm-Message-State: AOJu0Yz8UJnw2tvIB3IHto4gmWrKU5ov3LlG5MpjWt+fRar1gUjBaZ2N
	yiEfUOrjCSnEidgK3RlzInX6Xcjy9Aa1GnHC7rVTDQ==
X-Google-Smtp-Source: AGHT+IFgQwAWcTL4nLB/ElNRZ0+S2vbiEtJoIwCbh5mR+/RrPk1YSqiLknKiHzCo69OidfP2PyFUqQ==
X-Received: by 2002:a05:6a20:9387:b0:18c:5178:9649 with SMTP id x7-20020a056a20938700b0018c51789649mr624776pzh.14.1701845639642;
        Tue, 05 Dec 2023 22:53:59 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j14-20020aa783ce000000b006ce5da5956csm3868300pfn.24.2023.12.05.22.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 22:53:59 -0800 (PST)
Message-ID: <65701a87.a70a0220.25f24.cbb4@mx.google.com>
Date: Tue, 05 Dec 2023 22:53:59 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.141-64-g455871f0fe3d
Subject: stable-rc/queue/5.15 baseline: 152 runs,
 4 regressions (v5.15.141-64-g455871f0fe3d)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 152 runs, 4 regressions (v5.15.141-64-g45587=
1f0fe3d)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beagle-xm          | arm   | lab-baylibre  | gcc-10   | omap2plus_defconfig=
 | 1          =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
 | 1          =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.141-64-g455871f0fe3d/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.141-64-g455871f0fe3d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      455871f0fe3da76d22c33ee0d3f41957aae8c0c9 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beagle-xm          | arm   | lab-baylibre  | gcc-10   | omap2plus_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/656fea9ef1691998f9e134ab

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-64-g455871f0fe3d/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-64-g455871f0fe3d/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656fea9ef1691998f9e13=
4ac
        failing since 305 days (last pass: v5.15.91-12-g3290f78df1ab, first=
 fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/656fe662882fcce3ece1349e

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-64-g455871f0fe3d/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-64-g455871f0fe3d/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656fe662882fcce3ece134a3
        failing since 13 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-06T03:18:57.613007  / # #

    2023-12-06T03:18:57.713611  export SHELL=3D/bin/sh

    2023-12-06T03:18:57.713764  #

    2023-12-06T03:18:57.814287  / # export SHELL=3D/bin/sh. /lava-12193930/=
environment

    2023-12-06T03:18:57.814401  =


    2023-12-06T03:18:57.914900  / # . /lava-12193930/environment/lava-12193=
930/bin/lava-test-runner /lava-12193930/1

    2023-12-06T03:18:57.915149  =


    2023-12-06T03:18:57.926613  / # /lava-12193930/bin/lava-test-runner /la=
va-12193930/1

    2023-12-06T03:18:57.968404  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-06T03:18:57.985973  + cd /lav<8>[   15.989320] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12193930_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/656fe67be4002232d8e134f6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-64-g455871f0fe3d/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine=
-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-64-g455871f0fe3d/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine=
-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656fe67be4002232d8e134fb
        failing since 13 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-06T03:11:46.078551  <8>[   16.090686] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 446734_1.5.2.4.1>
    2023-12-06T03:11:46.183615  / # #
    2023-12-06T03:11:46.285286  export SHELL=3D/bin/sh
    2023-12-06T03:11:46.285919  #
    2023-12-06T03:11:46.386918  / # export SHELL=3D/bin/sh. /lava-446734/en=
vironment
    2023-12-06T03:11:46.387551  =

    2023-12-06T03:11:46.488576  / # . /lava-446734/environment/lava-446734/=
bin/lava-test-runner /lava-446734/1
    2023-12-06T03:11:46.489479  =

    2023-12-06T03:11:46.493741  / # /lava-446734/bin/lava-test-runner /lava=
-446734/1
    2023-12-06T03:11:46.525800  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/656fe676682a85f4f3e13504

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-64-g455871f0fe3d/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.141=
-64-g455871f0fe3d/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656fe676682a85f4f3e13509
        failing since 13 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-06T03:19:16.183213  / # #

    2023-12-06T03:19:16.285599  export SHELL=3D/bin/sh

    2023-12-06T03:19:16.286305  #

    2023-12-06T03:19:16.387618  / # export SHELL=3D/bin/sh. /lava-12193937/=
environment

    2023-12-06T03:19:16.388395  =


    2023-12-06T03:19:16.489826  / # . /lava-12193937/environment/lava-12193=
937/bin/lava-test-runner /lava-12193937/1

    2023-12-06T03:19:16.491073  =


    2023-12-06T03:19:16.493664  / # /lava-12193937/bin/lava-test-runner /la=
va-12193937/1

    2023-12-06T03:19:16.536893  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-06T03:19:16.568578  + cd /lava-1219393<8>[   16.875418] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12193937_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

