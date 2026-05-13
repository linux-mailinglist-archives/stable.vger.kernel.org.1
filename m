Return-Path: <stable+bounces-246960-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMqwFuCzBGowNQIAu9opvQ
	(envelope-from <stable+bounces-246960-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:24:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C04537F84
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5015C306DC8D
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C833A1E9E;
	Wed, 13 May 2026 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCDN+wkk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A563911C0
	for <stable@vger.kernel.org>; Wed, 13 May 2026 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778692558; cv=none; b=ESTFDsfnQlKSBXJ3mdhE9/CB5AREiX9R0AgfnZ4CNyJLs4vyEiTQCAPoNuSefiyQc47SlULSM+G/nVopjsvTjqfa+TS/8RcaIl+8FR/vqd/HONrGxrUaXZryXIRnSQpmhm4FZ2uoTEwQAm6JUD9VLx1t2RKgKHXwpueGtc2GHHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778692558; c=relaxed/simple;
	bh=vn8aNs0u11qrZfqJ2XJRLT6HiW4TSN/mkhAV4AI1QYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXzQfEahZX4vrjds4cW55DglrE3wtqJMDiyuajsGn2S2F2tYYprgGPZyuEKEwUryEq288vhUWKAEcSjec8y/FxAwp2dvdWux3mWIYlQEhLPko6FnBGMcrzyJ3ixZ1Fu8xD1QbEl7ZbhmUDprxp2JNYyKa6q+qHJRbtLJB2FpkqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCDN+wkk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785C5C2BCC6;
	Wed, 13 May 2026 17:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778692558;
	bh=vn8aNs0u11qrZfqJ2XJRLT6HiW4TSN/mkhAV4AI1QYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KCDN+wkkZ4LBi0ZS+CaeMgdW5oJmfZX/Yr3HsarzIQrBfvZZE/snSGdZ9KkNLZlne
	 LSESymG0vDzv3LA5LBJ295PAuqk2uZKGpZMcRo9tByWq6L939Btkgu5spt0UbV0Cl3
	 VEley2s/EI/+/SCjPMxA8Fnv2+O3fHZNxJW6N4Agr4vY0n7ECVQD4cfuVQzh5561lu
	 imx90chigMOmBno3vPsNO7ajM+GO7bLI4/gIl0InevhY8NidZ5zt2UqHaLbr+mEQ6G
	 YgU0uix6ZoszdGfSaMitt8SUYYn+jkhLMdhR9ufEYEHHZNTzP8ArXe41KH/qcxiSA/
	 f16RAEfOet9GA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] net: ipv6: stop checking crypto_ahash_alignmask
Date: Wed, 13 May 2026 13:15:53 -0400
Message-ID: <20260513171555.3876989-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513171555.3876989-1-sashal@kernel.org>
References: <2026051236-writing-prior-b532@gregkh>
 <20260513171555.3876989-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 99C04537F84
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246960-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
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
index 4bc6767c7e139..da79228f0c5de 100644
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
@@ -330,7 +327,7 @@ static void ah6_output_done(struct crypto_async_request *base, int err)
 
 	iph_base = AH_SKB_CB(skb)->tmp;
 	iph_ext = ah_tmp_ext(iph_base);
-	icv = ah_tmp_icv(ahp->ahash, iph_ext, extlen);
+	icv = ah_tmp_icv(iph_ext, extlen);
 
 	memcpy(ah->auth_data, icv, ahp->icv_trunc_len);
 	memcpy(top_iph, iph_base, IPV6HDR_BASELEN);
@@ -387,7 +384,7 @@ static int ah6_output(struct xfrm_state *x, struct sk_buff *skb)
 
 	iph_ext = ah_tmp_ext(iph_base);
 	seqhi = (__be32 *)((char *)iph_ext + extlen);
-	icv = ah_tmp_icv(ahash, seqhi, seqhi_len);
+	icv = ah_tmp_icv(seqhi, seqhi_len);
 	req = ah_tmp_req(ahash, icv);
 	sg = ah_req_sg(ahash, req);
 	seqhisg = sg + nfrags;
@@ -483,7 +480,7 @@ static void ah6_input_done(struct crypto_async_request *base, int err)
 
 	work_iph = AH_SKB_CB(skb)->tmp;
 	auth_data = ah_tmp_auth(work_iph, hdr_len);
-	icv = ah_tmp_icv(ahp->ahash, auth_data, ahp->icv_trunc_len);
+	icv = ah_tmp_icv(auth_data, ahp->icv_trunc_len);
 
 	err = crypto_memneq(icv, auth_data, ahp->icv_trunc_len) ? -EBADMSG : 0;
 	if (err)
@@ -591,7 +588,7 @@ static int ah6_input(struct xfrm_state *x, struct sk_buff *skb)
 
 	auth_data = ah_tmp_auth((u8 *)work_iph, hdr_len);
 	seqhi = (__be32 *)(auth_data + ahp->icv_trunc_len);
-	icv = ah_tmp_icv(ahash, seqhi, seqhi_len);
+	icv = ah_tmp_icv(seqhi, seqhi_len);
 	req = ah_tmp_req(ahash, icv);
 	sg = ah_req_sg(ahash, req);
 	seqhisg = sg + nfrags;
-- 
2.53.0


