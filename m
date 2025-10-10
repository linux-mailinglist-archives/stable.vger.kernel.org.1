Return-Path: <stable+bounces-184016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8292CBCDB1D
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 17:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 056F13561E9
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 15:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FAC2FB0A1;
	Fri, 10 Oct 2025 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwMKTOWj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1860A2FB097
	for <stable@vger.kernel.org>; Fri, 10 Oct 2025 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108620; cv=none; b=U6/FugBVAufncCF8+cgV52lj4ddNyQCcQ2juESxXUo6XUkeYOeE5jk+L0FUMiM3Mnjxw86pBpo/Yyi2xWJ0jrATN1FyK8hFt8CnCWL5YqjLsGtjYKSqGyhdsK05rZMxUnmrmJmAxKqA9xeuQy4HwivGHBzYxzWf/8qoSYTFjYm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108620; c=relaxed/simple;
	bh=FfeWAFL01yrxGNZ9KQqmQL8U/+v/91/EffrzfYdxZZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qDwT9hGaSpjOFhFjYtqE6R1+fOLKGzzg3dzYpVKdIjLqUuZ+Itp7DPLpagXHoaOXwFOCo3p5JKy0YnVZyWG11gW8q3ho0CKm5c4tAbRPPhmD46AHivzaOf6WLmZ5EcGMGyc/MFhEwBCkVUSg6pc9TeiLkevfc/Vi78+ePHd4aqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwMKTOWj; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-782e93932ffso2066218b3a.3
        for <stable@vger.kernel.org>; Fri, 10 Oct 2025 08:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760108618; x=1760713418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0bNeek1LW81/KG2/Q/uicdT1bV3tR+ITFKGtccSqSg=;
        b=PwMKTOWjlKiSl8aZ4Tlq2h2zXpGg1JGTXK+2+563ZeXzobtQwUekS+fZ6BRV/ryzIE
         ppH+oHxz7/46gEn1NADzkUBktoRhQyDNMICbXNroThOcPE4sL76b63ns+fsaueVqhGm9
         F0iSIW0DYN/LatDho76W58TtqfbzaN2AOpRZCACsHNH43sr/GY2OQb91KukM4QxBP9+k
         LiVa29UQdMiYwcsvGbX2pCvOPZfq3PGRDwyjswKcjYEIuq3IQlos3Pza52wMqN6B71vK
         BkbNaqQvpW257zoB0e0Dgubf/14DC4z+uzsGYx5+yrIv3HxVvAUPVdmkzgKxkXQPtKIY
         8GNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108618; x=1760713418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0bNeek1LW81/KG2/Q/uicdT1bV3tR+ITFKGtccSqSg=;
        b=T7jRkJYVJ9gTWAtoHWmj5MT1U4POfTs7KNz/Ct8OtOY5swh00cgazz6jz8aUrrmdJ4
         O/QNrRKcRfPsMP/DtDP7yFRxmKMXRQnzZmsjyGEVn58zgky9S7wkhU18ikgfitaQLSd+
         07CynKLNBypdv2P+yEQccB/YrDm9yy76Z+gQsEoUBfj8JVW0oKvYNV6F7TAqdRMdweBU
         xQTTu2fhgoJ31cMmjgz9NoyDpJt3yi66eGVSAXM2KilmhaWaQLt0sKQ+FP7a6C4uC42o
         i+Hs2ptLFrAEDjJVH3vPVkBYrCf73vnkP5KdoPVOeCSGTVdMedlsia2SAXnpSD3lxHy2
         zHzA==
X-Gm-Message-State: AOJu0YzbSSfPsNButH0/nHTq8oTqGoWL8XI1FWtE4bY2rs1UK0JLm5J5
	xvMn5bTUEYgjkNzs383FfhH99KAPib4bGEGy9C8V+dGvYHJVPdy1sIPFoU7GIwDqTQEUxQ==
X-Gm-Gg: ASbGncssMBKKNGrc433T/O27HRY7SMgyc9B+Q+Ev+L1P/9eyWrO/TfHXZgoYpZ98P2R
	Vebrtr5kvuQCG6Vc2hpIrVqHcDyRZ+A7AeM2pXxTfOt6hKKVXotIaKCBSSmbhIKgBxvNTiGeQdL
	JvJEE/Fq8zZT6hPyLg2UqMZhX1x/vihJoFtaoEwjPFEEjHmxE2JN5Xyrd9NOOwGEXGJ5k8KL63k
	fUN1CLqzL6IxQXCQ8UOKH3jG2XROJ6XIKKhoB0JcU3WtUPUtyeTZT5YhREmKvZjfcm2ZebK3UNx
	0laWVwGNwNjZ0b3BaamCKkteNPDDnDGsLJiEtoLuyk9iBVg/wIUmcOxObvrfflFqLIUFSXxCQ+L
	X1MYU7kP7lUPizWVQWYm1GvnUPbWb9+3IQqT3lW2hFjl7t5KmyChJxnrUPWNX8w//mTJ+MzKPW5
	iu+1QxWoJNzFNABQ==
X-Google-Smtp-Source: AGHT+IESNC8RkQTBaynIxPs6OR43ASsf0mjK4WexzZ/IzmWVAMQfi+tV6noR5/B9CBVHAqdLTCbbEg==
X-Received: by 2002:a05:6a00:3c84:b0:781:1e80:f0c6 with SMTP id d2e1a72fcca58-79387440a4dmr15774554b3a.17.1760108617993;
        Fri, 10 Oct 2025 08:03:37 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b639cbcsm3266359b3a.18.2025.10.10.08.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 08:03:37 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	Julia.Lawall@inria.fr,
	akpm@linux-foundation.org,
	anna-maria@linutronix.de,
	arnd@arndb.de,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	maz@kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sboyd@kernel.org,
	viresh.kumar@linaro.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH 6.1.y 08/12] timers: Split [try_to_]del_timer[_sync]() to prepare for shutdown mode
Date: Sat, 11 Oct 2025 00:02:48 +0900
Message-Id: <20251010150252.1115788-9-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010150252.1115788-1-aha310510@gmail.com>
References: <20251010150252.1115788-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 8553b5f2774a66b1f293b7d783934210afb8f23c ]

Tearing down timers which have circular dependencies to other
functionality, e.g. workqueues, where the timer can schedule work and work
can arm timers, is not trivial.

In those cases it is desired to shutdown the timer in a way which prevents
rearming of the timer. The mechanism to do so is to set timer->function to
NULL and use this as an indicator for the timer arming functions to ignore
the (re)arm request.

Split the inner workings of try_do_del_timer_sync(), del_timer_sync() and
del_timer() into helper functions to prepare for implementing the shutdown
functionality.

No functional change.

Co-developed-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home
Link: https://lore.kernel.org/all/20221110064101.429013735@goodmis.org
Link: https://lore.kernel.org/r/20221123201625.195147423@linutronix.de
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 kernel/time/timer.c | 143 ++++++++++++++++++++++++++++----------------
 1 file changed, 92 insertions(+), 51 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 3b6624cd9507..0b76a2ab42e3 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1298,20 +1298,14 @@ void add_timer_on(struct timer_list *timer, int cpu)
 EXPORT_SYMBOL_GPL(add_timer_on);
 
 /**
- * timer_delete - Deactivate a timer
+ * __timer_delete - Internal function: Deactivate a timer
  * @timer:	The timer to be deactivated
  *
- * The function only deactivates a pending timer, but contrary to
- * timer_delete_sync() it does not take into account whether the timer's
- * callback function is concurrently executed on a different CPU or not.
- * It neither prevents rearming of the timer. If @timer can be rearmed
- * concurrently then the return value of this function is meaningless.
- *
  * Return:
  * * %0 - The timer was not pending
  * * %1 - The timer was pending and deactivated
  */
-int timer_delete(struct timer_list *timer)
+static int __timer_delete(struct timer_list *timer)
 {
 	struct timer_base *base;
 	unsigned long flags;
@@ -1327,25 +1321,37 @@ int timer_delete(struct timer_list *timer)
 
 	return ret;
 }
-EXPORT_SYMBOL(timer_delete);
 
 /**
- * try_to_del_timer_sync - Try to deactivate a timer
- * @timer:	Timer to deactivate
+ * timer_delete - Deactivate a timer
+ * @timer:	The timer to be deactivated
  *
- * This function tries to deactivate a timer. On success the timer is not
- * queued and the timer callback function is not running on any CPU.
+ * The function only deactivates a pending timer, but contrary to
+ * timer_delete_sync() it does not take into account whether the timer's
+ * callback function is concurrently executed on a different CPU or not.
+ * It neither prevents rearming of the timer.  If @timer can be rearmed
+ * concurrently then the return value of this function is meaningless.
  *
- * This function does not guarantee that the timer cannot be rearmed right
- * after dropping the base lock. That needs to be prevented by the calling
- * code if necessary.
+ * Return:
+ * * %0 - The timer was not pending
+ * * %1 - The timer was pending and deactivated
+ */
+int timer_delete(struct timer_list *timer)
+{
+	return __timer_delete(timer);
+}
+EXPORT_SYMBOL(timer_delete);
+
+/**
+ * __try_to_del_timer_sync - Internal function: Try to deactivate a timer
+ * @timer:	Timer to deactivate
  *
  * Return:
  * * %0  - The timer was not pending
  * * %1  - The timer was pending and deactivated
  * * %-1 - The timer callback function is running on a different CPU
  */
-int try_to_del_timer_sync(struct timer_list *timer)
+static int __try_to_del_timer_sync(struct timer_list *timer)
 {
 	struct timer_base *base;
 	unsigned long flags;
@@ -1362,6 +1368,27 @@ int try_to_del_timer_sync(struct timer_list *timer)
 
 	return ret;
 }
