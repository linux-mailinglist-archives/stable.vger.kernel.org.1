Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024356FA5E1
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbjEHKOG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbjEHKNw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:13:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61047398B9
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:13:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC8B962411
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C308C433EF;
        Mon,  8 May 2023 10:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540826;
        bh=H9unlz98DIanzKWniSP9FpZ8IfQzLvvsI0eyM9uGUqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XS90mPCnOou12BUWc7lR8nUe7+gMMsIYOIAL8Z3TgWoU20lPWJ4iSPucPrXbSDYIr
         8Su2XLNUh/BlKfz5NRuzhmpjj6Rc4y/Mry+9wcKCUPpsSJXO/Zqj2xWKPdcyTW55fK
         AzPaGmoyECsjDRDhKSFeSY2LaYc9JQBaDnjEw38c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 512/611] swiotlb: relocate PageHighMem test away from rmem_swiotlb_setup
Date:   Mon,  8 May 2023 11:45:54 +0200
Message-Id: <20230508094438.683759389@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Doug Berger <opendmb@gmail.com>

[ Upstream commit a90922fa25370902322e9de6640e58737d459a50 ]

The reservedmem_of_init_fn's are invoked very early at boot before the
memory zones have even been defined. This makes it inappropriate to test
whether the page corresponding to a PFN is in ZONE_HIGHMEM from within
one.

Removing the check allows an ARM 32-bit kernel with SPARSEMEM enabled to
boot properly since otherwise we would be de-referencing an
uninitialized sparsemem map to perform pfn_to_page() check.

The arm64 architecture happens to work (and also has no high memory) but
other 32-bit architectures could also be having similar issues.

While it would be nice to provide early feedback about a reserved DMA
pool residing in highmem, it is not possible to do that until the first
time we try to use it, which is where the check is moved to.

Fixes: 0b84e4f8b793 ("swiotlb: Add restricted DMA pool initialization")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/swiotlb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 339a990554e7f..bf1ed08ec541f 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -987,6 +987,11 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 	/* Set Per-device io tlb area to one */
 	unsigned int nareas = 1;
 
+	if (PageHighMem(pfn_to_page(PHYS_PFN(rmem->base)))) {
+		dev_err(dev, "Restricted DMA pool must be accessible within the linear mapping.");
+		return -EINVAL;
+	}
+
 	/*
 	 * Since multiple devices can share the same pool, the private data,
 	 * io_tlb_mem struct, will be initialized by the first device attached
@@ -1048,11 +1053,6 @@ static int __init rmem_swiotlb_setup(struct reserved_mem *rmem)
 	    of_get_flat_dt_prop(node, "no-map", NULL))
 		return -EINVAL;
 
-	if (PageHighMem(pfn_to_page(PHYS_PFN(rmem->base)))) {
-		pr_err("Restricted DMA pool must be accessible within the linear mapping.");
-		return -EINVAL;
-	}
-
 	rmem->ops = &rmem_swiotlb_ops;
 	pr_info("Reserved memory: created restricted DMA pool at %pa, size %ld MiB\n",
 		&rmem->base, (unsigned long)rmem->size / SZ_1M);
-- 
2.39.2



