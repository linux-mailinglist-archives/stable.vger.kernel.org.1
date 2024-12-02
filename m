Return-Path: <stable+bounces-96075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E589E080B
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 17:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7405B35320
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB5D204093;
	Mon,  2 Dec 2024 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SaheF2H0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFCA481C4
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151947; cv=none; b=FbjjD+m2Rshc901dUrFxJ4MrvzxA4z0SXf8MSNk0DcQE4absn06tfW7aVh9YT8yeADqfdRvGTCrTb3LWYPO/jGrx0/GOrjgsqQSNTEoiGnXVKOz7Hc2iCVEAGxFXIAo6Y43FFpzGzEMsDh09r657SpbUyxH7nxPyz5QKbuWugHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151947; c=relaxed/simple;
	bh=VOIo13mfe30w3sFhPMjV9nmebYw0Yr6JfpLyWnLc9B4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S9KJMlre3/Qa0hxcvbnAEYYuRYqaSZi9OrjZz1pXZPdtoGSjVFtC+X2dxnpMKfvk/Mi5UEbk5qL2wfa58fmLY8wp1aDgHNos5Hboep1tlS9AAviIVoovAdMaXra8LzJZwXW+3y9zuVTY29kwtvo6mWIgio4lm+uHtsXoYhl9Ano=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SaheF2H0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78495C4CED1;
	Mon,  2 Dec 2024 15:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733151947;
	bh=VOIo13mfe30w3sFhPMjV9nmebYw0Yr6JfpLyWnLc9B4=;
	h=Subject:To:Cc:From:Date:From;
	b=SaheF2H0a16eD4oLIwlDAMZldODGKfyJaAYmlAa31DwabZRznCL4DBuQJ1K+EM4fQ
	 LAC8zzVzlrGpH+82bB/Ln1np4iQNXR4Ot258vMszNUsxETN2iqtwX/RGTkhIrvPsIN
	 S+u5KI8l+rQxvMTQw3SKapJng9rRW9NRpn0EaBGI=
Subject: FAILED: patch "[PATCH] Revert "KVM: VMX: Move LOAD_IA32_PERF_GLOBAL_CTRL errata" failed to apply to 6.11-stable tree
To: seanjc@google.com,mlevitsk@redhat.com,pbonzini@redhat.com,vkuznets@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Dec 2024 16:05:43 +0100
Message-ID: <2024120243-chimp-penknife-28f5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.11-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.11.y
git checkout FETCH_HEAD
git cherry-pick -x 85434c3c73fcad58870016ddfe5eaa5036672675
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120243-chimp-penknife-28f5@gregkh' --subject-prefix 'PATCH 6.11.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 85434c3c73fcad58870016ddfe5eaa5036672675 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Mon, 18 Nov 2024 17:14:33 -0800
Subject: [PATCH] Revert "KVM: VMX: Move LOAD_IA32_PERF_GLOBAL_CTRL errata
 handling out of setup_vmcs_config()"

Revert back to clearing VM_{ENTRY,EXIT}_LOAD_IA32_PERF_GLOBAL_CTRL in KVM's
golden VMCS config, as applying the workaround during vCPU creation is
pointless and broken.  KVM *unconditionally* clears the controls in the
values returned by vmx_vmentry_ctrl() and vmx_vmexit_ctrl(), as KVM loads
PERF_GLOBAL_CTRL if and only if its necessary to do so.  E.g. if KVM wants
to run the guest with the same PERF_GLOBAL_CTRL as the host, then there's
no need to re-load the MSR on entry and exit.

Even worse, the buggy commit failed to apply the erratum where it's
actually needed, add_atomic_switch_msr().  As a result, KVM completely
ignores the erratum for all intents and purposes, i.e. uses the flawed
VMCS controls to load PERF_GLOBAL_CTRL.

