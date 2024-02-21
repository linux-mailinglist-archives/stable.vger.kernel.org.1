Return-Path: <stable+bounces-23131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D4D85DF6A
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B8A1C23BA8
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BB77C08D;
	Wed, 21 Feb 2024 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cXSgRI23"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018FA78B60;
	Wed, 21 Feb 2024 14:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525670; cv=none; b=sCoT3FTH/4IFHJnITCQGx/FR7digWPscVpE6toMsSRzZQdaWGUF/Aw3KMIbwaHityVE36UhdysWeG4zu9wrRMr1ireUwadDJGKANIDsrYnHtJuExj7kNd+gyK9IdIQgtzNwO+jGHJrTReeGC2vbaykNylw5pm4GqDOiBqXlZVlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525670; c=relaxed/simple;
	bh=Wg1cn2uMIqIRas87aCbwN6cZ39JUKqJDR99jeWK6n6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8vbhgRz9jgPLhacY/vtGyY1wzlKAzXwiGxtFaNrf9yt8n0GNOZ60I7U1IgBcrqDgDTd1TrJDQTJ+vgtqOgso6E7ltBzUniRPn48MEDyg9x+6U3+QgfpLsiDkWoCtJMAWLyDCkOTgbZcCZ0DIzscdh3rFDujoXrnan1jKNPEcFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cXSgRI23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D7FC433F1;
	Wed, 21 Feb 2024 14:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708525669;
	bh=Wg1cn2uMIqIRas87aCbwN6cZ39JUKqJDR99jeWK6n6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cXSgRI23Vaz6aG3eUMmSXMzLq7qTO3r48ZBoF7Qjeq7YQMXyIZS+f9c5XbBIQBegH
	 5bxxDsSVdE+egtywOIKvwaWU4q88o7K6MujVJQ/+xRjsVHmiXHacxHlp21LARNcAr/
	 yVQbiPEOqvKvkSrLmOVJ4riIpiJl0fVAZrXh92Xk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5.4 198/267] hrtimer: Report offline hrtimer enqueue
Date: Wed, 21 Feb 2024 14:08:59 +0100
Message-ID: <20240221125946.373802086@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125940.058369148@linuxfoundation.org>
References: <20240221125940.058369148@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frederic Weisbecker <frederic@kernel.org>

commit dad6a09f3148257ac1773cd90934d721d68ab595 upstream.

The hrtimers migration on CPU-down hotplug process has been moved
earlier, before the CPU actually goes to die. This leaves a small window
of opportunity to queue an hrtimer in a blind spot, leaving it ignored.

For example a practical case has been reported with RCU waking up a
SCHED_FIFO task right before the CPUHP_AP_IDLE_DEAD stage, queuing that
way a sched/rt timer to the local offline CPU.

Make sure such situations never go unnoticed and warn when that happens.

Fixes: 5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240129235646.3171983-4-boqun.feng@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/hrtimer.h |    4 +++-
 kernel/time/hrtimer.c   |    3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -196,6 +196,7 @@ enum  hrtimer_base_type {
  * @max_hang_time:	Maximum time spent in hrtimer_interrupt
  * @softirq_expiry_lock: Lock which is taken while softirq based hrtimer are
  *			 expired
+ * @online:		CPU is online from an hrtimers point of view
  * @timer_waiters:	A hrtimer_cancel() invocation waits for the timer
  *			callback to finish.
  * @expires_next:	absolute time of the next event, is required for remote
@@ -218,7 +219,8 @@ struct hrtimer_cpu_base {
 	unsigned int			hres_active		: 1,
 					in_hrtirq		: 1,
 					hang_detected		: 1,
-					softirq_activated       : 1;
+					softirq_activated       : 1,
+					online			: 1;
 #ifdef CONFIG_HIGH_RES_TIMERS
 	unsigned int			nr_events;
 	unsigned short			nr_retries;
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -981,6 +981,7 @@ static int enqueue_hrtimer(struct hrtime
 			   enum hrtimer_mode mode)
 {
 	debug_activate(timer, mode);
+	WARN_ON_ONCE(!base->cpu_base->online);
 
 	base->cpu_base->active_bases |= 1 << base->index;
 
@@ -2069,6 +2070,7 @@ int hrtimers_prepare_cpu(unsigned int cp
 	cpu_base->softirq_next_timer = NULL;
 	cpu_base->expires_next = KTIME_MAX;
 	cpu_base->softirq_expires_next = KTIME_MAX;
+	cpu_base->online = 1;
 	hrtimer_cpu_base_init_expiry_lock(cpu_base);
 	return 0;
 }
@@ -2136,6 +2138,7 @@ int hrtimers_cpu_dying(unsigned int dyin
 	smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);
 
 	raw_spin_unlock(&new_base->lock);
+	old_base->online = 0;
 	raw_spin_unlock(&old_base->lock);
 
 	return 0;



