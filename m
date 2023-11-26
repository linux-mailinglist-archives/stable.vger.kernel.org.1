Return-Path: <stable+bounces-2661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EF87F9071
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 01:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D1E28139B
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 00:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCD5389;
	Sun, 26 Nov 2023 00:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="IxBoY/CB"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96CF110
	for <stable@vger.kernel.org>; Sat, 25 Nov 2023 16:23:38 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b85dcecc62so453641b6e.2
        for <stable@vger.kernel.org>; Sat, 25 Nov 2023 16:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700958218; x=1701563018; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9eykPe95T56PxWAmfAPnJihX/ldXF9hYC3RkaeI+zJ8=;
        b=IxBoY/CBNf7tKgPLCiuX1JmDTANBnnVC1LHx+8yqCS6/HDEP7QSTFPyrz1F4Z8F2Nr
         9kqb5BwyZruTNLpCszsleb+ZtWaYIwS3sQaAQkeqzoaeNVFBhPjWhiON919TRKvg5DJm
         eJNXYs83+O2Bxmd5TVWcOR2HKC1hAuClYvVbKUFmEsqP5v2mCm1fUKpqmk/kgT65NuzE
         5uKffL7w7VBFGX+4iRh/WtU3C5yhg04TDJEVcLSZ4H9nz4NvOdpd9zxmEn2BUh+ht6GD
         cZBLMR+u+MforNFwfz5lIs8whQYoBIX4heYTshPmvogQGthcUx8Oj4WXepgBZxIIaVW0
         3/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700958218; x=1701563018;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9eykPe95T56PxWAmfAPnJihX/ldXF9hYC3RkaeI+zJ8=;
        b=Wb7Xkv1M9UESR5fvTEzINHiAJv7JUQ48JpgxFWWUfpyccazJWHprx1HWrz+lqzuWgI
         tlNwfHYQlEiSmKdPj+9VGy6Bg25XS8QXPPXwbxBABf4YmHt4FAP+QnDmr7IWLklwGgUz
         dSV0QrpjjYRGaRLmc23HUvRdw+8PN5mSO9tC+lWYdKzkdpRT1OatH3v4gklpTrQWToLg
         PGgQDp1JyI2HtAKsEmpl4VPWWWhDkLYD2lraZLjwIuNy/I3Bg4CTJXPwCw972NVlLHZI
         AEFvF01w+v7oHysOx2Gu4vDNhVU1eAJdXbDvDMqozu6Tg7NXqnUCqc8h5eJOU9x11c8d
         7VMw==
X-Gm-Message-State: AOJu0Yx0M5+r1blPIUIb7pD6qLISTzO9Y4a2frLJxtMmf4yOpC1IlXOQ
	mranzGoLM+KD3Hl6+xCQYBOCE14PqjSA6QyJjx8=
X-Google-Smtp-Source: AGHT+IGMKRKvs/0/nm1ohOcIiNSS9bFoydozAAnfeEJhBtR8K7Kk5lEu/2VTyhQjif2IIM2+w7gt+Q==
X-Received: by 2002:a05:6808:484:b0:3b8:4b02:da5e with SMTP id z4-20020a056808048400b003b84b02da5emr8181200oid.37.1700958217785;
        Sat, 25 Nov 2023 16:23:37 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b14-20020aa7870e000000b006cbfbb3635bsm2699530pfo.161.2023.11.25.16.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 16:23:37 -0800 (PST)
Message-ID: <65629009.a70a0220.a1e0a.5f6e@mx.google.com>
Date: Sat, 25 Nov 2023 16:23:37 -0800 (PST)
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
X-Kernelci-Kernel: v4.19.299-94-gb37016ccf3078
Subject: stable-rc/linux-4.19.y baseline: 118 runs,
 2 regressions (v4.19.299-94-gb37016ccf3078)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-4.19.y baseline: 118 runs, 2 regressions (v4.19.299-94-gb37=
016ccf3078)

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
nel/v4.19.299-94-gb37016ccf3078/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.299-94-gb37016ccf3078
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b37016ccf307885bbc0080f367e1dc39cf9d6d84 =



