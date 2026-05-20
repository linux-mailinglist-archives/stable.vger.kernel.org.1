Return-Path: <stable+bounces-250469-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ih8BxPzDWry4wUAu9opvQ
	(envelope-from <stable+bounces-250469-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:44:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC9259475D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54461378E91A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1B13B27D8;
	Wed, 20 May 2026 16:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JKsgYaOi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A69352038;
	Wed, 20 May 2026 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295491; cv=none; b=qDs3lsfgt0S0y5o8t9zVQZFQhAvtAyiHWI94syY6ezZZXk9AZSs5dr9WvH+jxnIAnOXCXSE+7Z956Ad8YC5twMNiQH9Krk39skkL9VcvHN1fo7EHk8dlrgtAxpVOMTPROGhCnHraC3b7K75o7K4z3jT97ULPgEKToXURp84pFcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295491; c=relaxed/simple;
	bh=UhV401g20Ej5kBnwi6lJS7RUgZ4ehTzLoJfHYucLRH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4cOVHqK0+hncXWG59Xyh9r4rh5RfaeEZpaqqPRWpeNj9kqBwEQFXI7DgOwxFTN0Ypqdv3P7YLfDwQLQeRElE0FtmkJhYCOFyV+LwO7DSEENeD//tje5YHlZQNdsLBJtW5gzNg6YItXX3uMUvCkg+FmBLYl/pWNaM+BoBjnD44s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JKsgYaOi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3751F000E9;
	Wed, 20 May 2026 16:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295490;
	bh=jEfEl4nMqSSjgM2Z/GI40u9Nn7wCxfWkhTSO1cj7zEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JKsgYaOisM3Yw5+Iky+DtsBT+YjEekgGZUCq+tZSOgVFmB/r4Ra8DOMdVm0p3MSdg
	 uNU/yO7u2BpZ/LstRpkOIBJfbvlwgTvBglzmkPqwHaJv8agiHJ6yvEEKKFq5aQ61Da
	 xqTlxzaFoOF/NaqeZFpBiWPkQ3hrZD2GqplUFRJI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Haixin Xu <jerryxucs@gmail.com>,
	Stephan Mueller <smueller@chronox.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0440/1146] crypto: jitterentropy - replace long-held spinlock with mutex
Date: Wed, 20 May 2026 18:11:30 +0200
Message-ID: <20260520162158.157545272@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,lzu.edu.cn,chronox.de,gondor.apana.org.au,kernel.org];
	TAGGED_FROM(0.00)[bounces-250469-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 3BC9259475D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haixin Xu <jerryxucs@gmail.com>

[ Upstream commit 01d798e9feb30212952d4e992801ba6bd6a82351 ]

jent_kcapi_random() serializes the shared jitterentropy state, but it
currently holds a spinlock across the jent_read_entropy() call. That
path performs expensive jitter collection and SHA3 conditioning, so
parallel readers can trigger stalls as contending waiters spin for
the same lock.

To prevent non-preemptible lock hold, replace rng->jent_lock with a
mutex so contended readers sleep instead of spinning on a shared lock
held across expensive entropy generation.

Fixes: bb5530e40824 ("crypto: jitterentropy - add jitterentropy RNG")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Haixin Xu <jerryxucs@gmail.com>
Reviewed-by: Stephan Mueller <smueller@chronox.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/jitterentropy-kcapi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/crypto/jitterentropy-kcapi.c b/crypto/jitterentropy-kcapi.c
index 7c880cf34c523..5edc6d285aa14 100644
--- a/crypto/jitterentropy-kcapi.c
+++ b/crypto/jitterentropy-kcapi.c
@@ -42,6 +42,7 @@
 #include <linux/fips.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/time.h>
 #include <crypto/internal/rng.h>
@@ -193,7 +194,7 @@ int jent_read_random_block(void *hash_state, char *dst, unsigned int dst_len)
  ***************************************************************************/
 
 struct jitterentropy {
-	spinlock_t jent_lock;
+	struct mutex jent_lock;
 	struct rand_data *entropy_collector;
 	struct crypto_shash *tfm;
 	struct shash_desc *sdesc;
@@ -203,7 +204,7 @@ static void jent_kcapi_cleanup(struct crypto_tfm *tfm)
 {
 	struct jitterentropy *rng = crypto_tfm_ctx(tfm);
 
-	spin_lock(&rng->jent_lock);
+	mutex_lock(&rng->jent_lock);
 
 	if (rng->sdesc) {
 		shash_desc_zero(rng->sdesc);
@@ -218,7 +219,7 @@ static void jent_kcapi_cleanup(struct crypto_tfm *tfm)
 	if (rng->entropy_collector)
 		jent_entropy_collector_free(rng->entropy_collector);
 	rng->entropy_collector = NULL;
-	spin_unlock(&rng->jent_lock);
+	mutex_unlock(&rng->jent_lock);
 }
 
 static int jent_kcapi_init(struct crypto_tfm *tfm)
@@ -228,7 +229,7 @@ static int jent_kcapi_init(struct crypto_tfm *tfm)
 	struct shash_desc *sdesc;
 	int size, ret = 0;
 
-	spin_lock_init(&rng->jent_lock);
+	mutex_init(&rng->jent_lock);
 
 	/* Use SHA3-256 as conditioner */
 	hash = crypto_alloc_shash(JENT_CONDITIONING_HASH, 0, 0);
@@ -257,7 +258,6 @@ static int jent_kcapi_init(struct crypto_tfm *tfm)
 		goto err;
 	}
 
-	spin_lock_init(&rng->jent_lock);
 	return 0;
 
 err:
@@ -272,7 +272,7 @@ static int jent_kcapi_random(struct crypto_rng *tfm,
 	struct jitterentropy *rng = crypto_rng_ctx(tfm);
 	int ret = 0;
 
-	spin_lock(&rng->jent_lock);
+	mutex_lock(&rng->jent_lock);
 
 	ret = jent_read_entropy(rng->entropy_collector, rdata, dlen);
 
@@ -298,7 +298,7 @@ static int jent_kcapi_random(struct crypto_rng *tfm,
 		ret = -EINVAL;
 	}
 
-	spin_unlock(&rng->jent_lock);
+	mutex_unlock(&rng->jent_lock);
 
 	return ret;
 }
-- 
2.53.0




