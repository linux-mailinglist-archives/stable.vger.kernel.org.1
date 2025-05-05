Return-Path: <stable+bounces-140003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6892AAA397
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63531A84FC9
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB41A284B27;
	Mon,  5 May 2025 22:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKj3aQcW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6396128469D;
	Mon,  5 May 2025 22:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483887; cv=none; b=neixwSaTNOwhud2NMf17HjJNxhET4pbAz5+U6j1Mc0zd8FtotgNRCwE75QY2yMPzFI6WuvrA/y6KyuOJ6hk3mGkMNzhvz5372Q8V5hAux4KxMVP9Ni3gUbgrQBGte73Z7VAvPXMz1mJPyRyVvya7Dp9nic/ktauTtVox1jU8k+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483887; c=relaxed/simple;
	bh=+t5OmfX7kAXt9hUekn+s1vQN6NXWOqGqcrY1lEmV50g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NFeOWayEnqGqAUhtTTSOQQOBA1wcxv6fkUyR/9vw7Msu2AGLqJMH62oyY7++58IEK/0dRbZGIDUuyYlb5g8Pb0ygpS0vZxvYpN/Zt+9fHVuHbrEK7w0/e97nh89QD+VNX+s5uF+F8oX22UCrX/cl/BN0vavUr6Lof2Y02S+rfA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKj3aQcW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F70C4CEED;
	Mon,  5 May 2025 22:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483886;
	bh=+t5OmfX7kAXt9hUekn+s1vQN6NXWOqGqcrY1lEmV50g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iKj3aQcWEVuR1ZWK9hKwi8hcOx1V4RaQo3OCh8wiU7/mfbaw/QuWKAxID7VxTOQS6
	 0Mgig1vZL+qWqS7rwTvV4STZ3j1YIP+f6BnX0RkWCBgkzfCg70+yDRH3cm9wteGeWE
	 JMFS2TKHVq17k4WMcsxDggvPnrmrb/2WkHz4gYIx5/ijjf5OfxCjavU7QHnr000ANo
	 tvuoPCD1HdThc0E5hT/Q9RXz+Q+PP+FyLzO1bM5TWvPAG9grJ5W7ato3dLo+p6/Ka9
	 z4w/St88ZazCaqbwNIujDExNAnysyAQhWrl9La8Bbm8hl1efM3Xq5+YddKcPKwB3zD
	 m/YJvn1BZfQZg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 256/642] perf/core: Clean up perf_try_init_event()
Date: Mon,  5 May 2025 18:07:52 -0400
Message-Id: <20250505221419.2672473-256-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit da02f54e81db2f7bf6af9d1d0cfc5b41ec6d0dcb ]

Make sure that perf_try_init_event() doesn't leave event->pmu nor
event->destroy set on failure.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lore.kernel.org/r/20250205102449.110145835@infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 65 ++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 93ce810384c92..de838d3819ca7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12020,40 +12020,51 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 	if (ctx)
 		perf_event_ctx_unlock(event->group_leader, ctx);
 
-	if (!ret) {
-		if (!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS) &&
-		    has_extended_regs(event))
-			ret = -EOPNOTSUPP;
+	if (ret)
+		goto err_pmu;
 
-		if (pmu->capabilities & PERF_PMU_CAP_NO_EXCLUDE &&
-		    event_has_any_exclude_flag(event))
-			ret = -EINVAL;
+	if (!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS) &&
+	    has_extended_regs(event)) {
+		ret = -EOPNOTSUPP;
+		goto err_destroy;
+	}
 
-		if (pmu->scope != PERF_PMU_SCOPE_NONE && event->cpu >= 0) {
-			const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(pmu->scope, event->cpu);
-			struct cpumask *pmu_cpumask = perf_scope_cpumask(pmu->scope);
-			int cpu;
-
-			if (pmu_cpumask && cpumask) {
-				cpu = cpumask_any_and(pmu_cpumask, cpumask);
-				if (cpu >= nr_cpu_ids)
-					ret = -ENODEV;
-				else
-					event->event_caps |= PERF_EV_CAP_READ_SCOPE;
-			} else {
-				ret = -ENODEV;
-			}
-		}
+	if (pmu->capabilities & PERF_PMU_CAP_NO_EXCLUDE &&
+	    event_has_any_exclude_flag(event)) {
+		ret = -EINVAL;
+		goto err_destroy;
+	}
 
-		if (ret && event->destroy)
-			event->destroy(event);
+	if (pmu->scope != PERF_PMU_SCOPE_NONE && event->cpu >= 0) {
+		const struct cpumask *cpumask;
+		struct cpumask *pmu_cpumask;
+		int cpu;
+
+		cpumask = perf_scope_cpu_topology_cpumask(pmu->scope, event->cpu);
+		pmu_cpumask = perf_scope_cpumask(pmu->scope);
+
+		ret = -ENODEV;
+		if (!pmu_cpumask || !cpumask)
+			goto err_destroy;
+
+		cpu = cpumask_any_and(pmu_cpumask, cpumask);
+		if (cpu >= nr_cpu_ids)
+			goto err_destroy;
+
+		event->event_caps |= PERF_EV_CAP_READ_SCOPE;
 	}
 
-	if (ret) {
-		event->pmu = NULL;
-		module_put(pmu->module);
+	return 0;
+
+err_destroy:
+	if (event->destroy) {
+		event->destroy(event);
+		event->destroy = NULL;
 	}
 
+err_pmu:
+	event->pmu = NULL;
+	module_put(pmu->module);
 	return ret;
 }
 
-- 
2.39.5


