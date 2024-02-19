Return-Path: <stable+bounces-20492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E31859DD4
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 09:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D7D1F236EE
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 08:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7454E20DD5;
	Mon, 19 Feb 2024 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b="GMi2gc68"
X-Original-To: stable@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C985210FA
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708330174; cv=none; b=AmBXd5nDpytlwdGUeczU5lZhWzpc878JsO40FABfhYtYnLTZdoezdNHSSEPDpBCea1NzT9xFcoPcFDkiF6gE67ycbovGmsDGqVRpJrBq3iWn07f3+biA1/vXbA6Pi9aZcLhCXOT1vnW9Cuyknm+di9OoO1TC9asufmRWZ7oRVwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708330174; c=relaxed/simple;
	bh=S/+yemvHZgVdz8mxKtnq9ho60IBky1Q7ZHlY/toMv5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NxuPFvslbQKDFc4xjfbFszW4asBvQE8pz4INfILNebsvx8myvVS1T4nFQLxF9gBoRQoAuBMZWn/vDdSzvc18qoL/s31Vp0JFXFc8mdJV0rbNJ7d/V7GXt/etF7eG4JOX968KlxK1JX3OO5AqPtWUwjV688YJNZtf60nofkvlLgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b=GMi2gc68; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240219080928c30aab50a9bf8eb5a6
        for <stable@vger.kernel.org>;
        Mon, 19 Feb 2024 09:09:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Aogezgsootqf6Y+vTCDLAqgmqqzcNfdcg3Nqq5gQ8Sc=;
 b=GMi2gc68GKZyZ6SGEcA2YNsGWj9BcIMVYZEaTotMLRMFwKEjMO0D0L2JgrnqiipimS/scr
 72n9X3wXXcZ8oC5SCbR+2/qhBjzxw311tAse8V3059JFcRKHWxRm/8mlEJKvewXkFdBbrwXm
 VxxcTGfQyO48etTQpi/9ETYA8UMJc=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: stable@vger.kernel.org
Cc: dave@stgolabs.net,
	tglx@linutronix.de,
	bigeasy@linutronix.de,
	petr.ivanov@siemens.com,
	jan.kiszka@siemens.com
Subject: [PATCH][5.10, 5.15, 6.1][1/1] hrtimer: Ignore slack time for RT tasks in schedule_hrtimeout_range()
Date: Mon, 19 Feb 2024 09:08:51 +0100
Message-Id: <20240219080851.27386-2-felix.moessbauer@siemens.com>
In-Reply-To: <20240219080851.27386-1-felix.moessbauer@siemens.com>
References: <20240219080851.27386-1-felix.moessbauer@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer

From: Davidlohr Bueso <dave@stgolabs.net>

While in theory the timer can be triggered before expires + delta, for the
cases of RT tasks they really have no business giving any lenience for
extra slack time, so override any passed value by the user and always use
zero for schedule_hrtimeout_range() calls. Furthermore, this is similar to
what the nanosleep(2) family already does with current->timer_slack_ns.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230123173206.6764-3-dave@stgolabs.net
---
 kernel/time/hrtimer.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index ede09dda36e9..0aebb88f1c11 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2161,7 +2161,7 @@ void __init hrtimers_init(void)
 /**
  * schedule_hrtimeout_range_clock - sleep until timeout
  * @expires:	timeout value (ktime_t)
- * @delta:	slack in expires timeout (ktime_t)
+ * @delta:	slack in expires timeout (ktime_t) for SCHED_OTHER tasks
  * @mode:	timer mode
  * @clock_id:	timer clock to be used
  */
@@ -2188,6 +2188,13 @@ schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
 		return -EINTR;
 	}
 
+	/*
+	 * Override any slack passed by the user if under
+	 * rt contraints.
+	 */
+	if (rt_task(current))
+		delta = 0;
+
 	hrtimer_init_sleeper_on_stack(&t, clock_id, mode);
 	hrtimer_set_expires_range_ns(&t.timer, *expires, delta);
 	hrtimer_sleeper_start_expires(&t, mode);
@@ -2207,7 +2214,7 @@ EXPORT_SYMBOL_GPL(schedule_hrtimeout_range_clock);
 /**
  * schedule_hrtimeout_range - sleep until timeout
  * @expires:	timeout value (ktime_t)
- * @delta:	slack in expires timeout (ktime_t)
+ * @delta:	slack in expires timeout (ktime_t) for SCHED_OTHER tasks
  * @mode:	timer mode
  *
  * Make the current task sleep until the given expiry time has
@@ -2215,7 +2222,8 @@ EXPORT_SYMBOL_GPL(schedule_hrtimeout_range_clock);
  * the current task state has been set (see set_current_state()).
  *
  * The @delta argument gives the kernel the freedom to schedule the
- * actual wakeup to a time that is both power and performance friendly.
+ * actual wakeup to a time that is both power and performance friendly
+ * for regular (non RT/DL) tasks.
  * The kernel give the normal best effort behavior for "@expires+@delta",
  * but may decide to fire the timer earlier, but no earlier than @expires.
  *
-- 
2.39.2


