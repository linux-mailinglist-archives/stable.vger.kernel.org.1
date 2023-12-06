Return-Path: <stable+bounces-4811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A8E806731
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 07:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7243AB21877
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 06:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1EB10A04;
	Wed,  6 Dec 2023 06:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="JyqBCmZw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BCC1B5
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 22:13:49 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6ce6d926f76so409391b3a.1
        for <stable@vger.kernel.org>; Tue, 05 Dec 2023 22:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701843229; x=1702448029; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tCrVXeNkjo6Cj0YJCvdfzAK6mJyJFuiDhv8W+xZdX7k=;
        b=JyqBCmZwvbMt0pZOpXMq3dJLNLqWvIm8SBSJze/LS89zstMHNn1NXNCcLlxAwV8wVc
         mzpfPo5fUZJP0jSfNxKRGCLzFBqHYM71zp7Z7/KXh+ecjSooyJDWLJtP0rpHSKAe6PUM
         4fuFss/WQl3udGtegShLLXzG8l7PWashdwUV3FTUrqYmrrpOJwwPMXTpbSIeVzBjc2O+
         EchuRI1iZb8+lz0l57AAst5ZQjpJzAePaAxLoFuUN3upNHTX7IQGF0DfLEZLaAxAKRW6
         /x0oHf98Yy7INS9R8HLh2kzS7dYFcY+G1t8PVig+IpV1MGZ4xGKTDO5kMOaRT1atUPV/
         85Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701843229; x=1702448029;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tCrVXeNkjo6Cj0YJCvdfzAK6mJyJFuiDhv8W+xZdX7k=;
        b=itPOInA6R1bKohP2ORiI9ByYAhdcNzrNPaCFZqykRd2NGZl1ngeB1egc867/JNaTw+
         +wJSWCsFhudSzWMHWp46jEJ7P49+pNEqgKZZkrIqg6wyVUf7iG/t2NtX9bTaNKSnGBeV
         zPoYivx4L9GGXesJJSNpgWtA95ZAUPtHyi8GXe3BGMJ4dL1YCIHXhDKXvlGlrtNZ+BZn
         4L+S+Pl71RLIrSzbZSS9dBCgaB1wJd2EiapAmYrobSbnALLTmEv2/QvrkNxndsYGXUmq
         2j9X5EJ3QgPdxwlIQz8p3UR+gXl8ByjNGIelv9poGxHNp2qYnNE+9BbLeXRkKLMuUTen
         JtpQ==
X-Gm-Message-State: AOJu0YzCVa8oYyT6YptDPazo/4q8WJE8ePXU/EYFOx+7B/cb1b2t3dPq
	8CqO8DEJr9WtpAXgXzE88ptjooNg5+bFX314xmQJ/g==
X-Google-Smtp-Source: AGHT+IFxOKfftaDyzrIILy/2B3GxbBrfTlm4ojeE32MpwkhMuQR1ZXcVHkE3fgU+AQglTqR/b25acw==
X-Received: by 2002:a05:6a20:7fa0:b0:18b:594a:284c with SMTP id d32-20020a056a207fa000b0018b594a284cmr3550834pzj.15.1701843228860;
        Tue, 05 Dec 2023 22:13:48 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bm9-20020a656e89000000b0058988954686sm8764235pgb.90.2023.12.05.22.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 22:13:48 -0800 (PST)
Message-ID: <6570111c.650a0220.44ee.7dea@mx.google.com>
Date: Tue, 05 Dec 2023 22:13:48 -0800 (PST)
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
X-Kernelci-Kernel: v4.19.300-64-g58069964f7ae
Subject: stable-rc/linux-4.19.y baseline: 129 runs,
 3 regressions (v4.19.300-64-g58069964f7ae)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-4.19.y baseline: 129 runs, 3 regressions (v4.19.300-64-g580=
69964f7ae)

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

meson-gxl-s905d-p230 | arm64 | lab-baylibre | gcc-10   | defconfig         =
  | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.19.y/ker=
nel/v4.19.300-64-g58069964f7ae/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.300-64-g58069964f7ae
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      58069964f7aefef236c6f95ab212d0da19c7a4c1 =



Test Regressions
---------------- =



platform             | arch  | lab          | compiler | defconfig         =
  | regressions
---------------------+-------+--------------+----------+-------------------=
--+------------
at91sam9g20ek        | arm   | lab-broonie  | gcc-10   | multi_v5_defconfig=
  | 1          =


  Details:     https://kernelci.org/test/plan/id/656fde2c426f265a02e13499

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
00-64-g58069964f7ae/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91=
sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
00-64-g58069964f7ae/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91=
sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656fde2c426f265a02e134cb
        failing since 7 days (last pass: v4.19.299-93-g263cae4d5493f, first=
 fail: v4.19.299-93-gc66845304b463)

    2023-12-06T02:35:48.692658  + set +x
    2023-12-06T02:35:48.693128  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 312583_1.5.2=
