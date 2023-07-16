Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E52754DF4
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 11:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjGPJKL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 05:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGPJKK (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 05:10:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA463DF
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 02:10:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BA2B60C19
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 09:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20ED8C433C7;
        Sun, 16 Jul 2023 09:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689498607;
        bh=fPKzY+yL/k2FP3CGh9AEYPrIBCWW/E7JETgXZHsYvO0=;
        h=Subject:To:Cc:From:Date:From;
        b=EINP8s2HXV7QuQpDzGZJj8MBd6QlxJBBgcJCXbgOYTndnqpLc5fOmR/9MZbmUZrxa
         GS75dh4zkraHltCDQktR+MFf+xK+1KkxOllbsQSDm3jaITcgVakNUu5Xf2lL7JWhEY
         fJhJIAybkkfjOVnVTxJyneWIzBC7pPXTSa09m31w=
Subject: FAILED: patch "[PATCH] bcache: Remove unnecessary NULL point check in node" failed to apply to 4.14-stable tree
To:     zyytlz.wz@163.com, axboe@kernel.dk, colyli@suse.de
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 16 Jul 2023 11:10:04 +0200
Message-ID: <2023071604-panning-specimen-6e1a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 028ddcac477b691dd9205c92f991cc15259d033e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071604-panning-specimen-6e1a@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

028ddcac477b ("bcache: Remove unnecessary NULL point check in node allocations")
1fae7cf05293 ("bcache: style fix to add a blank line after declarations")
6f10f7d1b02b ("bcache: style fix to replace 'unsigned' by 'unsigned int'")
ea8c5356d390 ("bcache: set max writeback rate when I/O request is idle")
b467a6ac0b4b ("bcache: add code comments for bset.c")
b4cb6efc1af7 ("bcache: display rate debug parameters to 0 when writeback is not running")
94f71c16062e ("bcache: fix I/O significant decline while backend devices registering")
99a27d59bd7b ("bcache: simplify the calculation of the total amount of flash dirty data")
ddcf35d39797 ("block: Add and use op_stat_group() for indexing disk_stat fields.")
3f289dcb4b26 ("block: make bdev_ops->rw_page() take a REQ_OP instead of bool")
d19936a26658 ("bcache: convert to bioset_init()/mempool_init()")
0f0709e6bfc3 ("bcache: stop bcache device when backing device is offline")
522a777566f5 ("block: consolidate struct request timestamp fields")
4bc6339a583c ("block: move blk_stat_add() to __blk_mq_end_request()")
84c7afcebed9 ("block: use ktime_get_ns() instead of sched_clock() for cfq and bfq")
544ccc8dc904 ("block: get rid of struct blk_issue_stat")
a8a45941706b ("block: pass struct request instead of struct blk_issue_stat to wbt")
934031a12980 ("block: move some wbt helpers to blk-wbt.c")
782f569774d7 ("blk-wbt: throttle discards like background writes")
8bea60901974 ("blk-wbt: pass in enum wbt_flags to get_rq_wait()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 028ddcac477b691dd9205c92f991cc15259d033e Mon Sep 17 00:00:00 2001
From: Zheng Wang <zyytlz.wz@163.com>
Date: Thu, 15 Jun 2023 20:12:21 +0800
Subject: [PATCH] bcache: Remove unnecessary NULL point check in node
 allocations

Due to the previous fix of __bch_btree_node_alloc, the return value will
never be a NULL pointer. So IS_ERR is enough to handle the failure
situation. Fix it by replacing IS_ERR_OR_NULL check by an IS_ERR check.

Fixes: cafe56359144 ("bcache: A block layer cache")
Cc: stable@vger.kernel.org
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Signed-off-by: Coly Li <colyli@suse.de>
Link: https://lore.kernel.org/r/20230615121223.22502-5-colyli@suse.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 147c493a989a..7c21e54468bf 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -1138,7 +1138,7 @@ static struct btree *btree_node_alloc_replacement(struct btree *b,
 {
 	struct btree *n = bch_btree_node_alloc(b->c, op, b->level, b->parent);
 
-	if (!IS_ERR_OR_NULL(n)) {
+	if (!IS_ERR(n)) {
 		mutex_lock(&n->write_lock);
 		bch_btree_sort_into(&b->keys, &n->keys, &b->c->sort);
 		bkey_copy_key(&n->key, &b->key);
@@ -1340,7 +1340,7 @@ static int btree_gc_coalesce(struct btree *b, struct btree_op *op,
 	memset(new_nodes, 0, sizeof(new_nodes));
 	closure_init_stack(&cl);
 
-	while (nodes < GC_MERGE_NODES && !IS_ERR_OR_NULL(r[nodes].b))
+	while (nodes < GC_MERGE_NODES && !IS_ERR(r[nodes].b))
 		keys += r[nodes++].keys;
 
 	blocks = btree_default_blocks(b->c) * 2 / 3;
@@ -1352,7 +1352,7 @@ static int btree_gc_coalesce(struct btree *b, struct btree_op *op,
 
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
@@ -1669,7 +1669,7 @@ static int bch_btree_gc_root(struct btree *b, struct btree_op *op,
 	if (should_rewrite) {
 		n = btree_node_alloc_replacement(b, NULL);
 
-		if (!IS_ERR_OR_NULL(n)) {
+		if (!IS_ERR(n)) {
 			bch_btree_node_write_sync(n);
 
 			bch_btree_set_root(n);
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 1f829e74db0a..e2a803683105 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1723,7 +1723,7 @@ static void cache_set_flush(struct closure *cl)
 	if (!IS_ERR_OR_NULL(c->gc_thread))
 		kthread_stop(c->gc_thread);
 
-	if (!IS_ERR_OR_NULL(c->root))
+	if (!IS_ERR(c->root))
 		list_add(&c->root->list, &c->btree_cache);
 
 	/*
@@ -2087,7 +2087,7 @@ static int run_cache_set(struct cache_set *c)
 
 		err = "cannot allocate new btree root";
 		c->root = __bch_btree_node_alloc(c, NULL, 0, true, NULL);
-		if (IS_ERR_OR_NULL(c->root))
+		if (IS_ERR(c->root))
 			goto err;
 
 		mutex_lock(&c->root->write_lock);

