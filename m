Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5417036C5
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243842AbjEORNr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243653AbjEORNY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:13:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E605D100C3
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:11:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5CB962B75
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:11:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CCFC433EF;
        Mon, 15 May 2023 17:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170702;
        bh=hIzXVIqR9jTZqawadR1FwbhU/G1VFDxQMGhNXz/D3m0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CG6Pp6IIm9wqEqort6XvWcf/y3EVwq28ozOxe4sVacBWXPnt/vkfrG/wK2KOdxYY1
         FuMItb3qlVhPmHVdvZ6K4sB5LWnOJKG4CYzivZdzjjeAZoJWCdqwlAsBEGFboVtPSA
         T0FyzV6qsVFoeTGojXUp0tZjGrtRs1nJxBPeuUyM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 186/239] f2fs: remove unnecessary __init_extent_tree
Date:   Mon, 15 May 2023 18:27:29 +0200
Message-Id: <20230515161727.239455738@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit 749d543c0d451fff31e8f7a3e0a031ffcbf1ebb1 ]

Added into the caller.

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 043d2d00b443 ("f2fs: factor out victim_entry usage from general rb_tree use")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/extent_cache.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index a626ce0b70a50..d3c3b1b627c63 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -386,21 +386,6 @@ static struct extent_tree *__grab_extent_tree(struct inode *inode)
 	return et;
 }
 
-static struct extent_node *__init_extent_tree(struct f2fs_sb_info *sbi,
-				struct extent_tree *et, struct extent_info *ei)
-{
-	struct rb_node **p = &et->root.rb_root.rb_node;
-	struct extent_node *en;
-
-	en = __attach_extent_node(sbi, et, ei, NULL, p, true);
-	if (!en)
-		return NULL;
-
-	et->largest = en->ei;
-	et->cached_en = en;
-	return en;
-}
-
 static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
 					struct extent_tree *et)
 {
@@ -460,8 +445,12 @@ static void __f2fs_init_extent_tree(struct inode *inode, struct page *ipage)
 	if (atomic_read(&et->node_cnt))
 		goto out;
 
-	en = __init_extent_tree(sbi, et, &ei);
+	en = __attach_extent_node(sbi, et, &ei, NULL,
+				&et->root.rb_root.rb_node, true);
 	if (en) {
+		et->largest = en->ei;
+		et->cached_en = en;
+
 		spin_lock(&sbi->extent_lock);
 		list_add_tail(&en->list, &sbi->extent_list);
 		spin_unlock(&sbi->extent_lock);
-- 
2.39.2



