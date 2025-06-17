Return-Path: <stable+bounces-154208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F47ADD875
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C70C4A5118
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB55A2EA74F;
	Tue, 17 Jun 2025 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O9r3iZ/Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852372EA735;
	Tue, 17 Jun 2025 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178452; cv=none; b=B+RbuVXjIHkKX8JUTDQkUTPq+iUzvlxobaifssF4q4eidjgVWIZskJ+WFTqT4TBWzNt3KkyHM816ruHzQp4UKo1AweD2rQ5h80DujNAHsGVTryMfVv21QoMmXkr0M71C3GvUR/63DcUWBr8IyEI/LUJMhG47YjoErLG7O0o9Rxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178452; c=relaxed/simple;
	bh=YPTLisCBJI8i/ZyCBe9WFhoE7//NpnBs033SdewI7VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nD0QEjK25Kq/QiF5/VLnC5euNkUqNXoUELQ4U4Sk/j07HGS3fMs9IM0Om2N0so7ujjcKJ7q8g9J35KOXYwv1HHRoubBHS62gIClJIZR1A9euj/wcRhVdQXS9K2EJuGMrkqw5MMVxQIclMqNou1A1wVjxebkV4fYTeoxGcJSQmlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O9r3iZ/Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7664C4CEE3;
	Tue, 17 Jun 2025 16:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750178452;
	bh=YPTLisCBJI8i/ZyCBe9WFhoE7//NpnBs033SdewI7VQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O9r3iZ/ZGymR1bAesqD5k2kog+lTDlcbM2TRNJ/Spue2IAKx8yDTAwofiWT25QVDr
	 Q5ycDuq4fF8O56U0Qrpv6hSYQkwEaRR5Fre6qq+asC6gZNDfr004ogW5KhLFka+y0y
	 AFRLGsNp2QjRwxyGJK8EBKWctdi65Rcd/+KaTwho=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.12 501/512] ring-buffer: Move cpus_read_lock() outside of buffer->mutex
Date: Tue, 17 Jun 2025 17:27:47 +0200
Message-ID: <20250617152439.925934207@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Steven Rostedt <rostedt@goodmis.org>

commit c98cc9797b7009308fff73d41bc1d08642dab77a upstream.

