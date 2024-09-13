Return-Path: <stable+bounces-76047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 081B6977BB5
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 10:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64B31F21A60
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 08:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E431D6C58;
	Fri, 13 Sep 2024 08:58:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDEA1D58B7;
	Fri, 13 Sep 2024 08:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726217918; cv=none; b=I3VBvvoHOLTNJ+WPofGdI0M6LwiP+tmLDIraFsPSEmd5gBech6rbIzq0gMNYFEcSR5RA97dVdXX4lq/S9IYrUQS4EPz5qKUJwONezXc7f9M9jVEMuLwAoFSsbc6kHVBzv8fY6zLF/Y3Dns3RD3hErsfzoytKwGQ6fQwfEUqG/0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726217918; c=relaxed/simple;
	bh=gvYM1eP7xAAEJwcJpVXx5FknQI88VmeZhycs4DExV5M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AQYV7ZNXN6gocWZvY4cqMI5vCBNZf8VeXDTDLFSovfixP72fDDA60V4knIBg5+i11Sv03s0vNUAxemeh1+oW2+ZFn2V8SBN30znpVP/7GsXB3DIe5Vga4qeRfDIMGNZBF8s9W3nbVQcWqpvvhynVBOp7KI6TZ43Ma8N1Kv/PqB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEB8D13D5;
	Fri, 13 Sep 2024 01:59:05 -0700 (PDT)
Received: from e126645.arm.com (unknown [10.57.75.215])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C1D4E3F73B;
	Fri, 13 Sep 2024 01:58:33 -0700 (PDT)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Pierre Gondois <pierre.gondois@arm.com>,
	stable@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH] sched/fair: Fix integer underflow
Date: Fri, 13 Sep 2024 10:58:23 +0200
Message-Id: <20240913085824.404709-1-pierre.gondois@arm.com>
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

Fixes: 0b0695f2b34a ("sched/fair: Rework load_balance()")
cc: stable@vger.kernel.org
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
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


