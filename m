Return-Path: <stable+bounces-148727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6088ACA619
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 02:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 104D27A3BAA
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 00:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF96527056D;
	Sun,  1 Jun 2025 23:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5ot6bqk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A289B27144D;
	Sun,  1 Jun 2025 23:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748821193; cv=none; b=pwDNNBngsFAilljYBFsEeF3EwSfBLOd8j8JwYOFL4JgWoKUvcZ9e03R/oAS3fOOR5YVpfCCDM5peLF9QaRK967lnRoPGnA4HBgEPcYI4BrP6jXJtCRwyWUFEG/LzEdx33MGB/qD5CHnLVd302V+I89skRAZYp7mXbz8Vw2yGWVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748821193; c=relaxed/simple;
	bh=fOnsBg/VhUtA4bBbip0N9HGhzwNCbivG0QhYyGCUaLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kCOpBYIQNJM7rPXK6iTxJyQ73l0WxxSponUDc5u6RJY5t/Dz/9ZB+M02ufxHsdG5Baj3rtx8gzAAE3w7UBeAgRSxZb7PSrghh77Jh1VIQ4PyLRAr+Ag4fhDwnWuf8gRtjvojLiFi3QI+0F2JXZEq3Fw/pMmY4kJ2/LInTg6I2wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5ot6bqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64E0C4CEEE;
	Sun,  1 Jun 2025 23:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748821193;
	bh=fOnsBg/VhUtA4bBbip0N9HGhzwNCbivG0QhYyGCUaLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g5ot6bqkSmmknxtnljRGoa0YEbMJSkYSS+oXtzq9JkKWgsUOrp9Nx04K3TOC1MBte
	 zlNq/7xrhLOzHEXuoEO820zn6vvK2ZnJN45ua0m7aDJEt44VN+JHEMUvvit5DMKKYG
	 BJ3Mi0yBBJ0woF4flm2zaIxm6dZUGhMn7b1d+GqgS/+W7vwnJ83E5XeDgM2T6Mqgkj
	 6jUjmQQWHb2BhjKso1Xab/1azlTx5Ocsl4B7alNj+dlJAqQYm4VxEPRPdYlMhvMGPt
	 +K6RGAEffI2+GmYtaYlHUi1FWqRqZp+0vcUkfXQgIUiuJgUlMmmMsEqSlHYCQVJpzo
	 8p+ZoxEnBoN2A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Erick Shepherd <erick.shepherd@ni.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	avri.altman@wdc.com,
	keita.aihara@sony.com,
	dsimic@manjaro.org,
	jonathan@raspberrypi.com,
	victor.shih@genesyslogic.com.tw,
	cw9316.lee@samsung.com,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 56/66] mmc: Add quirk to disable DDR50 tuning
Date: Sun,  1 Jun 2025 19:37:33 -0400
Message-Id: <20250601233744.3514795-56-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601233744.3514795-1-sashal@kernel.org>
References: <20250601233744.3514795-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.92
Content-Transfer-Encoding: 8bit

From: Erick Shepherd <erick.shepherd@ni.com>

[ Upstream commit 9510b38dc0ba358c93cbf5ee7c28820afb85937b ]

