Return-Path: <stable+bounces-101443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 145189EEC6D
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9B2169026
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550FF215774;
	Thu, 12 Dec 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nxhBz888"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E932139CB;
	Thu, 12 Dec 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017565; cv=none; b=cldsBVvnxmGS2J6eC5IbWYsp8/ETbFZKFfsXQk/sPC+RxfacALaBfUvICk3Fv5ejiwt1geXsCidaLOzqFJY9SgkDIysPENcpOPMoOjul0Fm3Nq/iNZ2/B+jUqu7ZygW34TxX7q7zD80ICgyF4vrw8OGEPF6/RhZ76fMfGmsBnvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017565; c=relaxed/simple;
	bh=MbL12kgRvnVDWL0/Bq3UWyy8bagEe3PsEvF9yNBakGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JY8wmCWEkNO8tZxCjUbIZU5oVtOMm6t/Xl/6DSsVpAnnra6u28fIz2bv5jyTBo4ceFFno95xPH/1PmwAKPquQg+z7EWPTIkSEImTGF2lYJxHnKSDJAf6BE0Ab3iAZTkS5sUxZZdHvhtX5pjS/dXAjwsr3ZpXVudoEWeuaeDPaNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nxhBz888; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704DDC4CED0;
	Thu, 12 Dec 2024 15:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734017564;
	bh=MbL12kgRvnVDWL0/Bq3UWyy8bagEe3PsEvF9yNBakGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nxhBz888O+QH73POSRIfZr8YaYdFbo7NjNvu4LTrq/OpekBTZmhXaxYadJEmg5BLG
	 W1+5WWUZ9G1SYVOVEw2K1r9tC4IvwzcenE2zLwTziRJiRAxKRH1W37icxQ2Rw6uLA7
	 h6RJeYtcbzX5KABfvZIffhugCWFwRv7Be5oO/144=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+84d0441b9860f0d63285@syzkaller.appspotmail.com,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 049/356] netfilter: nft_inner: incorrect percpu area handling under softirq
Date: Thu, 12 Dec 2024 15:56:08 +0100
Message-ID: <20241212144246.572392971@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144244.601729511@linuxfoundation.org>
References: <20241212144244.601729511@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 7b1d83da254be3bf054965c8f3b1ad976f460ae5 ]

Softirq can interrupt ongoing packet from process context that is
walking over the percpu area that contains inner header offsets.

Disable bh and perform three checks before restoring the percpu inner
header offsets to validate that the percpu area is valid for this
skbuff:

1) If the NFT_PKTINFO_INNER_FULL flag is set on, then this skbuff
   has already been parsed before for inner header fetching to
   register.

2) Validate that the percpu area refers to this skbuff using the
   skbuff pointer as a cookie. If there is a cookie mismatch, then
   this skbuff needs to be parsed again.

3) Finally, validate if the percpu area refers to this tunnel type.

Only after these three checks the percpu area is restored to a on-stack
copy and bh is enabled again.

After inner header fetching, the on-stack copy is stored back to the
percpu area.

Fixes: 3a07327d10a0 ("netfilter: nft_inner: support for inner tunnel header matching")
Reported-by: syzbot+84d0441b9860f0d63285@syzkaller.appspotmail.com
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_tables_core.h |  1 +
 net/netfilter/nft_inner.c              | 57 ++++++++++++++++++++------
 2 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/include/net/netfilter/nf_tables_core.h b/include/net/netfilter/nf_tables_core.h
index 780a5f6ad4a67..16855c2a03f8e 100644
--- a/include/net/netfilter/nf_tables_core.h
+++ b/include/net/netfilter/nf_tables_core.h
@@ -161,6 +161,7 @@ enum {
 };
 
 struct nft_inner_tun_ctx {
+	unsigned long cookie;
 	u16	type;
 	u16	inner_tunoff;
 	u16	inner_lloff;
diff --git a/net/netfilter/nft_inner.c b/net/netfilter/nft_inner.c
index 928312d01eb1d..817ab978d24a1 100644
--- a/net/netfilter/nft_inner.c
+++ b/net/netfilter/nft_inner.c
@@ -210,35 +210,66 @@ static int nft_inner_parse(const struct nft_inner *priv,
 			   struct nft_pktinfo *pkt,
 			   struct nft_inner_tun_ctx *tun_ctx)
 {
-	struct nft_inner_tun_ctx ctx = {};
 	u32 off = pkt->inneroff;
 
 	if (priv->flags & NFT_INNER_HDRSIZE &&
-	    nft_inner_parse_tunhdr(priv, pkt, &ctx, &off) < 0)
+	    nft_inner_parse_tunhdr(priv, pkt, tun_ctx, &off) < 0)
 		return -1;
 
 	if (priv->flags & (NFT_INNER_LL | NFT_INNER_NH)) {
-		if (nft_inner_parse_l2l3(priv, pkt, &ctx, off) < 0)
+		if (nft_inner_parse_l2l3(priv, pkt, tun_ctx, off) < 0)
 			return -1;
 	} else if (priv->flags & NFT_INNER_TH) {
-		ctx.inner_thoff = off;
-		ctx.flags |= NFT_PAYLOAD_CTX_INNER_TH;
+		tun_ctx->inner_thoff = off;
+		tun_ctx->flags |= NFT_PAYLOAD_CTX_INNER_TH;
 	}
 
-	*tun_ctx = ctx;
 	tun_ctx->type = priv->type;
+	tun_ctx->cookie = (unsigned long)pkt->skb;
 	pkt->flags |= NFT_PKTINFO_INNER_FULL;
 
 	return 0;
 }
 
