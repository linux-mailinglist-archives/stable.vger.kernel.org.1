Return-Path: <stable+bounces-55110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1655915925
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 23:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E57E1F245A1
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 21:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7656A1A0AEC;
	Mon, 24 Jun 2024 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qCPQwdxo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1S8uA9rS"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A56F8F6B;
	Mon, 24 Jun 2024 21:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719265107; cv=none; b=hGFFM4ai8+1mGF0MYfiQzXU29WCQguR6AOViWfN9PNNE1jcMSUxr82dlpNLsO9umIb3TpaXOK1YZYGPNiczNmdfwIFn/6qqttWuaijJXuBc730HP6yxaQTrSbza2FaPC99gXWgp7NeU/fb5ulmKF6GzSoCz2nFIqC/j+ZLnpWXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719265107; c=relaxed/simple;
	bh=kSPAP0ltARe2VIKg4M2LmwCAz4zBRuD++Xx7/4bmzUA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ukQKsm1A5ojTeNVY4TqDOFHCtQCqtUKbSpbmynry2KnKSkHJzgbTFJMyqxv3ZhjGeBzlHXFGJk3cS6/g2o7lqEWHpoWS49sCu9wrvZoh8eVbYN1rFESROhbGlVNNkiuaHBs1Jgtsw6LWgHzJk4tI7NzXtqNUP69QOAuyaZnC6Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qCPQwdxo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1S8uA9rS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Jun 2024 21:38:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719265103;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=795W2AEFSNy6I3D9oUUKI9VVdZefYPasni8MsUvS+5o=;
	b=qCPQwdxogdFvtV1a+tlW7msctfIU5rhX2+bf7RS2TN5hywy7ma+fMqLqO6KvE9NEyHSwZv
	L7eIOC5f5FM1LoXVD2iVcstoRrSRKwxByVEf0KdvSyVGNJGamhuvqdnJHbd9BSOOs4EJxA
	nImNvDv2WBsL+END59TuupEuOPWayODZanCPz7+SZmDXdMdWoDYZKcFFhWbKi2Uhm2PF0W
	K2XaGInCgprAnqq+XjyPv9ZGC6jekN53cxP1L4bnkCf99C3auNXgkiJjaylcnczCODFPfw
	5Fdwf3unGhWsNNEIg2g7DxbWIgM3pYmHfC1Nu+lwdwT8FRbHVWWyxjZd6ahwBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719265103;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=795W2AEFSNy6I3D9oUUKI9VVdZefYPasni8MsUvS+5o=;
	b=1S8uA9rSYRrVPselldWaWKbCmnFfXeP5Wh0nv4UiI4Y3+uSPCanR2w76mV4x6C6OWjrNKA
	ipV3rPl6wn5uxtCA==
From: "tip-bot2 for Mostafa Saleh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] PCI/MSI: Fix UAF in msi_capability_init
Cc: Thomas Gleixner <tglx@linutronix.de>, Mostafa Saleh <smostafa@google.com>,
 Bjorn Heelgas <bhelgaas@google.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240624203729.1094506-1-smostafa@google.com>
References: <20240624203729.1094506-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171926510327.10875.9576124957334657501.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     9eee5330656bf92f51cb1f09b2dc9f8cf975b3d1
Gitweb:        https://git.kernel.org/tip/9eee5330656bf92f51cb1f09b2dc9f8cf975b3d1
Author:        Mostafa Saleh <smostafa@google.com>
AuthorDate:    Mon, 24 Jun 2024 20:37:28 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 24 Jun 2024 23:33:38 +02:00

PCI/MSI: Fix UAF in msi_capability_init

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
---
 drivers/pci/msi/msi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index c5625dd..3a45879 100644
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