Adds the MMC_QUIRK_NO_UHS_DDR50_TUNING quirk and updates
mmc_execute_tuning() to return 0 if that quirk is set. This fixes an
issue on certain Swissbit SD cards that do not support DDR50 tuning
where tuning requests caused I/O errors to be thrown.

Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20250331221337.1414534-1-erick.shepherd@ni.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees based on
the following detailed analysis: ## Critical Hardware Compatibility Fix
The commit addresses a specific and serious hardware compatibility issue
where certain Swissbit SD cards (series S46-u, manufactured 01/2019)
throw I/O errors during DDR50 tuning requests, particularly on Bay Trail
host controllers. This represents a real-world deployed hardware issue
that causes system instability. ## Code Analysis - Low Risk, High Impact
**1. Minimal and Targeted Changes:** - Adds a single quirk bit
(`MMC_QUIRK_NO_UHS_DDR50_TUNING`) in `include/linux/mmc/card.h` -
Introduces a simple helper function `mmc_card_no_uhs_ddr50_tuning()` in
`drivers/mmc/core/card.h` - Adds one specific quirk entry for the
problematic Swissbit cards in `drivers/mmc/core/quirks.h` - Modifies the
tuning logic in `drivers/mmc/core/sd.c` to respect the new quirk **2.
Functional Impact Analysis:** The key change is in the
`mmc_sd_use_tuning()` function where DDR50 tuning can now be disabled:
```c case MMC_TIMING_UHS_DDR50: return
!mmc_card_no_uhs_ddr50_tuning(card); ``` This change ensures that: -
DDR50 mode still functions normally - Only the tuning optimization is
disabled - Cards fall back to fixed sampling clock (still functional) -
No loss of core functionality, only slight performance optimization loss
**3. Risk Assessment:** - **Very Low Risk**: The quirk only disables
tuning optimization, not DDR50 functionality itself - **Highly
Targeted**: Affects only very specific cards (Swissbit 0016G,
manufactured 2019/01) - **Maintains Compatibility**: Cards remain fully
functional in DDR50 mode without tuning - **No Regression Potential**:
Other cards are completely unaffected ## Alignment with Stable Backport
Criteria **1. Important Bugfix**: Resolves I/O errors and system
instability on deployed hardware **2. Minimal Risk**: Only disables
optimization feature, maintains full functionality **3. Small and
Contained**: Changes are isolated to the MMC quirk system **4. No
Architectural Changes**: Uses existing quirk infrastructure **5. Clear
User Impact**: Fixes real-world hardware compatibility issues ##
Historical Pattern Consistency This commit follows the same pattern as
other successful stable backports in the MMC subsystem (like Similar
Commit #2 and #5 marked "YES"), which address specific hardware quirks
with minimal, targeted fixes that resolve compatibility issues without
introducing new functionality or architectural changes. The commit
represents exactly the type of hardware compatibility fix that stable
kernel trees are designed to accommodate - resolving real issues on
deployed hardware with minimal risk and maximal benefit.

 drivers/mmc/core/card.h   |  6 ++++++
 drivers/mmc/core/quirks.h | 10 ++++++++++
 drivers/mmc/core/sd.c     | 32 ++++++++++++++++++++++++--------
 include/linux/mmc/card.h  |  1 +
 4 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index 8476754b1b170..fe0b2fa3bb89d 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -86,6 +86,7 @@ struct mmc_fixup {
 #define CID_MANFID_MICRON       0x13
 #define CID_MANFID_SAMSUNG      0x15
 #define CID_MANFID_APACER       0x27
+#define CID_MANFID_SWISSBIT     0x5D
 #define CID_MANFID_KINGSTON     0x70
 #define CID_MANFID_HYNIX	0x90
 #define CID_MANFID_KINGSTON_SD	0x9F
@@ -291,4 +292,9 @@ static inline int mmc_card_broken_sd_poweroff_notify(const struct mmc_card *c)
 	return c->quirks & MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY;
 }
 
+static inline int mmc_card_no_uhs_ddr50_tuning(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_NO_UHS_DDR50_TUNING;
+}
+
 #endif
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index 89b512905be14..7f893bafaa607 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -34,6 +34,16 @@ static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
 		   MMC_QUIRK_BROKEN_SD_CACHE | MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY,
 		   EXT_CSD_REV_ANY),
 
+	/*
+	 * Swissbit series S46-u cards throw I/O errors during tuning requests
+	 * after the initial tuning request expectedly times out. This has
+	 * only been observed on cards manufactured on 01/2019 that are using
+	 * Bay Trail host controllers.
+	 */
+	_FIXUP_EXT("0016G", CID_MANFID_SWISSBIT, 0x5342, 2019, 1,
+		   0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
+		   MMC_QUIRK_NO_UHS_DDR50_TUNING, EXT_CSD_REV_ANY),
+
 	END_FIXUP
 };
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index f02c3e5eb5c85..a06f3011e2b58 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -618,6 +618,29 @@ static int sd_set_current_limit(struct mmc_card *card, u8 *status)
 	return 0;
 }
 
+/*
+ * Determine if the card should tune or not.
+ */
+static bool mmc_sd_use_tuning(struct mmc_card *card)
+{
+	/*
+	 * SPI mode doesn't define CMD19 and tuning is only valid for SDR50 and
+	 * SDR104 mode SD-cards. Note that tuning is mandatory for SDR104.
+	 */
+	if (mmc_host_is_spi(card->host))
+		return false;
+
+	switch (card->host->ios.timing) {
+	case MMC_TIMING_UHS_SDR50:
+	case MMC_TIMING_UHS_SDR104:
+		return true;
+	case MMC_TIMING_UHS_DDR50:
+		return !mmc_card_no_uhs_ddr50_tuning(card);
+	}
+
+	return false;
+}
+
 /*
  * UHS-I specific initialization procedure
  */
@@ -661,14 +684,7 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
 	if (err)
 		goto out;
 
-	/*
-	 * SPI mode doesn't define CMD19 and tuning is only valid for SDR50 and
-	 * SDR104 mode SD-cards. Note that tuning is mandatory for SDR104.
-	 */
-	if (!mmc_host_is_spi(card->host) &&
-		(card->host->ios.timing == MMC_TIMING_UHS_SDR50 ||
-		 card->host->ios.timing == MMC_TIMING_UHS_DDR50 ||
-		 card->host->ios.timing == MMC_TIMING_UHS_SDR104)) {
+	if (mmc_sd_use_tuning(card)) {
 		err = mmc_execute_tuning(card);
 
 		/*
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index afa575e362a47..7c6da19fff9f0 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -297,6 +297,7 @@ struct mmc_card {
 #define MMC_QUIRK_BROKEN_SD_CACHE	(1<<15)	/* Disable broken SD cache support */
 #define MMC_QUIRK_BROKEN_CACHE_FLUSH	(1<<16)	/* Don't flush cache until the write has occurred */
 #define MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY	(1<<17) /* Disable broken SD poweroff notify support */
+#define MMC_QUIRK_NO_UHS_DDR50_TUNING	(1<<18) /* Disable DDR50 tuning */
 
 	bool			written_flag;	/* Indicates eMMC has been written since power on */
 	bool			reenable_cmdq;	/* Re-enable Command Queue */
-- 
2.39.5


