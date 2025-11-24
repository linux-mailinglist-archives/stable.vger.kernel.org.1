Return-Path: <stable+bounces-196798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B55FC8275C
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 21:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2FF94E1EEC
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 20:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668952E62D9;
	Mon, 24 Nov 2025 20:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCo2XmbY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F222E2840
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 20:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764017960; cv=none; b=bnvzakVFKOI0t1TtkZjNBehibdSUwYZ9ydPOigWyzqwf1H0nvxpL0YneGiSAUjl1SfJ1LXxtHKo7UDG4tdMiFY8+baaaCb87p7ZKI0XrBvJqfUQB3jMEvpdA/rVTpkEgSebQirzvtcVgeJE6nkCBfwwO07w59+vo4f19vSfQD04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764017960; c=relaxed/simple;
	bh=0s2u8vGCFGQHz+mo+io0+6vxauG60CsL/Em7GW1KeD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUPKISrxjfG2VBKS/n1t1jA3v22DIKjQZPTutrl8ygToZR+gLJXSgMyGgc4cmpC30FhHN3tNrXbOIn/ri2iZxyytOtjju4YC8tSP4zDFgAq2Nw72dI5RBv+vhewJzbddG/ALx9Kq9yrwGyu2PxU9qdp0iR68h1u/824mTXOOmmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCo2XmbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B264C4CEF1;
	Mon, 24 Nov 2025 20:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764017959;
	bh=0s2u8vGCFGQHz+mo+io0+6vxauG60CsL/Em7GW1KeD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XCo2XmbY3GRI+qXov2bQOJ4hJ7mfkOipvq1I0zalRdl/yrekHXhTS1MpCIv4o56wX
	 h5Gvi0na0/uro+bQc4hpHaxGo5rWF9TmJfzCencAvR2mK1Af6YWPh54j6H0pOPciSI
	 vZFKQ4TY+1fwOZdCh0BlknqIOFyarIpw8E20X/hXhPZLPIrM+yO+vh/9RR7UyCGDXT
	 /8ghjywNdhEuzTnqmWM2QRcA/xEdeJwXdkOWym/x/QXKdh3dyaRor7CyCX8KQLLMe2
	 x6NRanKZ3Mp6qNOzSrs/tawlF+2/XYd9RT79VvfhSdWynxIomib7fyZGPbAEfFTdjw
	 0pwbiggagLlrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] mptcp: introduce mptcp_schedule_work
Date: Mon, 24 Nov 2025 15:59:16 -0500
Message-ID: <20251124205917.27437-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112402-confiding-slideshow-217f@gregkh>
References: <2025112402-confiding-slideshow-217f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit ba8f48f7a4d79352b764ace585b5f602ef940be0 ]

remove some of code duplications an allow preventing
rescheduling on close.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 035bca3f017e ("mptcp: fix race condition in mptcp_schedule_work()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm.c       |  3 +--
 net/mptcp/protocol.c | 36 ++++++++++++++++++++++--------------
 net/mptcp/protocol.h |  1 +
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index a8c26f4179004..7b9177503bd53 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -89,8 +89,7 @@ static bool mptcp_pm_schedule_work(struct mptcp_sock *msk,
 		return false;
 
 	msk->pm.status |= BIT(new_status);
-	if (schedule_work(&msk->work))
-		sock_hold((struct sock *)msk);
+	mptcp_schedule_work((struct sock *)msk);
 	return true;
 }
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1342c31df0c40..591882cf86453 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -641,9 +641,8 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 		 * this is not a good place to change state. Let the workqueue
 		 * do it.
 		 */
-		if (mptcp_pending_data_fin(sk, NULL) &&
-		    schedule_work(&msk->work))
-			sock_hold(sk);
+		if (mptcp_pending_data_fin(sk, NULL))
+			mptcp_schedule_work(sk);
 	}
 
 	spin_unlock_bh(&sk->sk_lock.slock);
@@ -715,23 +714,32 @@ static void mptcp_reset_timer(struct sock *sk)
 	sk_reset_timer(sk, &icsk->icsk_retransmit_timer, jiffies + tout);
 }
 
+bool mptcp_schedule_work(struct sock *sk)
+{
+	if (inet_sk_state_load(sk) != TCP_CLOSE &&
+	    schedule_work(&mptcp_sk(sk)->work)) {
+		/* each subflow already holds a reference to the sk, and the
+		 * workqueue is invoked by a subflow, so sk can't go away here.
+		 */
+		sock_hold(sk);
+		return true;
+	}
+	return false;
+}
+
 void mptcp_data_acked(struct sock *sk)
 {
 	mptcp_reset_timer(sk);
 
 	if ((!test_bit(MPTCP_SEND_SPACE, &mptcp_sk(sk)->flags) ||
-	     (inet_sk_state_load(sk) != TCP_ESTABLISHED)) &&
-	    schedule_work(&mptcp_sk(sk)->work))
-		sock_hold(sk);
+	     (inet_sk_state_load(sk) != TCP_ESTABLISHED)))
+		mptcp_schedule_work(sk);
 }
 
 void mptcp_subflow_eof(struct sock *sk)
 {
-	struct mptcp_sock *msk = mptcp_sk(sk);
-
-	if (!test_and_set_bit(MPTCP_WORK_EOF, &msk->flags) &&
-	    schedule_work(&msk->work))
-		sock_hold(sk);
+	if (!test_and_set_bit(MPTCP_WORK_EOF, &mptcp_sk(sk)->flags))
+		mptcp_schedule_work(sk);
 }
 
 static void mptcp_check_for_eof(struct mptcp_sock *msk)
@@ -1643,8 +1651,7 @@ static void mptcp_retransmit_handler(struct sock *sk)
 		mptcp_stop_timer(sk);
 	} else {
 		set_bit(MPTCP_WORK_RTX, &msk->flags);
-		if (schedule_work(&msk->work))
-			sock_hold(sk);
+		mptcp_schedule_work(sk);
 	}
 }
 
@@ -2503,7 +2510,8 @@ static void mptcp_release_cb(struct sock *sk)
 		struct sock *ssk;
 
 		ssk = mptcp_subflow_recv_lookup(msk);
-		if (!ssk || !schedule_work(&msk->work))
+		if (!ssk || sk->sk_state == TCP_CLOSE ||
+		    !schedule_work(&msk->work))
 			__sock_put(sk);
 	}
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f5aeb3061408a..313c8898b3b2c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -410,6 +410,7 @@ static inline bool mptcp_is_fully_established(struct sock *sk)
 void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk);
 void mptcp_data_ready(struct sock *sk, struct sock *ssk);
 bool mptcp_finish_join(struct sock *sk);
+bool mptcp_schedule_work(struct sock *sk);
 void mptcp_data_acked(struct sock *sk);
 void mptcp_subflow_eof(struct sock *sk);
 bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool use_64bit);
-- 
2.51.0


