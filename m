Return-Path: <stable+bounces-78497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B84A798BE44
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 15:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C850281A1C
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 13:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560A61C3F3E;
	Tue,  1 Oct 2024 13:46:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745C017FD;
	Tue,  1 Oct 2024 13:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790401; cv=none; b=ueij2DIJ/zg0jspruPF99CzTUMp4pGalFdLXJTQDsSSfcK8AZY4gjw96kBC+UV9m4Lj7XHSvk0y5oRF4QrfCIUo8UNc5VroOV6X4nHQkDJWImYlK32CxAmfDe7KFohxt9XazYPxfg2nJ/eWpDeYkG+ycZC19Ggbf5fcAqDxMcnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790401; c=relaxed/simple;
	bh=TKxnXDkGhATn0FqIrpUz5udTcw+K0UUOvMulDmQ8L8A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uaq1PRGkPmMcoAjYSrTeaBCetuXt2jtmPK41PGQ51/b3sMx2UvGzpFLrOa3kGkWd8nM4vmLD5TunaZ6I192D/G+vm5uywT0MmrhLLF5T+RZx7w7o2D+JvCiYBuQ/I4dlTyLgjwTfvfdVWlu4Tt/VQAnjVxjcoLkgn6q6rCP8DVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53ED3339;
	Tue,  1 Oct 2024 06:47:08 -0700 (PDT)
Received: from e126645.arm.com (unknown [10.57.84.141])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6F5153F64C;
	Tue,  1 Oct 2024 06:46:35 -0700 (PDT)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Pierre Gondois <pierre.gondois@arm.com>,
	stable@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Rik van Riel <riel@surriel.com>
Subject: [PATCH v2] sched/fair: Fix integer underflow
Date: Tue,  1 Oct 2024 15:46:03 +0200
Message-Id: <20241001134603.2758480-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(struct sg_lb_stats).idle_cpus is of type 'unsigned int'.
(local->idle_cpus - busiest->idle_cpus) can underflow to UINT_MAX
for instance, and max_t(long, 0, UINT_MAX) will output UINT_MAX.

Use lsub_positive() instead of max_t().

Fixes: 16b0a7a1a0af ("sched/fair: Ensure tasks spreading in LLC during LB")
cc: stable@vger.kernel.org
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9057584ec06d..6d9124499f52 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10775,8 +10775,8 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 			 * idle CPUs.
 			 */
 			env->migration_type = migrate_task;
-			env->imbalance = max_t(long, 0,
-					       (local->idle_cpus - busiest->idle_cpus));
+			env->imbalance = local->idle_cpus;
+			lsub_positive(&env->imbalance, busiest->idle_cpus);
 		}
 
 #ifdef CONFIG_NUMA
-- 
2.25.1


