Return-Path: <stable+bounces-252648-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPe8ILP8DWoK5QUAu9opvQ
	(envelope-from <stable+bounces-252648-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:25:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FCA5961D1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2115530F9E6D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39A93D1CC6;
	Wed, 20 May 2026 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V66eEk0H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2AC3F88B8;
	Wed, 20 May 2026 18:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301226; cv=none; b=QGZVZH0yYvTySAmedX9lpB/GJmFtVTOhJ2AWfxe2laH+drmc7J5zebpboy0NNZzKNNhZsAuWUSp94A5RaAprgnqsrCzohyTt4BEkIgSNQyFU3bPksdfTqQW7h18LkzL4sesH2xK8M5gLJqMw6qpu/oNFdv79S6nlMguUUd7SgTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301226; c=relaxed/simple;
	bh=9Bop+ig0fa+30rPTz84DvHznCgkJpDrDAwo32f1m8n0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDFUze9LMiZq+JadhvCvSzNpYyZoIUbUY56u0Pn+UEjokW4EyvgoCqAFSrrZj0AURmD/NIEJ6p8dY2mMyvE+DePOB3z3q1EY3GRjDC/Hc7+7/pg258z8+cJ8LcxtfEmgXuNukFlYTMMuQKvbSeU/aO+Sj1FHXs5MJjeYHKWj3Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V66eEk0H; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBF51F000E9;
	Wed, 20 May 2026 18:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301225;
	bh=pbAIDkYDDqT1GSFA6GucUaRz8pAIx26Ak9PnvSvtpWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V66eEk0H7AjKvCgGY6PX7eRYkBBmmMNpF6Hxwo/Th4n8l6PXCdYDzxhqJxNG4kBJr
	 4LBAlD/oXNiVINDFoB5dL6cY8J1U990zmz3z9praEx/+dle3xGBIfnoLEKVpTpFn4F
	 K+yBQry73OalMoGVsduxml/aVT2qnzgbCTlVpaPE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 472/666] netfilter: nfnetlink_osf: fix out-of-bounds read on option matching
Date: Wed, 20 May 2026 18:21:23 +0200
Message-ID: <20260520162121.500221024@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252648-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,strlen.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:email,netfilter.org:email]
X-Rspamd-Queue-Id: 27FCA5961D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fernando Fernandez Mancera <fmancera@suse.de>

[ Upstream commit f5ca450087c3baf3651055e7a6de92600f827af3 ]

In nf_osf_match(), the nf_osf_hdr_ctx structure is initialized once
and passed by reference to nf_osf_match_one() for each fingerprint
checked. During TCP option parsing, nf_osf_match_one() advances the
shared ctx->optp pointer.

If a fingerprint perfectly matches, the function returns early without
restoring ctx->optp to its initial state. If the user has configured
NF_OSF_LOGLEVEL_ALL, the loop continues to the next fingerprint.
However, because ctx->optp was not restored, the next call to
nf_osf_match_one() starts parsing from the end of the options buffer.
This causes subsequent matches to read garbage data and fail
immediately, making it impossible to log more than one match or logging
incorrect matches.

Instead of using a shared ctx->optp pointer, pass the context as a
constant pointer and use a local pointer (optp) for TCP option
traversal. This makes nf_osf_match_one() strictly stateless from the
caller's perspective, ensuring every fingerprint check starts at the
correct option offset.

Fixes: 1a6a0951fc00 ("netfilter: nfnetlink_osf: add missing fmatch check")
Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Reviewed-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nfnetlink_osf.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/net/netfilter/nfnetlink_osf.c b/net/netfilter/nfnetlink_osf.c
index 2305c7d9761eb..832a973c41777 100644
--- a/net/netfilter/nfnetlink_osf.c
+++ b/net/netfilter/nfnetlink_osf.c
@@ -64,9 +64,9 @@ struct nf_osf_hdr_ctx {
 static bool nf_osf_match_one(const struct sk_buff *skb,
 			     const struct nf_osf_user_finger *f,
 			     int ttl_check,
-			     struct nf_osf_hdr_ctx *ctx)
+			     const struct nf_osf_hdr_ctx *ctx)
 {
-	const __u8 *optpinit = ctx->optp;
+	const __u8 *optp = ctx->optp;
 	unsigned int check_WSS = 0;
 	int fmatch = FMATCH_WRONG;
 	int foptsize, optnum;
@@ -95,17 +95,17 @@ static bool nf_osf_match_one(const struct sk_buff *skb,
 	check_WSS = f->wss.wc;
 
 	for (optnum = 0; optnum < f->opt_num; ++optnum) {
-		if (f->opt[optnum].kind == *ctx->optp) {
+		if (f->opt[optnum].kind == *optp) {
 			__u32 len = f->opt[optnum].length;
-			const __u8 *optend = ctx->optp + len;
+			const __u8 *optend = optp + len;
 
 			fmatch = FMATCH_OK;
 
-			switch (*ctx->optp) {
+			switch (*optp) {
 			case OSFOPT_MSS:
-				mss = ctx->optp[3];
+				mss = optp[3];
 				mss <<= 8;
-				mss |= ctx->optp[2];
+				mss |= optp[2];
 
 				mss = ntohs((__force __be16)mss);
 				break;
@@ -113,7 +113,7 @@ static bool nf_osf_match_one(const struct sk_buff *skb,
 				break;
 			}
 
-			ctx->optp = optend;
+			optp = optend;
 		} else
 			fmatch = FMATCH_OPT_WRONG;
 
@@ -156,9 +156,6 @@ static bool nf_osf_match_one(const struct sk_buff *skb,
 		}
 	}
 
-	if (fmatch != FMATCH_OK)
-		ctx->optp = optpinit;
-
 	return fmatch == FMATCH_OK;
 }
 
-- 
2.53.0




