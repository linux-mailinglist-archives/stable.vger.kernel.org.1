Return-Path: <stable+bounces-211790-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCBaMDe7eGmasgEAu9opvQ
	(envelope-from <stable+bounces-211790-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:18:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D074194C7E
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D5E23003808
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 13:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF8B342500;
	Tue, 27 Jan 2026 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WwjHAAd3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E56132D0FE
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769519921; cv=none; b=VaIOFAigIp1diQZAf7gRD0B+Utg4Jsr/BSDaCQEtYMxU65YoJASlWAsrYh2S6ufhhGOE4+4NzuoB13BWePw24uzaIjGOv2MtQl/YZaaOHNY/UMwPQ7fW7UxhKXG13qykndDAexNmIA7QyYwfzuvisGRqCxKQWcyeoj5X3e2M5yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769519921; c=relaxed/simple;
	bh=wc9/XCE7PKml8aCgNoVB4KxYwMVAbXbLSi4Zs5LlfkI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bh3Hcv4WSN/qLqGFtnXwds0okWqx2Fw22bi5JibsexhILuJeuSIUsvN6xnmHOg31k3NYYbJsIK2Zi1gR0dDxaHYWZ+73LypS0gG/atKCNwS3TwqMhVnO+rtC0g3TI0e3ra8PpSzftiLKe7dCAq48PDP9R+MYQPTpl6+h7tWK4r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WwjHAAd3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C973C116C6;
	Tue, 27 Jan 2026 13:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769519920;
	bh=wc9/XCE7PKml8aCgNoVB4KxYwMVAbXbLSi4Zs5LlfkI=;
	h=Subject:To:Cc:From:Date:From;
	b=WwjHAAd3j0tAJpkzOShBfhUNVmbbqfv2LQT18VjbPxIUK0nlEKUbCM3T927a362oA
	 PRTTLY6wge07k/a9ooXibp6CfvUzXvchhrot0saskL/tJHJ+p0Bdytb4xZ4+8gd0Uh
	 zXWbLtZoJUEfkjhTr979w7EFGiPXaOQCiXa0dmZ4=
Subject: FAILED: patch "[PATCH] tracing: Fix crash on synthetic stacktrace field usage" failed to apply to 5.10-stable tree
To: rostedt@goodmis.org,mathieu.desnoyers@efficios.com,mhiramat@kernel.org,zanussi@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 27 Jan 2026 14:18:29 +0100
Message-ID: <2026012729-zipping-skedaddle-68ef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211790-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gregkh:email,goodmis.org:email,efficios.com:email]
X-Rspamd-Queue-Id: D074194C7E
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 90f9f5d64cae4e72defd96a2a22760173cb3c9ec
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012729-zipping-skedaddle-68ef@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 90f9f5d64cae4e72defd96a2a22760173cb3c9ec Mon Sep 17 00:00:00 2001
From: Steven Rostedt <rostedt@goodmis.org>
Date: Thu, 22 Jan 2026 19:48:24 -0500
Subject: [PATCH] tracing: Fix crash on synthetic stacktrace field usage

When creating a synthetic event based on an existing synthetic event that
had a stacktrace field and the new synthetic event used that field a
kernel crash occurred:

 ~# cd /sys/kernel/tracing
 ~# echo 's:stack unsigned long stack[];' > dynamic_events
 ~# echo 'hist:keys=prev_pid:s0=common_stacktrace if prev_state & 3' >> events/sched/sched_switch/trigger
 ~# echo 'hist:keys=next_pid:s1=$s0:onmatch(sched.sched_switch).trace(stack,$s1)' >> events/sched/sched_switch/trigger

The above creates a synthetic event that takes a stacktrace when a task
schedules out in a non-running state and passes that stacktrace to the
sched_switch event when that task schedules back in. It triggers the
"stack" synthetic event that has a stacktrace as its field (called "stack").

 ~# echo 's:syscall_stack s64 id; unsigned long stack[];' >> dynamic_events
 ~# echo 'hist:keys=common_pid:s2=stack' >> events/synthetic/stack/trigger
 ~# echo 'hist:keys=common_pid:s3=$s2,i0=id:onmatch(synthetic.stack).trace(syscall_stack,$i0,$s3)' >> events/raw_syscalls/sys_exit/trigger

The above makes another synthetic event called "syscall_stack" that
attaches the first synthetic event (stack) to the sys_exit trace event and
records the stacktrace from the stack event with the id of the system call
that is exiting.

When enabling this event (or using it in a historgram):

 ~# echo 1 > events/synthetic/syscall_stack/enable

