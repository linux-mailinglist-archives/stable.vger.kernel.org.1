Return-Path: <stable+bounces-217478-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OGmJtZGl2m2wQIAu9opvQ
	(envelope-from <stable+bounces-217478-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:22:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46593161223
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5482431384A1
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 17:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AFB3502B6;
	Thu, 19 Feb 2026 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgRX22We"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDA7350D55
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 17:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521249; cv=none; b=KRjlsxt72riGG/tXoEIbFRipYmfO+LyjbTc0uT2g+IpjPLQSHyWDYoupMwJAtOvQeNZWlmbrPmi/ZBFCkR89tNWL2vLiR1UAFf41apWpVtg9Uc8UOzv9FH7b/Py5MNv2GAcTtpKiW+FyAMrxnuSvjKjO0LhzN29F/sGraBO2S3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521249; c=relaxed/simple;
	bh=J7+paRiPLaCD/c+KTz8seNjK8t39KhNj40mTnjX9HD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=io/ooKo6QsghbYJb47N0gStN6mwRg/UQ7G7hDN2hjisnwHspq3a5QHBEwEdBSYLRsbcNVMr8aRcYtKZlore1XABEqXoHoTgUzLsLP8jzopkpghQyIEVgCvlyb9obvmq1sJGgjiNsfhKvmAjC9s2MvnuLttFXEs2+h8MXbdcygOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgRX22We; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8231061d234so934737b3a.1
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 09:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771521246; x=1772126046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkZJqZ3kQT2WglZ48UatqwsWbUOwu2gzPSjhRt06PHw=;
        b=kgRX22WeMszm0lbN6aVORu4ACNzYgkL2yG+In274D2/zZBMrVEj3yE0df0DvSHPNvc
         Es2U/vQ3tL0HP6BzLbd5NWPnmk7kcjNM1wCFU39WVQUZ+seMYw9NfO+sa2PdZAsdGn0b
         6RNMJAvZQ33SzAEJo2JkiaUTHrA2bN2/UrEJ1+XwH3PjTfHqiG2NWRhcWnWIYG0qQtC2
         csptSjwKBhh3yS6U9+gEeRNEf01dwf4r+S4wRad7lRYIRr8Fka7LECkZN7yiq41CjnlP
         wJOK2ACy1yHIG34Ycf7jvd2jHNg0rwkuXWvMj3OVOZH7xzhC1IYye3TZapvpjGs9Q59z
         giyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521246; x=1772126046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rkZJqZ3kQT2WglZ48UatqwsWbUOwu2gzPSjhRt06PHw=;
        b=aW6jB1Ml2HpHZME2zbCEmSk5b7rqDem24RcICpHd/C3JGONWmSLfPBVZfiBv/D/4Na
         1NQttCIIkOVgvYqzTLTZRbEsbF9eHsqj8KrRFUSIO0s0n9pKVMeZWujRhtqkXVUjbwS8
         BRb7iESWBSmy7uempgiYUORwB8mWR25Q/FUDG6IoqYBdjUNuBW5OVHJ8erSUeNwkvg8V
         P1qyH/AIAUztG+y0nAYQRP+S76Gm8sAyUeDC/W26ZjKc4h+qEi7gAuGGKmvksP826qLk
         dKVNtcOiLavOb8qwVAMTgrpbSm+ruJmJulmx0ggOj2sbFoIQKf5mWKTQgv/iYEk2V4PZ
         XELQ==
X-Gm-Message-State: AOJu0YwNAoVVjS9hTI4ST2e4mq3nuyFcAVlzBHZAxiVzsvIbucROJsgU
	5yxwpSOXbAoZgbGkjECTu4UnF8DyEH4PUpQH58koqPW+swIDFD9lurTofBzVk0iK
X-Gm-Gg: AZuq6aIdfadNX3DoegZdLqFiqy5WwU2kEJvMo1WOumjZo1ej0igl4+kPE3zZQHsSkML
	4wumAnY//lVEq4QhxY2lSCarOxuzXJcr1hOgbyfvpiMzXoMvuTfasLY1y5oWs4HuC9Z01WuiLFa
	b3jY2h7rtaHx5o5YauP6A5q/YFMMOvDMQEkQPZL5fgfyceUBqVEhPxV5PWPJX9BH6TlP1py8X4N
	R8bXG0RvDj5jkLptIbdXuqLLiLP3Fx/kRACHc0MCj2VzYZr3JAZWqgxsKrcjDw8CP9+F53o36Uw
	a20vPd8L/5fFOlTtFW1ny4bfcbVOeybwFVRajDAKWmjz03LxtsLvX/k5jqTsnrAY5BvawWoJvvv
	zr4HAW7HkpJX9A9m+ND4+2OugikuxMsFKZVrDatwPgOyBUjSwY2g27Em2NMrllwiFj03QurV+Qb
	J7stf1joOZRHc5i8JGrNLGY0bR3F+fjM71lGgyQYux6BdjpNtIJw==
X-Received: by 2002:a05:6a21:2982:b0:394:662e:89ab with SMTP id adf61e73a8af0-394fc24ddc9mr5454817637.23.1771521246359;
        Thu, 19 Feb 2026 09:14:06 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.236.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e532fa2e5sm15895002a12.26.2026.02.19.09.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:14:05 -0800 (PST)
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
	zouyipeng@huawei.com,
	aha310510@gmail.com,
	linux-staging@lists.linux.dev,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 5.10.y 12/15] timers: Provide timer_shutdown[_sync]()
