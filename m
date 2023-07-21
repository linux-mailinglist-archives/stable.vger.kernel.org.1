Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC3775BE41
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 08:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjGUGHV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 02:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjGUGGx (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 02:06:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5638B3592
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 23:06:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB0BD612C4
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 06:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3B1C433C8;
        Fri, 21 Jul 2023 06:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689919569;
        bh=E3dtNegOIVSFrcJ+cLlo52QchmBeUBAQQ4MsR/AWclU=;
        h=Subject:To:Cc:From:Date:From;
        b=DC4XLLn7mZ7HyD+VPP0x8niW3/0LzzDuWjT1mzPNPwMs3cgAc+gAAO1n75Rrw4R2e
         BaUsXq81tXhD7duyG6KoaJ8JcIZM6Np0JHtTwj/7VNnIEizO/rnwrlq85kED9DtDYo
         0eKRGgdfLaPtPtN1qu8mFDjMgmWo/aI0JXGNbQtM=
Subject: FAILED: patch "[PATCH] mm/mmap: Fix error return in do_vmi_align_munmap()" failed to apply to 6.1-stable tree
To:     dwmw@amazon.co.uk, Liam.Howlett@oracle.com,
        gregkh@linuxfoundation.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 08:06:06 +0200
Message-ID: <2023072106-monologue-browsing-161a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x 6c26bd4384da24841bac4f067741bbca18b0fb74
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072106-monologue-browsing-161a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

6c26bd4384da ("mm/mmap: Fix error return in do_vmi_align_munmap()")
606c812eb1d5 ("mm/mmap: Fix error path in do_vmi_align_munmap()")
457f67be5910 ("mm: introduce vma detached flag")
73046fd00b06 ("mm: write-lock VMAs before removing them from VMA tree")
5e31275cc997 ("mm: add per-VMA lock and helper functions to control it")
438b6e12cd60 ("mm: move mmap_lock assert function definitions")
440703e082b9 ("mm/mmap: refactor locking out of __vma_adjust()")
e3d73f848e5f ("mm/mmap: move anon_vma setting in __vma_adjust()")
9e56044625a1 ("mm: pass through vma iterator to __vma_adjust()")
fbcc3104b843 ("mmap: convert __vma_adjust() to use vma iterator")
183654ce26a5 ("mmap: change do_mas_munmap and do_mas_aligned_munmap() to use vma iterator")
0378c0a0e9e4 ("mm/mmap: remove preallocation from do_mas_align_munmap()")
92fed82047d7 ("mm/mmap: convert brk to use vma iterator")
b62b633e048b ("mm: expand vma iterator interface")
baabcfc93d3b ("mm/mmap: fix typo in comment")
c5d5546ea065 ("maple_tree: remove the parameter entry of mas_preallocate")
675eaca1f441 ("mm/mmap: properly unaccount memory on mas_preallocate() failure")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6c26bd4384da24841bac4f067741bbca18b0fb74 Mon Sep 17 00:00:00 2001
From: David Woodhouse <dwmw@amazon.co.uk>
Date: Wed, 28 Jun 2023 10:55:03 +0100
Subject: [PATCH] mm/mmap: Fix error return in do_vmi_align_munmap()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If mas_store_gfp() in the gather loop failed, the 'error' variable that
ultimately gets returned was not being set. In many cases, its original
value of -ENOMEM was still in place, and that was fine. But if VMAs had
been split at the start or end of the range, then 'error' could be zero.

Change to the 'error = foo(); if (error) goto …' idiom to fix the bug.

Also clean up a later case which avoided the same bug by *explicitly*
setting error = -ENOMEM right before calling the function that might
return -ENOMEM.

In a final cosmetic change, move the 'Point of no return' comment to
*after* the goto. That's been in the wrong place since the preallocation
was removed, and this new error path was added.

Fixes: 606c812eb1d5 ("mm/mmap: Fix error path in do_vmi_align_munmap()")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: stable@vger.kernel.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

diff --git a/mm/mmap.c b/mm/mmap.c
index d600404580b2..13128e908470 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2387,7 +2387,8 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		}
 		vma_start_write(next);
 		mas_set_range(&mas_detach, next->vm_start, next->vm_end - 1);
-		if (mas_store_gfp(&mas_detach, next, GFP_KERNEL))
+		error = mas_store_gfp(&mas_detach, next, GFP_KERNEL);
+		if (error)
 			goto munmap_gather_failed;
 		vma_mark_detached(next, true);
 		if (next->vm_flags & VM_LOCKED)
@@ -2436,12 +2437,12 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		BUG_ON(count != test_count);
 	}
 #endif
-	/* Point of no return */
-	error = -ENOMEM;
 	vma_iter_set(vmi, start);
-	if (vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL))
+	error = vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL);
+	if (error)
 		goto clear_tree_failed;
 
+	/* Point of no return */
 	mm->locked_vm -= locked_vm;
 	mm->map_count -= count;
 	/*

