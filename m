Return-Path: <stable+bounces-242018-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFzYNsj48mnFwAEAu9opvQ
	(envelope-from <stable+bounces-242018-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 08:38:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E6349E218
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 08:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 46E9E3009833
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 06:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D08377560;
	Thu, 30 Apr 2026 06:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9FhZLLN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FC1375AC6;
	Thu, 30 Apr 2026 06:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777531074; cv=none; b=Cq/DsZOZcFw6aD2mocHO1qzO6cEvtuyouYzm+oJTbq6SNL3fid3Yezv52l/N/Yid08eO97Y44B6Fv92dH8rL5NW17v25S0uncSQ9E5sgfIHBc05o5ecRH9WASHp46ifwxbfWPjPN19N9KvE8uFRH3Uj1o411pZ5rj5HLpZtojBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777531074; c=relaxed/simple;
	bh=JpyCLw1ruT1kJ4jIJQwxZ7t6Q6fp7dTjmshT/7yIxAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wz73tC4REDolgJbro5n86+zgkILYqWRcuGD0dBPHmsHcNHqbvv7bHp9j1D2a0+s77zRA8bKWBWw9zYJ8q9zRbXzDF6UJRFq2B4LSdNan0RsxJJdPqse/OIcA+qErfxIwLxhDbvXqR5LPXNTMBGxa+Z1J3IM+k57Ta/iXgTIk6NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9FhZLLN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338CAC2BCC7;
	Thu, 30 Apr 2026 06:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777531074;
	bh=JpyCLw1ruT1kJ4jIJQwxZ7t6Q6fp7dTjmshT/7yIxAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o9FhZLLNp5zAtS2+FD4/PvoX4adg2gVsg25fNFr7Oc3/PXj3zLbQkqcUaGzCSzCEb
	 HnjGurXkp4bGx3lMgFa0ZUt2Gma7UN1/V0wzreu/pT48PUfcGQ15hxWw2gruA7L06i
	 VzmgIBwrvLE8hTJLoYoIpoDXsf0yhw5iaFQ5QlV2gpF3s9XlPLlgz9H2sY73Np6XBv
	 To3vEDdtWP8QfdkrU2283mxQqhTYYHPrOeOfBbbK6U+kNyL3noSqq3AmUbmX9dKL/z
	 imdZhFw2W2EPOcvZ+d6aYrH8oVRxNBVdtFWHTFPEiE4p8vDes74Hf4Rr/ZASGP5WXt
	 YbJ2NRMWugJ/w==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@google.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 5.15 2/9] crypto: algif_aead - use memcpy_sglist() instead of null skcipher
Date: Wed, 29 Apr 2026 23:35:57 -0700
Message-ID: <20260430063604.173525-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430063604.173525-1-ebiggers@kernel.org>
References: <20260430063604.173525-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D8E6349E218
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242018-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,apana.org.au:email]

From: Eric Biggers <ebiggers@google.com>

commit f2804d0eee8ddd57aa79d0b82872b74c21e1b69b upstream.

For copying data between two scatterlists, just use memcpy_sglist()
instead of the so-called "null skcipher".  This is much simpler.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 crypto/Kconfig      |  1 -
 crypto/algif_aead.c | 98 ++++++++-------------------------------------
 2 files changed, 17 insertions(+), 82 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index db260ccfba51..15994570627b 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1870,11 +1870,10 @@ config CRYPTO_USER_API_RNG_CAVP
 config CRYPTO_USER_API_AEAD
 	tristate "User-space interface for AEAD cipher algorithms"
 	depends on NET
 	select CRYPTO_AEAD
 	select CRYPTO_SKCIPHER
-	select CRYPTO_NULL
 	select CRYPTO_USER_API
 	help
 	  This option enables the user-spaces interface for AEAD
 	  cipher algorithms.
 
diff --git a/crypto/algif_aead.c b/crypto/algif_aead.c
index 42493b4d8ce4..38a4ab8c90c7 100644
--- a/crypto/algif_aead.c
+++ b/crypto/algif_aead.c
@@ -25,32 +25,25 @@
 
 #include <crypto/internal/aead.h>
 #include <crypto/scatterwalk.h>
 #include <crypto/if_alg.h>
 #include <crypto/skcipher.h>
-#include <crypto/null.h>
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/net.h>
 #include <net/sock.h>
 
