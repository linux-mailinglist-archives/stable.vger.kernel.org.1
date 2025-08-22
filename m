Return-Path: <stable+bounces-172395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AC9B31A98
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C360A20352
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 13:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB732FB994;
	Fri, 22 Aug 2025 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cbyMsJvx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1903303CB3
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870941; cv=none; b=rSUQQt2qWjxpOfFbNQhccH2wzjEeo3d5OUi6BGX0V0tsXgJgLBqLf8qiVdVXYXqiXyE9Eg54Q2Ye1FHIjwtBKiLjwSX9Dkl3pETAIqZfaXacohgspSS1oPCgMJkT1M8B2+qiFw7pA/Y8CGIDV7h333DYMoVl6uen3uFzBVOfVTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870941; c=relaxed/simple;
	bh=YZUDoD+Uqar9BvANvdPQX1l76yBGPgIuNyEnohnOm5o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lsbm/vjt/pyPS75oX/g6zJvXgIHralm0Hs3vM5mT2yfikUmAxgJU0j/C/u3l/bV2oy/PtscNSYLLiez7o1MnbUaM/hN+28IWwlk05eu8h4QswF02LxnW6/iHzmKkyZZGyokbBM3lcsPaOtSILmaAGqykg8lMmizABFA0dyweSdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cbyMsJvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF021C113CF;
	Fri, 22 Aug 2025 13:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755870941;
	bh=YZUDoD+Uqar9BvANvdPQX1l76yBGPgIuNyEnohnOm5o=;
	h=Subject:To:Cc:From:Date:From;
	b=cbyMsJvxY6lWxnmPgOqdwehgrJ9+HFjoasZNqBARqtYZNArn/xRTqisExLjn4xsig
	 cp6Hv3AagQSbPjkj9s85VUG1UQ5ATy7Cqf41btcQp7YyHXf/272MAza36V9khgwqem
	 8JEkxP234sv+NFT8sAO5Y4j9K3RQCmM5bPQV7tl4=
Subject: FAILED: patch "[PATCH] mmc: sdhci-pci-gli: Add a new function to simplify the code" failed to apply to 6.6-stable tree
To: victor.shih@genesyslogic.com.tw,adrian.hunter@intel.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 22 Aug 2025 15:55:38 +0200
Message-ID: <2025082238-portal-perfectly-7a53@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x dec8b38be4b35cae5f7fa086daf2631e2cfa09c1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082238-portal-perfectly-7a53@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dec8b38be4b35cae5f7fa086daf2631e2cfa09c1 Mon Sep 17 00:00:00 2001
From: Victor Shih <victor.shih@genesyslogic.com.tw>
Date: Thu, 31 Jul 2025 14:57:50 +0800
Subject: [PATCH] mmc: sdhci-pci-gli: Add a new function to simplify the code

In preparation to fix replay timer timeout, add
sdhci_gli_mask_replay_timer_timeout() function
to simplify some of the code, allowing it to be re-used.

Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Fixes: 1ae1d2d6e555 ("mmc: sdhci-pci-gli: Add Genesys Logic GL9763E support")
Cc: stable@vger.kernel.org
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20250731065752.450231-2-victorshihgli@gmail.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 4c2ae71770f7..f678c91f8d3e 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -287,6 +287,20 @@
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
@@ -607,7 +621,6 @@ static void gl9750_hw_setting(struct sdhci_host *host)
 {
 	struct sdhci_pci_slot *slot = sdhci_priv(host);
 	struct pci_dev *pdev;
-	int aer;
 	u32 value;
 
 	pdev = slot->chip->pdev;
@@ -626,12 +639,7 @@ static void gl9750_hw_setting(struct sdhci_host *host)
 	pci_set_power_state(pdev, PCI_D0);
 
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
@@ -806,7 +814,6 @@ static void sdhci_gl9755_set_clock(struct sdhci_host *host, unsigned int clock)
 static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
 {
 	struct pci_dev *pdev = slot->chip->pdev;
-	int aer;
 	u32 value;
 
 	gl9755_wt_on(pdev);
@@ -841,12 +848,7 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
 	pci_set_power_state(pdev, PCI_D0);
 
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


