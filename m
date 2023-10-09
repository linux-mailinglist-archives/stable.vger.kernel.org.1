Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3337BDF51
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376954AbjJIN2l (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376953AbjJIN2k (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:28:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FDDC6
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:28:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70D4C433C8;
        Mon,  9 Oct 2023 13:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858119;
        bh=nkNOa3HZd6lXllKhxIVrO4IYXKKTTVlN2FoF2+Y88m0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O0jCXbn4ps9ggr94/sAZyExV4kpC8c7yi42v98yhgFR8fASjz8Wsfmv1Erw47CFVv
         KL4JO1Yr/+vlbWr46TRXi3tLXkoEbSWsZ1HpwKY8u71VcRi9wTPCsM+Ny3zxFXriik
         fvpeNLmEuvh0HGLu+mZHBiMtdshYovBr97KmkMqQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 014/131] netfilter: nf_tables: disallow element removal on anonymous sets
Date:   Mon,  9 Oct 2023 15:00:54 +0200
Message-ID: <20231009130116.756545960@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
References: <20231009130116.329529591@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
index a1a1f715fb624..9fc4431242e2a 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1047,8 +1047,7 @@ static int nft_flush_table(struct nft_ctx *ctx)
 		if (!nft_is_active_next(ctx->net, set))
 			continue;
 
-		if (nft_set_is_anonymous(set) &&
-		    !list_empty(&set->bindings))
+		if (nft_set_is_anonymous(set))
 			continue;
 
 		err = nft_delset(ctx, set);
@@ -5066,8 +5065,10 @@ static int nf_tables_delsetelem(struct net *net, struct sock *nlsk,
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



