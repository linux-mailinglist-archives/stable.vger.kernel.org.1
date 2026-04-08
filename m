Return-Path: <stable+bounces-234483-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNhbMvSe1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234483-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:31:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 237453C0DBC
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C997330166F0
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B093D6CB9;
	Wed,  8 Apr 2026 18:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QmlLyYPe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364583D4134;
	Wed,  8 Apr 2026 18:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672977; cv=none; b=mFV5UApGKXQ/V4KWg5fkAr2vSMHNkswPZqLT2WablONJLG0yAHmQsqs3MAdvzI7fXbI8SsbwokY/1nC3vv1yia2+7+h53iy//RYDbX9vxhOeNCfFMRlKlHQ/kEkztlFH+B5RoBoHx0Ei9nxSFNZSHcGwMSO0e8D9YCe4JP31/Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672977; c=relaxed/simple;
	bh=rgUpga0EBCGB0w3W+47iAFHvFENzSkK2QPZ/f3gr7Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyquRmFLUF39+7o79g1pWI4V/EO+8WZTMVS9jZqjT1e07eK/VS98GjrdPB85bjgmgxEcBlJP80fUf4XWO1/CpcgnczI3ChXnS+0lhBLbVyZcMEXZmfgjZk0Gk4We7LZP8KN1tyg7bvVyP1AcJkMHICvyY2tzRQMcZm2DzF7F2eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QmlLyYPe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDFDC19421;
	Wed,  8 Apr 2026 18:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672977;
	bh=rgUpga0EBCGB0w3W+47iAFHvFENzSkK2QPZ/f3gr7Vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QmlLyYPeic7K+6VeceYKi2zijDjKnq5w1ACCUqOLBMd7RloA2RkF14g4OGeiU9CHQ
	 yAI51vyQ4fpi0PcXjal62GHspMY4aAybyzy+FrbCAeXb13vIyrzMOH5JbkUHLIifIp
	 fVxgRkojI8mw8Fvc8zb+LbmbtPDYpZnYDE99dRuM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Taeyang Lee <0wn@theori.io>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 054/277] crypto: authencesn - Do not place hiseq at end of dst for out-of-place decryption
Date: Wed,  8 Apr 2026 20:00:39 +0200
Message-ID: <20260408175935.876406896@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
References: <20260408175933.836769063@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234483-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,apana.org.au:email]
X-Rspamd-Queue-Id: 237453C0DBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit e02494114ebf7c8b42777c6cd6982f113bfdbec7 ]

When decrypting data that is not in-place (src != dst), there is
no need to save the high-order sequence bits in dst as it could
simply be re-copied from the source.

However, the data to be hashed need to be rearranged accordingly.

