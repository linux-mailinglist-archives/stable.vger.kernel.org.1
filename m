Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A966713CE0
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjE1TTd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjE1TTc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:19:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE81AA0
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:19:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5356161A94
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFABC4339B;
        Sun, 28 May 2023 19:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301569;
        bh=m56gPBqnt4IRTppEYMGTdERF2xzdDTStU3dAoKGZtb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XjE6rCRBe972jffFKnjjqOlmwt+CyNCvcGAXntGDSvgh4+R7Xq/3xQ7SLHABKSGBG
         vensOO6hQU0QsFMRIJY+meB6VQATIoONGTb7w1FMOyTE2H85rtjJC8vNStnXxLn80f
         V38QFoX4xBUvTtdEOfZ7vAdAZWYFDwNGQXjwyGCk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 081/132] netfilter: nf_tables: allow up to 64 bytes in the set element data area
Date:   Sun, 28 May 2023 20:10:20 +0100
Message-Id: <20230528190836.027490734@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190833.565872088@linuxfoundation.org>
References: <20230528190833.565872088@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ fdb9c405e35bdc6e305b9b4e20ebc141ed14fc81 ]

So far, the set elements could store up to 128-bits in the data area.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_tables.h |  4 ++++
 net/netfilter/nf_tables_api.c     | 39 +++++++++++++++++++++----------
 2 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 2cd847212a048..1b4f47a878060 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -225,6 +225,10 @@ struct nft_set_elem {
 		u32		buf[NFT_DATA_VALUE_MAXLEN / sizeof(u32)];
 		struct nft_data	val;
 	} key;
+	union {
+		u32		buf[NFT_DATA_VALUE_MAXLEN / sizeof(u32)];
+		struct nft_data val;
+	} data;
 	void			*priv;
 };
 
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index acd0566a35860..c1cbcfb58b476 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4158,6 +4158,25 @@ static int nft_setelem_parse_key(struct nft_ctx *ctx, struct nft_set *set,
 	return 0;
 }
 
+static int nft_setelem_parse_data(struct nft_ctx *ctx, struct nft_set *set,
+				  struct nft_data_desc *desc,
+				  struct nft_data *data,
+				  struct nlattr *attr)
+{
+	int err;
+
+	err = nft_data_init(ctx, data, NFT_DATA_VALUE_MAXLEN, desc, attr);
+	if (err < 0)
+		return err;
+
+	if (desc->type != NFT_DATA_VERDICT && desc->len != set->dlen) {
+		nft_data_release(data, desc->type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int nft_get_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 			    const struct nlattr *attr)
 {
@@ -4382,7 +4401,6 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	struct nft_object *obj = NULL;
 	struct nft_userdata *udata;
 	struct nft_data_desc desc;
-	struct nft_data data;
 	enum nft_registers dreg;
 	struct nft_trans *trans;
 	u32 flags = 0;
@@ -4463,15 +4481,11 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	}
 
 	if (nla[NFTA_SET_ELEM_DATA] != NULL) {
-		err = nft_data_init(ctx, &data, sizeof(data), &desc,
-				    nla[NFTA_SET_ELEM_DATA]);
+		err = nft_setelem_parse_data(ctx, set, &desc, &elem.data.val,
+					     nla[NFTA_SET_ELEM_DATA]);
 		if (err < 0)
 			goto err2;
 
-		err = -EINVAL;
-		if (set->dtype != NFT_DATA_VERDICT && desc.len != set->dlen)
-			goto err3;
-
 		dreg = nft_type_to_reg(set->dtype);
 		list_for_each_entry(binding, &set->bindings, list) {
 			struct nft_ctx bind_ctx = {
@@ -4485,14 +4499,14 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 				continue;
 
 			err = nft_validate_register_store(&bind_ctx, dreg,
-							  &data,
+							  &elem.data.val,
 							  desc.type, desc.len);
 			if (err < 0)
 				goto err3;
 
 			if (desc.type == NFT_DATA_VERDICT &&
-			    (data.verdict.code == NFT_GOTO ||
-			     data.verdict.code == NFT_JUMP))
+			    (elem.data.val.verdict.code == NFT_GOTO ||
+			     elem.data.val.verdict.code == NFT_JUMP))
 				nft_validate_state_update(ctx->net,
 							  NFT_VALIDATE_NEED);
 		}
@@ -4513,7 +4527,8 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	}
 
 	err = -ENOMEM;
-	elem.priv = nft_set_elem_init(set, &tmpl, elem.key.val.data, data.data,
+	elem.priv = nft_set_elem_init(set, &tmpl, elem.key.val.data,
+				      elem.data.val.data,
 				      timeout, GFP_KERNEL);
 	if (elem.priv == NULL)
 		goto err3;
@@ -4580,7 +4595,7 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	kfree(elem.priv);
 err3:
 	if (nla[NFTA_SET_ELEM_DATA] != NULL)
-		nft_data_release(&data, desc.type);
+		nft_data_release(&elem.data.val, desc.type);
 err2:
 	nft_data_release(&elem.key.val, NFT_DATA_VALUE);
 err1:
-- 
2.39.2



