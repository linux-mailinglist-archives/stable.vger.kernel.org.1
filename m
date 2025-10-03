Return-Path: <stable+bounces-183210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E16BB6F53
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 15:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416BB188D55C
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 13:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411F37263B;
	Fri,  3 Oct 2025 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UGD8jSL5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DCA1A9F99
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759497155; cv=none; b=grLfyQXxAqTreYKPMu1dfvD5KOyKc5viQQiurDuUn/d1uoqZJGf3vP1ZxAv4PxVeJOHqBjM+wpttU/kcKotK4BtdNfxDSgrOsUXP6kI2qh0JYrK58DGfh4NUm/PYZ3EZmp+K4da2xFDu1hMLajsdeZIAfpE7gLGRUSdOEmmSOlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759497155; c=relaxed/simple;
	bh=azMQcdKcP/j6VrdpsLockX0ZM7eLv01c8HmbZ6fXjFc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bPu1nKIeTSvCHFpVAVtmbFAIAnsMf8Qh0n2NXhEacZGuYxdRS9CeokjfHkiWkS66CTUxUbkpqzNU/fn8ncTYG0tErnOicBn7L4/2urbO+nQrDHXgyuftvGn5XdgMgKwjhBY0/iwf13MjkFMOJytvQYJnjIpqviU7qFLr/JhridQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UGD8jSL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131EAC4CEF5;
	Fri,  3 Oct 2025 13:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759497154;
	bh=azMQcdKcP/j6VrdpsLockX0ZM7eLv01c8HmbZ6fXjFc=;
	h=Subject:To:Cc:From:Date:From;
	b=UGD8jSL5ZRkTVWgxyT/vGDJ8l1dcukgcKu8FSG9EL9IcCSLJkmrPyDFZXPNSeF5AY
	 9UoxUIkCmMqWgYPjSxWLdyC97qmzloo9o/WYCQ4HMaEYCoI3IJzc1gYcsR2mGpb1fL
	 ykzdgY65etlZUghJ9RMYwudU4GgOxUFvI8eWW79Y=
Subject: FAILED: patch "[PATCH] media: i2c: tc358743: Fix use-after-free bugs caused by" failed to apply to 6.6-stable tree
To: duoming@zju.edu.cn,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 03 Oct 2025 15:12:29 +0200
Message-ID: <2025100329-icy-unbroken-b3bb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 79d10f4f21a92e459b2276a77be62c59c1502c9d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025100329-icy-unbroken-b3bb@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 79d10f4f21a92e459b2276a77be62c59c1502c9d Mon Sep 17 00:00:00 2001
From: Duoming Zhou <duoming@zju.edu.cn>
Date: Wed, 17 Sep 2025 17:57:42 +0800
Subject: [PATCH] media: i2c: tc358743: Fix use-after-free bugs caused by
 orphan timer in probe

The state->timer is a cyclic timer that schedules work_i2c_poll and
delayed_work_enable_hotplug, while rearming itself. Using timer_delete()
fails to guarantee the timer isn't still running when destroyed, similarly
cancel_delayed_work() cannot ensure delayed_work_enable_hotplug has
terminated if already executing. During probe failure after timer
initialization, these may continue running as orphans and reference the
already-freed tc358743_state object through tc358743_irq_poll_timer.

The following is the trace captured by KASAN.

BUG: KASAN: slab-use-after-free in __run_timer_base.part.0+0x7d7/0x8c0
Write of size 8 at addr ffff88800ded83c8 by task swapper/1/0
...
Call Trace:
 <IRQ>
 dump_stack_lvl+0x55/0x70
 print_report+0xcf/0x610
 ? __pfx_sched_balance_find_src_group+0x10/0x10
 ? __run_timer_base.part.0+0x7d7/0x8c0
 kasan_report+0xb8/0xf0
 ? __run_timer_base.part.0+0x7d7/0x8c0
 __run_timer_base.part.0+0x7d7/0x8c0
 ? rcu_sched_clock_irq+0xb06/0x27d0
 ? __pfx___run_timer_base.part.0+0x10/0x10
 ? try_to_wake_up+0xb15/0x1960
 ? tmigr_update_events+0x280/0x740
 ? _raw_spin_lock_irq+0x80/0xe0
 ? __pfx__raw_spin_lock_irq+0x10/0x10
 tmigr_handle_remote_up+0x603/0x7e0
 ? __pfx_tmigr_handle_remote_up+0x10/0x10
 ? sched_balance_trigger+0x98/0x9f0
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

