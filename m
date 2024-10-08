Return-Path: <stable+bounces-82249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0324A994BD3
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FFFF1F28820
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC6F1DE2A5;
	Tue,  8 Oct 2024 12:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J734CXtb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC01D183CB8;
	Tue,  8 Oct 2024 12:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391630; cv=none; b=AKi7wuydvBTlJ/ZmmscEFmEmdwYLOi9dMgilqiydDTivab2Zp2jOKvnrS96Zt+o2Icn19gVialmyeY4txaPQO+2Ubdqoh463azxUoMkJYA67xGQ1k6dQdxgbVjoEf77bUQ5lnDZHRYdwsTFT5xvofn97e1rsmcX76jHtZdKYqHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391630; c=relaxed/simple;
	bh=zw9UL+7HJSkUgJSG7fY7oF4f4hpQ1aCksFoXSDujwbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JdR2b8qba1RblQL4aWY2HaoG8o98Qo2eWOXbzgzANcsA2/5AmcdCRR/J4r0PEh3GEv2ZIGlvqWJbZLQraVvLYErCi8rjSqvUELtZ4Gp1Ek4mexuGBtgGEVgt8asP2A6AwEebXV4bbQASDKXMcu2tn62jWD9mLumiKHizPTaavdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J734CXtb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337D9C4CEC7;
	Tue,  8 Oct 2024 12:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728391630;
	bh=zw9UL+7HJSkUgJSG7fY7oF4f4hpQ1aCksFoXSDujwbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J734CXtbouDQOCzPSQbeTMfzAZ5RrLay0ozpsn1oO7ww2rJeC4U/o+ZXLD9dQx8iA
	 3x6J8RGros4SFHzleU1dssZGJSlpD/WwdiIqgoVO87XM2t5hD8lFv7GhiFzOr/TUT4
	 JJSQ5hf2aznGX0wsJbG4xW4c2q1TFAiLqMxNfFSs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Al Grant <al.grant@arm.com>,
	James Clark <james.clark@linaro.org>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 145/558] drivers/perf: arm_spe: Use perf_allow_kernel() for permissions
Date: Tue,  8 Oct 2024 14:02:55 +0200
Message-ID: <20241008115708.069890095@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

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
index 1a8942277ddad..e336306b8c08e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1602,13 +1602,7 @@ static inline int perf_is_paranoid(void)
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
index 8a6c6bbcd658a..b21c8f24a9876 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13358,6 +13358,15 @@ const struct perf_event_attr *perf_event_attrs(struct perf_event *event)
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




