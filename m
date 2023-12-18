Return-Path: <stable+bounces-7831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AECF817BDD
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 21:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98BBD1F247D0
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 20:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232447206D;
	Mon, 18 Dec 2023 20:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ALHLzsu9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722BE72050
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 20:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d3ad3ad517so7358365ad.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 12:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702931354; x=1703536154; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=copOvz5cXZY3qp3SW66pa9VgUT9ygdDizioi+h4nAyQ=;
        b=ALHLzsu9rjrKSZSqXj1A4XS+CTtP8e9grKRU7qpg5L7Rt1+xJUctK9e/djK7A8+ZUN
         zgtx7SPafGyQLrLo1B2egiyop1tLhsnapgFopYbV3DTX0iNmUKbM/gWs+famGAwddk/h
         FJNSp1zF7mDgzWB6EHE7FiABW48U6GD+Y6YhbqiGOaLEgMMbh0MkhCnKMxuF8k8gGzuI
         1/uS1KhUb20MYSDZTDc17Rz7pNmqWq0KLY3cTXg2UsPol/GZpg0pXE1Zayy9olbkIbcE
         +lqFveh5mWbnjODr0DTKi7fllS6Nnt/orp7AnZKvINrdbsuWcSMwoV7jGX6NvWc/yN8a
         Wy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702931354; x=1703536154;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=copOvz5cXZY3qp3SW66pa9VgUT9ygdDizioi+h4nAyQ=;
        b=wu4qX8hnwNF7JYotmjYVR1DO54ijNCh+BkEc64ZuwQKUPs8GER+rOaabLg+OTzQmDv
         Pf4Otc7eyyW8BhIl1m5KopTocamjPXF5kMu1JBbM8uO6PpKz/hzH1qzpfC92smd+2zCL
         KWF5v2uTRw1qhuvfMgKPFkP9dAGjfVvTLv5SaT/KPjiGOc7hE7JxSE7W7qeMYoSx8Zfo
         NlqQvJmIal1mkyv3fy9t2bJk7XBaaQIhLgPS2CcwMs/4r/ArcdkAoJAwyKNf2NreHWBk
         wZkESF7U0vLBGbut+yiaCeIHJ2Figq5uwPxLzJAC99a23SXTr6G33kcEpwmiqSTjz348
         r4hw==
X-Gm-Message-State: AOJu0Yza6KY0iVW1TcAWBM5q0XJtzNtJHXYrx5YCsZMZShqQU3rb5cWV
	hqUmCtQeTCiXFBeWs9AHeWIh8ayd6kZraKG2kKk=
X-Google-Smtp-Source: AGHT+IE2pneFNO21Q/WLSWMLEhlsAF98SRZcAaP18LcovyfsGj6oz6fl+Og5r7APomua8T/QNjAI1A==
X-Received: by 2002:a17:902:e54e:b0:1d0:70f7:ba02 with SMTP id n14-20020a170902e54e00b001d070f7ba02mr9566744plf.92.1702931354229;
        Mon, 18 Dec 2023 12:29:14 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902bd4200b001d369beee67sm5124945plx.131.2023.12.18.12.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 12:29:13 -0800 (PST)
Message-ID: <6580ab99.170a0220.3e975.ce72@mx.google.com>
Date: Mon, 18 Dec 2023 12:29:13 -0800 (PST)
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
X-Kernelci-Kernel: v4.19.302-37-gc6ac8872cc6c4
Subject: stable-rc/linux-4.19.y baseline: 95 runs,
 3 regressions (v4.19.302-37-gc6ac8872cc6c4)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-4.19.y baseline: 95 runs, 3 regressions (v4.19.302-37-gc6ac=
8872cc6c4)

Regressions Summary
-------------------

platform          | arch | lab           | compiler | defconfig           |=
 regressions
------------------+------+---------------+----------+---------------------+=
------------
at91sam9g20ek     | arm  | lab-broonie   | gcc-10   | multi_v5_defconfig  |=
 1          =

beaglebone-black  | arm  | lab-broonie   | gcc-10   | omap2plus_defconfig |=
 1          =

rk3288-veyron-jaq | arm  | lab-collabora | gcc-10   | multi_v7_defconfig  |=
 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.19.y/ker=
