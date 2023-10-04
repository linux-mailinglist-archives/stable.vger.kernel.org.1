Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAB77B89B6
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244246AbjJDS2a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244255AbjJDS23 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:28:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC0A9E
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:28:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEFBC433C8;
        Wed,  4 Oct 2023 18:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444106;
        bh=Aq9gmMySOJ7iOV1eQy/YJjJ2h+G2oH1kQQ466eE85Yg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bx9DtbLoz0aUIDRVUzMN5PtCWV7L3waLrSgcwCIxyKKe0IDl0yX0HI46fyrEeA3pe
         SxtsbClDf8E+QQfkPZssItWy/sQ2X2Vbg9kvewqRI1uHrYClVnoyng1TNHpMwz711m
         c3DvlDT98VNK97apLFvRWYjCagxSuYFRfwjnz0po=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 133/321] swiotlb: use the calculated number of areas
Date:   Wed,  4 Oct 2023 19:54:38 +0200
Message-ID: <20231004175235.399448039@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ross Lagerwall <ross.lagerwall@citrix.com>

[ Upstream commit a6a241764f69c62d23fc6960920cc662ae4069e9 ]

Commit 8ac04063354a ("swiotlb: reduce the number of areas to match
actual memory pool size") calculated the reduced number of areas in
swiotlb_init_remap() but didn't actually use the value. Replace usage of
default_nareas accordingly.

Fixes: 8ac04063354a ("swiotlb: reduce the number of areas to match actual memory pool size")
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/swiotlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 2b83e3ad9dca1..aa0a4a220719a 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -350,14 +350,14 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	}
 
 	mem->areas = memblock_alloc(array_size(sizeof(struct io_tlb_area),
-		default_nareas), SMP_CACHE_BYTES);
+		nareas), SMP_CACHE_BYTES);
 	if (!mem->areas) {
 		pr_warn("%s: Failed to allocate mem->areas.\n", __func__);
 		return;
 	}
 
 	swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, flags, false,
-				default_nareas);
+				nareas);
 
 	if (flags & SWIOTLB_VERBOSE)
 		swiotlb_print_info();
-- 
2.40.1



