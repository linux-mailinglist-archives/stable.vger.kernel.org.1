Return-Path: <stable+bounces-197614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DA1C9286C
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 17:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A16DF4E5B58
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 16:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BF2331221;
	Fri, 28 Nov 2025 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alwvx1Tw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9AB33120C
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764346014; cv=none; b=MtKK9z99mBa916ouQTMEBSNXZie6z6KZyGyfALpsUx5/27n1dU1otYMYwWwU89zTnwO9dSitFyp3X8PL3CtCxfWFDB6EKXVzLUo5Rt5wCICH2RRyYdw3kgPv3klRHpHEW2n3eFi8vs4AFEXLWJsYBCI+bTY3vIA8klS5aoxYR+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764346014; c=relaxed/simple;
	bh=J7+paRiPLaCD/c+KTz8seNjK8t39KhNj40mTnjX9HD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U7fKsAR2tiRhdwACqwi4XOL1j/tZPifNw3tLv5+oozvk4bwt0w9q2niOnSAyiSdlagg2TPxN0nPH0I3jpOJoLynY6PcyXbJ0AWc6xTPa3H6oZpHgU84hA1Jr3OrI0VGQckHd6tvfaWRXjQvdMBC5ccv5MF//6CYH1t7XmEv7eZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alwvx1Tw; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b9387df58cso3330547b3a.3
        for <stable@vger.kernel.org>; Fri, 28 Nov 2025 08:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764346011; x=1764950811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkZJqZ3kQT2WglZ48UatqwsWbUOwu2gzPSjhRt06PHw=;
        b=alwvx1TwCnRD/Z4eW6RYq8k3jMVm6tTmLDibhQuny4iz9EJM0JWSOCoY3OKhsTUA7j
         mvhjIkYV68nAsTxbnNHRStg6RzEYk2VEU9MouhiE+9d/tvPaW0bN1zJEaux74N6iaJBY
         1iU4lYvcFk7zKDKxjftlBdXPLBUiH8nsYVp9ecxwd+zxEtJWHSmsfdlsbBWiX6jv/PGF
         SUpJrh+j4+Ap+xH7hu3w3U/aVvlUR+9HPfLO+8GzQSJO3pvue+7uYPsYjzg74vuEWqvQ
         D13AYCbb4+uMCQUDKt429vK7sfVlFUgafuBSiwfKEFAibKpMv5DQ6DGGuY9p2LnhKry0
         ks8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764346011; x=1764950811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rkZJqZ3kQT2WglZ48UatqwsWbUOwu2gzPSjhRt06PHw=;
        b=b37fTd4xTAGZ6o8YQfZp7p9X4bNfmydzvD0sP2sFdNv+0mQm4tw+11RD6aHHeSpPRQ
         P9f5OEDPxVyujvgJuCRGHkQncA72eyD2QNUwEmcrRCGTkZXtR8mrbWJSxjBHuWG9Ozz8
         YAJjwySU2rkp8NzBg5TS/JFbHOoW9squ+RwPWvI9WJaL+cJ73cpxhvoIf4mRZd/4t4nB
         4YNW1uVx0fTpLuW1cMqAz0Rhva73MjgL2lH5x6V91gWOuxRMH54mqTGGWWHPO5YIOBm0
         AnXAkHkkNhsPIgMdEdCOuqwshSNsSjJUieMlVK1E1m2S4NSOoIPBdl8GRecVDd/+MAlL
         HZow==
X-Gm-Message-State: AOJu0YwnTmuE3Qs+a/UGDaloKh19J8tRqK+oN0+ZtfNFj7wTJ1x8EtfL
	8oG6GMeFQ5v4VYTxvrXSj8gtxcHGnq2YcmrasnWDBD8Y7bthfxEMXYUgGvRV9/REFUrItg==
X-Gm-Gg: ASbGncsPOIg6ooxR7dCXbDPXL11FX/tYmhQowu2ofS4e2jAhLEsDrQvz12+TZXIOVAn
	YLpJXLfuWpkdVOsnaNGvM+x+Kn2Y+O44WBJcI9SbCEie6/kXUHAtfvFiJzDovRM7sXPGyWmhjDC
	vau0M2GuLfXaEDVO4b05wHNoNMSeWb9l6GhfxM0KRo1Ou21IWUbXVE4cJWFBPSUbnqVpsI7o8JW
	WXOQ0/QwKwECA9DcR971rMhBUA8eaPsZK660UX6+V70TD03qdOudEOCVggJa60k8j2sol53gP+n
	YO/fefhc16A4wpLD5epLNaNT9flSNus++niC+2nqEwx31wMNgvnYSY5KO/vzmbSZnqBr3jjA760
	VluqWmH444CtSyDogPmxRXB0A9QBa5pmRVH4AGVd9vnf/DLMCyucJQPmnHQD4VUzvQ5VRwnCYcl
	51u5AfkDnvadSngXBzliwNUwYlaaRemYZav0Pb9w==
X-Google-Smtp-Source: AGHT+IFe/WzAJ4YhXxjHwL8WErLggbUzDU+xEOEqWM7cgEhnUCfU8qyTm7b6vv30SmypDB6nYkwQ6g==
X-Received: by 2002:a05:6a00:1828:b0:7ad:386e:3b6d with SMTP id d2e1a72fcca58-7ca8975fbecmr18947035b3a.21.1764346011056;
        Fri, 28 Nov 2025 08:06:51 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f26f11fsm5408499b3a.50.2025.11.28.08.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 08:06:50 -0800 (PST)
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
Subject: [PATCH 5.15.y 12/14] timers: Provide timer_shutdown[_sync]()
Date: Sat, 29 Nov 2025 01:05:37 +0900
Message-Id: <20251128160539.358938-13-aha310510@gmail.com>
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

