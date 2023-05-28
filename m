Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F210871385D
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 09:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjE1HdD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 03:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjE1HdD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 03:33:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230C6D9
        for <stable@vger.kernel.org>; Sun, 28 May 2023 00:33:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A691614F8
        for <stable@vger.kernel.org>; Sun, 28 May 2023 07:33:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0E2C433EF;
        Sun, 28 May 2023 07:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685259181;
        bh=nzTCOvogOq9XRjfm9qTlRQB68j3ypG5PGe5xcR+n5iw=;
        h=Subject:To:Cc:From:Date:From;
        b=sF66dF4WjT22QdXpvHKPow/THnZAxArH5t3/Uu0yBepYE5gYI1kp8Trrpzo5yupwG
         1Dzgdh6twBIArS4XGqON/bl1RJAcyggiJyJDg7TrV/xfvK9Jrcl1v0rbNYaDUMAMEy
         W96geev1cSBb/tJH6CpdsUBUIB8hWjUI98+xXdtk=
Subject: FAILED: patch "[PATCH] Revert "binder_alloc: add missing mmap_lock calls when using" failed to apply to 5.15-stable tree
To:     cmllamas@google.com, gregkh@linuxfoundation.org,
        liam.howlett@oracle.com, surenb@google.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 08:32:42 +0100
Message-ID: <2023052842-ability-badness-50c6@gregkh>
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
git cherry-pick -x b15655b12ddca7ade09807f790bafb6fab61b50a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052842-ability-badness-50c6@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

b15655b12ddc ("Revert "binder_alloc: add missing mmap_lock calls when using the VMA"")
e66b77e50522 ("binder: rename alloc->vma_vm_mm to alloc->mm")
50e177c5bfd9 ("Merge 6.0-rc4 into char-misc-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b15655b12ddca7ade09807f790bafb6fab61b50a Mon Sep 17 00:00:00 2001
From: Carlos Llamas <cmllamas@google.com>
Date: Tue, 2 May 2023 20:12:17 +0000
Subject: [PATCH] Revert "binder_alloc: add missing mmap_lock calls when using
 the VMA"

This reverts commit 44e602b4e52f70f04620bbbf4fe46ecb40170bde.

This caused a performance regression particularly when pages are getting
reclaimed. We don't need to acquire the mmap_lock to determine when the
binder buffer has been fully initialized. A subsequent patch will bring
back the lockless approach for this.

[cmllamas: resolved trivial conflicts with renaming of alloc->mm]

Fixes: 44e602b4e52f ("binder_alloc: add missing mmap_lock calls when using the VMA")
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Link: https://lore.kernel.org/r/20230502201220.1756319-1-cmllamas@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 55a3c3c2409f..92c814ec44fe 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -380,15 +380,12 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	size_t size, data_offsets_size;
 	int ret;
 
-	mmap_read_lock(alloc->mm);
 	if (!binder_alloc_get_vma(alloc)) {
-		mmap_read_unlock(alloc->mm);
 		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
 				   "%d: binder_alloc_buf, no vma\n",
 				   alloc->pid);
 		return ERR_PTR(-ESRCH);
 	}
-	mmap_read_unlock(alloc->mm);
 
 	data_offsets_size = ALIGN(data_size, sizeof(void *)) +
 		ALIGN(offsets_size, sizeof(void *));
@@ -916,25 +913,17 @@ void binder_alloc_print_pages(struct seq_file *m,
 	 * Make sure the binder_alloc is fully initialized, otherwise we might
 	 * read inconsistent state.
 	 */
-
-	mmap_read_lock(alloc->mm);
-	if (binder_alloc_get_vma(alloc) == NULL) {
-		mmap_read_unlock(alloc->mm);
-		goto uninitialized;
-	}
-
-	mmap_read_unlock(alloc->mm);
-	for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
-		page = &alloc->pages[i];
-		if (!page->page_ptr)
-			free++;
-		else if (list_empty(&page->lru))
-			active++;
-		else
-			lru++;
+	if (binder_alloc_get_vma(alloc) != NULL) {
+		for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
+			page = &alloc->pages[i];
+			if (!page->page_ptr)
+				free++;
+			else if (list_empty(&page->lru))
+				active++;
+			else
+				lru++;
+		}
 	}
-
-uninitialized:
 	mutex_unlock(&alloc->mutex);
 	seq_printf(m, "  pages: %d:%d:%d\n", active, lru, free);
 	seq_printf(m, "  pages high watermark: %zu\n", alloc->pages_high);

