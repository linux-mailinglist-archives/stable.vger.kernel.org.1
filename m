Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9057B0AF2
	for <lists+stable@lfdr.de>; Wed, 27 Sep 2023 19:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjI0RPL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 27 Sep 2023 13:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjI0RPJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 27 Sep 2023 13:15:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD471A1;
        Wed, 27 Sep 2023 10:15:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA75C433C7;
        Wed, 27 Sep 2023 17:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1695834907;
        bh=4XKP41aVSVV0Q72ThqDp2TCjSva/zpmY4H44cesGbd0=;
        h=Date:To:From:Subject:From;
        b=Q6uj2f3ARdmXQe3YnEXFHz+lDtHgQGQUkbAPeyTB2lB1g725JaJgBy27w5/bk6Z45
         WfYyXr87yyrpL4whc4j0eV2Z/5jirYQKXYEgB414p+okWj5wk7S8ZT0n+L+gLU8QLx
         +2326O5P2vkfEt7uBfbGHa48e64JQJyLgi0w+cNo=
Date:   Wed, 27 Sep 2023 10:15:06 -0700
To:     mm-commits@vger.kernel.org, stable@vger.kernel.org,
        jannh@google.com, Liam.Howlett@oracle.com,
        akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: + mmap-fix-error-paths-with-dup_anon_vma.patch added to mm-hotfixes-unstable branch
Message-Id: <20230927171507.2EA75C433C7@smtp.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch titled
     Subject: mmap: fix error paths with dup_anon_vma()
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mmap-fix-error-paths-with-dup_anon_vma.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mmap-fix-error-paths-with-dup_anon_vma.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: mmap: fix error paths with dup_anon_vma()
Date: Wed, 27 Sep 2023 12:07:45 -0400

When the calling function fails after the dup_anon_vma(), the duplication
of the anon_vma is not being undone.  Add the necessary unlink_anon_vma()
call to the error paths that are missing them.

This issue showed up during inspection of the error path in vma_merge()
for an unrelated vma iterator issue.

Users may experience increased memory usage, which may be problematic as
the failure would likely be caused by a low memory situation.

Link: https://lkml.kernel.org/r/20230927160746.1928098-3-Liam.Howlett@oracle.com
Fixes: d4af56c5c7c6 ("mm: start tracking VMAs with maple tree")
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/mmap.c |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

--- a/mm/mmap.c~mmap-fix-error-paths-with-dup_anon_vma
+++ a/mm/mmap.c
@@ -587,7 +587,7 @@ again:
  * Returns: 0 on success.
  */
 static inline int dup_anon_vma(struct vm_area_struct *dst,
-			       struct vm_area_struct *src)
+		struct vm_area_struct *src, struct vm_area_struct **dup)
 {
 	/*
 	 * Easily overlooked: when mprotect shifts the boundary, make sure the
@@ -597,6 +597,7 @@ static inline int dup_anon_vma(struct vm
 	if (src->anon_vma && !dst->anon_vma) {
 		vma_assert_write_locked(dst);
 		dst->anon_vma = src->anon_vma;
+		*dup = dst;
 		return anon_vma_clone(dst, src);
 	}
 
@@ -624,6 +625,7 @@ int vma_expand(struct vma_iterator *vmi,
 	       unsigned long start, unsigned long end, pgoff_t pgoff,
 	       struct vm_area_struct *next)
 {
+	struct vm_area_struct *anon_dup = NULL;
 	bool remove_next = false;
 	struct vma_prepare vp;
 
@@ -633,7 +635,7 @@ int vma_expand(struct vma_iterator *vmi,
 
 		remove_next = true;
 		vma_start_write(next);
-		ret = dup_anon_vma(vma, next);
+		ret = dup_anon_vma(vma, next, &anon_dup);
 		if (ret)
 			return ret;
 	}
@@ -661,6 +663,8 @@ int vma_expand(struct vma_iterator *vmi,
 	return 0;
 
 nomem:
+	if (anon_dup)
+		unlink_anon_vmas(anon_dup);
 	return -ENOMEM;
 }
 
@@ -860,6 +864,7 @@ struct vm_area_struct *vma_merge(struct
 {
 	struct vm_area_struct *curr, *next, *res;
 	struct vm_area_struct *vma, *adjust, *remove, *remove2;
+	struct vm_area_struct *anon_dup = NULL;
 	struct vma_prepare vp;
 	pgoff_t vma_pgoff;
 	int err = 0;
@@ -927,18 +932,18 @@ struct vm_area_struct *vma_merge(struct
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
@@ -954,7 +959,7 @@ struct vm_area_struct *vma_merge(struct
 			vma_end = addr;
 			adjust = next;
 			adj_start = -(prev->vm_end - addr);
-			err = dup_anon_vma(next, prev);
+			err = dup_anon_vma(next, prev, &anon_dup);
 		} else {
 			/*
 			 * Note that cases 3 and 8 are the ONLY ones where prev
@@ -1018,6 +1023,9 @@ struct vm_area_struct *vma_merge(struct
 	return res;
 
 prealloc_fail:
+	if (anon_dup)
+		unlink_anon_vmas(anon_dup);
+
 anon_vma_fail:
 	if (merge_prev)
 		vma_next(vmi);
_

Patches currently in -mm which might be from Liam.Howlett@oracle.com are

maple_tree-add-mas_active-to-detect-in-tree-walks.patch
maple_tree-add-mas_underflow-and-mas_overflow-states.patch
mmap-fix-vma_iterator-in-error-path-of-vma_merge.patch
mmap-fix-error-paths-with-dup_anon_vma.patch
mmap-add-clarifying-comment-to-vma_merge-code.patch

