Return-Path: <stable+bounces-124188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C098CA5E75D
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 23:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00AAA16DD65
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 22:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EF31F03DA;
	Wed, 12 Mar 2025 22:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BUBXHGx7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06831EDA35;
	Wed, 12 Mar 2025 22:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818375; cv=none; b=MI5zGTjAoRkIr4AW6JbK6gkdcn7UHfgqvMtbGLAbWpCdXg39iN3ei4IuPTm58QHhf9DFLZteZEDyKQJ1NK/h7lz+IjP728HTNaoDcguPZsKN46vQO2DN9k3wxbuSVIir7fyECt9FZt+Hd9NmD4a+B1CJn3biegESF2+y9xp94zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818375; c=relaxed/simple;
	bh=HuX/Rj4sFbmA7KQot7MAho9D9tXAy4PDUehxEjbdNR0=;
	h=Date:To:From:Subject:Message-Id; b=GN/xcyroV51RuASPOTT4NbNwfm9UFvYhYjN50kv08GWxKDS0FBXvECcucLkM89+sQcydyTJRS5sDAA8DU6dl4v5RVhxe6z/6/7tsaQaNWu5ZpJQHN5Ul0ecyhuoJ2sMSWmhG5inSqJJV4ivUd+USuI/7hdeunfCig7N8enYabLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BUBXHGx7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A140C4CEDD;
	Wed, 12 Mar 2025 22:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741818374;
	bh=HuX/Rj4sFbmA7KQot7MAho9D9tXAy4PDUehxEjbdNR0=;
	h=Date:To:From:Subject:From;
	b=BUBXHGx7VoPrR3w4hbhkSU5iaSiumC86S3IvVEJIWldwjgEKeGrwOFZvq4LTWEn+f
	 mF/cHN17kx+1goM1E+Kqg5GFcVpNTfVAUV7GccLlEKRmOh1WhJMiSaN7ajM2oyhnbc
	 E1hEnqId4uPc+gk+o9zEZbZXzyNAHB/FdTXG5J2k=
Date: Wed, 12 Mar 2025 15:26:13 -0700
To: mm-commits@vger.kernel.org,yazen.ghannam@amd.com,tony.luck@intel.com,tianruidong@linux.alibaba.com,tglx@linutronix.de,stable@vger.kernel.org,peterz@infradead.org,nao.horiguchi@gmail.com,mingo@redhat.com,linmiaohe@huawei.com,jpoimboe@kernel.org,Jonathan.Cameron@huawei.com,jarkko@kernel.org,jane.chu@oracle.com,hpa@zytor.com,dave.hansen@linux.intel.com,catalin.marinas@arm.com,bp@alien8.de,baolin.wang@linux.alibaba.com,xueshuai@linux.alibaba.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + x86-mce-use-is_copy_from_user-to-determine-copy-from-user-context.patch added to mm-unstable branch
Message-Id: <20250312222614.4A140C4CEDD@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: x86/mce: use is_copy_from_user() to determine copy-from-user context
has been added to the -mm mm-unstable branch.  Its filename is
     x86-mce-use-is_copy_from_user-to-determine-copy-from-user-context.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/x86-mce-use-is_copy_from_user-to-determine-copy-from-user-context.patch

This patch will later appear in the mm-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Shuai Xue <xueshuai@linux.alibaba.com>
Subject: x86/mce: use is_copy_from_user() to determine copy-from-user context
Date: Wed, 12 Mar 2025 19:28:50 +0800

Patch series "mm/hwpoison: Fix regressions in memory failure handling",
v4.

## 1. What am I trying to do:

This patchset resolves two critical regressions related to memory failure
handling that have appeared in the upstream kernel since version 5.17, as
compared to 5.10 LTS.

    - copyin case: poison found in user page while kernel copying from user space
    - instr case: poison found while instruction fetching in user space

## 2. What is the expected outcome and why

- For copyin case:

Kernel can recover from poison found where kernel is doing get_user() or
copy_from_user() if those places get an error return and the kernel return
-EFAULT to the process instead of crashing.  More specifily, MCE handler
checks the fixup handler type to decide whether an in kernel #MC can be
recovered.  When EX_TYPE_UACCESS is found, the PC jumps to recovery code
specified in _ASM_EXTABLE_FAULT() and return a -EFAULT to user space.

- For instr case:

If a poison found while instruction fetching in user space, full recovery
is possible.  User process takes #PF, Linux allocates a new page and fills
by reading from storage.


## 3. What actually happens and why

- For copyin case: kernel panic since v5.17

Commit 4c132d1d844a ("x86/futex: Remove .fixup usage") introduced a new
extable fixup type, EX_TYPE_EFAULT_REG, and later patches updated the
extable fixup type for copy-from-user operations, changing it from
EX_TYPE_UACCESS to EX_TYPE_EFAULT_REG.  It breaks previous EX_TYPE_UACCESS
handling when posion found in get_user() or copy_from_user().

- For instr case: user process is killed by a SIGBUS signal due to #CMCI
  and #MCE race

When an uncorrected memory error is consumed there is a race between the
CMCI from the memory controller reporting an uncorrected error with a UCNA
signature, and the core reporting and SRAR signature machine check when
the data is about to be consumed.

### Background: why *UN*corrected errors tied to *C*MCI in Intel platform [1]

Prior to Icelake memory controllers reported patrol scrub events that
detected a previously unseen uncorrected error in memory by signaling a
broadcast machine check with an SRAO (Software Recoverable Action
Optional) signature in the machine check bank.  This was overkill because
it's not an urgent problem that no core is on the verge of consuming that
bad data.  It's also found that multi SRAO UCE may cause nested MCE
interrupts and finally become an IERR.