Reported-by: Taeyang Lee <0wn@theori.io>
Fixes: 104880a6b470 ("crypto: authencesn - Convert to new AEAD interface")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/authencesn.c | 48 +++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/crypto/authencesn.c b/crypto/authencesn.c
index 542a978663b9e..c0a01d738d9bc 100644
--- a/crypto/authencesn.c
+++ b/crypto/authencesn.c
@@ -207,6 +207,7 @@ static int crypto_authenc_esn_decrypt_tail(struct aead_request *req,
 	u8 *ohash = areq_ctx->tail;
 	unsigned int cryptlen = req->cryptlen - authsize;
 	unsigned int assoclen = req->assoclen;
+	struct scatterlist *src = req->src;
 	struct scatterlist *dst = req->dst;
 	u8 *ihash = ohash + crypto_ahash_digestsize(auth);
 	u32 tmp[2];
@@ -214,23 +215,27 @@ static int crypto_authenc_esn_decrypt_tail(struct aead_request *req,
 	if (!authsize)
 		goto decrypt;
 
-	/* Move high-order bits of sequence number back. */
-	scatterwalk_map_and_copy(tmp, dst, 4, 4, 0);
-	scatterwalk_map_and_copy(tmp + 1, dst, assoclen + cryptlen, 4, 0);
-	scatterwalk_map_and_copy(tmp, dst, 0, 8, 1);
+	if (src == dst) {
+		/* Move high-order bits of sequence number back. */
+		scatterwalk_map_and_copy(tmp, dst, 4, 4, 0);
+		scatterwalk_map_and_copy(tmp + 1, dst, assoclen + cryptlen, 4, 0);
+		scatterwalk_map_and_copy(tmp, dst, 0, 8, 1);
+	} else
+		memcpy_sglist(dst, src, assoclen);
 
 	if (crypto_memneq(ihash, ohash, authsize))
 		return -EBADMSG;
 
 decrypt:
 
-	sg_init_table(areq_ctx->dst, 2);
+	if (src != dst)
+		src = scatterwalk_ffwd(areq_ctx->src, src, assoclen);
 	dst = scatterwalk_ffwd(areq_ctx->dst, dst, assoclen);
 
 	skcipher_request_set_tfm(skreq, ctx->enc);
 	skcipher_request_set_callback(skreq, flags,
 				      req->base.complete, req->base.data);
-	skcipher_request_set_crypt(skreq, dst, dst, cryptlen, req->iv);
+	skcipher_request_set_crypt(skreq, src, dst, cryptlen, req->iv);
 
 	return crypto_skcipher_decrypt(skreq);
 }
@@ -255,6 +260,7 @@ static int crypto_authenc_esn_decrypt(struct aead_request *req)
 	unsigned int assoclen = req->assoclen;
 	unsigned int cryptlen = req->cryptlen;
 	u8 *ihash = ohash + crypto_ahash_digestsize(auth);
+	struct scatterlist *src = req->src;
 	struct scatterlist *dst = req->dst;
 	u32 tmp[2];
 	int err;
@@ -262,24 +268,28 @@ static int crypto_authenc_esn_decrypt(struct aead_request *req)
 	if (assoclen < 8)
 		return -EINVAL;
 
-	cryptlen -= authsize;
-
-	if (req->src != dst)
-		memcpy_sglist(dst, req->src, assoclen + cryptlen);
+	if (!authsize)
+		goto tail;
 
+	cryptlen -= authsize;
 	scatterwalk_map_and_copy(ihash, req->src, assoclen + cryptlen,
 				 authsize, 0);
 
-	if (!authsize)
-		goto tail;
-
 	/* Move high-order bits of sequence number to the end. */
-	scatterwalk_map_and_copy(tmp, dst, 0, 8, 0);
-	scatterwalk_map_and_copy(tmp, dst, 4, 4, 1);
-	scatterwalk_map_and_copy(tmp + 1, dst, assoclen + cryptlen, 4, 1);
-
-	sg_init_table(areq_ctx->dst, 2);
-	dst = scatterwalk_ffwd(areq_ctx->dst, dst, 4);
+	scatterwalk_map_and_copy(tmp, src, 0, 8, 0);
+	if (src == dst) {
+		scatterwalk_map_and_copy(tmp, dst, 4, 4, 1);
+		scatterwalk_map_and_copy(tmp + 1, dst, assoclen + cryptlen, 4, 1);
+		dst = scatterwalk_ffwd(areq_ctx->dst, dst, 4);
+	} else {
+		scatterwalk_map_and_copy(tmp, dst, 0, 4, 1);
+		scatterwalk_map_and_copy(tmp + 1, dst, assoclen + cryptlen - 4, 4, 1);
+
+		src = scatterwalk_ffwd(areq_ctx->src, src, 8);
+		dst = scatterwalk_ffwd(areq_ctx->dst, dst, 4);
+		memcpy_sglist(dst, src, assoclen + cryptlen - 8);
+		dst = req->dst;
+	}
 
 	ahash_request_set_tfm(ahreq, auth);
 	ahash_request_set_crypt(ahreq, dst, ohash, assoclen + cryptlen);
-- 
2.53.0




