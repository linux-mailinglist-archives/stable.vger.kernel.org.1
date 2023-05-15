Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9920970341C
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242914AbjEOQpB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242939AbjEOQoy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:44:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF2E4C27
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:44:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF01A628DE
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:44:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16ADC433EF;
        Mon, 15 May 2023 16:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169092;
        bh=kyb/I7Mzgm0bTHBTnzEi4Yt4j235MBOV9bVe4+dv6F4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PRv9XM24/S6uXgxUdx5ULGOya0PTM20qwBManqthk4D8+qmwCFT7kPxPabgwXvhBl
         8uT0UBBTjVeo1iLVnDPCh6+J88cwPyS3WvjsHcr8YqCAmhB11BDeGne9O9RQDzQxlR
         myPnvPzBg7ZcssYlA6VuZKixct7QWfANwtS5RwQQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 139/191] nohz: Add TICK_DEP_BIT_RCU
Date:   Mon, 15 May 2023 18:26:16 +0200
Message-Id: <20230515161712.456744188@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

[ Upstream commit 01b4c39901e087ceebae2733857248de81476bd8 ]

If a nohz_full CPU is looping in the kernel, the scheduling-clock tick
might nevertheless remain disabled.  In !PREEMPT kernels, this can
prevent RCU's attempts to enlist the aid of that CPU's executions of
cond_resched(), which can in turn result in an arbitrarily delayed grace
period and thus an OOM.  RCU therefore needs a way to enable a holdout
nohz_full CPU's scheduler-clock interrupt.

This commit therefore provides a new TICK_DEP_BIT_RCU value which RCU can
pass to tick_dep_set_cpu() and friends to force on the scheduler-clock
interrupt for a specified CPU or task.  In some cases, rcutorture needs
to turn on the scheduler-clock tick, so this commit also exports the
relevant symbols to GPL-licensed modules.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Stable-dep-of: 58d766824264 ("tick/nohz: Fix cpu_is_hotpluggable() by checking with nohz subsystem")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/tick.h         | 7 ++++++-
 include/trace/events/timer.h | 3 ++-
 kernel/time/tick-sched.c     | 7 +++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 55388ab45fd4d..965163bdfe412 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -102,7 +102,8 @@ enum tick_dep_bits {
 	TICK_DEP_BIT_POSIX_TIMER	= 0,
 	TICK_DEP_BIT_PERF_EVENTS	= 1,
 	TICK_DEP_BIT_SCHED		= 2,
-	TICK_DEP_BIT_CLOCK_UNSTABLE	= 3
+	TICK_DEP_BIT_CLOCK_UNSTABLE	= 3,
+	TICK_DEP_BIT_RCU		= 4
 };
 
 #define TICK_DEP_MASK_NONE		0
@@ -110,6 +111,7 @@ enum tick_dep_bits {
 #define TICK_DEP_MASK_PERF_EVENTS	(1 << TICK_DEP_BIT_PERF_EVENTS)
 #define TICK_DEP_MASK_SCHED		(1 << TICK_DEP_BIT_SCHED)
 #define TICK_DEP_MASK_CLOCK_UNSTABLE	(1 << TICK_DEP_BIT_CLOCK_UNSTABLE)
+#define TICK_DEP_MASK_RCU		(1 << TICK_DEP_BIT_RCU)
 
 #ifdef CONFIG_NO_HZ_COMMON
 extern bool tick_nohz_enabled;
@@ -257,6 +259,9 @@ static inline bool tick_nohz_full_enabled(void) { return false; }
 static inline bool tick_nohz_full_cpu(int cpu) { return false; }
 static inline void tick_nohz_full_add_cpus_to(struct cpumask *mask) { }
 
+static inline void tick_nohz_dep_set_cpu(int cpu, enum tick_dep_bits bit) { }
+static inline void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit) { }
+
 static inline void tick_dep_set(enum tick_dep_bits bit) { }
 static inline void tick_dep_clear(enum tick_dep_bits bit) { }
 static inline void tick_dep_set_cpu(int cpu, enum tick_dep_bits bit) { }
diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index a57e4ee989d62..350b046e7576c 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -362,7 +362,8 @@ TRACE_EVENT(itimer_expire,
 		tick_dep_name(POSIX_TIMER)		\
 		tick_dep_name(PERF_EVENTS)		\
 		tick_dep_name(SCHED)			\
-		tick_dep_name_end(CLOCK_UNSTABLE)
+		tick_dep_name(CLOCK_UNSTABLE)		\
+		tick_dep_name_end(RCU)
 
 #undef tick_dep_name
 #undef tick_dep_mask_name
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 48403fb653c2f..7228bdd2eabe2 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -199,6 +199,11 @@ static bool check_tick_dependency(atomic_t *dep)
 		return true;
 	}
 
+	if (val & TICK_DEP_MASK_RCU) {
+		trace_tick_stop(0, TICK_DEP_MASK_RCU);
+		return true;
+	}
+
 	return false;
 }
 
@@ -325,6 +330,7 @@ void tick_nohz_dep_set_cpu(int cpu, enum tick_dep_bits bit)
 		preempt_enable();
 	}
 }
+EXPORT_SYMBOL_GPL(tick_nohz_dep_set_cpu);
 
 void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit)
 {
@@ -332,6 +338,7 @@ void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit)
 
 	atomic_andnot(BIT(bit), &ts->tick_dep_mask);
 }
+EXPORT_SYMBOL_GPL(tick_nohz_dep_clear_cpu);
 
 /*
  * Set a per-task tick dependency. Posix CPU timers need this in order to elapse
-- 
2.39.2



