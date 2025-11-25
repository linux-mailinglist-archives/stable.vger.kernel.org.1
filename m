Return-Path: <stable+bounces-196923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 089B9C86268
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 18:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 81A2334B50F
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 17:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2842D329C73;
	Tue, 25 Nov 2025 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmZHWh34"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EBE273805;
	Tue, 25 Nov 2025 17:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764090669; cv=none; b=JXMQDpAahhdfaCRFOfM/5EYXXPPIKpWwp4oAQIYtPCIUJl4xZtKwai+eHiTndDiAHtQLekTdm/hvfJHSqGHR6csrKpl5DKJ+WtQLTEASyLpfJEE6pd4WZaDHGXs5XN4JK0CIrSXzCWwCNAsDjSU18uOGkwDHRJu7GxbcLc9Fm7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764090669; c=relaxed/simple;
	bh=xZR8pJbbTDC36ucMzn1ejVJnyZlat8zJQi3cfsqTE/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ygbn2Mmn8Arm1c/bjvE7LWdJHJA7hA0jtIa32xbq/FInHN5KFfWYIKUKJeFkPRqnklqw8gLUv4OTvVHSl0Md9xKHZv9FTiccr8aSzpAIPYmDVj6hayB0qGKOsKoLi244zo5viKH8A6S5vIyD3iTTKPtLkaI+GDEIuYLB9ONEgLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmZHWh34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E85C4CEF1;
	Tue, 25 Nov 2025 17:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764090669;
	bh=xZR8pJbbTDC36ucMzn1ejVJnyZlat8zJQi3cfsqTE/Y=;
	h=From:Date:Subject:To:Cc:From;
	b=RmZHWh345UtOHdBBl2skqpaSIDD3vOfTkuKHrc3GGu+S/PZHOefZZ9aFDnhOEPF/5
	 KfOHwaFc9xV6vyRZqK09ZPKnLIaNCAnB+nZ+CLNwEhwjCGjLYaanz1lWrQhrnnXWIq
	 xIcQogKdUf0uOoYZkNA5KUiuJlc2z3MLLuDPC9H9Q4ND52fsH/+y1C5Dyi3wl3ngU0
	 D6r8HTHyBaRlk7TcH1recUlaFxFUeHiOoE4LfuZJRSJMg9v8biKwiTiHZams2W11Co
	 wisPQ08/UP1SMAUeEmEDGoEPuglhQuWcfbUu6liPCutxVkcq0jOIPefAWdu4vurgci
	 2AOaj0JdL68hA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 25 Nov 2025 17:59:11 +0100
Subject: [PATCH net] mptcp: clear scheduled subflows on retransmit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251125-net-mptcp-clear-sched-rtx-v1-1-1cea4ad2165f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAF7gJWkC/x3MQQrDIBBG4auEWXcgSiTQq4QurP5NBhojo5SA5
 O6RLt/ie40KVFDoOTRS/KTIkXqYx0Bh82kFS+xNdrTOGOs4ofKea8gcvvDKJWyIrPVkP+HtZ0z
 RwVD3WfGR8/9eqDN6XdcNiPIel3AAAAA=
X-Change-ID: 20251125-net-mptcp-clear-sched-rtx-a4eba7e4d5e1
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Filip Pokryvka <fpokryvk@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2175; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=2hBOccHTvC3Ma2AnCdnY4gSmYbZkET0gScOy1lgMpdU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJVH2tx7+2+kDdB/rDzuUJnn3UB871CJ53mZp763vUwn
 /TVR32zOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZip87wv7CKcZsJf8kC9/K9
 E34dVys5mHNv2ubG/d78guGcpUrvhBkZZh53vi63+WBUhEvWpflPNLQazmho2kQd7juWq/qNccp
 8RgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

When __mptcp_retrans() kicks-in, it schedules one or more subflows for
retransmission, but such subflows could be actually left alone if there
is no more data to retransmit and/or in case of concurrent fallback.

Scheduled subflows could be processed much later in time, i.e. when new
data will be transmitted, leading to bad subflow selection.

Explicitly clear all scheduled subflows before leaving the
retransmission function.

Fixes: ee2708aedad0 ("mptcp: use get_retrans wrapper")
Cc: stable@vger.kernel.org
Reported-by: Filip Pokryvka <fpokryvk@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 33b5dce431c2..8abb425d8b5f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2665,7 +2665,7 @@ static void __mptcp_retrans(struct sock *sk)
 		}
 
 		if (!mptcp_send_head(sk))
-			return;
+			goto clear_scheduled;
 
 		goto reset_timer;
 	}
@@ -2696,7 +2696,7 @@ static void __mptcp_retrans(struct sock *sk)
 			if (__mptcp_check_fallback(msk)) {
 				spin_unlock_bh(&msk->fallback_lock);
 				release_sock(ssk);
-				return;
+				goto clear_scheduled;
 			}
 
 			while (info.sent < info.limit) {
@@ -2728,6 +2728,15 @@ static void __mptcp_retrans(struct sock *sk)
 
 	if (!mptcp_rtx_timer_pending(sk))
 		mptcp_reset_rtx_timer(sk);
+
+clear_scheduled:
+	/* If no rtx data was available or in case of fallback, there
+	 * could be left-over scheduled subflows; clear them all
+	 * or later xmit could use bad ones
+	 */
+	mptcp_for_each_subflow(msk, subflow)
+		if (READ_ONCE(subflow->scheduled))
+			mptcp_subflow_set_scheduled(subflow, false);
 }
 
 /* schedule the timeout timer for the relevant event: either close timeout

---
base-commit: 4fe5a00ec70717a7f1002d8913ec6143582b3c8e
change-id: 20251125-net-mptcp-clear-sched-rtx-a4eba7e4d5e1

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


