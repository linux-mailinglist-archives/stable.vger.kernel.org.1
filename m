Return-Path: <stable+bounces-172594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DC1B328CF
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 15:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60E387B522A
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 13:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2482D23504D;
	Sat, 23 Aug 2025 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTGDUyKA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ED4393DF6
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755956092; cv=none; b=h6I7hPFblOxWZQrsBvq7nZna2mFETiAodZ1D89/QQ8uUv+hV8WolTcia35O6jLQH5TbpNwu6iVlk25OfF6XkHq9kN8cgPUPROQoWUVKflE2Xt1SPT/agXvqZ5g7ASnXSzIso+Ge9k3W8TumoR7TtlskLmfbaS6ily5xbphUwumQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755956092; c=relaxed/simple;
	bh=Uy2gSRdFngmoo+Y5Mh/11d/lQw04gb06tmsDtB3Og8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5wIyaf0zEWGAW8DWRGh1IUUwt87lHl/DdrcOkA4pfNhvwPQ5zCzhkypS9N7ryBSR8xiAN6dBHhgeLQxNKSCnOpYSZp8JxMcu+p43QA/wD3wj9bA5gJBIvsSJ6qQAbF4rzXz/involcYKgyoQq6OG8kfc0CnGzK9Ra7cZwK+bhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTGDUyKA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1842AC116B1;
	Sat, 23 Aug 2025 13:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755956092;
	bh=Uy2gSRdFngmoo+Y5Mh/11d/lQw04gb06tmsDtB3Og8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mTGDUyKAa4K6EVpjJu+ogzTQXffxE1QL1OKL0V1rvS7G6ttwjhv7RE5/u8nSqrN6S
	 gELBOtYwGpZRrMw/sLtYizNNJzQjTzBqYZ2BCIA8VSUf+bVOWOSBUMkoL+lg8aIeVc
	 qfI0ZiEOC3CO2W+rpYNbe2/s4LrVS9hvwscBZbJXzoT8wJTfLVPlokaFfIF4N3W3aI
	 kJI9x02QABnS/IExI+yiZjhoFWub2iV3QSWaPMooE3m04UuNkAJX0dpnWJpA+enpes
	 PCT+AWVoY4uieYwfUb9AZMTf9l+S0hyTILG7FVkGK8DMJm5syScWXHeVuyDwVolzzR
	 wkHq4TMcqEq3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] cpuidle: governors: menu: Avoid selecting states with too much latency
Date: Sat, 23 Aug 2025 09:34:49 -0400
Message-ID: <20250823133449.2131644-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823133449.2131644-1-sashal@kernel.org>
References: <2025082216-despair-postnasal-6dbe@gregkh>
 <20250823133449.2131644-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 779b1a1cb13ae17028aeddb2fbbdba97357a1e15 ]

Occasionally, the exit latency of the idle state selected by the menu
governor may exceed the PM QoS CPU wakeup latency limit.  Namely, if the
scheduler tick has been stopped already and predicted_ns is greater than
the tick period length, the governor may return an idle state whose exit
latency exceeds latency_req because that decision is made before
checking the current idle state's exit latency.

For instance, say that there are 3 idle states, 0, 1, and 2.  For idle
states 0 and 1, the exit latency is equal to the target residency and
the values are 0 and 5 us, respectively.  State 2 is deeper and has the
exit latency and target residency of 200 us and 2 ms (which is greater
than the tick period length), respectively.

Say that predicted_ns is equal to TICK_NSEC and the PM QoS latency
limit is 20 us.  After the first two iterations of the main loop in
menu_select(), idx becomes 1 and in the third iteration of it the target
residency of the current state (state 2) is greater than predicted_ns.
State 2 is not a polling one and predicted_ns is not less than TICK_NSEC,
so the check on whether or not the tick has been stopped is done.  Say
that the tick has been stopped already and there are no imminent timers
(that is, delta_tick is greater than the target residency of state 2).
In that case, idx becomes 2 and it is returned immediately, but the exit
latency of state 2 exceeds the latency limit.

Address this issue by modifying the code to compare the exit latency of
the current idle state (idle state i) with the latency limit before
comparing its target residency with predicted_ns, which allows one
more exit_latency_ns check that becomes redundant to be dropped.

However, after the above change, latency_req cannot take the predicted_ns
value any more, which takes place after commit 38f83090f515 ("cpuidle:
menu: Remove iowait influence"), because it may cause a polling state
to be returned prematurely.

In the context of the previous example say that predicted_ns is 3000 and
the PM QoS latency limit is still 20 us.  Additionally, say that idle
state 0 is a polling one.  Moving the exit_latency_ns check before the
target_residency_ns one causes the loop to terminate in the second
iteration, before the target_residency_ns check, so idle state 0 will be
returned even though previously state 1 would be returned if there were
no imminent timers.

For this reason, remove the assignment of the predicted_ns value to
latency_req from the code.

Fixes: 5ef499cd571c ("cpuidle: menu: Handle stopped tick more aggressively")
Cc: 4.17+ <stable@vger.kernel.org> # 4.17+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/5043159.31r3eYUQgx@rafael.j.wysocki
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpuidle/governors/menu.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 26f0a067e5e5..0b2bab71ee7b 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -308,20 +308,15 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		return 0;
 	}
 
-	if (tick_nohz_tick_stopped()) {
-		/*
-		 * If the tick is already stopped, the cost of possible short
-		 * idle duration misprediction is much higher, because the CPU
-		 * may be stuck in a shallow idle state for a long time as a
-		 * result of it.  In that case say we might mispredict and use
-		 * the known time till the closest timer event for the idle
-		 * state selection.
-		 */
-		if (predicted_ns < TICK_NSEC)
-			predicted_ns = data->next_timer_ns;
-	} else if (latency_req > predicted_ns) {
-		latency_req = predicted_ns;
-	}
+	/*
+	 * If the tick is already stopped, the cost of possible short idle
+	 * duration misprediction is much higher, because the CPU may be stuck
+	 * in a shallow idle state for a long time as a result of it.  In that
+	 * case, say we might mispredict and use the known time till the closest
+	 * timer event for the idle state selection.
+	 */
+	if (tick_nohz_tick_stopped() && predicted_ns < TICK_NSEC)
+		predicted_ns = data->next_timer_ns;
 
 	/*
 	 * Find the idle state with the lowest power while satisfying
@@ -337,13 +332,15 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		if (idx == -1)
 			idx = i; /* first enabled state */
 
+		if (s->exit_latency_ns > latency_req)
+			break;
+
 		if (s->target_residency_ns > predicted_ns) {
 			/*
 			 * Use a physical idle state, not busy polling, unless
 			 * a timer is going to trigger soon enough.
 			 */
 			if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
-			    s->exit_latency_ns <= latency_req &&
 			    s->target_residency_ns <= data->next_timer_ns) {
 				predicted_ns = s->target_residency_ns;
 				idx = i;
@@ -375,8 +372,6 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 
 			return idx;
 		}
-		if (s->exit_latency_ns > latency_req)
-			break;
 
 		idx = i;
 	}
-- 
2.50.1


