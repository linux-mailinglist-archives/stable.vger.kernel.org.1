Return-Path: <stable+bounces-81727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD659994907
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 305A4B26E43
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FD71DED47;
	Tue,  8 Oct 2024 12:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ENyJ0raq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68D21DE8A9;
	Tue,  8 Oct 2024 12:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389930; cv=none; b=OwiSfRbfjLd9Dj8GxRrhQKvttZmmPeFg7qczbTPLjBLD5w/RmHHqbQ755RFQDdGTUgeU2oj2BuPsvoLwb1e+UBFJuz4LWXVQGqCGwwVwSeuPEEI+Iq37zQbouDn9L0k9hmb+NBTpyMh/kbwiWbUCyviscU0GQ7h815+t2Flw78o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389930; c=relaxed/simple;
	bh=89AAJqf3JKKvt7bEWvBlvminwqPuKAONPU4BaeltjLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=leybKpUUo6MbK+YfRPGrZXHfI2F7r6XlAYKLYK+CI85Pb+9TFhBPMfT4s2hEEEHvM2K2fc7/PaT0VzwB+CYtF5VNmI6Z3cAkI/Yp4cO89QG5XP52bufdjcIUUdSrQq6Sx90VhAO0+KXw+Q+KGhvJkwRshCgkXXTMorJefPiCVl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ENyJ0raq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F80C4CEC7;
	Tue,  8 Oct 2024 12:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728389930;
	bh=89AAJqf3JKKvt7bEWvBlvminwqPuKAONPU4BaeltjLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ENyJ0raqrA245A9l3f7M1wEWrJZB4qBfEwf2chvLLGC+3Ti6aaYFhRnjqKqfXFiyC
	 VaItCGPq9KloAunMLh2483i1cKvWlTXPBZiHNoF67p3KbmSMt0GFytdjvlh2MPici9
	 ekqlc0rlyeRto6WMDTVpXV9M/ftrwf7OeCmTZw/E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Al Grant <al.grant@arm.com>,
	James Clark <james.clark@linaro.org>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 122/482] drivers/perf: arm_spe: Use perf_allow_kernel() for permissions
Date: Tue,  8 Oct 2024 14:03:05 +0200
Message-ID: <20241008115653.107122779@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Clark <james.clark@linaro.org>

[ Upstream commit 5e9629d0ae977d6f6916d7e519724804e95f0b07 ]

Use perf_allow_kernel() for 'pa_enable' (physical addresses),
'pct_enable' (physical timestamps) and context IDs. This means that
perf_event_paranoid is now taken into account and LSM hooks can be used,
which is more consistent with other perf_event_open calls. For example
PERF_SAMPLE_PHYS_ADDR uses perf_allow_kernel() rather than just
perfmon_capable().

This also indirectly fixes the following error message which is
misleading because perf_event_paranoid is not taken into account by
perfmon_capable():

  $ perf record -e arm_spe/pa_enable/

  Error:
  Access to performance monitoring and observability operations is
  limited. Consider adjusting /proc/sys/kernel/perf_event_paranoid
  setting ...

Suggested-by: Al Grant <al.grant@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
Link: https://lore.kernel.org/r/20240827145113.1224604-1-james.clark@linaro.org
Link: https://lore.kernel.org/all/20240807120039.GD37996@noisy.programming.kicks-ass.net/
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/arm_spe_pmu.c | 9 ++++-----
 include/linux/perf_event.h | 8 +-------
 kernel/events/core.c       | 9 +++++++++
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 9100d82bfabc0..3569050f9cf37 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -41,7 +41,7 @@
 
 /*
  * Cache if the event is allowed to trace Context information.
- * This allows us to perform the check, i.e, perfmon_capable(),
+ * This allows us to perform the check, i.e, perf_allow_kernel(),
  * in the context of the event owner, once, during the event_init().
  */
 #define SPE_PMU_HW_FLAGS_CX			0x00001
@@ -50,7 +50,7 @@ static_assert((PERF_EVENT_FLAG_ARCH & SPE_PMU_HW_FLAGS_CX) == SPE_PMU_HW_FLAGS_C
 
 static void set_spe_event_has_cx(struct perf_event *event)
 {
-	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && perfmon_capable())
+	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && !perf_allow_kernel(&event->attr))
 		event->hw.flags |= SPE_PMU_HW_FLAGS_CX;
 }
 
@@ -745,9 +745,8 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 
 	set_spe_event_has_cx(event);
 	reg = arm_spe_event_to_pmscr(event);
-	if (!perfmon_capable() &&
-	    (reg & (PMSCR_EL1_PA | PMSCR_EL1_PCT)))
-		return -EACCES;
+	if (reg & (PMSCR_EL1_PA | PMSCR_EL1_PCT))
+		return perf_allow_kernel(&event->attr);
 
 	return 0;
 }
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 393fb13733b02..a7f1a3a4d1dce 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1608,13 +1608,7 @@ static inline int perf_is_paranoid(void)
 	return sysctl_perf_event_paranoid > -1;
 }
 
-static inline int perf_allow_kernel(struct perf_event_attr *attr)
-{
-	if (sysctl_perf_event_paranoid > 1 && !perfmon_capable())
-		return -EACCES;
-
-	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
-}
+int perf_allow_kernel(struct perf_event_attr *attr);
 
 static inline int perf_allow_cpu(struct perf_event_attr *attr)
 {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 36191add55c37..081d9692ce747 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13362,6 +13362,15 @@ const struct perf_event_attr *perf_event_attrs(struct perf_event *event)
 	return &event->attr;
 }
 
+int perf_allow_kernel(struct perf_event_attr *attr)
+{
+	if (sysctl_perf_event_paranoid > 1 && !perfmon_capable())
+		return -EACCES;
+
+	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
+}
+EXPORT_SYMBOL_GPL(perf_allow_kernel);
+
 /*
  * Inherit an event from parent task to child task.
  *
-- 
2.43.0




