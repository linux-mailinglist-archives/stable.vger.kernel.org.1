Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7A970511E
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 16:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjEPOpC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 16 May 2023 10:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbjEPOos (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 16 May 2023 10:44:48 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67DA230DC;
        Tue, 16 May 2023 07:44:47 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, sashal@kernel.org,
        stable@vger.kernel.org
Subject: [PATCH -stable,5.4 8/9] netfilter: nf_tables: validate NFTA_SET_ELEM_OBJREF based on NFT_SET_OBJECT flag
Date:   Tue, 16 May 2023 16:44:34 +0200
Message-Id: <20230516144435.4010-9-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230516144435.4010-1-pablo@netfilter.org>
References: <20230516144435.4010-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[ 5a2f3dc31811e93be15522d9eb13ed61460b76c8 ]

If the NFTA_SET_ELEM_OBJREF netlink attribute is present and
NFT_SET_OBJECT flag is set on, report EINVAL.

Move existing sanity check earlier to validate that NFT_SET_OBJECT
requires NFTA_SET_ELEM_OBJREF.

Fixes: 8aeff920dcc9 ("netfilter: nf_tables: add stateful object reference to set elements")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 61942e717d7b..a1b889e2748d 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4583,6 +4583,15 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 			return -EINVAL;
 	}
 
+	if (set->flags & NFT_SET_OBJECT) {
+		if (!nla[NFTA_SET_ELEM_OBJREF] &&
+		    !(flags & NFT_SET_ELEM_INTERVAL_END))
+			return -EINVAL;
+	} else {
+		if (nla[NFTA_SET_ELEM_OBJREF])
+			return -EINVAL;
+	}
+
 	if ((flags & NFT_SET_ELEM_INTERVAL_END) &&
 	     (nla[NFTA_SET_ELEM_DATA] ||
 	      nla[NFTA_SET_ELEM_OBJREF] ||
@@ -4627,10 +4636,6 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	}
 
 	if (nla[NFTA_SET_ELEM_OBJREF] != NULL) {
-		if (!(set->flags & NFT_SET_OBJECT)) {
-			err = -EINVAL;
-			goto err2;
-		}
 		obj = nft_obj_lookup(ctx->net, ctx->table,
 				     nla[NFTA_SET_ELEM_OBJREF],
 				     set->objtype, genmask);
-- 
2.30.2

