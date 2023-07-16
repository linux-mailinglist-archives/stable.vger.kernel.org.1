Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B077556EE
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjGPUzY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjGPUzX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:55:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5278D109
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:55:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5FC360E2C
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0685FC433C7;
        Sun, 16 Jul 2023 20:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540921;
        bh=lpKjYR8YtBNqgcYQ1biYaEaYfki/fu2fE6kWjePgTPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m8RK0NLWRUyhsXlnekqncqEafzg9lCsrzSKX5RXwj2zfUodrx2MUzWIVZxAEFk6Os
         /ZI6nbHmBK96C8Sb6I8VUvDUqDJ/cLI3Ey2aDIb9LyQwzci+c2iZynjQY2dlpmSv0x
         4ePJTpinBHAqSXWn6RBtk/dCl3/jotiekKvzAcxY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mingzhe Zou <mingzhe.zou@easystack.cn>,
        Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1 536/591] bcache: fixup btree_cache_wait list damage
Date:   Sun, 16 Jul 2023 21:51:15 +0200
Message-ID: <20230716194937.733300027@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mingzhe Zou <mingzhe.zou@easystack.cn>

commit f0854489fc07d2456f7cc71a63f4faf9c716ffbe upstream.

We get a kernel crash about "list_add corruption. next->prev should be
prev (ffff9c801bc01210), but was ffff9c77b688237c.
(next=ffffae586d8afe68)."

crash> struct list_head 0xffff9c801bc01210
struct list_head {
  next = 0xffffae586d8afe68,
  prev = 0xffffae586d8afe68
}
crash> struct list_head 0xffff9c77b688237c
struct list_head {
  next = 0x0,
  prev = 0x0
}
crash> struct list_head 0xffffae586d8afe68
struct list_head struct: invalid kernel virtual address: ffffae586d8afe68  type: "gdb_readmem_callback"
Cannot access memory at address 0xffffae586d8afe68

[230469.019492] Call Trace:
[230469.032041]  prepare_to_wait+0x8a/0xb0
[230469.044363]  ? bch_btree_keys_free+0x6c/0xc0 [escache]
[230469.056533]  mca_cannibalize_lock+0x72/0x90 [escache]
[230469.068788]  mca_alloc+0x2ae/0x450 [escache]
[230469.080790]  bch_btree_node_get+0x136/0x2d0 [escache]
[230469.092681]  bch_btree_check_thread+0x1e1/0x260 [escache]
[230469.104382]  ? finish_wait+0x80/0x80
[230469.115884]  ? bch_btree_check_recurse+0x1a0/0x1a0 [escache]
[230469.127259]  kthread+0x112/0x130
[230469.138448]  ? kthread_flush_work_fn+0x10/0x10
[230469.149477]  ret_from_fork+0x35/0x40

bch_btree_check_thread() and bch_dirty_init_thread() may call
mca_cannibalize() to cannibalize other cached btree nodes. Only one thread
can do it at a time, so the op of other threads will be added to the
btree_cache_wait list.

We must call finish_wait() to remove op from btree_cache_wait before free
it's memory address. Otherwise, the list will be damaged. Also should call
bch_cannibalize_unlock() to release the btree_cache_alloc_lock and wake_up
other waiters.

Fixes: 8e7102273f59 ("bcache: make bch_btree_check() to be multithreaded")
Fixes: b144e45fc576 ("bcache: make bch_sectors_dirty_init() to be multithreaded")
Cc: stable@vger.kernel.org
Signed-off-by: Mingzhe Zou <mingzhe.zou@easystack.cn>
Signed-off-by: Coly Li <colyli@suse.de>
Link: https://lore.kernel.org/r/20230615121223.22502-7-colyli@suse.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/bcache/btree.c     |   11 ++++++++++-
 drivers/md/bcache/btree.h     |    1 +
 drivers/md/bcache/writeback.c |   10 ++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -885,7 +885,7 @@ static struct btree *mca_cannibalize(str
  * cannibalize_bucket() will take. This means every time we unlock the root of
  * the btree, we need to release this lock if we have it held.
  */
-static void bch_cannibalize_unlock(struct cache_set *c)
+void bch_cannibalize_unlock(struct cache_set *c)
 {
 	spin_lock(&c->btree_cannibalize_lock);
 	if (c->btree_cache_alloc_lock == current) {
@@ -1968,6 +1968,15 @@ static int bch_btree_check_thread(void *
 			c->gc_stats.nodes++;
 			bch_btree_op_init(&op, 0);
 			ret = bcache_btree(check_recurse, p, c->root, &op);
+			/*
+			 * The op may be added to cache_set's btree_cache_wait
+			 * in mca_cannibalize(), must ensure it is removed from
+			 * the list and release btree_cache_alloc_lock before
+			 * free op memory.
+			 * Otherwise, the btree_cache_wait will be damaged.
+			 */
+			bch_cannibalize_unlock(c);
+			finish_wait(&c->btree_cache_wait, &(&op)->wait);
 			if (ret)
 				goto out;
 		}
--- a/drivers/md/bcache/btree.h
+++ b/drivers/md/bcache/btree.h
@@ -282,6 +282,7 @@ void bch_initial_gc_finish(struct cache_
 void bch_moving_gc(struct cache_set *c);
 int bch_btree_check(struct cache_set *c);
 void bch_initial_mark_key(struct cache_set *c, int level, struct bkey *k);
+void bch_cannibalize_unlock(struct cache_set *c);
 
 static inline void wake_up_gc(struct cache_set *c)
 {
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -890,6 +890,16 @@ static int bch_root_node_dirty_init(stru
 	if (ret < 0)
 		pr_warn("sectors dirty init failed, ret=%d!\n", ret);
 
+	/*
+	 * The op may be added to cache_set's btree_cache_wait
+	 * in mca_cannibalize(), must ensure it is removed from
+	 * the list and release btree_cache_alloc_lock before
+	 * free op memory.
+	 * Otherwise, the btree_cache_wait will be damaged.
+	 */
+	bch_cannibalize_unlock(c);
+	finish_wait(&c->btree_cache_wait, &(&op.op)->wait);
+
 	return ret;
 }
 


