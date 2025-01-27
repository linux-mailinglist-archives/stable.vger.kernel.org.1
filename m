Return-Path: <stable+bounces-110849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19089A1D391
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 10:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341853A29CF
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 09:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC3D28E7;
	Mon, 27 Jan 2025 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z7K3IriW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d6ZIOlgW"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03491FC7E7;
	Mon, 27 Jan 2025 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737970603; cv=none; b=lVjztAGxpKQTqfaHGI4K9cyr+7sFJzT+yPJRqIbygOnWCVtqaNAEh4fJ36AUubAs4xOob9Xn/V+HgVA3YRD3tOJFMcpendqB8CvBV7IJJZMxIgpKVsKWVG8pVNL+u0hixNRh+T8UwSEETC/SvGJOuIwRnNqadGaw1xYyNi486ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737970603; c=relaxed/simple;
	bh=5QHB32S3YFT5oy5aJyZKTRBXOtVKnCNSb4n63L2sucQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=k6IyC+OaTOB9YRSDQ9CPTgsW54cyS/T5UEQ0OGGWIcHfHuxHgykRlt2S8G+6aV7BqY5TgjvOUm7Tv4wKPKJDLYiPeNj4WDNT7RDv/uTveA+qWO4GjJW6KaBknfbYVWizeWoC80IE5dU91pCp8goDlVRXlmpIQK60AOLJaLkF2Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z7K3IriW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d6ZIOlgW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Jan 2025 09:36:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737970599;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+SI5CdpSexRMvjlBKvy9fNH1gruWLX6S6jphSTnoJ0=;
	b=z7K3IriWaLfgZxV7AakpAdW/QVugSJoEiOi07xoUvl1Y+AN8wiIfEbVTJYyVx/v3VTbGmV
	xHJhBJTXpdbLGj3rL/jo8t0pGaFKJ3LRV6ZPyOylhhXJ/0Z5DgKH6EpiCzYKUv0G0k/2Yr
	znD7mXrDtrdXhnG9F+KTVb/0ToUS/XDQdQh5tw1SgfPoWN0BxAhCiZwwBECnZ01BRcn+WR
	agxzVeGq3tDzJprtJoTB6mXKtyZFezb+SWmMIZqpml4qg8HHbNQeMFwSLdFk5GKnI7o5pF
	w2aOsDKidWdpTo8htenTG+KTYCPAvVlYBnHO37TIYsunE26KF8NrhspI1PbEXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737970599;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+SI5CdpSexRMvjlBKvy9fNH1gruWLX6S6jphSTnoJ0=;
	b=d6ZIOlgW8PBPTRpFIYe2+aVWWJvnOCJF52+LI5JxFsGROOPueywioIUuoUu8oLw4nB+E5E
	QNuSFHAdAgw2PLCw==
From: "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] clocksource: Use get_random_bytes() in
 clocksource_verify_choose_cpus()
Cc: Waiman Long <longman@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@kernel.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250125015442.3740588-2-longman@redhat.com>
References: <20250125015442.3740588-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173797059575.31546.10006501146762053184.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     01cfc84024e9a6b619696a35d2e5662255001cd0
Gitweb:        https://git.kernel.org/tip/01cfc84024e9a6b619696a35d2e5662255001cd0
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Fri, 24 Jan 2025 20:54:42 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Jan 2025 10:30:59 +01:00

clocksource: Use get_random_bytes() in clocksource_verify_choose_cpus()

The following bug report happened in a PREEMPT_RT kernel.

 BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
 in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2012, name: kwatchdog
 preempt_count: 1, expected: 0
 RCU nest depth: 0, expected: 0
 3 locks held by kwatchdog/2012:
  #0: ffffffff8af2da60 (clocksource_mutex){+.+.}-{3:3}, at: clocksource_watchdog_kthread+0x13/0x50
  #1: ffffffff8aa8d4d0 (cpu_hotplug_lock){++++}-{0:0}, at: clocksource_verify_percpu.part.0+0x5c/0x330
  #2: ffff9fe02f5f33e0 ((batched_entropy_u32.lock)){+.+.}-{2:2}, at: get_random_u32+0x4f/0x110
 Preemption disabled at:
 [<ffffffff88c1fe56>] clocksource_verify_percpu.part.0+0x66/0x330
 CPU: 33 PID: 2012 Comm: kwatchdog Not tainted 5.14.0-503.23.1.el9_5.x86_64+rt-debug #1
 Call Trace:
  <TASK>
  __might_resched.cold+0xf4/0x12f
  rt_spin_lock+0x4c/0x100
  get_random_u32+0x4f/0x110
  clocksource_verify_choose_cpus+0xab/0x1a0
  clocksource_verify_percpu.part.0+0x6b/0x330
  __clocksource_watchdog_kthread+0x193/0x1a0
  clocksource_watchdog_kthread+0x18/0x50
  kthread+0x114/0x140
  ret_from_fork+0x2c/0x50
  </TASK>

This happens due to the fact that get_random_u32() is called in
clocksource_verify_choose_cpus() with preemption disabled.  If crng_ready()
is true by the time get_random_u32() is called, The batched_entropy_32
local lock will be acquired. In a PREEMPT_RT enabled kernel, it is a
rtmutex, which can't be acquireq with preemption disabled.

Fix this problem by using the less random get_random_bytes() function which
will not take any lock. In fact, it has the same random-ness as
get_random_u32_below() when crng_ready() is false.

Fixes: 7560c02bdffb ("clocksource: Check per-CPU clock synchronization when marked unstable")
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250125015442.3740588-2-longman@redhat.com
---
 kernel/time/clocksource.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 77d9566..659c4b7 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -340,9 +340,13 @@ static void clocksource_verify_choose_cpus(void)
 	 * and no replacement CPU is selected.  This gracefully handles
 	 * situations where verify_n_cpus is greater than the number of
 	 * CPUs that are currently online.
+	 *
+	 * The get_random_bytes() is used here to avoid taking lock with
+	 * preemption disabled.
 	 */
 	for (i = 1; i < n; i++) {
-		cpu = get_random_u32_below(nr_cpu_ids);
+		get_random_bytes(&cpu, sizeof(cpu));
+		cpu %= nr_cpu_ids;
 		cpu = cpumask_next(cpu - 1, cpu_online_mask);
 		if (cpu >= nr_cpu_ids)
 			cpu = cpumask_first(cpu_online_mask);

