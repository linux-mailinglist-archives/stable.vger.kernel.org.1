Return-Path: <stable+bounces-219221-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePpxOamdnmkZWgQAu9opvQ
	(envelope-from <stable+bounces-219221-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:58:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 653C2192A64
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 983FA30C3999
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BE32C21F1;
	Wed, 25 Feb 2026 06:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UxGxXkLB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27F52C17A0;
	Wed, 25 Feb 2026 06:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002572; cv=none; b=tHTXeinD8SnoxX38UWP6sptPhPh/vKNyBkh/bs3GOxYXvWWUbDz5wvtG+m/tcjoYJXgZtHfSDc9+xzQw0QGu4L/x0oebg0Cnl7MMFnIMfZlox10vku0c8S3VTf0wZqJeqRSqapOfFAbpubwJ2ThT986zixYJgmGpB970L0EWtok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002572; c=relaxed/simple;
	bh=gk8ZIFHNVdKD5ltqqKO12rjL/u7lXbh5L5klznygEXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2i0sZBzXGRDUC2DmXECKMyJ0vaQZJzkKmRoipsda/PeGfG+O1qLtvh2wSctSVtTbxX8LYsBUq0ywdiu/FgkRT9x2AqqN96beyZySN8IazT4IRvlSB8VAhWA1soHdMDj25qBwvWT2jiufxcZufwuOUuwzK9Syd4EqO3EPXh/Tms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UxGxXkLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FB4C116D0;
	Wed, 25 Feb 2026 06:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002571;
	bh=gk8ZIFHNVdKD5ltqqKO12rjL/u7lXbh5L5klznygEXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UxGxXkLB1vTlT8feJQULHYV4ikgt+Iirp+u5NeQPaUXX/Yvz/0kERRJG9ZrdVtheT
	 zcMN2NfLfSdF2k/G1zFsd7nZ3uVOF9A7mZRrQ1ZJA+bQo39egC3bBDzUR48OCJZ+lv
	 6jdH6VaQj8uoesOrrVpJzkKNVFhMWM9PG0U2VDh8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 306/641] netfilter: nft_set_hash: fix get operation on big endian
Date: Tue, 24 Feb 2026 17:20:32 -0800
Message-ID: <20260225012356.151524823@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-219221-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 653C2192A64
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 2f635adbe2642d398a0be3ab245accd2987be0c3 ]

tests/shell/testcases/packetpath/set_match_nomatch_hash_fast
fails on big endian with:

Error: Could not process rule: No such file or directory
reset element ip test s { 244.147.90.126 }
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Fatal: Cannot fetch element "244.147.90.126"

... because the wrong bucket is searched, jhash() and jhash1_word are
not interchangeable on big endian.

Fixes: 3b02b0adc242 ("netfilter: nft_set_hash: fix lookups with fixed size hash on big endian")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_set_hash.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index ba01ce75d6dea..739b992bde591 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -619,15 +619,20 @@ static struct nft_elem_priv *
 nft_hash_get(const struct net *net, const struct nft_set *set,
 	     const struct nft_set_elem *elem, unsigned int flags)
 {
+	const u32 *key = (const u32 *)&elem->key.val;
 	struct nft_hash *priv = nft_set_priv(set);
 	u8 genmask = nft_genmask_cur(net);
 	struct nft_hash_elem *he;
 	u32 hash;
 
-	hash = jhash(elem->key.val.data, set->klen, priv->seed);
+	if (set->klen == 4)
+		hash = jhash_1word(*key, priv->seed);
+	else
+		hash = jhash(key, set->klen, priv->seed);
+
 	hash = reciprocal_scale(hash, priv->buckets);
 	hlist_for_each_entry_rcu(he, &priv->table[hash], node) {
-		if (!memcmp(nft_set_ext_key(&he->ext), elem->key.val.data, set->klen) &&
+		if (!memcmp(nft_set_ext_key(&he->ext), key, set->klen) &&
 		    nft_set_elem_active(&he->ext, genmask))
 			return &he->priv;
 	}
-- 
2.51.0




