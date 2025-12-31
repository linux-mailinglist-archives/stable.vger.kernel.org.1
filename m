Return-Path: <stable+bounces-204381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32821CEC7BA
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 19:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EF17301896F
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 18:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B432F745E;
	Wed, 31 Dec 2025 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAF6qo2g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3402BE64F
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767206850; cv=none; b=LGYhyaiprg3Om9HS77dX6iarRKAFtaVANxRnP1fnxqEDcIZfKY2gl6/ysKaPZiMyPkkxdaluE4QzGkvv8RAAYn96oAMvv9sFDHFSg0cEtm8FlogN+KrZsg3I12FNnmO1IhllSx8eb58eHvFGskL7QYGJtCX+eJvtCxKnOTgz/8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767206850; c=relaxed/simple;
	bh=MiHRf5IzT0cW63QpjbaDH/6L98QCn7tQJVVQiKGKcHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tcyvmg0NmQ4TekA2RkUHm/HV72RGciu0O17WLrOVNUJnFKx8v8dO8eRRY6WD3WyJoVKeiGtQSqdfG9xPauXdn3fv8kug/a9Ih3kW2dXNBF4hMAKYesVn4NQGjs+vqZyLh/62Zrocl7enw1zYJGTpCzd8WuCnPKlFqv2R5+7dFlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAF6qo2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FA8C113D0;
	Wed, 31 Dec 2025 18:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767206850;
	bh=MiHRf5IzT0cW63QpjbaDH/6L98QCn7tQJVVQiKGKcHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hAF6qo2g9ceh+x+t4HkHe6nRdfz2G1+mP33PdTXxJOcIw+3a5OFgQ3Y3t2RG7C9cR
	 IBYcYdBjTl7gHBUiioPuSDhl7JWOYPnwFD7FIvXDgqAEcGJuCiLLt7d1bwcRXIg16E
	 SQcZm5cV/9QLjj+fF/fb9eYP1X1z51Nd4UpYcufzkygZHzVwXKqCX7OAoewhLAirZJ
	 0xFiqD8/5inYeuiCD7V29ZhAwM3xezo6qBmmX4kZbesUw0Bqvfl+KZm6OWjAfelgE5
	 PrUAHoVzKfU5VL7IM4c8HcCZSfGAqd2cUB0hxWrFR3yVtdFQ8bQpMDmFoBiT1c+wGg
	 1knml0qGHF1kg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shivani Agarwal <shivani.agarwal@broadcom.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] crypto: af_alg - zero initialize memory allocated via sock_kmalloc
Date: Wed, 31 Dec 2025 13:47:27 -0500
Message-ID: <20251231184727.3370622-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122929-grid-certify-c610@gregkh>
References: <2025122929-grid-certify-c610@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shivani Agarwal <shivani.agarwal@broadcom.com>

[ Upstream commit 6f6e309328d53a10c0fe1f77dec2db73373179b6 ]

Several crypto user API contexts and requests allocated with
sock_kmalloc() were left uninitialized, relying on callers to
set fields explicitly. This resulted in the use of uninitialized
data in certain error paths or when new fields are added in the
future.

The ACVP patches also contain two user-space interface files:
algif_kpp.c and algif_akcipher.c. These too rely on proper
initialization of their context structures.

A particular issue has been observed with the newly added
'inflight' variable introduced in af_alg_ctx by commit:

  67b164a871af ("crypto: af_alg - Disallow multiple in-flight AIO requests")

Because the context is not memset to zero after allocation,
the inflight variable has contained garbage values. As a result,
af_alg_alloc_areq() has incorrectly returned -EBUSY randomly when
the garbage value was interpreted as true:

  https://github.com/gregkh/linux/blame/master/crypto/af_alg.c#L1209

The check directly tests ctx->inflight without explicitly
comparing against true/false. Since inflight is only ever set to
true or false later, an uninitialized value has triggered
-EBUSY failures. Zero-initializing memory allocated with
sock_kmalloc() ensures inflight and other fields start in a known
state, removing random issues caused by uninitialized data.

Fixes: fe869cdb89c9 ("crypto: algif_hash - User-space interface for hash operations")
Fixes: 5afdfd22e6ba ("crypto: algif_rng - add random number generator support")
Fixes: 2d97591ef43d ("crypto: af_alg - consolidation of duplicate code")
Fixes: 67b164a871af ("crypto: af_alg - Disallow multiple in-flight AIO requests")
Cc: stable@vger.kernel.org
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/af_alg.c     | 5 ++---
 crypto/algif_hash.c | 3 +--
 crypto/algif_rng.c  | 3 +--
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 24c273f53e90..658d5c3c88b7 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -1139,14 +1139,13 @@ struct af_alg_async_req *af_alg_alloc_areq(struct sock *sk,
 	if (unlikely(!areq))
 		return ERR_PTR(-ENOMEM);
 
+	memset(areq, 0, areqlen);
+
 	ctx->inflight = true;
 
 	areq->areqlen = areqlen;
 	areq->sk = sk;
-	areq->last_rsgl = NULL;
 	INIT_LIST_HEAD(&areq->rsgl_list);
-	areq->tsgl = NULL;
-	areq->tsgl_entries = 0;
 
 	return areq;
 }
diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
index be21cfdc6dbc..a48fc7c24341 100644
--- a/crypto/algif_hash.c
+++ b/crypto/algif_hash.c
@@ -423,9 +423,8 @@ static int hash_accept_parent_nokey(void *private, struct sock *sk)
 	if (!ctx)
 		return -ENOMEM;
 
-	ctx->result = NULL;
+	memset(ctx, 0, len);
 	ctx->len = len;
-	ctx->more = false;
 	crypto_init_wait(&ctx->wait);
 
 	ask->private = ctx;
diff --git a/crypto/algif_rng.c b/crypto/algif_rng.c
index 407408c43730..38a8f20a02e2 100644
--- a/crypto/algif_rng.c
+++ b/crypto/algif_rng.c
@@ -250,9 +250,8 @@ static int rng_accept_parent(void *private, struct sock *sk)
 	if (!ctx)
 		return -ENOMEM;
 
+	memset(ctx, 0, len);
 	ctx->len = len;
-	ctx->addtl = NULL;
-	ctx->addtl_len = 0;
 
 	/*
 	 * No seeding done at that point -- if multiple accepts are
-- 
2.51.0


