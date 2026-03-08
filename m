Return-Path: <stable+bounces-223467-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id m1m6EKrqrWlB9gEAu9opvQ
	(envelope-from <stable+bounces-223467-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 22:31:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0C1232549
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 22:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 087CB300E72C
	for <lists+stable@lfdr.de>; Sun,  8 Mar 2026 21:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557F832AABF;
	Sun,  8 Mar 2026 21:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F1t4hzPw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEAC19F48D;
	Sun,  8 Mar 2026 21:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773005477; cv=none; b=mVYpJH3dlcjNptiirvxvrH1kvmMzM87Rc6sT9b5Iulw9IAqeWFOMGWo9hQxkC/lJuPf5aOdp2d3njGyoDtKwT2141uNHBC9teA1xc5+MgWPkbqrsEu4g0kyK8BGQXv5aBLEFyaD8sX6VbOPVxuG1LaJu8JN6Bq3ZcjtA6D8qbDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773005477; c=relaxed/simple;
	bh=nDOIW0/T1Pc5sOoULgNx7dKfhs3Wz+JMrhygDjRgAJw=;
	h=Date:To:From:Subject:Message-Id; b=RrSRkgjRwoGm5met2vzZIubanRbkNh2C74Gc2DOhuR9TWhmM/0q0KkxeqEXibiwtqZ2LZ2hWXjRGHT4IRwOb1oFBvQAcsz+6klKZcIb3TR/6sBhtQvvj/gIK/XuKYL9wTUbMsmrOR6OHTe7+UdTf/6uYP7lGaejRsZbPhn1bA7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F1t4hzPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E884C116C6;
	Sun,  8 Mar 2026 21:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773005476;
	bh=nDOIW0/T1Pc5sOoULgNx7dKfhs3Wz+JMrhygDjRgAJw=;
	h=Date:To:From:Subject:From;
	b=F1t4hzPw9oNS4Yd2TAZH/vJGENXV/I6+IA2lLXvebyM7pb07PWntl9MHx1SVNk7JK
	 l4J6huxSAYlSlJT8MuF4V1HISHFrPoyxSvQk88HJgOc9udnF8PxEGUJaVkvOgJXaO6
	 ewYLaMN3MIiyU4vT96U9jkwrva/b6xBuYPR1mf/k=
Date: Sun, 08 Mar 2026 14:31:15 -0700
To: mm-commits@vger.kernel.org,vschneid@redhat.com,vincent.guittot@linaro.org,surenb@google.com,stable@vger.kernel.org,rppt@kernel.org,rostedt@goodmis.org,peterz@infradead.org,oleg@redhat.com,mingo@redhat.com,mhocko@suse.com,mgorman@suse.de,lorenzo.stoakes@oracle.com,liam.howlett@oracle.com,kees@kernel.org,Kartikey406@gmail.com,juri.lelli@redhat.com,dietmar.eggemann@arm.com,david@kernel.org,bsegall@google.com,brauner@kernel.org,kartikey406@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + kernel-fork-validate-exit_signal-in-clone-syscall.patch added to mm-nonmm-unstable branch
Message-Id: <20260308213116.7E884C116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 8E0C1232549
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223467-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,redhat.com,linaro.org,google.com,kernel.org,goodmis.org,infradead.org,suse.com,suse.de,oracle.com,gmail.com,arm.com,linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.975];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


The patch titled
     Subject: kernel/fork: validate exit_signal in clone() syscall
has been added to the -mm mm-nonmm-unstable branch.  Its filename is
     kernel-fork-validate-exit_signal-in-clone-syscall.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/kernel-fork-validate-exit_signal-in-clone-syscall.patch

This patch will later appear in the mm-nonmm-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via various
branches at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there most days

------------------------------------------------------
From: Deepanshu Kartikey <kartikey406@gmail.com>
Subject: kernel/fork: validate exit_signal in clone() syscall
Date: Sat, 7 Mar 2026 12:12:02 +0530

When a child process exits, it sends exit_signal to its parent via
do_notify_parent().  The clone() syscall constructs exit_signal as:

  (lower_32_bits(clone_flags) & CSIGNAL)

CSIGNAL is 0xff, so values in the range 65-255 are possible.  However,
valid_signal() only accepts signals up to _NSIG (64 on x86_64), causing a
WARN_ON in do_notify_parent() when the process exits:

  WARNING: kernel/signal.c:2174 do_notify_parent+0xc7e/0xd70

The syzkaller reproducer triggers this by calling clone() with flags=0x80,
resulting in exit_signal = (0x80 & CSIGNAL) = 128, which exceeds _NSIG and
is not a valid signal.

The comment above kernel_clone() states that callers are expected to
validate exit_signal.  clone3() correctly does this:

  if (unlikely((args.exit_signal & ~((u64)CSIGNAL)) ||
               !valid_signal(args.exit_signal)))
          return -EINVAL;

The clone() syscall has no such check.  Add the missing valid_signal()
check to clone(), consistent with the existing validation in clone3().

Link: https://lkml.kernel.org/r/20260307064202.353405-1-kartikey406@gmail.com
Fixes: 3f2c788a1314 ("fork: prevent accidental access to clone3 features")
Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
Reported-by: syzbot+bbe6b99feefc3a0842de@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bbe6b99feefc3a0842de
Tested-by: syzbot+bbe6b99feefc3a0842de@syzkaller.appspotmail.com
Cc: Ben Segall <bsegall@google.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 kernel/fork.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/fork.c~kernel-fork-validate-exit_signal-in-clone-syscall
+++ a/kernel/fork.c
@@ -2800,7 +2800,8 @@ SYSCALL_DEFINE5(clone, unsigned long, cl
 		.stack		= newsp,
 		.tls		= tls,
 	};
-
+	if (!valid_signal(args.exit_signal))
+		return -EINVAL;
 	return kernel_clone(&args);
 }
 #endif
_

Patches currently in -mm which might be from kartikey406@gmail.com are

kernel-fork-validate-exit_signal-in-clone-syscall.patch


