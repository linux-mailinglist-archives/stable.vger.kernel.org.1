Return-Path: <stable+bounces-3586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 862B37FFF31
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 00:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10A26B20E84
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 23:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FDD61FA9;
	Thu, 30 Nov 2023 23:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="G5D+MoUS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FF4D50
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 15:07:54 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-280351c32afso1475875a91.1
        for <stable@vger.kernel.org>; Thu, 30 Nov 2023 15:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701385673; x=1701990473; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ObucomfR6uxs5Z72PgoCw5kuJM/inn1rwFLmYaiXQ9w=;
        b=G5D+MoUSvNxghpqHDDxUfUkHoGzDmongUSRpUXtUXJ/dMFeNIM+eQBtTz6QQHPnlUA
         N55815mJxv4mNsFfHalCfPoPQj9YNxQhbrlemeDSz69D/Vy4TUwWCwwjuaha4Z0HPiCU
         dComEU94vLVEcalknTjiqr2Q9BZ7gYz1QYBQfJ6GoUj5OYAHUrp2Os06jomBD7egN+yx
         ZXcALofXoBzqgciAPCIbjsj81yCfjFv6Rz0kUdYi2l+yRWRQQ06mq3SNP1Jd7XgeDbvy
         kpPrGtFTcKzYtqQ8tvCFmHYjKY5NiGiB1z7lrRtIM6VQC7EWQHb+kOtI5w+bW3tYERiv
         EvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701385673; x=1701990473;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ObucomfR6uxs5Z72PgoCw5kuJM/inn1rwFLmYaiXQ9w=;
        b=QI1vku5w21rip6YMbDCbtTmph46trZR2Jqa2fUXWm94wDBEbNlxdhcXr0crx6dhgGd
         nsh+CVoebgPM2nkrcRlrqAq/ROTAIN2nAyu5Mhetj83biqWVNf81XCt/4AYIhGiOajox
         5SkZ4+iYCs7eK/IDJQE/ey5M9hw+R0xCGW8+SkjEPWEpQuBTMFaEnwt0mqEUsXwCp92J
         GyoaC0+zeW6WD8tZsMfTeLg5oSgr1HoqwoIv4kwQ7nkKk0MgKCdxO2C8oVXCynWgE160
         Pg2J1m7h848PyAA3gHbYanPXWWZf3JyM5pf1cyT5rdh8x1rfgywGVYPaNY44+ddWvRXV
         JPfQ==
X-Gm-Message-State: AOJu0Yw9alnNpJvHT/nqc9FE0A4tO3rEBhECEx2g6A1clu6Kn+FN4Ddz
	VrLcocoZJ0CptM5hRXlppBNuU2oBfQwffcxHrQdNnw==
X-Google-Smtp-Source: AGHT+IEhG4bTF3KiSEyfBerftSNeoCvrBHz7zCQxVttwXtqTtTsgfnyhiXUOAwxrHd64rbgKqkSBkA==
X-Received: by 2002:a17:90b:1d8c:b0:285:b7b9:dcd5 with SMTP id pf12-20020a17090b1d8c00b00285b7b9dcd5mr19075061pjb.36.1701385673277;
        Thu, 30 Nov 2023 15:07:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 13-20020a17090a034d00b0028656e226efsm167287pjf.1.2023.11.30.15.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 15:07:52 -0800 (PST)
Message-ID: <656915c8.170a0220.fd355.0ab1@mx.google.com>
Date: Thu, 30 Nov 2023 15:07:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.19.300-33-g467e4247b42cf
Subject: stable-rc/linux-4.19.y baseline: 129 runs,
 4 regressions (v4.19.300-33-g467e4247b42cf)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-4.19.y baseline: 129 runs, 4 regressions (v4.19.300-33-g467=
e4247b42cf)

Regressions Summary
-------------------

platform             | arch  | lab          | compiler | defconfig         =
  | regressions
---------------------+-------+--------------+----------+-------------------=
--+------------
at91sam9g20ek        | arm   | lab-broonie  | gcc-10   | multi_v5_defconfig=
  | 1          =

beaglebone-black     | arm   | lab-broonie  | gcc-10   | omap2plus_defconfi=
g | 1          =

meson-gxm-q200       | arm64 | lab-baylibre | gcc-10   | defconfig         =
  | 1          =

sun8i-h3-orangepi-pc | arm   | lab-clabbe   | gcc-10   | multi_v7_defconfig=
  | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.19.y/ker=
nel/v4.19.300-33-g467e4247b42cf/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.300-33-g467e4247b42cf
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      467e4247b42cf850bd3a413fc5ef2909a295c61f =



Test Regressions
---------------- =



platform             | arch  | lab          | compiler | defconfig         =
  | regressions
---------------------+-------+--------------+----------+-------------------=
--+------------
at91sam9g20ek        | arm   | lab-broonie  | gcc-10   | multi_v5_defconfig=
  | 1          =


  Details:     https://kernelci.org/test/plan/id/6568e3c13b72ca751a7e4a97

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
00-33-g467e4247b42cf/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at9=
1sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
00-33-g467e4247b42cf/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at9=
1sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6568e3c13b72ca751a7e4acd
        failing since 2 days (last pass: v4.19.299-93-g263cae4d5493f, first=
 fail: v4.19.299-93-gc66845304b463)

    2023-11-30T19:33:44.576245  + set +x
    2023-11-30T19:33:44.576741  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 293089_1.5.2=
