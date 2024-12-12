Return-Path: <stable+bounces-101176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48B49EEB3A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC83168058
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675D62153F4;
	Thu, 12 Dec 2024 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JKsawzkN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2365E2054F8;
	Thu, 12 Dec 2024 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016626; cv=none; b=tuXqX6uYbfKSK2F45YtYPxM0NMAjsaS6q2UFVo9oyrxYGay/A++KZI4D+VAhwIgcxmTbfjgkBo/o/NaZXoaxz2BdzuPAwAAEQ5lc2KnOqdOY6o3a1noKls1St/FuNQ1Df1Wzf89TEPxdR0lpYCkE/Er/A5iZx94+shPk1HuFv8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016626; c=relaxed/simple;
	bh=iu3DhkIypr2v/XyBJ1NGgFikZGar5I9BUvKkHsTVENY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n76ApP/nOJ5fEiLL+FdDOFLDYJ/YMtgDN+GDHVqURpXnvE7rVoGwpoVKx8JMpYCKaX7Up8S3uPcda7V+XD9md/mmuD/cet5g65dLiKLEiZ4Fg7TtHW1irQRErI1ljrZqP+QO9S4g+9VKdiXE8C4SZ+VGTihyp3NhdFTswFsAQAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JKsawzkN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FCCC4CECE;
	Thu, 12 Dec 2024 15:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734016626;
	bh=iu3DhkIypr2v/XyBJ1NGgFikZGar5I9BUvKkHsTVENY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JKsawzkNTAfy8yiXW6DSx+f2/7WGyO06OKjP9OZYQsed/qiDL+SQOZ7O61Gcvek/4
	 SuEa8vY6tIq6wdGykRF6YyJXi6B8IExk/e0AmdiKlzjfuWbxbGG+70mOUzohUv3mcN
	 7h09zg7t4ZtWH/4W8UmZY8cQQhvedfo8h92QTRWE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Changwoo Min <changwoo@igalia.com>,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 251/466] sched_ext: add a missing rcu_read_lock/unlock pair at scx_select_cpu_dfl()
Date: Thu, 12 Dec 2024 15:57:00 +0100
Message-ID: <20241212144316.704212358@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144306.641051666@linuxfoundation.org>
References: <20241212144306.641051666@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 16613631543f1..79bb18651cdb8 100644
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




