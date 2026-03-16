Return-Path: <stable+bounces-225636-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CJ0N1I+uGmxawEAu9opvQ
	(envelope-from <stable+bounces-225636-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:30:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 667C429E472
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CEA23156417
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85563CFF7D;
	Mon, 16 Mar 2026 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwoG5WZr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEA53CFF77
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681609; cv=none; b=pfxDBJ8cP9j0r6zodItJqnO4/igByc6vufaWEf0BFsqlX33fL8wdjZRUrfpHAmNdvt9xA41du9CX9wO3LTzucGLcIJpopZWunKeNXOtJKLEkyvmMCjfLODQgJotdptBws19At7ApjGlO9d0zoeJslwJvclPL9G9QrQvnpQFFWFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681609; c=relaxed/simple;
	bh=NdE7wjEHgRQvuRf7ECRMY/bYbfBOQ6w5U3hjmVh4TvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guXuc1t5vmIV+woIV6bJfYTMrNIOT96xMSj33qn2SKvthm5EqwCZFzAIB6H3n4DYiKOyTb/uOIbJI62Wb7wm6feE7bO2p9DdZzxqR1WpNMT/pi0fZlKT2Le9ME49yynwgC2JeasdNvhQRGumRSzwLlKRv2VaU9gIPVjagluqSgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwoG5WZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55FFC19425;
	Mon, 16 Mar 2026 17:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773681609;
	bh=NdE7wjEHgRQvuRf7ECRMY/bYbfBOQ6w5U3hjmVh4TvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XwoG5WZrf2JSbKcNmgS1OrSJwwh8pyvdXZ91yW8fyW9bAo2NSqCAdC1r4ZLnI8SPh
	 /Xamgv02ijnxmo8sA8+2PvUilSfcCvdp+M+Xrt0uoBXfvvJwvnMai0osM/p8dadHs9
	 UScKAzLJM9kkszSwI4cZKDDodA+YYz0a+DaiexvXeACXYX+9BJqYSWD+0b4PtyjJ9q
	 0Jq2kXGnafGtP27KWObpsjW8bgCepu+Pr6iAZ8sOGS26JzzTdbjJUvxDYDufwVnUX0
	 PgZjL/1pbUSK81Z6DhNft7+6MAK5FNS4OYLEkkDAYJg58g8I0j8sW1KueeS82THids
	 gJlH+8FO04szA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yan Zhao <yan.y.zhao@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 6/8] KVM: x86: Introduce Intel specific quirk KVM_X86_QUIRK_IGNORE_GUEST_PAT
Date: Mon, 16 Mar 2026 13:20:01 -0400
Message-ID: <20260316172003.1024253-6-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260316172003.1024253-1-sashal@kernel.org>
References: <2026031659-scroll-setting-4687@gregkh>
 <20260316172003.1024253-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225636-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 667C429E472
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yan Zhao <yan.y.zhao@intel.com>

[ Upstream commit c9c1e20b4c7d60fa084b3257525d21a49fe651a1 ]

Introduce an Intel specific quirk KVM_X86_QUIRK_IGNORE_GUEST_PAT to have
KVM ignore guest PAT when this quirk is enabled.

On AMD platforms, KVM always honors guest PAT.  On Intel however there are
two issues.  First, KVM *cannot* honor guest PAT if CPU feature self-snoop
is not supported. Second, UC access on certain Intel platforms can be very
slow[1] and honoring guest PAT on those platforms may break some old
guests that accidentally specify video RAM as UC. Those old guests may
never expect the slowness since KVM always forces WB previously. See [2].

So, introduce a quirk that KVM can enable by default on all Intel platforms
to avoid breaking old unmodifiable guests. Newer userspace can disable this
quirk if it wishes KVM to honor guest PAT; disabling the quirk will fail
if self-snoop is not supported, i.e. if KVM cannot obey the wish.

