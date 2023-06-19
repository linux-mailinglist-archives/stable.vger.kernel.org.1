Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61C8735787
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 15:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjFSNB1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 09:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjFSNBT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 09:01:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3304D1722
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 06:01:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA25460BFF
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 13:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BB8C433C0;
        Mon, 19 Jun 2023 13:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687179669;
        bh=oWy61UpNMpvfB2gIHACYRgrjfpoVUBxw+3adwBTFvN4=;
        h=Subject:To:Cc:From:Date:From;
        b=UU/cFsOq4qD2KvJ6W7DImHVcQmGZrmgIZFOGMJOtg49wSs7ycT9muvXW88ROYGk7V
         K7I3IP2WszVt6zcuI4byW1DxcQ4jEDBnqZCpBtWlmtoHbIerjr+N7lnomtmutxmNY5
         meosY+XijJT8nzb8f5n/CivXMcRAPtzvF66RpGEo=
Subject: FAILED: patch "[PATCH] mm/mmap: Fix error path in do_vmi_align_munmap()" failed to apply to 6.1-stable tree
To:     Liam.Howlett@oracle.com, torvalds@linux-foundation.org,
        vegard.nossum@oracle.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 19 Jun 2023 15:01:05 +0200
Message-ID: <2023061905-footless-freewill-5f13@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
git cherry-pick -x 606c812eb1d5b5fb0dd9e330ca94b52d7c227830
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023061905-footless-freewill-5f13@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 606c812eb1d5b5fb0dd9e330ca94b52d7c227830 Mon Sep 17 00:00:00 2001
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Date: Sat, 17 Jun 2023 20:47:08 -0400
Subject: [PATCH] mm/mmap: Fix error path in do_vmi_align_munmap()

The error unrolling was leaving the VMAs detached in many cases and
leaving the locked_vm statistic altered, and skipping the unrolling
entirely in the case of the vma tree write failing.

Fix the error path by re-attaching the detached VMAs and adding the
necessary goto for the failed vma tree write, and fix the locked_vm
statistic by only updating after the vma tree write succeeds.

Fixes: 763ecb035029 ("mm: remove the vma linked list")
Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/mm/mmap.c b/mm/mmap.c
index 13678edaa22c..d600404580b2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2318,21 +2318,6 @@ int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return __split_vma(vmi, vma, addr, new_below);
 }
 
-static inline int munmap_sidetree(struct vm_area_struct *vma,
-				   struct ma_state *mas_detach)
-{
-	vma_start_write(vma);
-	mas_set_range(mas_detach, vma->vm_start, vma->vm_end - 1);
-	if (mas_store_gfp(mas_detach, vma, GFP_KERNEL))
-		return -ENOMEM;
-
-	vma_mark_detached(vma, true);
-	if (vma->vm_flags & VM_LOCKED)
-		vma->vm_mm->locked_vm -= vma_pages(vma);
-
-	return 0;
-}
-
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
@@ -2354,6 +2339,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	struct maple_tree mt_detach;
 	int count = 0;
 	int error = -ENOMEM;
+	unsigned long locked_vm = 0;
 	MA_STATE(mas_detach, &mt_detach, 0, 0);
 	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
 	mt_set_external_lock(&mt_detach, &mm->mmap_lock);
@@ -2399,9 +2385,13 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 			if (error)
 				goto end_split_failed;
 		}
-		error = munmap_sidetree(next, &mas_detach);
-		if (error)
-			goto munmap_sidetree_failed;
+		vma_start_write(next);
+		mas_set_range(&mas_detach, next->vm_start, next->vm_end - 1);
+		if (mas_store_gfp(&mas_detach, next, GFP_KERNEL))
+			goto munmap_gather_failed;
+		vma_mark_detached(next, true);
+		if (next->vm_flags & VM_LOCKED)
+			locked_vm += vma_pages(next);
 
 		count++;
 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
@@ -2447,10 +2437,12 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	}
 #endif
 	/* Point of no return */
+	error = -ENOMEM;
 	vma_iter_set(vmi, start);
 	if (vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL))
-		return -ENOMEM;
+		goto clear_tree_failed;
 
+	mm->locked_vm -= locked_vm;
 	mm->map_count -= count;
 	/*
 	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
@@ -2480,9 +2472,14 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	validate_mm(mm);
 	return downgrade ? 1 : 0;
 
+clear_tree_failed:
 userfaultfd_error:
-munmap_sidetree_failed:
+munmap_gather_failed:
 end_split_failed:
+	mas_set(&mas_detach, 0);
+	mas_for_each(&mas_detach, next, end)
+		vma_mark_detached(next, false);
+
 	__mt_destroy(&mt_detach);
 start_split_failed:
 map_count_exceeded:

