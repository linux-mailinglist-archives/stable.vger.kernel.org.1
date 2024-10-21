Return-Path: <stable+bounces-87623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 464E79A72A4
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 20:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B09D4280E2F
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 18:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAC81F9420;
	Mon, 21 Oct 2024 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QznVDLPc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDE51F707E
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 18:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729536822; cv=none; b=IKJ3/1uDo1X11Y/BSTU4duUtcopYrio4E3sAFMwzl0VxYhphg5a8u9et1Fkr/ok6xndUMoli+kkaKcx+g/yYDhu4Yq2m3LKwR3FNwFERLMmA/eDgtjg9ASw3CfuWGqa82h40HEyu9wFY0aBpxacheCb2dcOTuyiRIgj7vTOds04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729536822; c=relaxed/simple;
	bh=YPPDaus60LpWHSl+YJdwD/33FVdS+zdf+RyEWiIG4ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtuZau1EIknuXp218GWFzFjQOGVmlW8NQoVbsUnb0JMTF5Yn0RUKabykKWKqlIY0pYSZ0kw/A3VeLQKDW+jygXBdO2tmzEokjNf5QFtood/XAAiTqve4z/d+14PE/BH3N7uL4l33jFtgECokIfHfIyRLlpcU1gKAGvQOlWZ7bik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QznVDLPc; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729536819; x=1761072819;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YPPDaus60LpWHSl+YJdwD/33FVdS+zdf+RyEWiIG4ik=;
  b=QznVDLPcqk1jET8hN34i55rXMxBKXZUaxNHo5hPbSslXc2/XnVvo9vtG
   NU3aiJbafedttU3uHmWfKMUs+5DSzBFxVtQgxy2YFoAGw7lU4btD+xHZ+
   JUjHs2wHPeuHJ2GOGlGECb2rhZjJ7ZNwm929RquRN4mJl0WjpvujuDnqz
   GD6SZljMk4iFV6dvSClLWxg3gqM0YLTV+w2jEPpAOuE2Cr47Jm1WhR33H
   I5YXcSNbfBDRzG9GbhYeNU/3bh48OUfxiRq/NnHrwyP/A7Oj6Xel6Qtv0
   Nb9r+MMt0gaccyPiHXKI9y+D6XWjd7pF/YY7MbFYqqyADhli/sx7Wi4so
   g==;
X-CSE-ConnectionGUID: 15ulSZ8aQouHxWj/HIuYWQ==
X-CSE-MsgGUID: czWhLStDQG6pvEKV76IlYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28810486"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28810486"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 11:53:38 -0700
X-CSE-ConnectionGUID: 1gle7xlJQamsadT4YE+NtA==
X-CSE-MsgGUID: a98yWKabRNeIyf+T84HBKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="84216648"
Received: from cphoward-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.124])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 11:53:37 -0700
Date: Mon, 21 Oct 2024 11:53:27 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: andrew.cooper3@citrix.com, brgerst@gmail.com,
	dave.hansen@linux.intel.com, mingo@kernel.org, rtgill82@gmail.com
Subject: [PATCH 6.1.y] x86/bugs: Use code segment selector for VERW operand
Message-ID: <7aad4bddc4cf131ee88657da20960c4a714aa756.1729536596.git.pawan.kumar.gupta@linux.intel.com>
References: <2024102128-omega-phosphate-db6c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024102128-omega-phosphate-db6c@gregkh>

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
[ pawan: Backported to 6.1 ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Backport is boot tested on x86 64 and 32 bit mode.

 arch/x86/include/asm/nospec-branch.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 1e481d308e18..daf58a96e0a7 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -211,7 +211,16 @@
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
 

base-commit: 54d90d17e8cee20b163d395829162cec92b583f4
-- 
2.34.1


