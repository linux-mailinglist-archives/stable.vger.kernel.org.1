Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109517E5897
	for <lists+stable@lfdr.de>; Wed,  8 Nov 2023 15:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjKHOWS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 8 Nov 2023 09:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjKHOWS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 8 Nov 2023 09:22:18 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B991FC2
        for <stable@vger.kernel.org>; Wed,  8 Nov 2023 06:22:16 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6c33ab26dddso5240275b3a.0
        for <stable@vger.kernel.org>; Wed, 08 Nov 2023 06:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699453335; x=1700058135; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9s/NfNwYjRte9ohK7mh6j2Z5GK+OK9G1ccG2nLthxRs=;
        b=BYWoIFf9sUq3uYKs+Z2eJ9APTqWtIfrQrrJ9Vsdiz3Ru+Do4GKANfLsvenEj+SOYdz
         ygxmcEJtW+OruIla9ezhfbvr+dARdF7bgcBY8FCGHzp5XPgfnOLtgfO4DlZwvU7sfmrI
         Ppsm9NwcxQCweQgvIHdqWGFnck1c1r2yyGBGdRkbzmJYwNnazPczPZPUyxbcvwq06d+L
         K/nn84mP9OTlF01ep44VaHr/DHmSWRg1cwqzZlseq3UYdBYZjsowpliF6fUIwWlts8Vh
         KV9DJzjgS3wrajDr3cwwpYsqrpxN26Ys6+NOqi+MW5QlusFaXwJjJGxtdwjJXjKtqkw2
         /B8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699453335; x=1700058135;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9s/NfNwYjRte9ohK7mh6j2Z5GK+OK9G1ccG2nLthxRs=;
        b=KbKJ5n0UIoIn+GO1LK9rX1c4YMlTEmu1BnpEvp8+GJCG2JNrx0tJMO8m0jGRRzO3xI
         7O+9+PHvbeW0Uib36pajr5CLIeO6heVkmLupi9VLmkl6dK80N5D0Fd/rQCCeEb3lxBHe
         f3FlvnZ0MDGPV52x7pB3EiKPMUVQQ0kuy1X+v3ZBRNbpfWxYAsX9dtJ+cvLuVTSttxs+
         Y8nRV8tgQQ1sAVhjXac0RgP6VcdNZhPZHUst5QVxN7aBEbxknDkNVow4yLfY+mj52L6x
         iW4WVYzfGe7Ip3URYssLB6Wwb8MlWabfz4hixOpN85mGBiGIp5fWrbCBl4VzmA0ZmAVq
         fBew==
X-Gm-Message-State: AOJu0Yw+uB3cXwH3bmQqDYMxx16Y0MLlV17DR/tIiSO8qMG2xsYJOfTU
        hxGKwQqzUEtbVQrXoxzhFWrlAxfJ7yEPyoskCU4C1w==
X-Google-Smtp-Source: AGHT+IEmZQ9L5hvqrf63fYyTggY+rl6HtVxC/WDft9SAinH+pPpu1ti4tQiDyqbV5p+DWa9HxVpL4g==
X-Received: by 2002:a05:6a21:7748:b0:180:132:e078 with SMTP id bc8-20020a056a21774800b001800132e078mr2487577pzc.31.1699453335030;
        Wed, 08 Nov 2023 06:22:15 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902c1c400b001c61e628e9dsm1815538plc.77.2023.11.08.06.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 06:22:14 -0800 (PST)
Message-ID: <654b9996.170a0220.fee0e.51cc@mx.google.com>
Date:   Wed, 08 Nov 2023 06:22:14 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.298
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable
Subject: stable/linux-4.19.y baseline: 123 runs, 7 regressions (v4.19.298)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-4.19.y baseline: 123 runs, 7 regressions (v4.19.298)

Regressions Summary
-------------------

platform                | arch  | lab          | compiler | defconfig      =
     | regressions
------------------------+-------+--------------+----------+----------------=
-----+------------
beaglebone-black        | arm   | lab-broonie  | gcc-10   | omap2plus_defco=
nfig | 1          =

