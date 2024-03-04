Return-Path: <stable+bounces-25813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C77D86F963
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 06:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0774B21108
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 05:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14811566D;
	Mon,  4 Mar 2024 05:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D8C7SR6Q"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665A63C39
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 05:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709528937; cv=none; b=jyTyObdI7AtrLMbmV+POIoGkqsEM4/jRaWNTqte9VTLm/1EkrD+Moo0B8WkNaIYEMvzJLk/7FpHpS3Yy6V2sGPhkdceMasY+P3gFjJyOnGOe0T13xH9+bop2QJBnlsLMhYgSvp/qbX4r8cJF86hWxCQkD0pFgN1UkzLf06nAW6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709528937; c=relaxed/simple;
	bh=kCCthfaSL/JLvlGht5hToQwbB1Kw9dumPt68GlqBUw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTIE6grcLy0hO65ZxtFL4TZvM3KK474M9ki6g4/vTCBJQi2ALg+tYIUS9Vq/Auk0ls+RlFIfaG3tyxOAHN6UMB9rc/D6zAz4kqTkLQOSXR/nxtu+o8DSeYq8odqmG+tk13QXxvujeaLSrL/6BSkKvJLiCkfuiK5QTpYnJo8r+SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D8C7SR6Q; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709528936; x=1741064936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kCCthfaSL/JLvlGht5hToQwbB1Kw9dumPt68GlqBUw4=;
  b=D8C7SR6Q7RC6xH6qA3Y2b2Y2VDfWyMe9m6YtylsFTk2W5kPu9s+fa2Ho
   zH1l2WjKO3r4PUN6MqUDKUHPNH3xnMW+RuNVj1RwsPlD4zt2VMYWffrdq
   5mGnkUX7TVdh8FPq10XA3AxNr138x+UK8kTnCrCP3g7HDLSdHyh3HJzYe
   tatpujKqgiKTvhXjWx+jpJoTc/BnlZm1DsYaw71ZnrVPkgcnUTQwpwG9h
   0k6qoYSdQgm2Oq3roXrUGp+sGavZj74QOrQ+vptkuuZG1RsrORtUS0i7v
   h2jo+muZVAnk0rarh5qTLl0h1DXRpGzpiAWOj6ikZGm6zPsweD9tJVGrM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4127499"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4127499"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 21:08:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="9061378"
Received: from dhorstma-mobl.amr.corp.intel.com (HELO desk) ([10.209.64.132])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 21:08:55 -0800
Date: Sun, 3 Mar 2024 21:08:54 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.6.y v2 5/5] KVM/VMX: Move VERW closer to VMentry for MDS
 mitigation
Message-ID: <20240303-delay-verw-backport-6-6-y-v2-5-40ce56b521a5@linux.intel.com>
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

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/all/20240213-delay-verw-v8-6-a6216d83edb7%40linux.intel.com
---
 arch/x86/kvm/vmx/vmenter.S |  3 +++
 arch/x86/kvm/vmx/vmx.c     | 20 ++++++++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index b3b13ec04bac..139960deb736 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -161,6 +161,9 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	/* Load guest RAX.  This kills the @regs pointer! */
 	mov VCPU_RAX(%_ASM_AX), %_ASM_AX
 
+	/* Clobbers EFLAGS.ZF */
+	CLEAR_CPU_BUFFERS
+
 	/* Check EFLAGS.CF from the VMX_RUN_VMRESUME bit test above. */
 	jnc .Lvmlaunch
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 0775196ddea9..b2ed051611b0 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -387,7 +387,16 @@ static __always_inline void vmx_enable_fb_clear(struct vcpu_vmx *vmx)
 
 static void vmx_update_fb_clear_dis(struct kvm_vcpu *vcpu, struct vcpu_vmx *vmx)
 {
-	vmx->disable_fb_clear = (host_arch_capabilities & ARCH_CAP_FB_CLEAR_CTRL) &&
+	/*
+	 * Disable VERW's behavior of clearing CPU buffers for the guest if the
+	 * CPU isn't affected by MDS/TAA, and the host hasn't forcefully enabled
+	 * the mitigation. Disabling the clearing behavior provides a
+	 * performance boost for guests that aren't aware that manually clearing
+	 * CPU buffers is unnecessary, at the cost of MSR accesses on VM-Entry
+	 * and VM-Exit.
+	 */
+	vmx->disable_fb_clear = !cpu_feature_enabled(X86_FEATURE_CLEAR_CPU_BUF) &&
+				(host_arch_capabilities & ARCH_CAP_FB_CLEAR_CTRL) &&
 				!boot_cpu_has_bug(X86_BUG_MDS) &&
 				!boot_cpu_has_bug(X86_BUG_TAA);
 
@@ -7226,11 +7235,14 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 
 	guest_state_enter_irqoff();
 
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



