Return-Path: <stable+bounces-252330-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPcKD9b5DWq75AUAu9opvQ
	(envelope-from <stable+bounces-252330-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:13:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C8959598B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 822083145F1E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6FD3F65E6;
	Wed, 20 May 2026 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qII+8t3B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7439D3EAC82;
	Wed, 20 May 2026 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300394; cv=none; b=MMxrfLGJmb7xG/VdabcQNIz6wx918laEJfekTwt4qzTOEij43sYw/q29SKcMkfvtIpIwhUN6HZ5BBw0cxGJ1Z/TVLoR7pYNirDK0gxo4xOkNIayM49wCaL2giQVYWLUMLriGaB5izdEt4Kz4zaoVeub+SAJ6nhy/3Yc3wGVdFaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300394; c=relaxed/simple;
	bh=0ToSm2LjC7FgsPrl6u5o6jGJbUfazPLJwlWO6pLZODc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkvmENOuHKMeSnUCy12PQufBdJEbzBHuuLELzmuwHJhvGmRSpgxNJVl5YUnsJmNWAB9eFoXdW4xvWWtcazMJwOD3rikXvcTA2t2Mr99xDzc2bZPNBa7wrTb+qR2R0adEqz2zKSjVsAgLJ5Kug6En1SwWW5fwHWFpRbD6o/stLus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qII+8t3B; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B6D1F000E9;
	Wed, 20 May 2026 18:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300393;
	bh=MseC2nTnPBk3ai0k+TdXfaLSYvCd/s3xkKaT76O2ceI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qII+8t3BTekQUXrsUdxpkfeWOI5sn4mbAclP/7pgjhBXJZNrjRiW10LB7UoMaqYt2
	 UI753sOwkS2AKF5h3T02dfYp8vBB45r+aBV3VvfNRefF5uWJuHHC4BZrraLChDOWjo
	 biWJg3TRoc1W2jVSBbHcwvPoR2uT8whxx0D/WgBE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 157/666] crypto: atmel - Use unregister_{aeads,ahashes,skciphers}
Date: Wed, 20 May 2026 18:16:08 +0200
Message-ID: <20260520162114.611659270@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252330-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,apana.org.au:email,linux.dev:email]
X-Rspamd-Queue-Id: A7C8959598B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit 2ffc1ef4e826f0c3274f9ff5eb42bc70a5571afd ]

Replace multiple for loops with calls to crypto_unregister_aeads(),
crypto_unregister_ahashes(), and crypto_unregister_skciphers().

