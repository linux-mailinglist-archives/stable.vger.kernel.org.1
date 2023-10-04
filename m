Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DDC7B8925
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244117AbjJDSXL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244123AbjJDSXK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:23:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D3DC6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:23:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0773AC433C8;
        Wed,  4 Oct 2023 18:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443783;
        bh=ZMnRPAaxL6JF1K3DCmMoNPT+CCezP65nY5g5XanbjAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LastduiM9or894GQlT1lgdgCSC35ca5Fh28bFH36DSYYKEispQ2fVfAy/Y5zDgp1X
         jqH8aC1X6YAQsduASr9DwgYV/2IOaqvQ/iYOzl4nnhff3TQ9xlC4v3rNSEkFA+SbQR
         jDLVuV8qGDetVESKenAr1vCSs7bz63eKRf95FWV8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 019/321] netfilter: nft_set_rbtree: use read spinlock to avoid datapath contention
Date:   Wed,  4 Oct 2023 19:52:44 +0200
Message-ID: <20231004175230.080151363@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit 96b33300fba880ec0eafcf3d82486f3463b4b6da upstream.

rbtree GC does not modify the datastructure, instead it collects expired
elements and it enqueues a GC transaction. Use a read spinlock instead
to avoid data contention while GC worker is running.

Fixes: f6c383b8c31a ("netfilter: nf_tables: adapt set backend to use GC transaction API")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_set_rbtree.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index f250b5399344a..70491ba98decb 100644
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
2.40.1



