Return-Path: <stable+bounces-242899-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBAhDkNc+GnatQIAu9opvQ
	(envelope-from <stable+bounces-242899-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:43:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAB04BA6B2
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20177300E3D1
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 08:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481F1340280;
	Mon,  4 May 2026 08:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A38896MD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CADD1B86C7
	for <stable@vger.kernel.org>; Mon,  4 May 2026 08:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884168; cv=none; b=P4KBi6Ljx320DYbr4jvgdeuMzQygGzp0SjYTsqCbZR5y2ghXAvdF7jpiCJIGmB3KPtrHcm2+UtFyRnLzyxDC7pGulSMxdTesQWWIhi2BT2LWuFx4Q2ZcbEA+XeAFgQPs0TdXWm2+DG8jvy7GgdxN+WdJDIB79jk9jkEN/YKUUi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884168; c=relaxed/simple;
	bh=uFE24XOTTnMPr7BzTg96eUnMptJfLoTP4bI9E7dC4yE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=g3rZdh74TWjKrBQ2FTYrmNvtpRN5y0bhqINwYehbKM35dxetNwgH7rKfj0dGXd68l9citWna162OqEDcoRAk1iGqvdroDCiMHTqx7o3VDO3G9DrqMMBgzwYskvBUn0zMv3mjF0ImoxoJUSxepLglFk81mw2XgcCgFIIg4mL8hB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A38896MD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96685C2BCB8;
	Mon,  4 May 2026 08:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777884167;
	bh=uFE24XOTTnMPr7BzTg96eUnMptJfLoTP4bI9E7dC4yE=;
	h=Subject:To:Cc:From:Date:From;
	b=A38896MDN3XQPjqw4UD9xQI55XDjygvdw5D1iEvMc6Gt9wQVMS5diFUUa9VOW6wXm
	 bKYUl4Umf8kfPcuDT8T6EjrY6sMbyr9a4poDeIL/7krzFgLrWfonvKxATTPwcpnl9J
	 0aFQj+G3MH14ZwojQqVgadxOO9m6xARLx4T7aOPc=
Subject: FAILED: patch "[PATCH] x86/shstk: Prevent deadlock during shstk sigreturn" failed to apply to 6.6-stable tree
To: rick.p.edgecombe@intel.com,dave.hansen@intel.com,tglx@kernel.org,torvalds@linux-foundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 May 2026 10:42:37 +0200
Message-ID: <2026050437-throat-unrivaled-2769@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DEAB04BA6B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242899-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:email,intel.com:email,linuxfoundation.org:dkim]


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9874b2917b9fbc30956fee209d3c4aa47201c64e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050437-throat-unrivaled-2769@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9874b2917b9fbc30956fee209d3c4aa47201c64e Mon Sep 17 00:00:00 2001
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
Date: Thu, 9 Apr 2026 11:43:30 -0700
Subject: [PATCH] x86/shstk: Prevent deadlock during shstk sigreturn

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

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 99bb5217649a..f3f7cb01d69d 100644
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
index 0962ae4c3017..0ca64900192f 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -326,10 +326,8 @@ static int shstk_push_sigframe(unsigned long *ssp)
 
 static int shstk_pop_sigframe(unsigned long *ssp)
 {
-	struct vm_area_struct *vma;
 	unsigned long token_addr;
-	bool need_to_check_vma;
-	int err = 1;
+	unsigned int seq;
 
 	/*
 	 * It is possible for the SSP to be off the end of a shadow stack by 4
@@ -340,25 +338,35 @@ static int shstk_pop_sigframe(unsigned long *ssp)
 	if (!IS_ALIGNED(*ssp, 8))
 		return -EINVAL;
 
-	need_to_check_vma = PAGE_ALIGN(*ssp) == *ssp;
+	do {
+		struct vm_area_struct *vma;
+		bool valid_vma;
+		int err;
 
-	if (need_to_check_vma)
 		if (mmap_read_lock_killable(current->mm))
 			return -EINTR;
 
-	err = get_shstk_data(&token_addr, (unsigned long __user *)*ssp);
-	if (unlikely(err))
-		goto out_err;
-
-	if (need_to_check_vma) {
 		vma = find_vma(current->mm, *ssp);
-		if (!vma || !(vma->vm_flags & VM_SHADOW_STACK)) {
-			err = -EFAULT;
-			goto out_err;
-		}
+		valid_vma = vma && (vma->vm_flags & VM_SHADOW_STACK);
 
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
+		err = get_shstk_data(&token_addr, (unsigned long __user *)*ssp);
+		if (err)
+			return err;
+	} while (mmap_lock_speculate_retry(current->mm, seq));
 
 	/* Restore SSP aligned? */
 	if (unlikely(!IS_ALIGNED(token_addr, 8)))
@@ -371,10 +379,6 @@ static int shstk_pop_sigframe(unsigned long *ssp)
 	*ssp = token_addr;
 
 	return 0;
-out_err:
-	if (need_to_check_vma)
-		mmap_read_unlock(current->mm);
-	return err;
 }
 
 int setup_signal_shadow_stack(struct ksignal *ksig)


