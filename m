Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3497B872B
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243696AbjJDSCW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243680AbjJDSCV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:02:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03415A6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:02:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B936C433C9;
        Wed,  4 Oct 2023 18:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442537;
        bh=J/dA9Di1OvbhuFh8EDaUpRBftdRhXwatyldbezyqyO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vlKzPuhlT3aeCwEuF8BiZdAFV6SKazUtQZtfYgzSz8ei6uwhg8hPXRXpHno+JDwMm
         hw0qA07zWUQl29kNQKFSleK6cXECC9khSnCwCrFv0HlNqPK+rJx1Zn+U9VtP5daF/8
         uVhdsAnChmoxf8Pp+lW2SSj8lvdvX96wc0s/QucI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 020/183] netfilter: nft_set_hash: mark set element as dead when deleting from packet path
Date:   Wed,  4 Oct 2023 19:54:11 +0200
Message-ID: <20231004175204.811645645@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

upstream c92db3030492b8ad1d0faace7a93bbcf53850d0c commit.

Set on the NFT_SET_ELEM_DEAD_BIT flag on this element, instead of
performing element removal which might race with an ongoing transaction.
Enable gc when dynamic flag is set on since dynset deletion requires
garbage collection after this patch.

Fixes: d0a8d877da97 ("netfilter: nft_dynset: support for element deletion")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.40.1



