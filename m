Return-Path: <stable+bounces-3166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA847FDE46
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 18:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45374B20EFB
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 17:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC333C6BF;
	Wed, 29 Nov 2023 17:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="QmNMygQU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCCDBD
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 09:24:19 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6cddb35ef8bso524012b3a.2
        for <stable@vger.kernel.org>; Wed, 29 Nov 2023 09:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701278658; x=1701883458; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wRr4EoPQh24wIjjvI6Le6Dp1eMRofnFgWwa4zcUDrzs=;
        b=QmNMygQUQ9tYehZdBYuHPnQm0c4nvsw03D7svATxBp3KE+/9VIr8pyYyF9Sw99gP63
         tBekhiDjp611YDq0HbL3ZC07DyIVdqbjYUV59B5EEc9sRawLSS4lZRwqTJv1Brx4A5c3
         RsTGLyCxjgPIjo82AY2JlwnS4TAJ8CgeWBryVFTl4sdiwaEWHSb53dU2mAJ4d3JzmpJN
         7+Srwsn3LJQoOEI+dof2fHwXj2GnvKSck7Ut2CJA36ggogmk0FC+hW4risE0IApuj1jm
         sNlotTlZF0jC+IJENGpjKOrEo0sLybn66j1+zNGdalXOQKaJEAwia3Zbb5/gB45w10LK
         5okA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701278658; x=1701883458;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wRr4EoPQh24wIjjvI6Le6Dp1eMRofnFgWwa4zcUDrzs=;
        b=B+4/nUALTgLbRjTAK5yxs0CZuW1JFAYjiVgB5UFHh9G84fsef3eKySa3sqdmbjXppI
         HHe7Ft43bJCVEPwqr4XlF8iuK/Ml+yi5WGXyi/siNgzw6fYB4u8hnGsF9sTa6kCYvQaw
         91rlE/xmZwsMTZJVDx6yGp8c8KovIRLjKbCuySPU3Pb20fThi3i53CqFmLJzfWBTWIYo
         HTgK3u5ix9mBeDHimG3O+oBc16FmkmfeK5eslr0P67c3MbH2vvUNQfx5Bcu4I0A8Swr1
         WHoTman4s2DIGFoVa7UJUPWD/G+yVT13tTgpjA6DTAYDDocJBrx7PX9cPa+EzslWeJPR
         EbBw==
X-Gm-Message-State: AOJu0YyYK+AmXaRf3e68OhGw7Nzocdtb816WRMcZQHJ7stLRDvd4/oSR
	W9v4R9N4zAIiXJMZoxLD8RWRt2v5YKeDU12zN0JCRg==
X-Google-Smtp-Source: AGHT+IFrq/hVxbm9MPKFC08sqMpHOYh4L3MkhzrzoyjHzYdZF1HfDFwv9iWxvAQJOLwl+BMXJMbs1Q==
X-Received: by 2002:a05:6a20:8f13:b0:18c:af15:7e73 with SMTP id b19-20020a056a208f1300b0018caf157e73mr11220207pzk.48.1701278658522;
        Wed, 29 Nov 2023 09:24:18 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k21-20020a635615000000b005c6007a13b5sm1773529pgb.25.2023.11.29.09.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 09:24:17 -0800 (PST)
Message-ID: <656773c1.630a0220.f7144.54ed@mx.google.com>
Date: Wed, 29 Nov 2023 09:24:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.64-54-g93cdac04ac8ae
Subject: stable-rc/queue/6.1 baseline: 145 runs,
 3 regressions (v6.1.64-54-g93cdac04ac8ae)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 145 runs, 3 regressions (v6.1.64-54-g93cdac04=
ac8ae)

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.64-54-g93cdac04ac8ae/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.64-54-g93cdac04ac8ae
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      93cdac04ac8ae72c8ab1b1187b3d1b2b4ac4dc32 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6567605cc103e7dae77e4a71

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.64-54=
-g93cdac04ac8ae/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.64-54=
-g93cdac04ac8ae/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6567605cc103e7dae77e4a7a
        failing since 6 days (last pass: v6.1.31-26-gef50524405c2, first fa=
il: v6.1.63-176-gecc0fed1ffa4)

    2023-11-29T16:07:50.077720  / # #

    2023-11-29T16:07:50.180241  export SHELL=3D/bin/sh

    2023-11-29T16:07:50.180926  #

    2023-11-29T16:07:50.282278  / # export SHELL=3D/bin/sh. /lava-12120843/=
environment

    2023-11-29T16:07:50.283039  =


    2023-11-29T16:07:50.384568  / # . /lava-12120843/environment/lava-12120=
843/bin/lava-test-runner /lava-12120843/1

    2023-11-29T16:07:50.385863  =


    2023-11-29T16:07:50.401037  / # /lava-12120843/bin/lava-test-runner /la=
va-12120843/1

    2023-11-29T16:07:50.450999  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-29T16:07:50.451510  + cd /lav<8>[   19.086783] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12120843_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65674273c8c9e2b95e7e4b3d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.64-54=
-g93cdac04ac8ae/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.64-54=
-g93cdac04ac8ae/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65674273c8c9e2b95e7e4b46
        failing since 6 days (last pass: v6.1.22-372-g971903477e72, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-11-29T13:53:49.038187  <8>[   18.092330] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 445815_1.5.2.4.1>
    2023-11-29T13:53:49.143182  / # #
    2023-11-29T13:53:49.244833  export SHELL=3D/bin/sh
    2023-11-29T13:53:49.245397  #
    2023-11-29T13:53:49.346412  / # export SHELL=3D/bin/sh. /lava-445815/en=
vironment
    2023-11-29T13:53:49.347012  =

    2023-11-29T13:53:49.448012  / # . /lava-445815/environment/lava-445815/=
bin/lava-test-runner /lava-445815/1
    2023-11-29T13:53:49.448883  =

    2023-11-29T13:53:49.453435  / # /lava-445815/bin/lava-test-runner /lava=
-445815/1
    2023-11-29T13:53:49.526638  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65674294f8536d6b787e4a8a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.64-54=
-g93cdac04ac8ae/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.64-54=
-g93cdac04ac8ae/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65674294f8536d6b787e4a93
        failing since 6 days (last pass: v6.1.22-372-g971903477e72, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-11-29T14:00:42.834747  / # #

    2023-11-29T14:00:42.936812  export SHELL=3D/bin/sh

    2023-11-29T14:00:42.937567  #

    2023-11-29T14:00:43.038884  / # export SHELL=3D/bin/sh. /lava-12120854/=
environment

    2023-11-29T14:00:43.039526  =


    2023-11-29T14:00:43.140873  / # . /lava-12120854/environment/lava-12120=
854/bin/lava-test-runner /lava-12120854/1

    2023-11-29T14:00:43.142016  =


    2023-11-29T14:00:43.145889  / # /lava-12120854/bin/lava-test-runner /la=
va-12120854/1

    2023-11-29T14:00:43.225685  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-29T14:00:43.226344  + cd /lava-1212085<8>[   19.216945] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12120854_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

