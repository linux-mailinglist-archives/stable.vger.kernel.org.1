Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653B27B872E
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243702AbjJDSCa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243700AbjJDSC3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:02:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E199E
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:02:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAFDC433C7;
        Wed,  4 Oct 2023 18:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442546;
        bh=dB+elkN1mf6Sc2DxsMGcXwclVX/rx4LmAbWbzegwuZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YZEht2gmwHHGuIm4t3BGB9ecuQIKlxKHnFPc0huN5YaOi6gQ8zPx8UQatjE53kwPk
         Vu38oA1/2pVHHQhz5L27TZPPMpkgewaT82/zaWIsBYQ8GzBeGDnjR98+G6RrpkVoRf
         qc5UUCl9nVUjRqlCN2piKAxRbUCYuT62Ub7vpJOc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 023/183] netfilter: nf_tables: fix GC transaction races with netns and netlink event exit path
Date:   Wed,  4 Oct 2023 19:54:14 +0200
Message-ID: <20231004175204.921529756@linuxfoundation.org>
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

commit 6a33d8b73dfac0a41f3877894b38082bd0c9a5bc upstream.

Netlink event path is missing a synchronization point with GC
transactions. Add GC sequence number update to netns release path and
netlink event path, any GC transaction losing race will be discarded.

Fixes: 5f68718b34a5 ("netfilter: nf_tables: GC transaction API to avoid race with control plane")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 36 +++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 194b78900bd33..aadcb2a5dc816 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -9207,6 +9207,22 @@ static void nft_set_commit_update(struct list_head *set_update_list)
 	}
 }
 
+static unsigned int nft_gc_seq_begin(struct nftables_pernet *nft_net)
+{
+	unsigned int gc_seq;
+
+	/* Bump gc counter, it becomes odd, this is the busy mark. */
+	gc_seq = READ_ONCE(nft_net->gc_seq);
+	WRITE_ONCE(nft_net->gc_seq, ++gc_seq);
+
+	return gc_seq;
+}
+
+static void nft_gc_seq_end(struct nftables_pernet *nft_net, unsigned int gc_seq)
+{
+	WRITE_ONCE(nft_net->gc_seq, ++gc_seq);
+}
+
 static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 {
 	struct nftables_pernet *nft_net = nft_pernet(net);
@@ -9292,9 +9308,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 
 	WRITE_ONCE(nft_net->base_seq, base_seq);
 
-	/* Bump gc counter, it becomes odd, this is the busy mark. */
-	gc_seq = READ_ONCE(nft_net->gc_seq);
-	WRITE_ONCE(nft_net->gc_seq, ++gc_seq);
+	gc_seq = nft_gc_seq_begin(nft_net);
 
 	/* step 3. Start new generation, rules_gen_X now in use. */
 	net->nft.gencursor = nft_gencursor_next(net);
@@ -9485,7 +9499,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 	nf_tables_gen_notify(net, skb, NFT_MSG_NEWGEN);
 	nf_tables_commit_audit_log(&adl, nft_net->base_seq);
 
-	WRITE_ONCE(nft_net->gc_seq, ++gc_seq);
+	nft_gc_seq_end(nft_net, gc_seq);
 	nf_tables_commit_release(net);
 
 	return 0;
@@ -10468,6 +10482,7 @@ static int nft_rcv_nl_event(struct notifier_block *this, unsigned long event,
 	struct net *net = n->net;
 	unsigned int deleted;
 	bool restart = false;
+	unsigned int gc_seq;
 
 	if (event != NETLINK_URELEASE || n->protocol != NETLINK_NETFILTER)
 		return NOTIFY_DONE;
@@ -10475,6 +10490,9 @@ static int nft_rcv_nl_event(struct notifier_block *this, unsigned long event,
 	nft_net = nft_pernet(net);
 	deleted = 0;
 	mutex_lock(&nft_net->commit_mutex);
+
+	gc_seq = nft_gc_seq_begin(nft_net);
+
 	if (!list_empty(&nf_tables_destroy_list))
 		nf_tables_trans_destroy_flush_work();
 again:
@@ -10497,6 +10515,8 @@ static int nft_rcv_nl_event(struct notifier_block *this, unsigned long event,
 		if (restart)
 			goto again;
 	}
+	nft_gc_seq_end(nft_net, gc_seq);
+
 	mutex_unlock(&nft_net->commit_mutex);
 
 	return NOTIFY_DONE;
@@ -10535,12 +10555,20 @@ static void __net_exit nf_tables_pre_exit_net(struct net *net)
 static void __net_exit nf_tables_exit_net(struct net *net)
 {
 	struct nftables_pernet *nft_net = nft_pernet(net);
+	unsigned int gc_seq;
 
 	mutex_lock(&nft_net->commit_mutex);
+
+	gc_seq = nft_gc_seq_begin(nft_net);
+
 	if (!list_empty(&nft_net->commit_list) ||
 	    !list_empty(&nft_net->module_list))
 		__nf_tables_abort(net, NFNL_ABORT_NONE);
+
 	__nft_release_tables(net);
+
+	nft_gc_seq_end(nft_net, gc_seq);
+
 	mutex_unlock(&nft_net->commit_mutex);
 	WARN_ON_ONCE(!list_empty(&nft_net->tables));
 	WARN_ON_ONCE(!list_empty(&nft_net->module_list));
-- 
2.40.1



