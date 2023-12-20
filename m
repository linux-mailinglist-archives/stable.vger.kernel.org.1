Return-Path: <stable+bounces-8186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D2981A7BD
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 21:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259FB1C21144
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 20:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7647F1DA59;
	Wed, 20 Dec 2023 20:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="CYqeziK1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FF01DA4A
	for <stable@vger.kernel.org>; Wed, 20 Dec 2023 20:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3e6c86868so1033635ad.1
        for <stable@vger.kernel.org>; Wed, 20 Dec 2023 12:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703105203; x=1703710003; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5ChyXZm0P117NvS/qv55Kfj4ParoTHkyAqxwz+ruiTc=;
        b=CYqeziK14T+Aen4WB3js91n6O6PjiTTFjWq4mYBmsMlXdr0diEjm/uXLEsXle5kHWu
         0BGIrsVH8VJRV0yDOxR4IX7TfFzC5JhwvML/rNLgsA1tuVMWQvMvHlSDkFEiKFhE6CFF
         N+Zc0UktRwzC+l31Cd4y56g+JVUdME5cks7LzlFXlhMxDxoWUo+aPmbSwLxIBbJfV6+P
         JYKVhtzG6/yJcqtrqX+MNiyAOEvNR1XkCBo1axzbIfUWJTq8cwc5m4mGZMd/5CxCmt6z
         k5nvX6Oe+MXXKXirt8lGWLIIjqOeqkF54g5zUpzod3OjLWUxKSLJn65xmD3ckb7Qofid
         brjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703105203; x=1703710003;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ChyXZm0P117NvS/qv55Kfj4ParoTHkyAqxwz+ruiTc=;
        b=Ml6DyGuY+8kRne+5vbtOn2azzzXXiykgi5Xy8zlzffr7WnfmbXsGmu9MxbW1d8ve4k
         ww5gxrBRykPbU/90Co7UWyUJ55+33lWiMRvyNQEaQUy3IQEexESFi57QePW62aU2zWXa
         kx8v5usDrqkxW0XwF9RpHFwPgl0LL+gGqGhjjWtXLV1BP5nEJ/Ui55LjIatkNQjmx10H
         Kg3OKbs2UAiEzJUGEbMhwfD+b8jmkAOkzBUd+qLZ+vkHxLhCdiJuxllte6MomH3d2mqN
         LgzR8tcWXH9XaDYDn4c5iV7viMvTL9i+a1SefH0IE2YnVFv9gdcD7a0Zk2+nLxo3KFhR
         cPSw==
X-Gm-Message-State: AOJu0YxHwX3HzB+k+cF/JSP6/vuECf01Um0BJR07NddWTyQkFDHqyilo
	QDtssyBk5t+yVFIaiBM7Kaygd6ZirkiT2EOu8Gs=
X-Google-Smtp-Source: AGHT+IEL4kLmnLrifeS7PtWKHPkzpOuoQwKpXv6UIHwrA2b0uYd0zVAUI9qy2j3JNWH5LpHbndhZIA==
X-Received: by 2002:a17:902:e789:b0:1d0:6ffe:9fb with SMTP id cp9-20020a170902e78900b001d06ffe09fbmr23694350plb.89.1703105203502;
        Wed, 20 Dec 2023 12:46:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l7-20020a170902f68700b001d39af62b1fsm137400plg.232.2023.12.20.12.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 12:46:42 -0800 (PST)
Message-ID: <658352b2.170a0220.16c4a.0d9e@mx.google.com>
Date: Wed, 20 Dec 2023 12:46:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.144
Subject: stable/linux-5.15.y baseline: 220 runs, 5 regressions (v5.15.144)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable/linux-5.15.y baseline: 220 runs, 5 regressions (v5.15.144)

Regressions Summary
-------------------

platform                    | arch  | lab        | compiler | defconfig    =
                | regressions
----------------------------+-------+------------+----------+--------------=
----------------+------------
sun50i-h6-orangepi-3        | arm64 | lab-clabbe | gcc-10   | defconfig    =
                | 1          =

