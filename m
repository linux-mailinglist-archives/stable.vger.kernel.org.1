Return-Path: <stable+bounces-242002-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LhFH0fy8mnNvwEAu9opvQ
	(envelope-from <stable+bounces-242002-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 08:10:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D7A49DE3D
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 08:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84A55302E79A
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 06:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91B4376492;
	Thu, 30 Apr 2026 06:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aX3J1geI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C5A375F65;
	Thu, 30 Apr 2026 06:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777529356; cv=none; b=ZahFqHyv8JTspYdUdTH2Y/x4GDv/B7nvwJGElCewMdDJgEADiweVjUe5xBy4v98s5DGzPbrwkF4tQtkd7ruZ7L1J8DJfsIPgEWmYoq7BjM3cgQFZHrPHPs3SrCNe5g5zSpj0x1Tj4Q0K4bsokiP9Y9S1HbmZ30FMbTvo+EBSMXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777529356; c=relaxed/simple;
	bh=fTiOy4m+abaSb5LRLdG3mSzgNpaK7AiJPxWj0tJsm+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPRUz+cIA7caFrUjZ+8ZWjCznsga8aWsP+fOr/MTtSZ+ndTGnN/P4S7bWhQSctnaKFFWVOYytk1Ss64JZZzgRZ35TLhX68Cpw06rJ5GItXYHN0dleZWmMQ2jFBqQS8pFd7XDDrWE3v2BL8K3Im7VVBhkbudO5MpHosxCpyzSklk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aX3J1geI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51247C2BCC6;
	Thu, 30 Apr 2026 06:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777529356;
	bh=fTiOy4m+abaSb5LRLdG3mSzgNpaK7AiJPxWj0tJsm+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aX3J1geIZZCzyXpFJtWLfn1UWFiLVJVPpX4eXfWPBRpDTa9q18xKNK2FFRjsPH73w
	 IPl3Sf279I+m8VDZ/7l0ECnKcwMcFZCcRsxVWz34ktlCNJxENQu0hNp62pAkQIVj6j
	 bg+zk4WQBihI8uJi+xvnMqLnAVtz9LvWAEkAsHzseF7fFrNd+CXUutqffs6/tq2QIh
	 fjRFqRwln7Mxn7C2v6YqBKhp9WLLa5+UL9cEJvddEs6ZcaKDO/AKzghmS4QcezseUg
	 OBP0MjVKJg1QjE3Yx/hSOxfiTQXZJ5JsCjht9+67U6lP1G5vWYCsQrp7OzgM6J+pl0
	 61g9Fpf/CYRpg==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Wolfgang Walter <linux@stwm.de>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 6.12 7/8] crypto: authencesn - Fix src offset when decrypting in-place
Date: Wed, 29 Apr 2026 23:07:01 -0700
Message-ID: <20260430060702.110091-8-ebiggers@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430060702.110091-1-ebiggers@kernel.org>
References: <20260430060702.110091-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 23D7A49DE3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242002-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:email,stwm.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Herbert Xu <herbert@gondor.apana.org.au>

commit 1f48ad3b19a9dfc947868edda0bb8e48e5b5a8fa upstream.

The src SG list offset wasn't set properly when decrypting in-place,
fix it.

Reported-by: Wolfgang Walter <linux@stwm.de>
Fixes: e02494114ebf ("crypto: authencesn - Do not place hiseq at end of dst for out-of-place decryption")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 crypto/authencesn.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/crypto/authencesn.c b/crypto/authencesn.c
index 257af38ac4de..c01cc3087919 100644
--- a/crypto/authencesn.c
+++ b/crypto/authencesn.c
@@ -226,13 +226,15 @@ static int crypto_authenc_esn_decrypt_tail(struct aead_request *req,
 	if (crypto_memneq(ihash, ohash, authsize))
 		return -EBADMSG;
 
 decrypt:
 
-	if (src != dst)
-		src = scatterwalk_ffwd(areq_ctx->src, src, assoclen);
 	dst = scatterwalk_ffwd(areq_ctx->dst, dst, assoclen);
+	if (req->src == req->dst)
+		src = dst;
+	else
+		src = scatterwalk_ffwd(areq_ctx->src, src, assoclen);
 
 	skcipher_request_set_tfm(skreq, ctx->enc);
 	skcipher_request_set_callback(skreq, flags,
 				      req->base.complete, req->base.data);
 	skcipher_request_set_crypt(skreq, src, dst, cryptlen, req->iv);
-- 
2.54.0


