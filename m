Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FE6713AD6
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 18:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjE1Qzw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 12:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjE1Qzv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 12:55:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614C2BE
        for <stable@vger.kernel.org>; Sun, 28 May 2023 09:55:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7D0761157
        for <stable@vger.kernel.org>; Sun, 28 May 2023 16:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3DA8C4339B;
        Sun, 28 May 2023 16:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685292949;
        bh=gDT6MW//FGPnGUouHD+7wxJDsygzkxZ3GZb8bMx86Hs=;
        h=Subject:To:Cc:From:Date:From;
        b=pyDzCNIeNSQSqkcUtm6gQSg9S6g1fowZuoV/x9TJ0Jk2pDfpOGbltwZqMVtvt4yFM
         RRfX+UKpDsUA9D0msFAGPhBbssSW75K3rmXYvYFWuEWkOlM5dyUYCxYwhjzg23CuEQ
         o8uX97jAIa3Wjno0A7W4rd+O1FKVzv0A7BXVtwZY=
Subject: FAILED: patch "[PATCH] page_pool: fix inconsistency for page_pool_ring_[un]lock()" failed to apply to 5.15-stable tree
To:     linyunsheng@huawei.com, brouer@redhat.com,
        ilias.apalodimas@linaro.org, kuba@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 17:55:22 +0100
Message-ID: <2023052821-wired-primate-24c3@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 368d3cb406cdd074d1df2ad9ec06d1bfcb664882
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052821-wired-primate-24c3@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

368d3cb406cd ("page_pool: fix inconsistency for page_pool_ring_[un]lock()")
542bcea4be86 ("net: page_pool: use in_softirq() instead")
590032a4d213 ("page_pool: Add recycle stats to page_pool_put_page_bulk")
6b95e3388b1e ("page_pool: Add function to batch and return stats")
ad6fa1e1ab1b ("page_pool: Add recycle stats")
8610037e8106 ("page_pool: Add allocation stats")
64693ec7774e ("page_pool: Store the XDP mem id")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 368d3cb406cdd074d1df2ad9ec06d1bfcb664882 Mon Sep 17 00:00:00 2001
From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Mon, 22 May 2023 11:17:14 +0800
Subject: [PATCH] page_pool: fix inconsistency for page_pool_ring_[un]lock()

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

diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index c8ec2f34722b..126f9e294389 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -399,22 +399,4 @@ static inline void page_pool_nid_changed(struct page_pool *pool, int new_nid)
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
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index e212e9d7edcb..a3e12a61d456 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -134,6 +134,29 @@ EXPORT_SYMBOL(page_pool_ethtool_stats_get);
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
@@ -617,6 +640,7 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 			     int count)
 {
 	int i, bulk_len = 0;
+	bool in_softirq;
 
 	for (i = 0; i < count; i++) {
 		struct page *page = virt_to_head_page(data[i]);
@@ -635,7 +659,7 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 		return;
 
 	/* Bulk producer into ptr_ring page_pool cache */
-	page_pool_ring_lock(pool);
+	in_softirq = page_pool_producer_lock(pool);
 	for (i = 0; i < bulk_len; i++) {
 		if (__ptr_ring_produce(&pool->ring, data[i])) {
 			/* ring full */
@@ -644,7 +668,7 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 		}
 	}
 	recycle_stat_add(pool, ring, i);
-	page_pool_ring_unlock(pool);
+	page_pool_producer_unlock(pool, in_softirq);
 
 	/* Hopefully all pages was return into ptr_ring */
 	if (likely(i == bulk_len))

