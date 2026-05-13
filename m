Return-Path: <stable+bounces-246944-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBBeJwqtBGoRNAIAu9opvQ
	(envelope-from <stable+bounces-246944-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:55:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F53C537842
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0268230F01F2
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 16:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A094D990A;
	Wed, 13 May 2026 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEwoF8RL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9D24D9902
	for <stable@vger.kernel.org>; Wed, 13 May 2026 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690799; cv=none; b=alsTLsenOJ33X1yzlhqur49RMFlZsPC818KYOo3J3uBTwl4Ae5jVEbKpVWsNnMliMBn1pTJ193uruqxuP1lznLDQWTW2Y4k7FVWixDDlvoxMOfG8ZoG9RH2gtgBQtCU6v+GyhApkeC48YUo0UP2RcZCQPAfNegKFYTr5TNQETmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690799; c=relaxed/simple;
	bh=vZmdIGwsYPnbljN86QTIUdEWqvmyJPPqxQtZvDMrEfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgGRtWtAJGf3bLaZnEDhpgh2bueMo8aHizbCLOEnkwoUvw2Yh6youNuB5N4rOGsnNGYAS1u9Fl2CUR0d7rQE+PqgBf4CN7DPGBDzWAEgMqSQ9dWq9uGIPjMzzlJbFUlMWlmSrF+JX82v/REUiycbu/gDPx27BV3gibE/M9sPLq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEwoF8RL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9F3C2BCC6;
	Wed, 13 May 2026 16:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778690798;
	bh=vZmdIGwsYPnbljN86QTIUdEWqvmyJPPqxQtZvDMrEfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rEwoF8RLwxhUU9qeParGp8w0VemR7Klk8VuoicUZFWSDzYHRVaR6+SZUO2o5cyH/b
	 /Z3NUTf6X6KwgZ2n98pD7JO39A5f4SMOls3gHQBFWeptRNJle2uRTKghL2Z5tTQtFD
	 PKuNDGmwIJb+SQ4/N/ILhSjq9Hc8BPfJjGs/5zaJtBTFxaUfAh4lYhQsel7Xep192k
	 Kw+kNoUSzpYWvK7AoXzKHxtn6wZTwHIw49VOSXhRSlp0WRSqj0AF220h9zsp5+5f8Y
	 1cmhbJKnGfg+bIUN8gxEUDIzw1On/puSBULW1DV3fmncupYSZg+4p1Zqs/As4/ZduO
	 nCvLRCGgA+Q3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] net: ipv6: stop checking crypto_ahash_alignmask
Date: Wed, 13 May 2026 12:46:34 -0400
Message-ID: <20260513164635.3816490-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513164635.3816490-1-sashal@kernel.org>
References: <2026051234-stabilize-delicious-029c@gregkh>
 <20260513164635.3816490-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0F53C537842
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246944-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit 0a6bfaa0e695facb072f2fedfb55df37c4483b50 ]

Now that the alignmask for ahash and shash algorithms is always 0,
crypto_ahash_alignmask() always returns 0 and will be removed.  In
preparation for this, stop checking crypto_ahash_alignmask() in ah6.c.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: ec54093e6a8f ("xfrm: ah: account for ESN high bits in async callbacks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ah6.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/net/ipv6/ah6.c b/net/ipv6/ah6.c
index 5361e2107458f..1938d96e2c0fd 100644
--- a/net/ipv6/ah6.c
+++ b/net/ipv6/ah6.c
@@ -79,9 +79,7 @@ static void *ah_alloc_tmp(struct crypto_ahash *ahash, int nfrags,
 {
 	unsigned int len;
 
-	len = size + crypto_ahash_digestsize(ahash) +
-	      (crypto_ahash_alignmask(ahash) &
-	       ~(crypto_tfm_ctx_alignment() - 1));
+	len = size + crypto_ahash_digestsize(ahash);
 
 	len = ALIGN(len, crypto_tfm_ctx_alignment());
 
@@ -103,10 +101,9 @@ static inline u8 *ah_tmp_auth(u8 *tmp, unsigned int offset)
 	return tmp + offset;
 }
 
-static inline u8 *ah_tmp_icv(struct crypto_ahash *ahash, void *tmp,
-			     unsigned int offset)
+static inline u8 *ah_tmp_icv(void *tmp, unsigned int offset)
 {
-	return PTR_ALIGN((u8 *)tmp + offset, crypto_ahash_alignmask(ahash) + 1);
+	return tmp + offset;
 }
 
 static inline struct ahash_request *ah_tmp_req(struct crypto_ahash *ahash,
@@ -327,7 +324,7 @@ static void ah6_output_done(void *data, int err)
 
 	iph_base = AH_SKB_CB(skb)->tmp;
 	iph_ext = ah_tmp_ext(iph_base);
-	icv = ah_tmp_icv(ahp->ahash, iph_ext, extlen);
+	icv = ah_tmp_icv(iph_ext, extlen);
 
 	memcpy(ah->auth_data, icv, ahp->icv_trunc_len);
 	memcpy(top_iph, iph_base, IPV6HDR_BASELEN);
@@ -384,7 +381,7 @@ static int ah6_output(struct xfrm_state *x, struct sk_buff *skb)
 
 	iph_ext = ah_tmp_ext(iph_base);
 	seqhi = (__be32 *)((char *)iph_ext + extlen);
-	icv = ah_tmp_icv(ahash, seqhi, seqhi_len);
+	icv = ah_tmp_icv(seqhi, seqhi_len);
 	req = ah_tmp_req(ahash, icv);
 	sg = ah_req_sg(ahash, req);
 	seqhisg = sg + nfrags;
@@ -480,7 +477,7 @@ static void ah6_input_done(void *data, int err)
 
 	work_iph = AH_SKB_CB(skb)->tmp;
 	auth_data = ah_tmp_auth(work_iph, hdr_len);
-	icv = ah_tmp_icv(ahp->ahash, auth_data, ahp->icv_trunc_len);
+	icv = ah_tmp_icv(auth_data, ahp->icv_trunc_len);
 
 	err = crypto_memneq(icv, auth_data, ahp->icv_trunc_len) ? -EBADMSG : 0;
 	if (err)
@@ -588,7 +585,7 @@ static int ah6_input(struct xfrm_state *x, struct sk_buff *skb)
 
 	auth_data = ah_tmp_auth((u8 *)work_iph, hdr_len);
 	seqhi = (__be32 *)(auth_data + ahp->icv_trunc_len);
-	icv = ah_tmp_icv(ahash, seqhi, seqhi_len);
+	icv = ah_tmp_icv(seqhi, seqhi_len);
 	req = ah_tmp_req(ahash, icv);
 	sg = ah_req_sg(ahash, req);
 	seqhisg = sg + nfrags;
-- 
2.53.0


