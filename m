Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B5E7E241E
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjKFNSW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbjKFNSV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:18:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10609D8
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:18:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0BEC433C9;
        Mon,  6 Nov 2023 13:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276698;
        bh=UHxqPPiBvrxHmcPF2x7+IwnZz8ESQphsX7JxQ3awo0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CI8Bmm5xZdmGl11GqndefQEOZTpjxXknahZtjMApqvtZg/mPC56x417Qcpl2YlUBs
         rlnOzQH+dvDRZskIOf0iv4C0CICIJn4i3nKhn88PI/e+3YqCFaEg7GJPCJ7oxAbFnz
         IdWnEiJXJMrAzvmGYyNNOuNVw5pfW9lfjoAUW83I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.5 66/88] mmap: fix error paths with dup_anon_vma()
Date:   Mon,  6 Nov 2023 14:04:00 +0100
Message-ID: <20231106130308.189613370@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
References: <20231106130305.772449722@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liam R. Howlett <Liam.Howlett@oracle.com>

commit 824135c46b00df7fb369ec7f1f8607427bbebeb0 upstream.

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
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/mmap.c |   30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -603,11 +603,12 @@ again:
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
@@ -615,9 +616,15 @@ static inline int dup_anon_vma(struct vm
 	 * anon pages imported.
 	 */
 	if (src->anon_vma && !dst->anon_vma) {
+		int ret;
+
 		vma_start_write(dst);
 		dst->anon_vma = src->anon_vma;
-		return anon_vma_clone(dst, src);
+		ret = anon_vma_clone(dst, src);
+		if (ret)
+			return ret;
+
+		*dup = dst;
 	}
 
 	return 0;
@@ -644,6 +651,7 @@ int vma_expand(struct vma_iterator *vmi,
 	       unsigned long start, unsigned long end, pgoff_t pgoff,
 	       struct vm_area_struct *next)
 {
+	struct vm_area_struct *anon_dup = NULL;
 	bool remove_next = false;
 	struct vma_prepare vp;
 
@@ -651,7 +659,7 @@ int vma_expand(struct vma_iterator *vmi,
 		int ret;
 
 		remove_next = true;
-		ret = dup_anon_vma(vma, next);
+		ret = dup_anon_vma(vma, next, &anon_dup);
 		if (ret)
 			return ret;
 	}
@@ -683,6 +691,8 @@ int vma_expand(struct vma_iterator *vmi,
 	return 0;
 
 nomem:
+	if (anon_dup)
+		unlink_anon_vmas(anon_dup);
 	return -ENOMEM;
 }
 
@@ -881,6 +891,7 @@ struct vm_area_struct *vma_merge(struct
 {
 	struct vm_area_struct *curr, *next, *res;
 	struct vm_area_struct *vma, *adjust, *remove, *remove2;
+	struct vm_area_struct *anon_dup = NULL;
 	struct vma_prepare vp;
 	pgoff_t vma_pgoff;
 	int err = 0;
@@ -945,16 +956,16 @@ struct vm_area_struct *vma_merge(struct
 	    is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL)) {
 		remove = next;				/* case 1 */
 		vma_end = next->vm_end;
-		err = dup_anon_vma(prev, next);
+		err = dup_anon_vma(prev, next, &anon_dup);
 		if (curr) {				/* case 6 */
 			remove = curr;
 			remove2 = next;
 			if (!next->anon_vma)
-				err = dup_anon_vma(prev, curr);
+				err = dup_anon_vma(prev, curr, &anon_dup);
 		}
 	} else if (merge_prev) {			/* case 2 */
 		if (curr) {
-			err = dup_anon_vma(prev, curr);
+			err = dup_anon_vma(prev, curr, &anon_dup);
 			if (end == curr->vm_end) {	/* case 7 */
 				remove = curr;
 			} else {			/* case 5 */
@@ -968,7 +979,7 @@ struct vm_area_struct *vma_merge(struct
 			vma_end = addr;
 			adjust = next;
 			adj_start = -(prev->vm_end - addr);
-			err = dup_anon_vma(next, prev);
+			err = dup_anon_vma(next, prev, &anon_dup);
 		} else {
 			/*
 			 * Note that cases 3 and 8 are the ONLY ones where prev
@@ -981,7 +992,7 @@ struct vm_area_struct *vma_merge(struct
 			if (curr) {			/* case 8 */
 				vma_pgoff = curr->vm_pgoff;
 				remove = curr;
-				err = dup_anon_vma(next, curr);
+				err = dup_anon_vma(next, curr, &anon_dup);
 			}
 		}
 	}
@@ -1026,6 +1037,9 @@ struct vm_area_struct *vma_merge(struct
 	return res;
 
 prealloc_fail:
+	if (anon_dup)
+		unlink_anon_vmas(anon_dup);
+
 anon_vma_fail:
 	vma_iter_set(vmi, addr);
 	vma_iter_load(vmi);


