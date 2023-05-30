Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4A2716DD7
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 21:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjE3ToA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 15:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjE3Tn6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 15:43:58 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F624115
        for <stable@vger.kernel.org>; Tue, 30 May 2023 12:43:56 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-53f06f7cc74so84603a12.1
        for <stable@vger.kernel.org>; Tue, 30 May 2023 12:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685475836; x=1688067836;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ftH1i7B4bHzPdsjKfJA4nT7vTkwk7yoT+/tju1GrDD8=;
        b=g9fz4kTXgwXrM7gXjsxE9AhrV5T8QPVst4BCk23Qonj+F5vw+8LuFh70SInxDWcqUF
         P04/GEUcKLW214WNMMqrlLMPDIGOF1Iex/icGyNXYY187CTTHSf+F6gTI5CmOC7AwXiC
         rjMpycNGOrBwb8YJWo2IIRX4rXnmy+W1n241MtdjxzbpuHa3D28PFJGtA+T3R3n0Ayrp
         V1HmZ92Ai/Y1g8v5HmjL4cy0I+i+y7ZHAhi1s05oJL1ncmu/ndLjh+4Vsc988NC7NJzU
         I4kvio0IY4QJH+hoVlLm1X+kYSoqMEW70L0s/UiuwYMHXO78qHSuE31Hr/nyae3mYkeW
         QJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685475836; x=1688067836;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftH1i7B4bHzPdsjKfJA4nT7vTkwk7yoT+/tju1GrDD8=;
        b=W7q1tkZNYyMHljUUHJIdTtNTQ53Cu5R2JiAjggVGDMph8NcZLBVTzgZncHt1LUwLej
         lG5JEEBgHnX8v5cTNYWtHyVHTYdAvLwCP+/TgiwxiG5GjF3yrkqZlxCs11D1hBgUY9yG
         Q0IasyEOkXlTC0eaaWZmkMZGU3Ax5yFWR6dranhvXaccoaK4xTMrcyNh0932N3dYF7R8
         trCvG/2YpPkxKY9DwmbxBLid7xbxWP/8H79eRgsTyeT/SMqQaiAY8pRlEtOi39oDFkJ+
         l2ifd+ENzZgDr9YlYgn+YYw9coarmO3RfQee/QtyemddrSUjgHOoiUeT87LMROWiUErZ
         jr+A==
X-Gm-Message-State: AC+VfDz8QruE3Ds+w+z9NIqhAl2LFBmichdIHl9o8QyHclPRXh6tAuKw
        JBcwD6tTWABJtmHDC3QlDcQ4ttBBkEvVzOH8YnwQAlTK39bH+DP+scvuoi9IvZvQYXITYb9c6Go
        dE/qogLxHPnCXiftkxHxdub1I8y55knr7DTWNU7jUmH10shwLggDScmPIEYsHe8uS+pM=
X-Google-Smtp-Source: ACHHUZ6sUtgEd7Xk0iH6q7d8WXbnMO+Ov/W+QbpksRyx30Lpy2ITwwqjd7bQwnMt6l39+2dySK25ZgLu6RI5qg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a65:45c1:0:b0:52c:4e3e:24ef with SMTP id
 m1-20020a6545c1000000b0052c4e3e24efmr734630pgr.2.1685475835954; Tue, 30 May
 2023 12:43:55 -0700 (PDT)
Date:   Tue, 30 May 2023 19:43:36 +0000
In-Reply-To: <20230530194338.1683009-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20230530194338.1683009-1-cmllamas@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230530194338.1683009-3-cmllamas@google.com>
Subject: [PATCH 5.15.y 3/5] Revert "android: binder: stop saving a pointer to
 the VMA"
From:   Carlos Llamas <cmllamas@google.com>
To:     stable@vger.kernel.org
Cc:     Carlos Llamas <cmllamas@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
[cmllamas: fixed merge conflict in binder_alloc_set_vma()]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c          | 27 ++++++++++++-------------
 drivers/android/binder_alloc.h          |  2 +-
 drivers/android/binder_alloc_selftest.c |  2 +-
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index f1dc5326a1d9..3cfad638db63 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -213,7 +213,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 
 	if (mm) {
 		mmap_read_lock(mm);
-		vma = vma_lookup(mm, alloc->vma_addr);
+		vma = alloc->vma;
 	}
 
 	if (!vma && need_mm) {
@@ -313,14 +313,12 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 static inline void binder_alloc_set_vma(struct binder_alloc *alloc,
 		struct vm_area_struct *vma)
 {
-	unsigned long vm_start = 0;
-
-	if (vma) {
-		vm_start = vma->vm_start;
-		mmap_assert_write_locked(alloc->vma_vm_mm);
-	}
-
-	alloc->vma_addr = vm_start;
+	/*
+	 * If we see alloc->vma is not NULL, buffer data structures set up
+	 * completely. Look at smp_rmb side binder_alloc_get_vma.
+	 */
+	smp_wmb();
+	alloc->vma = vma;
 }
 
 static inline struct vm_area_struct *binder_alloc_get_vma(
@@ -328,9 +326,11 @@ static inline struct vm_area_struct *binder_alloc_get_vma(
 {
 	struct vm_area_struct *vma = NULL;
 
-	if (alloc->vma_addr)
-		vma = vma_lookup(alloc->vma_vm_mm, alloc->vma_addr);
-
+	if (alloc->vma) {
+		/* Look at description in binder_alloc_set_vma */
+		smp_rmb();
+		vma = alloc->vma;
+	}
 	return vma;
 }
 
@@ -819,8 +819,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 
 	buffers = 0;
 	mutex_lock(&alloc->mutex);
-	BUG_ON(alloc->vma_addr &&
-	       vma_lookup(alloc->vma_vm_mm, alloc->vma_addr));
+	BUG_ON(alloc->vma);
 
 	while ((n = rb_first(&alloc->allocated_buffers))) {
 		buffer = rb_entry(n, struct binder_buffer, rb_node);
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index 1e4fd37af5e0..7dea57a84c79 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -100,7 +100,7 @@ struct binder_lru_page {
  */
 struct binder_alloc {
 	struct mutex mutex;
-	unsigned long vma_addr;
+	struct vm_area_struct *vma;
 	struct mm_struct *vma_vm_mm;
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
-- 
2.41.0.rc0.172.g3f132b7071-goog

