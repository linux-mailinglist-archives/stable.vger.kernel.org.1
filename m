Return-Path: <stable+bounces-75193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A2C973359
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25BFD286E9E
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFDD19F487;
	Tue, 10 Sep 2024 10:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xsxYXZwz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A72719067A;
	Tue, 10 Sep 2024 10:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964020; cv=none; b=ci8fRuzOIgGI4Pvi/zT7N+TCLzDcXytoNzxzcqtrBRX+z54a9ee2jIfol8mUdZGpVjwFxQUnbFL5YSX2mKp2eRPWgHU8kww6wIxXbNUhbDfwtayr5J/bxpGn2uxaUUJlsDBfKf1g8yzOEs6vNOY4MIELjpxgclnBJMn4Y6G6jPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964020; c=relaxed/simple;
	bh=m8jqyXy4I1SY/4I6Ij1tBMnqMFfk/xt3mKIgB/lgE/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRxO81zFxR4VOsgSc/MWK/7zdVIRsK2Yp3lyZlnWzzm/4AogyAOSkFBpC5QbytWWCKZo1ApCujpM5oyMyf4oTUm4hQTVDgQbNNUKOH2E1F4elUAhwA5RdeevyaYAeLLZeDuiBWMydnGa10mqPIF7GDWwumI5t8KpDelBPqq8M4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xsxYXZwz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D992C4CEC3;
	Tue, 10 Sep 2024 10:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725964020;
	bh=m8jqyXy4I1SY/4I6Ij1tBMnqMFfk/xt3mKIgB/lgE/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xsxYXZwzzYHohKBOSAIHJYht1Iz3rkIiDyJouRKA95oIXt6v59igI2FqWZCZYByw2
	 Tudcp+uftlKJd0Wqf1m0w4yoXL8dl/kgevQh/N4d3bXsM577KM5aTdPDQsOta9ZO+y
	 /VoYs2t/Wylij6nv2Z79gBxeOMSipoZooiVl5PRA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.6 041/269] tracing/osnoise: Use a cpumask to know what threads are kthreads
Date: Tue, 10 Sep 2024 11:30:28 +0200
Message-ID: <20240910092609.720262025@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092608.225137854@linuxfoundation.org>
References: <20240910092608.225137854@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt <rostedt@goodmis.org>

commit 177e1cc2f41235c145041eed03ef5bab18f32328 upstream.

The start_kthread() and stop_thread() code was not always called with the
interface_lock held. This means that the kthread variable could be
unexpectedly changed causing the kthread_stop() to be called on it when it
should not have been, leading to:

 while true; do
   rtla timerlat top -u -q & PID=$!;
   sleep 5;
   kill -INT $PID;
   sleep 0.001;
   kill -TERM $PID;
   wait $PID;
  done

Causing the following OOPS:

 Oops: general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN PTI
 KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
 CPU: 5 UID: 0 PID: 885 Comm: timerlatu/5 Not tainted 6.11.0-rc4-test-00002-gbc754cc76d1b-dirty #125 a533010b71dab205ad2f507188ce8c82203b0254
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
 RIP: 0010:hrtimer_active+0x58/0x300
 Code: 48 c1 ee 03 41 54 48 01 d1 48 01 d6 55 53 48 83 ec 20 80 39 00 0f 85 30 02 00 00 49 8b 6f 30 4c 8d 75 10 4c 89 f0 48 c1 e8 03 <0f> b6 3c 10 4c 89 f0 83 e0 07 83 c0 03 40 38 f8 7c 09 40 84 ff 0f
 RSP: 0018:ffff88811d97f940 EFLAGS: 00010202
 RAX: 0000000000000002 RBX: ffff88823c6b5b28 RCX: ffffed10478d6b6b
 RDX: dffffc0000000000 RSI: ffffed10478d6b6c RDI: ffff88823c6b5b28
 RBP: 0000000000000000 R08: ffff88823c6b5b58 R09: ffff88823c6b5b60
 R10: ffff88811d97f957 R11: 0000000000000010 R12: 00000000000a801d
 R13: ffff88810d8b35d8 R14: 0000000000000010 R15: ffff88823c6b5b28
 FS:  0000000000000000(0000) GS:ffff88823c680000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000561858ad7258 CR3: 000000007729e001 CR4: 0000000000170ef0
 Call Trace:
  <TASK>
  ? die_addr+0x40/0xa0
  ? exc_general_protection+0x154/0x230
  ? asm_exc_general_protection+0x26/0x30
  ? hrtimer_active+0x58/0x300
  ? __pfx_mutex_lock+0x10/0x10
  ? __pfx_locks_remove_file+0x10/0x10
  hrtimer_cancel+0x15/0x40
  timerlat_fd_release+0x8e/0x1f0
  ? security_file_release+0x43/0x80
  __fput+0x372/0xb10
  task_work_run+0x11e/0x1f0
  ? _raw_spin_lock+0x85/0xe0
  ? __pfx_task_work_run+0x10/0x10
  ? poison_slab_object+0x109/0x170
  ? do_exit+0x7a0/0x24b0
  do_exit+0x7bd/0x24b0
  ? __pfx_migrate_enable+0x10/0x10
  ? __pfx_do_exit+0x10/0x10
  ? __pfx_read_tsc+0x10/0x10
  ? ktime_get+0x64/0x140
  ? _raw_spin_lock_irq+0x86/0xe0
  do_group_exit+0xb0/0x220
  get_signal+0x17ba/0x1b50
  ? vfs_read+0x179/0xa40
  ? timerlat_fd_read+0x30b/0x9d0
  ? __pfx_get_signal+0x10/0x10
  ? __pfx_timerlat_fd_read+0x10/0x10
  arch_do_signal_or_restart+0x8c/0x570
  ? __pfx_arch_do_signal_or_restart+0x10/0x10
  ? vfs_read+0x179/0xa40
  ? ksys_read+0xfe/0x1d0
  ? __pfx_ksys_read+0x10/0x10
  syscall_exit_to_user_mode+0xbc/0x130
  do_syscall_64+0x74/0x110
  ? __pfx___rseq_handle_notify_resume+0x10/0x10
  ? __pfx_ksys_read+0x10/0x10
  ? fpregs_restore_userregs+0xdb/0x1e0
  ? fpregs_restore_userregs+0xdb/0x1e0
  ? syscall_exit_to_user_mode+0x116/0x130
  ? do_syscall_64+0x74/0x110
  ? do_syscall_64+0x74/0x110
  ? do_syscall_64+0x74/0x110
  entry_SYSCALL_64_after_hwframe+0x71/0x79
 RIP: 0033:0x7ff0070eca9c
 Code: Unable to access opcode bytes at 0x7ff0070eca72.
 RSP: 002b:00007ff006dff8c0 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
 RAX: 0000000000000000 RBX: 0000000000000005 RCX: 00007ff0070eca9c
 RDX: 0000000000000400 RSI: 00007ff006dff9a0 RDI: 0000000000000003
 RBP: 00007ff006dffde0 R08: 0000000000000000 R09: 00007ff000000ba0
 R10: 00007ff007004b08 R11: 0000000000000246 R12: 0000000000000003
 R13: 00007ff006dff9a0 R14: 0000000000000007 R15: 0000000000000008
  </TASK>
 Modules linked in: snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_hwdep snd_hda_core
 ---[ end trace 0000000000000000 ]---

