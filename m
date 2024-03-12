Return-Path: <stable+bounces-27528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2743A879D4B
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 22:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5231F22B08
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 21:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F276142916;
	Tue, 12 Mar 2024 21:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJtwzaft"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB0513B2BF
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 21:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710277871; cv=none; b=Cpb9LwFOQbwJxWVDcWcqJlrar6Cc2lgGfKrQ07nsP/bZSuHgdWvgwdVcI1H10Z93pqG8Jgg2XCNmeaRUDDeJM530VLPA3n+JJrOaNAQR6KRoDQfW+4bEdTbBeDzqZDJLuQDpy06QW00UGqEhomdMXTIQMrXe4az14W73w+24o6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710277871; c=relaxed/simple;
	bh=+jlgzoIWMR3VCkDqnMXcYtENbSuvoo2dpfLqnT1gmWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwVc6NJUujaxHipgxgiN5ReaT1a9VD94vVdEo1oRJleX1eZ5p3ijsakJqI9TZxGp0zhqUBGWOVkbA9gpBbGheobuzgUZoK/sUtIgIp8NgE9DK+I1wopVynPaOjOqRTPBqLmhA2T/UeNsIN+I+0TDkdgtPNYJ7vN3rS+9Tmjhw98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GJtwzaft; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710277870; x=1741813870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+jlgzoIWMR3VCkDqnMXcYtENbSuvoo2dpfLqnT1gmWY=;
  b=GJtwzaftWLAtj3FZCUdRWm47ZYZyKA3DuTLB4yFPgqGyA9bS5KHIhQE3
   RJd39xFgoOv8ZmGW8ADE8V4CF2orDj05EcyDKIC+iSuihYiJqaY381v1a
   G2PiviGkCXeAN6UWCfy611/6wb9R/M6VZ/g+nlyHq0W+rR/O2scj71qqa
   cM4v7n3RTjDczDRYDCmTsJXz7vUbXMzOEMZCx/6w5lIb+Xj3gIJbcf/un
   dYXg0Ga9n9+Dj1J+8Fe8xEXf+iPDGDlnH/+p71UFN7ldcUopRQ19JzuPS
   lHBmk8eDq7DKNqnUPuzLRpQxNedebr1lggnF1LUrrvt6YZ9ZBV3Vt2Gwg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="8836295"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="8836295"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 14:11:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16336223"
Received: from arnabkar-mobl1.amr.corp.intel.com (HELO desk) ([10.209.69.57])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 14:11:09 -0700
Date: Tue, 12 Mar 2024 14:11:08 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 5.15.y v2 06/11] KVM/VMX: Use BT+JNC, i.e. EFLAGS.CF to
 select VMRESUME vs. VMLAUNCH
Message-ID: <20240312-delay-verw-backport-5-15-y-v2-6-e0f71d17ed1b@linux.intel.com>
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

From: Sean Christopherson <seanjc@google.com>

commit 706a189dcf74d3b3f955e9384785e726ed6c7c80 upstream.

Use EFLAGS.CF instead of EFLAGS.ZF to track whether to use VMRESUME versus
VMLAUNCH.  Freeing up EFLAGS.ZF will allow doing VERW, which clobbers ZF,
for MDS mitigations as late as possible without needing to duplicate VERW
for both paths.

  [ pawan: resolved merge conflict in __vmx_vcpu_run in backport. ]

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/all/20240213-delay-verw-v8-5-a6216d83edb7%40linux.intel.com
---
 arch/x86/kvm/vmx/run_flags.h | 7 +++++--
 arch/x86/kvm/vmx/vmenter.S   | 6 +++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/run_flags.h b/arch/x86/kvm/vmx/run_flags.h
index edc3f16cc189..6a9bfdfbb6e5 100644
--- a/arch/x86/kvm/vmx/run_flags.h
+++ b/arch/x86/kvm/vmx/run_flags.h
@@ -2,7 +2,10 @@
 #ifndef __KVM_X86_VMX_RUN_FLAGS_H
 #define __KVM_X86_VMX_RUN_FLAGS_H
 
-#define VMX_RUN_VMRESUME	(1 << 0)
-#define VMX_RUN_SAVE_SPEC_CTRL	(1 << 1)
+#define VMX_RUN_VMRESUME_SHIFT		0
+#define VMX_RUN_SAVE_SPEC_CTRL_SHIFT	1
+
+#define VMX_RUN_VMRESUME		BIT(VMX_RUN_VMRESUME_SHIFT)
+#define VMX_RUN_SAVE_SPEC_CTRL		BIT(VMX_RUN_SAVE_SPEC_CTRL_SHIFT)
 
 #endif /* __KVM_X86_VMX_RUN_FLAGS_H */
diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index 982138bebb70..e4a04ecbaec7 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -77,7 +77,7 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	mov (%_ASM_SP), %_ASM_AX
 
 	/* Check if vmlaunch or vmresume is needed */
-	testb $VMX_RUN_VMRESUME, %bl
+	bt   $VMX_RUN_VMRESUME_SHIFT, %bx
 
 	/* Load guest registers.  Don't clobber flags. */
 	mov VCPU_RCX(%_ASM_AX), %_ASM_CX
@@ -99,8 +99,8 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	/* Load guest RAX.  This kills the @regs pointer! */
 	mov VCPU_RAX(%_ASM_AX), %_ASM_AX
 
-	/* Check EFLAGS.ZF from 'testb' above */
-	jz .Lvmlaunch
+	/* Check EFLAGS.CF from the VMX_RUN_VMRESUME bit test above. */
+	jnc .Lvmlaunch
 
 	/*
 	 * After a successful VMRESUME/VMLAUNCH, control flow "magically"

-- 
2.34.1



