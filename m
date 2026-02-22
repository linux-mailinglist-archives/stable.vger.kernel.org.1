Return-Path: <stable+bounces-217669-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2P3METggm2n6tAMAu9opvQ
	(envelope-from <stable+bounces-217669-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 16:26:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAA716F84A
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 16:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24028300FECE
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 15:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4BC33859C;
	Sun, 22 Feb 2026 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOAVHYQH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7FE19C542;
	Sun, 22 Feb 2026 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771774001; cv=none; b=CHNcNOt5ITJDdT+QJCx8iVLYtOL47NM/9lMAVvENwYgBT/dB1vvXiDDXWQtppibxD5FADM2lZ2Z9MCQO2S8PeSL+EQT43SaB5qzkXXRnkReTrRlr3ijVzoV0FAa9fZahFxo1TuEcyF7iIUJBKQGdVXuqkqX9jqJnGlXwN/6VqJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771774001; c=relaxed/simple;
	bh=WZHqKZ7RHO9FGDtLNE9eTusosEENC9JH1jqIRs2bwUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LONvvea4HNGSS+31lPmT6rxMfNFKIuYAGgxogcLnuRzHiGLyOceYJ0+ukL2P5fti7KqyvmKucICGuyUnCwodxuIONCp4cYGpDJiOGFMn4F05w0VXrNSfg9+jVkOKetIys9INJwPbNsDkGtiRAITfXllyvCZDyU0E32SDgJj/2fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOAVHYQH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E07C116D0;
	Sun, 22 Feb 2026 15:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771774000;
	bh=WZHqKZ7RHO9FGDtLNE9eTusosEENC9JH1jqIRs2bwUo=;
	h=From:To:Cc:Subject:Date:From;
	b=FOAVHYQHYYkTdHL6rTzMh7gNolEM4asR6tPB1+GPgpGwXgq3xV8ygqv84cFa9H2Yi
	 llwMs4XNGXby/j8qZdyBJXgfAs6V2139MYveFNo/KdE+YONLnR3+yLb4mtQJpHVJjN
	 dWJmUKmwByXXRhcnz777ukC2X2dD49KG+nU8wRsYz1isW2/6gFsPRw8odcEkt1UfFU
	 2wEhTDUndD39ATIw+z94ggpyebC/eTX/4sBZEKCr436JMLPYUCmKzVh8zvOTZiynSV
	 uGiKoZ36vFrty35QIh9/lno18wxd9ksvRUaV2AHEF/r0iPwLMG3jru+K+Gex7Gz2kx
	 OGCQ1NLj2cmag==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: stable@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 6.12.y] tracing: Fix to clear fprobe after unregister_fprobe() when module unloading
Date: Mon, 23 Feb 2026 00:26:36 +0900
Message-ID: <177177399650.99709.12415733322341955461.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217669-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhiramat@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9EAA716F84A
X-Rspamd-Action: no action

From: Masami Hiramatsu <mhiramat@kernel.org>

Clear fprobe after unregister_fprobe() for preventing double
unregistering fprobe.

Without this fix, test.d/dynevent/add_remove_tprobe_module.tc test
case of ftracetest caused a kernel panic as below on 6.12.y.

