Return-Path: <stable+bounces-267665-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id grG4KAIPOWqQmAcAu9opvQ
	(envelope-from <stable+bounces-267665-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 12:31:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE066AEB6D
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 12:31:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b="ErM/0Igd";
	dkim=pass header.d=linutronix.de header.s=2020e header.b=ZnkUWZDP;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267665-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267665-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4761B3066260
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 10:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F78A3A543A;
	Mon, 22 Jun 2026 10:26:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FBA3A5445
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 10:26:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124018; cv=none; b=t2DAWQPLnR1Ws5Io/WtK5fZTDPSMevxt1nomWFQolcrHIZdzY/gecoj/cHopyfYQa+Botbkjra3w08gTrTB4/d/Wp+YnaCMeuqSuGxzHcu+DEAr9xuVuzUj+YAumXuwYqKzrfJ/n5sCrYh+o2qCyez0Or5MCGshEN884G5T3GPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124018; c=relaxed/simple;
	bh=KvG4rcMBh6pHSgQoXTvPActQ05cCrhliwHH4GG8l4I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFXqPHTo7AkMVvPGGlEsh++JDC6T4aOWCYiMbvYy4lcqP02CSyQdv6pdLoSGv06LB4CAjIBqg9j5FUubfa346cL868pxI7nddCQBTccsEfdOY1fwroSABTZVUkFeabkNhLuOY5n99ofbLX+fMRsOwnAEGN0hlJEiNaWxE3IzINI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ErM/0Igd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZnkUWZDP; arc=none smtp.client-ip=193.142.43.55
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782124015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nACALUu0nPjGj38lA0InCvBNsegQPdKco+0dwwn67f8=;
	b=ErM/0IgdZWFB6XWSaxUtjRwSw3Vk9wgcU4od8sJ5UK4BIp3Fct/VdFyi6aGfB2hhUojH7v
	yV0OrWsa8cMGPeng1NPwM3I1S2xo/sYpbm/9Xi2fMJAbYENSId/6QO9JhnVqtRi6iO++1y
	ATMBbpPg5A9/RTGoNbxQ8xF4PebKm3JZDhLgy+AczqDjWhZtgmq1lwGPsAfOsOIhon3M4B
	veyJbf8TnSrA6qwoGtnK/+olZDaOWL2nNabalH1god/FEwe4W4cJ7dHsWUWBAuaHxNZsi1
	fE4+lYGgZYyUhZhIGRxRgnLfI/QB++XCbhEJ/ok6zpvZNOhIdkHTGGodrgRzug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782124015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nACALUu0nPjGj38lA0InCvBNsegQPdKco+0dwwn67f8=;
	b=ZnkUWZDPjPSjrxGB9iw/bBvN4JG/TSaaem6CbUON0trNdnguqPpcSqj+OMlAEO37ftIWo6
	cW4uThNm3zVi8OBA==
To: stable@vger.kernel.org
Cc: Bryan Brattlof <bb@ti.com>,
	Daniel Wagner <daniel.wagner@monom.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	cip-dev@lists.cip-project.org,
	nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Xie Yuanbin <xieyuanbin1@huawei.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/4] ARM: fix branch predictor hardening
Date: Mon, 22 Jun 2026 12:26:34 +0200
Message-ID: <20260622102634.780100-5-bigeasy@linutronix.de>
In-Reply-To: <20260622102634.780100-1-bigeasy@linutronix.de>
References: <20260622102634.780100-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267665-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:bb@ti.com,m:daniel.wagner@monom.org,m:jan.kiszka@siemens.com,m:cip-dev@lists.cip-project.org,m:nobuhiro.iwamatsu.x90@mail.toshiba,m:pavel@nabladev.com,m:rmk+kernel@armlinux.org.uk,m:xieyuanbin1@huawei.com,m:bigeasy@linutronix.de,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,huawei.com:email,armlinux.org.uk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EDE066AEB6D

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

commit fd2dee1c6e2256f726ba33fd3083a7be0efc80d3 upstream.

__do_user_fault() may be called with indeterminent interrupt enable
state, which means we may be preemptive at this point. This causes
problems when calling harden_branch_predictor(). For example, when
called from a data abort, do_alignment_fault()->do_bad_area().

Move harden_branch_predictor() out of __do_user_fault() and into the
calling contexts.

Moving it into do_kernel_address_page_fault(), we can be sure that
interrupts will be disabled here.

Converting do_translation_fault() to use do_kernel_address_page_fault()
rather than do_bad_area() means that we keep branch predictor handling
for translation faults. Interrupts will also be disabled at this call
site.

do_sect_fault() needs special handling, so detect user mode accesses
to kernel-addresses, and add an explicit call to branch predictor
hardening.