beaglebone-black        | arm   | lab-cip      | gcc-10   | omap2plus_defco=
nfig | 1          =

meson-gxl-s905d-p230    | arm64 | lab-baylibre | gcc-10   | defconfig      =
     | 1          =

meson-gxm-q200          | arm64 | lab-baylibre | gcc-10   | defconfig      =
     | 1          =

sun50i-a64-bananapi-m64 | arm64 | lab-clabbe   | gcc-10   | defconfig      =
     | 1          =

sun50i-a64-pine64-plus  | arm64 | lab-baylibre | gcc-10   | defconfig      =
     | 1          =

sun50i-a64-pine64-plus  | arm64 | lab-broonie  | gcc-10   | defconfig      =
     | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-4.19.y/kernel=
/v4.19.298/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-4.19.y
  Describe: v4.19.298
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      aa8663e85da65e4b92ac82208059c173cb42c3bd =



Test Regressions
---------------- =



platform                | arch  | lab          | compiler | defconfig      =
     | regressions
------------------------+-------+--------------+----------+----------------=
-----+------------
beaglebone-black        | arm   | lab-broonie  | gcc-10   | omap2plus_defco=
nfig | 1          =


  Details:     https://kernelci.org/test/plan/id/654b68bc1f8293d26befcf02

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.298/=
arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.298/=
arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/654b68bc1f8293d26befcf38
        new failure (last pass: v4.19.296)

    2023-11-08T10:53:11.611055  + set +x<8>[   17.633632] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 225911_1.5.2.4.1>
    2023-11-08T10:53:11.611372  =

    2023-11-08T10:53:11.721847  / # #
    2023-11-08T10:53:11.823841  export SHELL=3D/bin/sh
    2023-11-08T10:53:11.824346  #
    2023-11-08T10:53:11.925654  / # export SHELL=3D/bin/sh. /lava-225911/en=
vironment
    2023-11-08T10:53:11.926263  =

    2023-11-08T10:53:12.027953  / # . /lava-225911/environment/lava-225911/=
bin/lava-test-runner /lava-225911/1
    2023-11-08T10:53:12.028824  =

    2023-11-08T10:53:12.033438  / # /lava-225911/bin/lava-test-runner /lava=
-225911/1 =

    ... (12 line(s) more)  =

 =



platform                | arch  | lab          | compiler | defconfig      =
     | regressions
------------------------+-------+--------------+----------+----------------=
-----+------------
beaglebone-black        | arm   | lab-cip      | gcc-10   | omap2plus_defco=
nfig | 1          =


  Details:     https://kernelci.org/test/plan/id/654b68b9ca167c2d34efcefd

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.298/=
arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.298/=
arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/654b68b9ca167c2d34efcf26
        new failure (last pass: v4.19.296)

    2023-11-08T10:53:05.652906  + set +x<8>[   10.583490] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1034998_1.5.2.4.1>
    2023-11-08T10:53:05.653335  =

    2023-11-08T10:53:05.767374  / # #
    2023-11-08T10:53:05.869475  export SHELL=3D/bin/sh
    2023-11-08T10:53:05.870123  #
    2023-11-08T10:53:05.971440  / # export SHELL=3D/bin/sh. /lava-1034998/e=
nvironment
    2023-11-08T10:53:05.972096  =

    2023-11-08T10:53:06.073399  / # . /lava-1034998/environment/lava-103499=
8/bin/lava-test-runner /lava-1034998/1
    2023-11-08T10:53:06.074481  =

    2023-11-08T10:53:06.081378  / # /lava-1034998/bin/lava-test-runner /lav=
a-1034998/1 =

    ... (12 line(s) more)  =

 =



platform                | arch  | lab          | compiler | defconfig      =
     | regressions
