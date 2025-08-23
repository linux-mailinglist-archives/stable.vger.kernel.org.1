Return-Path: <stable+bounces-172592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1670EB328C6
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 15:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D08F57BA31F
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 13:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A0D255E23;
	Sat, 23 Aug 2025 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSGuA5UX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF3023F41F
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 13:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755955428; cv=none; b=Lp8j1TAQ/aTjtf+zXMiUoKorDl0boKWhb1LEy75cj2S1H68+ERzQAKgz3NImL38ZdDwOoJr3xZ4jDuZosszenr8wzL9PpNPN2d4wXcXbx+SUvnRyksvAp9jblgaAzV44nZsddmVp01BKL+UVbHDcrgvJUvfHPTcsyq4Y0HlCsLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755955428; c=relaxed/simple;
	bh=9SgWVAauOzzYZ2brV2lwYHP37gvv1lAqelP4+TcU7B4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOXcWpIzgE6pn8cOwKbyB1xTXzrlN86l3Qq05Vh6T3AfHUp1dj9nJBEIsDALy8z2yhVbHmvFs5bX6QxncxrRe6RP0Uj9B82g9xMq/NYTNkh7zukq8V1lYrASVie2tgPaRDXdjcUTu5IFxAEuoUT8/IzieiWruygapYyRaaZTDE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSGuA5UX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467ACC4CEF4;
	Sat, 23 Aug 2025 13:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755955427;
	bh=9SgWVAauOzzYZ2brV2lwYHP37gvv1lAqelP4+TcU7B4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KSGuA5UXDlbz7Dg9Dq7Y0pKdMCDqvRFNHHDZ2cRJuAczgYE+0JF/Chn9kLSCoy918
	 7JUDPaD/+PnWSmUui7mEHoRx0O4/iYTxuyDuOZ5abAl7Cyl0up0eSyCqw2awveJAJ3
	 I+j3XoRGhIulDuoe35XuKGXMuE1hAuNRF7uqI2R4MxxsLsCzlGaKntiNfu2fDAVQDO
	 XvE91j4gSeLqTMJmvoSU1M8xJ1M/0j4KG7VzL6ieJPwSJwYd+tgPlucR4B5uwH7+jw
	 Mqgq7r/BdxqPiCXEz9prRm16YbY0eQ0cvHUQDlWWH+6QI6iJZwJYkij2v9iDkwOoo2
	 E16FYrVGwi6lA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] cpuidle: governors: menu: Avoid selecting states with too much latency
Date: Sat, 23 Aug 2025 09:23:44 -0400
Message-ID: <20250823132344.2122561-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823132344.2122561-1-sashal@kernel.org>
References: <2025082214-daughter-popsicle-4c08@gregkh>
 <20250823132344.2122561-1-sashal@kernel.org>
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
index f07f76ccfc5e..3eb543b1644d 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -293,20 +293,15 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
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
@@ -322,13 +317,15 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
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
@@ -360,8 +357,6 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 
 			return idx;
 		}
-		if (s->exit_latency_ns > latency_req)
-			break;
 
 		idx = i;
 	}
-- 
2.50.1


