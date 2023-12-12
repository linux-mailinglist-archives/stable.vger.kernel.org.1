Return-Path: <stable+bounces-6425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D132380E855
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 10:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 597D6B20A24
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 09:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3E05914E;
	Tue, 12 Dec 2023 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="XTWApXN1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96042CF
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 01:56:56 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d04c097e34so42393765ad.0
        for <stable@vger.kernel.org>; Tue, 12 Dec 2023 01:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702375015; x=1702979815; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kK0qI6K+3uJLUVqlnaBncm1JA3jmNizQmDOVXzNN634=;
        b=XTWApXN1jkm6tZMbPj3lmbvW6Y2Rtn/2qSx3FyrdytnyZU7QIIkBCcLn0X3XHRB4f7
         Rm9BzidGYGtnIN/m2KOaqiXMvg/+FuvJDWDpiLb/1zodah4rVTu5jlXI3Jf+8trrBs7j
         2iXAL90JcEwQFNLHhIhAFT4J3x8sJZSeEqfj5eH0hMJAIVYTiWuO2a2qHkvK54HveTid
         4WnZ9tQGII7WqzZGePnHm/NU6jch5AMJkucZGgGv6As/NvtEhutXLlhHjUPfvRlqveLR
         AnamP7G9HmAR1yA5lAhP/KnUf0HCzTuL1ms3d3JdMEEWbu/Le9Ope9/rFXgP/MkThNg+
         QIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702375015; x=1702979815;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kK0qI6K+3uJLUVqlnaBncm1JA3jmNizQmDOVXzNN634=;
        b=ENZ2KSJ3QhoA+tA6cBAoRvOsAmHRJ7ShrSoxIj0eawMcyhBfcj0ECIf1HSYshSIXdT
         VtsadSlrSAGHAbRMPKYD1kJnnk9IDRzSaaVzg9VRLTAMcfPsGxEzC0ySy8bk4N+Tpn85
         nm0r6ENXn7OtQYoJk9Wcc70DWuPr6uLbmMZPYiByQN8zXMmaZgi/b5ysex09EkNrMiP5
         zqZDibgcorKiWV5wjPU+JuUPSySBnDEmbulZ5sfHWqYcfByywNNckqXqtOyVy7hopJwq
         xK3ypP9tlRSYMHVeGX+njhsffv0vOuAu9onAintgxdF2Fh5dQ1SmJiQt9RMUvNDsY8nN
         QbAw==
X-Gm-Message-State: AOJu0YwmPn1FufJSigZmPMaul/TmSkAK75ACxL1q+zKmjjOXDWxXICwi
	Ci63GRLSNqmaC9Wt+cAdASvBIA7DbCdPdaUH8LK8LQ==
X-Google-Smtp-Source: AGHT+IGLluK8+dC8y6atWkoVi1Wi2lTRtjtc8sRBU8LKDDuq3WLrgZYBB+7HqL8+zMuYY1+Rx19gRg==
X-Received: by 2002:a17:903:18a:b0:1d0:acd4:e711 with SMTP id z10-20020a170903018a00b001d0acd4e711mr7680251plg.15.1702375015393;
        Tue, 12 Dec 2023 01:56:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jk4-20020a170903330400b001d09c8e26absm8223109plb.283.2023.12.12.01.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:56:54 -0800 (PST)
Message-ID: <65782e66.170a0220.e1f1a.785f@mx.google.com>
Date: Tue, 12 Dec 2023 01:56:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.301-56-g47e943e888e77
Subject: stable-rc/linux-4.19.y baseline: 45 runs,
 2 regressions (v4.19.301-56-g47e943e888e77)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-4.19.y baseline: 45 runs, 2 regressions (v4.19.301-56-g47e9=
43e888e77)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
at91sam9g20ek    | arm  | lab-broonie | gcc-10   | multi_v5_defconfig  | 1 =
         =

beaglebone-black | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.19.y/ker=
nel/v4.19.301-56-g47e943e888e77/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.301-56-g47e943e888e77
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      47e943e888e77ca2629ef0cb4b60c5d5d1581e2d =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
at91sam9g20ek    | arm  | lab-broonie | gcc-10   | multi_v5_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/6577fc77722caae59ae134b3

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
01-56-g47e943e888e77/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at9=
1sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
01-56-g47e943e888e77/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at9=
1sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6577fc77722caae59ae134e9
        failing since 14 days (last pass: v4.19.299-93-g263cae4d5493f, firs=
t fail: v4.19.299-93-gc66845304b463)

    2023-12-12T06:23:11.408716  + set +x
    2023-12-12T06:23:11.409209  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 343343_1.5.2=
.4.1>
    2023-12-12T06:23:11.523267  / # #
    2023-12-12T06:23:11.626144  export SHELL=3D/bin/sh
    2023-12-12T06:23:11.626923  #
    2023-12-12T06:23:11.728901  / # export SHELL=3D/bin/sh. /lava-343343/en=
vironment
    2023-12-12T06:23:11.729635  =

    2023-12-12T06:23:11.831721  / # . /lava-343343/environment/lava-343343/=
bin/lava-test-runner /lava-343343/1
    2023-12-12T06:23:11.833052  =

    2023-12-12T06:23:11.836626  / # /lava-343343/bin/lava-test-runner /lava=
-343343/1 =

    ... (12 line(s) more)  =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/657800364252f9d763e1349b

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
01-56-g47e943e888e77/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beagle=
bone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
01-56-g47e943e888e77/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beagle=
bone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657800364252f9d763e134d1
        new failure (last pass: v4.19.301)

    2023-12-12T06:39:15.409134  / # #
    2023-12-12T06:39:15.510116  export SHELL=3D/bin/sh
    2023-12-12T06:39:15.510542  #
    2023-12-12T06:39:15.611317  / # export SHELL=3D/bin/sh. /lava-1057186/e=
nvironment
    2023-12-12T06:39:15.611703  =

    2023-12-12T06:39:15.712554  / # . /lava-1057186/environment/lava-105718=
6/bin/lava-test-runner /lava-1057186/1
    2023-12-12T06:39:15.713193  =

    2023-12-12T06:39:15.756880  / # /lava-1057186/bin/lava-test-runner /lav=
a-1057186/1
    2023-12-12T06:39:15.932117  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-12T06:39:15.932431  + cd /lava-1057186/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

