Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9D07ECDCB
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbjKOTi3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbjKOTi2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:38:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5499E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:38:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF92C433CC;
        Wed, 15 Nov 2023 19:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077105;
        bh=Ij6/gHl4Jo2LNnCymwtc0eHwrsK4zE7B43SwRFd4zOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rNE7+NHjxBD+YNKn1xLlVLKJVgkvHnHLzcC9lqwuzAgvLM5qZGJgT9bW5wK+aiP/S
         AiR9Qy9sXgEHkveBpDayqTgXWv9n/aCXnto1QeofqHkONkvaN1YrJiFGXrsgrWCXGH
         3MzXQaUmzE7g7CR3ibCgTIVetpJtE2fE5c8GlK9U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jian Shen <shenjian15@huawei.com>,
        Jijie Shao <shaojijie@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Jiri Pirko <jiri@nvidia.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 506/550] net: page_pool: add missing free_percpu when page_pool_init fail
Date:   Wed, 15 Nov 2023 14:18:10 -0500
Message-ID: <20231115191635.994857278@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jian Shen <shenjian15@huawei.com>

[ Upstream commit 8ffbd1669ed1d58939d6e878dffaa2f60bf961a4 ]

When ptr_ring_init() returns failure in page_pool_init(), free_percpu()
is not called to free pool->recycle_stats, which may cause memory
leak.

Fixes: ad6fa1e1ab1b ("page_pool: Add recycle stats")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Link: https://lore.kernel.org/r/20231030091256.2915394-1-shaojijie@huawei.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/page_pool.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index a3e12a61d456c..1ed4affd9149f 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -210,8 +210,12 @@ static int page_pool_init(struct page_pool *pool,
 		return -ENOMEM;
 #endif
 
-	if (ptr_ring_init(&pool->ring, ring_qsize, GFP_KERNEL) < 0)
+	if (ptr_ring_init(&pool->ring, ring_qsize, GFP_KERNEL) < 0) {
+#ifdef CONFIG_PAGE_POOL_STATS
+		free_percpu(pool->recycle_stats);
+#endif
 		return -ENOMEM;
+	}
 
 	atomic_set(&pool->pages_state_release_cnt, 0);
 
-- 
2.42.0



