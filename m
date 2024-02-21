Return-Path: <stable+bounces-22367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1A785DBAE
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4387DB25AA5
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EB878B5E;
	Wed, 21 Feb 2024 13:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GxJi4zHp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32451E4B2;
	Wed, 21 Feb 2024 13:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523041; cv=none; b=hDnMN8ohXel2JZzZQLhJb58KaPxrZYrIc1f0J9GWjIVmLh3RYLKPnK4HQJKqPmG7bBhNqRxWXJXeZFU3ovJwSFSG0RdFcVzY9JhBZvaM55W9MV3t3bcYLlaDqVFuOa2NmHs3H064h2quWHY2Lbtj5Ik6BaUPwilnnmxnGD5ZOw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523041; c=relaxed/simple;
	bh=bZr9qt5KOT1oIYWW2CpGajATd3eUNUEOYyTNO8I+Wa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eg6pirugEX2OfDyBcu/HMbZfMZzjCaFIfYPtNNLdozylCVjof/AGylEULKTSvlhXQsIJcMI8JlFq67Bkc0uikSHfpyPKo5/e6alN0Ks97DtcNrmcFYa4TwKiJxuBdA/ivHB2sAB17A2H+yCQwD555GSsZYxXe+iDJpeAUPNUAys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GxJi4zHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33261C433C7;
	Wed, 21 Feb 2024 13:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708523041;
	bh=bZr9qt5KOT1oIYWW2CpGajATd3eUNUEOYyTNO8I+Wa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GxJi4zHpC8qRLXU1sdZzrnZEXcNy/WAUXFoPw7NpQgModj5TBOX9cnSWrBCiuwnDS
	 DMn8RHHhiGDT/+ApQgjDNMyiHODR6VSSPVQ8MugQeBQ9MF7rxmD995bbUdohViFzyr
	 G5RGHi2Ked/7MplZaXx02y3qQjtw81uFBZaIN/eI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefano Brivio <sbrivio@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 323/476] netfilter: nft_set_pipapo: store index in scratch maps
Date: Wed, 21 Feb 2024 14:06:14 +0100
Message-ID: <20240221130019.972229430@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221130007.738356493@linuxfoundation.org>
References: <20240221130007.738356493@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 76313d1a4aa9e30d5b43dee5efd8bcd4d8250006 ]

Pipapo needs a scratchpad area to keep state during matching.
This state can be large and thus cannot reside on stack.

Each set preallocates percpu areas for this.

On each match stage, one scratchpad half starts with all-zero and the other
is inited to all-ones.

At the end of each stage, the half that starts with all-ones is
always zero.  Before next field is tested, pointers to the two halves
are swapped, i.e.  resmap pointer turns into fill pointer and vice versa.

After the last field has been processed, pipapo stashes the
index toggle in a percpu variable, with assumption that next packet
will start with the all-zero half and sets all bits in the other to 1.

This isn't reliable.

There can be multiple sets and we can't be sure that the upper
and lower half of all set scratch map is always in sync (lookups
can be conditional), so one set might have swapped, but other might
not have been queried.

Thus we need to keep the index per-set-and-cpu, just like the
scratchpad.

Note that this bug fix is incomplete, there is a related issue.

avx2 and normal implementation might use slightly different areas of the
map array space due to the avx2 alignment requirements, so
m->scratch (generic/fallback implementation) and ->scratch_aligned
(avx) may partially overlap. scratch and scratch_aligned are not distinct
objects, the latter is just the aligned address of the former.

After this change, write to scratch_align->map_index may write to
scratch->map, so this issue becomes more prominent, we can set to 1
a bit in the supposedly-all-zero area of scratch->map[].

A followup patch will remove the scratch_aligned and makes generic and
avx code use the same (aligned) area.

Its done in a separate change to ease review.

Fixes: 3c4287f62044 ("nf_tables: Add set type for arbitrary concatenation of ranges")
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_set_pipapo.c      | 41 ++++++++++++++++++-----------
 net/netfilter/nft_set_pipapo.h      | 14 ++++++++--
 net/netfilter/nft_set_pipapo_avx2.c | 15 +++++------
 3 files changed, 44 insertions(+), 26 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 4e1cc31729b8..fbd0dbf9b965 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -342,9 +342,6 @@
 #include "nft_set_pipapo_avx2.h"
 #include "nft_set_pipapo.h"
 
