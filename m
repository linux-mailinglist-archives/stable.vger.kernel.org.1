Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E24754DF7
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 11:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjGPJKi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 05:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGPJKh (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 05:10:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F19DF
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 02:10:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0A7E60BDC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 09:10:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D347DC433C8;
        Sun, 16 Jul 2023 09:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689498635;
        bh=fzzpAjPZfbKjdMTpZEtApy4UtFwKvI8mfg+9yWdD1uA=;
        h=Subject:To:Cc:From:Date:From;
        b=SU/35wYsXJvo28kcYJsN5geMKQ9+oi91UTB/JWfFs1/bRoAFnG1k9LxjmJDjNEyCt
         nZGlwZyd0RkCqoL0uYTA+omZqSUqeVACfSWehT8pGucIehgqBT5lcztiNjI6upkfiz
         1XLrrABjgcmPfvddI41mdxKmcueVxYpaSM6PkulQ=
Subject: FAILED: patch "[PATCH] bcache: Fix __bch_btree_node_alloc to make the failure" failed to apply to 4.14-stable tree
To:     zyytlz.wz@163.com, axboe@kernel.dk, colyli@suse.de
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 16 Jul 2023 11:10:22 +0200
Message-ID: <2023071622-crablike-glaucoma-f28c@gregkh>
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
git cherry-pick -x 80fca8a10b604afad6c14213fdfd816c4eda3ee4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071622-crablike-glaucoma-f28c@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

80fca8a10b60 ("bcache: Fix __bch_btree_node_alloc to make the failure behavior consistent")
17e4aed8309f ("bcache: remove 'int n' from parameter list of bch_bucket_alloc_set()")
8792099f9ad4 ("bcache: use MAX_CACHES_PER_SET instead of magic number 8 in __bch_bucket_alloc_set")
fc2d5988b597 ("bcache: add identifier names to arguments of function definitions")
6f10f7d1b02b ("bcache: style fix to replace 'unsigned' by 'unsigned int'")
ea8c5356d390 ("bcache: set max writeback rate when I/O request is idle")
b467a6ac0b4b ("bcache: add code comments for bset.c")
b4cb6efc1af7 ("bcache: display rate debug parameters to 0 when writeback is not running")
94f71c16062e ("bcache: fix I/O significant decline while backend devices registering")
99a27d59bd7b ("bcache: simplify the calculation of the total amount of flash dirty data")
ddcf35d39797 ("block: Add and use op_stat_group() for indexing disk_stat fields.")
3f289dcb4b26 ("block: make bdev_ops->rw_page() take a REQ_OP instead of bool")
0f0709e6bfc3 ("bcache: stop bcache device when backing device is offline")
522a777566f5 ("block: consolidate struct request timestamp fields")
4bc6339a583c ("block: move blk_stat_add() to __blk_mq_end_request()")
84c7afcebed9 ("block: use ktime_get_ns() instead of sched_clock() for cfq and bfq")
544ccc8dc904 ("block: get rid of struct blk_issue_stat")
a8a45941706b ("block: pass struct request instead of struct blk_issue_stat to wbt")
934031a12980 ("block: move some wbt helpers to blk-wbt.c")
782f569774d7 ("blk-wbt: throttle discards like background writes")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 80fca8a10b604afad6c14213fdfd816c4eda3ee4 Mon Sep 17 00:00:00 2001
From: Zheng Wang <zyytlz.wz@163.com>
Date: Thu, 15 Jun 2023 20:12:22 +0800
Subject: [PATCH] bcache: Fix __bch_btree_node_alloc to make the failure
 behavior consistent

In some specific situations, the return value of __bch_btree_node_alloc
may be NULL. This may lead to a potential NULL pointer dereference in
caller function like a calling chain :
btree_split->bch_btree_node_alloc->__bch_btree_node_alloc.

Fix it by initializing the return value in __bch_btree_node_alloc.

Fixes: cafe56359144 ("bcache: A block layer cache")
Cc: stable@vger.kernel.org
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Signed-off-by: Coly Li <colyli@suse.de>
Link: https://lore.kernel.org/r/20230615121223.22502-6-colyli@suse.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 7c21e54468bf..0ddf91204782 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -1090,10 +1090,12 @@ struct btree *__bch_btree_node_alloc(struct cache_set *c, struct btree_op *op,
 				     struct btree *parent)
 {
 	BKEY_PADDED(key) k;
-	struct btree *b = ERR_PTR(-EAGAIN);
+	struct btree *b;
 
 	mutex_lock(&c->bucket_lock);
 retry:
+	/* return ERR_PTR(-EAGAIN) when it fails */
+	b = ERR_PTR(-EAGAIN);
 	if (__bch_bucket_alloc_set(c, RESERVE_BTREE, &k.key, wait))
 		goto err;
 

