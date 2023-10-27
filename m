Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6513B7D977D
	for <lists+stable@lfdr.de>; Fri, 27 Oct 2023 14:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345833AbjJ0MOs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 08:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345830AbjJ0MOs (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 08:14:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FE5C0
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 05:14:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AC5C433C8;
        Fri, 27 Oct 2023 12:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698408885;
        bh=OJRBYkwiDT9X0cjq6wmrm/Ycv3wJLaqNyh+zSJUuukQ=;
        h=Subject:To:Cc:From:Date:From;
        b=kqHazBkI/RYPYfL66Bz+rqAEPurujjIsOuDtlL3TAlxVInJJjrYMefv8+UmqPQWvx
         6PPBY/K68gG5IFKk2W1AEobbLZAV1PZujp3GA98Bna+voitnGw6tefAs4iAPT1YZhe
         O6XjE3EDcYlU8+VDJX2sqZn9edTOCFCxHXh4tzPk=
Subject: FAILED: patch "[PATCH] mmap: fix error paths with dup_anon_vma()" failed to apply to 6.5-stable tree
To:     Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        jannh@google.com, lstoakes@gmail.com, stable@vger.kernel.org,
        surenb@google.com, vbabka@suse.cz, willy@infradead.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 27 Oct 2023 14:14:42 +0200
Message-ID: <2023102742-carnation-spinach-79d8@gregkh>
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


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x 824135c46b00df7fb369ec7f1f8607427bbebeb0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102742-carnation-spinach-79d8@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 824135c46b00df7fb369ec7f1f8607427bbebeb0 Mon Sep 17 00:00:00 2001
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Date: Fri, 29 Sep 2023 14:30:40 -0400
Subject: [PATCH] mmap: fix error paths with dup_anon_vma()

When the calling function fails after the dup_anon_vma(), the
duplication of the anon_vma is not being undone.  Add the necessary
unlink_anon_vma() call to the error paths that are missing them.

This issue showed up during inspection of the error path in vma_merge()
for an unrelated vma iterator issue.

Users may experience increased memory usage, which may be problematic as
the failure would likely be caused by a low memory situation.

Link: https://lkml.kernel.org/r/20230929183041.2835469-3-Liam.Howlett@oracle.com
Fixes: d4af56c5c7c6 ("mm: start tracking VMAs with maple tree")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Jann Horn <jannh@google.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/mmap.c b/mm/mmap.c
index a0917ed26057..9e018d8dd7d6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -583,11 +583,12 @@ static inline void vma_complete(struct vma_prepare *vp,
  * dup_anon_vma() - Helper function to duplicate anon_vma
  * @dst: The destination VMA
  * @src: The source VMA
+ * @dup: Pointer to the destination VMA when successful.
  *
  * Returns: 0 on success.
  */
 static inline int dup_anon_vma(struct vm_area_struct *dst,
-			       struct vm_area_struct *src)
+		struct vm_area_struct *src, struct vm_area_struct **dup)
 {
 	/*
 	 * Easily overlooked: when mprotect shifts the boundary, make sure the
@@ -595,9 +596,15 @@ static inline int dup_anon_vma(struct vm_area_struct *dst,
 	 * anon pages imported.
 	 */
 	if (src->anon_vma && !dst->anon_vma) {
+		int ret;
+
 		vma_assert_write_locked(dst);
 		dst->anon_vma = src->anon_vma;
-		return anon_vma_clone(dst, src);
+		ret = anon_vma_clone(dst, src);
+		if (ret)
+			return ret;
+
+		*dup = dst;
 	}
 
 	return 0;
@@ -624,6 +631,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	       unsigned long start, unsigned long end, pgoff_t pgoff,
 	       struct vm_area_struct *next)
 {
+	struct vm_area_struct *anon_dup = NULL;
 	bool remove_next = false;
 	struct vma_prepare vp;
 
@@ -633,7 +641,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 		remove_next = true;
 		vma_start_write(next);
-		ret = dup_anon_vma(vma, next);
+		ret = dup_anon_vma(vma, next, &anon_dup);
 		if (ret)
 			return ret;
 	}
@@ -661,6 +669,8 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return 0;
 
 nomem:
+	if (anon_dup)
+		unlink_anon_vmas(anon_dup);
 	return -ENOMEM;
 }
 
@@ -860,6 +870,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 {
 	struct vm_area_struct *curr, *next, *res;
 	struct vm_area_struct *vma, *adjust, *remove, *remove2;
+	struct vm_area_struct *anon_dup = NULL;
 	struct vma_prepare vp;
 	pgoff_t vma_pgoff;
 	int err = 0;
@@ -927,18 +938,18 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 		vma_start_write(next);
 		remove = next;				/* case 1 */
 		vma_end = next->vm_end;
-		err = dup_anon_vma(prev, next);
+		err = dup_anon_vma(prev, next, &anon_dup);
 		if (curr) {				/* case 6 */
 			vma_start_write(curr);
 			remove = curr;
 			remove2 = next;
 			if (!next->anon_vma)
-				err = dup_anon_vma(prev, curr);
+				err = dup_anon_vma(prev, curr, &anon_dup);
 		}
 	} else if (merge_prev) {			/* case 2 */
 		if (curr) {
 			vma_start_write(curr);
-			err = dup_anon_vma(prev, curr);
+			err = dup_anon_vma(prev, curr, &anon_dup);
 			if (end == curr->vm_end) {	/* case 7 */
 				remove = curr;
 			} else {			/* case 5 */
@@ -954,7 +965,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			vma_end = addr;
 			adjust = next;
 			adj_start = -(prev->vm_end - addr);
-			err = dup_anon_vma(next, prev);
+			err = dup_anon_vma(next, prev, &anon_dup);
 		} else {
 			/*
 			 * Note that cases 3 and 8 are the ONLY ones where prev
@@ -968,7 +979,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 				vma_pgoff = curr->vm_pgoff;
 				vma_start_write(curr);
 				remove = curr;
-				err = dup_anon_vma(next, curr);
+				err = dup_anon_vma(next, curr, &anon_dup);
 			}
 		}
 	}
@@ -1018,6 +1029,9 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	return res;
 
 prealloc_fail:
+	if (anon_dup)
+		unlink_anon_vmas(anon_dup);
+
 anon_vma_fail:
 	vma_iter_set(vmi, addr);
 	vma_iter_load(vmi);

