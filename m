Return-Path: <stable+bounces-251313-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIrbL0oZDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-251313-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:27:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5AD5999CA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E56C535889B2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5357366075;
	Wed, 20 May 2026 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F07ic0IP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5760037754D;
	Wed, 20 May 2026 17:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297657; cv=none; b=bKTNdVPza4cN66Z35ZV+wGutbYQcnYfU5CJIRPFhSRzchpfhckQii1iXafjDP7Eds+bIA0tMmFSF5qP1yK5LfDMorKipPporqig8ddL3UTqvDGE/JndTRLUubg9dY1Iau/OwrQQi4it4JW93Z0DOA7DiqOmRtyqRQn3iX9sIjfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297657; c=relaxed/simple;
	bh=5d8638nMvUF95dp2n5yT++ux9uq5CYlkeTTgJ12CFHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5362WFUxt8Vkw4xvBztGj1iE0dtnZdRAz1BlNRQPr0DcS0H/umsqvdKFV2TrchkucDMyGVEPXR3SEvxjbH5RTg01B8xTzcQLvD4t0P+U73XrUVb2foaJc2J9hrwGyVdoVcoFEvFTbEwu7w7ZmiYPo0rHyxRgtkKWSI/5yC8TqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F07ic0IP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A411F000E9;
	Wed, 20 May 2026 17:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297656;
	bh=QxnFxp8/TjcrnKk+U8Q0maZDECDjQCQll+HvalJyEeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F07ic0IPAT89+WKpVcUxI7xNZ7zsWlt47CKGKRyxt2ksqJ5JKSamBK78135RX9MtM
	 8ppRbUh+pgu9RDOHIZDL1VpJXyqRAXL/ke61pb3R4otVYa+wZzUC8PtzmJXG7y4Flm
	 36CFVqkwnhAVHb9YK1HrsuZZCc5RY6CMHf+YVWik=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Ankit Agrawal <ankita@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 113/957] vfio: refactor vfio_pci_mmap_huge_fault function
Date: Wed, 20 May 2026 18:09:56 +0200
Message-ID: <20260520162137.010082355@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251313-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,ziepe.ca:email]
X-Rspamd-Queue-Id: 1B5AD5999CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ankit Agrawal <ankita@nvidia.com>

[ Upstream commit 9b92bc7554b543dc00a0a0b62904a9ef2ad5c4b0 ]

Refactor vfio_pci_mmap_huge_fault to take out the implementation
to map the VMA to the PTE/PMD/PUD as a separate function.

Export the new function to be used by nvgrace-gpu module.

Move the alignment check code to verify that pfn and VMA VA is
aligned to the page order to the header file and make it inline.

No functional change is intended.

Cc: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
Link: https://lore.kernel.org/r/20251127170632.3477-2-ankita@nvidia.com
Signed-off-by: Alex Williamson <alex@shazbot.org>
Stable-dep-of: 948b71aa81cd ("drivers/vfio_pci_core: Change PXD_ORDER check from switch case to if/else block")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/pci/vfio_pci_core.c | 54 ++++++++++++++++----------------
 include/linux/vfio_pci_core.h    | 13 ++++++++
 2 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 69476fc67ca08..d07f0ede5d731 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1677,49 +1677,49 @@ static unsigned long vma_to_pfn(struct vm_area_struct *vma)
 	return (pci_resource_start(vdev->pdev, index) >> PAGE_SHIFT) + pgoff;
 }
 
