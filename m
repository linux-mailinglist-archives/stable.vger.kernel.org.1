Return-Path: <stable+bounces-172631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14579B329C4
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 17:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A4F9E70D8
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 15:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C54A221D88;
	Sat, 23 Aug 2025 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwCvdkJK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B987170A11
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755963925; cv=none; b=lxByk+0bJiDMxj42xQRMmJrKnBTDfOBBVLQV0yOQs/AcoiHHiH5WYPpvWIpPHo2NL5Y/4xf8eA1f+ckAnTN3/sFaY8kf8WNxTu7y2viAaS5Ijr2beVC8Pftobl4SaB/juq2gBJrgg7PnfTMgFS4hN0gZDriz0XKFMOs9pKF+bEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755963925; c=relaxed/simple;
	bh=UOulClWwBEj49VILcng5Zg1Gpe/V4dyfrzDWOUtoTqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhDk7orusoNP3rfipvXTnMAEqkXGM81vbb6bqQYZHnDG44gFgbEsXzlAYXWuFLOdp2m8ePPDw6W0M0FSSmWyiBfTZNvu1/fFPVeCSUF08Z2nTQlReAxjtz5UjbVFVHTjsXwU2M5BH7GAfhQNQJVTxhJ4Pvtnm9ZcrwsTOOvIbTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwCvdkJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791AEC4CEE7;
	Sat, 23 Aug 2025 15:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755963925;
	bh=UOulClWwBEj49VILcng5Zg1Gpe/V4dyfrzDWOUtoTqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EwCvdkJKrpQ6J8raRI8BFb+wfMDZ7+FHF+dGAzDQuHHrBYoFeAFCcD6qjND557MvL
	 XXLJUFnv9FAMixNzVnmp+FBqFRLEeAxwPYBZ+6zDguMUA2oi0qibAIPKAfCKyUnOXi
	 feER/HaCiihPN4ZYP98ZPoMCO2aFqvPcpmN/a3DpbrXiiwN6Iye2Ke1cwFpUo2rr0t
	 MYEZT0tF4g/+ePd08TktY3p4wOEcaJoTNxQElWgLhcWl6D1AKMNgXBSiQAcuc18dFc
	 jB64w4AHFMnNHIcQX/9T4ZpAn9nvWF3Sb1whrPRKhCQG3wOhlwOTh7qHUEfT7ew2Ru
	 q3VZmm0fpJXxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] mmc: sdhci-pci-gli: Use PCI AER definitions, not hard-coded values
Date: Sat, 23 Aug 2025 11:45:20 -0400
Message-ID: <20250823154522.2285870-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082238-bullring-fantasy-07b7@gregkh>
References: <2025082238-bullring-fantasy-07b7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

[ Upstream commit 951b7ccc54591ba48755b5e0c7fc8b9623a64640 ]

015c9cbcf0ad ("mmc: sdhci-pci-gli: GL9750: Mask the replay timer timeout of
AER") added PCI_GLI_9750_CORRERR_MASK, the offset of the AER Capability in
config space, and PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT, the
Replay Timer Timeout bit in the AER Correctable Error Status register.

Use pci_find_ext_capability() to locate the AER Capability and use the
existing PCI_ERR_COR_REP_TIMER definition to mask the bit.

This removes a little bit of unnecessarily device-specific code and makes
AER-related things more greppable.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20240327214831.1544595-2-helgaas@kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Stable-dep-of: 340be332e420 ("mmc: sdhci-pci-gli: GL9763e: Mask the replay timer timeout of AER")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-pci-gli.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 11c404374d79..dc6ec90d27f8 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -28,9 +28,6 @@
 #define PCI_GLI_9750_PM_CTRL	0xFC
 #define   PCI_GLI_9750_PM_STATE	  GENMASK(1, 0)
 
-#define PCI_GLI_9750_CORRERR_MASK				0x214
-#define   PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT	  BIT(12)
-
 #define SDHCI_GLI_9750_CFG2          0x848
 #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
 #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
@@ -155,9 +152,6 @@
 #define PCI_GLI_9755_PM_CTRL     0xFC
 #define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
 
-#define PCI_GLI_9755_CORRERR_MASK				0x214
-#define   PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT	  BIT(12)
-
 #define SDHCI_GLI_9767_GM_BURST_SIZE			0x510
 #define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET	  BIT(8)
 
@@ -547,6 +541,7 @@ static void gl9750_hw_setting(struct sdhci_host *host)
 {
 	struct sdhci_pci_slot *slot = sdhci_priv(host);
 	struct pci_dev *pdev;
+	int aer;
 	u32 value;
 
 	pdev = slot->chip->pdev;
@@ -568,9 +563,12 @@ static void gl9750_hw_setting(struct sdhci_host *host)
 	pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
 
 	/* mask the replay timer timeout of AER */
-	pci_read_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, &value);
-	value |= PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
-	pci_write_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, value);
+	aer = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
+	if (aer) {
+		pci_read_config_dword(pdev, aer + PCI_ERR_COR_MASK, &value);
+		value |= PCI_ERR_COR_REP_TIMER;
+		pci_write_config_dword(pdev, aer + PCI_ERR_COR_MASK, value);
+	}
 
 	gl9750_wt_off(host);
 }
@@ -745,6 +743,7 @@ static void sdhci_gl9755_set_clock(struct sdhci_host *host, unsigned int clock)
 static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
 {
 	struct pci_dev *pdev = slot->chip->pdev;
+	int aer;
 	u32 value;
 
 	gl9755_wt_on(pdev);
@@ -782,9 +781,12 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
 	pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
 
 	/* mask the replay timer timeout of AER */
-	pci_read_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, &value);
-	value |= PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
-	pci_write_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, value);
+	aer = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
+	if (aer) {
+		pci_read_config_dword(pdev, aer + PCI_ERR_COR_MASK, &value);
+		value |= PCI_ERR_COR_REP_TIMER;
+		pci_write_config_dword(pdev, aer + PCI_ERR_COR_MASK, value);
+	}
 
 	gl9755_wt_off(pdev);
 }
-- 
2.50.1


