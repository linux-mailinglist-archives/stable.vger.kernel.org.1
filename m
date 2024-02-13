Return-Path: <stable+bounces-19708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E38085311D
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 14:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8326FB24B0F
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 13:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4B14F610;
	Tue, 13 Feb 2024 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VA6cFnoF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0204F5FD
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707829204; cv=none; b=eOy/+VmQrVVwI7fThqCWDE/rivBO1otkpY8ZZzyAZrvGh5fbU944FxXmlz50BlkyggD+xYQ3ETNDbq6dmMBVtAa7qquO0GHPpolc9rj6pM7iitJbdMEt8Ziv+MDQ29coC50Y8fyql4FVcfVRGXSi8hBQ1MGMWuaAhdM+UdAsmJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707829204; c=relaxed/simple;
	bh=N8g9rWs7i7FIOn21ZfBl3kGqiGTwjCiQVWdpiPUD/9I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uYncYSINBBtH3Y43B66xggv2S/ArWEIsXbxd7udXJGm0aeiJXoSUb+WhgfOOvw/JxJJhC14/oNE5UeU6sxZapvhaxHGa13xjuUKMY/iIvJEPkIOGIz6xP6A0GOCHKIV5RYQr/8CXDZ0TVf66xQlRuV4X7/c/fxnVutqXrReTqaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VA6cFnoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4514C433F1;
	Tue, 13 Feb 2024 13:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707829204;
	bh=N8g9rWs7i7FIOn21ZfBl3kGqiGTwjCiQVWdpiPUD/9I=;
	h=Subject:To:Cc:From:Date:From;
	b=VA6cFnoF9sRj67LAQHEZ9O7F/nmiw2RUfpF+EoIppRRv64J96d7YzX2g8CpR3Smp5
	 314OfBG58Rz3+t+Jr8jvIHWvS9ThcNVdIjrqle2pHp5CPOu860bS5Lg8GLbPGVnV3U
	 1m628GkGYvX5t2fMv6C9ZZgqtTGBuxYWQySzMiwM=
Subject: FAILED: patch "[PATCH] hrtimer: Report offline hrtimer enqueue" failed to apply to 4.19-stable tree
To: frederic@kernel.org,paulmck@kernel.org,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 13 Feb 2024 14:00:00 +0100
Message-ID: <2024021300-sagging-enhance-9113@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x dad6a09f3148257ac1773cd90934d721d68ab595
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021300-sagging-enhance-9113@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

dad6a09f3148 ("hrtimer: Report offline hrtimer enqueue")
5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
f61eff83cec9 ("hrtimer: Prepare support for PREEMPT_RT")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dad6a09f3148257ac1773cd90934d721d68ab595 Mon Sep 17 00:00:00 2001
From: Frederic Weisbecker <frederic@kernel.org>
Date: Mon, 29 Jan 2024 15:56:36 -0800
Subject: [PATCH] hrtimer: Report offline hrtimer enqueue

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

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 87e3bedf8eb0..641c4567cfa7 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -157,6 +157,7 @@ enum  hrtimer_base_type {
  * @max_hang_time:	Maximum time spent in hrtimer_interrupt
  * @softirq_expiry_lock: Lock which is taken while softirq based hrtimer are
  *			 expired
+ * @online:		CPU is online from an hrtimers point of view
  * @timer_waiters:	A hrtimer_cancel() invocation waits for the timer
  *			callback to finish.
  * @expires_next:	absolute time of the next event, is required for remote
@@ -179,7 +180,8 @@ struct hrtimer_cpu_base {
 	unsigned int			hres_active		: 1,
 					in_hrtirq		: 1,
 					hang_detected		: 1,
-					softirq_activated       : 1;
+					softirq_activated       : 1,
+					online			: 1;
 #ifdef CONFIG_HIGH_RES_TIMERS
 	unsigned int			nr_events;
 	unsigned short			nr_retries;
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 760793998cdd..edb0f821dcea 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1085,6 +1085,7 @@ static int enqueue_hrtimer(struct hrtimer *timer,
 			   enum hrtimer_mode mode)
 {
 	debug_activate(timer, mode);
+	WARN_ON_ONCE(!base->cpu_base->online);
 
 	base->cpu_base->active_bases |= 1 << base->index;
 
@@ -2183,6 +2184,7 @@ int hrtimers_prepare_cpu(unsigned int cpu)
 	cpu_base->softirq_next_timer = NULL;
 	cpu_base->expires_next = KTIME_MAX;
 	cpu_base->softirq_expires_next = KTIME_MAX;
+	cpu_base->online = 1;
 	hrtimer_cpu_base_init_expiry_lock(cpu_base);
 	return 0;
 }
@@ -2250,6 +2252,7 @@ int hrtimers_cpu_dying(unsigned int dying_cpu)
 	smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);
 
 	raw_spin_unlock(&new_base->lock);
+	old_base->online = 0;
 	raw_spin_unlock(&old_base->lock);
 
 	return 0;


