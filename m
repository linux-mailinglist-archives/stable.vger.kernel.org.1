Return-Path: <stable+bounces-77737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 346AB986928
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 00:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4C9AB256BD
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 22:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DF815B14B;
	Wed, 25 Sep 2024 22:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PLQRk09P"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84892148838;
	Wed, 25 Sep 2024 22:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727303154; cv=none; b=ft3VLCrNRdzoPpHIkTwfin3WeRGLWlViN8fuG3++mJwoPG2pwPgQ+MuxgEVBpPGyXBZe0SAcnHeriQ/vK2cxX9+b26w03VW2OnJUDY9RRaldFl2+gxyXN43BGXtet/FID765adnj8zqGhTinPj3o0r4P5XsuNfGsqFYNx4AsZuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727303154; c=relaxed/simple;
	bh=5sBmeZb7zgbq4jsPslNM38CJ8kyfg1bQz+tU7ToEsR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9BmcBhGAWSURGLY/9Y4PiCDir6n31F9D1C7YPngvUDevds4muQqC9LlSNqqZnoe12nWssxRYF9nSI+P8haQEyaMqX6tOZ9MBfc6kkfR5OXi35C+365Vf36zJhtj0QEP3Jfehm2biQCvk2RL77/G2N1WCpvU9Et8Id5TZwk2DCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PLQRk09P; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727303153; x=1758839153;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5sBmeZb7zgbq4jsPslNM38CJ8kyfg1bQz+tU7ToEsR8=;
  b=PLQRk09PtpIj/k/VWYQ1RcLTvAKH+nofI2ixnU5fyujMwT41iiBwinxB
   eCdKqaPc+v39Yc2S1qNh53nZwTli4LsVAQcm4ITfPF4dXBj84etDkUy1G
   gQ5hRihflTz5yo0eUuULakQApVm1aZxaXQes6B5mIo+d4R0uF+houigaj
   gsd6uFLSq+LKHbRBAHp2HkCqycIU7R9hkZ+K9IGfPdxsJ+sFx/E4my+07
   u4Sz+KLZcG6GpnM7GgUHYMhGuaLbrc+dJb+4tLRYK2X5R1uGmxQP1bQ1z
   lr4f3KR94vDZu6agFfAWKMmU9KG9mGxwA3HOoAMDaOY8Q99ouF2Ra/J4f
   Q==;
X-CSE-ConnectionGUID: hOTThXShTuqgDD866Cqi7w==
X-CSE-MsgGUID: jnWPZkJpQ3GBs23kkb1KTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="43895205"
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="43895205"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 15:25:52 -0700
X-CSE-ConnectionGUID: HdLibePzRd2ER7RdHGcJ/A==
X-CSE-MsgGUID: F/Hub8YTRSiD927TWLe9cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="71929308"
Received: from fecarpio-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.229])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 15:25:51 -0700
Date: Wed, 25 Sep 2024 15:25:50 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Robert Gill <rtgill82@gmail.com>,
	Jari Ruusu <jariruusu@protonmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	antonio.gomez.iglesias@linux.intel.com,
	daniel.sneddon@linux.intel.com, stable@vger.kernel.org
Subject: [PATCH v7 3/3] x86/bugs: Use code segment selector for VERW operand
Message-ID: <20240925-fix-dosemu-vm86-v7-3-1de0daca2d42@linux.intel.com>
X-Mailer: b4 0.14.1
References: <20240925-fix-dosemu-vm86-v7-0-1de0daca2d42@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925-fix-dosemu-vm86-v7-0-1de0daca2d42@linux.intel.com>

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

Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace transition")
Cc: stable@vger.kernel.org # 5.10+
Reported-by: Robert Gill <rtgill82@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218707
Closes: https://lore.kernel.org/all/8c77ccfd-d561-45a1-8ed5-6b75212c7a58@leemhuis.info/
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Suggested-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/nospec-branch.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index ff5f1ecc7d1e..e18a6aaf414c 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -318,12 +318,14 @@
 /*
  * Macro to execute VERW instruction that mitigate transient data sampling
  * attacks such as MDS. On affected systems a microcode update overloaded VERW
- * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF.
+ * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF. Using %cs
+ * to reference VERW operand avoids a #GP fault for an arbitrary user %ds in
+ * 32-bit mode.
  *
  * Note: Only the memory operand variant of VERW clears the CPU buffers.
  */
 .macro CLEAR_CPU_BUFFERS
-	ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
+	ALTERNATIVE "", __stringify(verw %cs:_ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
 .endm
 
 #ifdef CONFIG_X86_64

-- 
2.34.1



