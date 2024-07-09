Return-Path: <stable+bounces-58735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB5292B89F
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6221A1F223FF
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9E315F3FE;
	Tue,  9 Jul 2024 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T8GXWA+q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ByZrffwF"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0337C15B0E1;
	Tue,  9 Jul 2024 11:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720525323; cv=none; b=Be365UOGc0aioCF6ZKTimuEEZG4mFyFg+yPDD2RIlkPW0bMQGq5TqI2BKbdrhKCcFz12PTm840EFzr9cHlvCdAivB/bYkZneKc5tUf9khWZnn/0H+3gJJ9i6mn3ViNmyv5ZDE59P7cwvPUFffftH8G0DthqUe0BTwlGVnwCQXJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720525323; c=relaxed/simple;
	bh=GEnUgTu8lPUb9sbiJtAnklk56wz/FMBgSpidCD4+D88=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JsqBVWiLwHQZ74f307m1adDLigTathuOB3mfSmGmWw67pBTL84qwx8/xSTRacKJjwdMgYV2XR3p9UsESvBMiz/wtcHmrluOG8jl1elwXRnVpB9fy60Sp+/JzQnI8DRVT8rcFbz4xkw3CbSGCp9RbD3TPECYl0T23saGb7TzZkzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T8GXWA+q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ByZrffwF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Jul 2024 11:42:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720525320;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LG4ihRH27yiQythiXxJ5u6cgg3+Qi+eGSXh3MeksO2E=;
	b=T8GXWA+qtJOg+okNZf9b3whQ9tfJZF4ZXDfBvp2AfxBn0177gt6NsrEEaruniMvJ0w0aMv
	mwOX9cn99FNunASUFAKZyEBkcXsllsY20Ufo+2wq5UxfVHWsDI93UwfVVvmre7AFlFMVoI
	lOxrPjVN7bP+4OYelPAqaAaJYdfy9J44p8bXu55V41GVJaXlpQfEotbT64eZpxuyVvSz++
	5x2ir4JcFf2FXXFDC94kr5OeWqnPSjzBkOMc+zoWYt4GrHCcB3MaLf5Ub3UeyJW3M8xk+U
	O59ffgiG9t9GfIM8Y6emru2Kb+JPt92PavH658vEiqJV+LNMS5TJvz5hQ+0JNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720525320;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LG4ihRH27yiQythiXxJ5u6cgg3+Qi+eGSXh3MeksO2E=;
	b=ByZrffwFwgqCGudPPiA6ZTaq9CR00i7Z/oHxTnxa5t6hcWXsR5HHX1Gd5yl6zTnrWTSbXL
	PkyfMiDxUmMYfyCQ==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Fix event leak upon exit
Cc: Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240621091601.18227-4-frederic@kernel.org>
References: <20240621091601.18227-4-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172052532020.2215.3558915435239309013.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2fd5ad3f310de22836cdacae919dd99d758a1f1b
Gitweb:        https://git.kernel.org/tip/2fd5ad3f310de22836cdacae919dd99d758a1f1b
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 21 Jun 2024 11:16:00 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 09 Jul 2024 13:26:33 +02:00

perf: Fix event leak upon exit

When a task is scheduled out, pending sigtrap deliveries are deferred
to the target task upon resume to userspace via task_work.

However failures while adding an event's callback to the task_work
engine are ignored. And since the last call for events exit happen
after task work is eventually closed, there is a small window during
which pending sigtrap can be queued though ignored, leaking the event
refcount addition such as in the following scenario:

    TASK A
    -----

    do_exit()
       exit_task_work(tsk);

       <IRQ>
       perf_event_overflow()
          event->pending_sigtrap = pending_id;
          irq_work_queue(&event->pending_irq);
       </IRQ>
    =========> PREEMPTION: TASK A -> TASK B
       event_sched_out()
          event->pending_sigtrap = 0;
          atomic_long_inc_not_zero(&event->refcount)
          // FAILS: task work has exited
          task_work_add(&event->pending_task)
       [...]
       <IRQ WORK>
       perf_pending_irq()
          // early return: event->oncpu = -1
       </IRQ WORK>
       [...]
    =========> TASK B -> TASK A
       perf_event_exit_task(tsk)
          perf_event_exit_event()
             free_event()
                WARN(atomic_long_cmpxchg(&event->refcount, 1, 0) != 1)
                // leak event due to unexpected refcount == 2

As a result the event is never released while the task exits.

Fix this with appropriate task_work_add()'s error handling.

Fixes: 517e6a301f34 ("perf: Fix perf_pending_task() UaF")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240621091601.18227-4-frederic@kernel.org
---
 kernel/events/core.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 51ce436..576400d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2284,18 +2284,15 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
 	}
 
 	if (event->pending_sigtrap) {
-		bool dec = true;
-
 		event->pending_sigtrap = 0;
 		if (state != PERF_EVENT_STATE_OFF &&
-		    !event->pending_work) {
-			event->pending_work = 1;
-			dec = false;
+		    !event->pending_work &&
+		    !task_work_add(current, &event->pending_task, TWA_RESUME)) {
 			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
-			task_work_add(current, &event->pending_task, TWA_RESUME);
-		}
-		if (dec)
+			event->pending_work = 1;
+		} else {
 			local_dec(&event->ctx->nr_pending);
+		}
 	}
 
 	perf_event_set_state(event, state);

