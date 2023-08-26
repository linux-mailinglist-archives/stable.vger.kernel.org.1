Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67C17898F4
	for <lists+stable@lfdr.de>; Sat, 26 Aug 2023 22:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjHZUOM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 16:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjHZUNr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 16:13:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555FF1AD
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 13:13:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2B696128D
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 20:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92A1C433C7;
        Sat, 26 Aug 2023 20:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693080823;
        bh=yTBdpkmGOMeyWCuylY986OlmEPCnteMusJLx27Q/agM=;
        h=Subject:To:Cc:From:Date:From;
        b=1cTioXy+Mdb1l9rm3g4AE8dCYB+mlIb0AQ3b0rZ18Fks3M/GJsYE71AqvKG9PahFw
         HEpcuXwofh+tYn2esVAr/XfUBvBh0R/84Pm++72aoUdoJLe3pqdmGmJPyZ0xww5nQy
         LoIJNj9aA8pTHhJjfi7wyKh+ftEurM7WWfFHTau8=
Subject: FAILED: patch "[PATCH] mm/gup: reintroduce FOLL_NUMA as FOLL_HONOR_NUMA_FAULT" failed to apply to 6.1-stable tree
To:     david@redhat.com, akpm@linux-foundation.org, hughd@google.com,
        jgg@ziepe.ca, jhubbard@nvidia.com, liubo254@huawei.com,
        mgorman@suse.de, mgorman@techsingularity.net, pbonzini@redhat.com,
        peterx@redhat.com, shuah@kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, willy@infradead.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 26 Aug 2023 22:13:39 +0200
Message-ID: <2023082639-crushed-impart-a42d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d74943a2f3cdade34e471b36f55f7979be656867
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082639-crushed-impart-a42d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

d74943a2f3cd ("mm/gup: reintroduce FOLL_NUMA as FOLL_HONOR_NUMA_FAULT")
2c2241081f7d ("mm/gup: move private gup FOLL_ flags to internal.h")
63b605128655 ("mm/gup: move gup_must_unshare() to mm/internal.h")
f04740f54594 ("mm/gup: add FOLL_UNLOCKABLE")
d64e2dbc33a1 ("mm/gup: simplify the external interface functions and consolidate invariants")
afa3c33e2684 ("mm/gup: don't call __gup_longterm_locked() if FOLL_LONGTERM cannot be set")
b2a72dff85fa ("mm/gup: have internal functions get the mmap_read_lock()")
b5054174ac7c ("mm: move FOLL_* defs to mm_types.h")
8fa590bf3448 ("Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d74943a2f3cdade34e471b36f55f7979be656867 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Thu, 3 Aug 2023 16:32:02 +0200
Subject: [PATCH] mm/gup: reintroduce FOLL_NUMA as FOLL_HONOR_NUMA_FAULT

Unfortunately commit 474098edac26 ("mm/gup: replace FOLL_NUMA by
gup_can_follow_protnone()") missed that follow_page() and
follow_trans_huge_pmd() never implicitly set FOLL_NUMA because they really
don't want to fail on PROT_NONE-mapped pages -- either due to NUMA hinting
or due to inaccessible (PROT_NONE) VMAs.

As spelled out in commit 0b9d705297b2 ("mm: numa: Support NUMA hinting
page faults from gup/gup_fast"): "Other follow_page callers like KSM
should not use FOLL_NUMA, or they would fail to get the pages if they use
follow_page instead of get_user_pages."

liubo reported [1] that smaps_rollup results are imprecise, because they
miss accounting of pages that are mapped PROT_NONE.  Further, it's easy to
reproduce that KSM no longer works on inaccessible VMAs on x86-64, because
pte_protnone()/pmd_protnone() also indictaes "true" in inaccessible VMAs,
and follow_page() refuses to return such pages right now.

As KVM really depends on these NUMA hinting faults, removing the
pte_protnone()/pmd_protnone() handling in GUP code completely is not
really an option.

To fix the issues at hand, let's revive FOLL_NUMA as FOLL_HONOR_NUMA_FAULT
to restore the original behavior for now and add better comments.

Set FOLL_HONOR_NUMA_FAULT independent of FOLL_FORCE in
is_valid_gup_args(), to add that flag for all external GUP users.

Note that there are three GUP-internal __get_user_pages() users that don't
end up calling is_valid_gup_args() and consequently won't get
FOLL_HONOR_NUMA_FAULT set.

1) get_dump_page(): we really don't want to handle NUMA hinting
   faults. It specifies FOLL_FORCE and wouldn't have honored NUMA
   hinting faults already.
2) populate_vma_page_range(): we really don't want to handle NUMA hinting
   faults. It specifies FOLL_FORCE on accessible VMAs, so it wouldn't have
   honored NUMA hinting faults already.
3) faultin_vma_page_range(): we similarly don't want to handle NUMA
   hinting faults.

