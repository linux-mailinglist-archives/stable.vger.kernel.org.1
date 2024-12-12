Return-Path: <stable+bounces-103177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445099EF562
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5FC8283D18
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5101F2381;
	Thu, 12 Dec 2024 17:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1tSQi8ay"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759D26F2FE;
	Thu, 12 Dec 2024 17:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023776; cv=none; b=fa/50tNYATpHHyuKXp/fIT/cRCZZr7KrJsJjsu14WSJ8N18Fu7XkNwQGVtU6SGvk0jgQHx/enhRHvmEv1tDkZNnmGfzAFpHrVFf+fJbgriu1OO0yiyx7kTavw2XYd74+Che+Va/fnk86Ukr2+fB4hRBuICmItqKvd9xGIwin0co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023776; c=relaxed/simple;
	bh=KTOr85fSl0DT3t7l3Hm4LTeacR0vEEaU75sEBwlFMUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EiSz5iRY95wmFRKmFBphJ9u7cE/T3DMseoWhMVUaf5WYgZtM6GObrSzszcYYEmVaKswp1XgyQwFeE4kg2oQt1sKADFDRX55ESR94cOGQez3tg9e7R0aKLsFrOkPbcFXYnqH3eQhzd6CF9t/4nqx4FV4upCr/I8espphZPbBwBDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1tSQi8ay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0405C4CECE;
	Thu, 12 Dec 2024 17:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734023776;
	bh=KTOr85fSl0DT3t7l3Hm4LTeacR0vEEaU75sEBwlFMUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1tSQi8ayvlrb4aqx6H+h1CX+Aqc1/pTa7QwUywZoAbN4wCdekt4K3ozCJTT9mBkxU
	 rlPqVlyYzRuZmBw88UxVmLXHsU8O/YcByjbNdTzXZvUwXiYpnq+XsmV2zO+0jIewgd
	 tcfWr+QJ9szBgPhYtYOc0E+3qAJwf0PPSRgF8lRM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 078/459] clkdev: remove CONFIG_CLKDEV_LOOKUP
Date: Thu, 12 Dec 2024 15:56:56 +0100
Message-ID: <20241212144256.604438110@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 2f4574dd6dd19eb3e8ab0415a3ae960d04be3a65 ]

This option is now synonymous with CONFIG_HAVE_CLK, so use
the latter globally. Any out-of-tree platform ports that
still use a private clk_get()/clk_put() implementation should
move to CONFIG_COMMON_CLK.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Stable-dep-of: 0309f714a090 ("clocksource/drivers:sp804: Make user selectable")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/Kconfig              |  2 --
 arch/mips/Kconfig             |  3 ---
 arch/mips/pic32/Kconfig       |  1 -
 arch/sh/Kconfig               |  1 -
 drivers/clk/Kconfig           |  6 +-----
 drivers/clk/Makefile          |  3 +--
 drivers/clocksource/Kconfig   |  6 +++---
 drivers/mmc/host/Kconfig      |  4 ++--
 drivers/staging/board/Kconfig |  2 +-
 sound/soc/dwc/Kconfig         |  2 +-
 sound/soc/rockchip/Kconfig    | 14 +++++++-------
 11 files changed, 16 insertions(+), 28 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 335308aff6ce0..27db1bddfb6c5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -366,7 +366,6 @@ config ARCH_EP93XX
 	imply ARM_PATCH_PHYS_VIRT
 	select ARM_VIC
 	select AUTO_ZRELADDR
-	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select CPU_ARM920T
 	select GENERIC_CLOCKEVENTS
@@ -523,7 +522,6 @@ config ARCH_OMAP1
 	bool "TI OMAP1"
 	depends on MMU
 	select ARCH_OMAP
-	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 57839f63074f7..7aeb3a7d4926d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -327,7 +327,6 @@ config BCM63XX
 	select SWAP_IO_SPACE
 	select GPIOLIB
 	select MIPS_L1_CACHE_SHIFT_4
-	select CLKDEV_LOOKUP
 	select HAVE_LEGACY_CLK
 	help
 	  Support for BCM63XX based boards
@@ -442,7 +441,6 @@ config LANTIQ
 	select GPIOLIB
 	select SWAP_IO_SPACE
 	select BOOT_RAW
-	select CLKDEV_LOOKUP
 	select HAVE_LEGACY_CLK
 	select USE_OF
 	select PINCTRL