Produces a kernel crash!

 BUG: unable to handle page fault for address: 0000000000400010
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0000 [#1] SMP PTI
 CPU: 6 UID: 0 PID: 1257 Comm: bash Not tainted 6.16.3+deb14-amd64 #1 PREEMPT(lazy)  Debian 6.16.3-1
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
 RIP: 0010:trace_event_raw_event_synth+0x90/0x380
 Code: c5 00 00 00 00 85 d2 0f 84 e1 00 00 00 31 db eb 34 0f 1f 00 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 2e 0f 1f 84 00 00 00 00 00 <49> 8b 04 24 48 83 c3 01 8d 0c c5 08 00 00 00 01 cd 41 3b 5d 40 0f
 RSP: 0018:ffffd2670388f958 EFLAGS: 00010202
 RAX: ffff8ba1065cc100 RBX: 0000000000000000 RCX: 0000000000000000
 RDX: 0000000000000001 RSI: fffff266ffda7b90 RDI: ffffd2670388f9b0
 RBP: 0000000000000010 R08: ffff8ba104e76000 R09: ffffd2670388fa50
 R10: ffff8ba102dd42e0 R11: ffffffff9a908970 R12: 0000000000400010
 R13: ffff8ba10a246400 R14: ffff8ba10a710220 R15: fffff266ffda7b90
 FS:  00007fa3bc63f740(0000) GS:ffff8ba2e0f48000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000400010 CR3: 0000000107f9e003 CR4: 0000000000172ef0
 Call Trace:
  <TASK>
  ? __tracing_map_insert+0x208/0x3a0
  action_trace+0x67/0x70
  event_hist_trigger+0x633/0x6d0
  event_triggers_call+0x82/0x130
  trace_event_buffer_commit+0x19d/0x250
  trace_event_raw_event_sys_exit+0x62/0xb0
  syscall_exit_work+0x9d/0x140
  do_syscall_64+0x20a/0x2f0
  ? trace_event_raw_event_sched_switch+0x12b/0x170
  ? save_fpregs_to_fpstate+0x3e/0x90
  ? _raw_spin_unlock+0xe/0x30
  ? finish_task_switch.isra.0+0x97/0x2c0
  ? __rseq_handle_notify_resume+0xad/0x4c0
  ? __schedule+0x4b8/0xd00
  ? restore_fpregs_from_fpstate+0x3c/0x90
  ? switch_fpu_return+0x5b/0xe0
  ? do_syscall_64+0x1ef/0x2f0
  ? do_fault+0x2e9/0x540
  ? __handle_mm_fault+0x7d1/0xf70
  ? count_memcg_events+0x167/0x1d0
  ? handle_mm_fault+0x1d7/0x2e0
  ? do_user_addr_fault+0x2c3/0x7f0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

The reason is that the stacktrace field is not labeled as such, and is
treated as a normal field and not as a dynamic event that it is.

In trace_event_raw_event_synth() the event is field is still treated as a
dynamic array, but the retrieval of the data is considered a normal field,
and the reference is just the meta data:

// Meta data is retrieved instead of a dynamic array
  str_val = (char *)(long)var_ref_vals[val_idx];

// Then when it tries to process it:
  len = *((unsigned long *)str_val) + 1;

It triggers a kernel page fault.

To fix this, first when defining the fields of the first synthetic event,
set the filter type to FILTER_STACKTRACE. This is used later by the second
synthetic event to know that this field is a stacktrace. When creating
the field of the new synthetic event, have it use this FILTER_STACKTRACE
to know to create a stacktrace field to copy the stacktrace into.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tom Zanussi <zanussi@kernel.org>
Link: https://patch.msgid.link/20260122194824.6905a38e@gandalf.local.home
Fixes: 00cf3d672a9d ("tracing: Allow synthetic events to pass around stacktraces")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5e6e70540eef..c97bb2fda5c0 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2057,6 +2057,15 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 			hist_field->fn_num = HIST_FIELD_FN_RELDYNSTRING;
 		else
 			hist_field->fn_num = HIST_FIELD_FN_PSTRING;
+	} else if (field->filter_type == FILTER_STACKTRACE) {
+		flags |= HIST_FIELD_FL_STACKTRACE;
+
+		hist_field->size = MAX_FILTER_STR_VAL;
+		hist_field->type = kstrdup_const(field->type, GFP_KERNEL);
+		if (!hist_field->type)
+			goto free;
+
+		hist_field->fn_num = HIST_FIELD_FN_STACK;
 	} else {
 		hist_field->size = field->size;
 		hist_field->is_signed = field->is_signed;
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 4554c458b78c..45c187e77e21 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -130,7 +130,9 @@ static int synth_event_define_fields(struct trace_event_call *call)
 	struct synth_event *event = call->data;
 	unsigned int i, size, n_u64;
 	char *name, *type;
+	int filter_type;
 	bool is_signed;
+	bool is_stack;
 	int ret = 0;
 
 	for (i = 0, n_u64 = 0; i < event->n_fields; i++) {
@@ -138,8 +140,12 @@ static int synth_event_define_fields(struct trace_event_call *call)
 		is_signed = event->fields[i]->is_signed;
 		type = event->fields[i]->type;
 		name = event->fields[i]->name;
+		is_stack = event->fields[i]->is_stack;
+
+		filter_type = is_stack ? FILTER_STACKTRACE : FILTER_OTHER;
+
 		ret = trace_define_field(call, type, name, offset, size,
-					 is_signed, FILTER_OTHER);
+					 is_signed, filter_type);
 		if (ret)
 			break;
 