-/* Current working bitmap index, toggled between field matches */
-static DEFINE_PER_CPU(bool, nft_pipapo_scratch_index);
-
 /**
  * pipapo_refill() - For each set bit, set bits from selected mapping table item
  * @map:	Bitmap to be scanned for set bits
@@ -412,6 +409,7 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 		       const u32 *key, const struct nft_set_ext **ext)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
+	struct nft_pipapo_scratch *scratch;
 	unsigned long *res_map, *fill_map;
 	u8 genmask = nft_genmask_cur(net);
 	const u8 *rp = (const u8 *)key;
@@ -422,15 +420,17 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 
 	local_bh_disable();
 
-	map_index = raw_cpu_read(nft_pipapo_scratch_index);
-
 	m = rcu_dereference(priv->match);
 
 	if (unlikely(!m || !*raw_cpu_ptr(m->scratch)))
 		goto out;
 
-	res_map  = *raw_cpu_ptr(m->scratch) + (map_index ? m->bsize_max : 0);
-	fill_map = *raw_cpu_ptr(m->scratch) + (map_index ? 0 : m->bsize_max);
+	scratch = *raw_cpu_ptr(m->scratch);
+
+	map_index = scratch->map_index;
+
+	res_map  = scratch->map + (map_index ? m->bsize_max : 0);
+	fill_map = scratch->map + (map_index ? 0 : m->bsize_max);
 
 	memset(res_map, 0xff, m->bsize_max * sizeof(*res_map));
 
@@ -460,7 +460,7 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 		b = pipapo_refill(res_map, f->bsize, f->rules, fill_map, f->mt,
 				  last);
 		if (b < 0) {
-			raw_cpu_write(nft_pipapo_scratch_index, map_index);
+			scratch->map_index = map_index;
 			local_bh_enable();
 
 			return false;
@@ -477,7 +477,7 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 			 * current inactive bitmap is clean and can be reused as
 			 * *next* bitmap (not initial) for the next packet.
 			 */
-			raw_cpu_write(nft_pipapo_scratch_index, map_index);
+			scratch->map_index = map_index;
 			local_bh_enable();
 
 			return true;
