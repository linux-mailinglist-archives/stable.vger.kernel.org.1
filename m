Return-Path: <stable+bounces-148563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8CDACA482
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 02:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED1063A8C34
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 00:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80370298999;
	Sun,  1 Jun 2025 23:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REexpT2T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B2B298991;
	Sun,  1 Jun 2025 23:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820808; cv=none; b=K1Bv5bQqg3ykMKPIkNufGuv9lu/Z5NuH9P3rxrfSjaI2MN6RAQZfjn8zzUShNQw4gxc7UrZwVdZ78HHaI5SovQCHorPOeHJXFNqc3Lkq9buUyXLDbN6cUjIVTQlirb3GU+h7o0OCreOHGCUhzASqpcv5rOnEQ2E8qB3kc1fW3vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820808; c=relaxed/simple;
	bh=9CU6hfKbWYy2dxGPG8ZymvVeS+wDqWRq4nXQbuX+UbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i2OA35K9LmJ0pBVdt4YW9XgqUmuThMzT1hyhwcQp54b1cHg5jOux7s+V8x+RaES4dim6o2ZftMoUNQ97wf4jmzyU5wGcTJ+27tO1I1/4oWncq+FRNsJxjr1V5VVNGgtIFickbeJZA63O95kMa/OvwYFsBi8XbNdzw3ccPK7t5Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REexpT2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE3DC4CEE7;
	Sun,  1 Jun 2025 23:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748820807;
	bh=9CU6hfKbWYy2dxGPG8ZymvVeS+wDqWRq4nXQbuX+UbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=REexpT2TfmHDclK6nX6pkX2peroWy9BkayWdaYmvQgXR8EtXWVNO1F+1y8cMf46Yn
	 bsPclf9GB+9rvd4JucPhsuYeZq5tPo2ng2TTbQHAaJ3CcZPfwUxbFfvDBV+jrSWASe
	 aNAtlXR2Y6dyCcISy7WVpInHq7/Zg8BMF/UN0KD+kCCS/pCJHcew+KHgwQgkuW1FUW
	 RCr5/NzI/fi7d6j5jrWJgeqeXdGr0czTwD2cI9baz8SUbkMOgAxH6asw6uE6AY/ASe
	 GLCrLZO9WFB5VlbqU/oJDtBKPHG3bV2qgHHaysD0bDI9bE6tKlE/vcPB2Mni9eQd8a
	 kqyHNoEFB5xTw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Luke Wang <ziniu.wang_1@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	haibo.chen@nxp.com,
	shawnguo@kernel.org,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 087/102] mmc: sdhci-esdhc-imx: Save tuning value when card stays powered in suspend
Date: Sun,  1 Jun 2025 19:29:19 -0400
Message-Id: <20250601232937.3510379-87-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601232937.3510379-1-sashal@kernel.org>
References: <20250601232937.3510379-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luke Wang <ziniu.wang_1@nxp.com>

[ Upstream commit c63d25cdc59ae2891b39ba2da950910291d9bcbf ]

For SoCs like i.MX6UL(L/Z) and i.MX7D, USDHC powers off completely during
system power management (PM), causing the internal tuning status to be
lost. To address this, save the tuning value when system suspend and
restore it for any command issued after system resume when re-tuning is
held.