To top things off, the patch was intended to be dropped, as the premise
of an L1 VMM being able to pivot on FMS is flawed, and KVM can (and now
does) fully emulate the controls in software.  Simply revert the commit,
as all upstream supported kernels that have the buggy commit should also
have commit f4c93d1a0e71 ("KVM: nVMX: Always emulate PERF_GLOBAL_CTRL
VM-Entry/VM-Exit controls"), i.e. the (likely theoretical) live migration
concern is a complete non-issue.

Opportunistically drop the manual "kvm: " scope from the warning about
the erratum, as KVM now uses pr_fmt() to provide the correct scope (v6.1
kernels and earlier don't, but the erratum only applies to CPUs that are
15+ years old; it's not worth a separate patch).

This reverts commit 9d78d6fb186bc4aff41b5d6c4726b76649d3cb53.

Link: https://lore.kernel.org/all/YtnZmCutdd5tpUmz@google.com
Fixes: 9d78d6fb186b ("KVM: VMX: Move LOAD_IA32_PERF_GLOBAL_CTRL errata handling out of setup_vmcs_config()")
Cc: stable@vger.kernel.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Message-ID: <20241119011433.1797921-1-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 0f008f5ef6f0..893366e53732 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2548,28 +2548,6 @@ static bool cpu_has_sgx(void)
 	return cpuid_eax(0) >= 0x12 && (cpuid_eax(0x12) & BIT(0));
 }
 
-/*
- * Some cpus support VM_{ENTRY,EXIT}_IA32_PERF_GLOBAL_CTRL but they
- * can't be used due to errata where VM Exit may incorrectly clear
- * IA32_PERF_GLOBAL_CTRL[34:32]. Work around the errata by using the
- * MSR load mechanism to switch IA32_PERF_GLOBAL_CTRL.
- */
-static bool cpu_has_perf_global_ctrl_bug(void)
-{
-	switch (boot_cpu_data.x86_vfm) {
-	case INTEL_NEHALEM_EP:	/* AAK155 */
-	case INTEL_NEHALEM:	/* AAP115 */
-	case INTEL_WESTMERE:	/* AAT100 */
-	case INTEL_WESTMERE_EP:	/* BC86,AAY89,BD102 */
-	case INTEL_NEHALEM_EX:	/* BA97 */
-		return true;
-	default:
-		break;
-	}
-
-	return false;
-}
-
 static int adjust_vmx_controls(u32 ctl_min, u32 ctl_opt, u32 msr, u32 *result)
 {
 	u32 vmx_msr_low, vmx_msr_high;
@@ -2729,6 +2707,27 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 		_vmexit_control &= ~x_ctrl;
 	}
 
+	/*
+	 * Some cpus support VM_{ENTRY,EXIT}_IA32_PERF_GLOBAL_CTRL but they
+	 * can't be used due to an errata where VM Exit may incorrectly clear
+	 * IA32_PERF_GLOBAL_CTRL[34:32].  Workaround the errata by using the
+	 * MSR load mechanism to switch IA32_PERF_GLOBAL_CTRL.
+	 */
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_NEHALEM_EP:	/* AAK155 */
+	case INTEL_NEHALEM:	/* AAP115 */
+	case INTEL_WESTMERE:	/* AAT100 */
+	case INTEL_WESTMERE_EP:	/* BC86,AAY89,BD102 */
+	case INTEL_NEHALEM_EX:	/* BA97 */
+		_vmentry_control &= ~VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
+		_vmexit_control &= ~VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
+		pr_warn_once("VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL "
+			     "does not work properly. Using workaround\n");
+		break;
+	default:
+		break;
+	}
+
 	rdmsrl(MSR_IA32_VMX_BASIC, basic_msr);
 
 	/* IA-32 SDM Vol 3B: VMCS size is never greater than 4kB. */
@@ -4432,9 +4431,6 @@ static u32 vmx_vmentry_ctrl(void)
 			  VM_ENTRY_LOAD_IA32_EFER |
 			  VM_ENTRY_IA32E_MODE);
 
-	if (cpu_has_perf_global_ctrl_bug())
-		vmentry_ctrl &= ~VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
-
 	return vmentry_ctrl;
 }
 
@@ -4452,10 +4448,6 @@ static u32 vmx_vmexit_ctrl(void)
 	if (vmx_pt_mode_is_system())
 		vmexit_ctrl &= ~(VM_EXIT_PT_CONCEAL_PIP |
 				 VM_EXIT_CLEAR_IA32_RTIT_CTL);
-
-	if (cpu_has_perf_global_ctrl_bug())
-		vmexit_ctrl &= ~VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
-
 	/* Loading of EFER and PERF_GLOBAL_CTRL are toggled dynamically */
 	return vmexit_ctrl &
 		~(VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL | VM_EXIT_LOAD_IA32_EFER);
@@ -8415,10 +8407,6 @@ __init int vmx_hardware_setup(void)
 	if (setup_vmcs_config(&vmcs_config, &vmx_capability) < 0)
 		return -EIO;
 
-	if (cpu_has_perf_global_ctrl_bug())
-		pr_warn_once("VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL "
-			     "does not work properly. Using workaround\n");
-
 	if (boot_cpu_has(X86_FEATURE_NX))
 		kvm_enable_efer_bits(EFER_NX);
 


