Return-Path: <stable+bounces-69519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF035956793
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C7C61F225D7
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B525C15696E;
	Mon, 19 Aug 2024 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rouFRCKa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7659013B592
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724061250; cv=none; b=JmrvO0tVKToppGodoF4aAeCrOHe1FBy2359t/H3MsTFS6dU9rQjgRIm3tY3RBYFc67xuyoorywZIRBk/NgCijsCfbXqwZUbXt/Kb+84Ow8mRaO+/vDfmo1Jx1c/GPKhmmFPeWDVDVPDWkK0Hdv3F8Gbb4ucxyD+muQeozauKzc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724061250; c=relaxed/simple;
	bh=IMLFliBzf92jjYhgCYfPu2+J4N9QANkbjGbpxaVBTK8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WaTbzNJ4CQYTWiHIp/Td6O63Y8CpISc6TvFm7xKeuX26aKEktEctr4Cg16myY6lykRVEZ0IRnecEE/8UHJEprHZiQ5UwySpiEuLLwahWvOuxIUmrMqDgLKr74QO+ylWL90KihvEdVmMcru/wP2l4t2l65WSW5IKN+SRxwqtKe2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rouFRCKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01F9C32782;
	Mon, 19 Aug 2024 09:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724061250;
	bh=IMLFliBzf92jjYhgCYfPu2+J4N9QANkbjGbpxaVBTK8=;
	h=Subject:To:Cc:From:Date:From;
	b=rouFRCKa1f6CHCwGbN4qiMAIhSjTo5WMTPaTdf4AUXn5ZBTYhy88oRWfi89GvnMdO
	 3VVAaGoj1wdSEn1GVUzHAcOlvbtWxgsiVhGLHR9INfXI0uJ08hS+YqoXmsWmQHHkkX
	 DYIMdtbs6DKmj4e7YZmudvjaVUOTxkplWeU4RU0U=
Subject: FAILED: patch "[PATCH] mm/numa: no task_numa_fault() call if PMD is changed" failed to apply to 5.15-stable tree
To: ziy@nvidia.com,akpm@linux-foundation.org,baolin.wang@linux.alibaba.com,david@redhat.com,mgorman@suse.de,shy828301@gmail.com,stable@vger.kernel.org,wangkefeng.wang@huawei.com,ying.huang@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 11:53:53 +0200
Message-ID: <2024081953-corncob-gab-6fce@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x fd8c35a92910f4829b7c99841f39b1b952c259d5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081953-corncob-gab-6fce@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

fd8c35a92910 ("mm/numa: no task_numa_fault() call if PMD is changed")
667ffc31aa95 ("mm: huge_memory: use a folio in do_huge_pmd_numa_page()")
73eab3ca481e ("mm: migrate: convert migrate_misplaced_page() to migrate_misplaced_folio()")
2ac9e99f3b21 ("mm: migrate: convert numamigrate_isolate_page() to numamigrate_isolate_folio()")
4e096ae1801e ("mm: convert migrate_pages() to work on folios")
2ef7dbb26990 ("migrate_pages: try migrate in batch asynchronously firstly")
a21d2133215b ("migrate_pages: move split folios processing out of migrate_pages_batch()")
fb3592c41a44 ("migrate_pages: fix deadlock in batched migration")
f9366f4c2a29 ("include/linux/migrate.h: remove unneeded externs")
cd7755800eb5 ("mm: change to return bool for isolate_movable_page()")
f7f9c00dfaff ("mm: change to return bool for isolate_lru_page()")
be2d57563822 ("mm: change to return bool for folio_isolate_lru()")
6f7d760e86fa ("migrate_pages: move THP/hugetlb migration support check to simplify code")
7e12beb8ca2a ("migrate_pages: batch flushing TLB")
ebe75e475106 ("migrate_pages: share more code between _unmap and _move")
80562ba0d837 ("migrate_pages: move migrate_folio_unmap()")
5dfab109d519 ("migrate_pages: batch _unmap and _move")
64c8902ed441 ("migrate_pages: split unmap_and_move() to _unmap() and _move()")
42012e0436d4 ("migrate_pages: restrict number of pages to migrate in batch")
e5bfff8b10e4 ("migrate_pages: separate hugetlb folios migration")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fd8c35a92910f4829b7c99841f39b1b952c259d5 Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Fri, 9 Aug 2024 10:59:05 -0400
Subject: [PATCH] mm/numa: no task_numa_fault() call if PMD is changed

When handling a numa page fault, task_numa_fault() should be called by a
process that restores the page table of the faulted folio to avoid
duplicated stats counting.  Commit c5b5a3dd2c1f ("mm: thp: refactor NUMA
fault handling") restructured do_huge_pmd_numa_page() and did not avoid
task_numa_fault() call in the second page table check after a numa
migration failure.  Fix it by making all !pmd_same() return immediately.

This issue can cause task_numa_fault() being called more than necessary
and lead to unexpected numa balancing results (It is hard to tell whether
the issue will cause positive or negative performance impact due to
duplicated numa fault counting).

Link: https://lkml.kernel.org/r/20240809145906.1513458-3-ziy@nvidia.com
Fixes: c5b5a3dd2c1f ("mm: thp: refactor NUMA fault handling")
Reported-by: "Huang, Ying" <ying.huang@intel.com>
Closes: https://lore.kernel.org/linux-mm/87zfqfw0yw.fsf@yhuang6-desk2.ccr.corp.intel.com/
Signed-off-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Yang Shi <shy828301@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f4be468e06a4..67c86a5d64a6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1685,7 +1685,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
 	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
 		spin_unlock(vmf->ptl);
-		goto out;
+		return 0;
 	}
 
 	pmd = pmd_modify(oldpmd, vma->vm_page_prot);
@@ -1728,22 +1728,16 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
 		flags |= TNF_MIGRATED;
 		nid = target_nid;
-	} else {
-		flags |= TNF_MIGRATE_FAIL;
-		vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
-		if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
-			spin_unlock(vmf->ptl);
-			goto out;
-		}
-		goto out_map;
+		task_numa_fault(last_cpupid, nid, HPAGE_PMD_NR, flags);
+		return 0;
 	}
 
-out:
-	if (nid != NUMA_NO_NODE)
-		task_numa_fault(last_cpupid, nid, HPAGE_PMD_NR, flags);
-
-	return 0;
-
+	flags |= TNF_MIGRATE_FAIL;
+	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
+	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
+		spin_unlock(vmf->ptl);
+		return 0;
+	}
 out_map:
 	/* Restore the PMD */
 	pmd = pmd_modify(oldpmd, vma->vm_page_prot);
@@ -1753,7 +1747,10 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	set_pmd_at(vma->vm_mm, haddr, vmf->pmd, pmd);
 	update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 	spin_unlock(vmf->ptl);
-	goto out;
+
+	if (nid != NUMA_NO_NODE)
+		task_numa_fault(last_cpupid, nid, HPAGE_PMD_NR, flags);
+	return 0;
 }
 
 /*


