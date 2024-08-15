Return-Path: <stable+bounces-68034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0932953052
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9219528758E
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6111718D630;
	Thu, 15 Aug 2024 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NP1nH3Qj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F36918D627;
	Thu, 15 Aug 2024 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729292; cv=none; b=it1nHWeA7UkXahudsqD+FYB4kPPP2O6HcxR1xJFxAxK3htzBBl4oJ8nZL2H1D4GwK2tPQiamAQhdwT0WI1pamHncuYcU13G15TqOSxdXLBW9cQmku6ZNLk+wsm3LGt7VEdEOPmixkWkKaejNkNvhX6Ub8YDdzKVMayHhpNCTdNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729292; c=relaxed/simple;
	bh=mGVLiYAbiU9dWDQvopC2SQsDaSFZAfKcnFHo3dWSDUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQz3b3MKIwWQxV7yKNYT5uEuFgeNhEaV+BIXt/uqmJ6ZE/smAthZ4kdDqpGlPSn8y3cC+Bjw2gtrqd22/SptT0LTde2fwMdI3DZlxFqc2G3Scmw+SKsBCebVNGA1BDZnprZHDDR1FzKD8QugYzibetUc0g50I0MFzFdlwW20P60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NP1nH3Qj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B46C32786;
	Thu, 15 Aug 2024 13:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723729292;
	bh=mGVLiYAbiU9dWDQvopC2SQsDaSFZAfKcnFHo3dWSDUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NP1nH3QjZeATp8+2lE2BC5xP1Tkro6naepD+2zwIs4fLIrZMgXG0uT5BD+10GFmrn
	 ++x+fRn67OgZc/pJcj7+ewZftlhZHgB0ROj95xIZUsECx5IMUoErY8K1Tqmia4oSCI
	 jfkDwtMMr8jmLyvy26d12o/eCZ0dbX485RIe6LAA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 051/484] tcp: fix race in tcp_write_err()
Date: Thu, 15 Aug 2024 15:18:29 +0200
Message-ID: <20240815131943.254329296@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
References: <20240815131941.255804951@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 853c3bd7b7917670224c9fe5245bd045cac411dd ]

I noticed flakes in a packetdrill test, expecting an epoll_wait()
to return EPOLLERR | EPOLLHUP on a failed connect() attempt,
after multiple SYN retransmits. It sometimes return EPOLLERR only.

The issue is that tcp_write_err():
 1) writes an error in sk->sk_err,
 2) calls sk_error_report(),
 3) then calls tcp_done().

tcp_done() is writing SHUTDOWN_MASK into sk->sk_shutdown,
among other things.

Problem is that the awaken user thread (from 2) sk_error_report())
might call tcp_poll() before tcp_done() has written sk->sk_shutdown.

tcp_poll() only sees a non zero sk->sk_err and returns EPOLLERR.

This patch fixes the issue by making sure to call sk_error_report()
after tcp_done().

tcp_write_err() also lacks an smp_wmb().

We can reuse tcp_done_with_error() to factor out the details,
as Neal suggested.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Link: https://lore.kernel.org/r/20240528125253.1966136-3-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_timer.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index ed01b775b8947..1a3a84992b9be 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -67,11 +67,7 @@ u32 tcp_clamp_probe0_to_user_timeout(const struct sock *sk, u32 when)
 
 static void tcp_write_err(struct sock *sk)
 {
-	WRITE_ONCE(sk->sk_err, READ_ONCE(sk->sk_err_soft) ? : ETIMEDOUT);
-	sk_error_report(sk);
-
-	tcp_write_queue_purge(sk);
-	tcp_done(sk);
+	tcp_done_with_error(sk, READ_ONCE(sk->sk_err_soft) ? : ETIMEDOUT);
 	__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONTIMEOUT);
 }
 
-- 
2.43.0




