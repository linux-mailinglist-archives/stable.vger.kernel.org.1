Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C685703340
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242552AbjEOQey (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242779AbjEOQew (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:34:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72EA10E7
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:34:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AC51627E8
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6107CC433EF;
        Mon, 15 May 2023 16:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168490;
        bh=BOTUwwwztEEg9uiSYrMVOPAiwd+S+u4fCn29B+wq1yY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eusAVgFXTPt0QT+rKcp7cEHQqZ//GksHsMWjfM/03uczheTDOMC1+w11ikMHR/i/P
         MJ7cNA4Mywdx6RmiD7ie33esbFiORCeuLBDox6veQEUSQ/UNc20KgwrN4TA/u6lLHf
         3nAPfifLgxilFwLN64oS1Xbo84UiLkDMJGJ8fiR4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 067/116] IB/hfi1: Fix SDMA mmu_rb_node not being evicted in LRU order
Date:   Mon, 15 May 2023 18:26:04 +0200
Message-Id: <20230515161700.517013998@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161658.228491273@linuxfoundation.org>
References: <20230515161658.228491273@linuxfoundation.org>
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

From: Patrick Kelsey <pat.kelsey@cornelisnetworks.com>

[ Upstream commit 9fe8fec5e43d5a80f43cbf61aaada1b047a1eb61 ]

hfi1_mmu_rb_remove_unless_exact() did not move mmu_rb_node objects in
mmu_rb_handler->lru_list after getting a cache hit on an mmu_rb_node.

As a result, hfi1_mmu_rb_evict() was not guaranteed to evict truly
least-recently used nodes.

This could be a performance issue for an application when that
application:
- Uses some long-lived buffers frequently.
- Uses a large number of buffers once.
- Hits the mmu_rb_handler cache size or pinned-page limits, forcing
  mmu_rb_handler cache entries to be evicted.

In this case, the one-time use buffers cause the long-lived buffer
entries to eventually filter to the end of the LRU list where
hfi1_mmu_rb_evict() will consider evicting a frequently-used long-lived
entry instead of evicting one of the one-time use entries.

Fix this by inserting new mmu_rb_node at the tail of
mmu_rb_handler->lru_list and move mmu_rb_ndoe to the tail of
mmu_rb_handler->lru_list when the mmu_rb_node is a hit in
hfi1_mmu_rb_remove_unless_exact(). Change hfi1_mmu_rb_evict() to evict
from the head of mmu_rb_handler->lru_list instead of the tail.

Fixes: 0636e9ab8355 ("IB/hfi1: Add cache evict LRU list")
Signed-off-by: Brendan Cunningham <bcunningham@cornelisnetworks.com>
Signed-off-by: Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Link: https://lore.kernel.org/r/168088635931.3027109.10423156330761536044.stgit@252.162.96.66.static.eigbox.net
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/mmu_rb.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.c b/drivers/infiniband/hw/hfi1/mmu_rb.c
index 175002c046ede..42eddaf3a9947 100644
--- a/drivers/infiniband/hw/hfi1/mmu_rb.c
+++ b/drivers/infiniband/hw/hfi1/mmu_rb.c
@@ -177,7 +177,7 @@ int hfi1_mmu_rb_insert(struct mmu_rb_handler *handler,
 		goto unlock;
 	}
 	__mmu_int_rb_insert(mnode, &handler->root);
-	list_add(&mnode->list, &handler->lru_list);
+	list_add_tail(&mnode->list, &handler->lru_list);
 
 	ret = handler->ops->insert(handler->ops_arg, mnode);
 	if (ret) {
@@ -224,8 +224,10 @@ bool hfi1_mmu_rb_remove_unless_exact(struct mmu_rb_handler *handler,
 	spin_lock_irqsave(&handler->lock, flags);
 	node = __mmu_rb_search(handler, addr, len);
 	if (node) {
-		if (node->addr == addr && node->len == len)
+		if (node->addr == addr && node->len == len) {
+			list_move_tail(&node->list, &handler->lru_list);
 			goto unlock;
+		}
 		__mmu_int_rb_remove(node, &handler->root);
 		list_del(&node->list); /* remove from LRU list */
 		ret = true;
@@ -246,8 +248,7 @@ void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg)
 	INIT_LIST_HEAD(&del_list);
 
 	spin_lock_irqsave(&handler->lock, flags);
-	list_for_each_entry_safe_reverse(rbnode, ptr, &handler->lru_list,
-					 list) {
+	list_for_each_entry_safe(rbnode, ptr, &handler->lru_list, list) {
 		if (handler->ops->evict(handler->ops_arg, rbnode, evict_arg,
 					&stop)) {
 			__mmu_int_rb_remove(rbnode, &handler->root);
@@ -259,9 +260,7 @@ void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg)
 	}
 	spin_unlock_irqrestore(&handler->lock, flags);
 
-	while (!list_empty(&del_list)) {
-		rbnode = list_first_entry(&del_list, struct mmu_rb_node, list);
-		list_del(&rbnode->list);
+	list_for_each_entry_safe(rbnode, ptr, &del_list, list) {
 		handler->ops->remove(handler->ops_arg, rbnode);
 	}
 }
-- 
2.39.2



