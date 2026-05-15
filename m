Return-Path: <stable+bounces-247772-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNdQAKskB2oEsQIAu9opvQ
	(envelope-from <stable+bounces-247772-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:50:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 16257550C21
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 307743144870
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2F43126C2;
	Fri, 15 May 2026 13:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fO7rG1x4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BCB30E834;
	Fri, 15 May 2026 13:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850371; cv=none; b=WvDcMGddYai4aXYcvV3OZWcdnzcjRZ344WhpHva1ByLO5IUSDNSkxFJjy/Igc0AT3Q2glhUGf6Sh2xe2QO1qW8YKFDkb9X1MEx5GBZNqIqgKyrIpTfpeOSmdphoJi3MOn8Zo3grVmqs924WydMV0Q7v8yHlTdoTeh1F0Z1z1f0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850371; c=relaxed/simple;
	bh=O09otWkAvkxOyyjbUwhtcN8YXkXvBUQhoECZZTjyDgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVn+Hla+WrsLShx4T2MjZ1TbleXQ78Jzb+RqoRPrSbHSQjGCDQte2O3h1zt+Icpn5y4FdNGOOJ3xu9z/YNVIjBbulCNm+0dWBrvcw1JOCZjM2tbyX0QjhXVHDZaAiJDuaRcj3NmXs/CFTqIxCgZ2pKTK/oytE5MVre23jdt1Dz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fO7rG1x4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BC4C2BCB0;
	Fri, 15 May 2026 13:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778850371;
	bh=O09otWkAvkxOyyjbUwhtcN8YXkXvBUQhoECZZTjyDgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fO7rG1x4lW+pYixIqTrzRZVMRWh70Ld0ZmeJTid/nxD0MWpjBNi365r9qqERiE+4U
	 Z5K4BNqoNOR+1HiJN3/hVqEZVBtJ9GjMqt7nigj9txsEkvqkdeWqJ708KE98XOtmkv
	 9iaF/DJ3aWmR5P/2HqebQ8GIN4gUh1DAJEPcU+5Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 7.0.8
Date: Fri, 15 May 2026 15:06:08 +0200
Message-ID: <2026051508-cabdriver-cost-e112@gregkh>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026051508-corset-rundown-5e61@gregkh>
References: <2026051508-corset-rundown-5e61@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 16257550C21
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247772-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.964];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

diff --git a/Makefile b/Makefile
index a854e46c1171..a0565b83ae40 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 7
 PATCHLEVEL = 0
-SUBLEVEL = 7
+SUBLEVEL = 8
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
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
index 9852444627a0..e2b636961254 100644
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

