Return-Path: <stable+bounces-19812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7979085375E
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 18:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F382D1F2391E
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 17:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1246024B;
	Tue, 13 Feb 2024 17:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nt9Jz8vd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0B55FEFA;
	Tue, 13 Feb 2024 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845073; cv=none; b=BJLcSpBKudxlV0M7JqGu909Vavnn/xWcMioKctd3ENDnU1KB5f5fhwTyqnWBxIs7mSAMsNc1qU60MvsZ5b24/3LBla+xUm2tTwCA1H39K8+uy0v0icYqv7C+aVzJOhuEvNv+bL3Q8EyhhN1cA+SDtgy+xcJA14MWyVZ/BNiKuzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845073; c=relaxed/simple;
	bh=/gIMbJ5n81dRkPZ7D5cqlISElaIQdvbSFncclk8SCr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDUSNoPm7QCKJ34KUAToDAwmtfp6oQIFZbDqBwkiR9LmbYUIuNtQ3oBDqD0HXigUmHWge6uAw8vND/RUcuEW+juIjW6RFGcJ8aqSgJm9xU74ZtjW55t5lCjNsA+A/ueGdSxe9SFroxNQamufbeFFidg084VXCipaFUjztSzx1Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nt9Jz8vd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DBCC43390;
	Tue, 13 Feb 2024 17:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707845072;
	bh=/gIMbJ5n81dRkPZ7D5cqlISElaIQdvbSFncclk8SCr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nt9Jz8vdfb59ir4HM5s+DBtrS/MNZwUwvdSwruy0ZSNnMMqwghaP3I1ml+3glWMdT
	 VU/GcMXmqC0Sh9pVwLJgGw/SjF88z151BVSy+eCVVCTvNrfQXnJ88JoAL6qZWpLKMA
	 Q/QsbhP3KTW/sLqwr/kVOMX/Usp7Z+0obWNmtmBI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefano Brivio <sbrivio@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 39/64] netfilter: nft_set_pipapo: remove scratch_aligned pointer
Date: Tue, 13 Feb 2024 18:21:25 +0100
Message-ID: <20240213171845.978724112@linuxfoundation.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240213171844.702064831@linuxfoundation.org>
References: <20240213171844.702064831@linuxfoundation.org>
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

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 5a8cdf6fd860ac5e6d08d72edbcecee049a7fec4 ]

use ->scratch for both avx2 and the generic implementation.

After previous change the scratch->map member is always aligned properly
for AVX2, so we can just use scratch->map in AVX2 too.

The alignoff delta is stored in the scratchpad so we can reconstruct
the correct address to free the area again.

Fixes: 7400b063969b ("nft_set_pipapo: Introduce AVX2-based lookup implementation")
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_set_pipapo.c      | 41 +++++------------------------
 net/netfilter/nft_set_pipapo.h      |  6 ++---
 net/netfilter/nft_set_pipapo_avx2.c |  2 +-
 3 files changed, 10 insertions(+), 39 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 977bf724fb7e..e1969209b3ab 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1116,6 +1116,7 @@ static void pipapo_free_scratch(const struct nft_pipapo_match *m, unsigned int c
 		return;
 
 	mem = s;
+	mem -= s->align_off;
 	kfree(mem);
 }
 
