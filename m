Return-Path: <stable+bounces-265522-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZKjBIgqMMWoxmQUAu9opvQ
	(envelope-from <stable+bounces-265522-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:46:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A78C4693784
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:46:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="jQnMoHO/";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265522-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265522-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 139C73031EA4
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C694779A8;
	Tue, 16 Jun 2026 17:40:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4A83C4178;
	Tue, 16 Jun 2026 17:40:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631643; cv=none; b=W+5+F+Hal6gV7LFvQL9AzjzIJgtwMBGLAH5efTpF9m9RBr9pGgrB0LkKY53LuYBrjgc/2gwcHmDxbtCKv9Fjp42b/GoelNZgAeiYEJglCoqKTuWFZVyT2nhOLWeOepBo6hMHjXJjNnybmmgB52htnyoXOUloEhfkMpsnCwQTTV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631643; c=relaxed/simple;
	bh=I1irsbtjfZdU0IVnbDTzSFHYDUETrJEoMUHc7wRKi+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V16tOhnr87gFID7dFdiKJ2/1UOYahwp1/Y9IiD3CNPsynqGl8UVoCRNaieLzBk1F9lzivI4rNLZ6dwybAzyaUEaysCMF6LlwCSNp72z5rEs6n0m9HbvJFV3RYHzzpNjGPG1C+7QUN8XpDzlELDim0v/fpz+849/2UVzrMOwOWgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jQnMoHO/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04781F000E9;
	Tue, 16 Jun 2026 17:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781631638;
	bh=4pSJJqhYM2bdZ97xKBmD4qmYPxqpcKo1PvoWoTd0wno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jQnMoHO/XuBnMkc5vQUFgIg9IkpNB0yzSlwHahSVSC7uZmEdDC6cHXuTACmHgEmxx
	 RU4IMC/eOdG/7S1rIEngMeJWw4yT1JVkJmVQRBVYbQaKRvX+gwcD1d69iuhjhVTCyp
	 GJ5AaGOXTSD9lZnUfsEy7QSdEGLbYeMAGpXL0Qcc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jian Zhou <eilaimemedsnaimel@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 259/522] netfilter: nft_exthdr: fix register tracking for F_PRESENT flag
Date: Tue, 16 Jun 2026 20:26:46 +0530
Message-ID: <20260616145138.063894277@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,strlen.de,netfilter.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-265522-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:eilaimemedsnaimel@gmail.com,m:fw@strlen.de,m:pablo@netfilter.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,netfilter.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A78C4693784

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 772cecf198da732faebb5dcfc46d66a505be8495 ]

nft_exthdr_init() passes user-controlled priv->len to
nft_parse_register_store(), which marks that many bytes in the
register bitmap as initialized.  However, when NFT_EXTHDR_F_PRESENT
is set, the eval paths write only 1 byte (nft_reg_store8) or
4 bytes (*dest = 0 on TCP/DCCP error path).  When len > 4,
registers beyond the first are never written, retaining
uninitialized stack data from nft_regs.

Bail out if userspace requests too much data when F_PRESENT is set.

Reported-by: Ji'an Zhou <eilaimemedsnaimel@gmail.com>
Fixes: c078ca3b0c5b ("netfilter: nft_exthdr: Add support for existence check")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_exthdr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index 60d18bd60d821e..a7cb4dd6205e9f 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -531,6 +531,9 @@ static int nft_exthdr_init(const struct nft_ctx *ctx,
 			return err;
 	}
 
+	if ((flags & NFT_EXTHDR_F_PRESENT) && len != 1)
+		return -EINVAL;
+
 	priv->type   = nla_get_u8(tb[NFTA_EXTHDR_TYPE]);
 	priv->offset = offset;
 	priv->len    = len;
-- 
2.53.0




