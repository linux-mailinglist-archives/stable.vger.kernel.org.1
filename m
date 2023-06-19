Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCA4735459
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjFSKzL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjFSKye (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:54:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135FE10F4
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:53:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8874D60B88
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15FFC433C8;
        Mon, 19 Jun 2023 10:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171990;
        bh=7K7OaqpqCpOGcLdIrxF06hJCehC0z1AWyZo0oeWAAyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HtFneeYPyo92OrLIIVwgnNUDxuhTeaEr/OijDuC+cntftHjw5/MERJVz7Xr6UFJLs
         99pjuxRs2RuQ7M+NE9DNsh6IQN56qpqEZx+7JwvbDlFK4ylJOW/WXU2ZSC6oQq6VJo
         7Stsm+TmcL0CYQNcJJKYz9sJIIRRab5067PyV3Q4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Leon Romanovsky <leonro@nvidia.com>,
        Eric Dumazet <edumazet@google.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.4 62/64] neighbour: delete neigh_lookup_nodev as not used
Date:   Mon, 19 Jun 2023 12:30:58 +0200
Message-ID: <20230619102136.017055105@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102132.808972458@linuxfoundation.org>
References: <20230619102132.808972458@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
@@ -571,37 +571,6 @@ struct neighbour *neigh_lookup(struct ne
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


