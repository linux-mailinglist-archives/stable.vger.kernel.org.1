Return-Path: <stable+bounces-172632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ED9B329C6
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 17:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357B89E70DB
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 15:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFE912B93;
	Sat, 23 Aug 2025 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIDJxixL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB1A246BCF
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755963926; cv=none; b=HQjbQ0gGu3RHTxyCaOYwE6r7mdyOXueklZTWH/rhomb6qzpWa3AItPyKOW+z31FbpIrKdfNZV5YFX46mmr40D2ylR8R5WAKhoRa1A01NcqqKEtGHiaZf5kgz66OtlavmxO/mjwyZv04IDhbrOHm0gGqV6q+MFIByKrce4KdSKBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755963926; c=relaxed/simple;
	bh=wf9JlqUukViRlyIqVqmAyd5coatdBryZErBM3iTRbSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1WEBzuIfRD9+KJfFBYdBtIydECXo6JZ5Bzmxn3Xu98RjmgmTwme9RQTFCJQL8SuKLB07S4rszxlsg9O2vvHz0C/Ag/yUyFF2pW10WjPu6r/Q7NlbK+O3cNOKRvn+RNuhPkS0QrnzjaGepuALR2wqW0AIwI4botFn07jJDsB2AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIDJxixL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F94C4CEF4;
	Sat, 23 Aug 2025 15:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755963925;
	bh=wf9JlqUukViRlyIqVqmAyd5coatdBryZErBM3iTRbSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mIDJxixLbdoxD0w1YSFv4FJPqwV7R9FG9Oh1kvUiZkDRz3VTJd30Bo5GxsN77ilHA
	 12DDALDZJM159KqdEEHjMqdX5G8GvMGWdFIDgfvgLVU5BbbXz9wsns9FjfwHyTzSqj
	 aMXwMs4y6/pWi4JtnPIwGom7Pzzz1nPZgcQd5nUeAaS/aLVUdOEwBD7H+jRBxl5XMu
	 0AhS0G134aqtNPlJZXzXbmWO0Fkp36seXzlisDnqvhAvByzvvL6o/ZGaUyxxEci2Td
	 tzs6kHBQBrns9IO11709B6Nx5wCzuKZVW6txfPa9VJ6P7rjE7LaHPZIrU/amLT7L9g
	 gR0KOgj2Nc3iQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Victor Shih <victor.shih@genesyslogic.com.tw>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] mmc: sdhci-pci-gli: Add a new function to simplify the code
Date: Sat, 23 Aug 2025 11:45:21 -0400
Message-ID: <20250823154522.2285870-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823154522.2285870-1-sashal@kernel.org>
References: <2025082238-bullring-fantasy-07b7@gregkh>
 <20250823154522.2285870-1-sashal@kernel.org>
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
Stable-dep-of: 340be332e420 ("mmc: sdhci-pci-gli: GL9763e: Mask the replay timer timeout of AER")
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


