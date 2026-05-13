Return-Path: <stable+bounces-246946-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QF/VNcOzBGowNQIAu9opvQ
	(envelope-from <stable+bounces-246946-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:24:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAB3537F56
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3E5731E8959
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 16:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8A148B38F;
	Wed, 13 May 2026 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jv999eyb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32285477E28
	for <stable@vger.kernel.org>; Wed, 13 May 2026 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778691178; cv=none; b=k1YOl8/OkCZsGdrrA9TzvZA1ISylG3conGpfvtEOUJAioxsim80+9i+TlFZnMFfVahFOlhqhZb6/dKFRs7r9sXWLb0Lp05MrXVn5SqAtE4rOxB28OOkapn8Hn0roon1I8z4dSKJ6FjIBVk8pBuQTPlftMP6bi1nzkeUqFDKLas0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778691178; c=relaxed/simple;
	bh=EFkuAh1bOq735j0n4hinCZCq3tEHy4MHBpZ0GB0UJ2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4n/Pcp4+8XuXKb3m7/nM2j/25/dVY11qYM11rn39f5vRDAJ6aT0A/twJh6dN1YjBeXDkJHbx+2JKHJfno+hQxk5Lr7sFKjdxlKi6oliCS9RswhUjUOZaH7V2odZb1TZ0F5o2bIbb58Cvpl3ji9QTBYDlFZb72xoCVeRvyFdeJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jv999eyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4080CC19425;
	Wed, 13 May 2026 16:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778691177;
	bh=EFkuAh1bOq735j0n4hinCZCq3tEHy4MHBpZ0GB0UJ2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jv999eybwjZj3G0sQ78s7QaoVoHDoAb1ao9O5SiWc4UugMadbfJjJzsiEF8qR1ULW
	 aEw118YbLZJnIJ7UuujAU9ffgdyc7PrmYz4iGs+pI75ytyY0zSkOTIxeBxt+qt9pT3
	 Ds7RpZHT9fwrH3N53slGZa2hxHmrkQvqeOYrPN5NZ+obmRne5oSpfWeKQ5ej7YmC1O
	 J5Hslu9TmanOWbpfcAIvjlfFdnSb+psOQmja9QbGu1RgYspKNRDSKl0maaYaBDEuyj
	 cXcQV6iP71UVTC6wBo0VPR1tMSSV72e5Pvl6VzyfGeXetzIC0kAkTNAZdn6rw7+s1G
	 RHy77JmH2qeeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] net: ipv4: stop checking crypto_ahash_alignmask
Date: Wed, 13 May 2026 12:52:53 -0400
Message-ID: <20260513165255.3822003-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051235-gigolo-wriggle-f7a3@gregkh>
References: <2026051235-gigolo-wriggle-f7a3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3FAB3537F56
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246946-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:email]
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
index ee4e578c7f201..c64e3212581bc 100644
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
@@ -129,7 +126,7 @@ static void ah_output_done(struct crypto_async_request *base, int err)
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
@@ -279,7 +276,7 @@ static void ah_input_done(struct crypto_async_request *base, int err)
 
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


