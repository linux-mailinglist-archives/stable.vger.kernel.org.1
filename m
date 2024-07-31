Return-Path: <stable+bounces-64745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FDC942BAC
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 12:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DC3AB20F19
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 10:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8841AC447;
	Wed, 31 Jul 2024 10:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHXi8JZm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39901AC437;
	Wed, 31 Jul 2024 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722420638; cv=none; b=qHvlfVhRF4MG/T2dQY5UI1xN9aqYrCWJy29eAsvmWTggMKtdALaAnsejTSy82ASNmtsQVZeSodSJKlOhlC2L8TYFWlM7U/1jVAld7UGtcaykqgXUqXCT0eHKqyGazOtKZQYqInCX272rBuo0+p79g5KdGGAE+EwrijKunNrCN2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722420638; c=relaxed/simple;
	bh=H8Dt8TRfu+FKsLww2oDHhCRoGlO5idEYzWV180422Jw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rAWgtFfjDpDKX4UigVyj32Kh0Xw3FJ/Z6hNLVce7rGt+kk1xwhlibVAiL1rzp9wsT4JrURyEXrXVQMMSLfRbSQ4YQQX7kbsDwA4ks4oal+mOCLzdcicys90tL6XID/Z79fUn0WOuggZyABiEuGEkFtwdc4tTj06FJJ+OyHNJHO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHXi8JZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FE3C4AF0E;
	Wed, 31 Jul 2024 10:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722420638;
	bh=H8Dt8TRfu+FKsLww2oDHhCRoGlO5idEYzWV180422Jw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZHXi8JZmYg/E1xsKvJZ/Ati9mTTFqY5Z48J2Ng5ynET3AuDAhDHJnHd0TRl/djgVi
	 NssnY5CI0qpvho14w5OSkQVZxy9K4d7A8Ky9W/U4RdJ4mtbEyGJbqRS5P0NdiNJHxP
	 vGgRjslj17M+rFDs4c/pO8sZ//vUuPWQT7pRoxu9r09ILt6oFUpmKG/DaUNTXDd1zl
	 oR0MWtF05+B/jc4Pmrdnzy5o2UrZTJ0ZiwyCu9j3WNex2EvG1mlZEHLD+p/6yBs8g7
	 Aaypo7iGl7DYzX+SNj3EZr9pi79A8gu5kJPkpqVu/qLUWDeCjgrQYZliO/py4Cnj9h
	 Vxty4d4zGGWVQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 31 Jul 2024 12:10:14 +0200
Subject: [PATCH net 1/2] mptcp: fix bad RCVPRUNED mib accounting
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-upstream-net-20240731-mptcp-dup-data-v1-1-bde833fa628a@kernel.org>
References: <20240731-upstream-net-20240731-mptcp-dup-data-v1-0-bde833fa628a@kernel.org>
In-Reply-To: <20240731-upstream-net-20240731-mptcp-dup-data-v1-0-bde833fa628a@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1600; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=B/IpD4eT5lsmU2JoZeqN31jRGBuOWnvRkoQrDPft8yw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmqg2YhQwvfFDP40KU2RFMHcfK7PKTzl1i2eapZ
 O07AQtI+Q2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqoNmAAKCRD2t4JPQmmg
 cynOD/9Dl/Nb3D4GsnwPqGjv5vj164TQMI0CPsqRsfooaNRsE8jRLWflKslWfQrlesNV+oFDnbO
 DGL04ppWvM4ydxnfVneZAXJWl+eNyj4461s0GnFWPQzqaEE/3rncw/AAaVCTpoliHzZJUbkrrp+
 T0HD9qYHXqCWeVnfVhdPa7Tzjeji7570dosC56mvT1aLhcAP9tGdpkF9fpigaEDOVfeVPLZoTwt
 EMNiorNor6ZczQXRpx5h/wrxNoZpwEEWWhJr7YjBXyQLcK7xYSqnMWOVXGj+IDIFv4RjFWB9G5s
 MMvAIgq/VW1hWihYvNHGqhqKVOmyc0UM/5u+3QS0XMkQwigh419cWgKAbam1kribE3f0kqoBol5
 LeOiuYbERa3Qn6avpek0ETp7jbrcZd6VbZ5lcZiUYPUjgCdSuPxdBf3LYz41eR5jRZLxC0/EVtC
 EiHi60uCIIUQWiwQoQ24znot3MGuRvYHDT0hkGl1Vq3h18f9brHM2sEGHwDEkQjsF04m+LYDyHY
 OwG7gXZrhVEcodOvhQN18jEbiu9u8d18W4eRcrLnlpQJ/W07WgTH5EYFH4fdRybgaB+5oG/PrAD
 YJALASt3fndTNAAWQqOOCF6OnrzmnC7YfbJdZqtHZ59bcqs5C5uFQuHq0HUH5bcLJKDIdVDyOfA
 8AviwiuMPslFF2g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Since its introduction, the mentioned MIB accounted for the wrong
event: wake-up being skipped as not-needed on some edge condition
instead of incoming skb being dropped after landing in the (subflow)
receive queue.

Move the increment in the correct location.

Fixes: ce599c516386 ("mptcp: properly account bulk freed memory")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a2fc54ed68c0..0d536b183a6c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -350,8 +350,10 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 	skb_orphan(skb);
 
 	/* try to fetch required memory from subflow */
-	if (!mptcp_rmem_schedule(sk, ssk, skb->truesize))
+	if (!mptcp_rmem_schedule(sk, ssk, skb->truesize)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
 		goto drop;
+	}
 
 	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
 
@@ -844,10 +846,8 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 		sk_rbuf = ssk_rbuf;
 
 	/* over limit? can't append more skbs to msk, Also, no need to wake-up*/
-	if (__mptcp_rmem(sk) > sk_rbuf) {
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
+	if (__mptcp_rmem(sk) > sk_rbuf)
 		return;
-	}
 
 	/* Wake-up the reader only for in-sequence data */
 	mptcp_data_lock(sk);

-- 
2.45.2