A typical case involves SDIO WiFi devices with the MMC_PM_KEEP_POWER and
MMC_PM_WAKE_SDIO_IRQ flag, which retain power during system PM. To
conserve power, WiFi switches to 1-bit mode and restores 4-bit mode upon
resume. As per the specification, tuning commands are not supported in
1-bit mode. When sending CMD52 to restore 4-bit mode, re-tuning must be
held. However, CMD52 still requires a correct sample point to avoid CRC
errors, necessitating preservation of the previous tuning value.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20250328112517.2624806-1-ziniu.wang_1@nxp.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. Here's
my extensive analysis: ## Why This Qualifies for Backporting ### 1.
**Fixes a Real User-Facing Bug** The commit addresses a critical issue
where SDIO WiFi devices lose tuning parameters during suspend/resume
cycles on i.MX SoCs. The commit message clearly describes a specific
scenario: - SDIO WiFi devices with MMC_PM_KEEP_POWER flag retain power
during suspend - WiFi switches to 1-bit mode for power conservation and
restores 4-bit mode on resume - CMD52 commands (needed for 4-bit mode
restoration) require correct tuning values to avoid CRC errors - Without
saved tuning values, these commands fail, breaking WiFi functionality
### 2. **Hardware-Specific Critical Issue** The code changes target
specific i.MX SoCs (i.MX6UL/ULL/ULZ and i.MX7D) where "USDHC powers off
completely during system power management (PM), causing the internal
tuning status to be lost." This is a documented hardware limitation, not
a software design flaw. ### 3. **Well-Contained and Low-Risk Changes**
**Code Analysis of Key Changes:** - **New tuning preservation fields**:
Adds `saved_tuning_delay_cell` to platform data (line 239) - minimal
risk, just data storage - **Save function (`sdhc_esdhc_tuning_save`)**:
Only saves tuning values for SDR50/SDR104 modes when specific conditions
are met (SDIO device keeping power) - very targeted scope - **Restore
function (`sdhc_esdhc_tuning_restore`)**: Carefully restores saved
values using existing register manipulation patterns already used
throughout the driver - **Integration points**: Adds save/restore calls
only in suspend/resume paths with proper conditional checks **Register
manipulation uses established patterns:** ```c // Uses existing
FIELD_PREP macro and register constants
writel(FIELD_PREP(ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_MASK,
imx_data->boarddata.saved_tuning_delay_cell), host->ioaddr +
ESDHC_TUNE_CTRL_STATUS); ``` ### 4. **Follows Stable Tree Criteria** **✓
Important bugfix**: Fixes WiFi connectivity after suspend/resume **✓
Minimal risk**: Changes are well-contained to specific code paths and
hardware **✓ No architectural changes**: Uses existing driver
infrastructure **✓ Confined to subsystem**: Only affects sdhci-esdhc-imx
driver ### 5. **Similar Historical Precedent** Looking at the provided
similar commits, this aligns with "Similar Commit #4" and "Similar
Commit #5" which were both marked "Backport Status: YES". Both dealt
with SDIO tuning issues and were considered appropriate for stable
trees: - Commit #4: Fixed SDIO retuning in 1-bit mode (had `Fixes:` tag
and `Cc: stable@vger.kernel.org`) - Commit #5: Disabled CMD CRC check
for tuning to prevent timing issues ### 6. **No Alternative
Workarounds** Users cannot work around this issue in userspace - it
requires kernel-level preservation of hardware tuning state during
suspend/resume cycles. ### 7. **Critical for Embedded Systems** i.MX
SoCs are widely used in embedded systems where: - SDIO WiFi is common -
Suspend/resume cycles are frequent (battery-powered devices) - WiFi
connectivity after resume is essential for functionality ## Conclusion
This commit fixes a legitimate hardware bug affecting real-world usage
scenarios with minimal risk. The changes are well-engineered, follow
existing code patterns, and address a problem that significantly impacts
user experience on affected platforms. It meets all criteria for stable
tree backporting.

 drivers/mmc/host/sdhci-esdhc-imx.c | 88 +++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 08336094e9b02..1d3c92de86a2f 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -82,6 +82,8 @@
 #define  ESDHC_TUNE_CTRL_STEP		1
 #define  ESDHC_TUNE_CTRL_MIN		0
 #define  ESDHC_TUNE_CTRL_MAX		((1 << 7) - 1)
+#define  ESDHC_TUNE_CTRL_STATUS_TAP_SEL_PRE_MASK	GENMASK(30, 24)
+#define  ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_MASK	GENMASK(14, 8)
 
 /* strobe dll register */
 #define ESDHC_STROBE_DLL_CTRL		0x70
