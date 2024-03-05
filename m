Return-Path: <stable+bounces-26869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAD08729D7
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 22:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA1C28D24E
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 21:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD5112D1FD;
	Tue,  5 Mar 2024 21:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dt5Vo9WJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8001E12D1E7
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 21:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709675723; cv=none; b=Pd8Y2BeRetVVcciMghZVa3SiW//SEeZQPksnh6RLrzvaCFbK4PKi0g6BwWsYE2RszNPYTQivRCiPIHAow5FNQxRpeJVYCx/IQHvvDFTr/7S5fkDmfdR2SS7yVrGcYl/5xqJfOY42NSBmAB+XJu2VMKXyKYO4P4E2B4juaDnUKVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709675723; c=relaxed/simple;
	bh=+jlgzoIWMR3VCkDqnMXcYtENbSuvoo2dpfLqnT1gmWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKY4JcMw0g1rpk55/++kUwTl1XVEhoh+FerHKHoKGPZGCzOKCbhS7EB4XhiKl8Ff9smI8xXG+y6BliwNsqljbXnr6AQKpBGguz0DMK/sabkMeDwRNE0NhXdPzDrjvpY0Sja/jN37yCcxQnjBHiO9iGSGzT7Gg4uhVS8vCx29ECg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dt5Vo9WJ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709675722; x=1741211722;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+jlgzoIWMR3VCkDqnMXcYtENbSuvoo2dpfLqnT1gmWY=;
  b=dt5Vo9WJ+jKPgO8g4skwsJFfImDwpRsVFXnnShP4sb850dgYypXR9tao
   e+t1Mko0e4aCLd+WfqHcekFbWiS9iiWh/BWCYxaX+1PZkt4f1YJvFzQ1Z
   wfiw3zfnm6hNh+hPtNUPzatAE9EE6qEAWkxmfU18pz1YmQoNaQJC0TQQq
   KTYProaOLzY0Usf5jd4QacQ1Y6/gNDDJoDRL0N70n3+ihQOa1Ppb4Az4/
   gRPc6Hn0Bklf0nRU8TcWl0RYEhJGh2SPAj+Kf/IO3PF1h38JoQlk5fhRV
   TmRR6rqQOdqoCWYD2tf1C/wgzEPsGZ43pQe1OL+8+xjehjhZVNDosWaP2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="15662659"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="15662659"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 13:55:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="9413671"
Received: from pbemalkh-mobl.amr.corp.intel.com (HELO desk) ([10.209.20.113])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 13:55:21 -0800
Date: Tue, 5 Mar 2024 13:55:20 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 5.10.y 6/7] KVM/VMX: Use BT+JNC, i.e. EFLAGS.CF to select
 VMRESUME vs. VMLAUNCH
Message-ID: <20240305-delay-verw-backport-5-10-y-v1-6-50bf452e96ba@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240305-delay-verw-backport-5-10-y-v1-0-50bf452e96ba@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-delay-verw-backport-5-10-y-v1-0-50bf452e96ba@linux.intel.com>

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



