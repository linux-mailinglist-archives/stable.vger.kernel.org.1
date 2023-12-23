Return-Path: <stable+bounces-8384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9666681D4A9
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 15:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5CAA1C210D0
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 14:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5859DDA1;
	Sat, 23 Dec 2023 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Wq8YPFZL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C83DF4D
	for <stable@vger.kernel.org>; Sat, 23 Dec 2023 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d532e4f6d6so1453014b3a.2
        for <stable@vger.kernel.org>; Sat, 23 Dec 2023 06:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703342373; x=1703947173; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wqm3WBaNHdT7XDx0E2Ht9YJVlsvx5tUkTdcWjUIgehA=;
        b=Wq8YPFZLccT+e8DuHBRDxvQVd1+uUL3k3OAqNyUjzF+2OE4PihkKC8E09Rurd7+CQh
         jNO+hLo1vpseNveLl5kCbC+LC0iUSlkEjk6jG7CBUR7SvpgWNCqGHwUZIxGmupHkD7xH
         u+nyojXpfKnE0QiliqnpKproG8PR07I9dp4oRGN2KBH4pLw9tiz/arB+mDn0QPrs7ErM
         vq8BSEnJXbuXpY/QcU9iiUNImJIAy7rf/b3f7XIkxEPsph76xMX/u7Uc9eDLoQlmSKaS
         kBhuXSOJCtgB+rcLOJ3T9LH/X0mK217SwpGEIlVVEBGPKLx96wQiJ/tq0oHdLdetHfyB
         +ZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703342373; x=1703947173;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wqm3WBaNHdT7XDx0E2Ht9YJVlsvx5tUkTdcWjUIgehA=;
        b=k5GJULOxfzEJsSLHKL1K0My4Gzf/eAZ3T7MQPww9mGiF5IthUFP4ngSq6NtnYrDmI1
         ozLcQwlYfLmJvoz0XaPElDKDuqtwtwpm92+BvNMG+E2h8a55Our+Cy3S4WJNWyxOPMcs
         fJK4pR3nuYXizpxDId+6vMdCYOWCTVfJTzZ6xaO/GMgWI3Bgue9gDUgDWtleSVFYR44j
         3hXIQZz0jlpwmhXknGyBrUVHJ3uWVbAojZ8vVjIhsWCHRns+TK1EZ/MkFVrWUYr1yYMy
         jZGDK8QEktf16/HTJf8E50mwQpOsfO7Y+bOKIkjBnPedaA4hud1ohZh6oSWln+xWXOzP
         ul1A==
X-Gm-Message-State: AOJu0YwGzZFHcMcmx42m6QXHe71BXJduWwiOYkDP5bxJG2MXPHS4CTp4
	jKbFYtwGsfaq6qK47KyQmir6MGXXo4PtbxUp4czDH1tHClo=
X-Google-Smtp-Source: AGHT+IG5HZSKH6U7i43GdPhyfjQfAelQI8U5NMTJY2/emKbpRhMrJzGs+hQoRxvwJXsR2/DC2IhGog==
X-Received: by 2002:a05:6a00:8c03:b0:6d5:79f5:b594 with SMTP id ih3-20020a056a008c0300b006d579f5b594mr1662913pfb.3.1703342373542;
        Sat, 23 Dec 2023 06:39:33 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e13-20020a62ee0d000000b006d9ab3cd847sm536570pfi.209.2023.12.23.06.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 06:39:32 -0800 (PST)
Message-ID: <6586f124.620a0220.3a1eb.0bff@mx.google.com>
Date: Sat, 23 Dec 2023 06:39:32 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.143-242-gd68d9bf0c4d6d
Subject: stable-rc/queue/5.15 baseline: 104 runs,
 4 regressions (v5.15.143-242-gd68d9bf0c4d6d)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 104 runs, 4 regressions (v5.15.143-242-gd68d=
9bf0c4d6d)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
kontron-pitx-imx8m | arm64 | lab-kontron   | gcc-10   | defconfig | 1      =
    =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.143-242-gd68d9bf0c4d6d/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.143-242-gd68d9bf0c4d6d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      d68d9bf0c4d6dc1c213df5ece29269ecb712b7c9 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
kontron-pitx-imx8m | arm64 | lab-kontron   | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6586be3f40dd7f2544e13480

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-242-gd68d9bf0c4d6d/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pit=
x-imx8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-242-gd68d9bf0c4d6d/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pit=
x-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6586be3f40dd7f2544e13=
481
        new failure (last pass: v5.15.143-109-gfda221fa55986) =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6586bd35817b4c95c1e13533

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-242-gd68d9bf0c4d6d/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-242-gd68d9bf0c4d6d/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6586bd35817b4c95c1e1353c
        failing since 30 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-23T11:05:08.661024  / # #

    2023-12-23T11:05:08.763153  export SHELL=3D/bin/sh

    2023-12-23T11:05:08.763908  #

    2023-12-23T11:05:08.865374  / # export SHELL=3D/bin/sh. /lava-12362237/=
environment

    2023-12-23T11:05:08.866111  =


    2023-12-23T11:05:08.967563  / # . /lava-12362237/environment/lava-12362=
237/bin/lava-test-runner /lava-12362237/1

    2023-12-23T11:05:08.968732  =


    2023-12-23T11:05:08.985081  / # /lava-12362237/bin/lava-test-runner /la=
va-12362237/1

    2023-12-23T11:05:09.034654  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-23T11:05:09.035150  + cd /lav<8>[   16.013509] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12362237_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6586bd20817b4c95c1e13475

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-242-gd68d9bf0c4d6d/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-242-gd68d9bf0c4d6d/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6586bd20817b4c95c1e1347e
        failing since 30 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-23T10:57:29.635294  <8>[   16.158614] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 449665_1.5.2.4.1>
    2023-12-23T10:57:29.740213  / # #
    2023-12-23T10:57:29.841764  export SHELL=3D/bin/sh
    2023-12-23T10:57:29.842302  #
    2023-12-23T10:57:29.943297  / # export SHELL=3D/bin/sh. /lava-449665/en=
vironment
    2023-12-23T10:57:29.943849  =

    2023-12-23T10:57:30.044842  / # . /lava-449665/environment/lava-449665/=
bin/lava-test-runner /lava-449665/1
    2023-12-23T10:57:30.045701  =

    2023-12-23T10:57:30.050527  / # /lava-449665/bin/lava-test-runner /lava=
-449665/1
    2023-12-23T10:57:30.118661  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6586bd34817b4c95c1e13526

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-242-gd68d9bf0c4d6d/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-242-gd68d9bf0c4d6d/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6586bd34817b4c95c1e1352f
        failing since 30 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-23T11:05:18.804032  / # #

    2023-12-23T11:05:18.904574  export SHELL=3D/bin/sh

    2023-12-23T11:05:18.904679  #

    2023-12-23T11:05:19.005214  / # export SHELL=3D/bin/sh. /lava-12362232/=
environment

    2023-12-23T11:05:19.005355  =


    2023-12-23T11:05:19.105884  / # . /lava-12362232/environment/lava-12362=
232/bin/lava-test-runner /lava-12362232/1

    2023-12-23T11:05:19.106164  =


    2023-12-23T11:05:19.117922  / # /lava-12362232/bin/lava-test-runner /la=
va-12362232/1

    2023-12-23T11:05:19.179830  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-23T11:05:19.179909  + cd /lava-1236223<8>[   16.784752] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12362232_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

