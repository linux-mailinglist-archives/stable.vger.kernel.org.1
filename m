Return-Path: <stable+bounces-62485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FD093F362
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3571F22076
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 10:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683AD145344;
	Mon, 29 Jul 2024 10:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lrPUrS+Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2940C1428F2
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 10:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722250680; cv=none; b=ZAmxXoXdtGH9XxBGqRj/EwCQB7NEs8O+lexu0NThsHAlxLzIMbLSb627Hun2mmYW4CIUWz1K26kwbsMWRhBpqQwl6Z1EJmWc4rmFXYupfaK+M7Z69rsgYZW/HScn5JBYLSdknflHR45K6wpupiV9EyqzeJ9KdAZIdKh4omCtpQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722250680; c=relaxed/simple;
	bh=3H2RB1kGrFFTCrny6KLahH1z3EQyJqkoTfUofJjQEBc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lYPKgIsyjosHaIO1UjBnkGfzs0flXZpCZg9CCou+uULpIQsvCvPpojE1NFZyYuLMHcSNhZDKPLGsWKCheWkVCvaKJUxpMFIhYYZZVDCGt/CDGRJFbaFwNqtcDKpw8en5avxRJK5DPdhcVAu0i5I6aSpJMkcKbP3v9c96rqz1a0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lrPUrS+Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE48C32786;
	Mon, 29 Jul 2024 10:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722250679;
	bh=3H2RB1kGrFFTCrny6KLahH1z3EQyJqkoTfUofJjQEBc=;
	h=Subject:To:Cc:From:Date:From;
	b=lrPUrS+YOtdUhpGyc3WlByzzx3Xorz1doDJ16r6RBRqp4OmsmX8tOLoB7FixY5DmZ
	 vw/pfTgQg0+foWFwy+86GcS4gXS9HVLFByDX6fiKPn3fVtEuVglFMwAih7ejrk8l/X
	 wouoCsjiEvBoo5xrL7i/zpaM49He1ak91E9fy+ZY=
Subject: FAILED: patch "[PATCH] KVM: nVMX: Add a helper to get highest pending from Posted" failed to apply to 6.1-stable tree
To: seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 12:57:48 +0200
Message-ID: <2024072948-cosponsor-jacket-16bb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d83c36d822be44db4bad0c43bea99c8908f54117
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072948-cosponsor-jacket-16bb@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

d83c36d822be ("KVM: nVMX: Add a helper to get highest pending from Posted Interrupt vector")
699f67512f04 ("KVM: VMX: Move posted interrupt descriptor out of VMX code")
50a82b0eb88c ("KVM: VMX: Split off vmx_onhyperv.{ch} from hyperv.{ch}")
662f6815786e ("KVM: VMX: Rename XSAVES control to follow KVM's preferred "ENABLE_XYZ"")
1143c0b85c07 ("KVM: VMX: Recompute "XSAVES enabled" only after CPUID update")
fbc722aac1ce ("KVM: VMX: Rename "KVM is using eVMCS" static key to match its wrapper")
19f10315fd53 ("KVM: VMX: Stub out enable_evmcs static key for CONFIG_HYPERV=n")
68ac4221497b ("KVM: nVMX: Move EVMCS1_SUPPORT_* macros to hyperv.c")
93827a0a3639 ("KVM: VMX: Fix crash due to uninitialized current_vmcs")
11633f69506d ("KVM: VMX: Always inline eVMCS read/write helpers")
d83420c2d74e ("KVM: x86: Move CPU compat checks hook to kvm_x86_ops (from kvm_x86_init_ops)")
325fc9579c2e ("KVM: SVM: Check for SVM support in CPU compatibility checks")
8504ef2139e2 ("KVM: VMX: Shuffle support checks and hardware enabling code around")
d41931324975 ("KVM: x86: Do VMX/SVM support checks directly in vendor code")
462689b37f08 ("KVM: VMX: Use current CPU's info to perform "disabled by BIOS?" checks")
8d20bd638167 ("KVM: x86: Unify pr_fmt to use module name for all KVM modules")
3045c483eeee ("KVM: x86: Do CPU compatibility checks in x86 code")
a578a0a9e352 ("KVM: Drop kvm_arch_{init,exit}() hooks")
20deee32f553 ("KVM: RISC-V: Do arch init directly in riscv_kvm_init()")
3fb8e89aa2a0 ("KVM: MIPS: Setup VZ emulation? directly from kvm_mips_init()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d83c36d822be44db4bad0c43bea99c8908f54117 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Fri, 7 Jun 2024 10:26:04 -0700
Subject: [PATCH] KVM: nVMX: Add a helper to get highest pending from Posted
 Interrupt vector

Add a helper to retrieve the highest pending vector given a Posted
Interrupt descriptor.  While the actual operation is straightforward, it's
surprisingly easy to mess up, e.g. if one tries to reuse lapic.c's
find_highest_vector(), which doesn't work with PID.PIR due to the APIC's
IRR and ISR component registers being physically discontiguous (they're
4-byte registers aligned at 16-byte intervals).

To make PIR handling more consistent with respect to IRR and ISR handling,
return -1 to indicate "no interrupt pending".

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240607172609.3205077-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 643935a0f70a..8f4db6e8f57c 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -12,6 +12,7 @@
 #include "mmu.h"
 #include "nested.h"
 #include "pmu.h"
+#include "posted_intr.h"
 #include "sgx.h"
 #include "trace.h"
 #include "vmx.h"
@@ -3899,8 +3900,8 @@ static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 	if (!pi_test_and_clear_on(vmx->nested.pi_desc))
 		return 0;
 
-	max_irr = find_last_bit((unsigned long *)vmx->nested.pi_desc->pir, 256);
-	if (max_irr != 256) {
+	max_irr = pi_find_highest_vector(vmx->nested.pi_desc);
+	if (max_irr > 0) {
 		vapic_page = vmx->nested.virtual_apic_map.hva;
 		if (!vapic_page)
 			goto mmio_needed;
diff --git a/arch/x86/kvm/vmx/posted_intr.h b/arch/x86/kvm/vmx/posted_intr.h
index 6b2a0226257e..1715d2ab07be 100644
--- a/arch/x86/kvm/vmx/posted_intr.h
+++ b/arch/x86/kvm/vmx/posted_intr.h
@@ -1,6 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __KVM_X86_VMX_POSTED_INTR_H
 #define __KVM_X86_VMX_POSTED_INTR_H
+
+#include <linux/find.h>
 #include <asm/posted_intr.h>
 
 void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu);
@@ -12,4 +14,12 @@ int vmx_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
 		       uint32_t guest_irq, bool set);
 void vmx_pi_start_assignment(struct kvm *kvm);
 
+static inline int pi_find_highest_vector(struct pi_desc *pi_desc)
+{
+	int vec;
+
+	vec = find_last_bit((unsigned long *)pi_desc->pir, 256);
+	return vec < 256 ? vec : -1;
+}
+
 #endif /* __KVM_X86_VMX_POSTED_INTR_H */


