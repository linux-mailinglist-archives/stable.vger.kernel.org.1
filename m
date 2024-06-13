Return-Path: <stable+bounces-50679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CFC906BE0
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D88283B64
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16002143C5F;
	Thu, 13 Jun 2024 11:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J2+MHnsA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54A91448EB;
	Thu, 13 Jun 2024 11:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279070; cv=none; b=HJyfwd1huoJSsV+KE5a1u2H3z8YjrWXrm/vJ6ae6WURz5PBKkR+NGhl+AvIKQkWwJ0CJm4hISczMtW2CnbCKqprl7DsXHgOYbzu19JfBOTw+LQnVR++57cKfiDvzTzYV5BSUwKnvZUgDXcT2h8vX7pwAEweYkVt+NtyUYtlEJaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279070; c=relaxed/simple;
	bh=T6Nl7h6YT1bJwGVBtPyPbOZKURBYV36CJYmY6g+yLWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOCvasVqj1crWK6RU6krohtsbTxWgvg7wIndb7NyykGW+/yVhrEwYmSwYQi2V46h/8AupyuvlWw1nk8Yu89++sRvAg/BRStgP9mxp3c2PuJKUqYlgYITxdu3ICyteIdZ0QqoSJ9zt4cYWEhVdDuadflEW2YtjG74NUHyaFUxoZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J2+MHnsA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FE2C2BBFC;
	Thu, 13 Jun 2024 11:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718279070;
	bh=T6Nl7h6YT1bJwGVBtPyPbOZKURBYV36CJYmY6g+yLWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J2+MHnsA4VgnP88vxxKxh6EOrgPqK1hkcGGpRNhra0vJWeSpdShPMfOAO3qPdd9Yx
	 GyWyh0JLJu6XjgyK2i1o+DmAlqp57RuDFkTe4a2gPCAofrbrnmMc1sS5BlKUEuD8aP
	 /IQbSIRIYUhFPEcY5gp1Ew9zZio6dt+GZkJs/qBI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org,
	netfilter-devel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 165/213] netfilter: nft_set_rbtree: fix null deref on element insertion
Date: Thu, 13 Jun 2024 13:33:33 +0200
Message-ID: <20240613113234.350164799@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.969123070@linuxfoundation.org>
References: <20240613113227.969123070@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit 61ae320a29b0540c16931816299eb86bf2b66c08 upstream.

There is no guarantee that rb_prev() will not return NULL in nft_rbtree_gc_elem():

general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
 nft_add_set_elem+0x14b0/0x2990
  nf_tables_newsetelem+0x528/0xb30

Furthermore, there is a possible use-after-free while iterating,
'node' can be free'd so we need to cache the next value to use.

Fixes: c9e6978e2725 ("netfilter: nft_set_rbtree: Switch to node list walk for overlap detection")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nft_set_rbtree.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -223,7 +223,7 @@ static int nft_rbtree_gc_elem(const stru
 {
 	struct nft_set *set = (struct nft_set *)__set;
 	struct rb_node *prev = rb_prev(&rbe->node);
-	struct nft_rbtree_elem *rbe_prev;
+	struct nft_rbtree_elem *rbe_prev = NULL;
 	struct nft_set_gc_batch *gcb;
 
 	gcb = nft_set_gc_batch_check(set, NULL, GFP_ATOMIC);
@@ -231,17 +231,21 @@ static int nft_rbtree_gc_elem(const stru
 		return -ENOMEM;
 
 	/* search for expired end interval coming before this element. */
-	do {
+	while (prev) {
 		rbe_prev = rb_entry(prev, struct nft_rbtree_elem, node);
 		if (nft_rbtree_interval_end(rbe_prev))
 			break;
 
 		prev = rb_prev(prev);
-	} while (prev != NULL);
+	}
+
+	if (rbe_prev) {
+		rb_erase(&rbe_prev->node, &priv->root);
+		atomic_dec(&set->nelems);
+	}
 
-	rb_erase(&rbe_prev->node, &priv->root);
 	rb_erase(&rbe->node, &priv->root);
-	atomic_sub(2, &set->nelems);
+	atomic_dec(&set->nelems);
 
 	nft_set_gc_batch_add(gcb, rbe);
 	nft_set_gc_batch_complete(gcb);
@@ -270,7 +274,7 @@ static int __nft_rbtree_insert(const str
 			       struct nft_set_ext **ext)
 {
 	struct nft_rbtree_elem *rbe, *rbe_le = NULL, *rbe_ge = NULL;
-	struct rb_node *node, *parent, **p, *first = NULL;
+	struct rb_node *node, *next, *parent, **p, *first = NULL;
 	struct nft_rbtree *priv = nft_set_priv(set);
 	u8 genmask = nft_genmask_next(net);
 	int d, err;
@@ -309,7 +313,9 @@ static int __nft_rbtree_insert(const str
 	 * Values stored in the tree are in reversed order, starting from
 	 * highest to lowest value.
 	 */
-	for (node = first; node != NULL; node = rb_next(node)) {
+	for (node = first; node != NULL; node = next) {
+		next = rb_next(node);
+
 		rbe = rb_entry(node, struct nft_rbtree_elem, node);
 
 		if (!nft_set_elem_active(&rbe->ext, genmask))