Hence, Intel downgrades the machine check bank signature of patrol scrub
from SRAO to UCNA (Uncorrected, No Action required), and signal changed to
#CMCI.  Just to add to the confusion, Linux does take an action (in
uc_decode_notifier()) to try to offline the page despite the UC*NA*
signature name.

### Background: why #CMCI and #MCE race when poison is consuming in
    Intel platform [1]

Having decided that CMCI/UCNA is the best action for patrol scrub errors,
the memory controller uses it for reads too.  But the memory controller is
executing asynchronously from the core, and can't tell the difference
between a "real" read and a speculative read.  So it will do CMCI/UCNA if
an error is found in any read.

Thus:

1) Core is clever and thinks address A is needed soon, issues a
   speculative read.

2) Core finds it is going to use address A soon after sending the read
   request

3) The CMCI from the memory controller is in a race with MCE from the
   core that will soon try to retire the load from address A.

Quite often (because speculation has got better) the CMCI from the memory
controller is delivered before the core is committed to the instruction
reading address A, so the interrupt is taken, and Linux offlines the page
(marking it as poison).


## Why user process is killed for instr case

Commit 046545a661af ("mm/hwpoison: fix error page recovered but reported
"not recovered"") tries to fix noise message "Memory error not recovered"
and skips duplicate SIGBUSs due to the race.  But it also introduced a bug
that kill_accessing_process() return -EHWPOISON for instr case, as result,
kill_me_maybe() send a SIGBUS to user process.

# 4. The fix, in my opinion, should be:

- For copyin case:

The key point is whether the error context is in a read from user memory. 
We do not care about the ex-type if we know its a MOV reading from
userspace.

is_copy_from_user() return true when both of the following two checks are
true:

    - the current instruction is copy
    - source address is user memory

If copy_user is true, we set

m->kflags |= MCE_IN_KERNEL_COPYIN | MCE_IN_KERNEL_RECOV;

Then do_machine_check() will try fixup_exception() first.

- For instr case: let kill_accessing_process() return 0 to prevent a SIGBUS.

- For patch 3:

The return value of memory_failure() is quite important while discussed
instr case regression with Tony and Miaohe for patch 2, so add comment
about the return value.


This patch (of 3):

Commit 4c132d1d844a ("x86/futex: Remove .fixup usage") introduced a new
extable fixup type, EX_TYPE_EFAULT_REG, and commit 4c132d1d844a
("x86/futex: Remove .fixup usage") updated the extable fixup type for
copy-from-user operations, changing it from EX_TYPE_UACCESS to
EX_TYPE_EFAULT_REG.  The error context for copy-from-user operations no
longer functions as an in-kernel recovery context.  Consequently, the
error context for copy-from-user operations no longer functions as an
in-kernel recovery context, resulting in kernel panics with the message:
"Machine check: Data load in unrecoverable area of kernel."

To address this, it is crucial to identify if an error context involves a
read operation from user memory.  The function is_copy_from_user() can be
utilized to determine:

    - the current operation is copy
    - when reading user memory

When these conditions are met, is_copy_from_user() will return true,
confirming that it is indeed a direct copy from user memory.  This check
is essential for correctly handling the context of errors in these
operations without relying on the extable fixup types that previously
allowed for in-kernel recovery.

So, use is_copy_from_user() to determine if a context is copy user directly.

Link: https://lkml.kernel.org/r/20250312112852.82415-1-xueshuai@linux.alibaba.com
Link: https://lkml.kernel.org/r/20250312112852.82415-2-xueshuai@linux.alibaba.com
Fixes: 4c132d1d844a ("x86/futex: Remove .fixup usage")
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Tony Luck <tony.luck@intel.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Borislav Betkov <bp@alien8.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Ruidong Tian <tianruidong@linux.alibaba.com>
Cc: Thomas Gleinxer <tglx@linutronix.de>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Jane Chu <jane.chu@oracle.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/x86/kernel/cpu/mce/severity.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/arch/x86/kernel/cpu/mce/severity.c~x86-mce-use-is_copy_from_user-to-determine-copy-from-user-context
+++ a/arch/x86/kernel/cpu/mce/severity.c
@@ -300,13 +300,12 @@ static noinstr int error_context(struct
 	copy_user  = is_copy_from_user(regs);
 	instrumentation_end();
 
-	switch (fixup_type) {
-	case EX_TYPE_UACCESS:
-		if (!copy_user)
-			return IN_KERNEL;
-		m->kflags |= MCE_IN_KERNEL_COPYIN;
-		fallthrough;
+	if (copy_user) {
+		m->kflags |= MCE_IN_KERNEL_COPYIN | MCE_IN_KERNEL_RECOV;
+		return IN_KERNEL_RECOV;
+	}
 
+	switch (fixup_type) {
 	case EX_TYPE_FAULT_MCE_SAFE:
 	case EX_TYPE_DEFAULT_MCE_SAFE:
 		m->kflags |= MCE_IN_KERNEL_RECOV;
_

Patches currently in -mm which might be from xueshuai@linux.alibaba.com are

x86-mce-use-is_copy_from_user-to-determine-copy-from-user-context.patch
mm-hwpoison-do-not-send-sigbus-to-processes-with-recovered-clean-pages.patch
mm-memory-failure-enhance-comments-for-return-value-of-memory_failure.patch