To make the combination of FOLL_FORCE and FOLL_HONOR_NUMA_FAULT work in
inaccessible VMAs properly, we have to perform VMA accessibility checks in
gup_can_follow_protnone().

As GUP-fast should reject such pages either way in
pte_access_permitted()/pmd_access_permitted() -- for example on x86-64 and
arm64 that both implement pte_protnone() -- let's just always fallback to
ordinary GUP when stumbling over pte_protnone()/pmd_protnone().

As Linus notes [2], honoring NUMA faults might only make sense for
selected GUP users.

So we should really see if we can instead let relevant GUP callers specify
it manually, and not trigger NUMA hinting faults from GUP as default.
Prepare for that by making FOLL_HONOR_NUMA_FAULT an external GUP flag and
adding appropriate documenation.

While at it, remove a stale comment from follow_trans_huge_pmd(): That
comment for pmd_protnone() was added in commit 2b4847e73004 ("mm: numa:
serialise parallel get_user_page against THP migration"), which noted:

	THP does not unmap pages due to a lack of support for migration
	entries at a PMD level.  This allows races with get_user_pages

Nowadays, we do have PMD migration entries, so the comment no longer
applies.  Let's drop it.

[1] https://lore.kernel.org/r/20230726073409.631838-1-liubo254@huawei.com
[2] https://lore.kernel.org/r/CAHk-=wgRiP_9X0rRdZKT8nhemZGNateMtb366t37d8-x7VRs=g@mail.gmail.com

Link: https://lkml.kernel.org/r/20230803143208.383663-2-david@redhat.com
Fixes: 474098edac26 ("mm/gup: replace FOLL_NUMA by gup_can_follow_protnone()")
Signed-off-by: David Hildenbrand <david@redhat.com>
Reported-by: liubo <liubo254@huawei.com>
Closes: https://lore.kernel.org/r/20230726073409.631838-1-liubo254@huawei.com
Reported-by: Peter Xu <peterx@redhat.com>
Closes: https://lore.kernel.org/all/ZMKJjDaqZ7FW0jfe@x1n/
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Peter Xu <peterx@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 406ab9ea818f..34f9dba17c1a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3421,15 +3421,24 @@ static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
  * Indicates whether GUP can follow a PROT_NONE mapped page, or whether
  * a (NUMA hinting) fault is required.
  */
-static inline bool gup_can_follow_protnone(unsigned int flags)
+static inline bool gup_can_follow_protnone(struct vm_area_struct *vma,
+					   unsigned int flags)
 {
 	/*
-	 * FOLL_FORCE has to be able to make progress even if the VMA is
-	 * inaccessible. Further, FOLL_FORCE access usually does not represent
-	 * application behaviour and we should avoid triggering NUMA hinting
-	 * faults.
+	 * If callers don't want to honor NUMA hinting faults, no need to
+	 * determine if we would actually have to trigger a NUMA hinting fault.
 	 */
-	return flags & FOLL_FORCE;
+	if (!(flags & FOLL_HONOR_NUMA_FAULT))
+		return true;
+
+	/*
+	 * NUMA hinting faults don't apply in inaccessible (PROT_NONE) VMAs.
+	 *
+	 * Requiring a fault here even for inaccessible VMAs would mean that
+	 * FOLL_FORCE cannot make any progress, because handle_mm_fault()
+	 * refuses to process NUMA hinting faults in inaccessible VMAs.
+	 */
+	return !vma_is_accessible(vma);
 }
 
 typedef int (*pte_fn_t)(pte_t *pte, unsigned long addr, void *data);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5e74ce4a28cd..7d30dc4ff0ff 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1286,6 +1286,15 @@ enum {
 	FOLL_PCI_P2PDMA = 1 << 10,
 	/* allow interrupts from generic signals */
 	FOLL_INTERRUPTIBLE = 1 << 11,
+	/*
+	 * Always honor (trigger) NUMA hinting faults.
+	 *
+	 * FOLL_WRITE implicitly honors NUMA hinting faults because a
+	 * PROT_NONE-mapped page is not writable (exceptions with FOLL_FORCE
+	 * apply). get_user_pages_fast_only() always implicitly honors NUMA
+	 * hinting faults.
+	 */
+	FOLL_HONOR_NUMA_FAULT = 1 << 12,
 
 	/* See also internal only FOLL flags in mm/internal.h */
 };
diff --git a/mm/gup.c b/mm/gup.c
index 76d222ccc3ff..6e2f9e9d6537 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -597,7 +597,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	pte = ptep_get(ptep);
 	if (!pte_present(pte))
 		goto no_page;
-	if (pte_protnone(pte) && !gup_can_follow_protnone(flags))
+	if (pte_protnone(pte) && !gup_can_follow_protnone(vma, flags))
 		goto no_page;
 
 	page = vm_normal_page(vma, address, pte);
@@ -714,7 +714,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 	if (likely(!pmd_trans_huge(pmdval)))
 		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
 
-	if (pmd_protnone(pmdval) && !gup_can_follow_protnone(flags))
+	if (pmd_protnone(pmdval) && !gup_can_follow_protnone(vma, flags))
 		return no_page_table(vma, flags);
 
 	ptl = pmd_lock(mm, pmd);
@@ -851,6 +851,10 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 	if (WARN_ON_ONCE(foll_flags & FOLL_PIN))
 		return NULL;
 
+	/*
+	 * We never set FOLL_HONOR_NUMA_FAULT because callers don't expect
+	 * to fail on PROT_NONE-mapped pages.
+	 */
 	page = follow_page_mask(vma, address, foll_flags, &ctx);
 	if (ctx.pgmap)
 		put_dev_pagemap(ctx.pgmap);
@@ -2227,6 +2231,13 @@ static bool is_valid_gup_args(struct page **pages, int *locked,
 		gup_flags |= FOLL_UNLOCKABLE;
 	}
 
+	/*
+	 * For now, always trigger NUMA hinting faults. Some GUP users like
+	 * KVM require the hint to be as the calling context of GUP is
+	 * functionally similar to a memory reference from task context.
+	 */
+	gup_flags |= FOLL_HONOR_NUMA_FAULT;
+
 	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
 	if (WARN_ON_ONCE((gup_flags & (FOLL_PIN | FOLL_GET)) ==
 			 (FOLL_PIN | FOLL_GET)))
@@ -2551,7 +2562,14 @@ static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 		struct page *page;
 		struct folio *folio;
 
-		if (pte_protnone(pte) && !gup_can_follow_protnone(flags))
+		/*
+		 * Always fallback to ordinary GUP on PROT_NONE-mapped pages:
+		 * pte_access_permitted() better should reject these pages
+		 * either way: otherwise, GUP-fast might succeed in
+		 * cases where ordinary GUP would fail due to VMA access
+		 * permissions.
+		 */
+		if (pte_protnone(pte))
 			goto pte_unmap;
 
 		if (!pte_access_permitted(pte, flags & FOLL_WRITE))
@@ -2970,8 +2988,8 @@ static int gup_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr, unsigned lo
 
 		if (unlikely(pmd_trans_huge(pmd) || pmd_huge(pmd) ||
 			     pmd_devmap(pmd))) {
-			if (pmd_protnone(pmd) &&
-			    !gup_can_follow_protnone(flags))
+			/* See gup_pte_range() */
+			if (pmd_protnone(pmd))
 				return 0;
 
 			if (!gup_huge_pmd(pmd, pmdp, addr, next, flags,
@@ -3151,7 +3169,7 @@ static int internal_get_user_pages_fast(unsigned long start,
 	if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM |
 				       FOLL_FORCE | FOLL_PIN | FOLL_GET |
 				       FOLL_FAST_ONLY | FOLL_NOFAULT |
-				       FOLL_PCI_P2PDMA)))
+				       FOLL_PCI_P2PDMA | FOLL_HONOR_NUMA_FAULT)))
 		return -EINVAL;
 
 	if (gup_flags & FOLL_PIN)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index eb3678360b97..f15d557e5708 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1467,8 +1467,7 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 	if ((flags & FOLL_DUMP) && is_huge_zero_pmd(*pmd))
 		return ERR_PTR(-EFAULT);
 
-	/* Full NUMA hinting faults to serialise migration in fault paths */
-	if (pmd_protnone(*pmd) && !gup_can_follow_protnone(flags))
+	if (pmd_protnone(*pmd) && !gup_can_follow_protnone(vma, flags))
 		return NULL;
 
 	if (!pmd_write(*pmd) && gup_must_unshare(vma, flags, page))

