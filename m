Return-Path: <stable+bounces-77596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B00AC985EF3
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 728DD289264
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833D82194B4;
	Wed, 25 Sep 2024 12:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugK2Rszc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1602194A8;
	Wed, 25 Sep 2024 12:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266408; cv=none; b=P+AGpUidHSyDiSVCHJTO1QNfakA3eAYhn1XL5YqMyb04s9+aUCKFAdcAo1Gt/hB7Iyoq7Dutim+1UkAFcgurg4IEs//i7t8sxyD92/f18sAca6hT1UhwwQyGPp80rDO/MybRQJLkDHUPW7ilnu8EZtH5hbUv7j2ud/4PY+49B5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266408; c=relaxed/simple;
	bh=LrCOcNgGPitG5crkhX9bq4DBpSXYwgiiKFJA3JrJJCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VxqjYMKc2xO76/zEdAVba4uWqj6U3vU3vNVkMWBuuKfxSm0KaAzCy1e2OA5o1YWLvjnvW7xreqwUca+UQpZ25Q1O0zgY25ojyPg0apDseBGqxXv7QLNfxNji3M02OMxgJzQNKbk+2UUj/5o86AiK1SjUFioIg9G5P1yLv4aiToM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (0-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugK2Rszc reason="key not found in DNS"; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F591C4CEC3;
	Wed, 25 Sep 2024 12:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266408;
	bh=LrCOcNgGPitG5crkhX9bq4DBpSXYwgiiKFJA3JrJJCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ugK2RszcsEfHwDOFcf/qV8Z7Od8qZTgf31yNsjjVyvPt5QsZT2XZ5w94YfJQByuu7
	 ofLJXXLPUJXrOxfagE42W7i9w+3Hs5UiLsoyd+GV4Eo3OCBDFx2rESRwUX02b8Cxes
	 p6blDDD8YrOYcH47tciN7squloF1DEuUYEGqOOHsjJ444ABibf24fE2++/KiCYqUjM
	 XRqWTvEeuYTCkky3Yn+aXfjmD/mvH/gFnMXQxe7ghiydVWdUkYFHjqupLKQcFF8m23
	 4Yd4z5gj+Lc+KM3JCiJBXx06UC74vqZHcndiGjGIZgx7icK3n/hU0U9eSgeBWVUOdV
	 FuZs0vcrcQCfw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Al Grant <al.grant@arm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mark.rutland@arm.com,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 049/139] drivers/perf: arm_spe: Use perf_allow_kernel() for permissions
Date: Wed, 25 Sep 2024 08:07:49 -0400
Message-ID: <20240925121137.1307574-49-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

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
index d2b0cbf0e0c41..2bec2e3af0bd6 100644
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
 
@@ -767,9 +767,8 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 
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
index 95d4118ee4a91..7a5563ffe61b5 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1599,13 +1599,7 @@ static inline int perf_is_paranoid(void)
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
index 4d0abdace4e7c..d40809bdf4b30 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13330,6 +13330,15 @@ const struct perf_event_attr *perf_event_attrs(struct perf_event *event)
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


