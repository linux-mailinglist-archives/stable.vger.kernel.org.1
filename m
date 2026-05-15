Return-Path: <stable+bounces-247468-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNsYF8/PBmqAoAIAu9opvQ
	(envelope-from <stable+bounces-247468-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:48:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCD454ACEB
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCC6830094E8
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5B13F1675;
	Fri, 15 May 2026 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="K1dFYuE5"
X-Original-To: stable@vger.kernel.org
Received: from master.debian.org (master.debian.org [82.195.75.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8006A3F167B
	for <stable@vger.kernel.org>; Fri, 15 May 2026 07:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778831307; cv=none; b=kFZw6rrOm1PaLcqnS+vbs6IJLxZRMBzJ8QL56YGRLP4+ZUI8+8dKh1WE0mPdXN5kguTnsqwxNxMI/AP/7diJZsCcqfTEMYLJmRrMdONaO5+ginaazmKZwodEQZXdAL4yd2QFEaITn5mA0M7Audb/54Q3q4vSQfmeswRuIoCvLkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778831307; c=relaxed/simple;
	bh=N9EIP7wcx1ho15AggRKYL8TQSL3ZJ9ksqzIZMfjYtU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c8o9sdSYW2Qt3eeccpCIXQzO8aU8dRQ7fPsLS4a1Rui6pyKuMh+qlI1Sshb4djdvA4KL91DO7Bfmu+7wWZYs8eNaY1nH7amdWQLFPnafKgSNnB6eWTUycC6lXSOcao9iysa5D3fNy9EOcQOGVqAFB9vU8zBoSCeWADaXRQOq00A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=master.debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=K1dFYuE5; arc=none smtp.client-ip=82.195.75.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=master.debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.master; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	In-Reply-To:References; bh=xPgCU2dPuW34NYB0H1vVls8qyLpPZ2L4ndCUQHh+djA=; b=K1
	dFYuE5IJN9ycfUaF/e3NMFruGDx7gm5n0HO6S9h53XLYXhNr9GAR38Ys/BRDNmA/6tfBlrPyGxfwc
	9Rs0N0WyHOSZ9mp9B1AjHHbyCuTXBjTMeMk4qf7oi85xukA8V3Lw7DryalA0eZ1OKsWFnF41tXAw/
	4Y+R3INlPxDSJGz4FG36j0XTYm1/2+sk7dWVBfsE2qropddc8dp7Zv2kS1t014bihlMaNiJD5/OQy
	T2mMpkwQw12hCdCinr67ZaUd3n4lChn2k2Nz8l610J+duJrF6W1LUsK0k+AVipSLcifZKbB91qm0A
	j54ZTP3AR7CguBZG77jE4s2ihw9yonbA==;
Received: from ukleinek by master.debian.org with local (Exim 4.96)
	(envelope-from <ukleinek@master.debian.org>)
	id 1wNnHR-0081Fv-2j;
	Fri, 15 May 2026 07:48:21 +0000
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To: stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Qualys Security Advisory <qsa@qualys.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH 6.6.y] ptrace: slightly saner 'get_dumpable()' logic
Date: Fri, 15 May 2026 09:48:13 +0200
Message-ID: <20260515074812.2976639-2-ukleinek@debian.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3953; i=ukleinek@debian.org; h=from:subject; bh=lFDzILmlIe9oPaA7cWHcGmCZhKk3b3kKlRXYFi02ZlI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqBs+8z2mWbyDjdM3mS7IVx5j09PAo3N2iyIE+1 Q9KpPJ1iweJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagbPvAAKCRCPgPtYfRL+ TmygB/9yUz4oad/1Qie8VinCEVCsadGjPYsZBBKbpTxM4plosIByt+Du920t6U7vauRWibf/Aqk uVZ4GW3yRx67OhXy1LoeYb3RYjnoBfZenomrcfjCMYWHX533gQtE8T28jRNOQiS+R1xaIFCAOoS fiZuLnO3CjM6FWPxwY3WP34SHo5/+C3viXIMhTAWYL/fTAObMiDdWO1LXfWst2I6O8cCrdqRzgs rCcPMPgU3Oidnf/s8iJGmpHcvUg/lKbyxOJjkSwX/y80jEkxFxRqsbKPTFdikH/EUx9J4sqbnMe ENzspdYpBYYEv4XyERchmFD/fog6d8v2fTJWFTmxU1W03NVj
X-Developer-Key: i=ukleinek@debian.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CBCD454ACEB
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
	TAGGED_FROM(0.00)[bounces-247468-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualys.com:email]
X-Rspamd-Action: no action

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 31e62c2ebbfdc3fe3dbdf5e02c92a9dc67087a3a upstream.

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

here is the 6.6 version, that also applies to 6.1.y and 5.15.y.

Best regards
Uwe

 include/linux/sched.h |  3 +++
 kernel/exit.c         |  1 +
 kernel/ptrace.c       | 22 ++++++++++++++++------
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9c7c67efce34..856a560100c2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -916,6 +916,9 @@ struct task_struct {
 	 */
 	unsigned			sched_remote_wakeup:1;
 
+	/* Save user-dumpable when mm goes away */
+	unsigned			user_dumpable:1;
+
 	/* Bit to tell LSMs we're in execve(): */
 	unsigned			in_execve:1;
 	unsigned			in_iowait:1;
diff --git a/kernel/exit.c b/kernel/exit.c
index 03a1dd32e6ff..686bbe72bb41 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -559,6 +559,7 @@ static void exit_mm(void)
 	 */
 	smp_mb__after_spinlock();
 	local_irq_disable();
+	current->user_dumpable = (get_dumpable(mm) == SUID_DUMP_USER);
 	current->mm = NULL;
 	membarrier_update_current_mm(NULL);
 	enter_lazy_tlb(mm, current);
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 443057bee87c..3c7d122a37fb 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -283,11 +283,24 @@ static bool ptrace_has_cap(struct user_namespace *ns, unsigned int mode)
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
 
@@ -348,11 +361,8 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
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

base-commit: 3b9f64db049687c0d38b4b3ef2f297f0642179af
-- 
2.47.3


