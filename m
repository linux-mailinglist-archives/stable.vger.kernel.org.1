Return-Path: <stable+bounces-2858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90997FB207
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 07:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25DF1C2040E
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 06:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A2ED311;
	Tue, 28 Nov 2023 06:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="F+8s+md1"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E3C198
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 22:40:08 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b58d96a3bbso3090596b6e.1
        for <stable@vger.kernel.org>; Mon, 27 Nov 2023 22:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701153607; x=1701758407; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HO6DONYaCWu9ZX3+E5cLWjaXQnARfZTgYUGS2Wzebv4=;
        b=F+8s+md12/S2qAK8FJHzC4OoeECzJD1H+YRAutWeE3UywUOqHObusLzmGSTmY7Kjyq
         bCLKtDhl6EZbb9Hda0uWXiqPDqq1PzH5mHzoCbunLLaneWD8e2ql77Bi/GUgzLycy/Ek
         zvwpxbBx2jcs1reU9GFwNCXHCv3v0dDHiw8vYsEBs3+X9YxmZhPr2knNJAPy4kAwoTCl
         BCm5eUxtekn1lSOQO3NtnOgzwpypw0NpfAmppANkLSkuwy6oSfRXUpSiqwm3/Rx4imAp
         k3Cvnd7pvHAA+S6xT8xIBmDw3ak3okX4LPQO1l8xZpxWTJRir0vx2bMRJrasBw0RHJDZ
         BwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701153607; x=1701758407;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HO6DONYaCWu9ZX3+E5cLWjaXQnARfZTgYUGS2Wzebv4=;
        b=Hb7xkdySTBcl3LCDHoKr7vxV6YPQbuT3IZ7Xjxj1Xj4DTZttGpcylfB5gOug9nRTyw
         Jh7GJhejytNvcXT3nmEE3IPinl7CfupidkZaEg8Zqkwl10VQGN9HkfUZydsUt4q/VQda
         5ODG5F/Q0d3FYd5vju+J10XT7sykjRiTUeuJeOwySp7oS2HlkkTJH3k+KzrCgWRtFclm
         JwDxykpCJ2xNLOlDtcYeNQOeJWY781/gC+jvv07l06ox6X3VH86lQJVLz3kLtyrZUdHZ
         CVZxnGDAifa+xl4W+Cox45aU3QcIUmYnqtbOkpHEzdr9u/jT0EGuikmEZhesXfxSshKm
         RmrA==
X-Gm-Message-State: AOJu0YwKiY+3vm4xX6lKWUS/GgSwyqB+0StGPJ+sbGxioyKaVikWkn3T
	Bipn8KSu5HqE5sPyK+/lASAa0ouj+GB32voeFlA=
X-Google-Smtp-Source: AGHT+IEgxz3m3P+7kYeXL3/xZAfKrct9/S0qsOv5xLTg6wYK7wxSkXZuhK1aVod/M8xbet5FGHhE7A==
X-Received: by 2002:a05:6808:2009:b0:3b8:643f:9345 with SMTP id q9-20020a056808200900b003b8643f9345mr9139396oiw.30.1701153607680;
        Mon, 27 Nov 2023 22:40:07 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q25-20020aa79839000000b006cb75e0eb02sm8125932pfl.152.2023.11.27.22.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 22:40:07 -0800 (PST)
Message-ID: <65658b47.a70a0220.8aec0.3f34@mx.google.com>
Date: Mon, 27 Nov 2023 22:40:07 -0800 (PST)
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
X-Kernelci-Kernel: v4.19.299-93-gc66845304b463
Subject: stable-rc/linux-4.19.y baseline: 129 runs,
 2 regressions (v4.19.299-93-gc66845304b463)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-4.19.y baseline: 129 runs, 2 regressions (v4.19.299-93-gc66=
845304b463)

Regressions Summary
-------------------

platform       | arch  | lab          | compiler | defconfig          | reg=
ressions
---------------+-------+--------------+----------+--------------------+----=
--------
at91sam9g20ek  | arm   | lab-broonie  | gcc-10   | multi_v5_defconfig | 1  =
        =

