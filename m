Return-Path: <stable+bounces-95421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BCA9D89F9
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 17:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B007164174
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 16:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84141B4130;
	Mon, 25 Nov 2024 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zs02fFfA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AEE2500D2
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732551055; cv=none; b=Qk+04q7qPKw9+zfjI+BiwzsOWawHoSN49tWRUm6tdAR2CBRNL0sWpEGxCKtFZdbr+R/hE/ZTzp+6GYHTk8rFglifrQuQv4E2wqMV1Uw0IuONdmMt33dcm3ldOUmDszwgHQMBg6TOnD6nt66jfJAp90Ej0aYOJskZF7zadlIT6qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732551055; c=relaxed/simple;
	bh=Vxi83iHqOqVWlF+f1zlIjo4tegAaBpywBBhPN2e0NJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJzUUmWl5ZOK3GirQgaW/ePgwEQZO2qhQCioHIZq/RwLiLv+1KYAMCBf2L9kxscT7X2rUrREfDCmkc/V0SKTjIkwhSToJuKvSVMfqq6YVJCizjUE2hXba60O14TE8XfxVuKywQcTWBL+ctFaillva/PB2TPXKRIpAtYfbzwLu4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zs02fFfA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9CC3C4CECE;
	Mon, 25 Nov 2024 16:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732551055;
	bh=Vxi83iHqOqVWlF+f1zlIjo4tegAaBpywBBhPN2e0NJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zs02fFfAJ+5lGeqCWjkShN27NCd45EcQQPbBCguXQxhndU1Jjxxk+hrey2x/iHW8k
	 3kD87rHwFr5Ci087oQm9kowL2+5a8Jldq70fd8m68KrlQaSMpFlpvzVp+Pgtdp/gy8
	 mORapmygcUH7dNL63ERSOcjAyzIcdrGduB77837E5ELsL6efqNi0SuZ0/ZgGaoqbz/
	 HhCxyP3lcXb+4szZR+G8y+RptFIXb7FohWAKMMub7UHsyzAZfH1OW2UIVcf7/SOy7B
	 PB78gtKmCNQslIhoJQHwUR21ALTpzsNaXJIlEkWHhSKSj1M+UPzXnHdD4Jg61TNjC3
	 G/TqAxnZfApIw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] mptcp: fix possible integer overflow in mptcp_reset_tout_timer
Date: Mon, 25 Nov 2024 11:10:53 -0500
Message-ID: <20241125104511-a5df769e18ed4c0d@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241125140524.3753666-2-matttbe@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: b169e76ebad22cbd055101ee5aa1a7bed0e66606

WARNING: Author mismatch between patch and upstream commit:
Backport author: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Commit author: Dmitry Kandybka <d.kandybka@gmail.com>


Status in newer kernel trees:
6.12.y | Not found
6.11.y | Not found
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-25 10:40:34.024304989 -0500
+++ /tmp/tmp.AFQFGr6Xvw	2024-11-25 10:40:34.014755112 -0500
@@ -1,3 +1,5 @@
+commit b169e76ebad22cbd055101ee5aa1a7bed0e66606 upstream.
+
 In 'mptcp_reset_tout_timer', promote 'probe_timestamp' to unsigned long
 to avoid possible integer overflow. Compile tested only.
 
@@ -6,22 +8,31 @@
 Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
 Link: https://patch.msgid.link/20241107103657.1560536-1-d.kandybka@gmail.com
 Signed-off-by: Jakub Kicinski <kuba@kernel.org>
+[ Conflict in this version because commit d866ae9aaa43 ("mptcp: add a
+  new sysctl for make after break timeout") is not in this version, and
+  replaced TCP_TIMEWAIT_LEN in the expression. The fix can still be
+  applied the same way: by forcing a cast to unsigned long for the first
+  item. ]
+Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
 ---
  net/mptcp/protocol.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)
 
 diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
-index b0e9a745ea621..a6f2a25edb119 100644
+index 1acd4e37a0ea..370afcac2623 100644
 --- a/net/mptcp/protocol.c
 +++ b/net/mptcp/protocol.c
-@@ -2722,8 +2722,8 @@ void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
+@@ -2708,8 +2708,8 @@ void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
  	if (!fail_tout && !inet_csk(sk)->icsk_mtup.probe_timestamp)
  		return;
  
 -	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies +
--			mptcp_close_timeout(sk);
+-			TCP_TIMEWAIT_LEN;
 +	close_timeout = (unsigned long)inet_csk(sk)->icsk_mtup.probe_timestamp -
-+			tcp_jiffies32 + jiffies + mptcp_close_timeout(sk);
++			tcp_jiffies32 + jiffies + TCP_TIMEWAIT_LEN;
  
  	/* the close timeout takes precedence on the fail one, and here at least one of
  	 * them is active
+-- 
+2.45.2
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

