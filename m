Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76747BE16D
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377327AbjJINuO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377379AbjJINuL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:50:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03220F2
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:50:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37868C433CA;
        Mon,  9 Oct 2023 13:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859407;
        bh=+unnAK5f2fw3Jbf9ueCXelZG34OwQWBFUzL90qx0D8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=etb/6JR8AcrT9lojDJfY+oStsb8SFOxphISRndZ6bO8B4kHnAFSmPJwIGhFhFJYMj
         aNkPv0HyYw+6eEiGeYemA2cvo9MPEQ9Ee/AZrGgi6aXvzgSCuD27KrodEKcfyPwB+1
         6K/VYPoHaNqBCwjotelFz49O4V8lbvcM+wNXiclE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 04/91] netfilter: nf_tables: disallow element removal on anonymous sets
Date:   Mon,  9 Oct 2023 15:05:36 +0200
Message-ID: <20231009130111.683800576@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.518916887@linuxfoundation.org>
References: <20231009130111.518916887@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 23a3bfd4ba7acd36abf52b78605f61b21bdac216 ]

Anonymous sets need to be populated once at creation and then they are
bound to rule since 938154b93be8 ("netfilter: nf_tables: reject unbound
anonymous set before commit phase"), otherwise transaction reports
EINVAL.

Userspace does not need to delete elements of anonymous sets that are
not yet bound, reject this with EOPNOTSUPP.

>From flush command path, skip anonymous sets, they are expected to be
bound already. Otherwise, EINVAL is hit at the end of this transaction
for unbound sets.

Fixes: 96518518cc41 ("netfilter: add nftables")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 0ff8f1006c6b9..3e30441162896 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -993,8 +993,7 @@ static int nft_flush_table(struct nft_ctx *ctx)
 		if (!nft_is_active_next(ctx->net, set))
 			continue;
 
-		if (nft_set_is_anonymous(set) &&
-		    !list_empty(&set->bindings))
+		if (nft_set_is_anonymous(set))
 			continue;
 
 		err = nft_delset(ctx, set);
@@ -4902,8 +4901,10 @@ static int nf_tables_delsetelem(struct net *net, struct sock *nlsk,
 	if (IS_ERR(set))
 		return PTR_ERR(set);
 
-	if (!list_empty(&set->bindings) &&
-	    (set->flags & (NFT_SET_CONSTANT | NFT_SET_ANONYMOUS)))
+	if (nft_set_is_anonymous(set))
+		return -EOPNOTSUPP;
+
+	if (!list_empty(&set->bindings) && (set->flags & NFT_SET_CONSTANT))
 		return -EBUSY;
 
 	if (nla[NFTA_SET_ELEM_LIST_ELEMENTS] == NULL) {
-- 
2.40.1



