Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4ECB75D402
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjGUTQv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjGUTQu (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:16:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EC630F1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:16:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 645C961D7F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752E5C433C8;
        Fri, 21 Jul 2023 19:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967006;
        bh=I3O+u2ID4nlzmr8kaoxZOdL0uKc+BNvrS4PvIqd6RoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B8YRRAjSbDYnLqLYRlgpseALgks6E/swFyzmOF/GHA7XJHA3NMzGVhOxyNWIsdYHO
         uDKmdDaQ9xppROdw1tdCnWqjFK6rvoQCX2CGu2zHu+3KGqN6q4bM+ZAAs6tMFzoUtc
         GdyGut/VUee8ldXr+IblWPIxAHm/gl0BJf0D+5qA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 012/223] swiotlb: reduce the number of areas to match actual memory pool size
Date:   Fri, 21 Jul 2023 18:04:25 +0200
Message-ID: <20230721160521.398600483@linuxfoundation.org>
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

From: Petr Tesarik <petr.tesarik.ext@huawei.com>

[ Upstream commit 8ac04063354a01a484d2e55d20ed1958aa0d3392 ]

Although the desired size of the SWIOTLB memory pool is increased in
swiotlb_adjust_nareas() to match the number of areas, the actual allocation
may be smaller, which may require reducing the number of areas.

For example, Xen uses swiotlb_init_late(), which in turn uses the page
allocator. On x86, page size is 4 KiB and MAX_ORDER is 10 (1024 pages),
resulting in a maximum memory pool size of 4 MiB. This corresponds to 2048
slots of 2 KiB each. The minimum area size is 128 (IO_TLB_SEGSIZE),
allowing at most 2048 / 128 = 16 areas.

If num_possible_cpus() is greater than the maximum number of areas, areas
are smaller than IO_TLB_SEGSIZE and contiguous groups of free slots will
span multiple areas. When allocating and freeing slots, only one area will
be properly locked, causing race conditions on the unlocked slots and
ultimately data corruption, kernel hangs and crashes.

Fixes: 20347fca71a3 ("swiotlb: split up the global swiotlb lock")
Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/swiotlb.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index cc0c55ed20429..491d3c86c2280 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -140,6 +140,23 @@ static void swiotlb_adjust_nareas(unsigned int nareas)
 			(default_nslabs << IO_TLB_SHIFT) >> 20);
 }
 
+/**
+ * limit_nareas() - get the maximum number of areas for a given memory pool size
+ * @nareas:	Desired number of areas.
+ * @nslots:	Total number of slots in the memory pool.
+ *
+ * Limit the number of areas to the maximum possible number of areas in
+ * a memory pool of the given size.
+ *
+ * Return: Maximum possible number of areas.
+ */
+static unsigned int limit_nareas(unsigned int nareas, unsigned long nslots)
+{
+	if (nslots < nareas * IO_TLB_SEGSIZE)
+		return nslots / IO_TLB_SEGSIZE;
+	return nareas;
+}
+
 static int __init
 setup_io_tlb_npages(char *str)
 {
@@ -347,6 +364,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 {
 	struct io_tlb_mem *mem = &io_tlb_default_mem;
 	unsigned long nslabs;
+	unsigned int nareas;
 	size_t alloc_size;
 	void *tlb;
 
@@ -359,10 +377,12 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 		swiotlb_adjust_nareas(num_possible_cpus());
 
 	nslabs = default_nslabs;
+	nareas = limit_nareas(default_nareas, nslabs);
 	while ((tlb = swiotlb_memblock_alloc(nslabs, flags, remap)) == NULL) {
 		if (nslabs <= IO_TLB_MIN_SLABS)
 			return;
 		nslabs = ALIGN(nslabs >> 1, IO_TLB_SEGSIZE);
+		nareas = limit_nareas(nareas, nslabs);
 	}
 
 	if (default_nslabs != nslabs) {
@@ -408,6 +428,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 {
 	struct io_tlb_mem *mem = &io_tlb_default_mem;
 	unsigned long nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
+	unsigned int nareas;
 	unsigned char *vstart = NULL;
 	unsigned int order, area_order;
 	bool retried = false;
@@ -453,8 +474,8 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 			(PAGE_SIZE << order) >> 20);
 	}
 
-	area_order = get_order(array_size(sizeof(*mem->areas),
-		default_nareas));
+	nareas = limit_nareas(default_nareas, nslabs);
+	area_order = get_order(array_size(sizeof(*mem->areas), nareas));
 	mem->areas = (struct io_tlb_area *)
 		__get_free_pages(GFP_KERNEL | __GFP_ZERO, area_order);
 	if (!mem->areas)
@@ -468,7 +489,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	set_memory_decrypted((unsigned long)vstart,
 			     (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
 	swiotlb_init_io_tlb_mem(mem, virt_to_phys(vstart), nslabs, 0, true,
-				default_nareas);
+				nareas);
 
 	swiotlb_print_info();
 	return 0;
-- 
2.39.2