-static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
-					   unsigned int order)
+vm_fault_t vfio_pci_vmf_insert_pfn(struct vfio_pci_core_device *vdev,
+				   struct vm_fault *vmf,
+				   unsigned long pfn,
+				   unsigned int order)
 {
-	struct vm_area_struct *vma = vmf->vma;
-	struct vfio_pci_core_device *vdev = vma->vm_private_data;
-	unsigned long addr = vmf->address & ~((PAGE_SIZE << order) - 1);
-	unsigned long pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
-	unsigned long pfn = vma_to_pfn(vma) + pgoff;
-	vm_fault_t ret = VM_FAULT_SIGBUS;
-
-	if (order && (addr < vma->vm_start ||
-		      addr + (PAGE_SIZE << order) > vma->vm_end ||
-		      pfn & ((1 << order) - 1))) {
-		ret = VM_FAULT_FALLBACK;
-		goto out;
-	}
-
-	down_read(&vdev->memory_lock);
+	lockdep_assert_held_read(&vdev->memory_lock);
 
 	if (vdev->pm_runtime_engaged || !__vfio_pci_memory_enabled(vdev))
-		goto out_unlock;
+		return VM_FAULT_SIGBUS;
 
 	switch (order) {
 	case 0:
-		ret = vmf_insert_pfn(vma, vmf->address, pfn);
-		break;
+		return vmf_insert_pfn(vmf->vma, vmf->address, pfn);
 #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
 	case PMD_ORDER:
-		ret = vmf_insert_pfn_pmd(vmf, pfn, false);
-		break;
+		return vmf_insert_pfn_pmd(vmf, pfn, false);
 #endif
 #ifdef CONFIG_ARCH_SUPPORTS_PUD_PFNMAP
 	case PUD_ORDER:
-		ret = vmf_insert_pfn_pud(vmf, pfn, false);
+		return vmf_insert_pfn_pud(vmf, pfn, false);
 		break;
 #endif
 	default:
-		ret = VM_FAULT_FALLBACK;
+		return VM_FAULT_FALLBACK;
+	}
+}
+EXPORT_SYMBOL_GPL(vfio_pci_vmf_insert_pfn);
+
+static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
+					   unsigned int order)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct vfio_pci_core_device *vdev = vma->vm_private_data;
+	unsigned long addr = vmf->address & ~((PAGE_SIZE << order) - 1);
+	unsigned long pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
+	unsigned long pfn = vma_to_pfn(vma) + pgoff;
+	vm_fault_t ret = VM_FAULT_FALLBACK;
+
+	if (is_aligned_for_order(vma, addr, pfn, order)) {
+		scoped_guard(rwsem_read, &vdev->memory_lock)
+			ret = vfio_pci_vmf_insert_pfn(vdev, vmf, pfn, order);
 	}
 
-out_unlock:
-	up_read(&vdev->memory_lock);
-out:
 	dev_dbg_ratelimited(&vdev->pdev->dev,
 			   "%s(,order = %d) BAR %ld page offset 0x%lx: 0x%x\n",
 			    __func__, order,
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 7aa29428982aa..0ddc42732647e 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -132,6 +132,9 @@ ssize_t vfio_pci_core_read(struct vfio_device *core_vdev, char __user *buf,
 		size_t count, loff_t *ppos);
 ssize_t vfio_pci_core_write(struct vfio_device *core_vdev, const char __user *buf,
 		size_t count, loff_t *ppos);
+vm_fault_t vfio_pci_vmf_insert_pfn(struct vfio_pci_core_device *vdev,
+				   struct vm_fault *vmf, unsigned long pfn,
+				   unsigned int order);
 int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma);
 void vfio_pci_core_request(struct vfio_device *core_vdev, unsigned int count);
 int vfio_pci_core_match(struct vfio_device *core_vdev, char *buf);
@@ -175,4 +178,14 @@ VFIO_IOREAD_DECLARATION(32)
 VFIO_IOREAD_DECLARATION(64)
 #endif
 
+static inline bool is_aligned_for_order(struct vm_area_struct *vma,
+					unsigned long addr,
+					unsigned long pfn,
+					unsigned int order)
+{
+	return !(order && (addr < vma->vm_start ||
+			   addr + (PAGE_SIZE << order) > vma->vm_end ||
+			   !IS_ALIGNED(pfn, 1 << order)));
+}
+
 #endif /* VFIO_PCI_CORE_H */
-- 
2.53.0




