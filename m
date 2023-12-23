Return-Path: <stable+bounces-8404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474DE81D680
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 21:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFBF4282D95
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 20:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAC112E60;
	Sat, 23 Dec 2023 20:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="yMc5d0P3"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D66515E93
	for <stable@vger.kernel.org>; Sat, 23 Dec 2023 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bb8f3d9f98so1364411b6e.3
        for <stable@vger.kernel.org>; Sat, 23 Dec 2023 12:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703363642; x=1703968442; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fGJZm/efYZXoBG4ZyQp8+1XUPw4r+/HhlCnvP8W09+o=;
        b=yMc5d0P3HIt8KpAyoKJvphgaF48+wYX7mXsX4MwwwdYw3+MGzG5rW7ROxzQBnnFbeL
         F65u5WEYoQukT/FGFX0kpg5OjIjGa5WOyFmmLZmX560d0R+eQXzCktr8+HCqisVObDF3
         Jr2H1Uy2pGFoSMcOaQNntin+F6fLRRsIk9h293ipCYaASXjQqa8sm2Puhu26OsR+2sH6
         0obl2+GquKg8JVFnNQhr9gnYlBH3Qy5MteUkg301SZP4jMkOeEQ00dB6U0lZWYkfX225
         u4AjqW2JWfjx1LpBiK+1UFFPW9/x8V+Ssh6Nfe5xQLA238QSq+IOqhSNOgHBfNruuUTz
         RtVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703363642; x=1703968442;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fGJZm/efYZXoBG4ZyQp8+1XUPw4r+/HhlCnvP8W09+o=;
        b=ortaC3KJPiJQRk/tHfNnJbyPiWg7aEPlkHUvV4hzZGA0qd/mqA3IQAzbAM2ZKekA+O
         8hvR/xdj7tC36LKdzKaxwH5m+WucHF/3e0IASC+k4tj30pnkWc/OIcrN0xzoAwhxQZL1
         lmPrhqQCBZKfAxybZuA4kAFmOKbP0AGXbgtPWAYye/YoSdQC2CUwcE8LQT/e/kcYhAXd
         ktk/3TqupROFgX4FCkHS7QsV4U5+BZGzIqwqjcCxANiNd4p46kG1tRRg3gvBRuPo17+3
         NJtHxSItR20LWJGhV2vaBIky7XhxZARFm51kH9T5/j/gme7Fbp8zCvxxOWpN/qh4R2rY
         J3LA==
X-Gm-Message-State: AOJu0Yy5WD6Qs3ys/BSX1WhGn6HHvmyxxhc//d4k3uBRU1/jKlSiwd6E
	cELtRtD2VQMBZREEkUoVab9xF9mocKrPWVechrdFMjhzlRY=
X-Google-Smtp-Source: AGHT+IHZIaW3BOjNntCP3ioPVdph0QpIlIVsvi1hjeqll2hANGgcnqdx6gGva6qtnfxSptduehLbFA==
X-Received: by 2002:a05:6808:1708:b0:3b9:e2bf:c24e with SMTP id bc8-20020a056808170800b003b9e2bfc24emr4343712oib.15.1703363641767;
        Sat, 23 Dec 2023 12:34:01 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o21-20020a056a001b5500b006d99056c4edsm2913530pfv.187.2023.12.23.12.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 12:34:01 -0800 (PST)
Message-ID: <65874439.050a0220.19f79.6f13@mx.google.com>
Date: Sat, 23 Dec 2023 12:34:01 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.143-247-g2c5a01b7b03a0
Subject: stable-rc/queue/5.15 baseline: 104 runs,
 3 regressions (v5.15.143-247-g2c5a01b7b03a0)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 104 runs, 3 regressions (v5.15.143-247-g2c5a=
01b7b03a0)

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
nel/v5.15.143-247-g2c5a01b7b03a0/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.143-247-g2c5a01b7b03a0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      2c5a01b7b03a00e41d0c1d6b5a5530532e62c389 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6587112a7196fb7bd3e134b4

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-247-g2c5a01b7b03a0/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-247-g2c5a01b7b03a0/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6587112a7196fb7bd3e134bd
        failing since 31 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-23T17:03:39.649133  / # #

    2023-12-23T17:03:39.749690  export SHELL=3D/bin/sh

    2023-12-23T17:03:39.749830  #

    2023-12-23T17:03:39.850329  / # export SHELL=3D/bin/sh. /lava-12365711/=
environment

    2023-12-23T17:03:39.850462  =


    2023-12-23T17:03:39.950968  / # . /lava-12365711/environment/lava-12365=
711/bin/lava-test-runner /lava-12365711/1

    2023-12-23T17:03:39.951178  =


    2023-12-23T17:03:39.962797  / # /lava-12365711/bin/lava-test-runner /la=
va-12365711/1

    2023-12-23T17:03:40.004412  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-23T17:03:40.021924  + cd /lav<8>[   15.978102] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12365711_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/658711237196fb7bd3e13475

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-247-g2c5a01b7b03a0/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-247-g2c5a01b7b03a0/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658711237196fb7bd3e1347e
        failing since 31 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-23T16:55:55.820261  <8>[   16.082829] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 449715_1.5.2.4.1>
    2023-12-23T16:55:55.925302  / # #
    2023-12-23T16:55:56.026993  export SHELL=3D/bin/sh
    2023-12-23T16:55:56.027626  #
    2023-12-23T16:55:56.128630  / # export SHELL=3D/bin/sh. /lava-449715/en=
vironment
    2023-12-23T16:55:56.129247  =

    2023-12-23T16:55:56.230284  / # . /lava-449715/environment/lava-449715/=
bin/lava-test-runner /lava-449715/1
    2023-12-23T16:55:56.231200  =

    2023-12-23T16:55:56.235576  / # /lava-449715/bin/lava-test-runner /lava=
-449715/1
    2023-12-23T16:55:56.267648  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6587113efe0bb24b58e1347f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-247-g2c5a01b7b03a0/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-247-g2c5a01b7b03a0/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6587113efe0bb24b58e13488
        failing since 31 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-23T17:03:55.950219  / # #

    2023-12-23T17:03:56.052220  export SHELL=3D/bin/sh

    2023-12-23T17:03:56.052972  #

    2023-12-23T17:03:56.154353  / # export SHELL=3D/bin/sh. /lava-12365707/=
environment

    2023-12-23T17:03:56.155051  =


    2023-12-23T17:03:56.256367  / # . /lava-12365707/environment/lava-12365=
707/bin/lava-test-runner /lava-12365707/1

    2023-12-23T17:03:56.257408  =


    2023-12-23T17:03:56.274538  / # /lava-12365707/bin/lava-test-runner /la=
va-12365707/1

    2023-12-23T17:03:56.333108  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-23T17:03:56.333288  + cd /lava-1236570<8>[   16.817078] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12365707_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