This is only happens on 6.12.y because this bug was introduced by
commit 5ba4f58ec2de ("tracing: tprobe-events: Fix to clean up tprobe
correctly when module unload"). This fix expects that the new fprobe
implementation based on fgraph, but on 6.12.y, fprobe is still using
ftrace.

 ------------[ cut here ]------------
 WARNING: CPU: 0 PID: 156 at kernel/trace/ftrace.c:378 __unregister_ftrace_function+0x154/0x170
 Modules linked in: [last unloaded: trace_events_sample]
 CPU: 0 UID: 0 PID: 156 Comm: ftracetest Not tainted 6.12.74 #1
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
 RIP: 0010:__unregister_ftrace_function+0x154/0x170
 Code: 85 30 ff ff ff c6 05 fd d5 85 01 01 48 c7 c7 eb 8e 14 82 be 39 01 00 00 48 c7 c2 dd bd 1c 82 e8 52 12 93 00 e9 0c ff ff ff 90 <0f> 0b 90 b8 f0 ff ff ff 5b e9 be 8b 95 00 cc 66 66 66 66 2e 0f 1f
 RSP: 0018:ffffc900005c3b48 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: ffff8880054ba818 RCX: 7a7d3ccd1e752c00
 RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff8880054ba818
 RBP: 0000000000000000 R08: 000000000000017b R09: 0000000000000000
 R10: 0000000000000002 R11: 0000000000000000 R12: ffff8880048216d0
 R13: ffff8880052f7850 R14: ffff8880054ba818 R15: ffffffff8124e160
 FS:  000000002de743c0(0000) GS:ffff88807d800000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000000002de8b898 CR3: 0000000005b3a000 CR4: 00000000000006b0
 Call Trace:
  <TASK>
  ftrace_shutdown+0x25/0x260
  ? __pfx_dyn_event_open+0x10/0x10
  unregister_ftrace_function+0x2a/0x140
  ? __pfx_dyn_event_open+0x10/0x10
  unregister_fprobe+0x57/0x90
  trace_fprobe_release+0x56/0x150
  dyn_event_open+0x99/0xe0
  do_dentry_open+0x14a/0x3e0
  vfs_open+0x2c/0xe0
  path_openat+0xca5/0xf10
  ? __lock_acquire+0xd38/0x2af0
  ? __create_object+0x36/0x100
  ? __create_object+0x36/0x100
  do_filp_open+0xb5/0x160
  do_sys_openat2+0x7f/0xd0
  __x64_sys_openat+0x81/0xa0
  do_syscall_64+0xec/0x1d0
  ? exc_page_fault+0x92/0x110
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
 RIP: 0033:0x4aa9cb
 Code: 25 00 00 41 00 3d 00 00 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 54 24 28 64 48 2b 14 25
 RSP: 002b:00007ffce30daf50 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
 RAX: ffffffffffffffda RBX: 000000002de79bd0 RCX: 00000000004aa9cb
 RDX: 0000000000000241 RSI: 000000002deb08f0 RDI: 00000000ffffff9c
 RBP: 000000002deb08f0 R08: 0000000000000000 R09: 0000000000000000
 R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000000241
 R13: 000000002deb08f0 R14: 00007ffce30db3f8 R15: 0000000000000000
  </TASK>
 irq event stamp: 147361
 hardirqs last  enabled at (147373): [<ffffffff81128511>] __console_unlock+0x81/0xd0
 hardirqs last disabled at (147386): [<ffffffff811284f6>] __console_unlock+0x66/0xd0
 softirqs last  enabled at (146866): [<ffffffff8109a74f>] handle_softirqs+0x34f/0x3b0
 softirqs last disabled at (146861): [<ffffffff8109a956>] __irq_exit_rcu+0x66/0xd0
 ---[ end trace 0000000000000000 ]---
 BUG: kernel NULL pointer dereference, address: 000000000000002e
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 8000000005af0067 P4D 8000000005af0067 PUD 55d7067 PMD 0
 Oops: Oops: 0000 [#1] PREEMPT SMP PTI
 CPU: 0 UID: 0 PID: 156 Comm: ftracetest Tainted: G        W          6.12.74 #1
 Tainted: [W]=WARN
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
 RIP: 0010:trace_fprobe_release+0x78/0x150
 Code: 4c 89 f7 e8 ba e2 ff ff ba f0 01 00 00 4c 89 f7 31 f6 e8 9b 64 8d 00 48 8b bb 10 02 00 00 48 85 ff 74 21 4c 8d b3 10 02 00 00 <48> 8b 77 30 31 d2 e8 8d cf f8 ff 49 c7 06 00 00 00 00 49 c7 46 08
 RSP: 0018:ffffc900005c3be8 EFLAGS: 00010282
 RAX: ffff8880054ba818 RBX: ffff8880054ba800 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: fffffffffffffffe
 RBP: 00000000fffffff0 R08: 000000000000017b R09: 0000000000000000
 R10: ffff8880054ba818 R11: 0000000000000000 R12: ffff8880048216d0
 R13: ffff8880052f7850 R14: ffff8880054baa10 R15: ffffffff8124e160
 FS:  000000002de743c0(0000) GS:ffff88807d800000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000000000000002e CR3: 0000000005b3a000 CR4: 00000000000006b0
 Call Trace:
  <TASK>
  dyn_event_open+0x99/0xe0
  do_dentry_open+0x14a/0x3e0
  vfs_open+0x2c/0xe0
  path_openat+0xca5/0xf10
  ? __lock_acquire+0xd38/0x2af0
  ? __create_object+0x36/0x100
  ? __create_object+0x36/0x100
  do_filp_open+0xb5/0x160
  do_sys_openat2+0x7f/0xd0
  __x64_sys_openat+0x81/0xa0
  do_syscall_64+0xec/0x1d0
  ? exc_page_fault+0x92/0x110
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
 RIP: 0033:0x4aa9cb
 Code: 25 00 00 41 00 3d 00 00 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 54 24 28 64 48 2b 14 25
 RSP: 002b:00007ffce30daf50 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
 RAX: ffffffffffffffda RBX: 000000002de79bd0 RCX: 00000000004aa9cb
 RDX: 0000000000000241 RSI: 000000002deb08f0 RDI: 00000000ffffff9c
 RBP: 000000002deb08f0 R08: 0000000000000000 R09: 0000000000000000
 R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000000241
 R13: 000000002deb08f0 R14: 00007ffce30db3f8 R15: 0000000000000000
  </TASK>
 Modules linked in: [last unloaded: trace_events_sample]
 CR2: 000000000000002e
 ---[ end trace 0000000000000000 ]---

Fixes: 5ba4f58ec2de ("tracing: tprobe-events: Fix to clean up tprobe correctly when module unload")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_fprobe.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 440dbfa6bbfd..2cf5036c825d 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -984,6 +984,7 @@ static int __tracepoint_probe_module_cb(struct notifier_block *self,
 			}
 		} else if (val == MODULE_STATE_GOING && tp_mod->mod == tf->mod) {
 			unregister_fprobe(&tf->fp);
+			memset(&tf->fp, 0, sizeof(tf->fp));
 			if (trace_fprobe_is_tracepoint(tf)) {
 				tracepoint_probe_unregister(tf->tpoint,
 					tf->tpoint->probestub, NULL);