Remove the definition of atmel_tdes_unregister_algs() because it is
equivalent to calling crypto_unregister_skciphers() directly, and the
function parameter 'struct atmel_tdes_dev *' is unused anyway.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: 57a13941c0bb ("crypto: atmel-aes - guard unregister on error in atmel_aes_register_algs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/atmel-aes.c  | 17 ++++++-----------
 drivers/crypto/atmel-sha.c  | 27 ++++++++++-----------------
 drivers/crypto/atmel-tdes.c | 25 ++++++-------------------
 3 files changed, 22 insertions(+), 47 deletions(-)

diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
index 5f53936eb905d..cf923be68a00f 100644
--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -2200,12 +2200,10 @@ static irqreturn_t atmel_aes_irq(int irq, void *dev_id)
 
 static void atmel_aes_unregister_algs(struct atmel_aes_dev *dd)
 {
-	int i;
-
 #if IS_ENABLED(CONFIG_CRYPTO_DEV_ATMEL_AUTHENC)
 	if (dd->caps.has_authenc)
-		for (i = 0; i < ARRAY_SIZE(aes_authenc_algs); i++)
-			crypto_unregister_aead(&aes_authenc_algs[i]);
+		crypto_unregister_aeads(aes_authenc_algs,
+					ARRAY_SIZE(aes_authenc_algs));
 #endif
 
 	if (dd->caps.has_xts)
@@ -2214,8 +2212,7 @@ static void atmel_aes_unregister_algs(struct atmel_aes_dev *dd)
 	if (dd->caps.has_gcm)
 		crypto_unregister_aead(&aes_gcm_alg);
 
-	for (i = 0; i < ARRAY_SIZE(aes_algs); i++)
-		crypto_unregister_skcipher(&aes_algs[i]);
+	crypto_unregister_skciphers(aes_algs, ARRAY_SIZE(aes_algs));
 }
 
 static void atmel_aes_crypto_alg_init(struct crypto_alg *alg)
@@ -2228,7 +2225,7 @@ static void atmel_aes_crypto_alg_init(struct crypto_alg *alg)
 
 static int atmel_aes_register_algs(struct atmel_aes_dev *dd)
 {
-	int err, i, j;
+	int err, i;
 
 	for (i = 0; i < ARRAY_SIZE(aes_algs); i++) {
 		atmel_aes_crypto_alg_init(&aes_algs[i].base);
@@ -2271,8 +2268,7 @@ static int atmel_aes_register_algs(struct atmel_aes_dev *dd)
 #if IS_ENABLED(CONFIG_CRYPTO_DEV_ATMEL_AUTHENC)
 	/* i = ARRAY_SIZE(aes_authenc_algs); */
 err_aes_authenc_alg:
-	for (j = 0; j < i; j++)
-		crypto_unregister_aead(&aes_authenc_algs[j]);
+	crypto_unregister_aeads(aes_authenc_algs, i);
 	crypto_unregister_skcipher(&aes_xts_alg);
 #endif
 err_aes_xts_alg:
@@ -2280,8 +2276,7 @@ static int atmel_aes_register_algs(struct atmel_aes_dev *dd)
 err_aes_gcm_alg:
 	i = ARRAY_SIZE(aes_algs);
 err_aes_algs:
-	for (j = 0; j < i; j++)
-		crypto_unregister_skcipher(&aes_algs[j]);
+	crypto_unregister_skciphers(aes_algs, i);
 
 	return err;
 }
diff --git a/drivers/crypto/atmel-sha.c b/drivers/crypto/atmel-sha.c
index 8cc57df257784..4f2f57bc3bb67 100644
--- a/drivers/crypto/atmel-sha.c
+++ b/drivers/crypto/atmel-sha.c
@@ -2416,27 +2416,23 @@ EXPORT_SYMBOL_GPL(atmel_sha_authenc_abort);
 
 static void atmel_sha_unregister_algs(struct atmel_sha_dev *dd)
 {
-	int i;
-
 	if (dd->caps.has_hmac)
-		for (i = 0; i < ARRAY_SIZE(sha_hmac_algs); i++)
-			crypto_unregister_ahash(&sha_hmac_algs[i]);
+		crypto_unregister_ahashes(sha_hmac_algs,
+					  ARRAY_SIZE(sha_hmac_algs));
 
-	for (i = 0; i < ARRAY_SIZE(sha_1_256_algs); i++)
-		crypto_unregister_ahash(&sha_1_256_algs[i]);
+	crypto_unregister_ahashes(sha_1_256_algs, ARRAY_SIZE(sha_1_256_algs));
 
 	if (dd->caps.has_sha224)
 		crypto_unregister_ahash(&sha_224_alg);
 
-	if (dd->caps.has_sha_384_512) {
-		for (i = 0; i < ARRAY_SIZE(sha_384_512_algs); i++)
-			crypto_unregister_ahash(&sha_384_512_algs[i]);
-	}
+	if (dd->caps.has_sha_384_512)
+		crypto_unregister_ahashes(sha_384_512_algs,
+					  ARRAY_SIZE(sha_384_512_algs));
 }
 
 static int atmel_sha_register_algs(struct atmel_sha_dev *dd)
 {
-	int err, i, j;
+	int err, i;
 
 	for (i = 0; i < ARRAY_SIZE(sha_1_256_algs); i++) {
 		atmel_sha_alg_init(&sha_1_256_algs[i]);
@@ -2478,18 +2474,15 @@ static int atmel_sha_register_algs(struct atmel_sha_dev *dd)
 
 	/*i = ARRAY_SIZE(sha_hmac_algs);*/
 err_sha_hmac_algs:
-	for (j = 0; j < i; j++)
-		crypto_unregister_ahash(&sha_hmac_algs[j]);
+	crypto_unregister_ahashes(sha_hmac_algs, i);
 	i = ARRAY_SIZE(sha_384_512_algs);
 err_sha_384_512_algs:
-	for (j = 0; j < i; j++)
-		crypto_unregister_ahash(&sha_384_512_algs[j]);
+	crypto_unregister_ahashes(sha_384_512_algs, i);
 	crypto_unregister_ahash(&sha_224_alg);
 err_sha_224_algs:
 	i = ARRAY_SIZE(sha_1_256_algs);
 err_sha_1_256_algs:
-	for (j = 0; j < i; j++)
-		crypto_unregister_ahash(&sha_1_256_algs[j]);
+	crypto_unregister_ahashes(sha_1_256_algs, i);
 
 	return err;
 }
diff --git a/drivers/crypto/atmel-tdes.c b/drivers/crypto/atmel-tdes.c
index 813ed47e60cce..f07109608a090 100644
--- a/drivers/crypto/atmel-tdes.c
+++ b/drivers/crypto/atmel-tdes.c
@@ -897,38 +897,25 @@ static irqreturn_t atmel_tdes_irq(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-static void atmel_tdes_unregister_algs(struct atmel_tdes_dev *dd)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(tdes_algs); i++)
-		crypto_unregister_skcipher(&tdes_algs[i]);
-}
-
 static int atmel_tdes_register_algs(struct atmel_tdes_dev *dd)
 {
-	int err, i, j;
+	int err, i;
 
 	for (i = 0; i < ARRAY_SIZE(tdes_algs); i++) {
 		atmel_tdes_skcipher_alg_init(&tdes_algs[i]);
 
 		err = crypto_register_skcipher(&tdes_algs[i]);
-		if (err)
-			goto err_tdes_algs;
+		if (err) {
+			crypto_unregister_skciphers(tdes_algs, i);
+			return err;
+		}
 	}
 
 	return 0;
-
-err_tdes_algs:
-	for (j = 0; j < i; j++)
-		crypto_unregister_skcipher(&tdes_algs[j]);
-
-	return err;
 }
 
 static void atmel_tdes_get_cap(struct atmel_tdes_dev *dd)
 {
-
 	dd->caps.has_dma = 0;
 
 	/* keep only major version number */
@@ -1061,7 +1048,7 @@ static void atmel_tdes_remove(struct platform_device *pdev)
 	list_del(&tdes_dd->list);
 	spin_unlock(&atmel_tdes.lock);
 
-	atmel_tdes_unregister_algs(tdes_dd);
+	crypto_unregister_skciphers(tdes_algs, ARRAY_SIZE(tdes_algs));
 
 	tasklet_kill(&tdes_dd->done_task);
 	tasklet_kill(&tdes_dd->queue_task);
-- 
2.53.0




