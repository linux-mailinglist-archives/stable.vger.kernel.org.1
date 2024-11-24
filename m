Return-Path: <stable+bounces-95076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC52B9D72FF
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66FA01654EA
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054A520FA83;
	Sun, 24 Nov 2024 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1QIA39p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A898B20E336;
	Sun, 24 Nov 2024 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455906; cv=none; b=OjmKwCEHe2WVju9bBMg+7xjs/teCrrALWNJwCUETcRjw0QSxiPY4r6SnqeTbAXtnLmX/yraAedvmt9HdVA7L0MwAHUezkjBjq+uZUvv4NzE9vyPUBBcEQifw28P/rwB/1TS01gbUhQl96YNLyTZL3sXO4C2G0NzCyVSZ0XKVHL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455906; c=relaxed/simple;
	bh=hdqRIr8JPrP6KkBfW641DB4VEjMrTEqRrJovrjFcl6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dewr2mEDOcWgFkX9te7QYAQPS0G4m3D0nbB4hLldpi6K+EIqXImK4n8SLm3jlNxpBckV70U5Ia3ilHtfd+MS+5uVOqLgbmp3efCCFzEuWhciXVGQulD5qwlSA0ZvVftsNOebQ0yKrLODb/4y5JwXvPkRrOYzNbDunxfravKbczQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1QIA39p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A86C4CED7;
	Sun, 24 Nov 2024 13:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455906;
	bh=hdqRIr8JPrP6KkBfW641DB4VEjMrTEqRrJovrjFcl6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g1QIA39pKDF7oRsatCZpe58glhqxm1CQ/cIMrUBgSqbmg6uhHSGowRgIORtxplWvd
	 5k/v7J7THxxoKYbxMpwq0Ol1JZ/mxtGTrfPHKjD09ExKPJkYpOKY/3AyejjuQckt0g
	 TPSfSzREqjAzQwSYSrYsoZmWdymBmzejklKYGfcve3zF7u7Ka9Z0+sMb8QWKLskIFG
	 /BT/1QwiI7tQG/4VQmPIVmrBLSQ5c/DvHI8Se7vMAq5o5fEbAZ4yXBcis5XlHZAznS
	 SQwsr+aI0NPHchoLkdGFOrA8EMtVxUGQQXsgEx2L++VFP37Cmujuod1ftqA1AoQDw6
	 J2UYdBSPcr5Gg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Kandybka <d.kandybka@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	matttbe@kernel.org,
	martineau@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH AUTOSEL 6.11 73/87] mptcp: fix possible integer overflow in mptcp_reset_tout_timer
Date: Sun, 24 Nov 2024 08:38:51 -0500
Message-ID: <20241124134102.3344326-73-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Dmitry Kandybka <d.kandybka@gmail.com>

[ Upstream commit b169e76ebad22cbd055101ee5aa1a7bed0e66606 ]

In 'mptcp_reset_tout_timer', promote 'probe_timestamp' to unsigned long
to avoid possible integer overflow. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
Link: https://patch.msgid.link/20241107103657.1560536-1-d.kandybka@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7913ba6b5daa3..31a7302c02a68 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2728,8 +2728,8 @@ void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
 	if (!fail_tout && !inet_csk(sk)->icsk_mtup.probe_timestamp)
 		return;
 
-	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies +
-			mptcp_close_timeout(sk);
+	close_timeout = (unsigned long)inet_csk(sk)->icsk_mtup.probe_timestamp -
+			tcp_jiffies32 + jiffies + mptcp_close_timeout(sk);
 
 	/* the close timeout takes precedence on the fail one, and here at least one of
 	 * them is active
-- 
2.43.0