.4.1>
    2023-11-30T19:33:44.689996  / # #
    2023-11-30T19:33:44.793228  export SHELL=3D/bin/sh
    2023-11-30T19:33:44.794051  #
    2023-11-30T19:33:44.896074  / # export SHELL=3D/bin/sh. /lava-293089/en=
vironment
    2023-11-30T19:33:44.896862  =

    2023-11-30T19:33:44.998968  / # . /lava-293089/environment/lava-293089/=
bin/lava-test-runner /lava-293089/1
    2023-11-30T19:33:45.000438  =

    2023-11-30T19:33:45.003830  / # /lava-293089/bin/lava-test-runner /lava=
-293089/1 =

    ... (12 line(s) more)  =

 =



platform             | arch  | lab          | compiler | defconfig         =
  | regressions
---------------------+-------+--------------+----------+-------------------=
--+------------
beaglebone-black     | arm   | lab-broonie  | gcc-10   | omap2plus_defconfi=
g | 1          =


  Details:     https://kernelci.org/test/plan/id/6568e4da986997bb597e4a9e

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
00-33-g467e4247b42cf/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-be=
aglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
00-33-g467e4247b42cf/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-be=
aglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6568e4da986997bb597e4ad4
        new failure (last pass: v4.19.300)

    2023-11-30T19:38:33.044164  + set +x<8>[   18.698545] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 293146_1.5.2.4.1>
    2023-11-30T19:38:33.044432  =

    2023-11-30T19:38:33.154399  / # #
    2023-11-30T19:38:33.256145  export SHELL=3D/bin/sh
    2023-11-30T19:38:33.256598  #
    2023-11-30T19:38:33.357899  / # export SHELL=3D/bin/sh. /lava-293146/en=
vironment
    2023-11-30T19:38:33.358497  =

    2023-11-30T19:38:33.459857  / # . /lava-293146/environment/lava-293146/=
bin/lava-test-runner /lava-293146/1
    2023-11-30T19:38:33.460573  =

    2023-11-30T19:38:33.465196  / # /lava-293146/bin/lava-test-runner /lava=
-293146/1 =

    ... (12 line(s) more)  =

 =



platform             | arch  | lab          | compiler | defconfig         =
  | regressions
---------------------+-------+--------------+----------+-------------------=
--+------------
meson-gxm-q200       | arm64 | lab-baylibre | gcc-10   | defconfig         =
  | 1          =


  Details:     https://kernelci.org/test/plan/id/6568e4b2d02301dd0c7e4a72

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
00-33-g467e4247b42cf/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm=
-q200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
00-33-g467e4247b42cf/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm=
-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/6568e4b2d02301d=
d0c7e4a75
        failing since 14 days (last pass: v4.19.298-87-g060b297883f5, first=
 fail: v4.19.298-89-g83d114914749)
        1 lines

    2023-11-30T19:38:14.281654  <4>[   49.533653] ------------[ cut here ]-=
-----------
    2023-11-30T19:38:14.282992  <4>[   49.533743] WARNING: CPU: 0 PID: 0 at=
 drivers/mmc/host/meson-gx-mmc.c:1039 meson_mmc_irq+0x1c8/0x1dc
    2023-11-30T19:38:14.286534  <4>[   49.542212] Modules linked in: ipv6 r=
ealtek dwmac_generic meson_gxl meson_dw_hdmi meson_drm dw_hdmi drm_kms_help=
er meson_rng crc32_ce drm meson_ir rc_core meson_gxbb_wdt dwmac_meson8b stm=
mac_platform adc_keys crct10dif_ce rng_core stmmac pwm_meson drm_panel_orie=
ntation_quirks nvmem_meson_efuse input_polldev
    2023-11-30T19:38:14.325014  <4>[   49.569472] CPU: 0 PID: 0 Comm: swapp=
er/0 Tainted: G        W         4.19.301-rc1 #1
    2023-11-30T19:38:14.325781  <4>[   49.577487] Hardware name: Amlogic Me=
son GXM (S912) Q200 Development Board (DT)
    2023-11-30T19:38:14.325999  <4>[   49.584993] pstate: 60000085 (nZCv da=
If -PAN -UAO)
    2023-11-30T19:38:14.326410  <4>[   49.589998] pc : meson_mmc_irq+0x1c8/=
0x1dc
    2023-11-30T19:38:14.326615  <4>[   49.594306] lr : meson_mmc_irq+0x1c8/=
0x1dc
    2023-11-30T19:38:14.326804  <4>[   49.598618] sp : ffff000008003cc0
    2023-11-30T19:38:14.327022  <4>[   49.602154] x29: ffff000008003cc0 x28=
: 00000000000000a0  =

    ... (37 line(s) more)  =

 =



platform             | arch  | lab          | compiler | defconfig         =
  | regressions
---------------------+-------+--------------+----------+-------------------=
--+------------
sun8i-h3-orangepi-pc | arm   | lab-clabbe   | gcc-10   | multi_v7_defconfig=
  | 1          =


  Details:     https://kernelci.org/test/plan/id/6568e60f4cc0b5522c7e4b09

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
00-33-g467e4247b42cf/arm/multi_v7_defconfig/gcc-10/lab-clabbe/baseline-sun8=
i-h3-orangepi-pc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
00-33-g467e4247b42cf/arm/multi_v7_defconfig/gcc-10/lab-clabbe/baseline-sun8=
i-h3-orangepi-pc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6568e60f4cc0b5522c7e4=
b0a
        new failure (last pass: v4.19.300) =

 =20

