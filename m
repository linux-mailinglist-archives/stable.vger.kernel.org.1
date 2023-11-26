Return-Path: <stable+bounces-2719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 359B87F95D7
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 23:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671451C2083A
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 22:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2619013FE2;
	Sun, 26 Nov 2023 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Alsguodw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D91E3
	for <stable@vger.kernel.org>; Sun, 26 Nov 2023 14:39:13 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cfabcbda7bso11911535ad.0
        for <stable@vger.kernel.org>; Sun, 26 Nov 2023 14:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701038352; x=1701643152; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KvDd22IYETC7pYNAKAtsfur47uWugC8ECVCeIvpjVu0=;
        b=Alsguodw8nC5mnipeKzUa0jgZwG4xx7s2b1iulmO1FqgeG/hNzjgpWh/zKYKKx1vHC
         2oyqmCklgUUWM98yGRRsgpukBhVkHhnp+YiJezUJKqpCD0WNvx2ocsV1U+deziTZdZIe
         LRhJ7ba6Zlc9u12VC2bhk0yOj9WTRzy4I5YbnWKmqK4g5ERik5SPxogIw3U63H+Ixry3
         Xi6AlbhBhuX4D+7dFUtdyZ2KsP6i5hGnKDQxK2trebEDIJXsK/pK48NAqdaiW7TCpQL4
         uQ1wDEFQvGKVCFCP0aXMgQV+6yMdJRjYc4nq/1cUKsU9RIgBJtgSP5CE1d6yfZiu4sym
         dTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701038352; x=1701643152;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KvDd22IYETC7pYNAKAtsfur47uWugC8ECVCeIvpjVu0=;
        b=eyg66vwjLgiE+1EgzOaS+ImSmtQ0wqda50kIDLD0fbs18zVS+650mYlQi0pTAgUxOm
         lsH7ZVTuZs1fRXElGS4PwLPEOfC/rWuHkJGIsm/wE0mtiRBpgtt9N5u5RHIx3KhtpQQS
         Dc7H3iQ/u332Iw5WPwSU6nmeR1Y3X7VTcjh22QxV0Xl92f6KjR6eAvKStnd6BE5mR0Ga
         FUp+/9SnSJv/xjbcVS5tJWrCkG27p3Zoz4L92R+yvwMmB7hk+f0v7SARjbCElyOxH8nS
         Lz2wnDFTees9wzGBispUDaVvHgTjryHMbnwjTRTfQcbXYUhA+jiq1SrYhJi0JME0GsdO
         tTLA==
X-Gm-Message-State: AOJu0YzSflVoMyptuElf2xJWw1KieZ9EWQY/ly8ppEvp//LiG2ZT6R6b
	Bhc0ibW0M5inAU8424bMVjf1hKwMzjZdmCGbt5I=
X-Google-Smtp-Source: AGHT+IHsT3iNjBGNxfkHkSdmtNwc7TpLmzg9aji6BMD3/7xMuKXo/TCIjz6QdBHDLNTxg3m8ouMIRQ==
X-Received: by 2002:a17:902:db0d:b0:1cf:cb80:3fa5 with SMTP id m13-20020a170902db0d00b001cfcb803fa5mr2496884plx.23.1701038352015;
        Sun, 26 Nov 2023 14:39:12 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902744c00b001ce5b6e97a9sm6888602plt.54.2023.11.26.14.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 14:39:11 -0800 (PST)
Message-ID: <6563c90f.170a0220.86467.f16a@mx.google.com>
Date: Sun, 26 Nov 2023 14:39:11 -0800 (PST)
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
X-Kernelci-Kernel: v4.19.299-93-g263cae4d5493f
Subject: stable-rc/linux-4.19.y baseline: 126 runs,
 2 regressions (v4.19.299-93-g263cae4d5493f)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-4.19.y baseline: 126 runs, 2 regressions (v4.19.299-93-g263=
cae4d5493f)

Regressions Summary
-------------------

