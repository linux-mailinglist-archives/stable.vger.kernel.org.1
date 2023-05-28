Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2651171385F
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 09:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjE1Hdi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 03:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjE1Hdh (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 03:33:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38657B4
        for <stable@vger.kernel.org>; Sun, 28 May 2023 00:33:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C211D60EAC
        for <stable@vger.kernel.org>; Sun, 28 May 2023 07:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E154FC433D2;
        Sun, 28 May 2023 07:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685259215;
        bh=fpOhW1NAUAL9Zp6fDZYoxPQCFtrYXOneYBfNCsRnUDs=;
        h=Subject:To:Cc:From:Date:From;
        b=D0s9o/Tdvt/lmU3kfAf2zQg28w8Q0bFmlvJ+0faRPv0gBPqD88uRXgvvCpxcx+lUY
         AP58rn/2ndbZVDHRZ5tDrDdgJp+C5KZNplHg86/Bj0EinTAL40QvckipjWMabGZIoc
         tp62YzTxR3JBvU2ptkYTx1ow6EdpnK8karVXCn7g=
Subject: FAILED: patch "[PATCH] binder: add lockless binder_alloc_(set|get)_vma()" failed to apply to 5.15-stable tree
To:     cmllamas@google.com, gregkh@linuxfoundation.org,
        liam.howlett@oracle.com, surenb@google.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 08:33:32 +0100
Message-ID: <2023052832-ideally-gleeful-6ac6@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0fa53349c3acba0239369ba4cd133740a408d246
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052832-ideally-gleeful-6ac6@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

0fa53349c3ac ("binder: add lockless binder_alloc_(set|get)_vma()")
c0fd2101781e ("Revert "android: binder: stop saving a pointer to the VMA"")
b15655b12ddc ("Revert "binder_alloc: add missing mmap_lock calls when using the VMA"")
7b0dbd940765 ("binder: fix binder_alloc kernel-doc warnings")
d6d04d71daae ("binder: remove binder_alloc_set_vma()")
e66b77e50522 ("binder: rename alloc->vma_vm_mm to alloc->mm")
50e177c5bfd9 ("Merge 6.0-rc4 into char-misc-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0fa53349c3acba0239369ba4cd133740a408d246 Mon Sep 17 00:00:00 2001
From: Carlos Llamas <cmllamas@google.com>
Date: Tue, 2 May 2023 20:12:19 +0000
Subject: [PATCH] binder: add lockless binder_alloc_(set|get)_vma()

Bring back the original lockless design in binder_alloc to determine
whether the buffer setup has been completed by the ->mmap() handler.
However, this time use smp_load_acquire() and smp_store_release() to
wrap all the ordering in a single macro call.

Also, add comments to make it evident that binder uses alloc->vma to
determine when the binder_alloc has been fully initialized. In these
scenarios acquiring the mmap_lock is not required.

Fixes: a43cfc87caaf ("android: binder: stop saving a pointer to the VMA")
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Link: https://lore.kernel.org/r/20230502201220.1756319-3-cmllamas@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index eb082b33115b..e7c9d466f8e8 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -309,17 +309,18 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 	return vma ? -ENOMEM : -ESRCH;
 }
 
+static inline void binder_alloc_set_vma(struct binder_alloc *alloc,
+		struct vm_area_struct *vma)
+{
+	/* pairs with smp_load_acquire in binder_alloc_get_vma() */
+	smp_store_release(&alloc->vma, vma);
+}
+
 static inline struct vm_area_struct *binder_alloc_get_vma(
 		struct binder_alloc *alloc)
 {
-	struct vm_area_struct *vma = NULL;
-
-	if (alloc->vma) {
-		/* Look at description in binder_alloc_set_vma */
-		smp_rmb();
-		vma = alloc->vma;
-	}
-	return vma;
+	/* pairs with smp_store_release in binder_alloc_set_vma() */
+	return smp_load_acquire(&alloc->vma);
 }
 
 static bool debug_low_async_space_locked(struct binder_alloc *alloc, int pid)
@@ -382,6 +383,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	size_t size, data_offsets_size;
 	int ret;
 
+	/* Check binder_alloc is fully initialized */
 	if (!binder_alloc_get_vma(alloc)) {
 		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
 				   "%d: binder_alloc_buf, no vma\n",
@@ -777,7 +779,9 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 	buffer->free = 1;
 	binder_insert_free_buffer(alloc, buffer);
 	alloc->free_async_space = alloc->buffer_size / 2;
-	alloc->vma = vma;
+
+	/* Signal binder_alloc is fully initialized */
+	binder_alloc_set_vma(alloc, vma);
 
 	return 0;
 
@@ -959,7 +963,7 @@ int binder_alloc_get_allocated_count(struct binder_alloc *alloc)
  */
 void binder_alloc_vma_close(struct binder_alloc *alloc)
 {
-	alloc->vma = 0;
+	binder_alloc_set_vma(alloc, NULL);
 }
 
 /**

