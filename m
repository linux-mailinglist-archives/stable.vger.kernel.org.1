Return-Path: <stable+bounces-247430-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sO45Io3NBmpjoAIAu9opvQ
	(envelope-from <stable+bounces-247430-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:38:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3174154AB35
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5334A3075F04
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA17335A3BF;
	Fri, 15 May 2026 07:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="M5POnIhV"
X-Original-To: stable@vger.kernel.org
Received: from master.debian.org (master.debian.org [82.195.75.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B5D1C01
	for <stable@vger.kernel.org>; Fri, 15 May 2026 07:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778830470; cv=none; b=iqNXan//rVE30zItKILeHzq2SaSo/uwKDffPnQX+IO4Ic1KpBF9k70iKIDCg3WoyLF/E2L5m87F1WVtwUj9G8M7BFKKyrXyYqhKRsF9iJbkB2g8pdqzN+67DXA5rfbhURQstp98THGL7Nkls0pDYeLaBmYhr+zjNPkMu3YOWSiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778830470; c=relaxed/simple;
	bh=S6ZS2W6odEH18OZKO7Lvi5j36O6dpyTztCr5Bm2aU9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qJM5IElHdMj4uVEd82iexzEjAs+aNCikkuhDKZWKJSDj1YHG+T4yEUIH1Wza0ss6ZQKk3HUyTRPp7Ogl/xywk0RgZcU16R27T5GO3AUtiKcwUrQvH4aFxc4Zmuko1N279wcs9ibyi9isobwkYvliNa54WE/g85VJ5dovMLhwUSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=master.debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=M5POnIhV; arc=none smtp.client-ip=82.195.75.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=master.debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.master; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	In-Reply-To:References; bh=CgMKUyn+rJsWAPKHFA5fgLrozRAfcwyp/Xd13f5mrdg=; b=M5
	POnIhVXmCw6VFpgoP1SuDKiWb6+hw9ILMRFUAuh9LTxpLoGDw0FuF5x0ACLAE1R8X7azfviuy+tI+
	qLVZksZ7XQZVL/AdVfCyf9Y6s1YKkQ/alparZ7jTR4ds1BjobpIomaqBvjMjT0fmnHNyhBBGsS9IU
	85jc7oThVU+pfDDypW/JaR5tCEr+v+RRz90278VRZIkvFRemmW8DPMEq0bX0lfYQZU1jaxsoSY/tV
	4SUx9q3pFReSbb8PUm7Ycf8d3JiBGvOcwRB5vwyqCzUNMC6wG+ft6PGTOMJJjfVgSWVsDH2gJC8fr
	WlxRKYytxkN+UvG+KDeHH7L5elKdrH5g==;
Received: from ukleinek by master.debian.org with local (Exim 4.96)
	(envelope-from <ukleinek@master.debian.org>)
	id 1wNn3r-0080d5-1v;
	Fri, 15 May 2026 07:34:19 +0000
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To: stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Qualys Security Advisory <qsa@qualys.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH 7.0.y] ptrace: slightly saner 'get_dumpable()' logic
Date: Fri, 15 May 2026 09:33:59 +0200
Message-ID: <20260515073404.2974912-2-ukleinek@debian.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4174; i=ukleinek@debian.org; h=from:subject; bh=jgkFOM3uHmcJ99TltRosOiJfxROxsgJ3TqVU80YQSbY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqBsxsh8HAO0pIerIt9jYmacbOAA6ARh1YVmVYE 9NKljMINuKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagbMbAAKCRCPgPtYfRL+ ThAxCAC57Zer5ZPVpLfN8KRU9HTyscEumy0E7A6QX1H7p0o1w5Ye93u2cDdJBQYLRwmzS/EL6lJ IkK1QZlmefflLF+PtfcVMT9sxgmuriLwmCxd/RwYV2F7a74AC+DeUFSNHzKcjnd/LHtUxCru70x MAZS9JY3ebt6CRtd2RSqMcx9k1GXIkGYXOUAlT+Oa0AVGeQfAgPM+G6UR5PKoBM7y0Yi/EMx5lb aysdUD+IBooUZmruSoqb6oG9JziUjQIoyXv29sBul57352wEr3UZCrjBmsJVuKoVA9Yzczw9Jna Bx4RX2845Dz/zagog0DVuoKbKYVMX1xabChXDCVIdXoc2NMu
X-Developer-Key: i=ukleinek@debian.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3174154AB35
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.master];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247430-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@debian.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:email,qualys.com:email]
X-Rspamd-Action: no action

