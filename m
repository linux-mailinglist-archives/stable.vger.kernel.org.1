Return-Path: <stable+bounces-246943-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLjwIZSrBGoxMwIAu9opvQ
	(envelope-from <stable+bounces-246943-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:49:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F34537690
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0DD730230E3
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 16:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71204A13A1;
	Wed, 13 May 2026 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0pqSFlN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511CF4D98E3
	for <stable@vger.kernel.org>; Wed, 13 May 2026 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690798; cv=none; b=kEsrgQUUdqs9z+LnATd6YkZAxxaxRcYPiB6OMIp4vFNTDtjI9eqRwa7LrjAzDEWekfg4XVTN0bvM0CiPnPnY5eb0GogQW2lBdC0IM7LL0g3Gm9R1zFaAUHPXSLJns+SeXzXExU/4O6kZxPqGf4SwB238VrfGSHbxlc9dixInj/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690798; c=relaxed/simple;
	bh=aoobRYZrJglvPm4f+rZ+J/xeV7NE6RF2ZpnuEbhqV9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0gc8bX5fiVbM5VnH2fQowtjvk3FnaK4KHSAgQDLog4uXez9yWWh+o7l8qi6SRyiVG0+C0WKoRolMIhgvL4HFb/2f6hCh5rRKlfX6klsBxcB6GquDuG0RImnw79W9ggfgOCTHMov+OBKdPzrIe/wyVXPiHJ+GJFcDnsQ5XwXwHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0pqSFlN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AD9C2BCB7;
	Wed, 13 May 2026 16:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778690798;
	bh=aoobRYZrJglvPm4f+rZ+J/xeV7NE6RF2ZpnuEbhqV9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N0pqSFlNEzllACL+oYbSBZFEUeYCpN2K9zjMiBsVb30ffGJ+IFITwYJAiW/R7w4U0
	 QDn7O+JINnWQSi6ReVFOp3XvrCDDhDRT0ckmqjazkevn6GYemG30ucP9eFuF0YK8Or
	 qncdA3mpZ+FKXPZPqSNzDS7dw+DYBjZjVizJRD48q7O34FtgFn8Fm3NLK8JJSaUB20
	 K4jkJi32HSoMp8W7yip1a0TEB9Wm5660yv4PuVDEipGEI8dgSzuufXwLz3s5rnmWJL
	 juGQBWPQqIDXGvnA9KSagjFfuE7oQkAOl0xKdNC5/lP2MEKn5T349/9UpwXfNjD/mD
	 URKnAOnzovMkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] net: ipv4: stop checking crypto_ahash_alignmask
Date: Wed, 13 May 2026 12:46:33 -0400
Message-ID: <20260513164635.3816490-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051234-stabilize-delicious-029c@gregkh>
References: <2026051234-stabilize-delicious-029c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 25F34537690
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246943-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,apana.org.au:email]
X-Rspamd-Action: no action

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit e77f5dd701381cef35b9ea8b6dea6e62c8a7f9f3 ]

Now that the alignmask for ahash and shash algorithms is always 0,
crypto_ahash_alignmask() always returns 0 and will be removed.  In
preparation for this, stop checking crypto_ahash_alignmask() in ah4.c.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: ec54093e6a8f ("xfrm: ah: account for ESN high bits in async callbacks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ah4.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/ah4.c b/net/ipv4/ah4.c
index 015c0f4ec5ba9..cf31fb266bc10 100644
--- a/net/ipv4/ah4.c
+++ b/net/ipv4/ah4.c
@@ -27,9 +27,7 @@ static void *ah_alloc_tmp(struct crypto_ahash *ahash, int nfrags,
 {
 	unsigned int len;
 
-	len = size + crypto_ahash_digestsize(ahash) +
-	      (crypto_ahash_alignmask(ahash) &
-	       ~(crypto_tfm_ctx_alignment() - 1));
+	len = size + crypto_ahash_digestsize(ahash);
 
 	len = ALIGN(len, crypto_tfm_ctx_alignment());
 
@@ -46,10 +44,9 @@ static inline u8 *ah_tmp_auth(void *tmp, unsigned int offset)
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
@@ -129,7 +126,7 @@ static void ah_output_done(void *data, int err)
 	int ihl = ip_hdrlen(skb);
 
 	iph = AH_SKB_CB(skb)->tmp;
-	icv = ah_tmp_icv(ahp->ahash, iph, ihl);
+	icv = ah_tmp_icv(iph, ihl);
 	memcpy(ah->auth_data, icv, ahp->icv_trunc_len);
 
 	top_iph->tos = iph->tos;
@@ -182,7 +179,7 @@ static int ah_output(struct xfrm_state *x, struct sk_buff *skb)
 	if (!iph)
 		goto out;
 	seqhi = (__be32 *)((char *)iph + ihl);
-	icv = ah_tmp_icv(ahash, seqhi, seqhi_len);
+	icv = ah_tmp_icv(seqhi, seqhi_len);
 	req = ah_tmp_req(ahash, icv);
 	sg = ah_req_sg(ahash, req);
 	seqhisg = sg + nfrags;
@@ -279,7 +276,7 @@ static void ah_input_done(void *data, int err)
 
 	work_iph = AH_SKB_CB(skb)->tmp;
 	auth_data = ah_tmp_auth(work_iph, ihl);
-	icv = ah_tmp_icv(ahp->ahash, auth_data, ahp->icv_trunc_len);
+	icv = ah_tmp_icv(auth_data, ahp->icv_trunc_len);
 
 	err = crypto_memneq(icv, auth_data, ahp->icv_trunc_len) ? -EBADMSG : 0;
 	if (err)
@@ -374,7 +371,7 @@ static int ah_input(struct xfrm_state *x, struct sk_buff *skb)
 
 	seqhi = (__be32 *)((char *)work_iph + ihl);
 	auth_data = ah_tmp_auth(seqhi, seqhi_len);
-	icv = ah_tmp_icv(ahash, auth_data, ahp->icv_trunc_len);
+	icv = ah_tmp_icv(auth_data, ahp->icv_trunc_len);
 	req = ah_tmp_req(ahash, icv);
 	sg = ah_req_sg(ahash, req);
 	seqhisg = sg + nfrags;
-- 
2.53.0


