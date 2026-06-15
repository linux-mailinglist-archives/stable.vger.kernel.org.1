Return-Path: <stable+bounces-263105-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SNtjEm13L2pyBAUAu9opvQ
	(envelope-from <stable+bounces-263105-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 05:54:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE13B683278
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 05:54:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=CZolEe8H;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263105-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263105-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29E333012C64
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 03:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98E2277C9D;
	Mon, 15 Jun 2026 03:49:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCFB1DE3DC
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 03:49:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495387; cv=none; b=EeO8MOXv6cfCNt+I9q640ArZx3UjQpbUEO7b73CVYJy1k7mHVytqBzacvDJM6sqzK0JXwWrBXIyCQS/N1DcYMtMGjj+1Xnv1k3KzehuOfQrceJkSM6xVfWzhKVLQNGs51wGX1qCc2+qDdUddzxFuUZnMxog+L1gDjgug9jbNjKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495387; c=relaxed/simple;
	bh=aVG+kw3y4mYRMcSexB8LORYNN4Ly82YakGrUM6yRePI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ikb1Gy8P4hlRLVssGDqmZLh8cYPzQj4MJhaVagv7SN3uhFM65wEP9ODXGFbxgsMVgvM7nv1EP+oTcwjvLUb4JCx6ErFGE1vQgsWfer/+R6HCLSdUqanKieV45y4HCfwi6W5V3gBAH6lCcQAdF64LPXKRb08raaxAily5kKCQ/Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CZolEe8H; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791081F000E9;
	Mon, 15 Jun 2026 03:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781495386;
	bh=6lxIGYGvsir4kA47LgOTh1HcUwerjV1VoQ2nOEAzY60=;
	h=Subject:To:Cc:From:Date;
	b=CZolEe8HGkI7kZux5aZYiE9EBAmCdXl42M2yG1T1h27PY9rVIwMze39ecjTqSJVlU
	 2xdWoy/QTNWPWcKC2Oib/g/aiXr9z4PSDylTK2/LQudiH/fzbpDCr14eOf7pKrmbyC
	 PbgmV6OTUzIP9oL94PrxpLMYKBEi2F8tbLM5iYhs=
Subject: FAILED: patch "[PATCH] netfilter: nft_fib: fix stale stack leak via the OIFNAME" failed to apply to 6.18-stable tree
To: d.ornaghi97@gmail.com,fw@strlen.de,pablo@netfilter.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 05:48:41 +0200
Message-ID: <2026061541-acrobat-user-e460@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263105-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:d.ornaghi97@gmail.com,m:fw@strlen.de,m:pablo@netfilter.org,m:stable@vger.kernel.org,m:dornaghi97@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,strlen.de,netfilter.org];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gregkh:mid,strlen.de:email,linuxfoundation.org:dkim,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE13B683278


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x ab185e0c4fb82dfba6fb86f8271e06f931d9c64c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061541-acrobat-user-e460@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ab185e0c4fb82dfba6fb86f8271e06f931d9c64c Mon Sep 17 00:00:00 2001
From: Davide Ornaghi <d.ornaghi97@gmail.com>
Date: Wed, 10 Jun 2026 12:39:12 +0200
Subject: [PATCH] netfilter: nft_fib: fix stale stack leak via the OIFNAME
 register

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

diff --git a/net/ipv4/netfilter/nft_fib_ipv4.c b/net/ipv4/netfilter/nft_fib_ipv4.c
index 9d0c6d75109b..177d738825b4 100644
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
index 2dbe44715df3..b9ad7cac1417 100644
--- a/net/ipv6/netfilter/nft_fib_ipv6.c
+++ b/net/ipv6/netfilter/nft_fib_ipv6.c
@@ -239,7 +239,7 @@ void nft_fib6_eval(const struct nft_expr *expr, struct nft_regs *regs,
 
 	lookup_flags = nft_fib6_flowi_init(&fl6, priv, pkt, oif, iph);
 
-	*dest = 0;
+	nft_fib_store_result(dest, priv, NULL);
 	ret = nft_fib6_lookup(nft_net(pkt), &fl6, &res, lookup_flags);
 	if (ret || res.fib6_flags & (RTF_REJECT | RTF_ANYCAST | RTF_LOCAL))
 		return;
diff --git a/net/netfilter/nft_fib.c b/net/netfilter/nft_fib.c
index 327a5f33659c..a1632e308f18 100644
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


