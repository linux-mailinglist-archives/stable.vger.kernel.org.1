Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656F8735556
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 13:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjFSLDo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 07:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjFSLDI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 07:03:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3561510F0
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 04:02:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C29C160B5B
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 11:02:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D055CC433C0;
        Mon, 19 Jun 2023 11:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172538;
        bh=oXugRJxy/rj3R/609zyWZR65FEM7OQqm2vyVMHsWTYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BfANcg3rGreHGN17ScVZIwdlt06m35id7RRf1W9zO1RO/KgZaecKzllyhLgJK5lim
         uMFnx3DTforP2icq5ZIO2UsXlwRZv+yhqcZ8i4hvh/r1GTZ0ce1d71U1rKQvjzZGeK
         Jg8dCfEaDZ/wpfpQpmLKkWK99+695zj4ihSnkWck=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Leon Romanovsky <leonro@nvidia.com>,
        Eric Dumazet <edumazet@google.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 104/107] neighbour: delete neigh_lookup_nodev as not used
Date:   Mon, 19 Jun 2023 12:31:28 +0200
Message-ID: <20230619102146.279982624@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102141.541044823@linuxfoundation.org>
References: <20230619102141.541044823@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

commit 76b9bf965c98c9b53ef7420b3b11438dbd764f92 upstream.

neigh_lookup_nodev isn't used in the kernel after removal
of DECnet. So let's remove it.

Fixes: 1202cdd66531 ("Remove DECnet support from kernel")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://lore.kernel.org/r/eb5656200d7964b2d177a36b77efa3c597d6d72d.1678267343.git.leonro@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/neighbour.h |    2 --
 net/core/neighbour.c    |   31 -------------------------------
 2 files changed, 33 deletions(-)

--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -309,8 +309,6 @@ void neigh_table_init(int index, struct
 int neigh_table_clear(int index, struct neigh_table *tbl);
 struct neighbour *neigh_lookup(struct neigh_table *tbl, const void *pkey,
 			       struct net_device *dev);
-struct neighbour *neigh_lookup_nodev(struct neigh_table *tbl, struct net *net,
-				     const void *pkey);
 struct neighbour *__neigh_create(struct neigh_table *tbl, const void *pkey,
 				 struct net_device *dev, bool want_ref);
 static inline struct neighbour *neigh_create(struct neigh_table *tbl,
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -570,37 +570,6 @@ struct neighbour *neigh_lookup(struct ne
 }
 EXPORT_SYMBOL(neigh_lookup);
 
-struct neighbour *neigh_lookup_nodev(struct neigh_table *tbl, struct net *net,
-				     const void *pkey)
-{
-	struct neighbour *n;
-	unsigned int key_len = tbl->key_len;
-	u32 hash_val;
-	struct neigh_hash_table *nht;
-
-	NEIGH_CACHE_STAT_INC(tbl, lookups);
-
-	rcu_read_lock_bh();
-	nht = rcu_dereference_bh(tbl->nht);
-	hash_val = tbl->hash(pkey, NULL, nht->hash_rnd) >> (32 - nht->hash_shift);
-
-	for (n = rcu_dereference_bh(nht->hash_buckets[hash_val]);
-	     n != NULL;
-	     n = rcu_dereference_bh(n->next)) {
-		if (!memcmp(n->primary_key, pkey, key_len) &&
-		    net_eq(dev_net(n->dev), net)) {
-			if (!refcount_inc_not_zero(&n->refcnt))
-				n = NULL;
-			NEIGH_CACHE_STAT_INC(tbl, hits);
-			break;
-		}
-	}
-
-	rcu_read_unlock_bh();
-	return n;
-}
-EXPORT_SYMBOL(neigh_lookup_nodev);
-
 static struct neighbour *
 ___neigh_create(struct neigh_table *tbl, const void *pkey,
 		struct net_device *dev, u8 flags,


