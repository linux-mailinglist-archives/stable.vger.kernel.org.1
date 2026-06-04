Return-Path: <stable+bounces-260713-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AJDzN7jlImrAewEAu9opvQ
	(envelope-from <stable+bounces-260713-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 17:05:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C56956491BD
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 17:05:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=pQsoPXbk;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260713-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260713-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9490E309B53F
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 14:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415DC3644CE;
	Fri,  5 Jun 2026 14:49:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58C53BCD1D
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 14:49:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670972; cv=none; b=uJpb+ZZsU329O03sgbj1DGtGqUUvupJoZU5bxcDFHeDWHnZMCrHeHuumWONmzin9K+LCgwQTSLTaaNSJNBfC71N1e0FQdhdZU6g6YRsn0HJG3I3v2+lLtVtG5rVp8SSKD3THQA+Er78DLtqxo6mx7E5rCWjes7YUbYMNqbvzl+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670972; c=relaxed/simple;
	bh=9uUNe3sCQOur+BhbT8TpstsGDg6thsew4DwnjYo/KfY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IiAKXh/8BzjUB1CseLUqcjSMUKSHtjuFtHIu2iEhn95Goa0x6l12ZDUXdpfamVMQEV18gTdxy8TJJuO4HuuJoAxgWIOoZ9brx30iBKmT1zaQL7N4QU6Jp/iGqTqrZFaS8cqsywA97ZN7o6x2ulhBn2wTuxHm0DffrpOMw2FS74I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pQsoPXbk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4805A1F00893;
	Fri,  5 Jun 2026 14:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780670970;
	bh=AztbCZuiDhaMMHcNANBWsnMqTFS5QlGtI2n/pvNAEro=;
	h=Subject:To:Cc:From:Date;
	b=pQsoPXbkU/QyhulsHZXTrCMK6Jz83fo0uzXrDBskXJ2SWaqGIy+v/zG9DWSLWYVtF
	 bob6C4r4wcSzNpg+hobxCbdi6nP+0hbRaafeppgxjNlA/coLN5F/7jS23Q2PnmQ7xc
	 hcnJYHuR66rsi1QAF5boQmgnTjaiTSe2D4nGO9vY=
Subject: FAILED: patch "[PATCH] x86/ftrace: Relocate %rip-relative percpu refs in dynamic" failed to apply to 6.12-stable tree
To: alexis.lothore@bootlin.com,bp@alien8.de,peterz@infradead.org,rostedt@goodmis.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 13:01:17 +0200
Message-ID: <2026060417-mounting-subarctic-8502@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	DATE_IN_PAST(1.00)[28];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260713-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alexis.lothore@bootlin.com,m:bp@alien8.de,m:peterz@infradead.org,m:rostedt@goodmis.org,m:stable@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C56956491BD


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a17dc12bfed8868e6a86f3b45c16065a70641acb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060417-mounting-subarctic-8502@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a17dc12bfed8868e6a86f3b45c16065a70641acb Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Alexis=20Lothor=C3=A9=20=28eBPF=20Foundation=29?=
 <alexis.lothore@bootlin.com>
Date: Wed, 27 May 2026 21:12:31 +0200
Subject: [PATCH] x86/ftrace: Relocate %rip-relative percpu refs in dynamic
 trampolines
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With CONFIG_CALL_DEPTH_TRACKING enabled on an x86 retbleed-affected platform
(eg: Skylake), with retbleed=stuff, registering a dynamic ftrace trampoline
crashes on the first call into the traced function:

  BUG: unable to handle page fault for address: ffff88817ae18880
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0002) - not-present page
  PGD 4b53067 P4D 4b53067 PUD 0
  Oops: Oops: 0002 [#1] SMP PTI
  CPU: 3 UID: 0 PID: 187 Comm: usleep Not tainted 7.0.10 #243 PREEMPT(full)
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.17.0-2-2 04/01/2014
  Code: 24 78 00 00 00 00 48 89 ea 48 89 54 24 20 48 8b b4 24 b8 00 00 00 48 8b bc 24 b0 00 00 00 48 89 bc 24 80 00 00 00 48 83 ef 05 <65> 48 c1 3d 1f a8 b6 02 05 48 8b 15 f6 00 00 00 4c 89 3c 24 4c 89
  Call Trace:
   <TASK>
   ? find_held_lock
   ? exc_page_fault
   ? lock_release
   ? __x64_sys_clock_nanosleep
   ? lockdep_hardirqs_on_prepare
   ? trace_hardirqs_on
   __x64_sys_clock_nanosleep
   do_syscall_64
   ? exc_page_fault
   ? call_depth_return_thunk
   entry_SYSCALL_64_after_hwframe
  ...
  Kernel panic - not syncing: Fatal exception

This small reproducer allows to easily trigger the crash:

  # echo 'p __x64_sys_clock_nanosleep' > /sys/kernel/tracing/kprobe_events
  # echo 1 > /sys/kernel/tracing/events/kprobes/p___x64_sys_clock_nanosleep_0/enable
  # usleep 1

Monitoring the crash under GDB points to the exact instruction in charge of
incrementing the call depth:

  sarq $5, %gs:__x86_call_depth(%rip)

This instruction matches the one inserted by the ftrace_regs_caller from
ftrace_64.S. This emitted code was likely working fine until the introduction
of

  59bec00ace28 ("x86/percpu: Introduce %rip-relative addressing to PER_CPU_VAR()"):

it has made the call depth accounting addressing relative to $rip, instead of
being based on an absolute address.

As this code exact location depends on where the trampoline lives in memory,
the corresponding displacement needs to be adjusted at runtime to actually
correctly find the per-cpu __x86_call_depth value, otherwise the targeted
address is wrong, leading to the page fault seen above.

Fix the %rip-relative displacement of the copied CALL_DEPTH_ACCOUNT
instruction (from ftrace_regs_caller) by calling text_poke_apply_relocation(),
as it is done for example by the x86 BPF JIT compiler through
x86_call_depth_emit_accounting(). This corrects both CALL_DEPTH_ACCOUNT slots,
in ftrace_caller and ftrace_regs_caller.

  [ bp: Massage. ]

Fixes: 59bec00ace28 ("x86/percpu: Introduce %rip-relative addressing to PER_CPU_VAR()")
Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Steven Rostedt <rostedt@goodmis.org>
Cc: <stable@kernel.org>
Link: https://patch.msgid.link/20260527-fix_call_depth_in_trampoline-v1-1-1c1abc8ae310@bootlin.com

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 0543b57f54ee..17d6edfcb7e0 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -375,6 +375,13 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 			goto fail;
 	}
 
+	/*
+	 * Generated trampoline may contain rIP-relative addressing which
+	 * displacement needs to be fixed.
+	 */
+	text_poke_apply_relocation(trampoline, trampoline, size,
+				   (void *)start_offset, size);
+
 	/*
 	 * The address of the ftrace_ops that is used for this trampoline
 	 * is stored at the end of the trampoline. This will be used to


