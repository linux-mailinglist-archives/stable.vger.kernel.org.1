Return-Path: <stable+bounces-77155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8378A98595D
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA151B25464
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 11:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9768319F42A;
	Wed, 25 Sep 2024 11:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnqDxSOC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503F219F416;
	Wed, 25 Sep 2024 11:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264321; cv=none; b=urBNYuihiMTm5Z0pzYzhlu0Go/fyiViLSLT8y5y1l81A/ooQt1cQavK6lMlVmGIbZaSVtxJ7C5y2ZPd3lQKoZNPqVWa5dmimck8Bv8IQ5OqdfLqsjsP2iVyxHpO2XzQt7I4F8HSUiXtXJDBGcqrezm5HXRUR29Z5gSaCni1ngMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264321; c=relaxed/simple;
	bh=BgjobYrsJh27T8JlqNPIa3v/ibUQLsfFkrmHT8zuep0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehw+SpJQCj91q+am2Uly83yJ8olRbcKbKPyjR4mr74E7PZTaq4T+XdiIJ/pNy8mUTTBxih6w4WU/+3nybxptHHqhD/yDaECWAouCO4pFQ/FlGR/dBC3qjABnrIxNO22sgzFv8AtUaphdsA5pvbgkIPBEJEZyPeW9Q15geV87/I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnqDxSOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC03C4CECE;
	Wed, 25 Sep 2024 11:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264320;
	bh=BgjobYrsJh27T8JlqNPIa3v/ibUQLsfFkrmHT8zuep0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tnqDxSOCH7a0duNP71c8z8sVZ5+bD1PosjadSnFsfmx7h5uHzt8TT4Xj26HiUIqOr
	 I2J1gXKCLOtDxnVvQdANjr40XFekrD05/T9TeYlosXDWdS8Gqfd6ZKqCaj4QlfcO91
	 UeLoS+gj04O7Nrk7u7o7Y8DdK7RXN/wB085w/Z/K1kx8q7kxoAPjW0o7cz1RziyPWZ
	 ZZlnkkgJ/3B1cyzTCG84d/GabOSXcNPXVT1vTXNwsNs0vvDdgep+Tl1PsvlUq7Hv/C
	 WlaaiJyLkA8Q2naVbNokMQ27vHrnoDHV70ph0E/35zPavKsiCxiyCWYmVLqesIbf5d
	 Bo0KDxAAgP41Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Jade Dong <jadedong@tencent.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	dsahern@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 057/244] tcp: avoid reusing FIN_WAIT2 when trying to find port in connect() process
Date: Wed, 25 Sep 2024 07:24:38 -0400
Message-ID: <20240925113641.1297102-57-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

[ Upstream commit 0d9e5df4a257afc3a471a82961ace9a22b88295a ]

We found that one close-wait socket was reset by the other side
due to a new connection reusing the same port which is beyond our
expectation, so we have to investigate the underlying reason.

The following experiment is conducted in the test environment. We
limit the port range from 40000 to 40010 and delay the time to close()
after receiving a fin from the active close side, which can help us
easily reproduce like what happened in production.

Here are three connections captured by tcpdump:
127.0.0.1.40002 > 127.0.0.1.9999: Flags [S], seq 2965525191
127.0.0.1.9999 > 127.0.0.1.40002: Flags [S.], seq 2769915070
127.0.0.1.40002 > 127.0.0.1.9999: Flags [.], ack 1
127.0.0.1.40002 > 127.0.0.1.9999: Flags [F.], seq 1, ack 1
// a few seconds later, within 60 seconds
127.0.0.1.40002 > 127.0.0.1.9999: Flags [S], seq 2965590730
127.0.0.1.9999 > 127.0.0.1.40002: Flags [.], ack 2
127.0.0.1.40002 > 127.0.0.1.9999: Flags [R], seq 2965525193
// later, very quickly
127.0.0.1.40002 > 127.0.0.1.9999: Flags [S], seq 2965590730
127.0.0.1.9999 > 127.0.0.1.40002: Flags [S.], seq 3120990805
127.0.0.1.40002 > 127.0.0.1.9999: Flags [.], ack 1

As we can see, the first flow is reset because:
1) client starts a new connection, I mean, the second one
2) client tries to find a suitable port which is a timewait socket
   (its state is timewait, substate is fin_wait2)
3) client occupies that timewait port to send a SYN
4) server finds a corresponding close-wait socket in ehash table,
   then replies with a challenge ack
5) client sends an RST to terminate this old close-wait socket.

I don't think the port selection algo can choose a FIN_WAIT2 socket
when we turn on tcp_tw_reuse because on the server side there
remain unread data. In some cases, if one side haven't call close() yet,
we should not consider it as expendable and treat it at will.

Even though, sometimes, the server isn't able to call close() as soon
as possible like what we expect, it can not be terminated easily,
especially due to a second unrelated connection happening.

After this patch, we can see the expected failure if we start a
connection when all the ports are occupied in fin_wait2 state:
"Ncat: Cannot assign requested address."

Reported-by: Jade Dong <jadedong@tencent.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20240823001152.31004-1-kerneljasonxing@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_ipv4.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index a4e510846905e..5087e12209a19 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -120,6 +120,9 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
 	struct tcp_sock *tp = tcp_sk(sk);
 	int ts_recent_stamp;
 
+	if (tw->tw_substate == TCP_FIN_WAIT2)
+		reuse = 0;
+
 	if (reuse == 2) {
 		/* Still does not detect *everything* that goes through
 		 * lo, since we require a loopback src or dst address
-- 
2.43.0


