Return-Path: <stable+bounces-69517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8836956791
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8421F22488
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A3715B14E;
	Mon, 19 Aug 2024 09:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K2yXRvvK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD14215696E
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724061243; cv=none; b=ih9be2WyGvopMdTWSrrV6nIFCOleyr1QR2memeVp/S+e++EeZ6jfmHsFudTKjXsYmn1bfTBzOMPsBzvFVBJLkpERVOLGqrIT0z66ux2wL89U6ImeiomRLy3yv549KYta02RJKdQ6LITU5DHywBOY93mE9YPb7cZBBv2DDQyj0tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724061243; c=relaxed/simple;
	bh=+0hn6fLfpIoJCHtaHKhsvIo6IzF8Fdh438mexgHBF/M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RD2jU98QGKmMENWFV2SPJfklsxo9afRI1vsoBSiwm8lGaWJfYScKsnIZGzFym8XtLIWjspwPisTpSSmy4/JU134bJdvuABqUk6qPlnT3ULTI+PURRBW3/3OWmC+df4XCC+lUjQ2PjB1mcEywLS8NMYiWdq8gQ7oK+PTs+OlYOlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K2yXRvvK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41255C4AF0C;
	Mon, 19 Aug 2024 09:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724061243;
	bh=+0hn6fLfpIoJCHtaHKhsvIo6IzF8Fdh438mexgHBF/M=;
	h=Subject:To:Cc:From:Date:From;
	b=K2yXRvvKNOnc9gpURS3w6v2bb3vcqgjWRbIFX+HeXGtsp8nyxr/Z1jcLFeDw42qpg
	 hLKSpo8iIoklEUqaMUPelRwCYuJpccr5RkJoCdG2YG4TgZvaAxPP5qQ3EzO96l7L3U
	 pneiWXge+uU575tG14syYsVM5aFFFdyDFqk+/Lrg=
Subject: FAILED: patch "[PATCH] mm/numa: no task_numa_fault() call if PMD is changed" failed to apply to 6.6-stable tree
To: ziy@nvidia.com,akpm@linux-foundation.org,baolin.wang@linux.alibaba.com,david@redhat.com,mgorman@suse.de,shy828301@gmail.com,stable@vger.kernel.org,wangkefeng.wang@huawei.com,ying.huang@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 11:53:51 +0200
Message-ID: <2024081951-fable-brewery-9048@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x fd8c35a92910f4829b7c99841f39b1b952c259d5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081951-fable-brewery-9048@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

fd8c35a92910 ("mm/numa: no task_numa_fault() call if PMD is changed")
667ffc31aa95 ("mm: huge_memory: use a folio in do_huge_pmd_numa_page()")
73eab3ca481e ("mm: migrate: convert migrate_misplaced_page() to migrate_misplaced_folio()")
2ac9e99f3b21 ("mm: migrate: convert numamigrate_isolate_page() to numamigrate_isolate_folio()")

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


