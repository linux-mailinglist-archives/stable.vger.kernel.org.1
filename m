Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8EF705198
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 17:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbjEPPGp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 16 May 2023 11:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbjEPPGo (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 16 May 2023 11:06:44 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08E808699;
        Tue, 16 May 2023 08:06:26 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, sashal@kernel.org,
        stable@vger.kernel.org
Subject: [PATCH -stable,4.19 2/9] netfilter: nftables: add nft_parse_register_store() and use it
Date:   Tue, 16 May 2023 17:06:06 +0200
Message-Id: <20230516150613.4566-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230516150613.4566-1-pablo@netfilter.org>
References: <20230516150613.4566-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
---
 include/net/netfilter/nf_tables.h      |  8 +++---
 include/net/netfilter/nf_tables_core.h |  4 +--
 include/net/netfilter/nft_fib.h        |  2 +-
 net/netfilter/nf_tables_api.c          | 34 ++++++++++++++++++++++----
 net/netfilter/nft_bitwise.c            |  8 +++---
 net/netfilter/nft_byteorder.c          |  8 +++---
 net/netfilter/nft_ct.c                 |  7 +++---
 net/netfilter/nft_exthdr.c             |  8 +++---
 net/netfilter/nft_fib.c                |  5 ++--
 net/netfilter/nft_hash.c               | 17 ++++++-------
 net/netfilter/nft_immediate.c          |  6 ++---
 net/netfilter/nft_lookup.c             |  8 +++---
 net/netfilter/nft_meta.c               |  7 +++---
 net/netfilter/nft_numgen.c             | 15 +++++-------
 net/netfilter/nft_osf.c                |  8 +++---
 net/netfilter/nft_payload.c            |  6 ++---
 net/netfilter/nft_rt.c                 |  7 +++---
 net/netfilter/nft_socket.c             |  7 +++---
 net/netfilter/nft_tunnel.c             |  8 +++---
 19 files changed, 92 insertions(+), 81 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 45440b362df9..904034d0e2dd 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -195,10 +195,10 @@ unsigned int nft_parse_register(const struct nlattr *attr);
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
index c81c12a825de..6a3f76e012be 100644
--- a/include/net/netfilter/nf_tables_core.h
+++ b/include/net/netfilter/nf_tables_core.h
@@ -28,7 +28,7 @@ struct nft_cmp_fast_expr {
 
 struct nft_immediate_expr {
 	struct nft_data		data;
-	enum nft_registers	dreg:8;
+	u8			dreg;
 	u8			dlen;
 };
 
@@ -48,7 +48,7 @@ struct nft_payload {
 	enum nft_payload_bases	base:8;
 	u8			offset;
 	u8			len;
-	enum nft_registers	dreg:8;
+	u8			dreg;
 };
 
 struct nft_payload_set {
diff --git a/include/net/netfilter/nft_fib.h b/include/net/netfilter/nft_fib.h
index a88f92737308..1f8726739529 100644
--- a/include/net/netfilter/nft_fib.h
+++ b/include/net/netfilter/nft_fib.h
@@ -3,7 +3,7 @@
 #define _NFT_FIB_H_
 
 struct nft_fib {
-	enum nft_registers	dreg:8;
+	u8			dreg;
 	u8			result;
 	u32			flags;
 };
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index bc0a345214eb..54d2cd0447da 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3687,6 +3687,12 @@ static int nf_tables_delset(struct net *net, struct sock *nlsk,
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
@@ -7059,10 +7065,11 @@ EXPORT_SYMBOL_GPL(nft_parse_register_load);
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
 
@@ -7094,7 +7101,24 @@ int nft_validate_register_store(const struct nft_ctx *ctx,
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
index 23a8a9d11987..c1055251ebde 100644
--- a/net/netfilter/nft_bitwise.c
+++ b/net/netfilter/nft_bitwise.c
@@ -19,7 +19,7 @@
 
 struct nft_bitwise {
 	u8			sreg;
-	enum nft_registers	dreg:8;
+	u8			dreg;
 	u8			len;
 	struct nft_data		mask;
 	struct nft_data		xor;
@@ -73,9 +73,9 @@ static int nft_bitwise_init(const struct nft_ctx *ctx,
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
index c81d618137ce..5e1fbdd7b284 100644
--- a/net/netfilter/nft_byteorder.c
+++ b/net/netfilter/nft_byteorder.c
@@ -20,7 +20,7 @@
 
 struct nft_byteorder {
 	u8			sreg;
-	enum nft_registers	dreg:8;
+	u8			dreg;
 	enum nft_byteorder_ops	op:8;
 	u8			len;
 	u8			size;
@@ -144,9 +144,9 @@ static int nft_byteorder_init(const struct nft_ctx *ctx,
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
index 045e350ba03e..f29f02805bcc 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -29,7 +29,7 @@ struct nft_ct {
 	enum nft_ct_keys	key:8;
 	enum ip_conntrack_dir	dir:8;
 	union {
-		enum nft_registers	dreg:8;
+		u8		dreg;
 		u8		sreg;
 	};
 };
@@ -486,9 +486,8 @@ static int nft_ct_get_init(const struct nft_ctx *ctx,
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
index 340520f10b68..8d0f14cd7cc3 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -22,7 +22,7 @@ struct nft_exthdr {
 	u8			offset;
 	u8			len;
 	u8			op;
-	enum nft_registers	dreg:8;
+	u8			dreg;
 	u8			sreg;
 	u8			flags;
 };
@@ -258,12 +258,12 @@ static int nft_exthdr_init(const struct nft_ctx *ctx,
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
index 21df8cccea65..ce6891337304 100644
--- a/net/netfilter/nft_fib.c
+++ b/net/netfilter/nft_fib.c
@@ -88,7 +88,6 @@ int nft_fib_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 		return -EINVAL;
 
 	priv->result = ntohl(nla_get_be32(tb[NFTA_FIB_RESULT]));
-	priv->dreg = nft_parse_register(tb[NFTA_FIB_DREG]);
 
 	switch (priv->result) {
 	case NFT_FIB_RESULT_OIF:
@@ -108,8 +107,8 @@ int nft_fib_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 		return -EINVAL;
 	}
 
-	err = nft_validate_register_store(ctx, priv->dreg, NULL,
-					  NFT_DATA_VALUE, len);
+	err = nft_parse_register_store(ctx, tb[NFTA_FIB_DREG], &priv->dreg,
+				       NULL, NFT_DATA_VALUE, len);
 	if (err < 0)
 		return err;
 
diff --git a/net/netfilter/nft_hash.c b/net/netfilter/nft_hash.c
index d08a14cfe56b..513419aca9c6 100644
--- a/net/netfilter/nft_hash.c
+++ b/net/netfilter/nft_hash.c
@@ -19,7 +19,7 @@
 
 struct nft_jhash {
 	u8			sreg;
-	enum nft_registers      dreg:8;
+	u8			dreg;
 	u8			len;
 	bool			autogen_seed:1;
 	u32			modulus;
@@ -65,7 +65,7 @@ static void nft_jhash_map_eval(const struct nft_expr *expr,
 }
 
 struct nft_symhash {
-	enum nft_registers      dreg:8;
+	u8			dreg;
 	u32			modulus;
 	u32			offset;
 	struct nft_set		*map;
@@ -136,8 +136,6 @@ static int nft_jhash_init(const struct nft_ctx *ctx,
 	if (tb[NFTA_HASH_OFFSET])
 		priv->offset = ntohl(nla_get_be32(tb[NFTA_HASH_OFFSET]));
 
-	priv->dreg = nft_parse_register(tb[NFTA_HASH_DREG]);
-
 	err = nft_parse_u32_check(tb[NFTA_HASH_LEN], U8_MAX, &len);
 	if (err < 0)
 		return err;
@@ -164,8 +162,8 @@ static int nft_jhash_init(const struct nft_ctx *ctx,
 		get_random_bytes(&priv->seed, sizeof(priv->seed));
 	}
 
-	return nft_validate_register_store(ctx, priv->dreg, NULL,
-					   NFT_DATA_VALUE, sizeof(u32));
+	return nft_parse_register_store(ctx, tb[NFTA_HASH_DREG], &priv->dreg,
+					NULL, NFT_DATA_VALUE, sizeof(u32));
 }
 
 static int nft_jhash_map_init(const struct nft_ctx *ctx,
@@ -195,8 +193,6 @@ static int nft_symhash_init(const struct nft_ctx *ctx,
 	if (tb[NFTA_HASH_OFFSET])
 		priv->offset = ntohl(nla_get_be32(tb[NFTA_HASH_OFFSET]));
 
-	priv->dreg = nft_parse_register(tb[NFTA_HASH_DREG]);
-
 	priv->modulus = ntohl(nla_get_be32(tb[NFTA_HASH_MODULUS]));
 	if (priv->modulus < 1)
 		return -ERANGE;
@@ -204,8 +200,9 @@ static int nft_symhash_init(const struct nft_ctx *ctx,
 	if (priv->offset + priv->modulus - 1 < priv->offset)
 		return -EOVERFLOW;
 
-	return nft_validate_register_store(ctx, priv->dreg, NULL,
-					   NFT_DATA_VALUE, sizeof(u32));
+	return nft_parse_register_store(ctx, tb[NFTA_HASH_DREG],
+					&priv->dreg, NULL, NFT_DATA_VALUE,
+					sizeof(u32));
 }
 
 static int nft_symhash_map_init(const struct nft_ctx *ctx,
diff --git a/net/netfilter/nft_immediate.c b/net/netfilter/nft_immediate.c
index 3f6d1d2a6281..af4e2a4bce93 100644
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -50,9 +50,9 @@ static int nft_immediate_init(const struct nft_ctx *ctx,
 
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
index c7b59bc24686..da8c7fc7c5c4 100644
--- a/net/netfilter/nft_lookup.c
+++ b/net/netfilter/nft_lookup.c
@@ -21,7 +21,7 @@
 struct nft_lookup {
 	struct nft_set			*set;
 	u8				sreg;
-	enum nft_registers		dreg:8;
+	u8				dreg;
 	bool				invert;
 	struct nft_set_binding		binding;
 };
@@ -100,9 +100,9 @@ static int nft_lookup_init(const struct nft_ctx *ctx,
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
index 7af90ed22111..061a29bd3066 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -30,7 +30,7 @@
 struct nft_meta {
 	enum nft_meta_keys	key:8;
 	union {
-		enum nft_registers	dreg:8;
+		u8		dreg;
 		u8		sreg;
 	};
 };
@@ -358,9 +358,8 @@ static int nft_meta_get_init(const struct nft_ctx *ctx,
 		return -EOPNOTSUPP;
 	}
 
-	priv->dreg = nft_parse_register(tb[NFTA_META_DREG]);
-	return nft_validate_register_store(ctx, priv->dreg, NULL,
-					   NFT_DATA_VALUE, len);
+	return nft_parse_register_store(ctx, tb[NFTA_META_DREG], &priv->dreg,
+					NULL, NFT_DATA_VALUE, len);
 }
 
 static int nft_meta_get_validate(const struct nft_ctx *ctx,
diff --git a/net/netfilter/nft_numgen.c b/net/netfilter/nft_numgen.c
index 3cc1b3dc3c3c..8ff82f17ecba 100644
--- a/net/netfilter/nft_numgen.c
+++ b/net/netfilter/nft_numgen.c
@@ -20,7 +20,7 @@
 static DEFINE_PER_CPU(struct rnd_state, nft_numgen_prandom_state);
 
 struct nft_ng_inc {
-	enum nft_registers      dreg:8;
+	u8			dreg;
 	u32			modulus;
 	atomic_t		counter;
 	u32			offset;
@@ -70,11 +70,10 @@ static int nft_ng_inc_init(const struct nft_ctx *ctx,
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
@@ -104,7 +103,7 @@ static int nft_ng_inc_dump(struct sk_buff *skb, const struct nft_expr *expr)
 }
 
 struct nft_ng_random {
-	enum nft_registers      dreg:8;
+	u8			dreg;
 	u32			modulus;
 	u32			offset;
 };
@@ -144,10 +143,8 @@ static int nft_ng_random_init(const struct nft_ctx *ctx,
 
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
index 4fac2d9a4b88..af2ce7a8c587 100644
--- a/net/netfilter/nft_osf.c
+++ b/net/netfilter/nft_osf.c
@@ -5,7 +5,7 @@
 #include <linux/netfilter/nfnetlink_osf.h>
 
 struct nft_osf {
-	enum nft_registers	dreg:8;
+	u8			dreg;
 };
 
 static const struct nla_policy nft_osf_policy[NFTA_OSF_MAX + 1] = {
@@ -55,9 +55,9 @@ static int nft_osf_init(const struct nft_ctx *ctx,
 	if (!tb[NFTA_OSF_DREG])
 		return -EINVAL;
 
-	priv->dreg = nft_parse_register(tb[NFTA_OSF_DREG]);
-	err = nft_validate_register_store(ctx, priv->dreg, NULL,
-					  NFT_DATA_VALUE, NFT_OSF_MAXGENRELEN);
+	err = nft_parse_register_store(ctx, tb[NFTA_OSF_DREG], &priv->dreg,
+				       NULL, NFT_DATA_VALUE,
+				       NFT_OSF_MAXGENRELEN);
 	if (err < 0)
 		return err;
 
diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 6c5312fecac5..77cfd5182784 100644
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
index 76dba9f6b6f6..edce109ef4b0 100644
--- a/net/netfilter/nft_rt.c
+++ b/net/netfilter/nft_rt.c
@@ -18,7 +18,7 @@
 
 struct nft_rt {
 	enum nft_rt_keys	key:8;
-	enum nft_registers	dreg:8;
+	u8			dreg;
 };
 
 static u16 get_tcpmss(const struct nft_pktinfo *pkt, const struct dst_entry *skbdst)
@@ -134,9 +134,8 @@ static int nft_rt_get_init(const struct nft_ctx *ctx,
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
index 4026ec38526f..7e4f7063f481 100644
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
index 3fc55c81f16a..ab69a34210a8 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -14,7 +14,7 @@
 
 struct nft_tunnel {
 	enum nft_tunnel_keys	key:8;
-	enum nft_registers	dreg:8;
+	u8			dreg;
 };
 
 static void nft_tunnel_get_eval(const struct nft_expr *expr,
@@ -72,10 +72,8 @@ static int nft_tunnel_get_init(const struct nft_ctx *ctx,
 		return -EOPNOTSUPP;
 	}
 
-	priv->dreg = nft_parse_register(tb[NFTA_TUNNEL_DREG]);
-
-	return nft_validate_register_store(ctx, priv->dreg, NULL,
-					   NFT_DATA_VALUE, len);
+	return nft_parse_register_store(ctx, tb[NFTA_TUNNEL_DREG], &priv->dreg,
+					NULL, NFT_DATA_VALUE, len);
 }
 
 static int nft_tunnel_get_dump(struct sk_buff *skb,
-- 
2.30.2

