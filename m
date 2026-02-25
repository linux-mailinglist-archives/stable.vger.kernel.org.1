Return-Path: <stable+bounces-219228-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGxCLtWdnmkZWgQAu9opvQ
	(envelope-from <stable+bounces-219228-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:59:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAFA192ACF
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAA3130D6E1A
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4722D1F44;
	Wed, 25 Feb 2026 06:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q+BogKTj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6102C3252;
	Wed, 25 Feb 2026 06:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002578; cv=none; b=tGMNvM52evPH00vVf6ImX9L9Yyldhn0cJqGaobg7tVP/7Wp4tqMiMg6MDafOqSoXH/Olo6tEzUTpScL5SZ57ReIsqtlrzMtOUMNqN5H+g6srAyNwoBqKKB4MifkC9GwIPTyAqarxBkJAAe5zYgAmsMCMrEG6puefiBIhC83IIg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002578; c=relaxed/simple;
	bh=zg+Zkv7bH0/uNJIJT9+mlDCTqLg+86dB186Tiu1Vdbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZD1xmFoCIrAHwK7th6J0XORtpp5fqtVStXaqOuz/U3P0bwp0IqfVKzEEeADOE4lqv+dZIiqdLpiGcKItp8ekokX1SA/XWVQ5mre4kprsjjuLAfhIczPwA1uGB+JXlUCEyuKfx0orPtXQNgNnq5ltM9N/KsjLMptWDC21UDilBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q+BogKTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62840C116D0;
	Wed, 25 Feb 2026 06:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002578;
	bh=zg+Zkv7bH0/uNJIJT9+mlDCTqLg+86dB186Tiu1Vdbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q+BogKTjN8LhUwCoGbnwkcDDHh3MrXneuJcOAJTju0bKbtyaizbVerGP7oLGCYmrU
	 MpwmOv1ejSktF3xE9kpezB8hIJykjBSpzQuhXxLLkWwHG5s8BZYRm4DHMXHu7RpQ4E
	 zXROcwZi9EE5Ogb5VMKCBtMoSekagqZEel+ufLgs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 312/641] netfilter: nft_set_rbtree: remove seqcount_rwlock_t
Date: Tue, 24 Feb 2026 17:20:38 -0800
Message-ID: <20260225012356.287048293@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-219228-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,netfilter.org:email,strlen.de:email]
X-Rspamd-Queue-Id: 2FAFA192ACF
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 5599fa810b503eafc2bd8cd15bd45f35fc8ff6b9 ]

After the conversion to binary search array, this is not required anymore.
Remove it.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Stable-dep-of: 782f2688128e ("netfilter: nft_set_rbtree: validate element belonging to interval")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_set_rbtree.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 1b0502cc87301..6470bc5d38749 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -33,7 +33,6 @@ struct nft_rbtree {
 	rwlock_t		lock;
 	struct nft_array __rcu	*array;
 	struct nft_array	*array_next;
-	seqcount_rwlock_t	count;
 	unsigned long		last_gc;
 };
 
@@ -572,9 +571,7 @@ static int nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 		cond_resched();
 
 		write_lock_bh(&priv->lock);
-		write_seqcount_begin(&priv->count);
 		err = __nft_rbtree_insert(net, set, rbe, elem_priv);
-		write_seqcount_end(&priv->count);
 		write_unlock_bh(&priv->lock);
 	} while (err == -EAGAIN);
 
@@ -584,9 +581,7 @@ static int nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 static void nft_rbtree_erase(struct nft_rbtree *priv, struct nft_rbtree_elem *rbe)
 {
 	write_lock_bh(&priv->lock);
-	write_seqcount_begin(&priv->count);
 	rb_erase(&rbe->node, &priv->root);
-	write_seqcount_end(&priv->count);
 	write_unlock_bh(&priv->lock);
 }
 
@@ -798,7 +793,6 @@ static int nft_rbtree_init(const struct nft_set *set,
 	BUILD_BUG_ON(offsetof(struct nft_rbtree_elem, priv) != 0);
 
 	rwlock_init(&priv->lock);
-	seqcount_rwlock_init(&priv->count, &priv->lock);
 	priv->root = RB_ROOT;
 
 	priv->array = NULL;
-- 
2.51.0