------------------------+-------+--------------+----------+----------------=
-----+------------
meson-gxl-s905d-p230    | arm64 | lab-baylibre | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/654b685f802936aa97efcef4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.298/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-s905d-p230.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.298/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-s905d-p230.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/654b685f802936aa97efcefd
        new failure (last pass: v4.19.297)

    2023-11-08T10:51:55.809523  + set +x<8>[   68.460772] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3827259_1.5.2.4.1>
    2023-11-08T10:51:55.809693  =

    2023-11-08T10:51:55.914901  / # #
    2023-11-08T10:51:56.017216  export SHELL=3D/bin/sh
    2023-11-08T10:51:56.017566  #
    2023-11-08T10:51:56.017711  / # <4>[   68.590924] ------------[ cut her=
e ]------------
    2023-11-08T10:51:56.017818  <4>[   68.590995] WARNING: CPU: 0 PID: 0 at=
 drivers/mmc/host/meson-gx-mmc.c:1040 meson_mmc_irq+0x1c8/0x1dc
    2023-11-08T10:51:56.017933  <4>[   68.599484] Modules linked in: ipv6 d=
wmac_generic realtek meson_gxl meson_dw_hdmi dw_hdmi meson_rng meson_drm dr=
m_kms_helper crc32_ce crct10dif_ce rng_core meson_ir drm rc_core dwmac_meso=
n8b stmmac_platform stmmac pwm_meson meson_gxbb_wdt drm_panel_orientation_q=
uirks adc_keys nvmem_meson_efuse input_polldev
    2023-11-08T10:51:56.018043  <4>[   68.626743] CPU: 0 PID: 0 Comm: swapp=
er/0 Tainted: G        W         4.19.298 #1
    2023-11-08T10:51:56.018142  <4>[   68.634415] Hardware name: Amlogic Me=
son GXL (S905D) P230 Development Board (DT) =

    ... (239 line(s) more)  =

 =



platform                | arch  | lab          | compiler | defconfig      =
     | regressions
------------------------+-------+--------------+----------+----------------=
-----+------------
meson-gxm-q200          | arm64 | lab-baylibre | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/654b680dfee4ff488eefcf1e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.298/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.298/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/654b680dfee4ff4=
88eefcf21
        new failure (last pass: v4.19.288)
        1 lines

    2023-11-08T10:50:29.382229  <4>[   49.606920] WARNING: CPU: 0 PID: 0 at=
 drivers/mmc/host/meson-gx-mmc.c:1040 meson_mmc_irq+0x1c8/0x1dc
    2023-11-08T10:50:29.422411  <4>[   49.615392] Modules linked in: ipv6 r=
ealtek meson_gxl dwmac_generic meson_dw_hdmi meson_drm dw_hdmi drm_kms_help=
er drm meson_gxbb_wdt meson_ir crc32_ce dwmac_meson8b stmmac_platform adc_k=
eys meson_rng input_polldev rc_core rng_core crct10dif_ce pwm_meson stmmac =
drm_panel_orientation_quirks nvmem_meson_efuse
    2023-11-08T10:50:29.423836  <4>[   49.642651] CPU: 0 PID: 0 Comm: swapp=
er/0 Tainted: G        W         4.19.298 #1
    2023-11-08T10:50:29.424473  <4>[   49.650323] Hardware name: Amlogic Me=
son GXM (S912) Q200 Development Board (DT)
    2023-11-08T10:50:29.424773  <4>[   49.657828] pstate: 60000085 (nZCv da=
If -PAN -UAO)
    2023-11-08T10:50:29.425285  <4>[   49.662830] pc : meson_mmc_irq+0x1c8/=
0x1dc
    2023-11-08T10:50:29.425575  <4>[   49.667142] lr : meson_mmc_irq+0x1c8/=
0x1dc
    2023-11-08T10:50:29.425844  <4>[   49.671453] sp : ffff000008003cc0
    2023-11-08T10:50:29.464936  <4>[   49.674989] x29: ffff000008003cc0 x28=
: 0000000000000080 =

    2023-11-08T10:50:29.465715  <4>[   49.680509] x27: 0000000000000001 x26=
