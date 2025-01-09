Return-Path: <stable+bounces-108128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBC9A07C49
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 16:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337DD16986C
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 15:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D98D21E08B;
	Thu,  9 Jan 2025 15:45:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D293121D5BC;
	Thu,  9 Jan 2025 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736437549; cv=none; b=SgXJTPyRzPgj7ZyNZYmTb/PQqZ6J0wbyidXrJJoYwtDHzN4EaLk18ueDNQqanmbKHgOKT6a69mwx8fQmpotlvVYwuMieU+ikc373HolzeROLuuOywimQkSIcRTxNxtGBp8WU9l3Bxm7BV5durq7KxI7A7hPWQs7oCg50B/tHEw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736437549; c=relaxed/simple;
	bh=ZlWK7zn88OfemaCt/b3tJb7fn13TllXdYU9TyOKrRxM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QPzOPVdslR74Ed8pzq1O93SI0FT+Z3IPehlPhPJlmd4xfV3yNyPzytGhB8I6zh+wMk6JcbWYsHIdca7Eutj4eEaNUXBuUzjvBgZ0/Q2nl9p1EgOOBoALSPOLz0rD8m/gKvQpW2kEIEtRpHoBWTQ1h0IR+9aC8zpZCD2PeS0pnfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH -stable,5.10 1/1] netfilter: nft_dynset: honor stateful expressions in set definition
Date: Thu,  9 Jan 2025 16:45:38 +0100
Message-Id: <20250109154538.43720-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 include/net/netfilter/nf_tables.h |  2 ++
 net/netfilter/nf_tables_api.c     | 23 +++++++++++++++++++++++
 net/netfilter/nft_dynset.c        |  7 ++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 484f9cdf2dd0..0f1103c43cb8 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -731,6 +731,8 @@ void *nft_set_elem_init(const struct nft_set *set,
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
2.30.2


