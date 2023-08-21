Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6D67832F0
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjHUUHw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjHUUHw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:07:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE5AE3
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:07:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE228649C3
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE74C433C8;
        Mon, 21 Aug 2023 20:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648469;
        bh=1Y3djnkq4GcPRyptUoXXY6BGPdqFi+uZWkc2soq5ePw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1JtlyDyjKLnMqp7+yp5wqp2Iz9hu4jJz+ilDs5zYQhvm5VLqX/HI/zLrC2SOTF+XV
         6rLm+vVVayyD7sh4s3R++PWH49RL8/a79VsVVX5QsqHtMKpN2Dbd1V8giTFOgEBm5v
         azOAXw2Jko1cGUBaWhXebDpRDeOLITovzWcmKqqk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 159/234] netfilter: nf_tables: dont fail inserts if duplicate has expired
Date:   Mon, 21 Aug 2023 21:42:02 +0200
Message-ID: <20230821194135.843121383@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 7845914f45f066497ac75b30c50dbc735e84e884 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_set_pipapo.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 3b5c3919fff9c..352180b123fc7 100644
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
@@ -1744,11 +1737,7 @@ static void nft_pipapo_activate(const struct net *net,
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
@@ -1962,10 +1951,6 @@ static void nft_pipapo_remove(const struct net *net, const struct nft_set *set,
 
 	data = (const u8 *)nft_set_ext_key(&e->ext);
 
-	e = pipapo_get(net, set, data, 0);
-	if (IS_ERR(e))
-		return;
-
 	while ((rules_f0 = pipapo_rules_same_key(m->f, first_rule))) {
 		union nft_pipapo_map_bucket rulemap[NFT_PIPAPO_MAX_FIELDS];
 		const u8 *match_start, *match_end;
-- 
2.40.1



