Return-Path: <stable+bounces-166294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5D3B198DA
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 02:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50AF41897C92
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 00:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10361E9B31;
	Mon,  4 Aug 2025 00:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h31FU6B3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687631E520F;
	Mon,  4 Aug 2025 00:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267868; cv=none; b=Ll61Kqj4+qOw8LpTV5vT24gcv0Jbax8cHe8HWjrK7WRnyYOYlqJLHXZt7z92A+85N9eVKEuerQxhkTViOzq+S7+70S1et1waszSUzu3rb443t76JIbpjz/LlCpA0Cwn0rXsy3ElNi9H9Dt1fZV8/lN/8ApYKJrzNl+QodSSepi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267868; c=relaxed/simple;
	bh=AwVUfQa5ih7ERhnmS/vJEQJ486eKdu9yIUKLNNK5gOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IbWpJkRWUQV/x7L40Yh0HjQZb83i5sgyP+HAbsfzuUz2yMWXvbyaY130cYW2tKgEYGnmNegSp3KvOQO8RCu+LVycpxEOXw+uXvEdBsnS58wyNtiqQqdqk154ZjQQEDyEp80TGOa89Ai7V+R0OU+VRlAmgdyS7VfrZLdXI3qCfwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h31FU6B3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8FEC4CEEB;
	Mon,  4 Aug 2025 00:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267868;
	bh=AwVUfQa5ih7ERhnmS/vJEQJ486eKdu9yIUKLNNK5gOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h31FU6B3+Rl6XkKh1QLB1xp+ENoT/hHa11rfYi3AKU2/VXhluqiMy8YhIW6bf0Mlz
	 33IgTTSOWSrDtJ2L940UxaIAU5kVMkrlX/E/Q6WVnGKUBCH7YEodXAYj2rqSDL3DRw
	 sMHHfer9KdqCkqk9qKwreBfhe8rVN5TKK6ahEVjwSrntVc883AW1ygEX45i69rvoVx
	 oFnLiBWfH0ECfs7zZdgnkqo+KAbDSKiZz4rlaCjl68uwwDtYDDOZfOtwXpGsPtx0cv
	 kPDxqneTD2/ECBLBD7wSiU52Nvclc444Btmmn8kfk441wJIpZPFbVbNZLuDmprwfUW
	 bIvQdS/EwwRsw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Sarthak Garg <quic_sartgarg@quicinc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 29/51] mmc: sdhci-msm: Ensure SD card power isn't ON when card removed
Date: Sun,  3 Aug 2025 20:36:21 -0400
Message-Id: <20250804003643.3625204-29-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804003643.3625204-1-sashal@kernel.org>
References: <20250804003643.3625204-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.147
Content-Transfer-Encoding: 8bit

From: Sarthak Garg <quic_sartgarg@quicinc.com>

[ Upstream commit db58532188ebf51d52b1d7693d9e94c76b926e9f ]

Many mobile phones feature multi-card tray designs, where the same
tray is used for both SD and SIM cards. If the SD card is placed
at the outermost location in the tray, the SIM card may come in
contact with SD card power-supply while removing the tray, possibly
resulting in SIM damage.

To prevent that, make sure the SD card is really inserted by reading
the Card Detect pin state. If it's not, turn off the power in
sdhci_msm_check_power_status() and also set the BUS_FAIL power state
on the controller as part of pwr_irq handling for BUS_ON request.

Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20250701100659.3310386-1-quic_sartgarg@quicinc.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **Hardware Damage Prevention**: This is a critical safety fix that
   prevents potential hardware damage to SIM cards. The commit message
   clearly describes a real-world scenario where SD card power can
   damage SIM cards in multi-card tray designs when the tray is removed.
   This is a serious hardware safety issue that affects end users'
   devices.

2. **Bug Fix Nature**: The commit fixes a specific bug where SD card
   power remains ON even when the card is physically removed. The code
   changes show two key additions:
   - In `sdhci_msm_check_power_status()`: Added check at lines 1625-1629
     that turns off power (writes 0 to SDHCI_POWER_CONTROL) when card is
     not detected (`!mmc->ops->get_cd(mmc)`)
   - In `sdhci_msm_handle_pwr_irq()`: Added check at lines 1689-1694
     that sets BUS_FAIL state when attempting to power on the bus while
     card is not present

3. **Small and Contained Fix**: The changes are minimal and well-
   contained:
   - Only 13 lines of actual code changes
   - Changes are localized to the sdhci-msm driver
   - No architectural changes or new features
   - Simple logic additions that check card presence before power
     operations

4. **Low Risk of Regression**: The fix adds defensive checks that only
   activate when:
   - A card is physically not present (detected via get_cd)
   - Power operations are being performed
   - This doesn't affect normal operation when cards are properly
     inserted

5. **Platform-Specific Critical Fix**: This affects Qualcomm MSM-based
   devices which are widely used in mobile phones. The multi-card tray
   design mentioned is common in many smartphones, making this a
   widespread potential issue.

6. **Clear Problem and Solution**: The commit has a clear problem
   statement (SIM damage from SD power) and a straightforward solution
   (turn off power when card is removed). This makes it easy to verify
   the fix is correct.

The commit follows stable tree rules perfectly - it's a important bugfix
that prevents hardware damage, has minimal code changes, doesn't
introduce new features, and has very low regression risk. This is
exactly the type of safety-critical fix that stable kernels should
include.

 drivers/mmc/host/sdhci-msm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index c8488b8e2073..f507fa491c58 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1560,6 +1560,7 @@ static void sdhci_msm_check_power_status(struct sdhci_host *host, u32 req_type)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	struct mmc_host *mmc = host->mmc;
 	bool done = false;
 	u32 val = SWITCHABLE_SIGNALING_VOLTAGE;
 	const struct sdhci_msm_offset *msm_offset =
@@ -1617,6 +1618,12 @@ static void sdhci_msm_check_power_status(struct sdhci_host *host, u32 req_type)
 				 "%s: pwr_irq for req: (%d) timed out\n",
 				 mmc_hostname(host->mmc), req_type);
 	}
+
+	if ((req_type & REQ_BUS_ON) && mmc->card && !mmc->ops->get_cd(mmc)) {
+		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+		host->pwr = 0;
+	}
+
 	pr_debug("%s: %s: request %d done\n", mmc_hostname(host->mmc),
 			__func__, req_type);
 }
@@ -1675,6 +1682,13 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 		udelay(10);
 	}
 
+	if ((irq_status & CORE_PWRCTL_BUS_ON) && mmc->card &&
+	    !mmc->ops->get_cd(mmc)) {
+		msm_host_writel(msm_host, CORE_PWRCTL_BUS_FAIL, host,
+				msm_offset->core_pwrctl_ctl);
+		return;
+	}
+
 	/* Handle BUS ON/OFF*/
 	if (irq_status & CORE_PWRCTL_BUS_ON) {
 		pwr_state = REQ_BUS_ON;
-- 
2.39.5


