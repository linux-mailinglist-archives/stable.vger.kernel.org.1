Return-Path: <stable+bounces-187093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D47BEA1A0
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 147F6586EB9
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B2632C944;
	Fri, 17 Oct 2025 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V2kotqcL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC5423EA9E;
	Fri, 17 Oct 2025 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715099; cv=none; b=jtXYOkOJG2vGwnELd+AMrmc7sqXhF85wMsjfJDs2jOewMaIi7ZE58GaPSx+6+gXqBONvlU5dJA4LG8fUrpAyh7iv/w45ejnHCBLnFpXHdJ2gAH46fPPmSGKoIGjOfEZhAW3pbPE29EhXo8mNG+S+YmnzFV7bM9zuX/Kkj+kpaEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715099; c=relaxed/simple;
	bh=Dw0JSyyBjJ8p9l6xBypvMhK8YdsONchgaVYjAhV9ELY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmCE9hQ4lEie9VukiP9NWeZ7BG+Aqpnw6pzm0U8yCcpdi2jFQVPhoDJM/N0mNnWlvZnq1fP3WBuuGOdAGnE9q0vdIuFTBwqnHQ4lZ6Ht7mhqvVYdE2ZeMmf7KyI+YXa75nZ3YiJSI1tX1iF82xoVihHtgYpinJHdU3wUM+lwJZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V2kotqcL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD40C4CEE7;
	Fri, 17 Oct 2025 15:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760715099;
	bh=Dw0JSyyBjJ8p9l6xBypvMhK8YdsONchgaVYjAhV9ELY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V2kotqcLM3cxJXhjUwAjovBxHyZd6BZPU785paRaXerie5Ub1aS4eoZrWKw29F84I
	 2sLqYUmp23RpC1f5HN8b7V34Sjoj3KNUf8aWw8O2J5pDMW4Ut1v8xAhhlfEgVQdhg4
	 1AH4sX3tYFnbkuRZV7cwBGjMvXKh2IM9Xn8bYWHY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Duoming Zhou <duoming@zju.edu.cn>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 090/371] net: mscc: ocelot: Fix use-after-free caused by cyclic delayed work
Date: Fri, 17 Oct 2025 16:51:05 +0200
Message-ID: <20251017145205.195447257@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
References: <20251017145201.780251198@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Duoming Zhou <duoming@zju.edu.cn>

[ Upstream commit bc9ea787079671cb19a8b25ff9f02be5ef6bfcf5 ]

The origin code calls cancel_delayed_work() in ocelot_stats_deinit()
to cancel the cyclic delayed work item ocelot->stats_work. However,
cancel_delayed_work() may fail to cancel the work item if it is already
executing. While destroy_workqueue() does wait for all pending work items
in the work queue to complete before destroying the work queue, it cannot
prevent the delayed work item from being rescheduled within the
ocelot_check_stats_work() function. This limitation exists because the
delayed work item is only enqueued into the work queue after its timer
expires. Before the timer expiration, destroy_workqueue() has no visibility
of this pending work item. Once the work queue appears empty,
destroy_workqueue() proceeds with destruction. When the timer eventually
expires, the delayed work item gets queued again, leading to the following
warning:

