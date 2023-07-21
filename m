Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E6775D34B
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjGUTJF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjGUTJE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:09:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A0230EA
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:09:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB23E61D7F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:09:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBC4C433C8;
        Fri, 21 Jul 2023 19:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966541;
        bh=4DezIZfi4AboRO/hg8r388tmL6dtYT6fbAyYEmcfubY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q+5ju/Q+QV8LJyttIB2RIoQlaI0eHY4pE1Xn5Uf106fKBRAOBd+0n8NUGKHmktBgX
         Oaypa2yPT8nhOKsX1rhCKnB6ZX8gQ2ahWHLncKPZd+UGUiRHh8s+EHPIX+sAECFcDl
         JPzQvXXiZZzH5GBUr94+/NQM3I4+rQipd+C7VF78=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zheng Wang <zyytlz.wz@163.com>,
        Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.15 351/532] bcache: Remove unnecessary NULL point check in node allocations
Date:   Fri, 21 Jul 2023 18:04:15 +0200
Message-ID: <20230721160633.484729629@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zheng Wang <zyytlz.wz@163.com>

commit 028ddcac477b691dd9205c92f991cc15259d033e upstream.

Due to the previous fix of __bch_btree_node_alloc, the return value will
never be a NULL pointer. So IS_ERR is enough to handle the failure
situation. Fix it by replacing IS_ERR_OR_NULL check by an IS_ERR check.

Fixes: cafe56359144 ("bcache: A block layer cache")
Cc: stable@vger.kernel.org
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Signed-off-by: Coly Li <colyli@suse.de>
Link: https://lore.kernel.org/r/20230615121223.22502-5-colyli@suse.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/bcache/btree.c |   10 +++++-----
 drivers/md/bcache/super.c |    4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -1138,7 +1138,7 @@ static struct btree *btree_node_alloc_re
 {
 	struct btree *n = bch_btree_node_alloc(b->c, op, b->level, b->parent);
 
-	if (!IS_ERR_OR_NULL(n)) {
+	if (!IS_ERR(n)) {
 		mutex_lock(&n->write_lock);
 		bch_btree_sort_into(&b->keys, &n->keys, &b->c->sort);
 		bkey_copy_key(&n->key, &b->key);
@@ -1340,7 +1340,7 @@ static int btree_gc_coalesce(struct btre
 	memset(new_nodes, 0, sizeof(new_nodes));
 	closure_init_stack(&cl);
 
-	while (nodes < GC_MERGE_NODES && !IS_ERR_OR_NULL(r[nodes].b))
+	while (nodes < GC_MERGE_NODES && !IS_ERR(r[nodes].b))
 		keys += r[nodes++].keys;
 
 	blocks = btree_default_blocks(b->c) * 2 / 3;
@@ -1352,7 +1352,7 @@ static int btree_gc_coalesce(struct btre
 
 	for (i = 0; i < nodes; i++) {
 		new_nodes[i] = btree_node_alloc_replacement(r[i].b, NULL);
-		if (IS_ERR_OR_NULL(new_nodes[i]))
+		if (IS_ERR(new_nodes[i]))
 			goto out_nocoalesce;
 	}
 
@@ -1487,7 +1487,7 @@ out_nocoalesce:
 	bch_keylist_free(&keylist);
 
 	for (i = 0; i < nodes; i++)
-		if (!IS_ERR_OR_NULL(new_nodes[i])) {
+		if (!IS_ERR(new_nodes[i])) {
 			btree_node_free(new_nodes[i]);
 			rw_unlock(true, new_nodes[i]);
 		}
@@ -1669,7 +1669,7 @@ static int bch_btree_gc_root(struct btre
 	if (should_rewrite) {
 		n = btree_node_alloc_replacement(b, NULL);
 
-		if (!IS_ERR_OR_NULL(n)) {
+		if (!IS_ERR(n)) {
 			bch_btree_node_write_sync(n);
 
 			bch_btree_set_root(n);
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1729,7 +1729,7 @@ static void cache_set_flush(struct closu
 	if (!IS_ERR_OR_NULL(c->gc_thread))
 		kthread_stop(c->gc_thread);
 
-	if (!IS_ERR_OR_NULL(c->root))
+	if (!IS_ERR(c->root))
 		list_add(&c->root->list, &c->btree_cache);
 
 	/*
@@ -2093,7 +2093,7 @@ static int run_cache_set(struct cache_se
 
 		err = "cannot allocate new btree root";
 		c->root = __bch_btree_node_alloc(c, NULL, 0, true, NULL);
-		if (IS_ERR_OR_NULL(c->root))
+		if (IS_ERR(c->root))
 			goto err;
 
 		mutex_lock(&c->root->write_lock);


