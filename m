Return-Path: <stable+bounces-172290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5669B30E59
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 07:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95621AE15E7
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 05:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F3427B329;
	Fri, 22 Aug 2025 05:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="etBfN0E4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3671279DAF
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 05:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755842070; cv=none; b=oF0Wz7IMedoS2yyHM1oT9bPJ3NPPoxVWqgVbdVPiRVyU8E9xkAfXn4raHJhIUEvAnt3leyfQsGaSJc+yYE+bR4bgDu0yBuQPZCRN2F94y3TrQ6cES/6HK6yMJXqVDXBhyD7IV+so5YD0BtnBmELH+i0ROHTJ/EORVzYq/vMbtSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755842070; c=relaxed/simple;
	bh=3Q9y0xK8KgrMEr+SBvXW+32ULux2UsTwRv9TmLY871E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=M2Z5pFr7FnlEkeMxn4cyRsC+02vHxEILYocvO2Iz2RVSbTxjWtWTNTBE1ulvS8QZJl/CnHreekxdhLddPY+xOQV2V+djXRvGZG7IpaObHGUgr8IuVPpRj1Kl+HM14av1sEearUnMLcGF6qcSijpS4+Qhr20snlw57xezoHFJsT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=etBfN0E4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2867CC4CEF1;
	Fri, 22 Aug 2025 05:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755842070;
	bh=3Q9y0xK8KgrMEr+SBvXW+32ULux2UsTwRv9TmLY871E=;
	h=Subject:To:Cc:From:Date:From;
	b=etBfN0E4UU0q05eRZ9QtXnLIkjN2/XcaYbvSKQGtcNMGJ4Co88lf0nYw0TAVP5vM2
	 HWNNJhP+wQKzfQZBXvIk8utYgOsA/Ieuw0ajLOFblSXkRHIVKOEUr+2tFIK/u6YGVd
	 E/Wkflv9yDn+ISx5SUIqId2eByAsIJyVB7mPjaPA=
Subject: FAILED: patch "[PATCH] cpuidle: governors: menu: Avoid selecting states with too" failed to apply to 6.1-stable tree
To: rafael.j.wysocki@intel.com,christian.loehle@arm.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 22 Aug 2025 07:54:17 +0200
Message-ID: <2025082217-sabbath-economist-f935@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 779b1a1cb13ae17028aeddb2fbbdba97357a1e15
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082217-sabbath-economist-f935@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 779b1a1cb13ae17028aeddb2fbbdba97357a1e15 Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Wed, 13 Aug 2025 12:25:58 +0200
Subject: [PATCH] cpuidle: governors: menu: Avoid selecting states with too
 much latency

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

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 81306612a5c6..b2e3d0b0a116 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -287,20 +287,15 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
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
@@ -316,13 +311,15 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
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
@@ -354,8 +351,6 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 
 			return idx;
 		}
-		if (s->exit_latency_ns > latency_req)
-			break;
 
 		idx = i;
 	}