workqueue: cannot queue ocelot_check_stats_work on wq ocelot-switch-stats
WARNING: CPU: 2 PID: 0 at kernel/workqueue.c:2255 __queue_work+0x875/0xaf0
...
RIP: 0010:__queue_work+0x875/0xaf0
...
RSP: 0018:ffff88806d108b10 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000101 RCX: 0000000000000027
RDX: 0000000000000027 RSI: 0000000000000004 RDI: ffff88806d123e88
RBP: ffffffff813c3170 R08: 0000000000000000 R09: ffffed100da247d2
R10: ffffed100da247d1 R11: ffff88806d123e8b R12: ffff88800c00f000
R13: ffff88800d7285c0 R14: ffff88806d0a5580 R15: ffff88800d7285a0
FS:  0000000000000000(0000) GS:ffff8880e5725000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe18e45ea10 CR3: 0000000005e6c000 CR4: 00000000000006f0
Call Trace:
 <IRQ>
 ? kasan_report+0xc6/0xf0
 ? __pfx_delayed_work_timer_fn+0x10/0x10
 ? __pfx_delayed_work_timer_fn+0x10/0x10
 call_timer_fn+0x25/0x1c0
 __run_timer_base.part.0+0x3be/0x8c0
 ? __pfx_delayed_work_timer_fn+0x10/0x10
 ? rcu_sched_clock_irq+0xb06/0x27d0
 ? __pfx___run_timer_base.part.0+0x10/0x10
 ? try_to_wake_up+0xb15/0x1960
 ? _raw_spin_lock_irq+0x80/0xe0
 ? __pfx__raw_spin_lock_irq+0x10/0x10
 tmigr_handle_remote_up+0x603/0x7e0
 ? __pfx_tmigr_handle_remote_up+0x10/0x10
 ? sched_balance_trigger+0x1c0/0x9f0
 ? sched_tick+0x221/0x5a0
 ? _raw_spin_lock_irq+0x80/0xe0
 ? __pfx__raw_spin_lock_irq+0x10/0x10
 ? tick_nohz_handler+0x339/0x440
 ? __pfx_tmigr_handle_remote_up+0x10/0x10
 __walk_groups.isra.0+0x42/0x150
 tmigr_handle_remote+0x1f4/0x2e0
 ? __pfx_tmigr_handle_remote+0x10/0x10
 ? ktime_get+0x60/0x140
 ? lapic_next_event+0x11/0x20
 ? clockevents_program_event+0x1d4/0x2a0
 ? hrtimer_interrupt+0x322/0x780
 handle_softirqs+0x16a/0x550
 irq_exit_rcu+0xaf/0xe0
 sysvec_apic_timer_interrupt+0x70/0x80
 </IRQ>
...

The following diagram reveals the cause of the above warning:

CPU 0 (remove)             | CPU 1 (delayed work callback)
mscc_ocelot_remove()       |
  ocelot_deinit()          | ocelot_check_stats_work()
    ocelot_stats_deinit()  |
      cancel_delayed_work()|   ...
                           |   queue_delayed_work()
      destroy_workqueue()  | (wait a time)
                           | __queue_work() //UAF

The above scenario actually constitutes a UAF vulnerability.

The ocelot_stats_deinit() is only invoked when initialization
failure or resource destruction, so we must ensure that any
delayed work items cannot be rescheduled.

Replace cancel_delayed_work() with disable_delayed_work_sync()
to guarantee proper cancellation of the delayed work item and
ensure completion of any currently executing work before the
workqueue is deallocated.

A deadlock concern was considered: ocelot_stats_deinit() is called
in a process context and is not holding any locks that the delayed
work item might also need. Therefore, the use of the _sync() variant
is safe here.

This bug was identified through static analysis. To reproduce the
issue and validate the fix, I simulated ocelot-switch device by
writing a kernel module and prepared the necessary resources for
the virtual ocelot-switch device's probe process. Then, removing
the virtual device will trigger the mscc_ocelot_remove() function,
which in turn destroys the workqueue.

Fixes: a556c76adc05 ("net: mscc: Add initial Ocelot switch support")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Link: https://patch.msgid.link/20251001011149.55073-1-duoming@zju.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mscc/ocelot_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_stats.c b/drivers/net/ethernet/mscc/ocelot_stats.c
index 545710dadcf54..d2be1be377165 100644
--- a/drivers/net/ethernet/mscc/ocelot_stats.c
+++ b/drivers/net/ethernet/mscc/ocelot_stats.c
@@ -1021,6 +1021,6 @@ int ocelot_stats_init(struct ocelot *ocelot)
 
 void ocelot_stats_deinit(struct ocelot *ocelot)
 {
-	cancel_delayed_work(&ocelot->stats_work);
+	disable_delayed_work_sync(&ocelot->stats_work);
 	destroy_workqueue(ocelot->stats_queue);
 }
-- 
2.51.0




