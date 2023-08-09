Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CB7775AF8
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjHILNI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbjHILNH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:13:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B7910F3
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:13:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9191762347
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54D8C433C8;
        Wed,  9 Aug 2023 11:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579586;
        bh=bagmIbV1nwDNCHl7KbGKA/QUvQ+rWOlS6GKdmsltRjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zuUJWCG+L0CqezfXB0Dg3cYyk4AO4cQo9rRkq5v/1ZbFNz1JpnMCYsZYYAbKTtWjK
         AecLr0SdEOmt23hKtrAJfGLMSiW3+s02gZVY5s/OdR6sv44WJMlaG7X8euO7cTHMf0
         2gMO5ZUYEEvb5KMONGj7NQB9NmdGc1ri5LJmPKjw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 015/323] clocksource/drivers: Unify the names to timer-* format
Date:   Wed,  9 Aug 2023 12:37:33 +0200
Message-ID: <20230809103658.791517986@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

[ Upstream commit 9d8d47ea6ec6048abc75ccc4486aff1a7db1ff4b ]

In order to make some housekeeping in the directory, this patch renames
drivers to the timer-* format in order to unify their names.

There is no functional changes.

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Vladimir Zapolskiy <vz@mleia.com>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Stable-dep-of: 8b5bf64c89c7 ("clocksource/drivers/cadence-ttc: Fix memory leak in ttc_timer_probe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 MAINTAINERS                                   | 10 +++----
 drivers/clocksource/Makefile                  | 26 +++++++++----------
 ...-armada-370-xp.c => timer-armada-370-xp.c} |  0
 ...adence_ttc_timer.c => timer-cadence-ttc.c} |  0
 .../{time-efm32.c => timer-efm32.c}           |  0
 .../{fsl_ftm_timer.c => timer-fsl-ftm.c}      |  0
 .../{time-lpc32xx.c => timer-lpc32xx.c}       |  0
 .../{time-orion.c => timer-orion.c}           |  0
 .../clocksource/{owl-timer.c => timer-owl.c}  |  0
 .../{time-pistachio.c => timer-pistachio.c}   |  0
 .../{qcom-timer.c => timer-qcom.c}            |  0
 .../{versatile.c => timer-versatile.c}        |  0
 .../{vf_pit_timer.c => timer-vf-pit.c}        |  0
 .../{vt8500_timer.c => timer-vt8500.c}        |  0
 .../{zevio-timer.c => timer-zevio.c}          |  0
 15 files changed, 18 insertions(+), 18 deletions(-)
 rename drivers/clocksource/{time-armada-370-xp.c => timer-armada-370-xp.c} (100%)
 rename drivers/clocksource/{cadence_ttc_timer.c => timer-cadence-ttc.c} (100%)
 rename drivers/clocksource/{time-efm32.c => timer-efm32.c} (100%)
 rename drivers/clocksource/{fsl_ftm_timer.c => timer-fsl-ftm.c} (100%)
 rename drivers/clocksource/{time-lpc32xx.c => timer-lpc32xx.c} (100%)
 rename drivers/clocksource/{time-orion.c => timer-orion.c} (100%)
 rename drivers/clocksource/{owl-timer.c => timer-owl.c} (100%)
 rename drivers/clocksource/{time-pistachio.c => timer-pistachio.c} (100%)
 rename drivers/clocksource/{qcom-timer.c => timer-qcom.c} (100%)
 rename drivers/clocksource/{versatile.c => timer-versatile.c} (100%)
 rename drivers/clocksource/{vf_pit_timer.c => timer-vf-pit.c} (100%)
 rename drivers/clocksource/{vt8500_timer.c => timer-vt8500.c} (100%)
 rename drivers/clocksource/{zevio-timer.c => timer-zevio.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d3d7f5d1c3f1..59003315a9597 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1180,7 +1180,7 @@ N:	owl
 F:	arch/arm/mach-actions/
 F:	arch/arm/boot/dts/owl-*
 F:	arch/arm64/boot/dts/actions/
-F:	drivers/clocksource/owl-*
+F:	drivers/clocksource/timer-owl*
 F:	drivers/pinctrl/actions/*
 F:	drivers/soc/actions/
 F:	include/dt-bindings/power/owl-*
@@ -1603,7 +1603,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/boot/dts/lpc43*
 F:	drivers/clk/nxp/clk-lpc18xx*
-F:	drivers/clocksource/time-lpc32xx.c
+F:	drivers/clocksource/timer-lpc32xx.c
 F:	drivers/i2c/busses/i2c-lpc2k.c
 F:	drivers/memory/pl172.c
 F:	drivers/mtd/spi-nor/nxp-spifi.c
@@ -2219,7 +2219,7 @@ F:	arch/arm/mach-vexpress/
 F:	*/*/vexpress*
 F:	*/*/*/vexpress*
 F:	drivers/clk/versatile/clk-vexpress-osc.c
-F:	drivers/clocksource/versatile.c
+F:	drivers/clocksource/timer-versatile.c
 N:	mps2
 
 ARM/VFP SUPPORT
@@ -2241,7 +2241,7 @@ M:	Tony Prisk <linux@prisktech.co.nz>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-vt8500/
-F:	drivers/clocksource/vt8500_timer.c
+F:	drivers/clocksource/timer-vt8500.c
 F:	drivers/i2c/busses/i2c-wmt.c
 F:	drivers/mmc/host/wmt-sdmmc.c
 F:	drivers/pwm/pwm-vt8500.c
@@ -2306,7 +2306,7 @@ F:	drivers/cpuidle/cpuidle-zynq.c
 F:	drivers/block/xsysace.c
 N:	zynq
 N:	xilinx
-F:	drivers/clocksource/cadence_ttc_timer.c
+F:	drivers/clocksource/timer-cadence-ttc.c
 F:	drivers/i2c/busses/i2c-cadence.c
 F:	drivers/mmc/host/sdhci-of-arasan.c
 F:	drivers/edac/synopsys_edac.c
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index db51b2427e8a6..e33b21d3f9d8b 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -23,8 +23,8 @@ obj-$(CONFIG_FTTMR010_TIMER)	+= timer-fttmr010.o
 obj-$(CONFIG_ROCKCHIP_TIMER)      += rockchip_timer.o
 obj-$(CONFIG_CLKSRC_NOMADIK_MTU)	+= nomadik-mtu.o
 obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clksrc-dbx500-prcmu.o
-obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= time-armada-370-xp.o
-obj-$(CONFIG_ORION_TIMER)	+= time-orion.o
+obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= timer-armada-370-xp.o
+obj-$(CONFIG_ORION_TIMER)	+= timer-orion.o
 obj-$(CONFIG_BCM2835_TIMER)	+= bcm2835_timer.o
 obj-$(CONFIG_CLPS711X_TIMER)	+= clps711x-timer.o
 obj-$(CONFIG_ATLAS7_TIMER)	+= timer-atlas7.o
@@ -36,25 +36,25 @@ obj-$(CONFIG_SUN4I_TIMER)	+= sun4i_timer.o
 obj-$(CONFIG_SUN5I_HSTIMER)	+= timer-sun5i.o
 obj-$(CONFIG_MESON6_TIMER)	+= meson6_timer.o
 obj-$(CONFIG_TEGRA_TIMER)	+= tegra20_timer.o
-obj-$(CONFIG_VT8500_TIMER)	+= vt8500_timer.o
-obj-$(CONFIG_NSPIRE_TIMER)	+= zevio-timer.o
+obj-$(CONFIG_VT8500_TIMER)	+= timer-vt8500.o
+obj-$(CONFIG_NSPIRE_TIMER)	+= timer-zevio.o
 obj-$(CONFIG_BCM_KONA_TIMER)	+= bcm_kona_timer.o
-obj-$(CONFIG_CADENCE_TTC_TIMER)	+= cadence_ttc_timer.o
-obj-$(CONFIG_CLKSRC_EFM32)	+= time-efm32.o
+obj-$(CONFIG_CADENCE_TTC_TIMER)	+= timer-cadence-ttc.o
+obj-$(CONFIG_CLKSRC_EFM32)	+= timer-efm32.o
 obj-$(CONFIG_CLKSRC_STM32)	+= timer-stm32.o
 obj-$(CONFIG_CLKSRC_EXYNOS_MCT)	+= exynos_mct.o
-obj-$(CONFIG_CLKSRC_LPC32XX)	+= time-lpc32xx.o
+obj-$(CONFIG_CLKSRC_LPC32XX)	+= timer-lpc32xx.o
 obj-$(CONFIG_CLKSRC_MPS2)	+= mps2-timer.o
 obj-$(CONFIG_CLKSRC_SAMSUNG_PWM)	+= samsung_pwm_timer.o
-obj-$(CONFIG_FSL_FTM_TIMER)	+= fsl_ftm_timer.o
-obj-$(CONFIG_VF_PIT_TIMER)	+= vf_pit_timer.o
-obj-$(CONFIG_CLKSRC_QCOM)	+= qcom-timer.o
+obj-$(CONFIG_FSL_FTM_TIMER)	+= timer-fsl-ftm.o
+obj-$(CONFIG_VF_PIT_TIMER)	+= timer-vf-pit.o
+obj-$(CONFIG_CLKSRC_QCOM)	+= timer-qcom.o
 obj-$(CONFIG_MTK_TIMER)		+= timer-mediatek.o
-obj-$(CONFIG_CLKSRC_PISTACHIO)	+= time-pistachio.o
+obj-$(CONFIG_CLKSRC_PISTACHIO)	+= timer-pistachio.o
 obj-$(CONFIG_CLKSRC_TI_32K)	+= timer-ti-32k.o
 obj-$(CONFIG_CLKSRC_NPS)	+= timer-nps.o
 obj-$(CONFIG_OXNAS_RPS_TIMER)	+= timer-oxnas-rps.o
-obj-$(CONFIG_OWL_TIMER)		+= owl-timer.o
+obj-$(CONFIG_OWL_TIMER)		+= timer-owl.o
 obj-$(CONFIG_SPRD_TIMER)	+= timer-sprd.o
 obj-$(CONFIG_NPCM7XX_TIMER)	+= timer-npcm7xx.o
 
@@ -66,7 +66,7 @@ obj-$(CONFIG_ARM_TIMER_SP804)		+= timer-sp804.o
 obj-$(CONFIG_ARCH_HAS_TICK_BROADCAST)	+= dummy_timer.o
 obj-$(CONFIG_KEYSTONE_TIMER)		+= timer-keystone.o
 obj-$(CONFIG_INTEGRATOR_AP_TIMER)	+= timer-integrator-ap.o
-obj-$(CONFIG_CLKSRC_VERSATILE)		+= versatile.o
+obj-$(CONFIG_CLKSRC_VERSATILE)		+= timer-versatile.o
 obj-$(CONFIG_CLKSRC_MIPS_GIC)		+= mips-gic-timer.o
 obj-$(CONFIG_CLKSRC_TANGO_XTAL)		+= tango_xtal.o
 obj-$(CONFIG_CLKSRC_IMX_GPT)		+= timer-imx-gpt.o
diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/timer-armada-370-xp.c
similarity index 100%
rename from drivers/clocksource/time-armada-370-xp.c
rename to drivers/clocksource/timer-armada-370-xp.c
diff --git a/drivers/clocksource/cadence_ttc_timer.c b/drivers/clocksource/timer-cadence-ttc.c
similarity index 100%
rename from drivers/clocksource/cadence_ttc_timer.c
rename to drivers/clocksource/timer-cadence-ttc.c
diff --git a/drivers/clocksource/time-efm32.c b/drivers/clocksource/timer-efm32.c
similarity index 100%
rename from drivers/clocksource/time-efm32.c
rename to drivers/clocksource/timer-efm32.c
diff --git a/drivers/clocksource/fsl_ftm_timer.c b/drivers/clocksource/timer-fsl-ftm.c
similarity index 100%
rename from drivers/clocksource/fsl_ftm_timer.c
rename to drivers/clocksource/timer-fsl-ftm.c
diff --git a/drivers/clocksource/time-lpc32xx.c b/drivers/clocksource/timer-lpc32xx.c
similarity index 100%
rename from drivers/clocksource/time-lpc32xx.c
rename to drivers/clocksource/timer-lpc32xx.c
diff --git a/drivers/clocksource/time-orion.c b/drivers/clocksource/timer-orion.c
similarity index 100%
rename from drivers/clocksource/time-orion.c
rename to drivers/clocksource/timer-orion.c
diff --git a/drivers/clocksource/owl-timer.c b/drivers/clocksource/timer-owl.c
similarity index 100%
rename from drivers/clocksource/owl-timer.c
rename to drivers/clocksource/timer-owl.c
diff --git a/drivers/clocksource/time-pistachio.c b/drivers/clocksource/timer-pistachio.c
similarity index 100%
rename from drivers/clocksource/time-pistachio.c
rename to drivers/clocksource/timer-pistachio.c
diff --git a/drivers/clocksource/qcom-timer.c b/drivers/clocksource/timer-qcom.c
similarity index 100%
rename from drivers/clocksource/qcom-timer.c
rename to drivers/clocksource/timer-qcom.c
diff --git a/drivers/clocksource/versatile.c b/drivers/clocksource/timer-versatile.c
similarity index 100%
rename from drivers/clocksource/versatile.c
rename to drivers/clocksource/timer-versatile.c
diff --git a/drivers/clocksource/vf_pit_timer.c b/drivers/clocksource/timer-vf-pit.c
similarity index 100%
rename from drivers/clocksource/vf_pit_timer.c
rename to drivers/clocksource/timer-vf-pit.c
diff --git a/drivers/clocksource/vt8500_timer.c b/drivers/clocksource/timer-vt8500.c
similarity index 100%
rename from drivers/clocksource/vt8500_timer.c
rename to drivers/clocksource/timer-vt8500.c
diff --git a/drivers/clocksource/zevio-timer.c b/drivers/clocksource/timer-zevio.c
similarity index 100%
rename from drivers/clocksource/zevio-timer.c
rename to drivers/clocksource/timer-zevio.c
-- 
2.39.2



