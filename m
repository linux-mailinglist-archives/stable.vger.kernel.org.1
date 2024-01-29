Return-Path: <stable+bounces-16646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEC7840DD4
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796CF285D3B
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B68E15AACE;
	Mon, 29 Jan 2024 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OWhN5hVb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEF9158D9B;
	Mon, 29 Jan 2024 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548173; cv=none; b=BEDRwizJR4JDLabrguOZOAL+IyPmJoGsiVBGNkZ1R+UNdH0IOxsRLDzSKILzcp/ZewPg3rRlszgzZ6LUsyzi4dysrewETNqvkGLg7CuhuyUgVeBfe4d7KyAfvttLaDuFp76XoIleBifKgYWghDs2PmChRZZjZjAxByrxC238Xac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548173; c=relaxed/simple;
	bh=iJE89hu2ZDowOmxoNDI7jpzXdutsDgIWZby8/i2KJCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkO2q9hd8XeI8J+CsIsgOTQmSW1ptNF96+DYqxEqyZIO2IQa7ClXIInt1LUH9juosM6DfwzL5WIm7VdSgbbk5j9VaNOyVOxAGriQpHN1FVfh0FYSpSHmeD4nm44qBRExxWGtjm3ILLcQJnhx8UQctjXr/rsPoTZ+Oz0inXSmPnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OWhN5hVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9748AC433B2;
	Mon, 29 Jan 2024 17:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548173;
	bh=iJE89hu2ZDowOmxoNDI7jpzXdutsDgIWZby8/i2KJCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OWhN5hVbzbWyZtQUIjex/0b382Ek8A//zJF4N/HleEp2KyGSGNXZ2XiUPUyak4G+K
	 kYh3IVblTfWpHKeQwYfruUaxTbgMj1PyfG4GrEpswTzCgMVWLOZm4W7oVTYirHM9eD
	 0RpZX3gLVkIwuD3/8dnTzDDtd9VA6ECzl63sag3U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 201/346] netfilter: nf_tables: validate NFPROTO_* family
Date: Mon, 29 Jan 2024 09:03:52 -0800
Message-ID: <20240129170022.315611358@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
References: <20240129170016.356158639@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit d0009effa8862c20a13af4cb7475d9771b905693 ]

Several expressions explicitly refer to NF_INET_* hook definitions
from expr->ops->validate, however, family is not validated.

Bail out with EOPNOTSUPP in case they are used from unsupported
families.

