Return-Path: <stable+bounces-27548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A237879EFF
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 23:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50D31F228D4
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 22:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00E31CA8F;
	Tue, 12 Mar 2024 22:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hgYPt8Rt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193CBBE7D
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 22:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710283265; cv=none; b=FHZECjGbpu/ghhVs7JYXLQ2VMEslFlHWZ3CuYox+GrN9tWd//IrxjpQNEKBUq9sr37qyW6ENXSfFvh39WgkP4ZcPpUv7qaazaJMAlwFFkzn9t4jtcodbrNCLGfh+E4FfJgp0etDZRK+3WiqhDFefEWttMrI0yRzTB3gYmIvUC1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710283265; c=relaxed/simple;
	bh=BJIajhAshHR5HYNzf6fynRtbz9Hwu8ZKjsuFClWaptM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKj5KlX13rchWw+9JqkSDQnx4kI50Qy25zIcXDTql+ZZWNdaOWvuJJQjiGa7pYAwhItvyqHtFNsFQYcqiRc8BnbeW8qzWw5n3EpJHzHAweSKbIcaGRQUE4asEephf8JSVU6YoG9iuwfCQajfHDovKBcYGJXerV8Nf7v6zjbt1Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hgYPt8Rt; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710283264; x=1741819264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BJIajhAshHR5HYNzf6fynRtbz9Hwu8ZKjsuFClWaptM=;
  b=hgYPt8Rt1QLjaetGHcdNm8UcvqWMuAYOht8ZLRxnCY+iUp3aKNDX264E
   7VrSsbxaIw5dTkJRt4ZV97c/qvNrpaKgWHRNRQSbweM6BaCJQEQ7NBGRG
   PBNVQ9QIuZ8Vl+vtxzofF5Z4Ml8bef732y9Eau6QBJ14W/tRmTLbQlRCN
   3sMqx/3Rq/BLOmaPxNkuuPvu5ghj1efulVASky5c8abOr8J842PAdGrFr
   F7K3K2xqEB1u4HxVfKJsWcmNWQC7ulU3kwnxIW6vLZfWaP952DIK/DiGH
   1WciyNAaULVtyQViy57lbCZ9dV4fWnPfSf6IR7uo0b2yMy+88Owk83t+G
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5632216"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5632216"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:41:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16423275"
Received: from arnabkar-mobl1.amr.corp.intel.com (HELO desk) ([10.209.69.57])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:41:03 -0700
Date: Tue, 12 Mar 2024 15:41:02 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 5.10.y v2 07/11] KVM/VMX: Move VERW closer to VMentry for MDS
 mitigation
Message-ID: <20240312-delay-verw-backport-5-10-y-v2-7-ad081ccd89ca@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240312-delay-verw-backport-5-10-y-v2-0-ad081ccd89ca@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312-delay-verw-backport-5-10-y-v2-0-ad081ccd89ca@linux.intel.com>

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
index 1030c5904122..3e9bb9ae836d 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -397,7 +397,8 @@ static __always_inline void vmx_enable_fb_clear(struct vcpu_vmx *vmx)
 
 static void vmx_update_fb_clear_dis(struct kvm_vcpu *vcpu, struct vcpu_vmx *vmx)
 {
-	vmx->disable_fb_clear = vmx_fb_clear_ctrl_available;
+	vmx->disable_fb_clear = !cpu_feature_enabled(X86_FEATURE_CLEAR_CPU_BUF) &&
+		vmx_fb_clear_ctrl_available;
 
 	/*
 	 * If guest will not execute VERW, there is no need to set FB_CLEAR_DIS
@@ -6792,11 +6793,14 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	guest_enter_irqoff();
 	lockdep_hardirqs_on(CALLER_ADDR0);
 
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



