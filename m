Return-Path: <stable+bounces-159884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2D7AF7B55
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02EB71CA3D08
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807DA2F005B;
	Thu,  3 Jul 2025 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e7JU/5PZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2442F0051;
	Thu,  3 Jul 2025 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555664; cv=none; b=UFy68hmad2DfvmHTW+v5Z+MTg2T5Z49iKB+Bwi2EKKVNaLxHODO+jUTn8K0cb3kGSy2SvkV/d5J5rOTVv5IBqidxNj5XDF8j/abm5qfOmGqUajK2GIGexYnrPI5HK7Uo0DSDNEKPSVMJD8Gk1um2MWHUbLFt7i9EfpeX1DAJpTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555664; c=relaxed/simple;
	bh=FRinWjuLMTtimI4Mi3CFm6Grhlkd/YXBeEPu2J7swVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nf+j9g7u+1DpYISQGjdFSOyGQOVDArUZguMYq2EzBhMVAYzPdKMo3/IbTYNzK3z/MVhdNIwkTv35nyY5PWj5tMnC3/NGDOl7tP92rjS7Z9N/D/GqZxNStWqb2fAEnMNmyn8m5AwTV/xwxyH0ZV8kMkeTNAR4hFe5gu4HH1OJx3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e7JU/5PZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE91C4AF0C;
	Thu,  3 Jul 2025 15:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751555664;
	bh=FRinWjuLMTtimI4Mi3CFm6Grhlkd/YXBeEPu2J7swVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e7JU/5PZfBBmnotsO+w886Mldq7gZd3B/b+Up5rCX7e4g22KiTx+/KRWZj+hFYaZN
	 PV8hfMqr8wd122BgM4LCQonXcafTzHVpu1CaogEljU7CPh0VAjIZCziCVHZFVCeBLP
	 9ZlQSSdeSO4JAnXQRBa7sH8vzJYRYJfRamvkVXVw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 083/139] af_unix: Dont set -ECONNRESET for consumed OOB skb.
Date: Thu,  3 Jul 2025 16:42:26 +0200
Message-ID: <20250703143944.406249042@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143941.182414597@linuxfoundation.org>
References: <20250703143941.182414597@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit 2a5a4841846b079b5fca5752fe94e59346fbda40 ]

Christian Brauner reported that even after MSG_OOB data is consumed,
calling close() on the receiver socket causes the peer's recv() to
return -ECONNRESET:

  1. send() and recv() an OOB data.

    >>> from socket import *
    >>> s1, s2 = socketpair(AF_UNIX, SOCK_STREAM)
    >>> s1.send(b'x', MSG_OOB)
    1
    >>> s2.recv(1, MSG_OOB)
    b'x'

  2. close() for s2 sets ECONNRESET to s1->sk_err even though
     s2 consumed the OOB data

    >>> s2.close()
    >>> s1.recv(10, MSG_DONTWAIT)
    ...
    ConnectionResetError: [Errno 104] Connection reset by peer

Even after being consumed, the skb holding the OOB 1-byte data stays in
the recv queue to mark the OOB boundary and break recv() at that point.

This must be considered while close()ing a socket.

Let's skip the leading consumed OOB skb while checking the -ECONNRESET
condition in unix_release_sock().

Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Reported-by: Christian Brauner <brauner@kernel.org>
Closes: https://lore.kernel.org/netdev/20250529-sinkt-abfeuern-e7b08200c6b0@brauner/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Acked-by: Christian Brauner <brauner@kernel.org>
Link: https://patch.msgid.link/20250619041457.1132791-4-kuni1840@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/unix/af_unix.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 7604d399a7788..f89cd01247f6b 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -630,6 +630,11 @@ static void unix_sock_destructor(struct sock *sk)
 #endif
 }
 
+static unsigned int unix_skb_len(const struct sk_buff *skb)
+{
+	return skb->len - UNIXCB(skb).consumed;
+}
+
 static void unix_release_sock(struct sock *sk, int embrion)
 {
 	struct unix_sock *u = unix_sk(sk);
@@ -664,10 +669,16 @@ static void unix_release_sock(struct sock *sk, int embrion)
 
 	if (skpair != NULL) {
 		if (sk->sk_type == SOCK_STREAM || sk->sk_type == SOCK_SEQPACKET) {
+			struct sk_buff *skb = skb_peek(&sk->sk_receive_queue);
+
+#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+			if (skb && !unix_skb_len(skb))
+				skb = skb_peek_next(skb, &sk->sk_receive_queue);
+#endif
 			unix_state_lock(skpair);
 			/* No more writes */
 			WRITE_ONCE(skpair->sk_shutdown, SHUTDOWN_MASK);
-			if (!skb_queue_empty_lockless(&sk->sk_receive_queue) || embrion)
+			if (skb || embrion)
 				WRITE_ONCE(skpair->sk_err, ECONNRESET);
 			unix_state_unlock(skpair);
 			skpair->sk_state_change(skpair);
@@ -2552,11 +2563,6 @@ static long unix_stream_data_wait(struct sock *sk, long timeo,
 	return timeo;
 }
 
-static unsigned int unix_skb_len(const struct sk_buff *skb)
-{
-	return skb->len - UNIXCB(skb).consumed;
-}
-
 struct unix_stream_read_state {
 	int (*recv_actor)(struct sk_buff *, int, int,
 			  struct unix_stream_read_state *);
-- 
2.39.5