@@ -236,6 +238,7 @@ struct esdhc_platform_data {
 	unsigned int tuning_step;       /* The delay cell steps in tuning procedure */
 	unsigned int tuning_start_tap;	/* The start delay cell point in tuning procedure */
 	unsigned int strobe_dll_delay_target;	/* The delay cell for strobe pad (read clock) */
+	unsigned int saved_tuning_delay_cell;	/* save the value of tuning delay cell */
 };
 
 struct esdhc_soc_data {
@@ -1058,7 +1061,7 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
-	u32 ctrl;
+	u32 ctrl, tuning_ctrl;
 	int ret;
 
 	/* Reset the tuning circuit */
@@ -1072,6 +1075,16 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
 			writel(0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
 		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
 			writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
+			/*
+			 * enable the std tuning just in case it cleared in
+			 * sdhc_esdhc_tuning_restore.
+			 */
+			tuning_ctrl = readl(host->ioaddr + ESDHC_TUNING_CTRL);
+			if (!(tuning_ctrl & ESDHC_STD_TUNING_EN)) {
+				tuning_ctrl |= ESDHC_STD_TUNING_EN;
+				writel(tuning_ctrl, host->ioaddr + ESDHC_TUNING_CTRL);
+			}
+
 			ctrl = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
 			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
 			ctrl &= ~ESDHC_MIX_CTRL_EXE_TUNE;
@@ -1150,7 +1163,8 @@ static void esdhc_prepare_tuning(struct sdhci_host *host, u32 val)
 	reg |= ESDHC_MIX_CTRL_EXE_TUNE | ESDHC_MIX_CTRL_SMPCLK_SEL |
 			ESDHC_MIX_CTRL_FBCLK_SEL;
 	writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
-	writel(val << 8, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
+	writel(FIELD_PREP(ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_MASK, val),
+	       host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
 	dev_dbg(mmc_dev(host->mmc),
 		"tuning with delay 0x%x ESDHC_TUNE_CTRL_STATUS 0x%x\n",
 			val, readl(host->ioaddr + ESDHC_TUNE_CTRL_STATUS));
@@ -1580,6 +1594,57 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
 	}
 }
 
+static void sdhc_esdhc_tuning_save(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	u32 reg;
+
+	/*
+	 * SD/eMMC do not need this tuning save because it will re-init
+	 * after system resume back.
+	 * Here save the tuning delay value for SDIO device since it may
+	 * keep power during system PM. And for usdhc, only SDR50 and
+	 * SDR104 mode for SDIO device need to do tuning, and need to
+	 * save/restore.
+	 */
+	if (host->timing == MMC_TIMING_UHS_SDR50 ||
+	    host->timing == MMC_TIMING_UHS_SDR104) {
+		reg = readl(host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
+		reg = FIELD_GET(ESDHC_TUNE_CTRL_STATUS_TAP_SEL_PRE_MASK, reg);
+		imx_data->boarddata.saved_tuning_delay_cell = reg;
+	}
+}
+
+static void sdhc_esdhc_tuning_restore(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	u32 reg;
+
+	if (host->timing == MMC_TIMING_UHS_SDR50 ||
+	    host->timing == MMC_TIMING_UHS_SDR104) {
+		/*
+		 * restore the tuning delay value actually is a
+		 * manual tuning method, so clear the standard
+		 * tuning enable bit here. Will set back this
+		 * ESDHC_STD_TUNING_EN in esdhc_reset_tuning()
+		 * when trigger re-tuning.
+		 */
+		reg = readl(host->ioaddr + ESDHC_TUNING_CTRL);
+		reg &= ~ESDHC_STD_TUNING_EN;
+		writel(reg, host->ioaddr + ESDHC_TUNING_CTRL);
+
+		reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
+		reg |= ESDHC_MIX_CTRL_SMPCLK_SEL | ESDHC_MIX_CTRL_FBCLK_SEL;
+		writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
+
+		writel(FIELD_PREP(ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_MASK,
+				  imx_data->boarddata.saved_tuning_delay_cell),
+		       host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
+	}
+}
+
 static void esdhc_cqe_enable(struct mmc_host *mmc)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
@@ -1911,6 +1976,15 @@ static int sdhci_esdhc_suspend(struct device *dev)
 	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
 		mmc_retune_needed(host->mmc);
 
+	/*
+	 * For the device need to keep power during system PM, need
+	 * to save the tuning delay value just in case the usdhc
+	 * lost power during system PM.
+	 */
+	if (mmc_card_keep_power(host->mmc) && mmc_card_wake_sdio_irq(host->mmc) &&
+	    esdhc_is_usdhc(imx_data))
+		sdhc_esdhc_tuning_save(host);
+
 	ret = sdhci_suspend_host(host);
 	if (ret)
 		return ret;
@@ -1927,6 +2001,8 @@ static int sdhci_esdhc_suspend(struct device *dev)
 static int sdhci_esdhc_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
 	ret = pinctrl_pm_select_default_state(dev);
@@ -1940,6 +2016,14 @@ static int sdhci_esdhc_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	/*
+	 * restore the saved tuning delay value for the device which keep
+	 * power during system PM.
+	 */
+	if (mmc_card_keep_power(host->mmc) && mmc_card_wake_sdio_irq(host->mmc) &&
+	    esdhc_is_usdhc(imx_data))
+		sdhc_esdhc_tuning_restore(host);
+
 	if (host->mmc->caps2 & MMC_CAP2_CQE)
 		ret = cqhci_resume(host->mmc);
 
-- 
2.39.5


