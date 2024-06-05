Return-Path: <stable+bounces-48226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8528FD0CE
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 16:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B720B32B3B
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7FF17BCD;
	Wed,  5 Jun 2024 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YHbbG7ip";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CsFYFFAk"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1AF539A;
	Wed,  5 Jun 2024 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717596249; cv=none; b=SWwDx0D6vXlRCSaCRvhd64TSBtaQiE/grLyacQm9ZyvuMsOjDlnXISxwP2OzvGoNTWRhUMYMfHfpvQhd0vy5a2k9Lv+jDv3/ZCRPqQsoEQ9AIH3rw5AeRul9Y9oDK72NCpjctguQ3LSKW3wYUGOffm9S9bxR4do97MoUxV19MGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717596249; c=relaxed/simple;
	bh=BgVHXbFCQ5fCSrVb9AGzyAjZOjIxURSO/TE9wep8Ln4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YMJx99lsiVc5w3YuQ396lLtZcWLEji3KGgEyFs+iI3/QXSVvjp3nn+7fpGC/slNyyonHOtAE7AAlLNz5++fQrualzhsvhu5q6p3OFAQE8m4DG/UOL3cZ3iuA33Q2+bL1fiQbhTjHqhGmwy2HK4XDyqsuuFoyQqIeUP2n/0jjDD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YHbbG7ip; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CsFYFFAk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Jun 2024 14:04:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717596243;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qUE6ykawHzViSKjz9qXZZvNMQC+Qtw9d/nagfNH5eCs=;
	b=YHbbG7ipnIFstVqefBFfKfl612TcYdYIlrrF9svDGVMtondvcQ2W+MoCLjID8PxTamD+xh
	4BevfEv/Hmo4s5EhOkL+vHX8FXBRfxIdv2YjZJEttynj5sZFMr6xznQzz/HPctVxffHopc
	LWpwajIetqXRGSwNc+tpktEAWiWbtYmC8zESETKXnos5T7wcvLH0ZhCUvFawJ+bXTDxn1e
	mqdB9BCQEyevtxokqD0xBhMCCqvXOVZHi8q0Rj5CdN4zRt6Rp/mZzarEyncDytyYjv/+17
	3F2MVJqDRPQmIF+TJjhrwmIwwO5kRFg1JmGGmxRYVZk3T0Sjtk5o2RF0GxUICw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717596243;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qUE6ykawHzViSKjz9qXZZvNMQC+Qtw9d/nagfNH5eCs=;
	b=CsFYFFAkNdoEbzzKrKWLI9t1WR03oIiTiuL907cdE5ChIa31aw39DC7sgBscMbXwYQlsUV
	cWtC14fPurTgsQBQ==
From: "tip-bot2 for Haifeng Xu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Fix missing wakeup when waiting for
 context reference
Cc: Haifeng Xu <haifeng.xu@shopee.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240513103948.33570-1-haifeng.xu@shopee.com>
References: <20240513103948.33570-1-haifeng.xu@shopee.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171759624302.10875.8851678460624573983.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     74751ef5c1912ebd3e65c3b65f45587e05ce5d36
Gitweb:        https://git.kernel.org/tip/74751ef5c1912ebd3e65c3b65f45587e05ce5d36
Author:        Haifeng Xu <haifeng.xu@shopee.com>
AuthorDate:    Mon, 13 May 2024 10:39:48 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 05 Jun 2024 15:52:33 +02:00

perf/core: Fix missing wakeup when waiting for context reference

In our production environment, we found many hung tasks which are
blocked for more than 18 hours. Their call traces are like this:

[346278.191038] __schedule+0x2d8/0x890
[346278.191046] schedule+0x4e/0xb0
[346278.191049] perf_event_free_task+0x220/0x270
[346278.191056] ? init_wait_var_entry+0x50/0x50
[346278.191060] copy_process+0x663/0x18d0
[346278.191068] kernel_clone+0x9d/0x3d0
[346278.191072] __do_sys_clone+0x5d/0x80
[346278.191076] __x64_sys_clone+0x25/0x30
[346278.191079] do_syscall_64+0x5c/0xc0
[346278.191083] ? syscall_exit_to_user_mode+0x27/0x50
[346278.191086] ? do_syscall_64+0x69/0xc0
[346278.191088] ? irqentry_exit_to_user_mode+0x9/0x20
[346278.191092] ? irqentry_exit+0x19/0x30
[346278.191095] ? exc_page_fault+0x89/0x160
[346278.191097] ? asm_exc_page_fault+0x8/0x30
[346278.191102] entry_SYSCALL_64_after_hwframe+0x44/0xae

The task was waiting for the refcount become to 1, but from the vmcore,
we found the refcount has already been 1. It seems that the task didn't
get woken up by perf_event_release_kernel() and got stuck forever. The
below scenario may cause the problem.

Thread A					Thread B
...						...
perf_event_free_task				perf_event_release_kernel
						   ...
						   acquire event->child_mutex
						   ...
						   get_ctx
   ...						   release event->child_mutex
   acquire ctx->mutex
   ...
   perf_free_event (acquire/release event->child_mutex)
   ...
   release ctx->mutex
   wait_var_event
						   acquire ctx->mutex
						   acquire event->child_mutex
						   # move existing events to free_list
						   release event->child_mutex
						   release ctx->mutex
						   put_ctx
...						...

In this case, all events of the ctx have been freed, so we couldn't
find the ctx in free_list and Thread A will miss the wakeup. It's thus
necessary to add a wakeup after dropping the reference.

Fixes: 1cf8dfe8a661 ("perf/core: Fix race between close() and fork()")
Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20240513103948.33570-1-haifeng.xu@shopee.com
---
 kernel/events/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f0128c5..8f908f0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5384,6 +5384,7 @@ int perf_event_release_kernel(struct perf_event *event)
 again:
 	mutex_lock(&event->child_mutex);
 	list_for_each_entry(child, &event->child_list, child_list) {
+		void *var = NULL;
 
 		/*
 		 * Cannot change, child events are not migrated, see the
@@ -5424,11 +5425,23 @@ again:
 			 * this can't be the last reference.
 			 */
 			put_event(event);
+		} else {
+			var = &ctx->refcount;
 		}
 
 		mutex_unlock(&event->child_mutex);
 		mutex_unlock(&ctx->mutex);
 		put_ctx(ctx);
+
+		if (var) {
+			/*
+			 * If perf_event_free_task() has deleted all events from the
+			 * ctx while the child_mutex got released above, make sure to
+			 * notify about the preceding put_ctx().
+			 */
+			smp_mb(); /* pairs with wait_var_event() */
+			wake_up_var(var);
+		}
 		goto again;
 	}
 	mutex_unlock(&event->child_mutex);