nel/v4.19.302-37-gc6ac8872cc6c4/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.302-37-gc6ac8872cc6c4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      c6ac8872cc6c4a8be4cb67fc13d5ab7e2004813b =



Test Regressions
---------------- =



platform          | arch | lab           | compiler | defconfig           |=
 regressions
------------------+------+---------------+----------+---------------------+=
------------
at91sam9g20ek     | arm  | lab-broonie   | gcc-10   | multi_v5_defconfig  |=
 1          =


  Details:     https://kernelci.org/test/plan/id/6580764dc034c4e1f7e134af

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
02-37-gc6ac8872cc6c4/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at9=
1sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
02-37-gc6ac8872cc6c4/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at9=
1sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6580764dc034c4e1f7e134e0
        failing since 20 days (last pass: v4.19.299-93-g263cae4d5493f, firs=
t fail: v4.19.299-93-gc66845304b463)

    2023-12-18T16:41:11.758141  + set +x
    2023-12-18T16:41:11.758611  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 369773_1.5.2=
.4.1>
    2023-12-18T16:41:11.870723  / # #
    2023-12-18T16:41:11.973772  export SHELL=3D/bin/sh
    2023-12-18T16:41:11.974605  #
    2023-12-18T16:41:12.076642  / # export SHELL=3D/bin/sh. /lava-369773/en=
vironment
    2023-12-18T16:41:12.077435  =

    2023-12-18T16:41:12.179589  / # . /lava-369773/environment/lava-369773/=
bin/lava-test-runner /lava-369773/1
    2023-12-18T16:41:12.181012  =

    2023-12-18T16:41:12.183507  / # /lava-369773/bin/lava-test-runner /lava=
-369773/1 =

    ... (12 line(s) more)  =

 =



platform          | arch | lab           | compiler | defconfig           |=
 regressions
------------------+------+---------------+----------+---------------------+=
------------
beaglebone-black  | arm  | lab-broonie   | gcc-10   | omap2plus_defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/65807711c2c1a06fdfe134d7

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
02-37-gc6ac8872cc6c4/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-be=
aglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
02-37-gc6ac8872cc6c4/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-be=
aglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65807711c2c1a06fdfe13509
        new failure (last pass: v4.19.302-32-gb2fab883a7817)

    2023-12-18T16:44:25.903778  + set +x
    2023-12-18T16:44:25.907812  <8>[   18.595603] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 369786_1.5.2.4.1>
    2023-12-18T16:44:26.017893  / # #
    2023-12-18T16:44:26.119817  export SHELL=3D/bin/sh
    2023-12-18T16:44:26.120339  #
    2023-12-18T16:44:26.221700  / # export SHELL=3D/bin/sh. /lava-369786/en=
vironment
    2023-12-18T16:44:26.222298  =

    2023-12-18T16:44:26.323608  / # . /lava-369786/environment/lava-369786/=
bin/lava-test-runner /lava-369786/1
    2023-12-18T16:44:26.324283  =

    2023-12-18T16:44:26.332985  / # /lava-369786/bin/lava-test-runner /lava=
-369786/1 =

    ... (12 line(s) more)  =

 =



platform          | arch | lab           | compiler | defconfig           |=
 regressions
------------------+------+---------------+----------+---------------------+=
------------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-10   | multi_v7_defconfig  |=
 1          =


  Details:     https://kernelci.org/test/plan/id/65807aaeb351ca3fe3e13486

  Results:     60 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
02-37-gc6ac8872cc6c4/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-r=
k3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
02-37-gc6ac8872cc6c4/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-r=
k3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cros-ec-keyb-probed: https://kernelci.org/test/case/id/=
65807aaeb351ca3fe3e134bd
        new failure (last pass: v4.19.302-32-gb2fab883a7817)

    2023-12-18T17:07:49.860741  <8>[   10.344823] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-keyb-driver-present RESULT=3Dpass>

    2023-12-18T17:07:50.872403  /lava-12305479/1/../bin/lava-test-case

    2023-12-18T17:07:50.881002  <8>[   11.365862] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-keyb-probed RESULT=3Dfail>
   =

 =20

