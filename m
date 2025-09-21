Return-Path: <stable+bounces-180793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F7DB8DB28
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06EE5189D2BF
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 12:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF752153D2;
	Sun, 21 Sep 2025 12:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EC2UXzaK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497002E40B
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 12:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758458298; cv=none; b=PcE2QxY38DvxwWCm6gAtkszdCpuAkHGTcgdihpqToyCrbVY1Me2U5Frx9zYRJrkoaWBMVshRwIfrbLnBiTIb4G1bHAT7T8hQDgYprkddOgFrUDAkoY7guYZARXNCcBD3M2Y/hu+gAE/lMhLrEkTM9wPLs2KFI597ZcGgBn2W5Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758458298; c=relaxed/simple;
	bh=giowIo3aSKjevU1OMmJ65BLQ3Ey0pD14Q7RJksw+52k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cqkXDLBu/HopZ2kc8jkoTWPhUrSiF6J2StjUU+K/hN8VwfY/sqMoIZRsppRMbLyjChww5biwY5e1q7laEEGswYCVOgDUwncDaVexGgej8UDQHOrR/jaO3C7yFqicsjalZ4PdByZVCpsP5pGqBYcjCGs3//ddc5K0CvKCRdOcSEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EC2UXzaK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD9EC4CEF0;
	Sun, 21 Sep 2025 12:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758458298;
	bh=giowIo3aSKjevU1OMmJ65BLQ3Ey0pD14Q7RJksw+52k=;
	h=Subject:To:Cc:From:Date:From;
	b=EC2UXzaKQ2W551IKO6sv2VOTg07pWNBqSVIERwrxwJlgUrb8DBTz2PZoxILWesbP/
	 cyCRzS8HREvfOd3ewQ3HyBfCYf4EYf6Z3rWrLqExbR49PVnZas0r7lRU7QjbP+bKgQ
	 9gBETNjV646Q/uQrpqATLupGuxeZnNKfaV4rLeTg=
Subject: FAILED: patch "[PATCH] crypto: af_alg - Disallow concurrent writes in af_alg_sendmsg" failed to apply to 5.15-stable tree
To: herbert@gondor.apana.org.au,billy@starlabs.sg,ramdhan@starlabs.sg
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 21 Sep 2025 14:38:07 +0200
Message-ID: <2025092107-crowbar-posting-c6ba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1b34cbbf4f011a121ef7b2d7d6e6920a036d5285
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092107-crowbar-posting-c6ba@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1b34cbbf4f011a121ef7b2d7d6e6920a036d5285 Mon Sep 17 00:00:00 2001
From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 16 Sep 2025 17:20:59 +0800
Subject: [PATCH] crypto: af_alg - Disallow concurrent writes in af_alg_sendmsg

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

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 407f2c238f2c..ca6fdcc6c54a 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -970,6 +970,12 @@ int af_alg_sendmsg(struct socket *sock, struct msghdr *msg, size_t size,
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
@@ -1105,6 +1111,7 @@ int af_alg_sendmsg(struct socket *sock, struct msghdr *msg, size_t size,
 
 unlock:
 	af_alg_data_wakeup(sk);
+	ctx->write = false;
 	release_sock(sk);
 
 	return copied ?: err;
diff --git a/include/crypto/if_alg.h b/include/crypto/if_alg.h
index f7b3b93f3a49..0c70f3a55575 100644
--- a/include/crypto/if_alg.h
+++ b/include/crypto/if_alg.h
@@ -135,6 +135,7 @@ struct af_alg_async_req {
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
 


