Return-Path: <stable+bounces-51301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F46906F36
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C516528569F
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D384145A10;
	Thu, 13 Jun 2024 12:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sWhKMIX6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA76136E00;
	Thu, 13 Jun 2024 12:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280898; cv=none; b=q/RAz1XyMDLBhXljkLSChEZveYWYo+cK/IFq4Vna6D53KuirUwOKRUYM/453L4QZmRD4VlllwBtihjBJmYPYjOVfRAsmVoPxLE5S+H7kAsLhUFxlHjC1KKe0DSGC3wC5eRHdsQ9L5wzmidJRgyuPC5WuEnMuKQj5hnAmADiYcv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280898; c=relaxed/simple;
	bh=JQ+XLqb9x4T/9I0hL+b+bioASgUNro21YHZ88Zzvcm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7PUGhP+eM67oYDuRo2hxL7I28Jrp4q2v/WJs5RpJXCXg8L10gjWWJF4R3Dch9Xb2GedE/6E0ji/9a3mj+tDAXoARwJf26WDpqjVPi5koEaZl0hn8mPIF3m52Pf7iav7uRFwoMG891hC1eHyYCtFOI2qgAwjEFEQqkkP/89z2BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sWhKMIX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BDFC2BBFC;
	Thu, 13 Jun 2024 12:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718280897;
	bh=JQ+XLqb9x4T/9I0hL+b+bioASgUNro21YHZ88Zzvcm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sWhKMIX6+Y0zg0aMEImEviCNIEQHZeVK0miqbpWhDKin6ehrDUntmgWN3zVZkEWvR
	 W926nQKFJfGvnPjQA3SmHfdCiXuHjw292j7Ql0hN1Vpuyjq2dLeWpw0e0TubXgQWYy
	 bvHRpXgXV7hfJCoudViOkYfHblhUZA5/2+Qb5Sew=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 064/317] tcp: avoid premature drops in tcp_add_backlog()
Date: Thu, 13 Jun 2024 13:31:22 +0200
Message-ID: <20240613113250.025751260@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113247.525431100@linuxfoundation.org>
References: <20240613113247.525431100@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit ec00ed472bdb7d0af840da68c8c11bff9f4d9caa ]

While testing TCP performance with latest trees,
I saw suspect SOCKET_BACKLOG drops.

tcp_add_backlog() computes its limit with :

    limit = (u32)READ_ONCE(sk->sk_rcvbuf) +
            (u32)(READ_ONCE(sk->sk_sndbuf) >> 1);
    limit += 64 * 1024;

This does not take into account that sk->sk_backlog.len
is reset only at the very end of __release_sock().

Both sk->sk_backlog.len and sk->sk_rmem_alloc could reach
sk_rcvbuf in normal conditions.

We should double sk->sk_rcvbuf contribution in the formula
to absorb bubbles in the backlog, which happen more often
for very fast flows.

This change maintains decent protection against abuses.

Fixes: c377411f2494 ("net: sk_add_backlog() take rmem_alloc into account")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20240423125620.3309458-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_ipv4.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 85d8688933f3c..0e7179a19e224 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1787,7 +1787,7 @@ int tcp_v4_early_demux(struct sk_buff *skb)
 
 bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
 {
-	u32 limit, tail_gso_size, tail_gso_segs;
+	u32 tail_gso_size, tail_gso_segs;
 	struct skb_shared_info *shinfo;
 	const struct tcphdr *th;
 	struct tcphdr *thtail;
@@ -1796,6 +1796,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
 	bool fragstolen;
 	u32 gso_segs;
 	u32 gso_size;
+	u64 limit;
 	int delta;
 
 	/* In case all data was pulled from skb frags (in __pskb_pull_tail()),
@@ -1891,7 +1892,13 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
 	__skb_push(skb, hdrlen);
 
 no_coalesce:
-	limit = (u32)READ_ONCE(sk->sk_rcvbuf) + (u32)(READ_ONCE(sk->sk_sndbuf) >> 1);
+	/* sk->sk_backlog.len is reset only at the end of __release_sock().
+	 * Both sk->sk_backlog.len and sk->sk_rmem_alloc could reach
+	 * sk_rcvbuf in normal conditions.
+	 */
+	limit = ((u64)READ_ONCE(sk->sk_rcvbuf)) << 1;
+
+	limit += ((u32)READ_ONCE(sk->sk_sndbuf)) >> 1;
 
 	/* Only socket owner can try to collapse/prune rx queues
 	 * to reduce memory overhead, so add a little headroom here.
@@ -1899,6 +1906,8 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
 	 */
 	limit += 64 * 1024;
 
+	limit = min_t(u64, limit, UINT_MAX);
+
 	if (unlikely(sk_add_backlog(sk, skb, limit))) {
 		bh_unlock_sock(sk);
 		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPBACKLOGDROP);
-- 
2.43.0




