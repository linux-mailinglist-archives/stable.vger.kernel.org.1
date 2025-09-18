Return-Path: <stable+bounces-173642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F66DB35E4D
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B195F560294
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC3329C339;
	Tue, 26 Aug 2025 11:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ap+DbNq1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233A429D292;
	Tue, 26 Aug 2025 11:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208778; cv=none; b=o32FXiso7V5GSixx3YjhBMPXfpMTgWkh3uAmWRTJcxy+l+FtG4hgQOpMAvq0A9Y8iXpBGUsg0Cg0A+GOnHW7oIGNJDxny0JKbpwD8FphZRB9mATk/d1ebd9MfWLEC7vsHcabL0KEjVFTuBpf60PaXttMbPeS4X5a9iAMKnTi21Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208778; c=relaxed/simple;
	bh=t9rhrH2WLS/rFOz+XxZ1UX143euaxLyvyiWhqaumU3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKblx0Joe5Oy4nVudRJgjFhgYwvBqcWm0VYKIlG+XNe9hrBoLMzTR/KtKz1DOoSF0kflFNGCm0LrshkbPzvDWqb/g4kahlenGzaia37YcguRd8xaKkfw6QbIIrVmRVGPM8Hoazx7C6kvm2fr8IlW1gw0lLprtEQIiTTGzsgNwgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ap+DbNq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B680C116B1;
	Tue, 26 Aug 2025 11:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208778;
	bh=t9rhrH2WLS/rFOz+XxZ1UX143euaxLyvyiWhqaumU3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ap+DbNq1Pnf1SmnHm7KcwFWNtUeSGTGhY/6gWsdPK4j5fqVk9v/43QOXi5Ki5+0LX
	 fbpdpyD8zuDatZ+S445OUrGV/K6zdtdmvgkJd6s/6g6toL1FNJMSa+TGYg4vUh7xac
	 UWyEy+xbElVK7Wb9nt8n+p2m+1hp8HjyQn9FrMI8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Loehle <christian.loehle@arm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 210/322] cpuidle: menu: Remove iowait influence
Date: Tue, 26 Aug 2025 13:10:25 +0200
Message-ID: <20250826110921.053871312@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
References: <20250826110915.169062587@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Loehle <christian.loehle@arm.com>

[ Upstream commit 38f83090f515b4b5d59382dfada1e7457f19aa47 ]

Remove CPU iowaiters influence on idle state selection.

Remove the menu notion of performance multiplier which increased with
the number of tasks that went to iowait sleep on this CPU and haven't
woken up yet.

Relying on iowait for cpuidle is problematic for a few reasons:

 1. There is no guarantee that an iowaiting task will wake up on the
    same CPU.

 2. The task being in iowait says nothing about the idle duration, we
    could be selecting shallower states for a long time.

 3. The task being in iowait doesn't always imply a performance hit
    with increased latency.

 4. If there is such a performance hit, the number of iowaiting tasks
    doesn't directly correlate.

 5. The definition of iowait altogether is vague at best, it is
    sprinkled across kernel code.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/20240905092645.2885200-2-christian.loehle@arm.com