-struct aead_tfm {
-	struct crypto_aead *aead;
-	struct crypto_sync_skcipher *null_tfm;
-};
-
 static inline bool aead_sufficient_data(struct sock *sk)
 {
 	struct alg_sock *ask = alg_sk(sk);
 	struct sock *psk = ask->parent;
 	struct alg_sock *pask = alg_sk(psk);
 	struct af_alg_ctx *ctx = ask->private;
-	struct aead_tfm *aeadc = pask->private;
-	struct crypto_aead *tfm = aeadc->aead;
+	struct crypto_aead *tfm = pask->private;
 	unsigned int as = crypto_aead_authsize(tfm);
 
 	/*
 	 * The minimum amount of memory needed for an AEAD cipher is
 	 * the AAD and in case of decryption the tag.
@@ -62,42 +55,25 @@ static int aead_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 {
 	struct sock *sk = sock->sk;
 	struct alg_sock *ask = alg_sk(sk);
 	struct sock *psk = ask->parent;
 	struct alg_sock *pask = alg_sk(psk);
-	struct aead_tfm *aeadc = pask->private;
-	struct crypto_aead *tfm = aeadc->aead;
+	struct crypto_aead *tfm = pask->private;
 	unsigned int ivsize = crypto_aead_ivsize(tfm);
 
 	return af_alg_sendmsg(sock, msg, size, ivsize);
 }
 
-static int crypto_aead_copy_sgl(struct crypto_sync_skcipher *null_tfm,
-				struct scatterlist *src,
-				struct scatterlist *dst, unsigned int len)
-{
-	SYNC_SKCIPHER_REQUEST_ON_STACK(skreq, null_tfm);
-
-	skcipher_request_set_sync_tfm(skreq, null_tfm);
-	skcipher_request_set_callback(skreq, CRYPTO_TFM_REQ_MAY_SLEEP,
-				      NULL, NULL);
-	skcipher_request_set_crypt(skreq, src, dst, len, NULL);
-
-	return crypto_skcipher_encrypt(skreq);
-}
-
 static int _aead_recvmsg(struct socket *sock, struct msghdr *msg,
 			 size_t ignored, int flags)
 {
 	struct sock *sk = sock->sk;
 	struct alg_sock *ask = alg_sk(sk);
 	struct sock *psk = ask->parent;
 	struct alg_sock *pask = alg_sk(psk);
 	struct af_alg_ctx *ctx = ask->private;
-	struct aead_tfm *aeadc = pask->private;
-	struct crypto_aead *tfm = aeadc->aead;
-	struct crypto_sync_skcipher *null_tfm = aeadc->null_tfm;
+	struct crypto_aead *tfm = pask->private;
 	unsigned int i, as = crypto_aead_authsize(tfm);
 	struct af_alg_async_req *areq;
 	struct af_alg_tsgl *tsgl, *tmp;
 	struct scatterlist *rsgl_src, *tsgl_src = NULL;
 	int err = 0;
@@ -221,14 +197,11 @@ static int _aead_recvmsg(struct socket *sock, struct msghdr *msg,
 		 *	    |	   |
 		 *	    | copy |
 		 *	    v	   v
 		 * RX SGL: AAD || PT || Tag
 		 */
-		err = crypto_aead_copy_sgl(null_tfm, tsgl_src,
-					   areq->first_rsgl.sgl.sg, processed);
-		if (err)
-			goto free;
+		memcpy_sglist(areq->first_rsgl.sgl.sg, tsgl_src, processed);
 		af_alg_pull_tsgl(sk, processed, NULL, 0);
 	} else {
 		/*
 		 * Decryption operation - To achieve an in-place cipher
 		 * operation, the following  SGL structure is used:
@@ -238,15 +211,12 @@ static int _aead_recvmsg(struct socket *sock, struct msghdr *msg,
 		 *	    | copy |	 | Create SGL link.
 		 *	    v	   v	 |
 		 * RX SGL: AAD || CT ----+
 		 */
 
-		 /* Copy AAD || CT to RX SGL buffer for in-place operation. */
-		err = crypto_aead_copy_sgl(null_tfm, tsgl_src,
-					   areq->first_rsgl.sgl.sg, outlen);
-		if (err)
-			goto free;
+		/* Copy AAD || CT to RX SGL buffer for in-place operation. */
+		memcpy_sglist(areq->first_rsgl.sgl.sg, tsgl_src, outlen);
 
 		/* Create TX SGL for tag and chain it to RX SGL. */
 		areq->tsgl_entries = af_alg_count_tsgl(sk, processed,
 						       processed - as);
 		if (!areq->tsgl_entries)
@@ -376,11 +346,11 @@ static struct proto_ops algif_aead_ops = {
 static int aead_check_key(struct socket *sock)
 {
 	int err = 0;
 	struct sock *psk;
 	struct alg_sock *pask;
-	struct aead_tfm *tfm;
+	struct crypto_aead *tfm;
 	struct sock *sk = sock->sk;
 	struct alg_sock *ask = alg_sk(sk);
 
 	lock_sock(sk);
 	if (!atomic_read(&ask->nokey_refcnt))
@@ -390,11 +360,11 @@ static int aead_check_key(struct socket *sock)
 	pask = alg_sk(ask->parent);
 	tfm = pask->private;
 
 	err = -ENOKEY;
 	lock_sock_nested(psk, SINGLE_DEPTH_NESTING);
-	if (crypto_aead_get_flags(tfm->aead) & CRYPTO_TFM_NEED_KEY)
+	if (crypto_aead_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
 		goto unlock;
 
 	atomic_dec(&pask->nokey_refcnt);
 	atomic_set(&ask->nokey_refcnt, 0);
 
@@ -464,68 +434,35 @@ static struct proto_ops algif_aead_ops_nokey = {
 	.poll		=	af_alg_poll,
 };
 
 static void *aead_bind(const char *name, u32 type, u32 mask)
 {
-	struct aead_tfm *tfm;
-	struct crypto_aead *aead;
-	struct crypto_sync_skcipher *null_tfm;
-
-	tfm = kzalloc(sizeof(*tfm), GFP_KERNEL);
-	if (!tfm)
-		return ERR_PTR(-ENOMEM);
-
-	aead = crypto_alloc_aead(name, type, mask);
-	if (IS_ERR(aead)) {
-		kfree(tfm);
-		return ERR_CAST(aead);
-	}
-
-	null_tfm = crypto_get_default_null_skcipher();
-	if (IS_ERR(null_tfm)) {
-		crypto_free_aead(aead);
-		kfree(tfm);
-		return ERR_CAST(null_tfm);
-	}
-
-	tfm->aead = aead;
-	tfm->null_tfm = null_tfm;
-
-	return tfm;
+	return crypto_alloc_aead(name, type, mask);
 }
 
 static void aead_release(void *private)
 {
-	struct aead_tfm *tfm = private;
-
-	crypto_free_aead(tfm->aead);
-	crypto_put_default_null_skcipher();
-	kfree(tfm);
+	crypto_free_aead(private);
 }
 
 static int aead_setauthsize(void *private, unsigned int authsize)
 {
-	struct aead_tfm *tfm = private;
-
-	return crypto_aead_setauthsize(tfm->aead, authsize);
+	return crypto_aead_setauthsize(private, authsize);
 }
 
 static int aead_setkey(void *private, const u8 *key, unsigned int keylen)
 {
-	struct aead_tfm *tfm = private;
-
-	return crypto_aead_setkey(tfm->aead, key, keylen);
+	return crypto_aead_setkey(private, key, keylen);
 }
 
 static void aead_sock_destruct(struct sock *sk)
 {
 	struct alg_sock *ask = alg_sk(sk);
 	struct af_alg_ctx *ctx = ask->private;
 	struct sock *psk = ask->parent;
 	struct alg_sock *pask = alg_sk(psk);
-	struct aead_tfm *aeadc = pask->private;
-	struct crypto_aead *tfm = aeadc->aead;
+	struct crypto_aead *tfm = pask->private;
 	unsigned int ivlen = crypto_aead_ivsize(tfm);
 
 	af_alg_pull_tsgl(sk, ctx->used, NULL, 0);
 	sock_kzfree_s(sk, ctx->iv, ivlen);
 	sock_kfree_s(sk, ctx, ctx->len);
@@ -534,14 +471,13 @@ static void aead_sock_destruct(struct sock *sk)
 
 static int aead_accept_parent_nokey(void *private, struct sock *sk)
 {
 	struct af_alg_ctx *ctx;
 	struct alg_sock *ask = alg_sk(sk);
-	struct aead_tfm *tfm = private;
-	struct crypto_aead *aead = tfm->aead;
+	struct crypto_aead *tfm = private;
 	unsigned int len = sizeof(*ctx);
-	unsigned int ivlen = crypto_aead_ivsize(aead);
+	unsigned int ivlen = crypto_aead_ivsize(tfm);
 
 	ctx = sock_kmalloc(sk, len, GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 	memset(ctx, 0, len);
@@ -564,13 +500,13 @@ static int aead_accept_parent_nokey(void *private, struct sock *sk)
 	return 0;
 }
 
 static int aead_accept_parent(void *private, struct sock *sk)
 {
-	struct aead_tfm *tfm = private;
+	struct crypto_aead *tfm = private;
 
-	if (crypto_aead_get_flags(tfm->aead) & CRYPTO_TFM_NEED_KEY)
+	if (crypto_aead_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
 		return -ENOKEY;
 
 	return aead_accept_parent_nokey(private, sk);
 }
 
-- 
2.54.0


