Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4C5713CDB
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjE1TTW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjE1TTU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:19:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3BBA0
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:19:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F10961A87
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:19:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CF7C433EF;
        Sun, 28 May 2023 19:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301556;
        bh=0WTaEabXSLHRshZk9XkAUdmMyuaKxSSpjrKR3uPPMjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C+vBoR/ZidBSQ+sfZxjzTHExWdTF0gASAqhQlm9TJ9lLU3Bv8u/DkpYDXiRUYshtg
         G9Zs8OA8tbV7WOFI31eSfK2rIIaJ6uS0cewPDEMudg2X9Hrhx9rNEaMzCKqZ/DcbGq
         1Xq0YSJUbOQKPzkUQyOt2D/2Os+tUw5EG7SbxALA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 076/132] netfilter: nftables: add nft_parse_register_load() and use it
Date:   Sun, 28 May 2023 20:10:15 +0100
Message-Id: <20230528190835.863109282@linuxfoundation.org>
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

[ 4f16d25c68ec844299a4df6ecbb0234eaf88a935 ]

This new function combines the netlink register attribute parser
and the load validation function.

This update requires to replace:

	enum nft_registers      sreg:8;

in many of the expression private areas otherwise compiler complains
with:

	error: cannot take address of bit-field ‘sreg’

when passing the register field as reference.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_tables.h      |  2 +-
 include/net/netfilter/nf_tables_core.h |  5 ++--
 include/net/netfilter/nft_masq.h       |  4 +--
 include/net/netfilter/nft_redir.h      |  4 +--
 net/ipv4/netfilter/nft_dup_ipv4.c      | 18 ++++++-------
 net/ipv6/netfilter/nft_dup_ipv6.c      | 18 ++++++-------
 net/netfilter/nf_tables_api.c          | 18 +++++++++++--
 net/netfilter/nft_bitwise.c            |  6 ++---
 net/netfilter/nft_byteorder.c          |  6 ++---
 net/netfilter/nft_cmp.c                |  8 +++---
 net/netfilter/nft_ct.c                 |  5 ++--
 net/netfilter/nft_dup_netdev.c         |  6 ++---
 net/netfilter/nft_dynset.c             | 12 ++++-----
 net/netfilter/nft_exthdr.c             |  6 ++---
 net/netfilter/nft_fwd_netdev.c         | 18 ++++++-------
 net/netfilter/nft_hash.c               | 10 +++++---
 net/netfilter/nft_lookup.c             |  6 ++---
 net/netfilter/nft_masq.c               | 14 ++++-------
 net/netfilter/nft_meta.c               |  5 ++--
 net/netfilter/nft_nat.c                | 35 +++++++++++---------------
 net/netfilter/nft_objref.c             |  6 ++---
 net/netfilter/nft_payload.c            |  4 +--
 net/netfilter/nft_queue.c              | 12 ++++-----
 net/netfilter/nft_range.c              |  6 ++---
 net/netfilter/nft_redir.c              | 14 ++++-------
 net/netfilter/nft_tproxy.c             | 14 +++++------
 26 files changed, 130 insertions(+), 132 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 78f5f0426e6b6..e7b1e241f6f6e 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -194,7 +194,7 @@ int nft_parse_u32_check(const struct nlattr *attr, int max, u32 *dest);
 unsigned int nft_parse_register(const struct nlattr *attr);
 int nft_dump_register(struct sk_buff *skb, unsigned int attr, unsigned int reg);
 