: ffff000008ee7e88  =

    ... (35 line(s) more)  =

 =



platform                | arch  | lab          | compiler | defconfig      =
     | regressions
------------------------+-------+--------------+----------+----------------=
-----+------------
sun50i-a64-bananapi-m64 | arm64 | lab-clabbe   | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/654b67b9c7c551cab8efcf5f

  Results:     7 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.298/=
arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-a64-bananapi-m64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.298/=
arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-a64-bananapi-m64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/654b67b9c7c551cab8efcf74
        failing since 293 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-11-08T10:49:04.104119  + set +x
    2023-11-08T10:49:04.106122  <8>[   17.151504] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 443196_1.5.2.4.1>
    2023-11-08T10:49:04.213137  / # #
    2023-11-08T10:49:04.314901  export SHELL=3D/bin/sh
    2023-11-08T10:49:04.315525  #
    2023-11-08T10:49:04.416593  / # export SHELL=3D/bin/sh. /lava-443196/en=
vironment
    2023-11-08T10:49:04.417211  =

    2023-11-08T10:49:04.417501  / # <3>[   17.369743] brcmfmac: brcmf_sdio_=
htclk: HT Avail timeout (1000000): clkctl 0x50
    2023-11-08T10:49:04.518524  . /lava-443196/environment/lava-443196/bin/=
lava-test-runner /lava-443196/1
    2023-11-08T10:49:04.519958   =

    ... (13 line(s) more)  =

 =



platform                | arch  | lab          | compiler | defconfig      =
     | regressions
------------------------+-------+--------------+----------+----------------=
-----+------------
sun50i-a64-pine64-plus  | arm64 | lab-baylibre | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/654b6902e1eb52bc6eefcefb

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.298/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.298/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/654b6902e1eb52bc6eefcf15
        failing since 275 days (last pass: v4.19.268, first fail: v4.19.272)

    2023-11-08T10:53:29.618277  <8>[   15.950879] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3827250_1.5.2.4.1>
    2023-11-08T10:53:29.727512  / # #
    2023-11-08T10:53:29.830914  export SHELL=3D/bin/sh
    2023-11-08T10:53:29.832128  #
    2023-11-08T10:53:29.934108  / # export SHELL=3D/bin/sh. /lava-3827250/e=
nvironment
    2023-11-08T10:53:29.935299  =

    2023-11-08T10:53:30.037293  / # . /lava-3827250/environment/lava-382725=
0/bin/lava-test-runner /lava-3827250/1
    2023-11-08T10:53:30.038958  =

    2023-11-08T10:53:30.043873  / # /lava-3827250/bin/lava-test-runner /lav=
a-3827250/1
    2023-11-08T10:53:30.087582  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                | arch  | lab          | compiler | defconfig      =
     | regressions
------------------------+-------+--------------+----------+----------------=
-----+------------
sun50i-a64-pine64-plus  | arm64 | lab-broonie  | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/654b67dfd67c14dfb1efcf17

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.298/=
arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.298/=
arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/654b67dfd67c14dfb1efcf40
        failing since 275 days (last pass: v4.19.268, first fail: v4.19.272)

    2023-11-08T10:49:25.222159  <8>[   15.955116] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 225900_1.5.2.4.1>
    2023-11-08T10:49:25.327743  / # #
    2023-11-08T10:49:25.429722  export SHELL=3D/bin/sh
    2023-11-08T10:49:25.430297  #
    2023-11-08T10:49:25.531943  / # export SHELL=3D/bin/sh. /lava-225900/en=
vironment
    2023-11-08T10:49:25.532475  =

    2023-11-08T10:49:25.634111  / # . /lava-225900/environment/lava-225900/=
bin/lava-test-runner /lava-225900/1
    2023-11-08T10:49:25.634825  =

    2023-11-08T10:49:25.638933  / # /lava-225900/bin/lava-test-runner /lava=
-225900/1
    2023-11-08T10:49:25.670355  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