The quirk is a no-op on AMD and also if any assigned devices have
non-coherent DMA.  This is not an issue, as KVM_X86_QUIRK_CD_NW_CLEARED is
another example of a quirk that is sometimes automatically disabled.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Link: https://lore.kernel.org/all/Ztl9NWCOupNfVaCA@yzhao56-desk.sh.intel.com # [1]
Link: https://lore.kernel.org/all/87jzfutmfc.fsf@redhat.com # [2]
Message-ID: <20250224070946.31482-1-yan.y.zhao@intel.com>
[Use supported_quirks/inapplicable_quirks to support both AMD and
 no-self-snoop cases, as well as to remove the shadow_memtype_mask check
 from kvm_mmu_may_ignore_guest_pat(). - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: e2ffe85b6d2b ("KVM: x86: Introduce KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/virt/kvm/api.rst  | 22 ++++++++++++++++++
 arch/x86/include/asm/kvm_host.h |  6 +++--
 arch/x86/include/uapi/asm/kvm.h |  1 +
 arch/x86/kvm/mmu.h              |  2 +-
 arch/x86/kvm/mmu/mmu.c          | 10 ++++----
 arch/x86/kvm/vmx/vmx.c          | 41 +++++++++++++++++++++++++++------
 arch/x86/kvm/x86.c              |  6 ++++-
 7 files changed, 73 insertions(+), 15 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 061ec93d9ecb7..b1b164bc5c11d 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -8129,6 +8129,28 @@ KVM_X86_QUIRK_STUFF_FEATURE_MSRS    By default, at vCPU creation, KVM sets the
                                     and 0x489), as KVM does now allow them to
                                     be set by userspace (KVM sets them based on
                                     guest CPUID, for safety purposes).
+
+KVM_X86_QUIRK_IGNORE_GUEST_PAT      By default, on Intel platforms, KVM ignores
+                                    guest PAT and forces the effective memory
+                                    type to WB in EPT.  The quirk is not available
+                                    on Intel platforms which are incapable of
+                                    safely honoring guest PAT (i.e., without CPU
+                                    self-snoop, KVM always ignores guest PAT and
+                                    forces effective memory type to WB).  It is
+                                    also ignored on AMD platforms or, on Intel,
+                                    when a VM has non-coherent DMA devices
+                                    assigned; KVM always honors guest PAT in
+                                    such case. The quirk is needed to avoid
+                                    slowdowns on certain Intel Xeon platforms
+                                    (e.g. ICX, SPR) where self-snoop feature is
+                                    supported but UC is slow enough to cause
+                                    issues with some older guests that use
+                                    UC instead of WC to map the video RAM.
+                                    Userspace can disable the quirk to honor
+                                    guest PAT if it knows that there is no such
+                                    guest software, for example if it does not
+                                    expose a bochs graphics device (which is
+                                    known to have had a buggy driver).
 =================================== ============================================
 
 7.32 KVM_CAP_MAX_VCPU_ID
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 7fdaefb301d93..7b1ea464e0147 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2386,10 +2386,12 @@ int memslot_rmap_alloc(struct kvm_memory_slot *slot, unsigned long npages);
 	 KVM_X86_QUIRK_FIX_HYPERCALL_INSN |	\
 	 KVM_X86_QUIRK_MWAIT_NEVER_UD_FAULTS |	\
 	 KVM_X86_QUIRK_SLOT_ZAP_ALL |		\
-	 KVM_X86_QUIRK_STUFF_FEATURE_MSRS)
+	 KVM_X86_QUIRK_STUFF_FEATURE_MSRS |	\
+	 KVM_X86_QUIRK_IGNORE_GUEST_PAT)
 
 #define KVM_X86_CONDITIONAL_QUIRKS		\
-	 KVM_X86_QUIRK_CD_NW_CLEARED
+	(KVM_X86_QUIRK_CD_NW_CLEARED |		\
+	 KVM_X86_QUIRK_IGNORE_GUEST_PAT)
 
 /*
  * KVM previously used a u32 field in kvm_run to indicate the hypercall was
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 88585c1de416f..700e7f9af18a7 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -441,6 +441,7 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_MWAIT_NEVER_UD_FAULTS	(1 << 6)
 #define KVM_X86_QUIRK_SLOT_ZAP_ALL		(1 << 7)
 #define KVM_X86_QUIRK_STUFF_FEATURE_MSRS	(1 << 8)
+#define KVM_X86_QUIRK_IGNORE_GUEST_PAT		(1 << 9)
 
 #define KVM_STATE_NESTED_FORMAT_VMX	0
 #define KVM_STATE_NESTED_FORMAT_SVM	1
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index e9322358678b6..1d9c919c92320 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -222,7 +222,7 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 	return -(u32)fault & errcode;
 }
 
-bool kvm_mmu_may_ignore_guest_pat(void);
+bool kvm_mmu_may_ignore_guest_pat(struct kvm *kvm);
 
 int kvm_mmu_post_init_vm(struct kvm *kvm);
 void kvm_mmu_pre_destroy_vm(struct kvm *kvm);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 700926eb77dfa..31921b6658dde 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4713,17 +4713,19 @@ static int kvm_tdp_mmu_page_fault(struct kvm_vcpu *vcpu,
 }
 #endif
 
-bool kvm_mmu_may_ignore_guest_pat(void)
+bool kvm_mmu_may_ignore_guest_pat(struct kvm *kvm)
 {
 	/*
 	 * When EPT is enabled (shadow_memtype_mask is non-zero), and the VM
 	 * has non-coherent DMA (DMA doesn't snoop CPU caches), KVM's ABI is to
 	 * honor the memtype from the guest's PAT so that guest accesses to
 	 * memory that is DMA'd aren't cached against the guest's wishes.  As a
-	 * result, KVM _may_ ignore guest PAT, whereas without non-coherent DMA,
-	 * KVM _always_ ignores guest PAT (when EPT is enabled).
+	 * result, KVM _may_ ignore guest PAT, whereas without non-coherent DMA.
+	 * KVM _always_ ignores guest PAT, when EPT is enabled and when quirk
+	 * KVM_X86_QUIRK_IGNORE_GUEST_PAT is enabled or the CPU lacks the
+	 * ability to safely honor guest PAT.
 	 */
