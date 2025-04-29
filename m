Return-Path: <stable+bounces-138650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BADE3AA18ED
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3F91BC74C8
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C9022AE68;
	Tue, 29 Apr 2025 18:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y1GpYHCs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20BA2AE96;
	Tue, 29 Apr 2025 18:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949919; cv=none; b=FBH3ozi9yZ0P3x9d5dxQYvU7FegS4mku8DqNeF4cz+e4Q44MSNd36DUxSI6w4mKYonGxVXcE8uThal4IK3kr6Fad3wgUzi8VkrnBs/rkPQPLZmJMu3alDVtKvA3lMx1oJyprq81KvlKFt7r5mN5m8Td763yFjtnATnLqJZhWH9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949919; c=relaxed/simple;
	bh=/eSjBWNWBF/H6nwW5T8COVcoH213j2EENkx/sOHnMx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmzfQj8AIsbEjgWX65Ll/EHXcUp75aAoi81qFvh0qmmg/ZiDX94TtxQmdVdX6dkBd4DxCDNCo+//H96sBHAvMDhJrjZeqW3OPD0cJuhvi7iuP5z6J4+egVo2ArW8Qo58zXda4WchxfeuLnf82vn3YYGiNP5xgPOKnJkZ1MtPGTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y1GpYHCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E32C4CEE3;
	Tue, 29 Apr 2025 18:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745949919;
	bh=/eSjBWNWBF/H6nwW5T8COVcoH213j2EENkx/sOHnMx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y1GpYHCsUhnKgX3ijcLapKzOFpBkfwLDfIMF9gpnWCG1kViFeXpUg43eTbpYdUEBw
	 z/cf8x7IaMkdw3cq9PGfL3n7dGC3SCjNzvayCWUvT6QwWadOXtXBVZvuIhzVna3wg2
	 PEuk6vndz4UPVbFdcHz24+MZ7zsHZzszoXjH87KU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+b3e02953598f447d4d2a@syzkaller.appspotmail.com,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 099/167] crypto: null - Use spin lock instead of mutex
Date: Tue, 29 Apr 2025 18:43:27 +0200
Message-ID: <20250429161055.757434707@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161051.743239894@linuxfoundation.org>
References: <20250429161051.743239894@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit dcc47a028c24e793ce6d6efebfef1a1e92f80297 ]

As the null algorithm may be freed in softirq context through
af_alg, use spin locks instead of mutexes to protect the default
null algorithm.

Reported-by: syzbot+b3e02953598f447d4d2a@syzkaller.appspotmail.com
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/crypto_null.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/crypto/crypto_null.c b/crypto/crypto_null.c
index 5b84b0f7cc178..3378670286535 100644
--- a/crypto/crypto_null.c
+++ b/crypto/crypto_null.c
@@ -17,10 +17,10 @@
 #include <crypto/internal/skcipher.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/mm.h>
+#include <linux/spinlock.h>
 #include <linux/string.h>
 
-static DEFINE_MUTEX(crypto_default_null_skcipher_lock);
+static DEFINE_SPINLOCK(crypto_default_null_skcipher_lock);
 static struct crypto_sync_skcipher *crypto_default_null_skcipher;
 static int crypto_default_null_skcipher_refcnt;
 
@@ -152,23 +152,32 @@ MODULE_ALIAS_CRYPTO("cipher_null");
 
 struct crypto_sync_skcipher *crypto_get_default_null_skcipher(void)
 {
+	struct crypto_sync_skcipher *ntfm = NULL;
 	struct crypto_sync_skcipher *tfm;
 
-	mutex_lock(&crypto_default_null_skcipher_lock);
+	spin_lock_bh(&crypto_default_null_skcipher_lock);
 	tfm = crypto_default_null_skcipher;
 
 	if (!tfm) {
-		tfm = crypto_alloc_sync_skcipher("ecb(cipher_null)", 0, 0);
-		if (IS_ERR(tfm))
-			goto unlock;
-
-		crypto_default_null_skcipher = tfm;
+		spin_unlock_bh(&crypto_default_null_skcipher_lock);
+
+		ntfm = crypto_alloc_sync_skcipher("ecb(cipher_null)", 0, 0);
+		if (IS_ERR(ntfm))
+			return ntfm;
+
+		spin_lock_bh(&crypto_default_null_skcipher_lock);
+		tfm = crypto_default_null_skcipher;
+		if (!tfm) {
+			tfm = ntfm;
+			ntfm = NULL;
+			crypto_default_null_skcipher = tfm;
+		}
 	}
 
 	crypto_default_null_skcipher_refcnt++;
+	spin_unlock_bh(&crypto_default_null_skcipher_lock);
 
-unlock:
-	mutex_unlock(&crypto_default_null_skcipher_lock);
+	crypto_free_sync_skcipher(ntfm);
 
 	return tfm;
 }
@@ -176,12 +185,16 @@ EXPORT_SYMBOL_GPL(crypto_get_default_null_skcipher);
 
 void crypto_put_default_null_skcipher(void)
 {
-	mutex_lock(&crypto_default_null_skcipher_lock);
+	struct crypto_sync_skcipher *tfm = NULL;
+
+	spin_lock_bh(&crypto_default_null_skcipher_lock);
 	if (!--crypto_default_null_skcipher_refcnt) {
-		crypto_free_sync_skcipher(crypto_default_null_skcipher);
+		tfm = crypto_default_null_skcipher;
 		crypto_default_null_skcipher = NULL;
 	}
-	mutex_unlock(&crypto_default_null_skcipher_lock);
+	spin_unlock_bh(&crypto_default_null_skcipher_lock);
+
+	crypto_free_sync_skcipher(tfm);
 }
 EXPORT_SYMBOL_GPL(crypto_put_default_null_skcipher);
 
-- 
2.39.5




