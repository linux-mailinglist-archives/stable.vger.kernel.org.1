Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA7C716DD6
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 21:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbjE3Tn7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 15:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbjE3Tn5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 15:43:57 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D42116
        for <stable@vger.kernel.org>; Tue, 30 May 2023 12:43:55 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565b499da27so3286667b3.1
        for <stable@vger.kernel.org>; Tue, 30 May 2023 12:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685475834; x=1688067834;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SNweh4ADCvFwR9iO9ggEaO8z71m4kgTRxYfIvru8nNM=;
        b=dCZoL45ayuC3cJzyp4Uw0dErcMDc4KHQ0kX2kEQhBcZtXcR3jF51on22wERsfG76F1
         KhL0Ocq1Nj8h5zmxEn6rVmVjA5zdLfWIPPSKrgK7P1hCV5r1smcFCbDl0tNGGnrroV/i
         wVGzd1wDfhyggC+lf9uGBB1OMGSanI1sHIRCgYDdgbMVW2MD0AIe+JII2T1+wnIE6y9K
         tBcWJvORWmV+FxjtBdPFsgTaDjmD+yFNC3zzXr9fr7BMaVAmwl/tTxmlrzo2E7XJ9ib9
         So4Cs/OlDRGBrjveBfvrUUAOsGYUzqJ1rdBdCe4a3SHlRluN+INVAhkGMbX814VPUgBG
         Msww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685475834; x=1688067834;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SNweh4ADCvFwR9iO9ggEaO8z71m4kgTRxYfIvru8nNM=;
        b=ArcFxlIDA3VwFPFPM2XF23Ybg2DIjCvCclMZ5ZSQzgUJ16P1/G2jOSU511SvtvknQ4
         JFIhqjCrYQtQ6lD7t20nzHPPWfcn2N/W6P2/V1jQ+sE8Ktxec3gr2QSmeMjuvY00UOEx
         +0oJr/z0a1ASSC6R97YkDpPK8YxDJp4wtZztIxJ5mtyISaUUihxM0GjtyMwiTbZEBhxB
         5KQT4xrpC2vcRQBwkrMGtDq1fPqrePIMXUMRRVJL4lgtXAIcbx5X5KFU+a5DKogNiJ7a
         ziIzY7r0wBqNOMAeHWDqzozDlUi7LyhmmFDUxLhPNVFpYRJJyzNxWzift/R727DbVU8T
         JdXg==
X-Gm-Message-State: AC+VfDzAdxhxHUnVohYbPP5Dr/ycHD/zp79B95202aSgP8VQqcfqVpyo
        Sj7c1kn4JcbiOoE6k0Pmf2fs17z9AknqoMe4WYvFeWg9NrzPSEygh+15wQfCmz8xyiCWKcATLdP
        qk32ufZeVLf/EFZukHjjCtvzpEyvQ1Gq9IErkTr9h9u+/5oEcY0ZcEgPtr6RRaZpMzWs=
X-Google-Smtp-Source: ACHHUZ7A/twy6+kg7XBnN2tKyjzg0tkY8Y+zTm1RlUR4FP2c75vuXPpAk3UlNAg8fq26+P0wt6aHBbnm4/ogZg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a25:a4a9:0:b0:ba8:1e5f:8514 with SMTP id
 g38-20020a25a4a9000000b00ba81e5f8514mr1941975ybi.5.1685475834172; Tue, 30 May
 2023 12:43:54 -0700 (PDT)
Date:   Tue, 30 May 2023 19:43:35 +0000
In-Reply-To: <20230530194338.1683009-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20230530194338.1683009-1-cmllamas@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230530194338.1683009-2-cmllamas@google.com>
Subject: [PATCH 5.15.y 2/5] Revert "binder_alloc: add missing mmap_lock calls
 when using the VMA"
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
[cmllamas: revert of original commit 44e602b4e52f applied clean]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 6acfb896b2e5..f1dc5326a1d9 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -394,15 +394,12 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	size_t size, data_offsets_size;
 	int ret;
 
-	mmap_read_lock(alloc->vma_vm_mm);
 	if (!binder_alloc_get_vma(alloc)) {
-		mmap_read_unlock(alloc->vma_vm_mm);
 		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
 				   "%d: binder_alloc_buf, no vma\n",
 				   alloc->pid);
 		return ERR_PTR(-ESRCH);
 	}
-	mmap_read_unlock(alloc->vma_vm_mm);
 
 	data_offsets_size = ALIGN(data_size, sizeof(void *)) +
 		ALIGN(offsets_size, sizeof(void *));
@@ -930,25 +927,17 @@ void binder_alloc_print_pages(struct seq_file *m,
 	 * Make sure the binder_alloc is fully initialized, otherwise we might
 	 * read inconsistent state.
 	 */
-
-	mmap_read_lock(alloc->vma_vm_mm);
-	if (binder_alloc_get_vma(alloc) == NULL) {
-		mmap_read_unlock(alloc->vma_vm_mm);
-		goto uninitialized;
-	}
-
-	mmap_read_unlock(alloc->vma_vm_mm);
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
-- 
2.41.0.rc0.172.g3f132b7071-goog