@@ -1135,6 +1136,7 @@ static int pipapo_realloc_scratch(struct nft_pipapo_match *clone,
 		struct nft_pipapo_scratch *scratch;
 #ifdef NFT_PIPAPO_ALIGN
 		void *scratch_aligned;
+		u32 align_off;
 #endif
 		scratch = kzalloc_node(struct_size(scratch, map,
 						   bsize_max * 2) +
@@ -1153,8 +1155,6 @@ static int pipapo_realloc_scratch(struct nft_pipapo_match *clone,
 
 		pipapo_free_scratch(clone, i);
 
-		*per_cpu_ptr(clone->scratch, i) = scratch;
-
 #ifdef NFT_PIPAPO_ALIGN
 		/* Align &scratch->map (not the struct itself): the extra
 		 * %NFT_PIPAPO_ALIGN_HEADROOM bytes passed to kzalloc_node()
@@ -1166,8 +1166,12 @@ static int pipapo_realloc_scratch(struct nft_pipapo_match *clone,
 
 		scratch_aligned = NFT_PIPAPO_LT_ALIGN(&scratch->map);
 		scratch_aligned -= offsetof(struct nft_pipapo_scratch, map);
-		*per_cpu_ptr(clone->scratch_aligned, i) = scratch_aligned;
+		align_off = scratch_aligned - (void *)scratch;
+
+		scratch = scratch_aligned;
+		scratch->align_off = align_off;
 #endif
+		*per_cpu_ptr(clone->scratch, i) = scratch;
 	}
 
 	return 0;
@@ -1321,11 +1325,6 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 	if (!new->scratch)
 		goto out_scratch;
 
-#ifdef NFT_PIPAPO_ALIGN
-	new->scratch_aligned = alloc_percpu(*new->scratch_aligned);
-	if (!new->scratch_aligned)
-		goto out_scratch;
-#endif
 	for_each_possible_cpu(i)
 		*per_cpu_ptr(new->scratch, i) = NULL;
 
@@ -1378,9 +1377,6 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 out_scratch_realloc:
 	for_each_possible_cpu(i)
 		pipapo_free_scratch(new, i);
-#ifdef NFT_PIPAPO_ALIGN
-	free_percpu(new->scratch_aligned);
-#endif
 out_scratch:
 	free_percpu(new->scratch);
 	kfree(new);
@@ -1667,11 +1663,7 @@ static void pipapo_free_match(struct nft_pipapo_match *m)
 	for_each_possible_cpu(i)
 		pipapo_free_scratch(m, i);
 
-#ifdef NFT_PIPAPO_ALIGN
-	free_percpu(m->scratch_aligned);
-#endif
 	free_percpu(m->scratch);
-
 	pipapo_free_fields(m);
 
 	kfree(m);
@@ -2167,16 +2159,6 @@ static int nft_pipapo_init(const struct nft_set *set,
 	for_each_possible_cpu(i)
 		*per_cpu_ptr(m->scratch, i) = NULL;
 
-#ifdef NFT_PIPAPO_ALIGN
-	m->scratch_aligned = alloc_percpu(struct nft_pipapo_scratch *);
-	if (!m->scratch_aligned) {
-		err = -ENOMEM;
-		goto out_free;
-	}
-	for_each_possible_cpu(i)
-		*per_cpu_ptr(m->scratch_aligned, i) = NULL;
-#endif
-
 	rcu_head_init(&m->rcu);
 
 	nft_pipapo_for_each_field(f, i, m) {
@@ -2207,9 +2189,6 @@ static int nft_pipapo_init(const struct nft_set *set,
 	return 0;
 
 out_free:
-#ifdef NFT_PIPAPO_ALIGN
-	free_percpu(m->scratch_aligned);
-#endif
 	free_percpu(m->scratch);
 out_scratch:
 	kfree(m);
@@ -2263,9 +2242,6 @@ static void nft_pipapo_destroy(const struct nft_ctx *ctx,
 
 		nft_set_pipapo_match_destroy(ctx, set, m);
 
-#ifdef NFT_PIPAPO_ALIGN
-		free_percpu(m->scratch_aligned);
-#endif
 		for_each_possible_cpu(cpu)
 			pipapo_free_scratch(m, cpu);
 		free_percpu(m->scratch);
@@ -2280,9 +2256,6 @@ static void nft_pipapo_destroy(const struct nft_ctx *ctx,
 		if (priv->dirty)
 			nft_set_pipapo_match_destroy(ctx, set, m);
 
-#ifdef NFT_PIPAPO_ALIGN
-		free_percpu(priv->clone->scratch_aligned);
-#endif
 		for_each_possible_cpu(cpu)
 			pipapo_free_scratch(priv->clone, cpu);
 		free_percpu(priv->clone->scratch);
diff --git a/net/netfilter/nft_set_pipapo.h b/net/netfilter/nft_set_pipapo.h
index de96e1a01dc0..30a3d092cd84 100644
--- a/net/netfilter/nft_set_pipapo.h
+++ b/net/netfilter/nft_set_pipapo.h
@@ -133,10 +133,12 @@ struct nft_pipapo_field {
 /**
  * struct nft_pipapo_scratch - percpu data used for lookup and matching
  * @map_index:	Current working bitmap index, toggled between field matches
+ * @align_off:	Offset to get the originally allocated address
  * @map:	store partial matching results during lookup
  */
 struct nft_pipapo_scratch {
 	u8 map_index;
+	u32 align_off;
 	unsigned long map[];
 };
 
@@ -144,16 +146,12 @@ struct nft_pipapo_scratch {
  * struct nft_pipapo_match - Data used for lookup and matching
  * @field_count		Amount of fields in set
  * @scratch:		Preallocated per-CPU maps for partial matching results
- * @scratch_aligned:	Version of @scratch aligned to NFT_PIPAPO_ALIGN bytes
  * @bsize_max:		Maximum lookup table bucket size of all fields, in longs
  * @rcu			Matching data is swapped on commits
  * @f:			Fields, with lookup and mapping tables
  */
 struct nft_pipapo_match {
 	int field_count;
-#ifdef NFT_PIPAPO_ALIGN
-	struct nft_pipapo_scratch * __percpu *scratch_aligned;
-#endif
 	struct nft_pipapo_scratch * __percpu *scratch;
 	size_t bsize_max;
 	struct rcu_head rcu;
diff --git a/net/netfilter/nft_set_pipapo_avx2.c b/net/netfilter/nft_set_pipapo_avx2.c
index 78213c73af2e..90e275bb3e5d 100644
--- a/net/netfilter/nft_set_pipapo_avx2.c
+++ b/net/netfilter/nft_set_pipapo_avx2.c
@@ -1139,7 +1139,7 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 	 */
 	kernel_fpu_begin_mask(0);
 
-	scratch = *raw_cpu_ptr(m->scratch_aligned);
+	scratch = *raw_cpu_ptr(m->scratch);
 	if (unlikely(!scratch)) {
 		kernel_fpu_end();
 		return false;
-- 
2.43.0




