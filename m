Return-Path: <stable+bounces-66899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FC294F300
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030E11F21045
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DDD18787F;
	Mon, 12 Aug 2024 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NGHDHRjN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D272D187872;
	Mon, 12 Aug 2024 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723479146; cv=none; b=dOsy7L2ECPgFi+4q5uwnfsd2F8szwVldR4M91NP5K+Kd3KS0TT35E7QUEi6oF+DuLQZ+B+5XJF1Gti/KHTIJR80zhFENrVVk98OYYZDu2hDt9bMhITGlaxhc4lrU4GkHghS7HHFonIZKWh0K491LDLph2JVFi3YEpgegHbD7QSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723479146; c=relaxed/simple;
	bh=9NSStMPxTsTwqNXAdeSmomq0Ndq6h1IGTY2nmwhzd3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rc74wR9jFS1lDrz5ekb+/f91okxzDjS+Lh8WvNNDVs9MTv4mXEYvaSDGuBR6XN5sa/uCXRja/r+wri2sxGuFxK+4a6CPTmUYZxyST/jxwaA68BEwPsT9XZNR53S2Uqm3wzFd0HmPDs4ZGbE6f/1qQJZN0viNuMKeM/BjvSLE0Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NGHDHRjN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34A3C32782;
	Mon, 12 Aug 2024 16:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723479146;
	bh=9NSStMPxTsTwqNXAdeSmomq0Ndq6h1IGTY2nmwhzd3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NGHDHRjNEhb3TlihEVFVuTjV7imD/pdQgTQntnJ7uD3rLzyOlxBl9a+tcim9ZKg0Y
	 Lu37gTuF/DjR02vve2vr5vAtzBZVr7svvYIR9aZmE8J2dhIIhueGz0cp2cngRFgC1g
	 wrcUeTIIs9WYICwqp8Wk11AFkIQ1qYOXfPz4aJJQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org,
	netfilter-devel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sven Auhagen <sven.auhagen@voleatech.de>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 6.1 147/150] netfilter: nf_tables: allow clone callbacks to sleep
Date: Mon, 12 Aug 2024 18:03:48 +0200
Message-ID: <20240812160130.842944267@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160125.139701076@linuxfoundation.org>
References: <20240812160125.139701076@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit fa23e0d4b756d25829e124d6b670a4c6bbd4bf7e upstream.

Sven Auhagen reports transaction failures with following error:
  ./main.nft:13:1-26: Error: Could not process rule: Cannot allocate memory
  percpu: allocation failed, size=16 align=8 atomic=1, atomic alloc failed, no space left

This points to failing pcpu allocation with GFP_ATOMIC flag.
However, transactions happen from user context and are allowed to sleep.

One case where we can call into percpu allocator with GFP_ATOMIC is
nft_counter expression.

Normally this happens from control plane, so this could use GFP_KERNEL
instead.  But one use case, element insertion from packet path,
needs to use GFP_ATOMIC allocations (nft_dynset expression).

At this time, .clone callbacks always use GFP_ATOMIC for this reason.

Add gfp_t argument to the .clone function and pass GFP_KERNEL or
GFP_ATOMIC flag depending on context, this allows all clone memory
allocations to sleep for the normal (transaction) case.

Cc: Sven Auhagen <sven.auhagen@voleatech.de>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/netfilter/nf_tables.h |    4 ++--
 net/netfilter/nf_tables_api.c     |    8 ++++----
 net/netfilter/nft_connlimit.c     |    4 ++--
 net/netfilter/nft_counter.c       |    4 ++--
 net/netfilter/nft_dynset.c        |    2 +-
 net/netfilter/nft_last.c          |    4 ++--
 net/netfilter/nft_limit.c         |   14 ++++++++------
 net/netfilter/nft_quota.c         |    4 ++--
 8 files changed, 23 insertions(+), 21 deletions(-)

--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -387,7 +387,7 @@ static inline void *nft_expr_priv(const
 	return (void *)expr->data;
 }
 
-int nft_expr_clone(struct nft_expr *dst, struct nft_expr *src);
+int nft_expr_clone(struct nft_expr *dst, struct nft_expr *src, gfp_t gfp);
 void nft_expr_destroy(const struct nft_ctx *ctx, struct nft_expr *expr);
 int nft_expr_dump(struct sk_buff *skb, unsigned int attr,
 		  const struct nft_expr *expr);