@@ -627,7 +625,6 @@ config RALINK
 	select SYS_SUPPORTS_MIPS16
 	select SYS_SUPPORTS_ZBOOT
 	select SYS_HAS_EARLY_PRINTK
-	select CLKDEV_LOOKUP
 	select ARCH_HAS_RESET_CONTROLLER
 	select RESET_CONTROLLER
 
diff --git a/arch/mips/pic32/Kconfig b/arch/mips/pic32/Kconfig
index 7acbb50c1dcd5..bb6ab1f3e80dc 100644
--- a/arch/mips/pic32/Kconfig
+++ b/arch/mips/pic32/Kconfig
@@ -17,7 +17,6 @@ config PIC32MZDA
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select GPIOLIB
 	select COMMON_CLK
-	select CLKDEV_LOOKUP
 	select LIBFDT
 	select USE_OF
 	select PINCTRL
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 44dffe7ce50ad..51f9ca675c416 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -13,7 +13,6 @@ config SUPERH
 	select ARCH_HIBERNATION_POSSIBLE if MMU
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_WANT_IPC_PARSE_VERSION
-	select CLKDEV_LOOKUP
 	select CPU_NO_EFFICIENT_FFS
 	select DMA_DECLARE_COHERENT
 	select GENERIC_ATOMIC64
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index df739665f2063..1a4cd684a4371 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -6,10 +6,6 @@ config HAVE_CLK
 	  The <linux/clk.h> calls support software clock gating and
 	  thus are a key power management tool on many systems.
 
-config CLKDEV_LOOKUP
-	bool
-	select HAVE_CLK
-
 config HAVE_CLK_PREPARE
 	bool
 
@@ -26,7 +22,7 @@ menuconfig COMMON_CLK
 	bool "Common Clock Framework"
 	depends on !HAVE_LEGACY_CLK
 	select HAVE_CLK_PREPARE
-	select CLKDEV_LOOKUP
+	select HAVE_CLK
 	select SRCU
 	select RATIONAL
 	help
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index da8fcf147eb13..707b592333918 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # common clock types
-obj-$(CONFIG_HAVE_CLK)		+= clk-devres.o clk-bulk.o
-obj-$(CONFIG_CLKDEV_LOOKUP)	+= clkdev.o
+obj-$(CONFIG_HAVE_CLK)		+= clk-devres.o clk-bulk.o clkdev.o
 obj-$(CONFIG_COMMON_CLK)	+= clk.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-divider.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-fixed-factor.o
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index a0c6e88bebe08..be4bb4008d6e6 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -399,7 +399,7 @@ config ARM_GLOBAL_TIMER
 
 config ARM_TIMER_SP804
 	bool "Support for Dual Timer SP804 module" if COMPILE_TEST
-	depends on GENERIC_SCHED_CLOCK && CLKDEV_LOOKUP
+	depends on GENERIC_SCHED_CLOCK && HAVE_CLK
 	select CLKSRC_MMIO
 	select TIMER_OF if OF
 
@@ -617,12 +617,12 @@ config H8300_TPU
 
 config CLKSRC_IMX_GPT
 	bool "Clocksource using i.MX GPT" if COMPILE_TEST
-	depends on (ARM || ARM64) && CLKDEV_LOOKUP
+	depends on (ARM || ARM64) && HAVE_CLK
 	select CLKSRC_MMIO
 
 config CLKSRC_IMX_TPM
 	bool "Clocksource using i.MX TPM" if COMPILE_TEST
-	depends on (ARM || ARM64) && CLKDEV_LOOKUP
+	depends on (ARM || ARM64) && HAVE_CLK
 	select CLKSRC_MMIO
 	select TIMER_OF
 	help
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 8fe4a0fd6ef18..9a6a94d5bdbdb 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -326,7 +326,7 @@ config MMC_SDHCI_SIRF
 
 config MMC_SDHCI_PXAV3
 	tristate "Marvell MMP2 SD Host Controller support (PXAV3)"
-	depends on CLKDEV_LOOKUP
+	depends on HAVE_CLK
 	depends on MMC_SDHCI_PLTFM
 	depends on ARCH_BERLIN || ARCH_MMP || ARCH_MVEBU || COMPILE_TEST
 	default CPU_MMP2
@@ -339,7 +339,7 @@ config MMC_SDHCI_PXAV3
 
 config MMC_SDHCI_PXAV2
 	tristate "Marvell PXA9XX SD Host Controller support (PXAV2)"