meson-gxm-q200 | arm64 | lab-baylibre | gcc-10   | defconfig          | 1  =
        =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.19.y/ker=
nel/v4.19.299-93-gc66845304b463/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.299-93-gc66845304b463
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      c66845304b4632f778a17e0056b8df432123907f =



Test Regressions
---------------- =



platform       | arch  | lab          | compiler | defconfig          | reg=
ressions
---------------+-------+--------------+----------+--------------------+----=
--------
at91sam9g20ek  | arm   | lab-broonie  | gcc-10   | multi_v5_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/656559d8ea129b77e97e4af1

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
99-93-gc66845304b463/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at9=
1sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
99-93-gc66845304b463/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at9=
1sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656559d8ea129b77e97e4b21
        new failure (last pass: v4.19.299-93-g263cae4d5493f)

    2023-11-28T03:08:32.638871  + set +x
    2023-11-28T03:08:32.639355  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 280416_1.5.2=
.4.1>
    2023-11-28T03:08:32.752066  / # #
    2023-11-28T03:08:32.855268  export SHELL=3D/bin/sh
    2023-11-28T03:08:32.856050  #
    2023-11-28T03:08:32.958042  / # export SHELL=3D/bin/sh. /lava-280416/en=
vironment
    2023-11-28T03:08:32.958819  =

    2023-11-28T03:08:33.060856  / # . /lava-280416/environment/lava-280416/=
bin/lava-test-runner /lava-280416/1
    2023-11-28T03:08:33.062311  =

    2023-11-28T03:08:33.065831  / # /lava-280416/bin/lava-test-runner /lava=
-280416/1 =

    ... (12 line(s) more)  =

 =



platform       | arch  | lab          | compiler | defconfig          | reg=
ressions
---------------+-------+--------------+----------+--------------------+----=
--------
meson-gxm-q200 | arm64 | lab-baylibre | gcc-10   | defconfig          | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/65655a7596159f7b8b7e4a6f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
99-93-gc66845304b463/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm=
-q200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
99-93-gc66845304b463/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm=
-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/65655a7596159f7=
b8b7e4a72
        failing since 12 days (last pass: v4.19.298-87-g060b297883f5, first=
 fail: v4.19.298-89-g83d114914749)
        1 lines

    2023-11-28T03:11:36.889484  <4>[   47.998267] Modules linked in: ipv6 d=
wmac_generic realtek meson_gxl meson_dw_hdmi meson_drm dw_hdmi drm_kms_help=
er crc32_ce drm meson_ir meson_rng rc_core rng_core dwmac_meson8b stmmac_pl=
atform adc_keys crct10dif_ce meson_gxbb_wdt stmmac pwm_meson drm_panel_orie=
ntation_quirks input_polldev nvmem_meson_efuse
    2023-11-28T03:11:36.889982  <4>[   48.025527] CPU: 0 PID: 0 Comm: swapp=
er/0 Tainted: G        W         4.19.300-rc3 #1
    2023-11-28T03:11:36.890190  <4>[   48.033543] Hardware name: Amlogic Me=
son GXM (S912) Q200 Development Board (DT)
    2023-11-28T03:11:36.890380  <4>[   48.041048] pstate: 60000085 (nZCv da=
If -PAN -UAO)
    2023-11-28T03:11:36.890775  <4>[   48.046050] pc : meson_mmc_irq+0x1c8/=
0x1dc
    2023-11-28T03:11:36.890970  <4>[   48.050362] lr : meson_mmc_irq+0x1c8/=
0x1dc
    2023-11-28T03:11:36.891153  <4>[   48.054673] sp : ffff000008003cc0
    2023-11-28T03:11:36.932392  <4>[   48.058210] x29: ffff000008003cc0 x28=
: 00000000000000a0 =

    2023-11-28T03:11:36.932919  <4>[   48.063730] x27: 0000000000000001 x26=
: ffff000008ee7f88 =

    2023-11-28T03:11:36.933113  <4>[   48.069250] x25: ffff00000929e85b x24=
: ffff8000bf35da00  =

    ... (34 line(s) more)  =

 =20