Running a modified trace-cmd record --nosplice where it does a mmap of the
ring buffer when '--nosplice' is set, caused the following lockdep splat:

 ======================================================
 WARNING: possible circular locking dependency detected
 6.15.0-rc7-test-00002-gfb7d03d8a82f #551 Not tainted
 ------------------------------------------------------
 trace-cmd/1113 is trying to acquire lock:
 ffff888100062888 (&buffer->mutex){+.+.}-{4:4}, at: ring_buffer_map+0x11c/0xe70

 but task is already holding lock:
 ffff888100a5f9f8 (&cpu_buffer->mapping_lock){+.+.}-{4:4}, at: ring_buffer_map+0xcf/0xe70

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #5 (&cpu_buffer->mapping_lock){+.+.}-{4:4}:
        __mutex_lock+0x192/0x18c0
        ring_buffer_map+0xcf/0xe70
        tracing_buffers_mmap+0x1c4/0x3b0
        __mmap_region+0xd8d/0x1f70
        do_mmap+0x9d7/0x1010
        vm_mmap_pgoff+0x20b/0x390
        ksys_mmap_pgoff+0x2e9/0x440
        do_syscall_64+0x79/0x1c0
        entry_SYSCALL_64_after_hwframe+0x76/0x7e

 -> #4 (&mm->mmap_lock){++++}-{4:4}:
        __might_fault+0xa5/0x110
        _copy_to_user+0x22/0x80
        _perf_ioctl+0x61b/0x1b70
        perf_ioctl+0x62/0x90
        __x64_sys_ioctl+0x134/0x190
        do_syscall_64+0x79/0x1c0
        entry_SYSCALL_64_after_hwframe+0x76/0x7e

 -> #3 (&cpuctx_mutex){+.+.}-{4:4}:
        __mutex_lock+0x192/0x18c0
        perf_event_init_cpu+0x325/0x7c0
        perf_event_init+0x52a/0x5b0
        start_kernel+0x263/0x3e0
        x86_64_start_reservations+0x24/0x30
        x86_64_start_kernel+0x95/0xa0
        common_startup_64+0x13e/0x141

 -> #2 (pmus_lock){+.+.}-{4:4}:
        __mutex_lock+0x192/0x18c0
        perf_event_init_cpu+0xb7/0x7c0
        cpuhp_invoke_callback+0x2c0/0x1030
        __cpuhp_invoke_callback_range+0xbf/0x1f0
        _cpu_up+0x2e7/0x690
        cpu_up+0x117/0x170
        cpuhp_bringup_mask+0xd5/0x120
        bringup_nonboot_cpus+0x13d/0x170
        smp_init+0x2b/0xf0
        kernel_init_freeable+0x441/0x6d0
        kernel_init+0x1e/0x160
        ret_from_fork+0x34/0x70
        ret_from_fork_asm+0x1a/0x30

 -> #1 (cpu_hotplug_lock){++++}-{0:0}:
        cpus_read_lock+0x2a/0xd0
        ring_buffer_resize+0x610/0x14e0
        __tracing_resize_ring_buffer.part.0+0x42/0x120
        tracing_set_tracer+0x7bd/0xa80
        tracing_set_trace_write+0x132/0x1e0
        vfs_write+0x21c/0xe80
        ksys_write+0xf9/0x1c0
        do_syscall_64+0x79/0x1c0
        entry_SYSCALL_64_after_hwframe+0x76/0x7e

 -> #0 (&buffer->mutex){+.+.}-{4:4}:
        __lock_acquire+0x1405/0x2210
        lock_acquire+0x174/0x310
        __mutex_lock+0x192/0x18c0
        ring_buffer_map+0x11c/0xe70
        tracing_buffers_mmap+0x1c4/0x3b0
        __mmap_region+0xd8d/0x1f70
        do_mmap+0x9d7/0x1010
        vm_mmap_pgoff+0x20b/0x390
        ksys_mmap_pgoff+0x2e9/0x440
        do_syscall_64+0x79/0x1c0
        entry_SYSCALL_64_after_hwframe+0x76/0x7e

 other info that might help us debug this:

 Chain exists of:
   &buffer->mutex --> &mm->mmap_lock --> &cpu_buffer->mapping_lock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&cpu_buffer->mapping_lock);
                                lock(&mm->mmap_lock);
                                lock(&cpu_buffer->mapping_lock);
   lock(&buffer->mutex);

  *** DEADLOCK ***

 2 locks held by trace-cmd/1113:
  #0: ffff888106b847e0 (&mm->mmap_lock){++++}-{4:4}, at: vm_mmap_pgoff+0x192/0x390
  #1: ffff888100a5f9f8 (&cpu_buffer->mapping_lock){+.+.}-{4:4}, at: ring_buffer_map+0xcf/0xe70

 stack backtrace:
 CPU: 5 UID: 0 PID: 1113 Comm: trace-cmd Not tainted 6.15.0-rc7-test-00002-gfb7d03d8a82f #551 PREEMPT
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x6e/0xa0
  print_circular_bug.cold+0x178/0x1be
  check_noncircular+0x146/0x160
  __lock_acquire+0x1405/0x2210
  lock_acquire+0x174/0x310
  ? ring_buffer_map+0x11c/0xe70
  ? ring_buffer_map+0x11c/0xe70
  ? __mutex_lock+0x169/0x18c0
  __mutex_lock+0x192/0x18c0
  ? ring_buffer_map+0x11c/0xe70
  ? ring_buffer_map+0x11c/0xe70
  ? function_trace_call+0x296/0x370
  ? __pfx___mutex_lock+0x10/0x10
  ? __pfx_function_trace_call+0x10/0x10
  ? __pfx___mutex_lock+0x10/0x10
  ? _raw_spin_unlock+0x2d/0x50
  ? ring_buffer_map+0x11c/0xe70
  ? ring_buffer_map+0x11c/0xe70
  ? __mutex_lock+0x5/0x18c0
  ring_buffer_map+0x11c/0xe70
  ? do_raw_spin_lock+0x12d/0x270
  ? find_held_lock+0x2b/0x80
  ? _raw_spin_unlock+0x2d/0x50
  ? rcu_is_watching+0x15/0xb0
  ? _raw_spin_unlock+0x2d/0x50
  ? trace_preempt_on+0xd0/0x110
  tracing_buffers_mmap+0x1c4/0x3b0
  __mmap_region+0xd8d/0x1f70
  ? ring_buffer_lock_reserve+0x99/0xff0
  ? __pfx___mmap_region+0x10/0x10
  ? ring_buffer_lock_reserve+0x99/0xff0
  ? __pfx_ring_buffer_lock_reserve+0x10/0x10
  ? __pfx_ring_buffer_lock_reserve+0x10/0x10
  ? bpf_lsm_mmap_addr+0x4/0x10
  ? security_mmap_addr+0x46/0xd0
  ? lock_is_held_type+0xd9/0x130
  do_mmap+0x9d7/0x1010
  ? 0xffffffffc0370095
  ? __pfx_do_mmap+0x10/0x10
  vm_mmap_pgoff+0x20b/0x390
  ? __pfx_vm_mmap_pgoff+0x10/0x10
  ? 0xffffffffc0370095
  ksys_mmap_pgoff+0x2e9/0x440
  do_syscall_64+0x79/0x1c0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7fb0963a7de2
 Code: 00 00 00 0f 1f 44 00 00 41 f7 c1 ff 0f 00 00 75 27 55 89 cd 53 48 89 fb 48 85 ff 74 3b 41 89 ea 48 89 df b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 76 5b 5d c3 0f 1f 00 48 8b 05 e1 9f 0d 00 64
 RSP: 002b:00007ffdcc8fb878 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
 RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb0963a7de2
 RDX: 0000000000000001 RSI: 0000000000001000 RDI: 0000000000000000
 RBP: 0000000000000001 R08: 0000000000000006 R09: 0000000000000000
 R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
 R13: 00007ffdcc8fbe68 R14: 00007fb096628000 R15: 00005633e01a5c90
  </TASK>

