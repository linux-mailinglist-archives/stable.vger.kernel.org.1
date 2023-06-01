Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52613719DB9
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbjFAN0D (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbjFANZn (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:25:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E62E7E
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:25:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB77764484
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74DDC433D2;
        Thu,  1 Jun 2023 13:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625921;
        bh=F6e+tRtPck4CiqDKOP1ijt0erdJztUWmRMHwr4X4fXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dfyI0Jzp3k+nr58HF+0L97LVR5VWWo4IWttluOqZj1Eoql4GLNq99GzHth4YoutZ+
         9uelo6MB1vhokPHZfdrvDch+N/mjb1DfpEL2pYDzSCMdgbDGv6HLM8f4upbOXUvguo
         HOJ/EVLvWqiE0uoX6e7nn2giHBSI5Lguhx7+OePM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Liam Howlett <liam.howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Carlos Llamas <cmllamas@google.com>
Subject: [PATCH 5.15 39/42] binder: add lockless binder_alloc_(set|get)_vma()
Date:   Thu,  1 Jun 2023 14:21:26 +0100
Message-Id: <20230601131938.459836957@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131936.699199833@linuxfoundation.org>
References: <20230601131936.699199833@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Carlos Llamas <cmllamas@google.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/android/binder_alloc.c |   22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -309,29 +309,18 @@ err_no_vma:
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
@@ -394,6 +383,7 @@ static struct binder_buffer *binder_allo
 	size_t size, data_offsets_size;
 	int ret;
 
+	/* Check binder_alloc is fully initialized */
 	if (!binder_alloc_get_vma(alloc)) {
 		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
 				   "%d: binder_alloc_buf, no vma\n",
@@ -789,6 +779,8 @@ int binder_alloc_mmap_handler(struct bin
 	buffer->free = 1;
 	binder_insert_free_buffer(alloc, buffer);
 	alloc->free_async_space = alloc->buffer_size / 2;
+
+	/* Signal binder_alloc is fully initialized */
 	binder_alloc_set_vma(alloc, vma);
 
 	return 0;


