Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F54F783196
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 21:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjHUTve (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjHUTvd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:51:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0868FD
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:51:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51A8064448
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5A7C433C7;
        Mon, 21 Aug 2023 19:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647490;
        bh=g8XEdtCxs+Z6p6Xs8PAIa7tF9d7ZLbj8Zaoh6QjuRvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WJQd2t3V4KqvNVltfAzr2RmVpAFc5h4jxMBrVklbY4O5YYIikIz8Z7HCEM5F5G/gW
         MpatM98XzxMs0krbk1nrmgJ0cdGqffDE9NVysa8QTPrSxi53q1/oC+EkJ92uRWG2r+
         zjTSsZhUfRtX/Gd9E6S01oTNYdTROEX+/QMqcJTU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrew Yang <andrew.yang@mediatek.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 005/194] zsmalloc: fix races between modifications of fullness and isolated
Date:   Mon, 21 Aug 2023 21:39:44 +0200
Message-ID: <20230821194122.943487705@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Andrew Yang <andrew.yang@mediatek.com>

[ Upstream commit 4b5d1e47b69426c0f7491d97d73ad0152d02d437 ]

We encountered many kernel exceptions of VM_BUG_ON(zspage->isolated ==
0) in dec_zspage_isolation() and BUG_ON(!pages[1]) in zs_unmap_object()
lately.  This issue only occurs when migration and reclamation occur at
the same time.

With our memory stress test, we can reproduce this issue several times
a day.  We have no idea why no one else encountered this issue.  BTW,
we switched to the new kernel version with this defect a few months
ago.

Since fullness and isolated share the same unsigned int, modifications of
them should be protected by the same lock.

[andrew.yang@mediatek.com: move comment]
  Link: https://lkml.kernel.org/r/20230727062910.6337-1-andrew.yang@mediatek.com
Link: https://lkml.kernel.org/r/20230721063705.11455-1-andrew.yang@mediatek.com
Fixes: c4549b871102 ("zsmalloc: remove zspage isolation for migration")
Signed-off-by: Andrew Yang <andrew.yang@mediatek.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/zsmalloc.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 326faa751f0a4..2f5e6d35b03bd 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1816,6 +1816,7 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 
 static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 {
+	struct zs_pool *pool;
 	struct zspage *zspage;
 
 	/*
@@ -1826,9 +1827,10 @@ static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 	VM_BUG_ON_PAGE(PageIsolated(page), page);
 
 	zspage = get_zspage(page);
-	migrate_write_lock(zspage);
+	pool = zspage->pool;
+	spin_lock(&pool->lock);
 	inc_zspage_isolation(zspage);
-	migrate_write_unlock(zspage);
+	spin_unlock(&pool->lock);
 
 	return true;
 }
@@ -1895,12 +1897,12 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	kunmap_atomic(s_addr);
 
 	replace_sub_page(class, zspage, newpage, page);
+	dec_zspage_isolation(zspage);
 	/*
 	 * Since we complete the data copy and set up new zspage structure,
 	 * it's okay to release the pool's lock.
 	 */
 	spin_unlock(&pool->lock);
-	dec_zspage_isolation(zspage);
 	migrate_write_unlock(zspage);
 
 	get_page(newpage);
@@ -1917,15 +1919,17 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 
 static void zs_page_putback(struct page *page)
 {
+	struct zs_pool *pool;
 	struct zspage *zspage;
 
 	VM_BUG_ON_PAGE(!PageMovable(page), page);
 	VM_BUG_ON_PAGE(!PageIsolated(page), page);
 
 	zspage = get_zspage(page);
-	migrate_write_lock(zspage);
+	pool = zspage->pool;
+	spin_lock(&pool->lock);
 	dec_zspage_isolation(zspage);
-	migrate_write_unlock(zspage);
+	spin_unlock(&pool->lock);
 }
 
 static const struct movable_operations zsmalloc_mops = {
-- 
2.40.1



