Return-Path: <stable+bounces-180035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A06B7E60F
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D33018890FB
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82C830AD1E;
	Wed, 17 Sep 2025 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yPHHZBCA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EA72F5A2E;
	Wed, 17 Sep 2025 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113172; cv=none; b=t0CDKC9zRS3QnwxB1rvp8OKYFvGsJWD1shePL+SGDRNQVYZKLLbobQxEfHhkQ9OW8Ok1qA3nRa0nD7CeXPYceFD9Lg1wxhNzQe9c8J7jRJEHQMVRBmTRp6yNf7T9tEgPaYQdcGEjKdokPRY4+iH9ckgPwV39V0SxGke4MujYxVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113172; c=relaxed/simple;
	bh=GgiVIQTOj5pBKbfoDwaDFhpGfNm2xyWzYU/L5XL6YW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OB9crkwYHvnK4vFBGSco63c9K3++sVUxQIX0etXSPSQHlYz3jOofNqLidIKtvV9LREtzf1nMtSa+3JZhUDvsbOIwci7zhmzpZXHtNqHEnDJsd99agqLYJK0U+jCVWITWI/+3hzid5VZTAz6WMAnkYRmnugDEsKtYhZgdi6CAh8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yPHHZBCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCCBBC4CEF0;
	Wed, 17 Sep 2025 12:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758113172;
	bh=GgiVIQTOj5pBKbfoDwaDFhpGfNm2xyWzYU/L5XL6YW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yPHHZBCA86Sz8yfw00BeS7QghVO9+rvDu5FwsE7u5p5uHovXqqVICcvx13bh7nivP
	 JlIU2NyaeaKpcNCOUZPTLRnmehE3z2j71wVrwFkML+zXwik9813LY7TiTvDy/LTSHd
	 uRTGot1OhCf7C22pOkmFhtl8D178dSxcalMCYMFU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefano Brivio <sbrivio@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 157/189] netfilter: nft_set_pipapo: dont check genbit from packetpath lookups
Date: Wed, 17 Sep 2025 14:34:27 +0200
Message-ID: <20250917123355.711754369@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123351.839989757@linuxfoundation.org>
References: <20250917123351.839989757@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit c4eaca2e1052adfd67bed0a36a9d4b8e515666e4 ]

The pipapo set type is special in that it has two copies of its
datastructure: one live copy containing only valid elements and one
on-demand clone used during transaction where adds/deletes happen.

This clone is not visible to the datapath.

This is unlike all other set types in nftables, those all link new
elements into their live hlist/tree.

For those sets, the lookup functions must skip the new elements while the
transaction is ongoing to ensure consistency.

As the clone is shallow, removal does have an effect on the packet path:
once the transaction enters the commit phase the 'gencursor' bit that
determines which elements are active and which elements should be ignored
(because they are no longer valid) is flipped.

This causes the datapath lookup to ignore these elements if they are found
during lookup.

This opens up a small race window where pipapo has an inconsistent view of
the dataset from when the transaction-cpu flipped the genbit until the
transaction-cpu calls nft_pipapo_commit() to swap live/clone pointers:

cpu0					cpu1
  has added new elements to clone
  has marked elements as being
  inactive in new generation
					perform lookup in the set
  enters commit phase:

I) increments the genbit
					A) observes new genbit
  removes elements from the clone so
  they won't be found anymore
					B) lookup in datastructure
					   can't see new elements yet,
					   but old elements are ignored
					   -> Only matches elements that
					   were not changed in the
					   transaction
II) calls nft_pipapo_commit(), clone
    and live pointers are swapped.
					C New nft_lookup happening now
				       	  will find matching elements.

Consider a packet matching range r1-r2:

cpu0 processes following transaction:
1. remove r1-r2
2. add r1-r3

P is contained in both ranges. Therefore, cpu1 should always find a match
for P.  Due to above race, this is not the case:

