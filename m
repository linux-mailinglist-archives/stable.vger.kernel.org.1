Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2EB7AB64F
	for <lists+stable@lfdr.de>; Fri, 22 Sep 2023 18:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjIVQnk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 22 Sep 2023 12:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbjIVQng (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 22 Sep 2023 12:43:36 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8EC7FCC9;
        Fri, 22 Sep 2023 09:43:21 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        sashal@kernel.org
Subject: [PATCH -stable,5.15 06/17] netfilter: nf_tables: don't fail inserts if duplicate has expired
Date:   Fri, 22 Sep 2023 18:43:02 +0200
Message-Id: <20230922164313.151564-7-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230922164313.151564-1-pablo@netfilter.org>
References: <20230922164313.151564-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

commit 7845914f45f066497ac75b30c50dbc735e84e884 upstream.

nftables selftests fail:
run-tests.sh testcases/sets/0044interval_overlap_0
Expected: 0-2 . 0-3, got:
W: [FAILED]     ./testcases/sets/0044interval_overlap_0: got 1

Insertion must ignore duplicate but expired entries.

Moreover, there is a strange asymmetry in nft_pipapo_activate:

It refetches the current element, whereas the other ->activate callbacks
(bitmap, hash, rhash, rbtree) use elem->priv.
Same for .remove: other set implementations take elem->priv,
nft_pipapo_remove fetches elem->priv, then does a relookup,
remove this.

I suspect this was the reason for the change that prompted the
removal of the expired check in pipapo_get() in the first place,
but skipping exired elements there makes no sense to me, this helper
is used for normal get requests, insertions (duplicate check)
and deactivate callback.

In first two cases expired elements must be skipped.

For ->deactivate(), this gets called for DELSETELEM, so it
seems to me that expired elements should be skipped as well, i.e.
delete request should fail with -ENOENT error.

Fixes: 24138933b97b ("netfilter: nf_tables: don't skip expired elements during walk")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_set_pipapo.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index a307a227d28d..58bd514260b9 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -566,6 +566,8 @@ static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 			goto out;
 
 		if (last) {
+			if (nft_set_elem_expired(&f->mt[b].e->ext))
+				goto next_match;
 			if ((genmask &&
 			     !nft_set_elem_active(&f->mt[b].e->ext, genmask)))
 				goto next_match;
@@ -600,17 +602,8 @@ static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 static void *nft_pipapo_get(const struct net *net, const struct nft_set *set,
 			    const struct nft_set_elem *elem, unsigned int flags)
 {
-	struct nft_pipapo_elem *ret;
-
-	ret = pipapo_get(net, set, (const u8 *)elem->key.val.data,
+	return pipapo_get(net, set, (const u8 *)elem->key.val.data,
 			 nft_genmask_cur(net));
-	if (IS_ERR(ret))
-		return ret;
-
-	if (nft_set_elem_expired(&ret->ext))
-		return ERR_PTR(-ENOENT);
-
-	return ret;
 }
 
 /**
@@ -1751,11 +1744,7 @@ static void nft_pipapo_activate(const struct net *net,
 				const struct nft_set *set,
 				const struct nft_set_elem *elem)
 {
-	struct nft_pipapo_elem *e;
-
-	e = pipapo_get(net, set, (const u8 *)elem->key.val.data, 0);
-	if (IS_ERR(e))
-		return;
+	struct nft_pipapo_elem *e = elem->priv;
 
 	nft_set_elem_change_active(net, set, &e->ext);
 }
@@ -1969,10 +1958,6 @@ static void nft_pipapo_remove(const struct net *net, const struct nft_set *set,
 
 	data = (const u8 *)nft_set_ext_key(&e->ext);
 
-	e = pipapo_get(net, set, data, 0);
-	if (IS_ERR(e))
-		return;
-
 	while ((rules_f0 = pipapo_rules_same_key(m->f, first_rule))) {
 		union nft_pipapo_map_bucket rulemap[NFT_PIPAPO_MAX_FIELDS];
 		const u8 *match_start, *match_end;
-- 
2.30.2

