Return-Path: <stable+bounces-43233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA488BF062
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77CA72810FD
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29433130A64;
	Tue,  7 May 2024 22:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qO4Gl5U/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB039130A61;
	Tue,  7 May 2024 22:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122721; cv=none; b=LO0rSXXOJ7Lufl9itEOgWZmNwA3j8NVZ3IdfBEcZ5Cvyyzz0nNZVAQFEXOxcp0HJDkeeCZs6lMUm7tlye2Hh7y/eau3I3mLTCkHLCMb/jhFtBCmef9uUheOcJNUV0S4z8IMwwhUXY2h2wjhwZ3cGhwcU8bsQfj0EgIZD3PYuskI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122721; c=relaxed/simple;
	bh=c3Zrankq9kyXbpJ5b7Mar568CnEDDczmTAIpy0VNr7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1iXdJkaTHsuXo6DCsoPNufv/zV8wZy4RUizZc7mPFO65HmAqOE3mIcG5L3A8xEg5dMLcziWHg9ZVdjHfPRIoBEZCb0rmfd9IJ4f/oW/ivspR3mzY70d+VBys9PTJroCin3IhlxaPSa35STiAFvxCbX/4UiUCRPpyyNs5bx3IOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qO4Gl5U/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8D9C3277B;
	Tue,  7 May 2024 22:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122720;
	bh=c3Zrankq9kyXbpJ5b7Mar568CnEDDczmTAIpy0VNr7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qO4Gl5U/iQswwiqGF0es7stQykr9cj4hkkUMEPSMgHK54R38Sf2amVC9aRqoAB1mt
	 UTxlNHiQF/r7rusbInho/jr/h2onF/HAUG6hb9efS7YBxlc3Qcq6oczjrFd++hCZiN
	 Cq9bMh61jn/R93gmmoy/QfGsGDWapjUVG5Qt3Tzz8KuQ00CkBH2FB1yrByPpzjYc02
	 vxGT2wzb5LZkCfDFW3YjYo2aujVYPoI3ysqzp0/wNiuXBlPk4Rzbv7Rp/7zb3Or/or
	 MW3pU5YX+O6NZLt2OQzumkN+WVnZkOu1rnINXvO4sgkRCwMws44y3Za5bFwAnq77iV
	 urxZEJWHgD5aA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Phil Auld <pauld@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Subject: [PATCH AUTOSEL 6.8 23/23] sched/isolation: Fix boot crash when maxcpus < first housekeeping CPU
Date: Tue,  7 May 2024 18:56:49 -0400
Message-ID: <20240507225725.390306-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507225725.390306-1-sashal@kernel.org>
References: <20240507225725.390306-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit

From: Oleg Nesterov <oleg@redhat.com>

[ Upstream commit 257bf89d84121280904800acd25cc2c444c717ae ]

housekeeping_setup() checks cpumask_intersects(present, online) to ensure
that the kernel will have at least one housekeeping CPU after smp_init(),
but this doesn't work if the maxcpus= kernel parameter limits the number of
processors available after bootup.

For example, a kernel with "maxcpus=2 nohz_full=0-2" parameters crashes at
boot time on a virtual machine with 4 CPUs.

Change housekeeping_setup() to use cpumask_first_and() and check that the
returned CPU number is valid and less than setup_max_cpus.

Another corner case is "nohz_full=0" on a machine with a single CPU or with
the maxcpus=1 kernel argument. In this case non_housekeeping_mask is empty
and tick_nohz_full_setup() makes no sense. And indeed, the kernel hits the
WARN_ON(tick_nohz_full_running) in tick_sched_do_timer().

And how should the kernel interpret the "nohz_full=" parameter? It should
be silently ignored, but currently cpulist_parse() happily returns the
empty cpumask and this leads to the same problem.

Change housekeeping_setup() to check cpumask_empty(non_housekeeping_mask)
and do nothing in this case.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240413141746.GA10008@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/isolation.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 373d42c707bc5..82e2f7fc7c267 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -109,6 +109,7 @@ static void __init housekeeping_setup_type(enum hk_type type,
 static int __init housekeeping_setup(char *str, unsigned long flags)
 {
 	cpumask_var_t non_housekeeping_mask, housekeeping_staging;
+	unsigned int first_cpu;
 	int err = 0;
 
 	if ((flags & HK_FLAG_TICK) && !(housekeeping.flags & HK_FLAG_TICK)) {
@@ -129,7 +130,8 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 	cpumask_andnot(housekeeping_staging,
 		       cpu_possible_mask, non_housekeeping_mask);
 
-	if (!cpumask_intersects(cpu_present_mask, housekeeping_staging)) {
+	first_cpu = cpumask_first_and(cpu_present_mask, housekeeping_staging);
+	if (first_cpu >= nr_cpu_ids || first_cpu >= setup_max_cpus) {
 		__cpumask_set_cpu(smp_processor_id(), housekeeping_staging);
 		__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
 		if (!housekeeping.flags) {
@@ -138,6 +140,9 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 		}
 	}
 
+	if (cpumask_empty(non_housekeeping_mask))
+		goto free_housekeeping_staging;
+
 	if (!housekeeping.flags) {
 		/* First setup call ("nohz_full=" or "isolcpus=") */
 		enum hk_type type;
-- 
2.43.0


