Return-Path: <stable+bounces-172225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC76AB302CC
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 21:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47CE0AC647E
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 19:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8A134DCC3;
	Thu, 21 Aug 2025 19:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="os6QjgIs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18BA3451D8
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 19:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755804095; cv=none; b=ZleP8L/UyJ0cGoaj3RZXyjyCHYC9LE16Pk0PLba5MJ4jl7LezepHRpFz5FFCf6UT9iqkxQfz8ws+LT/AYVUncMOC8A/bXB1r3PPj4uuxm41aE9Mp2o9bosU9NuSmcsK4RgbWICL2nV3Ln7mDHOo7DCQXAD8LX0kujh4o7NjUiEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755804095; c=relaxed/simple;
	bh=S4+yv34e+8Xx4SBZgHKyZxQ14JGWklEnLbAJKBb8ZgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nInSzb1musdbNeuMibvMmR23gNUJqTa4LdepwrPAusxSjTLD2EMInqOvMoJ+Dvx1xBXYhjVNV5ifLyMNO3VwBNL4rX+YYreCoOxnUNkT3fCERLrd/XNKZkeK1IiqxQPhr6jt4DrObz9dOVfjT1SyJmkXNMfCPY8aAezdYleBXE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=os6QjgIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F389DC4CEEB;
	Thu, 21 Aug 2025 19:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755804094;
	bh=S4+yv34e+8Xx4SBZgHKyZxQ14JGWklEnLbAJKBb8ZgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=os6QjgIsCU8rQvBNejDULMp2B35j+lwv49Cx2mT4MH0VibqYBgK1NvZCoA8yuSDfJ
	 EpGsBbHAvqKMynjdtSmHTJ0xxSDxaq8sUbGLz7r2R25+UT3rwzQwpyxnBysqyhNvqB
	 0D0sKsVWV4RtUgA/Nu/QmNDm/RvxBQfvCT0qJu+GhNvz3C6rtpXRWb3E0Ze+vRl4fQ
	 k60W4BhV9AHYKUPiWyn5lIRwrljLopzl2E7/WxKGX5wQVINGxaQh+kq0b5GP8Yc2T0
	 sPq++/wL/Cy3YD4SNZPt28rrAJ7sQOBhFg6zAmCmlXaOz2ybjnZeSCUK9s5SAwIwe0
	 xYxlaO1P3PU5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@kernel.org>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 2/2] crypto: acomp - Fix CFI failure due to type punning
Date: Thu, 21 Aug 2025 15:21:31 -0400
Message-ID: <20250821192131.923831-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821192131.923831-1-sashal@kernel.org>
References: <2025082113-buddhism-try-6476@gregkh>
 <20250821192131.923831-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@kernel.org>

[ Upstream commit 962ddc5a7a4b04c007bba0f3e7298cda13c62efd ]

To avoid a crash when control flow integrity is enabled, make the
workspace ("stream") free function use a consistent type, and call it
through a function pointer that has that same type.

Fixes: 42d9f6c77479 ("crypto: acomp - Move scomp stream allocation code into acomp")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/deflate.c                    | 7 ++++++-
 crypto/zstd.c                       | 7 ++++++-
 include/crypto/internal/acompress.h | 5 +----
 3 files changed, 13 insertions(+), 6 deletions(-)

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
index 657e0cf7b952..ff5f596a4ea7 100644
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
-- 
2.50.1


