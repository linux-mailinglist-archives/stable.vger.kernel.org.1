Return-Path: <stable+bounces-25865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B4A86FD67
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 10:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC1B1F26151
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 09:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF712224E4;
	Mon,  4 Mar 2024 09:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ie/HIb27"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103CD3717A
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 09:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544242; cv=none; b=hLq/LQil6wAMYSXEqDb43LSFp78BVSvRaLi+FSaLrvtf5d/7T87FhN2kcuag1uluzu3gBzIRrVZ1wyoogigwXIyfJy9UbAwFkDOBhSwoGsYQPG/Ks9i4I0ntUkyZTDM0hbOytKJumWCbdjWSUPI/MebgsFZHkpSoPuF0+9o/9V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544242; c=relaxed/simple;
	bh=dOIwlaZGZjfU0CqVNrkX4v+ksvq5qxQb8Hq031/xvLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpWf/kzwXdX9/D3b0UdP64oD2hL9mQCNG8Adt5nU+TfAgFIWmfqKKoQQ4nIWR5vvhIabeF8KBjdVkXh1uIEuTSX2B+g8j7FytEIr466aMH9wx7bTJctMeGWNLtjlQvWS6iW9wIiNB4jHvdUoOUy1YYB/WmnEUKpGDSiB5me0JnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ie/HIb27; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709544242; x=1741080242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dOIwlaZGZjfU0CqVNrkX4v+ksvq5qxQb8Hq031/xvLY=;
  b=ie/HIb273VWZL3+UY0T1Hwk1WkHUCLAQ4ULrUhpeT3ogVXfmw/b1fZzK
   zO1Qtd6cVzGZ6JCfWMV1G6dAkw/+ed8HQj8yvio5fyQy16VM7ksf6R4dk
   XKEHRNDP/8Q0y+troMguN1iDaGPOo+HtjUKokB0r0twpvdphB78qdl7AM
   ZU50zxq0UM/YvfK61BzAEzz8MBcnQfvgpH+h6XdLu7Dd/gHAMI6pfd7tf
   pzW8tIJ8uYUwFLGEHkugflDrSIcdqPIZpV5hcpaIdTDnUkN2GsWAUXI2u
   +Hyl5X94vCgBfJ1Q18cx1yQ+Y//dM5SPCvDvIM02aQmb9LTuLYGiGNVOE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="7834890"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="7834890"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 01:24:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="8839507"
Received: from smullaly-mobl1.amr.corp.intel.com (HELO desk) ([10.209.64.100])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 01:24:00 -0800
Date: Mon, 4 Mar 2024 01:23:59 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH 6.1.y v2 2/6] x86/entry_64: Add VERW just before userspace
 transition
Message-ID: <20240304-delay-verw-backport-6-1-y-v2-2-bf4bce517d60@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240304-delay-verw-backport-6-1-y-v2-0-bf4bce517d60@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-delay-verw-backport-6-1-y-v2-0-bf4bce517d60@linux.intel.com>

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

  [ pawan: resolved conflict for hunk swapgs_restore_regs_and_return_to_usermode in backport ]

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240213-delay-verw-v8-2-a6216d83edb7%40linux.intel.com
---
 arch/x86/entry/entry_64.S        | 11 +++++++++++
 arch/x86/entry/entry_64_compat.S |  1 +
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9953d966d124..c2383c2880ec 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -223,6 +223,7 @@ syscall_return_via_sysret:
 SYM_INNER_LABEL(entry_SYSRETQ_unsafe_stack, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 	swapgs
+	CLEAR_CPU_BUFFERS
 	sysretq
 SYM_INNER_LABEL(entry_SYSRETQ_end, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
@@ -656,6 +657,7 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 	/* Restore RDI. */
 	popq	%rdi
 	swapgs
+	CLEAR_CPU_BUFFERS
 	jmp	.Lnative_iret
 
 
@@ -767,6 +769,8 @@ native_irq_return_ldt:
 	 */
 	popq	%rax				/* Restore user RAX */
 
+	CLEAR_CPU_BUFFERS
+
 	/*
 	 * RSP now points to an ordinary IRET frame, except that the page
 	 * is read-only and RSP[31:16] are preloaded with the userspace
@@ -1493,6 +1497,12 @@ nmi_restore:
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
@@ -1511,6 +1521,7 @@ SYM_CODE_START(ignore_sysret)
 	UNWIND_HINT_EMPTY
 	ENDBR
 	mov	$-ENOSYS, %eax
+	CLEAR_CPU_BUFFERS
 	sysretl
 SYM_CODE_END(ignore_sysret)
 #endif
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index d6c08d8986b1..4bcd009a232b 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -272,6 +272,7 @@ SYM_INNER_LABEL(entry_SYSRETL_compat_unsafe_stack, SYM_L_GLOBAL)
 	xorl	%r9d, %r9d
 	xorl	%r10d, %r10d
 	swapgs
+	CLEAR_CPU_BUFFERS
 	sysretl
 SYM_INNER_LABEL(entry_SYSRETL_compat_end, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR

-- 
2.34.1



