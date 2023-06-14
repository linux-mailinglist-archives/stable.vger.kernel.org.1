Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4D972C11E
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbjFLK41 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235716AbjFLK4N (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:56:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81719526C
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:43:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1222D616EF
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24ABDC433EF;
        Mon, 12 Jun 2023 10:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566631;
        bh=8VrfnGZ1rfHOZ/yFldYrKcKJSmi/In6gdkVhTRolang=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=om6G0yua1agwOnxxxJcchLUdXJ6bY6eYLufc6ZItM29sOzxlRstO0gix4rKiULEyy
         Y+liuJaF/4F+e4gEHV/+GDrw1hyaOKgdVqY4KTPaOiiMJThdtIdLmwjh14wX6+lwVJ
         h9UkHrXV0AVzYD9/+smA99BcOur3A23X+e76VRmo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ruihan Li <lrh2000@pku.edu.cn>
Subject: [PATCH 6.1 098/132] usb: usbfs: Use consistent mmap functions
Date:   Mon, 12 Jun 2023 12:27:12 +0200
Message-ID: <20230612101714.776821366@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
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

commit d0b861653f8c16839c3035875b556afc4472f941 upstream.

When hcd->localmem_pool is non-null, localmem_pool is used to allocate
DMA memory. In this case, the dma address will be properly returned (in
dma_handle), and dma_mmap_coherent should be used to map this memory
into the user space. However, the current implementation uses
pfn_remap_range, which is supposed to map normal pages.

Instead of repeating the logic in the memory allocation function, this
patch introduces a more robust solution. Here, the type of allocated
memory is checked by testing whether dma_handle is properly set. If
dma_handle is properly returned, it means some DMA pages are allocated
and dma_mmap_coherent should be used to map them. Otherwise, normal
pages are allocated and pfn_remap_range should be called. This ensures
that the correct mmap functions are used consistently, independently
with logic details that determine which type of memory gets allocated.

Fixes: a0e710a7def4 ("USB: usbfs: fix mmap dma mismatch")
Cc: stable@vger.kernel.org
Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
Link: https://lore.kernel.org/r/20230515130958.32471-3-lrh2000@pku.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/devio.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -235,7 +235,7 @@ static int usbdev_mmap(struct file *file
 	size_t size = vma->vm_end - vma->vm_start;
 	void *mem;
 	unsigned long flags;
-	dma_addr_t dma_handle;
+	dma_addr_t dma_handle = DMA_MAPPING_ERROR;
 	int ret;
 
 	ret = usbfs_increase_memory_usage(size + sizeof(struct usb_memory));
@@ -265,7 +265,14 @@ static int usbdev_mmap(struct file *file
 	usbm->vma_use_count = 1;
 	INIT_LIST_HEAD(&usbm->memlist);
 
-	if (hcd->localmem_pool || !hcd_uses_dma(hcd)) {
+	/*
+	 * In DMA-unavailable cases, hcd_buffer_alloc_pages allocates
+	 * normal pages and assigns DMA_MAPPING_ERROR to dma_handle. Check
+	 * whether we are in such cases, and then use remap_pfn_range (or
+	 * dma_mmap_coherent) to map normal (or DMA) pages into the user
+	 * space, respectively.
+	 */
+	if (dma_handle == DMA_MAPPING_ERROR) {
 		if (remap_pfn_range(vma, vma->vm_start,
 				    virt_to_phys(usbm->mem) >> PAGE_SHIFT,
 				    size, vma->vm_page_prot) < 0) {


