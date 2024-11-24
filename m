Return-Path: <stable+bounces-94986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE789D71F0
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 011612840A0
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AC81E884C;
	Sun, 24 Nov 2024 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbYtD7UM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56A51E883E;
	Sun, 24 Nov 2024 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455508; cv=none; b=uufYeT10s8cEZ7VLCGtFNJH1sCi8R65M+R3MkX7e7dhUflTiRcE7kJ4wUzYpK3j0dSlPv7KmoCyuCRP+RMx+IpN/N92U75QmkT6tfTlEvSek5bk56FSStrUWcCsc8oJ52tf9y1GpKA0dNgyTSGEf+DJZzowf5Vyv2FVBSOvZGTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455508; c=relaxed/simple;
	bh=iSb+7DbzMIYQt/U5PSNHLMhXdEZt6hKvzRV2z5eiQw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxsPtyzNwiB/CFXsPkyXg1Xunc6kG2yAwDUBAtujjRo1OOHiTNxMtd34TFc7/RFAHMJkmPVosIHbNPm1fV4aes5Qz5JiRoJL5PUBid2SkQEM3Bs15QCyNxs6nc1odGjdU9063zCiR6w1NonjwriAm7bc+aGMrzM+NMrJKcYvfcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbYtD7UM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0FFC4CECC;
	Sun, 24 Nov 2024 13:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455508;
	bh=iSb+7DbzMIYQt/U5PSNHLMhXdEZt6hKvzRV2z5eiQw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YbYtD7UM38kpoIhN85REbqki55tH6WaFLI3zpEP+Q4zS65NoljTYPYwsaCgUMkien
	 Cm5Uh78gVCoJCyv26rdYKdIir1zf0DgaUXmUIWqvlldAImOoBnvJ4/zCLJ5Y8JUKE/
	 YyQpPu4RPzAjhMseGibXy3F9QyowOFPDRmazJbJMB+eX3D8D2N8aCLBK7SlbTX1x+3
	 Q2WrPX9a4EdFIqeA+mYyHJjoqtHebLDRDBQADwcj9HUZz130FgoG6KBYFo9qMMf+WU
	 LZlyEa1oUs/ouND2bL36oDf3oBYDFHH0bEXagwh8/23WDAdE4qiVhvurBf8nPrXcQk
	 Y0GpZnItcbKsw==
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
Subject: [PATCH AUTOSEL 6.12 090/107] mptcp: fix possible integer overflow in mptcp_reset_tout_timer
Date: Sun, 24 Nov 2024 08:29:50 -0500
Message-ID: <20241124133301.3341829-90-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index 47ee616f69c2d..8a8e8fee337f5 100644
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


