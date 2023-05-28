Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F111713E48
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjE1TeC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjE1TeB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:34:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B142B1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:34:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 392FE61DD8
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:34:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569BFC4339B;
        Sun, 28 May 2023 19:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302439;
        bh=8k+fTw8xakNgoxNYLQHVzl6u0c2BuK0tzlk9eHIawps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BI68YTc4fZ+nXzEONViFXXV2HlRFtkInu3dvWFXWEcb7M2IJ43MsDt54/hYqIN14u
         cVit7L6aKB0U7i5PwaCKyQ0+b3hgxIBIHuow4nFHowIDzhd39VLfYEO7JpyJnI10kE
         OqloE8hQ9JzzpPEJRuffPW06zFprdv8B9nBOMGE0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yunsheng Lin <linyunsheng@huawei.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.3 124/127] page_pool: fix inconsistency for page_pool_ring_[un]lock()
Date:   Sun, 28 May 2023 20:11:40 +0100
Message-Id: <20230528190840.272853078@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
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

From: Yunsheng Lin <linyunsheng@huawei.com>

commit 368d3cb406cdd074d1df2ad9ec06d1bfcb664882 upstream.

page_pool_ring_[un]lock() use in_softirq() to decide which
spin lock variant to use, and when they are called in the
context with in_softirq() being false, spin_lock_bh() is
called in page_pool_ring_lock() while spin_unlock() is
called in page_pool_ring_unlock(), because spin_lock_bh()
has disabled the softirq in page_pool_ring_lock(), which
causes inconsistency for spin lock pair calling.

This patch fixes it by returning in_softirq state from
page_pool_producer_lock(), and use it to decide which
spin lock variant to use in page_pool_producer_unlock().

As pool->ring has both producer and consumer lock, so
rename it to page_pool_producer_[un]lock() to reflect
the actual usage. Also move them to page_pool.c as they
are only used there, and remove the 'inline' as the
compiler may have better idea to do inlining or not.

Fixes: 7886244736a4 ("net: page_pool: Add bulk support for ptr_ring")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Link: https://lore.kernel.org/r/20230522031714.5089-1-linyunsheng@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/page_pool.h |   18 ------------------
 net/core/page_pool.c    |   28 ++++++++++++++++++++++++++--
 2 files changed, 26 insertions(+), 20 deletions(-)

--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -393,22 +393,4 @@ static inline void page_pool_nid_changed
 		page_pool_update_nid(pool, new_nid);
 }
 
-static inline void page_pool_ring_lock(struct page_pool *pool)
-	__acquires(&pool->ring.producer_lock)
-{
-	if (in_softirq())
-		spin_lock(&pool->ring.producer_lock);
-	else
-		spin_lock_bh(&pool->ring.producer_lock);
-}
-
-static inline void page_pool_ring_unlock(struct page_pool *pool)
-	__releases(&pool->ring.producer_lock)
-{
-	if (in_softirq())
-		spin_unlock(&pool->ring.producer_lock);
-	else
-		spin_unlock_bh(&pool->ring.producer_lock);
-}
-
 #endif /* _NET_PAGE_POOL_H */
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -133,6 +133,29 @@ EXPORT_SYMBOL(page_pool_ethtool_stats_ge
 #define recycle_stat_add(pool, __stat, val)
 #endif
 
+static bool page_pool_producer_lock(struct page_pool *pool)
+	__acquires(&pool->ring.producer_lock)
+{
+	bool in_softirq = in_softirq();
+
+	if (in_softirq)
+		spin_lock(&pool->ring.producer_lock);
+	else
+		spin_lock_bh(&pool->ring.producer_lock);
+
+	return in_softirq;
+}
+
+static void page_pool_producer_unlock(struct page_pool *pool,
+				      bool in_softirq)
+	__releases(&pool->ring.producer_lock)
+{
+	if (in_softirq)
+		spin_unlock(&pool->ring.producer_lock);
+	else
+		spin_unlock_bh(&pool->ring.producer_lock);
+}
+
 static int page_pool_init(struct page_pool *pool,
 			  const struct page_pool_params *params)
 {
@@ -615,6 +638,7 @@ void page_pool_put_page_bulk(struct page
 			     int count)
 {
 	int i, bulk_len = 0;
+	bool in_softirq;
 
 	for (i = 0; i < count; i++) {
 		struct page *page = virt_to_head_page(data[i]);
@@ -633,7 +657,7 @@ void page_pool_put_page_bulk(struct page
 		return;
 
 	/* Bulk producer into ptr_ring page_pool cache */
-	page_pool_ring_lock(pool);
+	in_softirq = page_pool_producer_lock(pool);
 	for (i = 0; i < bulk_len; i++) {
 		if (__ptr_ring_produce(&pool->ring, data[i])) {
 			/* ring full */
@@ -642,7 +666,7 @@ void page_pool_put_page_bulk(struct page
 		}
 	}
 	recycle_stat_add(pool, ring, i);
-	page_pool_ring_unlock(pool);
+	page_pool_producer_unlock(pool, in_softirq);
 
 	/* Hopefully all pages was return into ptr_ring */
 	if (likely(i == bulk_len))


