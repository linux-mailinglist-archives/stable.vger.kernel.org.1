Return-Path: <stable+bounces-25868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2177586FD7A
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 10:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5963283160
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 09:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAE23A292;
	Mon,  4 Mar 2024 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k9QpUTcc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0922134F
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544261; cv=none; b=aK0RghU/ngCbSpTxiDEWpQxLpE5F6WG5B0kMijlYNTcPxlaUZ57vDW31sKRFHYYnTKoLYqdLl2saGuOsrxQnJpgqKEGYiotG2YRnL2Bn8P1/bYBGw4DInHI0DNgothmmRg8V0e1O6lHOM6bzhd6fa7Eqbv/BMK9tdL1K65PNcFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544261; c=relaxed/simple;
	bh=h/vpxiEPCdpsNkM7GuKZcEi9eea1Ls7bsbPzzIZ33Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qB/QMGDXdrhUINqYoNaCi0BJ+JrsAkfXzPMQ3gNgJBLAPfp/uZiPneq/uYHatrdQfUd6k5mqO/6CrUNW7uPVON8rLTF95rolQ8XlOASQSeECF6XTSnZY3bPc4BOUURMms6qnrm4ylYlZSkCjAPEu8PurRROcjSCHKUcSMFXANRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k9QpUTcc; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709544260; x=1741080260;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h/vpxiEPCdpsNkM7GuKZcEi9eea1Ls7bsbPzzIZ33Y8=;
  b=k9QpUTcc3zbf2DoSwVpALEHPXuIaXghJPyYzGkrJNvZbQbjXIOZho+bC
   TUzHqhggniM7yb62mwx2OFBXj9f4YfmwQ4uOMtXt7bCIKCMQyHckrJnJO
   3dJOcReN4aHcTZYIXkfW783uOZFfx7bobVz4vcJu3LeuadK1qVN8untWc
   k44PHs+sAtx2hfjBgqg3YSMCrSBXTfxtZMxuKacDD2owxEoJ0PScehreE
   +AWu+x0NX/NWwcSqEw43fk3fMm7cSCWxZgPZYMHA+JQn56FXyZiXxXBRJ
   b8wmDlMQI0b3eRi+v98+BajcLLuqS+s8+zSzD6Hg5XqwtXi/JAg+khzZN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="7834914"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="7834914"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 01:24:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="8839529"
Received: from smullaly-mobl1.amr.corp.intel.com (HELO desk) ([10.209.64.100])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 01:24:18 -0800
Date: Mon, 4 Mar 2024 01:24:18 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 6.1.y v2 5/6] KVM/VMX: Use BT+JNC, i.e. EFLAGS.CF to select
 VMRESUME vs. VMLAUNCH
Message-ID: <20240304-delay-verw-backport-6-1-y-v2-5-bf4bce517d60@linux.intel.com>
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
index 0b5db4de4d09..42c0b2c3aee1 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -106,7 +106,7 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	mov (%_ASM_SP), %_ASM_AX
 
 	/* Check if vmlaunch or vmresume is needed */
-	testb $VMX_RUN_VMRESUME, %bl
+	bt   $VMX_RUN_VMRESUME_SHIFT, %bx
 
 	/* Load guest registers.  Don't clobber flags. */
 	mov VCPU_RCX(%_ASM_AX), %_ASM_CX
@@ -128,8 +128,8 @@ SYM_FUNC_START(__vmx_vcpu_run)
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



