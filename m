Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E827703745
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244014AbjEORTK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244020AbjEORSd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:18:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12B7DDAE
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:16:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BD6662BDD
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7ADC433D2;
        Mon, 15 May 2023 17:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171012;
        bh=YBYlm6vj409LhjO5PIPteA9rF87iOWsbzMuC2IpVG3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hxCavAAbAOEa6eJl2dWFk2XxSiGhCfGiA/o0O8poDOcbTHLGCUVWmMQyo53YE2d4l
         W0JXxRh2mYNEgVaChZXS1XpzCBfrjz5nPsO5c4PIF5aYPX986p1TRp9KpfpFcpG5DO
         xy2qHaGYQ6VAnyyZLq/BfkMCSPjAeMuig0EU42mE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Xin Long <lucien.xin@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        Coco Li <lixiaoyan@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 043/242] tcp: fix skb_copy_ubufs() vs BIG TCP
Date:   Mon, 15 May 2023 18:26:09 +0200
Message-Id: <20230515161723.209140527@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 7e692df3933628d974acb9f5b334d2b3e885e2a6 ]

David Ahern reported crashes in skb_copy_ubufs() caused by TCP tx zerocopy
using hugepages, and skb length bigger than ~68 KB.

skb_copy_ubufs() assumed it could copy all payload using up to
MAX_SKB_FRAGS order-0 pages.

This assumption broke when BIG TCP was able to put up to 512 KB per skb.

We did not hit this bug at Google because we use CONFIG_MAX_SKB_FRAGS=45
and limit gso_max_size to 180000.

A solution is to use higher order pages if needed.

v2: add missing __GFP_COMP, or we leak memory.

Fixes: 7c4e983c4f3c ("net: allow gso_max_size to exceed 65536")
Reported-by: David Ahern <dsahern@kernel.org>
Link: https://lore.kernel.org/netdev/c70000f6-baa4-4a05-46d0-4b3e0dc1ccc8@gmail.com/T/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Xin Long <lucien.xin@gmail.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Coco Li <lixiaoyan@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/skbuff.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6f5ef18a8b772..ef3dd8f120e02 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1608,7 +1608,7 @@ int skb_copy_ubufs(struct sk_buff *skb, gfp_t gfp_mask)
 {
 	int num_frags = skb_shinfo(skb)->nr_frags;
 	struct page *page, *head = NULL;
-	int i, new_frags;
+	int i, order, psize, new_frags;
 	u32 d_off;
 
 	if (skb_shared(skb) || skb_unclone(skb, gfp_mask))
@@ -1617,9 +1617,17 @@ int skb_copy_ubufs(struct sk_buff *skb, gfp_t gfp_mask)
 	if (!num_frags)
 		goto release;
 
-	new_frags = (__skb_pagelen(skb) + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	/* We might have to allocate high order pages, so compute what minimum
+	 * page order is needed.
+	 */
+	order = 0;
+	while ((PAGE_SIZE << order) * MAX_SKB_FRAGS < __skb_pagelen(skb))
+		order++;
+	psize = (PAGE_SIZE << order);
+
+	new_frags = (__skb_pagelen(skb) + psize - 1) >> (PAGE_SHIFT + order);
 	for (i = 0; i < new_frags; i++) {
-		page = alloc_page(gfp_mask);
+		page = alloc_pages(gfp_mask | __GFP_COMP, order);
 		if (!page) {
 			while (head) {
 				struct page *next = (struct page *)page_private(head);
@@ -1646,11 +1654,11 @@ int skb_copy_ubufs(struct sk_buff *skb, gfp_t gfp_mask)
 			vaddr = kmap_atomic(p);
 
 			while (done < p_len) {
-				if (d_off == PAGE_SIZE) {
+				if (d_off == psize) {
 					d_off = 0;
 					page = (struct page *)page_private(page);
 				}
-				copy = min_t(u32, PAGE_SIZE - d_off, p_len - done);
+				copy = min_t(u32, psize - d_off, p_len - done);
 				memcpy(page_address(page) + d_off,
 				       vaddr + p_off + done, copy);
 				done += copy;
@@ -1666,7 +1674,7 @@ int skb_copy_ubufs(struct sk_buff *skb, gfp_t gfp_mask)
 
 	/* skb frags point to kernel buffers */
 	for (i = 0; i < new_frags - 1; i++) {
-		__skb_fill_page_desc(skb, i, head, 0, PAGE_SIZE);
+		__skb_fill_page_desc(skb, i, head, 0, psize);
 		head = (struct page *)page_private(head);
 	}
 	__skb_fill_page_desc(skb, new_frags - 1, head, 0, d_off);
-- 
2.39.2



