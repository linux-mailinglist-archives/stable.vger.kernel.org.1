Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAB3782418
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 09:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjHUHC0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 03:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjHUHCZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 03:02:25 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26189AC
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 00:02:20 -0700 (PDT)
X-UUID: a95c60ba3ff011ee9cb5633481061a41-20230821
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=v8kDqv6AkJ6UholcGA/45hlSYaNcsteRMuCVmOL2Nxw=;
        b=jU8Njn8cAV80fQWdBAlfXlHnAQzL/fxl/3+O7pPom96bUeQm7oJY2O3amUCCXeXBqf0FqM0XtjejOvMMO4Uno31/uZn0nENA6MGQNd3LEq35hYdbk+lDqzVS7W/IMR7QOCO7rYjoJNxv5s+adlVGB46d/HSf+5yoFMVGn6yDBAY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:116c3de1-03be-4e2e-8270-6c9fe944a762,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.31,REQID:116c3de1-03be-4e2e-8270-6c9fe944a762,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:0ad78a4,CLOUDID:2e928f1f-33fd-4aaa-bb43-d3fd68d9d5ae,B
        ulkID:230821150216VU3SQVBK,BulkQuantity:0,Recheck:0,SF:29|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,
        TF_CID_SPAM_SDM,TF_CID_SPAM_ASC
X-UUID: a95c60ba3ff011ee9cb5633481061a41-20230821
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <andrew.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1417253466; Mon, 21 Aug 2023 15:02:16 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 21 Aug 2023 15:02:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 21 Aug 2023 15:02:14 +0800
From:   Andrew Yang <andrew.yang@mediatek.com>
To:     <stable@vger.kernel.org>
CC:     <wsd_upstream@mediatek.com>, <casper.li@mediatek.com>,
        Andrew Yang <andrew.yang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] zsmalloc: fix races between modifications of fullness and isolated
Date:   Mon, 21 Aug 2023 15:02:10 +0800
Message-ID: <20230821070210.13607-1-andrew.yang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <2023081217-gender-font-a356@gregkh>
References: <2023081217-gender-font-a356@gregkh>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
(cherry picked from commit 4b5d1e47b69426c0f7491d97d73ad0152d02d437)
---
 mm/zsmalloc.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index d03941cace2c..aa1cb03ad72c 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1821,6 +1821,7 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 
 static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 {
+	struct size_class *class;
 	struct zspage *zspage;
 
 	/*
@@ -1831,9 +1832,10 @@ static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 	VM_BUG_ON_PAGE(PageIsolated(page), page);
 
 	zspage = get_zspage(page);
-	migrate_write_lock(zspage);
+	class = zspage_class(zspage->pool, zspage);
+	spin_lock(&class->lock);
 	inc_zspage_isolation(zspage);
-	migrate_write_unlock(zspage);
+	spin_unlock(&class->lock);
 
 	return true;
 }
@@ -1909,8 +1911,8 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	 * it's okay to release migration_lock.
 	 */
 	write_unlock(&pool->migrate_lock);
-	spin_unlock(&class->lock);
 	dec_zspage_isolation(zspage);
+	spin_unlock(&class->lock);
 	migrate_write_unlock(zspage);
 
 	get_page(newpage);
@@ -1927,15 +1929,17 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 
 static void zs_page_putback(struct page *page)
 {
+	struct size_class *class;
 	struct zspage *zspage;
 
 	VM_BUG_ON_PAGE(!PageMovable(page), page);
 	VM_BUG_ON_PAGE(!PageIsolated(page), page);
 
 	zspage = get_zspage(page);
-	migrate_write_lock(zspage);
+	class = zspage_class(zspage->pool, zspage);
+	spin_lock(&class->lock);
 	dec_zspage_isolation(zspage);
-	migrate_write_unlock(zspage);
+	spin_unlock(&class->lock);
 }
 
 static const struct movable_operations zsmalloc_mops = {
-- 
2.18.0

