Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1B37F2CDF
	for <lists+stable@lfdr.de>; Tue, 21 Nov 2023 13:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjKUMO7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 21 Nov 2023 07:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbjKUMO7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 21 Nov 2023 07:14:59 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BB9183;
        Tue, 21 Nov 2023 04:14:55 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1r5PeY-00055z-1e; Tue, 21 Nov 2023 13:14:54 +0100
From:   Florian Westphal <fw@strlen.de>
To:     stable@vger.kernel.org
Cc:     <netfilter-devel@vger.kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        lonial con <kongln9170@gmail.com>,
        Florian Westphal <fw@strlen.de>
Subject: [PATCH 6.6.y 1/2] netfilter: nf_tables: remove catchall element in GC sync path
Date:   Tue, 21 Nov 2023 13:14:21 +0100
Message-ID: <20231121121431.8612-2-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231121121431.8612-1-fw@strlen.de>
References: <20231121121431.8612-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 93995bf4af2c5a99e2a87f0cd5ce547d31eb7630 ]

The expired catchall element is not deactivated and removed from GC sync
path. This path holds mutex so just call nft_setelem_data_deactivate()
and nft_setelem_catchall_remove() before queueing the GC work.

Fixes: 4a9e12ea7e70 ("netfilter: nft_set_pipapo: call nft_trans_gc_queue_sync() in catchall GC")
Reported-by: lonial con <kongln9170@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_tables_api.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 3bf428a188cc..d300e9fc5d62 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6464,6 +6464,12 @@ static int nft_setelem_deactivate(const struct net *net,
 	return ret;
 }
 
+static void nft_setelem_catchall_destroy(struct nft_set_elem_catchall *catchall)
+{
+	list_del_rcu(&catchall->list);
+	kfree_rcu(catchall, rcu);
+}
+
 static void nft_setelem_catchall_remove(const struct net *net,
 					const struct nft_set *set,
 					const struct nft_set_elem *elem)
@@ -6472,8 +6478,7 @@ static void nft_setelem_catchall_remove(const struct net *net,
 
 	list_for_each_entry_safe(catchall, next, &set->catchall_list, list) {
 		if (catchall->elem == elem->priv) {
-			list_del_rcu(&catchall->list);
-			kfree_rcu(catchall, rcu);
+			nft_setelem_catchall_destroy(catchall);
 			break;
 		}
 	}
@@ -9638,11 +9643,12 @@ static struct nft_trans_gc *nft_trans_gc_catchall(struct nft_trans_gc *gc,
 						  unsigned int gc_seq,
 						  bool sync)
 {
-	struct nft_set_elem_catchall *catchall;
+	struct nft_set_elem_catchall *catchall, *next;
 	const struct nft_set *set = gc->set;
+	struct nft_elem_priv *elem_priv;
 	struct nft_set_ext *ext;
 
-	list_for_each_entry_rcu(catchall, &set->catchall_list, list) {
+	list_for_each_entry_safe(catchall, next, &set->catchall_list, list) {
 		ext = nft_set_elem_ext(set, catchall->elem);
 
 		if (!nft_set_elem_expired(ext))
@@ -9660,7 +9666,17 @@ static struct nft_trans_gc *nft_trans_gc_catchall(struct nft_trans_gc *gc,
 		if (!gc)
 			return NULL;
 
-		nft_trans_gc_elem_add(gc, catchall->elem);
+		elem_priv = catchall->elem;
+		if (sync) {
+			struct nft_set_elem elem = {
+				.priv = elem_priv,
+			};
+
+			nft_setelem_data_deactivate(gc->net, gc->set, &elem);
+			nft_setelem_catchall_destroy(catchall);
+		}
+
+		nft_trans_gc_elem_add(gc, elem_priv);
 	}
 
 	return gc;
-- 
2.41.0