.4.1>
    2023-12-06T02:35:48.805955  / # #
    2023-12-06T02:35:48.909502  export SHELL=3D/bin/sh
    2023-12-06T02:35:48.910367  #
    2023-12-06T02:35:49.012491  / # export SHELL=3D/bin/sh. /lava-312583/en=
vironment
    2023-12-06T02:35:49.013352  =

    2023-12-06T02:35:49.115449  / # . /lava-312583/environment/lava-312583/=
bin/lava-test-runner /lava-312583/1
    2023-12-06T02:35:49.116921  =

    2023-12-06T02:35:49.120507  / # /lava-312583/bin/lava-test-runner /lava=
-312583/1 =

    ... (12 line(s) more)  =

 =



platform             | arch  | lab          | compiler | defconfig         =
  | regressions
---------------------+-------+--------------+----------+-------------------=
--+------------
beaglebone-black     | arm   | lab-broonie  | gcc-10   | omap2plus_defconfi=
g | 1          =


  Details:     https://kernelci.org/test/plan/id/656fdfba64f4ab711ae134a2

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
00-64-g58069964f7ae/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
00-64-g58069964f7ae/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656fdfba64f4ab711ae134d4
        failing since 0 day (last pass: v4.19.300-45-gc7158dd8db14c, first =
fail: v4.19.300-72-g82300ecbea43)

    2023-12-06T02:42:43.352475  + set +x
    2023-12-06T02:42:43.356463  <8>[   17.314494] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 312639_1.5.2.4.1>
    2023-12-06T02:42:43.467535  / # #
    2023-12-06T02:42:43.569811  export SHELL=3D/bin/sh
    2023-12-06T02:42:43.570312  #
    2023-12-06T02:42:43.672086  / # export SHELL=3D/bin/sh. /lava-312639/en=
vironment
    2023-12-06T02:42:43.672705  =

    2023-12-06T02:42:43.774510  / # . /lava-312639/environment/lava-312639/=
bin/lava-test-runner /lava-312639/1
    2023-12-06T02:42:43.775365  =

    2023-12-06T02:42:43.780134  / # /lava-312639/bin/lava-test-runner /lava=
-312639/1 =

    ... (12 line(s) more)  =

 =



platform             | arch  | lab          | compiler | defconfig         =
  | regressions
---------------------+-------+--------------+----------+-------------------=
--+------------
meson-gxl-s905d-p230 | arm64 | lab-baylibre | gcc-10   | defconfig         =
  | 1          =


  Details:     https://kernelci.org/test/plan/id/656fdf60957d17809ae13475

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
00-64-g58069964f7ae/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-=
s905d-p230.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
00-64-g58069964f7ae/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-=
s905d-p230.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656fdf60957d17809ae1347a
        failing since 20 days (last pass: v4.19.298-87-g060b297883f5, first=
 fail: v4.19.298-89-g83d114914749)

    2023-12-06T02:41:16.657101  + set +x<8>[   49.935114] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3862485_1.5.2.4.1>
    2023-12-06T02:41:16.657440  =

    2023-12-06T02:41:16.763846  / # #
    2023-12-06T02:41:16.865226  export SHELL=3D/bin/sh
    2023-12-06T02:41:16.865838  #<4>[   50.009859] ------------[ cut here ]=
------------
    2023-12-06T02:41:16.866066  <4>[   50.009930] WARNING: CPU: 0 PID: 0 at=
 drivers/mmc/host/meson-gx-mmc.c:1039 meson_mmc_irq+0x1c8/0x1dc
    2023-12-06T02:41:16.866262  <4>[   50.018413] Modules linked in: ipv6 d=
wmac_generic realtek meson_gxl meson_dw_hdmi meson_ir rc_core dw_hdmi dwmac=
_meson8b crc32_ce stmmac_platform meson_drm crct10dif_ce drm_kms_helper stm=
mac drm drm_panel_orientation_quirks meson_rng rng_core pwm_meson meson_gxb=
b_wdt adc_keys input_polldev nvmem_meson_efuse
    2023-12-06T02:41:16.866472  <4>[   50.045673] CPU: 0 PID: 0 Comm: swapp=
er/0 Tainted: G        W         4.19.301-rc2 #1
    2023-12-06T02:41:16.866648  <4>[   50.053689] Hardware name: Amlogic Me=
son GXL (S905D) P230 Development Board (DT)
    2023-12-06T02:41:16.866811  <4>[   50.061281] pstate: 60000085 (nZCv da=
If -PAN -UAO) =

    ... (209 line(s) more)  =

 =20

