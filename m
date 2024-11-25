Return-Path: <stable+bounces-95384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF529D8750
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 15:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D0F286804
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 14:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004CE1ADFFE;
	Mon, 25 Nov 2024 14:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMocElN1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D76B1AF0D1;
	Mon, 25 Nov 2024 14:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543534; cv=none; b=E2E5ruFG4G3NK65xGGIDnd0t8ebxh+R+O0lN6JKJTn9Cwp48hYw0jGXMZlfGK/s4JXFXLAjWWk529p8M4a/9Y4cvcP4JlVND/t8A80X7OF0bw3sLVteFslmYsRKm9uXjMAOJzTftr5jAEg0KiM7mYh5lh7QE8iS7aEiGEoSn69s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543534; c=relaxed/simple;
	bh=rekKS20wKYZQv5jnHd9JBUpdP5nqIwQWLlwpTWz8S9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FXFIE3PB118wJC3vEMfsHQg5FxuG7L/N/W/OPjQ03KcXVwUBBNTPpUd5apjrd9HGeyuhXEBt3AXwyoZaDiNT02zsG+nDoEa8DztXjyZCn4n19+gYC7YumbF+PdSWar+y5R1+z8y54GHDxFPMFvMiTtlw+zcwUREFjMzkWCGMdxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMocElN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D07AC4CED2;
	Mon, 25 Nov 2024 14:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543534;
	bh=rekKS20wKYZQv5jnHd9JBUpdP5nqIwQWLlwpTWz8S9Q=;
	h=From:To:Cc:Subject:Date:From;
	b=eMocElN1WfeP7p0cmuMCAHrGYKzXeq2PrMweso6A2x3e8rQYkxp10DJoL9R0dfUKG
	 9Xk5JPgkg2CUvt7ivVWQMc86G7D3oSM7Xh7bQY4tDY4FAZFTqvjHlpX+Lk8xgG+Coe
	 ky02pIjH2BDE5/Z0hqDAQWFcE6+T026tUvrYprtwiODx3KjUa3PMWxUF+b7WOj9k/n
	 B9M8m6p48SS9EGAxzD5y2dI+UHuzjdYgw1i5rxorvT7ljr8y/CuzfXJPxDfkycVTTA
	 Ohh1fAVioGt+01G8yw429i4rUs8vaXynx3385pOG49iuRlprEVwhj0BtTrgur/ArmS
	 TwT+vnsKC26Iw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: sashal@kernel.org,
	MPTCP Upstream <mptcp@lists.linux.dev>,
	Dmitry Kandybka <d.kandybka@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH 6.1.y] mptcp: fix possible integer overflow in mptcp_reset_tout_timer
Date: Mon, 25 Nov 2024 15:05:25 +0100
Message-ID: <20241125140524.3753666-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1580; i=matttbe@kernel.org; h=from:subject; bh=BtDIJuRWs9EVXovV/5nIlNAIAuJ/j1AjXsWcGrgusME=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnRIQlcrez1wYIc1NbZh8yXCBaf55nBKGqhS/Yz ItYbP0re/mJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ0SEJQAKCRD2t4JPQmmg cwdPEAC7wpMgtwCWwWCzH7peqKqaW98Mel6QO0308GchGgPupu2BVHrbgumUbdf613xvCD2/Rdt czxTRxaLNHKTz/0iMd2iDWPRUjietVykd2XMw0ubjwmymymXSynbgIAa4gYaoqH2e+88l71vv4q Q4QI+zjXgIPT4a1SGigxgRR1h7oktaavXlDobJOcAAqmgpc/VYxkXl7QAiJ1Xsb2JU3AtInKPHK s/z7Qf1l0hQ1Fq0+nbYVAdpc23zZTxFCTQayakwm49oZhhbdl1S7wMgJyfKF42WyQjL1CFUbhXA J8w7+yNTrwepRaOYDuA1JW69UKMhTKxpm1RlJ9N65Ny9ZHGKTR7cJFohHYe3ZmQlhfSc3HOi7MG zxVimVTkKST4NwOBx8pLb3tHJCGw8TWhG8y6yc/ap65VX/5rQxDyIIpe/4d/wL8goJeXw76Sq3K nUrBq5gHmHqUwcltWHOAh2xiOh2lmaaQdAErG0Zfxhq1ZfhStBxHtrMtLt6Np4ZOdpchIjTouIK Eap9yb/pKS1nzLdpQnb2Ex2xSSAlcr9lcQTaX7vmNTMdCWdoG0kolkctCyHjO/HKNR3NMkosA06 Ba5mYFNgKM5WNoUCZsLh6sTSuhTCWZELyGckiiaeHFa2SvQLf/nqocgYg5hERR96/tvXBrYTGou V8T+byEH9DpnyOQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Dmitry Kandybka <d.kandybka@gmail.com>

commit b169e76ebad22cbd055101ee5aa1a7bed0e66606 upstream.

In 'mptcp_reset_tout_timer', promote 'probe_timestamp' to unsigned long
to avoid possible integer overflow. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
Link: https://patch.msgid.link/20241107103657.1560536-1-d.kandybka@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflict in this version because commit d866ae9aaa43 ("mptcp: add a
  new sysctl for make after break timeout") is not in this version, and
  replaced TCP_TIMEWAIT_LEN in the expression. The fix can still be
  applied the same way: by forcing a cast to unsigned long for the first
  item. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1acd4e37a0ea..370afcac2623 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2708,8 +2708,8 @@ void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
 	if (!fail_tout && !inet_csk(sk)->icsk_mtup.probe_timestamp)
 		return;
 
-	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies +
-			TCP_TIMEWAIT_LEN;
+	close_timeout = (unsigned long)inet_csk(sk)->icsk_mtup.probe_timestamp -
+			tcp_jiffies32 + jiffies + TCP_TIMEWAIT_LEN;
 
 	/* the close timeout takes precedence on the fail one, and here at least one of
 	 * them is active
-- 
2.45.2


