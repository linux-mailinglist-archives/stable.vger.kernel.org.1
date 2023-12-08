Return-Path: <stable+bounces-5015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B0980A41F
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 14:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 359D71F2150B
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 13:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B5E1A72B;
	Fri,  8 Dec 2023 13:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="vKdVWHr2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F271724
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 05:06:13 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6cea2a38b48so1590541b3a.3
        for <stable@vger.kernel.org>; Fri, 08 Dec 2023 05:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702040772; x=1702645572; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SvRj0/Xcu7AiJ0/AMeHFBmRokrOCd5mE0ANwQdEYC/k=;
        b=vKdVWHr2Wahj9Luoq+IND57TeAJgm2nBcoV8OoKlcXqVWm//zLRu8n41yViIcYUsPp
         duOoKTy+hdTvfvNPJ88FUShNB35xN8tsM6AW2UWqbk6J70Jwysb93vEKF/YxbEtf7Hdd
         pvs3SXgFV29eW//bAfm7hznf20NEhfPjtFuX1eEIdo2Og+CD6XqllbD4xHyy2NsUgITe
         qeDbvGLP8RajaqNCzroac6w8JK9Z+v4LpOW/LScj6NGD2waB10cceFuSRkF605ZZ0v3C
         fLJTcQt3wwhBT4Q/bPY1T4gVP5RO71qGWbJjBedfx3NL8OMIk61JVUmmOl3k2gONh4Fm
         9vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702040772; x=1702645572;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SvRj0/Xcu7AiJ0/AMeHFBmRokrOCd5mE0ANwQdEYC/k=;
        b=Eq9P8NU/QT2a9pDFyu0kHPqc4RNZwYp/5rFTSnSujVQrtoa8Y9UqYVzt2bGkeu/sAP
         VxhoGhRNao/rD2XNoU9+gsG1z6QHZk3EXh7mr6DopxjN3NchilyyRMFdBl9myUYK5fwU
         cd0c8enOt/WIdZxQH4o9JODm77m4iZlVj2V3vOeH0UnRd1so1wHujHZeugUKB+QExUPf
         SGZPYH32I80b/bX9L9I82iPiQ8GK348FNHOPD9YwyGAT2jPERc7dvbTltAYGNhKEEbnc
         Vib61g/6TaptUljWN9jaKMoQmKL9lQ4d/FZkc2N9tPjX1S2J8uAfA6OT0afVJZ5r9GRi
         dDdA==
X-Gm-Message-State: AOJu0Yw5ynm7ae+O6vWq4EIs9Vf3vxIIFplEx4ObZLQA2+PPp/MvePYD
	qPzDqM/+B5QdcLUovab7suIPwnow4SPxT+PdRWNNhA==
X-Google-Smtp-Source: AGHT+IEDm3twfX0OjR7LwIIHeYTZsHMqkjALF15LfKX7+8sXPdufVQMiE6PutUrL+NStxQzfsH8gzQ==
X-Received: by 2002:a05:6a21:7890:b0:18f:97c:8a3a with SMTP id bf16-20020a056a21789000b0018f097c8a3amr5480884pzc.101.1702040772466;
        Fri, 08 Dec 2023 05:06:12 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id cn6-20020a056a020a8600b005b8f3293bf2sm1294464pgb.88.2023.12.08.05.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 05:06:12 -0800 (PST)
Message-ID: <657314c3.050a0220.42888.3982@mx.google.com>
Date: Fri, 08 Dec 2023 05:06:12 -0800 (PST)
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
X-Kernelci-Kernel: v4.19.301
Subject: stable/linux-4.19.y baseline: 136 runs, 4 regressions (v4.19.301)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable/linux-4.19.y baseline: 136 runs, 4 regressions (v4.19.301)

Regressions Summary
-------------------

platform             | arch  | lab          | compiler | defconfig         =
  | regressions
---------------------+-------+--------------+----------+-------------------=
--+------------
beaglebone-black     | arm   | lab-cip      | gcc-10   | omap2plus_defconfi=
g | 1          =

meson-gxbb-p200      | arm64 | lab-baylibre | gcc-10   | defconfig         =
  | 1          =

meson-gxl-s905d-p230 | arm64 | lab-baylibre | gcc-10   | defconfig         =
  | 1          =

meson-gxm-q200       | arm64 | lab-baylibre | gcc-10   | defconfig         =
  | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-4.19.y/kernel=
/v4.19.301/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-4.19.y
  Describe: v4.19.301
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      3e205b99cc35777195fea391cdfe25bd537589b3 =



Test Regressions
---------------- =



platform             | arch  | lab          | compiler | defconfig         =
  | regressions
