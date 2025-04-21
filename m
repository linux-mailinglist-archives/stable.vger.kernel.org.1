Return-Path: <stable+bounces-134775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F459A9502B
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 13:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B5B91716DA
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 11:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735AF263F5E;
	Mon, 21 Apr 2025 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V/92LcQ0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F37E263F3C
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 11:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745234793; cv=none; b=dT+YTI4XnYg/cEvAr6iJ2BDXihOjgELbRanu0Ri6P5ZxLZZvobp3PVT5zrpJ6wjz+RGaJDqiK9yohQsE1vHx3XCoA+5mlGtB4rx0tNcWuroIDzzrwhrRcwe9QfYTOZKNHRXJNFgQHyYcJF+SDXB92IFTaADlmdx6aytiJAl1gBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745234793; c=relaxed/simple;
	bh=+tVe73GLnzIxhCeKG0i6gGINZ+KaHXcp7uOz7Kyj/FE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WLGvGGO7tZymemxqn3wTsoFJHLNjzMzXxvxwOPnMuhEfDcFR1BbiRzAxv42Kx37ikD7DRK4JzmkurvnS4JisLHr17ZTaAcEnQz7oPlx0Nd7/kCijBVo/MDROJKpEr9bYSQlpdgPegOXlkQGb11O4+czUPlb4mJUwwUdJmQkjOY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V/92LcQ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E724C4CEE4;
	Mon, 21 Apr 2025 11:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745234792;
	bh=+tVe73GLnzIxhCeKG0i6gGINZ+KaHXcp7uOz7Kyj/FE=;
	h=Subject:To:Cc:From:Date:From;
	b=V/92LcQ0c8AUbU4gvrb9s5lkkcdfs3fL2W0NGinmAX5Q8vFWiX6AzJUHcSQ7WzoTt
	 cTDXezYJ8jmrvmAOsK8rUh0VCQaJfEOK8orgzUVy1muOcFYy34C0+M5uB87Z2iSfic
	 RW42N7/oWGNHxlj+4+GHHZk5rFQPFTYV1jY/LfrU=
Subject: FAILED: patch "[PATCH] PCI/MSI: Add an option to write MSIX ENTRY_DATA before any" failed to apply to 6.1-stable tree
To: dullfire@yahoo.com,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Apr 2025 13:26:20 +0200
Message-ID: <2025042120-skimming-facing-a7af@gregkh>
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
git cherry-pick -x cf761e3dacc6ad5f65a4886d00da1f9681e6805a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042120-skimming-facing-a7af@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cf761e3dacc6ad5f65a4886d00da1f9681e6805a Mon Sep 17 00:00:00 2001
From: Jonathan Currier <dullfire@yahoo.com>
Date: Sun, 17 Nov 2024 17:48:42 -0600
Subject: [PATCH] PCI/MSI: Add an option to write MSIX ENTRY_DATA before any
 reads

Commit 7d5ec3d36123 ("PCI/MSI: Mask all unused MSI-X entries") introduced a
readl() from ENTRY_VECTOR_CTRL before the writel() to ENTRY_DATA.

This is correct, however some hardware, like the Sun Neptune chips, the NIU
module, will cause an error and/or fatal trap if any MSIX table entry is
read before the corresponding ENTRY_DATA field is written to.

Add an optional early writel() in msix_prepare_msi_desc().

Fixes: 7d5ec3d36123 ("PCI/MSI: Mask all unused MSI-X entries")
Signed-off-by: Jonathan Currier <dullfire@yahoo.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20241117234843.19236-2-dullfire@yahoo.com

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 6569ba3577fe..8b8848788618 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -615,6 +615,9 @@ void msix_prepare_msi_desc(struct pci_dev *dev, struct msi_desc *desc)
 		void __iomem *addr = pci_msix_desc_addr(desc);
 
 		desc->pci.msi_attrib.can_mask = 1;
+		/* Workaround for SUN NIU insanity, which requires write before read */
+		if (dev->dev_flags & PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST)
+			writel(0, addr + PCI_MSIX_ENTRY_DATA);
 		desc->pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 	}
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0e8e3fd77e96..51e2bd6405cd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -245,6 +245,8 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
 	/* Device does honor MSI masking despite saying otherwise */
 	PCI_DEV_FLAGS_HAS_MSI_MASKING = (__force pci_dev_flags_t) (1 << 12),
+	/* Device requires write to PCI_MSIX_ENTRY_DATA before any MSIX reads */
+	PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST = (__force pci_dev_flags_t) (1 << 13),
 };
 
 enum pci_irq_reroute_variant {