-	return shadow_memtype_mask;
+	return kvm_check_has_quirk(kvm, KVM_X86_QUIRK_IGNORE_GUEST_PAT);
 }
 
 int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 4f4e75bb66ca3..b8aa9ef73e7a4 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7665,6 +7665,17 @@ int vmx_vm_init(struct kvm *kvm)
 	return 0;
 }
 
+static inline bool vmx_ignore_guest_pat(struct kvm *kvm)
+{
+	/*
+	 * Non-coherent DMA devices need the guest to flush CPU properly.
+	 * In that case it is not possible to map all guest RAM as WB, so
+	 * always trust guest PAT.
+	 */
+	return !kvm_arch_has_noncoherent_dma(kvm) &&
+	       kvm_check_has_quirk(kvm, KVM_X86_QUIRK_IGNORE_GUEST_PAT);
+}
+
 u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
 {
 	/*
@@ -7674,13 +7685,8 @@ u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
 	if (is_mmio)
 		return MTRR_TYPE_UNCACHABLE << VMX_EPT_MT_EPTE_SHIFT;
 
-	/*
-	 * Force WB and ignore guest PAT if the VM does NOT have a non-coherent
-	 * device attached.  Letting the guest control memory types on Intel
-	 * CPUs may result in unexpected behavior, and so KVM's ABI is to trust
-	 * the guest to behave only as a last resort.
-	 */
-	if (!kvm_arch_has_noncoherent_dma(vcpu->kvm))
+	/* Force WB if ignoring guest PAT */
+	if (vmx_ignore_guest_pat(vcpu->kvm))
 		return (MTRR_TYPE_WRBACK << VMX_EPT_MT_EPTE_SHIFT) | VMX_EPT_IPAT_BIT;
 
 	return (MTRR_TYPE_WRBACK << VMX_EPT_MT_EPTE_SHIFT);
@@ -8579,6 +8585,27 @@ __init int vmx_hardware_setup(void)
 
 	kvm_set_posted_intr_wakeup_handler(pi_wakeup_handler);
 
+	/*
+	 * On Intel CPUs that lack self-snoop feature, letting the guest control
+	 * memory types may result in unexpected behavior. So always ignore guest
+	 * PAT on those CPUs and map VM as writeback, not allowing userspace to
+	 * disable the quirk.
+	 *
+	 * On certain Intel CPUs (e.g. SPR, ICX), though self-snoop feature is
+	 * supported, UC is slow enough to cause issues with some older guests (e.g.
+	 * an old version of bochs driver uses ioremap() instead of ioremap_wc() to
+	 * map the video RAM, causing wayland desktop to fail to get started
+	 * correctly). To avoid breaking those older guests that rely on KVM to force
+	 * memory type to WB, provide KVM_X86_QUIRK_IGNORE_GUEST_PAT to preserve the
+	 * safer (for performance) default behavior.
+	 *
+	 * On top of this, non-coherent DMA devices need the guest to flush CPU
+	 * caches properly.  This also requires honoring guest PAT, and is forced
+	 * independent of the quirk in vmx_ignore_guest_pat().
+	 */
+	if (!static_cpu_has(X86_FEATURE_SELFSNOOP))
+		kvm_caps.supported_quirks &= ~KVM_X86_QUIRK_IGNORE_GUEST_PAT;
+       kvm_caps.inapplicable_quirks &= ~KVM_X86_QUIRK_IGNORE_GUEST_PAT;
 	return r;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 981562592d9ce..8a52b7bb821a7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9828,6 +9828,10 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 	if (IS_ENABLED(CONFIG_KVM_SW_PROTECTED_VM) && tdp_mmu_enabled)
 		kvm_caps.supported_vm_types |= BIT(KVM_X86_SW_PROTECTED_VM);
 
+	/* KVM always ignores guest PAT for shadow paging.  */
+	if (!tdp_enabled)
+		kvm_caps.supported_quirks &= ~KVM_X86_QUIRK_IGNORE_GUEST_PAT;
+
 	if (!kvm_cpu_cap_has(X86_FEATURE_XSAVES))
 		kvm_caps.supported_xss = 0;
 
@@ -13601,7 +13605,7 @@ static void kvm_noncoherent_dma_assignment_start_or_stop(struct kvm *kvm)
 	 * (or last) non-coherent device is (un)registered to so that new SPTEs
 	 * with the correct "ignore guest PAT" setting are created.
 	 */
-	if (kvm_mmu_may_ignore_guest_pat())
+	if (kvm_mmu_may_ignore_guest_pat(kvm))
 		kvm_zap_gfn_range(kvm, gpa_to_gfn(0), gpa_to_gfn(~0ULL));
 }
 
-- 
2.51.0