@@ -889,7 +889,7 @@ struct nft_expr_ops {
 						struct nft_regs *regs,
 						const struct nft_pktinfo *pkt);
 	int				(*clone)(struct nft_expr *dst,
-						 const struct nft_expr *src);
+						 const struct nft_expr *src, gfp_t gfp);
 	unsigned int			size;
 
 	int				(*init)(const struct nft_ctx *ctx,
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3119,7 +3119,7 @@ err_expr_parse:
 	return ERR_PTR(err);
 }
 
-int nft_expr_clone(struct nft_expr *dst, struct nft_expr *src)
+int nft_expr_clone(struct nft_expr *dst, struct nft_expr *src, gfp_t gfp)
 {
 	int err;
 
@@ -3127,7 +3127,7 @@ int nft_expr_clone(struct nft_expr *dst,
 		return -EINVAL;
 
 	dst->ops = src->ops;
-	err = src->ops->clone(dst, src);
+	err = src->ops->clone(dst, src, gfp);
 	if (err < 0)
 		return err;
 
@@ -6059,7 +6059,7 @@ int nft_set_elem_expr_clone(const struct
 		if (!expr)
 			goto err_expr;
 
-		err = nft_expr_clone(expr, set->exprs[i]);
+		err = nft_expr_clone(expr, set->exprs[i], GFP_KERNEL_ACCOUNT);
 		if (err < 0) {
 			kfree(expr);
 			goto err_expr;
@@ -6098,7 +6098,7 @@ static int nft_set_elem_expr_setup(struc
 
 	for (i = 0; i < num_exprs; i++) {
 		expr = nft_setelem_expr_at(elem_expr, elem_expr->size);
-		err = nft_expr_clone(expr, expr_array[i]);
+		err = nft_expr_clone(expr, expr_array[i], GFP_KERNEL_ACCOUNT);
 		if (err < 0)
 			goto err_elem_expr_setup;
 
--- a/net/netfilter/nft_connlimit.c
+++ b/net/netfilter/nft_connlimit.c
@@ -209,12 +209,12 @@ static void nft_connlimit_destroy(const
 	nft_connlimit_do_destroy(ctx, priv);
 }
 
-static int nft_connlimit_clone(struct nft_expr *dst, const struct nft_expr *src)
+static int nft_connlimit_clone(struct nft_expr *dst, const struct nft_expr *src, gfp_t gfp)
 {
 	struct nft_connlimit *priv_dst = nft_expr_priv(dst);
 	struct nft_connlimit *priv_src = nft_expr_priv(src);
 
-	priv_dst->list = kmalloc(sizeof(*priv_dst->list), GFP_ATOMIC);
+	priv_dst->list = kmalloc(sizeof(*priv_dst->list), gfp);
 	if (!priv_dst->list)
 		return -ENOMEM;
 
--- a/net/netfilter/nft_counter.c
+++ b/net/netfilter/nft_counter.c
@@ -225,7 +225,7 @@ static void nft_counter_destroy(const st
 	nft_counter_do_destroy(priv);
 }
 
-static int nft_counter_clone(struct nft_expr *dst, const struct nft_expr *src)
+static int nft_counter_clone(struct nft_expr *dst, const struct nft_expr *src, gfp_t gfp)
 {
 	struct nft_counter_percpu_priv *priv = nft_expr_priv(src);
 	struct nft_counter_percpu_priv *priv_clone = nft_expr_priv(dst);
@@ -235,7 +235,7 @@ static int nft_counter_clone(struct nft_
 
 	nft_counter_fetch(priv, &total);
 
-	cpu_stats = alloc_percpu_gfp(struct nft_counter, GFP_ATOMIC);
+	cpu_stats = alloc_percpu_gfp(struct nft_counter, gfp);
 	if (cpu_stats == NULL)
 		return -ENOMEM;
 
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -35,7 +35,7 @@ static int nft_dynset_expr_setup(const s
 
 	for (i = 0; i < priv->num_exprs; i++) {
 		expr = nft_setelem_expr_at(elem_expr, elem_expr->size);
-		if (nft_expr_clone(expr, priv->expr_array[i]) < 0)
+		if (nft_expr_clone(expr, priv->expr_array[i], GFP_ATOMIC) < 0)
 			return -1;
 
 		elem_expr->size += priv->expr_array[i]->ops->size;
--- a/net/netfilter/nft_last.c
+++ b/net/netfilter/nft_last.c
@@ -101,12 +101,12 @@ static void nft_last_destroy(const struc
 	kfree(priv->last);
 }
 
-static int nft_last_clone(struct nft_expr *dst, const struct nft_expr *src)
+static int nft_last_clone(struct nft_expr *dst, const struct nft_expr *src, gfp_t gfp)
 {
 	struct nft_last_priv *priv_dst = nft_expr_priv(dst);
 	struct nft_last_priv *priv_src = nft_expr_priv(src);
 
-	priv_dst->last = kzalloc(sizeof(*priv_dst->last), GFP_ATOMIC);
+	priv_dst->last = kzalloc(sizeof(*priv_dst->last), gfp);
 	if (!priv_dst->last)
 		return -ENOMEM;
 
--- a/net/netfilter/nft_limit.c
+++ b/net/netfilter/nft_limit.c
@@ -150,7 +150,7 @@ static void nft_limit_destroy(const stru
 }
 
 static int nft_limit_clone(struct nft_limit_priv *priv_dst,
-			   const struct nft_limit_priv *priv_src)
+			   const struct nft_limit_priv *priv_src, gfp_t gfp)
 {
 	priv_dst->tokens_max = priv_src->tokens_max;
 	priv_dst->rate = priv_src->rate;
@@ -158,7 +158,7 @@ static int nft_limit_clone(struct nft_li
 	priv_dst->burst = priv_src->burst;
 	priv_dst->invert = priv_src->invert;
 
-	priv_dst->limit = kmalloc(sizeof(*priv_dst->limit), GFP_ATOMIC);
+	priv_dst->limit = kmalloc(sizeof(*priv_dst->limit), gfp);
 	if (!priv_dst->limit)
 		return -ENOMEM;
 
@@ -222,14 +222,15 @@ static void nft_limit_pkts_destroy(const
 	nft_limit_destroy(ctx, &priv->limit);
 }
 
-static int nft_limit_pkts_clone(struct nft_expr *dst, const struct nft_expr *src)
+static int nft_limit_pkts_clone(struct nft_expr *dst, const struct nft_expr *src,
+				gfp_t gfp)
 {
 	struct nft_limit_priv_pkts *priv_dst = nft_expr_priv(dst);
 	struct nft_limit_priv_pkts *priv_src = nft_expr_priv(src);
 
 	priv_dst->cost = priv_src->cost;
 
-	return nft_limit_clone(&priv_dst->limit, &priv_src->limit);
+	return nft_limit_clone(&priv_dst->limit, &priv_src->limit, gfp);
 }
 
 static struct nft_expr_type nft_limit_type;
@@ -280,12 +281,13 @@ static void nft_limit_bytes_destroy(cons
 	nft_limit_destroy(ctx, priv);
 }
 
-static int nft_limit_bytes_clone(struct nft_expr *dst, const struct nft_expr *src)
+static int nft_limit_bytes_clone(struct nft_expr *dst, const struct nft_expr *src,
+				 gfp_t gfp)
 {
 	struct nft_limit_priv *priv_dst = nft_expr_priv(dst);
 	struct nft_limit_priv *priv_src = nft_expr_priv(src);
 
-	return nft_limit_clone(priv_dst, priv_src);
+	return nft_limit_clone(priv_dst, priv_src, gfp);
 }
 
 static const struct nft_expr_ops nft_limit_bytes_ops = {
--- a/net/netfilter/nft_quota.c
+++ b/net/netfilter/nft_quota.c
@@ -232,7 +232,7 @@ static void nft_quota_destroy(const stru
 	return nft_quota_do_destroy(ctx, priv);
 }
 
-static int nft_quota_clone(struct nft_expr *dst, const struct nft_expr *src)
+static int nft_quota_clone(struct nft_expr *dst, const struct nft_expr *src, gfp_t gfp)
 {
 	struct nft_quota *priv_dst = nft_expr_priv(dst);
 	struct nft_quota *priv_src = nft_expr_priv(src);
@@ -240,7 +240,7 @@ static int nft_quota_clone(struct nft_ex
 	priv_dst->quota = priv_src->quota;
 	priv_dst->flags = priv_src->flags;
 
-	priv_dst->consumed = kmalloc(sizeof(*priv_dst->consumed), GFP_ATOMIC);
+	priv_dst->consumed = kmalloc(sizeof(*priv_dst->consumed), gfp);
 	if (!priv_dst->consumed)
 		return -ENOMEM;
 



