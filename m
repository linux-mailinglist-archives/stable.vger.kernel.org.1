Return-Path: <stable+bounces-8199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7BD81A8B8
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 23:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A571C22088
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 22:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECBD487A3;
	Wed, 20 Dec 2023 22:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="hyT/Cp2h"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586F33DBBA
	for <stable@vger.kernel.org>; Wed, 20 Dec 2023 22:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d3ec3db764so1155985ad.2
        for <stable@vger.kernel.org>; Wed, 20 Dec 2023 14:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703109973; x=1703714773; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KCNsqxNkne3Uep7MoxM7FxQwFF/dPEkGnFGw4ECDuck=;
        b=hyT/Cp2h8+Rb1FEEvPefrJxeiaNiTFShmh5AoLR7mxOQ6GpdPzpV9t602vhf3JFLVj
         +/JjXqfuwK608mGZSI5PwXut7Xpi1d24V6vdYnCaHFE/wb5fnM3yXvToRPUXMPEsKek0
         Xlb1scYdVKeN5wIEhjVIIWMyGdSgb76QzveYUpIQB8VWLzFf6bYBgzNDjDgjsu3PbLTP
         HcfPb4UBjZ85l8eSpPUxec22EWWY6zA6RI2WBjWDnl/RNLsxKB3ojGUeViscGHVPOmb0
         CxHr8X1Oe7iYmh9c9gD9eVZm80Xr9ljnoiC48diY8nHvlxT/nj2OyeSl3BanfUEIo8z8
         fS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703109973; x=1703714773;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCNsqxNkne3Uep7MoxM7FxQwFF/dPEkGnFGw4ECDuck=;
        b=YuZo8S5+bGn8vNtAdGK1BHlJhyDZboZC91PKzMWhAZMdGx++C30kepiE6IJuOGnEiw
         f1vOYz+IwFVhY3DYTTPh6t/JYz70nzVaRnGmd35cIRFy4WmO1ZoGlXc7RsdbadtInZS9
         KFdioyfyRy1yftg8eOCb51GhdUJRvAJDjN/PvAPZr4V2VYMR59FM7Q/3Z1j0UyXX/khw
         /8gVFTKhZSyVaaVNzQkt1+wrocMEH2ok6eHLeqis2bRDdrwCqpqjbj6JUmq43DFMZVpX
         k0lNxY1f2D3HD2uzn1ekARYCbPc/HnmK32diFZ3zaxmt7q72LBCOZ29an0paHk+t1bbU
         krsA==
X-Gm-Message-State: AOJu0Yya2WVhElcnIOHd3zctQuS2SdBeExq/9hmIvvUvMA91qQMcyWec
	U3QnBMu0qeISWf/JjUfk1Lt+jAr3fkQkqkt8hoM=
X-Google-Smtp-Source: AGHT+IG1lWt9PAnFiF2laP5qhNvoHFRB861e3Heo0XzLmWVo0aalaFvSscohZYbd6MVzg4z/w/1jMQ==
X-Received: by 2002:a17:902:ceca:b0:1d3:f112:2bff with SMTP id d10-20020a170902ceca00b001d3f1122bffmr1020850plg.90.1703109973177;
        Wed, 20 Dec 2023 14:06:13 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902eec600b001d3d81c795bsm196086plb.271.2023.12.20.14.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 14:06:12 -0800 (PST)
Message-ID: <65836554.170a0220.569b0.0f73@mx.google.com>
Date: Wed, 20 Dec 2023 14:06:12 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.303
Subject: stable/linux-4.19.y baseline: 121 runs, 2 regressions (v4.19.303)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable/linux-4.19.y baseline: 121 runs, 2 regressions (v4.19.303)

Regressions Summary
-------------------

platform         | arch  | lab          | compiler | defconfig           | =
regressions
-----------------+-------+--------------+----------+---------------------+-=
-----------
beaglebone-black | arm   | lab-cip      | gcc-10   | omap2plus_defconfig | =
1          =

