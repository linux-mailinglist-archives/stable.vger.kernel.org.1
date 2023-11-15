Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AAD7ED803
	for <lists+stable@lfdr.de>; Thu, 16 Nov 2023 00:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjKOXSq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 18:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjKOXSq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 18:18:46 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03DF194
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 15:18:36 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1ce28faa92dso2138325ad.2
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 15:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700090316; x=1700695116; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K+acoOHL4kX4oEF8Um1hqOXxppQsIW5VfvwaxS+Q0zA=;
        b=nusnWe+uwT08AzUjJkes6Kz1bUpx58Kgb7GmeHUPE6WHj5T3vQOATASYjnhzD8NB18
         Dj5gn1yRgDQeG7UWrVz0TbU8WiSy1gwnCAZ5E+cNMxsB1uBOsS/H402v81r0kuoTZyqh
         CqxK92CVrzPtdIHmwMUhffj3kDaVCwTmuySmarpckivy8+GgY0ppNorzbj4DGZuo65Wk
         Kka6wB9TvbBHcOyRguFqEsyx9r3maUA5KFo6yrt1mJnUpxawGKXQ0tIC7F7szTgxcuru
         BPWkfukwABu3yW5u6gTDB12QzjD2lFx5ZZbKtKgxPzfh60R3hZ4k3/TvFqbjm1q4TxfN
         qQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700090316; x=1700695116;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+acoOHL4kX4oEF8Um1hqOXxppQsIW5VfvwaxS+Q0zA=;
        b=jd5VZHKlhuLSKTegENa0aKsTgnFspC6M7ZkhdFEfeFqbSupj5F5C8715wQ1+pIO1yK
         ERz6TdU7MFbAVe8YjVZLENu6Hp4I2VSYK1nBNN245FB77o66gT04EocWvDoIdoANr7LY
         jIFuz1YTOZmRoKNoA9KkNL5mMHKkrWXNb4RvQpk9jv0XMVDCMhhLEvHWZ7hCu2e3m/yQ
         tYfZCaLRlFq/Gsnwrvow+DcJhNE+sXtmfp0GYZJh3el5dA3i3edWzVQBXSuKfkWRmgkX
         WUsYZRKYAmWAryMd0HAeRjDvof7fOwdj5iG9rUTvpThGrkN2VTehJ16HLRrIuQceJWFu
         +WYA==
X-Gm-Message-State: AOJu0YxwTbTPZnX1hfePcdnsU7/teios2GjIvyxwuYVoayB6toQyKHDI
        vKgOgOXj9oBmFcdKxZtrLX9NZXo/EgpTpUop0mJKJw==
X-Google-Smtp-Source: AGHT+IE6Es1q+LIC+Gv8x3Wp4qviBHZv0axA3YT/d5FB16WH1RWtBWQ3LpoGGnwBDh07x2U0DHofuw==
X-Received: by 2002:a17:90b:3886:b0:27d:3ecb:3cbb with SMTP id mu6-20020a17090b388600b0027d3ecb3cbbmr12534713pjb.37.1700090315583;
        Wed, 15 Nov 2023 15:18:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e5c600b001ca21e05c69sm7867365plf.109.2023.11.15.15.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 15:18:34 -0800 (PST)
Message-ID: <655551ca.170a0220.30167.5e3d@mx.google.com>
Date:   Wed, 15 Nov 2023 15:18:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.19.298-89-g83d114914749
Subject: stable-rc/linux-4.19.y baseline: 91 runs,
 4 regressions (v4.19.298-89-g83d114914749)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-4.19.y baseline: 91 runs, 4 regressions (v4.19.298-89-g83d1=
14914749)

Regressions Summary
-------------------

platform               | arch  | lab          | compiler | defconfig       =
    | regressions
-----------------------+-------+--------------+----------+-----------------=
----+------------
beaglebone-black       | arm   | lab-broonie  | gcc-10   | omap2plus_defcon=
fig | 1          =

meson-gxl-s905d-p230   | arm64 | lab-baylibre | gcc-10   | defconfig       =
    | 1          =

meson-gxm-q200         | arm64 | lab-baylibre | gcc-10   | defconfig       =
    | 1          =

sun50i-a64-pine64-plus | arm64 | lab-broonie  | gcc-10   | defconfig       =
    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.19.y/ker=
nel/v4.19.298-89-g83d114914749/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.298-89-g83d114914749
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      83d114914749948d1e49cf019cd2f1ee486fabf5 =



Test Regressions
---------------- =



platform               | arch  | lab          | compiler | defconfig       =
    | regressions
-----------------------+-------+--------------+----------+-----------------=
----+------------
beaglebone-black       | arm   | lab-broonie  | gcc-10   | omap2plus_defcon=
fig | 1          =


  Details:     https://kernelci.org/test/plan/id/655521322aa7a3c8347e4a6e

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
98-89-g83d114914749/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
98-89-g83d114914749/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655521322aa7a3c8347e4aa2
        new failure (last pass: v4.19.298-87-g060b297883f5)

    2023-11-15T19:50:37.132174  + set +x<8>[   20.393725] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 244406_1.5.2.4.1>
    2023-11-15T19:50:37.132801  =

    2023-11-15T19:50:37.246262  / # #
    2023-11-15T19:50:37.349387  export SHELL=3D/bin/sh
    2023-11-15T19:50:37.350308  #
    2023-11-15T19:50:37.452407  / # export SHELL=3D/bin/sh. /lava-244406/en=