Date: Fri, 20 Feb 2026 02:13:07 +0900
Message-Id: <20260219171310.118170-13-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219171310.118170-1-aha310510@gmail.com>
References: <20260219171310.118170-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,linutronix.de,inria.fr,linux-foundation.org,arndb.de,vger.kernel.org,roeck-us.net,gmail.com,holtmann.org,kernel.org,infradead.org,goodmis.org,linaro.org,huawei.com,lists.linux.dev,intel.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-217478-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aha310510@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,goodmis.org:email,intel.com:email,roeck-us.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 46593161223
X-Rspamd-Action: no action

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit f571faf6e443b6011ccb585d57866177af1f643c ]

Tearing down timers which have circular dependencies to other
functionality, e.g. workqueues, where the timer can schedule work and work
can arm timers, is not trivial.

In those cases it is desired to shutdown the timer in a way which prevents
rearming of the timer. The mechanism to do so is to set timer->function to
NULL and use this as an indicator for the timer arming functions to ignore
the (re)arm request.

Expose new interfaces for this: timer_shutdown_sync() and timer_shutdown().

timer_shutdown_sync() has the same functionality as timer_delete_sync()
plus the NULL-ification of the timer function.

timer_shutdown() has the same functionality as timer_delete() plus the
NULL-ification of the timer function.

In both cases the rearming of the timer is prevented by silently discarding
rearm attempts due to timer->function being NULL.

Co-developed-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home
Link: https://lore.kernel.org/all/20221110064101.429013735@goodmis.org
Link: https://lore.kernel.org/r/20221123201625.314230270@linutronix.de
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 include/linux/timer.h |  2 ++
 kernel/time/timer.c   | 66 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index e338e173ce8b..9162f275819a 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -184,6 +184,8 @@ extern void add_timer(struct timer_list *timer);
 extern int try_to_del_timer_sync(struct timer_list *timer);
 extern int timer_delete_sync(struct timer_list *timer);
 extern int timer_delete(struct timer_list *timer);
+extern int timer_shutdown_sync(struct timer_list *timer);
+extern int timer_shutdown(struct timer_list *timer);
 
 /**
  * del_timer_sync - Delete a pending timer and wait for a running callback
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index b46614e14da1..4f39025ac933 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1362,6 +1362,27 @@ int timer_delete(struct timer_list *timer)
 }
 EXPORT_SYMBOL(timer_delete);
 
+/**
+ * timer_shutdown - Deactivate a timer and prevent rearming
+ * @timer:	The timer to be deactivated
+ *
+ * The function does not wait for an eventually running timer callback on a
+ * different CPU but it prevents rearming of the timer. Any attempt to arm
+ * @timer after this function returns will be silently ignored.
+ *
+ * This function is useful for teardown code and should only be used when
+ * timer_shutdown_sync() cannot be invoked due to locking or context constraints.
+ *
+ * Return:
+ * * %0 - The timer was not pending
+ * * %1 - The timer was pending
+ */
+int timer_shutdown(struct timer_list *timer)
+{
+	return __timer_delete(timer, true);
+}
+EXPORT_SYMBOL_GPL(timer_shutdown);
+
 /**
  * __try_to_del_timer_sync - Internal function: Try to deactivate a timer
  * @timer:	Timer to deactivate
@@ -1595,6 +1616,9 @@ static int __timer_delete_sync(struct timer_list *timer, bool shutdown)
  * lock. If there is the possibility of a concurrent rearm then the return
  * value of the function is meaningless.
  *
+ * If such a guarantee is needed, e.g. for teardown situations then use
+ * timer_shutdown_sync() instead.
+ *
  * Return:
  * * %0	- The timer was not pending
  * * %1	- The timer was pending and deactivated
@@ -1605,6 +1629,48 @@ int timer_delete_sync(struct timer_list *timer)
 }
 EXPORT_SYMBOL(timer_delete_sync);
 
+/**
+ * timer_shutdown_sync - Shutdown a timer and prevent rearming
+ * @timer: The timer to be shutdown
+ *
+ * When the function returns it is guaranteed that:
+ *   - @timer is not queued
+ *   - The callback function of @timer is not running
+ *   - @timer cannot be enqueued again. Any attempt to rearm
+ *     @timer is silently ignored.
+ *
+ * See timer_delete_sync() for synchronization rules.
+ *
+ * This function is useful for final teardown of an infrastructure where
+ * the timer is subject to a circular dependency problem.
+ *
+ * A common pattern for this is a timer and a workqueue where the timer can
+ * schedule work and work can arm the timer. On shutdown the workqueue must
+ * be destroyed and the timer must be prevented from rearming. Unless the
+ * code has conditionals like 'if (mything->in_shutdown)' to prevent that
+ * there is no way to get this correct with timer_delete_sync().
+ *
+ * timer_shutdown_sync() is solving the problem. The correct ordering of
+ * calls in this case is:
+ *
+ *	timer_shutdown_sync(&mything->timer);
+ *	workqueue_destroy(&mything->workqueue);
+ *
+ * After this 'mything' can be safely freed.
+ *
+ * This obviously implies that the timer is not required to be functional
+ * for the rest of the shutdown operation.
+ *
+ * Return:
+ * * %0 - The timer was not pending
+ * * %1 - The timer was pending
+ */
+int timer_shutdown_sync(struct timer_list *timer)
+{
+	return __timer_delete_sync(timer, true);
+}
+EXPORT_SYMBOL_GPL(timer_shutdown_sync);
+
 static void call_timer_fn(struct timer_list *timer,
 			  void (*fn)(struct timer_list *),
 			  unsigned long baseclk)
--

