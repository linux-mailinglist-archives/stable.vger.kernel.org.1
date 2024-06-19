Return-Path: <stable+bounces-54181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C570390ED0D
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A25280E3B
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043141422B8;
	Wed, 19 Jun 2024 13:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LeXJKqF3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B707314389C;
	Wed, 19 Jun 2024 13:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802821; cv=none; b=e4FIRvTtus3aO1NpWehwGsbyPUZlok0ND3G4TFapMATMhnmuoxGON8VRC6cme2yLGKawNN4qas0VLYUJ9BpGN9qVq4MkUmiPO0MvbvnZx6TvpW8l8XqOdRBURsnqigYHwCoLkPzNmF28exPD+sRcp28XEJtnLYfa7SPzBmx6qb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802821; c=relaxed/simple;
	bh=Arq88Fhe1gJV3A4j9szl9+8SVDxaTMPD/DJeFhz8k4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QjOvruEbc5MtssCtbLS/f+jRhTbm72CH4X7OWFLt2ei2wDmBL+dYvzYPijge2dkNFzCjZRum9WFgV32Q0x8NGOBB51T9Bk08QJLwldYphalNzHo5uZ9/1aQTE0wzFPLsjFkHIERbkyd0Cda7UVIuAFpYkSRMr1QTPZBsKt4ma5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LeXJKqF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B781C2BBFC;
	Wed, 19 Jun 2024 13:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718802821;
	bh=Arq88Fhe1gJV3A4j9szl9+8SVDxaTMPD/DJeFhz8k4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LeXJKqF3GGFbVfr7Vub/ii8KVi64RzLgrm55+ilpr1euQv9Sj2oMHUPQeQUiFK/5S
	 tD/pOfuNkg3CAYmOZ4WI7k3ZEIGND+6hxxS3sY5VcSWkOcEcZ4Jfuprrp+WNA/SgCf
	 XXesCKSZS8TGJ4xX277HfXjym3wHhJCgez6Ho14w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 059/281] af_unix: Annotate data-race of sk->sk_state in unix_inq_len().
Date: Wed, 19 Jun 2024 14:53:38 +0200
Message-ID: <20240619125612.119715128@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125609.836313103@linuxfoundation.org>
References: <20240619125609.836313103@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 3a0f38eb285c8c2eead4b3230c7ac2983707599d ]

ioctl(SIOCINQ) calls unix_inq_len() that checks sk->sk_state first
and returns -EINVAL if it's TCP_LISTEN.

Then, for SOCK_STREAM sockets, unix_inq_len() returns the number of
bytes in recvq.

However, unix_inq_len() does not hold unix_state_lock(), and the
concurrent listen() might change the state after checking sk->sk_state.

If the race occurs, 0 is returned for the listener, instead of -EINVAL,
because the length of skb with embryo is 0.

We could hold unix_state_lock() in unix_inq_len(), but it's overkill
given the result is true for pre-listen() TCP_CLOSE state.

So, let's use READ_ONCE() for sk->sk_state in unix_inq_len().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/unix/af_unix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 0a9c3975d4303..989c2c76dce66 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -3064,7 +3064,7 @@ long unix_inq_len(struct sock *sk)
 	struct sk_buff *skb;
 	long amount = 0;
 
-	if (sk->sk_state == TCP_LISTEN)
+	if (READ_ONCE(sk->sk_state) == TCP_LISTEN)
 		return -EINVAL;
 
 	spin_lock(&sk->sk_receive_queue.lock);
-- 
2.43.0




