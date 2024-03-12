Return-Path: <stable+bounces-27544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 283D3879EFB
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 23:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939301F22926
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 22:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1BB1CA8F;
	Tue, 12 Mar 2024 22:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+ZdT+0D"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C095426286
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 22:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710283241; cv=none; b=gZupdNy4ckGJOP91EiGqNFzZu1dpPhzGzmT7NM9WUB0tkvZB5c+BSm2JgQmwVddKR5egOJf0248fTMBCBsTBUEY87803LEQgoje8KZ/oZW0wCQMG/tQOQfAjZNhMqg3HW46nUY3ZU/1Q0IhJ5EhAwY2iFHY0OpQE600uMipIyZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710283241; c=relaxed/simple;
	bh=QJk7+rDOFBmXDYiizUoh8an0yb95FTgkKApqEUDwEac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jED62gjd+VHRkCx2vk22UF9k9btQgOHuKP/rQIX6yocPtoT7iWLakT/hZIth+R4m9e5NruvybPHi64Hu/qF3ZVlgyHyHsmjo9AoeqqTI4idmrTZerIhyE/uNOep93zM0IscTCDd+6/YzHa6H4b+dj07fDyxyarFvQLe+X9S3zJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X+ZdT+0D; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710283240; x=1741819240;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QJk7+rDOFBmXDYiizUoh8an0yb95FTgkKApqEUDwEac=;
  b=X+ZdT+0DE7yOmsDORiIgD06VuXCWMoSLRGt+uSxTJvIfzNv/5sDql8vf
   hJjEgp6NAsy9G7Eu8Bdhj+wT2xaKC76CIYyOv/ia7vuAGf3rDE8ljZDu9
   9Y58hYSridxhX1XdGHbZIpjcv7SaZF9aGOvZ9uiNu1C4VBJQmitNRzwJn
   +afI8/iJzoT81Xe3tK8yjZkCCI03h6QP4RLfjoZ+AvBY8AU0IZ4A20v0V
   vJaeZ8xvhIsUC0iJ2j0N9lVr1dPQ5kYT2la1haSjhmnsDbj0mEbhQcvtB
   B8IHNji8pmet+3ZdSB6KTYyGPvN+VFBmlyMgpr+TSlTYofarnu7Bk2E+I
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="22475890"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="22475890"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:40:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="12116160"
Received: from arnabkar-mobl1.amr.corp.intel.com (HELO desk) ([10.209.69.57])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:40:40 -0700
Date: Tue, 12 Mar 2024 15:40:39 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 5.10.y v2 03/11] x86/entry_64: Add VERW just before userspace
 transition
Message-ID: <20240312-delay-verw-backport-5-10-y-v2-3-ad081ccd89ca@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240312-delay-verw-backport-5-10-y-v2-0-ad081ccd89ca@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312-delay-verw-backport-5-10-y-v2-0-ad081ccd89ca@linux.intel.com>

commit 3c7501722e6b31a6e56edd23cea5e77dbb9ffd1a upstream.

Mitigation for MDS is to use VERW instruction to clear any secrets in
CPU Buffers. Any memory accesses after VERW execution can still remain
in CPU buffers. It is safer to execute VERW late in return to user path
to minimize the window in which kernel data can end up in CPU buffers.
There are not many kernel secrets to be had after SWITCH_TO_USER_CR3.

Add support for deploying VERW mitigation after user register state is
restored. This helps minimize the chances of kernel data ending up into
CPU buffers after executing VERW.

Note that the mitigation at the new location is not yet enabled.

  Corner case not handled
  =======================
  Interrupts returning to kernel don't clear CPUs buffers since the
  exit-to-user path is expected to do that anyways. But, there could be
  a case when an NMI is generated in kernel after the exit-to-user path
  has cleared the buffers. This case is not handled and NMI returning to
  kernel don't clear CPU buffers because:

  1. It is rare to get an NMI after VERW, but before returning to user.
  2. For an unprivileged user, there is no known way to make that NMI
     less rare or target it.
  3. It would take a large number of these precisely-timed NMIs to mount
     an actual attack.  There's presumably not enough bandwidth.
  4. The NMI in question occurs after a VERW, i.e. when user state is
     restored and most interesting data is already scrubbed. Whats left
     is only the data that NMI touches, and that may or may not be of
     any interest.

  [ pawan: resolved conflict in syscall_return_via_sysret, added
           CLEAR_CPU_BUFFERS to USERGS_SYSRET64 ]

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240213-delay-verw-v8-2-a6216d83edb7%40linux.intel.com
---
 arch/x86/entry/entry_64.S        | 10 ++++++++++
 arch/x86/entry/entry_64_compat.S |  1 +
 arch/x86/include/asm/irqflags.h  |  1 +
 3 files changed, 12 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 23212c53cef7..1631a9a1566e 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -615,6 +615,7 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 	/* Restore RDI. */
 	popq	%rdi
 	SWAPGS
+	CLEAR_CPU_BUFFERS
 	INTERRUPT_RETURN
 
 
@@ -721,6 +722,8 @@ native_irq_return_ldt:
 	 */
 	popq	%rax				/* Restore user RAX */
 
+	CLEAR_CPU_BUFFERS
+
 	/*
 	 * RSP now points to an ordinary IRET frame, except that the page
 	 * is read-only and RSP[31:16] are preloaded with the userspace
@@ -1487,6 +1490,12 @@ nmi_restore:
 	std
 	movq	$0, 5*8(%rsp)		/* clear "NMI executing" */
 
+	/*
+	 * Skip CLEAR_CPU_BUFFERS here, since it only helps in rare cases like
+	 * NMI in kernel after user state is restored. For an unprivileged user
+	 * these conditions are hard to meet.
+	 */
+
 	/*
 	 * iretq reads the "iret" frame and exits the NMI stack in a
 	 * single instruction.  We are returning to kernel mode, so this
@@ -1504,6 +1513,7 @@ SYM_CODE_END(asm_exc_nmi)
 SYM_CODE_START(ignore_sysret)
 	UNWIND_HINT_EMPTY
 	mov	$-ENOSYS, %eax
+	CLEAR_CPU_BUFFERS
 	sysretl
 SYM_CODE_END(ignore_sysret)
 #endif
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 4d637a965efb..7f09e7ad3c74 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -319,6 +319,7 @@ sysret32_from_system_call:
 	xorl	%r9d, %r9d
 	xorl	%r10d, %r10d
 	swapgs
+	CLEAR_CPU_BUFFERS
 	sysretl
 SYM_CODE_END(entry_SYSCALL_compat)
 
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 8c86edefa115..f40dea50dfbf 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -134,6 +134,7 @@ static __always_inline unsigned long arch_local_irq_save(void)
 #define INTERRUPT_RETURN	jmp native_iret
 #define USERGS_SYSRET64				\
 	swapgs;					\
+	CLEAR_CPU_BUFFERS;			\
 	sysretq;
 #define USERGS_SYSRET32				\
 	swapgs;					\

-- 
2.34.1



