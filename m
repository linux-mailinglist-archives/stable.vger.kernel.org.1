Return-Path: <stable+bounces-140576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE06AAAE45
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05CBC188799E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D413679CB;
	Mon,  5 May 2025 22:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iblX7p40"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABE32BD585;
	Mon,  5 May 2025 22:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485191; cv=none; b=gczajIXzeRCRyY8/hYeP2JMdkDalKoYyUSFBuk4UDQeWIuKkkaoLmAeKga4uP0s32uxnluJnmU3XsWUf2+XnUC7kU8irlt+ly8OupyXUDdwR9jqlhBVzPQ1R3NmUbZ/kXNt0OW0JJH5ceDiaFStImwvJldTtt4vIM1cjVDdXvJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485191; c=relaxed/simple;
	bh=Nb9WwKqb2w5KCbCEHMmkoXMoM7qE9XNWo3xQoG4YWSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZsA3I62bOPJ8+J1kiC69gxXqhe7MSpbBhaHVC6UrVngj6bQDw2fgPwiff2mSt72TW+qKJcoNQ1Csw+o1iTbi5j94vYq1OY9QNMb9zq3M3SzP8SPdkPpwogwDxQV4pTzHmFwUJJsJVJZ19RwytKW7fUi/oXmsYgfIvmw03Ow6qXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iblX7p40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA247C4CEEF;
	Mon,  5 May 2025 22:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485189;
	bh=Nb9WwKqb2w5KCbCEHMmkoXMoM7qE9XNWo3xQoG4YWSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iblX7p408hqdLmDLKjYJEfKId/zMU/4uE4ufAYa3RB3XHh+Yq4SCakS0CKZ/k9pnX
	 Szy/Lvjfh101ZQkWOhnduewTfsllCQIw/87Aaao8lXsNPnRNznuWUDk6snOXg+hwfd
	 Zj1X0tImVZYGgFNNoiClvirKdugGZ6xh9bpZM0B+DEwuBnEueYXcsH6f0vulC53iy5
	 yrnehDh2mHU5XiA1xXAF4bpgKj+cAAnKrUOq17tdQDxNhaUcCMBP1MRKygCN6yxZEi
	 r9WAzIi3RiLomGVhnGNfQ9Y/slKIqPHSytAWuXESDj02qGqHPgiydy9vNxXnT0jjoE
	 iTYlGw737Q1Nw==
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
Subject: [PATCH AUTOSEL 6.12 202/486] perf/core: Clean up perf_try_init_event()
Date: Mon,  5 May 2025 18:34:38 -0400
Message-Id: <20250505223922.2682012-202-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index edafe9fc4bdd0..19dde12f23b83 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11978,40 +11978,51 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
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


