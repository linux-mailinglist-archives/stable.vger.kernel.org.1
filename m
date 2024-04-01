Return-Path: <stable+bounces-34429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E15A4893F51
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C38D1C216D1
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D42481C2;
	Mon,  1 Apr 2024 16:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f/hlIVF/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A04A481AB;
	Mon,  1 Apr 2024 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711988092; cv=none; b=d8RzGbHVImF9AEyL6s9LbSGdC3zsiDyO1q1j/AeeWEDbzSTV93tz8l7BYB+b0rLTZmWfsun8uOXplI4J8sQnlfoPtVgchy0L/2EB/ngpfbswF2zZSYyRKsIGTSxXy0qvorx/EtjRE3y+nEGSlmeLSGzK1rY9vbWX5nYYaXZFb4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711988092; c=relaxed/simple;
	bh=VEWdvMgLmWmcmUTdrTYJIc4ssvEewyr7Y9shjsS+l4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0m5p3m9GlgY8FHAI1sGcV0940+6hOqG91YqhbQQcEqDHl2rAz1Ix8Rb0kEKeNZ+89esOoI016RxkN/NxMboBw6H1vdYqy3ovBSm7AHtA3dHDXiEMI5C6G9SFmFKKWfa5Nq9FLIR1BZaNETaNU7thxKM3reCcar5adWWl9gclvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f/hlIVF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456C0C433F1;
	Mon,  1 Apr 2024 16:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711988091;
	bh=VEWdvMgLmWmcmUTdrTYJIc4ssvEewyr7Y9shjsS+l4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f/hlIVF/Xhqkpi8thknqowLsdWJWc6s5BvMmPTittm9t7OtDBCDmI/XsqJG9h+dzK
	 ukdJEx3rQq4DyaMrrSBMThKlZF/ETv4vWvzS4hzfNDQKxcc4D224kmfj1+Aa/LSh1B
	 NKtg4srr4BjVQtSRWuBbEmLreL/l1Ixa7zY1TjWE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Woodhouse <dwmw@amazon.co.uk>,
	Paul Durrant <paul@xen.org>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 082/432] KVM: x86/xen: inject vCPU upcall vector when local APIC is enabled
Date: Mon,  1 Apr 2024 17:41:09 +0200
Message-ID: <20240401152555.566972380@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

[ Upstream commit 8e62bf2bfa46367e14d0ffdcde5aada08759497c ]

Linux guests since commit b1c3497e604d ("x86/xen: Add support for
HVMOP_set_evtchn_upcall_vector") in v6.0 onwards will use the per-vCPU
upcall vector when it's advertised in the Xen CPUID leaves.

This upcall is injected through the guest's local APIC as an MSI, unlike
the older system vector which was merely injected by the hypervisor any
time the CPU was able to receive an interrupt and the upcall_pending
flags is set in its vcpu_info.

Effectively, that makes the per-CPU upcall edge triggered instead of
level triggered, which results in the upcall being lost if the MSI is
delivered when the local APIC is *disabled*.

Xen checks the vcpu_info->evtchn_upcall_pending flag when the local APIC
for a vCPU is software enabled (in fact, on any write to the SPIV
register which doesn't disable the APIC). Do the same in KVM since KVM
doesn't provide a way for userspace to intervene and trap accesses to
the SPIV register of a local APIC emulated by KVM.

Fixes: fde0451be8fb3 ("KVM: x86/xen: Support per-vCPU event channel upcall via local APIC")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240227115648.3104-3-dwmw2@infradead.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/lapic.c |  5 ++++-
 arch/x86/kvm/xen.c   |  2 +-
 arch/x86/kvm/xen.h   | 18 ++++++++++++++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 245b20973caee..23fab75993a51 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -41,6 +41,7 @@
 #include "ioapic.h"
 #include "trace.h"
 #include "x86.h"
+#include "xen.h"
 #include "cpuid.h"
 #include "hyperv.h"
 #include "smm.h"
@@ -499,8 +500,10 @@ static inline void apic_set_spiv(struct kvm_lapic *apic, u32 val)
 	}
 
 	/* Check if there are APF page ready requests pending */
-	if (enabled)
+	if (enabled) {
 		kvm_make_request(KVM_REQ_APF_READY, apic->vcpu);
+		kvm_xen_sw_enable_lapic(apic->vcpu);
+	}
 }
 
 static inline void kvm_apic_set_xapic_id(struct kvm_lapic *apic, u8 id)
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index e53fad915a626..50218f3fc1703 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -493,7 +493,7 @@ void kvm_xen_update_runstate(struct kvm_vcpu *v, int state)
 		kvm_xen_update_runstate_guest(v, state == RUNSTATE_runnable);
 }
 
-static void kvm_xen_inject_vcpu_vector(struct kvm_vcpu *v)
+void kvm_xen_inject_vcpu_vector(struct kvm_vcpu *v)
 {
 	struct kvm_lapic_irq irq = { };
 	int r;
diff --git a/arch/x86/kvm/xen.h b/arch/x86/kvm/xen.h
index f8f1fe22d0906..f5841d9000aeb 100644
--- a/arch/x86/kvm/xen.h
+++ b/arch/x86/kvm/xen.h
@@ -18,6 +18,7 @@ extern struct static_key_false_deferred kvm_xen_enabled;
 
 int __kvm_xen_has_interrupt(struct kvm_vcpu *vcpu);
 void kvm_xen_inject_pending_events(struct kvm_vcpu *vcpu);
+void kvm_xen_inject_vcpu_vector(struct kvm_vcpu *vcpu);
 int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data);
 int kvm_xen_vcpu_get_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data);
 int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data);
@@ -36,6 +37,19 @@ int kvm_xen_setup_evtchn(struct kvm *kvm,
 			 const struct kvm_irq_routing_entry *ue);
 void kvm_xen_update_tsc_info(struct kvm_vcpu *vcpu);
 
+static inline void kvm_xen_sw_enable_lapic(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * The local APIC is being enabled. If the per-vCPU upcall vector is
+	 * set and the vCPU's evtchn_upcall_pending flag is set, inject the
+	 * interrupt.
+	 */
+	if (static_branch_unlikely(&kvm_xen_enabled.key) &&
+	    vcpu->arch.xen.vcpu_info_cache.active &&
+	    vcpu->arch.xen.upcall_vector && __kvm_xen_has_interrupt(vcpu))
+		kvm_xen_inject_vcpu_vector(vcpu);
+}
+
 static inline bool kvm_xen_msr_enabled(struct kvm *kvm)
 {
 	return static_branch_unlikely(&kvm_xen_enabled.key) &&
@@ -101,6 +115,10 @@ static inline void kvm_xen_destroy_vcpu(struct kvm_vcpu *vcpu)
 {
 }
 
+static inline void kvm_xen_sw_enable_lapic(struct kvm_vcpu *vcpu)
+{
+}
+
 static inline bool kvm_xen_msr_enabled(struct kvm *kvm)
 {
 	return false;
-- 
2.43.0