From: Linus Torvalds <torvalds@linux-foundation.org>

The 'dumpability' of a task is fundamentally about the memory image of
the task - the concept comes from whether it can core dump or not - and
makes no sense when you don't have an associated mm.

And almost all users do in fact use it only for the case where the task
has a mm pointer.

But we have one odd special case: ptrace_may_access() uses 'dumpable' to
check various other things entirely independently of the MM (typically
explicitly using flags like PTRACE_MODE_READ_FSCREDS).  Including for
threads that no longer have a VM (and maybe never did, like most kernel
threads).

It's not what this flag was designed for, but it is what it is.

The ptrace code does check that the uid/gid matches, so you do have to
be uid-0 to see kernel thread details, but this means that the
traditional "drop capabilities" model doesn't make any difference for
this all.

Make it all make a *bit* more sense by saying that if you don't have a
MM pointer, we'll use a cached "last dumpability" flag if the thread
ever had a MM (it will be zero for kernel threads since it is never
set), and require a proper CAP_SYS_PTRACE capability to override.

Reported-by: Qualys Security Advisory <qsa@qualys.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Kees Cook <kees@kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Uwe Kleine-König <ukleinek@debian.org>
---
Hello,

this fix seems to be relevant for backporting but lacks a Cc: for stable
and didn't appear on the list yet. I assume that the stable team has
this on their radar, but just to be sure and maybe to make more people
aware, here is an official backport.

It applies fine to 6.18.y and 6.12.y. Will send backports to 6.6.y and
older in a moment.

Best regards
Uwe

 include/linux/sched.h |  3 +++
 kernel/exit.c         |  1 +
 kernel/ptrace.c       | 22 ++++++++++++++++------
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 007a0b61856d..d41e7a8f9c85 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -998,6 +998,9 @@ struct task_struct {
 	unsigned			sched_rt_mutex:1;
 #endif
 
+	/* Save user-dumpable when mm goes away */
+	unsigned			user_dumpable:1;
+
 	/* Bit to tell TOMOYO we're in execve(): */
 	unsigned			in_execve:1;
 	unsigned			in_iowait:1;
diff --git a/kernel/exit.c b/kernel/exit.c
index ede3117fa7d4..bbb44fd3ffba 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -571,6 +571,7 @@ static void exit_mm(void)
 	 */
 	smp_mb__after_spinlock();
 	local_irq_disable();
+	current->user_dumpable = (get_dumpable(mm) == SUID_DUMP_USER);
 	current->mm = NULL;
 	membarrier_update_current_mm(NULL);
 	enter_lazy_tlb(mm, current);
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 392ec2f75f01..0e3ab697cff5 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -272,11 +272,24 @@ static bool ptrace_has_cap(struct user_namespace *ns, unsigned int mode)
 	return ns_capable(ns, CAP_SYS_PTRACE);
 }
 
+static bool task_still_dumpable(struct task_struct *task, unsigned int mode)
+{
+	struct mm_struct *mm = task->mm;
+	if (mm) {
+		if (get_dumpable(mm) == SUID_DUMP_USER)
+			return true;
+		return ptrace_has_cap(mm->user_ns, mode);
+	}
+
+	if (task->user_dumpable)
+		return true;
+	return ptrace_has_cap(&init_user_ns, mode);
+}
+
 /* Returns 0 on success, -errno on denial. */
 static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
 {
 	const struct cred *cred = current_cred(), *tcred;
-	struct mm_struct *mm;
 	kuid_t caller_uid;
 	kgid_t caller_gid;
 
@@ -337,11 +350,8 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
 	 * Pairs with a write barrier in commit_creds().
 	 */
 	smp_rmb();
-	mm = task->mm;
-	if (mm &&
-	    ((get_dumpable(mm) != SUID_DUMP_USER) &&
-	     !ptrace_has_cap(mm->user_ns, mode)))
-	    return -EPERM;
+	if (!task_still_dumpable(task, mode))
+		return -EPERM;
 
 	return security_ptrace_access_check(task, mode);
 }

base-commit: 5d83f95062a860326fd9c69a9d7a1f01063270c1
-- 
2.47.3


