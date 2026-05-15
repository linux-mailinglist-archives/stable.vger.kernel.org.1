Return-Path: <stable+bounces-247470-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id p9oGBQLSBmrMoAIAu9opvQ
	(envelope-from <stable+bounces-247470-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:57:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C503F54AE9D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D869530332CD
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB0D3FA5E1;
	Fri, 15 May 2026 07:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="cgHvo9cd"
X-Original-To: stable@vger.kernel.org
Received: from master.debian.org (master.debian.org [82.195.75.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F06B3FE37E
	for <stable@vger.kernel.org>; Fri, 15 May 2026 07:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778831814; cv=none; b=e6YhBsrAFjcfDctYxhpvWXojddu4b6bo8ZvUwQ4yGoEwE26TlovHZoCxsPYQ/crj3p43nv1z6UdUo7+vw2XDD4kM/KyKKE/nAM1VUAj1TN1uJRhsCOgaGpwFP4W+kwukyS6g/Ktw4JzNMq/Q/mIODlEc97mpzE18PgKA0135HHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778831814; c=relaxed/simple;
	bh=PTtJs2Kx8A1/uOP1pbZP1Erk8VtOL+zQxFE3ebCyukY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pWirnYT/Ai7cNc1i9ZbUUhGbfi1DzGlyeIhSvoSW3Do7raM0ZXvUONlZhgg/0x7NDMe+KXK+Q4+PdJZtW2itgCJ7RrrnjEseb7iwZN/MnrYUppPGvo+J+Bp7eWQ/KwhHs3VqMbZP3WFEFAc4+OzcuVVA0a5c7+rn1qwkehEx5Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=master.debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=cgHvo9cd; arc=none smtp.client-ip=82.195.75.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=master.debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.master; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	In-Reply-To:References; bh=0DRoHlftxaeUQGojOKHjAEenhwdJV2WQuN6WL5IJ2jM=; b=cg
	Hvo9cdpMi1Ze2irTKuwtDyaOSIRsPsEnzxTrxtnK3TF4LVXTn+NnInfMBhsTq802Q9hHCG7y7zQOV
	La+AnzUYWxiqdPklDIuxfJbEtHj9k0UTiNVngAcNfP2CaZ+WS6Bx3nRG2/ApBdaYcxc/8eGUu9F8F
	UL5xpw4rGdYhzd+v0HwHpOneJJ8PksYV0PaF7dQRfPtnaR4P2hDUeF6SHViZR7Y/0R+RSPD0HjIxh
	u5J3MRnSnUt3bQbmMUqNUhabYce35XlQsrn0uYAJt6xg3W+PvEcKDZR/MslEb0F7EpodfyeeJkh1F
	OiiR6cXCc5EWFuIfwlir0XBrLhRnS67A==;
Received: from ukleinek by master.debian.org with local (Exim 4.96)
	(envelope-from <ukleinek@master.debian.org>)
	id 1wNnPc-0081mJ-2m;
	Fri, 15 May 2026 07:56:48 +0000
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To: stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Qualys Security Advisory <qsa@qualys.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH 5.10.y] ptrace: slightly saner 'get_dumpable()' logic
Date: Fri, 15 May 2026 09:56:38 +0200
Message-ID: <20260515075637.2994463-2-ukleinek@debian.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4038; i=ukleinek@debian.org; h=from:subject; bh=jz2WCMcCdiUt2WHD+qJVn2lNRZcUTLds4GxNE0XQ4Kw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqBtG1pIfotorC7Lil75viGOS5dprrtlUcABl7x Skjmi3Mxy2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagbRtQAKCRCPgPtYfRL+ TlRoB/9i76Z/z+0SJW4ArJupm4IcUXqPufj7kQmrm26bE6dEEFL/kD+QB1CAw5kIh4Z1M9rTeT+ KPrWIZ2zukzc1SG07o1NvpiSBwEot/F+yr4oekRsUig2WFrpBzutqxRRlbjCPkPKbFSCdQYmF8g hDeERCJ/p7+NUcr7CCR+8jNwOVp/FZJW/TyX/Tk3+YPFjqAd1z3I+0GkkTmccuVutkuZ6EL+cXu rerDHl8YkK+BLVdBJXmtArYAqi5PIdo7a+aVn+75/RQhYh7Pt03EYzTNqfsa8dc2Z5xq9QcMWIo 9mQXH4BU/q6Y7vuTHMkvLD6lNJi2KZAkrn2zBfv8GgxIq3gm
X-Developer-Key: i=ukleinek@debian.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C503F54AE9D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.master];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247470-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualys.com:email]
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

this one needs a non-trivial conflict resolution. I think I did it
right, but maybe take it with a grain of salt.

Best regards
Uwe

 include/linux/sched.h |  3 +++
 kernel/exit.c         |  1 +
 kernel/ptrace.c       | 22 ++++++++++++++++------
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3613c3f43b83..540431e31681 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -805,6 +805,9 @@ struct task_struct {
 	 */
 	unsigned			sched_remote_wakeup:1;
 
+	/* Save user-dumpable when mm goes away */
+	unsigned			user_dumpable:1;
+
 	/* Bit to tell LSMs we're in execve(): */
 	unsigned			in_execve:1;
 	unsigned			in_iowait:1;
diff --git a/kernel/exit.c b/kernel/exit.c
index cfdf2d275bba..99ab6d7a09ce 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -528,6 +528,7 @@ static void exit_mm(void)
 	BUG_ON(mm != current->active_mm);
 	/* more a memory barrier than a real lock */
 	task_lock(current);
+	current->user_dumpable = (get_dumpable(mm) == SUID_DUMP_USER);
 	current->mm = NULL;
 	mmap_read_unlock(mm);
 	enter_lazy_tlb(mm, current);
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index aab480e24bd6..fb21c2bf55c3 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -287,11 +287,24 @@ static bool ptrace_has_cap(struct user_namespace *ns, unsigned int mode)
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
 
@@ -352,11 +365,8 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
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

base-commit: 8d9ad8de1c07b07bc75178cda26a7c47f2cc0812
-- 
2.47.3


