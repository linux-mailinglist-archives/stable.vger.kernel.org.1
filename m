Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FEC716DD8
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 21:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjE3ToB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 15:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjE3ToA (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 15:44:00 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F789C9
        for <stable@vger.kernel.org>; Tue, 30 May 2023 12:43:58 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2566e9b14a4so3004038a91.2
        for <stable@vger.kernel.org>; Tue, 30 May 2023 12:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685475837; x=1688067837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lsoKnhMyYWtvX7bgcV3hXyUa2iRxf5rViO/PTAWQSPE=;
        b=Kb6r3plcykzI4Yfcqr7qmgepDs3uhEnMC8MnnxQXLRxptWjsaf1qgrxqOzR4fNZs1+
         LbbezNSqqAG6vySW2ljNOICjDbrbKE3/bWrRn3VEuH6s/4mj7m5aMnlhN67z3PX2Ncnw
         9zlg7YuJJpy9xepZLzJqjQeTUGYCeZBuxVta9TsS2FuMug9HDd2XSOgUEVHZi4Y2CE2F
         mzybBj2a101sRb3fCreid6rMyVM6k3TMNWYZYhLLpxb7RiJKDg9AXi6QQI299qiSasda
         itqm3sHi2tMLd2vXO76yxOCMSLBZ/o7kynF0UQFULPMvSDwWOCPf9sdZlYoqycI2Osek
         yRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685475837; x=1688067837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lsoKnhMyYWtvX7bgcV3hXyUa2iRxf5rViO/PTAWQSPE=;
        b=LFg1PlXnWFraeenFfrz2PSHvCPyr5APqtHZJck6TTZ5twyL+DJziQJO1ySR5O1mfdh
         9o7PpwRDN/y7kkiAouBDeplahQpKKYFcwadS4327jEJzHxS1jOotQtWF2oIQDSY4gr2j
         oi6nVhK5WbRqn1l7/ueHzwUImdOfEiTfxKx6EQ8kgsAf2ZABqChzP4FPatw2IYfgT2DF
         R7oodChtGpDDEXDKbCIUXfxs/TCACDjs7ZVzG2VxkLhtswsQFD/kwCpXerEkOSAcIDEh
         R3b6NLa2ZreHbmq0OIwTj74v7hGSoySw3b67NVmUFkI4+pIzbQeU7pnJQJkjStYy4x+U
         KAug==
X-Gm-Message-State: AC+VfDxHe/6yI4zpCmas5GajNkUk0cocm9/rdsS2d2N9rvIgP55MqzHZ
        9uk6nGewBlrHoTB535SOcFODRVLbNb3L49I4+vBWbrmhBx+oyVsnvKxdxmTHiIY6rxadJtQahsf
        a0dbFdXMix68DdWwBnTSaXVDopRgwPbadkCytFBTXmeGvgQRbt/v+EBSm0EcIttHzVho=
X-Google-Smtp-Source: ACHHUZ7YYG0zF2wLZY3Fq2LkXPGP/LyiUsm+s0GLWGNClS3H4vuHy7qQFfBH8o+JqM3Zub5DvKqjeahrVu9H2g==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:90a:b401:b0:250:9311:ebb7 with SMTP
 id f1-20020a17090ab40100b002509311ebb7mr724312pjr.9.1685475837512; Tue, 30
 May 2023 12:43:57 -0700 (PDT)
Date:   Tue, 30 May 2023 19:43:37 +0000
In-Reply-To: <20230530194338.1683009-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20230530194338.1683009-1-cmllamas@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230530194338.1683009-4-cmllamas@google.com>
Subject: [PATCH 5.15.y 4/5] binder: add lockless binder_alloc_(set|get)_vma()
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

commit 0fa53349c3acba0239369ba4cd133740a408d246 upstream.

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
[cmllamas: fixed minor merge conflict in binder_alloc_set_vma()]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 3cfad638db63..a54deddafc6d 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -309,29 +309,18 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 	return vma ? -ENOMEM : -ESRCH;
 }
 
-
 static inline void binder_alloc_set_vma(struct binder_alloc *alloc,
 		struct vm_area_struct *vma)
 {
-	/*
-	 * If we see alloc->vma is not NULL, buffer data structures set up
-	 * completely. Look at smp_rmb side binder_alloc_get_vma.
-	 */
-	smp_wmb();
-	alloc->vma = vma;
+	/* pairs with smp_load_acquire in binder_alloc_get_vma() */
+	smp_store_release(&alloc->vma, vma);
 }
 
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
@@ -394,6 +383,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	size_t size, data_offsets_size;
 	int ret;
 
+	/* Check binder_alloc is fully initialized */
 	if (!binder_alloc_get_vma(alloc)) {
 		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
 				   "%d: binder_alloc_buf, no vma\n",
@@ -789,6 +779,8 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 	buffer->free = 1;
 	binder_insert_free_buffer(alloc, buffer);
 	alloc->free_async_space = alloc->buffer_size / 2;
+
+	/* Signal binder_alloc is fully initialized */
 	binder_alloc_set_vma(alloc, vma);
 
 	return 0;
-- 
2.41.0.rc0.172.g3f132b7071-goog

