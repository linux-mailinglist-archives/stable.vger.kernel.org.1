Return-Path: <stable+bounces-27525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E485C879D46
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 22:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 122891C20BE2
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 21:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329F2143729;
	Tue, 12 Mar 2024 21:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mBfU3m/8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AAF14291E
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 21:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710277854; cv=none; b=LBh61MDoV+rkWZJcXzjZDCr6pKfZBUevgS23qvjmiP8G1EeOfGn5NWUtK7GVSsQKhX9o4TKDf7D8Q8+FyIlq5WDbKBP3YMEjPOOKJ1ib7ZmZvwG3V3T1/ztTP0BGbv2cCVFSQO/hroni/099KKELPWxQMSanNbnA9q+ramMJvgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710277854; c=relaxed/simple;
	bh=iULivcLdy/bfbLfSrPdJ9AALgxFR7cJ8APSbwNljDC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgBqwO0HgWntdFBNjTug06mMhwAUop6cIfjq9xvc8cJkMw/0PjJDkPInjGGjCj2+OGrzzkgCAUvM3ojeHb+dM9K1niatUqGuoBwy7Ahcns0EVv7qbFzfYIww8RdTENeVNsURE5aB3Kq7qSqmmwMyVcxGodU3wo49yi/tXr6Ru9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mBfU3m/8; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710277853; x=1741813853;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iULivcLdy/bfbLfSrPdJ9AALgxFR7cJ8APSbwNljDC4=;
  b=mBfU3m/8FxM1Lc1GRa1u6ZJ6ywnNYy1Cfe4KnzAWeBBsdQZyofEjMlMf
   XBr1L/JFCppRKatdVxx0aHpZ8IVZCzwBkeRKqu29SQATCVDs65n+9xLKq
   F716Fei9OAtUTUVr7CMAg/kOfey+flKVAH/BuB0rn7wr5RoDlHo/j5ecZ
   vF5+0xN9lRoN0+fek6F5XCv1FIM9IvhMkw/xm9GuXW0M5AQs9pUJrQVv4
   ZdRvmNGlbZu40KFScolz3ehqjk56J/KZuH+3nfafoNWeeCvMs88jul/6P
   b/2Kc/ZqjgCFKLuptkjhNVr+aIL8tr/QA0KL+6S6lVKgrTirkepy5W/uG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5138839"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5138839"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 14:10:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16322721"
Received: from arnabkar-mobl1.amr.corp.intel.com (HELO desk) ([10.209.69.57])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 14:10:52 -0700
Date: Tue, 12 Mar 2024 14:10:51 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 5.15.y v2 03/11] x86/entry_64: Add VERW just before userspace
 transition
Message-ID: <20240312-delay-verw-backport-5-15-y-v2-3-e0f71d17ed1b@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240312-delay-verw-backport-5-15-y-v2-0-e0f71d17ed1b@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312-delay-verw-backport-5-15-y-v2-0-e0f71d17ed1b@linux.intel.com>

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

  [ pawan: resolved conflict for hunk swapgs_restore_regs_and_return_to_usermode ]

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240213-delay-verw-v8-2-a6216d83edb7%40linux.intel.com
---
 arch/x86/entry/entry_64.S        | 11 +++++++++++
 arch/x86/entry/entry_64_compat.S |  1 +
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9f1333a9ee41..abf1db34c647 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -219,6 +219,7 @@ syscall_return_via_sysret:
 	popq	%rdi
 	popq	%rsp
 	swapgs
+	CLEAR_CPU_BUFFERS
 	sysretq
 SYM_CODE_END(entry_SYSCALL_64)
 
@@ -637,6 +638,7 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 	/* Restore RDI. */
 	popq	%rdi
 	SWAPGS
+	CLEAR_CPU_BUFFERS
 	INTERRUPT_RETURN
 
 
@@ -743,6 +745,8 @@ native_irq_return_ldt:
 	 */
 	popq	%rax				/* Restore user RAX */
 
+	CLEAR_CPU_BUFFERS
+
 	/*
 	 * RSP now points to an ordinary IRET frame, except that the page
 	 * is read-only and RSP[31:16] are preloaded with the userspace
@@ -1465,6 +1469,12 @@ nmi_restore:
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
@@ -1482,6 +1492,7 @@ SYM_CODE_END(asm_exc_nmi)
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
 

-- 
2.34.1



