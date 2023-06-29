Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B13742C2A
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjF2SpM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjF2Sor (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:44:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F7930F6
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:44:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7A01615DC
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A2AC433C0;
        Thu, 29 Jun 2023 18:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688064276;
        bh=jiBNPPQlhBhI9RuBfeQMzcn3DZgZQWtK/fidqMTM90k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cDpPMFsicc7DXTS+l/VdeDNhT+W7uqu+SWWtk8ONwj56VP2y/Hg4tyHwOhBhUCZ1z
         5lGK2F2MUK+9JjYK4unBFzzxwLIT0I2kh8cGcs4sN3bJZAAlbiyiy1HBmf8rNELvSr
         o4aghNGjvNnQkufEvY6r+HzQE1TI2L8uVMNSTKT0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vegard Nossum <vegard.nossum@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 6.1 01/30] mm/mmap: Fix error path in do_vmi_align_munmap()
Date:   Thu, 29 Jun 2023 20:43:20 +0200
Message-ID: <20230629184151.707413629@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629184151.651069086@linuxfoundation.org>
References: <20230629184151.651069086@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

commit 606c812eb1d5b5fb0dd9e330ca94b52d7c227830 upstream

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
[ dwmw2: Strictly, the original patch wasn't *re-attaching* the
         detached VMAs. They *were* still attached but just had
         the 'detached' flag set, which is an optimisation. Which
         doesn't exist in 6.3, so drop that. Also drop the call
         to vma_start_write() which came in with the per-VMA
         locking in 6.4. ]
[ dwmw2 (6.1): It's do_mas_align_munmap() here. And has two call
         sites for the now-removed munmap_sidetree() function.
         Inline them both rather then trying to backport various
         dependencies with potentially subtle interactions. ]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/mmap.c |   33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2311,19 +2311,6 @@ int split_vma(struct mm_struct *mm, stru
 	return __split_vma(mm, vma, addr, new_below);
 }
 
-static inline int munmap_sidetree(struct vm_area_struct *vma,
-				   struct ma_state *mas_detach)
-{
-	mas_set_range(mas_detach, vma->vm_start, vma->vm_end - 1);
-	if (mas_store_gfp(mas_detach, vma, GFP_KERNEL))
-		return -ENOMEM;
-
-	if (vma->vm_flags & VM_LOCKED)
-		vma->vm_mm->locked_vm -= vma_pages(vma);
-
-	return 0;
-}
-
 /*
  * do_mas_align_munmap() - munmap the aligned region from @start to @end.
  * @mas: The maple_state, ideally set up to alter the correct tree location.
@@ -2345,6 +2332,7 @@ do_mas_align_munmap(struct ma_state *mas
 	struct maple_tree mt_detach;
 	int count = 0;
 	int error = -ENOMEM;
+	unsigned long locked_vm = 0;
 	MA_STATE(mas_detach, &mt_detach, 0, 0);
 	mt_init_flags(&mt_detach, mas->tree->ma_flags & MT_FLAGS_LOCK_MASK);
 	mt_set_external_lock(&mt_detach, &mm->mmap_lock);
@@ -2403,18 +2391,23 @@ do_mas_align_munmap(struct ma_state *mas
 
 			mas_set(mas, end);
 			split = mas_prev(mas, 0);
-			error = munmap_sidetree(split, &mas_detach);
+			mas_set_range(&mas_detach, split->vm_start, split->vm_end - 1);
+			error = mas_store_gfp(&mas_detach, split, GFP_KERNEL);
 			if (error)
-				goto munmap_sidetree_failed;
+				goto munmap_gather_failed;
+			if (next->vm_flags & VM_LOCKED)
+				locked_vm += vma_pages(split);
 
 			count++;
 			if (vma == next)
 				vma = split;
 			break;
 		}
-		error = munmap_sidetree(next, &mas_detach);
-		if (error)
-			goto munmap_sidetree_failed;
+		mas_set_range(&mas_detach, next->vm_start, next->vm_end - 1);
+		if (mas_store_gfp(&mas_detach, next, GFP_KERNEL))
+			goto munmap_gather_failed;
+		if (next->vm_flags & VM_LOCKED)
+			locked_vm += vma_pages(next);
 
 		count++;
 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
@@ -2464,6 +2457,8 @@ do_mas_align_munmap(struct ma_state *mas
 	}
 #endif
 	mas_store_prealloc(mas, NULL);
+
+	mm->locked_vm -= locked_vm;
 	mm->map_count -= count;
 	/*
 	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
@@ -2490,7 +2485,7 @@ do_mas_align_munmap(struct ma_state *mas
 	return downgrade ? 1 : 0;
 
 userfaultfd_error:
-munmap_sidetree_failed:
+munmap_gather_failed:
 end_split_failed:
 	__mt_destroy(&mt_detach);
 start_split_failed:


