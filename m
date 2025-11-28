Return-Path: <stable+bounces-197611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C4BC92867
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 17:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 01E9234868D
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 16:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C0733033A;
	Fri, 28 Nov 2025 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYhaCsCl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B292C15AB
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764345998; cv=none; b=j6NeoVxNHnPWLwvGwoNraVcKoe0G9N4Jo+DDfJC0JezvS0DGBS56H0Pc/llLQZqRYYWn6XcfNusyMkTPRomF35HHYnc6tWBpNdgOZOcQ79xv4T1tV4DFP4MmrmX29O8q9pDKeO/jA7m3sPxEemcIQD2qzUwOcVTPoZ0BlWkRWXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764345998; c=relaxed/simple;
	bh=A7NZvw6BwM3JH9LFTZM0pkj7MM2Mf/KMJNxtIByaxbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bRE/IJKhqMK80fmzMlh1laNKHQRx1osPekbjhS387BtJYY3SWr1xaR/rCumgj/4KvW4SzwYVkIDj6Ez1qNn1Mxxy53zE+Y2b8sJb+mk+1Cs7NDPQcWsNFJ2H/MzfGv1FY1+H3t2f+kudYg7XuferHutfeOL1xcgKpktwtJnDAgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYhaCsCl; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7bb3092e4d7so2102366b3a.0
        for <stable@vger.kernel.org>; Fri, 28 Nov 2025 08:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764345996; x=1764950796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIvAwaANSEMHidUC241SU/ATL2QFU3HABzkGaIq1H88=;
        b=MYhaCsClS+WoMgwkCexc+jqHtqfk7wjuxPEoGMCoz2gXOmavZWF7YsM8gpzZiQxQhK
         irmoW7CEl/8DsjX+V44wwhQ6pxDgF1zw5PXWcBGJk+aOwhbYaWq6JNr6IKCJsiLCQ/xJ
         1itMMAFkdTzQLpticTdw3aI+0SP4p2voGWLjhXVOA4a7mabh/yw/byuh8XjRHlshShzn
         l4IVaGSdYMg3l6A9/cSvhqoxkn+9iLfHnsYXv6nogtdBK9sUhySnXPt2MAe8p39gDcxC
         8ATnf6GfNpoRSzYkFs7ZPhhnF2tf3LlleTxb0QOdBVjNhOZFdkd3wGCw5b95OEnZeyjO
         W6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764345996; x=1764950796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HIvAwaANSEMHidUC241SU/ATL2QFU3HABzkGaIq1H88=;
        b=oikipPCfFyHfuH6/wUMwK6WsqsbHdWcvU4QBC+DZBuRpi/CQUKGdhyqKBV4i2eQabA
         1sgiMKNJyooeAaDw8M546LDlg0RCuBfPSHVXxnj9OynnAHA4h7yQiY6kW1Paid/yIFgE
         hzHDV/qvDIJ0TT6fw9cqoIBqy9q0E4cWvqASjIRkgmy/Wbe+aQPxTV4Y/74PclurtSa8
         +cbmrtfleKbsmxcs/DigFRvP8b/JjlqsSwAnMltM9NPLKI9ZukOr7gkHGV7sIkotPUil
         zzskz1NeBDFr9/2k5NrKCojSCc3UgdDC9rZ1QJG/g9u7ffEj1WWeJRUGHaDyV9wab4pQ
         QZPg==
X-Gm-Message-State: AOJu0Yz73THEU2IQvqKqSSGBuLpeptB/RGgHquvEAhP7Yz9ljasuaN/m
	lpM25RdHxM1hIh2dI1r3YliHKGrli+5qP+e7rrpTIeGw/Doy5paJ/iL1daE2HFzGSIYYvQ==
X-Gm-Gg: ASbGncvfNBPBl7aXGANJqid/s6cfDJSm3o83NDgZUzZhnPApT15hxXwXy4oaNQwzOcS
	tL1cvA3MzyKBRaJfC6y1qV/8fwxIIULA/tDZvPQcqXBqgLuCGhwXj0l8rqQGigKajTSe9z6q0D+
	gqqL7i34Xdakxb6MBjS07Z1b7LL4JhwLtXliv/lXEjqYBH+UuPZkud7M+AQuFODUnSsc7AJnbnI
	Y7j6Xlk6j6XHv8SEd99wb0K6K9J6nEqJ4eCCR3p1D0Iwzi49wbXgQW8vx0Gfs2/8l14ooJr1EbY
	6lNxBwl9+UWvZeePQWVgXt9QFoSyGpr1ADXisDC7g/Mlu+wwypIHODJf/kvyf5FgLOQytbdT354
	7ufx7d6/BPXlZaTQf0xlDyOeDIj+n5CdGkoR5bv2uDsHdf/EB5iwDIhUh2b/fiRUsSGHNrAW1uQ
	XEcZy7SqExvVBqjz4iT7Jmb2ZknF5cQv+ckoBb8Q==
X-Google-Smtp-Source: AGHT+IFLg5ORPm0TEtuxOShEmNUFI7ZjoXaSp/U/kqJZNCs3wbN4/+zsI460r5w0wy7yoJqUDfaS3A==
X-Received: by 2002:a05:6a20:1592:b0:35d:d477:a7ff with SMTP id adf61e73a8af0-3614eb798e6mr32656783637.21.1764345995543;
        Fri, 28 Nov 2025 08:06:35 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f26f11fsm5408499b3a.50.2025.11.28.08.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 08:06:34 -0800 (PST)
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
	aha310510@gmail.com,
	linux-staging@lists.linux.dev,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 5.15.y 09/14] timers: Silently ignore timers with a NULL function
Date: Sat, 29 Nov 2025 01:05:34 +0900
Message-Id: <20251128160539.358938-10-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251128160539.358938-1-aha310510@gmail.com>
References: <20251128160539.358938-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit d02e382cef06cc73561dd32dfdc171c00dcc416d ]

Tearing down timers which have circular dependencies to other
functionality, e.g. workqueues, where the timer can schedule work and work
can arm timers, is not trivial.

In those cases it is desired to shutdown the timer in a way which prevents
rearming of the timer. The mechanism to do so is to set timer->function to
NULL and use this as an indicator for the timer arming functions to ignore
the (re)arm request.

In preparation for that replace the warnings in the relevant code paths
with checks for timer->function == NULL. If the pointer is NULL, then
discard the rearm request silently.

Add debug_assert_init() instead of the WARN_ON_ONCE(!timer->function)
checks so that debug objects can warn about non-initialized timers.

The warning of debug objects does not warn if timer->function == NULL.  It
warns when timer was not initialized using timer_setup[_on_stack]() or via
DEFINE_TIMER(). If developers fail to enable debug objects and then waste
lots of time to figure out why their non-initialized timer is not firing,
they deserve it. Same for initializing a timer with a NULL function.

Co-developed-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home
Link: https://lore.kernel.org/all/20221110064101.429013735@goodmis.org
Link: https://lore.kernel.org/r/87wn7kdann.ffs@tglx
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 kernel/time/timer.c | 57 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 5 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 7094b916c854..3b6624cd9507 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1017,7 +1017,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 	unsigned int idx = UINT_MAX;
 	int ret = 0;
 
-	BUG_ON(!timer->function);
+	debug_assert_init(timer);
 
 	/*
 	 * This is a common optimization triggered by the networking code - if
@@ -1044,6 +1044,14 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 		 * dequeue/enqueue dance.
 		 */
 		base = lock_timer_base(timer, &flags);
+		/*
+		 * Has @timer been shutdown? This needs to be evaluated
+		 * while holding base lock to prevent a race against the
+		 * shutdown code.
+		 */
+		if (!timer->function)
+			goto out_unlock;
+
 		forward_timer_base(base);
 
 		if (timer_pending(timer) && (options & MOD_TIMER_REDUCE) &&
@@ -1070,6 +1078,14 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 		}
 	} else {
 		base = lock_timer_base(timer, &flags);
+		/*
+		 * Has @timer been shutdown? This needs to be evaluated
+		 * while holding base lock to prevent a race against the
+		 * shutdown code.
+		 */
+		if (!timer->function)
+			goto out_unlock;
+
 		forward_timer_base(base);
 	}
 
@@ -1128,8 +1144,12 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
  * mod_timer_pending() is the same for pending timers as mod_timer(), but
  * will not activate inactive timers.
  *
+ * If @timer->function == NULL then the start operation is silently
+ * discarded.
+ *
  * Return:
- * * %0 - The timer was inactive and not modified
+ * * %0 - The timer was inactive and not modified or was in
+ *	  shutdown state and the operation was discarded
  * * %1 - The timer was active and requeued to expire at @expires
  */
 int mod_timer_pending(struct timer_list *timer, unsigned long expires)
@@ -1155,8 +1175,12 @@ EXPORT_SYMBOL(mod_timer_pending);
  * same timer, then mod_timer() is the only safe way to modify the timeout,
  * since add_timer() cannot modify an already running timer.
  *
+ * If @timer->function == NULL then the start operation is silently
+ * discarded. In this case the return value is 0 and meaningless.
+ *
  * Return:
- * * %0 - The timer was inactive and started
+ * * %0 - The timer was inactive and started or was in shutdown
+ *	  state and the operation was discarded
  * * %1 - The timer was active and requeued to expire at @expires or
  *	  the timer was active and not modified because @expires did
  *	  not change the effective expiry time
@@ -1176,8 +1200,12 @@ EXPORT_SYMBOL(mod_timer);
  * modify an enqueued timer if that would reduce the expiration time. If
  * @timer is not enqueued it starts the timer.
  *
+ * If @timer->function == NULL then the start operation is silently
+ * discarded.
+ *
  * Return:
- * * %0 - The timer was inactive and started
+ * * %0 - The timer was inactive and started or was in shutdown
+ *	  state and the operation was discarded
  * * %1 - The timer was active and requeued to expire at @expires or
  *	  the timer was active and not modified because @expires
  *	  did not change the effective expiry time such that the
@@ -1200,6 +1228,9 @@ EXPORT_SYMBOL(timer_reduce);
  * The @timer->expires and @timer->function fields must be set prior
  * to calling this function.
  *
+ * If @timer->function == NULL then the start operation is silently
+ * discarded.
+ *
  * If @timer->expires is already in the past @timer will be queued to
  * expire at the next timer tick.
  *
@@ -1228,7 +1259,9 @@ void add_timer_on(struct timer_list *timer, int cpu)
 	struct timer_base *new_base, *base;
 	unsigned long flags;
 
-	if (WARN_ON_ONCE(timer_pending(timer) || !timer->function))
+	debug_assert_init(timer);
+
+	if (WARN_ON_ONCE(timer_pending(timer)))
 		return;
 
 	new_base = get_timer_cpu_base(timer->flags, cpu);
@@ -1239,6 +1272,13 @@ void add_timer_on(struct timer_list *timer, int cpu)
 	 * wrong base locked.  See lock_timer_base().
 	 */
 	base = lock_timer_base(timer, &flags);
+	/*
+	 * Has @timer been shutdown? This needs to be evaluated while
+	 * holding base lock to prevent a race against the shutdown code.
+	 */
+	if (!timer->function)
+		goto out_unlock;
+
 	if (base != new_base) {
 		timer->flags |= TIMER_MIGRATING;
 
@@ -1252,6 +1292,7 @@ void add_timer_on(struct timer_list *timer, int cpu)
 
 	debug_timer_activate(timer);
 	internal_add_timer(base, timer);
+out_unlock:
 	raw_spin_unlock_irqrestore(&base->lock, flags);
 }
 EXPORT_SYMBOL_GPL(add_timer_on);
@@ -1541,6 +1582,12 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
 
 		fn = timer->function;
 
+		if (WARN_ON_ONCE(!fn)) {
+			/* Should never happen. Emphasis on should! */
+			base->running_timer = NULL;
+			continue;
+		}
+
 		if (timer->flags & TIMER_IRQSAFE) {
 			raw_spin_unlock(&base->lock);
 			call_timer_fn(timer, fn, baseclk);
--

