Return-Path: <stable+bounces-214487-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HwsJ5yyhGk54wMAu9opvQ
	(envelope-from <stable+bounces-214487-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 16:09:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B20D7F46BB
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 16:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 294923001FA6
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 15:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F8A4219E1;
	Thu,  5 Feb 2026 15:09:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329CB39900A;
	Thu,  5 Feb 2026 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770304149; cv=none; b=VI2SbKunvB9C8tr/vpWULB3jD0Yn0gtXJYGfQJQ8B+PgH/S8L1+uH+ZwZ4i8TxAoDu/4QBreKWqTkEJahYyc1dNykDluF8lrbdU/ldcaTi9UnkhNpJUaHbAR/qlPFlxoec1yMhk8bqHpiExVxBdL+2JU5RlwsCbMd1u3f/XL9Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770304149; c=relaxed/simple;
	bh=K2EVgGdoi4y2PT+Y9ctngywJVj8QdCcBShw16+ochMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3TJyu7quooDvUIOiVWaqIclBGcMDV5OSBtxX0hUpQd6+yQcw7R9siNUQ1Rf0emkgY/EjflnjIwFRrroYhKYretUZHUWUi9d4472ZT6P9Ce1YoCgW97ptWtc8arOq+sSYOBIxv3lHphQ7/XOgCzTFYG3fJpl+MqgjQHCJm2OQ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A5491516;
	Thu,  5 Feb 2026 07:09:02 -0800 (PST)
Received: from e135073.arm.com (unknown [10.57.8.39])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 27F0B3F778;
	Thu,  5 Feb 2026 07:09:04 -0800 (PST)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Christian Loehle <christian.loehle@arm.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
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
Subject: [PATCH 1/2] sched/fair: Fix integer underflow
Date: Thu,  5 Feb 2026 16:08:44 +0100
Message-ID: <20260205150846.1242134-2-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205150846.1242134-1-pierre.gondois@arm.com>
References: <20260205150846.1242134-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-214487-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pierre.gondois@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B20D7F46BB
X-Rspamd-Action: no action

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
index da46c31645378..aa14a9982b9f1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11249,8 +11249,8 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
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
2.43.0


