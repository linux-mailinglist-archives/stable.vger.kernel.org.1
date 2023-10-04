Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F127B874A
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243755AbjJDSDi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243756AbjJDSDh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:03:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70057A7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:03:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE09C433C9;
        Wed,  4 Oct 2023 18:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442613;
        bh=hc0BgQVcIj/G6gaTswwP4vOjWp16ACgEQHr3vBBPSs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fh9cNiwkSZwKtqsSQZic7Sd1Mu8AkYm3FT/UAeeOZILoco/zRga39wvRcOuM5NOC7
         3/xpKfP0t8DrgU02+DN8YCVDgDraCmqMrQtuoK9MEDrKgkkKkuK+y4LWMLGksWiRFF
         qHihKGrIbMYFF3HFMkdoOUMChZFjTrwdfvmrJ07E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 030/183] netfilter: nft_set_pipapo: call nft_trans_gc_queue_sync() in catchall GC
Date:   Wed,  4 Oct 2023 19:54:21 +0200
Message-ID: <20231004175205.230486964@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit 4a9e12ea7e70223555ec010bec9f711089ce96f6 upstream.

pipapo needs to enqueue GC transactions for catchall elements through
nft_trans_gc_queue_sync(). Add nft_trans_gc_catchall_sync() and
nft_trans_gc_catchall_async() to handle GC transaction queueing
accordingly.

Fixes: 5f68718b34a5 ("netfilter: nf_tables: GC transaction API to avoid race with control plane")
Fixes: f6c383b8c31a ("netfilter: nf_tables: adapt set backend to use GC transaction API")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_tables.h |  5 +++--
 net/netfilter/nf_tables_api.c     | 22 +++++++++++++++++++---
 net/netfilter/nft_set_hash.c      |  2 +-
 net/netfilter/nft_set_pipapo.c    |  2 +-
 net/netfilter/nft_set_rbtree.c    |  2 +-
 5 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index af703d295f0cd..d543078c43f95 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1623,8 +1623,9 @@ void nft_trans_gc_queue_sync_done(struct nft_trans_gc *trans);
 
 void nft_trans_gc_elem_add(struct nft_trans_gc *gc, void *priv);
 
-struct nft_trans_gc *nft_trans_gc_catchall(struct nft_trans_gc *gc,
-					   unsigned int gc_seq);
+struct nft_trans_gc *nft_trans_gc_catchall_async(struct nft_trans_gc *gc,
+						 unsigned int gc_seq);
+struct nft_trans_gc *nft_trans_gc_catchall_sync(struct nft_trans_gc *gc);
 
 void nft_setelem_data_deactivate(const struct net *net,
 				 const struct nft_set *set,
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index ac266dc2c31b7..58fec8806ec53 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -9027,8 +9027,9 @@ void nft_trans_gc_queue_sync_done(struct nft_trans_gc *trans)
 	call_rcu(&trans->rcu, nft_trans_gc_trans_free);
 }
 
-struct nft_trans_gc *nft_trans_gc_catchall(struct nft_trans_gc *gc,
-					   unsigned int gc_seq)
+static struct nft_trans_gc *nft_trans_gc_catchall(struct nft_trans_gc *gc,
+						  unsigned int gc_seq,
+						  bool sync)
 {
 	struct nft_set_elem_catchall *catchall;
 	const struct nft_set *set = gc->set;
@@ -9044,7 +9045,11 @@ struct nft_trans_gc *nft_trans_gc_catchall(struct nft_trans_gc *gc,
 
 		nft_set_elem_dead(ext);
 dead_elem:
-		gc = nft_trans_gc_queue_async(gc, gc_seq, GFP_ATOMIC);
+		if (sync)
+			gc = nft_trans_gc_queue_sync(gc, GFP_ATOMIC);
+		else
+			gc = nft_trans_gc_queue_async(gc, gc_seq, GFP_ATOMIC);
+
 		if (!gc)
 			return NULL;
 
@@ -9054,6 +9059,17 @@ struct nft_trans_gc *nft_trans_gc_catchall(struct nft_trans_gc *gc,
 	return gc;
 }
 
+struct nft_trans_gc *nft_trans_gc_catchall_async(struct nft_trans_gc *gc,
+						 unsigned int gc_seq)
+{
+	return nft_trans_gc_catchall(gc, gc_seq, false);
+}
+
+struct nft_trans_gc *nft_trans_gc_catchall_sync(struct nft_trans_gc *gc)
+{
+	return nft_trans_gc_catchall(gc, 0, true);
+}
+
 static void nf_tables_module_autoload_cleanup(struct net *net)
 {
 	struct nftables_pernet *nft_net = nft_pernet(net);
diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index 524763659f251..eca20dc601384 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -372,7 +372,7 @@ static void nft_rhash_gc(struct work_struct *work)
 		nft_trans_gc_elem_add(gc, he);
 	}
 
-	gc = nft_trans_gc_catchall(gc, gc_seq);
+	gc = nft_trans_gc_catchall_async(gc, gc_seq);
 
 try_later:
 	/* catchall list iteration requires rcu read side lock. */
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 58bd514260b90..7248a1737ee14 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1611,7 +1611,7 @@ static void pipapo_gc(const struct nft_set *_set, struct nft_pipapo_match *m)
 		}
 	}
 
-	gc = nft_trans_gc_catchall(gc, 0);
+	gc = nft_trans_gc_catchall_sync(gc);
 	if (gc) {
 		nft_trans_gc_queue_sync_done(gc);
 		priv->last_gc = jiffies;
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 70491ba98decb..487572dcd6144 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -669,7 +669,7 @@ static void nft_rbtree_gc(struct work_struct *work)
 		nft_trans_gc_elem_add(gc, rbe);
 	}
 
-	gc = nft_trans_gc_catchall(gc, gc_seq);
+	gc = nft_trans_gc_catchall_async(gc, gc_seq);
 
 try_later:
 	read_unlock_bh(&priv->lock);
-- 
2.40.1