[ rjw: Minor edits in the changelog ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 779b1a1cb13a ("cpuidle: governors: menu: Avoid selecting states with too much latency")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpuidle/governors/menu.c |   76 ++++-----------------------------------
 1 file changed, 9 insertions(+), 67 deletions(-)

--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -19,7 +19,7 @@
 
 #include "gov.h"
 
-#define BUCKETS 12
+#define BUCKETS 6
 #define INTERVAL_SHIFT 3
 #define INTERVALS (1UL << INTERVAL_SHIFT)
 #define RESOLUTION 1024
@@ -29,12 +29,11 @@
 /*
  * Concepts and ideas behind the menu governor
  *
- * For the menu governor, there are 3 decision factors for picking a C
+ * For the menu governor, there are 2 decision factors for picking a C
  * state:
  * 1) Energy break even point
- * 2) Performance impact
- * 3) Latency tolerance (from pmqos infrastructure)
- * These three factors are treated independently.
+ * 2) Latency tolerance (from pmqos infrastructure)
+ * These two factors are treated independently.
  *
  * Energy break even point
  * -----------------------
@@ -75,30 +74,6 @@
  * intervals and if the stand deviation of these 8 intervals is below a
  * threshold value, we use the average of these intervals as prediction.
  *
- * Limiting Performance Impact
- * ---------------------------
- * C states, especially those with large exit latencies, can have a real
- * noticeable impact on workloads, which is not acceptable for most sysadmins,
- * and in addition, less performance has a power price of its own.
- *
- * As a general rule of thumb, menu assumes that the following heuristic
- * holds:
- *     The busier the system, the less impact of C states is acceptable
- *
- * This rule-of-thumb is implemented using a performance-multiplier:
- * If the exit latency times the performance multiplier is longer than
- * the predicted duration, the C state is not considered a candidate
- * for selection due to a too high performance impact. So the higher
- * this multiplier is, the longer we need to be idle to pick a deep C
- * state, and thus the less likely a busy CPU will hit such a deep
- * C state.
- *
- * Currently there is only one value determining the factor:
- * 10 points are added for each process that is waiting for IO on this CPU.
- * (This value was experimentally determined.)
- * Utilization is no longer a factor as it was shown that it never contributed
- * significantly to the performance multiplier in the first place.
- *
  */
 
 struct menu_device {
@@ -112,19 +87,10 @@ struct menu_device {
 	int		interval_ptr;
 };
 
-static inline int which_bucket(u64 duration_ns, unsigned int nr_iowaiters)
+static inline int which_bucket(u64 duration_ns)
 {
 	int bucket = 0;
 
-	/*
-	 * We keep two groups of stats; one with no
-	 * IO pending, one without.
-	 * This allows us to calculate
-	 * E(duration)|iowait
-	 */
-	if (nr_iowaiters)
-		bucket = BUCKETS/2;
-
 	if (duration_ns < 10ULL * NSEC_PER_USEC)
 		return bucket;
 	if (duration_ns < 100ULL * NSEC_PER_USEC)
@@ -138,19 +104,6 @@ static inline int which_bucket(u64 durat
 	return bucket + 5;
 }
 
-/*
- * Return a multiplier for the exit latency that is intended
- * to take performance requirements into account.
- * The more performance critical we estimate the system
- * to be, the higher this multiplier, and thus the higher
- * the barrier to go to an expensive C state.
- */
-static inline int performance_multiplier(unsigned int nr_iowaiters)
-{
-	/* for IO wait tasks (per cpu!) we add 10x each */
-	return 1 + 10 * nr_iowaiters;
-}
-
 static DEFINE_PER_CPU(struct menu_device, menu_devices);
 
 static void menu_update_intervals(struct menu_device *data, unsigned int interval_us)
@@ -277,8 +230,6 @@ static int menu_select(struct cpuidle_dr
 	struct menu_device *data = this_cpu_ptr(&menu_devices);
 	s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
 	u64 predicted_ns;
-	u64 interactivity_req;
-	unsigned int nr_iowaiters;
 	ktime_t delta, delta_tick;
 	int i, idx;
 
@@ -295,8 +246,6 @@ static int menu_select(struct cpuidle_dr
 		menu_update_intervals(data, UINT_MAX);
 	}
 
-	nr_iowaiters = nr_iowait_cpu(dev->cpu);
-
 	/* Find the shortest expected idle interval. */
 	predicted_ns = get_typical_interval(data) * NSEC_PER_USEC;
 	if (predicted_ns > RESIDENCY_THRESHOLD_NS) {
@@ -310,7 +259,7 @@ static int menu_select(struct cpuidle_dr
 		}
 
 		data->next_timer_ns = delta;
-		data->bucket = which_bucket(data->next_timer_ns, nr_iowaiters);
+		data->bucket = which_bucket(data->next_timer_ns);
 
 		/* Round up the result for half microseconds. */
 		timer_us = div_u64((RESOLUTION * DECAY * NSEC_PER_USEC) / 2 +
@@ -328,7 +277,7 @@ static int menu_select(struct cpuidle_dr
 		 */
 		data->next_timer_ns = KTIME_MAX;
 		delta_tick = TICK_NSEC / 2;
-		data->bucket = which_bucket(KTIME_MAX, nr_iowaiters);
+		data->bucket = which_bucket(KTIME_MAX);
 	}
 
 	if (unlikely(drv->state_count <= 1 || latency_req == 0) ||
@@ -355,15 +304,8 @@ static int menu_select(struct cpuidle_dr
 		 */
 		if (predicted_ns < TICK_NSEC)
 			predicted_ns = data->next_timer_ns;
-	} else {
-		/*
-		 * Use the performance multiplier and the user-configurable
-		 * latency_req to determine the maximum exit latency.
-		 */
-		interactivity_req = div64_u64(predicted_ns,
-					      performance_multiplier(nr_iowaiters));
-		if (latency_req > interactivity_req)
-			latency_req = interactivity_req;
+	} else if (latency_req > predicted_ns) {
+		latency_req = predicted_ns;
 	}
 
 	/*



