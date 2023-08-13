Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7305677AD65
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjHMVs4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjHMVs0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:48:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9C61BF9
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:42:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E747A623FF
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0467FC433C8;
        Sun, 13 Aug 2023 21:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962928;
        bh=kWd2UDvlp47925AesQ9yZZB/LslHx/esUxeX+rW1+M0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n7L9GsQRJs4Mv0duwUvF8bVmWN3TgotPZ0L8NWo227XSnJzx8Ubv4ha0y1zslMw+n
         E4P4byWQ8qi/b1icAVdwWisVlIpa51WKpLnw0ng0D03fOAaytJAAHJDGewLez44JXe
         gEUXqL2JYUkOKn9PO3G87dnJ0ApYRx1oIuapen8s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.10 31/68] netfilter: nf_tables: dont skip expired elements during walk
Date:   Sun, 13 Aug 2023 23:19:32 +0200
Message-ID: <20230813211709.102802314@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211708.149630011@linuxfoundation.org>
References: <20230813211708.149630011@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_tables_api.c  |    4 ++++
 net/netfilter/nft_set_hash.c   |    2 --
 net/netfilter/nft_set_pipapo.c |   18 ++++++++++++------
 net/netfilter/nft_set_rbtree.c |    2 --
 4 files changed, 16 insertions(+), 10 deletions(-)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4911,8 +4911,12 @@ static int nf_tables_dump_setelem(const
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
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -277,8 +277,6 @@ static void nft_rhash_walk(const struct
 
 		if (iter->count < iter->skip)
 			goto cont;
-		if (nft_set_elem_expired(&he->ext))
-			goto cont;
 		if (!nft_set_elem_active(&he->ext, iter->genmask))
 			goto cont;
 
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -566,8 +566,7 @@ next_match:
 			goto out;
 
 		if (last) {
-			if (nft_set_elem_expired(&f->mt[b].e->ext) ||
-			    (genmask &&
+			if ((genmask &&
 			     !nft_set_elem_active(&f->mt[b].e->ext, genmask)))
 				goto next_match;
 
@@ -601,8 +600,17 @@ out:
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
@@ -1981,8 +1989,6 @@ static void nft_pipapo_walk(const struct
 			goto cont;
 
 		e = f->mt[r].e;
-		if (nft_set_elem_expired(&e->ext))
-			goto cont;
 
 		elem.priv = e;
 
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -551,8 +551,6 @@ static void nft_rbtree_walk(const struct
 
 		if (iter->count < iter->skip)
 			goto cont;
-		if (nft_set_elem_expired(&rbe->ext))
-			goto cont;
 		if (!nft_set_elem_active(&rbe->ext, iter->genmask))
 			goto cont;
 


