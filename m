Return-Path: <stable+bounces-204386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C0BCEC892
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 21:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB551300AC4D
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 20:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4029D30CDA9;
	Wed, 31 Dec 2025 20:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ushr2eAG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E7A30CD89
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 20:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767213703; cv=none; b=fzJAjMTGOz7lX+4bET5mIkvxbHeOOFuKU/yvEwB3OoqqVxgIRlZ5NutmA9tj+L284xmeJVElCazQLRH+HucT1mN6LOHD70qq8cyKfeOR7z+JFeyuKNEEdcy7qIb0Kwt9EwyO2xnNuzUDXfxPAHN4j/YaazYnorF98S3aGl5Foc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767213703; c=relaxed/simple;
	bh=3VrN/qXrvLpIhsqXnqK0UlrbXeIPgz5NDB5Q6H/FMQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lsN6KLulFMClOk/wY/nb1juEWlc+y3+Lr04soNF1mjPhWD1UeHAivxixhCh9ED194KMPdS6YqpQC5DIYq8YlLRBzVdLfiTTUHIjBlqSABjZQMda3J8/v89A0BTA9Ue4xb4C5561jEZBPyGeZMIObheSf1vFOHQ+BKVMrQirR2i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ushr2eAG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235C1C113D0;
	Wed, 31 Dec 2025 20:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767213702;
	bh=3VrN/qXrvLpIhsqXnqK0UlrbXeIPgz5NDB5Q6H/FMQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ushr2eAG2Iynjzi/+AzScZf6jLJyK3elXxcMcv/78V3Hqijj0j4zfiZpC3ur62kQv
	 PCG43SicH4e8cjCYuxq5bWNm3Pm5gOBy9vQP4cBGhQxPgxQ6Vghn3Tn4ATqyasZnZZ
	 UKi/W3j+xcol7AK/AWe/Wnfj6xw3F6iLb70E53QpcfZSh+yLN3ssqJKxNq2c8M2Z/s
	 RnvgFKkK+311RrDXZLglhJlF+KCgkZXbv8UqV++xy3a6p+nX2e4fXFYjdPOadbK2QO
	 uSk+ijOw2ijVq9EoAIpc1HZdi9DICMlCLFudXr39rQQJWRXiaJEX6960pyKUA3sD3k
	 q2OdukvV0/3fg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shivani Agarwal <shivani.agarwal@broadcom.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] crypto: af_alg - zero initialize memory allocated via sock_kmalloc
Date: Wed, 31 Dec 2025 15:41:40 -0500
Message-ID: <20251231204140.3475630-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122930-sinner-squad-c6cd@gregkh>
References: <2025122930-sinner-squad-c6cd@gregkh>
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
index 25cf2fa3dde7..3d622904f4c3 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -1127,14 +1127,13 @@ struct af_alg_async_req *af_alg_alloc_areq(struct sock *sk,
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