vironment
    2023-11-15T19:50:37.453375  =

    2023-11-15T19:50:37.555516  / # . /lava-244406/environment/lava-244406/=
bin/lava-test-runner /lava-244406/1
    2023-11-15T19:50:37.556979  =

    2023-11-15T19:50:37.560661  / # /lava-244406/bin/lava-test-runner /lava=
-244406/1 =

    ... (12 line(s) more)  =

 =



platform               | arch  | lab          | compiler | defconfig       =
    | regressions
-----------------------+-------+--------------+----------+-----------------=
----+------------
meson-gxl-s905d-p230   | arm64 | lab-baylibre | gcc-10   | defconfig       =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/655520927fc514ddd67e4a6d

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
98-89-g83d114914749/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-=
s905d-p230.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
98-89-g83d114914749/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-=
s905d-p230.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655520927fc514ddd67e4a76
        new failure (last pass: v4.19.298-87-g060b297883f5)

    2023-11-15T19:48:04.993049  + set +x<8>[   50.368526] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3835133_1.5.2.4.1>
    2023-11-15T19:48:04.993588  =

    2023-11-15T19:48:05.102355  / # #
    2023-11-15T19:48:05.205110  export SHELL=3D/bin/sh
    2023-11-15T19:48:05.205478  #
    2023-11-15T19:48:05.205618  / # <4>[   50.498178] ------------[ cut her=
e ]------------
    2023-11-15T19:48:05.205724  <4>[   50.498249] WARNING: CPU: 0 PID: 0 at=
 drivers/mmc/host/meson-gx-mmc.c:1040 meson_mmc_irq+0x1c8/0x1dc
    2023-11-15T19:48:05.205823  <4>[   50.506733] Modules linked in: ipv6 d=
wmac_generic realtek meson_gxl meson_dw_hdmi dw_hdmi meson_drm drm_kms_help=
er drm meson_rng crc32_ce crct10dif_ce dwmac_meson8b stmmac_platform meson_=
ir rc_core rng_core stmmac drm_panel_orientation_quirks adc_keys meson_gxbb=
_wdt pwm_meson nvmem_meson_efuse input_polldev
    2023-11-15T19:48:05.205925  <4>[   50.533993] CPU: 0 PID: 0 Comm: swapp=
er/0 Tainted: G        W         4.19.299-rc1 #1
    2023-11-15T19:48:05.206019  <4>[   50.542009] Hardware name: Amlogic Me=
son GXL (S905D) P230 Development Board (DT) =

    ... (233 line(s) more)  =

 =



platform               | arch  | lab          | compiler | defconfig       =
    | regressions
-----------------------+-------+--------------+----------+-----------------=
----+------------
meson-gxm-q200         | arm64 | lab-baylibre | gcc-10   | defconfig       =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/655522fbae9fa9a1e57e4a8c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
98-89-g83d114914749/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-=
q200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
98-89-g83d114914749/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-=
q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/655522fbae9fa9a=
1e57e4a8f
        new failure (last pass: v4.19.298-87-g060b297883f5)
        1 lines

    2023-11-15T19:58:34.628348  <4>[   49.522511] ------------[ cut here ]-=
-----------
    2023-11-15T19:58:34.628946  <4>[   49.522598] WARNING: CPU: 0 PID: 0 at=
 drivers/mmc/host/meson-gx-mmc.c:1040 meson_mmc_irq+0x1c8/0x1dc
    2023-11-15T19:58:34.632439  <4>[   49.531068] Modules linked in: ipv6 d=
wmac_generic meson_dw_hdmi realtek meson_gxl dw_hdmi meson_drm drm_kms_help=
er meson_rng dwmac_meson8b drm stmmac_platform adc_keys rng_core stmmac mes=
on_ir crc32_ce crct10dif_ce rc_core meson_gxbb_wdt pwm_meson drm_panel_orie=
ntation_quirks nvmem_meson_efuse input_polldev
    2023-11-15T19:58:34.671783  <4>[   49.558327] CPU: 0 PID: 0 Comm: swapp=
er/0 Tainted: G        W         4.19.299-rc1 #1
    2023-11-15T19:58:34.672017  <4>[   49.566343] Hardware name: Amlogic Me=
son GXM (S912) Q200 Development Board (DT)
    2023-11-15T19:58:34.672269  <4>[   49.573850] pstate: 60000085 (nZCv da=
If -PAN -UAO)
    2023-11-15T19:58:34.672486  <4>[   49.578851] pc : meson_mmc_irq+0x1c8/=
0x1dc
    2023-11-15T19:58:34.672911  <4>[   49.583165] lr : meson_mmc_irq+0x1c8/=
0x1dc
    2023-11-15T19:58:34.673123  <8>[   49.584844] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D1>   =

 =



platform               | arch  | lab          | compiler | defconfig       =
    | regressions
-----------------------+-------+--------------+----------+-----------------=
----+------------
sun50i-a64-pine64-plus | arm64 | lab-broonie  | gcc-10   | defconfig       =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/6555219696c2e1c5867e4ad0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
98-89-g83d114914749/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-=
pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
98-89-g83d114914749/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-=
pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6555219696c2e1c5867e4=
ad1
        new failure (last pass: v4.19.298-87-g060b297883f5) =

 =20
