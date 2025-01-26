Return-Path: <stable+bounces-110682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F50A1CB61
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62A3316BF3C
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F89221D82;
	Sun, 26 Jan 2025 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxcsIhlV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAAC220681;
	Sun, 26 Jan 2025 15:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903830; cv=none; b=A8XwqJaeQRZiMb7Sh9g1OmCKPE6ALYL2vBwO4A33R/iz6CYifzPiiozl1NFzRvFMol56G++WQWCW6DUzAxyun7NoS+pUr/qZjU3HFHYLeItOraSUZC/Gahiu9flDDk8lO7OJvGKLD0elbF0Tbw93W8HFRGCfBFl2ElS+FuAd6gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903830; c=relaxed/simple;
	bh=fQFHNmD05joUar13jSrtNJ9mWNFlpz+3NRo4O2r0QCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LaAWLX39riGiTDp6H8aVhqecjFRzKVv9ViqIpzddg/CRc3CoN+YdPdIqii0itIPWZmB6EqdKsedrDaVuq3u3mkLTiQ0/ol8hvXYDDeTsh2qz0JDqoOGYTIyNLGveR1FCI3BxWUwjYbO2UVRiFa5gFcHr0pO/EWxZwO55NW/+aRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxcsIhlV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0991C4CEE5;
	Sun, 26 Jan 2025 15:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903829;
	bh=fQFHNmD05joUar13jSrtNJ9mWNFlpz+3NRo4O2r0QCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DxcsIhlVFe+4nJSQCKB2QE8eLE1EjqwKD3pW9FePMcwXC/kp6Ooyp5DVy1suoJyYJ
	 Ask7D9X9jGeGZJxeqT4KKyfCzJeS691t19N5V5eR4th6sZPZIC9aR4QUZ/HtDA1u6M
	 MqIAE7qTcJ8m5GVeBWFi+I1nPo+i89ub3e2Yrerku8D5M8YgVZJvSlSWcKju4yPcb6
	 ATym1AvAbm0VOO/3OEEPJAtgfrpqazu9gJuoJnvIq4BhWkNGQPV8V+7h6IDfcfU9NO
	 Y70HVk41V0OAmiESzBX479iWglxzU4hQd0IBC+5iCBhOARURFZL1ZCbMmPq94cqKAX
	 JwKrZivJQvjvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yuanjie Yang <quic_yuanjiey@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	adrian.hunter@intel.com,
	linux-mmc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 17/19] mmc: sdhci-msm: Correctly set the load for the regulator
Date: Sun, 26 Jan 2025 10:03:12 -0500
Message-Id: <20250126150315.956795-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150315.956795-1-sashal@kernel.org>
References: <20250126150315.956795-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.74
Content-Transfer-Encoding: 8bit

From: Yuanjie Yang <quic_yuanjiey@quicinc.com>

[ Upstream commit 20a0c37e44063997391430c4ae09973e9cbc3911 ]

Qualcomm regulator supports two power supply modes: HPM and LPM.
Currently, the sdhci-msm.c driver does not set the load to adjust
the current for eMMC and SD. If the regulator dont't set correct
load in LPM state, it will lead to the inability to properly
initialize eMMC and SD.

Set the correct regulator current for eMMC and SD to ensure that the
device can work normally even when the regulator is in LPM.

Signed-off-by: Yuanjie Yang <quic_yuanjiey@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20250114083514.258379-1-quic_yuanjiey@quicinc.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-msm.c | 53 ++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 8716004fcf6c9..945d08531de37 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -134,9 +134,18 @@
 /* Timeout value to avoid infinite waiting for pwr_irq */
 #define MSM_PWR_IRQ_TIMEOUT_MS 5000
 
+/* Max load for eMMC Vdd supply */
+#define MMC_VMMC_MAX_LOAD_UA	570000
+
 /* Max load for eMMC Vdd-io supply */
 #define MMC_VQMMC_MAX_LOAD_UA	325000
 
+/* Max load for SD Vdd supply */
+#define SD_VMMC_MAX_LOAD_UA	800000
+
+/* Max load for SD Vdd-io supply */
+#define SD_VQMMC_MAX_LOAD_UA	22000
+
 #define msm_host_readl(msm_host, host, offset) \
 	msm_host->var_ops->msm_readl_relaxed(host, offset)
 
@@ -1403,11 +1412,48 @@ static int sdhci_msm_set_pincfg(struct sdhci_msm_host *msm_host, bool level)
 	return ret;
 }
 
-static int sdhci_msm_set_vmmc(struct mmc_host *mmc)
+static void msm_config_vmmc_regulator(struct mmc_host *mmc, bool hpm)
+{
+	int load;
+
+	if (!hpm)
+		load = 0;
+	else if (!mmc->card)
+		load = max(MMC_VMMC_MAX_LOAD_UA, SD_VMMC_MAX_LOAD_UA);
+	else if (mmc_card_mmc(mmc->card))
+		load = MMC_VMMC_MAX_LOAD_UA;
+	else if (mmc_card_sd(mmc->card))
+		load = SD_VMMC_MAX_LOAD_UA;
+	else
+		return;
+
+	regulator_set_load(mmc->supply.vmmc, load);
+}
+
+static void msm_config_vqmmc_regulator(struct mmc_host *mmc, bool hpm)
+{
+	int load;
+
+	if (!hpm)
+		load = 0;
+	else if (!mmc->card)
+		load = max(MMC_VQMMC_MAX_LOAD_UA, SD_VQMMC_MAX_LOAD_UA);
+	else if (mmc_card_sd(mmc->card))
+		load = SD_VQMMC_MAX_LOAD_UA;
+	else
+		return;
+
+	regulator_set_load(mmc->supply.vqmmc, load);
+}
+
+static int sdhci_msm_set_vmmc(struct sdhci_msm_host *msm_host,
+			      struct mmc_host *mmc, bool hpm)
 {
 	if (IS_ERR(mmc->supply.vmmc))
 		return 0;
 
+	msm_config_vmmc_regulator(mmc, hpm);
+
 	return mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, mmc->ios.vdd);
 }
 
@@ -1420,6 +1466,8 @@ static int msm_toggle_vqmmc(struct sdhci_msm_host *msm_host,
 	if (msm_host->vqmmc_enabled == level)
 		return 0;
 
+	msm_config_vqmmc_regulator(mmc, level);
+
 	if (level) {
 		/* Set the IO voltage regulator to default voltage level */
 		if (msm_host->caps_0 & CORE_3_0V_SUPPORT)
@@ -1642,7 +1690,8 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 	}
 
 	if (pwr_state) {
-		ret = sdhci_msm_set_vmmc(mmc);
+		ret = sdhci_msm_set_vmmc(msm_host, mmc,
+					 pwr_state & REQ_BUS_ON);
 		if (!ret)
 			ret = sdhci_msm_set_vqmmc(msm_host, mmc,
 					pwr_state & REQ_BUS_ON);
-- 
2.39.5


