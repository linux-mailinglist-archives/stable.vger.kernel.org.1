Return-Path: <stable+bounces-69523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F91B956798
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CC551C20D1F
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE7515B14E;
	Mon, 19 Aug 2024 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="adQrWjsh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E07213B592
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724061284; cv=none; b=HTHhsP0VFzqRLjFVwlcFqm6PCvy+Y3ia4CQctRnArJAZLBLRJvKc2BHcAX6VnccHwdTdHxc/HJqCYLnYhOke7uOgNdSptpNglf8Oq2PSLH1Z+HppLU1F3pquilr0c1pFp8zFh9WC3MSBGFr2F0QOW9o0NN61xg+CLDE9QKcqrCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724061284; c=relaxed/simple;
	bh=XChQEm+PfiULxXvH2nvs5t445P2XtHfh22D5abSvbdI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=t/cyX7PE/Q+ZquDcCKC/Q17/YBglRmqm2XxXL3os3hQVRX4Cxk7pVW+L+aUw0aeNi3DdFmIG0MZ5uQ8He7o9XfyShcGmNT1JKIZ4TxIfgupFZs0aK3eH8i6kRLmx0K36kHIkafN58x9mFz2RdoPflMKaGR35ap3tnTCXuUhjI2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=adQrWjsh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E834C32782;
	Mon, 19 Aug 2024 09:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724061284;
	bh=XChQEm+PfiULxXvH2nvs5t445P2XtHfh22D5abSvbdI=;
	h=Subject:To:Cc:From:Date:From;
	b=adQrWjsh9opVEixxBOvf3d/dWL8yxQE9qPCnoPZWPAQZ32HwLDbEa3cncJo0dPhlg
	 0Nme0gYNYbMf2UEez9CypqosmBFAisz2ho4UoBkLTxnyQgAQyLlCbiln5zKGmkaZ+z
	 K/nk8jl3v7OMnpt2NvUdRJ1efXFVNzMelXCTyIqc=
Subject: FAILED: patch "[PATCH] mm/numa: no task_numa_fault() call if PTE is changed" failed to apply to 6.1-stable tree
To: ziy@nvidia.com,akpm@linux-foundation.org,baolin.wang@linux.alibaba.com,david@redhat.com,mgorman@suse.de,shy828301@gmail.com,stable@vger.kernel.org,wangkefeng.wang@huawei.com,ying.huang@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 11:54:33 +0200
Message-ID: <2024081933-cheddar-oak-0777@gregkh>
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
git cherry-pick -x 40b760cfd44566bca791c80e0720d70d75382b84
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081933-cheddar-oak-0777@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

40b760cfd445 ("mm/numa: no task_numa_fault() call if PTE is changed")
d2136d749d76 ("mm: support multi-size THP numa balancing")
6b0ed7b3c775 ("mm: factor out the numa mapping rebuilding into a new helper")
ec1778807a80 ("mm: mprotect: use a folio in change_pte_range()")
6695cf68b15c ("mm: memory: use a folio in do_numa_page()")
73eab3ca481e ("mm: migrate: convert migrate_misplaced_page() to migrate_misplaced_folio()")
2ac9e99f3b21 ("mm: migrate: convert numamigrate_isolate_page() to numamigrate_isolate_folio()")
df57721f9a63 ("Merge tag 'x86_shstk_for_6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 40b760cfd44566bca791c80e0720d70d75382b84 Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Fri, 9 Aug 2024 10:59:04 -0400
Subject: [PATCH] mm/numa: no task_numa_fault() call if PTE is changed

When handling a numa page fault, task_numa_fault() should be called by a
process that restores the page table of the faulted folio to avoid
duplicated stats counting.  Commit b99a342d4f11 ("NUMA balancing: reduce
TLB flush via delaying mapping on hint page fault") restructured
do_numa_page() and did not avoid task_numa_fault() call in the second page
table check after a numa migration failure.  Fix it by making all
!pte_same() return immediately.

This issue can cause task_numa_fault() being called more than necessary
and lead to unexpected numa balancing results (It is hard to tell whether
the issue will cause positive or negative performance impact due to
duplicated numa fault counting).

Link: https://lkml.kernel.org/r/20240809145906.1513458-2-ziy@nvidia.com
Fixes: b99a342d4f11 ("NUMA balancing: reduce TLB flush via delaying mapping on hint page fault")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reported-by: "Huang, Ying" <ying.huang@intel.com>
Closes: https://lore.kernel.org/linux-mm/87zfqfw0yw.fsf@yhuang6-desk2.ccr.corp.intel.com/
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Yang Shi <shy828301@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/memory.c b/mm/memory.c
index 34f8402d2046..3c01d68065be 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5295,7 +5295,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 
 	if (unlikely(!pte_same(old_pte, vmf->orig_pte))) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		goto out;
+		return 0;
 	}
 
 	pte = pte_modify(old_pte, vma->vm_page_prot);
@@ -5358,23 +5358,19 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
 		nid = target_nid;
 		flags |= TNF_MIGRATED;
-	} else {
-		flags |= TNF_MIGRATE_FAIL;
-		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
-					       vmf->address, &vmf->ptl);
-		if (unlikely(!vmf->pte))
-			goto out;
-		if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
-			pte_unmap_unlock(vmf->pte, vmf->ptl);
-			goto out;
-		}
-		goto out_map;
+		task_numa_fault(last_cpupid, nid, nr_pages, flags);
+		return 0;
 	}
 
-out:
-	if (nid != NUMA_NO_NODE)
-		task_numa_fault(last_cpupid, nid, nr_pages, flags);
-	return 0;
+	flags |= TNF_MIGRATE_FAIL;
+	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
+				       vmf->address, &vmf->ptl);
+	if (unlikely(!vmf->pte))
+		return 0;
+	if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		return 0;
+	}
 out_map:
 	/*
 	 * Make it present again, depending on how arch implements
@@ -5387,7 +5383,10 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 		numa_rebuild_single_mapping(vmf, vma, vmf->address, vmf->pte,
 					    writable);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
-	goto out;
+
+	if (nid != NUMA_NO_NODE)
+		task_numa_fault(last_cpupid, nid, nr_pages, flags);
+	return 0;
 }
 
 static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)


