Return-Path: <stable+bounces-94827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046A09D6F73
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96CC28163A
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3AE1EE00B;
	Sun, 24 Nov 2024 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICtEPduc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6151EE006;
	Sun, 24 Nov 2024 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452648; cv=none; b=e65ABdirl4g8veJXQrRaiWX6Dknw7PwUDiMgmG/+qYSgnb3HXQR6q6S4ES5T5iaTyJnezvd4M4Ws1Bp0kQ8eSwPXXRKyfnDv8WfLvoNNPQ4cSDO1q2jhItuhCs3tlIw1+5PmwJRKLS++He/E1mLKTYdXLsqKj3MYTau3DuEU6pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452648; c=relaxed/simple;
	bh=hI+JUynws8lrs+JNE8DmN199ZNZUGwgxR+TfbKVGYMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t665d3+SkRKjz8qpASd0O+sNQOQyLe5Wg2AJvhWQHrdw0Udt/ZT58EjnNBTkW5egCuV2VcFvtvt+SngTe8WIjfREjlj1vWF5w4lh4VOJDe68fECMKyXEencMIZ8Xwbw6GEuMTqYx22Pu10MKGNsNFZRzWyTLMeah8O4BeTcDF8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICtEPduc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F3CC4CED1;
	Sun, 24 Nov 2024 12:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452648;
	bh=hI+JUynws8lrs+JNE8DmN199ZNZUGwgxR+TfbKVGYMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ICtEPducIbSyc8AbMSxAL+5V0dT1pXPucH1JZY+iR3ketPyk5F8P5WQOBBKeiTUom
	 txuTnlMgHMZcBh8FNe5sU1qsGnb+2qf00FgWNFDrQRiW813pwgYLzi0TR770GxJ64m
	 gLqTkniXbAEPyLeBEzLPzm7uuarFgVxbuZz2gcF2+oUHZXOgFHoVxyg1T0cn79RzI9
	 LEAekUbhgxPAalGu96/nnFl9Vfr7imK1nShrBcDMJ+bDiWBMxtIQEYhfBmfoaU6GVX
	 xZlRRQuFUlEfRY+0WLQDpA72MJkfgeoHhn7FUGtf5gl7YwWnNmjMEcTPTg6A2ikHPS
	 vePsNsCX+JiFA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Changwoo Min <multics69@gmail.com>,
	Changwoo Min <changwoo@igalia.com>,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Subject: [PATCH AUTOSEL 6.12 22/23] sched_ext: add a missing rcu_read_lock/unlock pair at scx_select_cpu_dfl()
Date: Sun, 24 Nov 2024 07:48:33 -0500
Message-ID: <20241124124919.3338752-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124919.3338752-1-sashal@kernel.org>
References: <20241124124919.3338752-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Changwoo Min <multics69@gmail.com>

[ Upstream commit f39489fea677ad78ca4ce1ab2d204a6639b868dc ]

When getting an LLC CPU mask in the default CPU selection policy,
scx_select_cpu_dfl(), a pointer to the sched_domain is dereferenced
using rcu_read_lock() without holding rcu_read_lock(). Such an unprotected
dereference often causes the following warning and can cause an invalid
memory access in the worst case.

Therefore, protect dereference of a sched_domain pointer using a pair
of rcu_read_lock() and unlock().