+static bool nft_inner_restore_tun_ctx(const struct nft_pktinfo *pkt,
+				      struct nft_inner_tun_ctx *tun_ctx)
+{
+	struct nft_inner_tun_ctx *this_cpu_tun_ctx;
+
+	local_bh_disable();
+	this_cpu_tun_ctx = this_cpu_ptr(&nft_pcpu_tun_ctx);
+	if (this_cpu_tun_ctx->cookie != (unsigned long)pkt->skb) {
+		local_bh_enable();
+		return false;
+	}
+	*tun_ctx = *this_cpu_tun_ctx;
+	local_bh_enable();
+
+	return true;
+}
+
+static void nft_inner_save_tun_ctx(const struct nft_pktinfo *pkt,
+				   const struct nft_inner_tun_ctx *tun_ctx)
+{
+	struct nft_inner_tun_ctx *this_cpu_tun_ctx;
+
+	local_bh_disable();
+	this_cpu_tun_ctx = this_cpu_ptr(&nft_pcpu_tun_ctx);
+	if (this_cpu_tun_ctx->cookie != tun_ctx->cookie)
+		*this_cpu_tun_ctx = *tun_ctx;
+	local_bh_enable();
+}
+
 static bool nft_inner_parse_needed(const struct nft_inner *priv,
 				   const struct nft_pktinfo *pkt,
-				   const struct nft_inner_tun_ctx *tun_ctx)
+				   struct nft_inner_tun_ctx *tun_ctx)
 {
 	if (!(pkt->flags & NFT_PKTINFO_INNER_FULL))
 		return true;
 
+	if (!nft_inner_restore_tun_ctx(pkt, tun_ctx))
+		return true;
+
 	if (priv->type != tun_ctx->type)
 		return true;
 
@@ -248,27 +279,29 @@ static bool nft_inner_parse_needed(const struct nft_inner *priv,
 static void nft_inner_eval(const struct nft_expr *expr, struct nft_regs *regs,
 			   const struct nft_pktinfo *pkt)
 {
-	struct nft_inner_tun_ctx *tun_ctx = this_cpu_ptr(&nft_pcpu_tun_ctx);
 	const struct nft_inner *priv = nft_expr_priv(expr);
+	struct nft_inner_tun_ctx tun_ctx = {};
 
 	if (nft_payload_inner_offset(pkt) < 0)
 		goto err;
 
-	if (nft_inner_parse_needed(priv, pkt, tun_ctx) &&
-	    nft_inner_parse(priv, (struct nft_pktinfo *)pkt, tun_ctx) < 0)
+	if (nft_inner_parse_needed(priv, pkt, &tun_ctx) &&
+	    nft_inner_parse(priv, (struct nft_pktinfo *)pkt, &tun_ctx) < 0)
 		goto err;
 
 	switch (priv->expr_type) {
 	case NFT_INNER_EXPR_PAYLOAD:
-		nft_payload_inner_eval((struct nft_expr *)&priv->expr, regs, pkt, tun_ctx);
+		nft_payload_inner_eval((struct nft_expr *)&priv->expr, regs, pkt, &tun_ctx);
 		break;
 	case NFT_INNER_EXPR_META:
-		nft_meta_inner_eval((struct nft_expr *)&priv->expr, regs, pkt, tun_ctx);
+		nft_meta_inner_eval((struct nft_expr *)&priv->expr, regs, pkt, &tun_ctx);
 		break;
 	default:
 		WARN_ON_ONCE(1);
 		goto err;
 	}
+	nft_inner_save_tun_ctx(pkt, &tun_ctx);
+
 	return;
 err:
 	regs->verdict.code = NFT_BREAK;
-- 
2.43.0




