Return-Path: <stable+bounces-203655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8809ECE7427
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 519813012759
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D06329E60;
	Mon, 29 Dec 2025 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bY6mZWeN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE521BF33
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767023551; cv=none; b=dmXONZeWhHblyhPM1lCJR+FZBF1cB60Rg1QhnJvzH9G7176GNM5Xk/BtYTQHO/xrn0P1+6IJlId+ELepgSEPp4NUnx7nsha60nx/2QJg9qPNAeDyC5xQhx4Iwzk7efO6f2l14dWgRaVAim0qkRdO8aNBsRvBNghGH+SZRmfkeA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767023551; c=relaxed/simple;
	bh=WaMSbLQXK6wkWFxXww0Qf7TjCYmFAiEGV+ilQjLL5uo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MZEVCFthLkM6Ogq04AqWNpvIrhMcF4edaUwKKdjRx+RUsPKpJ9tP62lv+QOtlPBCIBg9wT0KFHX+cYB8NN88CxWTk5BlLvvn/8+qzuZW3qYg0CaW82+OLqtNiaM8GCJUTiFfYag/BK9h5Iod9hmMvwh48QCu3ggforzLsE/tT9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bY6mZWeN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11351C116C6;
	Mon, 29 Dec 2025 15:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767023551;
	bh=WaMSbLQXK6wkWFxXww0Qf7TjCYmFAiEGV+ilQjLL5uo=;
	h=Subject:To:Cc:From:Date:From;
	b=bY6mZWeNDxMtXKWmQS0exjexr4r1lZfbdWbAbd5ykPUx4tj6/mo37FKl3ViO7L38+
	 njvzSIBK8/z/+smV9MkgJZgjPefuR3jRmZRDu3APXKxrsH5+Tc2SCRa0jpgi6LvUqa
	 Gi6Vw32z7NSX3W7mrrnePyH5VDZkoIeRP6egZLrI=
Subject: FAILED: patch "[PATCH] crypto: af_alg - zero initialize memory allocated via" failed to apply to 6.1-stable tree
To: shivani.agarwal@broadcom.com,herbert@gondor.apana.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 16:52:28 +0100
Message-ID: <2025122928-monotone-prodigy-ba4d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6f6e309328d53a10c0fe1f77dec2db73373179b6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122928-monotone-prodigy-ba4d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6f6e309328d53a10c0fe1f77dec2db73373179b6 Mon Sep 17 00:00:00 2001
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
Date: Tue, 23 Sep 2025 23:01:48 -0700
Subject: [PATCH] crypto: af_alg - zero initialize memory allocated via
 sock_kmalloc

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

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index ca6fdcc6c54a..6c271e55f44d 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -1212,15 +1212,14 @@ struct af_alg_async_req *af_alg_alloc_areq(struct sock *sk,
 	if (unlikely(!areq))
 		return ERR_PTR(-ENOMEM);
 
+	memset(areq, 0, areqlen);
+
 	ctx->inflight = true;
 
 	areq->areqlen = areqlen;
 	areq->sk = sk;
 	areq->first_rsgl.sgl.sgt.sgl = areq->first_rsgl.sgl.sgl;
-	areq->last_rsgl = NULL;
 	INIT_LIST_HEAD(&areq->rsgl_list);
-	areq->tsgl = NULL;
-	areq->tsgl_entries = 0;
 
 	return areq;
 }
diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
index e3f1a4852737..4d3dfc60a16a 100644
--- a/crypto/algif_hash.c
+++ b/crypto/algif_hash.c
@@ -416,9 +416,8 @@ static int hash_accept_parent_nokey(void *private, struct sock *sk)
 	if (!ctx)
 		return -ENOMEM;
 
-	ctx->result = NULL;
+	memset(ctx, 0, len);
 	ctx->len = len;
-	ctx->more = false;
 	crypto_init_wait(&ctx->wait);
 
 	ask->private = ctx;
diff --git a/crypto/algif_rng.c b/crypto/algif_rng.c
index 10c41adac3b1..1a86e40c8372 100644
--- a/crypto/algif_rng.c
+++ b/crypto/algif_rng.c
@@ -248,9 +248,8 @@ static int rng_accept_parent(void *private, struct sock *sk)
 	if (!ctx)
 		return -ENOMEM;
 
+	memset(ctx, 0, len);
 	ctx->len = len;
-	ctx->addtl = NULL;
-	ctx->addtl_len = 0;
 
 	/*
 	 * No seeding done at that point -- if multiple accepts are


