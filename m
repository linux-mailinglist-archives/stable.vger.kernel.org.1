Return-Path: <stable+bounces-225786-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPdrKzweuWmbrQEAu9opvQ
	(envelope-from <stable+bounces-225786-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 10:26:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1E92A6A25
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 10:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE3EE30D50AB
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 09:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EB6392C5E;
	Tue, 17 Mar 2026 09:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nE7gbFTo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602EF37A4B9
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773739184; cv=none; b=eAD1UOJg3vD4rEVATTDbhNQuHlYG23vlzVEKyRjSX+rZMIlBFoVXYoM2OqIkNRXwFq72i5lx69SnqDa8oeUnXW9if5j0udSnfiCH3P0I7yzafnReh4ng71+eV5EqbonwVU43F968aUWMTeXsUOy3NpiqjxlymE18SMveYvTV+Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773739184; c=relaxed/simple;
	bh=LGRCmUUzvgNiXg+6a7OTcZOai8ypZI648St6Yz6hy0M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pBZ2iCs4VjdKUfZBQMsY3n+GCh/wjzh619pNujySsrcA3rYQEf8bPYHhknZwNN5LGa9x0ch7h/6vp9H8TqsJP024mz7jFzqDhtR/vqzZMDeIxk1IRn9gG3tOkhVC2x9sy02DUW47bS+WGx+6zrzfwKwd0NyieSENMk5Ke0FStIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nE7gbFTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CE4C19425;
	Tue, 17 Mar 2026 09:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773739184;
	bh=LGRCmUUzvgNiXg+6a7OTcZOai8ypZI648St6Yz6hy0M=;
	h=Subject:To:Cc:From:Date:From;
	b=nE7gbFTo7OZ2etkaRnAq1BAyKtpJz3gJ6AxMsBGECxpiZ0ocrvLXF0/WqWlA85kbE
	 +9+qfLUr94ldk0oFgXBltW7zCUybLpt0If7LoKy7abq7ZHeFa+C83Juwcw95PwaAhI
	 lcqC0TieKDE5ZUOy2LCz/AGvCV9Tdc8Xo4hn8728=
Subject: FAILED: patch "[PATCH] kprobes: avoid crash when rmmod/insmod after ftrace killed" failed to apply to 6.1-stable tree
To: mhiramat@kernel.org,rostedt@goodmis.org,yebin10@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 10:19:29 +0100
Message-ID: <2026031729-unclad-trivial-122a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225786-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goodmis.org:email,huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 2B1E92A6A25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e113f0b46d19626ec15388bcb91432c9a4fd6261
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031729-unclad-trivial-122a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e113f0b46d19626ec15388bcb91432c9a4fd6261 Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Fri, 13 Mar 2026 23:14:14 +0900
Subject: [PATCH] kprobes: avoid crash when rmmod/insmod after ftrace killed

After we hit ftrace is killed by some errors, the kernel crash if
we remove modules in which kprobe probes.

BUG: unable to handle page fault for address: fffffbfff805000d
PGD 817fcc067 P4D 817fcc067 PUD 817fc8067 PMD 101555067 PTE 0
Oops: Oops: 0000 [#1] SMP KASAN PTI
CPU: 4 UID: 0 PID: 2012 Comm: rmmod Tainted: G        W  OE
Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
RIP: 0010:kprobes_module_callback+0x89/0x790
RSP: 0018:ffff88812e157d30 EFLAGS: 00010a02
RAX: 1ffffffff805000d RBX: dffffc0000000000 RCX: ffffffff86a8de90
RDX: ffffed1025c2af9b RSI: 0000000000000008 RDI: ffffffffc0280068
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed1025c2af9a
R10: ffff88812e157cd7 R11: 205d323130325420 R12: 0000000000000002
R13: ffffffffc0290488 R14: 0000000000000002 R15: ffffffffc0280040
FS:  00007fbc450dd740(0000) GS:ffff888420331000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff805000d CR3: 000000010f624000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 notifier_call_chain+0xc6/0x280
 blocking_notifier_call_chain+0x60/0x90
 __do_sys_delete_module.constprop.0+0x32a/0x4e0
 do_syscall_64+0x5d/0xfa0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

This is because the kprobe on ftrace does not correctly handles
the kprobe_ftrace_disabled flag set by ftrace_kill().

To prevent this error, check kprobe_ftrace_disabled in
__disarm_kprobe_ftrace() and skip all ftrace related operations.

Link: https://lore.kernel.org/all/176473947565.1727781.13110060700668331950.stgit@mhiramat.tok.corp.google.com/

Reported-by: Ye Bin <yebin10@huawei.com>
Closes: https://lore.kernel.org/all/20251125020536.2484381-1-yebin@huaweicloud.com/
Fixes: ae6aa16fdc16 ("kprobes: introduce ftrace based optimization")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ab25b4aa9095..025af57ad3ed 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1178,6 +1178,10 @@ static int __disarm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 	int ret;
 
 	lockdep_assert_held(&kprobe_mutex);
+	if (unlikely(kprobe_ftrace_disabled)) {
+		/* Now ftrace is disabled forever, disarm is already done. */
+		return 0;
+	}
 
 	if (*cnt == 1) {
 		ret = unregister_ftrace_function(ops);


