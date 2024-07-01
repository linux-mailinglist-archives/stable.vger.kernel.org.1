Return-Path: <stable+bounces-56240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC0291E249
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 16:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E661F25F1F
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 14:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA9182D9A;
	Mon,  1 Jul 2024 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QYxY4oWl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3893D3BC
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843743; cv=none; b=hu/mOTCfnyfPPcMvZ8/N9W0FklxkPVa3DXEY+NJE7Guy5mlEwq5ak+Cs9yS/ixhoLqHwuiz+M+/Q+ukVnDEepgzgZerb/OdP4oAYq08ERYFcIA+NiP6PGXw+CI81Sv2+LneWy8oWtitTyGjlKN5hIXpv55/o6bb7qVSYfzYDZVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843743; c=relaxed/simple;
	bh=19F17hWu+Ye2sSoVRb3+Z9lZBe6TldJV/MN/4tOlWsc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KX04GeeEKZa+BEWjRCC5YRQQ2Jk4FRxRVj7S8aw7puEZ0xBxXMO9FuhjTtgoE+V418fl6firBtoEyfzHo5wsZGbRFJIu9qjQwnUR+x8CyyBmPY10Z+L3IQLwd5LQK2NbXXMT19gqWnkPNrPEcIkGWzI5Y+1hkGOPzbA2eoXS2eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QYxY4oWl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFD9C116B1;
	Mon,  1 Jul 2024 14:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719843743;
	bh=19F17hWu+Ye2sSoVRb3+Z9lZBe6TldJV/MN/4tOlWsc=;
	h=Subject:To:Cc:From:Date:From;
	b=QYxY4oWl5t5gPzHWvsnjVEmUhuHKRWKg5K8oAN2BtO+G/AIPqpr4VXQVpb3TBmYYi
	 nwIDBKo/ZcfGBTYbUFTc65v+8SBMst0aB0Wt1DhNF/vEte29/j9tTmBhOprqnbQe6+
	 ThLZ+f02aV4fa0F/fDdIHov88ne6+mKMkB3xsWjE=
Subject: FAILED: patch "[PATCH] PCI/MSI: Fix UAF in msi_capability_init" failed to apply to 6.1-stable tree
To: smostafa@google.com,bhelgaas@google.com,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Jul 2024 16:22:20 +0200
Message-ID: <2024070120-undergo-stipulate-9aae@gregkh>
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
git cherry-pick -x 9eee5330656bf92f51cb1f09b2dc9f8cf975b3d1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070120-undergo-stipulate-9aae@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

9eee5330656b ("PCI/MSI: Fix UAF in msi_capability_init")
b12d0bec385b ("PCI/MSI: Move pci_disable_msi() to api.c")
c93fd5266cff ("PCI/MSI: Move mask and unmask helpers to msi.h")
a474d3fbe287 ("PCI/MSI: Get rid of PCI_MSI_IRQ_DOMAIN")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9eee5330656bf92f51cb1f09b2dc9f8cf975b3d1 Mon Sep 17 00:00:00 2001
From: Mostafa Saleh <smostafa@google.com>
Date: Mon, 24 Jun 2024 20:37:28 +0000
Subject: [PATCH] PCI/MSI: Fix UAF in msi_capability_init

KFENCE reports the following UAF:

 BUG: KFENCE: use-after-free read in __pci_enable_msi_range+0x2c0/0x488

 Use-after-free read at 0x0000000024629571 (in kfence-#12):
  __pci_enable_msi_range+0x2c0/0x488
  pci_alloc_irq_vectors_affinity+0xec/0x14c
  pci_alloc_irq_vectors+0x18/0x28

 kfence-#12: 0x0000000008614900-0x00000000e06c228d, size=104, cache=kmalloc-128

 allocated by task 81 on cpu 7 at 10.808142s:
  __kmem_cache_alloc_node+0x1f0/0x2bc
  kmalloc_trace+0x44/0x138
  msi_alloc_desc+0x3c/0x9c
  msi_domain_insert_msi_desc+0x30/0x78
  msi_setup_msi_desc+0x13c/0x184
  __pci_enable_msi_range+0x258/0x488
  pci_alloc_irq_vectors_affinity+0xec/0x14c
  pci_alloc_irq_vectors+0x18/0x28

 freed by task 81 on cpu 7 at 10.811436s:
  msi_domain_free_descs+0xd4/0x10c
  msi_domain_free_locked.part.0+0xc0/0x1d8
  msi_domain_alloc_irqs_all_locked+0xb4/0xbc
  pci_msi_setup_msi_irqs+0x30/0x4c
  __pci_enable_msi_range+0x2a8/0x488
  pci_alloc_irq_vectors_affinity+0xec/0x14c
  pci_alloc_irq_vectors+0x18/0x28

Descriptor allocation done in:
__pci_enable_msi_range
    msi_capability_init
        msi_setup_msi_desc
            msi_insert_msi_desc
                msi_domain_insert_msi_desc
                    msi_alloc_desc
                        ...

Freed in case of failure in __msi_domain_alloc_locked()
__pci_enable_msi_range
    msi_capability_init
        pci_msi_setup_msi_irqs
            msi_domain_alloc_irqs_all_locked
                msi_domain_alloc_locked
                    __msi_domain_alloc_locked => fails
                    msi_domain_free_locked
                        ...

That failure propagates back to pci_msi_setup_msi_irqs() in
msi_capability_init() which accesses the descriptor for unmasking in the
error exit path.

Cure it by copying the descriptor and using the copy for the error exit path
unmask operation.

[ tglx: Massaged change log ]

Fixes: bf6e054e0e3f ("genirq/msi: Provide msi_device_populate/destroy_sysfs()")
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Heelgas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240624203729.1094506-1-smostafa@google.com

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index c5625dd9bf49..3a45879d85db 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -352,7 +352,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 			       struct irq_affinity *affd)
 {
 	struct irq_affinity_desc *masks = NULL;
-	struct msi_desc *entry;
+	struct msi_desc *entry, desc;
 	int ret;
 
 	/* Reject multi-MSI early on irq domain enabled architectures */
@@ -377,6 +377,12 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 	/* All MSIs are unmasked by default; mask them all */
 	entry = msi_first_desc(&dev->dev, MSI_DESC_ALL);
 	pci_msi_mask(entry, msi_multi_mask(entry));
+	/*
+	 * Copy the MSI descriptor for the error path because
+	 * pci_msi_setup_msi_irqs() will free it for the hierarchical
+	 * interrupt domain case.
+	 */
+	memcpy(&desc, entry, sizeof(desc));
 
 	/* Configure MSI capability structure */
 	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSI);
@@ -396,7 +402,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 	goto unlock;
 
 err:
-	pci_msi_unmask(entry, msi_multi_mask(entry));
+	pci_msi_unmask(&desc, msi_multi_mask(&desc));
 	pci_free_msi_irqs(dev);
 fail:
 	dev->msi_enabled = 0;


