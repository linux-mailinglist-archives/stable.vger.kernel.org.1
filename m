Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655DC7A6919
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 18:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjISQpC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 12:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjISQpB (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 12:45:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9569690
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 09:44:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBD6C433CD;
        Tue, 19 Sep 2023 16:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695141896;
        bh=Otj2OUGwCOoeZdqPIyrIrVecOhhihCrCvEi7k4GHM84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j1gRQ/sq4Hy3azggoAZGDIbudx5HbCt9cpy+YbI8ALZ2cb4AmN/D+tcvWVF270oTN
         FmXsaPQ3AmuzO/2Uow1myyIRXshPY1ZGXjEq8BGQCgkJw6R6vHNrP/y3BxklRJEa8y
         TWQLTuGlhvnV7kP98jHOMn8sPeK6MSQHL926FDaiQZT5SYm7U4YKo/+i4m0ZRLsqNO
         O9QpAXjmCxllxcdnOSlwW9FRJ5wqpsXWy4ODa+xUNMhZLP3W1yWc9R95oso0I4cV/i
         SpXVfAaARBgkn5YrgVv4un2Zv4XsdMKykD/cHPW7tPwGknod7Q38YNrO9iOS+q1sQa
         ChZ0JCh2gIDKw==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, stable@vger.kernel.org
Cc:     pablo@netfilter.org, fw@strlen.de, Lee Jones <joneslee@google.com>
Subject: [PATCH 4/5] netfilter: nft_set_hash: mark set element as dead when deleting from packet path
Date:   Tue, 19 Sep 2023 17:44:32 +0100
Message-ID: <20230919164437.3297021-5-lee@kernel.org>
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

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit c92db3030492b8ad1d0faace7a93bbcf53850d0c ]

Set on the NFT_SET_ELEM_DEAD_BIT flag on this element, instead of
performing element removal which might race with an ongoing transaction.
Enable gc when dynamic flag is set on since dynset deletion requires
garbage collection after this patch.

Fixes: d0a8d877da97 ("netfilter: nft_dynset: support for element deletion")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Lee Jones <joneslee@google.com>
---
 net/netfilter/nft_set_hash.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index 2f067e4596b02..cef5df8460009 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -249,7 +249,9 @@ static bool nft_rhash_delete(const struct nft_set *set,
 	if (he == NULL)
 		return false;
 
-	return rhashtable_remove_fast(&priv->ht, &he->node, nft_rhash_params) == 0;
+	nft_set_elem_dead(&he->ext);
+
+	return true;
 }
 
 static void nft_rhash_walk(const struct nft_ctx *ctx, struct nft_set *set,
@@ -412,7 +414,7 @@ static int nft_rhash_init(const struct nft_set *set,
 		return err;
 
 	INIT_DEFERRABLE_WORK(&priv->gc_work, nft_rhash_gc);
-	if (set->flags & NFT_SET_TIMEOUT)
+	if (set->flags & (NFT_SET_TIMEOUT | NFT_SET_EVAL))
 		nft_rhash_gc_init(set);
 
 	return 0;
-- 
2.42.0.459.ge4e396fd5e-goog

