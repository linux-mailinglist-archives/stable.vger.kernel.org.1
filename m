Return-Path: <stable+bounces-1733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 225007F811A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5CD1F20FC2
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E762364A6;
	Fri, 24 Nov 2023 18:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DVTBsjCe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38612D787;
	Fri, 24 Nov 2023 18:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730F6C433C8;
	Fri, 24 Nov 2023 18:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852139;
	bh=p8qxT74Tbf9G9LWYBQ+1cAmC2FScmAqc7VuHoOb4pZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DVTBsjCeNE4cDH4NyWlfeE1URD8si1f0G6eEOKzvpdXekMifJbu4cOh3QTNdfAgfb
	 MK8ss3dATnlmqHk1zXDH6duygpQlrF+GrnBdmHw2FwPl/wB+yrCoHPG2p87QoWp0pq
	 I4/3AMrC1FHlF1y3GfV1Iv0B9mA7nJ8mY4cGOkbs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	lonial con <kongln9170@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 235/372] netfilter: nf_tables: remove catchall element in GC sync path
Date: Fri, 24 Nov 2023 17:50:22 +0000
Message-ID: <20231124172018.355551475@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 93995bf4af2c5a99e2a87f0cd5ce547d31eb7630 ]

The expired catchall element is not deactivated and removed from GC sync
path. This path holds mutex so just call nft_setelem_data_deactivate()
and nft_setelem_catchall_remove() before queueing the GC work.

Fixes: 4a9e12ea7e70 ("netfilter: nft_set_pipapo: call nft_trans_gc_queue_sync() in catchall GC")
Reported-by: lonial con <kongln9170@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index d6d59e36d17a7..6a34a4a2f4a42 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6194,6 +6194,12 @@ static int nft_setelem_deactivate(const struct net *net,
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
@@ -6202,8 +6208,7 @@ static void nft_setelem_catchall_remove(const struct net *net,
 
 	list_for_each_entry_safe(catchall, next, &set->catchall_list, list) {
 		if (catchall->elem == elem->priv) {
-			list_del_rcu(&catchall->list);
-			kfree_rcu(catchall, rcu);
+			nft_setelem_catchall_destroy(catchall);
 			break;
 		}
 	}
@@ -9270,11 +9275,12 @@ static struct nft_trans_gc *nft_trans_gc_catchall(struct nft_trans_gc *gc,
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
@@ -9292,7 +9298,17 @@ static struct nft_trans_gc *nft_trans_gc_catchall(struct nft_trans_gc *gc,
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
2.42.0




