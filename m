Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC867D977C
	for <lists+stable@lfdr.de>; Fri, 27 Oct 2023 14:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345739AbjJ0MOh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 08:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345539AbjJ0MOh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 08:14:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB0DFA
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 05:14:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B62C433C7;
        Fri, 27 Oct 2023 12:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698408874;
        bh=oxUCkV3vMRRkEnBbfAeZZwHYDg5DUjoF/MLWvBQFVP8=;
        h=Subject:To:Cc:From:Date:From;
        b=Sf8pbyckgBJ4Q3/e4bFoi5YfQYtw/luHiWK20heb6GR8NEEJAPu84Rbfwy9o3wDVS
         nHb9ijZ84o+0XD+nCG0i9XDheRN+Orgzi1WnYNlKsk1CHuuGzH+CE/WbaLI+8RXelz
         iW9SKEQWa1cvJZx8JXuDSwbV4XKHMcKtnrPe7yqQ=
Subject: FAILED: patch "[PATCH] mmap: fix vma_iterator in error path of vma_merge()" failed to apply to 6.5-stable tree
To:     Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        jannh@google.com, lstoakes@gmail.com, stable@vger.kernel.org,
        surenb@google.com, vbabka@suse.cz, willy@infradead.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 27 Oct 2023 14:14:31 +0200
Message-ID: <2023102731-olympics-bullpen-6897@gregkh>
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
git cherry-pick -x 1419430c8abb5a00590169068590dd54d86590ba
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102731-olympics-bullpen-6897@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1419430c8abb5a00590169068590dd54d86590ba Mon Sep 17 00:00:00 2001
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Date: Fri, 29 Sep 2023 14:30:39 -0400
Subject: [PATCH] mmap: fix vma_iterator in error path of vma_merge()

During the error path, the vma iterator may not be correctly positioned or
set to the correct range.  Undo the vma_prev() call by resetting to the
passed in address.  Re-walking to the same range will fix the range to the
area previously passed in.

Users would notice increased cycles as vma_merge() would be called an
extra time with vma == prev, and thus would fail to merge and return.

Link: https://lore.kernel.org/linux-mm/CAG48ez12VN1JAOtTNMY+Y2YnsU45yL5giS-Qn=ejtiHpgJAbdQ@mail.gmail.com/
Link: https://lkml.kernel.org/r/20230929183041.2835469-2-Liam.Howlett@oracle.com
Fixes: 18b098af2890 ("vma_merge: set vma iterator to correct position.")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reported-by: Jann Horn <jannh@google.com>
Closes: https://lore.kernel.org/linux-mm/CAG48ez12VN1JAOtTNMY+Y2YnsU45yL5giS-Qn=ejtiHpgJAbdQ@mail.gmail.com/
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/mmap.c b/mm/mmap.c
index 7ed286662839..a0917ed26057 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -975,7 +975,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 
 	/* Error in anon_vma clone. */
 	if (err)
-		return NULL;
+		goto anon_vma_fail;
 
 	if (vma_start < vma->vm_start || vma_end > vma->vm_end)
 		vma_expanded = true;
@@ -988,7 +988,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	}
 
 	if (vma_iter_prealloc(vmi, vma))
-		return NULL;
+		goto prealloc_fail;
 
 	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
 	VM_WARN_ON(vp.anon_vma && adjust && adjust->anon_vma &&
@@ -1016,6 +1016,12 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	vma_complete(&vp, vmi, mm);
 	khugepaged_enter_vma(res, vm_flags);
 	return res;
+
+prealloc_fail:
+anon_vma_fail:
+	vma_iter_set(vmi, addr);
+	vma_iter_load(vmi);
+	return NULL;
 }
 
 /*

