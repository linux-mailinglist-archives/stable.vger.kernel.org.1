Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41DF7B8434
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 17:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242962AbjJDPw2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 11:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242929AbjJDPw1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 11:52:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B1C98
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 08:52:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE88C433C7;
        Wed,  4 Oct 2023 15:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696434743;
        bh=vL3OISoVuDI2p3FNGmOxLQdH6BRShMIw23jHSW1uK/k=;
        h=Subject:To:Cc:From:Date:From;
        b=TAqnAzIV+KXf1ZYtFFeZ8rxWZgITOL+KasCOZ4jshE1qAVOOnx1EZHkpWNBaZuZdQ
         dPSkuqAsGluIs7BEvovSBas+bYRZIJMBtXkTOPubcHRmUYrmKhKZDev08+6cnpPqBd
         otur8tVUTE18jcsAmzuX5dZDxqHrs03khDkT6pFM=
Subject: FAILED: patch "[PATCH] mm: mempolicy: keep VMA walk if both MPOL_MF_STRICT and" failed to apply to 6.1-stable tree
To:     yang@os.amperecomputing.com, akpm@linux-foundation.org,
        aquini@redhat.com, hughd@google.com, kirill@shutemov.name,
        mhocko@suse.com, osalvador@suse.de, rientjes@google.com,
        stable@vger.kernel.org, surenb@google.com, vbabka@suse.cz,
        willy@infradead.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 04 Oct 2023 17:52:20 +0200
Message-ID: <2023100420-grafting-raft-1e1b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x 24526268f4e38c9ec0c4a30de4f37ad2a2a84e47
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100420-grafting-raft-1e1b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 24526268f4e38c9ec0c4a30de4f37ad2a2a84e47 Mon Sep 17 00:00:00 2001
From: Yang Shi <yang@os.amperecomputing.com>
Date: Wed, 20 Sep 2023 15:32:42 -0700
Subject: [PATCH] mm: mempolicy: keep VMA walk if both MPOL_MF_STRICT and
 MPOL_MF_MOVE are specified

