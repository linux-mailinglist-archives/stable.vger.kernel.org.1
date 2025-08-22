Return-Path: <stable+bounces-172447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B13CB31CC4
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D80DA21EEE
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2119D30E0F2;
	Fri, 22 Aug 2025 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OIOT48Xz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E6B2BDC33
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874104; cv=none; b=qR7Zd3c/Mf28mr4EOXYNVSxd6/o2k6kItmr2/F4ZvrMsR4OIZ5VwHgQx1uTa7pzM+NiSD90Fb1i42SyTMvXRyAtev10mKcpcw5Ld4IuhGKR0Hgy4G/oy7GM6E4wZT/HBt6FnJbe7syFPIeEyKS0uA47AK1/iZDCYOSnhl4TsAuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874104; c=relaxed/simple;
	bh=coHCDhTnQqSCqUaDXcSXfzxUfUKQcKc6CByZzyVIpD4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AG6gSieTSVv6coe1uAT0o48QrFlE6fBnfVKW/WHBakgES69NLtKbbgYyy4o3gDfSFa6C7DYy3fa3PR47zyPUS1b42cso37Rn5B+Eaa9bx9vUK+bA+wPFXc1LqetxtKmxx8fmlzNSXNl1nC4OCqr3VmBpIgHmQpxs45NWNwfStOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OIOT48Xz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5B1C4CEED;
	Fri, 22 Aug 2025 14:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755874104;
	bh=coHCDhTnQqSCqUaDXcSXfzxUfUKQcKc6CByZzyVIpD4=;
	h=Subject:To:Cc:From:Date:From;
	b=OIOT48XzhhxqPlOkWUY1uzf/CXSvlfeBTnYJ1YL7PfTASg+d5nyAiPYDp2fNO2Zyk
	 Nn5yeGmhY5HKJWjCsGBPioOygvpjjjuucTMwwiBWW11O+kVUK5tv63UMOHNEldos1h
	 FMMzbxeJpSs35iyK7X8+H5cX6MkUNDj24YaFAi/I=
Subject: FAILED: patch "[PATCH] mmc: sdhci-pci-gli: GL9763e: Mask the replay timer timeout of" failed to apply to 6.1-stable tree
To: victor.shih@genesyslogic.com.tw,adrian.hunter@intel.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 22 Aug 2025 16:48:21 +0200
Message-ID: <2025082221-murmuring-commotion-35cb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 340be332e420ed37d15d4169a1b4174e912ad6cb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082221-murmuring-commotion-35cb@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 340be332e420ed37d15d4169a1b4174e912ad6cb Mon Sep 17 00:00:00 2001
From: Victor Shih <victor.shih@genesyslogic.com.tw>
Date: Thu, 31 Jul 2025 14:57:52 +0800
Subject: [PATCH] mmc: sdhci-pci-gli: GL9763e: Mask the replay timer timeout of
 AER

Due to a flaw in the hardware design, the GL9763e replay timer frequently
times out when ASPM is enabled. As a result, the warning messages will
often appear in the system log when the system accesses the GL9763e
PCI config. Therefore, the replay timer timeout must be masked.

Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Fixes: 1ae1d2d6e555 ("mmc: sdhci-pci-gli: Add Genesys Logic GL9763E support")
Cc: stable@vger.kernel.org
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20250731065752.450231-4-victorshihgli@gmail.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 436f0460222f..3a1de477e9af 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -1782,6 +1782,9 @@ static void gl9763e_hw_setting(struct sdhci_pci_slot *slot)
 	value |= FIELD_PREP(GLI_9763E_HS400_RXDLY, GLI_9763E_HS400_RXDLY_5);
 	pci_write_config_dword(pdev, PCIE_GLI_9763E_CLKRXDLY, value);
 
+	/* mask the replay timer timeout of AER */
+	sdhci_gli_mask_replay_timer_timeout(pdev);
+
 	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
 	value &= ~GLI_9763E_VHS_REV;
 	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);