The issue is that cpus_read_lock() is taken within buffer->mutex. The
memory mapped pages are taken with the mmap_lock held. The buffer->mutex
is taken within the cpu_buffer->mapping_lock. There's quite a chain with
all these locks, where the deadlock can be fixed by moving the
cpus_read_lock() outside the taking of the buffer->mutex.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Vincent Donnefort <vdonnefort@google.com>
Link: https://lore.kernel.org/20250527105820.0f45d045@gandalf.local.home
Fixes: 117c39200d9d7 ("ring-buffer: Introducing ring-buffer mapping functions")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/ring_buffer.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2796,6 +2796,12 @@ int ring_buffer_resize(struct trace_buff
 	if (nr_pages < 2)
 		nr_pages = 2;
 
+	/*
+	 * Keep CPUs from coming online while resizing to synchronize
+	 * with new per CPU buffers being created.
+	 */
+	guard(cpus_read_lock)();
+
 	/* prevent another thread from changing buffer sizes */
 	mutex_lock(&buffer->mutex);
 	atomic_inc(&buffer->resizing);
@@ -2840,7 +2846,6 @@ int ring_buffer_resize(struct trace_buff
 			cond_resched();
 		}
 
-		cpus_read_lock();
 		/*
 		 * Fire off all the required work handlers
 		 * We can't schedule on offline CPUs, but it's not necessary
@@ -2880,7 +2885,6 @@ int ring_buffer_resize(struct trace_buff
 			cpu_buffer->nr_pages_to_update = 0;
 		}
 
-		cpus_read_unlock();
 	} else {
 		cpu_buffer = buffer->buffers[cpu_id];
 
@@ -2908,8 +2912,6 @@ int ring_buffer_resize(struct trace_buff
 			goto out_err;
 		}
 
-		cpus_read_lock();
-
 		/* Can't run something on an offline CPU. */
 		if (!cpu_online(cpu_id))
 			rb_update_pages(cpu_buffer);
@@ -2928,7 +2930,6 @@ int ring_buffer_resize(struct trace_buff
 		}
 
 		cpu_buffer->nr_pages_to_update = 0;
-		cpus_read_unlock();
 	}
 
  out:



