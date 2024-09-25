Return-Path: <stable+bounces-77589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C74985FAF
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 16:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAE17B2B35A
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BD21D14F8;
	Wed, 25 Sep 2024 12:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YM7sZJqc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002401D14ED;
	Wed, 25 Sep 2024 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266389; cv=none; b=QUaVD6cwbQ0kDFwbIThxInxkvT9UiPELjQk5DlqnSaZXSs6lNI5J07x/sISiX/tauUorq4wCor9EoooY+QffhQIcioXmPve+oPrRv/giU7pt/9R/XUv1PessOGo+0Lbx8bvNqIIsLvB5ZFWob3r7j1GtTk/y2wBUQmmrqW7fIH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266389; c=relaxed/simple;
	bh=w69zHY5WGGQGuMEnH4vTSQUuCHg4t5goKv+0g4Ys2Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H24Ls79T9WV9zTgeubcJ4xnxQ+dZr0tdqbiphpYAFC+TVJKC/GFUd6bJvEl+sBbbrJJe/F5Bth2pXdNRagWUNHdNR+giJZ3YoVS8IE9AEdfFnw1P4vR/Y0hd6aAWCRkjrM/B5/M0WgnXK1Ofaibi6pdL+gJhutzcNIcxZMcxwxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YM7sZJqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3790CC4CEC3;
	Wed, 25 Sep 2024 12:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266388;
	bh=w69zHY5WGGQGuMEnH4vTSQUuCHg4t5goKv+0g4Ys2Vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YM7sZJqcm2Ni3EaLuHakd3T8RRfIloM9N4ZY6qfXYnizAVdGNRkUESoGPfb6SNU7b
	 50R3PbFAcjCphgxKlegbFp730UeqpDr7+fbAb4QJx7AZM6Lqy6od2REuQcWrpu0Oi/
	 +ScXL+dW9NeBLsQM6Z45YhRP75P7TgbGIGUy7JkjTgdtpAtFET+xt5fUDyqAwJ2txL
	 ex6hvG33qk5DtEXjOXGvjGpfddUwZcuMKrm3sx7H+/5OF88Mb2xn8YO4aGQY1cxK3R
	 b9Rp489D4INxnsow6eskzq3Xi13owQC3LyGsE0hoj39rFELFBZHTJnlJCSHw/Ppd5d
	 Shew7mn/tH+2g==
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
Subject: [PATCH AUTOSEL 6.6 043/139] tcp: avoid reusing FIN_WAIT2 when trying to find port in connect() process
Date: Wed, 25 Sep 2024 08:07:43 -0400
Message-ID: <20240925121137.1307574-43-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
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
index 96d235bcf5cb2..df3ddf31f8e67 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -116,6 +116,9 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
 	const struct tcp_timewait_sock *tcptw = tcp_twsk(sktw);
 	struct tcp_sock *tp = tcp_sk(sk);
 
+	if (tw->tw_substate == TCP_FIN_WAIT2)
+		reuse = 0;
+
 	if (reuse == 2) {
 		/* Still does not detect *everything* that goes through
 		 * lo, since we require a loopback src or dst address
-- 
2.43.0


