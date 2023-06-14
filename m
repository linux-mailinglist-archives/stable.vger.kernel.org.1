Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB31272C241
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237682AbjFLLDx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237551AbjFLLDa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:03:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EF27EE5
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:51:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A39CD6252C
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AADC433EF;
        Mon, 12 Jun 2023 10:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686567080;
        bh=5eYBm2bcki/A1vvT+UmJV2teb44iFs0AW5Vl0ny7UIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FGzuyJWkTt0Ex3w4W616pj7uqy/i5kD/g0CcQ9+LhNthJWrMUbpysiVX7U7wJ4zBz
         IHdqUG+F04jm+lp5AP5pUfo6qani1KGj5Sg25fbVN0looNuMnurkGAjw/WEek8oa3x
         uOUscy1+spXHNwJZk9I/FndSWNCLFEB6jEHSk2xo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.comm,
        Ruihan Li <lrh2000@pku.edu.cn>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 6.3 114/160] usb: usbfs: Enforce page requirements for mmap
Date:   Mon, 12 Jun 2023 12:27:26 +0200
Message-ID: <20230612101720.276160501@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Ruihan Li <lrh2000@pku.edu.cn>

commit 0143d148d1e882fb1538dc9974c94d63961719b9 upstream.

The current implementation of usbdev_mmap uses usb_alloc_coherent to
allocate memory pages that will later be mapped into the user space.
Meanwhile, usb_alloc_coherent employs three different methods to
allocate memory, as outlined below:
 * If hcd->localmem_pool is non-null, it uses gen_pool_dma_alloc to
   allocate memory;
 * If DMA is not available, it uses kmalloc to allocate memory;
 * Otherwise, it uses dma_alloc_coherent.

However, it should be noted that gen_pool_dma_alloc does not guarantee
that the resulting memory will be page-aligned. Furthermore, trying to
map slab pages (i.e., memory allocated by kmalloc) into the user space
is not resonable and can lead to problems, such as a type confusion bug
when PAGE_TABLE_CHECK=y [1].

To address these issues, this patch introduces hcd_alloc_coherent_pages,
which addresses the above two problems. Specifically,
hcd_alloc_coherent_pages uses gen_pool_dma_alloc_align instead of
gen_pool_dma_alloc to ensure that the memory is page-aligned. To replace
kmalloc, hcd_alloc_coherent_pages directly allocates pages by calling
__get_free_pages.

Reported-by: syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.comm
Closes: https://lore.kernel.org/lkml/000000000000258e5e05fae79fc1@google.com/ [1]
Fixes: f7d34b445abc ("USB: Add support for usbfs zerocopy.")
Fixes: ff2437befd8f ("usb: host: Fix excessive alignment restriction for local memory allocations")
Cc: stable@vger.kernel.org
Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20230515130958.32471-2-lrh2000@pku.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/buffer.c |   41 +++++++++++++++++++++++++++++++++++++++++
 drivers/usb/core/devio.c  |    9 +++++----
 include/linux/usb/hcd.h   |    5 +++++
 3 files changed, 51 insertions(+), 4 deletions(-)

--- a/drivers/usb/core/buffer.c
+++ b/drivers/usb/core/buffer.c
@@ -172,3 +172,44 @@ void hcd_buffer_free(
 	}
 	dma_free_coherent(hcd->self.sysdev, size, addr, dma);
 }
+
+void *hcd_buffer_alloc_pages(struct usb_hcd *hcd,
+		size_t size, gfp_t mem_flags, dma_addr_t *dma)
+{
+	if (size == 0)
+		return NULL;
+
+	if (hcd->localmem_pool)
+		return gen_pool_dma_alloc_align(hcd->localmem_pool,
+				size, dma, PAGE_SIZE);
+
+	/* some USB hosts just use PIO */
+	if (!hcd_uses_dma(hcd)) {
+		*dma = DMA_MAPPING_ERROR;
+		return (void *)__get_free_pages(mem_flags,
+				get_order(size));
+	}
+
+	return dma_alloc_coherent(hcd->self.sysdev,
+			size, dma, mem_flags);
+}
+
+void hcd_buffer_free_pages(struct usb_hcd *hcd,
+		size_t size, void *addr, dma_addr_t dma)
+{
+	if (!addr)
+		return;
+
+	if (hcd->localmem_pool) {
+		gen_pool_free(hcd->localmem_pool,
+				(unsigned long)addr, size);
+		return;
+	}
+
+	if (!hcd_uses_dma(hcd)) {
+		free_pages((unsigned long)addr, get_order(size));
+		return;
+	}
+
+	dma_free_coherent(hcd->self.sysdev, size, addr, dma);
+}
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -186,6 +186,7 @@ static int connected(struct usb_dev_stat
 static void dec_usb_memory_use_count(struct usb_memory *usbm, int *count)
 {
 	struct usb_dev_state *ps = usbm->ps;
+	struct usb_hcd *hcd = bus_to_hcd(ps->dev->bus);
 	unsigned long flags;
 
 	spin_lock_irqsave(&ps->lock, flags);
@@ -194,8 +195,8 @@ static void dec_usb_memory_use_count(str
 		list_del(&usbm->memlist);
 		spin_unlock_irqrestore(&ps->lock, flags);
 
-		usb_free_coherent(ps->dev, usbm->size, usbm->mem,
-				usbm->dma_handle);
+		hcd_buffer_free_pages(hcd, usbm->size,
+				usbm->mem, usbm->dma_handle);
 		usbfs_decrease_memory_usage(
 			usbm->size + sizeof(struct usb_memory));
 		kfree(usbm);
@@ -247,8 +248,8 @@ static int usbdev_mmap(struct file *file
 		goto error_decrease_mem;
 	}
 
-	mem = usb_alloc_coherent(ps->dev, size, GFP_USER | __GFP_NOWARN,
-			&dma_handle);
+	mem = hcd_buffer_alloc_pages(hcd,
+			size, GFP_USER | __GFP_NOWARN, &dma_handle);
 	if (!mem) {
 		ret = -ENOMEM;
 		goto error_free_usbm;
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -503,6 +503,11 @@ void *hcd_buffer_alloc(struct usb_bus *b
 void hcd_buffer_free(struct usb_bus *bus, size_t size,
 	void *addr, dma_addr_t dma);
 
+void *hcd_buffer_alloc_pages(struct usb_hcd *hcd,
+		size_t size, gfp_t mem_flags, dma_addr_t *dma);
+void hcd_buffer_free_pages(struct usb_hcd *hcd,
+		size_t size, void *addr, dma_addr_t dma);
+
 /* generic bus glue, needed for host controllers that don't use PCI */
 extern irqreturn_t usb_hcd_irq(int irq, void *__hcd);
 