---------------------+-------+--------------+----------+-------------------=
--+------------
beaglebone-black     | arm   | lab-cip      | gcc-10   | omap2plus_defconfi=
g | 1          =


  Details:     https://kernelci.org/test/plan/id/6572ebf177882c713ee13476

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.301/=
arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.301/=
arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6572ebf177882c713ee134a8
        failing since 9 days (last pass: v4.19.299, first fail: v4.19.300)

    2023-12-08T10:11:24.760680  + set +x<8>[   11.435380] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1054437_1.5.2.4.1>
    2023-12-08T10:11:24.760806  =

    2023-12-08T10:11:24.869712  / # #
    2023-12-08T10:11:24.970506  export SHELL=3D/bin/sh
    2023-12-08T10:11:24.970759  #
    2023-12-08T10:11:25.071316  / # export SHELL=3D/bin/sh. /lava-1054437/e=
nvironment
    2023-12-08T10:11:25.071590  =

    2023-12-08T10:11:25.172174  / # . /lava-1054437/environment/lava-105443=
7/bin/lava-test-runner /lava-1054437/1
    2023-12-08T10:11:25.172573  =

    2023-12-08T10:11:25.176743  / # /lava-1054437/bin/lava-test-runner /lav=
a-1054437/1 =

    ... (12 line(s) more)  =

 =



platform             | arch  | lab          | compiler | defconfig         =
  | regressions
---------------------+-------+--------------+----------+-------------------=
--+------------
meson-gxbb-p200      | arm64 | lab-baylibre | gcc-10   | defconfig         =
  | 1          =


  Details:     https://kernelci.org/test/plan/id/6572e49eb022be0374e134ad

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.301/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.301/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6572e49eb022be0374e13=
4ae
        new failure (last pass: v4.19.297) =

 =



platform             | arch  | lab          | compiler | defconfig         =
  | regressions
---------------------+-------+--------------+----------+-------------------=
--+------------
meson-gxl-s905d-p230 | arm64 | lab-baylibre | gcc-10   | defconfig         =
  | 1          =


  Details:     https://kernelci.org/test/plan/id/6572e39b788dd29e38e13479

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.301/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-s905d-p230.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.301/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-s905d-p230.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/6572e39b788dd29=
e38e1347c
        new failure (last pass: v4.19.298)
        3 lines

    2023-12-08T09:36:16.053265  kern  :emerg : Disabling IRQ #19
    2023-12-08T09:36:16.058590  kern  :emerg : Disabling IRQ #20
    2023-12-08T09:36:16.069527  kern  :emerg : Disabling IRQ <8>[   51.7009=
98] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines =
MEASUREMENT=3D3>
    2023-12-08T09:36:16.069959  #18   =

 =



platform             | arch  | lab          | compiler | defconfig         =
  | regressions
---------------------+-------+--------------+----------+-------------------=
--+------------
meson-gxm-q200       | arm64 | lab-baylibre | gcc-10   | defconfig         =
  | 1          =


  Details:     https://kernelci.org/test/plan/id/6572e3ab788dd29e38e13492

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.301/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.301/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/6572e3ab788dd29=
e38e13495
        failing since 29 days (last pass: v4.19.288, first fail: v4.19.298)
        1 lines

    2023-12-08T09:36:24.884385  <4>[   46.452629] ------------[ cut here ]-=
-----------
    2023-12-08T09:36:24.884839  <4>[   46.452724] WARNING: CPU: 0 PID: 0 at=
 drivers/mmc/host/meson-gx-mmc.c:1039 meson_mmc_irq+0x1c8/0x1dc
    2023-12-08T09:36:24.888065  <4>[   46.461191] Modules linked in: ipv6 d=
wmac_generic meson_dw_hdmi realtek meson_gxl dw_hdmi meson_drm drm_kms_help=
er drm crc32_ce meson_rng crct10dif_ce dwmac_meson8b meson_ir stmmac_platfo=
rm rc_core adc_keys rng_core stmmac meson_gxbb_wdt pwm_meson drm_panel_orie=
ntation_quirks nvmem_meson_efuse input_polldev
    2023-12-08T09:36:24.927711  <4>[   46.488452] CPU: 0 PID: 0 Comm: swapp=
er/0 Tainted: G        W         4.19.301 #1
    2023-12-08T09:36:24.927957  <4>[   46.496122] Hardware name: Amlogic Me=
son GXM (S912) Q200 Development Board (DT)
    2023-12-08T09:36:24.928308  <4>[   46.503628] pstate: 60000085 (nZCv da=
If -PAN -UAO)
    2023-12-08T09:36:24.928583  <4>[   46.508630] pc : meson_mmc_irq+0x1c8/=
0x1dc
    2023-12-08T09:36:24.928856  <4>[   46.512942] lr : meson_mmc_irq+0x1c8/=
0x1dc
    2023-12-08T09:36:24.929090  <4>[   46.517253] sp : ffff000008003cc0
    2023-12-08T09:36:24.929320  <4>[   46.520789] x29: ffff000008003cc0 x28=
: 00000000000000a0  =

    ... (37 line(s) more)  =

 =20

