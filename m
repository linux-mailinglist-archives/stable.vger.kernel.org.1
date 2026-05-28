Return-Path: <stable+bounces-255448-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAN8ETKhGGqnlggAu9opvQ
	(envelope-from <stable+bounces-255448-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:10:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9FA5F7F9E
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91DBE306951B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A59409602;
	Thu, 28 May 2026 20:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HZzjLkII"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1B4352019;
	Thu, 28 May 2026 20:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998940; cv=none; b=kT5Gd2XSA/XgT0VudKNv1Fw8HuiNaLnXj8R9irPcOlxpeET4nT0ITv6Pw9f232XzIBcu7KwuqNYHgu8vvZ/dH8NZfOoVpSUWvqKp54m5eoU+AJt+5F+0fSYKGl3Qlx2AwEizLopwCYspNVx8202v9Et+u4YKDiOPPmTxquoULFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998940; c=relaxed/simple;
	bh=pqPvhJMfC2C4YcZWW33eaUVrluMNg1NkPfXY8qf0CcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hA27YLYfgOZL5ZlMAADhvbG11Uf7Eoxi8jkC/YH4bTE6UFV0WQLHpLbV49n7aeE/Rzg90E+OD1/LW7lUYZztFjNfRX/mA0/3S0e9KglHYLCRPHMY7kEf5wPsRZX1LlB1sROwdbnN8vsbGuLtWmdjdxOkuLRLoM3UFSzG/hmi92w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HZzjLkII; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA2D1F000E9;
	Thu, 28 May 2026 20:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998939;
	bh=fu+29yf0gZjJgqRLBE7YoNCLkU/JlEpS8bU4bHPDLHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HZzjLkIIGcD7ChjJ7lwJc989hlOCF8LhbPYh0jvwlWyTPII/p45latmu4sPIyxf7a
	 45ohpwS8NiHaeT8tINGdu5k9lv1YmGMFUwVWtfTe6/zDUKWtHXxyQKmI2ri4iEQ0o4
	 6WJ7nzaMHbxsWoG31PvFGRUh/tmoSo2R2FQ8IrSY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 350/461] netfilter: nft_inner: release local_lock before re-enabling softirqs
Date: Thu, 28 May 2026 21:47:59 +0200
Message-ID: <20260528194657.524269275@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255448-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.de:email,strlen.de:email]
X-Rspamd-Queue-Id: DF9FA5F7F9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit a6cb3ff979855f7f0ee9450a947fe8f96c2ba37a ]

Quoting sashiko:
 In the error path, local_bh_enable() is called before
 local_unlock_nested_bh().

Fixes: ba36fada9ab4 ("netfilter: nft_inner: Use nested-BH locking for nft_pcpu_tun_ctx")
Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_inner.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_inner.c b/net/netfilter/nft_inner.c
index 1b3e7a976f560..ad08a43535b55 100644
--- a/net/netfilter/nft_inner.c
+++ b/net/netfilter/nft_inner.c
@@ -246,8 +246,8 @@ static bool nft_inner_restore_tun_ctx(const struct nft_pktinfo *pkt,
 	local_lock_nested_bh(&nft_pcpu_tun_ctx.bh_lock);
 	this_cpu_tun_ctx = this_cpu_ptr(&nft_pcpu_tun_ctx.ctx);
 	if (this_cpu_tun_ctx->cookie != (unsigned long)pkt->skb) {
-		local_bh_enable();
 		local_unlock_nested_bh(&nft_pcpu_tun_ctx.bh_lock);
+		local_bh_enable();
 		return false;
 	}
 	*tun_ctx = *this_cpu_tun_ctx;
-- 
2.53.0




