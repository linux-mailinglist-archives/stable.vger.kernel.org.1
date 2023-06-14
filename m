Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08946713549
	for <lists+stable@lfdr.de>; Sat, 27 May 2023 17:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjE0PII (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 27 May 2023 11:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjE0PIG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 27 May 2023 11:08:06 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98D94EA;
        Sat, 27 May 2023 08:08:04 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        sashal@kernel.org
Subject: [PATCH -stable,4.14 05/11] netfilter: nf_tables: add nft_setelem_parse_key()
Date:   Sat, 27 May 2023 18:08:05 +0200
Message-Id: <20230527160811.67779-6-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230527160811.67779-1-pablo@netfilter.org>
References: <20230527160811.67779-1-pablo@netfilter.org>
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

[ 20a1452c35425b2cef76f21f8395ef069dfddfa9 ]

Add helper function to parse the set element key netlink attribute.

v4: No changes
v3: New patch

[sbrivio: refactor error paths and labels; use NFT_DATA_VALUE_MAXLEN
  instead of sizeof(*key) in helper, value can be longer than that;
  rebase]
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 78 +++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 36 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 404e0484ddd0..c49e93c5db9c 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3736,6 +3736,24 @@ static int nf_tables_dump_set_done(struct netlink_callback *cb)
 	return 0;
 }
 
+static int nft_setelem_parse_key(struct nft_ctx *ctx, struct nft_set *set,
+				 struct nft_data *key, struct nlattr *attr)
+{
+	struct nft_data_desc desc;
+	int err;
+
+	err = nft_data_init(ctx, key, NFT_DATA_VALUE_MAXLEN, &desc, attr);
+	if (err < 0)
+		return err;
+
+	if (desc.type != NFT_DATA_VALUE || desc.len != set->klen) {
+		nft_data_release(key, desc.type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int nf_tables_getsetelem(struct net *net, struct sock *nlsk,
 				struct sk_buff *skb, const struct nlmsghdr *nlh,
 				const struct nlattr * const nla[],
@@ -3941,13 +3959,13 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 {
 	struct nlattr *nla[NFTA_SET_ELEM_MAX + 1];
 	u8 genmask = nft_genmask_next(ctx->net);
-	struct nft_data_desc d1, d2;
 	struct nft_set_ext_tmpl tmpl;
 	struct nft_set_ext *ext, *ext2;
 	struct nft_set_elem elem;
 	struct nft_set_binding *binding;
 	struct nft_object *obj = NULL;
 	struct nft_userdata *udata;
+	struct nft_data_desc desc;
 	struct nft_data data;
 	enum nft_registers dreg;
 	struct nft_trans *trans;
@@ -4000,15 +4018,12 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 		timeout = set->timeout;
 	}
 
-	err = nft_data_init(ctx, &elem.key.val, sizeof(elem.key), &d1,
-			    nla[NFTA_SET_ELEM_KEY]);
+	err = nft_setelem_parse_key(ctx, set, &elem.key.val,
+				    nla[NFTA_SET_ELEM_KEY]);
 	if (err < 0)
 		goto err1;
-	err = -EINVAL;
-	if (d1.type != NFT_DATA_VALUE || d1.len != set->klen)
-		goto err2;
 
-	nft_set_ext_add_length(&tmpl, NFT_SET_EXT_KEY, d1.len);
+	nft_set_ext_add_length(&tmpl, NFT_SET_EXT_KEY, set->klen);
 	if (timeout > 0) {
 		nft_set_ext_add(&tmpl, NFT_SET_EXT_EXPIRATION);
 		if (timeout != set->timeout)
@@ -4030,13 +4045,13 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	}
 
 	if (nla[NFTA_SET_ELEM_DATA] != NULL) {
-		err = nft_data_init(ctx, &data, sizeof(data), &d2,
+		err = nft_data_init(ctx, &data, sizeof(data), &desc,
 				    nla[NFTA_SET_ELEM_DATA]);
 		if (err < 0)
 			goto err2;
 
 		err = -EINVAL;
-		if (set->dtype != NFT_DATA_VERDICT && d2.len != set->dlen)
+		if (set->dtype != NFT_DATA_VERDICT && desc.len != set->dlen)
 			goto err3;
 
 		dreg = nft_type_to_reg(set->dtype);
@@ -4053,12 +4068,12 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 
 			err = nft_validate_register_store(&bind_ctx, dreg,
 							  &data,
-							  d2.type, d2.len);
+							  desc.type, desc.len);
 			if (err < 0)
 				goto err3;
 		}
 
-		nft_set_ext_add_length(&tmpl, NFT_SET_EXT_DATA, d2.len);
+		nft_set_ext_add_length(&tmpl, NFT_SET_EXT_DATA, desc.len);
 	}
 
 	/* The full maximum length of userdata can exceed the maximum
@@ -4141,9 +4156,9 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	kfree(elem.priv);
 err3:
 	if (nla[NFTA_SET_ELEM_DATA] != NULL)
-		nft_data_release(&data, d2.type);
+		nft_data_release(&data, desc.type);
 err2:
-	nft_data_release(&elem.key.val, d1.type);
+	nft_data_release(&elem.key.val, NFT_DATA_VALUE);
 err1:
 	return err;
 }
@@ -4241,7 +4256,6 @@ static int nft_del_setelem(struct nft_ctx *ctx, struct nft_set *set,
 {
 	struct nlattr *nla[NFTA_SET_ELEM_MAX + 1];
 	struct nft_set_ext_tmpl tmpl;
-	struct nft_data_desc desc;
 	struct nft_set_elem elem;
 	struct nft_set_ext *ext;
 	struct nft_trans *trans;
@@ -4252,11 +4266,10 @@ static int nft_del_setelem(struct nft_ctx *ctx, struct nft_set *set,
 	err = nla_parse_nested(nla, NFTA_SET_ELEM_MAX, attr,
 			       nft_set_elem_policy, NULL);
 	if (err < 0)
-		goto err1;
+		return err;
 
-	err = -EINVAL;
 	if (nla[NFTA_SET_ELEM_KEY] == NULL)
-		goto err1;
+		return -EINVAL;
 
 	nft_set_ext_prepare(&tmpl);
 
@@ -4266,37 +4279,31 @@ static int nft_del_setelem(struct nft_ctx *ctx, struct nft_set *set,
 	if (flags != 0)
 		nft_set_ext_add(&tmpl, NFT_SET_EXT_FLAGS);
 
-	err = nft_data_init(ctx, &elem.key.val, sizeof(elem.key), &desc,
-			    nla[NFTA_SET_ELEM_KEY]);
+	err = nft_setelem_parse_key(ctx, set, &elem.key.val,
+				    nla[NFTA_SET_ELEM_KEY]);
 	if (err < 0)
-		goto err1;
-
-	err = -EINVAL;
-	if (desc.type != NFT_DATA_VALUE || desc.len != set->klen)
-		goto err2;
+		return err;
 
-	nft_set_ext_add_length(&tmpl, NFT_SET_EXT_KEY, desc.len);
+	nft_set_ext_add_length(&tmpl, NFT_SET_EXT_KEY, set->klen);
 
 	err = -ENOMEM;
 	elem.priv = nft_set_elem_init(set, &tmpl, elem.key.val.data, NULL, 0,
 				      GFP_KERNEL);
 	if (elem.priv == NULL)
-		goto err2;
+		goto fail_elem;
 
 	ext = nft_set_elem_ext(set, elem.priv);
 	if (flags)
 		*nft_set_ext_flags(ext) = flags;
 
 	trans = nft_trans_elem_alloc(ctx, NFT_MSG_DELSETELEM, set);
-	if (trans == NULL) {
-		err = -ENOMEM;
-		goto err3;
-	}
+	if (trans == NULL)
+		goto fail_trans;
 
 	priv = set->ops->deactivate(ctx->net, set, &elem);
 	if (priv == NULL) {
 		err = -ENOENT;
-		goto err4;
+		goto fail_ops;
 	}
 	kfree(elem.priv);
 	elem.priv = priv;
@@ -4307,13 +4314,12 @@ static int nft_del_setelem(struct nft_ctx *ctx, struct nft_set *set,
 	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
 	return 0;
 
-err4:
+fail_ops:
 	kfree(trans);
-err3:
+fail_trans:
 	kfree(elem.priv);
-err2:
-	nft_data_release(&elem.key.val, desc.type);
-err1:
+fail_elem:
+	nft_data_release(&elem.key.val, NFT_DATA_VALUE);
 	return err;
 }
 
-- 
2.30.2