Fixes: 0ca743a55991 ("netfilter: nf_tables: add compatibility layer for x_tables")
Fixes: a3c90f7a2323 ("netfilter: nf_tables: flow offload expression")
Fixes: 2fa841938c64 ("netfilter: nf_tables: introduce routing expression")
Fixes: 554ced0a6e29 ("netfilter: nf_tables: add support for native socket matching")
Fixes: ad49d86e07a4 ("netfilter: nf_tables: Add synproxy support")
Fixes: 4ed8eb6570a4 ("netfilter: nf_tables: Add native tproxy support")
Fixes: 6c47260250fc ("netfilter: nf_tables: add xfrm expression")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_compat.c       | 12 ++++++++++++
 net/netfilter/nft_flow_offload.c |  5 +++++
 net/netfilter/nft_nat.c          |  5 +++++
 net/netfilter/nft_rt.c           |  5 +++++
 net/netfilter/nft_socket.c       |  5 +++++
 net/netfilter/nft_synproxy.c     |  7 +++++--
 net/netfilter/nft_tproxy.c       |  5 +++++
 net/netfilter/nft_xfrm.c         |  5 +++++
 8 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index 5284cd2ad532..f0eeda97bfcd 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -350,6 +350,12 @@ static int nft_target_validate(const struct nft_ctx *ctx,
 	unsigned int hook_mask = 0;
 	int ret;
 
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_BRIDGE &&
+	    ctx->family != NFPROTO_ARP)
+		return -EOPNOTSUPP;
+
 	if (nft_is_base_chain(ctx->chain)) {
 		const struct nft_base_chain *basechain =
 						nft_base_chain(ctx->chain);
@@ -595,6 +601,12 @@ static int nft_match_validate(const struct nft_ctx *ctx,
 	unsigned int hook_mask = 0;
 	int ret;
 
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_BRIDGE &&
+	    ctx->family != NFPROTO_ARP)
+		return -EOPNOTSUPP;
+
 	if (nft_is_base_chain(ctx->chain)) {
 		const struct nft_base_chain *basechain =
 						nft_base_chain(ctx->chain);
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index ab3362c483b4..397351fa4d5f 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -384,6 +384,11 @@ static int nft_flow_offload_validate(const struct nft_ctx *ctx,
 {
 	unsigned int hook_mask = (1 << NF_INET_FORWARD);
 
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET)
+		return -EOPNOTSUPP;
+
 	return nft_chain_validate_hooks(ctx->chain, hook_mask);
 }
 
diff --git a/net/netfilter/nft_nat.c b/net/netfilter/nft_nat.c
index 583885ce7232..808f5802c270 100644
--- a/net/netfilter/nft_nat.c
+++ b/net/netfilter/nft_nat.c
@@ -143,6 +143,11 @@ static int nft_nat_validate(const struct nft_ctx *ctx,
 	struct nft_nat *priv = nft_expr_priv(expr);
 	int err;
 
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET)
+		return -EOPNOTSUPP;
+
 	err = nft_chain_validate_dependency(ctx->chain, NFT_CHAIN_T_NAT);
 	if (err < 0)
 		return err;
diff --git a/net/netfilter/nft_rt.c b/net/netfilter/nft_rt.c
index 35a2c28caa60..24d977138572 100644
--- a/net/netfilter/nft_rt.c
+++ b/net/netfilter/nft_rt.c
@@ -166,6 +166,11 @@ static int nft_rt_validate(const struct nft_ctx *ctx, const struct nft_expr *exp
 	const struct nft_rt *priv = nft_expr_priv(expr);
 	unsigned int hooks;
 
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET)
+		return -EOPNOTSUPP;
+
 	switch (priv->key) {
 	case NFT_RT_NEXTHOP4:
 	case NFT_RT_NEXTHOP6:
diff --git a/net/netfilter/nft_socket.c b/net/netfilter/nft_socket.c
index 9ed85be79452..f30163e2ca62 100644
--- a/net/netfilter/nft_socket.c
+++ b/net/netfilter/nft_socket.c
@@ -242,6 +242,11 @@ static int nft_socket_validate(const struct nft_ctx *ctx,
 			       const struct nft_expr *expr,
 			       const struct nft_data **data)
 {
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET)
+		return -EOPNOTSUPP;
+
 	return nft_chain_validate_hooks(ctx->chain,
 					(1 << NF_INET_PRE_ROUTING) |
 					(1 << NF_INET_LOCAL_IN) |
diff --git a/net/netfilter/nft_synproxy.c b/net/netfilter/nft_synproxy.c
index 13da882669a4..1d737f89dfc1 100644
--- a/net/netfilter/nft_synproxy.c
+++ b/net/netfilter/nft_synproxy.c
@@ -186,7 +186,6 @@ static int nft_synproxy_do_init(const struct nft_ctx *ctx,
 		break;
 #endif
 	case NFPROTO_INET:
-	case NFPROTO_BRIDGE:
 		err = nf_synproxy_ipv4_init(snet, ctx->net);
 		if (err)
 			goto nf_ct_failure;
@@ -219,7 +218,6 @@ static void nft_synproxy_do_destroy(const struct nft_ctx *ctx)
 		break;
 #endif
 	case NFPROTO_INET:
-	case NFPROTO_BRIDGE:
 		nf_synproxy_ipv4_fini(snet, ctx->net);
 		nf_synproxy_ipv6_fini(snet, ctx->net);
 		break;
@@ -253,6 +251,11 @@ static int nft_synproxy_validate(const struct nft_ctx *ctx,
 				 const struct nft_expr *expr,
 				 const struct nft_data **data)
 {
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET)
+		return -EOPNOTSUPP;
+
 	return nft_chain_validate_hooks(ctx->chain, (1 << NF_INET_LOCAL_IN) |
 						    (1 << NF_INET_FORWARD));
 }
diff --git a/net/netfilter/nft_tproxy.c b/net/netfilter/nft_tproxy.c
index ae15cd693f0e..71412adb73d4 100644
--- a/net/netfilter/nft_tproxy.c
+++ b/net/netfilter/nft_tproxy.c
@@ -316,6 +316,11 @@ static int nft_tproxy_validate(const struct nft_ctx *ctx,
 			       const struct nft_expr *expr,
 			       const struct nft_data **data)
 {
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET)
+		return -EOPNOTSUPP;
+
 	return nft_chain_validate_hooks(ctx->chain, 1 << NF_INET_PRE_ROUTING);
 }
 
diff --git a/net/netfilter/nft_xfrm.c b/net/netfilter/nft_xfrm.c
index 452f8587adda..1c866757db55 100644
--- a/net/netfilter/nft_xfrm.c
+++ b/net/netfilter/nft_xfrm.c
@@ -235,6 +235,11 @@ static int nft_xfrm_validate(const struct nft_ctx *ctx, const struct nft_expr *e
 	const struct nft_xfrm *priv = nft_expr_priv(expr);
 	unsigned int hooks;
 
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET)
+		return -EOPNOTSUPP;
+
 	switch (priv->dir) {
 	case XFRM_POLICY_IN:
 		hooks = (1 << NF_INET_FORWARD) |
-- 
2.43.0




