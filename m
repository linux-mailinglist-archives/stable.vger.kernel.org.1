Return-Path: <stable+bounces-144837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35846ABBED2
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 15:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2281B6146E
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 13:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C4927978B;
	Mon, 19 May 2025 13:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E7H83tnQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69EF1F4717
	for <stable@vger.kernel.org>; Mon, 19 May 2025 13:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747660394; cv=none; b=O/OiAHiP2cwLZRV+ywBX6MMDGd0p37FkBdBb9Z9AKWzBD5sT4sKSmZ01nBr3P4ZNwYc5IFLGvFCrvh/q4KZf+p6irf7IEIopmOnXqUiC7A5uZ5vRPCQcOkMC5366PhJb2oPJ9MaUuyxBpkVwP+y2NF6UXvh6EY2ljcHxUlyJpQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747660394; c=relaxed/simple;
	bh=5MtRNSsj0daPbHJT2E0IOjSj6wEwUsUrXTQR8JDgasI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CFCwlKy8EpceZ/uw7+l0ZdH8Zo7c+KvG1BnmBpCjMMgMKUS25YptqGIrstO7870chPMSfyRyNnTQuWA4fmbs/y51zMcqmuLFpqkZrAk2ZOxcYLUcY5S0QVeYi7DoEROUENaRaLlx1DZOKCjYMo7pAQNZXVFZh432IQwz+kCrP7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E7H83tnQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3E8C4CEE4;
	Mon, 19 May 2025 13:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747660394;
	bh=5MtRNSsj0daPbHJT2E0IOjSj6wEwUsUrXTQR8JDgasI=;
	h=Subject:To:Cc:From:Date:From;
	b=E7H83tnQl1Urqa4WllDmsbuLAmrQotR1ZcG+XCc6tbDRwFhQ1JO1hp1DcVQer4ylK
	 e0WVEaaPczbpQHqfiXVrmXxZH9pqBumQQYjQBlZgirT3bE8JzPfAkXXBPfT6R0sBvz
	 6Fbj1l9qCZ+hxD9NMXSrtNVG4wR8RQbx7JUQSscM=
Subject: FAILED: patch "[PATCH] mm: hugetlb: fix incorrect fallback for subpool" failed to apply to 6.1-stable tree
To: mawupeng1@huawei.com,akpm@linux-foundation.org,david@redhat.com,joshua.hahnjy@gmail.com,muchun.song@linux.dev,osalvador@suse.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 15:13:07 +0200
Message-ID: <2025051907-laxative-caviar-b847@gregkh>
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
git cherry-pick -x a833a693a490ecff8ba377654c6d4d333718b6b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051907-laxative-caviar-b847@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a833a693a490ecff8ba377654c6d4d333718b6b1 Mon Sep 17 00:00:00 2001
From: Wupeng Ma <mawupeng1@huawei.com>
Date: Thu, 10 Apr 2025 14:26:33 +0800
Subject: [PATCH] mm: hugetlb: fix incorrect fallback for subpool

During our testing with hugetlb subpool enabled, we observe that
hstate->resv_huge_pages may underflow into negative values.  Root cause
analysis reveals a race condition in subpool reservation fallback handling
as follow:

hugetlb_reserve_pages()
    /* Attempt subpool reservation */
    gbl_reserve = hugepage_subpool_get_pages(spool, chg);

    /* Global reservation may fail after subpool allocation */
    if (hugetlb_acct_memory(h, gbl_reserve) < 0)
        goto out_put_pages;

out_put_pages:
    /* This incorrectly restores reservation to subpool */
    hugepage_subpool_put_pages(spool, chg);

When hugetlb_acct_memory() fails after subpool allocation, the current
implementation over-commits subpool reservations by returning the full
'chg' value instead of the actual allocated 'gbl_reserve' amount.  This
discrepancy propagates to global reservations during subsequent releases,
eventually causing resv_huge_pages underflow.

This problem can be trigger easily with the following steps:
1. reverse hugepage for hugeltb allocation
2. mount hugetlbfs with min_size to enable hugetlb subpool
3. alloc hugepages with two task(make sure the second will fail due to
   insufficient amount of hugepages)
4. with for a few seconds and repeat step 3 which will make
   hstate->resv_huge_pages to go below zero.

To fix this problem, return corrent amount of pages to subpool during the
fallback after hugepage_subpool_get_pages is called.

Link: https://lkml.kernel.org/r/20250410062633.3102457-1-mawupeng1@huawei.com
Fixes: 1c5ecae3a93f ("hugetlbfs: add minimum size accounting to subpools")
Signed-off-by: Wupeng Ma <mawupeng1@huawei.com>
Tested-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: David Hildenbrand <david@redhat.com>
Cc: Ma Wupeng <mawupeng1@huawei.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6ea1be71aa42..7ae38bfb9096 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3010,7 +3010,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	struct hugepage_subpool *spool = subpool_vma(vma);
 	struct hstate *h = hstate_vma(vma);
 	struct folio *folio;
-	long retval, gbl_chg;
+	long retval, gbl_chg, gbl_reserve;
 	map_chg_state map_chg;
 	int ret, idx;
 	struct hugetlb_cgroup *h_cg = NULL;
@@ -3163,8 +3163,16 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		hugetlb_cgroup_uncharge_cgroup_rsvd(idx, pages_per_huge_page(h),
 						    h_cg);
 out_subpool_put:
-	if (map_chg)
-		hugepage_subpool_put_pages(spool, 1);
+	/*
+	 * put page to subpool iff the quota of subpool's rsv_hpages is used
+	 * during hugepage_subpool_get_pages.
+	 */
+	if (map_chg && !gbl_chg) {
+		gbl_reserve = hugepage_subpool_put_pages(spool, 1);
+		hugetlb_acct_memory(h, -gbl_reserve);
+	}
+
+
 out_end_reservation:
 	if (map_chg != MAP_CHG_ENFORCED)
 		vma_end_reservation(h, vma, addr);
@@ -7239,7 +7247,7 @@ bool hugetlb_reserve_pages(struct inode *inode,
 					struct vm_area_struct *vma,
 					vm_flags_t vm_flags)
 {
-	long chg = -1, add = -1;
+	long chg = -1, add = -1, spool_resv, gbl_resv;
 	struct hstate *h = hstate_inode(inode);
 	struct hugepage_subpool *spool = subpool_inode(inode);
 	struct resv_map *resv_map;
@@ -7374,8 +7382,16 @@ bool hugetlb_reserve_pages(struct inode *inode,
 	return true;
 
 out_put_pages:
-	/* put back original number of pages, chg */
-	(void)hugepage_subpool_put_pages(spool, chg);
+	spool_resv = chg - gbl_reserve;
+	if (spool_resv) {
+		/* put sub pool's reservation back, chg - gbl_reserve */
+		gbl_resv = hugepage_subpool_put_pages(spool, spool_resv);
+		/*
+		 * subpool's reserved pages can not be put back due to race,
+		 * return to hstate.
+		 */
+		hugetlb_acct_memory(h, -gbl_resv);
+	}
 out_uncharge_cgroup:
 	hugetlb_cgroup_uncharge_cgroup_rsvd(hstate_index(h),
 					    chg * pages_per_huge_page(h), h_cg);


