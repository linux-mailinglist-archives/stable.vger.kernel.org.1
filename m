Return-Path: <stable+bounces-19754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA438534A1
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 16:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19DD31F24D81
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 15:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2C05DF26;
	Tue, 13 Feb 2024 15:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C9ukjvdu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A6npGlaZ"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296C35EE62
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838143; cv=none; b=Y0yyiIgsb3bm9zH6fVQ6g8r19lfw9poKG9MMQA8yMapCdj7jBWbhOc8/SeaTLRAU29BaRwJUY+UYFjLH0ISqrqiHSeE+ChkHPapqIK8A+rlxROUL+YbuDQ8IOdgGoQvwMQu9xYkH8DCLL5ZkztIfi8rFsX39xSn/s9F0LzoTbn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838143; c=relaxed/simple;
	bh=ZhAxJ/hnuf9oA4lbe5AFAIrTNb5FGmxku1yxl0u7QVk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jFAkno3oJ2OdTAcqqYuwPBLAKeHPASTGHu67FAH1Tau7xW1/iFywVFNbv9UxM1OTuCoJulXlbGRkF+U02Bc8ikQrVKP/4SXUQcFAm7AqscdTCGZvZzxUX0bK+JNxeGzBuWoGN7P/4SMq2HTTAj7zTEseJw7DjIvdlhcN/gl4Bvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C9ukjvdu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A6npGlaZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707838139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+wQIQEQ/yp/pdeWENzG1IOOx2hYMz4qyIorNxiPYDdo=;
	b=C9ukjvduMwrAFKi8TuUtkmI4DUhMowvXRVSpaeA4pqcenYPKCI3XMoDVzkf+JsJyX5f73U
	WRfs5oXXY3aG7BNqa3KiW1i2x77kqUQ/FI4gsAppuIfemuVgET7oP3CZCCn1suJRiJBpLI
	+5+q/xZ6hIfIhAr6YzqmHsMN13wF1h5mWZCmmeppnuVc0vEDBV5vTVQQu6trjnGYUwS5/b
	28e8rFWJCYteSIQ78KLzoh8349hDHH9Km1UTFgWT+tmUpT1onc0a79gKxum0pJJy35GOy8
	ARYVjMjmJvziNGimMrOhKDs1xS0ZD6WJV1GW514z9aoux7z8s8+2LuGeIUlqlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707838139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+wQIQEQ/yp/pdeWENzG1IOOx2hYMz4qyIorNxiPYDdo=;
	b=A6npGlaZk9e2c+Dhbdza+LrILTGqwQjj3O9uKezc++9LodH6LilL+pwT9mo2sOMWbXaYyK
	FZ8wBPupS8kpk9Dg==
To: gregkh@linuxfoundation.org, frederic@kernel.org, paulmck@kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 4.19] hrtimer: Report offline hrtimer enqueue
In-Reply-To: <2024021300-sagging-enhance-9113@gregkh>
References: <2024021300-sagging-enhance-9113@gregkh>
Date: Tue, 13 Feb 2024 16:28:59 +0100
Message-ID: <87h6icgz7o.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


From:  Frederic Weisbecker <frederic@kernel.org>

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
---

Backport to 4.19 as tglx has too much spare time...

---
 include/linux/hrtimer.h |    4 +++-
 kernel/time/hrtimer.c   |    3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -182,6 +182,7 @@ enum  hrtimer_base_type {
  * @hang_detected:	The last hrtimer interrupt detected a hang
  * @softirq_activated:	displays, if the softirq is raised - update of softirq
  *			related settings is not required then.
+ * @online:		CPU is online from an hrtimers point of view
  * @nr_events:		Total number of hrtimer interrupt events
  * @nr_retries:		Total number of hrtimer interrupt retries
  * @nr_hangs:		Total number of hrtimer interrupt hangs
@@ -206,7 +207,8 @@ struct hrtimer_cpu_base {
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
@@ -970,6 +970,7 @@ static int enqueue_hrtimer(struct hrtime
 			   enum hrtimer_mode mode)
 {
 	debug_activate(timer, mode);
+	WARN_ON_ONCE(!base->cpu_base->online);
 
 	base->cpu_base->active_bases |= 1 << base->index;
 
@@ -1887,6 +1888,7 @@ int hrtimers_prepare_cpu(unsigned int cp
 	cpu_base->softirq_next_timer = NULL;
 	cpu_base->expires_next = KTIME_MAX;
 	cpu_base->softirq_expires_next = KTIME_MAX;
+	cpu_base->online = 1;
 	return 0;
 }
 
@@ -1953,6 +1955,7 @@ int hrtimers_cpu_dying(unsigned int dyin
 	smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);
 
 	raw_spin_unlock(&new_base->lock);
+	old_base->online = 0;
 	raw_spin_unlock(&old_base->lock);
 
 	return 0;

