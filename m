Return-Path: <stable+bounces-172654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7140BB32B2B
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 18:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B60AA5044
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 16:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F2921B9CD;
	Sat, 23 Aug 2025 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmVsDpdl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F8481720
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755968107; cv=none; b=UJSbKGkUphjfjw64iS9ZpyuZVMKdzfZBCPs7gScRck4Z48Uz1nHQYwvFAbSXjd6u9JSaRhBrDIBjdiJIL7KZkpHage+VEsT9pAzae1fHemqSsdMY98o1WqsSMJ3JArTyXB48bCroUKWHcNA+p9HwN8KwboYxVTPakSS7PkMRtAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755968107; c=relaxed/simple;
	bh=X30+2ydfCXUS9iocZfJVqgXQGFCOjYLPtsv3S1jPP3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnRvHIJ5dR0GxLniXcoPYkraGj8UXCWsDQUjbQyeU9fRKeysxzg/VcUs9qNU5PQc66thUo5Wim8k/mYNn0dW/etR9ZPsDNkgnSnma4MH1aWJl6Jf0c6yBb13kq63ZGR8s07S+Y4JaN+bdLjPi6cETE/1IvJNOrenTLZSMSzLVb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmVsDpdl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61388C4CEE7;
	Sat, 23 Aug 2025 16:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755968106;
	bh=X30+2ydfCXUS9iocZfJVqgXQGFCOjYLPtsv3S1jPP3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PmVsDpdlmjG1KpD9AwolBSCUhSVzP7uOiBODgZzwLNEbmlRB1OFMDz+pQANhKnITR
	 /avkBUwhAYDzyKpBkEnWDdt0P5aB5gOlyJwxQ3zj6S+/4Yxul7Xjftd5Oi/T70QSCo
	 NkVBlj6fjuNT7sXXTg3G7Ud6roxoiMVhe0pysxlAVd3Szv1w6YeFPijesbaY497qe3
	 79IwhFCavbS/5MgiViNcpzd2VWGJOF6ecOsTmT57fFS2i+t0AtUSc5bI9PqMykRoHY
	 5luxBPIxV0+1jH+eE565aLeaLjeBgR9p/kN5q7a3xtyV/0oX0HuRrAzPdsdEk2X9PT
	 xaJKlQwO2dg9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] mmc: sdhci-pci-gli: Use PCI AER definitions, not hard-coded values
Date: Sat, 23 Aug 2025 12:55:02 -0400
Message-ID: <20250823165504.2340548-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082221-murmuring-commotion-35cb@gregkh>
References: <2025082221-murmuring-commotion-35cb@gregkh>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-pci-gli.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 3b5b5c139206..52e716daddbe 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -27,8 +27,6 @@
 #define PCI_GLI_9750_PM_CTRL	0xFC
 #define   PCI_GLI_9750_PM_STATE	  GENMASK(1, 0)
 
-#define PCI_GLI_9750_CORRERR_MASK				0x214
-#define   PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT	  BIT(12)
 
 #define SDHCI_GLI_9750_CFG2          0x848
 #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
@@ -154,8 +152,6 @@
 #define PCI_GLI_9755_PM_CTRL     0xFC
 #define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
 
-#define PCI_GLI_9755_CORRERR_MASK				0x214
-#define   PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT	  BIT(12)
 
 #define GLI_MAX_TUNING_LOOP 40
 
@@ -501,9 +497,7 @@ static void gl9750_hw_setting(struct sdhci_host *host)
 	pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
 
 	/* mask the replay timer timeout of AER */
-	pci_read_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, &value);
-	value |= PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
-	pci_write_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, value);
+	sdhci_gli_mask_replay_timer_timeout(pdev);
 
 	gl9750_wt_off(host);
 }
@@ -715,9 +709,7 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
 	pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
 
 	/* mask the replay timer timeout of AER */
-	pci_read_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, &value);
-	value |= PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
-	pci_write_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, value);
+	sdhci_gli_mask_replay_timer_timeout(pdev);
 
 	gl9755_wt_off(pdev);
 }
-- 
2.50.1