@@ -1114,12 +1114,12 @@ static int pipapo_realloc_scratch(struct nft_pipapo_match *clone,
 	int i;
 
 	for_each_possible_cpu(i) {
-		unsigned long *scratch;
+		struct nft_pipapo_scratch *scratch;
 #ifdef NFT_PIPAPO_ALIGN
-		unsigned long *scratch_aligned;
+		void *scratch_aligned;
 #endif
-
-		scratch = kzalloc_node(bsize_max * sizeof(*scratch) * 2 +
+		scratch = kzalloc_node(struct_size(scratch, map,
+						   bsize_max * 2) +
 				       NFT_PIPAPO_ALIGN_HEADROOM,
 				       GFP_KERNEL, cpu_to_node(i));
 		if (!scratch) {
@@ -1138,7 +1138,16 @@ static int pipapo_realloc_scratch(struct nft_pipapo_match *clone,
 		*per_cpu_ptr(clone->scratch, i) = scratch;
 
 #ifdef NFT_PIPAPO_ALIGN
-		scratch_aligned = NFT_PIPAPO_LT_ALIGN(scratch);
+		/* Align &scratch->map (not the struct itself): the extra
+		 * %NFT_PIPAPO_ALIGN_HEADROOM bytes passed to kzalloc_node()
+		 * above guarantee we can waste up to those bytes in order
+		 * to align the map field regardless of its offset within
+		 * the struct.
+		 */
+		BUILD_BUG_ON(offsetof(struct nft_pipapo_scratch, map) > NFT_PIPAPO_ALIGN_HEADROOM);
+
+		scratch_aligned = NFT_PIPAPO_LT_ALIGN(&scratch->map);
+		scratch_aligned -= offsetof(struct nft_pipapo_scratch, map);
 		*per_cpu_ptr(clone->scratch_aligned, i) = scratch_aligned;
 #endif
 	}
@@ -2132,7 +2141,7 @@ static int nft_pipapo_init(const struct nft_set *set,
 	m->field_count = field_count;
 	m->bsize_max = 0;
 
-	m->scratch = alloc_percpu(unsigned long *);
+	m->scratch = alloc_percpu(struct nft_pipapo_scratch *);
 	if (!m->scratch) {
 		err = -ENOMEM;
 		goto out_scratch;
@@ -2141,7 +2150,7 @@ static int nft_pipapo_init(const struct nft_set *set,
 		*per_cpu_ptr(m->scratch, i) = NULL;
 
 #ifdef NFT_PIPAPO_ALIGN
-	m->scratch_aligned = alloc_percpu(unsigned long *);
+	m->scratch_aligned = alloc_percpu(struct nft_pipapo_scratch *);
 	if (!m->scratch_aligned) {
 		err = -ENOMEM;
 		goto out_free;
diff --git a/net/netfilter/nft_set_pipapo.h b/net/netfilter/nft_set_pipapo.h
index 25a75591583e..de96e1a01dc0 100644
--- a/net/netfilter/nft_set_pipapo.h
+++ b/net/netfilter/nft_set_pipapo.h
@@ -130,6 +130,16 @@ struct nft_pipapo_field {
 	union nft_pipapo_map_bucket *mt;
 };
 
+/**
+ * struct nft_pipapo_scratch - percpu data used for lookup and matching
+ * @map_index:	Current working bitmap index, toggled between field matches
+ * @map:	store partial matching results during lookup
+ */
+struct nft_pipapo_scratch {
+	u8 map_index;
+	unsigned long map[];
+};
+
 /**
  * struct nft_pipapo_match - Data used for lookup and matching
  * @field_count		Amount of fields in set
@@ -142,9 +152,9 @@ struct nft_pipapo_field {
 struct nft_pipapo_match {
 	int field_count;
 #ifdef NFT_PIPAPO_ALIGN
-	unsigned long * __percpu *scratch_aligned;
+	struct nft_pipapo_scratch * __percpu *scratch_aligned;
 #endif
-	unsigned long * __percpu *scratch;
+	struct nft_pipapo_scratch * __percpu *scratch;
 	size_t bsize_max;
 	struct rcu_head rcu;
 	struct nft_pipapo_field f[];
diff --git a/net/netfilter/nft_set_pipapo_avx2.c b/net/netfilter/nft_set_pipapo_avx2.c
index 6f4116e72958..e608973587ee 100644
--- a/net/netfilter/nft_set_pipapo_avx2.c
+++ b/net/netfilter/nft_set_pipapo_avx2.c
@@ -71,9 +71,6 @@
 #define NFT_PIPAPO_AVX2_ZERO(reg)					\
 	asm volatile("vpxor %ymm" #reg ", %ymm" #reg ", %ymm" #reg)
 
-/* Current working bitmap index, toggled between field matches */
-static DEFINE_PER_CPU(bool, nft_pipapo_avx2_scratch_index);
-
 /**
  * nft_pipapo_avx2_prepare() - Prepare before main algorithm body
  *
@@ -1122,11 +1119,12 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 			    const u32 *key, const struct nft_set_ext **ext)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
-	unsigned long *res, *fill, *scratch;
+	struct nft_pipapo_scratch *scratch;
 	u8 genmask = nft_genmask_cur(net);
 	const u8 *rp = (const u8 *)key;
 	struct nft_pipapo_match *m;
 	struct nft_pipapo_field *f;
+	unsigned long *res, *fill;
 	bool map_index;
 	int i, ret = 0;
 
@@ -1148,10 +1146,11 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 		kernel_fpu_end();
 		return false;
 	}
-	map_index = raw_cpu_read(nft_pipapo_avx2_scratch_index);
 
-	res  = scratch + (map_index ? m->bsize_max : 0);
-	fill = scratch + (map_index ? 0 : m->bsize_max);
+	map_index = scratch->map_index;
+
+	res  = scratch->map + (map_index ? m->bsize_max : 0);
+	fill = scratch->map + (map_index ? 0 : m->bsize_max);
 
 	/* Starting map doesn't need to be set for this implementation */
 
@@ -1223,7 +1222,7 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 
 out:
 	if (i % 2)
-		raw_cpu_write(nft_pipapo_avx2_scratch_index, !map_index);
+		scratch->map_index = !map_index;
 	kernel_fpu_end();
 
 	return ret >= 0;
-- 
2.43.0




