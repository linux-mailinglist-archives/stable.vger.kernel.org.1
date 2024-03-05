Return-Path: <stable+bounces-26707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E702987150E
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 06:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B1C3281973
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 05:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7FF43ACF;
	Tue,  5 Mar 2024 05:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oqukl0NT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A7B1803A
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 05:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709614934; cv=none; b=TyPfy0tdmcxewCymad4ZLwSDtmowzPE/2GlKClEEz13ziMYA//qUmgfJl61w6BdkyvdcRtKioUaQOAv+ztIEidhketrPctUF/6JgRhxG4mV7w3lnSZdoOXs/iuyRZcnOkuEDzzR5dH8wWyl/S3OrAgNcudysf1RXFbB4IAL43y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709614934; c=relaxed/simple;
	bh=iULivcLdy/bfbLfSrPdJ9AALgxFR7cJ8APSbwNljDC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pf32wtnyM9mM3A0lteWDmIZxetX3owwaBQQBYCJFnX4rpmvT89swXycrs5WntkVb7It6bhMFKZu7IxWLJOhLkcq2W0RJJX7AkPOjC1MwzveScMVOWiteskDLK+Cd1Xq7ANXnz6sKxp5c74HKtzZ1DNMXAAsiWMI6vdB8kjeH7As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oqukl0NT; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709614933; x=1741150933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iULivcLdy/bfbLfSrPdJ9AALgxFR7cJ8APSbwNljDC4=;
  b=Oqukl0NTP3aGCXJx2S7Q0Z2ITTwqjvgRZvrtUjKzl0/mYVKDNCojsDRd
   JB9VBTpMQKAOANwulJi75Pux42XrSXVJDZeZmh868036OdUC58DdQiDK/
   vxABZrXTO6/ysNySCDtYJhSuKWjfT1ybj55VRmqie3KUWiX0/Yufd+ZgM
   DwDZTHX3DG0GjrcTu8z6nFTxPIN+SrUk8MOL9CXBkTv4dy4foiMSs6LWD
   UOVcWt0BvHb4v3S/UZEHJWOe+MSqulFofA971bh9LKmouvnY1ssM5DfVL
   glrM84TK/Ymi+EdExjO548Ff20RgR8t3FbZzTtvoQmzENWy8+qUMYJ3YM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="15285267"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="15285267"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 21:02:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9822698"
Received: from egolubev-mobl.amr.corp.intel.com (HELO desk) ([10.212.137.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 21:02:11 -0800
Date: Mon, 4 Mar 2024 21:02:09 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 5.15.y 3/7] x86/entry_64: Add VERW just before userspace
 transition
Message-ID: <20240304-delay-verw-backport-5-15-y-v1-3-fd02afc00fec@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240304-delay-verw-backport-5-15-y-v1-0-fd02afc00fec@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-delay-verw-backport-5-15-y-v1-0-fd02afc00fec@linux.intel.com>

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



