Return-Path: <stable+bounces-204484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA89CEED85
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 16:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1F7330010D1
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 15:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C4925D1E9;
	Fri,  2 Jan 2026 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5dYrabS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C1F25B31D
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767367176; cv=none; b=jzFu5M9xm1rHiZxgJSAYvjOkR+TxOkim3UC1lfauMToOUm2CJg4eY22IofzVd4V4TJ6oxiPRaO88JDt5fVR3fvttdcOUx48LnTAn+yssEbMRKAzX9jxR9Mp7mvbMO/SLweIEwk1dnIlAmdOqlrmonOOOKkLTRSM0LhPyQ1Glewk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767367176; c=relaxed/simple;
	bh=dxPUpFrRnY+gzV+DKENswezMf6LvtnRaiflLkua/dRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dVNl4v0iZupJFM533dNzdIp55e5H3blNMIb2bhpBNsymHaDMWRPkqF00vya4cTq0Z5727jXb2wGZpt9jb481J+Lihtt1z3lTUN5rV1Y6UbpSWdxCX+glH3qHOHM187S8GO/PkOvDYN77WwRTAd6QzDvuryYy47k/rit1jS9iN/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5dYrabS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CF0C116B1;
	Fri,  2 Jan 2026 15:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767367176;
	bh=dxPUpFrRnY+gzV+DKENswezMf6LvtnRaiflLkua/dRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J5dYrabS9VN8FDYAp6zeSVmX7N3NklcLR/lG++Uv8RGlcdrtssLaP3Ul0Vp8dFIb4
	 gZ9t4CscW+umezie9iaJ2Cgyq0YIKNeCuwy6goWvx8sduhJRDD40oHetmG10bNLHG8
	 ZK/LrlD2mhqgTepL3be/XzyOEzYtMSdLXm8V868VPFQqJHBJrmC0TIzjhUC+hioBxw
	 aPs9s+6s4Np8n4vPDdVIqtn+ML8pM77cJJpDh0T18G8afI10ELz7jcZ3TaAGKkgHpa
	 xHrIazQrLHpStHi8Y4O/5R4G+Jg6o2dSJh7503uwtUeWQ8Swhgwux6cIrXJX4ixGVz
	 MxWHJqeig35Bw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fernand Sieber <sieberf@amazon.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] sched/fair: Forfeit vruntime on yield
Date: Fri,  2 Jan 2026 10:19:29 -0500
Message-ID: <20260102151931.300967-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122903-sterile-from-4520@gregkh>
References: <2025122903-sterile-from-4520@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fernand Sieber <sieberf@amazon.com>

[ Upstream commit 79104becf42baeeb4a3f2b106f954b9fc7c10a3c ]

If a task yields, the scheduler may decide to pick it again. The task in
turn may decide to yield immediately or shortly after, leading to a tight
loop of yields.

If there's another runnable task as this point, the deadline will be
increased by the slice at each loop. This can cause the deadline to runaway
pretty quickly, and subsequent elevated run delays later on as the task
doesn't get picked again. The reason the scheduler can pick the same task
again and again despite its deadline increasing is because it may be the
only eligible task at that point.

Fix this by making the task forfeiting its remaining vruntime and pushing
the deadline one slice ahead. This implements yield behavior more
authentically.

We limit the forfeiting to eligible tasks. This is because core scheduling
prefers running ineligible tasks rather than force idling. As such, without
the condition, we can end up on a yield loop which makes the vruntime
increase rapidly, leading to anomalous run delays later down the line.

Fixes: 147f3efaa24182 ("sched/fair: Implement an EEVDF-like scheduling  policy")
Signed-off-by: Fernand Sieber <sieberf@amazon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250401123622.584018-1-sieberf@amazon.com
Link: https://lore.kernel.org/r/20250911095113.203439-1-sieberf@amazon.com
Link: https://lore.kernel.org/r/20250916140228.452231-1-sieberf@amazon.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/fair.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7f23b866c3d4..cf3a51f323e3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8614,7 +8614,19 @@ static void yield_task_fair(struct rq *rq)
 	 */
 	rq_clock_skip_update(rq);
 
-	se->deadline += calc_delta_fair(se->slice, se);
+	/*
+	 * Forfeit the remaining vruntime, only if the entity is eligible. This
+	 * condition is necessary because in core scheduling we prefer to run
+	 * ineligible tasks rather than force idling. If this happens we may
+	 * end up in a loop where the core scheduler picks the yielding task,
+	 * which yields immediately again; without the condition the vruntime
+	 * ends up quickly running away.
+	 */
+	if (entity_eligible(cfs_rq, se)) {
+		se->vruntime = se->deadline;
+		se->deadline += calc_delta_fair(se->slice, se);
+		update_min_vruntime(cfs_rq);
+	}
 }
 
 static bool yield_to_task_fair(struct rq *rq, struct task_struct *p)
-- 
2.51.0


