Return-Path: <stable+bounces-172607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFD1B32931
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 16:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566FB1BA10AE
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 14:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF9E23E346;
	Sat, 23 Aug 2025 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vfg6FIVW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13971448D5
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755959650; cv=none; b=Zj8kaQUzjrYqR1eHUK8cvrUz24it2KIdPSJdh9dFQyPEm8uUu4wWvpKRAWMGXG7x1PffRi2Fpn4bCbcMVwb0lf1KNXIaU8225wOx/oNOvmGMnIJCu4r3k+bNtsJtFDWqeZBM3zYN0RhB6nCdo9wm+QwXODKSk1117u1RzX2zX0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755959650; c=relaxed/simple;
	bh=AtrCxR9jMV0fPR8muJtIppXfk7OYrZg3QM8+XCk/2s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ReyHAxt2MmxZJcVS1u3vNLTm7pKTk4oqgF2HeuHGIx34Ulp8428lDYJBcb44I8lZ5gvi8Rx53W2AbtpsFb42srviUFc1FFfw1DccMpSq1m8PT53LIGub9PtNGFPiRndKiKHFvtjU5rFrXaUN4uwKwEF01Ty/qujmaJO5yFYJyPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vfg6FIVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC60C113CF;
	Sat, 23 Aug 2025 14:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755959649;
	bh=AtrCxR9jMV0fPR8muJtIppXfk7OYrZg3QM8+XCk/2s0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vfg6FIVWfkoyJ90/2V9V85T5BjV/qXFBVB2kyOVs/3On1+a9FCgx712MyshZ8AMVk
	 0+fVtwPAumsEAoZF5jTUSOySlr1ods/PwqHIx84GadhsRjAZu/YWeypsJB+dsx9oXR
	 LTxniHnqAiEROxfUVtXOa47NcUbTsyilsx+hPDv2tmT2oZRO8zSrGykvHdpiFHGQ1h
	 AwFDsOT13XR+njjRkNoUtwqQW2S4N+VTdjmoLIst8Jz/qaruWGiwsiB8Ficcua4U40
	 X+VdaQ/Pqm7ZTt0w4phyGvhjcmeRNWdgcufzrGiFIanJ1JVQu7U1m4ikEOlrHzXSaQ
	 ogkqMm547LuJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geliang Tang <geliang@kernel.org>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mptcp: remove duplicate sk_reset_timer call
Date: Sat, 23 Aug 2025 10:34:06 -0400
Message-ID: <20250823143406.2247894-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082230-overlay-latitude-1a75@gregkh>
References: <2025082230-overlay-latitude-1a75@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang@kernel.org>

[ Upstream commit 5d13349472ac8abcbcb94407969aa0fdc2e1f1be ]

sk_reset_timer() was called twice in mptcp_pm_alloc_anno_list.

Simplify the code by using a 'goto' statement to eliminate the
duplication.

Note that this is not a fix, but it will help backporting the following
patch. The same "Fixes" tag has been added for this reason.

Fixes: 93f323b9cccc ("mptcp: add a new sysctl add_addr_timeout")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250815-net-mptcp-misc-fixes-6-17-rc2-v1-4-521fe9957892@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ adjusted function location from pm.c to pm_netlink.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_netlink.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3391d4df2dbb..1f22c434d122 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -383,9 +383,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
 			return false;
 
-		sk_reset_timer(sk, &add_entry->add_timer,
-			       jiffies + mptcp_get_add_addr_timeout(net));
-		return true;
+		goto reset_timer;
 	}
 
 	add_entry = kmalloc(sizeof(*add_entry), GFP_ATOMIC);
@@ -399,6 +397,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry->retrans_times = 0;
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
+reset_timer:
 	sk_reset_timer(sk, &add_entry->add_timer,
 		       jiffies + mptcp_get_add_addr_timeout(net));
 
-- 
2.50.1