+
+/**
+ * try_to_del_timer_sync - Try to deactivate a timer
+ * @timer:	Timer to deactivate
+ *
+ * This function tries to deactivate a timer. On success the timer is not
+ * queued and the timer callback function is not running on any CPU.
+ *
+ * This function does not guarantee that the timer cannot be rearmed right
+ * after dropping the base lock. That needs to be prevented by the calling
+ * code if necessary.
+ *
+ * Return:
+ * * %0  - The timer was not pending
+ * * %1  - The timer was pending and deactivated
+ * * %-1 - The timer callback function is running on a different CPU
+ */
+int try_to_del_timer_sync(struct timer_list *timer)
+{
+	return __try_to_del_timer_sync(timer);
+}
 EXPORT_SYMBOL(try_to_del_timer_sync);
 
 #ifdef CONFIG_PREEMPT_RT
@@ -1438,45 +1465,15 @@ static inline void del_timer_wait_running(struct timer_list *timer) { }
 #endif
 
 /**
- * timer_delete_sync - Deactivate a timer and wait for the handler to finish.
+ * __timer_delete_sync - Internal function: Deactivate a timer and wait
+ *			 for the handler to finish.
  * @timer:	The timer to be deactivated
  *
- * Synchronization rules: Callers must prevent restarting of the timer,
- * otherwise this function is meaningless. It must not be called from
- * interrupt contexts unless the timer is an irqsafe one. The caller must
- * not hold locks which would prevent completion of the timer's callback
- * function. The timer's handler must not call add_timer_on(). Upon exit
- * the timer is not queued and the handler is not running on any CPU.
- *
- * For !irqsafe timers, the caller must not hold locks that are held in
- * interrupt context. Even if the lock has nothing to do with the timer in
- * question.  Here's why::
- *
- *    CPU0                             CPU1
- *    ----                             ----
- *                                     <SOFTIRQ>
- *                                       call_timer_fn();
- *                                       base->running_timer = mytimer;
- *    spin_lock_irq(somelock);
- *                                     <IRQ>
- *                                        spin_lock(somelock);
- *    timer_delete_sync(mytimer);
- *    while (base->running_timer == mytimer);
- *
- * Now timer_delete_sync() will never return and never release somelock.
- * The interrupt on the other CPU is waiting to grab somelock but it has
- * interrupted the softirq that CPU0 is waiting to finish.
- *
- * This function cannot guarantee that the timer is not rearmed again by
- * some concurrent or preempting code, right after it dropped the base
- * lock. If there is the possibility of a concurrent rearm then the return
- * value of the function is meaningless.
- *
  * Return:
  * * %0	- The timer was not pending
  * * %1	- The timer was pending and deactivated
  */
-int timer_delete_sync(struct timer_list *timer)
+static int __timer_delete_sync(struct timer_list *timer)
 {
 	int ret;
 
@@ -1506,7 +1503,7 @@ int timer_delete_sync(struct timer_list *timer)
 		lockdep_assert_preemption_enabled();
 
 	do {
-		ret = try_to_del_timer_sync(timer);
+		ret = __try_to_del_timer_sync(timer);
 
 		if (unlikely(ret < 0)) {
 			del_timer_wait_running(timer);
@@ -1516,6 +1513,50 @@ int timer_delete_sync(struct timer_list *timer)
 
 	return ret;
 }
+
+/**
+ * timer_delete_sync - Deactivate a timer and wait for the handler to finish.
+ * @timer:	The timer to be deactivated
+ *
+ * Synchronization rules: Callers must prevent restarting of the timer,
+ * otherwise this function is meaningless. It must not be called from
+ * interrupt contexts unless the timer is an irqsafe one. The caller must
+ * not hold locks which would prevent completion of the timer's callback
+ * function. The timer's handler must not call add_timer_on(). Upon exit
+ * the timer is not queued and the handler is not running on any CPU.
+ *
+ * For !irqsafe timers, the caller must not hold locks that are held in
+ * interrupt context. Even if the lock has nothing to do with the timer in
+ * question.  Here's why::
+ *
+ *    CPU0                             CPU1
+ *    ----                             ----
+ *                                     <SOFTIRQ>
+ *                                       call_timer_fn();
+ *                                       base->running_timer = mytimer;
+ *    spin_lock_irq(somelock);
+ *                                     <IRQ>
+ *                                        spin_lock(somelock);
+ *    timer_delete_sync(mytimer);
+ *    while (base->running_timer == mytimer);
+ *
+ * Now timer_delete_sync() will never return and never release somelock.
+ * The interrupt on the other CPU is waiting to grab somelock but it has
+ * interrupted the softirq that CPU0 is waiting to finish.
+ *
+ * This function cannot guarantee that the timer is not rearmed again by
+ * some concurrent or preempting code, right after it dropped the base
+ * lock. If there is the possibility of a concurrent rearm then the return
+ * value of the function is meaningless.
+ *
+ * Return:
+ * * %0	- The timer was not pending
+ * * %1	- The timer was pending and deactivated
+ */
+int timer_delete_sync(struct timer_list *timer)
+{
+	return __timer_delete_sync(timer);
+}
 EXPORT_SYMBOL(timer_delete_sync);
 
 static void call_timer_fn(struct timer_list *timer,
--

