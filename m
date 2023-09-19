Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E357A7A6917
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 18:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjISQo6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 12:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjISQo5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 12:44:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CD690
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 09:44:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9D1C433C8;
        Tue, 19 Sep 2023 16:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695141891;
        bh=nP29xhndFjSWGfF0vTsZnVcqtUQMPqLUji/DjP0Iupk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L5rR4k2ct8V/DvS67lCHPne3LRQ9yLmDFDqQIcZic/7H8tBrO2DH4Tm6sHFqpytb3
         p76ihewU+cfFPeclmobttG4hLBkv69tgrM9txOimso9qEjPud3KnOSXpM5cGEQr1T6
         kARE8mA/mRs0ZZLzN7Y5KX3uzWCox2PZVQgHXIjhbujefQPx6xxw1SmWdI7GEFsSgM
         t/4ltV+qPwxOg3DmO9PLxChQGJy4rZrDg27FYQ0lky/yKevjWbJGH+oL1IdmkqPonx
         0uy+5pkr+PLA3FMjU7bNZ40RUZduvpPAv0mCJcePxxBNLqXBM5hprWv/pNOvDo2c3o
         zcrHmyDz+f40g==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, stable@vger.kernel.org
Cc:     pablo@netfilter.org, fw@strlen.de, Lee Jones <joneslee@google.com>
Subject: [PATCH 1/5] netfilter: nf_tables: don't skip expired elements during walk
Date:   Tue, 19 Sep 2023 17:44:29 +0100
Message-ID: <20230919164437.3297021-2-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230919164437.3297021-1-lee@kernel.org>
References: <20230919164437.3297021-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 24138933b97b055d486e8064b4a1721702442a9b ]

There is an asymmetry between commit/abort and preparation phase if the
following conditions are met:

1. set is a verdict map ("1.2.3.4 : jump foo")
2. timeouts are enabled

In this case, following sequence is problematic:

1. element E in set S refers to chain C
2. userspace requests removal of set S
3. kernel does a set walk to decrement chain->use count for all elements
   from preparation phase
4. kernel does another set walk to remove elements from the commit phase
   (or another walk to do a chain->use increment for all elements from
    abort phase)

If E has already expired in 1), it will be ignored during list walk, so its use count
won't have been changed.

Then, when set is culled, ->destroy callback will zap the element via
nf_tables_set_elem_destroy(), but this function is only safe for
elements that have been deactivated earlier from the preparation phase:
lack of earlier deactivate removes the element but leaks the chain use
count, which results in a WARN splat when the chain gets removed later,
plus a leak of the nft_chain structure.

Update pipapo_get() not to skip expired elements, otherwise flush
command reports bogus ENOENT errors.

Fixes: 3c4287f62044 ("nf_tables: Add set type for arbitrary concatenation of ranges")
Fixes: 8d8540c4f5e0 ("netfilter: nft_set_rbtree: add timeout support")
Fixes: 9d0982927e79 ("netfilter: nft_hash: add support for timeouts")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Lee Jones <joneslee@google.com>
---
 net/netfilter/nf_tables_api.c  |  4 ++++
 net/netfilter/nft_set_hash.c   |  2 --
 net/netfilter/nft_set_pipapo.c | 18 ++++++++++++------
 net/netfilter/nft_set_rbtree.c |  2 --
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 3c5cac9bd9b70..475c556f49912 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5386,8 +5386,12 @@ static int nf_tables_dump_setelem(const struct nft_ctx *ctx,
 				  const struct nft_set_iter *iter,
 				  struct nft_set_elem *elem)
 {
+	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
 	struct nft_set_dump_args *args;
 
+	if (nft_set_elem_expired(ext))
+		return 0;
+
 	args = container_of(iter, struct nft_set_dump_args, iter);
 	return nf_tables_fill_setelem(args->skb, set, elem);
 }
diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index 0b73cb0e752f7..24caa31fa2310 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -278,8 +278,6 @@ static void nft_rhash_walk(const struct nft_ctx *ctx, struct nft_set *set,
 
 		if (iter->count < iter->skip)
 			goto cont;
-		if (nft_set_elem_expired(&he->ext))
-			goto cont;
 		if (!nft_set_elem_active(&he->ext, iter->genmask))
 			goto cont;
 
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 8c16681884b7e..b6a994ba72f31 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -566,8 +566,7 @@ static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 			goto out;
 
 		if (last) {
-			if (nft_set_elem_expired(&f->mt[b].e->ext) ||
-			    (genmask &&
+			if ((genmask &&
 			     !nft_set_elem_active(&f->mt[b].e->ext, genmask)))
 				goto next_match;
 
@@ -601,8 +600,17 @@ static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 static void *nft_pipapo_get(const struct net *net, const struct nft_set *set,
 			    const struct nft_set_elem *elem, unsigned int flags)
 {
-	return pipapo_get(net, set, (const u8 *)elem->key.val.data,
-			  nft_genmask_cur(net));
+	struct nft_pipapo_elem *ret;
+
+	ret = pipapo_get(net, set, (const u8 *)elem->key.val.data,
+			 nft_genmask_cur(net));
+	if (IS_ERR(ret))
+		return ret;
+
+	if (nft_set_elem_expired(&ret->ext))
+		return ERR_PTR(-ENOENT);
+
+	return ret;
 }
 
 /**
@@ -2024,8 +2032,6 @@ static void nft_pipapo_walk(const struct nft_ctx *ctx, struct nft_set *set,
 			goto cont;
 
 		e = f->mt[r].e;
-		if (nft_set_elem_expired(&e->ext))
-			goto cont;
 
 		elem.priv = e;
 
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 8d73fffd2d09d..39956e5341c9e 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -552,8 +552,6 @@ static void nft_rbtree_walk(const struct nft_ctx *ctx,
 
 		if (iter->count < iter->skip)
 			goto cont;
-		if (nft_set_elem_expired(&rbe->ext))
-			goto cont;
 		if (!nft_set_elem_active(&rbe->ext, iter->genmask))
 			goto cont;
 
-- 
2.42.0.459.ge4e396fd5e-goog