-int nft_validate_register_load(enum nft_registers reg, unsigned int len);
+int nft_parse_register_load(const struct nlattr *attr, u8 *sreg, u32 len);
 int nft_validate_register_store(const struct nft_ctx *ctx,
 				enum nft_registers reg,
 				const struct nft_data *data,
diff --git a/include/net/netfilter/nf_tables_core.h b/include/net/netfilter/nf_tables_core.h
index 8da837d2aaf99..c81c12a825de4 100644
--- a/include/net/netfilter/nf_tables_core.h
+++ b/include/net/netfilter/nf_tables_core.h
@@ -21,7 +21,8 @@ void nf_tables_core_module_exit(void);
 
 struct nft_cmp_fast_expr {
 	u32			data;
-	enum nft_registers	sreg:8;
+	u32			mask;
+	u8			sreg;
 	u8			len;
 };
 
@@ -54,7 +55,7 @@ struct nft_payload_set {
 	enum nft_payload_bases	base:8;
 	u8			offset;
 	u8			len;
-	enum nft_registers	sreg:8;
+	u8			sreg;
 	u8			csum_type;
 	u8			csum_offset;
 	u8			csum_flags;
diff --git a/include/net/netfilter/nft_masq.h b/include/net/netfilter/nft_masq.h
index e51ab3815797b..e69a8277b70b3 100644
--- a/include/net/netfilter/nft_masq.h
+++ b/include/net/netfilter/nft_masq.h
@@ -4,8 +4,8 @@
 
 struct nft_masq {
 	u32			flags;
-	enum nft_registers      sreg_proto_min:8;
-	enum nft_registers      sreg_proto_max:8;
+	u8			sreg_proto_min;
+	u8			sreg_proto_max;
 };
 
 extern const struct nla_policy nft_masq_policy[];
diff --git a/include/net/netfilter/nft_redir.h b/include/net/netfilter/nft_redir.h
index 4a970737c03c8..2b4036c94cb3e 100644
--- a/include/net/netfilter/nft_redir.h
+++ b/include/net/netfilter/nft_redir.h
@@ -3,8 +3,8 @@
 #define _NFT_REDIR_H_
 
 struct nft_redir {
-	enum nft_registers	sreg_proto_min:8;
-	enum nft_registers	sreg_proto_max:8;
+	u8			sreg_proto_min;
+	u8			sreg_proto_max;
 	u16			flags;
 };
 
diff --git a/net/ipv4/netfilter/nft_dup_ipv4.c b/net/ipv4/netfilter/nft_dup_ipv4.c
index 0af3d8df70dd7..157bca240edce 100644
--- a/net/ipv4/netfilter/nft_dup_ipv4.c
+++ b/net/ipv4/netfilter/nft_dup_ipv4.c
@@ -16,8 +16,8 @@
 #include <net/netfilter/ipv4/nf_dup_ipv4.h>
 
 struct nft_dup_ipv4 {
-	enum nft_registers	sreg_addr:8;
-	enum nft_registers	sreg_dev:8;
+	u8	sreg_addr;
+	u8	sreg_dev;
 };
 
 static void nft_dup_ipv4_eval(const struct nft_expr *expr,
@@ -43,16 +43,16 @@ static int nft_dup_ipv4_init(const struct nft_ctx *ctx,
 	if (tb[NFTA_DUP_SREG_ADDR] == NULL)
 		return -EINVAL;
 
-	priv->sreg_addr = nft_parse_register(tb[NFTA_DUP_SREG_ADDR]);
-	err = nft_validate_register_load(priv->sreg_addr, sizeof(struct in_addr));
+	err = nft_parse_register_load(tb[NFTA_DUP_SREG_ADDR], &priv->sreg_addr,
+				      sizeof(struct in_addr));
 	if (err < 0)
 		return err;
 
-	if (tb[NFTA_DUP_SREG_DEV] != NULL) {
-		priv->sreg_dev = nft_parse_register(tb[NFTA_DUP_SREG_DEV]);
-		return nft_validate_register_load(priv->sreg_dev, sizeof(int));
-	}
-	return 0;
+	if (tb[NFTA_DUP_SREG_DEV])
+		err = nft_parse_register_load(tb[NFTA_DUP_SREG_DEV],
+					      &priv->sreg_dev, sizeof(int));
+
+	return err;
 }
 
 static int nft_dup_ipv4_dump(struct sk_buff *skb, const struct nft_expr *expr)
diff --git a/net/ipv6/netfilter/nft_dup_ipv6.c b/net/ipv6/netfilter/nft_dup_ipv6.c
index d8b5b60b7d531..d8bb7c85287cb 100644
--- a/net/ipv6/netfilter/nft_dup_ipv6.c
+++ b/net/ipv6/netfilter/nft_dup_ipv6.c
@@ -16,8 +16,8 @@
 #include <net/netfilter/ipv6/nf_dup_ipv6.h>
 
 struct nft_dup_ipv6 {
-	enum nft_registers	sreg_addr:8;
-	enum nft_registers	sreg_dev:8;
+	u8	sreg_addr;
+	u8	sreg_dev;
 };
 
 static void nft_dup_ipv6_eval(const struct nft_expr *expr,
@@ -41,16 +41,16 @@ static int nft_dup_ipv6_init(const struct nft_ctx *ctx,
 	if (tb[NFTA_DUP_SREG_ADDR] == NULL)
 		return -EINVAL;
 
-	priv->sreg_addr = nft_parse_register(tb[NFTA_DUP_SREG_ADDR]);
-	err = nft_validate_register_load(priv->sreg_addr, sizeof(struct in6_addr));
+	err = nft_parse_register_load(tb[NFTA_DUP_SREG_ADDR], &priv->sreg_addr,
+				      sizeof(struct in6_addr));
 	if (err < 0)
 		return err;
 
-	if (tb[NFTA_DUP_SREG_DEV] != NULL) {
-		priv->sreg_dev = nft_parse_register(tb[NFTA_DUP_SREG_DEV]);
-		return nft_validate_register_load(priv->sreg_dev, sizeof(int));
-	}
-	return 0;
+	if (tb[NFTA_DUP_SREG_DEV])
+		err = nft_parse_register_load(tb[NFTA_DUP_SREG_DEV],
+					      &priv->sreg_dev, sizeof(int));
+
+	return err;
 }
 
 static int nft_dup_ipv6_dump(struct sk_buff *skb, const struct nft_expr *expr)
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index e20bde9cc7b12..3b4cb6a9e85d5 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -7026,7 +7026,7 @@ EXPORT_SYMBOL_GPL(nft_dump_register);
  * 	Validate that the input register is one of the general purpose
  * 	registers and that the length of the load is within the bounds.
  */
-int nft_validate_register_load(enum nft_registers reg, unsigned int len)
+static int nft_validate_register_load(enum nft_registers reg, unsigned int len)
 {
 	if (reg < NFT_REG_1 * NFT_REG_SIZE / NFT_REG32_SIZE)
 		return -EINVAL;
@@ -7037,7 +7037,21 @@ int nft_validate_register_load(enum nft_registers reg, unsigned int len)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(nft_validate_register_load);
+
+int nft_parse_register_load(const struct nlattr *attr, u8 *sreg, u32 len)
+{
+	u32 reg;
+	int err;
+
+	reg = nft_parse_register(attr);
+	err = nft_validate_register_load(reg, len);
+	if (err < 0)
+		return err;
+
+	*sreg = reg;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nft_parse_register_load);
 
 /**
  *	nft_validate_register_store - validate an expressions' register store
diff --git a/net/netfilter/nft_bitwise.c b/net/netfilter/nft_bitwise.c
index 058ee84ea531b..23a8a9d119876 100644
--- a/net/netfilter/nft_bitwise.c
+++ b/net/netfilter/nft_bitwise.c
@@ -18,7 +18,7 @@
 #include <net/netfilter/nf_tables.h>
 
 struct nft_bitwise {
-	enum nft_registers	sreg:8;
+	u8			sreg;
 	enum nft_registers	dreg:8;
 	u8			len;
 	struct nft_data		mask;
@@ -68,8 +68,8 @@ static int nft_bitwise_init(const struct nft_ctx *ctx,
 
 	priv->len = len;
 
-	priv->sreg = nft_parse_register(tb[NFTA_BITWISE_SREG]);
-	err = nft_validate_register_load(priv->sreg, priv->len);
+	err = nft_parse_register_load(tb[NFTA_BITWISE_SREG], &priv->sreg,
+				      priv->len);
 	if (err < 0)
 		return err;
 
diff --git a/net/netfilter/nft_byteorder.c b/net/netfilter/nft_byteorder.c
index 13d4e421a6b33..c81d618137ce8 100644
--- a/net/netfilter/nft_byteorder.c
+++ b/net/netfilter/nft_byteorder.c
@@ -19,7 +19,7 @@
 #include <net/netfilter/nf_tables.h>
 
 struct nft_byteorder {
-	enum nft_registers	sreg:8;
+	u8			sreg;
 	enum nft_registers	dreg:8;
 	enum nft_byteorder_ops	op:8;
 	u8			len;
@@ -133,14 +133,14 @@ static int nft_byteorder_init(const struct nft_ctx *ctx,
 		return -EINVAL;
 	}
 
-	priv->sreg = nft_parse_register(tb[NFTA_BYTEORDER_SREG]);
 	err = nft_parse_u32_check(tb[NFTA_BYTEORDER_LEN], U8_MAX, &len);
 	if (err < 0)
 		return err;
 
 	priv->len = len;
 
-	err = nft_validate_register_load(priv->sreg, priv->len);
+	err = nft_parse_register_load(tb[NFTA_BYTEORDER_SREG], &priv->sreg,
+				      priv->len);
 	if (err < 0)
 		return err;
 
diff --git a/net/netfilter/nft_cmp.c b/net/netfilter/nft_cmp.c
index 7007045c08498..36bf64ebc8926 100644
--- a/net/netfilter/nft_cmp.c
+++ b/net/netfilter/nft_cmp.c
@@ -19,7 +19,7 @@
 
 struct nft_cmp_expr {
 	struct nft_data		data;
-	enum nft_registers	sreg:8;
+	u8			sreg;
 	u8			len;
 	enum nft_cmp_ops	op:8;
 };
@@ -88,8 +88,7 @@ static int nft_cmp_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 		return err;
 	}
 
-	priv->sreg = nft_parse_register(tb[NFTA_CMP_SREG]);
-	err = nft_validate_register_load(priv->sreg, desc.len);
+	err = nft_parse_register_load(tb[NFTA_CMP_SREG], &priv->sreg, desc.len);
 	if (err < 0)
 		return err;
 
@@ -139,8 +138,7 @@ static int nft_cmp_fast_init(const struct nft_ctx *ctx,
 	if (err < 0)
 		return err;
 
-	priv->sreg = nft_parse_register(tb[NFTA_CMP_SREG]);
-	err = nft_validate_register_load(priv->sreg, desc.len);
+	err = nft_parse_register_load(tb[NFTA_CMP_SREG], &priv->sreg, desc.len);
 	if (err < 0)
 		return err;
 
diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index 5dd87748afa8a..045e350ba03ea 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -30,7 +30,7 @@ struct nft_ct {
 	enum ip_conntrack_dir	dir:8;
 	union {
 		enum nft_registers	dreg:8;
-		enum nft_registers	sreg:8;
+		u8		sreg;
 	};
 };
 
@@ -581,8 +581,7 @@ static int nft_ct_set_init(const struct nft_ctx *ctx,
 		}
 	}
 
-	priv->sreg = nft_parse_register(tb[NFTA_CT_SREG]);
-	err = nft_validate_register_load(priv->sreg, len);
+	err = nft_parse_register_load(tb[NFTA_CT_SREG], &priv->sreg, len);
 	if (err < 0)
 		goto err1;
 
diff --git a/net/netfilter/nft_dup_netdev.c b/net/netfilter/nft_dup_netdev.c
index 2cc1e0ef56e88..e862f916efa09 100644
--- a/net/netfilter/nft_dup_netdev.c
+++ b/net/netfilter/nft_dup_netdev.c
@@ -16,7 +16,7 @@
 #include <net/netfilter/nf_dup_netdev.h>
 
 struct nft_dup_netdev {
-	enum nft_registers	sreg_dev:8;
+	u8	sreg_dev;
 };
 
 static void nft_dup_netdev_eval(const struct nft_expr *expr,
@@ -42,8 +42,8 @@ static int nft_dup_netdev_init(const struct nft_ctx *ctx,
 	if (tb[NFTA_DUP_SREG_DEV] == NULL)
 		return -EINVAL;
 
-	priv->sreg_dev = nft_parse_register(tb[NFTA_DUP_SREG_DEV]);
-	return nft_validate_register_load(priv->sreg_dev, sizeof(int));
+	return nft_parse_register_load(tb[NFTA_DUP_SREG_DEV], &priv->sreg_dev,
+				       sizeof(int));
 }
 
 static const struct nft_expr_ops nft_dup_netdev_ingress_ops;
diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index ea73130427eb8..c5d42e704f043 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -20,8 +20,8 @@ struct nft_dynset {
 	struct nft_set			*set;
 	struct nft_set_ext_tmpl		tmpl;
 	enum nft_dynset_ops		op:8;
-	enum nft_registers		sreg_key:8;
-	enum nft_registers		sreg_data:8;
+	u8				sreg_key;
+	u8				sreg_data;
 	bool				invert;
 	u64				timeout;
 	struct nft_expr			*expr;
@@ -166,8 +166,8 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 						tb[NFTA_DYNSET_TIMEOUT])));
 	}
 
-	priv->sreg_key = nft_parse_register(tb[NFTA_DYNSET_SREG_KEY]);
-	err = nft_validate_register_load(priv->sreg_key, set->klen);
+	err = nft_parse_register_load(tb[NFTA_DYNSET_SREG_KEY], &priv->sreg_key,
+				      set->klen);
 	if (err < 0)
 		return err;
 
@@ -177,8 +177,8 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 		if (set->dtype == NFT_DATA_VERDICT)
 			return -EOPNOTSUPP;
 
-		priv->sreg_data = nft_parse_register(tb[NFTA_DYNSET_SREG_DATA]);
-		err = nft_validate_register_load(priv->sreg_data, set->dlen);
+		err = nft_parse_register_load(tb[NFTA_DYNSET_SREG_DATA],
+					      &priv->sreg_data, set->dlen);
 		if (err < 0)
 			return err;
 	} else if (set->flags & NFT_SET_MAP)
diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index 93fee41060192..340520f10b686 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -23,7 +23,7 @@ struct nft_exthdr {
 	u8			len;
 	u8			op;
 	enum nft_registers	dreg:8;
-	enum nft_registers	sreg:8;
+	u8			sreg;
 	u8			flags;
 };
 
@@ -308,11 +308,11 @@ static int nft_exthdr_tcp_set_init(const struct nft_ctx *ctx,
 	priv->type   = nla_get_u8(tb[NFTA_EXTHDR_TYPE]);
 	priv->offset = offset;
 	priv->len    = len;
-	priv->sreg   = nft_parse_register(tb[NFTA_EXTHDR_SREG]);
 	priv->flags  = flags;
 	priv->op     = op;
 
-	return nft_validate_register_load(priv->sreg, priv->len);
+	return nft_parse_register_load(tb[NFTA_EXTHDR_SREG], &priv->sreg,
+				       priv->len);
 }
 
 static int nft_exthdr_dump_common(struct sk_buff *skb, const struct nft_exthdr *priv)
diff --git a/net/netfilter/nft_fwd_netdev.c b/net/netfilter/nft_fwd_netdev.c
index 10a12e0949299..2efbe78de3b22 100644
--- a/net/netfilter/nft_fwd_netdev.c
+++ b/net/netfilter/nft_fwd_netdev.c
@@ -20,7 +20,7 @@
 #include <net/ip.h>
 
 struct nft_fwd_netdev {
-	enum nft_registers	sreg_dev:8;
+	u8	sreg_dev;
 };
 
 static void nft_fwd_netdev_eval(const struct nft_expr *expr,
@@ -49,8 +49,8 @@ static int nft_fwd_netdev_init(const struct nft_ctx *ctx,
 	if (tb[NFTA_FWD_SREG_DEV] == NULL)
 		return -EINVAL;
 
-	priv->sreg_dev = nft_parse_register(tb[NFTA_FWD_SREG_DEV]);
-	return nft_validate_register_load(priv->sreg_dev, sizeof(int));
+	return nft_parse_register_load(tb[NFTA_FWD_SREG_DEV], &priv->sreg_dev,
+				       sizeof(int));
 }
 
 static const struct nft_expr_ops nft_fwd_netdev_ingress_ops;
@@ -69,8 +69,8 @@ static int nft_fwd_netdev_dump(struct sk_buff *skb, const struct nft_expr *expr)
 }
 
 struct nft_fwd_neigh {
-	enum nft_registers	sreg_dev:8;
-	enum nft_registers	sreg_addr:8;
+	u8			sreg_dev;
+	u8			sreg_addr;
 	u8			nfproto;
 };
 
@@ -148,8 +148,6 @@ static int nft_fwd_neigh_init(const struct nft_ctx *ctx,
 	    !tb[NFTA_FWD_NFPROTO])
 		return -EINVAL;
 
-	priv->sreg_dev = nft_parse_register(tb[NFTA_FWD_SREG_DEV]);
-	priv->sreg_addr = nft_parse_register(tb[NFTA_FWD_SREG_ADDR]);
 	priv->nfproto = ntohl(nla_get_be32(tb[NFTA_FWD_NFPROTO]));
 
 	switch (priv->nfproto) {
@@ -163,11 +161,13 @@ static int nft_fwd_neigh_init(const struct nft_ctx *ctx,
 		return -EOPNOTSUPP;
 	}
 
-	err = nft_validate_register_load(priv->sreg_dev, sizeof(int));
+	err = nft_parse_register_load(tb[NFTA_FWD_SREG_DEV], &priv->sreg_dev,
+				      sizeof(int));
 	if (err < 0)
 		return err;
 
-	return nft_validate_register_load(priv->sreg_addr, addr_len);
+	return nft_parse_register_load(tb[NFTA_FWD_SREG_ADDR], &priv->sreg_addr,
+				       addr_len);
 }
 
 static const struct nft_expr_ops nft_fwd_netdev_ingress_ops;
diff --git a/net/netfilter/nft_hash.c b/net/netfilter/nft_hash.c
index b8f23f75aea6c..d08a14cfe56b7 100644
--- a/net/netfilter/nft_hash.c
+++ b/net/netfilter/nft_hash.c
@@ -18,7 +18,7 @@
 #include <linux/jhash.h>
 
 struct nft_jhash {
-	enum nft_registers      sreg:8;
+	u8			sreg;
 	enum nft_registers      dreg:8;
 	u8			len;
 	bool			autogen_seed:1;
@@ -136,7 +136,6 @@ static int nft_jhash_init(const struct nft_ctx *ctx,
 	if (tb[NFTA_HASH_OFFSET])
 		priv->offset = ntohl(nla_get_be32(tb[NFTA_HASH_OFFSET]));
 
-	priv->sreg = nft_parse_register(tb[NFTA_HASH_SREG]);
 	priv->dreg = nft_parse_register(tb[NFTA_HASH_DREG]);
 
 	err = nft_parse_u32_check(tb[NFTA_HASH_LEN], U8_MAX, &len);
@@ -147,6 +146,10 @@ static int nft_jhash_init(const struct nft_ctx *ctx,
 
 	priv->len = len;
 
+	err = nft_parse_register_load(tb[NFTA_HASH_SREG], &priv->sreg, len);
+	if (err < 0)
+		return err;
+
 	priv->modulus = ntohl(nla_get_be32(tb[NFTA_HASH_MODULUS]));
 	if (priv->modulus < 1)
 		return -ERANGE;
@@ -161,8 +164,7 @@ static int nft_jhash_init(const struct nft_ctx *ctx,
 		get_random_bytes(&priv->seed, sizeof(priv->seed));
 	}
 
-	return nft_validate_register_load(priv->sreg, len) &&
-	       nft_validate_register_store(ctx, priv->dreg, NULL,
+	return nft_validate_register_store(ctx, priv->dreg, NULL,
 					   NFT_DATA_VALUE, sizeof(u32));
 }
 
diff --git a/net/netfilter/nft_lookup.c b/net/netfilter/nft_lookup.c
index cb9e937a5ce02..671f124d56b34 100644
--- a/net/netfilter/nft_lookup.c
+++ b/net/netfilter/nft_lookup.c
@@ -20,7 +20,7 @@
 
 struct nft_lookup {
 	struct nft_set			*set;
-	enum nft_registers		sreg:8;
+	u8				sreg;
 	enum nft_registers		dreg:8;
 	bool				invert;
 	struct nft_set_binding		binding;
@@ -76,8 +76,8 @@ static int nft_lookup_init(const struct nft_ctx *ctx,
 	if (IS_ERR(set))
 		return PTR_ERR(set);
 
-	priv->sreg = nft_parse_register(tb[NFTA_LOOKUP_SREG]);
-	err = nft_validate_register_load(priv->sreg, set->klen);
+	err = nft_parse_register_load(tb[NFTA_LOOKUP_SREG], &priv->sreg,
+				      set->klen);
 	if (err < 0)
 		return err;
 
diff --git a/net/netfilter/nft_masq.c b/net/netfilter/nft_masq.c
index 9d8655bc1bea6..4ecfebc2fdc4a 100644
--- a/net/netfilter/nft_masq.c
+++ b/net/netfilter/nft_masq.c
@@ -53,19 +53,15 @@ int nft_masq_init(const struct nft_ctx *ctx,
 	}
 
 	if (tb[NFTA_MASQ_REG_PROTO_MIN]) {
-		priv->sreg_proto_min =
-			nft_parse_register(tb[NFTA_MASQ_REG_PROTO_MIN]);
-
-		err = nft_validate_register_load(priv->sreg_proto_min, plen);
+		err = nft_parse_register_load(tb[NFTA_MASQ_REG_PROTO_MIN],
+					      &priv->sreg_proto_min, plen);
 		if (err < 0)
 			return err;
 
 		if (tb[NFTA_MASQ_REG_PROTO_MAX]) {
-			priv->sreg_proto_max =
-				nft_parse_register(tb[NFTA_MASQ_REG_PROTO_MAX]);
-
-			err = nft_validate_register_load(priv->sreg_proto_max,
-							 plen);
+			err = nft_parse_register_load(tb[NFTA_MASQ_REG_PROTO_MAX],
+						      &priv->sreg_proto_max,
+						      plen);
 			if (err < 0)
 				return err;
 		} else {
diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 297fe7d97c182..7af90ed221113 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -31,7 +31,7 @@ struct nft_meta {
 	enum nft_meta_keys	key:8;
 	union {
 		enum nft_registers	dreg:8;
-		enum nft_registers	sreg:8;
+		u8		sreg;
 	};
 };
 
@@ -448,8 +448,7 @@ static int nft_meta_set_init(const struct nft_ctx *ctx,
 		return -EOPNOTSUPP;
 	}
 
-	priv->sreg = nft_parse_register(tb[NFTA_META_SREG]);
-	err = nft_validate_register_load(priv->sreg, len);
+	err = nft_parse_register_load(tb[NFTA_META_SREG], &priv->sreg, len);
 	if (err < 0)
 		return err;
 
diff --git a/net/netfilter/nft_nat.c b/net/netfilter/nft_nat.c
index 2c3d7ff6f58a7..aa6149cc8c87c 100644
--- a/net/netfilter/nft_nat.c
+++ b/net/netfilter/nft_nat.c
@@ -27,10 +27,10 @@
 #include <net/ip.h>
 
 struct nft_nat {
-	enum nft_registers      sreg_addr_min:8;
-	enum nft_registers      sreg_addr_max:8;
-	enum nft_registers      sreg_proto_min:8;
-	enum nft_registers      sreg_proto_max:8;
+	u8			sreg_addr_min;
+	u8			sreg_addr_max;
+	u8			sreg_proto_min;
+	u8			sreg_proto_max;
 	enum nf_nat_manip_type  type:8;
 	u8			family;
 	u16			flags;
@@ -160,18 +160,15 @@ static int nft_nat_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 	priv->family = family;
 
 	if (tb[NFTA_NAT_REG_ADDR_MIN]) {
-		priv->sreg_addr_min =
-			nft_parse_register(tb[NFTA_NAT_REG_ADDR_MIN]);
-		err = nft_validate_register_load(priv->sreg_addr_min, alen);
+		err = nft_parse_register_load(tb[NFTA_NAT_REG_ADDR_MIN],
+					      &priv->sreg_addr_min, alen);
 		if (err < 0)
 			return err;
 
 		if (tb[NFTA_NAT_REG_ADDR_MAX]) {
-			priv->sreg_addr_max =
-				nft_parse_register(tb[NFTA_NAT_REG_ADDR_MAX]);
-
-			err = nft_validate_register_load(priv->sreg_addr_max,
-							 alen);
+			err = nft_parse_register_load(tb[NFTA_NAT_REG_ADDR_MAX],
+						      &priv->sreg_addr_max,
+						      alen);
 			if (err < 0)
 				return err;
 		} else {
@@ -181,19 +178,15 @@ static int nft_nat_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 
 	plen = FIELD_SIZEOF(struct nf_nat_range, min_addr.all);
 	if (tb[NFTA_NAT_REG_PROTO_MIN]) {
-		priv->sreg_proto_min =
-			nft_parse_register(tb[NFTA_NAT_REG_PROTO_MIN]);
-
-		err = nft_validate_register_load(priv->sreg_proto_min, plen);
+		err = nft_parse_register_load(tb[NFTA_NAT_REG_PROTO_MIN],
+					      &priv->sreg_proto_min, plen);
 		if (err < 0)
 			return err;
 
 		if (tb[NFTA_NAT_REG_PROTO_MAX]) {
-			priv->sreg_proto_max =
-				nft_parse_register(tb[NFTA_NAT_REG_PROTO_MAX]);
-
-			err = nft_validate_register_load(priv->sreg_proto_max,
-							 plen);
+			err = nft_parse_register_load(tb[NFTA_NAT_REG_PROTO_MAX],
+						      &priv->sreg_proto_max,
+						      plen);
 			if (err < 0)
 				return err;
 		} else {
diff --git a/net/netfilter/nft_objref.c b/net/netfilter/nft_objref.c
index eff2173db7e4b..615f0fcf711c6 100644
--- a/net/netfilter/nft_objref.c
+++ b/net/netfilter/nft_objref.c
@@ -97,7 +97,7 @@ static const struct nft_expr_ops nft_objref_ops = {
 
 struct nft_objref_map {
 	struct nft_set		*set;
-	enum nft_registers	sreg:8;
+	u8			sreg;
 	struct nft_set_binding	binding;
 };
 
@@ -139,8 +139,8 @@ static int nft_objref_map_init(const struct nft_ctx *ctx,
 	if (!(set->flags & NFT_SET_OBJECT))
 		return -EINVAL;
 
-	priv->sreg = nft_parse_register(tb[NFTA_OBJREF_SET_SREG]);
-	err = nft_validate_register_load(priv->sreg, set->klen);
+	err = nft_parse_register_load(tb[NFTA_OBJREF_SET_SREG], &priv->sreg,
+				      set->klen);
 	if (err < 0)
 		return err;
 
diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 5732b32ab9320..6c5312fecac5c 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -338,7 +338,6 @@ static int nft_payload_set_init(const struct nft_ctx *ctx,
 	priv->base        = ntohl(nla_get_be32(tb[NFTA_PAYLOAD_BASE]));
 	priv->offset      = ntohl(nla_get_be32(tb[NFTA_PAYLOAD_OFFSET]));
 	priv->len         = ntohl(nla_get_be32(tb[NFTA_PAYLOAD_LEN]));
-	priv->sreg        = nft_parse_register(tb[NFTA_PAYLOAD_SREG]);
 
 	if (tb[NFTA_PAYLOAD_CSUM_TYPE])
 		csum_type = ntohl(nla_get_be32(tb[NFTA_PAYLOAD_CSUM_TYPE]));
@@ -369,7 +368,8 @@ static int nft_payload_set_init(const struct nft_ctx *ctx,
 	}
 	priv->csum_type = csum_type;
 
-	return nft_validate_register_load(priv->sreg, priv->len);
+	return nft_parse_register_load(tb[NFTA_PAYLOAD_SREG], &priv->sreg,
+				       priv->len);
 }
 
 static int nft_payload_set_dump(struct sk_buff *skb, const struct nft_expr *expr)
diff --git a/net/netfilter/nft_queue.c b/net/netfilter/nft_queue.c
index 98613658d4ac5..de5f1bda9d6f1 100644
--- a/net/netfilter/nft_queue.c
+++ b/net/netfilter/nft_queue.c
@@ -22,10 +22,10 @@
 static u32 jhash_initval __read_mostly;
 
 struct nft_queue {
-	enum nft_registers	sreg_qnum:8;
-	u16			queuenum;
-	u16			queues_total;
-	u16			flags;
+	u8	sreg_qnum;
+	u16	queuenum;
+	u16	queues_total;
+	u16	flags;
 };
 
 static void nft_queue_eval(const struct nft_expr *expr,
@@ -114,8 +114,8 @@ static int nft_queue_sreg_init(const struct nft_ctx *ctx,
 	struct nft_queue *priv = nft_expr_priv(expr);
 	int err;
 
-	priv->sreg_qnum = nft_parse_register(tb[NFTA_QUEUE_SREG_QNUM]);
-	err = nft_validate_register_load(priv->sreg_qnum, sizeof(u32));
+	err = nft_parse_register_load(tb[NFTA_QUEUE_SREG_QNUM],
+				      &priv->sreg_qnum, sizeof(u32));
 	if (err < 0)
 		return err;
 
diff --git a/net/netfilter/nft_range.c b/net/netfilter/nft_range.c
index 2e1d2ec2f52a4..a5f74e5b8184f 100644
--- a/net/netfilter/nft_range.c
+++ b/net/netfilter/nft_range.c
@@ -18,7 +18,7 @@
 struct nft_range_expr {
 	struct nft_data		data_from;
 	struct nft_data		data_to;
-	enum nft_registers	sreg:8;
+	u8			sreg;
 	u8			len;
 	enum nft_range_ops	op:8;
 };
@@ -90,8 +90,8 @@ static int nft_range_init(const struct nft_ctx *ctx, const struct nft_expr *expr
 		goto err2;
 	}
 
-	priv->sreg = nft_parse_register(tb[NFTA_RANGE_SREG]);
-	err = nft_validate_register_load(priv->sreg, desc_from.len);
+	err = nft_parse_register_load(tb[NFTA_RANGE_SREG], &priv->sreg,
+				      desc_from.len);
 	if (err < 0)
 		goto err2;
 
diff --git a/net/netfilter/nft_redir.c b/net/netfilter/nft_redir.c
index c64cbe78dee7b..08a05bd1e8178 100644
--- a/net/netfilter/nft_redir.c
+++ b/net/netfilter/nft_redir.c
@@ -49,19 +49,15 @@ int nft_redir_init(const struct nft_ctx *ctx,
 
 	plen = FIELD_SIZEOF(struct nf_nat_range, min_addr.all);
 	if (tb[NFTA_REDIR_REG_PROTO_MIN]) {
-		priv->sreg_proto_min =
-			nft_parse_register(tb[NFTA_REDIR_REG_PROTO_MIN]);
-
-		err = nft_validate_register_load(priv->sreg_proto_min, plen);
+		err = nft_parse_register_load(tb[NFTA_REDIR_REG_PROTO_MIN],
+					      &priv->sreg_proto_min, plen);
 		if (err < 0)
 			return err;
 
 		if (tb[NFTA_REDIR_REG_PROTO_MAX]) {
-			priv->sreg_proto_max =
-				nft_parse_register(tb[NFTA_REDIR_REG_PROTO_MAX]);
-
-			err = nft_validate_register_load(priv->sreg_proto_max,
-							 plen);
+			err = nft_parse_register_load(tb[NFTA_REDIR_REG_PROTO_MAX],
+						      &priv->sreg_proto_max,
+						      plen);
 			if (err < 0)
 				return err;
 		} else {
diff --git a/net/netfilter/nft_tproxy.c b/net/netfilter/nft_tproxy.c
index a0e30bf4a845c..db780b5985abc 100644
--- a/net/netfilter/nft_tproxy.c
+++ b/net/netfilter/nft_tproxy.c
@@ -13,9 +13,9 @@
 #endif
 
 struct nft_tproxy {
-	enum nft_registers      sreg_addr:8;
-	enum nft_registers      sreg_port:8;
-	u8			family;
+	u8	sreg_addr;
+	u8	sreg_port;
+	u8	family;
 };
 
 static void nft_tproxy_eval_v4(const struct nft_expr *expr,
@@ -254,15 +254,15 @@ static int nft_tproxy_init(const struct nft_ctx *ctx,
 	}
 
 	if (tb[NFTA_TPROXY_REG_ADDR]) {
-		priv->sreg_addr = nft_parse_register(tb[NFTA_TPROXY_REG_ADDR]);
-		err = nft_validate_register_load(priv->sreg_addr, alen);
+		err = nft_parse_register_load(tb[NFTA_TPROXY_REG_ADDR],
+					      &priv->sreg_addr, alen);
 		if (err < 0)
 			return err;
 	}
 
 	if (tb[NFTA_TPROXY_REG_PORT]) {
-		priv->sreg_port = nft_parse_register(tb[NFTA_TPROXY_REG_PORT]);
-		err = nft_validate_register_load(priv->sreg_port, sizeof(u16));
+		err = nft_parse_register_load(tb[NFTA_TPROXY_REG_PORT],
+					      &priv->sreg_port, sizeof(u16));
 		if (err < 0)
 			return err;
 	}
-- 
2.39.2