meson-gxm-q200   | arm64 | lab-baylibre | gcc-10   | defconfig           | =
1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-4.19.y/kernel=
/v4.19.303/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-4.19.y
  Describe: v4.19.303
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      74ad23cd9b482897e0421fd62b3662c9b4740959 =



Test Regressions
---------------- =



platform         | arch  | lab          | compiler | defconfig           | =
regressions
-----------------+-------+--------------+----------+---------------------+-=
-----------
beaglebone-black | arm   | lab-cip      | gcc-10   | omap2plus_defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/65833cdbc266b909d8e13484

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.303/=
arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.303/=
arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65833cdbc266b909d8e134b5
        new failure (last pass: v4.19.302)

    2023-12-20T19:12:55.035760  / # #
    2023-12-20T19:12:55.136983  export SHELL=3D/bin/sh
    2023-12-20T19:12:55.137329  #
    2023-12-20T19:12:55.238001  / # export SHELL=3D/bin/sh. /lava-1063034/e=
nvironment
    2023-12-20T19:12:55.238427  =

    2023-12-20T19:12:55.339077  / # . /lava-1063034/environment/lava-106303=
4/bin/lava-test-runner /lava-1063034/1
    2023-12-20T19:12:55.339573  =

    2023-12-20T19:12:55.380925  / # /lava-1063034/bin/lava-test-runner /lav=
a-1063034/1
    2023-12-20T19:12:55.559698  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-20T19:12:55.560007  + cd /lava-1063034/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform         | arch  | lab          | compiler | defconfig           | =
regressions
-----------------+-------+--------------+----------+---------------------+-=
-----------
meson-gxm-q200   | arm64 | lab-baylibre | gcc-10   | defconfig           | =
1          =


  Details:     https://kernelci.org/test/plan/id/658335d8d5550b92d6e1347a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.303/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.303/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/658335d8d5550b9=
2d6e13481
        failing since 42 days (last pass: v4.19.288, first fail: v4.19.298)
        1 lines

    2023-12-20T18:43:16.171365  <4>[   50.883259] ------------[ cut here ]-=
-----------
    2023-12-20T18:43:16.171787  <4>[   50.883345] WARNING: CPU: 0 PID: 0 at=
 drivers/mmc/host/meson-gx-mmc.c:1039 meson_mmc_irq+0x1c8/0x1dc
    2023-12-20T18:43:16.213088  <4>[   50.891814] Modules linked in: ipv6 r=
ealtek meson_gxl dwmac_generic meson_dw_hdmi crc32_ce crct10dif_ce meson_rn=
g meson_drm rng_core dw_hdmi drm_kms_helper dwmac_meson8b stmmac_platform d=
rm meson_ir stmmac rc_core pwm_meson meson_gxbb_wdt drm_panel_orientation_q=
uirks nvmem_meson_efuse adc_keys input_polldev
    2023-12-20T18:43:16.214477  <4>[   50.919073] CPU: 0 PID: 0 Comm: swapp=
er/0 Tainted: G        W         4.19.303 #1
    2023-12-20T18:43:16.214677  <4>[   50.926744] Hardware name: Amlogic Me=
son GXM (S912) Q200 Development Board (DT)
    2023-12-20T18:43:16.215089  <4>[   50.934249] pstate: 60000085 (nZCv da=
If -PAN -UAO)
    2023-12-20T18:43:16.215282  <4>[   50.939252] pc : meson_mmc_irq+0x1c8/=
0x1dc
    2023-12-20T18:43:16.215464  <4>[   50.943563] lr : meson_mmc_irq+0x1c8/=
0x1dc
    2023-12-20T18:43:16.215846  <4>[   50.947875] sp : ffff000008003cc0
    2023-12-20T18:43:16.217976  <4>[   50.951411] x29: ffff000008003cc0 x28=
: 0000000000000080  =

    ... (37 line(s) more)  =

 =20

