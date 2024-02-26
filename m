Return-Path: <stable+bounces-23687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AB8867503
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 13:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3B471F22919
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 12:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4E57BAEA;
	Mon, 26 Feb 2024 12:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pIdnBZVg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D4D7C087
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 12:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950733; cv=none; b=Os0U43FoUl73XFjmB6MkJsW2sgRYmlavFvzrsg4pNGCzJvUuzFTHvAeRVg/ePQqHpt0skuCeGKVmjc79YKHVTuLTzcy1I107+ZCT846A2sTAFgKNFfeC7klce6RkZDevHlrtX/nN12UIF76KaOPvejk8DI/mXk+vFKXQeRksm7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950733; c=relaxed/simple;
	bh=erWBkQZZsdhi8UKgIEvQ6VHm3MD/qGiFoGmbQFiue00=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qJZRNtWb7roFvcOTEjhB+crC7EYOmoBkajJQu0+jsBy7gs6ATT+lupwXmRMvIQ+XQ6qlnWUYVRkbZQP5SH6z+RHSfqCaSCCBnnmoKtQRd/fDU9vFoa0UJepKiodVh2hgoPqcXTrur8Hxaxo+8wAmdAhX/X0VfIlkDO6QxTU8dQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pIdnBZVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F4DC433F1;
	Mon, 26 Feb 2024 12:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708950732;
	bh=erWBkQZZsdhi8UKgIEvQ6VHm3MD/qGiFoGmbQFiue00=;
	h=Subject:To:Cc:From:Date:From;
	b=pIdnBZVg5BBw8scc3I9ZRzQYhj2kb7Iy8I1e8+hn41ugIonOKml5DLcg5GPBFBvK0
	 wxNIxwgRXeuGj57qwai2/P8uagshvexlP37Tr64+tWh2rbq26nRZ9/1jMf/HyBs0qJ
	 3cQuvCn37GUnSoosUE0pvilv3B/llEDVqQnKLgWw=
Subject: FAILED: patch "[PATCH] PCI/MSI: Prevent MSI hardware interrupt number truncation" failed to apply to 4.19-stable tree
To: vidyas@nvidia.com,sdonthineni@nvidia.com,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Feb 2024 13:32:09 +0100
Message-ID: <2024022609-womanless-imprison-678c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x db744ddd59be798c2627efbfc71f707f5a935a40
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024022609-womanless-imprison-678c@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

db744ddd59be ("PCI/MSI: Prevent MSI hardware interrupt number truncation")
aa423ac4221a ("PCI/MSI: Split out irqdomain code")
a01e09ef1237 ("PCI/MSI: Split out !IRQDOMAIN code")
54324c2f3d72 ("PCI/MSI: Split out CONFIG_PCI_MSI independent part")
288c81ce4be7 ("PCI/MSI: Move code into a separate directory")
29a03ada4a00 ("PCI/MSI: Cleanup include zoo")
ae72f3156729 ("PCI/MSI: Make arch_restore_msi_irqs() less horrible.")
e58f2259b91c ("genirq/msi, treewide: Use a named struct for PCI/MSI attributes")
ade044a3d0f0 ("PCI/MSI: Remove msi_desc_to_pci_sysdata()")
9e8688c5f299 ("PCI/MSI: Make pci_msi_domain_write_msg() static")
29bbc35e29d9 ("PCI/MSI: Fix pci_irq_vector()/pci_irq_get_affinity()")
c36e33e2f477 ("Merge tag 'irq-urgent-2021-11-14' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From db744ddd59be798c2627efbfc71f707f5a935a40 Mon Sep 17 00:00:00 2001
From: Vidya Sagar <vidyas@nvidia.com>
Date: Mon, 15 Jan 2024 19:26:49 +0530
Subject: [PATCH] PCI/MSI: Prevent MSI hardware interrupt number truncation

While calculating the hardware interrupt number for a MSI interrupt, the
higher bits (i.e. from bit-5 onwards a.k.a domain_nr >= 32) of the PCI
domain number gets truncated because of the shifted value casting to return
type of pci_domain_nr() which is 'int'. This for example is resulting in
same hardware interrupt number for devices 0019:00:00.0 and 0039:00:00.0.

To address this cast the PCI domain number to 'irq_hw_number_t' before left
shifting it to calculate the hardware interrupt number.

Please note that this fixes the issue only on 64-bit systems and doesn't
change the behavior for 32-bit systems i.e. the 32-bit systems continue to
have the issue. Since the issue surfaces only if there are too many PCIe
controllers in the system which usually is the case in modern server
systems and they don't tend to run 32-bit kernels.

Fixes: 3878eaefb89a ("PCI/MSI: Enhance core to support hierarchy irqdomain")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240115135649.708536-1-vidyas@nvidia.com

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index c8be056c248d..cfd84a899c82 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -61,7 +61,7 @@ static irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc)
 
 	return (irq_hw_number_t)desc->msi_index |
 		pci_dev_id(dev) << 11 |
-		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
+		((irq_hw_number_t)(pci_domain_nr(dev->bus) & 0xFFFFFFFF)) << 27;
 }
 
 static void pci_msi_domain_set_desc(msi_alloc_info_t *arg,


