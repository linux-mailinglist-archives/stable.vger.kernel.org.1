Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FA57B87EE
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243915AbjJDSLB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243911AbjJDSLA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:11:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B23ABF
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:10:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B7FC433CB;
        Wed,  4 Oct 2023 18:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443056;
        bh=UpfNmkrrz+LZO0dXkXd+LokIA//pAnbbNSBCnZ0WPpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XYKbm0hNxvqhi+XVR7KEVeqS7QkqKSCWIHTsrxeXqN1G94HOeljn9Y8f30s2ksmZe
         gq0OxJoETLdDaTjfaDmkmpl9kAVGOoMSfq/BQtul4VjDC7cZg8ltXLeG9JKfEj3zBf
         OUaVcox83cBmpWewBs6CAHtGhonmxs5Suvh5K1Y8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 020/259] netfilter: nf_tables: dont skip expired elements during walk
Date:   Wed,  4 Oct 2023 19:53:13 +0200
Message-ID: <20231004175218.355052454@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 24138933b97b055d486e8064b4a1721702442a9b upstream.

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.40.1



