Return-Path: <stable+bounces-240002-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kATEJJWT5mnGyQEAu9opvQ
	(envelope-from <stable+bounces-240002-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 22:59:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB81433DBE
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 22:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFD063007AC2
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58830388E40;
	Mon, 20 Apr 2026 20:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zv5n4l7p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2aVmVScr"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4982D7D3A;
	Mon, 20 Apr 2026 20:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776718726; cv=none; b=ZDsrqIVvq+aIuukSlm8k2/BVUAqIqyaHy7myYAdkH/3vdm55lbnCHMsuVnNhtItkQSkeAL1YM/YuIajKVfcHgRSJqFEU/U4BVJwY/I5W9AsrOqoK1scnaY6xP4ZtOtUd1QBIB9WWd50R9Q4EGSReOlZDkzcht9b09vao+v27nFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776718726; c=relaxed/simple;
	bh=kBLMYYUW8k3OQFqUcMvPQJd9UwULXFsPCzSd1JlMlhs=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=aA6d1L0Xkdn6vPWCpy9/qiaQytf29dr008H7A608Hl/xKzSAq/DdWFhbr0jN4bGj40uvPOnoh3s0qsBsf2WhA7N7imH9d0kXE+xnwLW/hTPXhCL9mO8f2R5p+agmyPyyE6X4j70zowEFddvfr67LsHL4oNfzNCspXEM2mRL1ljE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zv5n4l7p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2aVmVScr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 20 Apr 2026 20:58:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776718722;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=178EqlvaX0rCaKmJXSzWU/4JfL+C4JG9e5U1G7QmOHo=;
	b=Zv5n4l7p+kF0A61mlh00f3PhQKvnY3qNxcOvDKOItrWDpK2VvhGhxIeUt4pDq1XH9C03yr
	/6/p6BGZzKsZ38nrFt6uARl8L+kjUz1eyfym6JzLoNQvH1qPb72RyI9Fq22iSymtBluI7x
	nzq5bgQBvCvud3UJGsw1jTuHVud0Mr15mTnvQWY5zG73Cu0lihFTvCHIx7XmuRBvsrZ9sG
	Tqn8I4NeBFFomwuzZvwlFIfpfdBWcc0MduLZ65pQgcEn7EPkx+1WTo9sTpINn5TPy9oGac
	w9RtUteM/lGYWA9WcmSt4P4wkZYJDK40EYK2DS3Zb5iSz2iWZR3qSLPln3EuVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776718722;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=178EqlvaX0rCaKmJXSzWU/4JfL+C4JG9e5U1G7QmOHo=;
	b=2aVmVScrFyV7W9gNGAGc/R9nR+EeT4Irvdko6bobGmWLyL044wFbo3ALaaodAdNalEMEkr
	5NQtMceeC3kqyjAA==
From: "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/shstk: Prevent deadlock during shstk sigreturn
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Thomas Gleixner <tglx@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177671872110.2419917.14323935361056076481.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240002-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,intel.com:email,linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EFB81433DBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     9874b2917b9fbc30956fee209d3c4aa47201c64e
Gitweb:        https://git.kernel.org/tip/9874b2917b9fbc30956fee209d3c4aa4720=
1c64e
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Thu, 09 Apr 2026 11:43:30 -07:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 20 Apr 2026 22:54:24 +02:00

x86/shstk: Prevent deadlock during shstk sigreturn

During sigreturn the shadow stack signal frame is popped. The kernel does
this by reading the shadow stack using normal read accesses. When it can't
assume the memory is shadow stack, it takes extra steps to makes sure it is
reading actual shadow stack memory and not other normal readable memory. It
does this by holding the mmap read lock while doing the access and checking
the flags of the VMA.

Unfortunately that is not safe. If the read of the shadow stack sigframe
hits a page fault, the fault handler will try to recursively grab another
mmap read lock. This normally works ok, but if a writer on another CPU is
also waiting, the second read lock could fail and cause a deadlock.

Fix this by not holding mmap lock during the read access to userspace.

Instead use mmap_lock_speculate_...() to watch for changes between dropping
mmap lock and the userspace access. Retry if anything grabbed an mmap write
lock in between and could have changed the VMA.

These mmap_lock_speculate_...() helpers use mm::mm_lock_seq, which is only
available when PER_VMA_LOCK is configured. So make X86_USER_SHADOW_STACK
depend on it. On x86, PER_VMA_LOCK is a default configuration for SMP
kernels. So drop support for the other configs under the assumption that
the !SMP shadow stack user base does not exist.

Currently there is a check that skips the lookup work when the SSP can be
assumed to be on a shadow stack. While reorganizing the function, remove
the optimization to make the tricky code flows more common, such that
issues like this cannot escape detection for so long.

Fixes: 7fad2a432cd3 ("x86/shstk: Check that signal frame is shadow stack mem")
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Reviewed-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/x86/Kconfig        |  1 +-
 arch/x86/kernel/shstk.c | 44 +++++++++++++++++++++-------------------
 2 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 99bb521..f3f7cb0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1885,6 +1885,7 @@ config X86_USER_SHADOW_STACK
 	bool "X86 userspace shadow stack"
 	depends on AS_WRUSS
 	depends on X86_64
+	depends on PER_VMA_LOCK
 	select ARCH_USES_HIGH_VMA_FLAGS
 	select ARCH_HAS_USER_SHADOW_STACK
 	select X86_CET
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 0962ae4..0ca6490 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -326,10 +326,8 @@ static int shstk_push_sigframe(unsigned long *ssp)
=20
 static int shstk_pop_sigframe(unsigned long *ssp)
 {
-	struct vm_area_struct *vma;
 	unsigned long token_addr;
-	bool need_to_check_vma;
-	int err =3D 1;
+	unsigned int seq;
=20
 	/*
 	 * It is possible for the SSP to be off the end of a shadow stack by 4
@@ -340,25 +338,35 @@ static int shstk_pop_sigframe(unsigned long *ssp)
 	if (!IS_ALIGNED(*ssp, 8))
 		return -EINVAL;
=20
-	need_to_check_vma =3D PAGE_ALIGN(*ssp) =3D=3D *ssp;
+	do {
+		struct vm_area_struct *vma;
+		bool valid_vma;
+		int err;
=20
-	if (need_to_check_vma)
 		if (mmap_read_lock_killable(current->mm))
 			return -EINTR;
=20
-	err =3D get_shstk_data(&token_addr, (unsigned long __user *)*ssp);
-	if (unlikely(err))
-		goto out_err;
-
-	if (need_to_check_vma) {
 		vma =3D find_vma(current->mm, *ssp);
-		if (!vma || !(vma->vm_flags & VM_SHADOW_STACK)) {
-			err =3D -EFAULT;
-			goto out_err;
-		}
-
+		valid_vma =3D vma && (vma->vm_flags & VM_SHADOW_STACK);
+
+		/*
+		 * VMAs can change between get_shstk_data() and find_vma().
+		 * Watch for changes and ensure that 'token_addr' comes from
+		 * 'vma' by recording a seqcount.
+		 *
+		 * Ignore the return value of mmap_lock_speculate_try_begin()
+		 * because the mmap lock excludes the possibility of writers.
+		 */
+		mmap_lock_speculate_try_begin(current->mm, &seq);
 		mmap_read_unlock(current->mm);
-	}
+
+		if (!valid_vma)
+			return -EINVAL;
+
+		err =3D get_shstk_data(&token_addr, (unsigned long __user *)*ssp);
+		if (err)
+			return err;
+	} while (mmap_lock_speculate_retry(current->mm, seq));
=20
 	/* Restore SSP aligned? */
 	if (unlikely(!IS_ALIGNED(token_addr, 8)))
@@ -371,10 +379,6 @@ static int shstk_pop_sigframe(unsigned long *ssp)
 	*ssp =3D token_addr;
=20
 	return 0;
-out_err:
-	if (need_to_check_vma)
-		mmap_read_unlock(current->mm);
-	return err;
 }
=20
 int setup_signal_shadow_stack(struct ksignal *ksig)

