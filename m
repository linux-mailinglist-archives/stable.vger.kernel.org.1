Return-Path: <stable+bounces-111515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93943A22F81
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981B43A232B
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005AE1E98F1;
	Thu, 30 Jan 2025 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HUFF8OBL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CB31E522;
	Thu, 30 Jan 2025 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246960; cv=none; b=nPA02qdNJnnm/vQAgWczpFxAjl84myw77yVxH50UZWl7eNeEe5KTAUvYSfkUmp8unzjChOrqnpcyXyaesPRFzkAWGBJQRHIhMftNpr75GSQfb5GN8l01Mcp9FTehMuQLrG26D93cMHqxMeODOYba/S8Bk67wW13s7FxklIvrZMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246960; c=relaxed/simple;
	bh=tunrI2S57SfkhGu9ySelBoRYvAOJYmN8ZlQVOYh+/2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s7iGGz/cnzPBxj7mvQjOOVWqxVQJ0txvWpLr0YIE5MOZPQNhhlkLkRujPTvp2fv+l6YvCKUTaOlHM4XEnxsp0Xy7i1uvamgolnINreqWvXD0xLG+66F196PbVYzHmSaiYXxhAVLs92E+H2dbanRzMLOtWN51FOFWteW514z7I/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HUFF8OBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A769C4CED2;
	Thu, 30 Jan 2025 14:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738246960;
	bh=tunrI2S57SfkhGu9ySelBoRYvAOJYmN8ZlQVOYh+/2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HUFF8OBL+YeQnI8HIyS+17MM3kIRIly0HI0YTGXJcyj0U7ZpqgZY1uQO8TW45vnv5
	 JFfCgNdZOIpd7BJDIkvXdzvYjBQjP+i7Z3/LPojPgXFdoDD3VqwCecPW+Si4ALMco2
	 PA0x7RbL62sHee/DS/YRxc9KfJ0jdgNUHxoZ7OCc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 008/133] netfilter: nft_dynset: honor stateful expressions in set definition
Date: Thu, 30 Jan 2025 14:59:57 +0100
Message-ID: <20250130140142.830294163@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130140142.491490528@linuxfoundation.org>
References: <20250130140142.491490528@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit fca05d4d61e65fa573a3768f9019a42143c03349 upstream.

If the set definition contains stateful expressions, allocate them for
the newly added entries from the packet path.

[ This backport includes nft_set_elem_expr_clone() which has been
  taken from 8cfd9b0f8515 ("netfilter: nftables: generalize set
  expressions support") and skip redundant expressions when set
  already provides it per ce5379963b28 ("netfilter: nft_dynset: dump
  expressions when set definition contains no expressions") ]

Fixes: 65038428b2c6 ("netfilter: nf_tables: allow to specify stateful expression in set definition")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_tables.h |  2 ++
 net/netfilter/nf_tables_api.c     | 23 +++++++++++++++++++++++
 net/netfilter/nft_dynset.c        |  7 ++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 31edeafeda77..cb13e604dc34 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -734,6 +734,8 @@ void *nft_set_elem_init(const struct nft_set *set,
 			const struct nft_set_ext_tmpl *tmpl,
 			const u32 *key, const u32 *key_end, const u32 *data,
 			u64 timeout, u64 expiration, gfp_t gfp);
+int nft_set_elem_expr_clone(const struct nft_ctx *ctx, struct nft_set *set,
+			    struct nft_expr **pexpr);
 void nft_set_elem_destroy(const struct nft_set *set, void *elem,
 			  bool destroy_expr);
 void nf_tables_set_elem_destroy(const struct nft_ctx *ctx,
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 2bd1c7e7edc3..28ea2ed3f337 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5548,6 +5548,29 @@ static int nft_set_elem_expr_setup(struct nft_ctx *ctx,
 	return 0;
 }
 
+int nft_set_elem_expr_clone(const struct nft_ctx *ctx, struct nft_set *set,
+			    struct nft_expr **pexpr)
+{
+	struct nft_expr *expr;
+	int err;
+
+	expr = kzalloc(set->expr->ops->size, GFP_KERNEL);
+	if (!expr)
+		goto err_expr;
+
+	err = nft_expr_clone(expr, set->expr, GFP_KERNEL);
+	if (err < 0) {
+		kfree(expr);
+		goto err_expr;
+	}
+	*pexpr = expr;
+
+	return 0;
+
+err_expr:
+	return -ENOMEM;
+}
+
 static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 			    const struct nlattr *attr, u32 nlmsg_flags)
 {
diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index 9461293182e8..fc81bda6cc6b 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -192,6 +192,10 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 			err = -EOPNOTSUPP;
 			goto err_expr_free;
 		}
+	} else if (set->expr) {
+		err = nft_set_elem_expr_clone(ctx, set, &priv->expr);
+		if (err < 0)
+			return err;
 	}
 
 	nft_set_ext_prepare(&priv->tmpl);
@@ -272,7 +276,8 @@ static int nft_dynset_dump(struct sk_buff *skb, const struct nft_expr *expr)
 			 nf_jiffies64_to_msecs(priv->timeout),
 			 NFTA_DYNSET_PAD))
 		goto nla_put_failure;
-	if (priv->expr && nft_expr_dump(skb, NFTA_DYNSET_EXPR, priv->expr))
+	if (!priv->set->expr && priv->expr &&
+	    nft_expr_dump(skb, NFTA_DYNSET_EXPR, priv->expr))
 		goto nla_put_failure;
 	if (nla_put_be32(skb, NFTA_DYNSET_FLAGS, htonl(flags)))
 		goto nla_put_failure;
-- 
2.39.5




