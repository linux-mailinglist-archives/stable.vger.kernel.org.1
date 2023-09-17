Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0617A3A78
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240368AbjIQUEv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240365AbjIQUE3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:04:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A07B97
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:04:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B536EC433C7;
        Sun, 17 Sep 2023 20:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981064;
        bh=+aKeu1gdyAA4axKXCjIL8fQugs5Vionc2qXBfwyWeZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JiQ+A8bZtF/J85jK9Lz6CBoRWx3ND8oOKFgiEP83pvQ+2MUe3oMprczi9liHsqtml
         zXp92LBBX8vnBsY9LpBGXY/Fo+fQwDuM4B03i1vvliM1wuqehYN9OOhbjys/R8tJGy
         uteQmy4tYjryEpxkkV922u4eKr052FIYUAEH2zso=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Ajay Kaher <akaher@vmware.com>
Subject: [PATCH 6.1 052/219] net: add SKB_HEAD_ALIGN() helper
Date:   Sun, 17 Sep 2023 21:12:59 +0200
Message-ID: <20230917191042.884108341@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 115f1a5c42bdad9a9ea356fc0b4a39ec7537947f upstream.

We have many places using this expression:

 SKB_DATA_ALIGN(sizeof(struct skb_shared_info))

Use of SKB_HEAD_ALIGN() will allow to clean them.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[Ajay: Regenerated the patch for v6.1.y]
Signed-off-by: Ajay Kaher <akaher@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/skbuff.h |    8 ++++++++
 net/core/skbuff.c      |   18 ++++++------------
 2 files changed, 14 insertions(+), 12 deletions(-)

--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -261,6 +261,14 @@
 #define SKB_DATA_ALIGN(X)	ALIGN(X, SMP_CACHE_BYTES)
 #define SKB_WITH_OVERHEAD(X)	\
 	((X) - SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
+
+/* For X bytes available in skb->head, what is the minimal
+ * allocation needed, knowing struct skb_shared_info needs
+ * to be aligned.
+ */
+#define SKB_HEAD_ALIGN(X) (SKB_DATA_ALIGN(X) + \
+	SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
+
 #define SKB_MAX_ORDER(X, ORDER) \
 	SKB_WITH_OVERHEAD((PAGE_SIZE << (ORDER)) - (X))
 #define SKB_MAX_HEAD(X)		(SKB_MAX_ORDER((X), 0))
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -504,8 +504,7 @@ struct sk_buff *__alloc_skb(unsigned int
 	 * aligned memory blocks, unless SLUB/SLAB debug is enabled.
 	 * Both skb->head and skb_shared_info are cache line aligned.
 	 */
-	size = SKB_DATA_ALIGN(size);
-	size += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	size = SKB_HEAD_ALIGN(size);
 	osize = kmalloc_size_roundup(size);
 	data = kmalloc_reserve(osize, gfp_mask, node, &pfmemalloc);
 	if (unlikely(!data))
@@ -578,8 +577,7 @@ struct sk_buff *__netdev_alloc_skb(struc
 		goto skb_success;
 	}
 
-	len += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-	len = SKB_DATA_ALIGN(len);
+	len = SKB_HEAD_ALIGN(len);
 
 	if (sk_memalloc_socks())
 		gfp_mask |= __GFP_MEMALLOC;
@@ -678,8 +676,7 @@ struct sk_buff *__napi_alloc_skb(struct
 		data = page_frag_alloc_1k(&nc->page_small, gfp_mask);
 		pfmemalloc = NAPI_SMALL_PAGE_PFMEMALLOC(nc->page_small);
 	} else {
-		len += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-		len = SKB_DATA_ALIGN(len);
+		len = SKB_HEAD_ALIGN(len);
 
 		data = page_frag_alloc(&nc->page, len, gfp_mask);
 		pfmemalloc = nc->page.pfmemalloc;
@@ -1837,8 +1834,7 @@ int pskb_expand_head(struct sk_buff *skb
 	if (skb_pfmemalloc(skb))
 		gfp_mask |= __GFP_MEMALLOC;
 
-	size = SKB_DATA_ALIGN(size);
-	size += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	size = SKB_HEAD_ALIGN(size);
 	size = kmalloc_size_roundup(size);
 	data = kmalloc_reserve(size, gfp_mask, NUMA_NO_NODE, NULL);
 	if (!data)
@@ -6204,8 +6200,7 @@ static int pskb_carve_inside_header(stru
 	if (skb_pfmemalloc(skb))
 		gfp_mask |= __GFP_MEMALLOC;
 
-	size = SKB_DATA_ALIGN(size);
-	size += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	size = SKB_HEAD_ALIGN(size);
 	size = kmalloc_size_roundup(size);
 	data = kmalloc_reserve(size, gfp_mask, NUMA_NO_NODE, NULL);
 	if (!data)
@@ -6323,8 +6318,7 @@ static int pskb_carve_inside_nonlinear(s
 	if (skb_pfmemalloc(skb))
 		gfp_mask |= __GFP_MEMALLOC;
 
-	size = SKB_DATA_ALIGN(size);
-	size += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	size = SKB_HEAD_ALIGN(size);
 	size = kmalloc_size_roundup(size);
 	data = kmalloc_reserve(size, gfp_mask, NUMA_NO_NODE, NULL);
 	if (!data)