Allocated by task 141:
 kasan_save_stack+0x24/0x50
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0x7f/0x90
 __kmalloc_node_track_caller_noprof+0x198/0x430
 devm_kmalloc+0x7b/0x1e0
 tc358743_probe+0xb7/0x610  i2c_device_probe+0x51d/0x880
 really_probe+0x1ca/0x5c0
 __driver_probe_device+0x248/0x310
 driver_probe_device+0x44/0x120
 __device_attach_driver+0x174/0x220
 bus_for_each_drv+0x100/0x190
 __device_attach+0x206/0x370
 bus_probe_device+0x123/0x170
 device_add+0xd25/0x1470
 i2c_new_client_device+0x7a0/0xcd0
 do_one_initcall+0x89/0x300
 do_init_module+0x29d/0x7f0
 load_module+0x4f48/0x69e0
 init_module_from_file+0xe4/0x150
 idempotent_init_module+0x320/0x670
 __x64_sys_finit_module+0xbd/0x120
 do_syscall_64+0xac/0x280
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 141:
 kasan_save_stack+0x24/0x50
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3a/0x60
 __kasan_slab_free+0x3f/0x50
 kfree+0x137/0x370
 release_nodes+0xa4/0x100
 devres_release_group+0x1b2/0x380
 i2c_device_probe+0x694/0x880
 really_probe+0x1ca/0x5c0
 __driver_probe_device+0x248/0x310
 driver_probe_device+0x44/0x120
 __device_attach_driver+0x174/0x220
 bus_for_each_drv+0x100/0x190
 __device_attach+0x206/0x370
 bus_probe_device+0x123/0x170
 device_add+0xd25/0x1470
 i2c_new_client_device+0x7a0/0xcd0
 do_one_initcall+0x89/0x300
 do_init_module+0x29d/0x7f0
 load_module+0x4f48/0x69e0
 init_module_from_file+0xe4/0x150
 idempotent_init_module+0x320/0x670
 __x64_sys_finit_module+0xbd/0x120
 do_syscall_64+0xac/0x280
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
...

Replace timer_delete() with timer_delete_sync() and cancel_delayed_work()
with cancel_delayed_work_sync() to ensure proper termination of timer and
work items before resource cleanup.

This bug was initially identified through static analysis. For reproduction
and testing, I created a functional emulation of the tc358743 device via a
kernel module and introduced faults through the debugfs interface.

Fixes: 869f38ae07f7 ("media: i2c: tc358743: Fix crash in the probe error path when using polling")
Fixes: d32d98642de6 ("[media] Driver for Toshiba TC358743 HDMI to CSI-2 bridge")
Cc: stable@vger.kernel.org
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/i2c/tc358743.c b/drivers/media/i2c/tc358743.c
index aa02a5a6ae3e..a0ca19359c43 100644
--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -2326,10 +2326,10 @@ static int tc358743_probe(struct i2c_client *client)
 err_work_queues:
 	cec_unregister_adapter(state->cec_adap);
 	if (!state->i2c_client->irq) {
-		timer_delete(&state->timer);
+		timer_delete_sync(&state->timer);
 		flush_work(&state->work_i2c_poll);
 	}
-	cancel_delayed_work(&state->delayed_work_enable_hotplug);
+	cancel_delayed_work_sync(&state->delayed_work_enable_hotplug);
 	mutex_destroy(&state->confctl_mutex);
 err_hdl:
 	media_entity_cleanup(&sd->entity);


