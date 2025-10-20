Return-Path: <stable+bounces-188152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE68BF22CA
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC254344F9E
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F80E26B96A;
	Mon, 20 Oct 2025 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTWkljph"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFB0264FB5
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975059; cv=none; b=OlWXDjwMwU1nN+1hWs9vViKVYyTbZ7idwwEA14yzxop8K9zUj8YGKU8pxqy2Heb6WeQmGJNw7/p+HqRykdBg2B/3DTPs1LVmV23qjHGuu8ZLfV6Vz9fhxDsKfsAH8t3IGhjlMnJ8HKC/0a5UhoCDsRqrqamyG3PxuNIAOLRlfxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975059; c=relaxed/simple;
	bh=RCYfSGk8jNXiHD89++DKvMXC6kGOm70xTlhiEFvDPnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSSAjogRStvKZPZh9RO2JRQa4ebrVcV3m7MkmXJeVfubWu2ZftBU9LDS+AI6P/Mv8sNVPUGUsaRTQoyKpFetfeY71uMI+A2LEK1DErQ0+KDhrQG7XPuiVrOD5eQupRTAqV7+de9u/K0LJMaYPHkZY4cdwmnEeVz6eYHc2FfHM7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTWkljph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25619C116D0;
	Mon, 20 Oct 2025 15:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760975058;
	bh=RCYfSGk8jNXiHD89++DKvMXC6kGOm70xTlhiEFvDPnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pTWkljphzvN0Tsev0RxyumYD6RNHVFA2L4UOpmVgv7S5Xhw6BLwfMmiDeOjPC/IEa
	 ADJPD/77qYTpMclQtNQVcFPNP+/8HvsylSa1iTIuJ+ojQ7tZ/1P+Oy4X7jmJuIBLTu
	 +xTn4Ax/ty0vpDEVUvuW59GXIP9wQ7aE5Tg3qThvW7v4FX6fz3aY8TPvn0R8oIa445
	 /d2I60bVl0rFCGz9qIwEuSxagRG6XsUv7EOo/pdIRNeZI/2fgFrY9JMnyhLxV873pq
	 7P5S9iZ590arYwWMUkW/GydCnClKJ9is/aYo2vd8Ydnx3xaYJ2hJXVrzA4jsqJ99MU
	 w2ZHmmZnIaoBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 6/8] mptcp: Call dst_release() in mptcp_active_enable().
Date: Mon, 20 Oct 2025 11:44:07 -0400
Message-ID: <20251020154409.1823664-6-sashal@kernel.org>
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

[ Upstream commit 108a86c71c93ff28087994e6107bc99ebe336629 ]

mptcp_active_enable() calls sk_dst_get(), which returns dst with its
refcount bumped, but forgot dst_release().

Let's add missing dst_release().

Cc: stable@vger.kernel.org
Fixes: 27069e7cb3d1 ("mptcp: disable active MPTCP in case of blackhole")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20250916214758.650211-7-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 833d4313bc1e ("mptcp: reset blackhole on success with non-loopback ifaces")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/ctrl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index dd595d9b5e50c..6a97d11bda7e2 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -385,6 +385,8 @@ void mptcp_active_enable(struct sock *sk)
 
 		if (dst && dst->dev && (dst->dev->flags & IFF_LOOPBACK))
 			atomic_set(&pernet->active_disable_times, 0);
+
+		dst_release(dst);
 	}
 }
 
-- 
2.51.0


