Return-Path: <stable+bounces-115531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21718A3443C
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FB801708D8
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E2923F422;
	Thu, 13 Feb 2025 14:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GzeGXYnx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EF726B08D;
	Thu, 13 Feb 2025 14:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458375; cv=none; b=n+OY537DBjSBjBR9IjjFZSFWs/md/bq+gCNbwQ/pgPFUhar61j6cwsra8G99VbtSoWYnaL9I4QSZgSjw9GZrPf6k6rKJ3frUCwUsumNRx9MVJS2ZmvDz6LSINwei6uWQ6u/t9aiz4mY2CJlAFMMvZ6xm1ijRdwVUfQnaabFKFnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458375; c=relaxed/simple;
	bh=lLSIi1X21DjRYOHq9iczHsUhYzQKT5uJFbLfZsoOu8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgUUriL49g8I1yCQaz/364K8rBGlf524uszkpPQZoNPsoYwGbabGDgXvnW8ZqdpymnAfgxqp67cBy71JNDxY/f7G+MB3cN5fgMKhPEybCZTNxd2wHdcFkYfAz+1qfXOrtO1ACtyY/Vjt8XfYgyOYr906UZ4H68IKtXuf5qG2sIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GzeGXYnx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DFCC4CED1;
	Thu, 13 Feb 2025 14:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739458375;
	bh=lLSIi1X21DjRYOHq9iczHsUhYzQKT5uJFbLfZsoOu8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GzeGXYnxaLhrrFjhVPZ/kia0RSxxIzmja0ERLm49C1Jb2utk/mVFDPuFvadA3UL8l
	 ZTh1VqtFfz4wGLAVNitRLR26V5ByPNf3Q4SavaFlWtsMWMsaT9eB4nrN5X9DY6qI0v
	 BcELaGuyWBaI8zF2l/rCRiqDeQglXmTgDhoQ2AS0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.12 382/422] tracing/osnoise: Fix resetting of tracepoints
Date: Thu, 13 Feb 2025 15:28:51 +0100
Message-ID: <20250213142451.288568640@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142436.408121546@linuxfoundation.org>
References: <20250213142436.408121546@linuxfoundation.org>
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

commit e3ff4245928f948f3eb2e852aa350b870421c358 upstream.

If a timerlat tracer is started with the osnoise option OSNOISE_WORKLOAD
disabled, but then that option is enabled and timerlat is removed, the
tracepoints that were enabled on timerlat registration do not get
disabled. If the option is disabled again and timelat is started, then it
triggers a warning in the tracepoint code due to registering the
tracepoint again without ever disabling it.

Do not use the same user space defined options to know to disable the
tracepoints when timerlat is removed. Instead, set a global flag when it
is enabled and use that flag to know to disable the events.

 ~# echo NO_OSNOISE_WORKLOAD > /sys/kernel/tracing/osnoise/options
 ~# echo timerlat > /sys/kernel/tracing/current_tracer
 ~# echo OSNOISE_WORKLOAD > /sys/kernel/tracing/osnoise/options
 ~# echo nop > /sys/kernel/tracing/current_tracer
 ~# echo NO_OSNOISE_WORKLOAD > /sys/kernel/tracing/osnoise/options
 ~# echo timerlat > /sys/kernel/tracing/current_tracer

Triggers:

 ------------[ cut here ]------------
 WARNING: CPU: 6 PID: 1337 at kernel/tracepoint.c:294 tracepoint_add_func+0x3b6/0x3f0
 Modules linked in:
 CPU: 6 UID: 0 PID: 1337 Comm: rtla Not tainted 6.13.0-rc4-test-00018-ga867c441128e-dirty #73
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
 RIP: 0010:tracepoint_add_func+0x3b6/0x3f0
 Code: 48 8b 53 28 48 8b 73 20 4c 89 04 24 e8 23 59 11 00 4c 8b 04 24 e9 36 fe ff ff 0f 0b b8 ea ff ff ff 45 84 e4 0f 84 68 fe ff ff <0f> 0b e9 61 fe ff ff 48 8b 7b 18 48 85 ff 0f 84 4f ff ff ff 49 8b
 RSP: 0018:ffffb9b003a87ca0 EFLAGS: 00010202
 RAX: 00000000ffffffef RBX: ffffffff92f30860 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: ffff9bf59e91ccd0 RDI: ffffffff913b6410
 RBP: 000000000000000a R08: 00000000000005c7 R09: 0000000000000002
 R10: ffffb9b003a87ce0 R11: 0000000000000002 R12: 0000000000000001
 R13: ffffb9b003a87ce0 R14: ffffffffffffffef R15: 0000000000000008
 FS:  00007fce81209240(0000) GS:ffff9bf6fdd00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000055e99b728000 CR3: 00000001277c0002 CR4: 0000000000172ef0
 Call Trace:
  <TASK>
  ? __warn.cold+0xb7/0x14d
  ? tracepoint_add_func+0x3b6/0x3f0
  ? report_bug+0xea/0x170
  ? handle_bug+0x58/0x90
  ? exc_invalid_op+0x17/0x70
  ? asm_exc_invalid_op+0x1a/0x20
  ? __pfx_trace_sched_migrate_callback+0x10/0x10
  ? tracepoint_add_func+0x3b6/0x3f0
  ? __pfx_trace_sched_migrate_callback+0x10/0x10
  ? __pfx_trace_sched_migrate_callback+0x10/0x10
  tracepoint_probe_register+0x78/0xb0
  ? __pfx_trace_sched_migrate_callback+0x10/0x10
  osnoise_workload_start+0x2b5/0x370
  timerlat_tracer_init+0x76/0x1b0
  tracing_set_tracer+0x244/0x400
  tracing_set_trace_write+0xa0/0xe0
  vfs_write+0xfc/0x570
  ? do_sys_openat2+0x9c/0xe0
  ksys_write+0x72/0xf0
  do_syscall_64+0x79/0x1c0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tomas Glozar <tglozar@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Link: https://lore.kernel.org/20250123204159.4450c88e@gandalf.local.home
Fixes: e88ed227f639e ("tracing/timerlat: Add user-space interface")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_osnoise.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1235,6 +1235,8 @@ static void trace_sched_migrate_callback
 	}
 }
 
+static bool monitor_enabled;
+
 static int register_migration_monitor(void)
 {
 	int ret = 0;
@@ -1243,16 +1245,25 @@ static int register_migration_monitor(vo
 	 * Timerlat thread migration check is only required when running timerlat in user-space.
 	 * Thus, enable callback only if timerlat is set with no workload.
 	 */
-	if (timerlat_enabled() && !test_bit(OSN_WORKLOAD, &osnoise_options))
+	if (timerlat_enabled() && !test_bit(OSN_WORKLOAD, &osnoise_options)) {
+		if (WARN_ON_ONCE(monitor_enabled))
+			return 0;
+
 		ret = register_trace_sched_migrate_task(trace_sched_migrate_callback, NULL);
+		if (!ret)
+			monitor_enabled = true;
+	}
 
 	return ret;
 }
 
 static void unregister_migration_monitor(void)
 {
-	if (timerlat_enabled() && !test_bit(OSN_WORKLOAD, &osnoise_options))
-		unregister_trace_sched_migrate_task(trace_sched_migrate_callback, NULL);
+	if (!monitor_enabled)
+		return;
+
+	unregister_trace_sched_migrate_task(trace_sched_migrate_callback, NULL);
+	monitor_enabled = false;
 }
 #else
 static int register_migration_monitor(void)



