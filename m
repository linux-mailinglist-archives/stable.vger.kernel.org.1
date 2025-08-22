Return-Path: <stable+bounces-172446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3140CB31CC3
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8613644158
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3267F30E834;
	Fri, 22 Aug 2025 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aMMGgAPN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B6430AAC6
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874062; cv=none; b=VT5bku3AdIPjQ5Lx8IP6n8SVwimsM2KtDx6nt2jMKTKzWraWB5kvXS2LVDum78jgOLxN9bNnOLhPeBIBPwuoDFcfR5SOJFMTyptF6ko6l2p7KKqY83USiJelmnMl1558P0CRo0qEC7pMhGTsDmJAxjaG0WvXdZU0p5bWPcRBEoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874062; c=relaxed/simple;
	bh=fcWyJO4Poa6owYL0OMhdEgRxDTTkTQdhFRrm+3upnww=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=h2aF30xsfQfC4Bkb4W5BPsOUIQo6SzrZXC6Oq2+B/y7NNWE5HAbR6eusxumsMgX6lrMbT0WvZYeuYBCbLe7Yobf7pzzNp7PFoi7o4JEn7c8ETQTvT/uX1SZgpamqxhaAOaCzxx7vk5ogOEdztT34A1BQ8Ew34GR9J1CA828wEMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aMMGgAPN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8135C113D0;
	Fri, 22 Aug 2025 14:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755874062;
	bh=fcWyJO4Poa6owYL0OMhdEgRxDTTkTQdhFRrm+3upnww=;
	h=Subject:To:Cc:From:Date:From;
	b=aMMGgAPNGo9tGVwcDl28yyfjVNG5D/Yw110oF15ryGELqFxZvtczXM2ASvsqSXNvd
	 CZEyQPL/hQ5/SG3Y+3CRMrvsmjUm5GNmKX8T59LROVNRuZAgE3i4JN/1gprRFhlvwZ
	 kgUoW/6abZh74ySySnLNZ6Oe0A4NZPaT/5FoqfPY=
Subject: FAILED: patch "[PATCH] mmc: sdhci-pci-gli: GL9763e: Mask the replay timer timeout of" failed to apply to 6.6-stable tree
To: victor.shih@genesyslogic.com.tw,adrian.hunter@intel.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 22 Aug 2025 16:47:39 +0200
Message-ID: <2025082238-bullring-fantasy-07b7@gregkh>
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
git cherry-pick -x 340be332e420ed37d15d4169a1b4174e912ad6cb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082238-bullring-fantasy-07b7@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


