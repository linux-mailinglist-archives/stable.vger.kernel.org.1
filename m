Return-Path: <stable+bounces-180792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC18B8DB25
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2B83BEED9
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 12:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504112153D2;
	Sun, 21 Sep 2025 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S/O6/pZJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8442E40B
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758458290; cv=none; b=itQOzRiipHtLa86iwhRhioIWf1WVF0CyOSLV4awgr6EH1+oFmz8ormNYeQ6if4g8uCLXV5GMUop4McRjlcfOK3bHd9B06rMIb0DLBkNi6bdlmkKi61UaGYCJlbvD+n2ZoVWl2crfRh7MQ11YHT/zf9jyz6pONxs+ipp49jgVyTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758458290; c=relaxed/simple;
	bh=cdkKtCWVAkNPjHl6AVDDgn/IN4RuecYKvUXJ51HddrM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OREA1FhSyvPFd5VRxaM31zvwMtQy9FppPl0Ghd/J3qp+GFxodTTTgeL03b3wuAMlyxYT2T7K/cwaWRVgSyrJi2mZql0D4XZNNzCVjuWVONMkUWQc6C9lmK5Tez4+4/2U7Mqp4z1nBfLJGfss8XKp0bHKOlR45XhSeZR4sE7kjYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S/O6/pZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4349AC4CEE7;
	Sun, 21 Sep 2025 12:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758458289;
	bh=cdkKtCWVAkNPjHl6AVDDgn/IN4RuecYKvUXJ51HddrM=;
	h=Subject:To:Cc:From:Date:From;
	b=S/O6/pZJyEptqYfQW/tCS8LUTu/IZSi8nfCmzU+XmQAd07RQTXwChCW4Fo0E2GpaS
	 0JkMTj4pJaArm0SsVegG0GHikBPeoXurnVDx+prXij64kq2arb0/E18DhKIMi7MkNE
	 jK5QF8FgifEHJNey9u5TPYAqjl7VlJ/taxcdhT7k=
Subject: FAILED: patch "[PATCH] crypto: af_alg - Disallow concurrent writes in af_alg_sendmsg" failed to apply to 6.1-stable tree
To: herbert@gondor.apana.org.au,billy@starlabs.sg,ramdhan@starlabs.sg
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 21 Sep 2025 14:38:07 +0200
Message-ID: <2025092107-making-cough-9671@gregkh>
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
git cherry-pick -x 1b34cbbf4f011a121ef7b2d7d6e6920a036d5285
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092107-making-cough-9671@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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
 


