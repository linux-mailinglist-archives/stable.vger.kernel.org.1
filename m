Return-Path: <stable+bounces-265786-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sp8UJB6QMWo1mwUAu9opvQ
	(envelope-from <stable+bounces-265786-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:04:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3321693C5E
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:04:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="QN/p3w1H";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265786-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-265786-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47C5D317B898
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71C23CFF55;
	Tue, 16 Jun 2026 18:02:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B761B3C5842;
	Tue, 16 Jun 2026 18:02:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632975; cv=none; b=ml2DVF7o+W9TXxZ97fK6Vq55EMR740PVzXgG1AXHuTYtOZL92xLP5rC1StqOmDta265iPxQ3y/CHgvu2L7kVbnhArPpto49DLnTy8BUOkSOh5AbL0XtEaAZjIToQ/oDA1+oGkfJlnwq7q+GmtWy2RJ26oeZovFTy7gE1hKOvkPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632975; c=relaxed/simple;
	bh=IeZijJ6DWBgowb4caEOEV24Zo8WI9dRqbgWcZN5ZMjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9opUhlNA/Kfrk0HBI2TuLw5zbT0OJdie2DovXjXFZJMHuVemzJooOvq7zTYzCp6eA2yRxbfsmOUDsMxYfyTn1YiOEBincmal159LqNyhN7diwEZq6nt6QQu9ykwhiFkUHv1zQsMDOcr410mCGwII+rgRKE8Zcy6Pat/v9PEYts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QN/p3w1H; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914B21F000E9;
	Tue, 16 Jun 2026 18:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781632974;
	bh=2g7vtNLDLt9hIpwKlCyxa2miV/aNVxKGlA9BbIcgtJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QN/p3w1H0cKkgSUHBmNHAenNIoJcEsuRbqKIMTCnwEMrRGHMq8//nRYAP3B8olhxM
	 8cPnrayXP660/BpqX2fE/DKAW1iD2qXXKQP9b15dOaL1rFZUtX91M0vslIh/xy8sXI
	 EocsLiWJPyObp5fKaNs9k9MfECSNBiJPiZFkUzCY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Davide Ornaghi <d.ornaghi97@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 480/522] netfilter: nft_fib: fix stale stack leak via the OIFNAME register
Date: Tue, 16 Jun 2026 20:30:27 +0530
Message-ID: <20260616145148.278338988@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,strlen.de,gmail.com,netfilter.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-265786-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:fw@strlen.de,m:d.ornaghi97@gmail.com,m:pablo@netfilter.org,m:sashal@kernel.org,m:dornaghi97@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,strlen.de:email,netfilter.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3321693C5E

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
[ kept the tree's existing `ip6_route_lookup`/`rt6_info` machinery (missing `fib6_lookup` refactor) and changed only `*dest = 0;` to `nft_fib_store_result(dest, priv, NULL)` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/netfilter/nft_fib_ipv4.c |    2 +-
 net/ipv6/netfilter/nft_fib_ipv6.c |    2 +-
 net/netfilter/nft_fib.c           |    6 ++++++
 3 files changed, 8 insertions(+), 2 deletions(-)

--- a/net/ipv4/netfilter/nft_fib_ipv4.c
+++ b/net/ipv4/netfilter/nft_fib_ipv4.c
@@ -122,7 +122,7 @@ void nft_fib4_eval(const struct nft_expr
 		fl4.saddr = get_saddr(iph->daddr);
 	}
 
-	*dest = 0;
+	nft_fib_store_result(dest, priv, NULL);
 
 	if (fib_lookup(nft_net(pkt), &fl4, &res, FIB_LOOKUP_IGNORE_LINKSTATE))
 		return;
--- a/net/ipv6/netfilter/nft_fib_ipv6.c
+++ b/net/ipv6/netfilter/nft_fib_ipv6.c
@@ -193,7 +193,7 @@ void nft_fib6_eval(const struct nft_expr
 		}
 	}
 
-	*dest = 0;
+	nft_fib_store_result(dest, priv, NULL);
 	rt = (void *)ip6_route_lookup(nft_net(pkt), &fl6, pkt->skb,
 				      lookup_flags);
 	if (rt->dst.error)
--- a/net/netfilter/nft_fib.c
+++ b/net/netfilter/nft_fib.c
@@ -107,6 +107,12 @@ int nft_fib_init(const struct nft_ctx *c
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



