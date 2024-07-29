Return-Path: <stable+bounces-62483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3C593F35F
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1A53B224B1
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 10:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5B4145335;
	Mon, 29 Jul 2024 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mzsfouSV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D12B13EFEE
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722250671; cv=none; b=fVJ0gT9i8ARK3+9YgNlJr2xjlW/+dnBkuzXfsw6t/OfJUok+wVpwFE3kx1PY5fEyuDS4TgfpeUtukkK+cQVoHCkN2gWA5g/q7VPv8NVM7SzAgR85Ibu96qcrl2hrgPzdkf0leiNEHcBzdRPtZzUiLVkAznTDXS42176kV9JmQds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722250671; c=relaxed/simple;
	bh=cJ5w6nikbAFzfTYQBPZBqlxrVUk38jTq5fMwLom6jGk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jiD0i3X8Sdez00d5jSAzFIcVlUI7b+IyXdmdQcE7bmDLjTlvTqBqRaG/W39RDkx+29Qv591afCz4ucFnFHSBd6Hd4+QU4UK3eqJnXbD/deJbZxtpvj4OhxGxEFHsBNixzefEVkT/OTnZ1H4X0yyFooOmmV493pulXGxxV5QS4to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mzsfouSV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AFB5C32786;
	Mon, 29 Jul 2024 10:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722250671;
	bh=cJ5w6nikbAFzfTYQBPZBqlxrVUk38jTq5fMwLom6jGk=;
	h=Subject:To:Cc:From:Date:From;
	b=mzsfouSV5ZD+HOtKK7TKOPiEYtUfLxNYC557TdQBFjOG+obq9cNESMfXGmEcukmiY
	 E59lkTXQwuJ/9kvoQCQG+8eaI9yxcGrfQIKKge/soWgBGaPxUaVTAfZBlF03hH++Hk
	 VMGlwMUNHgOIhmO+zSPn+TQY2/U0d2RKs/oY4fPs=
Subject: FAILED: patch "[PATCH] KVM: nVMX: Add a helper to get highest pending from Posted" failed to apply to 6.6-stable tree
To: seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 12:57:47 +0200
Message-ID: <2024072947-acutely-kindness-fc65@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d83c36d822be44db4bad0c43bea99c8908f54117
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072947-acutely-kindness-fc65@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

d83c36d822be ("KVM: nVMX: Add a helper to get highest pending from Posted Interrupt vector")
699f67512f04 ("KVM: VMX: Move posted interrupt descriptor out of VMX code")
50a82b0eb88c ("KVM: VMX: Split off vmx_onhyperv.{ch} from hyperv.{ch}")

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


