Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C689B713DA0
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjE1T1a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjE1T10 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:27:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCA1BB;
        Sun, 28 May 2023 12:27:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AEAA61C5E;
        Sun, 28 May 2023 19:27:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A3CC433D2;
        Sun, 28 May 2023 19:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302037;
        bh=zat9A3bkxgnPlqSAEL/uUU/TRoUcHrfCv3PHsXPcp9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vb5KpvZxjow6q5KagjY9Y5utXaQpj4AM0CGC3fD6DzR9o+xYzoCTF0b5uujIhgGhz
         Rn6il2vWRqMBNBkdlYxnzTYAjQg8kIyUuym7Ai6JI8R8Gpk7GM4FsjaUTm7J7hBlsz
         bFBfqWy8JjBTNQ9RummFA+UdvVLdPsEdekyld7fQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-parisc@vger.kernel.org,
        Helge Deller <deller@gmx.de>, stable@kernel.org
Subject: [PATCH 5.4 136/161] parisc: Fix flush_dcache_page() for usage from irq context
Date:   Sun, 28 May 2023 20:11:00 +0100
Message-Id: <20230528190841.290607543@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
References: <20230528190837.051205996@linuxfoundation.org>
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

From: Helge Deller <deller@gmx.de>

commit 61e150fb310729c98227a5edf6e4a3619edc3702 upstream.

Since at least kernel 6.1, flush_dcache_page() is called with IRQs
disabled, e.g. from aio_complete().

But the current implementation for flush_dcache_page() on parisc
unintentionally re-enables IRQs, which may lead to deadlocks.

Fix it by using xa_lock_irqsave() and xa_unlock_irqrestore()
for the flush_dcache_mmap_*lock() macros instead.

Cc: linux-parisc@vger.kernel.org
Cc: stable@kernel.org # 5.18+
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/include/asm/cacheflush.h |    5 +++++
 arch/parisc/kernel/cache.c           |    5 +++--
 2 files changed, 8 insertions(+), 2 deletions(-)

--- a/arch/parisc/include/asm/cacheflush.h
+++ b/arch/parisc/include/asm/cacheflush.h
@@ -57,6 +57,11 @@ extern void flush_dcache_page(struct pag
 
 #define flush_dcache_mmap_lock(mapping)		xa_lock_irq(&mapping->i_pages)
 #define flush_dcache_mmap_unlock(mapping)	xa_unlock_irq(&mapping->i_pages)
+#define flush_dcache_mmap_lock_irqsave(mapping, flags)		\
+		xa_lock_irqsave(&mapping->i_pages, flags)
+#define flush_dcache_mmap_unlock_irqrestore(mapping, flags)	\
+		xa_unlock_irqrestore(&mapping->i_pages, flags)
+
 
 #define flush_icache_page(vma,page)	do { 		\
 	flush_kernel_dcache_page(page);			\
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -328,6 +328,7 @@ void flush_dcache_page(struct page *page
 	struct vm_area_struct *mpnt;
 	unsigned long offset;
 	unsigned long addr, old_addr = 0;
+	unsigned long flags;
 	pgoff_t pgoff;
 
 	if (mapping && !mapping_mapped(mapping)) {
@@ -347,7 +348,7 @@ void flush_dcache_page(struct page *page
 	 * declared as MAP_PRIVATE or MAP_SHARED), so we only need
 	 * to flush one address here for them all to become coherent */
 
-	flush_dcache_mmap_lock(mapping);
+	flush_dcache_mmap_lock_irqsave(mapping, flags);
 	vma_interval_tree_foreach(mpnt, &mapping->i_mmap, pgoff, pgoff) {
 		offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
 		addr = mpnt->vm_start + offset;
@@ -370,7 +371,7 @@ void flush_dcache_page(struct page *page
 			old_addr = addr;
 		}
 	}
-	flush_dcache_mmap_unlock(mapping);
+	flush_dcache_mmap_unlock_irqrestore(mapping, flags);
 }
 EXPORT_SYMBOL(flush_dcache_page);
 