Finally, add branch predictor hardening to do_alignment() for the
faulting case (user mode accessing kernel addresses) before interrupts
are enabled.

This should cover all cases where harden_branch_predictor() is called,
ensuring that it is always has interrupts disabled, also ensuring that
it is called early in each call path.

Reviewed-by: Xie Yuanbin <xieyuanbin1@huawei.com>
Tested-by: Xie Yuanbin <xieyuanbin1@huawei.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/mm/alignment.c |  4 ++++
 arch/arm/mm/fault.c     | 39 ++++++++++++++++++++++++++-------------
 2 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index f8dd0b3cc8e04..ee264737be6d2 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -22,6 +22,7 @@
=20
 #include <asm/cp15.h>
 #include <asm/system_info.h>
+#include <asm/system_misc.h>
 #include <asm/unaligned.h>
 #include <asm/opcodes.h>
=20
@@ -809,6 +810,9 @@ do_alignment(unsigned long addr, unsigned int fsr, stru=
ct pt_regs *regs)
 	int thumb2_32b =3D 0;
 	int fault;
=20
+	if (addr >=3D TASK_SIZE && user_mode(regs))
+		harden_branch_predictor();
+
 	if (interrupts_enabled(regs))
 		local_irq_enable();
=20
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 47eecdf29a831..87ed5da30e44f 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -199,9 +199,6 @@ __do_user_fault(unsigned long addr, unsigned int fsr, u=
nsigned int sig,
 {
 	struct task_struct *tsk =3D current;
=20
-	if (addr > TASK_SIZE)
-		harden_branch_predictor();
-
 #ifdef CONFIG_DEBUG_USER
 	if (((user_debug & UDBG_SEGV) && (sig =3D=3D SIGSEGV)) ||
 	    ((user_debug & UDBG_BUS)  && (sig =3D=3D SIGBUS))) {
@@ -252,8 +249,10 @@ do_kernel_address_page_fault(struct mm_struct *mm, uns=
igned long addr,
 		/*
 		 * Fault from user mode for a kernel space address. User mode
 		 * should not be faulting in kernel space, which includes the
-		 * vector/khelper page. Send a SIGSEGV.
+		 * vector/khelper page. Handle the branch predictor hardening
+		 * while interrupts are still disabled, then send a SIGSEGV.
 		 */
+		harden_branch_predictor();
 		__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
 	} else {
 		/*
@@ -423,16 +422,20 @@ do_page_fault(unsigned long addr, unsigned int fsr, s=
truct pt_regs *regs)
  * We enter here because the first level page table doesn't contain
  * a valid entry for the address.
  *
- * If the address is in kernel space (>=3D TASK_SIZE), then we are
- * probably faulting in the vmalloc() area.
+ * If this is a user address (addr < TASK_SIZE), we handle this as a
+ * normal page fault. This leaves the remainder of the function to handle
+ * kernel address translation faults.
  *
- * If the init_task's first level page tables contains the relevant
- * entry, we copy the it to this task.  If not, we send the process
- * a signal, fixup the exception, or oops the kernel.
+ * Since user mode is not permitted to access kernel addresses, pass these
+ * directly to do_kernel_address_page_fault() to handle.
  *
- * NOTE! We MUST NOT take any locks for this case. We may be in an
- * interrupt or a critical region, and should only copy the information
- * from the master page table, nothing more.
+ * Otherwise, we're probably faulting in the vmalloc() area, so try to fix
+ * that up. Note that we must not take any locks or enable interrupts in
+ * this case.
+ *
+ * If vmalloc() fixup fails, that means the non-leaf page tables did not
+ * contain an entry for this address, so handle this via
+ * do_kernel_address_page_fault().
  */
 #ifdef CONFIG_MMU
 static int __kprobes
@@ -498,7 +501,8 @@ do_translation_fault(unsigned long addr, unsigned int f=
sr,
 	return 0;
=20
 bad_area:
-	do_bad_area(addr, fsr, regs);
+	do_kernel_address_page_fault(current->mm, addr, fsr, regs);
+
 	return 0;
 }
 #else					/* CONFIG_MMU */
@@ -518,7 +522,16 @@ do_translation_fault(unsigned long addr, unsigned int =
fsr,
 static int
 do_sect_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
+	/*
+	 * If this is a kernel address, but from user mode, then userspace
+	 * is trying bad stuff. Invoke the branch predictor handling.
+	 * Interrupts are disabled here.
+	 */
+	if (addr >=3D TASK_SIZE && user_mode(regs))
+		harden_branch_predictor();
+
 	do_bad_area(addr, fsr, regs);
+
 	return 0;
 }
 #endif /* CONFIG_ARM_LPAE */
--=20
2.53.0


