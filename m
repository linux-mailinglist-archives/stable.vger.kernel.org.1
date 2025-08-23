Return-Path: <stable+bounces-172605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC108B32930
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 16:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFF305C619E
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 14:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439C823909C;
	Sat, 23 Aug 2025 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8OxZjOH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ADE1991CA
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755959570; cv=none; b=D1lXejHCg7Z3wfpSre+jSK9fFhdH0FELdUtmhwUY/jikkr6JaX5fIiNnrfpXcXNjpgHikIsnFA6nSJY893ohrV8Pzk/zI+wyXmKOslsNaihJiRl9/xlY+b8iZS/AvueF6ChB8xlT/yoAI58uXYd/m0BvvFPoWAHxZPC4/59N2HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755959570; c=relaxed/simple;
	bh=jxY1w+cHWKrEJvaVsVtM3TbMxFUwXKZ1doNTdTX0ffM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nf31Pfz8eg4lk1Ej2ocZJMflHr4BAMgRg+nOdOPn2gwNPUuuwnuuQwlFNfQtjTKz/KIPZTyE/XvPrxuXD7g/sCvx4xT3GKbvJBjM7X2971SIh0x5YeZEHLgyXtmJGI43fDljtZk5pfMeNgdJ4VVwGcWDgbvoMXKFYRDHcI40HnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8OxZjOH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00502C4CEE7;
	Sat, 23 Aug 2025 14:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755959569;
	bh=jxY1w+cHWKrEJvaVsVtM3TbMxFUwXKZ1doNTdTX0ffM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N8OxZjOHIlUKw1kFVsrGQ62hkJ/KkQDJpdjrvaPqriQvr2U+IogIQ7HBg/+4tyIAC
	 OJdvEYQk4tC2M3ScA5GVjxf8LrXn25LuFGR4KxxfcixQ0OOUtSpjOeXKdIED7Frnpg
	 jhKL08/V6bhmFUx2FtVkt+ggS4NFd1v/QgrLiWtu9gd0teU/PikUPjEYQFgc7MgO2A
	 Of4uV5HxBALh3wYrDcLI1xaRPyoVJ0+IPe4cW8MNUSLLXkzVZjF1fSwcJ4y1y3xWq4
	 Ozv8krA/kDFgKfgq/0t3NIkEQqGjlqFqeW/SqVffls91koBkwcQmKLLpuUhP5cEwfP
	 qV1dPuqWvpd2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Victor Shih <victor.shih@genesyslogic.com.tw>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] mmc: sdhci-pci-gli: Add a new function to simplify the code
Date: Sat, 23 Aug 2025 10:32:44 -0400
Message-ID: <20250823143244.2247015-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823143244.2247015-1-sashal@kernel.org>
References: <2025082238-portal-perfectly-7a53@gregkh>
 <20250823143244.2247015-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

[ Upstream commit dec8b38be4b35cae5f7fa086daf2631e2cfa09c1 ]

In preparation to fix replay timer timeout, add
sdhci_gli_mask_replay_timer_timeout() function
to simplify some of the code, allowing it to be re-used.

Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Fixes: 1ae1d2d6e555 ("mmc: sdhci-pci-gli: Add Genesys Logic GL9763E support")
Cc: stable@vger.kernel.org
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20250731065752.450231-2-victorshihgli@gmail.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-pci-gli.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index dc6ec90d27f8..02cde1b87a44 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -221,6 +221,20 @@
 #define GLI_MAX_TUNING_LOOP 40
 
 /* Genesys Logic chipset */
+static void sdhci_gli_mask_replay_timer_timeout(struct pci_dev *pdev)
+{
+	int aer;
+	u32 value;
+
+	/* mask the replay timer timeout of AER */
+	aer = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
+	if (aer) {
+		pci_read_config_dword(pdev, aer + PCI_ERR_COR_MASK, &value);
+		value |= PCI_ERR_COR_REP_TIMER;
+		pci_write_config_dword(pdev, aer + PCI_ERR_COR_MASK, value);
+	}
+}
+
 static inline void gl9750_wt_on(struct sdhci_host *host)
 {
 	u32 wt_value;
@@ -541,7 +555,6 @@ static void gl9750_hw_setting(struct sdhci_host *host)
 {
 	struct sdhci_pci_slot *slot = sdhci_priv(host);
 	struct pci_dev *pdev;
-	int aer;
 	u32 value;
 
 	pdev = slot->chip->pdev;
@@ -563,12 +576,7 @@ static void gl9750_hw_setting(struct sdhci_host *host)
 	pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
 
 	/* mask the replay timer timeout of AER */
-	aer = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
-	if (aer) {
-		pci_read_config_dword(pdev, aer + PCI_ERR_COR_MASK, &value);
-		value |= PCI_ERR_COR_REP_TIMER;
-		pci_write_config_dword(pdev, aer + PCI_ERR_COR_MASK, value);
-	}
+	sdhci_gli_mask_replay_timer_timeout(pdev);
 
 	gl9750_wt_off(host);
 }
@@ -743,7 +751,6 @@ static void sdhci_gl9755_set_clock(struct sdhci_host *host, unsigned int clock)
 static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
 {
 	struct pci_dev *pdev = slot->chip->pdev;
-	int aer;
 	u32 value;
 
 	gl9755_wt_on(pdev);
@@ -781,12 +788,7 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
 	pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
 
 	/* mask the replay timer timeout of AER */
-	aer = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
-	if (aer) {
-		pci_read_config_dword(pdev, aer + PCI_ERR_COR_MASK, &value);
-		value |= PCI_ERR_COR_REP_TIMER;
-		pci_write_config_dword(pdev, aer + PCI_ERR_COR_MASK, value);
-	}
+	sdhci_gli_mask_replay_timer_timeout(pdev);
 
 	gl9755_wt_off(pdev);
 }
-- 
2.50.1


