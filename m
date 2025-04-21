Return-Path: <stable+bounces-134776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B43A9502E
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 13:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D1313B296C
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 11:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82F02641CB;
	Mon, 21 Apr 2025 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iYBEhhc6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988AD263C9B
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745234795; cv=none; b=qyCzZIwxp9xEq86nOHd0PpOLKxMOQMxp+TIfOMmtWlCnMnp78cgHXykVpGUmzvUI8wtdkxXTHgeyD5uFZhL9JTKz+rxSG8gDpeqLkS3RuhwEZZ9Ypcm46gJyPs5Rz5pN1t7KCS8MBbCxYm29aB+mN70GnE0Bee7Ww06GcRgKb1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745234795; c=relaxed/simple;
	bh=idpiqp/n3j48NWmhnRxyE+IHTZ5ruS2SRckUVXYdw6k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=j9M/9xozY/SgFMHGiZ2ilRnN1yjQAgNUFj7uBozmBVmE6EcLeYK/i8TuPyr1E7mz19MVSIYLnFIc6oVcTsXen/9K//mFQ2bCzTj7D5ExZE/JgjMnu2Y5kAExtuvqIMw4DwepCMEDaqEVR3Y6fo/Bi+7g7DXzHjRpNYBoyCgOhoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iYBEhhc6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA3CC4CEE4;
	Mon, 21 Apr 2025 11:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745234795;
	bh=idpiqp/n3j48NWmhnRxyE+IHTZ5ruS2SRckUVXYdw6k=;
	h=Subject:To:Cc:From:Date:From;
	b=iYBEhhc6oBJDcXuuDfx0Xz1Nk1ATmCvAfRYXKmmEzfUSotHKqSt8VQ69I2Uiro2tY
	 hocLH+gjJ3VjuiILC2dzChAUY/viVTJWeXPeU6yAzyLAlISUM/MNX0BKSSXk6TYBdq
	 Qa2PEwk5/18OXZAEqMGieyWaSHY1InDSMbpOzSew=
Subject: FAILED: patch "[PATCH] PCI/MSI: Add an option to write MSIX ENTRY_DATA before any" failed to apply to 5.4-stable tree
To: dullfire@yahoo.com,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Apr 2025 13:26:21 +0200
Message-ID: <2025042121-bullfrog-dean-00a2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x cf761e3dacc6ad5f65a4886d00da1f9681e6805a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042121-bullfrog-dean-00a2@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


