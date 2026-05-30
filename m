Return-Path: <stable+bounces-257619-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APCzGrwdG2qV/QgAu9opvQ
	(envelope-from <stable+bounces-257619-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:26:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D65F660FA6C
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 198DD306F8BF
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65213161A3;
	Sat, 30 May 2026 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XiNuZG9x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924543242D7;
	Sat, 30 May 2026 17:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161609; cv=none; b=hnYOCQF0Kx4XaV64pmd/Ny5pvZpbK87VT35WqOcrQmwmYa5PBfzYf34mEiomi2hDZXEu2bCCfImDd/fjSC5BiBkz8iEDwyhJmuRXj3FZvnN1Xpy9TgUwvS8wtJDVzyIy2xxMQ4+qH4vORSYtX5+GpHeqgtQh73G/E758NHiBek0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161609; c=relaxed/simple;
	bh=25zmkX3tnVgPzZ6HEcmHqXM6PjpNJRZCGY8Bhf8Jgso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tu90LAeKz7QUr9nglKLptFxFuM/rtdy57870U3NjXESKt3Oom+eAnIiLPsehFyofqheOMtwyGq0v7taxlZ41UuZCg9cpBojD+WHguG8v1PFxjs0esRWTGeUY2zZthrnHLfdJB45/7xBatwJzc1xbHgVjAcFSKlJ/7cWUOuPp7Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XiNuZG9x; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4251F00893;
	Sat, 30 May 2026 17:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780161608;
	bh=vrsZ+6zb1mgtEXreBm97Un3udE9oPoaK8vNC8uv+sSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XiNuZG9x78vWtuUdBkliIxfGidavb2nvgUPx+yE/Z9YijPQ+rJIzVHUco29chKDbs
	 8chchF113aY6hrL9l/6+mCfiB+kI0/mdbn9i9NScaWVZCtjK0SUgr1i1pydUXwsH6d
	 gQzQAPX93kfDON4VByFkSina//2lt9VZ6PxwOe6Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paul Moses <p@1g4.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 674/969] crypto: ccp - copy IV using skcipher ivsize
Date: Sat, 30 May 2026 18:03:18 +0200
Message-ID: <20260530160319.105447494@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257619-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D65F660FA6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Moses <p@1g4.org>

[ Upstream commit a7a1f3cdd64d8a165d9b8c9e9ad7fb46ac19dfc4 ]

AF_ALG rfc3686-ctr-aes-ccp requests pass an 8-byte IV to the driver.

ccp_aes_complete() restores AES_BLOCK_SIZE bytes into the caller's IV
buffer while RFC3686 skciphers expose an 8-byte IV, so the restore
overruns the provided buffer.

Use crypto_skcipher_ivsize() to copy only the algorithm's IV length.

Fixes: 2b789435d7f3 ("crypto: ccp - CCP AES crypto API support")
Signed-off-by: Paul Moses <p@1g4.org>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/ccp/ccp-crypto-aes.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/ccp/ccp-crypto-aes.c b/drivers/crypto/ccp/ccp-crypto-aes.c
index bed331953ff94..87b628bebf96e 100644
--- a/drivers/crypto/ccp/ccp-crypto-aes.c
+++ b/drivers/crypto/ccp/ccp-crypto-aes.c
@@ -28,8 +28,11 @@ static int ccp_aes_complete(struct crypto_async_request *async_req, int ret)
 	if (ret)
 		return ret;
 
-	if (ctx->u.aes.mode != CCP_AES_MODE_ECB)
-		memcpy(req->iv, rctx->iv, AES_BLOCK_SIZE);
+	if (ctx->u.aes.mode != CCP_AES_MODE_ECB) {
+		size_t ivsize = crypto_skcipher_ivsize(crypto_skcipher_reqtfm(req));
+
+		memcpy(req->iv, rctx->iv, ivsize);
+	}
 
 	return 0;
 }
-- 
2.53.0




