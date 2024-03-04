Return-Path: <stable+bounces-25809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB96086F95F
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 06:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC68F1C20F2F
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 05:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D606546AD;
	Mon,  4 Mar 2024 05:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cP7TYvis"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F5F6138
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 05:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709528913; cv=none; b=DjKlL2yu0Ku+n6xKMP7ivioJxchKVaEsrY0G8D07fTldu2nppWRXpGKNcY3kUpCR5bRMWbiBItW6ENRJ67sNzokRNwxNRQh7iaf+gUORnFpP3WsFq15xoPSoSZOpDiF/kycCQ7UIlUXQdnDZTBgijx9lcgk2w4kcgel4G79XRJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709528913; c=relaxed/simple;
	bh=63Gfdali9nmeCvmUFVGp1w+z1LJGQ9EYl6BBaB2A6zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRRlJiauh/VfualkLfcwxv+eSaxhRksgzs3tLmyTSAzrjl0/CxOcc/JpnXh7EntPB1Psg/oCmKRcSaNP1yuK6ws/30R2KU+ypwPAjVfqRHBqa8X8y3lvtq5R/RSBp0xsTWoCYdeGzaizPBB2aVoIp1s2OdmhAPvME4qj0ZoTcAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cP7TYvis; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709528912; x=1741064912;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=63Gfdali9nmeCvmUFVGp1w+z1LJGQ9EYl6BBaB2A6zs=;
  b=cP7TYvisOwy8hZiSwoJBMmFgbO8eBvzUX1LbPsP2yz8mLsgFoHorNwPO
   1JqA/vIqzerfvpLc9ax4ZGwzvXBcIZofAelccpMaYgqcA3dW1Y3g8F1i0
   nMJxqPV8ovoKMTUKZr0inKztUENdd7hz8pW/Tlr4t/kQr8uC7feBofzGk
   QK11hYrWhDjOvTp3/CxiBJfhnXHP1Icnl4xgXTG9VDzuDASji/MvZBd1O
   YnJqa5F4OacW3Rdc0d1mWoT0UQAlPrnFXq711UfHmTZWXuw5J1sTlKEh2
   33iH9dcqcJoFYim0ycBYnXEJ2S2l998jDCzloSDTYQ33qZrLe+16fU14e
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4127472"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4127472"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 21:08:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="32030429"
Received: from dhorstma-mobl.amr.corp.intel.com (HELO desk) ([10.209.64.132])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 21:08:31 -0800
Date: Sun, 3 Mar 2024 21:08:31 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH 6.6.y v2 1/5] x86/entry_64: Add VERW just before userspace
 transition
Message-ID: <20240303-delay-verw-backport-6-6-y-v2-1-40ce56b521a5@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240303-delay-verw-backport-6-6-y-v2-0-40ce56b521a5@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240303-delay-verw-backport-6-6-y-v2-0-40ce56b521a5@linux.intel.com>

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

  1. It is rare to get an NMI after VERW, but before returning to userspace.
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
index 43606de22511..9f97a8bd11e8 100644
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
@@ -663,6 +664,7 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 	/* Restore RDI. */
 	popq	%rdi
 	swapgs
+	CLEAR_CPU_BUFFERS
 	jmp	.Lnative_iret
 
 
@@ -774,6 +776,8 @@ native_irq_return_ldt:
 	 */
 	popq	%rax				/* Restore user RAX */
 
+	CLEAR_CPU_BUFFERS
+
 	/*
 	 * RSP now points to an ordinary IRET frame, except that the page
 	 * is read-only and RSP[31:16] are preloaded with the userspace
@@ -1502,6 +1506,12 @@ nmi_restore:
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
@@ -1520,6 +1530,7 @@ SYM_CODE_START(ignore_sysret)
 	UNWIND_HINT_END_OF_STACK
 	ENDBR
 	mov	$-ENOSYS, %eax
+	CLEAR_CPU_BUFFERS
 	sysretl
 SYM_CODE_END(ignore_sysret)
 #endif
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 4e88f8438706..306181e4fcb9 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -271,6 +271,7 @@ SYM_INNER_LABEL(entry_SYSRETL_compat_unsafe_stack, SYM_L_GLOBAL)
 	xorl	%r9d, %r9d
 	xorl	%r10d, %r10d
 	swapgs
+	CLEAR_CPU_BUFFERS
 	sysretl
 SYM_INNER_LABEL(entry_SYSRETL_compat_end, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR

-- 
2.34.1



