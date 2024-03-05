Return-Path: <stable+bounces-26711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1E1871512
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 06:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BFEF1C21179
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 05:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E100743ACF;
	Tue,  5 Mar 2024 05:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z6BsN+9n"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467861803A
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 05:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709614956; cv=none; b=dXBuOmxMYOAmCZ8Rqkt9DqetSlp/nB0qQ1pV2D1t4JCUR8iaFUKnTXWtwsn8gcR31kcGCP+f0FVhWpWhCJ8iLJG0iv88/+TomyWAZVKnwlKS6n54qzrEzyriqfbuPumRvE2JZ5MEWB7k3lPQFCc46vlqcJy7JF2XbRxPMZPSHb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709614956; c=relaxed/simple;
	bh=VkODjK6Xic2+Xa5zG9OS84/4AFeMvFq9BuACnV3YWrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfkDlOVpv/2744NOK+LsTQZW91eZyaXrWg0kXhIPvHOUAQ7Q/p6QkmYMFgpcO5KT2MEx0D/NyfWXBmXhdYb5DKm0wzvhiFKkMZQYECbbMFyoUKSA/9E8qr3Ja4DsGlUpdEiARE5FP88BhE/f4FtzjH5NvXCO6Us7B9mhmU61kTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z6BsN+9n; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709614955; x=1741150955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VkODjK6Xic2+Xa5zG9OS84/4AFeMvFq9BuACnV3YWrI=;
  b=Z6BsN+9nSJdqLlN6GrP61rE2fKUGOGMAYWH8Av0fsGlJ9P/8Y2NJHdWg
   uCyZWxppCFP+uMyaNztIaPtwrXnYuhYoNz9FJ+OCaOzbYpQVUYgvvjM8b
   /egmYLHJwRP/gxn3zNU8c0ujP0a7KRemfeodl9w81K+V/ydq5wjcwCOi6
   qiqhpGo/OCC93EDXGRUjWH31MTbUzMvNOWLxdJVuRArSyV557EFk+r8d4
   V32nSfdKM//hiBgR/HkP4NDePW2965hx7ElzbUMGdZlydsPmbuIZ1GPBF
   riwCAL0E4bA9tk9aZ+MwNe+6qu3cnVoFxoppIscc1quVQcMLPZU2bKTEd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4726940"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4726940"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 21:02:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9088210"
Received: from egolubev-mobl.amr.corp.intel.com (HELO desk) ([10.212.137.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 21:02:34 -0800
Date: Mon, 4 Mar 2024 21:02:33 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 5.15.y 7/7] KVM/VMX: Move VERW closer to VMentry for MDS
 mitigation
Message-ID: <20240304-delay-verw-backport-5-15-y-v1-7-fd02afc00fec@linux.intel.com>
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

commit 43fb862de8f628c5db5e96831c915b9aebf62d33 upstream.

During VMentry VERW is executed to mitigate MDS. After VERW, any memory
access like register push onto stack may put host data in MDS affected
CPU buffers. A guest can then use MDS to sample host data.

Although likelihood of secrets surviving in registers at current VERW
callsite is less, but it can't be ruled out. Harden the MDS mitigation
by moving the VERW mitigation late in VMentry path.

Note that VERW for MMIO Stale Data mitigation is unchanged because of
the complexity of per-guest conditional VERW which is not easy to handle
that late in asm with no GPRs available. If the CPU is also affected by
MDS, VERW is unconditionally executed late in asm regardless of guest
having MMIO access.

  [ pawan: conflict resolved in backport ]

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/all/20240213-delay-verw-v8-6-a6216d83edb7%40linux.intel.com
---
 arch/x86/kvm/vmx/vmenter.S |  3 +++
 arch/x86/kvm/vmx/vmx.c     | 12 ++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index e4a04ecbaec7..7a4b999d5701 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -99,6 +99,9 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	/* Load guest RAX.  This kills the @regs pointer! */
 	mov VCPU_RAX(%_ASM_AX), %_ASM_AX
 
+	/* Clobbers EFLAGS.ZF */
+	CLEAR_CPU_BUFFERS
+
 	/* Check EFLAGS.CF from the VMX_RUN_VMRESUME bit test above. */
 	jnc .Lvmlaunch
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2d6edf8cc59d..bedbd077e50e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -398,7 +398,8 @@ static __always_inline void vmx_enable_fb_clear(struct vcpu_vmx *vmx)
 
 static void vmx_update_fb_clear_dis(struct kvm_vcpu *vcpu, struct vcpu_vmx *vmx)
 {
-	vmx->disable_fb_clear = vmx_fb_clear_ctrl_available;
+	vmx->disable_fb_clear = !cpu_feature_enabled(X86_FEATURE_CLEAR_CPU_BUF) &&
+		vmx_fb_clear_ctrl_available;
 
 	/*
 	 * If guest will not execute VERW, there is no need to set FB_CLEAR_DIS
@@ -6747,11 +6748,14 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 {
 	kvm_guest_enter_irqoff();
 
-	/* L1D Flush includes CPU buffer clear to mitigate MDS */
+	/*
+	 * L1D Flush includes CPU buffer clear to mitigate MDS, but VERW
+	 * mitigation for MDS is done late in VMentry and is still
+	 * executed in spite of L1D Flush. This is because an extra VERW
+	 * should not matter much after the big hammer L1D Flush.
+	 */
 	if (static_branch_unlikely(&vmx_l1d_should_flush))
 		vmx_l1d_flush(vcpu);
-	else if (cpu_feature_enabled(X86_FEATURE_CLEAR_CPU_BUF))
-		mds_clear_cpu_buffers();
 	else if (static_branch_unlikely(&mmio_stale_data_clear) &&
 		 kvm_arch_has_assigned_device(vcpu->kvm))
 		mds_clear_cpu_buffers();

-- 
2.34.1



