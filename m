Return-Path: <stable+bounces-7924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEAB818A2F
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 15:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC52C1F2B2F9
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 14:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AC21B29A;
	Tue, 19 Dec 2023 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="b8jv5VQv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FEA225D1
	for <stable@vger.kernel.org>; Tue, 19 Dec 2023 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d075392ff6so31655675ad.1
        for <stable@vger.kernel.org>; Tue, 19 Dec 2023 06:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702996681; x=1703601481; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5cFF8uZEqVa03wUezlJN4hXaGvQY7GR61NwqHsSmrhY=;
        b=b8jv5VQv6ztYEXHcLxlB9JWPjXr1HBLaZjGXcR5gfF06J7iK7YQBOlyOchDHqWKgz3
         VowwJlLzwBkPlWjK3Bcjm25ubmO4g2fSEMbx2W70qi0cjJHDK0IObwKgblacbw4cAkoE
         cuQFVvwJ8GpR87oBZxmI8ZOKSYuKYLE/JSqqUHPUcf6FgAySPUtRyPsHi+DTFN91sE4P
         bGdm4ma+JY1DDj0cm1jaPRZB4gJZW4qpNV1wGmHPbwO6ify9HDk7RQ2BYXPABb+iYqFY
         aULHEb1rlK0pcFa757n94qSUI+u6PiONSkCjL68Mzl1a4ZpDEA4YSDAEc+w/5Dp7ztCu
         bXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702996681; x=1703601481;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5cFF8uZEqVa03wUezlJN4hXaGvQY7GR61NwqHsSmrhY=;
        b=mfPFkHBfbbJo1tbdFWptCU3LKE7zA666YgCgpSf441ReUwGTKshQzVXDDdDlnbCvSx
         RR5v5D8uC3zayEJ9G3rYVO2k3XYbAcPie/Z0voj3q5+CfzQqlUYT1wrLdPnztrsUNduJ
         KFWmuMGKE8uKxGkJI7WqbfWZcO6IDLKCYAZXyPq1FWyN8iHhwXEWncRcRv4WpJJCfnSG
         y420E9YIkE/aPUxqYKo5tfxIe2O5JztvsJ2kCSGgstFRLauKUe8rk8WaPRIr2Bl9LqW3
         E9yMhJ/nBN/BAgs8bn73YGsJbKhqNpWdO2ry92J0kqEuATykiA1ISkTg5MVcnXSwOH7j
         lpIg==
X-Gm-Message-State: AOJu0Yyq3d2uf7GxTNkcdfcC84+MrX0dLJ6HQckUwtvXQpSg4Dxux232
	mT77hx8n9RzW/wy6YPntC5QbEzscM12WFncg6eI=
X-Google-Smtp-Source: AGHT+IGvbB2bk4AWAafGSvsZRuTTNIHZI0k6wWwttH0JNh94vhxyaXitkNKq4BPasxFnzy/F2hch4g==
X-Received: by 2002:a17:902:dacf:b0:1d3:dc48:853 with SMTP id q15-20020a170902dacf00b001d3dc480853mr1453235plx.2.1702996680644;
        Tue, 19 Dec 2023 06:38:00 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j21-20020a170902759500b001d326103500sm15771926pll.277.2023.12.19.06.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 06:37:59 -0800 (PST)
Message-ID: <6581aac7.170a0220.d482e.00ab@mx.google.com>
Date: Tue, 19 Dec 2023 06:37:59 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.204-61-g163d4e782432
Subject: stable-rc/linux-5.10.y baseline: 111 runs,
 3 regressions (v5.10.204-61-g163d4e782432)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-5.10.y baseline: 111 runs, 3 regressions (v5.10.204-61-g163=
d4e782432)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
juno-uboot         | arm64 | lab-broonie   | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.204-61-g163d4e782432/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.204-61-g163d4e782432
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      163d4e78243233162937b69caa8e5368a4fba1b0 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
juno-uboot         | arm64 | lab-broonie   | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65817b218033dfffe4e1348f

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
04-61-g163d4e782432/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.=
txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
04-61-g163d4e782432/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65817b218033dfffe4e134ca
        failing since 5 days (last pass: v5.10.203-98-g670205df0377e, first=
 fail: v5.10.204)

    2023-12-19T11:14:17.032125  <8>[   16.117956] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 373795_1.5.2.4.1>
    2023-12-19T11:14:17.140353  / # #
    2023-12-19T11:14:17.243224  export SHELL=3D/bin/sh
    2023-12-19T11:14:17.243980  #
    2023-12-19T11:14:17.345945  / # export SHELL=3D/bin/sh. /lava-373795/en=
vironment
    2023-12-19T11:14:17.346735  =

    2023-12-19T11:14:17.448736  / # . /lava-373795/environment/lava-373795/=
bin/lava-test-runner /lava-373795/1
    2023-12-19T11:14:17.450072  =

    2023-12-19T11:14:17.463911  / # /lava-373795/bin/lava-test-runner /lava=
-373795/1
    2023-12-19T11:14:17.522714  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6581799b4ad8501f5fe134a0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
04-61-g163d4e782432/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
04-61-g163d4e782432/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6581799b4ad8501f5fe134a5
        failing since 69 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-12-19T11:07:47.779332  / # #
    2023-12-19T11:07:47.880966  export SHELL=3D/bin/sh
    2023-12-19T11:07:47.881605  #
    2023-12-19T11:07:47.982580  / # export SHELL=3D/bin/sh. /lava-448955/en=
vironment
    2023-12-19T11:07:47.983212  =

    2023-12-19T11:07:48.084286  / # . /lava-448955/environment/lava-448955/=
bin/lava-test-runner /lava-448955/1
    2023-12-19T11:07:48.085346  =

    2023-12-19T11:07:48.089377  / # /lava-448955/bin/lava-test-runner /lava=
-448955/1
    2023-12-19T11:07:48.156603  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-19T11:07:48.157001  + cd /lava-448955/<8>[   17.398725] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 448955_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/658179b2d6dcdef87fe1348a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
04-61-g163d4e782432/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
04-61-g163d4e782432/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658179b2d6dcdef87fe1348f
        failing since 69 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-12-19T11:15:57.143505  / # #

    2023-12-19T11:15:57.244091  export SHELL=3D/bin/sh

    2023-12-19T11:15:57.244234  #

    2023-12-19T11:15:57.344722  / # export SHELL=3D/bin/sh. /lava-12313498/=
environment

    2023-12-19T11:15:57.344857  =


    2023-12-19T11:15:57.445435  / # . /lava-12313498/environment/lava-12313=
498/bin/lava-test-runner /lava-12313498/1

    2023-12-19T11:15:57.445760  =


    2023-12-19T11:15:57.457347  / # /lava-12313498/bin/lava-test-runner /la=
va-12313498/1

    2023-12-19T11:15:57.517780  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-19T11:15:57.518255  + cd /lava-1231349<8>[   18.236986] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12313498_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