sun7i-a20-cubieboard2       | arm   | lab-clabbe | gcc-10   | multi_v7_defc=
onfig+kselftest | 1          =

sun8i-a33-olinuxino         | arm   | lab-clabbe | gcc-10   | multi_v7_defc=
onfig+kselftest | 1          =

sun8i-h3-orangepi-pc        | arm   | lab-clabbe | gcc-10   | multi_v7_defc=
onfig+kselftest | 1          =

sun8i-r40-bananapi-m2-ultra | arm   | lab-clabbe | gcc-10   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.15.y/kernel=
/v5.15.144/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.144
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      1d146b1875fc901ae6bfe26ec8fed15b8dcd97ae =



Test Regressions
---------------- =



platform                    | arch  | lab        | compiler | defconfig    =
                | regressions
----------------------------+-------+------------+----------+--------------=
----------------+------------
sun50i-h6-orangepi-3        | arm64 | lab-clabbe | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65831e27dbfb427157e13482

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.144/=
arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-orangepi-3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.144/=
arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-orangepi-3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65831e27dbfb427157e13487
        new failure (last pass: v5.15.80)

    2023-12-20T17:02:15.280732  <8>[   15.367866] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 449144_1.5.2.4.1>
    2023-12-20T17:02:15.385656  / # #
    2023-12-20T17:02:15.487247  export SHELL=3D/bin/sh
    2023-12-20T17:02:15.487893  #
    2023-12-20T17:02:15.588872  / # export SHELL=3D/bin/sh. /lava-449144/en=
vironment
    2023-12-20T17:02:15.589509  =

    2023-12-20T17:02:15.690503  / # . /lava-449144/environment/lava-449144/=
bin/lava-test-runner /lava-449144/1
    2023-12-20T17:02:15.691340  =

    2023-12-20T17:02:15.696007  / # /lava-449144/bin/lava-test-runner /lava=
-449144/1
    2023-12-20T17:02:15.728015  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                    | arch  | lab        | compiler | defconfig    =
                | regressions
----------------------------+-------+------------+----------+--------------=
----------------+------------
sun7i-a20-cubieboard2       | arm   | lab-clabbe | gcc-10   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/658320916c96fc6ac2e134c4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.144/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun7i-a20-cubie=
board2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.144/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun7i-a20-cubie=
board2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/658320916c96fc6ac2e13=
4c5
        failing since 41 days (last pass: v5.15.137, first fail: v5.15.138) =

 =



platform                    | arch  | lab        | compiler | defconfig    =
                | regressions
----------------------------+-------+------------+----------+--------------=
----------------+------------
sun8i-a33-olinuxino         | arm   | lab-clabbe | gcc-10   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/658320936c96fc6ac2e134c7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.144/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-a33-olinu=
xino.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.144/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-a33-olinu=
xino.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/658320936c96fc6ac2e13=
4c8
        failing since 41 days (last pass: v5.15.137, first fail: v5.15.138) =

 =



platform                    | arch  | lab        | compiler | defconfig    =
                | regressions
----------------------------+-------+------------+----------+--------------=
----------------+------------
sun8i-h3-orangepi-pc        | arm   | lab-clabbe | gcc-10   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/658322adffec9d020fe13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.144/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-h3-orange=
pi-pc.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.144/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-h3-orange=
pi-pc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/658322adffec9d020fe13=
476
        failing since 41 days (last pass: v5.15.137, first fail: v5.15.138) =

 =



platform                    | arch  | lab        | compiler | defconfig    =
                | regressions
----------------------------+-------+------------+----------+--------------=
----------------+------------
sun8i-r40-bananapi-m2-ultra | arm   | lab-clabbe | gcc-10   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/658323761c9b20fefae13526

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.144/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-r40-banan=
api-m2-ultra.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.144/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-r40-banan=
api-m2-ultra.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/658323761c9b20fefae13=
527
        failing since 41 days (last pass: v5.15.137, first fail: v5.15.138) =

 =20

