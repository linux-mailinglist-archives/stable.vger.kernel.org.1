Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BA37AB5FE
	for <lists+stable@lfdr.de>; Fri, 22 Sep 2023 18:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjIVQbH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 22 Sep 2023 12:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjIVQbG (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 22 Sep 2023 12:31:06 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9008114;
        Fri, 22 Sep 2023 09:30:59 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     stable@vger.kernel.org, gregkh@linuxfoundation.org,
        sashal@kernel.org
Subject: [-stable,6.1 13/17] netfilter: nft_set_rbtree: use read spinlock to avoid datapath contention
Date:   Fri, 22 Sep 2023 18:30:25 +0200
Message-Id: <20230922163029.150988-14-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230922163029.150988-1-pablo@netfilter.org>
References: <20230922163029.150988-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 96b33300fba880ec0eafcf3d82486f3463b4b6da upstream.

rbtree GC does not modify the datastructure, instead it collects expired
elements and it enqueues a GC transaction. Use a read spinlock instead
to avoid data contention while GC worker is running.

Fixes: f6c383b8c31a ("netfilter: nf_tables: adapt set backend to use GC transaction API")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_set_rbtree.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index f250b5399344..70491ba98dec 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -622,8 +622,7 @@ static void nft_rbtree_gc(struct work_struct *work)
 	if (!gc)
 		goto done;
 
-	write_lock_bh(&priv->lock);
-	write_seqcount_begin(&priv->count);
+	read_lock_bh(&priv->lock);
 	for (node = rb_first(&priv->root); node != NULL; node = rb_next(node)) {
 
 		/* Ruleset has been updated, try later. */
@@ -673,8 +672,7 @@ static void nft_rbtree_gc(struct work_struct *work)
 	gc = nft_trans_gc_catchall(gc, gc_seq);
 
 try_later:
-	write_seqcount_end(&priv->count);
-	write_unlock_bh(&priv->lock);
+	read_unlock_bh(&priv->lock);
 
 	if (gc)
 		nft_trans_gc_queue_async_done(gc);
-- 
2.30.2

