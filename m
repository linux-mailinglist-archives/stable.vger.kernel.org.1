Return-Path: <stable+bounces-2548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 405C57F8567
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 22:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB87528A7DB
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 21:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802513A8FF;
	Fri, 24 Nov 2023 21:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="bb+1Grjp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2017119A4
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 13:17:08 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cf6a67e290so17962515ad.1
        for <stable@vger.kernel.org>; Fri, 24 Nov 2023 13:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700860627; x=1701465427; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AkT87mY6YEo0L+BkZcGfHM6trfZlwJMNFukGCCYTubQ=;
        b=bb+1Grjpl+9PQByzuyR+XVUANc9FWHQBCpo7RJPHknDO5YTgGBuxQYCe7xhnkxcmpd
         RO7I8C8rUAUuFHFnrGBAi4CRN7WdZMG914bW7x/VFIe1Gz0Da781XCeMCYwccXXDHSSG
         RCPomSXwdgTJ29nbXquCe+yL//XGJ+L8ckRreLjVzmmc4wI83WmXUYosgbHk0JSE6q0s
         7jAxr67Uv3MmrB+Ji5Fo7wYQip+bmSxSPRpCiZbY7d0vID8iH8jKm6Zn9l6yCdAvVZs0
         6ep+WlKXo0JEpQX9TSwdOn+bLQmRBWUMsoG3okEqqFlJeNFFfCELbBpvZNFyLiUOaorT
         PHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700860627; x=1701465427;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AkT87mY6YEo0L+BkZcGfHM6trfZlwJMNFukGCCYTubQ=;
        b=BoWLsF/JdkwBULi8kDhP2FQl9ENbVVWnTycZpoSupF/ftuGF5IrKLRsl+PfXty0wIb
         GVMa2c1iaubywLBRwkSmXkGJ/WIkFVY9JvpsKDYbj8v9nN1yvJGsECThR1jAjmzZpfr5
         Y08Aw408hKnkHWwJPpxgf9XpNwUlQfRpd2cyPSVLTjgaPwz9V/9OcaC3I+o2j4/JNae1
         dQ3zSSvz39ivDcaRR2WtzQC6OQwJkDWUuDLP/MZQe89wS5u2QV08cuqjrO5mJXs9lzfQ
         JjRsth46ESbqR3pDcg/EOGbZE/XE+33muasT2WkirdHhPPgXnbEJhisVmzRqs+6eh+cm
         52Hw==
X-Gm-Message-State: AOJu0Ywk7NN/t24m+Ns0ZJIr2EGst+7uwRk/vVe1I9JHWt3Sm0nzLUfz
	k25qCQ+bMHOPsyCbXr5OfilAnS3hL34ShExUCd4=
X-Google-Smtp-Source: AGHT+IHN4OZHldOGT43aIADxJRxPsR6yhwG6iC/UBcoDURs60OnB8H2qepmMIBz0URrPD1bMZ+X58Q==
X-Received: by 2002:a17:903:2312:b0:1cc:b460:e6cc with SMTP id d18-20020a170903231200b001ccb460e6ccmr5286655plh.12.1700860627029;
        Fri, 24 Nov 2023 13:17:07 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m7-20020a1709026bc700b001c9bfd20d0csm3581133plt.124.2023.11.24.13.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 13:17:06 -0800 (PST)
Message-ID: <656112d2.170a0220.4030c.902e@mx.google.com>
Date: Fri, 24 Nov 2023 13:17:06 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: queue/4.19
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.19.299-97-g7841746109202
Subject: stable-rc/queue/4.19 baseline: 55 runs,
 2 regressions (v4.19.299-97-g7841746109202)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/4.19 baseline: 55 runs, 2 regressions (v4.19.299-97-g784174=
6109202)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
at91sam9g20ek    | arm  | lab-broonie | gcc-10   | multi_v5_defconfig  | 1 =
         =

beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F4.19/ker=
nel/v4.19.299-97-g7841746109202/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/4.19
  Describe: v4.19.299-97-g7841746109202
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      7841746109202b3ce2043656626af75730a07859 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
at91sam9g20ek    | arm  | lab-broonie | gcc-10   | multi_v5_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/6560e0fdb05d6727217e4a6d

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.299=
-97-g7841746109202/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91s=
am9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.299=
-97-g7841746109202/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91s=
am9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6560e0feb05d6727217e4a98
        failing since 2 days (last pass: v4.19.284-5-gd33af5806015, first f=
ail: v4.19.299-50-gaa3fbf0e1c59)

    2023-11-24T17:43:51.482203  + set +x
    2023-11-24T17:43:51.482660  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 270271_1.5.2=
.4.1>
    2023-11-24T17:43:51.596179  / # #
    2023-11-24T17:43:51.699219  export SHELL=3D/bin/sh
    2023-11-24T17:43:51.699987  #
    2023-11-24T17:43:51.801914  / # export SHELL=3D/bin/sh. /lava-270271/en=
vironment
    2023-11-24T17:43:51.802732  =

    2023-11-24T17:43:51.904699  / # . /lava-270271/environment/lava-270271/=
bin/lava-test-runner /lava-270271/1
    2023-11-24T17:43:51.906033  =

    2023-11-24T17:43:51.909589  / # /lava-270271/bin/lava-test-runner /lava=
-270271/1 =

    ... (12 line(s) more)  =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/6560e23bef4dc5f0ac7e4a81

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.299=
-97-g7841746109202/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.299=
-97-g7841746109202/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6560e23cef4dc5f0ac7e4ab4
        new failure (last pass: v4.19.299-70-gb7330b98ae65)

    2023-11-24T17:49:24.186141  + set +x<8>[   15.788630] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 270282_1.5.2.4.1>
    2023-11-24T17:49:24.186511  =

    2023-11-24T17:49:24.298275  / # #
    2023-11-24T17:49:24.401298  export SHELL=3D/bin/sh
    2023-11-24T17:49:24.401875  #
    2023-11-24T17:49:24.503139  / # export SHELL=3D/bin/sh. /lava-270282/en=
vironment
    2023-11-24T17:49:24.503539  =

    2023-11-24T17:49:24.604806  / # . /lava-270282/environment/lava-270282/=
bin/lava-test-runner /lava-270282/1
    2023-11-24T17:49:24.605512  =

    2023-11-24T17:49:24.609973  / # /lava-270282/bin/lava-test-runner /lava=
-270282/1 =

    ... (12 line(s) more)  =

 =20

