Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F006E713E95
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjE1Tgz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjE1Tgx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:36:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71502DC
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:36:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ED2C61E52
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDE7C433D2;
        Sun, 28 May 2023 19:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302611;
        bh=rtSK500I63Shf+BP5KyddA4A75N3rORTgN+WI4SjmvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MwT1E5ckVYcbPl4iIsXtDyryARF4oW8qNxdLwViTxBNwgJc5BojXERqlzxfKCFae1
         O5n2Fq1MGGTCmYVv5XdOw+JyiNL3kG37K+Hml+OTDKfQcoAJbdVFBH01mpUG2nSENX
         P55rX+TNItxa5iE/U+quYx+H+YZ8vpAsH+ilwuhQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Liam Howlett <liam.howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Carlos Llamas <cmllamas@google.com>
Subject: [PATCH 6.1 046/119] Revert "android: binder: stop saving a pointer to the VMA"
Date:   Sun, 28 May 2023 20:10:46 +0100
Message-Id: <20230528190836.918701923@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
References: <20230528190835.386670951@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Carlos Llamas <cmllamas@google.com>

commit c0fd2101781ef761b636769b2f445351f71c3626 upstream.

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
---
 drivers/android/binder_alloc.c          |   17 +++++++++--------
 drivers/android/binder_alloc.h          |    4 ++--
 drivers/android/binder_alloc_selftest.c |    2 +-
 3 files changed, 12 insertions(+), 11 deletions(-)

--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -213,7 +213,7 @@ static int binder_update_page_range(stru
 
 	if (mm) {
 		mmap_read_lock(mm);
-		vma = vma_lookup(mm, alloc->vma_addr);
+		vma = alloc->vma;
 	}
 
 	if (!vma && need_mm) {
@@ -314,9 +314,11 @@ static inline struct vm_area_struct *bin
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
 
@@ -775,7 +777,7 @@ int binder_alloc_mmap_handler(struct bin
 	buffer->free = 1;
 	binder_insert_free_buffer(alloc, buffer);
 	alloc->free_async_space = alloc->buffer_size / 2;
-	alloc->vma_addr = vma->vm_start;
+	alloc->vma = vma;
 
 	return 0;
 
@@ -805,8 +807,7 @@ void binder_alloc_deferred_release(struc
 
 	buffers = 0;
 	mutex_lock(&alloc->mutex);
-	BUG_ON(alloc->vma_addr &&
-	       vma_lookup(alloc->mm, alloc->vma_addr));
+	BUG_ON(alloc->vma);
 
 	while ((n = rb_first(&alloc->allocated_buffers))) {
 		buffer = rb_entry(n, struct binder_buffer, rb_node);
@@ -958,7 +959,7 @@ int binder_alloc_get_allocated_count(str
  */
 void binder_alloc_vma_close(struct binder_alloc *alloc)
 {
-	alloc->vma_addr = 0;
+	alloc->vma = 0;
 }
 
 /**
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
--- a/drivers/android/binder_alloc_selftest.c
+++ b/drivers/android/binder_alloc_selftest.c
@@ -287,7 +287,7 @@ void binder_selftest_alloc(struct binder
 	if (!binder_selftest_run)
 		return;
 	mutex_lock(&binder_selftest_lock);
-	if (!binder_selftest_run || !alloc->vma_addr)
+	if (!binder_selftest_run || !alloc->vma)
 		goto done;
 	pr_info("STARTED\n");
 	binder_selftest_alloc_offset(alloc, end_offset, 0);


