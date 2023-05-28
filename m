Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED22713DF4
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjE1Ta3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjE1Ta2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:30:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A728CDE
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:30:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E854061D4F
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDEC8C433D2;
        Sun, 28 May 2023 19:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302225;
        bh=XktxH3/hbUNNoaNIiVwnuzT4+djUighnKX/FL+0Oezw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dkfSdE3pV5l2nbm0/358V+co2u1PccwoAI3I54FtIqDD/EEw+lsMJk00uDQX/8mgG
         4VnZ5EUISjk/Q7ZlsPSN2/Z7PudvJawbqU1FvXqG6P1fjTqHjaDCA2raZ27ZhVk2AU
         8i/cMm0BsH6j7qJ45o34Ty1ZlOBlmpdywuq8Oeq0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Liam Howlett <liam.howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Carlos Llamas <cmllamas@google.com>
Subject: [PATCH 6.3 050/127] Revert "binder_alloc: add missing mmap_lock calls when using the VMA"
Date:   Sun, 28 May 2023 20:10:26 +0100
Message-Id: <20230528190837.981455980@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
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

commit b15655b12ddca7ade09807f790bafb6fab61b50a upstream.

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
---
 drivers/android/binder_alloc.c |   31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -380,15 +380,12 @@ static struct binder_buffer *binder_allo
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
@@ -916,25 +913,17 @@ void binder_alloc_print_pages(struct seq
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