Test Regressions
---------------- =



platform       | arch  | lab          | compiler | defconfig          | reg=
ressions
---------------+-------+--------------+----------+--------------------+----=
--------
at91sam9g20ek  | arm   | lab-broonie  | gcc-10   | multi_v5_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/65625d601ab35612517e4a97

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
99-94-gb37016ccf3078/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at9=
1sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
99-94-gb37016ccf3078/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at9=
1sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65625d611ab35612517e4ac7
        failing since 1 day (last pass: v4.19.299, first fail: v4.19.299-98=
-g859b6f4860d8b)

    2023-11-25T20:46:49.535448  + set +x
    2023-11-25T20:46:49.535933  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 273110_1.5.2=
.4.1>
    2023-11-25T20:46:49.649352  / # #
    2023-11-25T20:46:49.752529  export SHELL=3D/bin/sh
    2023-11-25T20:46:49.753318  #
    2023-11-25T20:46:49.855384  / # export SHELL=3D/bin/sh. /lava-273110/en=
vironment
    2023-11-25T20:46:49.856162  =

    2023-11-25T20:46:49.958242  / # . /lava-273110/environment/lava-273110/=
bin/lava-test-runner /lava-273110/1
    2023-11-25T20:46:49.959656  =

    2023-11-25T20:46:49.963085  / # /lava-273110/bin/lava-test-runner /lava=
-273110/1 =

    ... (12 line(s) more)  =

 =



platform       | arch  | lab          | compiler | defconfig          | reg=
ressions
---------------+-------+--------------+----------+--------------------+----=
--------
meson-gxm-q200 | arm64 | lab-baylibre | gcc-10   | defconfig          | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/65625edbbff26e24867e4abc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
99-94-gb37016ccf3078/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm=
-q200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
99-94-gb37016ccf3078/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm=
-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/65625edbbff26e2=
4867e4abf
        failing since 10 days (last pass: v4.19.298-87-g060b297883f5, first=
 fail: v4.19.298-89-g83d114914749)
        1 lines

    2023-11-25T20:53:30.933910  <4>[   49.529944] ------------[ cut here ]-=
-----------
    2023-11-25T20:53:30.935321  <4>[   49.530025] WARNING: CPU: 0 PID: 0 at=
 drivers/mmc/host/meson-gx-mmc.c:1039 meson_mmc_irq+0x1c8/0x1dc
    2023-11-25T20:53:30.939302  <4>[   49.538502] Modules linked in: ipv6 r=
ealtek dwmac_generic meson_gxl meson_dw_hdmi crc32_ce dw_hdmi meson_drm drm=
_kms_helper dwmac_meson8b meson_ir stmmac_platform pwm_meson drm meson_gxbb=
_wdt meson_rng adc_keys crct10dif_ce rc_core stmmac rng_core drm_panel_orie=
ntation_quirks input_polldev nvmem_meson_efuse
    2023-11-25T20:53:30.977551  <4>[   49.565761] CPU: 0 PID: 0 Comm: swapp=
er/0 Tainted: G        W         4.19.300-rc2 #1
    2023-11-25T20:53:30.978190  <4>[   49.573777] Hardware name: Amlogic Me=
son GXM (S912) Q200 Development Board (DT)
    2023-11-25T20:53:30.978403  <4>[   49.581283] pstate: 60000085 (nZCv da=
If -PAN -UAO)
    2023-11-25T20:53:30.978825  <4>[   49.586285] pc : meson_mmc_irq+0x1c8/=
0x1dc
    2023-11-25T20:53:30.979031  <4>[   49.590597] lr : meson_mmc_irq+0x1c8/=
0x1dc
    2023-11-25T20:53:30.979221  <4>[   49.594908] sp : ffff000008003cc0
    2023-11-25T20:53:30.979629  <4>[   49.598444] x29: ffff000008003cc0 x28=
: 00000000000000a0  =

    ... (37 line(s) more)  =

 =20

