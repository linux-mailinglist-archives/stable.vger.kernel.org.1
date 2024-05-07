Return-Path: <stable+bounces-43265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A06FB8BF104
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FDD51F23FBD
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC02713B2AF;
	Tue,  7 May 2024 23:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1FKGaa6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5F313B29B;
	Tue,  7 May 2024 23:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122869; cv=none; b=iiALbe3f6Cec+/WaCBuHR0judKSXdo5pkyf/4sCW7OMlbWpRljVYUEqWfyiFrJTI/Wkl20oQOijJujuUuU+ooTi61IRL86kDkD+rZyGiJ1d4Xcnr5/UAu/1DHi6oIR0lyMijKsd9eZ47jf3had0jbf//mamxDiypiBXH+VUR6OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122869; c=relaxed/simple;
	bh=c3Zrankq9kyXbpJ5b7Mar568CnEDDczmTAIpy0VNr7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8Ls/XrrrAxJ4xlp1xXRGJDa6HdCGH1aCviaIYXN7s5XI6v4TMw7iqW2zAxrzfFee68XNmevuWyYDcl6+N6uiZzd+smebzzf919iQ7AM4JUWU9lCnv0SGc8PrwG8EHrNLtFkERTkDZcU8ENLeY23lk/wLY5clZJbConhEc3EOgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1FKGaa6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9A5C3277B;
	Tue,  7 May 2024 23:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122869;
	bh=c3Zrankq9kyXbpJ5b7Mar568CnEDDczmTAIpy0VNr7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I1FKGaa6F3Ecd5Djhe7CAjGIVgCe4OcxwoXRtptK+H8YgpFGqJDPZtq24CHgKrm6y
	 vUcIxn820gnkSGoPesP7/epdKBtKnkzLTu2ZCpXOs8xi6bttLc8k4YpDQHWx4Q90IO
	 +gNPpTxHkyD9MlgME65MUBIMgmm+BvBrPn54eOWcCKJmz5moYxUsr5Nm3pqNnXoCKn
	 bRAFOzoulvyOlHmbPJk9na5Dbz+nI5ENYjVH9CufiolAJUiv2oiEoYPea+mDwYsCdX
	 QznrZfD2sQtKBpkRZ/EoqUnuIR4ap5TQbR09Qo988L2Cs25z2vmd/Uda3RscPDrp2m
	 EIFZ8KWG7LrVg==
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
Subject: [PATCH AUTOSEL 6.1 12/12] sched/isolation: Fix boot crash when maxcpus < first housekeeping CPU
Date: Tue,  7 May 2024 19:00:14 -0400
Message-ID: <20240507230031.391436-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230031.391436-1-sashal@kernel.org>
References: <20240507230031.391436-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.90
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


