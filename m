Return-Path: <stable+bounces-181016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF596B92A23
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 20:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B822B4E2911
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 18:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2DB31A569;
	Mon, 22 Sep 2025 18:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAy6cHdl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F080A31A55C
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 18:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758566696; cv=none; b=MHZKnBablBO3Kck1BzEKdBt2dKPzg1JRZNF+O6KKYPqOEtWsT7sHQJsJUiJshgdDAhvHgqDQFfkLRVlRrm8VbgXhJ606DPoEkvEQgjM5s96JVhGCp3SdcX6ZD22AkjDG5tb/8zx4zhSNQ/WOmdB1/Da6vSxbblqpWvOUeb1jc+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758566696; c=relaxed/simple;
	bh=eG9k2p/nPod4HW6UYyx4PZ5iKt/Mekb6gK3vgGV1yZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzUy/Bl5iXshUNdDCMJMRjZFl97g/Z9psH/jkETn6Wed/wk2rEbNirkooZQ6epmMBtJ5pAER8lOYtsZBelwv7z6WStBnE7OyxwKVUSASHQhRO990u7ScxuPvhGZ190wMICiZPelUEb/PVmMQjELYlcjusuOxgKmtet3RZkk9UFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAy6cHdl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125D3C4CEF7;
	Mon, 22 Sep 2025 18:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758566695;
	bh=eG9k2p/nPod4HW6UYyx4PZ5iKt/Mekb6gK3vgGV1yZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jAy6cHdlRYOiSyDV2kdh12B4ti/1IcfulNsJ73RdfWrPEjcU9z5O1RZJ7P6k6yQte
	 5zyZd2UyELsRkwFudb1+qZoeuaeq3dY/9Q//cYtl14YBqsqdXJqZGI3LJkllJFFxjV
	 vFO38fBTqUmONlxk2wFptDdQTSq3vVb4Ax9DoTH3b9WFkrN7o1l/83t3H/9O7pz6ty
	 VhSMyY6cfrFRtt63fD9hLRQDXVWUoz4G0B2BK5lpOHd/CKi5m7CZLgUz/o+nUjcY6w
	 vVKjrBfSuaMrpWFjzhX/ctc4ku8ZNerxvjpDWrOXHZCfpGocXUsPmHPWdaHEjAfept
	 op1uCtO2+gLiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Muhammad Alifa Ramdhan <ramdhan@starlabs.sg>,
	Bing-Jhong Billy Jheng <billy@starlabs.sg>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] crypto: af_alg - Disallow concurrent writes in af_alg_sendmsg
Date: Mon, 22 Sep 2025 14:44:49 -0400
Message-ID: <20250922184449.3864288-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922184449.3864288-1-sashal@kernel.org>
References: <2025092107-making-cough-9671@gregkh>
 <20250922184449.3864288-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit 1b34cbbf4f011a121ef7b2d7d6e6920a036d5285 ]

Issuing two writes to the same af_alg socket is bogus as the
data will be interleaved in an unpredictable fashion.  Furthermore,
concurrent writes may create inconsistencies in the internal
socket state.

Disallow this by adding a new ctx->write field that indiciates
exclusive ownership for writing.

Fixes: 8ff590903d5 ("crypto: algif_skcipher - User-space interface for skcipher operations")
Reported-by: Muhammad Alifa Ramdhan <ramdhan@starlabs.sg>
Reported-by: Bing-Jhong Billy Jheng <billy@starlabs.sg>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/af_alg.c         |  7 +++++++
 include/crypto/if_alg.h | 10 ++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 303225c674558..cd3f0a625fb19 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -859,6 +859,12 @@ int af_alg_sendmsg(struct socket *sock, struct msghdr *msg, size_t size,
 	}
 
 	lock_sock(sk);
+	if (ctx->write) {
+		release_sock(sk);
+		return -EBUSY;
+	}
+	ctx->write = true;
+
 	if (ctx->init && !ctx->more) {
 		if (ctx->used) {
 			err = -EINVAL;
@@ -969,6 +975,7 @@ int af_alg_sendmsg(struct socket *sock, struct msghdr *msg, size_t size,
 
 unlock:
 	af_alg_data_wakeup(sk);
+	ctx->write = false;
 	release_sock(sk);
 
 	return copied ?: err;
diff --git a/include/crypto/if_alg.h b/include/crypto/if_alg.h
index a406e281ae571..1424200fe88cf 100644
--- a/include/crypto/if_alg.h
+++ b/include/crypto/if_alg.h
@@ -136,6 +136,7 @@ struct af_alg_async_req {
  *			SG?
  * @enc:		Cryptographic operation to be performed when
  *			recvmsg is invoked.
+ * @write:		True if we are in the middle of a write.
  * @init:		True if metadata has been sent.
  * @len:		Length of memory allocated for this data structure.
  * @inflight:		Non-zero when AIO requests are in flight.
@@ -151,10 +152,11 @@ struct af_alg_ctx {
 	size_t used;
 	atomic_t rcvused;
 
-	bool more;
-	bool merge;
-	bool enc;
-	bool init;
+	u32		more:1,
+			merge:1,
+			enc:1,
+			write:1,
+			init:1;
 
 	unsigned int len;
 
-- 
2.51.0


