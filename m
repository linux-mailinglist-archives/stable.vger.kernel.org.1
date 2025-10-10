Return-Path: <stable+bounces-184018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34462BCDB7A
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 17:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798FE54493E
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 15:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3FD2FB612;
	Fri, 10 Oct 2025 15:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2bCTEbu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DB02F363E
	for <stable@vger.kernel.org>; Fri, 10 Oct 2025 15:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108631; cv=none; b=oc0T5F7see3gUCwfDjBiAtsC433xioSKnQzyQ8C5Z9ygs4hBTX3iBn1rhOslBqihSV7ejJzldzk4Cks1J9uFMYqsrtg/hG+/uWXcV4R6PdZNo6jAQug4OmGx5KFDoCk/FW3Q6g3H1Z1CGjIjAzuZDK+Xl4gTJFrVYk7BQ0bCWyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108631; c=relaxed/simple;
	bh=J7+paRiPLaCD/c+KTz8seNjK8t39KhNj40mTnjX9HD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OAkvqks0esTzQeUj5y9c2Pyx3ztkrkDG6QYH+PIf2wWpB0HO8K+gQ0d0u7cn+I5sNcvzMFDCEhUVUf+CL25H86bwdLGl1hpolZH2Pcq0gy96TMNNBQGkUnv7omTjPr5O7MoBSIcd4emn9HXe6T9xT65vvnI6iyJwz5jGwW1YQTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2bCTEbu; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33274fcf5c1so2478853a91.1
        for <stable@vger.kernel.org>; Fri, 10 Oct 2025 08:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760108628; x=1760713428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkZJqZ3kQT2WglZ48UatqwsWbUOwu2gzPSjhRt06PHw=;
        b=J2bCTEbuT/xgJxk9A96X4yJjVIpMD2i5KUhf3bZdOKu2r9sCjNqGcMkk1MjWI/pQaE
         ul1D8u7IUbb+jmX3IoxYs080x1WQOLqJduOxhhd3Pv5rxHSwDEAYf7GepUlZKZFjvHj6
         S+PK4hkIaw0RLwusBiPJy0GaJHCH4Z8QiS/zl3fJCT9WXNfza3xHEQLnD5gzzEpCamf7
         Neb7vmH5MX+kwQmuJv46ksQxH+wet9bdSnglVgTd8nmks6byc+u6eUsLalLqsuYQVGO4
         bF4DaZlngf+W7zt9or6azR6ruCTlPfmKHMwCJx+XC9Wk7vetoorDdGqhrtdd+Cw+qj17
         HVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108628; x=1760713428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkZJqZ3kQT2WglZ48UatqwsWbUOwu2gzPSjhRt06PHw=;
        b=gpJrrh9b7dUguAuIFkTPmHkQT/6YFu97WoFyRwKWOWuv26Vn5EElpJBb+N6OSn5QSU
         jQfkihkHykxbvfOWtPoB1Dj2YQH0zMBTbE8AqjEBvkl9AUI4WFm4y18kBURwNf5qxnWf
         AhaTA3wymsiohYlRxzdfcptvKBy+DvYWWcJIfGjVyHfZzsjKNeuqYA/VRiFX6M1ls3EN
         dg78wjlgS3CMKNAJ+70GqqRaJ1d8AAyEuC19wtoYXotmtGUSF1wMUS51S06R4wrzqdhK
         NijtxwsaSUGKBBFZk4MjeZnFuWEG6Ql5brftX1piTXLThGiF0sJMFsLTfQ5POFBC7/Ub
         a+og==
X-Gm-Message-State: AOJu0YxmMvSXOmX4BAoHkrftij1o0iSVfXxUd5Ncj5+h2gP4cu4lJBGW
	qsaY1lhWsJbp64uG6j1kKyQ+i2xN0YNgzpa+rjpvK26d08u2Wuq0jktVGcSlvvuQfaYX+A==
X-Gm-Gg: ASbGncup3BjaC+Dc3kvHUDg24q0eVrlTCP0irolkbIY/SblVZGUBodvK3KpmO6bX1J0
	BcNdxR33pMm9otXcCvekmi7Utp5Ighw5ialGep5u+2yXJbkQZ5jQtTwdQtSBfvSS24jS9K6WdZa
	iwmAUtvPRoi4GrSrAZNmrZrABeRVc43axis6tL14jWWQKqFaRKwV6hmujazTkqS/txxYNGvZO73
	wE6XaiCTLByXD5dn+Jl0Az9cH6IK0wer/EQgdgAoZ18X0ssjUGrKvvHYIFvEdadouqef363hyZl
	9iwH8YwrFuP1b0dFPuyYFDCPfTGIGKTBPrxNvfNNT8jowftz7juNytScqMuGrpA22RIO9I2q6xH
	Bfta5peBaOFAgixg6GKq0CptKJo3UXCKR5dZgHs4Mvpb7cULSwMkDvZwOD8RQC4Qd3JPdU+qO0L
	M8NlI=
X-Google-Smtp-Source: AGHT+IHczjaTgP4/pfpS/l/3EBov9boHLxVTpFJ6LfHIqXB5t2YuOsq75pLWvu6/yWJavDCuN/2ueA==
X-Received: by 2002:a17:90b:4c4b:b0:339:9a71:efd8 with SMTP id 98e67ed59e1d1-33b513a24demr15370525a91.37.1760108627701;
        Fri, 10 Oct 2025 08:03:47 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b639cbcsm3266359b3a.18.2025.10.10.08.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 08:03:47 -0700 (PDT)
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
Subject: [PATCH 6.1.y 10/12] timers: Provide timer_shutdown[_sync]()
Date: Sat, 11 Oct 2025 00:02:50 +0900
Message-Id: <20251010150252.1115788-11-aha310510@gmail.com>
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

