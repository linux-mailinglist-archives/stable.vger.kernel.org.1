Return-Path: <stable+bounces-132575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCB4A88377
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A191892287
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82642D11DD;
	Mon, 14 Apr 2025 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tc4ZCyDq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737392D11AF;
	Mon, 14 Apr 2025 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637445; cv=none; b=Pxv/ch64i9qmQUNPd8YPljPwGZYyWn2ui5/b2FCvEC45faVswcLAsYCt4ZF9VSw5dwx4w/GR6TVa2sUUtAH3bOx+KyXj8c6w/RGZKRKpEr/rbGhwBhWxRyHh6U3jV4gDzNuczjZoQmCIydHeXWLXrjKSGeOWXdF6VjDNcUGuvS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637445; c=relaxed/simple;
	bh=yT53AX2C1X/ZgjzklomnAalqFEUWrqd7TesYE3PPwMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AquoCA2LZkyiO4tpHHl4JSWkwyy/FKhK2bNJIeNh+qBAqbLh1Bc1y9ptIJlSzmJkPfUfy++kxYEub2NCH9x0brO6LTa6X/WpfwdxknBig+ZJs5OlnyqhGKiu3RJaxaxupc0043Y0sscP27l4s0clNr/rCLjOq06ZB++MW+93YR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tc4ZCyDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FBDC4CEE2;
	Mon, 14 Apr 2025 13:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637443;
	bh=yT53AX2C1X/ZgjzklomnAalqFEUWrqd7TesYE3PPwMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tc4ZCyDqEgcstzUSYXIF1GA5cTKmEPqPQHy1B/InMEJXub/jfYVd1wpshszlzuQZy
	 i9LmOK9KMw3Nm9UnDOCZ1DiMPr+AsYYgzAc/VMdUVY4XT8SLRVB6TsWNM8e4ZaPuLy
	 2zfFER++rkqnBM+nLMDIPmgSXpnmowSMcVi//sVE6CreZuJU5SEqTRSHeoWdg4QMwC
	 oPw/GQ25TvzjtTvWVapUx/PSMDPrNTRnhj3y98ENYNhsu2rJF2ayO9jraWLpjexciJ
	 D2Zm6eTbPmi6f89uVmEJhk8w17msl9TMwAxM9CaQBcqW9KaoMjUBJ6dBgDTCxJIWN3
	 nAw7Ge/66t7xA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Chris Bainbridge <chris.bainbridge@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	mingo@kernel.org,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 22/24] timekeeping: Add a lockdep override in tick_freeze()
Date: Mon, 14 Apr 2025 09:29:55 -0400
Message-Id: <20250414132957.680250-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132957.680250-1-sashal@kernel.org>
References: <20250414132957.680250-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.87
Content-Transfer-Encoding: 8bit

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 92e250c624ea37fde64bfd624fd2556f0d846f18 ]

tick_freeze() acquires a raw spinlock (tick_freeze_lock). Later in the
callchain (timekeeping_suspend() -> mc146818_avoid_UIP()) the RTC driver
acquires a spinlock which becomes a sleeping lock on PREEMPT_RT.  Lockdep
complains about this lock nesting.

Add a lockdep override for this special case and a comment explaining
why it is okay.

Reported-by: Borislav Petkov <bp@alien8.de>
Reported-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250404133429.pnAzf-eF@linutronix.de
Closes: https://lore.kernel.org/all/20250330113202.GAZ-krsjAnurOlTcp-@fat_crate.local/
Closes: https://lore.kernel.org/all/CAP-bSRZ0CWyZZsMtx046YV8L28LhY0fson2g4EqcwRAVN1Jk+Q@mail.gmail.com/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/tick-common.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 7f2b17fc8ce40..ecdb8c2b2cab2 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -495,6 +495,7 @@ void tick_resume(void)
 
 #ifdef CONFIG_SUSPEND
 static DEFINE_RAW_SPINLOCK(tick_freeze_lock);
+static DEFINE_WAIT_OVERRIDE_MAP(tick_freeze_map, LD_WAIT_SLEEP);
 static unsigned int tick_freeze_depth;
 
 /**
@@ -514,9 +515,22 @@ void tick_freeze(void)
 	if (tick_freeze_depth == num_online_cpus()) {
 		trace_suspend_resume(TPS("timekeeping_freeze"),
 				     smp_processor_id(), true);
+		/*
+		 * All other CPUs have their interrupts disabled and are
+		 * suspended to idle. Other tasks have been frozen so there
+		 * is no scheduling happening. This means that there is no
+		 * concurrency in the system at this point. Therefore it is
+		 * okay to acquire a sleeping lock on PREEMPT_RT, such as a
+		 * spinlock, because the lock cannot be held by other CPUs
+		 * or threads and acquiring it cannot block.
+		 *
+		 * Inform lockdep about the situation.
+		 */
+		lock_map_acquire_try(&tick_freeze_map);
 		system_state = SYSTEM_SUSPEND;
 		sched_clock_suspend();
 		timekeeping_suspend();
+		lock_map_release(&tick_freeze_map);
 	} else {
 		tick_suspend_local();
 	}
@@ -538,8 +552,16 @@ void tick_unfreeze(void)
 	raw_spin_lock(&tick_freeze_lock);
 
 	if (tick_freeze_depth == num_online_cpus()) {
+		/*
+		 * Similar to tick_freeze(). On resumption the first CPU may
+		 * acquire uncontended sleeping locks while other CPUs block on
+		 * tick_freeze_lock.
+		 */
+		lock_map_acquire_try(&tick_freeze_map);
 		timekeeping_resume();
 		sched_clock_resume();
+		lock_map_release(&tick_freeze_map);
+
 		system_state = SYSTEM_RUNNING;
 		trace_suspend_resume(TPS("timekeeping_freeze"),
 				     smp_processor_id(), false);
-- 
2.39.5


