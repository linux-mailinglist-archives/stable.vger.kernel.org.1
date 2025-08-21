Return-Path: <stable+bounces-172002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85318B2F90F
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E955833DC
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 12:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA22319844;
	Thu, 21 Aug 2025 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="arihiXwk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C15315761
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780856; cv=none; b=E7OzL9IE+DIx34l6btN+eNnoiwC3XWt9HKdzsCUROJ0B2inSzGJ7zANnGlHHEFPmFN4c+ZYT3Wt3jmYKak0Qt37riihmTX+dSky3MTswZD0Wm0KiGcLWE5QVJEQMHmCSaNdUU7+vO5UsXapk04/SOcueLN4xbPGOBonMGQtXU0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780856; c=relaxed/simple;
	bh=YbzovBc0pBe+9Z9ssViisQRBOL0m7puRQcnuxBYegf0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TCFurHf33YFKP5sHMu+HattpP5HjLs+TPNjiu5LmyP90OrpygECkhpgEc5YXTWQafxwAljchbhVT/DhxmS4W0EUSZ6vpsbYyYvVN1sTAAoU7cuCXfHz69llsJwrdB12ikXxiERKXLAB6/69cSbPT4ggEdBITir9Q7n1b7mO64mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=arihiXwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E644C4CEEB;
	Thu, 21 Aug 2025 12:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755780856;
	bh=YbzovBc0pBe+9Z9ssViisQRBOL0m7puRQcnuxBYegf0=;
	h=Subject:To:Cc:From:Date:From;
	b=arihiXwk8NCB5Ddj3WEGpnehvlRUukxG9ZL+fXHpRrJfGNXKLWIIn0Ea8XOkWrj0L
	 cMIl+iRyYZV3cyCp11r56wX3DsoDiWzOPzdnweNLmOv8JBiM7Qk+hS0vFY1H5e16tz
	 6mdBLPJpd96DKo3iYGII66TqDAObf4sM+bfvGACM=
Subject: FAILED: patch "[PATCH] crypto: acomp - Fix CFI failure due to type punning" failed to apply to 6.16-stable tree
To: ebiggers@kernel.org,giovanni.cabiddu@intel.com,herbert@gondor.apana.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 14:54:13 +0200
Message-ID: <2025082113-buddhism-try-6476@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.16-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.16.y
git checkout FETCH_HEAD
git cherry-pick -x 962ddc5a7a4b04c007bba0f3e7298cda13c62efd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082113-buddhism-try-6476@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 962ddc5a7a4b04c007bba0f3e7298cda13c62efd Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Tue, 8 Jul 2025 17:59:54 -0700
Subject: [PATCH] crypto: acomp - Fix CFI failure due to type punning

To avoid a crash when control flow integrity is enabled, make the
workspace ("stream") free function use a consistent type, and call it
through a function pointer that has that same type.

Fixes: 42d9f6c77479 ("crypto: acomp - Move scomp stream allocation code into acomp")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/deflate.c b/crypto/deflate.c
index fe8e4ad0fee1..21404515dc77 100644
--- a/crypto/deflate.c
+++ b/crypto/deflate.c
@@ -48,9 +48,14 @@ static void *deflate_alloc_stream(void)
 	return ctx;
 }
 
+static void deflate_free_stream(void *ctx)
+{
+	kvfree(ctx);
+}
+
 static struct crypto_acomp_streams deflate_streams = {
 	.alloc_ctx = deflate_alloc_stream,
-	.cfree_ctx = kvfree,
+	.free_ctx = deflate_free_stream,
 };
 
 static int deflate_compress_one(struct acomp_req *req,
diff --git a/crypto/zstd.c b/crypto/zstd.c
index ebeadc1f3b5f..c2a19cb0879d 100644
--- a/crypto/zstd.c
+++ b/crypto/zstd.c
@@ -54,9 +54,14 @@ static void *zstd_alloc_stream(void)
 	return ctx;
 }
 
+static void zstd_free_stream(void *ctx)
+{
+	kvfree(ctx);
+}
+
 static struct crypto_acomp_streams zstd_streams = {
 	.alloc_ctx = zstd_alloc_stream,
-	.cfree_ctx = kvfree,
+	.free_ctx = zstd_free_stream,
 };
 
 static int zstd_init(struct crypto_acomp *acomp_tfm)
diff --git a/include/crypto/internal/acompress.h b/include/crypto/internal/acompress.h
index ffffd88bbbad..2d97440028ff 100644
--- a/include/crypto/internal/acompress.h
+++ b/include/crypto/internal/acompress.h
@@ -63,10 +63,7 @@ struct crypto_acomp_stream {
 struct crypto_acomp_streams {
 	/* These must come first because of struct scomp_alg. */
 	void *(*alloc_ctx)(void);
-	union {
-		void (*free_ctx)(void *);
-		void (*cfree_ctx)(const void *);
-	};
+	void (*free_ctx)(void *);
 
 	struct crypto_acomp_stream __percpu *streams;
 	struct work_struct stream_work;


