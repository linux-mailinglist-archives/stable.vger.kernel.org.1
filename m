Return-Path: <stable+bounces-143386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17626AB3F8B
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 19:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2AD19E64B6
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 17:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36C426561E;
	Mon, 12 May 2025 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0tzMBfFw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE9A28751B;
	Mon, 12 May 2025 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747071812; cv=none; b=YKoYJukZgItAnYCsT2+Vnrx6hz+XkJ3erRtpy1Ij4TZijWyumpqcIXQknkrL8uK8B02yvLmazfn14zEWnp2nIMW2fugqt0nIBhqh+lBO0NX/yr+5yxohE1s8oMY2nZgqiL7mJVo205u9mk4Zao/mUlaniqSeGa50YbLrSsDRlGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747071812; c=relaxed/simple;
	bh=TJcQbWXnLJIhs2dXuah2HEhXhlmexJaHIBF3t7kpAfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NbgE7yFoCKgP8XVTAAZ9y7RjapwrzRjb3CA1n4+0i2mUEG9ij46meNJguPu3U+uOC6biHK5T1Sr3DUT5DZhmdXTLsM4qZ+vVqif+knUFNV6P0MjhSo4qBBOm6+ztPLP8OOQ75gdHmPW+wVdkr7LZrXbTggJ64veOW+DgpWQAjCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0tzMBfFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9225FC4CEE7;
	Mon, 12 May 2025 17:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747071811;
	bh=TJcQbWXnLJIhs2dXuah2HEhXhlmexJaHIBF3t7kpAfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0tzMBfFwZlnHRy+26h4aWDB1Ywe2xVqtdWLQMCh6edzMZw+GHYwZ/LnjvUpfmznTX
	 pvc0Rx8zOdGd8sgCXEQTV5AY5EjoCz9MBwQAO7jdroB6xdCFvdkKAJGcCXLL7RR5Fc
	 sti8aZ1qKZtjboJWgxPaR4C5tKQ1xhXpRSwukRy0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adolfo <adolfotregosa@gmail.com>,
	Peter Xu <peterx@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 6.14 009/197] vfio/pci: Align huge faults to order
Date: Mon, 12 May 2025 19:37:39 +0200
Message-ID: <20250512172044.727230005@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172044.326436266@linuxfoundation.org>
References: <20250512172044.326436266@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Williamson <alex.williamson@redhat.com>

commit c1d9dac0db168198b6f63f460665256dedad9b6e upstream.

The vfio-pci huge_fault handler doesn't make any attempt to insert a
mapping containing the faulting address, it only inserts mappings if the
faulting address and resulting pfn are aligned.  This works in a lot of
cases, particularly in conjunction with QEMU where DMA mappings linearly
fault the mmap.  However, there are configurations where we don't get
that linear faulting and pages are faulted on-demand.

The scenario reported in the bug below is such a case, where the physical
address width of the CPU is greater than that of the IOMMU, resulting in a
VM where guest firmware has mapped device MMIO beyond the address width of
the IOMMU.  In this configuration, the MMIO is faulted on demand and
tracing indicates that occasionally the faults generate a VM_FAULT_OOM.
Given the use case, this results in a "error: kvm run failed Bad address",
killing the VM.

The host is not under memory pressure in this test, therefore it's
suspected that VM_FAULT_OOM is actually the result of a NULL return from
__pte_offset_map_lock() in the get_locked_pte() path from insert_pfn().
This suggests a potential race inserting a pte concurrent to a pmd, and
maybe indicates some deficiency in the mm layer properly handling such a
case.

Nevertheless, Peter noted the inconsistency of vfio-pci's huge_fault
handler where our mapping granularity depends on the alignment of the
faulting address relative to the order rather than aligning the faulting
address to the order to more consistently insert huge mappings.  This
change not only uses the page tables more consistently and efficiently, but
as any fault to an aligned page results in the same mapping, the race
condition suspected in the VM_FAULT_OOM is avoided.

Reported-by: Adolfo <adolfotregosa@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220057
Fixes: 09dfc8a5f2ce ("vfio/pci: Fallback huge faults for unaligned pfn")
Cc: stable@vger.kernel.org
Tested-by: Adolfo <adolfotregosa@gmail.com>
Co-developed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20250502224035.3183451-1-alex.williamson@redhat.com
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vfio/pci/vfio_pci_core.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1654,14 +1654,14 @@ static vm_fault_t vfio_pci_mmap_huge_fau
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct vfio_pci_core_device *vdev = vma->vm_private_data;
-	unsigned long pfn, pgoff = vmf->pgoff - vma->vm_pgoff;
+	unsigned long addr = vmf->address & ~((PAGE_SIZE << order) - 1);
+	unsigned long pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
+	unsigned long pfn = vma_to_pfn(vma) + pgoff;
 	vm_fault_t ret = VM_FAULT_SIGBUS;
 
-	pfn = vma_to_pfn(vma) + pgoff;
-
-	if (order && (pfn & ((1 << order) - 1) ||
-		      vmf->address & ((PAGE_SIZE << order) - 1) ||
-		      vmf->address + (PAGE_SIZE << order) > vma->vm_end)) {
+	if (order && (addr < vma->vm_start ||
+		      addr + (PAGE_SIZE << order) > vma->vm_end ||
+		      pfn & ((1 << order) - 1))) {
 		ret = VM_FAULT_FALLBACK;
 		goto out;
 	}



