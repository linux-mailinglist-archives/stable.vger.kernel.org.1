Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8040C75D401
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjGUTQs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjGUTQr (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:16:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844DD1BF4
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:16:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A852D61D76
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA106C433C9;
        Fri, 21 Jul 2023 19:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967004;
        bh=a4PgXN//rlm5y+8RxnIoDDKJPqNpn3SX4h8K3CaHvik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qwg5VbpCr8Z23iVZmCX/cOUOE3u1KB5h9yEOXcR9aJFDdKmIuBvZOJxNip6+DJbpy
         xs6iJ00Mq/IzJXVpbX74UUr8WkIBR0reoWCTiaiSu8LiaLNsP9mtvZHt7MTGYPiQSW
         gABfNkJthoWRpQasSG7uSoCfyhEaM0uT2GL0S9lk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexey Kardashevskiy <aik@amd.com>,
        Pankaj Gupta <pankaj.gupta@amd.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 011/223] swiotlb: reduce the swiotlb buffer size on allocation failure
Date:   Fri, 21 Jul 2023 18:04:24 +0200
Message-ID: <20230721160521.356466644@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexey Kardashevskiy <aik@amd.com>

[ Upstream commit 8d58aa484920c4f9be4834a7aeb446cdced21a37 ]

At the moment the AMD encrypted platform reserves 6% of RAM for SWIOTLB
or 1GB, whichever is less. However it is possible that there is no block
big enough in the low memory which make SWIOTLB allocation fail and
the kernel continues without DMA. In such case a VM hangs on DMA.

This moves alloc+remap to a helper and calls it from a loop where
the size is halved on each iteration.

This updates default_nslabs on successful allocation which looks like
an oversight as not doing so should have broken callers of
swiotlb_size_or_default().

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Stable-dep-of: 8ac04063354a ("swiotlb: reduce the number of areas to match actual memory pool size")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/swiotlb.c | 63 +++++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 3961065412542..cc0c55ed20429 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -307,6 +307,37 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 	return;
 }
 
+static void *swiotlb_memblock_alloc(unsigned long nslabs, unsigned int flags,
+		int (*remap)(void *tlb, unsigned long nslabs))
+{
+	size_t bytes = PAGE_ALIGN(nslabs << IO_TLB_SHIFT);
+	void *tlb;
+
+	/*
+	 * By default allocate the bounce buffer memory from low memory, but
+	 * allow to pick a location everywhere for hypervisors with guest
+	 * memory encryption.
+	 */
+	if (flags & SWIOTLB_ANY)
+		tlb = memblock_alloc(bytes, PAGE_SIZE);
+	else
+		tlb = memblock_alloc_low(bytes, PAGE_SIZE);
+
+	if (!tlb) {
+		pr_warn("%s: Failed to allocate %zu bytes tlb structure\n",
+			__func__, bytes);
+		return NULL;
+	}
+
+	if (remap && remap(tlb, nslabs) < 0) {
+		memblock_free(tlb, PAGE_ALIGN(bytes));
+		pr_warn("%s: Failed to remap %zu bytes\n", __func__, bytes);
+		return NULL;
+	}
+
+	return tlb;
+}
+
 /*
  * Statically reserve bounce buffer space and initialize bounce buffer data
  * structures for the software IO TLB used to implement the DMA API.
@@ -317,7 +348,6 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	struct io_tlb_mem *mem = &io_tlb_default_mem;
 	unsigned long nslabs;
 	size_t alloc_size;
-	size_t bytes;
 	void *tlb;
 
 	if (!addressing_limit && !swiotlb_force_bounce)
@@ -329,31 +359,16 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 		swiotlb_adjust_nareas(num_possible_cpus());
 
 	nslabs = default_nslabs;
-	/*
-	 * By default allocate the bounce buffer memory from low memory, but
-	 * allow to pick a location everywhere for hypervisors with guest
-	 * memory encryption.
-	 */
-retry:
-	bytes = PAGE_ALIGN(nslabs << IO_TLB_SHIFT);
-	if (flags & SWIOTLB_ANY)
-		tlb = memblock_alloc(bytes, PAGE_SIZE);
-	else
-		tlb = memblock_alloc_low(bytes, PAGE_SIZE);
-	if (!tlb) {
-		pr_warn("%s: failed to allocate tlb structure\n", __func__);
-		return;
-	}
-
-	if (remap && remap(tlb, nslabs) < 0) {
-		memblock_free(tlb, PAGE_ALIGN(bytes));
-
+	while ((tlb = swiotlb_memblock_alloc(nslabs, flags, remap)) == NULL) {
+		if (nslabs <= IO_TLB_MIN_SLABS)
+			return;
 		nslabs = ALIGN(nslabs >> 1, IO_TLB_SEGSIZE);
-		if (nslabs >= IO_TLB_MIN_SLABS)
-			goto retry;
+	}
 
-		pr_warn("%s: Failed to remap %zu bytes\n", __func__, bytes);
-		return;
+	if (default_nslabs != nslabs) {
+		pr_info("SWIOTLB bounce buffer size adjusted %lu -> %lu slabs",
+			default_nslabs, nslabs);
+		default_nslabs = nslabs;
 	}
 
 	alloc_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), nslabs));
-- 
2.39.2



