Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DC871385E
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 09:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjE1HdU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 03:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjE1HdT (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 03:33:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58028B4
        for <stable@vger.kernel.org>; Sun, 28 May 2023 00:33:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E64EF60EAC
        for <stable@vger.kernel.org>; Sun, 28 May 2023 07:33:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10820C433D2;
        Sun, 28 May 2023 07:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685259197;
        bh=A3b7Gs5wL2hxpyliJ+fsXuiF1Reb9Cegv/Yv7AleEcA=;
        h=Subject:To:Cc:From:Date:From;
        b=hGBbB3ccyuNfwd55UfnP81SX4rgACdy7wJI0+zSWUsegnjcEF6frvBFM6Tl8oJl03
         HkljtwxSMmGK7PJqUjtC3k2LTV8EKCD/5X2xx3SZnpRT9X5Cq0pXIxj9UglSPdl6vO
         RwUwhi+ggWuBPEq4HcuMsCIZBoS44hpBYDDGJ2/U=
Subject: FAILED: patch "[PATCH] Revert "android: binder: stop saving a pointer to the VMA"" failed to apply to 5.15-stable tree
To:     cmllamas@google.com, gregkh@linuxfoundation.org,
        liam.howlett@oracle.com, surenb@google.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 08:33:14 +0100
Message-ID: <2023052814-bannister-undaunted-57c2@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c0fd2101781ef761b636769b2f445351f71c3626
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052814-bannister-undaunted-57c2@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

c0fd2101781e ("Revert "android: binder: stop saving a pointer to the VMA"")
7b0dbd940765 ("binder: fix binder_alloc kernel-doc warnings")
d6d04d71daae ("binder: remove binder_alloc_set_vma()")
e66b77e50522 ("binder: rename alloc->vma_vm_mm to alloc->mm")
50e177c5bfd9 ("Merge 6.0-rc4 into char-misc-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c0fd2101781ef761b636769b2f445351f71c3626 Mon Sep 17 00:00:00 2001
From: Carlos Llamas <cmllamas@google.com>
Date: Tue, 2 May 2023 20:12:18 +0000
Subject: [PATCH] Revert "android: binder: stop saving a pointer to the VMA"

This reverts commit a43cfc87caaf46710c8027a8c23b8a55f1078f19.

This patch fixed an issue reported by syzkaller in [1]. However, this
turned out to be only a band-aid in binder. The root cause, as bisected
by syzkaller, was fixed by commit 5789151e48ac ("mm/mmap: undo ->mmap()
when mas_preallocate() fails"). We no longer need the patch for binder.

Reverting such patch allows us to have a lockless access to alloc->vma
in specific cases where the mmap_lock is not required. This approach
avoids the contention that caused a performance regression.

[1] https://lore.kernel.org/all/0000000000004a0dbe05e1d749e0@google.com

[cmllamas: resolved conflicts with rework of alloc->mm and removal of
 binder_alloc_set_vma() also fixed comment section]

Fixes: a43cfc87caaf ("android: binder: stop saving a pointer to the VMA")
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Link: https://lore.kernel.org/r/20230502201220.1756319-2-cmllamas@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 92c814ec44fe..eb082b33115b 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -213,7 +213,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 
 	if (mm) {
 		mmap_read_lock(mm);
-		vma = vma_lookup(mm, alloc->vma_addr);
+		vma = alloc->vma;
 	}
 
 	if (!vma && need_mm) {
@@ -314,9 +314,11 @@ static inline struct vm_area_struct *binder_alloc_get_vma(
 {
 	struct vm_area_struct *vma = NULL;
 
-	if (alloc->vma_addr)
-		vma = vma_lookup(alloc->mm, alloc->vma_addr);
-
+	if (alloc->vma) {
+		/* Look at description in binder_alloc_set_vma */
+		smp_rmb();
+		vma = alloc->vma;
+	}
 	return vma;
 }
 
@@ -775,7 +777,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 	buffer->free = 1;
 	binder_insert_free_buffer(alloc, buffer);
 	alloc->free_async_space = alloc->buffer_size / 2;
-	alloc->vma_addr = vma->vm_start;
+	alloc->vma = vma;
 
 	return 0;
 
@@ -805,8 +807,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 
 	buffers = 0;
 	mutex_lock(&alloc->mutex);
-	BUG_ON(alloc->vma_addr &&
-	       vma_lookup(alloc->mm, alloc->vma_addr));
+	BUG_ON(alloc->vma);
 
 	while ((n = rb_first(&alloc->allocated_buffers))) {
 		buffer = rb_entry(n, struct binder_buffer, rb_node);
@@ -958,7 +959,7 @@ int binder_alloc_get_allocated_count(struct binder_alloc *alloc)
  */
 void binder_alloc_vma_close(struct binder_alloc *alloc)
 {
-	alloc->vma_addr = 0;
+	alloc->vma = 0;
 }
 
 /**
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index 0f811ac4bcff..138d1d5af9ce 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -75,7 +75,7 @@ struct binder_lru_page {
 /**
  * struct binder_alloc - per-binder proc state for binder allocator
  * @mutex:              protects binder_alloc fields
- * @vma_addr:           vm_area_struct->vm_start passed to mmap_handler
+ * @vma:                vm_area_struct passed to mmap_handler
  *                      (invariant after mmap)
  * @mm:                 copy of task->mm (invariant after open)
  * @buffer:             base of per-proc address space mapped via mmap
@@ -99,7 +99,7 @@ struct binder_lru_page {
  */
 struct binder_alloc {
 	struct mutex mutex;
-	unsigned long vma_addr;
+	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 	void __user *buffer;
 	struct list_head buffers;
diff --git a/drivers/android/binder_alloc_selftest.c b/drivers/android/binder_alloc_selftest.c
index 43a881073a42..c2b323bc3b3a 100644
--- a/drivers/android/binder_alloc_selftest.c
+++ b/drivers/android/binder_alloc_selftest.c
@@ -287,7 +287,7 @@ void binder_selftest_alloc(struct binder_alloc *alloc)
 	if (!binder_selftest_run)
 		return;
 	mutex_lock(&binder_selftest_lock);
-	if (!binder_selftest_run || !alloc->vma_addr)
+	if (!binder_selftest_run || !alloc->vma)
 		goto done;
 	pr_info("STARTED\n");
 	binder_selftest_alloc_offset(alloc, end_offset, 0);

