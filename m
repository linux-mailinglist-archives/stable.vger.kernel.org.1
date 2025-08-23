Return-Path: <stable+bounces-172593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94129B328D0
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 15:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014D4189472D
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 13:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9041E7C18;
	Sat, 23 Aug 2025 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKgHh66U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D974393DF6
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755956092; cv=none; b=fba66LqvFzkNmWS9xTPE04ZwDKGk4red1agl1UFZIQjsgcOLD1GYekHPy+oEOeswFuL9K4twcTo1Cp5HSDzV64WQvEUgujlPNMbMTdyjgKVGkypqgLQMgLkorGDkYVchInufshCHCqmsoWLle8JOMcqZq2nVZGuJ/l8VyaPY8PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755956092; c=relaxed/simple;
	bh=A+towh5SLzUTLR3+K1r+1gI/eSkDNc2xzaLBlMCibcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnZEtCz7BcGN9XMbwZY0xAX1cLiLAi6i7zaS+SdQ0nCe2mDp1oAeVJk6AqRz6yQFehT0Uyspurc44lC2seMrZJnehd4xMinHIe8NyJ8cnJRbose2Zrku2J2oObtLuymD5t4T/dMEUh2fbpOo6vd7cuOMdiU+CpgmCEqoduVSA+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKgHh66U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564ADC4CEF4;
	Sat, 23 Aug 2025 13:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755956091;
	bh=A+towh5SLzUTLR3+K1r+1gI/eSkDNc2xzaLBlMCibcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CKgHh66UdTQGFeae8JBeR4i3qBsDoBj03H0JN2ZvjSi8hdxa0m5FtQ61nK9CEaOrx
	 rL6fiOp+jOUJbMMQiNI2dGFYj5ixxiGNiiXmnqYW1GXIIIMSzqBppY1cDty14jehhe
	 /4Bw6l0/s3NPNwlYHDssyrrLEsldanaX4Yxkd3KFNtcNl22znovjSx+oGFNSFfdbMM
	 ZphJeNrRMcAu7f3W8vCpKnnWZ3Z1r5a73Bc/tm1aqBfNbU5iEVYOA2kLa3TucOqA0Y
	 J+0WMia6puQch6h7XCXgi8lXBWAeuOGp4E88HzPDYYmm6sxM22Qoky6ahcGY+zqNpg
	 oEqAsylMW7+0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Loehle <christian.loehle@arm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] cpuidle: menu: Remove iowait influence
Date: Sat, 23 Aug 2025 09:34:48 -0400
Message-ID: <20250823133449.2131644-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082216-despair-postnasal-6dbe@gregkh>
References: <2025082216-despair-postnasal-6dbe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/cpuidle/governors/menu.c | 52 ++++++--------------------------
 1 file changed, 9 insertions(+), 43 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index edd9a8fb9878..26f0a067e5e5 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -21,7 +21,7 @@
 
 #include "gov.h"
 
-#define BUCKETS 12
+#define BUCKETS 6
 #define INTERVAL_SHIFT 3
 #define INTERVALS (1UL << INTERVAL_SHIFT)
 #define RESOLUTION 1024
@@ -31,12 +31,11 @@
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
@@ -119,19 +118,10 @@ struct menu_device {
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
@@ -145,19 +135,6 @@ static inline int which_bucket(u64 duration_ns, unsigned int nr_iowaiters)
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
 
 static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev);
@@ -276,8 +253,6 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	struct menu_device *data = this_cpu_ptr(&menu_devices);
 	s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
 	u64 predicted_ns;
-	u64 interactivity_req;
-	unsigned int nr_iowaiters;
 	ktime_t delta, delta_tick;
 	int i, idx;
 
@@ -286,8 +261,6 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		data->needs_update = 0;
 	}
 
-	nr_iowaiters = nr_iowait_cpu(dev->cpu);
-
 	/* Find the shortest expected idle interval. */
 	predicted_ns = get_typical_interval(data) * NSEC_PER_USEC;
 	if (predicted_ns > RESIDENCY_THRESHOLD_NS) {
@@ -301,7 +274,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		}
 
 		data->next_timer_ns = delta;
-		data->bucket = which_bucket(data->next_timer_ns, nr_iowaiters);
+		data->bucket = which_bucket(data->next_timer_ns);
 
 		/* Round up the result for half microseconds. */
 		timer_us = div_u64((RESOLUTION * DECAY * NSEC_PER_USEC) / 2 +
@@ -319,7 +292,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		 */
 		data->next_timer_ns = KTIME_MAX;
 		delta_tick = TICK_NSEC / 2;
-		data->bucket = which_bucket(KTIME_MAX, nr_iowaiters);
+		data->bucket = which_bucket(KTIME_MAX);
 	}
 
 	if (unlikely(drv->state_count <= 1 || latency_req == 0) ||
@@ -346,15 +319,8 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
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
-- 
2.50.1