This is because it would mistakenly call kthread_stop() on a user space
thread making it "exit" before it actually exits.

Since kthreads are created based on global behavior, use a cpumask to know
when kthreads are running and that they need to be shutdown before
proceeding to do new work.

Link: https://lore.kernel.org/all/20240820130001.124768-1-tglozar@redhat.com/

This was debugged by using the persistent ring buffer:

Link: https://lore.kernel.org/all/20240823013902.135036960@goodmis.org/

Note, locking was originally used to fix this, but that proved to cause too
many deadlocks to work around:

  https://lore.kernel.org/linux-trace-kernel/20240823102816.5e55753b@gandalf.local.home/

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Link: https://lore.kernel.org/20240904103428.08efdf4c@gandalf.local.home
Fixes: e88ed227f639e ("tracing/timerlat: Add user-space interface")
Reported-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_osnoise.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 66a871553d4a..d770927efcd9 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1612,6 +1612,7 @@ static int run_osnoise(void)
 
 static struct cpumask osnoise_cpumask;
 static struct cpumask save_cpumask;
+static struct cpumask kthread_cpumask;
 
 /*
  * osnoise_sleep - sleep until the next period
@@ -1675,6 +1676,7 @@ static inline int osnoise_migration_pending(void)
 	 */
 	mutex_lock(&interface_lock);
 	this_cpu_osn_var()->kthread = NULL;
+	cpumask_clear_cpu(smp_processor_id(), &kthread_cpumask);
 	mutex_unlock(&interface_lock);
 
 	return 1;
@@ -1947,9 +1949,10 @@ static void stop_kthread(unsigned int cpu)
 
 	kthread = per_cpu(per_cpu_osnoise_var, cpu).kthread;
 	if (kthread) {
-		if (test_bit(OSN_WORKLOAD, &osnoise_options)) {
+		if (cpumask_test_and_clear_cpu(cpu, &kthread_cpumask) &&
+		    !WARN_ON(!test_bit(OSN_WORKLOAD, &osnoise_options))) {
 			kthread_stop(kthread);
-		} else {
+		} else if (!WARN_ON(test_bit(OSN_WORKLOAD, &osnoise_options))) {
 			/*
 			 * This is a user thread waiting on the timerlat_fd. We need
 			 * to close all users, and the best way to guarantee this is
@@ -2021,6 +2024,7 @@ static int start_kthread(unsigned int cpu)
 	}
 
 	per_cpu(per_cpu_osnoise_var, cpu).kthread = kthread;
+	cpumask_set_cpu(cpu, &kthread_cpumask);
 
 	return 0;
 }
@@ -2048,8 +2052,16 @@ static int start_per_cpu_kthreads(void)
 	 */
 	cpumask_and(current_mask, cpu_online_mask, &osnoise_cpumask);
 
-	for_each_possible_cpu(cpu)
+	for_each_possible_cpu(cpu) {
+		if (cpumask_test_and_clear_cpu(cpu, &kthread_cpumask)) {
+			struct task_struct *kthread;
+
+			kthread = per_cpu(per_cpu_osnoise_var, cpu).kthread;
+			if (!WARN_ON(!kthread))
+				kthread_stop(kthread);
+		}
 		per_cpu(per_cpu_osnoise_var, cpu).kthread = NULL;
+	}
 
 	for_each_cpu(cpu, current_mask) {
 		retval = start_kthread(cpu);
-- 
2.46.0




