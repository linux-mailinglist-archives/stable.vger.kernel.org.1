Return-Path: <stable+bounces-265492-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UypoCvmJMWormAUAu9opvQ
	(envelope-from <stable+bounces-265492-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:38:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC5D693528
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:37:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=berDRBCH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265492-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-265492-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4161303B16F
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED76477E57;
	Tue, 16 Jun 2026 17:37:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A58D332EC1;
	Tue, 16 Jun 2026 17:37:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631478; cv=none; b=ZX4cnNBmwASw6IaDhyRlhjom42gYxXsCfLiiu7wE0/GD6Uth7FCNrA6lWku0/P9t7Rl07L6oMa+YrMHe+p2UdzIjVt/JG7vWzdUtoCa62BhUX57aeJSJ/n368/cASpInOQipwAV4BVZieRl1ICq5AlbVsQ/8upZVr07uM1xKcyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631478; c=relaxed/simple;
	bh=lGtr3nE79M9MwX1GUyde57vU3rBBBloctLiDXe/RjVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9Rn9XICyXjhdXz+3rBt7VG6D3mXmv6WaaTzv1CUFf6O10xqVS33rOVtxqIJniCNBjFVWK1LI4G8E7mspCBU90mF/ca8YRwTyzNPaDdd0EWGGXVCoPfCrkm3FE4aUtwFJkPHWqhJ3ZkiXgs4piBJ49AfwxsZLrMfumuxarr1wpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=berDRBCH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128C61F000E9;
	Tue, 16 Jun 2026 17:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781631476;
	bh=+FT6lvFJkJi35NDw3+H1wuTb+KZoFLoD/8h1eiV4BBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=berDRBCHjWIC9lJ4BqbX1iSkXcyvDvU46pCtxYyyZX0UBH2VlyX5D0cDlCIm4+KQv
	 bAC1zvdmjR0Ao3BztnJTYSdS444RjpUwCaISiyLpTtUKzUBzzKUrgk8py4+M+BrA11
	 1cIkI62ag1NPn25/Uw0ATimyEedKtlUv9Dp4Uz4Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+b109633ea805cac54a61@syzkaller.appspotmail.com,
	Aleksandr Nogikh <nogikh@google.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 228/522] signal: clear JOBCTL_PENDING_MASK for caller in zap_other_threads()
Date: Tue, 16 Jun 2026 20:26:15 +0530
Message-ID: <20260616145136.669505744@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265492-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:syzbot+b109633ea805cac54a61@syzkaller.appspotmail.com,m:nogikh@google.com,m:brauner@kernel.org,m:sashal@kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,b109633ea805cac54a61];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,syzkaller.appspot.com:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CEC5D693528

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksandr Nogikh <nogikh@google.com>

[ Upstream commit 90918794a4e2c3b440f8fcf3847765a8b1d81b25 ]

When a multi-threaded process receives a stop signal (e.g., SIGSTOP),
do_signal_stop() sets JOBCTL_STOP_PENDING and JOBCTL_STOP_CONSUME on all
threads and sets signal->group_stop_count to the number of threads. If
one of the threads concurrently calls execve(), de_thread() invokes
zap_other_threads() to kill all other threads. zap_other_threads()
aborts the pending group stop by resetting signal->group_stop_count to 0
and clears the JOBCTL_PENDING_MASK for all other threads. However, it
fails to clear the job control flags for the calling thread.

When execve() completes, the calling thread returns to user mode and
checks for pending signals. Seeing the stale JOBCTL_STOP_PENDING flag,
it calls do_signal_stop(), which invokes task_participate_group_stop().
Since JOBCTL_STOP_CONSUME is still set, it attempts to decrement the
already-zero signal->group_stop_count, triggering a warning:

sig->group_stop_count == 0
WARNING: CPU: 1 PID: 6475 at kernel/signal.c:373
task_participate_group_stop+0x215/0x2d0
Call Trace:
 <TASK>
 do_signal_stop+0x3be/0x5c0 kernel/signal.c:2619
 get_signal+0xa8c/0x1330 kernel/signal.c:2884
 arch_do_signal_or_restart+0xbc/0x840 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x8c/0x4d0 kernel/entry/common.c:98
 do_syscall_64+0x33e/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 </TASK>

Fix this race condition by clearing the JOBCTL_PENDING_MASK for the
calling thread in zap_other_threads(), ensuring it does not retain any
stale job control state after the thread group is destroyed. This aligns
with other functions that tear down a thread group and abort group
stops, such as zap_process() and complete_signal(), which correctly
clear these flags for all threads including the current one.

Fixes: 39efa3ef3a37 ("signal: Use GROUP_STOP_PENDING to stop once for a single group stop")
Assisted-by: Gemini:gemini-3.1-pro-preview Gemini:gemini-3-flash-preview syzbot
Reported-by: syzbot+b109633ea805cac54a61@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b109633ea805cac54a61
Link: https://syzkaller.appspot.com/ai_job?id=d70208cc-862b-4fe3-bf02-3031e10cd0b3
Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
Link: https://patch.msgid.link/20260521142240.2973022-1-nogikh@google.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/signal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index 723c84d162ddba..98dbe713829ec3 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1371,6 +1371,7 @@ int zap_other_threads(struct task_struct *p)
 	int count = 0;
 
 	p->signal->group_stop_count = 0;
+	task_clear_jobctl_pending(p, JOBCTL_PENDING_MASK);
 
 	while_each_thread(p, t) {
 		task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
-- 
2.53.0