When calling mbind() with MPOL_MF_{MOVE|MOVEALL} | MPOL_MF_STRICT, kernel
should attempt to migrate all existing pages, and return -EIO if there is
misplaced or unmovable page.  Then commit 6f4576e3687b ("mempolicy: apply
page table walker on queue_pages_range()") messed up the return value and
didn't break VMA scan early ianymore when MPOL_MF_STRICT alone.  The
return value problem was fixed by commit a7f40cfe3b7a ("mm: mempolicy:
make mbind() return -EIO when MPOL_MF_STRICT is specified"), but it broke
the VMA walk early if unmovable page is met, it may cause some pages are
not migrated as expected.

The code should conceptually do:

 if (MPOL_MF_MOVE|MOVEALL)
     scan all vmas
     try to migrate the existing pages
     return success
 else if (MPOL_MF_MOVE* | MPOL_MF_STRICT)
     scan all vmas
     try to migrate the existing pages
     return -EIO if unmovable or migration failed
 else /* MPOL_MF_STRICT alone */
     break early if meets unmovable and don't call mbind_range() at all
 else /* none of those flags */
     check the ranges in test_walk, EFAULT without mbind_range() if discontig.

Fixed the behavior.

Link: https://lkml.kernel.org/r/20230920223242.3425775-1-yang@os.amperecomputing.com
Fixes: a7f40cfe3b7a ("mm: mempolicy: make mbind() return -EIO when MPOL_MF_STRICT is specified")
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Rafael Aquini <aquini@redhat.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: David Rientjes <rientjes@google.com>
Cc: <stable@vger.kernel.org>	[4.9+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 42b5567e3773..f1b00d6ac7ee 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -426,6 +426,7 @@ struct queue_pages {
 	unsigned long start;
 	unsigned long end;
 	struct vm_area_struct *first;
+	bool has_unmovable;
 };
 
 /*
@@ -446,9 +447,8 @@ static inline bool queue_folio_required(struct folio *folio,
 /*
  * queue_folios_pmd() has three possible return values:
  * 0 - folios are placed on the right node or queued successfully, or
- *     special page is met, i.e. huge zero page.
- * 1 - there is unmovable folio, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
- *     specified.
+ *     special page is met, i.e. zero page, or unmovable page is found
+ *     but continue walking (indicated by queue_pages.has_unmovable).
  * -EIO - is migration entry or only MPOL_MF_STRICT was specified and an
  *        existing folio was already on a node that does not follow the
  *        policy.
@@ -479,7 +479,7 @@ static int queue_folios_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
 	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
 		if (!vma_migratable(walk->vma) ||
 		    migrate_folio_add(folio, qp->pagelist, flags)) {
-			ret = 1;
+			qp->has_unmovable = true;
 			goto unlock;
 		}
 	} else
@@ -495,9 +495,8 @@ static int queue_folios_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
  *
  * queue_folios_pte_range() has three possible return values:
  * 0 - folios are placed on the right node or queued successfully, or
- *     special page is met, i.e. zero page.
- * 1 - there is unmovable folio, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
- *     specified.
+ *     special page is met, i.e. zero page, or unmovable page is found
+ *     but continue walking (indicated by queue_pages.has_unmovable).
  * -EIO - only MPOL_MF_STRICT was specified and an existing folio was already
  *        on a node that does not follow the policy.
  */
@@ -508,7 +507,6 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 	struct folio *folio;
 	struct queue_pages *qp = walk->private;
 	unsigned long flags = qp->flags;
-	bool has_unmovable = false;
 	pte_t *pte, *mapped_pte;
 	pte_t ptent;
 	spinlock_t *ptl;
@@ -538,11 +536,12 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 		if (!queue_folio_required(folio, qp))
 			continue;
 		if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
-			/* MPOL_MF_STRICT must be specified if we get here */
-			if (!vma_migratable(vma)) {
-				has_unmovable = true;
-				break;
-			}
+			/*
+			 * MPOL_MF_STRICT must be specified if we get here.
+			 * Continue walking vmas due to MPOL_MF_MOVE* flags.
+			 */
+			if (!vma_migratable(vma))
+				qp->has_unmovable = true;
 
 			/*
 			 * Do not abort immediately since there may be
@@ -550,16 +549,13 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 			 * need migrate other LRU pages.
 			 */
 			if (migrate_folio_add(folio, qp->pagelist, flags))
-				has_unmovable = true;
+				qp->has_unmovable = true;
 		} else
 			break;
 	}
 	pte_unmap_unlock(mapped_pte, ptl);
 	cond_resched();
 
-	if (has_unmovable)
-		return 1;
-
 	return addr != end ? -EIO : 0;
 }
 
@@ -599,7 +595,7 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
 		 * Detecting misplaced folio but allow migrating folios which
 		 * have been queued.
 		 */
-		ret = 1;
+		qp->has_unmovable = true;
 		goto unlock;
 	}
 
@@ -620,7 +616,7 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
 			 * Failed to isolate folio but allow migrating pages
 			 * which have been queued.
 			 */
-			ret = 1;
+			qp->has_unmovable = true;
 	}
 unlock:
 	spin_unlock(ptl);
@@ -756,12 +752,15 @@ queue_pages_range(struct mm_struct *mm, unsigned long start, unsigned long end,
 		.start = start,
 		.end = end,
 		.first = NULL,
+		.has_unmovable = false,
 	};
 	const struct mm_walk_ops *ops = lock_vma ?
 			&queue_pages_lock_vma_walk_ops : &queue_pages_walk_ops;
 
 	err = walk_page_range(mm, start, end, ops, &qp);
 
+	if (qp.has_unmovable)
+		err = 1;
 	if (!qp.first)
 		/* whole range in hole */
 		err = -EFAULT;
@@ -1358,7 +1357,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 				putback_movable_pages(&pagelist);
 		}
 
-		if ((ret > 0) || (nr_failed && (flags & MPOL_MF_STRICT)))
+		if (((ret > 0) || nr_failed) && (flags & MPOL_MF_STRICT))
 			err = -EIO;
 	} else {
 up_out:

