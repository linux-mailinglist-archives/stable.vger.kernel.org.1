Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B51713D80
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjE1T0E (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjE1T0D (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:26:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A47B1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:26:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46BAC61BF5
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:26:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25526C433D2;
        Sun, 28 May 2023 19:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301959;
        bh=Nq9U2NXcLXy7EEr6H6g5KjpVe7q2naemftlvltGjaT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ePZcJhaWNb6N/zadIVELF4o5fRymCybxblH5/Hh05pfFv4AvOU9sltPhJsymIMg3E
         Nm1oZDNL3vWA/krEtHuAZ3lYTICdAGV4JrXmYG6oGsQ6+zpl9hlw8xPPrbDW8Rs0Ed
         rVPaZ4GFg031Lu/rjP5qxS5SXZOZy6qX/yjL3L74=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 105/161] netfilter: nftables: add nft_parse_register_store() and use it
Date:   Sun, 28 May 2023 20:10:29 +0100
Message-Id: <20230528190840.446755018@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
References: <20230528190837.051205996@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ 345023b0db315648ccc3c1a36aee88304a8b4d91 ]

This new function combines the netlink register attribute parser
and the store validation function.

This update requires to replace:

        enum nft_registers      dreg:8;

in many of the expression private areas otherwise compiler complains
with:

        error: cannot take address of bit-field ‘dreg’

when passing the register field as reference.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_tables.h      |  8 +++---
 include/net/netfilter/nf_tables_core.h |  4 +--
 include/net/netfilter/nft_fib.h        |  2 +-
 include/net/netfilter/nft_meta.h       |  2 +-
 net/bridge/netfilter/nft_meta_bridge.c |  5 ++--
 net/netfilter/nf_tables_api.c          | 34 ++++++++++++++++++++++----
 net/netfilter/nft_bitwise.c            |  8 +++---
 net/netfilter/nft_byteorder.c          |  8 +++---
 net/netfilter/nft_ct.c                 |  7 +++---
 net/netfilter/nft_exthdr.c             |  8 +++---
 net/netfilter/nft_fib.c                |  5 ++--
 net/netfilter/nft_hash.c               | 17 ++++++-------
 net/netfilter/nft_immediate.c          |  6 ++---
 net/netfilter/nft_lookup.c             |  8 +++---
 net/netfilter/nft_meta.c               |  5 ++--
 net/netfilter/nft_numgen.c             | 15 +++++-------
 net/netfilter/nft_osf.c                |  8 +++---
 net/netfilter/nft_payload.c            |  6 ++---
 net/netfilter/nft_rt.c                 |  7 +++---
 net/netfilter/nft_socket.c             |  7 +++---
 net/netfilter/nft_tunnel.c             |  8 +++---
 net/netfilter/nft_xfrm.c               |  7 +++---
 22 files changed, 97 insertions(+), 88 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 78181f017681b..446f70132d827 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -209,10 +209,10 @@ unsigned int nft_parse_register(const struct nlattr *attr);
 int nft_dump_register(struct sk_buff *skb, unsigned int attr, unsigned int reg);
 
 int nft_parse_register_load(const struct nlattr *attr, u8 *sreg, u32 len);
-int nft_validate_register_store(const struct nft_ctx *ctx,
-				enum nft_registers reg,
-				const struct nft_data *data,
-				enum nft_data_types type, unsigned int len);
+int nft_parse_register_store(const struct nft_ctx *ctx,
+			     const struct nlattr *attr, u8 *dreg,
+			     const struct nft_data *data,
+			     enum nft_data_types type, unsigned int len);
 
 /**
  *	struct nft_userdata - user defined data associated with an object
diff --git a/include/net/netfilter/nf_tables_core.h b/include/net/netfilter/nf_tables_core.h
index c57ecb9e157cd..6a3fd54c69c17 100644
--- a/include/net/netfilter/nf_tables_core.h
+++ b/include/net/netfilter/nf_tables_core.h
@@ -31,7 +31,7 @@ struct nft_cmp_fast_expr {
 
 struct nft_immediate_expr {
 	struct nft_data		data;
-	enum nft_registers	dreg:8;
+	u8			dreg;
 	u8			dlen;
 };
 
@@ -51,7 +51,7 @@ struct nft_payload {
 	enum nft_payload_bases	base:8;
 	u8			offset;
 	u8			len;
-	enum nft_registers	dreg:8;
+	u8			dreg;
 };
 
 struct nft_payload_set {
diff --git a/include/net/netfilter/nft_fib.h b/include/net/netfilter/nft_fib.h
index 628b6fa579cd8..237f3757637e1 100644
--- a/include/net/netfilter/nft_fib.h
+++ b/include/net/netfilter/nft_fib.h
@@ -5,7 +5,7 @@
 #include <net/netfilter/nf_tables.h>
 
 struct nft_fib {
-	enum nft_registers	dreg:8;
+	u8			dreg;
 	u8			result;
 	u32			flags;
 };
diff --git a/include/net/netfilter/nft_meta.h b/include/net/netfilter/nft_meta.h
index 946fa8c83798e..2dce55c736f40 100644
--- a/include/net/netfilter/nft_meta.h
+++ b/include/net/netfilter/nft_meta.h
@@ -7,7 +7,7 @@
 struct nft_meta {
 	enum nft_meta_keys	key:8;
 	union {
-		enum nft_registers	dreg:8;
+		u8		dreg;
 		u8		sreg;
 	};
 };
diff --git a/net/bridge/netfilter/nft_meta_bridge.c b/net/bridge/netfilter/nft_meta_bridge.c
index 7c9e92b2f806c..0c28fa4647b73 100644
--- a/net/bridge/netfilter/nft_meta_bridge.c
+++ b/net/bridge/netfilter/nft_meta_bridge.c
@@ -87,9 +87,8 @@ static int nft_meta_bridge_get_init(const struct nft_ctx *ctx,
 		return nft_meta_get_init(ctx, expr, tb);
 	}
 
-	priv->dreg = nft_parse_register(tb[NFTA_META_DREG]);
-	return nft_validate_register_store(ctx, priv->dreg, NULL,
-					   NFT_DATA_VALUE, len);
+	return nft_parse_register_store(ctx, tb[NFTA_META_DREG], &priv->dreg,
+					NULL, NFT_DATA_VALUE, len);
 }
 
 static struct nft_expr_type nft_meta_bridge_type;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 26390fb986215..0ccbe8751085a 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3839,6 +3839,12 @@ static int nf_tables_delset(struct net *net, struct sock *nlsk,
 	return nft_delset(&ctx, set);
 }
 
+static int nft_validate_register_store(const struct nft_ctx *ctx,
+				       enum nft_registers reg,
+				       const struct nft_data *data,
+				       enum nft_data_types type,
+				       unsigned int len);
+
 static int nf_tables_bind_check_setelem(const struct nft_ctx *ctx,
 					struct nft_set *set,
 					const struct nft_set_iter *iter,
@@ -7473,10 +7479,11 @@ EXPORT_SYMBOL_GPL(nft_parse_register_load);
  * 	A value of NULL for the data means that its runtime gathered
  * 	data.
  */
-int nft_validate_register_store(const struct nft_ctx *ctx,
-				enum nft_registers reg,
-				const struct nft_data *data,
-				enum nft_data_types type, unsigned int len)
+static int nft_validate_register_store(const struct nft_ctx *ctx,
+				       enum nft_registers reg,
+				       const struct nft_data *data,
+				       enum nft_data_types type,
+				       unsigned int len)
 {
 	int err;
 
@@ -7508,7 +7515,24 @@ int nft_validate_register_store(const struct nft_ctx *ctx,
 		return 0;
 	}
 }
-EXPORT_SYMBOL_GPL(nft_validate_register_store);
+
+int nft_parse_register_store(const struct nft_ctx *ctx,
+			     const struct nlattr *attr, u8 *dreg,
+			     const struct nft_data *data,
+			     enum nft_data_types type, unsigned int len)
+{
+	int err;
+	u32 reg;
+
+	reg = nft_parse_register(attr);
+	err = nft_validate_register_store(ctx, reg, data, type, len);
+	if (err < 0)
+		return err;
+
+	*dreg = reg;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nft_parse_register_store);
 
 static const struct nla_policy nft_verdict_policy[NFTA_VERDICT_MAX + 1] = {
 	[NFTA_VERDICT_CODE]	= { .type = NLA_U32 },
diff --git a/net/netfilter/nft_bitwise.c b/net/netfilter/nft_bitwise.c
index 850c6b5713b43..ccab2e66d754b 100644
--- a/net/netfilter/nft_bitwise.c
+++ b/net/netfilter/nft_bitwise.c
@@ -17,7 +17,7 @@
 
 struct nft_bitwise {
 	u8			sreg;
-	enum nft_registers	dreg:8;
+	u8			dreg;
 	u8			len;
 	struct nft_data		mask;
 	struct nft_data		xor;
@@ -70,9 +70,9 @@ static int nft_bitwise_init(const struct nft_ctx *ctx,
 	if (err < 0)
 		return err;
 
-	priv->dreg = nft_parse_register(tb[NFTA_BITWISE_DREG]);
-	err = nft_validate_register_store(ctx, priv->dreg, NULL,
-					  NFT_DATA_VALUE, priv->len);
+	err = nft_parse_register_store(ctx, tb[NFTA_BITWISE_DREG],
+				       &priv->dreg, NULL, NFT_DATA_VALUE,
+				       priv->len);
 	if (err < 0)
 		return err;
 
diff --git a/net/netfilter/nft_byteorder.c b/net/netfilter/nft_byteorder.c
index 0960563cd5a19..9d5947ab8d4ef 100644
--- a/net/netfilter/nft_byteorder.c
+++ b/net/netfilter/nft_byteorder.c
@@ -17,7 +17,7 @@
 
 struct nft_byteorder {
 	u8			sreg;
-	enum nft_registers	dreg:8;
+	u8			dreg;
 	enum nft_byteorder_ops	op:8;
 	u8			len;
 	u8			size;
@@ -142,9 +142,9 @@ static int nft_byteorder_init(const struct nft_ctx *ctx,
 	if (err < 0)
 		return err;
 
-	priv->dreg = nft_parse_register(tb[NFTA_BYTEORDER_DREG]);
-	return nft_validate_register_store(ctx, priv->dreg, NULL,
-					   NFT_DATA_VALUE, priv->len);
+	return nft_parse_register_store(ctx, tb[NFTA_BYTEORDER_DREG],
+					&priv->dreg, NULL, NFT_DATA_VALUE,
+					priv->len);
 }
 
 static int nft_byteorder_dump(struct sk_buff *skb, const struct nft_expr *expr)
diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index edc6b8ae06480..7e269f7378cc0 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -27,7 +27,7 @@ struct nft_ct {
 	enum nft_ct_keys	key:8;
 	enum ip_conntrack_dir	dir:8;
 	union {
-		enum nft_registers	dreg:8;
+		u8		dreg;
 		u8		sreg;
 	};
 };
@@ -498,9 +498,8 @@ static int nft_ct_get_init(const struct nft_ctx *ctx,
 		}
 	}
 
-	priv->dreg = nft_parse_register(tb[NFTA_CT_DREG]);
-	err = nft_validate_register_store(ctx, priv->dreg, NULL,
-					  NFT_DATA_VALUE, len);
+	err = nft_parse_register_store(ctx, tb[NFTA_CT_DREG], &priv->dreg, NULL,
+				       NFT_DATA_VALUE, len);
 	if (err < 0)
 		return err;
 
diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index f2b36b9c2b53c..670dd146fb2b1 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -19,7 +19,7 @@ struct nft_exthdr {
 	u8			offset;
 	u8			len;
 	u8			op;
-	enum nft_registers	dreg:8;
+	u8			dreg;
 	u8			sreg;
 	u8			flags;
 };
@@ -353,12 +353,12 @@ static int nft_exthdr_init(const struct nft_ctx *ctx,
 	priv->type   = nla_get_u8(tb[NFTA_EXTHDR_TYPE]);
 	priv->offset = offset;
 	priv->len    = len;
-	priv->dreg   = nft_parse_register(tb[NFTA_EXTHDR_DREG]);
 	priv->flags  = flags;
 	priv->op     = op;
 
-	return nft_validate_register_store(ctx, priv->dreg, NULL,
-					   NFT_DATA_VALUE, priv->len);
+	return nft_parse_register_store(ctx, tb[NFTA_EXTHDR_DREG],
+					&priv->dreg, NULL, NFT_DATA_VALUE,
+					priv->len);
 }
 
 static int nft_exthdr_tcp_set_init(const struct nft_ctx *ctx,
diff --git a/net/netfilter/nft_fib.c b/net/netfilter/nft_fib.c
index cfac0964f48db..d2777aff5943d 100644
--- a/net/netfilter/nft_fib.c
+++ b/net/netfilter/nft_fib.c
@@ -86,7 +86,6 @@ int nft_fib_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 		return -EINVAL;
 
 	priv->result = ntohl(nla_get_be32(tb[NFTA_FIB_RESULT]));
-	priv->dreg = nft_parse_register(tb[NFTA_FIB_DREG]);
 
 	switch (priv->result) {
 	case NFT_FIB_RESULT_OIF:
@@ -106,8 +105,8 @@ int nft_fib_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 		return -EINVAL;
 	}
 
-	err = nft_validate_register_store(ctx, priv->dreg, NULL,
-					  NFT_DATA_VALUE, len);
+	err = nft_parse_register_store(ctx, tb[NFTA_FIB_DREG], &priv->dreg,
+				       NULL, NFT_DATA_VALUE, len);
 	if (err < 0)
 		return err;
 
diff --git a/net/netfilter/nft_hash.c b/net/netfilter/nft_hash.c
index 3b01ad0a02dfe..2ff6c7759494b 100644
--- a/net/netfilter/nft_hash.c
+++ b/net/netfilter/nft_hash.c
@@ -15,7 +15,7 @@
 
 struct nft_jhash {
 	u8			sreg;
-	enum nft_registers      dreg:8;
+	u8			dreg;
 	u8			len;
 	bool			autogen_seed:1;
 	u32			modulus;
@@ -38,7 +38,7 @@ static void nft_jhash_eval(const struct nft_expr *expr,
 }
 
 struct nft_symhash {
-	enum nft_registers      dreg:8;
+	u8			dreg;
 	u32			modulus;
 	u32			offset;
 };
@@ -83,8 +83,6 @@ static int nft_jhash_init(const struct nft_ctx *ctx,
 	if (tb[NFTA_HASH_OFFSET])
 		priv->offset = ntohl(nla_get_be32(tb[NFTA_HASH_OFFSET]));
 
-	priv->dreg = nft_parse_register(tb[NFTA_HASH_DREG]);
-
 	err = nft_parse_u32_check(tb[NFTA_HASH_LEN], U8_MAX, &len);
 	if (err < 0)
 		return err;
@@ -111,8 +109,8 @@ static int nft_jhash_init(const struct nft_ctx *ctx,
 		get_random_bytes(&priv->seed, sizeof(priv->seed));
 	}
 
-	return nft_validate_register_store(ctx, priv->dreg, NULL,
-					   NFT_DATA_VALUE, sizeof(u32));
+	return nft_parse_register_store(ctx, tb[NFTA_HASH_DREG], &priv->dreg,
+					NULL, NFT_DATA_VALUE, sizeof(u32));
 }
 
 static int nft_symhash_init(const struct nft_ctx *ctx,
@@ -128,8 +126,6 @@ static int nft_symhash_init(const struct nft_ctx *ctx,
 	if (tb[NFTA_HASH_OFFSET])
 		priv->offset = ntohl(nla_get_be32(tb[NFTA_HASH_OFFSET]));
 
-	priv->dreg = nft_parse_register(tb[NFTA_HASH_DREG]);
-
 	priv->modulus = ntohl(nla_get_be32(tb[NFTA_HASH_MODULUS]));
 	if (priv->modulus < 1)
 		return -ERANGE;
@@ -137,8 +133,9 @@ static int nft_symhash_init(const struct nft_ctx *ctx,
 	if (priv->offset + priv->modulus - 1 < priv->offset)
 		return -EOVERFLOW;
 
-	return nft_validate_register_store(ctx, priv->dreg, NULL,
-					   NFT_DATA_VALUE, sizeof(u32));
+	return nft_parse_register_store(ctx, tb[NFTA_HASH_DREG],
+					&priv->dreg, NULL, NFT_DATA_VALUE,
+					sizeof(u32));
 }
 
 static int nft_jhash_dump(struct sk_buff *skb,
diff --git a/net/netfilter/nft_immediate.c b/net/netfilter/nft_immediate.c
index 98a8149be094b..6a95d532eaecc 100644
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -48,9 +48,9 @@ static int nft_immediate_init(const struct nft_ctx *ctx,
 
 	priv->dlen = desc.len;
 
-	priv->dreg = nft_parse_register(tb[NFTA_IMMEDIATE_DREG]);
-	err = nft_validate_register_store(ctx, priv->dreg, &priv->data,
-					  desc.type, desc.len);
+	err = nft_parse_register_store(ctx, tb[NFTA_IMMEDIATE_DREG],
+				       &priv->dreg, &priv->data, desc.type,
+				       desc.len);
 	if (err < 0)
 		goto err1;
 
diff --git a/net/netfilter/nft_lookup.c b/net/netfilter/nft_lookup.c
index 349591dabb36a..e0ffd463a1320 100644
--- a/net/netfilter/nft_lookup.c
+++ b/net/netfilter/nft_lookup.c
@@ -18,7 +18,7 @@
 struct nft_lookup {
 	struct nft_set			*set;
 	u8				sreg;
-	enum nft_registers		dreg:8;
+	u8				dreg;
 	bool				invert;
 	struct nft_set_binding		binding;
 };
@@ -97,9 +97,9 @@ static int nft_lookup_init(const struct nft_ctx *ctx,
 		if (!(set->flags & NFT_SET_MAP))
 			return -EINVAL;
 
-		priv->dreg = nft_parse_register(tb[NFTA_LOOKUP_DREG]);
-		err = nft_validate_register_store(ctx, priv->dreg, NULL,
-						  set->dtype, set->dlen);
+		err = nft_parse_register_store(ctx, tb[NFTA_LOOKUP_DREG],
+					       &priv->dreg, NULL, set->dtype,
+					       set->dlen);
 		if (err < 0)
 			return err;
 	} else if (set->flags & NFT_SET_MAP)
diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 28761430d9ee4..ec2798ff822e6 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -380,9 +380,8 @@ int nft_meta_get_init(const struct nft_ctx *ctx,
 		return -EOPNOTSUPP;
 	}
 
-	priv->dreg = nft_parse_register(tb[NFTA_META_DREG]);
-	return nft_validate_register_store(ctx, priv->dreg, NULL,
-					   NFT_DATA_VALUE, len);
+	return nft_parse_register_store(ctx, tb[NFTA_META_DREG], &priv->dreg,
+					NULL, NFT_DATA_VALUE, len);
 }
 EXPORT_SYMBOL_GPL(nft_meta_get_init);
 
diff --git a/net/netfilter/nft_numgen.c b/net/netfilter/nft_numgen.c
index 48edb9d5f0125..7bbca252e7fc5 100644
--- a/net/netfilter/nft_numgen.c
+++ b/net/netfilter/nft_numgen.c
@@ -16,7 +16,7 @@
 static DEFINE_PER_CPU(struct rnd_state, nft_numgen_prandom_state);
 
 struct nft_ng_inc {
-	enum nft_registers      dreg:8;
+	u8			dreg;
 	u32			modulus;
 	atomic_t		counter;
 	u32			offset;
@@ -66,11 +66,10 @@ static int nft_ng_inc_init(const struct nft_ctx *ctx,
 	if (priv->offset + priv->modulus - 1 < priv->offset)
 		return -EOVERFLOW;
 
-	priv->dreg = nft_parse_register(tb[NFTA_NG_DREG]);
 	atomic_set(&priv->counter, priv->modulus - 1);
 
-	return nft_validate_register_store(ctx, priv->dreg, NULL,
-					   NFT_DATA_VALUE, sizeof(u32));
+	return nft_parse_register_store(ctx, tb[NFTA_NG_DREG], &priv->dreg,
+					NULL, NFT_DATA_VALUE, sizeof(u32));
 }
 
 static int nft_ng_dump(struct sk_buff *skb, enum nft_registers dreg,
@@ -100,7 +99,7 @@ static int nft_ng_inc_dump(struct sk_buff *skb, const struct nft_expr *expr)
 }
 
 struct nft_ng_random {
-	enum nft_registers      dreg:8;
+	u8			dreg;
 	u32			modulus;
 	u32			offset;
 };
@@ -140,10 +139,8 @@ static int nft_ng_random_init(const struct nft_ctx *ctx,
 
 	prandom_init_once(&nft_numgen_prandom_state);
 
-	priv->dreg = nft_parse_register(tb[NFTA_NG_DREG]);
-
-	return nft_validate_register_store(ctx, priv->dreg, NULL,
-					   NFT_DATA_VALUE, sizeof(u32));
+	return nft_parse_register_store(ctx, tb[NFTA_NG_DREG], &priv->dreg,
+					NULL, NFT_DATA_VALUE, sizeof(u32));
 }
 
 static int nft_ng_random_dump(struct sk_buff *skb, const struct nft_expr *expr)
diff --git a/net/netfilter/nft_osf.c b/net/netfilter/nft_osf.c
index d966a3aff1d33..b7c2bc01f8a27 100644
--- a/net/netfilter/nft_osf.c
+++ b/net/netfilter/nft_osf.c
@@ -6,7 +6,7 @@
 #include <linux/netfilter/nfnetlink_osf.h>
 
 struct nft_osf {
-	enum nft_registers	dreg:8;
+	u8			dreg;
 	u8			ttl;
 	u32			flags;
 };
@@ -83,9 +83,9 @@ static int nft_osf_init(const struct nft_ctx *ctx,
 		priv->flags = flags;
 	}
 
-	priv->dreg = nft_parse_register(tb[NFTA_OSF_DREG]);
-	err = nft_validate_register_store(ctx, priv->dreg, NULL,
-					  NFT_DATA_VALUE, NFT_OSF_MAXGENRELEN);
+	err = nft_parse_register_store(ctx, tb[NFTA_OSF_DREG], &priv->dreg,
+				       NULL, NFT_DATA_VALUE,
+				       NFT_OSF_MAXGENRELEN);
 	if (err < 0)
 		return err;
 
diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index ce670c959a99e..54298fcd82f0e 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -135,10 +135,10 @@ static int nft_payload_init(const struct nft_ctx *ctx,
 	priv->base   = ntohl(nla_get_be32(tb[NFTA_PAYLOAD_BASE]));
 	priv->offset = ntohl(nla_get_be32(tb[NFTA_PAYLOAD_OFFSET]));
 	priv->len    = ntohl(nla_get_be32(tb[NFTA_PAYLOAD_LEN]));
-	priv->dreg   = nft_parse_register(tb[NFTA_PAYLOAD_DREG]);
 
-	return nft_validate_register_store(ctx, priv->dreg, NULL,
-					   NFT_DATA_VALUE, priv->len);
+	return nft_parse_register_store(ctx, tb[NFTA_PAYLOAD_DREG],
+					&priv->dreg, NULL, NFT_DATA_VALUE,
+					priv->len);
 }
 
 static int nft_payload_dump(struct sk_buff *skb, const struct nft_expr *expr)
diff --git a/net/netfilter/nft_rt.c b/net/netfilter/nft_rt.c
index 7cfcb0e2f7ee1..bcd01a63e38f1 100644
--- a/net/netfilter/nft_rt.c
+++ b/net/netfilter/nft_rt.c
@@ -15,7 +15,7 @@
 
 struct nft_rt {
 	enum nft_rt_keys	key:8;
-	enum nft_registers	dreg:8;
+	u8			dreg;
 };
 
 static u16 get_tcpmss(const struct nft_pktinfo *pkt, const struct dst_entry *skbdst)
@@ -141,9 +141,8 @@ static int nft_rt_get_init(const struct nft_ctx *ctx,
 		return -EOPNOTSUPP;
 	}
 
-	priv->dreg = nft_parse_register(tb[NFTA_RT_DREG]);
-	return nft_validate_register_store(ctx, priv->dreg, NULL,
-					   NFT_DATA_VALUE, len);
+	return nft_parse_register_store(ctx, tb[NFTA_RT_DREG], &priv->dreg,
+					NULL, NFT_DATA_VALUE, len);
 }
 
 static int nft_rt_get_dump(struct sk_buff *skb,
diff --git a/net/netfilter/nft_socket.c b/net/netfilter/nft_socket.c
index 4026ec38526f6..7e4f7063f4811 100644
--- a/net/netfilter/nft_socket.c
+++ b/net/netfilter/nft_socket.c
@@ -10,7 +10,7 @@
 struct nft_socket {
 	enum nft_socket_keys		key:8;
 	union {
-		enum nft_registers	dreg:8;
+		u8			dreg;
 	};
 };
 
@@ -119,9 +119,8 @@ static int nft_socket_init(const struct nft_ctx *ctx,
 		return -EOPNOTSUPP;
 	}
 
-	priv->dreg = nft_parse_register(tb[NFTA_SOCKET_DREG]);
-	return nft_validate_register_store(ctx, priv->dreg, NULL,
-					   NFT_DATA_VALUE, len);
+	return nft_parse_register_store(ctx, tb[NFTA_SOCKET_DREG], &priv->dreg,
+					NULL, NFT_DATA_VALUE, len);
 }
 
 static int nft_socket_dump(struct sk_buff *skb,
diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index 4e850c81ad8d8..b2070f9f98ffa 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -14,7 +14,7 @@
 
 struct nft_tunnel {
 	enum nft_tunnel_keys	key:8;
-	enum nft_registers	dreg:8;
+	u8			dreg;
 	enum nft_tunnel_mode	mode:8;
 };
 
@@ -92,8 +92,6 @@ static int nft_tunnel_get_init(const struct nft_ctx *ctx,
 		return -EOPNOTSUPP;
 	}
 
-	priv->dreg = nft_parse_register(tb[NFTA_TUNNEL_DREG]);
-
 	if (tb[NFTA_TUNNEL_MODE]) {
 		priv->mode = ntohl(nla_get_be32(tb[NFTA_TUNNEL_MODE]));
 		if (priv->mode > NFT_TUNNEL_MODE_MAX)
@@ -102,8 +100,8 @@ static int nft_tunnel_get_init(const struct nft_ctx *ctx,
 		priv->mode = NFT_TUNNEL_MODE_NONE;
 	}
 
-	return nft_validate_register_store(ctx, priv->dreg, NULL,
-					   NFT_DATA_VALUE, len);
+	return nft_parse_register_store(ctx, tb[NFTA_TUNNEL_DREG], &priv->dreg,
+					NULL, NFT_DATA_VALUE, len);
 }
 
 static int nft_tunnel_get_dump(struct sk_buff *skb,
diff --git a/net/netfilter/nft_xfrm.c b/net/netfilter/nft_xfrm.c
index 06d5cabf1d7c4..cbbbc4ecad3ae 100644
--- a/net/netfilter/nft_xfrm.c
+++ b/net/netfilter/nft_xfrm.c
@@ -24,7 +24,7 @@ static const struct nla_policy nft_xfrm_policy[NFTA_XFRM_MAX + 1] = {
 
 struct nft_xfrm {
 	enum nft_xfrm_keys	key:8;
-	enum nft_registers	dreg:8;
+	u8			dreg;
 	u8			dir;
 	u8			spnum;
 };
@@ -86,9 +86,8 @@ static int nft_xfrm_get_init(const struct nft_ctx *ctx,
 
 	priv->spnum = spnum;
 
-	priv->dreg = nft_parse_register(tb[NFTA_XFRM_DREG]);
-	return nft_validate_register_store(ctx, priv->dreg, NULL,
-					   NFT_DATA_VALUE, len);
+	return nft_parse_register_store(ctx, tb[NFTA_XFRM_DREG], &priv->dreg,
+					NULL, NFT_DATA_VALUE, len);
 }
 
 /* Return true if key asks for daddr/saddr and current
-- 
2.39.2



