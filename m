Return-Path: <stable+bounces-263195-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P0oDLoj4L2qJKgUAu9opvQ
	(envelope-from <stable+bounces-263195-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 15:05:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 333B168683B
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 15:05:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=K1yzPnnS;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263195-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263195-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B024E305591A
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 13:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C9131E841;
	Mon, 15 Jun 2026 13:04:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5533033D6
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 13:04:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781528652; cv=none; b=YiEFnyJTK6zUp+JxvYy2R+KuqQVEManFSipoIVmE1jwXLyU4cerHKvnTl8xUuzOmQB9MWfWVIJXUGY5352DOnVw7ljRT+6tqpRF/9l2wkePV5onX5/WbOZt0EELPwmFHYY7YoDHWHr7idUzGLsxUNS0t05WdpcoA6BQreykLjV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781528652; c=relaxed/simple;
	bh=PYr/P5p9USRlZDfXmQJGLEjgbW2FKXvbtbeGNA4umxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQKVefQ9FrPjWyYy4RqxYFq3Gbk//9UFkoTOtmSqjYFPJ2s01qyTkgDfwLrQG8z+kFRNl+hWkUgmRq6Vp59SGE7503MQrBnhQ/Z15T3q1rFOMf/iRhUrVIisN95Xr3+PI+W2XJ9eFRHL+PbgDCTCjljbR9jiX1jBJsAfmtCbdbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1yzPnnS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBEB1F000E9;
	Mon, 15 Jun 2026 13:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781528651;
	bh=TMlDCoYoSrO3vdRyX1vZusXJAZ9OvXBopTNdM5QHveQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K1yzPnnSnvxBx2qOPDZP5UjicRYIdXc4VHSCis3c18g9FhRQ8n4TjPFTLVp7usXdn
	 9gI2B2gEl4dUidGVJ8uA5j+3MWpdBq6jgOlJXJ+rUJX6wpX0ldUmFB/BvZ0fxGLm5i
	 U6TyWkSdUJFvMbxfE3WiKUFbVv4PTWaRMTq0PB/M2H+XtTNn5gEh24l6lDN/pYgkJg
	 1Xtbj3wvBdciyUFgM/O6DmsvvX+XbSfFiCGNgNliUsJubkNxMskuJH4c498B/e1HEK
	 TmJZB8num8Op6CsuVrW6W2tYRoP7YyJuHUnhdWR2IhT8r3/CWngH+kvZhV6+7fmAdr
	 QRvi1Wqzl48Fg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Davide Ornaghi <d.ornaghi97@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y] netfilter: nft_fib: fix stale stack leak via the OIFNAME register
Date: Mon, 15 Jun 2026 09:04:08 -0400
Message-ID: <20260615130408.2055029-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061540-whomever-shading-96d4@gregkh>
References: <2026061540-whomever-shading-96d4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,strlen.de,netfilter.org,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-263195-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:d.ornaghi97@gmail.com,m:fw@strlen.de,m:pablo@netfilter.org,m:sashal@kernel.org,m:dornaghi97@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[vger.kernel.org:server fail,netfilter.org:server fail,strlen.de:server fail];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,netfilter.org:email,strlen.de:email];
	RBL_SEM_FAIL(0.00)[172.234.253.10:server fail];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[vger.kernel.org:server fail,strlen.de:server fail,netfilter.org:server fail]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 333B168683B

From: Davide Ornaghi <d.ornaghi97@gmail.com>

[ Upstream commit ab185e0c4fb82dfba6fb86f8271e06f931d9c64c ]

For NFT_FIB_RESULT_OIFNAME the destination register is declared with
len = IFNAMSIZ (four 32-bit registers), but on the lookup-fail,
RTN_LOCAL and oif-mismatch paths nft_fib{4,6}_eval() only writes one
register via "*dest = 0". The remaining three registers are left as
whatever was on the stack in nft_do_chain()'s struct nft_regs, and a
downstream expression that loads the register span can leak that
uninitialised kernel stack to userspace.

The NFTA_FIB_F_PRESENT existence check has the same shape: it is only
meaningful for NFT_FIB_RESULT_OIF, yet it was accepted for any result type
while the eval stores a single byte via nft_reg_store8(), leaving the rest
of the declared span stale.

Fix both:

 - replace the bare "*dest = 0" in the eval with nft_fib_store_result(),
   which strscpy_pad()s the whole IFNAMSIZ for OIFNAME (and is already
   used on the other early-return path), and

 - restrict NFTA_FIB_F_PRESENT to NFT_FIB_RESULT_OIF and declare its
   destination as a single u8, so the marked span matches the one byte
   the eval writes.

Fixes: f6d0cbcf09c5 ("netfilter: nf_tables: add fib expression")
Suggested-by: Florian Westphal <fw@strlen.de>
Cc: stable@vger.kernel.org
Signed-off-by: Davide Ornaghi <d.ornaghi97@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
[ kept the tree's older `ip6_route_lookup()`/`rt6_info` IPv6 context and changed only `*dest = 0;` to `nft_fib_store_result(dest, priv, NULL);` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/netfilter/nft_fib_ipv4.c | 2 +-
 net/ipv6/netfilter/nft_fib_ipv6.c | 2 +-
 net/netfilter/nft_fib.c           | 6 ++++++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/netfilter/nft_fib_ipv4.c b/net/ipv4/netfilter/nft_fib_ipv4.c
index 82af6cd76d13e0..e695283aeb2d04 100644
--- a/net/ipv4/netfilter/nft_fib_ipv4.c
+++ b/net/ipv4/netfilter/nft_fib_ipv4.c
@@ -128,7 +128,7 @@ void nft_fib4_eval(const struct nft_expr *expr, struct nft_regs *regs,
 		fl4.saddr = get_saddr(iph->daddr);
 	}
 
-	*dest = 0;
+	nft_fib_store_result(dest, priv, NULL);
 
 	if (fib_lookup(nft_net(pkt), &fl4, &res, FIB_LOOKUP_IGNORE_LINKSTATE))
 		return;
diff --git a/net/ipv6/netfilter/nft_fib_ipv6.c b/net/ipv6/netfilter/nft_fib_ipv6.c
index 421036a3605b46..3005dfbca6155b 100644
--- a/net/ipv6/netfilter/nft_fib_ipv6.c
+++ b/net/ipv6/netfilter/nft_fib_ipv6.c
@@ -192,7 +192,7 @@ void nft_fib6_eval(const struct nft_expr *expr, struct nft_regs *regs,
 
 	lookup_flags = nft_fib6_flowi_init(&fl6, priv, pkt, oif, iph);
 
-	*dest = 0;
+	nft_fib_store_result(dest, priv, NULL);
 	rt = (void *)ip6_route_lookup(nft_net(pkt), &fl6, pkt->skb,
 				      lookup_flags);
 	if (rt->dst.error)
diff --git a/net/netfilter/nft_fib.c b/net/netfilter/nft_fib.c
index 96e02a83c045e2..22846136c754a2 100644
--- a/net/netfilter/nft_fib.c
+++ b/net/netfilter/nft_fib.c
@@ -107,6 +107,12 @@ int nft_fib_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 		return -EINVAL;
 	}
 
+	if (priv->flags & NFTA_FIB_F_PRESENT) {
+		if (priv->result != NFT_FIB_RESULT_OIF)
+			return -EINVAL;
+		len = sizeof(u8);
+	}
+
 	err = nft_parse_register_store(ctx, tb[NFTA_FIB_DREG], &priv->dreg,
 				       NULL, NFT_DATA_VALUE, len);
 	if (err < 0)
-- 
2.53.0


