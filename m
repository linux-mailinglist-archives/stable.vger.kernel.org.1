Return-Path: <stable+bounces-95418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 114199D89F6
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 17:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA868284D0E
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 16:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6D01B412E;
	Mon, 25 Nov 2024 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nS5Pv3vM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC872500D2
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732551049; cv=none; b=OAc28z2AW9qIgRr0FKvlEyMygQVKwR0egxkzICBnElwwK8+SVKe/O9/oaLt762d/fZ9MO4Bu3P7k2WWVg0MjkfpqxXCiC8pqNBR6AAyK4xMoBbzZ49D3NVep+q9pldhfEuXNsTrCHfPA3F4QIG1slKRJMm3wQzxPYKZ4k0yEUPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732551049; c=relaxed/simple;
	bh=Q7BHKOh/ypBzQzDaEkPvPttMcQq9D3Gwz0+dpLxGjKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJCjhNJzZ0dAXkx9Yo3ixzj05YXHFL1lLDq2QBUfEzDoOmLeZiJjfXHnkel6/QRkl/IoOJRk4hSqdNEl7fj+PMJdkxMxhox3ZWXYfqpTen3p/PgmTzu5UIGsBpxcBIxZb9mxFz/btpYQjry6Mf6ykSNLa5F9VqzFrWtTbmCa5hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nS5Pv3vM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D70EC4CECE;
	Mon, 25 Nov 2024 16:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732551049;
	bh=Q7BHKOh/ypBzQzDaEkPvPttMcQq9D3Gwz0+dpLxGjKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nS5Pv3vMAhuNkgjJK9h/MLqItbZxEOqcmUvA5gjIHoWMbqjZJEiLncnJxvB0txiju
	 gUW/c8Gu7v8ckhXGmjdcRq3nLVYFodc2K5+RwVZ4q2GZW3nPRTKoAHPRwI1t2rY5Ti
	 iP5doBnhqgZguvT9zIfq/FsorydSqfcalelF4blb6sc2RgsUfsdi9JbdqYmIaqC5QL
	 P2oX6VKs/+ao4hDGoR4MEHKr/8fSA10v4hrJRSPI5XaoSFP/hkZ0aOqx4cV/ocA5bh
	 gG/wXOVNWFJPc2nyOJkKVKX+I52NDn3butKCLqk/ddXaQKBgoTiyVGbPQ+XESp2Zzx
	 k3Oh5ZcOcD2mw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] mptcp: fix possible integer overflow in mptcp_reset_tout_timer
Date: Mon, 25 Nov 2024 11:10:47 -0500
Message-ID: <20241125103724-da91848044902486@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241125140450.3752859-2-matttbe@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: b169e76ebad22cbd055101ee5aa1a7bed0e66606

WARNING: Author mismatch between patch and upstream commit:
Backport author: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Commit author: Dmitry Kandybka <d.kandybka@gmail.com>


Status in newer kernel trees:
6.12.y | Not found
6.11.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-25 10:32:38.653460225 -0500
+++ /tmp/tmp.e3CQHyz4BZ	2024-11-25 10:32:38.645231976 -0500
@@ -1,3 +1,5 @@
+commit b169e76ebad22cbd055101ee5aa1a7bed0e66606 upstream.
+
 In 'mptcp_reset_tout_timer', promote 'probe_timestamp' to unsigned long
 to avoid possible integer overflow. Compile tested only.
 
@@ -6,22 +8,31 @@
 Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
 Link: https://patch.msgid.link/20241107103657.1560536-1-d.kandybka@gmail.com
 Signed-off-by: Jakub Kicinski <kuba@kernel.org>
+[ Conflict in this version because commit d866ae9aaa43 ("mptcp: add a
+  new sysctl for make after break timeout") is not in this version, and
+  replaced TCP_TIMEWAIT_LEN in the expression. The fix can still be
+  applied the same way: by forcing a cast to unsigned long for the first
+  item. ]
+Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
 ---
  net/mptcp/protocol.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)
 
 diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
-index b0e9a745ea621..a6f2a25edb119 100644
+index b8357d7c6b3a..01f6ce970918 100644
 --- a/net/mptcp/protocol.c
 +++ b/net/mptcp/protocol.c
-@@ -2722,8 +2722,8 @@ void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
+@@ -2691,8 +2691,8 @@ void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
  	if (!fail_tout && !inet_csk(sk)->icsk_mtup.probe_timestamp)
  		return;
  
 -	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies +
--			mptcp_close_timeout(sk);
+-			TCP_TIMEWAIT_LEN;
 +	close_timeout = (unsigned long)inet_csk(sk)->icsk_mtup.probe_timestamp -
-+			tcp_jiffies32 + jiffies + mptcp_close_timeout(sk);
++			tcp_jiffies32 + jiffies + TCP_TIMEWAIT_LEN;
  
  	/* the close timeout takes precedence on the fail one, and here at least one of
  	 * them is active
+-- 
+2.45.2
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

