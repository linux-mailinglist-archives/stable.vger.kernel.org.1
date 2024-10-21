Return-Path: <stable+bounces-87629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8E49A900C
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 21:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 508531C2223A
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 19:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D751FCC52;
	Mon, 21 Oct 2024 19:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UHi8S4C9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D78C1FCC58
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 19:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729539693; cv=none; b=J+vyUfHqXncDkP32h4iDZMCwxadb52rS1j2lTny0+Y22yOILaxZrAE3GAlSJhU2KWAtx4YpRQbYOXUXBa3oue4bz+dj/CaqUTRcLS82teTv0zmRFEQ4wuPbXbfCgqAZtRL0d2N52h0U+Q/e6WB+Dr+oDleGLmyPzNtJ0WYOGuE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729539693; c=relaxed/simple;
	bh=4nnZKHZ4VeZEpEUFCpXG/mrHTSwFduNl18fwqhzYuOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3WJIBrikCkX81Em9oZxdTU6cbJqoy3+NiXiSTB00gtDVo2OgGiis5eU1DO00TLyWrh8IMBd8HWByde7ReCpXc9YCCIWXhdAEtyaZVevp5I4kaje61OrDWq60UhNly8HAEohs5+byDlOoHi9tpNycXRQi/ONnUwjLtW10Cf17TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UHi8S4C9; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729539691; x=1761075691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4nnZKHZ4VeZEpEUFCpXG/mrHTSwFduNl18fwqhzYuOo=;
  b=UHi8S4C99JqL6c3YME3g6XM22eyNPYTXGFsiRcH5PrbrOQHxwrKGQNj/
   2Jr5fwHL12CCXG6a01NB3K4N+uUczrxTvvSlw+LGF74AlJqWBe2t0PAHG
   4jEP/0cbRAIXNct2euNfaSaeVuaz2l9BdLguWB5yfF7bkNiY8G/etB7Zt
   VCGo95lFdsv9G/H93IZvWZg0cpd3Dg41jJOOdbOP6b2ShO+cZMvK0Efzw
   VrK33KVt2yKmUn+gzvq6hb3dTqniilmlQX72TC0hklJMpVNb+fIP4SJ1L
   ggBP4Eo3sXWK2tJ95qnyqvP7jwtgtjebMjVOD9EFaL8cQi3B0N2x8+JTa
   w==;
X-CSE-ConnectionGUID: rEbV8oFYSWCvluEhx9EChw==
X-CSE-MsgGUID: dPbUbjcaQ0y2lnUSnNeieg==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="28921065"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="28921065"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 12:41:30 -0700
X-CSE-ConnectionGUID: YfV/ggW9R4qwsivbFHIrzQ==
X-CSE-MsgGUID: OdKtzdKoRb6Rx5aRa4+5dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79708178"
Received: from cphoward-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.124])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 12:41:30 -0700
Date: Mon, 21 Oct 2024 12:41:19 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: andrew.cooper3@citrix.com, brgerst@gmail.com,
	dave.hansen@linux.intel.com, mingo@kernel.org, rtgill82@gmail.com
Subject: [PATCH 5.10.y] x86/bugs: Use code segment selector for VERW operand
Message-ID: <f9c84ff992511890556cd52c19c2875b440b98c6.1729538774.git.pawan.kumar.gupta@linux.intel.com>
References: <2024102131-blissful-iodize-4056@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024102131-blissful-iodize-4056@gregkh>

commit e4d2102018542e3ae5e297bc6e229303abff8a0f upstream.

Robert Gill reported below #GP in 32-bit mode when dosemu software was
executing vm86() system call:

  general protection fault: 0000 [#1] PREEMPT SMP
  CPU: 4 PID: 4610 Comm: dosemu.bin Not tainted 6.6.21-gentoo-x86 #1
  Hardware name: Dell Inc. PowerEdge 1950/0H723K, BIOS 2.7.0 10/30/2010
  EIP: restore_all_switch_stack+0xbe/0xcf
  EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
  ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: ff8affdc
  DS: 0000 ES: 0000 FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010046
  CR0: 80050033 CR2: 00c2101c CR3: 04b6d000 CR4: 000406d0
  Call Trace:
   show_regs+0x70/0x78
   die_addr+0x29/0x70
   exc_general_protection+0x13c/0x348
   exc_bounds+0x98/0x98
   handle_exception+0x14d/0x14d
   exc_bounds+0x98/0x98
   restore_all_switch_stack+0xbe/0xcf
   exc_bounds+0x98/0x98
   restore_all_switch_stack+0xbe/0xcf

This only happens in 32-bit mode when VERW based mitigations like MDS/RFDS
are enabled. This is because segment registers with an arbitrary user value
can result in #GP when executing VERW. Intel SDM vol. 2C documents the
following behavior for VERW instruction:

  #GP(0) - If a memory operand effective address is outside the CS, DS, ES,
	   FS, or GS segment limit.

CLEAR_CPU_BUFFERS macro executes VERW instruction before returning to user
space. Use %cs selector to reference VERW operand. This ensures VERW will
not #GP for an arbitrary user %ds.

[ mingo: Fixed the SOB chain. ]
[ pawan: Backported to 5.10 ]

Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace transition")
Reported-by: Robert Gill <rtgill82@gmail.com>
Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: stable@vger.kernel.org # 5.10+
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218707
Closes: https://lore.kernel.org/all/8c77ccfd-d561-45a1-8ed5-6b75212c7a58@leemhuis.info/
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Suggested-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
Backport is boot tested on x86 64 and 32 bit mode.

 arch/x86/include/asm/nospec-branch.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 87e1ff064025..7978d5fe1ce6 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -199,7 +199,16 @@
  */
 .macro CLEAR_CPU_BUFFERS
 	ALTERNATIVE "jmp .Lskip_verw_\@", "", X86_FEATURE_CLEAR_CPU_BUF
-	verw _ASM_RIP(mds_verw_sel)
+#ifdef CONFIG_X86_64
+	verw mds_verw_sel(%rip)
+#else
+	/*
+	 * In 32bit mode, the memory operand must be a %cs reference. The data
+	 * segments may not be usable (vm86 mode), and the stack segment may not
+	 * be flat (ESPFIX32).
+	 */
+	verw %cs:mds_verw_sel
+#endif
 .Lskip_verw_\@:
 .endm
 

base-commit: eac1c5bfc13c2b84ddb038dc54c90829e0066e60
-- 
2.34.1


