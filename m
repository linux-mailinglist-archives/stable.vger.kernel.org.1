Return-Path: <stable+bounces-188153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43137BF232D
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E7D3AAD11
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E7B26E71E;
	Mon, 20 Oct 2025 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="na8Bjarr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58097191F92
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975060; cv=none; b=UXh7Lc8IF51E2BmXl9JNfL8BAXhongl1zoilWtTWOpilQYZow2T2JI2lODNETriyr9TypgErWDA8lRQ8b/qTY66Asx3L8Tqq7SqRqinljiMmg51UGlOMyqSiRIFxqCfv53k97uBqPJhyOAIrSuPhprkTTW6vlI/3j3ZT0FRVVdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975060; c=relaxed/simple;
	bh=LkvrscrIBp06mopZAl9cfw1ZExmnu5oyZTd/waLUHQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NPNynJUuFQt3XcgSBtOyPS7If88vGQnGJKzHpPU9hw6x5T3/DPKg8oGNxQAlclJmCobAEwKUA7QIl1jxsHe8ejmd5Z3u3RIxIDjXidYDVWKDjH4hIR87NJ5AOyDqjCfA5AX2X0EZ9R/zXeFvydtJCezXLap89XrbOyGyV2MuzPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=na8Bjarr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE34C4CEF9;
	Mon, 20 Oct 2025 15:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760975059;
	bh=LkvrscrIBp06mopZAl9cfw1ZExmnu5oyZTd/waLUHQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=na8BjarrUoXJdXHh0u2aOwPxxz/4lCYEIzl/uUjMykRLOBnGu+S5/Jy9BPxgQNcGc
	 5V+IskeMEXHHbxzYej9bV5zq3A78U2Xd9RgX6xAkKp8DxMRVUop3FM7xB3THcwRfBL
	 B/cwpDA3EKfLfbkgAmL6+cLn3JSybPRp8AA/DXJO8zd4O8GEo2UM1LxIkq8nB80r/f
	 iPWFPcJCzcAIw90eb0oqi9DcovuMf1HX7tKUSc3L0Q4w31vdTInz4iBnH82Rb6S9ac
	 c5icu9bX9LqAY/omt61ZglvRG9ydAk47RR8pms5LnoMPVImK78l4ZybUyt5xkld5iV
	 5yJPpJzTQXNmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 7/8] mptcp: Use __sk_dst_get() and dst_dev_rcu() in mptcp_active_enable().
Date: Mon, 20 Oct 2025 11:44:08 -0400
Message-ID: <20251020154409.1823664-7-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020154409.1823664-1-sashal@kernel.org>
References: <2025101604-chamber-playhouse-5278@gregkh>
 <20251020154409.1823664-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit 893c49a78d9f85e4b8081b908fb7c407d018106a ]

mptcp_active_enable() is called from subflow_finish_connect(),
which is icsk->icsk_af_ops->sk_rx_dst_set() and it's not always
under RCU.

Using sk_dst_get(sk)->dev could trigger UAF.

Let's use __sk_dst_get() and dst_dev_rcu().

Fixes: 27069e7cb3d1 ("mptcp: disable active MPTCP in case of blackhole")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20250916214758.650211-8-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 833d4313bc1e ("mptcp: reset blackhole on success with non-loopback ifaces")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/ctrl.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 6a97d11bda7e2..9e1f61b02a66e 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -381,12 +381,15 @@ void mptcp_active_enable(struct sock *sk)
 	struct mptcp_pernet *pernet = mptcp_get_pernet(sock_net(sk));
 
 	if (atomic_read(&pernet->active_disable_times)) {
-		struct dst_entry *dst = sk_dst_get(sk);
+		struct net_device *dev;
+		struct dst_entry *dst;
 
-		if (dst && dst->dev && (dst->dev->flags & IFF_LOOPBACK))
+		rcu_read_lock();
+		dst = __sk_dst_get(sk);
+		dev = dst ? dst_dev_rcu(dst) : NULL;
+		if (dev && (dev->flags & IFF_LOOPBACK))
 			atomic_set(&pernet->active_disable_times, 0);
-
-		dst_release(dst);
+		rcu_read_unlock();
 	}
 }
 
-- 
2.51.0


