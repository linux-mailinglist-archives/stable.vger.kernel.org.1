Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBDF779D7A
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 08:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjHLGDX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 02:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjHLGDW (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 02:03:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4148F1AA
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 23:03:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA4DB644FE
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 06:03:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1F0C433C7;
        Sat, 12 Aug 2023 06:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691820201;
        bh=MjBsZ8ne7Rpm5oyDCiRGaTu18Z62IqTBxBziYR3i+6c=;
        h=Subject:To:Cc:From:Date:From;
        b=OIzqkmcK8I6OBj+OlcXiQMfWAma1yYuNCRKB6F5oXcWN6jMW4iEXmPkIIDBTbKYwA
         u+G/oQOQW/HTMY5nxnR+YVMOfVKrZV84vLzn1zH8rt9DBJuZ38Yr0Wt55EWkNEMrRJ
         9NOt1l2xOqZUyvryfCNWWIWScbh3Of8cdUVwDRlo=
Subject: FAILED: patch "[PATCH] zsmalloc: fix races between modifications of fullness and" failed to apply to 6.1-stable tree
To:     andrew.yang@mediatek.com, akpm@linux-foundation.org,
        angelogioacchino.delregno@collabora.com, bigeasy@linutronix.de,
        matthias.bgg@gmail.com, minchan@kernel.org,
        senozhatsky@chromium.org, stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 08:03:17 +0200
Message-ID: <2023081217-gender-font-a356@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4b5d1e47b69426c0f7491d97d73ad0152d02d437
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081217-gender-font-a356@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

4b5d1e47b694 ("zsmalloc: fix races between modifications of fullness and isolated")
c0547d0b6a4b ("zsmalloc: consolidate zs_pool's migrate_lock and size_class's locks")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4b5d1e47b69426c0f7491d97d73ad0152d02d437 Mon Sep 17 00:00:00 2001
From: Andrew Yang <andrew.yang@mediatek.com>
Date: Fri, 21 Jul 2023 14:37:01 +0800
Subject: [PATCH] zsmalloc: fix races between modifications of fullness and
 isolated

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

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 3f057970504e..32916d28d9d9 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1798,6 +1798,7 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 
 static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 {
+	struct zs_pool *pool;
 	struct zspage *zspage;
 
 	/*
@@ -1807,9 +1808,10 @@ static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
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
@@ -1875,12 +1877,12 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
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
@@ -1897,14 +1899,16 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 
 static void zs_page_putback(struct page *page)
 {
+	struct zs_pool *pool;
 	struct zspage *zspage;
 
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