-	depends on CLKDEV_LOOKUP
+	depends on HAVE_CLK
 	depends on MMC_SDHCI_PLTFM
 	depends on ARCH_MMP || COMPILE_TEST
 	default CPU_PXA910
diff --git a/drivers/staging/board/Kconfig b/drivers/staging/board/Kconfig
index d0c6e42eadda4..ff5e417dd8528 100644
--- a/drivers/staging/board/Kconfig
+++ b/drivers/staging/board/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config STAGING_BOARD
 	bool "Staging Board Support"
-	depends on OF_ADDRESS && OF_IRQ && CLKDEV_LOOKUP
+	depends on OF_ADDRESS && OF_IRQ && HAVE_CLK
 	help
 	  Select to enable per-board staging support code.
 
diff --git a/sound/soc/dwc/Kconfig b/sound/soc/dwc/Kconfig
index 0cd1a15f40aae..71a58f7ac13a9 100644
--- a/sound/soc/dwc/Kconfig
+++ b/sound/soc/dwc/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config SND_DESIGNWARE_I2S
 	tristate "Synopsys I2S Device Driver"
-	depends on CLKDEV_LOOKUP
+	depends on HAVE_CLK
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	 Say Y or M if you want to add support for I2S driver for
diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index d610b553ea3b2..053097b73e28d 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -9,7 +9,7 @@ config SND_SOC_ROCKCHIP
 
 config SND_SOC_ROCKCHIP_I2S
 	tristate "Rockchip I2S Device Driver"
-	depends on CLKDEV_LOOKUP && SND_SOC_ROCKCHIP
+	depends on HAVE_CLK && SND_SOC_ROCKCHIP
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y or M if you want to add support for I2S driver for
@@ -18,7 +18,7 @@ config SND_SOC_ROCKCHIP_I2S
 
 config SND_SOC_ROCKCHIP_PDM
 	tristate "Rockchip PDM Controller Driver"
-	depends on CLKDEV_LOOKUP && SND_SOC_ROCKCHIP
+	depends on HAVE_CLK && SND_SOC_ROCKCHIP
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select RATIONAL
 	help
@@ -28,7 +28,7 @@ config SND_SOC_ROCKCHIP_PDM
 
 config SND_SOC_ROCKCHIP_SPDIF
 	tristate "Rockchip SPDIF Device Driver"
-	depends on CLKDEV_LOOKUP && SND_SOC_ROCKCHIP
+	depends on HAVE_CLK && SND_SOC_ROCKCHIP
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y or M if you want to add support for SPDIF driver for
@@ -36,7 +36,7 @@ config SND_SOC_ROCKCHIP_SPDIF
 
 config SND_SOC_ROCKCHIP_MAX98090
 	tristate "ASoC support for Rockchip boards using a MAX98090 codec"
-	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB && CLKDEV_LOOKUP
+	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB && HAVE_CLK
 	select SND_SOC_ROCKCHIP_I2S
 	select SND_SOC_MAX98090
 	select SND_SOC_TS3A227E
@@ -47,7 +47,7 @@ config SND_SOC_ROCKCHIP_MAX98090
 
 config SND_SOC_ROCKCHIP_RT5645
 	tristate "ASoC support for Rockchip boards using a RT5645/RT5650 codec"
-	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB && CLKDEV_LOOKUP
+	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB && HAVE_CLK
 	select SND_SOC_ROCKCHIP_I2S
 	select SND_SOC_RT5645
 	help
@@ -56,7 +56,7 @@ config SND_SOC_ROCKCHIP_RT5645
 
 config SND_SOC_RK3288_HDMI_ANALOG
 	tristate "ASoC support multiple codecs for Rockchip RK3288 boards"
-	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB && CLKDEV_LOOKUP
+	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB && HAVE_CLK
 	select SND_SOC_ROCKCHIP_I2S
 	select SND_SOC_HDMI_CODEC
 	select SND_SOC_ES8328_I2C
@@ -68,7 +68,7 @@ config SND_SOC_RK3288_HDMI_ANALOG
 
 config SND_SOC_RK3399_GRU_SOUND
 	tristate "ASoC support multiple codecs for Rockchip RK3399 GRU boards"
-	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB && CLKDEV_LOOKUP && SPI
+	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB && HAVE_CLK && SPI
 	select SND_SOC_ROCKCHIP_I2S
 	select SND_SOC_MAX98357A
 	select SND_SOC_RT5514
-- 
2.43.0