platform       | arch  | lab          | compiler | defconfig           | re=
gressions
---------------+-------+--------------+----------+---------------------+---=
---------
imx6q-udoo     | arm   | lab-broonie  | gcc-10   | imx_v6_v7_defconfig | 1 =
         =

meson-gxm-q200 | arm64 | lab-baylibre | gcc-10   | defconfig           | 1 =
         =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.19.y/ker=
nel/v4.19.299-93-g263cae4d5493f/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.299-93-g263cae4d5493f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      263cae4d5493fd62387a61e60908e48685259989 =



Test Regressions
---------------- =



platform       | arch  | lab          | compiler | defconfig           | re=
gressions
---------------+-------+--------------+----------+---------------------+---=
---------
imx6q-udoo     | arm   | lab-broonie  | gcc-10   | imx_v6_v7_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/6563981bbd438b6bfc7e4a78

  Results:     28 PASS, 5 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
99-93-g263cae4d5493f/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-im=
x6q-udoo.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
99-93-g263cae4d5493f/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-im=
x6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.sound-card-probed: https://kernelci.org/test/case/id/65=
63981bbd438b6bfc7e4a86
        new failure (last pass: v4.19.299-94-gb37016ccf3078)

    2023-11-26T19:10:00.551009  /lava-275790/1/../bin/lava-test-case
    2023-11-26T19:10:00.585722  <8>[   21.184087] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card-probed RESULT=3Dfail>   =

 =



platform       | arch  | lab          | compiler | defconfig           | re=
gressions
---------------+-------+--------------+----------+---------------------+---=
---------
meson-gxm-q200 | arm64 | lab-baylibre | gcc-10   | defconfig           | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/656397906d7799bd2c7e4a7b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
99-93-g263cae4d5493f/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm=
-q200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
99-93-g263cae4d5493f/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm=
-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/656397906d7799b=
d2c7e4a7e
        failing since 10 days (last pass: v4.19.298-87-g060b297883f5, first=
 fail: v4.19.298-89-g83d114914749)
        1 lines

    2023-11-26T19:07:47.408692  <4>[   46.786567] ------------[ cut here ]-=
-----------
    2023-11-26T19:07:47.409213  <4>[   46.786659] WARNING: CPU: 0 PID: 0 at=
 drivers/mmc/host/meson-gx-mmc.c:1039 meson_mmc_irq+0x1c8/0x1dc
    2023-11-26T19:07:47.412681  <4>[   46.795134] Modules linked in: ipv6 r=
ealtek meson_gxl dwmac_generic meson_dw_hdmi dw_hdmi meson_drm drm_kms_help=
er dwmac_meson8b meson_ir stmmac_platform adc_keys drm crc32_ce rc_core mes=
on_rng crct10dif_ce rng_core stmmac drm_panel_orientation_quirks pwm_meson =
meson_gxbb_wdt input_polldev nvmem_meson_efuse
    2023-11-26T19:07:47.452092  <4>[   46.822394] CPU: 0 PID: 0 Comm: swapp=
er/0 Tainted: G        W         4.19.300-rc3 #1
    2023-11-26T19:07:47.452313  <4>[   46.830409] Hardware name: Amlogic Me=
son GXM (S912) Q200 Development Board (DT)
    2023-11-26T19:07:47.452502  <4>[   46.837914] pstate: 60000085 (nZCv da=
If -PAN -UAO)
    2023-11-26T19:07:47.452692  <4>[   46.842917] pc : meson_mmc_irq+0x1c8/=
0x1dc
    2023-11-26T19:07:47.453080  <4>[   46.847228] lr : meson_mmc_irq+0x1c8/=
0x1dc
    2023-11-26T19:07:47.453270  <4>[   46.851539] sp : ffff000008003cc0
    2023-11-26T19:07:47.453450  <4>[   46.855076] x29: ffff000008003cc0 x28=
: 00000000000000a0  =

    ... (37 line(s) more)  =

 =20