cpu1 does find r1-r2, but then ignores it due to the genbit indicating
the range has been removed.

At the same time, r1-r3 is not visible yet, because it can only be found
in the clone.

The situation persists for all lookups until after cpu0 hits II).

The fix is easy: Don't check the genbit from pipapo lookup functions.
This is possible because unlike the other set types, the new elements are
not reachable from the live copy of the dataset.

The clone/live pointer swap is enough to avoid matching on old elements
while at the same time all new elements are exposed in one go.

After this change, step B above returns a match in r1-r2.
This is fine: r1-r2 only becomes truly invalid the moment they get freed.
This happens after a synchronize_rcu() call and rcu read lock is held
via netfilter hook traversal (nf_hook_slow()).

Cc: Stefano Brivio <sbrivio@redhat.com>
Fixes: 3c4287f62044 ("nf_tables: Add set type for arbitrary concatenation of ranges")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_set_pipapo.c      | 20 ++++++++++++++++++--
 net/netfilter/nft_set_pipapo_avx2.c |  4 +---
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 1a19649c28511..fa6741b3205a6 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -511,6 +511,23 @@ static struct nft_pipapo_elem *pipapo_get(const struct nft_pipapo_match *m,
  *
  * This function is called from the data path.  It will search for
  * an element matching the given key in the current active copy.
+ * Unlike other set types, this uses NFT_GENMASK_ANY instead of
+ * nft_genmask_cur().
+ *
+ * This is because new (future) elements are not reachable from
+ * priv->match, they get added to priv->clone instead.
+ * When the commit phase flips the generation bitmask, the
+ * 'now old' entries are skipped but without the 'now current'
+ * elements becoming visible. Using nft_genmask_cur() thus creates
+ * inconsistent state: matching old entries get skipped but thew
+ * newly matching entries are unreachable.
+ *
+ * GENMASK will still find the 'now old' entries which ensures consistent
+ * priv->match view.
+ *
+ * nft_pipapo_commit swaps ->clone and ->match shortly after the
+ * genbit flip.  As ->clone doesn't contain the old entries in the first
+ * place, lookup will only find the now-current ones.
  *
  * Return: ntables API extension pointer or NULL if no match.
  */
@@ -519,12 +536,11 @@ nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 		  const u32 *key)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
-	u8 genmask = nft_genmask_cur(net);
 	const struct nft_pipapo_match *m;
 	const struct nft_pipapo_elem *e;
 
 	m = rcu_dereference(priv->match);
-	e = pipapo_get(m, (const u8 *)key, genmask, get_jiffies_64());
+	e = pipapo_get(m, (const u8 *)key, NFT_GENMASK_ANY, get_jiffies_64());
 
 	return e ? &e->ext : NULL;
 }
diff --git a/net/netfilter/nft_set_pipapo_avx2.c b/net/netfilter/nft_set_pipapo_avx2.c
index 2155c7f345c21..39e356c9687a9 100644
--- a/net/netfilter/nft_set_pipapo_avx2.c
+++ b/net/netfilter/nft_set_pipapo_avx2.c
@@ -1153,7 +1153,6 @@ nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 	struct nft_pipapo *priv = nft_set_priv(set);
 	const struct nft_set_ext *ext = NULL;
 	struct nft_pipapo_scratch *scratch;
-	u8 genmask = nft_genmask_cur(net);
 	const struct nft_pipapo_match *m;
 	const struct nft_pipapo_field *f;
 	const u8 *rp = (const u8 *)key;
@@ -1249,8 +1248,7 @@ nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 		if (last) {
 			const struct nft_set_ext *e = &f->mt[ret].e->ext;
 
-			if (unlikely(nft_set_elem_expired(e) ||
-				     !nft_set_elem_active(e, genmask)))
+			if (unlikely(nft_set_elem_expired(e)))
 				goto next_match;
 
 			ext = e;
-- 
2.51.0




