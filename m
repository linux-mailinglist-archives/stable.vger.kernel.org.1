Return-Path: <stable+bounces-3730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5098023C3
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 13:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77518280E92
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 12:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A628828;
	Sun,  3 Dec 2023 12:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="cUp5HlH0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA539C2
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 04:33:43 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-28652d59505so1817331a91.2
        for <stable@vger.kernel.org>; Sun, 03 Dec 2023 04:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701606823; x=1702211623; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E28SVIsiVfUOo/rfWaR8b6ZhD8ZTrrcAbbbnZRZ1C6g=;
        b=cUp5HlH07Y+nUCXEzBVpAe6/jmX1BJcWiQaAhXu5d0ZlE06BjTEjeQy1Yvqrx1j3SX
         a8a0ix+tupYbyI97XLf5KV9t/RteUgBrsto2OZpyVvnbH4cZLwwquBiHFm6+DHdcZn9c
         t/UWyfJipIp6ogNqVg/LejFcI027O3fiiPAGMHEcUKP9owKORPqzarRqTApoeMuBsj4Y
         ILT3wFBAEhqIsHQW67Rp2W5lh2sZyUBLBvmPkaG9B192MiMwPXB3Nvqfa1KKMKGdpl7P
         RtW5Hse+QeD5E4PzGhvpKHDMcsX0SFrXyz/5nd0Ekepj/u82Kl2EdBgLGmutn0NLB7Xb
         TXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701606823; x=1702211623;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E28SVIsiVfUOo/rfWaR8b6ZhD8ZTrrcAbbbnZRZ1C6g=;
        b=IWhjGL0hq7GkFc1pva7Wjh+gS4XjA9Rs6qFqZnw8X+OiFaf+au8MInu36tF3wOB2gr
         ExXrRgPohfSe1fi3jWM/5oOc0D/hZK+DMyrUDrbjq5csihYsV1abhLWJDNcGyQJvhLN4
         5JxoghWsxNRVENtYv4ppmpiIP/KyIIoQXl004MJVYr8tW3PyIN7ORFJdVeQdYkKrlVBR
         byZZlktNaRfBg+zBa8z7Nn4pGY7x3O74oAbXugzxq3u+mm0YVksr+7Mo4VqUw4/l5k3o
         /aPU+2GN/E2EGdNyIz7qfwOONvIh9E/CmpoO+d7wxGKYr3+Hf93erGjIJ71W475NuuT9
         o3tw==
X-Gm-Message-State: AOJu0YxNURyPTCn36hT0o4UA/0WvrXdbrI8ViZwFv9r3KOmRd8NMF7Mk
	lqQg5AVT0Kv5ZrCEDhtG6FqtyqcOIzTfKVQiN43ORA==
X-Google-Smtp-Source: AGHT+IHlUWaM6fQL22QS0CGdntSZust+7c8Px4AztMnWEU95oV+ucaABqRwebEjODaYmT7xVjkxHMA==
X-Received: by 2002:a05:6a20:7351:b0:18b:69a8:fab5 with SMTP id v17-20020a056a20735100b0018b69a8fab5mr980581pzc.15.1701606822733;
        Sun, 03 Dec 2023 04:33:42 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902b20900b001cf5d0e7e05sm1688075plr.109.2023.12.03.04.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 04:33:42 -0800 (PST)
Message-ID: <656c75a6.170a0220.2de40.33ae@mx.google.com>
Date: Sun, 03 Dec 2023 04:33:42 -0800 (PST)
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
X-Kernelci-Kernel: v4.19.300
Subject: stable-rc/linux-4.19.y baseline: 129 runs, 2 regressions (v4.19.300)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-4.19.y baseline: 129 runs, 2 regressions (v4.19.300)

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
nel/v4.19.300/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.300
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      979b2ade8052a563f9cdd9913e45c2462a7c665a =



Test Regressions
---------------- =



platform       | arch  | lab          | compiler | defconfig          | reg=
ressions
---------------+-------+--------------+----------+--------------------+----=
--------
at91sam9g20ek  | arm   | lab-broonie  | gcc-10   | multi_v5_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/6566d05fca9d6358ab7e4a89

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
00/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
00/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6566d05fca9d6358ab7e4abd
        failing since 1 day (last pass: v4.19.299-93-g263cae4d5493f, first =
fail: v4.19.299-93-gc66845304b463)

    2023-12-03T09:01:01.594827  + set +x
    2023-12-03T09:01:01.595350  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 299987_1.5.2=
.4.1>
    2023-12-03T09:01:01.708392  / # #
    2023-12-03T09:01:01.811315  export SHELL=3D/bin/sh
    2023-12-03T09:01:01.812069  #
    2023-12-03T09:01:01.914039  / # export SHELL=3D/bin/sh. /lava-299987/en=
vironment
    2023-12-03T09:01:01.914792  =

    2023-12-03T09:01:02.016805  / # . /lava-299987/environment/lava-299987/=
bin/lava-test-runner /lava-299987/1
    2023-12-03T09:01:02.018158  =

    2023-12-03T09:01:02.021737  / # /lava-299987/bin/lava-test-runner /lava=
-299987/1 =

    ... (12 line(s) more)  =

 =



platform       | arch  | lab          | compiler | defconfig          | reg=
ressions
---------------+-------+--------------+----------+--------------------+----=
--------
meson-gxm-q200 | arm64 | lab-baylibre | gcc-10   | defconfig          | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/6566d1533a526686cf7e4a71

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
00/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
00/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/6566d1533a52668=
6cf7e4a74
        failing since 13 days (last pass: v4.19.298-87-g060b297883f5, first=
 fail: v4.19.298-89-g83d114914749)
        1 lines

    2023-11-29T05:50:48.126732  <4>[   51.158249] ------------[ cut here ]-=
-----------
    2023-11-29T05:50:48.127555  <4>[   51.158342] WARNING: CPU: 0 PID: 0 at=
 drivers/mmc/host/meson-gx-mmc.c:1039 meson_mmc_irq+0x1c8/0x1dc
    2023-11-29T05:50:48.130624  <4>[   51.166805] Modules linked in: ipv6 r=
ealtek meson_gxl dwmac_generic meson_dw_hdmi meson_drm dw_hdmi drm_kms_help=
er crc32_ce drm meson_rng adc_keys meson_ir rc_core dwmac_meson8b meson_gxb=
b_wdt stmmac_platform crct10dif_ce stmmac rng_core pwm_meson drm_panel_orie=
ntation_quirks nvmem_meson_efuse input_polldev
    2023-11-29T05:50:48.171056  <8>[   51.173006] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D1>
    2023-11-29T05:50:48.171585  <4>[   51.194068] CPU: 0 PID: 0 Comm: swapp=
er/0 Tainted: G        W         4.19.300 #1   =

 =20

