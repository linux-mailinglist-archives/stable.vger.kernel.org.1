Return-Path: <stable+bounces-56708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E362C9245A1
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 19:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6440FB23B1E
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B791BD4E9;
	Tue,  2 Jul 2024 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H6yU1fqO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46A515218A;
	Tue,  2 Jul 2024 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941092; cv=none; b=jl4vGlEs5dn8ZTyim/zLx6P/CnumTLMckGkgYpbzLtL2JUtRXdxvALyp9x5L47al/D84IzGr963CSusw95sDGL8uxYOcnHn9ZHsn57pu3Tvx4/ddVOrbD9uKRsMNJU7AX03CNbriDOZRMjFBWxAtq5LfWlHoqMZn6J4UfhKbauY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941092; c=relaxed/simple;
	bh=cJXpNC0I8D7r8RIwX5OGTQyBCPyZxCpJON79IEp/SJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oie4snvz7ulVFi7gwKxNCCaS+GW8eWt0ql/b+ULkbtDtJDfZcRlr9g1iageITvTH1wZKP404oM7Olo2Dff/LGRA1hEdFngR68BBgz9Mo2LlpoyENsQVebLGnFNE/B1prW/u24z3XYJ97jXPy9TfopwL5biBmFxj7HJgQLhHexxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H6yU1fqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B3FC116B1;
	Tue,  2 Jul 2024 17:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719941092;
	bh=cJXpNC0I8D7r8RIwX5OGTQyBCPyZxCpJON79IEp/SJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H6yU1fqOAvSqw0n7I9+oc7pwML9KCOAB/6HJ1U3HX6ozeB06CwW/ceH3BTY6khJaX
	 drjmVMT2j1+XycfPAZiDCNh6JkgLCJaSx3ZSv/+Uv6+nVZKGlpTIWQYu4uKdXdlM+S
	 WP7Uk5VRnqRlmlgN4SJt8EQCGHTnUdI1hBFdkwzg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Mostafa Saleh <smostafa@google.com>,
	Bjorn Heelgas <bhelgaas@google.com>
Subject: [PATCH 6.6 125/163] PCI/MSI: Fix UAF in msi_capability_init
Date: Tue,  2 Jul 2024 19:03:59 +0200
Message-ID: <20240702170237.783974391@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702170233.048122282@linuxfoundation.org>
References: <20240702170233.048122282@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mostafa Saleh <smostafa@google.com>

commit 9eee5330656bf92f51cb1f09b2dc9f8cf975b3d1 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/msi/msi.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -348,7 +348,7 @@ static int msi_capability_init(struct pc
 			       struct irq_affinity *affd)
 {
 	struct irq_affinity_desc *masks = NULL;
-	struct msi_desc *entry;
+	struct msi_desc *entry, desc;
 	int ret;
 
 	/* Reject multi-MSI early on irq domain enabled architectures */
@@ -373,6 +373,12 @@ static int msi_capability_init(struct pc
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
@@ -392,7 +398,7 @@ static int msi_capability_init(struct pc
 	goto unlock;
 
 err:
-	pci_msi_unmask(entry, msi_multi_mask(entry));
+	pci_msi_unmask(&desc, msi_multi_mask(&desc));
 	pci_free_msi_irqs(dev);
 fail:
 	dev->msi_enabled = 0;



