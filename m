Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95ABD73531D
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjFSKlm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjFSKlb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:41:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF861BE
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:41:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 737AB60B7F
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D444C433C8;
        Mon, 19 Jun 2023 10:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171289;
        bh=dGrqX5L8WiOq02ann3SFdrcLL+pFWgZRZorwYCf07rk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WVnSDi6kM6kT9xG+O+dHYsSTP3a/jocLbou3qAJzdW6ake3Xo78yTouH2WLbnZ7qq
         IqUF2pAO0Ar31cAprt8PGTg1MkuQsIyYP7v3lHn/UV957oHPW4jdrw/iplqzOQRJKl
         +2iKwzNbfz815GRSIBEnJj1KRJj9Tce5htsOSLiI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Helge Deller <deller@gmx.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 08/49] parisc: Improve cache flushing for PCXL in arch_sync_dma_for_cpu()
Date:   Mon, 19 Jun 2023 12:29:46 +0200
Message-ID: <20230619102130.294527793@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102129.856988902@linuxfoundation.org>
References: <20230619102129.856988902@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Helge Deller <deller@gmx.de>

[ Upstream commit 59fa12646d9f56c842b4d5b6418ed77af625c588 ]

Add comment in arch_sync_dma_for_device() and handle the direction flag in
arch_sync_dma_for_cpu().

When receiving data from the device (DMA_FROM_DEVICE) unconditionally
purge the data cache in arch_sync_dma_for_cpu().

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/parisc/kernel/pci-dma.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
index 04c48f1ef3fbd..20084336704fc 100644
--- a/arch/parisc/kernel/pci-dma.c
+++ b/arch/parisc/kernel/pci-dma.c
@@ -464,13 +464,29 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
 		size_t size, enum dma_data_direction dir)
 {
+	/*
+	 * fdc: The data cache line is written back to memory, if and only if
+	 * it is dirty, and then invalidated from the data cache.
+	 */
 	flush_kernel_dcache_range((unsigned long)phys_to_virt(paddr), size);
 }
 
 void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
 		size_t size, enum dma_data_direction dir)
 {
-	flush_kernel_dcache_range((unsigned long)phys_to_virt(paddr), size);
+	unsigned long addr = (unsigned long) phys_to_virt(paddr);
+
+	switch (dir) {
+	case DMA_TO_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		flush_kernel_dcache_range(addr, size);
+		return;
+	case DMA_FROM_DEVICE:
+		purge_kernel_dcache_range_asm(addr, addr + size);
+		return;
+	default:
+		BUG();
+	}
 }
 
 void arch_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-- 
2.39.2