[   20.996135] =============================
[   20.996345] WARNING: suspicious RCU usage
[   20.996563] 6.11.0-virtme #17 Tainted: G        W
[   20.996576] -----------------------------
[   20.996576] kernel/sched/ext.c:3323 suspicious rcu_dereference_check() usage!
[   20.996576]
[   20.996576] other info that might help us debug this:
[   20.996576]
[   20.996576]
[   20.996576] rcu_scheduler_active = 2, debug_locks = 1
[   20.996576] 4 locks held by kworker/8:1/140:
[   20.996576]  #0: ffff8b18c00dd348 ((wq_completion)pm){+.+.}-{0:0}, at: process_one_work+0x4a0/0x590
[   20.996576]  #1: ffffb3da01f67e58 ((work_completion)(&dev->power.work)){+.+.}-{0:0}, at: process_one_work+0x1ba/0x590
[   20.996576]  #2: ffffffffa316f9f0 (&rcu_state.gp_wq){..-.}-{2:2}, at: swake_up_one+0x15/0x60
[   20.996576]  #3: ffff8b1880398a60 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0x59/0x7d0
[   20.996576]
[   20.996576] stack backtrace:
[   20.996576] CPU: 8 UID: 0 PID: 140 Comm: kworker/8:1 Tainted: G        W          6.11.0-virtme #17
[   20.996576] Tainted: [W]=WARN
[   20.996576] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
[   20.996576] Workqueue: pm pm_runtime_work
[   20.996576] Sched_ext: simple (disabling+all), task: runnable_at=-6ms
[   20.996576] Call Trace:
[   20.996576]  <IRQ>
[   20.996576]  dump_stack_lvl+0x6f/0xb0
[   20.996576]  lockdep_rcu_suspicious.cold+0x4e/0x96
[   20.996576]  scx_select_cpu_dfl+0x234/0x260
[   20.996576]  select_task_rq_scx+0xfb/0x190
[   20.996576]  select_task_rq+0x47/0x110
[   20.996576]  try_to_wake_up+0x110/0x7d0
[   20.996576]  swake_up_one+0x39/0x60
[   20.996576]  rcu_core+0xb08/0xe50
[   20.996576]  ? srso_alias_return_thunk+0x5/0xfbef5
[   20.996576]  ? mark_held_locks+0x40/0x70
[   20.996576]  handle_softirqs+0xd3/0x410
[   20.996576]  irq_exit_rcu+0x78/0xa0
[   20.996576]  sysvec_apic_timer_interrupt+0x73/0x80
[   20.996576]  </IRQ>
[   20.996576]  <TASK>
[   20.996576]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   20.996576] RIP: 0010:_raw_spin_unlock_irqrestore+0x36/0x70
[   20.996576] Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 11 b4 36 ff 48 89 df e8 99 0d 37 ff f7 c5 00 02 00 00 75 17 9c 58 f6 c4 02 75 2b <65> ff 0d 5b 55 3c 5e 74 16 5b 5d e9 95 8e 28 00 e8 a5 ee 44 ff 9c
[   20.996576] RSP: 0018:ffffb3da01f67d20 EFLAGS: 00000246
[   20.996576] RAX: 0000000000000002 RBX: ffffffffa4640220 RCX: 0000000000000040
[   20.996576] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffa1c7b27b
[   20.996576] RBP: 0000000000000246 R08: 0000000000000001 R09: 0000000000000000
[   20.996576] R10: 0000000000000001 R11: 000000000000021c R12: 0000000000000246
[   20.996576] R13: ffff8b1881363958 R14: 0000000000000000 R15: ffff8b1881363800
[   20.996576]  ? _raw_spin_unlock_irqrestore+0x4b/0x70
[   20.996576]  serial_port_runtime_resume+0xd4/0x1a0
[   20.996576]  ? __pfx_serial_port_runtime_resume+0x10/0x10
[   20.996576]  __rpm_callback+0x44/0x170
[   20.996576]  ? __pfx_serial_port_runtime_resume+0x10/0x10
[   20.996576]  rpm_callback+0x55/0x60
[   20.996576]  ? __pfx_serial_port_runtime_resume+0x10/0x10
[   20.996576]  rpm_resume+0x582/0x7b0
[   20.996576]  pm_runtime_work+0x7c/0xb0
[   20.996576]  process_one_work+0x1fb/0x590
[   20.996576]  worker_thread+0x18e/0x350
[   20.996576]  ? __pfx_worker_thread+0x10/0x10
[   20.996576]  kthread+0xe2/0x110
[   20.996576]  ? __pfx_kthread+0x10/0x10
[   20.996576]  ret_from_fork+0x34/0x50
[   20.996576]  ? __pfx_kthread+0x10/0x10
[   20.996576]  ret_from_fork_asm+0x1a/0x30
[   20.996576]  </TASK>
[   21.056592] sched_ext: BPF scheduler "simple" disabled (unregistered from user space)

Signed-off-by: Changwoo Min <changwoo@igalia.com>
Acked-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 751d73d500e51..a7bbfb406a734 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3105,6 +3105,12 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 
 	*found = false;
 
+
+	/*
+	 * This is necessary to protect llc_cpus.
+	 */
+	rcu_read_lock();
+
 	/*
 	 * If WAKE_SYNC, the waker's local DSQ is empty, and the system is
 	 * under utilized, wake up @p to the local DSQ of the waker. Checking
@@ -3147,9 +3153,12 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	if (cpu >= 0)
 		goto cpu_found;
 
+	rcu_read_unlock();
 	return prev_cpu;
 
 cpu_found:
+	rcu_read_unlock();
+
 	*found = true;
 	return cpu;
 }
-- 
2.43.0


