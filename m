Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F31719E0F
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbjFAN2j (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbjFAN2U (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:28:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E14E7B
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:28:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 302FB644E4
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34145C433EF;
        Thu,  1 Jun 2023 13:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685626083;
        bh=pQ5AMwfN0f1HgZXJEDjsIOwVfRZs2m++UiXpxG5RUmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kE8U/ddPSV+7Nmk3ympUR+rvN9PcUDI5YPL75OU93HdyMwWZFLHgpI+nReiFJsgoA
         2HkOEvMzReBVuaSxU2ZixXM2JnBlBvEMHyJYyuPkHr/Sx1mn2deqXN98TWMSY4E/K9
         KMH9c7nRQ+ZjRl3L/kwEpQvy5Odcn7BnzqMSxjYc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Qingfang DENG <qingfang.deng@siflower.com.cn>,
        Felix Fietkau <nbd@nbd.name>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 24/42] net: page_pool: use in_softirq() instead
Date:   Thu,  1 Jun 2023 14:21:33 +0100
Message-Id: <20230601131940.103152438@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131939.051934720@linuxfoundation.org>
References: <20230601131939.051934720@linuxfoundation.org>
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

From: Qingfang DENG <qingfang.deng@siflower.com.cn>

[ Upstream commit 542bcea4be866b14b3a5c8e90773329066656c43 ]

We use BH context only for synchronization, so we don't care if it's
actually serving softirq or not.

As a side node, in case of threaded NAPI, in_serving_softirq() will
return false because it's in process context with BH off, making
page_pool_recycle_in_cache() unreachable.

Signed-off-by: Qingfang DENG <qingfang.deng@siflower.com.cn>
Tested-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 368d3cb406cd ("page_pool: fix inconsistency for page_pool_ring_[un]lock()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/page_pool.h | 4 ++--
 net/core/page_pool.c    | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index 813c93499f201..34bf531ffc8d6 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -386,7 +386,7 @@ static inline void page_pool_nid_changed(struct page_pool *pool, int new_nid)
 static inline void page_pool_ring_lock(struct page_pool *pool)
 	__acquires(&pool->ring.producer_lock)
 {
-	if (in_serving_softirq())
+	if (in_softirq())
 		spin_lock(&pool->ring.producer_lock);
 	else
 		spin_lock_bh(&pool->ring.producer_lock);
@@ -395,7 +395,7 @@ static inline void page_pool_ring_lock(struct page_pool *pool)
 static inline void page_pool_ring_unlock(struct page_pool *pool)
 	__releases(&pool->ring.producer_lock)
 {
-	if (in_serving_softirq())
+	if (in_softirq())
 		spin_unlock(&pool->ring.producer_lock);
 	else
 		spin_unlock_bh(&pool->ring.producer_lock);
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 9b203d8660e47..193c187998650 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -511,8 +511,8 @@ static void page_pool_return_page(struct page_pool *pool, struct page *page)
 static bool page_pool_recycle_in_ring(struct page_pool *pool, struct page *page)
 {
 	int ret;
-	/* BH protection not needed if current is serving softirq */
-	if (in_serving_softirq())
+	/* BH protection not needed if current is softirq */
+	if (in_softirq())
 		ret = ptr_ring_produce(&pool->ring, page);
 	else
 		ret = ptr_ring_produce_bh(&pool->ring, page);
@@ -570,7 +570,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
 			page_pool_dma_sync_for_device(pool, page,
 						      dma_sync_size);
 
-		if (allow_direct && in_serving_softirq() &&
+		if (allow_direct && in_softirq() &&
 		    page_pool_recycle_in_cache(page, pool))
 			return NULL;
 
-- 
2.39.2



