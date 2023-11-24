Return-Path: <stable+bounces-847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8F27F7CD7
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 946B0B2130B
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA4539FE1;
	Fri, 24 Nov 2023 18:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P6y2A3p5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA64139FC3;
	Fri, 24 Nov 2023 18:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1B3C433C7;
	Fri, 24 Nov 2023 18:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849925;
	bh=U9lIcfV8A2n3QUUeRPJ/z62p+kXPdafNUXMZVVpK5t0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P6y2A3p5Rr8AusaoEFoKTHObUrH9toTJhVRn+0DnYotVdT4dyh4zMevrG/W21KMtf
	 i4kUo7aAGrXcvc/rz+2mm5VzGHPgwVB8H+dSRj3rGU8sjiidrxhhW7iiGkn8t+RWK8
	 RMw8DrnIiu0QkxcabKM5nsr6kHKkPibuqfdn5rmg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 351/530] netfilter: nf_tables: split async and sync catchall in two functions
Date: Fri, 24 Nov 2023 17:48:37 +0000
Message-ID: <20231124172038.696041067@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 8837ba3e58ea1e3d09ae36db80b1e80853aada95 ]

list_for_each_entry_safe() does not work for the async case which runs
under RCU, therefore, split GC logic for catchall in two functions
instead, one for each of the sync and async GC variants.

The catchall sync GC variant never sees a _DEAD bit set on ever, thus,
this handling is removed in such case, moreover, allocate GC sync batch
via GFP_KERNEL.

Fixes: 93995bf4af2c ("netfilter: nf_tables: remove catchall element in GC sync path")
Reported-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 61 ++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index e6c52d417b6d0..4a450f6d12a59 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -9640,16 +9640,14 @@ void nft_trans_gc_queue_sync_done(struct nft_trans_gc *trans)
 	call_rcu(&trans->rcu, nft_trans_gc_trans_free);
 }
 
-static struct nft_trans_gc *nft_trans_gc_catchall(struct nft_trans_gc *gc,
-						  unsigned int gc_seq,
-						  bool sync)
+struct nft_trans_gc *nft_trans_gc_catchall_async(struct nft_trans_gc *gc,
+						 unsigned int gc_seq)
 {
-	struct nft_set_elem_catchall *catchall, *next;
+	struct nft_set_elem_catchall *catchall;
 	const struct nft_set *set = gc->set;
-	struct nft_elem_priv *elem_priv;
 	struct nft_set_ext *ext;
 
-	list_for_each_entry_safe(catchall, next, &set->catchall_list, list) {
+	list_for_each_entry_rcu(catchall, &set->catchall_list, list) {
 		ext = nft_set_elem_ext(set, catchall->elem);
 
 		if (!nft_set_elem_expired(ext))
@@ -9659,39 +9657,44 @@ static struct nft_trans_gc *nft_trans_gc_catchall(struct nft_trans_gc *gc,
 
 		nft_set_elem_dead(ext);
 dead_elem:
-		if (sync)
-			gc = nft_trans_gc_queue_sync(gc, GFP_ATOMIC);
-		else
-			gc = nft_trans_gc_queue_async(gc, gc_seq, GFP_ATOMIC);
-
+		gc = nft_trans_gc_queue_async(gc, gc_seq, GFP_ATOMIC);
 		if (!gc)
 			return NULL;
 
-		elem_priv = catchall->elem;
-		if (sync) {
-			struct nft_set_elem elem = {
-				.priv = elem_priv,
-			};
-
-			nft_setelem_data_deactivate(gc->net, gc->set, &elem);
-			nft_setelem_catchall_destroy(catchall);
-		}
-
-		nft_trans_gc_elem_add(gc, elem_priv);
+		nft_trans_gc_elem_add(gc, catchall->elem);
 	}
 
 	return gc;
 }
 
-struct nft_trans_gc *nft_trans_gc_catchall_async(struct nft_trans_gc *gc,
-						 unsigned int gc_seq)
-{
-	return nft_trans_gc_catchall(gc, gc_seq, false);
-}
-
 struct nft_trans_gc *nft_trans_gc_catchall_sync(struct nft_trans_gc *gc)
 {
-	return nft_trans_gc_catchall(gc, 0, true);
+	struct nft_set_elem_catchall *catchall, *next;
+	const struct nft_set *set = gc->set;
+	struct nft_set_elem elem;
+	struct nft_set_ext *ext;
+
+	WARN_ON_ONCE(!lockdep_commit_lock_is_held(gc->net));
+
+	list_for_each_entry_safe(catchall, next, &set->catchall_list, list) {
+		ext = nft_set_elem_ext(set, catchall->elem);
+
+		if (!nft_set_elem_expired(ext))
+			continue;
+
+		gc = nft_trans_gc_queue_sync(gc, GFP_KERNEL);
+		if (!gc)
+			return NULL;
+
+		memset(&elem, 0, sizeof(elem));
+		elem.priv = catchall->elem;
+
+		nft_setelem_data_deactivate(gc->net, gc->set, &elem);
+		nft_setelem_catchall_destroy(catchall);
+		nft_trans_gc_elem_add(gc, elem.priv);
+	}
+
+	return gc;
 }
 
 static void nf_tables_module_autoload_cleanup(struct net *net)
-- 
2.42.0




