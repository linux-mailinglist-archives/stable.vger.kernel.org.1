Return-Path: <stable+bounces-186140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C6CBE3AEA
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 15:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C34403A4B
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E832FFFA8;
	Thu, 16 Oct 2025 13:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PWzzY4Ns"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1791F1505
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 13:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760620996; cv=none; b=YYpoeZqLV/Tw4+LcTk4a+6LGU2HzZKt9ygl6twBug2xJIzov5vrO7MlJNX1R0lP/ZU3n8Bjse3qqeX0dSFkFKpJbmki1RbDCkE5ck9f/FBYnawWpfVPMITFhNZLR0Rl5Gzi3Ql0oPzFJN4YZ2Dkwb/8V6B4hrRava81vsWsKrXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760620996; c=relaxed/simple;
	bh=np335C/jl7rhikP338NePJlFKDX6wKVw9xIvM1T2G1A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cUWmak/tSeObdS5ajtnrK9RIXu8F/JAYeisvM6QcH8CoAOaNnObjBIdYDHhwDcvxJaAav8w5QOOsSEWN2bMYMF4rsKEMkjXbKsHQ8qHLqSPVzLjz7wxtTaMeR9OfJff761fm1laa8RhrYe5CoFj+LIajQWg5Q8pGzCzpIU+FrA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PWzzY4Ns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F84CC4CEF1;
	Thu, 16 Oct 2025 13:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760620996;
	bh=np335C/jl7rhikP338NePJlFKDX6wKVw9xIvM1T2G1A=;
	h=Subject:To:Cc:From:Date:From;
	b=PWzzY4NsTTMbeadsjUN25KLuIpnYljx+qm1z+VdhP1gjrP6c5SEJehbxRFDPwc/eA
	 xi7+ZI82DSN69MbWtzYDgg9lY5tfcq8RRJHCzEItsqWtKJk4XYXRm/hk4QDs+tbyCe
	 CMTzUS0r/s3jb8vQdiVQ14hFJwH/vSqI+r1spRME=
Subject: FAILED: patch "[PATCH] mm/rmap: fix soft-dirty and uffd-wp bit loss when remapping" failed to apply to 6.12-stable tree
To: lance.yang@linux.dev,Liam.Howlett@oracle.com,akpm@linux-foundation.org,apopple@nvidia.com,baohua@kernel.org,baolin.wang@linux.alibaba.com,byungchul@sk.com,david@redhat.com,dev.jain@arm.com,gourry@gourry.net,harry.yoo@oracle.com,jannh@google.com,joshua.hahnjy@gmail.com,lorenzo.stoakes@oracle.com,matthew.brost@intel.com,npache@redhat.com,peterx@redhat.com,rakie.kim@sk.com,riel@surriel.com,ryan.roberts@arm.com,stable@vger.kernel.org,usamaarif642@gmail.com,vbabka@suse.cz,ying.huang@linux.alibaba.com,yuzhao@google.com,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 15:22:27 +0200
Message-ID: <2025101627-shortage-author-7f5b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 9658d698a8a83540bf6a6c80d13c9a61590ee985
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101627-shortage-author-7f5b@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9658d698a8a83540bf6a6c80d13c9a61590ee985 Mon Sep 17 00:00:00 2001
From: Lance Yang <lance.yang@linux.dev>
Date: Tue, 30 Sep 2025 16:10:40 +0800
Subject: [PATCH] mm/rmap: fix soft-dirty and uffd-wp bit loss when remapping
 zero-filled mTHP subpage to shared zeropage

When splitting an mTHP and replacing a zero-filled subpage with the shared
zeropage, try_to_map_unused_to_zeropage() currently drops several
important PTE bits.

For userspace tools like CRIU, which rely on the soft-dirty mechanism for
incremental snapshots, losing the soft-dirty bit means modified pages are
missed, leading to inconsistent memory state after restore.

As pointed out by David, the more critical uffd-wp bit is also dropped.
This breaks the userfaultfd write-protection mechanism, causing writes to
be silently missed by monitoring applications, which can lead to data
corruption.

Preserve both the soft-dirty and uffd-wp bits from the old PTE when
creating the new zeropage mapping to ensure they are correctly tracked.

Link: https://lkml.kernel.org/r/20250930081040.80926-1-lance.yang@linux.dev
Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage when splitting isolated thp")
Signed-off-by: Lance Yang <lance.yang@linux.dev>
Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Dev Jain <dev.jain@arm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Jann Horn <jannh@google.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mariano Pache <npache@redhat.com>
Cc: Mathew Brost <matthew.brost@intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Yu Zhao <yuzhao@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/migrate.c b/mm/migrate.c
index ce83c2c3c287..e3065c9edb55 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -296,8 +296,7 @@ bool isolate_folio_to_list(struct folio *folio, struct list_head *list)
 }
 
 static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
-					  struct folio *folio,
-					  unsigned long idx)
+		struct folio *folio, pte_t old_pte, unsigned long idx)
 {
 	struct page *page = folio_page(folio, idx);
 	pte_t newpte;
@@ -306,7 +305,7 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 		return false;
 	VM_BUG_ON_PAGE(!PageAnon(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	VM_BUG_ON_PAGE(pte_present(ptep_get(pvmw->pte)), page);
+	VM_BUG_ON_PAGE(pte_present(old_pte), page);
 
 	if (folio_test_mlocked(folio) || (pvmw->vma->vm_flags & VM_LOCKED) ||
 	    mm_forbids_zeropage(pvmw->vma->vm_mm))
@@ -322,6 +321,12 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 
 	newpte = pte_mkspecial(pfn_pte(my_zero_pfn(pvmw->address),
 					pvmw->vma->vm_page_prot));
+
+	if (pte_swp_soft_dirty(old_pte))
+		newpte = pte_mksoft_dirty(newpte);
+	if (pte_swp_uffd_wp(old_pte))
+		newpte = pte_mkuffd_wp(newpte);
+
 	set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
 
 	dec_mm_counter(pvmw->vma->vm_mm, mm_counter(folio));
@@ -364,13 +369,13 @@ static bool remove_migration_pte(struct folio *folio,
 			continue;
 		}
 #endif
+		old_pte = ptep_get(pvmw.pte);
 		if (rmap_walk_arg->map_unused_to_zeropage &&
-		    try_to_map_unused_to_zeropage(&pvmw, folio, idx))
+		    try_to_map_unused_to_zeropage(&pvmw, folio, old_pte, idx))
 			continue;
 
 		folio_get(folio);
 		pte = mk_pte(new, READ_ONCE(vma->vm_page_prot));
-		old_pte = ptep_get(pvmw.pte);
 
 		entry = pte_to_swp_entry(old_pte);
 		if (!is_migration_entry_young(entry))


