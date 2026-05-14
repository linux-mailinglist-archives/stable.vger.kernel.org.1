Return-Path: <stable+bounces-247213-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OoTEejdBWqjcwIAu9opvQ
	(envelope-from <stable+bounces-247213-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 16:36:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC32543396
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 16:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C663303991B
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 14:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534D23E4C99;
	Thu, 14 May 2026 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m00B3Epu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB923DFC6B;
	Thu, 14 May 2026 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778768634; cv=none; b=mlynj9OSfwaLAVl/4c65e00QB/dMcMEiqr10dHjPhH6wgIcfFBwweA37B7VcPaqVlD2IdLjLHBJ+ur9H4nJFAoT+C8+Onyr8nnHZFA0vFpq0OXUy/8hQQg14Y1ldM2aS+t04ipA0mHapBycedWHZaH9k6CWEQ8Z9RNSQcL7apPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778768634; c=relaxed/simple;
	bh=AExZ5QqgtWUT/8qEW3rN+yqXSD9oylZR3Yl+4a7ngG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KygdpUUabFV5lorxNlJy6HA+vMbiF3gU0q4VSnNJLlDIqBRdX7qx2Zq+wQp8xznR1IXDaoj8OiOoxnJ3LU+HWaSoBW0q+axazvCIJ4SF7LmYZNWOOmrbNXDgGit9puAwO/R9pfLy0rrf/MWbFvoCz7xfUk8kM93hgnOFLQL6ZCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m00B3Epu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC22C2BCB3;
	Thu, 14 May 2026 14:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778768634;
	bh=AExZ5QqgtWUT/8qEW3rN+yqXSD9oylZR3Yl+4a7ngG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m00B3EpuPeJJk4S/M8rpp54t4IABHcaFzN5M1oWu5eJafq8FQw4jz4uH1RRbJT8Zd
	 d4KnHoVrpbizVD5IdXR2jxy+KcybpA2/0FHmGMek2G0ONrTO0CNabPwhTgkXaujqjm
	 8ht/khX9dWfOjeNgyTV9RxIUljfC2FyvDpalWHME=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 7.0.7
Date: Thu, 14 May 2026 16:23:51 +0200
Message-ID: <2026051451-widow-germicide-25f4@gregkh>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026051451-frightful-buffalo-8217@gregkh>
References: <2026051451-frightful-buffalo-8217@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AFC32543396
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247213-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[run_syscall_errors_test.sh:url,addr.id:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,run_param_test.sh:url,run_timeslice_test.sh:url,run_legacy_check.sh:url,m.to:url]
X-Rspamd-Action: no action

diff --git a/Documentation/ABI/obsolete/sysfs-selinux-user b/Documentation/ABI/obsolete/sysfs-selinux-user
deleted file mode 100644
index 8ab7557f283f..000000000000
--- a/Documentation/ABI/obsolete/sysfs-selinux-user
+++ /dev/null
@@ -1,12 +0,0 @@
-What:		/sys/fs/selinux/user
-Date:		April 2005 (predates git)
-KernelVersion:	2.6.12-rc2 (predates git)
-Contact:	selinux@vger.kernel.org
-Description:
-
-	The selinuxfs "user" node allows userspace to request a list
-	of security contexts that can be reached for a given SELinux
-	user from a given starting context. This was used by libselinux
-	when various login-style programs requested contexts for
-	users, but libselinux stopped using it in 2020.
-	Kernel support will be removed no sooner than Dec 2025.
diff --git a/Documentation/ABI/removed/sysfs-selinux-user b/Documentation/ABI/removed/sysfs-selinux-user
new file mode 100644
index 000000000000..8ab7557f283f
--- /dev/null
+++ b/Documentation/ABI/removed/sysfs-selinux-user
@@ -0,0 +1,12 @@
+What:		/sys/fs/selinux/user
+Date:		April 2005 (predates git)
+KernelVersion:	2.6.12-rc2 (predates git)
+Contact:	selinux@vger.kernel.org
+Description:
+
+	The selinuxfs "user" node allows userspace to request a list
+	of security contexts that can be reached for a given SELinux
+	user from a given starting context. This was used by libselinux
+	when various login-style programs requested contexts for
+	users, but libselinux stopped using it in 2020.
+	Kernel support will be removed no sooner than Dec 2025.
diff --git a/Makefile b/Makefile
index dbc380a9339e..a854e46c1171 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 7
 PATCHLEVEL = 0
-SUBLEVEL = 6
+SUBLEVEL = 7
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
@@ -486,6 +486,8 @@ export rust_common_flags := --edition=2021 \
 			    -Wclippy::as_ptr_cast_mut \
 			    -Wclippy::as_underscore \
 			    -Wclippy::cast_lossless \
+			    -Aclippy::collapsible_if \
+			    -Aclippy::collapsible_match \
 			    -Wclippy::ignored_unit_patterns \
 			    -Wclippy::mut_mut \
 			    -Wclippy::needless_bitwise_bool \
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 70cb9cfd760a..9d82f9a644cd 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1506,7 +1506,7 @@ static inline bool __vcpu_has_feature(const struct kvm_arch *ka, int feature)
 #define kvm_vcpu_has_feature(k, f)	__vcpu_has_feature(&(k)->arch, (f))
 #define vcpu_has_feature(v, f)	__vcpu_has_feature(&(v)->kvm->arch, (f))
 
-#define kvm_vcpu_initialized(v) vcpu_get_flag(vcpu, VCPU_INITIALIZED)
+#define kvm_vcpu_initialized(v) vcpu_get_flag(v, VCPU_INITIALIZED)
 
 int kvm_trng_call(struct kvm_vcpu *vcpu);
 #ifdef CONFIG_KVM
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index ba5eab23fd90..4d08598e2891 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -983,8 +983,8 @@ static int sve_set_common(struct task_struct *target,
 	}
 
 	/* Always zero V regs, FPSR, and FPCR */
-	memset(&current->thread.uw.fpsimd_state, 0,
-	       sizeof(current->thread.uw.fpsimd_state));
+	memset(&target->thread.uw.fpsimd_state, 0,
+	       sizeof(target->thread.uw.fpsimd_state));
 
 	/* Registers: FPSIMD-only case */
 
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 08ffc5a5aea4..38e6fa204c17 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -67,6 +67,9 @@ struct rt_sigframe_user_layout {
 	unsigned long end_offset;
 };
 
+#define TERMINATOR_SIZE round_up(sizeof(struct _aarch64_ctx), 16)
+#define EXTRA_CONTEXT_SIZE round_up(sizeof(struct extra_context), 16)
+
 /*
  * Holds any EL0-controlled state that influences unprivileged memory accesses.
  * This includes both accesses done in userspace and uaccess done in the kernel.
@@ -74,13 +77,35 @@ struct rt_sigframe_user_layout {
  * This state needs to be carefully managed to ensure that it doesn't cause
  * uaccess to fail when setting up the signal frame, and the signal handler
  * itself also expects a well-defined state when entered.
+ *
+ * The struct should be zero-initialised. Its members should only be accessed
+ * via the accessors below. __valid_fields tracks which of the fields are valid
+ * (have been set to some value).
  */
 struct user_access_state {
-	u64 por_el0;
+	unsigned int __valid_fields;
+	u64 __por_el0;
 };
 
-#define TERMINATOR_SIZE round_up(sizeof(struct _aarch64_ctx), 16)
-#define EXTRA_CONTEXT_SIZE round_up(sizeof(struct extra_context), 16)
+#define UA_STATE_HAS_POR_EL0	BIT(0)
+
+static void set_ua_state_por_el0(struct user_access_state *ua_state,
+				 u64 por_el0)
+{
+	ua_state->__por_el0 = por_el0;
+	ua_state->__valid_fields |= UA_STATE_HAS_POR_EL0;
+}
+
+static int get_ua_state_por_el0(const struct user_access_state *ua_state,
+				u64 *por_el0)
+{
+	if (ua_state->__valid_fields & UA_STATE_HAS_POR_EL0) {
+		*por_el0 = ua_state->__por_el0;
+		return 0;
+	}
+
+	return -ENOENT;
+}
 
 /*
  * Save the user access state into ua_state and reset it to disable any
@@ -94,7 +119,7 @@ static void save_reset_user_access_state(struct user_access_state *ua_state)
 		for (int pkey = 0; pkey < arch_max_pkey(); pkey++)
 			por_enable_all |= POR_ELx_PERM_PREP(pkey, POE_RWX);
 
-		ua_state->por_el0 = read_sysreg_s(SYS_POR_EL0);
+		set_ua_state_por_el0(ua_state, read_sysreg_s(SYS_POR_EL0));
 		write_sysreg_s(por_enable_all, SYS_POR_EL0);
 		/*
 		 * No ISB required as we can tolerate spurious Overlay faults -
@@ -122,8 +147,10 @@ static void set_handler_user_access_state(void)
  */
 static void restore_user_access_state(const struct user_access_state *ua_state)
 {
-	if (system_supports_poe())
-		write_sysreg_s(ua_state->por_el0, SYS_POR_EL0);
+	u64 por_el0;
+
+	if (get_ua_state_por_el0(ua_state, &por_el0) == 0)
+		write_sysreg_s(por_el0, SYS_POR_EL0);
 }
 
 static void init_user_layout(struct rt_sigframe_user_layout *user)
@@ -333,11 +360,16 @@ static int restore_fpmr_context(struct user_ctxs *user)
 static int preserve_poe_context(struct poe_context __user *ctx,
 				const struct user_access_state *ua_state)
 {
-	int err = 0;
+	int err;
+	u64 por_el0;
+
+	err = get_ua_state_por_el0(ua_state, &por_el0);
+	if (WARN_ON_ONCE(err))
+		return err;
 
 	__put_user_error(POE_MAGIC, &ctx->head.magic, err);
 	__put_user_error(sizeof(*ctx), &ctx->head.size, err);
-	__put_user_error(ua_state->por_el0, &ctx->por_el0, err);
+	__put_user_error(por_el0, &ctx->por_el0, err);
 
 	return err;
 }
@@ -353,7 +385,7 @@ static int restore_poe_context(struct user_ctxs *user,
 
 	__get_user_error(por_el0, &(user->poe->por_el0), err);
 	if (!err)
-		ua_state->por_el0 = por_el0;
+		set_ua_state_por_el0(ua_state, por_el0);
 
 	return err;
 }
@@ -1095,7 +1127,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
 {
 	struct pt_regs *regs = current_pt_regs();
 	struct rt_sigframe __user *frame;
-	struct user_access_state ua_state;
+	struct user_access_state ua_state = {};
 
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
@@ -1507,7 +1539,7 @@ static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
 {
 	struct rt_sigframe_user_layout user;
 	struct rt_sigframe __user *frame;
-	struct user_access_state ua_state;
+	struct user_access_state ua_state = {};
 	int err = 0;
 
 	fpsimd_save_and_flush_current_state();
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 410ffd41fd73..f9c9e7fb0997 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -805,6 +805,10 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
 {
 	bool irq_lines = *vcpu_hcr(v) & (HCR_VI | HCR_VF | HCR_VSE);
 
+	irq_lines |= (!irqchip_in_kernel(v->kvm) &&
+		      (kvm_timer_should_notify_user(v) ||
+		       kvm_pmu_should_notify_user(v)));
+
 	return ((irq_lines || kvm_vgic_vcpu_pending_irq(v))
 		&& !kvm_arm_vcpu_stopped(v) && !v->arch.pause);
 }
diff --git a/arch/arm64/kvm/config.c b/arch/arm64/kvm/config.c
index 0859c4d28415..f95783a7fa4c 100644
--- a/arch/arm64/kvm/config.c
+++ b/arch/arm64/kvm/config.c
@@ -131,7 +131,6 @@ struct reg_feat_map_desc {
 	}
 
 #define FEAT_SPE		ID_AA64DFR0_EL1, PMSVer, IMP
-#define FEAT_SPE_FnE		ID_AA64DFR0_EL1, PMSVer, V1P2
 #define FEAT_BRBE		ID_AA64DFR0_EL1, BRBE, IMP
 #define FEAT_TRC_SR		ID_AA64DFR0_EL1, TraceVer, IMP
 #define FEAT_PMUv3		ID_AA64DFR0_EL1, PMUVer, IMP
@@ -192,7 +191,7 @@ struct reg_feat_map_desc {
 #define FEAT_SRMASK		ID_AA64MMFR4_EL1, SRMASK, IMP
 #define FEAT_PoPS		ID_AA64MMFR4_EL1, PoPS, IMP
 #define FEAT_PFAR		ID_AA64PFR1_EL1, PFAR, IMP
-#define FEAT_Debugv8p9		ID_AA64DFR0_EL1, PMUVer, V3P9
+#define FEAT_Debugv8p9		ID_AA64DFR0_EL1, DebugVer, V8P9
 #define FEAT_PMUv3_SS		ID_AA64DFR0_EL1, PMSS, IMP
 #define FEAT_SEBEP		ID_AA64DFR0_EL1, SEBEP, IMP
 #define FEAT_EBEP		ID_AA64DFR1_EL1, EBEP, IMP
@@ -301,6 +300,16 @@ static bool feat_spe_fds(struct kvm *kvm)
 		(read_sysreg_s(SYS_PMSIDR_EL1) & PMSIDR_EL1_FDS));
 }
 
+static bool feat_spe_fne(struct kvm *kvm)
+{
+	/*
+	 * Revisit this if KVM ever supports SPE -- this really should
+	 * look at the guest's view of PMSIDR_EL1.
+	 */
+	return (kvm_has_feat(kvm, FEAT_SPEv1p2) &&
+		(read_sysreg_s(SYS_PMSIDR_EL1) & PMSIDR_EL1_FnE));
+}
+
 static bool feat_trbe_mpam(struct kvm *kvm)
 {
 	/*
@@ -536,7 +545,7 @@ static const struct reg_bits_to_feat_map hdfgrtr_feat_map[] = {
 		   HDFGRTR_EL2_PMBPTR_EL1	|
 		   HDFGRTR_EL2_PMBLIMITR_EL1,
 		   FEAT_SPE),
-	NEEDS_FEAT(HDFGRTR_EL2_nPMSNEVFR_EL1, FEAT_SPE_FnE),
+	NEEDS_FEAT(HDFGRTR_EL2_nPMSNEVFR_EL1, feat_spe_fne),
 	NEEDS_FEAT(HDFGRTR_EL2_nBRBDATA		|
 		   HDFGRTR_EL2_nBRBCTL		|
 		   HDFGRTR_EL2_nBRBIDR,
@@ -604,7 +613,7 @@ static const struct reg_bits_to_feat_map hdfgwtr_feat_map[] = {
 		   HDFGWTR_EL2_PMBPTR_EL1	|
 		   HDFGWTR_EL2_PMBLIMITR_EL1,
 		   FEAT_SPE),
-	NEEDS_FEAT(HDFGWTR_EL2_nPMSNEVFR_EL1, FEAT_SPE_FnE),
+	NEEDS_FEAT(HDFGWTR_EL2_nPMSNEVFR_EL1, feat_spe_fne),
 	NEEDS_FEAT(HDFGWTR_EL2_nBRBDATA		|
 		   HDFGWTR_EL2_nBRBCTL,
 		   FEAT_BRBE),
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index 2f029bfe4755..13db8979fe9d 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -258,7 +258,8 @@ struct pkvm_hyp_vcpu *pkvm_load_hyp_vcpu(pkvm_handle_t handle,
 	if (!hyp_vm || hyp_vm->kvm.created_vcpus <= vcpu_idx)
 		goto unlock;
 
-	hyp_vcpu = hyp_vm->vcpus[vcpu_idx];
+	/* Pairs with smp_store_release() in register_hyp_vcpu(). */
+	hyp_vcpu = smp_load_acquire(&hyp_vm->vcpus[vcpu_idx]);
 	if (!hyp_vcpu)
 		goto unlock;
 
@@ -803,12 +804,30 @@ int __pkvm_init_vm(struct kvm *host_kvm, unsigned long vm_hva,
  *	     the page-aligned size of 'struct pkvm_hyp_vcpu'.
  * Return 0 on success, negative error code on failure.
  */
+static int register_hyp_vcpu(struct pkvm_hyp_vm *hyp_vm,
+			      struct pkvm_hyp_vcpu *hyp_vcpu)
+{
+	unsigned int idx = hyp_vcpu->vcpu.vcpu_idx;
+
+	if (idx >= hyp_vm->kvm.created_vcpus)
+		return -EINVAL;
+
+	if (hyp_vm->vcpus[idx])
+		return -EINVAL;
+
+	/*
+	 * Ensure the hyp_vcpu is initialised before publishing it to
+	 * the vCPU-load path via 'hyp_vm->vcpus[]'.
+	 */
+	smp_store_release(&hyp_vm->vcpus[idx], hyp_vcpu);
+	return 0;
+}
+
 int __pkvm_init_vcpu(pkvm_handle_t handle, struct kvm_vcpu *host_vcpu,
 		     unsigned long vcpu_hva)
 {
 	struct pkvm_hyp_vcpu *hyp_vcpu;
 	struct pkvm_hyp_vm *hyp_vm;
-	unsigned int idx;
 	int ret;
 
 	hyp_vcpu = map_donated_memory(vcpu_hva, sizeof(*hyp_vcpu));
@@ -827,18 +846,11 @@ int __pkvm_init_vcpu(pkvm_handle_t handle, struct kvm_vcpu *host_vcpu,
 	if (ret)
 		goto unlock;
 
-	idx = hyp_vcpu->vcpu.vcpu_idx;
-	if (idx >= hyp_vm->kvm.created_vcpus) {
-		ret = -EINVAL;
-		goto unlock;
-	}
-
-	if (hyp_vm->vcpus[idx]) {
-		ret = -EINVAL;
-		goto unlock;
+	ret = register_hyp_vcpu(hyp_vm, hyp_vcpu);
+	if (ret) {
+		unpin_host_vcpu(host_vcpu);
+		unpin_host_sve_state(hyp_vcpu);
 	}
-
-	hyp_vm->vcpus[idx] = hyp_vcpu;
 unlock:
 	hyp_spin_unlock(&vm_table_lock);
 
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 90bd014e952f..97643fc02d92 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -312,15 +312,15 @@ void __noreturn __pkvm_init_finalise(void)
 	};
 	pkvm_pgtable.mm_ops = &pkvm_pgtable_mm_ops;
 
-	ret = fix_host_ownership();
+	ret = fix_hyp_pgtable_refcnt();
 	if (ret)
 		goto out;
 
-	ret = fix_hyp_pgtable_refcnt();
+	ret = hyp_create_fixmap();
 	if (ret)
 		goto out;
 
-	ret = hyp_create_fixmap();
+	ret = fix_host_ownership();
 	if (ret)
 		goto out;
 
diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v2.c b/arch/arm64/kvm/vgic/vgic-mmio-v2.c
index 406845b3117c..0643e333db35 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v2.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v2.c
@@ -91,7 +91,7 @@ static int vgic_mmio_uaccess_write_v2_misc(struct kvm_vcpu *vcpu,
 		 * migration from old kernels to new kernels with legacy
 		 * userspace.
 		 */
-		reg = FIELD_GET(GICD_IIDR_REVISION_MASK, reg);
+		reg = FIELD_GET(GICD_IIDR_REVISION_MASK, val);
 		switch (reg) {
 		case KVM_VGIC_IMP_REV_2:
 		case KVM_VGIC_IMP_REV_3:
diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 89edb84d1ac6..5913a20d8301 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -194,7 +194,7 @@ static int vgic_mmio_uaccess_write_v3_misc(struct kvm_vcpu *vcpu,
 		if ((reg ^ val) & ~GICD_IIDR_REVISION_MASK)
 			return -EINVAL;
 
-		reg = FIELD_GET(GICD_IIDR_REVISION_MASK, reg);
+		reg = FIELD_GET(GICD_IIDR_REVISION_MASK, val);
 		switch (reg) {
 		case KVM_VGIC_IMP_REV_2:
 		case KVM_VGIC_IMP_REV_3:
diff --git a/arch/loongarch/Kbuild b/arch/loongarch/Kbuild
index beb8499dd8ed..1c7a0dbe5e72 100644
--- a/arch/loongarch/Kbuild
+++ b/arch/loongarch/Kbuild
@@ -3,7 +3,7 @@ obj-y += mm/
 obj-y += net/
 obj-y += vdso/
 
-obj-$(CONFIG_KVM) += kvm/
+obj-$(subst m,y,$(CONFIG_KVM)) += kvm/
 
 # for cleaning
 subdir- += boot
diff --git a/arch/loongarch/include/asm/asm-prototypes.h b/arch/loongarch/include/asm/asm-prototypes.h
index 704066b4f736..de0c17f3f49c 100644
--- a/arch/loongarch/include/asm/asm-prototypes.h
+++ b/arch/loongarch/include/asm/asm-prototypes.h
@@ -20,3 +20,23 @@ asmlinkage void noinstr __no_stack_protector ret_from_kernel_thread(struct task_
 								    struct pt_regs *regs,
 								    int (*fn)(void *),
 								    void *fn_arg);
+
+struct kvm_run;
+struct kvm_vcpu;
+struct loongarch_fpu;
+
+void kvm_exc_entry(void);
+int  kvm_enter_guest(struct kvm_run *run, struct kvm_vcpu *vcpu);
+
+void kvm_save_fpu(struct loongarch_fpu *fpu);
+void kvm_restore_fpu(struct loongarch_fpu *fpu);
+
+#ifdef CONFIG_CPU_HAS_LSX
+void kvm_save_lsx(struct loongarch_fpu *fpu);
+void kvm_restore_lsx(struct loongarch_fpu *fpu);
+#endif
+
+#ifdef CONFIG_CPU_HAS_LASX
+void kvm_save_lasx(struct loongarch_fpu *fpu);
+void kvm_restore_lasx(struct loongarch_fpu *fpu);
+#endif
diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index 19eb5e5c3984..0bcdffc14c5f 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -86,7 +86,6 @@ struct kvm_context {
 struct kvm_world_switch {
 	int (*exc_entry)(void);
 	int (*enter_guest)(struct kvm_run *run, struct kvm_vcpu *vcpu);
-	unsigned long page_order;
 };
 
 #define MAX_PGTABLE_LEVELS	4
@@ -356,8 +355,6 @@ void kvm_exc_entry(void);
 int  kvm_enter_guest(struct kvm_run *run, struct kvm_vcpu *vcpu);
 
 extern unsigned long vpid_mask;
-extern const unsigned long kvm_exception_size;
-extern const unsigned long kvm_enter_guest_size;
 extern struct kvm_world_switch *kvm_loongarch_ops;
 
 #define SW_GCSR		(1 << 0)
diff --git a/arch/loongarch/include/asm/linkage.h b/arch/loongarch/include/asm/linkage.h
index a1bd6a3ee03a..ae937d1708b2 100644
--- a/arch/loongarch/include/asm/linkage.h
+++ b/arch/loongarch/include/asm/linkage.h
@@ -69,7 +69,7 @@
 		  9,  10, 11, 12, 13, 14, 15, 16,	\
 		  17, 18, 19, 20, 21, 22, 23, 24,	\
 		  25, 26, 27, 28, 29, 30, 31;		\
-	.cfi_offset \num, SC_REGS + \num * SZREG;	\
+	.cfi_offset \num, SC_REGS + \num * 8;		\
 	.endr;						\
 							\
 	nop;						\
diff --git a/arch/loongarch/kvm/Makefile b/arch/loongarch/kvm/Makefile
index cb41d9265662..f32a170c1838 100644
--- a/arch/loongarch/kvm/Makefile
+++ b/arch/loongarch/kvm/Makefile
@@ -7,11 +7,12 @@ include $(srctree)/virt/kvm/Makefile.kvm
 
 obj-$(CONFIG_KVM) += kvm.o
 
+obj-y += switch.o
+
 kvm-y += exit.o
 kvm-y += interrupt.o
 kvm-y += main.o
 kvm-y += mmu.o
-kvm-y += switch.o
 kvm-y += timer.o
 kvm-y += tlb.o
 kvm-y += vcpu.o
diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
index da0ad89f2eb7..3b95cd0f989b 100644
--- a/arch/loongarch/kvm/exit.c
+++ b/arch/loongarch/kvm/exit.c
@@ -390,6 +390,7 @@ int kvm_emu_mmio_read(struct kvm_vcpu *vcpu, larch_inst inst)
 			run->mmio.len = 8;
 			break;
 		default:
+			ret = EMULATE_FAIL;
 			break;
 		}
 		break;
diff --git a/arch/loongarch/kvm/interrupt.c b/arch/loongarch/kvm/interrupt.c
index fb704f4c8ac5..656092e19062 100644
--- a/arch/loongarch/kvm/interrupt.c
+++ b/arch/loongarch/kvm/interrupt.c
@@ -27,6 +27,7 @@ static unsigned int priority_to_irq[EXCCODE_INT_NUM] = {
 static int kvm_irq_deliver(struct kvm_vcpu *vcpu, unsigned int priority)
 {
 	unsigned int irq = 0;
+	unsigned long old, new;
 
 	clear_bit(priority, &vcpu->arch.irq_pending);
 	if (priority < EXCCODE_INT_NUM)
@@ -42,7 +43,13 @@ static int kvm_irq_deliver(struct kvm_vcpu *vcpu, unsigned int priority)
 	case INT_IPI:
 	case INT_SWI0:
 	case INT_SWI1:
+		old = kvm_read_hw_gcsr(LOONGARCH_CSR_TVAL);
 		set_gcsr_estat(irq);
+		new = kvm_read_hw_gcsr(LOONGARCH_CSR_TVAL);
+
+		/* Inject TI if TVAL inverted */
+		if (new > old)
+			set_gcsr_estat(CPU_TIMER);
 		break;
 
 	case INT_HWI0 ... INT_HWI7:
@@ -59,6 +66,7 @@ static int kvm_irq_deliver(struct kvm_vcpu *vcpu, unsigned int priority)
 static int kvm_irq_clear(struct kvm_vcpu *vcpu, unsigned int priority)
 {
 	unsigned int irq = 0;
+	unsigned long old, new;
 
 	clear_bit(priority, &vcpu->arch.irq_clear);
 	if (priority < EXCCODE_INT_NUM)
@@ -74,7 +82,13 @@ static int kvm_irq_clear(struct kvm_vcpu *vcpu, unsigned int priority)
 	case INT_IPI:
 	case INT_SWI0:
 	case INT_SWI1:
+		old = kvm_read_hw_gcsr(LOONGARCH_CSR_TVAL);
 		clear_gcsr_estat(irq);
+		new = kvm_read_hw_gcsr(LOONGARCH_CSR_TVAL);
+
+		/* Inject TI if TVAL inverted */
+		if (new > old)
+			set_gcsr_estat(CPU_TIMER);
 		break;
 
 	case INT_HWI0 ... INT_HWI7:
diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
index 2c593ac7892f..18800a38b150 100644
--- a/arch/loongarch/kvm/main.c
+++ b/arch/loongarch/kvm/main.c
@@ -348,8 +348,7 @@ void kvm_arch_disable_virtualization_cpu(void)
 
 static int kvm_loongarch_env_init(void)
 {
-	int cpu, order, ret;
-	void *addr;
+	int cpu, ret;
 	struct kvm_context *context;
 
 	vmcs = alloc_percpu(struct kvm_context);
@@ -365,30 +364,8 @@ static int kvm_loongarch_env_init(void)
 		return -ENOMEM;
 	}
 
-	/*
-	 * PGD register is shared between root kernel and kvm hypervisor.
-	 * So world switch entry should be in DMW area rather than TLB area
-	 * to avoid page fault reenter.
-	 *
-	 * In future if hardware pagetable walking is supported, we won't
-	 * need to copy world switch code to DMW area.
-	 */
-	order = get_order(kvm_exception_size + kvm_enter_guest_size);
-	addr = (void *)__get_free_pages(GFP_KERNEL, order);
-	if (!addr) {
-		free_percpu(vmcs);
-		vmcs = NULL;
-		kfree(kvm_loongarch_ops);
-		kvm_loongarch_ops = NULL;
-		return -ENOMEM;
-	}
-
-	memcpy(addr, kvm_exc_entry, kvm_exception_size);
-	memcpy(addr + kvm_exception_size, kvm_enter_guest, kvm_enter_guest_size);
-	flush_icache_range((unsigned long)addr, (unsigned long)addr + kvm_exception_size + kvm_enter_guest_size);
-	kvm_loongarch_ops->exc_entry = addr;
-	kvm_loongarch_ops->enter_guest = addr + kvm_exception_size;
-	kvm_loongarch_ops->page_order = order;
+	kvm_loongarch_ops->exc_entry = (void *)kvm_exc_entry;
+	kvm_loongarch_ops->enter_guest = (void *)kvm_enter_guest;
 
 	vpid_mask = read_csr_gstat();
 	vpid_mask = (vpid_mask & CSR_GSTAT_GIDBIT) >> CSR_GSTAT_GIDBIT_SHIFT;
@@ -422,16 +399,10 @@ static int kvm_loongarch_env_init(void)
 
 static void kvm_loongarch_env_exit(void)
 {
-	unsigned long addr;
-
 	if (vmcs)
 		free_percpu(vmcs);
 
 	if (kvm_loongarch_ops) {
-		if (kvm_loongarch_ops->exc_entry) {
-			addr = (unsigned long)kvm_loongarch_ops->exc_entry;
-			free_pages(addr, kvm_loongarch_ops->page_order);
-		}
 		kfree(kvm_loongarch_ops);
 	}
 
diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
index a7fa458e3360..e104897aa532 100644
--- a/arch/loongarch/kvm/mmu.c
+++ b/arch/loongarch/kvm/mmu.c
@@ -95,7 +95,7 @@ static int kvm_flush_pte(kvm_pte_t *pte, phys_addr_t addr, kvm_ptw_ctx *ctx)
 	else
 		kvm->stat.pages--;
 
-	*pte = ctx->invalid_entry;
+	kvm_set_pte(pte, ctx->invalid_entry);
 
 	return 1;
 }
diff --git a/arch/loongarch/kvm/switch.S b/arch/loongarch/kvm/switch.S
index f1768b7a6194..936e4ae3e408 100644
--- a/arch/loongarch/kvm/switch.S
+++ b/arch/loongarch/kvm/switch.S
@@ -4,9 +4,11 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/kvm_types.h>
 #include <asm/asm.h>
 #include <asm/asmmacro.h>
 #include <asm/loongarch.h>
+#include <asm/page.h>
 #include <asm/regdef.h>
 #include <asm/unwind_hints.h>
 
@@ -100,11 +102,16 @@
 	 *  -        is still in guest mode, such as pgd table/vmid registers etc,
 	 *  -        will fix with hw page walk enabled in future
 	 * load kvm_vcpu from reserved CSR KVM_VCPU_KS, and save a2 to KVM_TEMP_KS
+	 *
+	 * PGD register is shared between root kernel and kvm hypervisor.
+	 * So world switch entry should be in DMW area rather than TLB area
+	 * to avoid page fault re-enter.
 	 */
 	.text
+	.p2align PAGE_SHIFT
 	.cfi_sections	.debug_frame
 SYM_CODE_START(kvm_exc_entry)
-	UNWIND_HINT_UNDEFINED
+	UNWIND_HINT_END_OF_STACK
 	csrwr	a2,   KVM_TEMP_KS
 	csrrd	a2,   KVM_VCPU_KS
 	addi.d	a2,   a2, KVM_VCPU_ARCH
@@ -190,8 +197,8 @@ ret_to_host:
 	kvm_restore_host_gpr    a2
 	jr      ra
 
-SYM_INNER_LABEL(kvm_exc_entry_end, SYM_L_LOCAL)
 SYM_CODE_END(kvm_exc_entry)
+EXPORT_SYMBOL_FOR_KVM(kvm_exc_entry)
 
 /*
  * int kvm_enter_guest(struct kvm_run *run, struct kvm_vcpu *vcpu)
@@ -215,8 +222,8 @@ SYM_FUNC_START(kvm_enter_guest)
 	/* Save kvm_vcpu to kscratch */
 	csrwr	a1, KVM_VCPU_KS
 	kvm_switch_to_guest
-SYM_INNER_LABEL(kvm_enter_guest_end, SYM_L_LOCAL)
 SYM_FUNC_END(kvm_enter_guest)
+EXPORT_SYMBOL_FOR_KVM(kvm_enter_guest)
 
 SYM_FUNC_START(kvm_save_fpu)
 	fpu_save_csr	a0 t1
@@ -224,6 +231,7 @@ SYM_FUNC_START(kvm_save_fpu)
 	fpu_save_cc	a0 t1 t2
 	jr              ra
 SYM_FUNC_END(kvm_save_fpu)
+EXPORT_SYMBOL_FOR_KVM(kvm_save_fpu)
 
 SYM_FUNC_START(kvm_restore_fpu)
 	fpu_restore_double a0 t1
@@ -231,6 +239,7 @@ SYM_FUNC_START(kvm_restore_fpu)
 	fpu_restore_cc	   a0 t1 t2
 	jr                 ra
 SYM_FUNC_END(kvm_restore_fpu)
+EXPORT_SYMBOL_FOR_KVM(kvm_restore_fpu)
 
 #ifdef CONFIG_CPU_HAS_LSX
 SYM_FUNC_START(kvm_save_lsx)
@@ -239,6 +248,7 @@ SYM_FUNC_START(kvm_save_lsx)
 	lsx_save_data   a0 t1
 	jr              ra
 SYM_FUNC_END(kvm_save_lsx)
+EXPORT_SYMBOL_FOR_KVM(kvm_save_lsx)
 
 SYM_FUNC_START(kvm_restore_lsx)
 	lsx_restore_data a0 t1
@@ -246,6 +256,7 @@ SYM_FUNC_START(kvm_restore_lsx)
 	fpu_restore_csr  a0 t1 t2
 	jr               ra
 SYM_FUNC_END(kvm_restore_lsx)
+EXPORT_SYMBOL_FOR_KVM(kvm_restore_lsx)
 #endif
 
 #ifdef CONFIG_CPU_HAS_LASX
@@ -255,6 +266,7 @@ SYM_FUNC_START(kvm_save_lasx)
 	lasx_save_data  a0 t1
 	jr              ra
 SYM_FUNC_END(kvm_save_lasx)
+EXPORT_SYMBOL_FOR_KVM(kvm_save_lasx)
 
 SYM_FUNC_START(kvm_restore_lasx)
 	lasx_restore_data a0 t1
@@ -262,10 +274,8 @@ SYM_FUNC_START(kvm_restore_lasx)
 	fpu_restore_csr   a0 t1 t2
 	jr                ra
 SYM_FUNC_END(kvm_restore_lasx)
+EXPORT_SYMBOL_FOR_KVM(kvm_restore_lasx)
 #endif
-	.section ".rodata"
-SYM_DATA(kvm_exception_size, .quad kvm_exc_entry_end - kvm_exc_entry)
-SYM_DATA(kvm_enter_guest_size, .quad kvm_enter_guest_end - kvm_enter_guest)
 
 #ifdef CONFIG_CPU_HAS_LBT
 STACK_FRAME_NON_STANDARD kvm_restore_fpu
diff --git a/arch/loongarch/kvm/timer.c b/arch/loongarch/kvm/timer.c
index 29c2aaba63c3..8356fce0043f 100644
--- a/arch/loongarch/kvm/timer.c
+++ b/arch/loongarch/kvm/timer.c
@@ -96,15 +96,21 @@ void kvm_restore_timer(struct kvm_vcpu *vcpu)
 		 * and set CSR TVAL with -1
 		 */
 		write_gcsr_timertick(0);
-		__delay(2); /* Wait cycles until timer interrupt injected */
 
 		/*
 		 * Writing CSR_TINTCLR_TI to LOONGARCH_CSR_TINTCLR will clear
 		 * timer interrupt, and CSR TVAL keeps unchanged with -1, it
 		 * avoids spurious timer interrupt
 		 */
-		if (!(estat & CPU_TIMER))
+		if (!(estat & CPU_TIMER)) {
+			__delay(2); /* Wait cycles until timer interrupt injected */
+
+			/* Write TVAL with max value if no TI shot */
+			estat = kvm_read_hw_gcsr(LOONGARCH_CSR_ESTAT);
+			if (!(estat & CPU_TIMER))
+				write_gcsr_timertick(CSR_TCFG_VAL);
 			gcsr_write(CSR_TINTCLR_TI, LOONGARCH_CSR_TINTCLR);
+		}
 		return;
 	}
 
diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
index 8cc5ee1c53ef..1317c718f896 100644
--- a/arch/loongarch/kvm/vm.c
+++ b/arch/loongarch/kvm/vm.c
@@ -125,7 +125,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = 1;
 		break;
 	case KVM_CAP_NR_VCPUS:
-		r = num_online_cpus();
+		r = min_t(unsigned int, num_online_cpus(), KVM_MAX_VCPUS);
 		break;
 	case KVM_CAP_MAX_VCPUS:
 		r = KVM_MAX_VCPUS;
diff --git a/arch/loongarch/pci/acpi.c b/arch/loongarch/pci/acpi.c
index 0dde3ddcd544..b02698a338ee 100644
--- a/arch/loongarch/pci/acpi.c
+++ b/arch/loongarch/pci/acpi.c
@@ -61,11 +61,16 @@ static void acpi_release_root_info(struct acpi_pci_root_info *ci)
 static int acpi_prepare_root_resources(struct acpi_pci_root_info *ci)
 {
 	int status;
+	unsigned long long pci_h = 0;
 	struct resource_entry *entry, *tmp;
 	struct acpi_device *device = ci->bridge;
 
 	status = acpi_pci_probe_root_resources(ci);
 	if (status > 0) {
+		acpi_evaluate_integer(device->handle, "PCIH", NULL, &pci_h);
+		if (pci_h)
+			return status;
+
 		resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
 			if (entry->res->flags & IORESOURCE_MEM) {
 				entry->offset = ci->root->mcfg_addr & GENMASK_ULL(63, 40);
diff --git a/arch/loongarch/pci/pci.c b/arch/loongarch/pci/pci.c
index d233ea2218fe..f33c7ea1443d 100644
--- a/arch/loongarch/pci/pci.c
+++ b/arch/loongarch/pci/pci.c
@@ -132,6 +132,9 @@ static void loongson_gpu_fixup_dma_hang(struct pci_dev *pdev, bool on)
 		crtc_reg = regbase;
 		crtc_offset = 0x400;
 		break;
+	default:
+		iounmap(regbase);
+		return;
 	}
 
 	for (i = 0; i < CRTC_NUM_MAX; i++, crtc_reg += crtc_offset) {
diff --git a/arch/powerpc/kexec/Makefile b/arch/powerpc/kexec/Makefile
index 470eb0453e17..ec7a0eed75dc 100644
--- a/arch/powerpc/kexec/Makefile
+++ b/arch/powerpc/kexec/Makefile
@@ -16,4 +16,4 @@ GCOV_PROFILE_core_$(BITS).o := n
 KCOV_INSTRUMENT_core_$(BITS).o := n
 UBSAN_SANITIZE_core_$(BITS).o := n
 KASAN_SANITIZE_core.o := n
-KASAN_SANITIZE_core_$(BITS) := n
+KASAN_SANITIZE_core_$(BITS).o := n
diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index 14ae480d060a..c007560d2d8c 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -206,10 +206,11 @@ static int hvpipe_rtas_recv_msg(char __user *buf, int size)
 					bytes_written, size);
 				bytes_written = size;
 			}
-			ret = copy_to_user(buf,
+			if (copy_to_user(buf,
 					rtas_work_area_raw_buf(work_area),
-					bytes_written);
-			if (!ret)
+					bytes_written))
+				ret = -EFAULT;
+			else
 				ret = bytes_written;
 		}
 	} else {
@@ -327,8 +328,8 @@ static ssize_t papr_hvpipe_handle_read(struct file *file,
 {
 
 	struct hvpipe_source_info *src_info = file->private_data;
-	struct papr_hvpipe_hdr hdr;
-	long ret;
+	struct papr_hvpipe_hdr hdr = {};
+	ssize_t ret = 0;
 
 	/*
 	 * Return -ENXIO during migration
@@ -376,7 +377,7 @@ static ssize_t papr_hvpipe_handle_read(struct file *file,
 
 	ret = copy_to_user(buf, &hdr, HVPIPE_HDR_LEN);
 	if (ret)
-		return ret;
+		return -EFAULT;
 
 	/*
 	 * Message event has payload, so get the payload with
@@ -385,19 +386,23 @@ static ssize_t papr_hvpipe_handle_read(struct file *file,
 	if (hdr.flags & HVPIPE_MSG_AVAILABLE) {
 		ret = hvpipe_rtas_recv_msg(buf + HVPIPE_HDR_LEN,
 				size - HVPIPE_HDR_LEN);
-		if (ret > 0) {
+		/*
+		 * Always clear MSG_AVAILABLE once the RTAS call has drained
+		 * the message, regardless of whether copy_to_user succeeded.
+		 */
+		if (ret >= 0 || ret == -EFAULT)
 			src_info->hvpipe_status &= ~HVPIPE_MSG_AVAILABLE;
-			ret += HVPIPE_HDR_LEN;
-		}
 	} else if (hdr.flags & HVPIPE_LOST_CONNECTION) {
 		/*
 		 * Hypervisor is closing the pipe for the specific
 		 * source. So notify user space.
 		 */
 		src_info->hvpipe_status &= ~HVPIPE_LOST_CONNECTION;
-		ret = HVPIPE_HDR_LEN;
 	}
 
+	if (ret >= 0)
+		ret += HVPIPE_HDR_LEN;
+
 	return ret;
 }
 
@@ -444,13 +449,14 @@ static int papr_hvpipe_handle_release(struct inode *inode,
 				struct file *file)
 {
 	struct hvpipe_source_info *src_info;
+	unsigned long flags;
 
 	/*
 	 * Hold the lock, remove source from src_list, reset the
 	 * hvpipe status and release the lock to prevent any race
 	 * with message event IRQ.
 	 */
-	spin_lock(&hvpipe_src_list_lock);
+	spin_lock_irqsave(&hvpipe_src_list_lock, flags);
 	src_info = file->private_data;
 	list_del(&src_info->list);
 	file->private_data = NULL;
@@ -461,10 +467,10 @@ static int papr_hvpipe_handle_release(struct inode *inode,
 	 */
 	if (src_info->hvpipe_status & HVPIPE_MSG_AVAILABLE) {
 		src_info->hvpipe_status = 0;
-		spin_unlock(&hvpipe_src_list_lock);
+		spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
 		hvpipe_rtas_recv_msg(NULL, 0);
 	} else
-		spin_unlock(&hvpipe_src_list_lock);
+		spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
 
 	kfree(src_info);
 	return 0;
@@ -479,21 +485,9 @@ static const struct file_operations papr_hvpipe_handle_ops = {
 
 static int papr_hvpipe_dev_create_handle(u32 srcID)
 {
-	struct hvpipe_source_info *src_info __free(kfree) = NULL;
-
-	spin_lock(&hvpipe_src_list_lock);
-	/*
-	 * Do not allow more than one process communicates with
-	 * each source.
-	 */
-	src_info = hvpipe_find_source(srcID);
-	if (src_info) {
-		spin_unlock(&hvpipe_src_list_lock);
-		pr_err("pid(%d) is already using the source(%d)\n",
-				src_info->tsk->pid, srcID);
-		return -EALREADY;
-	}
-	spin_unlock(&hvpipe_src_list_lock);
+	struct hvpipe_source_info *src_info;
+	int fd;
+	unsigned long flags;
 
 	src_info = kzalloc_obj(*src_info, GFP_KERNEL_ACCOUNT);
 	if (!src_info)
@@ -503,26 +497,42 @@ static int papr_hvpipe_dev_create_handle(u32 srcID)
 	src_info->tsk = current;
 	init_waitqueue_head(&src_info->recv_wqh);
 
-	FD_PREPARE(fdf, O_RDONLY | O_CLOEXEC,
-		   anon_inode_getfile("[papr-hvpipe]", &papr_hvpipe_handle_ops,
-				      (void *)src_info, O_RDWR));
-	if (fdf.err)
-		return fdf.err;
-
-	retain_and_null_ptr(src_info);
-	spin_lock(&hvpipe_src_list_lock);
 	/*
-	 * If two processes are executing ioctl() for the same
-	 * source ID concurrently, prevent the second process to
-	 * acquire FD.
+	 * Do not allow more than one process communicates with
+	 * each source.
 	 */
+	spin_lock_irqsave(&hvpipe_src_list_lock, flags);
 	if (hvpipe_find_source(srcID)) {
-		spin_unlock(&hvpipe_src_list_lock);
+		spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
+		pr_err("pid(%d) could not get the source(%d)\n",
+				src_info->tsk->pid, srcID);
+		kfree(src_info);
 		return -EALREADY;
 	}
 	list_add(&src_info->list, &hvpipe_src_list);
-	spin_unlock(&hvpipe_src_list_lock);
-	return fd_publish(fdf);
+	spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
+
+	fd = FD_ADD(O_RDONLY | O_CLOEXEC,
+		   anon_inode_getfile("[papr-hvpipe]", &papr_hvpipe_handle_ops,
+				      (void *)src_info, O_RDWR));
+	if (fd < 0) {
+		spin_lock_irqsave(&hvpipe_src_list_lock, flags);
+		list_del(&src_info->list);
+		spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
+		/*
+		 * if we fail to add FD, that means no userspace program is
+		 * polling. In that case if there is a msg pending because the
+		 * interrupt was fired after the src_info was added to the
+		 * global list, then let's consume it here, to unblock the
+		 * hvpipe
+		 */
+		if (src_info->hvpipe_status & HVPIPE_MSG_AVAILABLE)
+			hvpipe_rtas_recv_msg(NULL, 0);
+		kfree(src_info);
+		return fd;
+	}
+
+	return fd;
 }
 
 /*
@@ -775,23 +785,29 @@ static int __init papr_hvpipe_init(void)
 	}
 
 	ret = enable_hvpipe_IRQ();
-	if (!ret) {
-		ret = set_hvpipe_sys_param(1);
-		if (!ret)
-			ret = misc_register(&papr_hvpipe_dev);
-	}
+	if (ret)
+		goto out_wq;
 
-	if (!ret) {
-		pr_info("hvpipe feature is enabled\n");
-		hvpipe_feature = true;
-		return 0;
-	}
+	ret = misc_register(&papr_hvpipe_dev);
+	if (ret)
+		goto out_wq;
 
-	pr_err("hvpipe feature is not enabled %d\n", ret);
+	ret = set_hvpipe_sys_param(1);
+	if (ret)
+		goto out_misc;
+
+	pr_info("hvpipe feature is enabled\n");
+	hvpipe_feature = true;
+	return 0;
+
+out_misc:
+	misc_deregister(&papr_hvpipe_dev);
+out_wq:
 	destroy_workqueue(papr_hvpipe_wq);
 out:
 	kfree(papr_hvpipe_work);
 	papr_hvpipe_work = NULL;
+	pr_err("hvpipe feature is not enabled %d\n", ret);
 	return ret;
 }
 machine_device_initcall(pseries, papr_hvpipe_init);
diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index e1a4f8a97393..6b1b7541ca31 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -1038,13 +1038,19 @@ static struct xive_irq_data *xive_irq_alloc_data(unsigned int virq, irq_hw_numbe
 	return xd;
 }
 
-static void xive_irq_free_data(unsigned int virq)
+static void xive_irq_free_data(struct irq_domain *domain, unsigned int virq)
 {
-	struct xive_irq_data *xd = irq_get_chip_data(virq);
+	struct xive_irq_data *xd;
+	struct irq_data *data = irq_domain_get_irq_data(domain, virq);
+
+	if (!data)
+		return;
 
+	xd = irq_data_get_irq_chip_data(data);
 	if (!xd)
 		return;
-	irq_set_chip_data(virq, NULL);
+
+	irq_domain_reset_irq_data(data);
 	xive_cleanup_irq_data(xd);
 	kfree(xd);
 }
@@ -1305,7 +1311,7 @@ static int xive_irq_domain_map(struct irq_domain *h, unsigned int virq,
 
 static void xive_irq_domain_unmap(struct irq_domain *d, unsigned int virq)
 {
-	xive_irq_free_data(virq);
+	xive_irq_free_data(d, virq);
 }
 
 static int xive_irq_domain_xlate(struct irq_domain *h, struct device_node *ct,
@@ -1443,7 +1449,7 @@ static void xive_irq_domain_free(struct irq_domain *domain,
 	pr_debug("%s %d #%d\n", __func__, virq, nr_irqs);
 
 	for (i = 0; i < nr_irqs; i++)
-		xive_irq_free_data(virq + i);
+		xive_irq_free_data(domain, virq + i);
 }
 #endif
 
diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
index 05f3cc2d8e31..5b6ad82d47be 100644
--- a/arch/riscv/kvm/vcpu_vector.c
+++ b/arch/riscv/kvm/vcpu_vector.c
@@ -80,8 +80,11 @@ int kvm_riscv_vcpu_alloc_vector_context(struct kvm_vcpu *vcpu)
 		return -ENOMEM;
 
 	vcpu->arch.host_context.vector.datap = kzalloc(riscv_v_vsize, GFP_KERNEL);
-	if (!vcpu->arch.host_context.vector.datap)
+	if (!vcpu->arch.host_context.vector.datap) {
+		kfree(vcpu->arch.guest_context.vector.datap);
+		vcpu->arch.guest_context.vector.datap = NULL;
 		return -ENOMEM;
+	}
 
 	return 0;
 }
diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index 31430e9bcfdd..7650f2adb5cf 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -1414,6 +1414,9 @@ static inline char *debug_get_user_string(const char __user *user_buf,
 {
 	char *buffer;
 
+	if (!user_len)
+		return ERR_PTR(-EINVAL);
+
 	buffer = memdup_user_nul(user_buf, user_len);
 	if (IS_ERR(buffer))
 		return buffer;
@@ -1584,6 +1587,11 @@ static int debug_input_flush_fn(debug_info_t *id, struct debug_view *view,
 	char input_buf[1];
 	int rc = user_len;
 
+	if (!user_len) {
+		rc = -EINVAL;
+		goto out;
+	}
+
 	if (user_len > 0x10000)
 		user_len = 0x10000;
 	if (*offset != 0) {
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 810ab21ffd99..4b9e105309c6 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1294,13 +1294,16 @@ int x86_perf_rdpmc_index(struct perf_event *event)
 	return event->hw.event_base_rdpmc;
 }
 
-static inline int match_prev_assignment(struct hw_perf_event *hwc,
+static inline int match_prev_assignment(struct perf_event *event,
 					struct cpu_hw_events *cpuc,
 					int i)
 {
+	struct hw_perf_event *hwc = &event->hw;
+
 	return hwc->idx == cpuc->assign[i] &&
-		hwc->last_cpu == smp_processor_id() &&
-		hwc->last_tag == cpuc->tags[i];
+	       hwc->last_cpu == smp_processor_id() &&
+	       hwc->last_tag == cpuc->tags[i] &&
+	       !is_acr_event_group(event);
 }
 
 static void x86_pmu_start(struct perf_event *event, int flags);
@@ -1346,7 +1349,7 @@ static void x86_pmu_enable(struct pmu *pmu)
 			 * - no other event has used the counter since
 			 */
 			if (hwc->idx == -1 ||
-			    match_prev_assignment(hwc, cpuc, i))
+			    match_prev_assignment(event, cpuc, i))
 				continue;
 
 			/*
@@ -1367,7 +1370,7 @@ static void x86_pmu_enable(struct pmu *pmu)
 			event = cpuc->event_list[i];
 			hwc = &event->hw;
 
-			if (!match_prev_assignment(hwc, cpuc, i))
+			if (!match_prev_assignment(event, cpuc, i))
 				x86_assign_hw_event(event, cpuc, i);
 			else if (i < n_running)
 				continue;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 793335c3ce78..d8ac015f5fdb 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3118,11 +3118,11 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
 	intel_set_masks(event, idx);
 
 	/*
-	 * Enable IRQ generation (0x8), if not PEBS,
-	 * and enable ring-3 counting (0x2) and ring-0 counting (0x1)
-	 * if requested:
+	 * Enable IRQ generation (0x8), if not PEBS or self-reloaded
+	 * ACR event, and enable ring-3 counting (0x2) and ring-0
+	 * counting (0x1) if requested:
 	 */
-	if (!event->attr.precise_ip)
+	if (!event->attr.precise_ip && !is_acr_self_reload_event(event))
 		bits |= INTEL_FIXED_0_ENABLE_PMI;
 	if (hwc->config & ARCH_PERFMON_EVENTSEL_USR)
 		bits |= INTEL_FIXED_0_USER;
@@ -3306,6 +3306,15 @@ static void intel_pmu_enable_event(struct perf_event *event)
 		intel_set_masks(event, idx);
 		static_call_cond(intel_pmu_enable_acr_event)(event);
 		static_call_cond(intel_pmu_enable_event_ext)(event);
+		/*
+		 * For self-reloaded ACR event, don't enable PMI since
+		 * HW won't set overflow bit in GLOBAL_STATUS. Otherwise,
+		 * the PMI would be recognized as a suspicious NMI.
+		 */
+		if (is_acr_self_reload_event(event))
+			hwc->config &= ~ARCH_PERFMON_EVENTSEL_INT;
+		else if (!event->attr.precise_ip)
+			hwc->config |= ARCH_PERFMON_EVENTSEL_INT;
 		__x86_pmu_enable_event(hwc, enable_mask);
 		break;
 	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS - 1:
@@ -3332,23 +3341,41 @@ static void intel_pmu_enable_event(struct perf_event *event)
 static void intel_pmu_acr_late_setup(struct cpu_hw_events *cpuc)
 {
 	struct perf_event *event, *leader;
-	int i, j, idx;
+	int i, j, k, bit, idx;
 
+	/*
+	 * FIXME: ACR mask parsing relies on cpuc->event_list[] (active events only).
+	 * Disabling an ACR event causes bit-shifting errors in the acr_mask of
+	 * remaining group members. As ACR sampling requires all events to be active,
+	 * this limitation is acceptable for now. Revisit if independent event toggling
+	 * is required.
+	 */
 	for (i = 0; i < cpuc->n_events; i++) {
 		leader = cpuc->event_list[i];
 		if (!is_acr_event_group(leader))
 			continue;
 
-		/* The ACR events must be contiguous. */
+		/* Find the last event of the ACR group. */
 		for (j = i; j < cpuc->n_events; j++) {
 			event = cpuc->event_list[j];
 			if (event->group_leader != leader->group_leader)
 				break;
-			for_each_set_bit(idx, (unsigned long *)&event->attr.config2, X86_PMC_IDX_MAX) {
-				if (i + idx >= cpuc->n_events ||
-				    !is_acr_event_group(cpuc->event_list[i + idx]))
-					return;
-				__set_bit(cpuc->assign[i + idx], (unsigned long *)&event->hw.config1);
+		}
+
+		/*
+		 * Translate the user-space ACR mask (attr.config2) into the physical
+		 * counter bitmask (hw.config1) for each ACR event in the group.
+		 * NOTE: ACR event contiguity is guaranteed by intel_pmu_hw_config().
+		 */
+		for (k = i; k < j; k++) {
+			event = cpuc->event_list[k];
+			event->hw.config1 = 0;
+			for_each_set_bit(bit, (unsigned long *)&event->attr.config2, X86_PMC_IDX_MAX) {
+				idx = i + bit;
+				/* Event index of ACR group must locate in [i, j). */
+				if (idx >= j || !is_acr_event_group(cpuc->event_list[idx]))
+					continue;
+				__set_bit(cpuc->assign[idx], (unsigned long *)&event->hw.config1);
 			}
 		}
 		i = j - 1;
@@ -7498,6 +7525,7 @@ static __always_inline void intel_pmu_init_pnc(struct pmu *pmu)
 	hybrid(pmu, event_constraints) = intel_pnc_event_constraints;
 	hybrid(pmu, pebs_constraints) = intel_pnc_pebs_event_constraints;
 	hybrid(pmu, extra_regs) = intel_pnc_extra_regs;
+	static_call_update(intel_pmu_enable_acr_event, intel_pmu_enable_acr);
 }
 
 static __always_inline void intel_pmu_init_skt(struct pmu *pmu)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index fad87d3c8b2c..524668dcf4cc 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -137,6 +137,16 @@ static inline bool is_acr_event_group(struct perf_event *event)
 	return check_leader_group(event->group_leader, PERF_X86_EVENT_ACR);
 }
 
+static inline bool is_acr_self_reload_event(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (hwc->idx < 0)
+		return false;
+
+	return test_bit(hwc->idx, (unsigned long *)&hwc->config1);
+}
+
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
 	int refcnt; /* reference count */
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 51b4cdbea061..f5932705f4b0 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -137,7 +137,8 @@ extern void __init efi_dump_pagetable(void);
 extern void __init efi_apply_memmap_quirks(void);
 extern int __init efi_reuse_config(u64 tables, int nr_tables);
 extern void efi_delete_dummy_variable(void);
-extern void efi_crash_gracefully_on_page_fault(unsigned long phys_addr);
+extern void efi_crash_gracefully_on_page_fault(unsigned long phys_addr,
+					       const struct pt_regs *regs);
 extern void efi_unmap_boot_services(void);
 
 void arch_efi_call_virt_setup(void);
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 92bb6b2f778e..4efbbf9d117b 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -796,9 +796,10 @@
 #define MSR_AMD64_LBR_SELECT			0xc000010e
 
 /* Zen4 */
-#define MSR_ZEN4_BP_CFG                 0xc001102e
+#define MSR_ZEN4_BP_CFG			0xc001102e
 #define MSR_ZEN4_BP_CFG_BP_SPEC_REDUCE_BIT 4
 #define MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT 5
+#define MSR_ZEN2_BP_CFG_BUG_FIX_BIT	33
 
 /* Fam 19h MSRs */
 #define MSR_F19H_UMC_PERF_CTL           0xc0010800
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 9b9bf7df7aad..820fee2658c6 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -988,6 +988,9 @@ static void init_amd_zen2(struct cpuinfo_x86 *c)
 
 	/* Correct misconfigured CPUID on some clients. */
 	clear_cpu_cap(c, X86_FEATURE_INVLPGB);
+
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR))
+		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN2_BP_CFG_BUG_FIX_BIT);
 }
 
 static void init_amd_zen3(struct cpuinfo_x86 *c)
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 2a9992758933..eb72537bc0b1 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -450,6 +450,10 @@ __init static int append_e820_table(struct boot_e820_entry *entries, u32 nr_entr
 {
 	struct boot_e820_entry *entry = entries;
 
+	/* If there aren't any entries, we'll want to fall back to another source: */
+	if (!nr_entries)
+		return -ENOENT;
+
 	while (nr_entries) {
 		u64 start = entry->addr;
 		u64 size  = entry->size;
@@ -458,7 +462,7 @@ __init static int append_e820_table(struct boot_e820_entry *entries, u32 nr_entr
 
 		/* Ignore the remaining entries on 64-bit overflow: */
 		if (start > end && likely(size))
-			return -1;
+			return -EINVAL;
 
 		e820__range_add(start, size, type);
 
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 9b140bbdc1d8..4438ecac9a89 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2040,7 +2040,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	 * flush).  Translate the address here so the memory can be uniformly
 	 * read with kvm_read_guest().
 	 */
-	if (!hc->fast && is_guest_mode(vcpu)) {
+	if (!hc->fast && mmu_is_nested(vcpu)) {
 		hc->ingpa = translate_nested_gpa(vcpu, hc->ingpa, 0, NULL);
 		if (unlikely(hc->ingpa == INVALID_GPA))
 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 9381c58d4c85..e9f1e5451160 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -669,12 +669,14 @@ bool __kvm_apic_update_irr(unsigned long *pir, void *regs, int *max_irr)
 	u32 irr_val, prev_irr_val;
 	int max_updated_irr;
 
+	if (!pi_harvest_pir(pir, pir_vals)) {
+		*max_irr = apic_find_highest_vector(regs + APIC_IRR);
+		return false;
+	}
+
 	max_updated_irr = -1;
 	*max_irr = -1;
 
-	if (!pi_harvest_pir(pir, pir_vals))
-		return false;
-
 	for (i = vec = 0; i <= 7; i++, vec += 32) {
 		u32 *p_irr = (u32 *)(regs + APIC_IRR + i * 0x10);
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index dd06453d5b72..729240bc00a2 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -182,6 +182,8 @@ static struct kmem_cache *pte_list_desc_cache;
 struct kmem_cache *mmu_page_header_cache;
 
 static void mmu_spte_set(u64 *sptep, u64 spte);
+static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
+			    u64 *spte, struct list_head *invalid_list);
 
 struct kvm_mmu_role_regs {
 	const unsigned long cr0;
@@ -1287,19 +1289,6 @@ static void drop_spte(struct kvm *kvm, u64 *sptep)
 		rmap_remove(kvm, sptep);
 }
 
-static void drop_large_spte(struct kvm *kvm, u64 *sptep, bool flush)
-{
-	struct kvm_mmu_page *sp;
-
-	sp = sptep_to_sp(sptep);
-	WARN_ON_ONCE(sp->role.level == PG_LEVEL_4K);
-
-	drop_spte(kvm, sptep);
-
-	if (flush)
-		kvm_flush_remote_tlbs_sptep(kvm, sptep);
-}
-
 /*
  * Write-protect on the specified @sptep, @pt_protect indicates whether
  * spte write-protection is caused by protecting shadow page table.
@@ -2466,7 +2455,8 @@ static struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu,
 {
 	union kvm_mmu_page_role role;
 
-	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep))
+	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep) &&
+	    spte_to_child_sp(*sptep) && spte_to_child_sp(*sptep)->gfn == gfn)
 		return ERR_PTR(-EEXIST);
 
 	role = kvm_mmu_child_role(sptep, direct, access);
@@ -2544,13 +2534,16 @@ static void __link_shadow_page(struct kvm *kvm,
 
 	BUILD_BUG_ON(VMX_EPT_WRITABLE_MASK != PT_WRITABLE_MASK);
 
-	/*
-	 * If an SPTE is present already, it must be a leaf and therefore
-	 * a large one.  Drop it, and flush the TLB if needed, before
-	 * installing sp.
-	 */
-	if (is_shadow_present_pte(*sptep))
-		drop_large_spte(kvm, sptep, flush);
+	if (is_shadow_present_pte(*sptep)) {
+		struct kvm_mmu_page *parent_sp;
+		LIST_HEAD(invalid_list);
+
+		parent_sp = sptep_to_sp(sptep);
+		WARN_ON_ONCE(parent_sp->role.level == PG_LEVEL_4K);
+
+		mmu_page_zap_pte(kvm, parent_sp, sptep, &invalid_list);
+		kvm_mmu_remote_flush_or_zap(kvm, &invalid_list, true);
+	}
 
 	spte = make_nonleaf_spte(sp->spt, sp_ad_disabled(sp));
 
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index b83a06739b51..b33a52a3c515 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -686,7 +686,7 @@ page_fault_oops(struct pt_regs *regs, unsigned long error_code,
 	 * avoid hanging the system.
 	 */
 	if (IS_ENABLED(CONFIG_EFI))
-		efi_crash_gracefully_on_page_fault(address);
+		efi_crash_gracefully_on_page_fault(address, regs);
 
 	/* Only not-present faults should be handled by KFENCE. */
 	if (!(error_code & X86_PF_PROT) &&
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 79f0818131e8..1f234c33c85a 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -761,7 +761,8 @@ int efi_capsule_setup_info(struct capsule_info *cap_info, void *kbuff,
  * @return: Returns, if the page fault is not handled. This function
  * will never return if the page fault is handled successfully.
  */
-void efi_crash_gracefully_on_page_fault(unsigned long phys_addr)
+void efi_crash_gracefully_on_page_fault(unsigned long phys_addr,
+					const struct pt_regs *regs)
 {
 	if (!IS_ENABLED(CONFIG_X86_64))
 		return;
@@ -770,7 +771,7 @@ void efi_crash_gracefully_on_page_fault(unsigned long phys_addr)
 	 * If we get an interrupt/NMI while processing an EFI runtime service
 	 * then this is a regular OOPS, not an EFI failure.
 	 */
-	if (in_interrupt())
+	if (!in_task())
 		return;
 
 	/*
@@ -810,6 +811,14 @@ void efi_crash_gracefully_on_page_fault(unsigned long phys_addr)
 		return;
 	}
 
+	/*
+	 * The API does not permit entering a kernel mode FPU section with
+	 * interrupts enabled and leaving it with interrupts disabled.  So
+	 * re-enable interrupts now if they were enabled when the page fault
+	 * occurred.
+	 */
+	local_irq_restore(regs->flags);
+
 	/*
 	 * Before calling EFI Runtime Service, the kernel has switched the
 	 * calling process to efi_mm. Hence, switch back to task_mm.
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index fd0d0e7fcb8a..7aae3c236cad 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -99,17 +99,17 @@ static inline unsigned int disk_zone_wplugs_hash_size(struct gendisk *disk)
  *    being executed or the zone write plug bio list is not empty.
  *  - BLK_ZONE_WPLUG_NEED_WP_UPDATE: Indicates that we lost track of a zone
  *    write pointer offset and need to update it.
- *  - BLK_ZONE_WPLUG_UNHASHED: Indicates that the zone write plug was removed
- *    from the disk hash table and that the initial reference to the zone
- *    write plug set when the plug was first added to the hash table has been
- *    dropped. This flag is set when a zone is reset, finished or become full,
- *    to prevent new references to the zone write plug to be taken for
- *    newly incoming BIOs. A zone write plug flagged with this flag will be
- *    freed once all remaining references from BIOs or functions are dropped.
+ *  - BLK_ZONE_WPLUG_DEAD: Indicates that the zone write plug will be
+ *    removed from the disk hash table of zone write plugs when the last
+ *    reference on the zone write plug is dropped. If set, this flag also
+ *    indicates that the initial extra reference on the zone write plug was
+ *    dropped, meaning that the reference count indicates the current number of
+ *    active users (code context or BIOs and requests in flight). This flag is
+ *    set when a zone is reset, finished or becomes full.
  */
 #define BLK_ZONE_WPLUG_PLUGGED		(1U << 0)
 #define BLK_ZONE_WPLUG_NEED_WP_UPDATE	(1U << 1)
-#define BLK_ZONE_WPLUG_UNHASHED		(1U << 2)
+#define BLK_ZONE_WPLUG_DEAD		(1U << 2)
 
 /**
  * blk_zone_cond_str - Return a zone condition name string
@@ -587,64 +587,15 @@ static void disk_free_zone_wplug_rcu(struct rcu_head *rcu_head)
 	mempool_free(zwplug, zwplug->disk->zone_wplugs_pool);
 }
 
-static inline void disk_put_zone_wplug(struct blk_zone_wplug *zwplug)
-{
-	if (refcount_dec_and_test(&zwplug->ref)) {
-		WARN_ON_ONCE(!bio_list_empty(&zwplug->bio_list));
-		WARN_ON_ONCE(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED);
-		WARN_ON_ONCE(!(zwplug->flags & BLK_ZONE_WPLUG_UNHASHED));
-
-		call_rcu(&zwplug->rcu_head, disk_free_zone_wplug_rcu);
-	}
-}
-
-static inline bool disk_should_remove_zone_wplug(struct gendisk *disk,
-						 struct blk_zone_wplug *zwplug)
-{
-	lockdep_assert_held(&zwplug->lock);
-
-	/* If the zone write plug was already removed, we are done. */
-	if (zwplug->flags & BLK_ZONE_WPLUG_UNHASHED)
-		return false;
-
-	/* If the zone write plug is still plugged, it cannot be removed. */
-	if (zwplug->flags & BLK_ZONE_WPLUG_PLUGGED)
-		return false;
-
-	/*
-	 * Completions of BIOs with blk_zone_write_plug_bio_endio() may
-	 * happen after handling a request completion with
-	 * blk_zone_write_plug_finish_request() (e.g. with split BIOs
-	 * that are chained). In such case, disk_zone_wplug_unplug_bio()
-	 * should not attempt to remove the zone write plug until all BIO
-	 * completions are seen. Check by looking at the zone write plug
-	 * reference count, which is 2 when the plug is unused (one reference
-	 * taken when the plug was allocated and another reference taken by the
-	 * caller context).
-	 */
-	if (refcount_read(&zwplug->ref) > 2)
-		return false;
-
-	/* We can remove zone write plugs for zones that are empty or full. */
-	return !zwplug->wp_offset || disk_zone_wplug_is_full(disk, zwplug);
-}
-
-static void disk_remove_zone_wplug(struct gendisk *disk,
-				   struct blk_zone_wplug *zwplug)
+static void disk_free_zone_wplug(struct blk_zone_wplug *zwplug)
 {
+	struct gendisk *disk = zwplug->disk;
 	unsigned long flags;
 
-	/* If the zone write plug was already removed, we have nothing to do. */
-	if (zwplug->flags & BLK_ZONE_WPLUG_UNHASHED)
-		return;
+	WARN_ON_ONCE(!(zwplug->flags & BLK_ZONE_WPLUG_DEAD));
+	WARN_ON_ONCE(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED);
+	WARN_ON_ONCE(!bio_list_empty(&zwplug->bio_list));
 
-	/*
-	 * Mark the zone write plug as unhashed and drop the extra reference we
-	 * took when the plug was inserted in the hash table. Also update the
-	 * disk zone condition array with the current condition of the zone
-	 * write plug.
-	 */
-	zwplug->flags |= BLK_ZONE_WPLUG_UNHASHED;
 	spin_lock_irqsave(&disk->zone_wplugs_lock, flags);
 	blk_zone_set_cond(rcu_dereference_check(disk->zones_cond,
 				lockdep_is_held(&disk->zone_wplugs_lock)),
@@ -652,7 +603,29 @@ static void disk_remove_zone_wplug(struct gendisk *disk,
 	hlist_del_init_rcu(&zwplug->node);
 	atomic_dec(&disk->nr_zone_wplugs);
 	spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);
-	disk_put_zone_wplug(zwplug);
+
+	call_rcu(&zwplug->rcu_head, disk_free_zone_wplug_rcu);
+}
+
+static inline void disk_put_zone_wplug(struct blk_zone_wplug *zwplug)
+{
+	if (refcount_dec_and_test(&zwplug->ref))
+		disk_free_zone_wplug(zwplug);
+}
+
+/*
+ * Flag the zone write plug as dead and drop the initial reference we got when
+ * the zone write plug was added to the hash table. The zone write plug will be
+ * unhashed when its last reference is dropped.
+ */
+static void disk_mark_zone_wplug_dead(struct blk_zone_wplug *zwplug)
+{
+	lockdep_assert_held(&zwplug->lock);
+
+	if (!(zwplug->flags & BLK_ZONE_WPLUG_DEAD)) {
+		zwplug->flags |= BLK_ZONE_WPLUG_DEAD;
+		disk_put_zone_wplug(zwplug);
+	}
 }
 
 static void blk_zone_wplug_bio_work(struct work_struct *work);
@@ -672,18 +645,7 @@ static struct blk_zone_wplug *disk_get_and_lock_zone_wplug(struct gendisk *disk,
 again:
 	zwplug = disk_get_zone_wplug(disk, sector);
 	if (zwplug) {
-		/*
-		 * Check that a BIO completion or a zone reset or finish
-		 * operation has not already removed the zone write plug from
-		 * the hash table and dropped its reference count. In such case,
-		 * we need to get a new plug so start over from the beginning.
-		 */
 		spin_lock_irqsave(&zwplug->lock, *flags);
-		if (zwplug->flags & BLK_ZONE_WPLUG_UNHASHED) {
-			spin_unlock_irqrestore(&zwplug->lock, *flags);
-			disk_put_zone_wplug(zwplug);
-			goto again;
-		}
 		return zwplug;
 	}
 
@@ -788,14 +750,8 @@ static void disk_zone_wplug_set_wp_offset(struct gendisk *disk,
 	disk_zone_wplug_update_cond(disk, zwplug);
 
 	disk_zone_wplug_abort(zwplug);
-
-	/*
-	 * The zone write plug now has no BIO plugged: remove it from the
-	 * hash table so that it cannot be seen. The plug will be freed
-	 * when the last reference is dropped.
-	 */
-	if (disk_should_remove_zone_wplug(disk, zwplug))
-		disk_remove_zone_wplug(disk, zwplug);
+	if (!zwplug->wp_offset || disk_zone_wplug_is_full(disk, zwplug))
+		disk_mark_zone_wplug_dead(zwplug);
 }
 
 static unsigned int blk_zone_wp_offset(struct blk_zone *zone)
@@ -1451,6 +1407,19 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
 		return true;
 	}
 
+	/*
+	 * If we got a zone write plug marked as dead, then the user is issuing
+	 * writes to a full zone, or without synchronizing with zone reset or
+	 * zone finish operations. In such case, fail the BIO to signal this
+	 * invalid usage.
+	 */
+	if (zwplug->flags & BLK_ZONE_WPLUG_DEAD) {
+		spin_unlock_irqrestore(&zwplug->lock, flags);
+		disk_put_zone_wplug(zwplug);
+		bio_io_error(bio);
+		return true;
+	}
+
 	/* Indicate that this BIO is being handled using zone write plugging. */
 	bio_set_flag(bio, BIO_ZONE_WRITE_PLUGGING);
 
@@ -1531,7 +1500,7 @@ static void blk_zone_wplug_handle_native_zone_append(struct bio *bio)
 				    disk->disk_name, zwplug->zone_no);
 		disk_zone_wplug_abort(zwplug);
 	}
-	disk_remove_zone_wplug(disk, zwplug);
+	disk_mark_zone_wplug_dead(zwplug);
 	spin_unlock_irqrestore(&zwplug->lock, flags);
 
 	disk_put_zone_wplug(zwplug);
@@ -1634,14 +1603,8 @@ static void disk_zone_wplug_unplug_bio(struct gendisk *disk,
 	}
 
 	zwplug->flags &= ~BLK_ZONE_WPLUG_PLUGGED;
-
-	/*
-	 * If the zone is full (it was fully written or finished, or empty
-	 * (it was reset), remove its zone write plug from the hash table.
-	 */
-	if (disk_should_remove_zone_wplug(disk, zwplug))
-		disk_remove_zone_wplug(disk, zwplug);
-
+	if (!zwplug->wp_offset || disk_zone_wplug_is_full(disk, zwplug))
+		disk_mark_zone_wplug_dead(zwplug);
 	spin_unlock_irqrestore(&zwplug->lock, flags);
 }
 
@@ -1852,9 +1815,9 @@ static void disk_destroy_zone_wplugs_hash_table(struct gendisk *disk)
 		while (!hlist_empty(&disk->zone_wplugs_hash[i])) {
 			zwplug = hlist_entry(disk->zone_wplugs_hash[i].first,
 					     struct blk_zone_wplug, node);
-			refcount_inc(&zwplug->ref);
-			disk_remove_zone_wplug(disk, zwplug);
-			disk_put_zone_wplug(zwplug);
+			spin_lock_irq(&zwplug->lock);
+			disk_mark_zone_wplug_dead(zwplug);
+			spin_unlock_irq(&zwplug->lock);
 		}
 	}
 
diff --git a/block/blk.h b/block/blk.h
index a55e2e4fcda4..a7abf3be34ef 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -132,6 +132,8 @@ static inline bool biovec_phys_mergeable(struct request_queue *q,
 
 	if (addr1 + vec1->bv_len != addr2)
 		return false;
+	if (!zone_device_pages_have_same_pgmap(vec1->bv_page, vec2->bv_page))
+		return false;
 	if (xen_domain() && !xen_biovec_phys_mergeable(vec1, vec2->bv_page))
 		return false;
 	if ((addr1 | mask) != ((addr2 + vec2->bv_len - 1) | mask))
diff --git a/block/ioctl.c b/block/ioctl.c
index 0b04661ac809..6fc63c794892 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -864,6 +864,8 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 #endif
 
 struct blk_iou_cmd {
+	u64 start;
+	u64 len;
 	int res;
 	bool nowait;
 };
@@ -953,23 +955,27 @@ int blkdev_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
 	struct block_device *bdev = I_BDEV(cmd->file->f_mapping->host);
 	struct blk_iou_cmd *bic = io_uring_cmd_to_pdu(cmd, struct blk_iou_cmd);
-	const struct io_uring_sqe *sqe = cmd->sqe;
 	u32 cmd_op = cmd->cmd_op;
-	uint64_t start, len;
 
-	if (unlikely(sqe->ioprio || sqe->__pad1 || sqe->len ||
-		     sqe->rw_flags || sqe->file_index))
-		return -EINVAL;
+	/* Read what we need from the SQE on the first issue */
+	if (!(issue_flags & IORING_URING_CMD_REISSUE)) {
+		const struct io_uring_sqe *sqe = cmd->sqe;
+
+		if (unlikely(sqe->ioprio || sqe->__pad1 || sqe->len ||
+			     sqe->rw_flags || sqe->file_index))
+			return -EINVAL;
+
+		bic->start = READ_ONCE(sqe->addr);
+		bic->len = READ_ONCE(sqe->addr3);
+	}
 
 	bic->res = 0;
 	bic->nowait = issue_flags & IO_URING_F_NONBLOCK;
 
-	start = READ_ONCE(sqe->addr);
-	len = READ_ONCE(sqe->addr3);
-
 	switch (cmd_op) {
 	case BLOCK_URING_CMD_DISCARD:
-		return blkdev_cmd_discard(cmd, bdev, start, len, bic->nowait);
+		return blkdev_cmd_discard(cmd, bdev, bic->start, bic->len,
+					  bic->nowait);
 	}
 	return -EINVAL;
 }
diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 5900a40c7a78..328c4fc468ba 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -460,6 +460,26 @@ static const struct file_operations ivpu_fops = {
 #endif
 };
 
+static int ivpu_gem_prime_handle_to_fd(struct drm_device *dev, struct drm_file *file_priv,
+				       u32 handle, u32 flags, int *prime_fd)
+{
+	struct drm_gem_object *obj;
+
+	obj = drm_gem_object_lookup(file_priv, handle);
+	if (!obj)
+		return -ENOENT;
+
+	if (drm_gem_is_imported(obj)) {
+		/* Do not allow re-exporting */
+		drm_gem_object_put(obj);
+		return -EOPNOTSUPP;
+	}
+
+	drm_gem_object_put(obj);
+
+	return drm_gem_prime_handle_to_fd(dev, file_priv, handle, flags, prime_fd);
+}
+
 static const struct drm_driver driver = {
 	.driver_features = DRIVER_GEM | DRIVER_COMPUTE_ACCEL,
 
@@ -468,6 +488,7 @@ static const struct drm_driver driver = {
 
 	.gem_create_object = ivpu_gem_create_object,
 	.gem_prime_import = ivpu_gem_prime_import,
+	.prime_handle_to_fd = ivpu_gem_prime_handle_to_fd,
 
 	.ioctls = ivpu_drm_ioctls,
 	.num_ioctls = ARRAY_SIZE(ivpu_drm_ioctls),
diff --git a/drivers/acpi/arm64/cpuidle.c b/drivers/acpi/arm64/cpuidle.c
index 801f9c450142..c68a5db8ebba 100644
--- a/drivers/acpi/arm64/cpuidle.c
+++ b/drivers/acpi/arm64/cpuidle.c
@@ -16,7 +16,7 @@
 
 static int psci_acpi_cpu_init_idle(unsigned int cpu)
 {
-	int i, count;
+	int i;
 	struct acpi_lpi_state *lpi;
 	struct acpi_processor *pr = per_cpu(processors, cpu);
 
@@ -30,14 +30,10 @@ static int psci_acpi_cpu_init_idle(unsigned int cpu)
 	if (!psci_ops.cpu_suspend)
 		return -EOPNOTSUPP;
 
-	count = pr->power.count - 1;
-	if (count <= 0)
-		return -ENODEV;
-
-	for (i = 0; i < count; i++) {
+	for (i = 1; i < pr->power.count; i++) {
 		u32 state;
 
-		lpi = &pr->power.lpi_states[i + 1];
+		lpi = &pr->power.lpi_states[i];
 		/*
 		 * Only bits[31:0] represent a PSCI power_state while
 		 * bits[63:32] must be 0x0 as per ARM ACPI FFH Specification
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index f0e513e9ed5d..bcfe2e6b8445 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -362,7 +362,7 @@ static int send_pcc_cmd(int pcc_ss_id, u16 cmd)
 end:
 	if (cmd == CMD_WRITE) {
 		if (unlikely(ret)) {
-			for_each_online_cpu(i) {
+			for_each_possible_cpu(i) {
 				struct cpc_desc *desc = per_cpu(cpc_desc_ptr, i);
 
 				if (!desc)
@@ -524,13 +524,13 @@ int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data)
 	else if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ANY)
 		cpu_data->shared_type = CPUFREQ_SHARED_TYPE_ANY;
 
-	for_each_online_cpu(i) {
+	for_each_possible_cpu(i) {
 		if (i == cpu)
 			continue;
 
 		match_cpc_ptr = per_cpu(cpc_desc_ptr, i);
 		if (!match_cpc_ptr)
-			goto err_fault;
+			continue;
 
 		match_pdomain = &(match_cpc_ptr->domain_info);
 		if (match_pdomain->domain != pdomain->domain)
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 4611159ee734..cf535966b9f7 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -991,7 +991,7 @@ struct acpi_device *acpi_add_power_resource(acpi_handle handle)
 	return device;
 
  err:
-	acpi_release_power_resource(&device->dev);
+	acpi_dev_put(device);
 	return NULL;
 }
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index e8cdbdb46fdb..530547cda8b2 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1900,7 +1900,7 @@ static int acpi_add_single_object(struct acpi_device **child,
 		result = acpi_device_add(device);
 
 	if (result) {
-		acpi_device_release(&device->dev);
+		acpi_dev_put(device);
 		return result;
 	}
 
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 4cf74f173c78..2c120ade8f51 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -878,6 +878,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 7760 AIO"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Dell OptiPlex 7770 AIO */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 7770 AIO"),
+		},
+	},
 
 	/*
 	 * Models which have nvidia-ec-wmi support, but should not use it.
@@ -899,6 +907,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 15 3535"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* HP OMEN Gaming Laptop 16-n0xxx */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "OMEN by HP Gaming Laptop 16-n0xxx"),
+		},
+	},
 
 	/*
 	 * x86 android tablets which directly control the backlight through
diff --git a/drivers/android/binder/range_alloc/array.rs b/drivers/android/binder/range_alloc/array.rs
index ada1d1b4302e..081d19b09d4b 100644
--- a/drivers/android/binder/range_alloc/array.rs
+++ b/drivers/android/binder/range_alloc/array.rs
@@ -204,7 +204,6 @@ pub(crate) fn reservation_abort(&mut self, offset: usize) -> Result<FreedRange>
         // caller will mark them as unused, which means that they can be freed if the system comes
         // under memory pressure.
         let mut freed_range = FreedRange::interior_pages(offset, size);
-        #[expect(clippy::collapsible_if)] // reads better like this
         if offset % PAGE_SIZE != 0 {
             if i == 0 || self.ranges[i - 1].endpoint() <= (offset & PAGE_MASK) {
                 freed_range.start_page_idx -= 1;
diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index fa7533578f85..31ff133b6159 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -654,8 +654,13 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 	if (data->evt_skb == NULL)
 		goto err_free_wc;
 
-	/* Parse and handle the return WMT event */
-	wmt_evt = (struct btmtk_hci_wmt_evt *)data->evt_skb->data;
+	wmt_evt = skb_pull_data(data->evt_skb, sizeof(*wmt_evt));
+	if (!wmt_evt) {
+		bt_dev_err(hdev, "WMT event too short (%u bytes)",
+			   data->evt_skb->len);
+		err = -EINVAL;
+		goto err_free_skb;
+	}
 	if (wmt_evt->whdr.op != hdr->op) {
 		bt_dev_err(hdev, "Wrong op received %d expected %d",
 			   wmt_evt->whdr.op, hdr->op);
@@ -671,6 +676,12 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 			status = BTMTK_WMT_PATCH_DONE;
 		break;
 	case BTMTK_WMT_FUNC_CTRL:
+		if (!skb_pull_data(data->evt_skb,
+				   sizeof(wmt_evt_funcc->status))) {
+			err = -EINVAL;
+			goto err_free_skb;
+		}
+
 		wmt_evt_funcc = (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
 		if (be16_to_cpu(wmt_evt_funcc->status) == 0x404)
 			status = BTMTK_WMT_ON_DONE;
diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 76d61af8a275..140ab55c9fc5 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -12,6 +12,7 @@
 #include <net/bluetooth/hci_core.h>
 
 #define VERSION "0.1"
+#define VIRTBT_RX_BUF_SIZE 1000
 
 enum {
 	VIRTBT_VQ_TX,
@@ -33,11 +34,11 @@ static int virtbt_add_inbuf(struct virtio_bluetooth *vbt)
 	struct sk_buff *skb;
 	int err;
 
-	skb = alloc_skb(1000, GFP_KERNEL);
+	skb = alloc_skb(VIRTBT_RX_BUF_SIZE, GFP_KERNEL);
 	if (!skb)
 		return -ENOMEM;
 
-	sg_init_one(sg, skb->data, 1000);
+	sg_init_one(sg, skb->data, VIRTBT_RX_BUF_SIZE);
 
 	err = virtqueue_add_inbuf(vq, sg, 1, skb, GFP_KERNEL);
 	if (err < 0) {
@@ -197,6 +198,7 @@ static int virtbt_shutdown_generic(struct hci_dev *hdev)
 
 static void virtbt_rx_handle(struct virtio_bluetooth *vbt, struct sk_buff *skb)
 {
+	size_t min_hdr;
 	__u8 pkt_type;
 
 	pkt_type = *((__u8 *) skb->data);
@@ -204,16 +206,32 @@ static void virtbt_rx_handle(struct virtio_bluetooth *vbt, struct sk_buff *skb)
 
 	switch (pkt_type) {
 	case HCI_EVENT_PKT:
+		min_hdr = sizeof(struct hci_event_hdr);
+		break;
 	case HCI_ACLDATA_PKT:
+		min_hdr = sizeof(struct hci_acl_hdr);
+		break;
 	case HCI_SCODATA_PKT:
+		min_hdr = sizeof(struct hci_sco_hdr);
+		break;
 	case HCI_ISODATA_PKT:
-		hci_skb_pkt_type(skb) = pkt_type;
-		hci_recv_frame(vbt->hdev, skb);
+		min_hdr = sizeof(struct hci_iso_hdr);
 		break;
 	default:
 		kfree_skb(skb);
-		break;
+		return;
+	}
+
+	if (skb->len < min_hdr) {
+		bt_dev_err_ratelimited(vbt->hdev,
+				       "rx pkt_type 0x%02x payload %u < hdr %zu\n",
+				       pkt_type, skb->len, min_hdr);
+		kfree_skb(skb);
+		return;
 	}
+
+	hci_skb_pkt_type(skb) = pkt_type;
+	hci_recv_frame(vbt->hdev, skb);
 }
 
 static void virtbt_rx_work(struct work_struct *work)
@@ -227,8 +245,15 @@ static void virtbt_rx_work(struct work_struct *work)
 	if (!skb)
 		return;
 
-	skb_put(skb, len);
-	virtbt_rx_handle(vbt, skb);
+	if (!len || len > VIRTBT_RX_BUF_SIZE) {
+		bt_dev_err_ratelimited(vbt->hdev,
+				       "rx reply len %u outside [1, %u]\n",
+				       len, VIRTBT_RX_BUF_SIZE);
+		kfree_skb(skb);
+	} else {
+		skb_put(skb, len);
+		virtbt_rx_handle(vbt, skb);
+	}
 
 	if (virtbt_add_inbuf(vbt) < 0)
 		return;
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 4a9e9de4d684..9a9d12be9bf7 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -168,6 +168,10 @@ struct smi_info {
 			     OEM2_DATA_AVAIL)
 	unsigned char       msg_flags;
 
+	/* When requesting events and messages, don't do it forever. */
+	unsigned int        num_requests_in_a_row;
+	bool		    last_was_flag_fetch;
+
 	/* Does the BMC have an event buffer? */
 	bool		    has_event_buffer;
 
@@ -410,7 +414,10 @@ static void start_getting_msg_queue(struct smi_info *smi_info)
 
 	start_new_msg(smi_info, smi_info->curr_msg->data,
 		      smi_info->curr_msg->data_size);
-	smi_info->si_state = SI_GETTING_MESSAGES;
+	if (smi_info->si_state != SI_GETTING_MESSAGES) {
+		smi_info->num_requests_in_a_row = 0;
+		smi_info->si_state = SI_GETTING_MESSAGES;
+	}
 }
 
 static void start_getting_events(struct smi_info *smi_info)
@@ -421,7 +428,10 @@ static void start_getting_events(struct smi_info *smi_info)
 
 	start_new_msg(smi_info, smi_info->curr_msg->data,
 		      smi_info->curr_msg->data_size);
-	smi_info->si_state = SI_GETTING_EVENTS;
+	if (smi_info->si_state != SI_GETTING_EVENTS) {
+		smi_info->num_requests_in_a_row = 0;
+		smi_info->si_state = SI_GETTING_EVENTS;
+	}
 }
 
 /*
@@ -487,15 +497,19 @@ static void handle_flags(struct smi_info *smi_info)
 	} else if (smi_info->msg_flags & RECEIVE_MSG_AVAIL) {
 		/* Messages available. */
 		smi_info->curr_msg = alloc_msg_handle_irq(smi_info);
-		if (!smi_info->curr_msg)
+		if (!smi_info->curr_msg) {
+			smi_info->si_state = SI_NORMAL;
 			return;
+		}
 
 		start_getting_msg_queue(smi_info);
 	} else if (smi_info->msg_flags & EVENT_MSG_BUFFER_FULL) {
 		/* Events available. */
 		smi_info->curr_msg = alloc_msg_handle_irq(smi_info);
-		if (!smi_info->curr_msg)
+		if (!smi_info->curr_msg) {
+			smi_info->si_state = SI_NORMAL;
 			return;
+		}
 
 		start_getting_events(smi_info);
 	} else if (smi_info->msg_flags & OEM_DATA_AVAIL &&
@@ -595,6 +609,7 @@ static void handle_transaction_done(struct smi_info *smi_info)
 			smi_info->si_state = SI_NORMAL;
 		} else {
 			smi_info->msg_flags = msg[3];
+			smi_info->last_was_flag_fetch = true;
 			handle_flags(smi_info);
 		}
 		break;
@@ -630,7 +645,13 @@ static void handle_transaction_done(struct smi_info *smi_info)
 		 */
 		msg = smi_info->curr_msg;
 		smi_info->curr_msg = NULL;
-		if (msg->rsp[2] != 0) {
+		/*
+		 * It appears some BMCs, with no event data, return no
+		 * data in the message and not a 0x80 error as the
+		 * spec says they should.  Shut down processing if
+		 * the data is not the right length.
+		 */
+		if (msg->rsp[2] != 0 || msg->rsp_size != 19) {
 			/* Error getting event, probably done. */
 			msg->done(msg);
 
@@ -640,6 +661,11 @@ static void handle_transaction_done(struct smi_info *smi_info)
 		} else {
 			smi_inc_stat(smi_info, events);
 
+			smi_info->num_requests_in_a_row++;
+			if (smi_info->num_requests_in_a_row > 10)
+				/* Stop if we do this too many times. */
+				smi_info->msg_flags &= ~EVENT_MSG_BUFFER_FULL;
+
 			/*
 			 * Do this before we deliver the message
 			 * because delivering the message releases the
@@ -678,6 +704,11 @@ static void handle_transaction_done(struct smi_info *smi_info)
 		} else {
 			smi_inc_stat(smi_info, incoming_messages);
 
+			smi_info->num_requests_in_a_row++;
+			if (smi_info->num_requests_in_a_row > 10)
+				/* Stop if we do this too many times. */
+				smi_info->msg_flags &= ~RECEIVE_MSG_AVAIL;
+
 			/*
 			 * Do this before we deliver the message
 			 * because delivering the message releases the
@@ -819,6 +850,26 @@ static enum si_sm_result smi_event_handler(struct smi_info *smi_info,
 		goto out;
 	}
 
+	/*
+	 * If we are currently idle, or if the last thing that was
+	 * done was a flag fetch and there is a message pending, try
+	 * to start the next message.
+	 *
+	 * We do the waiting message check to avoid a stuck flag
+	 * completely wedging the driver.  Let a message through
+	 * in between flag operations if that happens.
+	 */
+	if (si_sm_result == SI_SM_IDLE ||
+	    (si_sm_result == SI_SM_ATTN && smi_info->waiting_msg &&
+	     smi_info->last_was_flag_fetch)) {
+		smi_info->last_was_flag_fetch = false;
+		smi_inc_stat(smi_info, idles);
+
+		si_sm_result = start_next_msg(smi_info);
+		if (si_sm_result != SI_SM_IDLE)
+			goto restart;
+	}
+
 	/*
 	 * We prefer handling attn over new messages.  But don't do
 	 * this if there is not yet an upper layer to handle anything.
@@ -846,15 +897,6 @@ static enum si_sm_result smi_event_handler(struct smi_info *smi_info,
 		}
 	}
 
-	/* If we are currently idle, try to start the next message. */
-	if (si_sm_result == SI_SM_IDLE) {
-		smi_inc_stat(smi_info, idles);
-
-		si_sm_result = start_next_msg(smi_info);
-		if (si_sm_result != SI_SM_IDLE)
-			goto restart;
-	}
-
 	if ((si_sm_result == SI_SM_IDLE)
 	    && (atomic_read(&smi_info->req_events))) {
 		/*
diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 69765bbe08be..f419b46bf002 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -225,6 +225,9 @@ struct ssif_info {
 	bool		    has_event_buffer;
 	bool		    supports_alert;
 
+	/* When requesting events and messages, don't do it forever. */
+	unsigned int        num_requests_in_a_row;
+
 	/*
 	 * Used to tell what we should do with alerts.  If we are
 	 * waiting on a response, read the data immediately.
@@ -413,7 +416,10 @@ static void start_event_fetch(struct ssif_info *ssif_info, unsigned long *flags)
 	}
 
 	ssif_info->curr_msg = msg;
-	ssif_info->ssif_state = SSIF_GETTING_EVENTS;
+	if (ssif_info->ssif_state != SSIF_GETTING_EVENTS) {
+		ssif_info->num_requests_in_a_row = 0;
+		ssif_info->ssif_state = SSIF_GETTING_EVENTS;
+	}
 	ipmi_ssif_unlock_cond(ssif_info, flags);
 
 	msg->data[0] = (IPMI_NETFN_APP_REQUEST << 2);
@@ -436,7 +442,10 @@ static void start_recv_msg_fetch(struct ssif_info *ssif_info,
 	}
 
 	ssif_info->curr_msg = msg;
-	ssif_info->ssif_state = SSIF_GETTING_MESSAGES;
+	if (ssif_info->ssif_state != SSIF_GETTING_MESSAGES) {
+		ssif_info->num_requests_in_a_row = 0;
+		ssif_info->ssif_state = SSIF_GETTING_MESSAGES;
+	}
 	ipmi_ssif_unlock_cond(ssif_info, flags);
 
 	msg->data[0] = (IPMI_NETFN_APP_REQUEST << 2);
@@ -843,6 +852,11 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
 			ssif_info->msg_flags &= ~EVENT_MSG_BUFFER_FULL;
 			handle_flags(ssif_info, flags);
 		} else {
+			ssif_info->num_requests_in_a_row++;
+			if (ssif_info->num_requests_in_a_row > 10)
+				/* Stop if we do this too many times. */
+				ssif_info->msg_flags &= ~EVENT_MSG_BUFFER_FULL;
+
 			handle_flags(ssif_info, flags);
 			ssif_inc_stat(ssif_info, events);
 			deliver_recv_msg(ssif_info, msg);
@@ -876,6 +890,11 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
 			ssif_info->msg_flags &= ~RECEIVE_MSG_AVAIL;
 			handle_flags(ssif_info, flags);
 		} else {
+			ssif_info->num_requests_in_a_row++;
+			if (ssif_info->num_requests_in_a_row > 10)
+				/* Stop if we do this too many times. */
+				ssif_info->msg_flags &= ~RECEIVE_MSG_AVAIL;
+
 			ssif_inc_stat(ssif_info, incoming_messages);
 			handle_flags(ssif_info, flags);
 			deliver_recv_msg(ssif_info, msg);
diff --git a/drivers/clk/clk-rk808.c b/drivers/clk/clk-rk808.c
index f7412b137e5e..5a75b5c91555 100644
--- a/drivers/clk/clk-rk808.c
+++ b/drivers/clk/clk-rk808.c
@@ -153,7 +153,7 @@ static int rk808_clkout_probe(struct platform_device *pdev)
 	struct rk808_clkout *rk808_clkout;
 	int ret;
 
-	dev->of_node = pdev->dev.parent->of_node;
+	device_set_of_node_from_dev(dev, dev->parent);
 
 	rk808_clkout = devm_kzalloc(dev,
 				    sizeof(*rk808_clkout), GFP_KERNEL);
diff --git a/drivers/clk/imx/clk-imx8-acm.c b/drivers/clk/imx/clk-imx8-acm.c
index 790f7e44b11e..07dca6f31cf8 100644
--- a/drivers/clk/imx/clk-imx8-acm.c
+++ b/drivers/clk/imx/clk-imx8-acm.c
@@ -371,7 +371,8 @@ static int imx8_acm_clk_probe(struct platform_device *pdev)
 	for (i = 0; i < priv->soc_data->num_sels; i++) {
 		hws[sels[i].clkid] = devm_clk_hw_register_mux_parent_data_table(dev,
 										sels[i].name, sels[i].parents,
-										sels[i].num_parents, 0,
+										sels[i].num_parents,
+										CLK_SET_RATE_NO_REPARENT,
 										base + sels[i].reg,
 										sels[i].shift, sels[i].width,
 										0, NULL, NULL);
diff --git a/drivers/clk/microchip/clk-mpfs-ccc.c b/drivers/clk/microchip/clk-mpfs-ccc.c
index 3a3ea2d142f8..0a76a1aaa50f 100644
--- a/drivers/clk/microchip/clk-mpfs-ccc.c
+++ b/drivers/clk/microchip/clk-mpfs-ccc.c
@@ -178,7 +178,7 @@ static int mpfs_ccc_register_outputs(struct device *dev, struct mpfs_ccc_out_hw_
 			return dev_err_probe(dev, ret, "failed to register clock id: %d\n",
 					     out_hw->id);
 
-		data->hw_data.hws[out_hw->id] = &out_hw->divider.hw;
+		data->hw_data.hws[out_hw->id - 2] = &out_hw->divider.hw;
 	}
 
 	return 0;
@@ -234,6 +234,10 @@ static int mpfs_ccc_probe(struct platform_device *pdev)
 	unsigned int num_clks;
 	int ret;
 
+	/*
+	 * If DLLs get added here, mpfs_ccc_register_outputs() currently packs
+	 * sparse clock IDs in the hws array
+	 */
 	num_clks = ARRAY_SIZE(mpfs_ccc_pll_clks) + ARRAY_SIZE(mpfs_ccc_pll0out_clks) +
 		   ARRAY_SIZE(mpfs_ccc_pll1out_clks);
 
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 9ebedd972df0..b89e7111e7b8 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -95,7 +95,10 @@ static int snooze_loop(struct cpuidle_device *dev,
 
 	HMT_medium();
 	ppc64_runlatch_on();
-	clear_thread_flag(TIF_POLLING_NRFLAG);
+
+	/* Avoid double clear when breaking */
+	if (!dev->poll_time_limit)
+		clear_thread_flag(TIF_POLLING_NRFLAG);
 
 	local_irq_disable();
 
diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index f68c65f1d023..864dd5d6e627 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -64,7 +64,10 @@ int snooze_loop(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	}
 
 	HMT_medium();
-	clear_thread_flag(TIF_POLLING_NRFLAG);
+
+       /* Avoid double clear when breaking */
+	if (!dev->poll_time_limit)
+		clear_thread_flag(TIF_POLLING_NRFLAG);
 
 	raw_local_irq_disable();
 
diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 78964e1712e5..3343ddc30076 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -3269,7 +3269,7 @@ static int hash_digest_key(struct caam_hash_ctx *ctx, u32 *keylen, u8 *key,
 	dpaa2_fl_set_addr(out_fle, key_dma);
 	dpaa2_fl_set_len(out_fle, digestsize);
 
-	print_hex_dump_debug("key_in@" __stringify(__LINE__)": ",
+	print_hex_dump_devel("key_in@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, *keylen, 1);
 	print_hex_dump_debug("shdesc@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
@@ -3289,7 +3289,7 @@ static int hash_digest_key(struct caam_hash_ctx *ctx, u32 *keylen, u8 *key,
 		/* in progress */
 		wait_for_completion(&result.completion);
 		ret = result.err;
-		print_hex_dump_debug("digested key@" __stringify(__LINE__)": ",
+		print_hex_dump_devel("digested key@" __stringify(__LINE__)": ",
 				     DUMP_PREFIX_ADDRESS, 16, 4, key,
 				     digestsize, 1);
 	}
diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
index 44122208f70c..a0c417b7b805 100644
--- a/drivers/crypto/caam/caamhash.c
+++ b/drivers/crypto/caam/caamhash.c
@@ -393,7 +393,7 @@ static int hash_digest_key(struct caam_hash_ctx *ctx, u32 *keylen, u8 *key,
 	append_seq_store(desc, digestsize, LDST_CLASS_2_CCB |
 			 LDST_SRCDST_BYTE_CONTEXT);
 
-	print_hex_dump_debug("key_in@"__stringify(__LINE__)": ",
+	print_hex_dump_devel("key_in@"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, *keylen, 1);
 	print_hex_dump_debug("jobdesc@"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
@@ -408,7 +408,7 @@ static int hash_digest_key(struct caam_hash_ctx *ctx, u32 *keylen, u8 *key,
 		wait_for_completion(&result.completion);
 		ret = result.err;
 
-		print_hex_dump_debug("digested key@"__stringify(__LINE__)": ",
+		print_hex_dump_devel("digested key@"__stringify(__LINE__)": ",
 				     DUMP_PREFIX_ADDRESS, 16, 4, key,
 				     digestsize, 1);
 	}
diff --git a/drivers/crypto/intel/qat/qat_common/adf_accel_engine.c b/drivers/crypto/intel/qat/qat_common/adf_accel_engine.c
index f9f1018a2823..09d4f547e082 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_accel_engine.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_accel_engine.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
 /* Copyright(c) 2014 - 2020 Intel Corporation */
+#include <linux/delay.h>
 #include <linux/firmware.h>
 #include <linux/pci.h>
 #include "adf_cfg.h"
@@ -162,8 +163,14 @@ int adf_ae_stop(struct adf_accel_dev *accel_dev)
 static int adf_ae_reset(struct adf_accel_dev *accel_dev, int ae)
 {
 	struct adf_fw_loader_data *loader_data = accel_dev->fw_loader;
+	unsigned long reset_delay;
 
 	qat_hal_reset(loader_data->fw_loader);
+
+	reset_delay = loader_data->fw_loader->chip_info->reset_delay_us;
+	if (reset_delay)
+		fsleep(reset_delay);
+
 	if (qat_hal_clr_reset(loader_data->fw_loader))
 		return -EFAULT;
 
diff --git a/drivers/crypto/intel/qat/qat_common/icp_qat_fw_loader_handle.h b/drivers/crypto/intel/qat/qat_common/icp_qat_fw_loader_handle.h
index 6887930c7995..e74cafa95f1c 100644
--- a/drivers/crypto/intel/qat/qat_common/icp_qat_fw_loader_handle.h
+++ b/drivers/crypto/intel/qat/qat_common/icp_qat_fw_loader_handle.h
@@ -27,6 +27,7 @@ struct icp_qat_fw_loader_chip_info {
 	int mmp_sram_size;
 	bool nn;
 	bool lm2lm3;
+	u16 reset_delay_us;
 	u32 lm_size;
 	u32 icp_rst_csr;
 	u32 icp_rst_mask;
diff --git a/drivers/crypto/intel/qat/qat_common/qat_hal.c b/drivers/crypto/intel/qat/qat_common/qat_hal.c
index 7a6ba6f22e3e..1c3d1311f1c7 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_hal.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_hal.c
@@ -9,17 +9,18 @@
 #include "icp_qat_hal.h"
 #include "icp_qat_uclo.h"
 
-#define BAD_REGADDR	       0xffff
-#define MAX_RETRY_TIMES	   10000
-#define INIT_CTX_ARB_VALUE	0x0
-#define INIT_CTX_ENABLE_VALUE     0x0
-#define INIT_PC_VALUE	     0x0
-#define INIT_WAKEUP_EVENTS_VALUE  0x1
-#define INIT_SIG_EVENTS_VALUE     0x1
-#define INIT_CCENABLE_VALUE       0x2000
-#define RST_CSR_QAT_LSB	   20
-#define RST_CSR_AE_LSB		  0
-#define MC_TIMESTAMP_ENABLE       (0x1 << 7)
+#define BAD_REGADDR			0xffff
+#define MAX_RETRY_TIMES			10000
+#define INIT_CTX_ARB_VALUE		0x0
+#define INIT_CTX_ENABLE_VALUE		0x0
+#define INIT_PC_VALUE			0x0
+#define INIT_WAKEUP_EVENTS_VALUE	0x1
+#define INIT_SIG_EVENTS_VALUE		0x1
+#define INIT_CCENABLE_VALUE		0x2000
+#define RST_CSR_QAT_LSB			20
+#define RST_CSR_AE_LSB			0
+#define MC_TIMESTAMP_ENABLE		(0x1 << 7)
+#define MIN_RESET_DELAY_US		3
 
 #define IGNORE_W1C_MASK ((~(1 << CE_BREAKPOINT_BITPOS)) & \
 	(~(1 << CE_CNTL_STORE_PARITY_ERROR_BITPOS)) & \
@@ -713,8 +714,10 @@ static int qat_hal_chip_init(struct icp_qat_fw_loader_handle *handle,
 		handle->chip_info->wakeup_event_val = 0x80000000;
 		handle->chip_info->fw_auth = true;
 		handle->chip_info->css_3k = true;
-		if (handle->pci_dev->device == PCI_DEVICE_ID_INTEL_QAT_6XXX)
+		if (handle->pci_dev->device == PCI_DEVICE_ID_INTEL_QAT_6XXX) {
 			handle->chip_info->dual_sign = true;
+			handle->chip_info->reset_delay_us = MIN_RESET_DELAY_US;
+		}
 		handle->chip_info->tgroup_share_ustore = true;
 		handle->chip_info->fcu_ctl_csr = FCU_CONTROL_4XXX;
 		handle->chip_info->fcu_sts_csr = FCU_STATUS_4XXX;
diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 78ad86c4a3be..31970fb34fcb 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -331,6 +331,19 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
 	return 0;
 }
 
+static int ptn5150_resume(struct device *dev)
+{
+	struct i2c_client *i2c = to_i2c_client(dev);
+	struct ptn5150_info *info = i2c_get_clientdata(i2c);
+
+	/* Need to check possible pending interrupt events */
+	schedule_work(&info->irq_work);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(ptn5150_pm_ops, NULL, ptn5150_resume);
+
 static const struct of_device_id ptn5150_dt_match[] = {
 	{ .compatible = "nxp,ptn5150" },
 	{ },
@@ -346,6 +359,7 @@ MODULE_DEVICE_TABLE(i2c, ptn5150_i2c_id);
 static struct i2c_driver ptn5150_i2c_driver = {
 	.driver		= {
 		.name	= "ptn5150",
+		.pm = pm_sleep_ptr(&ptn5150_pm_ops),
 		.of_match_table = ptn5150_dt_match,
 	},
 	.probe		= ptn5150_i2c_probe,
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index ef1ac68b94b7..08b7b662512b 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -1210,7 +1210,14 @@ int of_gpiochip_add(struct gpio_chip *chip)
 
 void of_gpiochip_remove(struct gpio_chip *chip)
 {
-	of_node_put(dev_of_node(&chip->gpiodev->dev));
+	struct device_node *np = dev_of_node(&chip->gpiodev->dev);
+
+	for_each_child_of_node_scoped(np, child) {
+		if (of_property_present(child, "gpio-hog"))
+			of_node_clear_flag(child, OF_POPULATED);
+	}
+
+	of_node_put(np);
 }
 
 bool of_gpiochip_instance_match(struct gpio_chip *gc, unsigned int index)
diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 7937ac0cbd0f..2d0b3fcb0ff8 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -9,7 +9,6 @@ config HYPERV
 	select PARAVIRT
 	select X86_HV_CALLBACK_VECTOR if X86
 	select OF_EARLY_FLATTREE if OF
-	select SYSFB if EFI && !HYPERV_VTL_MODE
 	select IRQ_MSI_LIB if X86
 	help
 	  Select this option to run Linux as a Hyper-V client operating
@@ -62,6 +61,7 @@ config HYPERV_VMBUS
 	tristate "Microsoft Hyper-V VMBus driver"
 	depends on HYPERV
 	default HYPERV
+	select SYSFB if EFI && !HYPERV_VTL_MODE
 	help
 	  Select this option to enable Hyper-V Vmbus driver.
 
diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
index dddbd2463f8d..76f3e1da68d0 100644
--- a/drivers/hwmon/corsair-psu.c
+++ b/drivers/hwmon/corsair-psu.c
@@ -796,13 +796,13 @@ static int corsairpsu_probe(struct hid_device *hdev, const struct hid_device_id
 	ret = corsairpsu_init(priv);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "unable to initialize device (%d)\n", ret);
-		goto fail_and_stop;
+		goto fail_and_close;
 	}
 
 	ret = corsairpsu_fwinfo(priv);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "unable to query firmware (%d)\n", ret);
-		goto fail_and_stop;
+		goto fail_and_close;
 	}
 
 	corsairpsu_get_criticals(priv);
diff --git a/drivers/hwmon/ltc2992.c b/drivers/hwmon/ltc2992.c
index 1fcd320d6161..2617c4538af9 100644
--- a/drivers/hwmon/ltc2992.c
+++ b/drivers/hwmon/ltc2992.c
@@ -431,10 +431,16 @@ static int ltc2992_get_voltage(struct ltc2992_state *st, u32 reg, u32 scale, lon
 
 static int ltc2992_set_voltage(struct ltc2992_state *st, u32 reg, u32 scale, long val)
 {
-	val = DIV_ROUND_CLOSEST(val * 1000, scale);
-	val = val << 4;
+	u32 reg_val;
+	long vmax;
+
+	vmax = DIV_ROUND_CLOSEST_ULL(0xFFFULL * scale, 1000);
+	val = max(val, 0L);
+	val = min(val, vmax);
+	reg_val = min(DIV_ROUND_CLOSEST_ULL((u64)val * 1000, scale),
+		      0xFFFULL) << 4;
 
-	return ltc2992_write_reg(st, reg, 2, val);
+	return ltc2992_write_reg(st, reg, 2, reg_val);
 }
 
 static int ltc2992_read_gpio_alarm(struct ltc2992_state *st, int nr_gpio, u32 attr, long *val)
@@ -559,9 +565,15 @@ static int ltc2992_get_current(struct ltc2992_state *st, u32 reg, u32 channel, l
 static int ltc2992_set_current(struct ltc2992_state *st, u32 reg, u32 channel, long val)
 {
 	u32 reg_val;
+	long cmax;
 
-	reg_val = DIV_ROUND_CLOSEST(val * st->r_sense_uohm[channel], LTC2992_IADC_NANOV_LSB);
-	reg_val = reg_val << 4;
+	cmax = DIV_ROUND_CLOSEST_ULL(0xFFFULL * LTC2992_IADC_NANOV_LSB,
+				     st->r_sense_uohm[channel]);
+	val = max(val, 0L);
+	val = min(val, cmax);
+	reg_val = min(DIV_ROUND_CLOSEST_ULL((u64)val * st->r_sense_uohm[channel],
+					    LTC2992_IADC_NANOV_LSB),
+		      0xFFFULL) << 4;
 
 	return ltc2992_write_reg(st, reg, 2, reg_val);
 }
@@ -625,8 +637,10 @@ static int ltc2992_get_power(struct ltc2992_state *st, u32 reg, u32 channel, lon
 	if (reg_val < 0)
 		return reg_val;
 
-	*val = mul_u64_u32_div(reg_val, LTC2992_VADC_UV_LSB * LTC2992_IADC_NANOV_LSB,
-			       st->r_sense_uohm[channel] * 1000);
+	*val = mul_u64_u32_div(reg_val,
+			       LTC2992_VADC_UV_LSB / 1000 *
+			       LTC2992_IADC_NANOV_LSB,
+			       st->r_sense_uohm[channel]);
 
 	return 0;
 }
@@ -634,9 +648,18 @@ static int ltc2992_get_power(struct ltc2992_state *st, u32 reg, u32 channel, lon
 static int ltc2992_set_power(struct ltc2992_state *st, u32 reg, u32 channel, long val)
 {
 	u32 reg_val;
-
-	reg_val = mul_u64_u32_div(val, st->r_sense_uohm[channel] * 1000,
-				  LTC2992_VADC_UV_LSB * LTC2992_IADC_NANOV_LSB);
+	u64 pmax, uval;
+
+	uval = max(val, 0L);
+	pmax = mul_u64_u32_div(0xFFFFFFULL,
+			       LTC2992_VADC_UV_LSB / 1000 *
+			       LTC2992_IADC_NANOV_LSB,
+			       st->r_sense_uohm[channel]);
+	uval = min(uval, pmax);
+	reg_val = min(mul_u64_u32_div(uval, st->r_sense_uohm[channel],
+				      LTC2992_VADC_UV_LSB / 1000 *
+				      LTC2992_IADC_NANOV_LSB),
+		      0xFFFFFFULL);
 
 	return ltc2992_write_reg(st, reg, 3, reg_val);
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 5f7ea6c16644..44300f7db5b1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1178,6 +1178,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 	struct hns_roce_ib_create_qp_resp resp = {};
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_ib_create_qp ucmd = {};
+	unsigned long flags;
 	int ret;
 
 	mutex_init(&hr_qp->mutex);
@@ -1264,7 +1265,13 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 	return 0;
 
 err_flow_ctrl:
+	spin_lock_irqsave(&hr_dev->qp_list_lock, flags);
+	hns_roce_lock_cqs(init_attr->send_cq ? to_hr_cq(init_attr->send_cq) : NULL,
+			  init_attr->recv_cq ? to_hr_cq(init_attr->recv_cq) : NULL);
 	hns_roce_qp_remove(hr_dev, hr_qp);
+	hns_roce_unlock_cqs(init_attr->send_cq ? to_hr_cq(init_attr->send_cq) : NULL,
+			    init_attr->recv_cq ? to_hr_cq(init_attr->recv_cq) : NULL);
+	spin_unlock_irqrestore(&hr_dev->qp_list_lock, flags);
 err_store:
 	free_qpc(hr_dev, hr_qp);
 err_qpc:
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.c b/drivers/infiniband/hw/ionic/ionic_ibdev.c
index bd4c73e530d0..73a616ae3502 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.c
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.c
@@ -185,7 +185,7 @@ static ssize_t hca_type_show(struct device *device,
 	struct ionic_ibdev *dev =
 		rdma_device_to_drv_device(device, struct ionic_ibdev, ibdev);
 
-	return sysfs_emit(buf, "%s\n", dev->ibdev.node_desc);
+	return sysfs_emit(buf, "%.64s\n", dev->ibdev.node_desc);
 }
 static DEVICE_ATTR_RO(hca_type);
 
diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index b2749f971cd0..25e5b904e7c8 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -142,8 +142,9 @@ int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *cq)
 
 	if (cq->queue.id >= gc->max_num_cqs)
 		return -EINVAL;
-	/* Create CQ table entry */
-	WARN_ON(gc->cq_table[cq->queue.id]);
+	/* Create CQ table entry, sharing a CQ between WQs is not supported */
+	if (gc->cq_table[cq->queue.id])
+		return -EINVAL;
 	if (cq->queue.kmem)
 		gdma_cq = cq->queue.kmem;
 	else
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index c8a7129bbad5..123e298dcb85 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -21,6 +21,9 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
 
 	gc = mdev_to_gc(dev);
 
+	if (rx_hash_key_len > sizeof(req->hashkey))
+		return -EINVAL;
+
 	req_buf_size = struct_size(req, indir_tab, MANA_INDIRECT_TABLE_DEF_SIZE);
 	req = kzalloc(req_buf_size, GFP_KERNEL);
 	if (!req)
@@ -193,11 +196,8 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 
 		ret = mana_create_wq_obj(mpc, mpc->port_handle, GDMA_RQ,
 					 &wq_spec, &cq_spec, &wq->rx_object);
-		if (ret) {
-			/* Do cleanup starting with index i-1 */
-			i--;
+		if (ret)
 			goto fail;
-		}
 
 		/* The GDMA regions are now owned by the WQ object */
 		wq->queue.gdma_region = GDMA_INVALID_DMA_REGION;
@@ -217,8 +217,10 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 
 		/* Create CQ table entry */
 		ret = mana_ib_install_cq_cb(mdev, cq);
-		if (ret)
+		if (ret) {
+			mana_destroy_wq_obj(mpc, GDMA_RQ, wq->rx_object);
 			goto fail;
+		}
 	}
 	resp.num_entries = i;
 
@@ -235,13 +237,15 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		ibdev_dbg(&mdev->ib_dev,
 			  "Failed to copy to udata create rss-qp, %d\n",
 			  ret);
-		goto fail;
+		goto err_disable_vport_rx;
 	}
 
 	kfree(mana_ind_table);
 
 	return 0;
 
+err_disable_vport_rx:
+	mana_disable_vport_rx(mpc);
 fail:
 	while (i-- > 0) {
 		ibwq = ind_tbl->ind_tbl[i];
diff --git a/drivers/infiniband/hw/mlx4/srq.c b/drivers/infiniband/hw/mlx4/srq.c
index c4cf91235eee..68e8b04c5388 100644
--- a/drivers/infiniband/hw/mlx4/srq.c
+++ b/drivers/infiniband/hw/mlx4/srq.c
@@ -193,13 +193,15 @@ int mlx4_ib_create_srq(struct ib_srq *ib_srq,
 	if (udata)
 		if (ib_copy_to_udata(udata, &srq->msrq.srqn, sizeof (__u32))) {
 			err = -EFAULT;
-			goto err_wrid;
+			goto err_srq;
 		}
 
 	init_attr->attr.max_wr = srq->msrq.max - 1;
 
 	return 0;
 
+err_srq:
+	mlx4_srq_free(dev->dev, &srq->msrq);
 err_wrid:
 	if (udata)
 		mlx4_ib_db_unmap_user(ucontext, &srq->db);
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 635002e684a5..356a7c7856e7 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3380,6 +3380,7 @@ int mlx5_ib_dev_res_srq_init(struct mlx5_ib_dev *dev)
 			    "Couldn't create SRQ 1 for res init, err=%pe\n",
 			    s1);
 		ib_destroy_srq(s0);
+		goto unlock;
 	}
 
 	devr->s0 = s0;
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index e89be2fbd5eb..ea04b8cace99 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -620,9 +620,9 @@ static int ocrdma_copy_pd_uresp(struct ocrdma_dev *dev, struct ocrdma_pd *pd,
 
 ucopy_err:
 	if (pd->dpp_enabled)
-		ocrdma_del_mmap(pd->uctx, dpp_page_addr, PAGE_SIZE);
+		ocrdma_del_mmap(uctx, dpp_page_addr, PAGE_SIZE);
 dpp_map_err:
-	ocrdma_del_mmap(pd->uctx, db_page_addr, db_page_size);
+	ocrdma_del_mmap(uctx, db_page_addr, db_page_size);
 	return status;
 }
 
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
index bcd43dc30e21..c7c2b41060e5 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
@@ -322,7 +322,7 @@ int pvrdma_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 	uresp.qp_tab_size = vdev->dsr->caps.max_qp;
 	ret = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
 	if (ret) {
-		pvrdma_uar_free(vdev, &context->uar);
+		/* pvrdma_dealloc_ucontext() also frees the UAR */
 		pvrdma_dealloc_ucontext(&context->ibucontext);
 		return -EFAULT;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index f79214738c2b..2d5e701ff961 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -330,6 +330,17 @@ void rxe_rcv(struct sk_buff *skb)
 	pkt->qp = NULL;
 	pkt->mask |= rxe_opcode[pkt->opcode].mask;
 
+	/*
+	 * Unknown opcodes have a zero-initialized rxe_opcode[] entry, so
+	 * both mask and length are 0.  Reject them before any length math:
+	 * rxe_icrc_hdr() would otherwise compute length - RXE_BTH_BYTES
+	 * and pass the underflowed value to rxe_crc32(), producing an
+	 * out-of-bounds read.
+	 */
+	if (unlikely(!rxe_opcode[pkt->opcode].mask ||
+		     !rxe_opcode[pkt->opcode].length))
+		goto drop;
+
 	if (unlikely(pkt->paylen < header_size(pkt) + bth_pad(pkt) +
 		       RXE_ICRC_SIZE))
 		goto drop;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 711f73e0bbb1..09ba21d0f3c4 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -526,7 +526,19 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	}
 
 skip_check_range:
-	if (pkt->mask & (RXE_WRITE_MASK | RXE_ATOMIC_WRITE_MASK)) {
+	if (pkt->mask & RXE_ATOMIC_WRITE_MASK) {
+		/* IBA oA19-28: ATOMIC_WRITE payload is exactly 8 bytes.
+		 * Reject any other length before the responder reads
+		 * sizeof(u64) bytes from payload_addr(pkt); a shorter
+		 * payload would read past the logical end of the packet
+		 * into skb->head tailroom.
+		 */
+		if (resid != sizeof(u64) || pktlen != sizeof(u64) ||
+		    bth_pad(pkt)) {
+			state = RESPST_ERR_LENGTH;
+			goto err;
+		}
+	} else if (pkt->mask & RXE_WRITE_MASK) {
 		if (resid > mtu) {
 			if (pktlen != mtu || bth_pad(pkt)) {
 				state = RESPST_ERR_LENGTH;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 4d00d796f078..606abe051e68 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1236,6 +1236,13 @@ void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer, __le64 *entry,
 	__le64 unused_update[NUM_ENTRY_QWORDS];
 	u8 used_qword_diff;
 
+	/*
+	 * Many of the entry structures have pointers to other structures that
+	 * need to have their updates be visible before any writes of the entry
+	 * happen.
+	 */
+	dma_wmb();
+
 	used_qword_diff =
 		arm_smmu_entry_qword_diff(writer, entry, target, unused_update);
 	if (hweight8(used_qword_diff) == 1) {
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 2b979bec56ce..16c82ba47d30 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -148,6 +148,7 @@ static int intel_nested_set_dev_pasid(struct iommu_domain *domain,
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct iommu_domain *s2_domain = &dmar_domain->s2_domain->domain;
 	struct intel_iommu *iommu = info->iommu;
 	struct dev_pasid_info *dev_pasid;
 	int ret;
@@ -155,10 +156,13 @@ static int intel_nested_set_dev_pasid(struct iommu_domain *domain,
 	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
 		return -EOPNOTSUPP;
 
+	if (s2_domain->dirty_ops)
+		return -EINVAL;
+
 	if (context_copied(iommu, info->bus, info->devfn))
 		return -EBUSY;
 
-	ret = paging_domain_compatible(&dmar_domain->s2_domain->domain, dev);
+	ret = paging_domain_compatible(s2_domain, dev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index f1e686b3a265..710eef0b6004 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -187,9 +187,10 @@ static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *b
 
 	mutex_lock(&fault->mutex);
 	while (count > done) {
-		rc = copy_from_user(&response, buf + done, response_size);
-		if (rc)
+		if (copy_from_user(&response, buf + done, response_size)) {
+			rc = -EFAULT;
 			break;
+		}
 
 		static_assert((int)IOMMUFD_PAGE_RESP_SUCCESS ==
 			      (int)IOMMU_PAGE_RESP_SUCCESS);
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index ee003bb2f647..24d4917105d9 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -814,6 +814,16 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 		unmapped_bytes += area_last - area_first + 1;
 
 		down_write(&iopt->iova_rwsem);
+
+		/*
+		 * After releasing the iova_rwsem concurrent allocation could
+		 * place new areas at IOVAs we have already unmapped. Keep
+		 * moving the start of the search forward to ignore the area
+		 * already unmapped.
+		 */
+		if (area_last >= last)
+			break;
+		start = area_last + 1;
 	}
 
 out_unlock_iova:
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 3ab8b4beff86..e0c574862d06 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -384,7 +384,7 @@ static void dm_hash_remove_all(bool keep_open_devices, bool mark_deferred, bool
 
 	up_write(&_hash_lock);
 
-	if (dev_skipped)
+	if (dev_skipped && !only_deferred)
 		DMWARN("remove_all left %d open device(s)", dev_skipped);
 }
 
@@ -1341,6 +1341,10 @@ static void retrieve_status(struct dm_table *table,
 		used = param->data_start + (outptr - outbuf);
 
 		outptr = align_ptr(outptr);
+		if (!outptr || outptr > outbuf + len) {
+			param->flags |= DM_BUFFER_FULL_FLAG;
+			break;
+		}
 		spec->next = outptr - outbuf;
 	}
 
diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index 14be4d888af3..e5d38bb3f16f 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -33,36 +33,6 @@ static inline u64 fec_interleave(struct dm_verity *v, u64 offset)
 	return offset + mod * (v->fec->rounds << v->data_dev_block_bits);
 }
 
-/*
- * Read error-correcting codes for the requested RS block. Returns a pointer
- * to the data block. Caller is responsible for releasing buf.
- */
-static u8 *fec_read_parity(struct dm_verity *v, u64 rsb, int index,
-			   unsigned int *offset, unsigned int par_buf_offset,
-			   struct dm_buffer **buf, unsigned short ioprio)
-{
-	u64 position, block, rem;
-	u8 *res;
-
-	/* We have already part of parity bytes read, skip to the next block */
-	if (par_buf_offset)
-		index++;
-
-	position = (index + rsb) * v->fec->roots;
-	block = div64_u64_rem(position, v->fec->io_size, &rem);
-	*offset = par_buf_offset ? 0 : (unsigned int)rem;
-
-	res = dm_bufio_read_with_ioprio(v->fec->bufio, block, buf, ioprio);
-	if (IS_ERR(res)) {
-		DMERR("%s: FEC %llu: parity read failed (block %llu): %ld",
-		      v->data_dev->name, (unsigned long long)rsb,
-		      (unsigned long long)block, PTR_ERR(res));
-		*buf = NULL;
-	}
-
-	return res;
-}
-
 /* Loop over each allocated buffer. */
 #define fec_for_each_buffer(io, __i) \
 	for (__i = 0; __i < (io)->nbufs; __i++)
@@ -102,15 +72,29 @@ static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_io *io,
 {
 	int r, corrected = 0, res;
 	struct dm_buffer *buf;
-	unsigned int n, i, j, offset, par_buf_offset = 0;
+	unsigned int n, i, j, parity_pos, to_copy;
 	uint16_t par_buf[DM_VERITY_FEC_RSM - DM_VERITY_FEC_MIN_RSN];
 	u8 *par, *block;
+	u64 parity_block;
 	struct bio *bio = dm_bio_from_per_bio_data(io, v->ti->per_io_data_size);
 
-	par = fec_read_parity(v, rsb, block_offset, &offset,
-			      par_buf_offset, &buf, bio->bi_ioprio);
-	if (IS_ERR(par))
+	/*
+	 * Compute the index of the first parity block that will be needed and
+	 * the starting position in that block.  Then read that block.
+	 *
+	 * io_size is always a power of 2, but roots might not be.  Note that
+	 * when it's not, a codeword's parity bytes can span a block boundary.
+	 */
+	parity_block = (rsb + block_offset) * v->fec->roots;
+	parity_pos = parity_block & (v->fec->io_size - 1);
+	parity_block >>= v->data_dev_block_bits;
+	par = dm_bufio_read_with_ioprio(v->fec->bufio, parity_block, &buf,
+					bio->bi_ioprio);
+	if (IS_ERR(par)) {
+		DMERR("%s: FEC %llu: parity read failed (block %llu): %ld",
+		      v->data_dev->name, rsb, parity_block, PTR_ERR(par));
 		return PTR_ERR(par);
+	}
 
 	/*
 	 * Decode the RS blocks we have in bufs. Each RS block results in
@@ -118,8 +102,32 @@ static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_io *io,
 	 */
 	fec_for_each_buffer_rs_block(fio, n, i) {
 		block = fec_buffer_rs_block(v, fio, n, i);
-		for (j = 0; j < v->fec->roots - par_buf_offset; j++)
-			par_buf[par_buf_offset + j] = par[offset + j];
+
+		/*
+		 * Copy the next 'roots' parity bytes to 'par_buf', reading
+		 * another parity block if needed.
+		 */
+		to_copy = min(v->fec->io_size - parity_pos, v->fec->roots);
+		for (j = 0; j < to_copy; j++)
+			par_buf[j] = par[parity_pos++];
+		if (to_copy < v->fec->roots) {
+			parity_block++;
+			parity_pos = 0;
+
+			dm_bufio_release(buf);
+			par = dm_bufio_read_with_ioprio(v->fec->bufio,
+							parity_block, &buf,
+							bio->bi_ioprio);
+			if (IS_ERR(par)) {
+				DMERR("%s: FEC %llu: parity read failed (block %llu): %ld",
+				      v->data_dev->name, rsb, parity_block,
+				      PTR_ERR(par));
+				return PTR_ERR(par);
+			}
+			for (; j < v->fec->roots; j++)
+				par_buf[j] = par[parity_pos++];
+		}
+
 		/* Decode an RS block using Reed-Solomon */
 		res = decode_rs8(fio->rs, block, par_buf, v->fec->rsn,
 				 NULL, neras, fio->erasures, 0, NULL);
@@ -134,26 +142,6 @@ static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_io *io,
 		block_offset++;
 		if (block_offset >= 1 << v->data_dev_block_bits)
 			goto done;
-
-		/* Read the next block when we run out of parity bytes */
-		offset += (v->fec->roots - par_buf_offset);
-		/* Check if parity bytes are split between blocks */
-		if (offset < v->fec->io_size && (offset + v->fec->roots) > v->fec->io_size) {
-			par_buf_offset = v->fec->io_size - offset;
-			for (j = 0; j < par_buf_offset; j++)
-				par_buf[j] = par[offset + j];
-			offset += par_buf_offset;
-		} else
-			par_buf_offset = 0;
-
-		if (offset >= v->fec->io_size) {
-			dm_bufio_release(buf);
-
-			par = fec_read_parity(v, rsb, block_offset, &offset,
-					      par_buf_offset, &buf, bio->bi_ioprio);
-			if (IS_ERR(par))
-				return PTR_ERR(par);
-		}
 	}
 done:
 	r = corrected;
@@ -163,11 +151,9 @@ static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_io *io,
 	if (r < 0 && neras)
 		DMERR_LIMIT("%s: FEC %llu: failed to correct: %d",
 			    v->data_dev->name, (unsigned long long)rsb, r);
-	else if (r > 0) {
+	else if (r > 0)
 		DMWARN_LIMIT("%s: FEC %llu: corrected %d errors",
 			     v->data_dev->name, (unsigned long long)rsb, r);
-		atomic64_inc(&v->fec->corrected);
-	}
 
 	return r;
 }
@@ -439,6 +425,7 @@ int verity_fec_decode(struct dm_verity *v, struct dm_verity_io *io,
 	}
 
 	memcpy(dest, fio->output, 1 << v->data_dev_block_bits);
+	atomic64_inc(&v->fec->corrected);
 
 done:
 	fio->level--;
@@ -625,7 +612,7 @@ int verity_fec_ctr(struct dm_verity *v)
 {
 	struct dm_verity_fec *f = v->fec;
 	struct dm_target *ti = v->ti;
-	u64 hash_blocks, fec_blocks;
+	u64 hash_blocks;
 	int ret;
 
 	if (!verity_fec_is_enabled(v)) {
@@ -688,7 +675,8 @@ int verity_fec_ctr(struct dm_verity *v)
 	 * it to be large enough.
 	 */
 	f->hash_blocks = f->blocks - v->data_blocks;
-	if (dm_bufio_get_device_size(v->bufio) < f->hash_blocks) {
+	if (dm_bufio_get_device_size(v->bufio) <
+	    v->hash_start + f->hash_blocks) {
 		ti->error = "Hash device is too small for "
 			DM_VERITY_OPT_FEC_BLOCKS;
 		return -E2BIG;
@@ -706,8 +694,7 @@ int verity_fec_ctr(struct dm_verity *v)
 
 	dm_bufio_set_sector_offset(f->bufio, f->start << (v->data_dev_block_bits - SECTOR_SHIFT));
 
-	fec_blocks = div64_u64(f->rounds * f->roots, v->fec->roots << SECTOR_SHIFT);
-	if (dm_bufio_get_device_size(f->bufio) < fec_blocks) {
+	if (dm_bufio_get_device_size(f->bufio) < f->rounds * f->roots) {
 		ti->error = "FEC device is too small";
 		return -E2BIG;
 	}
diff --git a/drivers/md/dm-verity-fec.h b/drivers/md/dm-verity-fec.h
index 35d28d9f8a9b..32ca2bfee1db 100644
--- a/drivers/md/dm-verity-fec.h
+++ b/drivers/md/dm-verity-fec.h
@@ -47,7 +47,8 @@ struct dm_verity_fec {
 /* per-bio data */
 struct dm_verity_fec_io {
 	struct rs_control *rs;	/* Reed-Solomon state */
-	int erasures[DM_VERITY_FEC_MAX_RSN];	/* erasures for decode_rs8 */
+	/* erasures for decode_rs8 */
+	int erasures[DM_VERITY_FEC_RSM - DM_VERITY_FEC_MIN_RSN + 1];
 	u8 *output;		/* buffer for corrected output */
 	unsigned int level;		/* recursion level */
 	unsigned int nbufs;		/* number of buffers allocated */
diff --git a/drivers/md/persistent-data/dm-btree-remove.c b/drivers/md/persistent-data/dm-btree-remove.c
index 942cd47eb52d..aeec5b9a1dd5 100644
--- a/drivers/md/persistent-data/dm-btree-remove.c
+++ b/drivers/md/persistent-data/dm-btree-remove.c
@@ -490,12 +490,20 @@ static int rebalance_children(struct shadow_spine *s,
 
 	if (le32_to_cpu(n->header.nr_entries) == 1) {
 		struct dm_block *child;
+		int is_shared;
 		dm_block_t b = value64(n, 0);
 
+		r = dm_tm_block_is_shared(info->tm, b, &is_shared);
+		if (r)
+			return r;
+
 		r = dm_tm_read_lock(info->tm, b, &btree_node_validator, &child);
 		if (r)
 			return r;
 
+		if (is_shared)
+			inc_children(info->tm, dm_block_data(child), vt);
+
 		memcpy(n, dm_block_data(child),
 		       dm_bm_block_size(dm_tm_get_bm(info->tm)));
 
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 12cbeec026c5..698d169628a0 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3791,6 +3791,8 @@ static int setup_geo(struct geom *geo, struct mddev *mddev, enum geo_type new)
 	nc = layout & 255;
 	fc = (layout >> 8) & 255;
 	fo = layout & (1<<16);
+	if (!nc || !fc)
+		return -1;
 	geo->raid_disks = disks;
 	geo->near_copies = nc;
 	geo->far_copies = fc;
diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index 1200951bab08..a7c364d0030a 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -89,6 +89,7 @@ struct mmc_fixup {
 #define CID_MANFID_MICRON       0x13
 #define CID_MANFID_SAMSUNG      0x15
 #define CID_MANFID_APACER       0x27
+#define CID_MANFID_SANDISK_MMC  0x45
 #define CID_MANFID_SWISSBIT     0x5D
 #define CID_MANFID_KINGSTON     0x70
 #define CID_MANFID_HYNIX	0x90
@@ -305,4 +306,14 @@ static inline int mmc_card_no_uhs_ddr50_tuning(const struct mmc_card *c)
 	return c->quirks & MMC_QUIRK_NO_UHS_DDR50_TUNING;
 }
 
+static inline int mmc_card_broken_mdt(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_BROKEN_MDT;
+}
+
+static inline int mmc_card_fixed_secure_erase_trim_time(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME;
+}
+
 #endif
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 7c86efb1044a..8846550a8892 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -671,7 +671,19 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		card->ext_csd.enhanced_rpmb_supported =
 					(card->ext_csd.rel_param &
 					 EXT_CSD_WR_REL_PARAM_EN_RPMB_REL_WR);
+
+		if (card->ext_csd.rev >= 9) {
+			/* Adjust production date as per JEDEC JESD84-B51B September 2025 */
+			if (card->cid.year < 2023)
+				card->cid.year += 16;
+		} else {
+			/* Handle vendors with broken MDT reporting */
+			if (mmc_card_broken_mdt(card) && card->cid.year >= 2010 &&
+			    card->cid.year <= 2012)
+				card->cid.year += 16;
+		}
 	}
+
 out:
 	return err;
 }
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 13000fc57e2e..39fcb662c43f 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -184,8 +184,13 @@ static void mmc_queue_setup_discard(struct mmc_card *card,
 		return;
 
 	lim->max_hw_discard_sectors = max_discard;
-	if (mmc_card_can_secure_erase_trim(card))
-		lim->max_secure_erase_sectors = max_discard;
+	if (mmc_card_can_secure_erase_trim(card)) {
+		if (mmc_card_fixed_secure_erase_trim_time(card))
+			lim->max_secure_erase_sectors = UINT_MAX >> card->erase_shift;
+		else
+			lim->max_secure_erase_sectors = max_discard;
+	}
+
 	if (mmc_card_can_trim(card) && card->erased_byte == 0)
 		lim->max_write_zeroes_sectors = max_discard;
 
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index c417ed34c057..6f727b4a60a5 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -153,6 +153,15 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
 	MMC_FIXUP("M62704", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
 		  MMC_QUIRK_TRIM_BROKEN),
 
+	/*
+	 * On Some Kingston eMMCs, secure erase/trim time is independent
+	 * of erase size, fixed at approximately 2 seconds.
+	 */
+	MMC_FIXUP("IY2964", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
+		  MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME),
+	MMC_FIXUP("IB2932", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
+		  MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME),
+
 	END_FIXUP
 };
 
@@ -170,6 +179,9 @@ static const struct mmc_fixup __maybe_unused mmc_ext_csd_fixups[] = {
 	MMC_FIXUP_EXT_CSD_REV(CID_NAME_ANY, CID_MANFID_NUMONYX,
 			      0x014e, add_quirk, MMC_QUIRK_BROKEN_HPI, 6),
 
+	MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK_MMC, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_BROKEN_MDT),
+
 	END_FIXUP
 };
 
diff --git a/drivers/mtd/spi-nor/debugfs.c b/drivers/mtd/spi-nor/debugfs.c
index fa6956144d2e..14ba1680c315 100644
--- a/drivers/mtd/spi-nor/debugfs.c
+++ b/drivers/mtd/spi-nor/debugfs.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/array_size.h>
 #include <linux/debugfs.h>
 #include <linux/mtd/spi-nor.h>
 #include <linux/spi/spi.h>
@@ -92,7 +93,8 @@ static int spi_nor_params_show(struct seq_file *s, void *data)
 	seq_printf(s, "address nbytes\t%u\n", nor->addr_nbytes);
 
 	seq_puts(s, "flags\t\t");
-	spi_nor_print_flags(s, nor->flags, snor_f_names, sizeof(snor_f_names));
+	spi_nor_print_flags(s, nor->flags, snor_f_names,
+			    ARRAY_SIZE(snor_f_names));
 	seq_puts(s, "\n");
 
 	seq_puts(s, "\nopcodes\n");
diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 4d6b9e83e341..b813dd9b39ed 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1756,6 +1756,27 @@ static int ibmveth_set_mac_addr(struct net_device *dev, void *p)
 	return 0;
 }
 
+static netdev_features_t ibmveth_features_check(struct sk_buff *skb,
+						struct net_device *dev,
+						netdev_features_t features)
+{
+	/* Some physical adapters do not support segmentation offload with
+	 * MSS < 224. Disable GSO for such packets to avoid adapter freeze.
+	 * Note: Single-segment packets (gso_segs == 1) don't need this check
+	 * as they bypass the LSO path and are transmitted without segmentation.
+	 */
+	if (skb_is_gso(skb)) {
+		if (skb_shinfo(skb)->gso_size < IBMVETH_MIN_LSO_MSS) {
+			netdev_warn_once(dev,
+					 "MSS %u too small for LSO, disabling GSO\n",
+					 skb_shinfo(skb)->gso_size);
+			features &= ~NETIF_F_GSO_MASK;
+		}
+	}
+
+	return vlan_features_check(skb, features);
+}
+
 static const struct net_device_ops ibmveth_netdev_ops = {
 	.ndo_open		= ibmveth_open,
 	.ndo_stop		= ibmveth_close,
@@ -1767,6 +1788,7 @@ static const struct net_device_ops ibmveth_netdev_ops = {
 	.ndo_set_features	= ibmveth_set_features,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address    = ibmveth_set_mac_addr,
+	.ndo_features_check	= ibmveth_features_check,
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller	= ibmveth_poll_controller,
 #endif
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index 068f99df133e..d87713668ed3 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -37,6 +37,7 @@
 #define IBMVETH_ILLAN_IPV4_TCP_CSUM		0x0000000000000002UL
 #define IBMVETH_ILLAN_ACTIVE_TRUNK		0x0000000000000001UL
 
+#define IBMVETH_MIN_LSO_MSS		224	/* Minimum MSS for LSO */
 /* hcall macros */
 #define h_register_logical_lan(ua, buflst, rxq, fltlst, mac) \
   plpar_hcall_norets(H_REGISTER_LOGICAL_LAN, ua, buflst, rxq, fltlst, mac)
diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index 2cf04bc6edce..a730aa368c92 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -305,6 +305,8 @@ ice_sf_eth_activate(struct ice_dynamic_port *dyn_port,
 
 aux_dev_uninit:
 	auxiliary_device_uninit(&sf_dev->adev);
+	return err;
+
 sf_dev_free:
 	kfree(sf_dev);
 xa_erase:
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
index b579d5b545c4..8347e696937c 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
@@ -409,10 +409,17 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 			data_offset = OCTEP_VF_OQ_RESP_HW_SIZE;
 			rx_ol_flags = 0;
 		}
-		rx_bytes += buff_info->len;
-
 		if (buff_info->len <= oq->max_single_buffer_size) {
 			skb = napi_build_skb((void *)resp_hw, PAGE_SIZE);
+			if (!skb) {
+				oq->stats->alloc_failures++;
+				desc_used++;
+				read_idx++;
+				if (read_idx == oq->max_count)
+					read_idx = 0;
+				continue;
+			}
+			rx_bytes += buff_info->len;
 			skb_reserve(skb, data_offset);
 			skb_put(skb, buff_info->len);
 			read_idx++;
@@ -424,6 +431,31 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 			u16 data_len;
 
 			skb = napi_build_skb((void *)resp_hw, PAGE_SIZE);
+			if (!skb) {
+				oq->stats->alloc_failures++;
+				desc_used++;
+				read_idx++;
+				if (read_idx == oq->max_count)
+					read_idx = 0;
+				data_len = buff_info->len - oq->max_single_buffer_size;
+				while (data_len) {
+					dma_unmap_page(oq->dev, oq->desc_ring[read_idx].buffer_ptr,
+						       PAGE_SIZE, DMA_FROM_DEVICE);
+					buff_info = (struct octep_vf_rx_buffer *)
+						    &oq->buff_info[read_idx];
+					buff_info->page = NULL;
+					if (data_len < oq->buffer_size)
+						data_len = 0;
+					else
+						data_len -= oq->buffer_size;
+					desc_used++;
+					read_idx++;
+					if (read_idx == oq->max_count)
+						read_idx = 0;
+				}
+				continue;
+			}
+			rx_bytes += buff_info->len;
 			skb_reserve(skb, data_offset);
 			/* Head fragment includes response header(s);
 			 * subsequent fragments contains only data.
diff --git a/drivers/net/ethernet/mellanox/mlx4/srq.c b/drivers/net/ethernet/mellanox/mlx4/srq.c
index dd890f5d7b72..8711689120f3 100644
--- a/drivers/net/ethernet/mellanox/mlx4/srq.c
+++ b/drivers/net/ethernet/mellanox/mlx4/srq.c
@@ -44,13 +44,14 @@ void mlx4_srq_event(struct mlx4_dev *dev, u32 srqn, int event_type)
 {
 	struct mlx4_srq_table *srq_table = &mlx4_priv(dev)->srq_table;
 	struct mlx4_srq *srq;
+	unsigned long flags;
 
-	rcu_read_lock();
+	spin_lock_irqsave(&srq_table->lock, flags);
 	srq = radix_tree_lookup(&srq_table->tree, srqn & (dev->caps.num_srqs - 1));
-	rcu_read_unlock();
-	if (srq)
-		refcount_inc(&srq->refcount);
-	else {
+	if (!srq || !refcount_inc_not_zero(&srq->refcount))
+		srq = NULL;
+	spin_unlock_irqrestore(&srq_table->lock, flags);
+	if (!srq) {
 		mlx4_warn(dev, "Async event for bogus SRQ %08x\n", srqn);
 		return;
 	}
@@ -203,8 +204,8 @@ int mlx4_srq_alloc(struct mlx4_dev *dev, u32 pdn, u32 cqn, u16 xrcd,
 	if (err)
 		goto err_radix;
 
-	refcount_set(&srq->refcount, 1);
 	init_completion(&srq->free);
+	refcount_set_release(&srq->refcount, 1);
 
 	return 0;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
index 37f9417c7c0e..fc04a23342cf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
@@ -47,7 +47,7 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 
 	while (len != 0) {
 		tx_q->tx_skbuff[entry] = NULL;
-		entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
+		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
 		desc = tx_q->dma_tx + entry;
 
 		if (len > bmax) {
diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index d26e8a063022..bd0fb5142d66 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -63,7 +63,7 @@ static inline bool dwmac_is_xmac(enum dwmac_core_type core_type)
 #define DMA_MIN_RX_SIZE		64
 #define DMA_MAX_RX_SIZE		1024
 #define DMA_DEFAULT_RX_SIZE	512
-#define STMMAC_GET_ENTRY(x, size)	((x + 1) & (size - 1))
+#define STMMAC_NEXT_ENTRY(x, size)	((x + 1) & (size - 1))
 
 #undef FRAME_FILTER_DEBUG
 /* #define FRAME_FILTER_DEBUG */
diff --git a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
index 382d94a3b972..78fc6aa5bbe9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
@@ -51,7 +51,7 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 		stmmac_prepare_tx_desc(priv, desc, 1, bmax, csum,
 				STMMAC_RING_MODE, 0, false, skb->len);
 		tx_q->tx_skbuff[entry] = NULL;
-		entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
+		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
 
 		if (priv->extend_desc)
 			desc = (struct dma_desc *)(tx_q->dma_etx + entry);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 13d3cac056be..81a6ab19a45b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2744,7 +2744,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		xsk_tx_metadata_to_compl(meta,
 					 &tx_q->tx_skbuff_dma[entry].xsk_meta);
 
-		tx_q->cur_tx = STMMAC_GET_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
+		tx_q->cur_tx = STMMAC_NEXT_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
 		entry = tx_q->cur_tx;
 	}
 	u64_stats_update_begin(&txq_stats->napi_syncp);
@@ -2915,7 +2915,7 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
 
 		stmmac_release_tx_desc(priv, p, priv->mode);
 
-		entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
+		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
 	}
 	tx_q->dirty_tx = entry;
 
@@ -4258,7 +4258,7 @@ static bool stmmac_vlan_insert(struct stmmac_priv *priv, struct sk_buff *skb,
 		return false;
 
 	stmmac_set_tx_owner(priv, p);
-	tx_q->cur_tx = STMMAC_GET_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
+	tx_q->cur_tx = STMMAC_NEXT_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
 	return true;
 }
 
@@ -4286,7 +4286,7 @@ static void stmmac_tso_allocator(struct stmmac_priv *priv, dma_addr_t des,
 	while (tmp_len > 0) {
 		dma_addr_t curr_addr;
 
-		tx_q->cur_tx = STMMAC_GET_ENTRY(tx_q->cur_tx,
+		tx_q->cur_tx = STMMAC_NEXT_ENTRY(tx_q->cur_tx,
 						priv->dma_conf.dma_tx_size);
 		WARN_ON(tx_q->tx_skbuff[tx_q->cur_tx]);
 
@@ -4437,7 +4437,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 
 		stmmac_set_mss(priv, mss_desc, mss);
 		tx_q->mss = mss;
-		tx_q->cur_tx = STMMAC_GET_ENTRY(tx_q->cur_tx,
+		tx_q->cur_tx = STMMAC_NEXT_ENTRY(tx_q->cur_tx,
 						priv->dma_conf.dma_tx_size);
 		WARN_ON(tx_q->tx_skbuff[tx_q->cur_tx]);
 	}
@@ -4541,7 +4541,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	 * ndo_start_xmit will fill this descriptor the next time it's
 	 * called and stmmac_tx_clean may clean up to this descriptor.
 	 */
-	tx_q->cur_tx = STMMAC_GET_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
+	tx_q->cur_tx = STMMAC_NEXT_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
 
 	if (unlikely(stmmac_tx_avail(priv, queue) <= (MAX_SKB_FRAGS + 1))) {
 		netif_dbg(priv, hw, priv->dev, "%s: stop transmitted packets\n",
@@ -4751,7 +4751,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		int len = skb_frag_size(frag);
 		bool last_segment = (i == (nfrags - 1));
 
-		entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
+		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
 		WARN_ON(tx_q->tx_skbuff[entry]);
 
 		if (likely(priv->extend_desc))
@@ -4821,7 +4821,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	 * ndo_start_xmit will fill this descriptor the next time it's
 	 * called and stmmac_tx_clean may clean up to this descriptor.
 	 */
-	entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
+	entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
 	tx_q->cur_tx = entry;
 
 	if (netif_msg_pktdata(priv)) {
@@ -4990,7 +4990,7 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
 		dma_wmb();
 		stmmac_set_rx_owner(priv, p, use_rx_wd);
 
-		entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_rx_size);
+		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_rx_size);
 	}
 	rx_q->dirty_rx = entry;
 	rx_q->rx_tail_addr = rx_q->dma_rx_phy +
@@ -5140,7 +5140,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 
 	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
 
-	entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
+	entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
 	tx_q->cur_tx = entry;
 
 	return STMMAC_XDP_TX;
@@ -5374,7 +5374,7 @@ static bool stmmac_rx_refill_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		dma_wmb();
 		stmmac_set_rx_owner(priv, rx_desc, use_rx_wd);
 
-		entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_rx_size);
+		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_rx_size);
 	}
 
 	if (rx_desc) {
@@ -5469,9 +5469,12 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 			break;
 
 		/* Prefetch the next RX descriptor */
-		rx_q->cur_rx = STMMAC_GET_ENTRY(rx_q->cur_rx,
-						priv->dma_conf.dma_rx_size);
-		next_entry = rx_q->cur_rx;
+		next_entry = STMMAC_NEXT_ENTRY(rx_q->cur_rx,
+					       priv->dma_conf.dma_rx_size);
+		if (unlikely(next_entry == rx_q->dirty_rx))
+			break;
+
+		rx_q->cur_rx = next_entry;
 
 		if (priv->extend_desc)
 			np = (struct dma_desc *)(rx_q->dma_erx + next_entry);
@@ -5609,7 +5612,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 	dma_dir = page_pool_get_dma_dir(rx_q->page_pool);
 	bufsz = DIV_ROUND_UP(priv->dma_conf.dma_buf_sz, PAGE_SIZE) * PAGE_SIZE;
-	limit = min(priv->dma_conf.dma_rx_size - 1, (unsigned int)limit);
 
 	if (netif_msg_rx_status(priv)) {
 		void *rx_head;
@@ -5665,9 +5667,12 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		if (unlikely(status & dma_own))
 			break;
 
-		rx_q->cur_rx = STMMAC_GET_ENTRY(rx_q->cur_rx,
-						priv->dma_conf.dma_rx_size);
-		next_entry = rx_q->cur_rx;
+		next_entry = STMMAC_NEXT_ENTRY(rx_q->cur_rx,
+					       priv->dma_conf.dma_rx_size);
+		if (unlikely(next_entry == rx_q->dirty_rx))
+			break;
+
+		rx_q->cur_rx = next_entry;
 
 		if (priv->extend_desc)
 			np = (struct dma_desc *)(rx_q->dma_erx + next_entry);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index bee9e245e792..5315d5c92d0b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2480,8 +2480,11 @@ int wx_sw_init(struct wx *wx)
 	wx->oem_svid = pdev->subsystem_vendor;
 	wx->oem_ssid = pdev->subsystem_device;
 	wx->bus.device = PCI_SLOT(pdev->devfn);
-	wx->bus.func = FIELD_GET(WX_CFG_PORT_ST_LANID,
-				 rd32(wx, WX_CFG_PORT_ST));
+	if (pdev->is_virtfn)
+		wx->bus.func = PCI_FUNC(pdev->devfn);
+	else
+		wx->bus.func = FIELD_GET(WX_CFG_PORT_ST_LANID,
+					 rd32(wx, WX_CFG_PORT_ST));
 
 	if (wx->oem_svid == PCI_VENDOR_ID_WANGXUN ||
 	    pdev->is_virtfn) {
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index ade2bfe563aa..5478f2fdfce8 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -98,8 +98,8 @@ int wx_request_msix_irqs_vf(struct wx *wx)
 		}
 	}
 
-	err = request_threaded_irq(wx->msix_entry->vector, wx_msix_misc_vf,
-				   NULL, IRQF_ONESHOT, netdev->name, wx);
+	err = request_irq(wx->msix_entry->vector, wx_msix_misc_vf,
+			  0, netdev->name, wx);
 	if (err) {
 		wx_err(wx, "request_irq for msix_other failed: %d\n", err);
 		goto free_queue_irqs;
diff --git a/drivers/net/wireless/ath/ath5k/base.c b/drivers/net/wireless/ath/ath5k/base.c
index 05c9c07591fc..6ca31d4ea437 100644
--- a/drivers/net/wireless/ath/ath5k/base.c
+++ b/drivers/net/wireless/ath/ath5k/base.c
@@ -1738,7 +1738,8 @@ ath5k_tx_frame_completed(struct ath5k_hw *ah, struct sk_buff *skb,
 	}
 
 	info->status.rates[ts->ts_final_idx].count = ts->ts_final_retry;
-	info->status.rates[ts->ts_final_idx + 1].idx = -1;
+	if (ts->ts_final_idx + 1 < IEEE80211_TX_MAX_RATES)
+		info->status.rates[ts->ts_final_idx + 1].idx = -1;
 
 	if (unlikely(ts->ts_status)) {
 		ah->stats.ack_fail++;
diff --git a/drivers/net/wireless/broadcom/b43/xmit.c b/drivers/net/wireless/broadcom/b43/xmit.c
index 7651b1bdb592..f0b082596637 100644
--- a/drivers/net/wireless/broadcom/b43/xmit.c
+++ b/drivers/net/wireless/broadcom/b43/xmit.c
@@ -702,7 +702,8 @@ void b43_rx(struct b43_wldev *dev, struct sk_buff *skb, const void *_rxhdr)
 		 * key index, but the ucode passed it slightly different.
 		 */
 		keyidx = b43_kidx_to_raw(dev, keyidx);
-		B43_WARN_ON(keyidx >= ARRAY_SIZE(dev->key));
+		if (B43_WARN_ON(keyidx >= ARRAY_SIZE(dev->key)))
+			goto drop;
 
 		if (dev->key[keyidx].algorithm != B43_SEC_ALGO_NONE) {
 			wlhdr_len = ieee80211_hdrlen(fctl);
diff --git a/drivers/net/wireless/broadcom/b43legacy/xmit.c b/drivers/net/wireless/broadcom/b43legacy/xmit.c
index efd63f4ce74f..ee199d4eaf03 100644
--- a/drivers/net/wireless/broadcom/b43legacy/xmit.c
+++ b/drivers/net/wireless/broadcom/b43legacy/xmit.c
@@ -476,7 +476,8 @@ void b43legacy_rx(struct b43legacy_wldev *dev,
 		 * key index, but the ucode passed it slightly different.
 		 */
 		keyidx = b43legacy_kidx_to_raw(dev, keyidx);
-		B43legacy_WARN_ON(keyidx >= dev->max_nr_keys);
+		if (B43legacy_WARN_ON(keyidx >= dev->max_nr_keys))
+			goto drop;
 
 		if (dev->key[keyidx].algorithm != B43legacy_SEC_ALGO_NONE) {
 			/* Remove PROTECTED flag to mark it as decrypted. */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 30f6fcb68632..8fb595733b9c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -2476,8 +2476,9 @@ static void brcmf_sdio_bus_stop(struct device *dev)
 	brcmf_dbg(TRACE, "Enter\n");
 
 	if (bus->watchdog_tsk) {
+		get_task_struct(bus->watchdog_tsk);
 		send_sig(SIGTERM, bus->watchdog_tsk, 1);
-		kthread_stop(bus->watchdog_tsk);
+		kthread_stop_put(bus->watchdog_tsk);
 		bus->watchdog_tsk = NULL;
 	}
 
@@ -4567,8 +4568,9 @@ void brcmf_sdio_remove(struct brcmf_sdio *bus)
 	if (bus) {
 		/* Stop watchdog task */
 		if (bus->watchdog_tsk) {
+			get_task_struct(bus->watchdog_tsk);
 			send_sig(SIGTERM, bus->watchdog_tsk, 1);
-			kthread_stop(bus->watchdog_tsk);
+			kthread_stop_put(bus->watchdog_tsk);
 			bus->watchdog_tsk = NULL;
 		}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 5fae9a6e273c..021335805acb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -387,10 +387,11 @@ void mt7921_roc_work(struct work_struct *work)
 	phy = (struct mt792x_phy *)container_of(work, struct mt792x_phy,
 						roc_work);
 
-	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
-		return;
-
 	mt792x_mutex_acquire(phy->dev);
+	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state)) {
+		mt792x_mutex_release(phy->dev);
+		return;
+	}
 	ieee80211_iterate_active_interfaces(phy->mt76->hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7921_roc_iter, phy);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 833d0ab64230..8442dbd2ee23 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1353,6 +1353,9 @@ int __mt7921_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 		u16 len = le16_to_cpu(rule->len);
 		u16 offset = len + sizeof(*rule);
 
+		if (buf_len < offset)
+			break;
+
 		pos += offset;
 		buf_len -= offset;
 		if (rule->alpha2[0] != alpha2[0] ||
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 0d9435900423..ebe872f58c88 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -882,8 +882,10 @@ static void mt7925_tx_check_aggr(struct ieee80211_sta *sta, struct sk_buff *skb,
 	else
 		mlink = &msta->deflink;
 
-	if (!test_and_set_bit(tid, &mlink->wcid.ampdu_state))
-		ieee80211_start_tx_ba_session(sta, tid, 0);
+	if (!test_and_set_bit(tid, &mlink->wcid.ampdu_state)) {
+		if (ieee80211_start_tx_ba_session(sta, tid, 0))
+			clear_bit(tid, &mlink->wcid.ampdu_state);
+	}
 }
 
 static bool
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index cf0fdea45cf7..47f91b9f1b95 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -3375,7 +3375,6 @@ __mt7925_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 		u8 rsvd[64];
 	} __packed req = {
 		.tag = cpu_to_le16(0x3),
-		.len = cpu_to_le16(sizeof(req) - 4),
 
 		.idx = idx,
 		.env = env_cap,
@@ -3404,6 +3403,7 @@ __mt7925_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 		memcpy(req.type, rule->type, 2);
 
 		req.size = cpu_to_le16(seg->len);
+		req.len = cpu_to_le16(sizeof(req) + seg->len - 4);
 		dev->phy.clc_chan_conf = clc->ver == 1 ? 0xff : rule->flag;
 		skb = __mt76_mcu_msg_alloc(&dev->mt76, &req,
 					   le16_to_cpu(req.size) + sizeof(req),
@@ -3727,7 +3727,7 @@ mt7925_mcu_rate_txpower_band(struct mt76_phy *phy,
 		memcpy(tx_power_tlv->alpha2, dev->alpha2, sizeof(dev->alpha2));
 		tx_power_tlv->n_chan = num_ch;
 		tx_power_tlv->tag = cpu_to_le16(0x1);
-		tx_power_tlv->len = cpu_to_le16(sizeof(*tx_power_tlv));
+		tx_power_tlv->len = cpu_to_le16(msg_len);
 
 		switch (band) {
 		case NL80211_BAND_2GHZ:
diff --git a/drivers/net/wireless/rsi/rsi_common.h b/drivers/net/wireless/rsi/rsi_common.h
index 7aa5124575cf..c40f8101febc 100644
--- a/drivers/net/wireless/rsi/rsi_common.h
+++ b/drivers/net/wireless/rsi/rsi_common.h
@@ -70,12 +70,11 @@ static inline int rsi_create_kthread(struct rsi_common *common,
 	return 0;
 }
 
-static inline int rsi_kill_thread(struct rsi_thread *handle)
+static inline void rsi_kill_thread(struct rsi_thread *handle)
 {
 	atomic_inc(&handle->thread_done);
 	rsi_set_event(&handle->event);
-
-	return kthread_stop(handle->task);
+	wait_for_completion(&handle->completion);
 }
 
 void rsi_mac80211_detach(struct rsi_hw *hw);
diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.c b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
index 7968e208dd37..adb29d30c63f 100644
--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.c
+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
@@ -457,8 +457,20 @@ static int t7xx_parse_host_rt_data(struct t7xx_fsm_ctl *ctl, struct t7xx_sys_inf
 
 	offset = sizeof(struct feature_query);
 	for (i = 0; i < FEATURE_COUNT && offset < data_length; i++) {
+		size_t remaining = data_length - offset;
+		size_t feat_data_len, feat_total;
+
+		if (remaining < sizeof(*rt_feature))
+			break;
+
 		rt_feature = data + offset;
-		offset += sizeof(*rt_feature) + le32_to_cpu(rt_feature->data_len);
+		feat_data_len = le32_to_cpu(rt_feature->data_len);
+
+		if (feat_data_len > remaining - sizeof(*rt_feature))
+			break;
+
+		feat_total = sizeof(*rt_feature) + feat_data_len;
+		offset += feat_total;
 
 		ft_spt_cfg = FIELD_GET(FEATURE_MSK, core->feature_set[i]);
 		if (ft_spt_cfg != MTK_FEATURE_MUST_BE_SUPPORTED)
@@ -468,8 +480,10 @@ static int t7xx_parse_host_rt_data(struct t7xx_fsm_ctl *ctl, struct t7xx_sys_inf
 		if (ft_spt_st != MTK_FEATURE_MUST_BE_SUPPORTED)
 			return -EINVAL;
 
-		if (i == RT_ID_MD_PORT_ENUM || i == RT_ID_AP_PORT_ENUM)
-			t7xx_port_enum_msg_handler(ctl->md, rt_feature->data);
+		if (i == RT_ID_MD_PORT_ENUM || i == RT_ID_AP_PORT_ENUM) {
+			t7xx_port_enum_msg_handler(ctl->md, rt_feature->data,
+						   feat_data_len);
+		}
 	}
 
 	return 0;
diff --git a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
index ae632ef96698..f869e4ed9ee9 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
@@ -117,6 +117,7 @@ static int fsm_ee_message_handler(struct t7xx_port *port, struct t7xx_fsm_ctl *c
  * t7xx_port_enum_msg_handler() - Parse the port enumeration message to create/remove nodes.
  * @md: Modem context.
  * @msg: Message.
+ * @msg_len:	Length of @msg in bytes.
  *
  * Used to control create/remove device node.
  *
@@ -124,12 +125,18 @@ static int fsm_ee_message_handler(struct t7xx_port *port, struct t7xx_fsm_ctl *c
  * * 0		- Success.
  * * -EFAULT	- Message check failure.
  */
-int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg)
+int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg, size_t msg_len)
 {
 	struct device *dev = &md->t7xx_dev->pdev->dev;
 	unsigned int version, port_count, i;
 	struct port_msg *port_msg = msg;
 
+	if (msg_len < sizeof(*port_msg)) {
+		dev_err(dev, "Port enum msg too short for header: need %zu, have %zu\n",
+			sizeof(*port_msg), msg_len);
+		return -EINVAL;
+	}
+
 	version = FIELD_GET(PORT_MSG_VERSION, le32_to_cpu(port_msg->info));
 	if (version != PORT_ENUM_VER ||
 	    le32_to_cpu(port_msg->head_pattern) != PORT_ENUM_HEAD_PATTERN ||
@@ -141,6 +148,13 @@ int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg)
 	}
 
 	port_count = FIELD_GET(PORT_MSG_PRT_CNT, le32_to_cpu(port_msg->info));
+
+	if (msg_len < struct_size(port_msg, data, port_count)) {
+		dev_err(dev, "Port enum msg too short: need %zu, have %zu\n",
+			struct_size(port_msg, data, port_count), msg_len);
+		return -EINVAL;
+	}
+
 	for (i = 0; i < port_count; i++) {
 		u32 port_info = le32_to_cpu(port_msg->data[i]);
 		unsigned int ch_id;
@@ -191,7 +205,7 @@ static int control_msg_handler(struct t7xx_port *port, struct sk_buff *skb)
 
 	case CTL_ID_PORT_ENUM:
 		skb_pull(skb, sizeof(*ctrl_msg_h));
-		ret = t7xx_port_enum_msg_handler(ctl->md, (struct port_msg *)skb->data);
+		ret = t7xx_port_enum_msg_handler(ctl->md, (struct port_msg *)skb->data, skb->len);
 		if (!ret)
 			ret = port_ctl_send_msg_to_md(port, CTL_ID_PORT_ENUM, 0);
 		else
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.h b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
index f0918b36e899..7c3190bf0fcf 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.h
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
@@ -103,7 +103,7 @@ void t7xx_port_proxy_reset(struct port_proxy *port_prox);
 void t7xx_port_proxy_uninit(struct port_proxy *port_prox);
 int t7xx_port_proxy_init(struct t7xx_modem *md);
 void t7xx_port_proxy_md_status_notify(struct port_proxy *port_prox, unsigned int state);
-int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg);
+int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg, size_t msg_len);
 int t7xx_port_proxy_chl_enable_disable(struct port_proxy *port_prox, unsigned int ch_id,
 				       bool en_flag);
 void t7xx_port_proxy_set_cfg(struct t7xx_modem *md, enum port_cfg_id cfg_id);
diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index ed61b97fde59..423c9c628e7b 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1267,11 +1267,7 @@ static int apple_nvme_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 
 static void apple_nvme_free_ctrl(struct nvme_ctrl *ctrl)
 {
-	struct apple_nvme *anv = ctrl_to_apple_nvme(ctrl);
-
-	if (anv->ctrl.admin_q)
-		blk_put_queue(anv->ctrl.admin_q);
-	put_device(anv->dev);
+	put_device(ctrl->dev);
 }
 
 static const struct nvme_ctrl_ops nvme_ctrl_ops = {
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 9238e13bd480..ba4e1a5e0d4c 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1743,7 +1743,7 @@ static void nvmet_ctrl_free(struct kref *ref)
 
 	nvmet_stop_keep_alive_timer(ctrl);
 
-	flush_work(&ctrl->async_event_work);
+	cancel_work_sync(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fatal_err_work);
 
 	nvmet_destroy_auth(ctrl);
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index acc71a26733f..255ebd948dfe 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -398,6 +398,19 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 
 static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue)
 {
+	/*
+	 * Keep rcv_state at RECV_ERR even for the internal -ESHUTDOWN path.
+	 * nvmet_tcp_handle_icreq() can return -ESHUTDOWN after the ICReq has
+	 * already been consumed and queue teardown has started.
+	 *
+	 * If nvmet_tcp_data_ready() or nvmet_tcp_write_space() queues
+	 * nvmet_tcp_io_work() again before nvmet_tcp_release_queue_work()
+	 * cancels it, the queue must not keep that old receive state.
+	 * Otherwise the next nvmet_tcp_io_work() run can reach
+	 * nvmet_tcp_done_recv_pdu() and try to handle the same ICReq again.
+	 *
+	 * That is why queue->rcv_state needs to be updated before we return.
+	 */
 	queue->rcv_state = NVMET_TCP_RECV_ERR;
 	if (queue->nvme_sq.ctrl)
 		nvmet_ctrl_fatal_error(queue->nvme_sq.ctrl);
@@ -922,11 +935,24 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 	iov.iov_len = sizeof(*icresp);
 	ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
 	if (ret < 0) {
+		spin_lock_bh(&queue->state_lock);
+		if (queue->state == NVMET_TCP_Q_DISCONNECTING) {
+			spin_unlock_bh(&queue->state_lock);
+			return -ESHUTDOWN;
+		}
 		queue->state = NVMET_TCP_Q_FAILED;
+		spin_unlock_bh(&queue->state_lock);
 		return ret; /* queue removal will cleanup */
 	}
 
+	spin_lock_bh(&queue->state_lock);
+	if (queue->state == NVMET_TCP_Q_DISCONNECTING) {
+		spin_unlock_bh(&queue->state_lock);
+		/* Tell nvmet_tcp_socket_error() teardown is in progress. */
+		return -ESHUTDOWN;
+	}
 	queue->state = NVMET_TCP_Q_LIVE;
+	spin_unlock_bh(&queue->state_lock);
 	nvmet_prepare_receive_pdu(queue);
 	return 0;
 }
diff --git a/drivers/parisc/lasi.c b/drivers/parisc/lasi.c
index ef6125d83878..a5b80cd5cc37 100644
--- a/drivers/parisc/lasi.c
+++ b/drivers/parisc/lasi.c
@@ -193,8 +193,7 @@ static int __init lasi_init_chip(struct parisc_device *dev)
 
 	ret = request_irq(lasi->gsc_irq.irq, gsc_asic_intr, 0, "lasi", lasi);
 	if (ret < 0) {
-		kfree(lasi);
-		return ret;
+		goto err_free;
 	}
 
 	/* enable IRQ's for devices below LASI */
@@ -203,8 +202,7 @@ static int __init lasi_init_chip(struct parisc_device *dev)
 	/* Done init'ing, register this driver */
 	ret = gsc_common_setup(dev, lasi);
 	if (ret) {
-		kfree(lasi);
-		return ret;
+		goto err_irq;
 	}    
 
 	gsc_fixup_irqs(dev, lasi, lasi_choose_irq);
@@ -214,6 +212,12 @@ static int __init lasi_init_chip(struct parisc_device *dev)
 		SYS_OFF_PRIO_DEFAULT, lasi_power_off, lasi);
 
 	return ret;
+
+err_irq:
+	free_irq(lasi->gsc_irq.irq, lasi);
+err_free:
+	kfree(lasi);
+	return ret;
 }
 
 static struct parisc_device_id lasi_tbl[] __initdata = {
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8479c2e1f74f..8e3e4e24c909 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2241,10 +2241,9 @@ EXPORT_SYMBOL_GPL(pci_set_pcie_reset_state);
 #ifdef CONFIG_PCIEAER
 void pcie_clear_device_status(struct pci_dev *dev)
 {
-	u16 sta;
-
-	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
-	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
+	pcie_capability_write_word(dev, PCI_EXP_DEVSTA,
+				   PCI_EXP_DEVSTA_CED | PCI_EXP_DEVSTA_NFED |
+				   PCI_EXP_DEVSTA_FED | PCI_EXP_DEVSTA_URD);
 }
 #endif
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d916378bc707..c4fd9c0b2a54 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1041,8 +1041,6 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
 	 *      3) There are multiple errors and prior ID comparing fails;
 	 * We check AER status registers to find possible reporter.
 	 */
-	if (atomic_read(&dev->enable_cnt) == 0)
-		return false;
 
 	/* Check if AER is enabled */
 	pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &reg16);
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 21f5d23e0b61..925373b98dff 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -706,22 +706,29 @@ static void aspm_calc_l12_info(struct pcie_link_state *link,
 	}
 
 	/* Program T_POWER_ON times in both ports */
-	pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, ctl2);
-	pci_write_config_dword(child, child->l1ss + PCI_L1SS_CTL2, ctl2);
+	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2,
+				       PCI_L1SS_CTL2_T_PWR_ON_VALUE |
+				       PCI_L1SS_CTL2_T_PWR_ON_SCALE, ctl2);
+	pci_clear_and_set_config_dword(child, child->l1ss + PCI_L1SS_CTL2,
+				       PCI_L1SS_CTL2_T_PWR_ON_VALUE |
+				       PCI_L1SS_CTL2_T_PWR_ON_SCALE, ctl2);
 
 	/* Program Common_Mode_Restore_Time in upstream device */
 	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
-				       PCI_L1SS_CTL1_CM_RESTORE_TIME, ctl1);
+				       PCI_L1SS_CTL1_CM_RESTORE_TIME,
+				       ctl1 & PCI_L1SS_CTL1_CM_RESTORE_TIME);
 
 	/* Program LTR_L1.2_THRESHOLD time in both ports */
 	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
 				       PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
 				       PCI_L1SS_CTL1_LTR_L12_TH_SCALE,
-				       ctl1);
+				       ctl1 & (PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
+					       PCI_L1SS_CTL1_LTR_L12_TH_SCALE));
 	pci_clear_and_set_config_dword(child, child->l1ss + PCI_L1SS_CTL1,
 				       PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
 				       PCI_L1SS_CTL1_LTR_L12_TH_SCALE,
-				       ctl1);
+				       ctl1 & (PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
+					       PCI_L1SS_CTL1_LTR_L12_TH_SCALE));
 
 	if (pl1_2_enables || cl1_2_enables) {
 		pci_clear_and_set_config_dword(parent,
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index bb2aef373d6f..d11babcb1290 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -102,6 +102,7 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
 	}
 
 	pci_write_config_dword(dev, reg, new);
+	dev->saved_config_space[reg / 4] = new;
 	pci_read_config_dword(dev, reg, &check);
 
 	if ((new ^ check) & mask) {
@@ -112,6 +113,7 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
 	if (res->flags & IORESOURCE_MEM_64) {
 		new = region.start >> 16 >> 16;
 		pci_write_config_dword(dev, reg + 4, new);
+		dev->saved_config_space[(reg + 4) / 4] = new;
 		pci_read_config_dword(dev, reg + 4, &check);
 		if (check != new) {
 			pci_err(dev, "%s: error updating (high %#010x != %#010x)\n",
diff --git a/drivers/platform/chrome/cros_typec_altmode.c b/drivers/platform/chrome/cros_typec_altmode.c
index 557340b53af0..66c546bf89b5 100644
--- a/drivers/platform/chrome/cros_typec_altmode.c
+++ b/drivers/platform/chrome/cros_typec_altmode.c
@@ -359,6 +359,7 @@ cros_typec_register_thunderbolt(struct cros_typec_port *port,
 	}
 
 	INIT_WORK(&adata->work, cros_typec_altmode_work);
+	mutex_init(&adata->lock);
 	adata->alt = alt;
 	adata->port = port;
 	adata->ap_mode_entry = true;
diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 52ea84e548ff..f9757dcb255e 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3082,6 +3082,7 @@ static const struct bus_type genpd_bus_type = {
 static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 {
 	struct generic_pm_domain *pd;
+	bool is_virt_dev;
 	unsigned int i;
 	int ret = 0;
 
@@ -3091,6 +3092,13 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 
 	dev_dbg(dev, "removing from PM domain %s\n", pd->name);
 
+	/* Check if the device was created by genpd at attach. */
+	is_virt_dev = dev->bus == &genpd_bus_type;
+
+	/* Disable runtime PM if we enabled it at attach. */
+	if (is_virt_dev)
+		pm_runtime_disable(dev);
+
 	/* Drop the default performance state */
 	if (dev_gpd_data(dev)->default_pstate) {
 		dev_pm_genpd_set_performance_state(dev, 0);
@@ -3116,7 +3124,7 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 	genpd_queue_power_off_work(pd);
 
 	/* Unregister the device if it was created by genpd. */
-	if (dev->bus == &genpd_bus_type)
+	if (is_virt_dev)
 		device_unregister(dev);
 }
 
diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index e2800aa1bc59..d3b36f32417c 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -993,6 +993,7 @@ static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *s
 	struct device_node *node, *smi_np;
 	int num_regmaps = 0, i, j;
 	struct regmap *regmap[3];
+	int ret = 0;
 
 	/*
 	 * Legacy code retrieves a maximum of three bus protection handles:
@@ -1043,11 +1044,14 @@ static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *s
 	if (node) {
 		regmap[2] = syscon_regmap_lookup_by_phandle(node, "mediatek,infracfg-nao");
 		num_regmaps++;
-		of_node_put(node);
-		if (IS_ERR(regmap[2]))
-			return dev_err_probe(dev, PTR_ERR(regmap[2]),
+		if (IS_ERR(regmap[2])) {
+			ret = dev_err_probe(dev, PTR_ERR(regmap[2]),
 					     "%pOF: failed to get infracfg regmap\n",
 					     node);
+			of_node_put(node);
+			return ret;
+		}
+		of_node_put(node);
 	} else {
 		regmap[2] = NULL;
 	}
diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index acea176101fa..a32ff503f45f 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -201,7 +201,7 @@ static int max17042_get_battery_health(struct max17042_chip *chip, int *health)
 		goto out;
 	}
 
-	if (vbatt > chip->pdata->vmax + MAX17042_VMAX_TOLERANCE) {
+	if (vbatt > size_add(chip->pdata->vmax, MAX17042_VMAX_TOLERANCE)) {
 		*health = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
 		goto out;
 	}
diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 8c8ddbf995a4..23126bc22705 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -812,7 +812,7 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
 
 		/* Not use resource version, because we might share region */
 		priv->mem[b].cpu_addr = devm_ioremap_resource_wc(&pdev->dev, &res);
-		if (!priv->mem[b].cpu_addr) {
+		if (IS_ERR(priv->mem[b].cpu_addr)) {
 			dev_err(dev, "failed to remap %pr\n", &res);
 			return -ENOMEM;
 		}
diff --git a/drivers/remoteproc/ti_k3_common.c b/drivers/remoteproc/ti_k3_common.c
index 32aa954dc5be..3cb8ae5d72f6 100644
--- a/drivers/remoteproc/ti_k3_common.c
+++ b/drivers/remoteproc/ti_k3_common.c
@@ -513,7 +513,7 @@ int k3_reserved_mem_init(struct k3_rproc *kproc)
 		kproc->rmem[i].dev_addr = (u32)res.start;
 		kproc->rmem[i].size = resource_size(&res);
 		kproc->rmem[i].cpu_addr = devm_ioremap_resource_wc(dev, &res);
-		if (!kproc->rmem[i].cpu_addr) {
+		if (IS_ERR(kproc->rmem[i].cpu_addr)) {
 			dev_err(dev, "failed to map reserved memory#%d at %pR\n",
 				i + 1, &res);
 			return -ENOMEM;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 6ff788557294..12caffeed3a0 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -2738,8 +2738,20 @@ scsih_sdev_configure(struct scsi_device *sdev, struct queue_limits *lim)
 				pcie_device->enclosure_level,
 				pcie_device->connector_name);
 
+		/*
+		 * The HBA firmware passes the NVMe drive's MDTS
+		 * (Maximum Data Transfer Size) up to the driver. However,
+		 * the driver hardcodes a 4K buffer size for the PRP list,
+		 * accommodating at most 512 entries. This strictly limits
+		 * the maximum supported NVMe I/O transfer to 2 MiB.
+		 *
+		 * Cap max_hw_sectors to the smaller of the drive's reported
+		 * MDTS or the 2 MiB driver limit to prevent kernel oopses.
+		 */
+		lim->max_hw_sectors = SZ_2M >> SECTOR_SHIFT;
 		if (pcie_device->nvme_mdts)
-			lim->max_hw_sectors = pcie_device->nvme_mdts / 512;
+			lim->max_hw_sectors = min(lim->max_hw_sectors,
+					pcie_device->nvme_mdts >> SECTOR_SHIFT);
 
 		pcie_device_put(pcie_device);
 		spin_unlock_irqrestore(&ioc->pcie_device_lock, flags);
diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index aafe6cbf2aea..70215a407b5a 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -74,6 +74,13 @@
 #define STATUS_FLAGSX4		BIT(8)
 #define STATUS_MASK		GENMASK(8, 0)
 
+/*
+ * QSPI Direct Access register defines
+ */
+#define DIRECT_ACCESS_EN_SSEL		BIT(0)
+#define DIRECT_ACCESS_OP_SSEL		BIT(1)
+#define DIRECT_ACCESS_OP_SSEL_SHIFT	1
+
 #define BYTESUPPER_MASK		GENMASK(31, 16)
 #define BYTESLOWER_MASK		GENMASK(15, 0)
 
@@ -158,6 +165,38 @@ static int mchp_coreqspi_set_mode(struct mchp_coreqspi *qspi, const struct spi_m
 	return 0;
 }
 
+static void mchp_coreqspi_set_cs(struct spi_device *spi, bool enable)
+{
+	struct mchp_coreqspi *qspi = spi_controller_get_devdata(spi->controller);
+	u32 val;
+
+	val = readl(qspi->regs + REG_DIRECT_ACCESS);
+
+	val &= ~DIRECT_ACCESS_OP_SSEL;
+	val |= !enable << DIRECT_ACCESS_OP_SSEL_SHIFT;
+
+	writel(val, qspi->regs + REG_DIRECT_ACCESS);
+}
+
+static int mchp_coreqspi_setup(struct spi_device *spi)
+{
+	struct mchp_coreqspi *qspi = spi_controller_get_devdata(spi->controller);
+	u32 val;
+
+	/*
+	 * Active low devices need to be specifically set to their inactive
+	 * states during probe.
+	 */
+	if (spi->mode & SPI_CS_HIGH)
+		return 0;
+
+	val = readl(qspi->regs + REG_DIRECT_ACCESS);
+	val |= DIRECT_ACCESS_OP_SSEL;
+	writel(val, qspi->regs + REG_DIRECT_ACCESS);
+
+	return 0;
+}
+
 static inline void mchp_coreqspi_read_op(struct mchp_coreqspi *qspi)
 {
 	u32 control, data;
@@ -380,19 +419,6 @@ static int mchp_coreqspi_setup_clock(struct mchp_coreqspi *qspi, struct spi_devi
 	return 0;
 }
 
-static int mchp_coreqspi_setup_op(struct spi_device *spi_dev)
-{
-	struct spi_controller *ctlr = spi_dev->controller;
-	struct mchp_coreqspi *qspi = spi_controller_get_devdata(ctlr);
-	u32 control = readl_relaxed(qspi->regs + REG_CONTROL);
-
-	control |= (CONTROL_MASTER | CONTROL_ENABLE);
-	control &= ~CONTROL_CLKIDLE;
-	writel_relaxed(control, qspi->regs + REG_CONTROL);
-
-	return 0;
-}
-
 static inline void mchp_coreqspi_config_op(struct mchp_coreqspi *qspi, const struct spi_mem_op *op)
 {
 	u32 idle_cycles = 0;
@@ -483,6 +509,7 @@ static int mchp_coreqspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *o
 
 	reinit_completion(&qspi->data_completion);
 	mchp_coreqspi_config_op(qspi, op);
+	mchp_coreqspi_set_cs(mem->spi, true);
 	if (op->cmd.opcode) {
 		qspi->txbuf = &opcode;
 		qspi->rxbuf = NULL;
@@ -523,6 +550,7 @@ static int mchp_coreqspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *o
 		err = -ETIMEDOUT;
 
 error:
+	mchp_coreqspi_set_cs(mem->spi, false);
 	mutex_unlock(&qspi->op_lock);
 	mchp_coreqspi_disable_ints(qspi);
 
@@ -662,18 +690,28 @@ static int mchp_coreqspi_transfer_one(struct spi_controller *ctlr, struct spi_de
 				      struct spi_transfer *t)
 {
 	struct mchp_coreqspi *qspi = spi_controller_get_devdata(ctlr);
+	bool dual_quad = false;
 
 	qspi->tx_len = t->len;
 
+	if (t->tx_nbits == SPI_NBITS_QUAD || t->rx_nbits == SPI_NBITS_QUAD ||
+			t->tx_nbits == SPI_NBITS_DUAL ||
+			t->rx_nbits == SPI_NBITS_DUAL)
+		dual_quad = true;
+
 	if (t->tx_buf)
 		qspi->txbuf = (u8 *)t->tx_buf;
 
 	if (!t->rx_buf) {
 		mchp_coreqspi_write_op(qspi);
-	} else {
+	} else if (!dual_quad) {
 		qspi->rxbuf = (u8 *)t->rx_buf;
 		qspi->rx_len = t->len;
 		mchp_coreqspi_write_read_op(qspi);
+	} else {
+		qspi->rxbuf = (u8 *)t->rx_buf;
+		qspi->rx_len = t->len;
+		mchp_coreqspi_read_op(qspi);
 	}
 
 	return 0;
@@ -686,13 +724,14 @@ static int mchp_coreqspi_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	int ret;
+	u32 num_cs, val;
 
 	ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*qspi));
 	if (!ctlr)
 		return -ENOMEM;
 
 	qspi = spi_controller_get_devdata(ctlr);
-	platform_set_drvdata(pdev, qspi);
+	platform_set_drvdata(pdev, ctlr);
 
 	qspi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(qspi->regs))
@@ -718,10 +757,18 @@ static int mchp_coreqspi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/*
+	 * The IP core only has a single CS, any more have to be provided via
+	 * gpios
+	 */
+	if (of_property_read_u32(pdev->dev.of_node, "num-cs", &num_cs))
+		num_cs = 1;
+
+	ctlr->num_chipselect = num_cs;
+
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctlr->mem_ops = &mchp_coreqspi_mem_ops;
 	ctlr->mem_caps = &mchp_coreqspi_mem_caps;
-	ctlr->setup = mchp_coreqspi_setup_op;
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
 			  SPI_TX_DUAL | SPI_TX_QUAD;
 	ctlr->dev.of_node = np;
@@ -729,10 +776,22 @@ static int mchp_coreqspi_probe(struct platform_device *pdev)
 	ctlr->prepare_message = mchp_coreqspi_prepare_message;
 	ctlr->unprepare_message = mchp_coreqspi_unprepare_message;
 	ctlr->transfer_one = mchp_coreqspi_transfer_one;
-	ctlr->num_chipselect = 2;
+	ctlr->setup = mchp_coreqspi_setup;
+	ctlr->set_cs = mchp_coreqspi_set_cs;
 	ctlr->use_gpio_descriptors = true;
 
-	ret = devm_spi_register_controller(&pdev->dev, ctlr);
+	val = readl_relaxed(qspi->regs + REG_CONTROL);
+	val |= (CONTROL_MASTER | CONTROL_ENABLE);
+	writel_relaxed(val, qspi->regs + REG_CONTROL);
+
+	/*
+	 * Put cs into software controlled mode
+	 */
+	val = readl_relaxed(qspi->regs + REG_DIRECT_ACCESS);
+	val |= DIRECT_ACCESS_EN_SSEL;
+	writel(val, qspi->regs + REG_DIRECT_ACCESS);
+
+	ret = spi_register_controller(ctlr);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
 				     "spi_register_controller failed\n");
@@ -742,9 +801,13 @@ static int mchp_coreqspi_probe(struct platform_device *pdev)
 
 static void mchp_coreqspi_remove(struct platform_device *pdev)
 {
-	struct mchp_coreqspi *qspi = platform_get_drvdata(pdev);
-	u32 control = readl_relaxed(qspi->regs + REG_CONTROL);
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+	struct mchp_coreqspi *qspi = spi_controller_get_devdata(ctlr);
+	u32 control;
 
+	spi_unregister_controller(ctlr);
+
+	control = readl_relaxed(qspi->regs + REG_CONTROL);
 	mchp_coreqspi_disable_ints(qspi);
 	control &= ~CONTROL_ENABLE;
 	writel_relaxed(control, qspi->regs + REG_CONTROL);
diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
index a4c128ae391b..be01c178e2b0 100644
--- a/drivers/spi/spi-microchip-core-spi.c
+++ b/drivers/spi/spi-microchip-core-spi.c
@@ -384,7 +384,7 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 
 	mchp_corespi_init(host, spi);
 
-	ret = devm_spi_register_controller(dev, host);
+	ret = spi_register_controller(host);
 	if (ret) {
 		mchp_corespi_disable_ints(spi);
 		mchp_corespi_disable(spi);
@@ -399,6 +399,8 @@ static void mchp_corespi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct mchp_corespi *spi = spi_controller_get_devdata(host);
 
+	spi_unregister_controller(host);
+
 	mchp_corespi_disable_ints(spi);
 	mchp_corespi_disable(spi);
 }
diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index fd2ebef4903f..eb1992b4178e 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -908,7 +908,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 		break;
 	}
 
-	ret = devm_spi_register_controller(&pdev->dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register controller\n");
 		goto err_free_dma_rx;
@@ -936,6 +936,8 @@ static void rockchip_spi_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(&pdev->dev);
 
+	spi_unregister_controller(ctlr);
+
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index ba85243d6d89..96f39b5ae9df 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1401,11 +1401,6 @@ static void s3c64xx_spi_remove(struct platform_device *pdev)
 
 	writel(0, sdd->regs + S3C64XX_SPI_INT_EN);
 
-	if (!is_polling(sdd)) {
-		dma_release_channel(sdd->rx_dma.ch);
-		dma_release_channel(sdd->tx_dma.ch);
-	}
-
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index bfdf419a583c..b7fbb5270edb 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -504,7 +504,7 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_idle(&pdev->dev);
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&pdev->dev, "cannot register SPI host\n");
 		goto err_pm_disable;
@@ -522,7 +522,15 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 
 static void sun4i_spi_remove(struct platform_device *pdev)
 {
+	struct spi_controller *host = platform_get_drvdata(pdev);
+
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	pm_runtime_force_suspend(&pdev->dev);
+
+	spi_controller_put(host);
 }
 
 static const struct of_device_id sun4i_spi_match[] = {
diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 240e46f84f7b..5ac73d324d06 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -742,7 +742,7 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&pdev->dev, "cannot register SPI host\n");
 		goto err_pm_disable;
@@ -768,12 +768,18 @@ static void sun6i_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *host = platform_get_drvdata(pdev);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	pm_runtime_force_suspend(&pdev->dev);
 
 	if (host->dma_tx)
 		dma_release_channel(host->dma_tx);
 	if (host->dma_rx)
 		dma_release_channel(host->dma_rx);
+
+	spi_controller_put(host);
 }
 
 static const struct sun6i_spi_cfg sun6i_a31_spi_cfg = {
diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
index d0a875249910..290c439897c4 100644
--- a/drivers/spi/spi-synquacer.c
+++ b/drivers/spi/spi-synquacer.c
@@ -716,7 +716,7 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 	pm_runtime_set_active(sspi->dev);
 	pm_runtime_enable(sspi->dev);
 
-	ret = devm_spi_register_controller(sspi->dev, host);
+	ret = spi_register_controller(host);
 	if (ret)
 		goto disable_pm;
 
@@ -737,9 +737,15 @@ static void synquacer_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct synquacer_spi *sspi = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	pm_runtime_disable(sspi->dev);
 
 	clk_disable_unprepare(sspi->clk);
+
+	spi_controller_put(host);
 }
 
 static int __maybe_unused synquacer_spi_suspend(struct device *dev)
diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 848cb6836bd5..b8b0ebe0fe93 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1415,7 +1415,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 		goto exit_pm_disable;
 	}
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "can not register to host err %d\n", ret);
 		goto exit_free_irq;
@@ -1441,6 +1441,10 @@ static void tegra_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct tegra_spi_data	*tspi = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	free_irq(tspi->irq, tspi);
 
 	if (tspi->tx_dma_chan)
@@ -1452,6 +1456,8 @@ static void tegra_spi_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		tegra_spi_runtime_suspend(&pdev->dev);
+
+	spi_controller_put(host);
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index d9d536d7f7b6..9256729f2d49 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -505,7 +505,7 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 	tegra_sflash_writel(tsd, tsd->def_command_reg, SPI_COMMAND);
 	pm_runtime_put(&pdev->dev);
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "can not register to host err %d\n", ret);
 		goto exit_pm_disable;
@@ -528,11 +528,17 @@ static void tegra_sflash_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct tegra_sflash_data	*tsd = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	free_irq(tsd->irq, tsd);
 
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		tegra_sflash_runtime_suspend(&pdev->dev);
+
+	spi_controller_put(host);
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index d1d880a8ed7d..1fbd710d616f 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -888,7 +888,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	qspi->mmap_enabled = false;
 	qspi->current_cs = -1;
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (!ret)
 		return 0;
 
@@ -903,19 +903,17 @@ static int ti_qspi_probe(struct platform_device *pdev)
 static void ti_qspi_remove(struct platform_device *pdev)
 {
 	struct ti_qspi *qspi = platform_get_drvdata(pdev);
-	int rc;
 
-	rc = spi_controller_suspend(qspi->host);
-	if (rc) {
-		dev_alert(&pdev->dev, "spi_controller_suspend() failed (%pe)\n",
-			  ERR_PTR(rc));
-		return;
-	}
+	spi_controller_get(qspi->host);
+
+	spi_unregister_controller(qspi->host);
 
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	ti_qspi_dma_cleanup(qspi);
+
+	spi_controller_put(qspi->host);
 }
 
 static const struct dev_pm_ops ti_qspi_pm_ops = {
diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index cae2dcefabea..14d11450e86d 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1406,8 +1406,9 @@ static void pch_spi_pd_remove(struct platform_device *plat_dev)
 	dev_dbg(&plat_dev->dev, "%s:[ch%d] irq=%d\n",
 		__func__, plat_dev->id, board_dat->pdev->irq);
 
-	if (use_dma)
-		pch_free_dma_buf(board_dat, data);
+	spi_controller_get(data->host);
+
+	spi_unregister_controller(data->host);
 
 	/* check for any pending messages; no action is taken if the queue
 	 * is still full; but at least we tried.  Unload anyway */
@@ -1432,8 +1433,12 @@ static void pch_spi_pd_remove(struct platform_device *plat_dev)
 		free_irq(board_dat->pdev->irq, data);
 	}
 
+	if (use_dma)
+		pch_free_dma_buf(board_dat, data);
+
 	pci_iounmap(board_dat->pdev, data->io_remap_addr);
-	spi_unregister_controller(data->host);
+
+	spi_controller_put(data->host);
 }
 #ifdef CONFIG_PM
 static int pch_spi_pd_suspend(struct platform_device *pd_dev,
diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index af252500195c..406fd9d5337e 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -643,7 +643,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 
 	xqspi = spi_controller_get_devdata(ctlr);
 	xqspi->dev = dev;
-	platform_set_drvdata(pdev, xqspi);
+	platform_set_drvdata(pdev, ctlr);
 	xqspi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(xqspi->regs)) {
 		ret = PTR_ERR(xqspi->regs);
@@ -702,9 +702,9 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	/* QSPI controller initializations */
 	zynq_qspi_init_hw(xqspi, ctlr->num_chipselect);
 
-	ret = devm_spi_register_controller(&pdev->dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret) {
-		dev_err(&pdev->dev, "devm_spi_register_controller failed\n");
+		dev_err(&pdev->dev, "failed to register controller\n");
 		goto remove_ctlr;
 	}
 
@@ -728,9 +728,16 @@ static int zynq_qspi_probe(struct platform_device *pdev)
  */
 static void zynq_qspi_remove(struct platform_device *pdev)
 {
-	struct zynq_qspi *xqspi = platform_get_drvdata(pdev);
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+	struct zynq_qspi *xqspi = spi_controller_get_devdata(ctlr);
+
+	spi_controller_get(ctlr);
+
+	spi_unregister_controller(ctlr);
 
 	zynq_qspi_write(xqspi, ZYNQ_QSPI_ENABLE_OFFSET, 0);
+
+	spi_controller_put(ctlr);
 }
 
 static const struct of_device_id zynq_qspi_of_match[] = {
diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 502fd5eccc83..f9a1427dabad 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1324,7 +1324,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	ctlr->dev.of_node = np;
 	ctlr->auto_runtime_pm = true;
 
-	ret = devm_spi_register_controller(&pdev->dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret) {
 		dev_err(&pdev->dev, "spi_register_controller failed\n");
 		goto clk_dis_all;
@@ -1362,6 +1362,8 @@ static void zynqmp_qspi_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(&pdev->dev);
 
+	spi_unregister_controller(xqspi->ctlr);
+
 	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
 
 	pm_runtime_disable(&pdev->dev);
diff --git a/drivers/staging/rtl8723bs/os_dep/osdep_service.c b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
index 7959daeabc6f..4cfdf7c62344 100644
--- a/drivers/staging/rtl8723bs/os_dep/osdep_service.c
+++ b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
@@ -194,7 +194,8 @@ struct rtw_cbuf *rtw_cbuf_alloc(u32 size)
 	struct rtw_cbuf *cbuf;
 
 	cbuf = kzalloc_flex(*cbuf, bufs, size);
-	cbuf->size = size;
+	if (cbuf)
+		cbuf->size = size;
 
 	return cbuf;
 }
diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index be4ad47ed526..8abaa3165fbb 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -1230,6 +1230,8 @@ static int __init fake_init(void)
 err_driver:
 	kfree(fake_bridge);
 err_struct:
+	root_device_unregister(vme_root);
+
 	return retval;
 }
 
diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index a1c91d4515bc..84124b222a99 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -3227,7 +3227,7 @@ static ssize_t target_tg_pt_gp_members_show(struct config_item *item,
 			config_item_name(&lun->lun_group.cg_item));
 		cur_len++; /* Extra byte for NULL terminator */
 
-		if ((cur_len + len) > PAGE_SIZE) {
+		if (cur_len > TG_PT_GROUP_NAME_BUF || (cur_len + len) > PAGE_SIZE) {
 			pr_warn("Ran out of lu_gp_show_attr"
 				"_members buffer\n");
 			break;
diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
index e546067c9621..44fa45f74da7 100644
--- a/drivers/thermal/sprd_thermal.c
+++ b/drivers/thermal/sprd_thermal.c
@@ -178,7 +178,7 @@ static int sprd_thm_sensor_calibration(struct device_node *np,
 static int sprd_thm_rawdata_to_temp(struct sprd_thermal_sensor *sen,
 				    u32 rawdata)
 {
-	clamp(rawdata, (u32)SPRD_THM_RAW_DATA_LOW, (u32)SPRD_THM_RAW_DATA_HIGH);
+	rawdata = clamp(rawdata, SPRD_THM_RAW_DATA_LOW, SPRD_THM_RAW_DATA_HIGH);
 
 	/*
 	 * According to the thermal datasheet, the formula of converting
@@ -192,7 +192,7 @@ static int sprd_thm_temp_to_rawdata(int temp, struct sprd_thermal_sensor *sen)
 {
 	u32 val;
 
-	clamp(temp, (int)SPRD_THM_TEMP_LOW, (int)SPRD_THM_TEMP_HIGH);
+	temp = clamp(temp, SPRD_THM_TEMP_LOW, SPRD_THM_TEMP_HIGH);
 
 	/*
 	 * According to the thermal datasheet, the formula of converting
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index cf75f7035602..cb25e628c248 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -965,6 +965,7 @@ static void thermal_release(struct device *dev)
 		tz = to_thermal_zone(dev);
 		thermal_zone_destroy_device_groups(tz);
 		thermal_set_governor(tz, NULL);
+		ida_destroy(&tz->ida);
 		mutex_destroy(&tz->lock);
 		complete(&tz->removal);
 	} else if (!strncmp(dev_name(dev), "cooling_device",
@@ -1730,8 +1731,6 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 
 	thermal_thresholds_exit(tz);
 	thermal_remove_hwmon_sysfs(tz);
-	ida_free(&thermal_tz_ida, tz->id);
-	ida_destroy(&tz->ida);
 
 	device_del(&tz->device);
 	put_device(&tz->device);
@@ -1739,6 +1738,9 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	thermal_notify_tz_delete(tz);
 
 	wait_for_completion(&tz->removal);
+
+	ida_free(&thermal_tz_ida, tz->id);
+
 	kfree(tz->tzp);
 	kfree(tz);
 }
diff --git a/drivers/usb/class/usblp.c b/drivers/usb/class/usblp.c
index 669b9e6879bf..746414763da5 100644
--- a/drivers/usb/class/usblp.c
+++ b/drivers/usb/class/usblp.c
@@ -1178,7 +1178,7 @@ static int usblp_probe(struct usb_interface *intf,
 	}
 
 	/* Allocate buffer for printer status */
-	usblp->statusbuf = kmalloc(STATUS_BUF_SIZE, GFP_KERNEL);
+	usblp->statusbuf = kzalloc(STATUS_BUF_SIZE, GFP_KERNEL);
 	if (!usblp->statusbuf) {
 		retval = -ENOMEM;
 		goto abort;
@@ -1377,6 +1377,7 @@ static int usblp_cache_device_id_string(struct usblp *usblp)
 {
 	int err, length;
 
+	memset(usblp->device_id_string, 0, USBLP_DEVICE_ID_SIZE);
 	err = usblp_get_id(usblp, 0, usblp->device_id_string, USBLP_DEVICE_ID_SIZE - 1);
 	if (err < 0) {
 		dev_dbg(&usblp->intf->dev,
diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
index b34fb65813c4..9b69148128e5 100644
--- a/drivers/usb/common/ulpi.c
+++ b/drivers/usb/common/ulpi.c
@@ -286,12 +286,15 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
 	ACPI_COMPANION_SET(&ulpi->dev, ACPI_COMPANION(dev));
 
 	ret = ulpi_of_register(ulpi);
-	if (ret)
+	if (ret) {
+		kfree(ulpi);
 		return ret;
+	}
 
 	ret = ulpi_read_id(ulpi);
 	if (ret) {
 		of_node_put(ulpi->dev.of_node);
+		kfree(ulpi);
 		return ret;
 	}
 
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 161a4d58b2ce..0d3c7e7b2262 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1341,12 +1341,6 @@ int dwc3_core_init(struct dwc3 *dwc)
 
 	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
 
-	/*
-	 * Write Linux Version Code to our GUID register so it's easy to figure
-	 * out which kernel version a bug was found.
-	 */
-	dwc3_writel(dwc, DWC3_GUID, LINUX_VERSION_CODE);
-
 	ret = dwc3_phy_setup(dwc);
 	if (ret)
 		return ret;
@@ -1378,6 +1372,12 @@ int dwc3_core_init(struct dwc3 *dwc)
 	if (ret)
 		goto err_exit_phy;
 
+	/*
+	 * Write Linux Version Code to our GUID register so it's easy to figure
+	 * out which kernel version a bug was found.
+	 */
+	dwc3_writel(dwc, DWC3_GUID, LINUX_VERSION_CODE);
+
 	dwc3_core_setup_global_control(dwc);
 	dwc3_core_num_eps(dwc);
 
diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index 91139ae668f4..f3ca79cece1b 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -733,8 +733,6 @@ static void dma_channel_claim(struct omap_ep *ep, unsigned channel)
 		if (status == 0) {
 			omap_writew(reg, UDC_TXDMA_CFG);
 			/* EMIFF or SDRC */
-			omap_set_dma_src_burst_mode(ep->lch,
-						OMAP_DMA_DATA_BURST_4);
 			omap_set_dma_src_data_pack(ep->lch, 1);
 			/* TIPB */
 			omap_set_dma_dest_params(ep->lch,
@@ -756,8 +754,6 @@ static void dma_channel_claim(struct omap_ep *ep, unsigned channel)
 				UDC_DATA_DMA,
 				0, 0);
 			/* EMIFF or SDRC */
-			omap_set_dma_dest_burst_mode(ep->lch,
-						OMAP_DMA_DATA_BURST_4);
 			omap_set_dma_dest_data_pack(ep->lch, 1);
 		}
 	}
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index c71461893d20..42e4cecd28ac 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1513,7 +1513,11 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1231, 0xff),	/* Telit LE910Cx (RNDIS) */
 	  .driver_info = NCTRL(2) | RSVD(3) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x1250, 0xff, 0x00, 0x00) },	/* Telit LE910Cx (rmnet) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1251, 0xff) },	/* Telit LE910Cx (RNDIS) */
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1252, 0xff) },	/* Telit LE910Cx (MBIM) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1253, 0xff) },	/* Telit LE910Cx (ECM) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1254, 0xff) },	/* Telit LE910Cx */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1255, 0xff) },	/* Telit LE910Cx */
 	{ USB_DEVICE(TELIT_VENDOR_ID, 0x1260),
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, 0x1261),
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 8e0e14a2704e..a3b04f0608c1 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -634,9 +634,14 @@ static const char * const pd_rev[] = {
 	 (tcpm_cc_is_source((port)->cc2) && \
 	  !tcpm_cc_is_source((port)->cc1)))
 
+#define tcpm_port_is_debug_source(port) \
+	(tcpm_cc_is_source((port)->cc1) && tcpm_cc_is_source((port)->cc2))
+
+#define tcpm_port_is_debug_sink(port) \
+	(tcpm_cc_is_sink((port)->cc1) && tcpm_cc_is_sink((port)->cc2))
+
 #define tcpm_port_is_debug(port) \
-	((tcpm_cc_is_source((port)->cc1) && tcpm_cc_is_source((port)->cc2)) || \
-	 (tcpm_cc_is_sink((port)->cc1) && tcpm_cc_is_sink((port)->cc2)))
+	(tcpm_port_is_debug_source(port) || tcpm_port_is_debug_sink(port))
 
 #define tcpm_port_is_audio(port) \
 	(tcpm_cc_is_audio((port)->cc1) && tcpm_cc_is_audio((port)->cc2))
@@ -4812,7 +4817,7 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_set_state(port, SNK_UNATTACHED, PD_T_DRP_SNK);
 		break;
 	case SRC_ATTACH_WAIT:
-		if (tcpm_port_is_debug(port))
+		if (tcpm_port_is_debug_source(port))
 			tcpm_set_state(port, DEBUG_ACC_ATTACHED,
 				       port->timings.cc_debounce_time);
 		else if (tcpm_port_is_audio(port))
@@ -5070,7 +5075,7 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_set_state(port, SRC_UNATTACHED, PD_T_DRP_SRC);
 		break;
 	case SNK_ATTACH_WAIT:
-		if (tcpm_port_is_debug(port))
+		if (tcpm_port_is_debug_sink(port))
 			tcpm_set_state(port, DEBUG_ACC_ATTACHED,
 				       PD_T_CC_DEBOUNCE);
 		else if (tcpm_port_is_audio(port))
@@ -5090,7 +5095,7 @@ static void run_state_machine(struct tcpm_port *port)
 		if (tcpm_port_is_disconnected(port))
 			tcpm_set_state(port, SNK_UNATTACHED,
 				       PD_T_PD_DEBOUNCE);
-		else if (tcpm_port_is_debug(port))
+		else if (tcpm_port_is_debug_sink(port))
 			tcpm_set_state(port, DEBUG_ACC_ATTACHED,
 				       PD_T_CC_DEBOUNCE);
 		else if (tcpm_port_is_audio(port))
@@ -5961,10 +5966,10 @@ static void _tcpm_cc_change(struct tcpm_port *port, enum typec_cc_status cc1,
 
 	switch (port->state) {
 	case TOGGLING:
-		if (tcpm_port_is_debug(port) || tcpm_port_is_audio(port) ||
+		if (tcpm_port_is_debug_source(port) || tcpm_port_is_audio(port) ||
 		    tcpm_port_is_source(port))
 			tcpm_set_state(port, SRC_ATTACH_WAIT, 0);
-		else if (tcpm_port_is_sink(port))
+		else if (tcpm_port_is_debug_sink(port) || tcpm_port_is_sink(port))
 			tcpm_set_state(port, SNK_ATTACH_WAIT, 0);
 		break;
 	case CHECK_CONTAMINANT:
@@ -5972,9 +5977,11 @@ static void _tcpm_cc_change(struct tcpm_port *port, enum typec_cc_status cc1,
 		break;
 	case SRC_UNATTACHED:
 	case ACC_UNATTACHED:
-		if (tcpm_port_is_debug(port) || tcpm_port_is_audio(port) ||
+		if (tcpm_port_is_debug_source(port) || tcpm_port_is_audio(port) ||
 		    tcpm_port_is_source(port))
 			tcpm_set_state(port, SRC_ATTACH_WAIT, 0);
+		else if (tcpm_port_is_debug_sink(port))
+			tcpm_set_state(port, SNK_ATTACH_WAIT, 0);
 		break;
 	case SRC_ATTACH_WAIT:
 		if (tcpm_port_is_disconnected(port) ||
@@ -5996,7 +6003,7 @@ static void _tcpm_cc_change(struct tcpm_port *port, enum typec_cc_status cc1,
 		}
 		break;
 	case SNK_UNATTACHED:
-		if (tcpm_port_is_debug(port) || tcpm_port_is_audio(port) ||
+		if (tcpm_port_is_debug_sink(port) || tcpm_port_is_audio(port) ||
 		    tcpm_port_is_sink(port))
 			tcpm_set_state(port, SNK_ATTACH_WAIT, 0);
 		break;
diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index 1562a8f20b4f..5348f6c6f57c 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -46,6 +46,10 @@ int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 		info->fbops->fb_sync(info);
 
 	if (par->fd_size < d_cellsize * len) {
+		kfree(par->fontbuffer);
+		par->fontbuffer = NULL;
+		par->fd_size = 0;
+
 		dst = kmalloc_array(len, d_cellsize, GFP_KERNEL);
 
 		if (dst == NULL) {
@@ -54,7 +58,6 @@ int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 		}
 
 		par->fd_size = d_cellsize * len;
-		kfree(par->fontbuffer);
 		par->fontbuffer = dst;
 	}
 
diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index c341d76bc564..fdbb8671a810 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -321,12 +321,32 @@ static int dlfb_set_video_mode(struct dlfb_data *dlfb,
 	return retval;
 }
 
+static void dlfb_vm_open(struct vm_area_struct *vma)
+{
+	struct dlfb_data *dlfb = vma->vm_private_data;
+
+	atomic_inc(&dlfb->mmap_count);
+}
+
+static void dlfb_vm_close(struct vm_area_struct *vma)
+{
+	struct dlfb_data *dlfb = vma->vm_private_data;
+
+	atomic_dec(&dlfb->mmap_count);
+}
+
+static const struct vm_operations_struct dlfb_vm_ops = {
+	.open  = dlfb_vm_open,
+	.close = dlfb_vm_close,
+};
+
 static int dlfb_ops_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	unsigned long start = vma->vm_start;
 	unsigned long size = vma->vm_end - vma->vm_start;
 	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
 	unsigned long page, pos;
+	struct dlfb_data *dlfb = info->par;
 
 	if (info->fbdefio)
 		return fb_deferred_io_mmap(info, vma);
@@ -358,6 +378,9 @@ static int dlfb_ops_mmap(struct fb_info *info, struct vm_area_struct *vma)
 			size = 0;
 	}
 
+	vma->vm_ops = &dlfb_vm_ops;
+	vma->vm_private_data = dlfb;
+	atomic_inc(&dlfb->mmap_count);
 	return 0;
 }
 
@@ -1176,7 +1199,6 @@ static void dlfb_deferred_vfree(struct dlfb_data *dlfb, void *mem)
 
 /*
  * Assumes &info->lock held by caller
- * Assumes no active clients have framebuffer open
  */
 static int dlfb_realloc_framebuffer(struct dlfb_data *dlfb, struct fb_info *info, u32 new_len)
 {
@@ -1188,6 +1210,13 @@ static int dlfb_realloc_framebuffer(struct dlfb_data *dlfb, struct fb_info *info
 	new_len = PAGE_ALIGN(new_len);
 
 	if (new_len > old_len) {
+		if (atomic_read(&dlfb->mmap_count) > 0) {
+			dev_warn(info->dev,
+				"refusing realloc: %d active mmaps\n",
+				atomic_read(&dlfb->mmap_count));
+			return -EBUSY;
+		}
+
 		/*
 		 * Alloc system memory for virtual framebuffer
 		 */
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f643a0520872..2ad2d503e79a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1060,6 +1060,12 @@ static void compress_file_range(struct btrfs_work *work)
 			mapping_set_error(mapping, -EIO);
 		return;
 	}
+	/*
+	 * If a single block at file offset 0 cannot be inlined, fall back to
+	 * regular writes without marking the file incompressible.
+	 */
+	if (start == 0 && end <= blocksize)
+		goto cleanup_and_bail_uncompressed;
 
 	/*
 	 * We aren't doing an inline extent. Round the compressed size up to a
@@ -4961,6 +4967,8 @@ static int btrfs_rmdir(struct inode *vfs_dir, struct dentry *dentry)
 	if (ret)
 		goto out;
 
+	btrfs_record_unlink_dir(trans, dir, inode, false);
+
 	/* now the directory is empty */
 	ret = btrfs_unlink_inode(trans, dir, inode, &fname.disk_name);
 	if (!ret)
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d75d31b606e4..4a1d27e4884d 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2897,7 +2897,7 @@ static long btrfs_ioctl_space_info(struct btrfs_fs_info *fs_info,
 		return -ENOMEM;
 
 	space_args.total_spaces = 0;
-	dest = kmalloc(alloc_size, GFP_KERNEL);
+	dest = kzalloc(alloc_size, GFP_KERNEL);
 	if (!dest)
 		return -ENOMEM;
 	dest_orig = dest;
@@ -2953,7 +2953,8 @@ static long btrfs_ioctl_space_info(struct btrfs_fs_info *fs_info,
 	user_dest = (struct btrfs_ioctl_space_info __user *)
 		(arg + sizeof(struct btrfs_ioctl_space_args));
 
-	if (copy_to_user(user_dest, dest_orig, alloc_size))
+	if (copy_to_user(user_dest, dest_orig,
+		 space_args.total_spaces * sizeof(*dest_orig)))
 		return -EFAULT;
 
 out:
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 87cbc051cb12..4e5196cf7b35 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -276,10 +276,8 @@ static int create_space_info_sub_group(struct btrfs_space_info *parent, u64 flag
 	sub_group->subgroup_id = id;
 
 	ret = btrfs_sysfs_add_space_info_type(sub_group);
-	if (ret) {
-		kfree(sub_group);
+	if (ret)
 		parent->sub_group[index] = NULL;
-	}
 	return ret;
 }
 
@@ -311,7 +309,7 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 
 	ret = btrfs_sysfs_add_space_info_type(space_info);
 	if (ret)
-		goto out_free;
+		return ret;
 
 	list_add(&space_info->list, &info->space_info);
 	if (flags & BTRFS_BLOCK_GROUP_DATA)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index adc8befe119a..e35e2f03cfbc 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1576,7 +1576,8 @@ static bool f2fs_map_blocks_cached(struct inode *inode,
 		f2fs_wait_on_block_writeback_range(inode,
 					map->m_pblk, map->m_len);
 
-	if (f2fs_allow_multi_device_dio(sbi, flag)) {
+	map->m_multidev_dio = f2fs_allow_multi_device_dio(sbi, flag);
+	if (map->m_multidev_dio) {
 		int bidx = f2fs_target_device_index(sbi, map->m_pblk);
 		struct f2fs_dev_info *dev = &sbi->devs[bidx];
 
@@ -1636,8 +1637,26 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 	lfs_dio_write = (flag == F2FS_GET_BLOCK_DIO && f2fs_lfs_mode(sbi) &&
 				map->m_may_create);
 
-	if (!map->m_may_create && f2fs_map_blocks_cached(inode, map, flag))
-		goto out;
+	if (!map->m_may_create && f2fs_map_blocks_cached(inode, map, flag)) {
+		struct extent_info ei;
+
+		/*
+		 * 1. If map->m_multidev_dio is true, map->m_pblk cannot be
+		 * waitted by f2fs_wait_on_block_writeback_range() and are not
+		 * mergeable.
+		 * 2. If pgofs hits the read extent cache, it means the mapping
+		 * is already cached in the extent cache, but it is not
+		 * mergeable, and there is no need to query the mapping again
+		 * via f2fs_get_dnode_of_data().
+		 */
+		pgofs =	(pgoff_t)map->m_lblk + map->m_len;
+		if (map->m_len == maxblocks ||
+			map->m_multidev_dio ||
+			f2fs_lookup_read_extent_cache(inode, pgofs, &ei))
+			goto out;
+		ofs = map->m_len;
+		goto map_more;
+	}
 
 	map->m_bdev = inode->i_sb->s_bdev;
 	map->m_multidev_dio =
@@ -1648,7 +1667,8 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 
 	/* it only supports block size == page size */
 	pgofs =	(pgoff_t)map->m_lblk;
-	end = pgofs + maxblocks;
+map_more:
+	end = (pgoff_t)map->m_lblk + maxblocks;
 
 	if (flag == F2FS_GET_BLOCK_PRECACHE)
 		mode = LOOKUP_NODE_RA;
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 0ed84cc065a7..87169fd29d89 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -119,9 +119,10 @@ static bool __may_extent_tree(struct inode *inode, enum extent_type type)
 	if (!__init_may_extent_tree(inode, type))
 		return false;
 
+	if (is_inode_flag_set(inode, FI_NO_EXTENT))
+		return false;
+
 	if (type == EX_READ) {
-		if (is_inode_flag_set(inode, FI_NO_EXTENT))
-			return false;
 		if (is_inode_flag_set(inode, FI_COMPRESSED_FILE) &&
 				 !f2fs_sb_has_readonly(F2FS_I_SB(inode)))
 			return false;
@@ -644,6 +645,8 @@ static unsigned int __destroy_extent_node(struct inode *inode,
 
 	while (atomic_read(&et->node_cnt)) {
 		write_lock(&et->lock);
+		if (!is_inode_flag_set(inode, FI_NO_EXTENT))
+			set_inode_flag(inode, FI_NO_EXTENT);
 		node_cnt += __free_extent_tree(sbi, et, nr_shrink);
 		write_unlock(&et->lock);
 	}
@@ -688,12 +691,12 @@ static void __update_extent_tree_range(struct inode *inode,
 
 	write_lock(&et->lock);
 
-	if (type == EX_READ) {
-		if (is_inode_flag_set(inode, FI_NO_EXTENT)) {
-			write_unlock(&et->lock);
-			return;
-		}
+	if (is_inode_flag_set(inode, FI_NO_EXTENT)) {
+		write_unlock(&et->lock);
+		return;
+	}
 
+	if (type == EX_READ) {
 		prev = et->largest;
 		dei.len = 0;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 65c0d20df3a4..ef3961c6d8cf 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2042,6 +2042,9 @@ struct f2fs_sb_info {
 	spinlock_t iostat_lat_lock;
 	struct iostat_lat_info *iostat_io_lat;
 #endif
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lock_class_key cp_global_sem_key;
+#endif
 };
 
 /* Definitions to access f2fs_sb_info */
@@ -3947,6 +3950,8 @@ int f2fs_sanity_check_node_footer(struct f2fs_sb_info *sbi,
 					enum node_type ntype, bool in_irq);
 struct folio *f2fs_get_inode_folio(struct f2fs_sb_info *sbi, pgoff_t ino);
 struct folio *f2fs_get_xnode_folio(struct f2fs_sb_info *sbi, pgoff_t xnid);
+int f2fs_write_single_node_folio(struct folio *node_folio, int sync_mode,
+			bool mark_dirty, enum iostat_type io_type);
 int f2fs_move_node_folio(struct folio *node_folio, int gc_type);
 void f2fs_flush_inline_data(struct f2fs_sb_info *sbi);
 int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 0a1052d5ee62..62a8a1192a41 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -792,7 +792,7 @@ int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
 int f2fs_inline_data_fiemap(struct inode *inode,
 		struct fiemap_extent_info *fieinfo, __u64 start, __u64 len)
 {
-	__u64 byteaddr, ilen;
+	__u64 byteaddr = 0, ilen;
 	__u32 flags = FIEMAP_EXTENT_DATA_INLINE | FIEMAP_EXTENT_NOT_ALIGNED |
 		FIEMAP_EXTENT_LAST;
 	struct node_info ni;
@@ -814,6 +814,15 @@ int f2fs_inline_data_fiemap(struct inode *inode,
 		goto out;
 	}
 
+	if (fieinfo->fi_flags & FIEMAP_FLAG_SYNC) {
+		err = f2fs_write_single_node_folio(ifolio, true, false, FS_NODE_IO);
+		if (err)
+			return err;
+		ifolio = f2fs_get_inode_folio(F2FS_I_SB(inode), inode->i_ino);
+		if (IS_ERR(ifolio))
+			return PTR_ERR(ifolio);
+		f2fs_folio_wait_writeback(ifolio, NODE, true, true);
+	}
 	ilen = min_t(size_t, MAX_INLINE_DATA(inode), i_size_read(inode));
 	if (start >= ilen)
 		goto out;
@@ -825,9 +834,14 @@ int f2fs_inline_data_fiemap(struct inode *inode,
 	if (err)
 		goto out;
 
-	byteaddr = (__u64)ni.blk_addr << inode->i_sb->s_blocksize_bits;
-	byteaddr += (char *)inline_data_addr(inode, ifolio) -
-					(char *)F2FS_INODE(ifolio);
+	if (__is_valid_data_blkaddr(ni.blk_addr)) {
+		byteaddr = (__u64)ni.blk_addr << inode->i_sb->s_blocksize_bits;
+		byteaddr += (char *)inline_data_addr(inode, ifolio) -
+						(char *)F2FS_INODE(ifolio);
+	} else {
+		f2fs_bug_on(F2FS_I_SB(inode), ni.blk_addr != NEW_ADDR);
+		flags |= FIEMAP_EXTENT_DELALLOC | FIEMAP_EXTENT_UNKNOWN;
+	}
 	err = fiemap_fill_next_extent(fieinfo, start, byteaddr, ilen, flags);
 	trace_f2fs_fiemap(inode, start, byteaddr, ilen, flags, err);
 out:
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index e0f850b3f0c3..89240be8cc59 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -687,7 +687,7 @@ void f2fs_update_inode(struct inode *inode, struct folio *node_folio)
 	ri->i_uid = cpu_to_le32(i_uid_read(inode));
 	ri->i_gid = cpu_to_le32(i_gid_read(inode));
 	ri->i_links = cpu_to_le32(inode->i_nlink);
-	ri->i_blocks = cpu_to_le64(SECTOR_TO_BLOCK(inode->i_blocks) + 1);
+	ri->i_blocks = cpu_to_le64(SECTOR_TO_BLOCK(READ_ONCE(inode->i_blocks)) + 1);
 
 	if (!f2fs_is_atomic_file(inode) ||
 			is_inode_flag_set(inode, FI_ATOMIC_COMMITTED))
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 74992fd9c9b6..9ff954952a15 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1729,9 +1729,10 @@ static struct folio *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
 	return last_folio;
 }
 
-static bool __write_node_folio(struct folio *folio, bool atomic, bool *submitted,
-				struct writeback_control *wbc, bool do_balance,
-				enum iostat_type io_type, unsigned int *seq_id)
+static bool __write_node_folio(struct folio *folio, bool atomic, bool do_fsync,
+				bool *submitted, struct writeback_control *wbc,
+				bool do_balance, enum iostat_type io_type,
+				unsigned int *seq_id)
 {
 	struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
 	nid_t nid;
@@ -1801,13 +1802,14 @@ static bool __write_node_folio(struct folio *folio, bool atomic, bool *submitted
 		goto redirty_out;
 	}
 
-	if (atomic) {
-		if (!test_opt(sbi, NOBARRIER))
-			fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
-		if (IS_INODE(folio))
-			set_dentry_mark(folio,
+	if (atomic && !test_opt(sbi, NOBARRIER))
+		fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
+
+	set_dentry_mark(folio, false);
+	set_fsync_mark(folio, do_fsync);
+	if (IS_INODE(folio) && (atomic || is_fsync_dnode(folio)))
+		set_dentry_mark(folio,
 				f2fs_need_dentry_mark(sbi, ino_of_node(folio)));
-	}
 
 	/* should add to global list before clearing PAGECACHE status */
 	if (f2fs_in_warm_node_list(sbi, folio)) {
@@ -1843,41 +1845,51 @@ static bool __write_node_folio(struct folio *folio, bool atomic, bool *submitted
 	return false;
 }
 
-int f2fs_move_node_folio(struct folio *node_folio, int gc_type)
+int f2fs_write_single_node_folio(struct folio *node_folio, int sync_mode,
+			bool mark_dirty, enum iostat_type io_type)
 {
 	int err = 0;
+	struct writeback_control wbc = {
+		.sync_mode = WB_SYNC_ALL,
+		.nr_to_write = 1,
+	};
 
-	if (gc_type == FG_GC) {
-		struct writeback_control wbc = {
-			.sync_mode = WB_SYNC_ALL,
-			.nr_to_write = 1,
-		};
+	if (!sync_mode) {
+		/* set page dirty and write it */
+		if (!folio_test_writeback(node_folio))
+			folio_mark_dirty(node_folio);
+		goto out_folio;
+	}
 
-		f2fs_folio_wait_writeback(node_folio, NODE, true, true);
+	f2fs_folio_wait_writeback(node_folio, NODE, true, true);
 
+	if (mark_dirty)
 		folio_mark_dirty(node_folio);
+	else if (!folio_test_dirty(node_folio))
+		goto out_folio;
 
-		if (!folio_clear_dirty_for_io(node_folio)) {
-			err = -EAGAIN;
-			goto out_page;
-		}
-
-		if (!__write_node_folio(node_folio, false, NULL,
-					&wbc, false, FS_GC_NODE_IO, NULL))
-			err = -EAGAIN;
-		goto release_page;
-	} else {
-		/* set page dirty and write it */
-		if (!folio_test_writeback(node_folio))
-			folio_mark_dirty(node_folio);
+	if (!folio_clear_dirty_for_io(node_folio)) {
+		err = -EAGAIN;
+		goto out_folio;
 	}
-out_page:
+
+	if (!__write_node_folio(node_folio, false, false, NULL,
+				&wbc, false, FS_GC_NODE_IO, NULL))
+		err = -EAGAIN;
+	goto release_folio;
+out_folio:
 	folio_unlock(node_folio);
-release_page:
+release_folio:
 	f2fs_folio_put(node_folio, false);
 	return err;
 }
 
+int f2fs_move_node_folio(struct folio *node_folio, int gc_type)
+{
+	return f2fs_write_single_node_folio(node_folio, gc_type == FG_GC,
+			true, FS_GC_NODE_IO);
+}
+
 int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			struct writeback_control *wbc, bool atomic,
 			unsigned int *seq_id)
@@ -1908,6 +1920,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 		for (i = 0; i < nr_folios; i++) {
 			struct folio *folio = fbatch.folios[i];
 			bool submitted = false;
+			bool do_fsync = false;
 
 			if (unlikely(f2fs_cp_error(sbi))) {
 				f2fs_folio_put(last_folio, false);
@@ -1938,19 +1951,13 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 
 			f2fs_folio_wait_writeback(folio, NODE, true, true);
 
-			set_fsync_mark(folio, 0);
-			set_dentry_mark(folio, 0);
-
 			if (!atomic || folio == last_folio) {
-				set_fsync_mark(folio, 1);
+				do_fsync = true;
 				percpu_counter_inc(&sbi->rf_node_block_count);
 				if (IS_INODE(folio)) {
 					if (is_inode_flag_set(inode,
 								FI_DIRTY_INODE))
 						f2fs_update_inode(inode, folio);
-					if (!atomic)
-						set_dentry_mark(folio,
-							f2fs_need_dentry_mark(sbi, ino));
 				}
 				/* may be written by other thread */
 				if (!folio_test_dirty(folio))
@@ -1962,8 +1969,9 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 
 			if (!__write_node_folio(folio, atomic &&
 						folio == last_folio,
-						&submitted, wbc, true,
-						FS_NODE_IO, seq_id)) {
+						do_fsync, &submitted,
+						wbc, true, FS_NODE_IO,
+						seq_id)) {
 				f2fs_folio_put(last_folio, false);
 				folio_batch_release(&fbatch);
 				ret = -EIO;
@@ -2163,10 +2171,7 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 			if (!folio_clear_dirty_for_io(folio))
 				goto continue_unlock;
 
-			set_fsync_mark(folio, 0);
-			set_dentry_mark(folio, 0);
-
-			if (!__write_node_folio(folio, false, &submitted,
+			if (!__write_node_folio(folio, false, false, &submitted,
 					wbc, do_balance, io_type, NULL)) {
 				folio_batch_release(&fbatch);
 				ret = -EIO;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 40079fd7886b..255db40c49ed 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4953,6 +4953,11 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	init_f2fs_rwsem_trace(&sbi->gc_lock, sbi, LOCK_NAME_GC_LOCK);
 	mutex_init(&sbi->writepages);
 	init_f2fs_rwsem_trace(&sbi->cp_global_sem, sbi, LOCK_NAME_CP_GLOBAL);
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	lockdep_register_key(&sbi->cp_global_sem_key);
+	lockdep_set_class(&sbi->cp_global_sem.internal_rwsem,
+					&sbi->cp_global_sem_key);
+#endif
 	init_f2fs_rwsem_trace(&sbi->node_write, sbi, LOCK_NAME_NODE_WRITE);
 	init_f2fs_rwsem_trace(&sbi->node_change, sbi, LOCK_NAME_NODE_CHANGE);
 	spin_lock_init(&sbi->stat_lock);
@@ -5424,6 +5429,9 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 free_sb_buf:
 	kfree(raw_super);
 free_sbi:
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	lockdep_unregister_key(&sbi->cp_global_sem_key);
+#endif
 	kfree(sbi);
 	sb->s_fs_info = NULL;
 
@@ -5505,6 +5513,9 @@ static void kill_f2fs_super(struct super_block *sb)
 	/* Release block devices last, after fscrypt_destroy_keyring(). */
 	if (sbi) {
 		destroy_device_list(sbi);
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+		lockdep_unregister_key(&sbi->cp_global_sem_key);
+#endif
 		kfree(sbi);
 		sb->s_fs_info = NULL;
 	}
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 5fbfdc96e502..cd1921edb59e 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1984,24 +1984,26 @@ int __init f2fs_init_sysfs(void)
 	ret = kobject_init_and_add(&f2fs_feat, &f2fs_feat_ktype,
 				   NULL, "features");
 	if (ret)
-		goto put_kobject;
+		goto unregister_kset;
 
 	ret = kobject_init_and_add(&f2fs_tune, &f2fs_tune_ktype,
 				   NULL, "tuning");
 	if (ret)
-		goto put_kobject;
+		goto put_feat;
 
 	f2fs_proc_root = proc_mkdir("fs/f2fs", NULL);
 	if (!f2fs_proc_root) {
 		ret = -ENOMEM;
-		goto put_kobject;
+		goto put_tune;
 	}
 
 	return 0;
 
-put_kobject:
+put_tune:
 	kobject_put(&f2fs_tune);
+put_feat:
 	kobject_put(&f2fs_feat);
+unregister_kset:
 	kset_unregister(&f2fs_kset);
 	return ret;
 }
diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index 336d654861c5..9a55fa6d5294 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -287,3 +287,54 @@ int hfs_brec_goto(struct hfs_find_data *fd, int cnt)
 	fd->bnode = bnode;
 	return res;
 }
+
+/**
+ * hfsplus_brec_read_cat - read and validate a catalog record
+ * @fd: find data structure
+ * @entry: pointer to catalog entry to read into
+ *
+ * Reads a catalog record and validates its size matches the expected
+ * size based on the record type.
+ *
+ * Returns 0 on success, or negative error code on failure.
+ */
+int hfsplus_brec_read_cat(struct hfs_find_data *fd, hfsplus_cat_entry *entry)
+{
+	int res;
+	u32 expected_size;
+
+	res = hfs_brec_read(fd, entry, sizeof(hfsplus_cat_entry));
+	if (res)
+		return res;
+
+	/* Validate catalog record size based on type */
+	switch (be16_to_cpu(entry->type)) {
+	case HFSPLUS_FOLDER:
+		expected_size = sizeof(struct hfsplus_cat_folder);
+		break;
+	case HFSPLUS_FILE:
+		expected_size = sizeof(struct hfsplus_cat_file);
+		break;
+	case HFSPLUS_FOLDER_THREAD:
+	case HFSPLUS_FILE_THREAD:
+		/* Ensure we have at least the fixed fields before reading nodeName.length */
+		if (fd->entrylength < HFSPLUS_MIN_THREAD_SZ) {
+			pr_err("thread record too short (got %u)\n", fd->entrylength);
+			return -EIO;
+		}
+		expected_size = hfsplus_cat_thread_size(&entry->thread);
+		break;
+	default:
+		pr_err("unknown catalog record type %d\n",
+		       be16_to_cpu(entry->type));
+		return -EIO;
+	}
+
+	if (fd->entrylength != expected_size) {
+		pr_err("catalog record size mismatch (type %d, got %u, expected %u)\n",
+		       be16_to_cpu(entry->type), fd->entrylength, expected_size);
+		return -EIO;
+	}
+
+	return 0;
+}
diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
index 02c1eee4a4b8..6c8380f7208d 100644
--- a/fs/hfsplus/catalog.c
+++ b/fs/hfsplus/catalog.c
@@ -194,12 +194,12 @@ static int hfsplus_fill_cat_thread(struct super_block *sb,
 int hfsplus_find_cat(struct super_block *sb, u32 cnid,
 		     struct hfs_find_data *fd)
 {
-	hfsplus_cat_entry tmp;
+	hfsplus_cat_entry tmp = {0};
 	int err;
 	u16 type;
 
 	hfsplus_cat_build_key_with_cnid(sb, fd->search_key, cnid);
-	err = hfs_brec_read(fd, &tmp, sizeof(hfsplus_cat_entry));
+	err = hfsplus_brec_read_cat(fd, &tmp);
 	if (err)
 		return err;
 
diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index d559bf8625f8..25535592234c 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -49,7 +49,7 @@ static struct dentry *hfsplus_lookup(struct inode *dir, struct dentry *dentry,
 	if (unlikely(err < 0))
 		goto fail;
 again:
-	err = hfs_brec_read(&fd, &entry, sizeof(entry));
+	err = hfsplus_brec_read_cat(&fd, &entry);
 	if (err) {
 		if (err == -ENOENT) {
 			hfs_find_exit(&fd);
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 5f891b73a646..61d52091dd28 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -509,6 +509,15 @@ int hfsplus_submit_bio(struct super_block *sb, sector_t sector, void *buf,
 		       void **data, blk_opf_t opf);
 int hfsplus_read_wrapper(struct super_block *sb);
 
+static inline u32 hfsplus_cat_thread_size(const struct hfsplus_cat_thread *thread)
+{
+	return offsetof(struct hfsplus_cat_thread, nodeName) +
+	       offsetof(struct hfsplus_unistr, unicode) +
+	       be16_to_cpu(thread->nodeName.length) * sizeof(hfsplus_unichr);
+}
+
+int hfsplus_brec_read_cat(struct hfs_find_data *fd, hfsplus_cat_entry *entry);
+
 /*
  * time helpers: convert between 1904-base and 1970-base timestamps
  *
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 7229a8ae89f9..67df3af9cf15 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -569,9 +569,11 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		goto out_put_root;
 	err = hfsplus_cat_build_key(sb, fd.search_key, HFSPLUS_ROOT_CNID, &str);
-	if (unlikely(err < 0))
+	if (unlikely(err < 0)) {
+		hfs_find_exit(&fd);
 		goto out_put_root;
-	if (!hfs_brec_read(&fd, &entry, sizeof(entry))) {
+	}
+	if (!hfsplus_brec_read_cat(&fd, &entry)) {
 		hfs_find_exit(&fd);
 		if (entry.type != cpu_to_be16(HFSPLUS_FOLDER)) {
 			err = -EIO;
diff --git a/fs/isofs/export.c b/fs/isofs/export.c
index 421d247fae52..78f80c1a5c54 100644
--- a/fs/isofs/export.c
+++ b/fs/isofs/export.c
@@ -24,7 +24,7 @@ isofs_export_iget(struct super_block *sb,
 {
 	struct inode *inode;
 
-	if (block == 0)
+	if (block == 0 || block >= ISOFS_SB(sb)->s_nzones)
 		return ERR_PTR(-ESTALE);
 	inode = isofs_iget(sb, block, offset);
 	if (IS_ERR(inode))
diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
index 6fe6dbd0c740..1232fab59a4e 100644
--- a/fs/isofs/rock.c
+++ b/fs/isofs/rock.c
@@ -101,6 +101,15 @@ static int rock_continue(struct rock_state *rs)
 		goto out;
 	}
 
+	if ((unsigned)rs->cont_extent >= ISOFS_SB(rs->inode->i_sb)->s_nzones) {
+		printk(KERN_NOTICE "rock: corrupted directory entry. "
+			"extent=%u out of volume (nzones=%lu)\n",
+			(unsigned)rs->cont_extent,
+			ISOFS_SB(rs->inode->i_sb)->s_nzones);
+		ret = -EIO;
+		goto out;
+	}
+
 	if (rs->cont_extent) {
 		struct buffer_head *bh;
 
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 9995de1710e5..b646a861a84c 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -388,7 +388,7 @@ static struct fsnotify_mark *fsnotify_first_mark(struct fsnotify_mark_connector
 	return hlist_entry_safe(node, struct fsnotify_mark, obj_list);
 }
 
-static struct fsnotify_mark *fsnotify_next_mark(struct fsnotify_mark *mark)
+struct fsnotify_mark *fsnotify_next_mark(struct fsnotify_mark *mark)
 {
 	struct hlist_node *node = NULL;
 
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index c2ed5b11b0fe..622f05977f86 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -457,9 +457,6 @@ EXPORT_SYMBOL_GPL(fsnotify_put_mark);
  */
 static bool fsnotify_get_mark_safe(struct fsnotify_mark *mark)
 {
-	if (!mark)
-		return true;
-
 	if (refcount_inc_not_zero(&mark->refcnt)) {
 		spin_lock(&mark->lock);
 		if (mark->flags & FSNOTIFY_MARK_FLAG_ATTACHED) {
@@ -500,15 +497,22 @@ bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info)
 	int type;
 
 	fsnotify_foreach_iter_type(type) {
+		struct fsnotify_mark *mark = iter_info->marks[type];
+
 		/* This can fail if mark is being removed */
-		if (!fsnotify_get_mark_safe(iter_info->marks[type])) {
-			__release(&fsnotify_mark_srcu);
-			goto fail;
+		while (mark && !fsnotify_get_mark_safe(mark)) {
+			if (mark->group == iter_info->current_group) {
+				__release(&fsnotify_mark_srcu);
+				goto fail;
+			}
+			/* This is a mark in an unrelated group, skip */
+			mark = fsnotify_next_mark(mark);
+			iter_info->marks[type] = mark;
 		}
 	}
 
 	/*
-	 * Now that both marks are pinned by refcount in the inode / vfsmount
+	 * Now that all marks are pinned by refcount in the inode / vfsmount / etc
 	 * lists, we can drop SRCU lock, and safely resume the list iteration
 	 * once userspace returns.
 	 */
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 2ea769f311c3..339cb0a3942b 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1379,7 +1379,7 @@ int ovl_ensure_verity_loaded(const struct path *datapath)
 	struct inode *inode = d_inode(datapath->dentry);
 	struct file *filp;
 
-	if (!fsverity_active(inode) && IS_VERITY(inode)) {
+	if (IS_VERITY(inode) && fsverity_get_info(inode) == NULL) {
 		/*
 		 * If this inode was not yet opened, the verity info hasn't been
 		 * loaded yet, so we need to do that here to force it into memory.
diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index 04bb95091f49..64e22c064fa0 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -286,6 +286,14 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 			    &rqst[0], &oplock, &oparms, utf16_path);
 	if (rc)
 		goto oshr_free;
+
+	if (oplock != SMB2_OPLOCK_LEVEL_II) {
+		rc = -EINVAL;
+		cifs_dbg(FYI, "%s: Oplock level %d not suitable for cached directory\n",
+			 __func__, oplock);
+		goto oshr_free;
+	}
+
 	smb2_set_next_command(tcon, &rqst[0]);
 
 	memset(&qi_iov, 0, sizeof(qi_iov));
diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index 4ec204d2c774..e5d0d581c130 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -1264,6 +1264,17 @@ static int parse_sid(struct smb_sid *psid, char *end_of_acl)
 	return 0;
 }
 
+static bool dacl_offset_valid(unsigned int acl_len, __u32 dacloffset)
+{
+	if (acl_len < sizeof(struct smb_acl))
+		return false;
+
+	if (dacloffset < sizeof(struct smb_ntsd))
+		return false;
+
+	return dacloffset <= acl_len - sizeof(struct smb_acl);
+}
+
 
 /* Convert CIFS ACL to POSIX form */
 static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
@@ -1284,7 +1295,6 @@ static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
 	group_sid_ptr = (struct smb_sid *)((char *)pntsd +
 				le32_to_cpu(pntsd->gsidoffset));
 	dacloffset = le32_to_cpu(pntsd->dacloffset);
-	dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
 	cifs_dbg(NOISY, "revision %d type 0x%x ooffset 0x%x goffset 0x%x sacloffset 0x%x dacloffset 0x%x\n",
 		 pntsd->revision, pntsd->type, le32_to_cpu(pntsd->osidoffset),
 		 le32_to_cpu(pntsd->gsidoffset),
@@ -1315,11 +1325,18 @@ static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
 		return rc;
 	}
 
-	if (dacloffset)
+	if (dacloffset) {
+		if (!dacl_offset_valid(acl_len, dacloffset)) {
+			cifs_dbg(VFS, "Server returned illegal DACL offset\n");
+			return -EINVAL;
+		}
+
+		dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
 		parse_dacl(dacl_ptr, end_of_acl, owner_sid_ptr,
 			   group_sid_ptr, fattr, get_mode_from_special_sid);
-	else
+	} else {
 		cifs_dbg(FYI, "no ACL\n"); /* BB grant all or default perms? */
+	}
 
 	return rc;
 }
@@ -1342,6 +1359,11 @@ static int build_sec_desc(struct smb_ntsd *pntsd, struct smb_ntsd *pnntsd,
 
 	dacloffset = le32_to_cpu(pntsd->dacloffset);
 	if (dacloffset) {
+		if (!dacl_offset_valid(secdesclen, dacloffset)) {
+			cifs_dbg(VFS, "Server returned illegal DACL offset\n");
+			return -EINVAL;
+		}
+
 		dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
 		rc = validate_dacl(dacl_ptr, end_of_acl);
 		if (rc)
@@ -1710,6 +1732,12 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 		nsecdesclen = sizeof(struct smb_ntsd) + (sizeof(struct smb_sid) * 2);
 		dacloffset = le32_to_cpu(pntsd->dacloffset);
 		if (dacloffset) {
+			if (!dacl_offset_valid(secdesclen, dacloffset)) {
+				cifs_dbg(VFS, "Server returned illegal DACL offset\n");
+				rc = -EINVAL;
+				goto id_mode_to_cifs_acl_exit;
+			}
+
 			dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
 			rc = validate_dacl(dacl_ptr, (char *)pntsd + secdesclen);
 			if (rc) {
@@ -1732,7 +1760,7 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 	 * descriptor parameters, and security descriptor itself
 	 */
 	nsecdesclen = max_t(u32, nsecdesclen, DEFAULT_SEC_DESC_LEN);
-	pnntsd = kmalloc(nsecdesclen, GFP_KERNEL);
+	pnntsd = kzalloc(nsecdesclen, GFP_KERNEL);
 	if (!pnntsd) {
 		kfree(pntsd);
 		cifs_put_tlink(tlink);
@@ -1752,6 +1780,7 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 		rc = ops->set_acl(pnntsd, nsecdesclen, inode, path, aclflag);
 		cifs_dbg(NOISY, "set_cifs_acl rc: %d\n", rc);
 	}
+id_mode_to_cifs_acl_exit:
 	cifs_put_tlink(tlink);
 
 	kfree(pnntsd);
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index fe1c9d776580..3b09cf8ab0f2 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -111,7 +111,7 @@ static int check_wsl_eas(struct kvec *rsp_iov)
 	u32 outlen, next;
 	u16 vlen;
 	u8 nlen;
-	u8 *end;
+	u8 *ea_end, *iov_end;
 
 	outlen = le32_to_cpu(rsp->OutputBufferLength);
 	if (outlen < SMB2_WSL_MIN_QUERY_EA_RESP_SIZE ||
@@ -120,15 +120,19 @@ static int check_wsl_eas(struct kvec *rsp_iov)
 
 	ea = (void *)((u8 *)rsp_iov->iov_base +
 		      le16_to_cpu(rsp->OutputBufferOffset));
-	end = (u8 *)rsp_iov->iov_base + rsp_iov->iov_len;
+	ea_end = (u8 *)ea + outlen;
+	iov_end = (u8 *)rsp_iov->iov_base + rsp_iov->iov_len;
+	if (ea_end > iov_end)
+		return -EINVAL;
+
 	for (;;) {
-		if ((u8 *)ea > end - sizeof(*ea))
+		if ((u8 *)ea > ea_end - sizeof(*ea))
 			return -EINVAL;
 
 		nlen = ea->ea_name_length;
 		vlen = le16_to_cpu(ea->ea_value_length);
 		if (nlen != SMB2_WSL_XATTR_NAME_LEN ||
-		    (u8 *)ea->ea_data + nlen + 1 + vlen > end)
+		    (u8 *)ea->ea_data + nlen + 1 + vlen > ea_end)
 			return -EINVAL;
 
 		switch (vlen) {
diff --git a/fs/smb/client/smb2misc.c b/fs/smb/client/smb2misc.c
index 973fce3c959c..2a7355ce1a07 100644
--- a/fs/smb/client/smb2misc.c
+++ b/fs/smb/client/smb2misc.c
@@ -241,7 +241,8 @@ smb2_check_message(char *buf, unsigned int pdu_len, unsigned int len,
 	if (len != calc_len) {
 		/* create failed on symlink */
 		if (command == SMB2_CREATE_HE &&
-		    shdr->Status == STATUS_STOPPED_ON_SYMLINK)
+		    shdr->Status == STATUS_STOPPED_ON_SYMLINK &&
+		    len > calc_len)
 			return 0;
 		/* Windows 7 server returns 24 bytes more */
 		if (calc_len + 24 == len && command == SMB2_OPLOCK_BREAK_HE)
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 3600705255f8..ccc06c83956b 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -111,10 +111,21 @@ smb2_add_credits(struct TCP_Server_Info *server,
 				      cifs_trace_rw_credits_zero_in_flight);
 	}
 	server->in_flight--;
+
+	/*
+	 * Rebalance credits when an op drains in_flight. For session setup,
+	 * do this only when the total accumulated credits are high enough (>2)
+	 * so that a newly established secondary channel can reserve credits for
+	 * echoes and oplocks. We expect this to happen at the end of the final
+	 * session setup response.
+	 */
 	if (server->in_flight == 0 &&
 	   ((optype & CIFS_OP_MASK) != CIFS_NEG_OP) &&
 	   ((optype & CIFS_OP_MASK) != CIFS_SESS_OP))
 		rc = change_conf(server);
+	else if (server->in_flight == 0 &&
+		 ((optype & CIFS_OP_MASK) == CIFS_SESS_OP) && *val > 2)
+		rc = change_conf(server);
 	/*
 	 * Sometimes server returns 0 credits on oplock break ack - we need to
 	 * rebalance credits in this case.
diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index 461658105013..d0fcc7779415 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -2920,7 +2920,7 @@ struct smbdirect_mr_io *smbd_register_mr(struct smbd_connection *info,
 	struct smbdirect_socket *sc = &info->socket;
 	struct smbdirect_socket_parameters *sp = &sc->parameters;
 	struct smbdirect_mr_io *mr;
-	int rc, num_pages;
+	int rc, num_pages, num_mapped;
 	struct ib_reg_wr *reg_wr;
 
 	num_pages = iov_iter_npages(iter, sp->max_frmr_depth + 1);
@@ -2948,18 +2948,21 @@ struct smbdirect_mr_io *smbd_register_mr(struct smbd_connection *info,
 		    num_pages, iov_iter_count(iter), sp->max_frmr_depth);
 	smbd_iter_to_mr(iter, &mr->sgt, sp->max_frmr_depth);
 
-	rc = ib_dma_map_sg(sc->ib.dev, mr->sgt.sgl, mr->sgt.nents, mr->dir);
-	if (!rc) {
-		log_rdma_mr(ERR, "ib_dma_map_sg num_pages=%x dir=%x rc=%x\n",
-			    num_pages, mr->dir, rc);
+	num_mapped = ib_dma_map_sg(sc->ib.dev, mr->sgt.sgl, mr->sgt.nents, mr->dir);
+	if (!num_mapped) {
+		log_rdma_mr(ERR, "ib_dma_map_sg num_pages=%x dir=%x num_mapped=%x\n",
+			    num_pages, mr->dir, num_mapped);
+		rc = -EIO;
 		goto dma_map_error;
 	}
 
-	rc = ib_map_mr_sg(mr->mr, mr->sgt.sgl, mr->sgt.nents, NULL, PAGE_SIZE);
-	if (rc != mr->sgt.nents) {
+	rc = ib_map_mr_sg(mr->mr, mr->sgt.sgl, num_mapped, NULL, PAGE_SIZE);
+	if (rc != num_mapped) {
 		log_rdma_mr(ERR,
-			    "ib_map_mr_sg failed rc = %d nents = %x\n",
-			    rc, mr->sgt.nents);
+			    "ib_map_mr_sg failed rc = %d num_mapped = %x\n",
+			    rc, num_mapped);
+		if (rc >= 0)
+			rc = -EIO;
 		goto map_mr_error;
 	}
 
diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index 48f0c51740cf..9d7e8a081272 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -535,24 +535,54 @@ int ksmbd_conn_transport_init(void)
 
 static void stop_sessions(void)
 {
-	struct ksmbd_conn *conn;
+	struct ksmbd_conn *conn, *target;
 	struct ksmbd_transport *t;
+	bool any;
 	int bkt;
 
+	/*
+	 * Serialised via init_lock; no concurrent stop_sessions() can
+	 * touch conn->stop_called, so writing it under the read lock is
+	 * safe.
+	 */
 again:
+	target = NULL;
+	any = false;
 	down_read(&conn_list_lock);
 	hash_for_each(conn_list, bkt, conn, hlist) {
-		t = conn->transport;
-		ksmbd_conn_set_exiting(conn);
-		if (t->ops->shutdown) {
-			up_read(&conn_list_lock);
+		any = true;
+		if (conn->stop_called)
+			continue;
+		atomic_inc(&conn->refcnt);
+		conn->stop_called = true;
+		/*
+		 * Mark the connection EXITING while still holding the
+		 * read lock so the selection and the status transition
+		 * happen together.  Do not regress a connection that has
+		 * already advanced to RELEASING on its own (e.g. the
+		 * handler exited its receive loop for an unrelated
+		 * reason).
+		 */
+		if (READ_ONCE(conn->status) != KSMBD_SESS_RELEASING)
+			ksmbd_conn_set_exiting(conn);
+		target = conn;
+		break;
+	}
+	up_read(&conn_list_lock);
+
+	if (target) {
+		t = target->transport;
+		if (t->ops->shutdown)
 			t->ops->shutdown(t);
-			down_read(&conn_list_lock);
+		if (atomic_dec_and_test(&target->refcnt)) {
+			ida_destroy(&target->async_ida);
+			t->ops->free_transport(t);
+			kfree(target);
 		}
+		goto again;
 	}
-	up_read(&conn_list_lock);
 
-	if (!hash_empty(conn_list)) {
+	if (any) {
 		msleep(100);
 		goto again;
 	}
diff --git a/fs/smb/server/connection.h b/fs/smb/server/connection.h
index 1e2587036bca..4df31e85a77c 100644
--- a/fs/smb/server/connection.h
+++ b/fs/smb/server/connection.h
@@ -49,6 +49,7 @@ struct ksmbd_conn {
 	struct mutex			srv_mutex;
 	int				status;
 	unsigned int			cli_cap;
+	bool				stop_called;
 	union {
 		__be32			inet_addr;
 #if IS_ENABLED(CONFIG_IPV6)
diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 4bbc2c27e680..c1d1f34581d6 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1068,7 +1068,26 @@ static void smb_set_ace(struct smb_ace *ace, const struct smb_sid *sid, u8 type,
 	ace->flags = flags;
 	ace->access_req = access_req;
 	smb_copy_sid(&ace->sid, sid);
-	ace->size = cpu_to_le16(1 + 1 + 2 + 4 + 1 + 1 + 6 + (sid->num_subauth * 4));
+	ace->size = cpu_to_le16(1 + 1 + 2 + 4 + 1 + 1 + 6 +
+				(ace->sid.num_subauth * 4));
+}
+
+static int smb_append_inherited_ace(struct smb_ace **ace, int *nt_size,
+				    u16 *ace_cnt, const struct smb_sid *sid,
+				    u8 type, u8 flags, __le32 access_req)
+{
+	int ace_size;
+
+	smb_set_ace(*ace, sid, type, flags, access_req);
+	ace_size = le16_to_cpu((*ace)->size);
+	/* pdacl->size is __le16 and includes struct smb_acl. */
+	if (check_add_overflow(*nt_size, ace_size, nt_size) ||
+	    *nt_size > U16_MAX - (int)sizeof(struct smb_acl))
+		return -EINVAL;
+
+	(*ace_cnt)++;
+	*ace = (struct smb_ace *)((char *)*ace + ace_size);
+	return 0;
 }
 
 int smb_inherit_dacl(struct ksmbd_conn *conn,
@@ -1157,6 +1176,12 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 				CIFS_SID_BASE_SIZE)
 			break;
 
+		if (parent_aces->sid.num_subauth > SID_MAX_SUB_AUTHORITIES ||
+		    pace_size < offsetof(struct smb_ace, sid) +
+				CIFS_SID_BASE_SIZE +
+				sizeof(__le32) * parent_aces->sid.num_subauth)
+			break;
+
 		aces_size -= pace_size;
 
 		flags = parent_aces->flags;
@@ -1186,22 +1211,24 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 		}
 
 		if (is_dir && creator && flags & CONTAINER_INHERIT_ACE) {
-			smb_set_ace(aces, psid, parent_aces->type, inherited_flags,
-				    parent_aces->access_req);
-			nt_size += le16_to_cpu(aces->size);
-			ace_cnt++;
-			aces = (struct smb_ace *)((char *)aces + le16_to_cpu(aces->size));
+			rc = smb_append_inherited_ace(&aces, &nt_size, &ace_cnt,
+						      psid, parent_aces->type,
+						      inherited_flags,
+						      parent_aces->access_req);
+			if (rc)
+				goto free_aces_base;
 			flags |= INHERIT_ONLY_ACE;
 			psid = creator;
 		} else if (is_dir && !(parent_aces->flags & NO_PROPAGATE_INHERIT_ACE)) {
 			psid = &parent_aces->sid;
 		}
 
-		smb_set_ace(aces, psid, parent_aces->type, flags | inherited_flags,
-			    parent_aces->access_req);
-		nt_size += le16_to_cpu(aces->size);
-		aces = (struct smb_ace *)((char *)aces + le16_to_cpu(aces->size));
-		ace_cnt++;
+		rc = smb_append_inherited_ace(&aces, &nt_size, &ace_cnt, psid,
+					      parent_aces->type,
+					      flags | inherited_flags,
+					      parent_aces->access_req);
+		if (rc)
+			goto free_aces_base;
 pass:
 		parent_aces = (struct smb_ace *)((char *)parent_aces + pace_size);
 	}
@@ -1211,7 +1238,7 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 		struct smb_acl *pdacl;
 		struct smb_sid *powner_sid = NULL, *pgroup_sid = NULL;
 		int powner_sid_size = 0, pgroup_sid_size = 0, pntsd_size;
-		int pntsd_alloc_size;
+		size_t pntsd_alloc_size;
 
 		if (parent_pntsd->osidoffset) {
 			powner_sid = (struct smb_sid *)((char *)parent_pntsd +
@@ -1224,8 +1251,19 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 			pgroup_sid_size = 1 + 1 + 6 + (pgroup_sid->num_subauth * 4);
 		}
 
-		pntsd_alloc_size = sizeof(struct smb_ntsd) + powner_sid_size +
-			pgroup_sid_size + sizeof(struct smb_acl) + nt_size;
+		if (check_add_overflow(sizeof(struct smb_ntsd),
+				       (size_t)powner_sid_size,
+				       &pntsd_alloc_size) ||
+		    check_add_overflow(pntsd_alloc_size,
+				       (size_t)pgroup_sid_size,
+				       &pntsd_alloc_size) ||
+		    check_add_overflow(pntsd_alloc_size, sizeof(struct smb_acl),
+				       &pntsd_alloc_size) ||
+		    check_add_overflow(pntsd_alloc_size, (size_t)nt_size,
+				       &pntsd_alloc_size)) {
+			rc = -EINVAL;
+			goto free_aces_base;
+		}
 
 		pntsd = kzalloc(pntsd_alloc_size, KSMBD_DEFAULT_GFP);
 		if (!pntsd) {
diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 8e5ac464b328..af3387eebef5 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -250,6 +250,8 @@ static void eventfs_set_attrs(struct eventfs_inode *ei, bool update_uid, kuid_t
 {
 	struct eventfs_inode *ei_child;
 
+	lockdep_assert_held(&eventfs_mutex);
+
 	/* Update events/<system>/<event> */
 	if (WARN_ON_ONCE(level > 3))
 		return;
@@ -912,3 +914,15 @@ void eventfs_remove_events_dir(struct eventfs_inode *ei)
 	d_invalidate(dentry);
 	d_make_discardable(dentry);
 }
+
+int eventfs_remount_lock(void)
+{
+	mutex_lock(&eventfs_mutex);
+	return srcu_read_lock(&eventfs_srcu);
+}
+
+void eventfs_remount_unlock(int srcu_idx)
+{
+	srcu_read_unlock(&eventfs_srcu, srcu_idx);
+	mutex_unlock(&eventfs_mutex);
+}
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 51c00c8fa175..40477513cce1 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -336,6 +336,7 @@ static int tracefs_apply_options(struct super_block *sb, bool remount)
 	struct inode *inode = d_inode(sb->s_root);
 	struct tracefs_inode *ti;
 	bool update_uid, update_gid;
+	int srcu_idx;
 	umode_t tmp_mode;
 
 	/*
@@ -360,6 +361,7 @@ static int tracefs_apply_options(struct super_block *sb, bool remount)
 		update_uid = fsi->opts & BIT(Opt_uid);
 		update_gid = fsi->opts & BIT(Opt_gid);
 
+		srcu_idx = eventfs_remount_lock();
 		rcu_read_lock();
 		list_for_each_entry_rcu(ti, &tracefs_inodes, list) {
 			if (update_uid) {
@@ -381,6 +383,7 @@ static int tracefs_apply_options(struct super_block *sb, bool remount)
 				eventfs_remount(ti, update_uid, update_gid);
 		}
 		rcu_read_unlock();
+		eventfs_remount_unlock(srcu_idx);
 	}
 
 	return 0;
@@ -426,7 +429,7 @@ static int tracefs_drop_inode(struct inode *inode)
 	 * This inode is being freed and cannot be used for
 	 * eventfs. Clear the flag so that it doesn't call into
 	 * eventfs during the remount flag updates. The eventfs_inode
-	 * gets freed after an RCU cycle, so the content will still
+	 * gets freed after an SRCU cycle, so the content will still
 	 * be safe if the iteration is going on now.
 	 */
 	ti->flags &= ~TRACEFS_EVENT_INODE;
@@ -491,6 +494,7 @@ static int tracefs_fill_super(struct super_block *sb, struct fs_context *fc)
 		return err;
 
 	sb->s_op = &tracefs_super_operations;
+	tracefs_apply_options(sb, false);
 	set_default_d_op(sb, &tracefs_dentry_operations);
 
 	return 0;
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index d83c2a25f288..a4a7f8431aff 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -76,4 +76,7 @@ struct inode *tracefs_get_inode(struct super_block *sb);
 void eventfs_remount(struct tracefs_inode *ti, bool update_uid, bool update_gid);
 void eventfs_d_release(struct dentry *dentry);
 
+int eventfs_remount_lock(void);
+void eventfs_remount_unlock(int srcu_idx);
+
 #endif /* _TRACEFS_INTERNAL_H */
diff --git a/fs/udf/misc.c b/fs/udf/misc.c
index 0788593b6a1d..6928e378fbbd 100644
--- a/fs/udf/misc.c
+++ b/fs/udf/misc.c
@@ -230,8 +230,12 @@ struct buffer_head *udf_read_tagged(struct super_block *sb, uint32_t block,
 	}
 
 	/* Verify the descriptor CRC */
-	if (le16_to_cpu(tag_p->descCRCLength) + sizeof(struct tag) > sb->s_blocksize ||
-	    le16_to_cpu(tag_p->descCRC) == crc_itu_t(0,
+	if (le16_to_cpu(tag_p->descCRCLength) + sizeof(struct tag) > sb->s_blocksize) {
+		udf_err(sb, "block %u: CRC length %u exceeds block size\n",
+			block, le16_to_cpu(tag_p->descCRCLength));
+		goto error_out;
+	}
+	if (le16_to_cpu(tag_p->descCRC) == crc_itu_t(0,
 					bh->b_data + sizeof(struct tag),
 					le16_to_cpu(tag_p->descCRCLength)))
 		return bh;
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 95985400d3d8..e5cde39d6e85 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -915,6 +915,7 @@ extern void fsnotify_clear_marks_by_group(struct fsnotify_group *group,
 					  unsigned int obj_type);
 extern void fsnotify_get_mark(struct fsnotify_mark *mark);
 extern void fsnotify_put_mark(struct fsnotify_mark *mark);
+struct fsnotify_mark *fsnotify_next_mark(struct fsnotify_mark *mark);
 extern void fsnotify_finish_user_wait(struct fsnotify_iter_info *iter_info);
 extern bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info);
 
diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index e6272f9c5e42..20cc16ea4e5a 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -147,11 +147,13 @@ extern __be16 vlan_dev_vlan_proto(const struct net_device *dev);
  *	@priority: skb priority
  *	@vlan_qos: vlan priority: (skb->priority << 13) & 0xE000
  *	@next: pointer to next struct
+ *	@rcu: used for deferred freeing of mapping nodes
  */
 struct vlan_priority_tci_mapping {
 	u32					priority;
 	u16					vlan_qos;
-	struct vlan_priority_tci_mapping	*next;
+	struct vlan_priority_tci_mapping __rcu	*next;
+	struct rcu_head			rcu;
 };
 
 struct proc_dir_entry;
@@ -177,7 +179,7 @@ struct vlan_dev_priv {
 	unsigned int				nr_ingress_mappings;
 	u32					ingress_priority_map[8];
 	unsigned int				nr_egress_mappings;
-	struct vlan_priority_tci_mapping	*egress_priority_map[16];
+	struct vlan_priority_tci_mapping __rcu	*egress_priority_map[16];
 
 	__be16					vlan_proto;
 	u16					vlan_id;
@@ -209,19 +211,24 @@ static inline u16
 vlan_dev_get_egress_qos_mask(struct net_device *dev, u32 skprio)
 {
 	struct vlan_priority_tci_mapping *mp;
+	u16 vlan_qos = 0;
 
-	smp_rmb(); /* coupled with smp_wmb() in vlan_dev_set_egress_priority() */
+	rcu_read_lock();
 
-	mp = vlan_dev_priv(dev)->egress_priority_map[(skprio & 0xF)];
+	mp = rcu_dereference(vlan_dev_priv(dev)->egress_priority_map[skprio & 0xF]);
 	while (mp) {
 		if (mp->priority == skprio) {
-			return mp->vlan_qos; /* This should already be shifted
-					      * to mask correctly with the
-					      * VLAN's TCI */
+			vlan_qos = READ_ONCE(mp->vlan_qos);
+			break;
 		}
-		mp = mp->next;
+		mp = rcu_dereference(mp->next);
 	}
-	return 0;
+	rcu_read_unlock();
+
+	/* This should already be shifted to mask correctly with
+	 * the VLAN's TCI.
+	 */
+	return vlan_qos;
 }
 
 extern bool vlan_do_receive(struct sk_buff **skb);
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index e9e964c20e53..9dc4750296af 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -329,6 +329,8 @@ struct mmc_card {
 #define MMC_QUIRK_BROKEN_CACHE_FLUSH	(1<<16)	/* Don't flush cache until the write has occurred */
 #define MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY	(1<<17) /* Disable broken SD poweroff notify support */
 #define MMC_QUIRK_NO_UHS_DDR50_TUNING	(1<<18) /* Disable DDR50 tuning */
+#define MMC_QUIRK_BROKEN_MDT    (1<<19) /* Wrong manufacturing year */
+#define MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME	(1<<20) /* Secure erase/trim time is fixed regardless of size */
 
 	bool			written_flag;	/* Indicates eMMC has been written since power on */
 	bool			reenable_cmdq;	/* Re-enable Command Queue */
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 63d516c873b4..54e3c621fec3 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -801,6 +801,19 @@ static inline void print_hex_dump_debug(const char *prefix_str, int prefix_type,
 }
 #endif
 
+#if defined(DEBUG)
+#define print_hex_dump_devel(prefix_str, prefix_type, rowsize,		\
+			     groupsize, buf, len, ascii)		\
+	print_hex_dump(KERN_DEBUG, prefix_str, prefix_type, rowsize,	\
+		       groupsize, buf, len, ascii)
+#else
+static inline void print_hex_dump_devel(const char *prefix_str, int prefix_type,
+					int rowsize, int groupsize,
+					const void *buf, size_t len, bool ascii)
+{
+}
+#endif
+
 /**
  * print_hex_dump_bytes - shorthand form of print_hex_dump() with default params
  * @prefix_str: string to prefix each line with;
diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index b9d62fc2140d..f446909551df 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -119,6 +119,8 @@ static inline void rseq_virt_userspace_exit(void)
 
 static inline void rseq_reset(struct task_struct *t)
 {
+	/* Protect against preemption and membarrier IPI */
+	guard(irqsave)();
 	memset(&t->rseq, 0, sizeof(t->rseq));
 	t->rseq.ids.cpu_id = RSEQ_CPU_ID_UNINITIALIZED;
 }
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 1ff16141c8a5..05c4344b378a 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -898,7 +898,8 @@ struct io_uring_buf_reg {
 	__u32	ring_entries;
 	__u16	bgid;
 	__u16	flags;
-	__u64	resv[3];
+	__u32	min_left;
+	__u32	resv[5];
 };
 
 /* argument for IORING_REGISTER_PBUF_STATUS */
diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index f69344fe6c08..ca6fe1f9d05e 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -28,7 +28,7 @@ enum rseq_cs_flags_bit {
 	RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT	= 0,
 	RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT	= 1,
 	RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT	= 2,
-	/* (3) Intentional gap to put new bits into a separate byte */
+	/* (3) Intentional gap to keep new bits separate */
 
 	/* User read only feature flags */
 	RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE_BIT	= 4,
@@ -161,6 +161,9 @@ struct rseq {
 	 *	- RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT
 	 *	- RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL
 	 *	- RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE
+	 *
+	 * It is now used for feature status advertisement by the kernel.
+	 * See: enum rseq_cs_flags_bit for further information.
 	 */
 	__u32 flags;
 
diff --git a/include/video/udlfb.h b/include/video/udlfb.h
index 58fb5732831a..ab34790d57ec 100644
--- a/include/video/udlfb.h
+++ b/include/video/udlfb.h
@@ -56,6 +56,7 @@ struct dlfb_data {
 	spinlock_t damage_lock;
 	struct work_struct damage_work;
 	struct fb_ops ops;
+	atomic_t mmap_count;
 	/* blit-only rendering path metrics, exposed through sysfs */
 	atomic_t bytes_rendered; /* raw pixel-bytes driver asked to render */
 	atomic_t bytes_identical; /* saved effort with backbuffer comparison */
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 5257b3aad395..15be9d6eb412 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -47,7 +47,7 @@ static bool io_kbuf_inc_commit(struct io_buffer_list *bl, int len)
 		this_len = min_t(u32, len, buf_len);
 		buf_len -= this_len;
 		/* Stop looping for invalid buffer length of 0 */
-		if (buf_len || !this_len) {
+		if (buf_len > bl->min_left_sub_one || !this_len) {
 			WRITE_ONCE(buf->addr, READ_ONCE(buf->addr) + this_len);
 			WRITE_ONCE(buf->len, buf_len);
 			return false;
@@ -637,6 +637,10 @@ int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 	if (reg.ring_entries >= 65536)
 		return -EINVAL;
 
+	/* minimum left byte count is a property of incremental buffers */
+	if (!(reg.flags & IOU_PBUF_RING_INC) && reg.min_left)
+		return -EINVAL;
+
 	bl = io_buffer_get_list(ctx, reg.bgid);
 	if (bl) {
 		/* if mapped buffer ring OR classic exists, don't allow */
@@ -684,6 +688,8 @@ int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 	bl->mask = reg.ring_entries - 1;
 	bl->flags |= IOBL_BUF_RING;
 	bl->buf_ring = br;
+	if (reg.min_left)
+		bl->min_left_sub_one = reg.min_left - 1;
 	if (reg.flags & IOU_PBUF_RING_INC)
 		bl->flags |= IOBL_INC;
 	ret = io_buffer_add_list(ctx, bl, reg.bgid);
diff --git a/io_uring/kbuf.h b/io_uring/kbuf.h
index bf15e26520d3..1d9600d08e55 100644
--- a/io_uring/kbuf.h
+++ b/io_uring/kbuf.h
@@ -33,6 +33,13 @@ struct io_buffer_list {
 
 	__u16 flags;
 
+	/*
+	 * minimum required amount to be left to reuse an incrementally
+	 * consumed buffer. If less than this is left at consumption time,
+	 * buffer is done and head is incremented to the next buffer.
+	 */
+	__u32 min_left_sub_one;
+
 	struct io_mapped_region region;
 };
 
diff --git a/io_uring/tw.c b/io_uring/tw.c
index 2f2b4ac4b126..578fc2ae1d0f 100644
--- a/io_uring/tw.c
+++ b/io_uring/tw.c
@@ -273,8 +273,18 @@ void io_req_task_work_add_remote(struct io_kiocb *req, unsigned flags)
 
 void __cold io_move_task_work_from_local(struct io_ring_ctx *ctx)
 {
-	struct llist_node *node = llist_del_all(&ctx->work_llist);
+	struct llist_node *node;
 
+	/*
+	 * Running the work items may utilize ->retry_llist as a means
+	 * for capping the number of task_work entries run at the same
+	 * time. But that list can potentially race with moving the work
+	 * from here, if the task is exiting. As any normal task_work
+	 * running holds ->uring_lock already, just guard this slow path
+	 * with ->uring_lock to avoid racing on ->retry_llist.
+	 */
+	guard(mutex)(&ctx->uring_lock);
+	node = llist_del_all(&ctx->work_llist);
 	__io_fallback_tw(node, false);
 	node = llist_del_all(&ctx->retry_llist);
 	__io_fallback_tw(node, false);
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index f355cf1c1a16..9c68c9b0b24a 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -341,6 +341,16 @@ static void arena_vm_open(struct vm_area_struct *vma)
 	refcount_inc(&vml->mmap_count);
 }
 
+static int arena_vm_may_split(struct vm_area_struct *vma, unsigned long addr)
+{
+	return -EINVAL;
+}
+
+static int arena_vm_mremap(struct vm_area_struct *vma)
+{
+	return -EINVAL;
+}
+
 static void arena_vm_close(struct vm_area_struct *vma)
 {
 	struct bpf_map *map = vma->vm_file->private_data;
@@ -417,6 +427,8 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 
 static const struct vm_operations_struct arena_vm_ops = {
 	.open		= arena_vm_open,
+	.may_split	= arena_vm_may_split,
+	.mremap		= arena_vm_mremap,
 	.close		= arena_vm_close,
 	.fault          = arena_vm_fault,
 };
@@ -486,10 +498,11 @@ static int arena_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
 	arena->user_vm_end = vma->vm_end;
 	/*
 	 * bpf_map_mmap() checks that it's being mmaped as VM_SHARED and
-	 * clears VM_MAYEXEC. Set VM_DONTEXPAND as well to avoid
-	 * potential change of user_vm_start.
+	 * clears VM_MAYEXEC. Set VM_DONTEXPAND to avoid potential change
+	 * of user_vm_start. Set VM_DONTCOPY to prevent arena VMA from
+	 * being copied into the child process on fork.
 	 */
-	vm_flags_set(vma, VM_DONTEXPAND);
+	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTCOPY);
 	vma->vm_ops = &arena_vm_ops;
 	return 0;
 }
diff --git a/kernel/exit.c b/kernel/exit.c
index ede3117fa7d4..9852444627a0 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1074,6 +1074,7 @@ void __noreturn make_task_dead(int signr)
 		futex_exit_recursive(tsk);
 		tsk->exit_state = EXIT_DEAD;
 		refcount_inc(&tsk->rcu_users);
+		preempt_disable();
 		do_task_dead();
 	}
 
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 38d3ef540760..586f58f652c6 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -236,11 +236,6 @@ static int __init rseq_debugfs_init(void)
 }
 __initcall(rseq_debugfs_init);
 
-static bool rseq_set_ids(struct task_struct *t, struct rseq_ids *ids, u32 node_id)
-{
-	return rseq_set_ids_get_csaddr(t, ids, node_id, NULL);
-}
-
 static bool rseq_handle_cs(struct task_struct *t, struct pt_regs *regs)
 {
 	struct rseq __user *urseq = t->rseq.usrptr;
@@ -384,19 +379,22 @@ void rseq_syscall(struct pt_regs *regs)
 
 static bool rseq_reset_ids(void)
 {
-	struct rseq_ids ids = {
-		.cpu_id		= RSEQ_CPU_ID_UNINITIALIZED,
-		.mm_cid		= 0,
-	};
+	struct rseq __user *rseq = current->rseq.usrptr;
 
 	/*
 	 * If this fails, terminate it because this leaves the kernel in
 	 * stupid state as exit to user space will try to fixup the ids
 	 * again.
 	 */
-	if (rseq_set_ids(current, &ids, 0))
-		return true;
+	scoped_user_rw_access(rseq, efault) {
+		unsafe_put_user(0, &rseq->cpu_id_start, efault);
+		unsafe_put_user(RSEQ_CPU_ID_UNINITIALIZED, &rseq->cpu_id, efault);
+		unsafe_put_user(0, &rseq->node_id, efault);
+		unsafe_put_user(0, &rseq->mm_cid, efault);
+	}
+	return true;
 
+efault:
 	force_sig(SIGSEGV);
 	return false;
 }
@@ -464,10 +462,11 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len, int, flags, u32
 		return -EFAULT;
 
 	if (IS_ENABLED(CONFIG_RSEQ_SLICE_EXTENSION)) {
-		rseqfl |= RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE;
-		if (rseq_slice_extension_enabled() &&
-		    (flags & RSEQ_FLAG_SLICE_EXT_DEFAULT_ON))
-			rseqfl |= RSEQ_CS_FLAG_SLICE_EXT_ENABLED;
+		if (rseq_slice_extension_enabled()) {
+			rseqfl |= RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE;
+			if (flags & RSEQ_FLAG_SLICE_EXT_DEFAULT_ON)
+				rseqfl |= RSEQ_CS_FLAG_SLICE_EXT_ENABLED;
+		}
 	}
 
 	scoped_user_write_access(rseq, efault) {
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 064eaa76be4b..c07996aeb2f4 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1093,11 +1093,13 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 			if (!(dsq->id & SCX_DSQ_FLAG_BUILTIN))
 				rcu_assign_pointer(dsq->first_task, p);
 		} else {
-			bool was_empty;
-
-			was_empty = list_empty(&dsq->list);
+			/*
+			 * dsq->list can contain parked BPF iterator cursors, so
+			 * list_empty() here isn't a reliable proxy for "no real
+			 * task in the DSQ". Test dsq->first_task directly.
+			 */
 			list_add_tail(&p->scx.dsq_list.node, &dsq->list);
-			if (was_empty && !(dsq->id & SCX_DSQ_FLAG_BUILTIN))
+			if (!dsq->first_task && !(dsq->id & SCX_DSQ_FLAG_BUILTIN))
 				rcu_assign_pointer(dsq->first_task, p);
 		}
 	}
@@ -3430,9 +3432,10 @@ void scx_cgroup_cancel_attach(struct cgroup_taskset *tset)
 
 void scx_group_set_weight(struct task_group *tg, unsigned long weight)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch;
 
 	percpu_down_read(&scx_cgroup_ops_rwsem);
+	sch = scx_root;
 
 	if (scx_cgroup_enabled && SCX_HAS_OP(sch, cgroup_set_weight) &&
 	    tg->scx.weight != weight)
@@ -3446,9 +3449,10 @@ void scx_group_set_weight(struct task_group *tg, unsigned long weight)
 
 void scx_group_set_idle(struct task_group *tg, bool idle)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch;
 
 	percpu_down_read(&scx_cgroup_ops_rwsem);
+	sch = scx_root;
 
 	if (scx_cgroup_enabled && SCX_HAS_OP(sch, cgroup_set_idle))
 		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, cgroup_set_idle, NULL,
@@ -3463,9 +3467,10 @@ void scx_group_set_idle(struct task_group *tg, bool idle)
 void scx_group_set_bandwidth(struct task_group *tg,
 			     u64 period_us, u64 quota_us, u64 burst_us)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch;
 
 	percpu_down_read(&scx_cgroup_ops_rwsem);
+	sch = scx_root;
 
 	if (scx_cgroup_enabled && SCX_HAS_OP(sch, cgroup_set_bandwidth) &&
 	    (tg->scx.bw_period_us != period_us ||
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 44c3a50c542c..ba8fcb1ab8b5 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -459,12 +459,6 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 
 	preempt_disable();
 
-	/*
-	 * Check whether @prev_cpu is still within the allowed set. If not,
-	 * we can still try selecting a nearby CPU.
-	 */
-	is_prev_allowed = cpumask_test_cpu(prev_cpu, allowed);
-
 	/*
 	 * Determine the subset of CPUs usable by @p within @cpus_allowed.
 	 */
@@ -481,6 +475,12 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 		}
 	}
 
+	/*
+	 * Check whether @prev_cpu is still within the allowed set. If not,
+	 * we can still try selecting a nearby CPU.
+	 */
+	is_prev_allowed = cpumask_test_cpu(prev_cpu, allowed);
+
 	/*
 	 * This is necessary to protect llc_cpus.
 	 */
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index fc7018b28fdd..0afaae4e1a59 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -79,32 +79,29 @@ static const struct rhashtable_params fprobe_rht_params = {
 };
 
 /* Node insertion and deletion requires the fprobe_mutex */
-static int insert_fprobe_node(struct fprobe_hlist_node *node)
+static int insert_fprobe_node(struct fprobe_hlist_node *node, struct fprobe *fp)
 {
+	int ret;
+
 	lockdep_assert_held(&fprobe_mutex);
 
-	return rhltable_insert(&fprobe_ip_table, &node->hlist, fprobe_rht_params);
+	ret = rhltable_insert(&fprobe_ip_table, &node->hlist, fprobe_rht_params);
+	/* Set the fprobe pointer if insertion was successful. */
+	if (!ret)
+		WRITE_ONCE(node->fp, fp);
+	return ret;
 }
 
-/* Return true if there are synonims */
-static bool delete_fprobe_node(struct fprobe_hlist_node *node)
+static void delete_fprobe_node(struct fprobe_hlist_node *node)
 {
 	lockdep_assert_held(&fprobe_mutex);
-	bool ret;
 
-	/* Avoid double deleting */
+	/* Avoid double deleting and non-inserted nodes */
 	if (READ_ONCE(node->fp) != NULL) {
 		WRITE_ONCE(node->fp, NULL);
 		rhltable_remove(&fprobe_ip_table, &node->hlist,
 				fprobe_rht_params);
 	}
-
-	rcu_read_lock();
-	ret = !!rhltable_lookup(&fprobe_ip_table, &node->addr,
-				fprobe_rht_params);
-	rcu_read_unlock();
-
-	return ret;
 }
 
 /* Check existence of the fprobe */
@@ -324,9 +321,10 @@ static void fprobe_ftrace_remove_ips(unsigned long *addrs, int num)
 	lockdep_assert_held(&fprobe_mutex);
 
 	fprobe_ftrace_active--;
-	if (!fprobe_ftrace_active)
+	if (!fprobe_ftrace_active) {
 		unregister_ftrace_function(&fprobe_ftrace_ops);
-	if (num)
+		ftrace_free_filter(&fprobe_ftrace_ops);
+	} else if (num)
 		ftrace_set_filter_ips(&fprobe_ftrace_ops, addrs, num, 1, 0);
 }
 
@@ -335,12 +333,37 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
 	return !fp->exit_handler;
 }
 
+static bool fprobe_exists_on_hash(unsigned long ip, bool ftrace)
+{
+	struct rhlist_head *head, *pos;
+	struct fprobe_hlist_node *node;
+	struct fprobe *fp;
+
+	guard(rcu)();
+	head = rhltable_lookup(&fprobe_ip_table, &ip,
+				fprobe_rht_params);
+	if (!head)
+		return false;
+	/* We have to check the same type on the list. */
+	rhl_for_each_entry_rcu(node, pos, head, hlist) {
+		if (node->addr != ip)
+			break;
+		fp = READ_ONCE(node->fp);
+		if (likely(fp)) {
+			if ((!ftrace && fp->exit_handler) ||
+			    (ftrace && !fp->exit_handler))
+				return true;
+		}
+	}
+
+	return false;
+}
+
 #ifdef CONFIG_MODULES
-static void fprobe_set_ips(unsigned long *ips, unsigned int cnt, int remove,
-			   int reset)
+static void fprobe_remove_ips(unsigned long *ips, unsigned int cnt)
 {
-	ftrace_set_filter_ips(&fprobe_graph_ops.ops, ips, cnt, remove, reset);
-	ftrace_set_filter_ips(&fprobe_ftrace_ops, ips, cnt, remove, reset);
+	ftrace_set_filter_ips(&fprobe_graph_ops.ops, ips, cnt, 1, 0);
+	ftrace_set_filter_ips(&fprobe_ftrace_ops, ips, cnt, 1, 0);
 }
 #endif
 #else
@@ -358,11 +381,33 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
 	return false;
 }
 
+static bool fprobe_exists_on_hash(unsigned long ip, bool ftrace __maybe_unused)
+{
+	struct rhlist_head *head, *pos;
+	struct fprobe_hlist_node *node;
+	struct fprobe *fp;
+
+	guard(rcu)();
+	head = rhltable_lookup(&fprobe_ip_table, &ip,
+				fprobe_rht_params);
+	if (!head)
+		return false;
+	/* We only need to check fp is there. */
+	rhl_for_each_entry_rcu(node, pos, head, hlist) {
+		if (node->addr != ip)
+			break;
+		fp = READ_ONCE(node->fp);
+		if (likely(fp))
+			return true;
+	}
+
+	return false;
+}
+
 #ifdef CONFIG_MODULES
-static void fprobe_set_ips(unsigned long *ips, unsigned int cnt, int remove,
-			   int reset)
+static void fprobe_remove_ips(unsigned long *ips, unsigned int cnt)
 {
-	ftrace_set_filter_ips(&fprobe_graph_ops.ops, ips, cnt, remove, reset);
+	ftrace_set_filter_ips(&fprobe_graph_ops.ops, ips, cnt, 1, 0);
 }
 #endif
 #endif /* !CONFIG_DYNAMIC_FTRACE_WITH_ARGS && !CONFIG_DYNAMIC_FTRACE_WITH_REGS */
@@ -527,16 +572,16 @@ static void fprobe_graph_remove_ips(unsigned long *addrs, int num)
 
 	fprobe_graph_active--;
 	/* Q: should we unregister it ? */
-	if (!fprobe_graph_active)
+	if (!fprobe_graph_active) {
 		unregister_ftrace_graph(&fprobe_graph_ops);
-
-	if (num)
+		ftrace_free_filter(&fprobe_graph_ops.ops);
+	} else if (num)
 		ftrace_set_filter_ips(&fprobe_graph_ops.ops, addrs, num, 1, 0);
 }
 
 #ifdef CONFIG_MODULES
 
-#define FPROBE_IPS_BATCH_INIT 8
+#define FPROBE_IPS_BATCH_INIT 128
 /* instruction pointer address list */
 struct fprobe_addr_list {
 	int index;
@@ -544,43 +589,29 @@ struct fprobe_addr_list {
 	unsigned long *addrs;
 };
 
-static int fprobe_addr_list_add(struct fprobe_addr_list *alist, unsigned long addr)
+static int fprobe_remove_node_in_module(struct module *mod, struct fprobe_hlist_node *node,
+					 struct fprobe_addr_list *alist)
 {
-	unsigned long *addrs;
+	lockdep_assert_in_rcu_read_lock();
 
-	/* Previously we failed to expand the list. */
-	if (alist->index == alist->size)
-		return -ENOSPC;
-
-	alist->addrs[alist->index++] = addr;
-	if (alist->index < alist->size)
+	if (!within_module(node->addr, mod))
 		return 0;
 
-	/* Expand the address list */
-	addrs = kcalloc(alist->size * 2, sizeof(*addrs), GFP_KERNEL);
-	if (!addrs)
-		return -ENOMEM;
-
-	memcpy(addrs, alist->addrs, alist->size * sizeof(*addrs));
-	alist->size *= 2;
-	kfree(alist->addrs);
-	alist->addrs = addrs;
-
-	return 0;
-}
-
-static void fprobe_remove_node_in_module(struct module *mod, struct fprobe_hlist_node *node,
-					 struct fprobe_addr_list *alist)
-{
-	if (!within_module(node->addr, mod))
-		return;
-	if (delete_fprobe_node(node))
-		return;
+	delete_fprobe_node(node);
+	/* If no address list is available, we can't track this address. */
+	if (!alist->addrs)
+		return 0;
 	/*
-	 * If failed to update alist, just continue to update hlist.
-	 * Therefore, at list user handler will not hit anymore.
+	 * Don't care the type here, because all fprobes on the same
+	 * address must be removed eventually.
 	 */
-	fprobe_addr_list_add(alist, node->addr);
+	if (!rhltable_lookup(&fprobe_ip_table, &node->addr, fprobe_rht_params)) {
+		alist->addrs[alist->index++] = node->addr;
+		if (alist->index == alist->size)
+			return -ENOSPC;
+	}
+
+	return 0;
 }
 
 /* Handle module unloading to manage fprobe_ip_table. */
@@ -591,29 +622,50 @@ static int fprobe_module_callback(struct notifier_block *nb,
 	struct fprobe_hlist_node *node;
 	struct rhashtable_iter iter;
 	struct module *mod = data;
+	bool retry;
 
 	if (val != MODULE_STATE_GOING)
 		return NOTIFY_DONE;
 
 	alist.addrs = kcalloc(alist.size, sizeof(*alist.addrs), GFP_KERNEL);
-	/* If failed to alloc memory, we can not remove ips from hash. */
-	if (!alist.addrs)
-		return NOTIFY_DONE;
+	/*
+	 * If failed to alloc memory, ftrace_ops will not be able to remove ips from
+	 * hash, but we can still remove nodes from fprobe_ip_table, so we can avoid
+	 * the potential wrong callback. So just print a warning here and try to
+	 * continue without address list.
+	 */
+	WARN_ONCE(!alist.addrs,
+		"Failed to allocate memory for fprobe_addr_list, ftrace_ops will not be updated");
 
 	mutex_lock(&fprobe_mutex);
+again:
+	retry = false;
+	alist.index = 0;
 	rhltable_walk_enter(&fprobe_ip_table, &iter);
 	do {
 		rhashtable_walk_start(&iter);
 
 		while ((node = rhashtable_walk_next(&iter)) && !IS_ERR(node))
-			fprobe_remove_node_in_module(mod, node, &alist);
+			if (fprobe_remove_node_in_module(mod, node, &alist) < 0) {
+				retry = true;
+				break;
+			}
 
 		rhashtable_walk_stop(&iter);
-	} while (node == ERR_PTR(-EAGAIN));
+	} while (node == ERR_PTR(-EAGAIN) && !retry);
 	rhashtable_walk_exit(&iter);
+	/* Remove any ips from hash table(s) */
+	if (alist.index > 0) {
+		fprobe_remove_ips(alist.addrs, alist.index);
+		/*
+		 * If we break rhashtable walk loop except for -EAGAIN, we need
+		 * to restart looping from start for safety. Anyway, this is
+		 * not a hotpath.
+		 */
+		if (retry)
+			goto again;
+	}
 
-	if (alist.index > 0)
-		fprobe_set_ips(alist.addrs, alist.index, 1, 0);
 	mutex_unlock(&fprobe_mutex);
 
 	kfree(alist.addrs);
@@ -757,7 +809,6 @@ static int fprobe_init(struct fprobe *fp, unsigned long *addrs, int num)
 	fp->hlist_array = hlist_array;
 	hlist_array->fp = fp;
 	for (i = 0; i < num; i++) {
-		hlist_array->array[i].fp = fp;
 		addr = ftrace_location(addrs[i]);
 		if (!addr) {
 			fprobe_fail_cleanup(fp);
@@ -821,6 +872,8 @@ int register_fprobe(struct fprobe *fp, const char *filter, const char *notfilter
 }
 EXPORT_SYMBOL_GPL(register_fprobe);
 
+static int unregister_fprobe_nolock(struct fprobe *fp);
+
 /**
  * register_fprobe_ips() - Register fprobe to ftrace by address.
  * @fp: A fprobe data structure to be registered.
@@ -847,28 +900,25 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
 	if (ret)
 		return ret;
 
-	hlist_array = fp->hlist_array;
 	if (fprobe_is_ftrace(fp))
 		ret = fprobe_ftrace_add_ips(addrs, num);
 	else
 		ret = fprobe_graph_add_ips(addrs, num);
-
-	if (!ret) {
-		add_fprobe_hash(fp);
-		for (i = 0; i < hlist_array->size; i++) {
-			ret = insert_fprobe_node(&hlist_array->array[i]);
-			if (ret)
-				break;
-		}
-		/* fallback on insert error */
-		if (ret) {
-			for (i--; i >= 0; i--)
-				delete_fprobe_node(&hlist_array->array[i]);
-		}
+	if (ret) {
+		fprobe_fail_cleanup(fp);
+		return ret;
 	}
 
-	if (ret)
-		fprobe_fail_cleanup(fp);
+	hlist_array = fp->hlist_array;
+	ret = add_fprobe_hash(fp);
+	for (i = 0; i < hlist_array->size && !ret; i++)
+		ret = insert_fprobe_node(&hlist_array->array[i], fp);
+
+	if (ret) {
+		unregister_fprobe_nolock(fp);
+		/* In error case, wait for clean up safely. */
+		synchronize_rcu();
+	}
 
 	return ret;
 }
@@ -912,37 +962,28 @@ bool fprobe_is_registered(struct fprobe *fp)
 	return true;
 }
 
-/**
- * unregister_fprobe() - Unregister fprobe.
- * @fp: A fprobe data structure to be unregistered.
- *
- * Unregister fprobe (and remove ftrace hooks from the function entries).
- *
- * Return 0 if @fp is unregistered successfully, -errno if not.
- */
-int unregister_fprobe(struct fprobe *fp)
+static int unregister_fprobe_nolock(struct fprobe *fp)
 {
-	struct fprobe_hlist *hlist_array;
+	struct fprobe_hlist *hlist_array = fp->hlist_array;
 	unsigned long *addrs = NULL;
-	int ret = 0, i, count;
+	int i, count;
 
-	mutex_lock(&fprobe_mutex);
-	if (!fp || !fprobe_registered(fp)) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	hlist_array = fp->hlist_array;
 	addrs = kcalloc(hlist_array->size, sizeof(unsigned long), GFP_KERNEL);
-	if (!addrs) {
-		ret = -ENOMEM;	/* TODO: Fallback to one-by-one loop */
-		goto out;
-	}
+	/*
+	 * This will remove fprobe_hash_node from the hash table even if
+	 * memory allocation fails. However, ftrace_ops will not be updated.
+	 * Anyway, when the last fprobe is unregistered, ftrace_ops is also
+	 * unregistered.
+	 */
+	if (!addrs)
+		pr_warn("Failed to allocate working array. ftrace_ops may not sync.\n");
 
 	/* Remove non-synonim ips from table and hash */
 	count = 0;
 	for (i = 0; i < hlist_array->size; i++) {
-		if (!delete_fprobe_node(&hlist_array->array[i]))
+		delete_fprobe_node(&hlist_array->array[i]);
+		if (addrs && !fprobe_exists_on_hash(hlist_array->array[i].addr,
+						    fprobe_is_ftrace(fp)))
 			addrs[count++] = hlist_array->array[i].addr;
 	}
 	del_fprobe_hash(fp);
@@ -954,12 +995,26 @@ int unregister_fprobe(struct fprobe *fp)
 
 	kfree_rcu(hlist_array, rcu);
 	fp->hlist_array = NULL;
+	kfree(addrs);
 
-out:
-	mutex_unlock(&fprobe_mutex);
+	return 0;
+}
 
-	kfree(addrs);
-	return ret;
+/**
+ * unregister_fprobe() - Unregister fprobe.
+ * @fp: A fprobe data structure to be unregistered.
+ *
+ * Unregister fprobe (and remove ftrace hooks from the function entries).
+ *
+ * Return 0 if @fp is unregistered successfully, -errno if not.
+ */
+int unregister_fprobe(struct fprobe *fp)
+{
+	guard(mutex)(&fprobe_mutex);
+	if (!fp || !fprobe_registered(fp))
+		return -EINVAL;
+
+	return unregister_fprobe_nolock(fp);
 }
 EXPORT_SYMBOL_GPL(unregister_fprobe);
 
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index e1c73065dae5..e0d3a0da26af 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1523,6 +1523,12 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 	parg->offset = *size;
 	*size += parg->type->size * (parg->count ?: 1);
 
+	if (*size > MAX_PROBE_EVENT_SIZE) {
+		ret = -E2BIG;
+		trace_probe_log_err(ctx->offset, EVENT_TOO_BIG);
+		goto fail;
+	}
+
 	if (parg->count) {
 		len = strlen(parg->type->fmttype) + 6;
 		parg->fmt = kmalloc(len, GFP_KERNEL);
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 9fc56c937130..262d8707a3df 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -38,6 +38,7 @@
 #define MAX_BTF_ARGS_LEN	128
 #define MAX_DENTRY_ARGS_LEN	256
 #define MAX_STRING_SIZE		PATH_MAX
+#define MAX_PROBE_EVENT_SIZE	3072
 
 /* Reserved field names */
 #define FIELD_STRING_IP		"__probe_ip"
@@ -561,7 +562,8 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(BAD_TYPE4STR,		"This type does not fit for string."),\
 	C(NEED_STRING_TYPE,	"$comm and immediate-string only accepts string type"),\
 	C(TOO_MANY_ARGS,	"Too many arguments are specified"),	\
-	C(TOO_MANY_EARGS,	"Too many entry arguments specified"),
+	C(TOO_MANY_EARGS,	"Too many entry arguments specified"),	\
+	C(EVENT_TOO_BIG,	"Event too big (too many fields?)"),
 
 #undef C
 #define C(a, b)		TP_ERR_##a
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 91905aa19294..dffef52a807b 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -300,6 +300,8 @@ static int tracepoint_add_func(struct tracepoint *tp,
 			lockdep_is_held(&tracepoints_mutex));
 	old = func_add(&tp_funcs, func, prio);
 	if (IS_ERR(old)) {
+		if (tp->ext && tp->ext->unregfunc && !static_key_enabled(&tp->key))
+			tp->ext->unregfunc();
 		WARN_ON_ONCE(warn && PTR_ERR(old) != -ENOMEM);
 		return PTR_ERR(old);
 	}
diff --git a/lib/crc/Kconfig b/lib/crc/Kconfig
index 70e7a6016de3..9ddfd1a29757 100644
--- a/lib/crc/Kconfig
+++ b/lib/crc/Kconfig
@@ -99,13 +99,8 @@ config CRC_OPTIMIZATIONS
 
 config CRC_KUNIT_TEST
 	tristate "KUnit tests for CRC functions" if !KUNIT_ALL_TESTS
-	depends on KUNIT
+	depends on KUNIT && (CRC7 || CRC16 || CRC_T10DIF || CRC32 || CRC64)
 	default KUNIT_ALL_TESTS
-	select CRC7
-	select CRC16
-	select CRC_T10DIF
-	select CRC32
-	select CRC64
 	help
 	  Unit tests for the CRC library functions.
 
diff --git a/lib/crc/tests/crc_kunit.c b/lib/crc/tests/crc_kunit.c
index 9a450e25ac81..9428cd913625 100644
--- a/lib/crc/tests/crc_kunit.c
+++ b/lib/crc/tests/crc_kunit.c
@@ -268,8 +268,7 @@ crc_benchmark(struct kunit *test,
 	}
 }
 
-/* crc7_be */
-
+#if IS_REACHABLE(CONFIG_CRC7)
 static u64 crc7_be_wrapper(u64 crc, const u8 *p, size_t len)
 {
 	/*
@@ -294,9 +293,9 @@ static void crc7_be_benchmark(struct kunit *test)
 {
 	crc_benchmark(test, crc7_be_wrapper);
 }
+#endif /* CONFIG_CRC7 */
 
-/* crc16 */
-
+#if IS_REACHABLE(CONFIG_CRC16)
 static u64 crc16_wrapper(u64 crc, const u8 *p, size_t len)
 {
 	return crc16(crc, p, len);
@@ -318,9 +317,9 @@ static void crc16_benchmark(struct kunit *test)
 {
 	crc_benchmark(test, crc16_wrapper);
 }
+#endif /* CONFIG_CRC16 */
 
-/* crc_t10dif */
-
+#if IS_REACHABLE(CONFIG_CRC_T10DIF)
 static u64 crc_t10dif_wrapper(u64 crc, const u8 *p, size_t len)
 {
 	return crc_t10dif_update(crc, p, len);
@@ -342,6 +341,9 @@ static void crc_t10dif_benchmark(struct kunit *test)
 {
 	crc_benchmark(test, crc_t10dif_wrapper);
 }
+#endif /* CONFIG_CRC_T10DIF */
+
+#if IS_REACHABLE(CONFIG_CRC32)
 
 /* crc32_le */
 
@@ -414,6 +416,9 @@ static void crc32c_benchmark(struct kunit *test)
 {
 	crc_benchmark(test, crc32c_wrapper);
 }
+#endif /* CONFIG_CRC32 */
+
+#if IS_REACHABLE(CONFIG_CRC64)
 
 /* crc64_be */
 
@@ -463,24 +468,35 @@ static void crc64_nvme_benchmark(struct kunit *test)
 {
 	crc_benchmark(test, crc64_nvme_wrapper);
 }
+#endif /* CONFIG_CRC64 */
 
 static struct kunit_case crc_test_cases[] = {
+#if IS_REACHABLE(CONFIG_CRC7)
 	KUNIT_CASE(crc7_be_test),
 	KUNIT_CASE(crc7_be_benchmark),
+#endif
+#if IS_REACHABLE(CONFIG_CRC16)
 	KUNIT_CASE(crc16_test),
 	KUNIT_CASE(crc16_benchmark),
+#endif
+#if IS_REACHABLE(CONFIG_CRC_T10DIF)
 	KUNIT_CASE(crc_t10dif_test),
 	KUNIT_CASE(crc_t10dif_benchmark),
+#endif
+#if IS_REACHABLE(CONFIG_CRC32)
 	KUNIT_CASE(crc32_le_test),
 	KUNIT_CASE(crc32_le_benchmark),
 	KUNIT_CASE(crc32_be_test),
 	KUNIT_CASE(crc32_be_benchmark),
 	KUNIT_CASE(crc32c_test),
 	KUNIT_CASE(crc32c_benchmark),
+#endif
+#if IS_REACHABLE(CONFIG_CRC64)
 	KUNIT_CASE(crc64_be_test),
 	KUNIT_CASE(crc64_be_benchmark),
 	KUNIT_CASE(crc64_nvme_test),
 	KUNIT_CASE(crc64_nvme_benchmark),
+#endif
 	{},
 };
 
diff --git a/lib/crypto/mpi/mpicoder.c b/lib/crypto/mpi/mpicoder.c
index bf716a03c704..9359a58c29ec 100644
--- a/lib/crypto/mpi/mpicoder.c
+++ b/lib/crypto/mpi/mpicoder.c
@@ -347,7 +347,7 @@ MPI mpi_read_raw_from_sgl(struct scatterlist *sgl, unsigned int nbytes)
 	lzeros = 0;
 	len = 0;
 	while (nbytes > 0) {
-		while (len && !*buff) {
+		while (len && !*buff && lzeros < nbytes) {
 			lzeros++;
 			len--;
 			buff++;
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index d773720d11bf..b7fe91ef35b8 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -1123,8 +1123,7 @@ static ssize_t extract_user_to_sg(struct iov_iter *iter,
 	size_t len, off;
 
 	/* We decant the page list into the tail of the scatterlist */
-	pages = (void *)sgtable->sgl +
-		array_size(sg_max, sizeof(struct scatterlist));
+	pages = (void *)sg + array_size(sg_max, sizeof(struct scatterlist));
 	pages -= sg_max;
 
 	do {
@@ -1247,7 +1246,7 @@ static ssize_t extract_kvec_to_sg(struct iov_iter *iter,
 			else
 				page = virt_to_page((void *)kaddr);
 
-			sg_set_page(sg, page, len, off);
+			sg_set_page(sg, page, seg, off);
 			sgtable->nents++;
 			sg++;
 			sg_max--;
@@ -1256,6 +1255,7 @@ static ssize_t extract_kvec_to_sg(struct iov_iter *iter,
 			kaddr += PAGE_SIZE;
 			off = 0;
 		} while (len > 0 && sg_max > 0);
+		ret -= len;
 
 		if (maxsize <= 0 || sg_max == 0)
 			break;
@@ -1409,7 +1409,7 @@ ssize_t extract_iter_to_sg(struct iov_iter *iter, size_t maxsize,
 			   struct sg_table *sgtable, unsigned int sg_max,
 			   iov_iter_extraction_t extraction_flags)
 {
-	if (maxsize == 0)
+	if (maxsize == 0 || sg_max == 0)
 		return 0;
 
 	switch (iov_iter_type(iter)) {
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 7bc5c0b2aea3..2e29dbbcaf94 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -161,15 +161,6 @@ module_param(monitor_region_end, ulong, 0600);
  */
 static unsigned long addr_unit __read_mostly = 1;
 
-/*
- * PID of the DAMON thread
- *
- * If DAMON_LRU_SORT is enabled, this becomes the PID of the worker thread.
- * Else, -1.
- */
-static int kdamond_pid __read_mostly = -1;
-module_param(kdamond_pid, int, 0400);
-
 static struct damos_stat damon_lru_sort_hot_stat;
 DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_lru_sort_hot_stat,
 		lru_sort_tried_hot_regions, lru_sorted_hot_regions,
@@ -391,12 +382,8 @@ static int damon_lru_sort_turn(bool on)
 {
 	int err;
 
-	if (!on) {
-		err = damon_stop(&ctx, 1);
-		if (!err)
-			kdamond_pid = -1;
-		return err;
-	}
+	if (!on)
+		return damon_stop(&ctx, 1);
 
 	err = damon_lru_sort_apply_parameters();
 	if (err)
@@ -405,9 +392,6 @@ static int damon_lru_sort_turn(bool on)
 	err = damon_start(&ctx, 1, true);
 	if (err)
 		return err;
-	kdamond_pid = damon_kdamond_pid(ctx);
-	if (kdamond_pid < 0)
-		return kdamond_pid;
 	return damon_call(ctx, &call_control);
 }
 
@@ -435,42 +419,83 @@ module_param_cb(addr_unit, &addr_unit_param_ops, &addr_unit, 0600);
 MODULE_PARM_DESC(addr_unit,
 	"Scale factor for DAMON_LRU_SORT to ops address conversion (default: 1)");
 
+static bool damon_lru_sort_enabled(void)
+{
+	if (!ctx)
+		return false;
+	return damon_is_running(ctx);
+}
+
 static int damon_lru_sort_enabled_store(const char *val,
 		const struct kernel_param *kp)
 {
-	bool is_enabled = enabled;
-	bool enable;
 	int err;
 
-	err = kstrtobool(val, &enable);
+	err = kstrtobool(val, &enabled);
 	if (err)
 		return err;
 
-	if (is_enabled == enable)
+	if (damon_lru_sort_enabled() == enabled)
 		return 0;
 
 	/* Called before init function.  The function will handle this. */
 	if (!damon_initialized())
-		goto set_param_out;
+		return 0;
 
-	err = damon_lru_sort_turn(enable);
-	if (err)
-		return err;
+	return damon_lru_sort_turn(enabled);
+}
 
-set_param_out:
-	enabled = enable;
-	return err;
+static int damon_lru_sort_enabled_load(char *buffer,
+		const struct kernel_param *kp)
+{
+	return sprintf(buffer, "%c\n", damon_lru_sort_enabled() ? 'Y' : 'N');
 }
 
 static const struct kernel_param_ops enabled_param_ops = {
 	.set = damon_lru_sort_enabled_store,
-	.get = param_get_bool,
+	.get = damon_lru_sort_enabled_load,
 };
 
 module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
 MODULE_PARM_DESC(enabled,
 	"Enable or disable DAMON_LRU_SORT (default: disabled)");
 
+static int damon_lru_sort_kdamond_pid_store(const char *val,
+		const struct kernel_param *kp)
+{
+	/*
+	 * kdamond_pid is read-only, but kernel command line could write it.
+	 * Do nothing here.
+	 */
+	return 0;
+}
+
+static int damon_lru_sort_kdamond_pid_load(char *buffer,
+		const struct kernel_param *kp)
+{
+	int kdamond_pid = -1;
+
+	if (ctx) {
+		kdamond_pid = damon_kdamond_pid(ctx);
+		if (kdamond_pid < 0)
+			kdamond_pid = -1;
+	}
+	return sprintf(buffer, "%d\n", kdamond_pid);
+}
+
+static const struct kernel_param_ops kdamond_pid_param_ops = {
+	.set = damon_lru_sort_kdamond_pid_store,
+	.get = damon_lru_sort_kdamond_pid_load,
+};
+
+/*
+ * PID of the DAMON thread
+ *
+ * If DAMON_LRU_SORT is enabled, this becomes the PID of the worker thread.
+ * Else, -1.
+ */
+module_param_cb(kdamond_pid, &kdamond_pid_param_ops, NULL, 0400);
+
 static int __init damon_lru_sort_init(void)
 {
 	int err;
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 43d76f5bed44..a15cf1e603d2 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -144,15 +144,6 @@ static unsigned long addr_unit __read_mostly = 1;
 static bool skip_anon __read_mostly;
 module_param(skip_anon, bool, 0600);
 
-/*
- * PID of the DAMON thread
- *
- * If DAMON_RECLAIM is enabled, this becomes the PID of the worker thread.
- * Else, -1.
- */
-static int kdamond_pid __read_mostly = -1;
-module_param(kdamond_pid, int, 0400);
-
 static struct damos_stat damon_reclaim_stat;
 DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_reclaim_stat,
 		reclaim_tried_regions, reclaimed_regions, quota_exceeds);
@@ -293,12 +284,8 @@ static int damon_reclaim_turn(bool on)
 {
 	int err;
 
-	if (!on) {
-		err = damon_stop(&ctx, 1);
-		if (!err)
-			kdamond_pid = -1;
-		return err;
-	}
+	if (!on)
+		return damon_stop(&ctx, 1);
 
 	err = damon_reclaim_apply_parameters();
 	if (err)
@@ -307,9 +294,6 @@ static int damon_reclaim_turn(bool on)
 	err = damon_start(&ctx, 1, true);
 	if (err)
 		return err;
-	kdamond_pid = damon_kdamond_pid(ctx);
-	if (kdamond_pid < 0)
-		return kdamond_pid;
 	return damon_call(ctx, &call_control);
 }
 
@@ -337,42 +321,83 @@ module_param_cb(addr_unit, &addr_unit_param_ops, &addr_unit, 0600);
 MODULE_PARM_DESC(addr_unit,
 	"Scale factor for DAMON_RECLAIM to ops address conversion (default: 1)");
 
+static bool damon_reclaim_enabled(void)
+{
+	if (!ctx)
+		return false;
+	return damon_is_running(ctx);
+}
+
 static int damon_reclaim_enabled_store(const char *val,
 		const struct kernel_param *kp)
 {
-	bool is_enabled = enabled;
-	bool enable;
 	int err;
 
-	err = kstrtobool(val, &enable);
+	err = kstrtobool(val, &enabled);
 	if (err)
 		return err;
 
-	if (is_enabled == enable)
+	if (damon_reclaim_enabled() == enabled)
 		return 0;
 
 	/* Called before init function.  The function will handle this. */
 	if (!damon_initialized())
-		goto set_param_out;
+		return 0;
 
-	err = damon_reclaim_turn(enable);
-	if (err)
-		return err;
+	return damon_reclaim_turn(enabled);
+}
 
-set_param_out:
-	enabled = enable;
-	return err;
+static int damon_reclaim_enabled_load(char *buffer,
+		const struct kernel_param *kp)
+{
+	return sprintf(buffer, "%c\n", damon_reclaim_enabled() ? 'Y' : 'N');
 }
 
 static const struct kernel_param_ops enabled_param_ops = {
 	.set = damon_reclaim_enabled_store,
-	.get = param_get_bool,
+	.get = damon_reclaim_enabled_load,
 };
 
 module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
 MODULE_PARM_DESC(enabled,
 	"Enable or disable DAMON_RECLAIM (default: disabled)");
 
+static int damon_reclaim_kdamond_pid_store(const char *val,
+		const struct kernel_param *kp)
+{
+	/*
+	 * kdamond_pid is read-only, but kernel command line could write it.
+	 * Do nothing here.
+	 */
+	return 0;
+}
+
+static int damon_reclaim_kdamond_pid_load(char *buffer,
+		const struct kernel_param *kp)
+{
+	int kdamond_pid = -1;
+
+	if (ctx) {
+		kdamond_pid = damon_kdamond_pid(ctx);
+		if (kdamond_pid < 0)
+			kdamond_pid = -1;
+	}
+	return sprintf(buffer, "%d\n", kdamond_pid);
+}
+
+static const struct kernel_param_ops kdamond_pid_param_ops = {
+	.set = damon_reclaim_kdamond_pid_store,
+	.get = damon_reclaim_kdamond_pid_load,
+};
+
+/*
+ * PID of the DAMON thread
+ *
+ * If DAMON_RECLAIM is enabled, this becomes the PID of the worker thread.
+ * Else, -1.
+ */
+module_param_cb(kdamond_pid, &kdamond_pid_param_ops, NULL, 0400);
+
 static int __init damon_reclaim_init(void)
 {
 	int err;
diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index 99ba346f9e32..3951b762cbdd 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -19,14 +19,17 @@
 static int damon_stat_enabled_store(
 		const char *val, const struct kernel_param *kp);
 
+static int damon_stat_enabled_load(char *buffer,
+		const struct kernel_param *kp);
+
 static const struct kernel_param_ops enabled_param_ops = {
 	.set = damon_stat_enabled_store,
-	.get = param_get_bool,
+	.get = damon_stat_enabled_load,
 };
 
 static bool enabled __read_mostly = IS_ENABLED(
 	CONFIG_DAMON_STAT_ENABLED_DEFAULT);
-module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
+module_param_cb(enabled, &enabled_param_ops, NULL, 0600);
 MODULE_PARM_DESC(enabled, "Enable of disable DAMON_STAT");
 
 static unsigned long estimated_memory_bandwidth __read_mostly;
@@ -273,17 +276,23 @@ static void damon_stat_stop(void)
 	damon_stat_context = NULL;
 }
 
+static bool damon_stat_enabled(void)
+{
+	if (!damon_stat_context)
+		return false;
+	return damon_is_running(damon_stat_context);
+}
+
 static int damon_stat_enabled_store(
 		const char *val, const struct kernel_param *kp)
 {
-	bool is_enabled = enabled;
 	int err;
 
 	err = kstrtobool(val, &enabled);
 	if (err)
 		return err;
 
-	if (is_enabled == enabled)
+	if (damon_stat_enabled() == enabled)
 		return 0;
 
 	if (!damon_initialized())
@@ -293,16 +302,17 @@ static int damon_stat_enabled_store(
 		 */
 		return 0;
 
-	if (enabled) {
-		err = damon_stat_start();
-		if (err)
-			enabled = false;
-		return err;
-	}
+	if (enabled)
+		return damon_stat_start();
 	damon_stat_stop();
 	return 0;
 }
 
+static int damon_stat_enabled_load(char *buffer, const struct kernel_param *kp)
+{
+	return sprintf(buffer, "%c\n", damon_stat_enabled() ? 'Y' : 'N');
+}
+
 static int __init damon_stat_init(void)
 {
 	int err = 0;
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 3a0782e576fa..9302ad0a603b 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -533,9 +533,14 @@ static ssize_t memcg_path_show(struct kobject *kobj,
 {
 	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
 			struct damon_sysfs_scheme_filter, kobj);
+	int len;
 
-	return sysfs_emit(buf, "%s\n",
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	len = sysfs_emit(buf, "%s\n",
 			filter->memcg_path ? filter->memcg_path : "");
+	mutex_unlock(&damon_sysfs_lock);
+	return len;
 }
 
 static ssize_t memcg_path_store(struct kobject *kobj,
@@ -550,8 +555,13 @@ static ssize_t memcg_path_store(struct kobject *kobj,
 		return -ENOMEM;
 
 	strscpy(path, buf, count + 1);
+	if (!mutex_trylock(&damon_sysfs_lock)) {
+		kfree(path);
+		return -EBUSY;
+	}
 	kfree(filter->memcg_path);
 	filter->memcg_path = path;
+	mutex_unlock(&damon_sysfs_lock);
 	return count;
 }
 
@@ -1187,8 +1197,13 @@ static ssize_t path_show(struct kobject *kobj,
 {
 	struct damos_sysfs_quota_goal *goal = container_of(kobj,
 			struct damos_sysfs_quota_goal, kobj);
+	int len;
 
-	return sysfs_emit(buf, "%s\n", goal->path ? goal->path : "");
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	len = sysfs_emit(buf, "%s\n", goal->path ? goal->path : "");
+	mutex_unlock(&damon_sysfs_lock);
+	return len;
 }
 
 static ssize_t path_store(struct kobject *kobj,
@@ -1203,8 +1218,13 @@ static ssize_t path_store(struct kobject *kobj,
 		return -ENOMEM;
 
 	strscpy(path, buf, count + 1);
+	if (!mutex_trylock(&damon_sysfs_lock)) {
+		kfree(path);
+		return -EBUSY;
+	}
 	kfree(goal->path);
 	goal->path = path;
+	mutex_unlock(&damon_sysfs_lock);
 	return count;
 }
 
diff --git a/mm/hugetlb_cma.c b/mm/hugetlb_cma.c
index f83ae4998990..7693ccefd0c6 100644
--- a/mm/hugetlb_cma.c
+++ b/mm/hugetlb_cma.c
@@ -204,6 +204,7 @@ void __init hugetlb_cma_reserve(void)
 		 */
 		per_node = DIV_ROUND_UP(hugetlb_cma_size,
 					nodes_weight(hugetlb_bootmem_nodes));
+		per_node = round_up(per_node, PAGE_SIZE << order);
 		pr_info("hugetlb_cma: reserve %lu MiB, up to %lu MiB per node\n",
 			hugetlb_cma_size / SZ_1M, per_node / SZ_1M);
 	}
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index c40f7d5c4fca..7aa3af8b10ea 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -172,39 +172,42 @@ int vlan_dev_set_egress_priority(const struct net_device *dev,
 				 u32 skb_prio, u16 vlan_prio)
 {
 	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
-	struct vlan_priority_tci_mapping *mp = NULL;
+	struct vlan_priority_tci_mapping __rcu **mpp;
+	struct vlan_priority_tci_mapping *mp;
 	struct vlan_priority_tci_mapping *np;
+	u32 bucket = skb_prio & 0xF;
 	u32 vlan_qos = (vlan_prio << VLAN_PRIO_SHIFT) & VLAN_PRIO_MASK;
 
 	/* See if a priority mapping exists.. */
-	mp = vlan->egress_priority_map[skb_prio & 0xF];
+	mpp = &vlan->egress_priority_map[bucket];
+	mp = rtnl_dereference(*mpp);
 	while (mp) {
 		if (mp->priority == skb_prio) {
-			if (mp->vlan_qos && !vlan_qos)
+			if (!vlan_qos) {
+				rcu_assign_pointer(*mpp, rtnl_dereference(mp->next));
 				vlan->nr_egress_mappings--;
-			else if (!mp->vlan_qos && vlan_qos)
-				vlan->nr_egress_mappings++;
-			mp->vlan_qos = vlan_qos;
+				kfree_rcu(mp, rcu);
+			} else {
+				WRITE_ONCE(mp->vlan_qos, vlan_qos);
+			}
 			return 0;
 		}
-		mp = mp->next;
+		mpp = &mp->next;
+		mp = rtnl_dereference(*mpp);
 	}
 
 	/* Create a new mapping then. */
-	mp = vlan->egress_priority_map[skb_prio & 0xF];
+	if (!vlan_qos)
+		return 0;
+
 	np = kmalloc_obj(struct vlan_priority_tci_mapping);
 	if (!np)
 		return -ENOBUFS;
 
-	np->next = mp;
 	np->priority = skb_prio;
 	np->vlan_qos = vlan_qos;
-	/* Before inserting this element in hash table, make sure all its fields
-	 * are committed to memory.
-	 * coupled with smp_rmb() in vlan_dev_get_egress_qos_mask()
-	 */
-	smp_wmb();
-	vlan->egress_priority_map[skb_prio & 0xF] = np;
+	RCU_INIT_POINTER(np->next, rtnl_dereference(vlan->egress_priority_map[bucket]));
+	rcu_assign_pointer(vlan->egress_priority_map[bucket], np);
 	if (vlan_qos)
 		vlan->nr_egress_mappings++;
 	return 0;
@@ -604,11 +607,17 @@ void vlan_dev_free_egress_priority(const struct net_device *dev)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(vlan->egress_priority_map); i++) {
-		while ((pm = vlan->egress_priority_map[i]) != NULL) {
-			vlan->egress_priority_map[i] = pm->next;
-			kfree(pm);
+		pm = rtnl_dereference(vlan->egress_priority_map[i]);
+		RCU_INIT_POINTER(vlan->egress_priority_map[i], NULL);
+		while (pm) {
+			struct vlan_priority_tci_mapping *next;
+
+			next = rtnl_dereference(pm->next);
+			kfree_rcu(pm, rcu);
+			pm = next;
 		}
 	}
+	vlan->nr_egress_mappings = 0;
 }
 
 static void vlan_dev_uninit(struct net_device *dev)
diff --git a/net/8021q/vlan_netlink.c b/net/8021q/vlan_netlink.c
index a000b1ef0520..368d53ca7d87 100644
--- a/net/8021q/vlan_netlink.c
+++ b/net/8021q/vlan_netlink.c
@@ -260,13 +260,11 @@ static int vlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 			goto nla_put_failure;
 
 		for (i = 0; i < ARRAY_SIZE(vlan->egress_priority_map); i++) {
-			for (pm = vlan->egress_priority_map[i]; pm;
-			     pm = pm->next) {
-				if (!pm->vlan_qos)
-					continue;
-
+			for (pm = rcu_dereference_rtnl(vlan->egress_priority_map[i]); pm;
+			     pm = rcu_dereference_rtnl(pm->next)) {
+				u16 vlan_qos = READ_ONCE(pm->vlan_qos);
 				m.from = pm->priority;
-				m.to   = (pm->vlan_qos >> 13) & 0x7;
+				m.to   = (vlan_qos >> 13) & 0x7;
 				if (nla_put(skb, IFLA_VLAN_QOS_MAPPING,
 					    sizeof(m), &m))
 					goto nla_put_failure;
diff --git a/net/8021q/vlanproc.c b/net/8021q/vlanproc.c
index fa67374bda49..0e424e0895b7 100644
--- a/net/8021q/vlanproc.c
+++ b/net/8021q/vlanproc.c
@@ -262,15 +262,19 @@ static int vlandev_seq_show(struct seq_file *seq, void *offset)
 		   vlan->ingress_priority_map[7]);
 
 	seq_printf(seq, " EGRESS priority mappings: ");
+	rcu_read_lock();
 	for (i = 0; i < 16; i++) {
-		const struct vlan_priority_tci_mapping *mp
-			= vlan->egress_priority_map[i];
+		const struct vlan_priority_tci_mapping *mp =
+			rcu_dereference(vlan->egress_priority_map[i]);
 		while (mp) {
+			u16 vlan_qos = READ_ONCE(mp->vlan_qos);
+
 			seq_printf(seq, "%u:%d ",
-				   mp->priority, ((mp->vlan_qos >> 13) & 0x7));
-			mp = mp->next;
+				   mp->priority, ((vlan_qos >> 13) & 0x7));
+			mp = rcu_dereference(mp->next);
 		}
 	}
+	rcu_read_unlock();
 	seq_puts(seq, "\n");
 
 	return 0;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 11d3ad8d2551..9fa6901aae9f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2130,6 +2130,9 @@ static int create_big_sync(struct hci_dev *hdev, void *data)
 	u32 flags = 0;
 	int err;
 
+	if (!hci_conn_valid(hdev, conn))
+		return -ECANCELED;
+
 	if (qos->bcast.out.phys == BIT(1))
 		flags |= MGMT_ADV_FLAG_SEC_2M;
 
@@ -2204,11 +2207,24 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
 
 	bt_dev_dbg(hdev, "conn %p", conn);
 
+	if (err == -ECANCELED)
+		goto done;
+
+	hci_dev_lock(hdev);
+
+	if (!hci_conn_valid(hdev, conn))
+		goto unlock;
+
 	if (err) {
 		bt_dev_err(hdev, "Unable to create BIG: %d", err);
 		hci_connect_cfm(conn, err);
 		hci_conn_del(conn);
 	}
+
+unlock:
+	hci_dev_unlock(hdev);
+done:
+	hci_conn_put(conn);
 }
 
 struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
@@ -2336,10 +2352,11 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 				 BT_BOUND, &data);
 
 	/* Queue start periodic advertising and create BIG */
-	err = hci_cmd_sync_queue(hdev, create_big_sync, conn,
+	err = hci_cmd_sync_queue(hdev, create_big_sync, hci_conn_get(conn),
 				 create_big_complete);
 	if (err < 0) {
 		hci_conn_drop(conn);
+		hci_conn_put(conn);
 		return ERR_PTR(err);
 	}
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6500f7a327f6..0df1c0cbc8f7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7121,9 +7121,29 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 			continue;
 		}
 
+		if (ev->num_bis <= i) {
+			bt_dev_err(hdev,
+				   "Not enough BIS handles for BIG 0x%2.2x",
+				   ev->handle);
+			ev->status = HCI_ERROR_UNSPECIFIED;
+			hci_connect_cfm(conn, ev->status);
+			hci_conn_del(conn);
+			continue;
+		}
+
 		if (hci_conn_set_handle(conn,
-					__le16_to_cpu(ev->bis_handle[i++])))
+					__le16_to_cpu(ev->bis_handle[i++]))) {
+			bt_dev_err(hdev,
+				   "Failed to set BIS handle for BIG 0x%2.2x",
+				   ev->handle);
+			/* Force error so BIG gets terminated as not all BIS
+			 * could be connected.
+			 */
+			ev->status = HCI_ERROR_UNSPECIFIED;
+			hci_connect_cfm(conn, ev->status);
+			hci_conn_del(conn);
 			continue;
+		}
 
 		conn->state = BT_CONNECTED;
 		set_bit(HCI_CONN_BIG_CREATED, &conn->flags);
@@ -7132,7 +7152,10 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 		hci_iso_setup_path(conn);
 	}
 
-	if (!ev->status && !i)
+	/* If there is an unexpected error or if no BISes have been connected
+	 * for the BIG, terminate it.
+	 */
+	if (ev->status == HCI_ERROR_UNSPECIFIED || (!ev->status && !i))
 		/* If no BISes have been connected for the BIG,
 		 * terminate. This is in case all bound connections
 		 * have been closed before the BIG creation
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 71e8c1b45bce..cf590a67d364 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1498,6 +1498,9 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 {
 	struct sock *sk, *parent = chan->data;
 
+	if (!parent)
+		return NULL;
+
 	lock_sock(parent);
 
 	/* Check for backlog size */
@@ -1657,6 +1660,9 @@ static void l2cap_sock_state_change_cb(struct l2cap_chan *chan, int state,
 {
 	struct sock *sk = chan->data;
 
+	if (!sk)
+		return;
+
 	sk->sk_state = state;
 
 	if (err)
@@ -1758,6 +1764,9 @@ static long l2cap_sock_get_sndtimeo_cb(struct l2cap_chan *chan)
 {
 	struct sock *sk = chan->data;
 
+	if (!sk)
+		return 0;
+
 	return READ_ONCE(sk->sk_sndtimeo);
 }
 
diff --git a/net/ceph/auth.c b/net/ceph/auth.c
index 3314705e5914..17660bde896b 100644
--- a/net/ceph/auth.c
+++ b/net/ceph/auth.c
@@ -257,7 +257,7 @@ int ceph_handle_auth_reply(struct ceph_auth_client *ac,
 		ac->negotiating = false;
 	}
 
-	if (result) {
+	if (result < 0) {
 		pr_err("auth protocol '%s' mauth authentication failed: %d\n",
 		       ceph_auth_proto_name(ac->protocol), result);
 		ret = result;
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index d5080530ce0c..d2cdc8ee3155 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -174,6 +174,8 @@ int ceph_monmap_contains(struct ceph_monmap *m, struct ceph_entity_addr *addr)
  */
 static void __send_prepared_auth_request(struct ceph_mon_client *monc, int len)
 {
+	BUG_ON(len > monc->m_auth->front_alloc_len);
+
 	monc->pending_auth = 1;
 	monc->m_auth->front.iov_len = len;
 	monc->m_auth->hdr.front_len = cpu_to_le32(len);
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 1b61bb25ba0e..2a98f5fa74eb 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1374,16 +1374,13 @@ bool __skb_flow_dissect(const struct net *net,
 			break;
 		}
 
-		/* least significant bit of the most significant octet
-		 * indicates if protocol field was compressed
+		/* PFC (compressed 1-byte protocol) frames are not processed.
+		 * A compressed protocol field has the least significant bit of
+		 * the most significant octet set, which will fail the following
+		 * ppp_proto_is_valid(), returning FLOW_DISSECT_RET_OUT_BAD.
 		 */
 		ppp_proto = ntohs(hdr->proto);
-		if (ppp_proto & 0x0100) {
-			ppp_proto = ppp_proto >> 8;
-			nhoff += PPPOE_SES_HLEN - 1;
-		} else {
-			nhoff += PPPOE_SES_HLEN;
-		}
+		nhoff += PPPOE_SES_HLEN;
 
 		if (ppp_proto == PPP_IP) {
 			proto = htons(ETH_P_IP);
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index cd74beffd209..5ae90c14ba49 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -608,14 +608,16 @@ EXPORT_SYMBOL_GPL(__netpoll_setup);
 /*
  * Returns a pointer to a string representation of the identifier used
  * to select the egress interface for the given netpoll instance. buf
- * must be a buffer of length at least MAC_ADDR_STR_LEN + 1.
+ * is used to format np->dev_mac when np->dev_name is empty; bufsz must
+ * be at least MAC_ADDR_STR_LEN + 1 to fit the formatted MAC address
+ * and its NUL terminator.
  */
-static char *egress_dev(struct netpoll *np, char *buf)
+static char *egress_dev(struct netpoll *np, char *buf, size_t bufsz)
 {
 	if (np->dev_name[0])
 		return np->dev_name;
 
-	snprintf(buf, MAC_ADDR_STR_LEN, "%pM", np->dev_mac);
+	snprintf(buf, bufsz, "%pM", np->dev_mac);
 	return buf;
 }
 
@@ -645,7 +647,7 @@ static int netpoll_take_ipv6(struct netpoll *np, struct net_device *ndev)
 
 	if (!IS_ENABLED(CONFIG_IPV6)) {
 		np_err(np, "IPv6 is not supported %s, aborting\n",
-		       egress_dev(np, buf));
+		       egress_dev(np, buf, sizeof(buf)));
 		return -EINVAL;
 	}
 
@@ -667,7 +669,7 @@ static int netpoll_take_ipv6(struct netpoll *np, struct net_device *ndev)
 	}
 	if (err) {
 		np_err(np, "no IPv6 address for %s, aborting\n",
-		       egress_dev(np, buf));
+		       egress_dev(np, buf, sizeof(buf)));
 		return err;
 	}
 
@@ -687,14 +689,14 @@ static int netpoll_take_ipv4(struct netpoll *np, struct net_device *ndev)
 	in_dev = __in_dev_get_rtnl(ndev);
 	if (!in_dev) {
 		np_err(np, "no IP address for %s, aborting\n",
-		       egress_dev(np, buf));
+		       egress_dev(np, buf, sizeof(buf)));
 		return -EDESTADDRREQ;
 	}
 
 	ifa = rtnl_dereference(in_dev->ifa_list);
 	if (!ifa) {
 		np_err(np, "no IP address for %s, aborting\n",
-		       egress_dev(np, buf));
+		       egress_dev(np, buf, sizeof(buf)));
 		return -EDESTADDRREQ;
 	}
 
@@ -719,7 +721,8 @@ int netpoll_setup(struct netpoll *np)
 		ndev = dev_getbyhwaddr(net, ARPHRD_ETHER, np->dev_mac);
 
 	if (!ndev) {
-		np_err(np, "%s doesn't exist, aborting\n", egress_dev(np, buf));
+		np_err(np, "%s doesn't exist, aborting\n",
+		       egress_dev(np, buf, sizeof(buf)));
 		err = -ENODEV;
 		goto unlock;
 	}
@@ -727,14 +730,14 @@ int netpoll_setup(struct netpoll *np)
 
 	if (netdev_master_upper_dev_get(ndev)) {
 		np_err(np, "%s is a slave device, aborting\n",
-		       egress_dev(np, buf));
+		       egress_dev(np, buf, sizeof(buf)));
 		err = -EBUSY;
 		goto put;
 	}
 
 	if (!netif_running(ndev)) {
 		np_info(np, "device %s not up yet, forcing it\n",
-			egress_dev(np, buf));
+			egress_dev(np, buf, sizeof(buf)));
 
 		err = dev_open(ndev, NULL);
 		if (err) {
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 69daba3ddaf0..ad0c7b0b4a50 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1572,6 +1572,7 @@ static noinline_for_stack int rtnl_fill_vfinfo(struct sk_buff *skb,
 		port_guid.vf = ivi.vf;
 
 	memcpy(vf_mac.mac, ivi.mac, sizeof(ivi.mac));
+	memset(&vf_broadcast, 0, sizeof(vf_broadcast));
 	memcpy(vf_broadcast.broadcast, dev->broadcast, dev->addr_len);
 	vf_vlan.vlan = ivi.vlan;
 	vf_vlan.qos = ivi.qos;
diff --git a/net/ipv4/ah4.c b/net/ipv4/ah4.c
index 5fb812443a08..4366cbac3f06 100644
--- a/net/ipv4/ah4.c
+++ b/net/ipv4/ah4.c
@@ -124,9 +124,14 @@ static void ah_output_done(void *data, int err)
 	struct iphdr *top_iph = ip_hdr(skb);
 	struct ip_auth_hdr *ah = ip_auth_hdr(skb);
 	int ihl = ip_hdrlen(skb);
+	int seqhi_len = 0;
+	__be32 *seqhi;
 
+	if (x->props.flags & XFRM_STATE_ESN)
+		seqhi_len = sizeof(*seqhi);
 	iph = AH_SKB_CB(skb)->tmp;
-	icv = ah_tmp_icv(iph, ihl);
+	seqhi = (__be32 *)((char *)iph + ihl);
+	icv = ah_tmp_icv(seqhi, seqhi_len);
 	memcpy(ah->auth_data, icv, ahp->icv_trunc_len);
 
 	top_iph->tos = iph->tos;
@@ -270,12 +275,17 @@ static void ah_input_done(void *data, int err)
 	struct ip_auth_hdr *ah = ip_auth_hdr(skb);
 	int ihl = ip_hdrlen(skb);
 	int ah_hlen = (ah->hdrlen + 2) << 2;
+	int seqhi_len = 0;
+	__be32 *seqhi;
 
 	if (err)
 		goto out;
 
+	if (x->props.flags & XFRM_STATE_ESN)
+		seqhi_len = sizeof(*seqhi);
 	work_iph = AH_SKB_CB(skb)->tmp;
-	auth_data = ah_tmp_auth(work_iph, ihl);
+	seqhi = (__be32 *)((char *)work_iph + ihl);
+	auth_data = ah_tmp_auth(seqhi, seqhi_len);
 	icv = ah_tmp_icv(auth_data, ahp->icv_trunc_len);
 
 	err = crypto_memneq(icv, auth_data, ahp->icv_trunc_len) ? -EBADMSG : 0;
diff --git a/net/ipv6/ah6.c b/net/ipv6/ah6.c
index cb26beea4398..de1e68199a01 100644
--- a/net/ipv6/ah6.c
+++ b/net/ipv6/ah6.c
@@ -317,14 +317,19 @@ static void ah6_output_done(void *data, int err)
 	struct ipv6hdr *top_iph = ipv6_hdr(skb);
 	struct ip_auth_hdr *ah = ip_auth_hdr(skb);
 	struct tmp_ext *iph_ext;
+	int seqhi_len = 0;
+	__be32 *seqhi;
 
 	extlen = skb_network_header_len(skb) - sizeof(struct ipv6hdr);
 	if (extlen)
 		extlen += sizeof(*iph_ext);
 
+	if (x->props.flags & XFRM_STATE_ESN)
+		seqhi_len = sizeof(*seqhi);
 	iph_base = AH_SKB_CB(skb)->tmp;
 	iph_ext = ah_tmp_ext(iph_base);
-	icv = ah_tmp_icv(iph_ext, extlen);
+	seqhi = (__be32 *)((char *)iph_ext + extlen);
+	icv = ah_tmp_icv(seqhi, seqhi_len);
 
 	memcpy(ah->auth_data, icv, ahp->icv_trunc_len);
 	memcpy(top_iph, iph_base, IPV6HDR_BASELEN);
@@ -471,13 +476,18 @@ static void ah6_input_done(void *data, int err)
 	struct ip_auth_hdr *ah = ip_auth_hdr(skb);
 	int hdr_len = skb_network_header_len(skb);
 	int ah_hlen = ipv6_authlen(ah);
+	int seqhi_len = 0;
+	__be32 *seqhi;
 
 	if (err)
 		goto out;
 
+	if (x->props.flags & XFRM_STATE_ESN)
+		seqhi_len = sizeof(*seqhi);
 	work_iph = AH_SKB_CB(skb)->tmp;
 	auth_data = ah_tmp_auth(work_iph, hdr_len);
-	icv = ah_tmp_icv(auth_data, ahp->icv_trunc_len);
+	seqhi = (__be32 *)(auth_data + ahp->icv_trunc_len);
+	icv = ah_tmp_icv(seqhi, seqhi_len);
 
 	err = crypto_memneq(icv, auth_data, ahp->icv_trunc_len) ? -EBADMSG : 0;
 	if (err)
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index dafcc0dcd77a..0097d4784c71 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -2261,10 +2261,11 @@ static int ip6erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 				struct nlattr *data[],
 				struct netlink_ext_ack *extack)
 {
-	struct ip6gre_net *ign = net_generic(dev_net(dev), ip6gre_net_id);
+	struct ip6_tnl *t = netdev_priv(dev);
 	struct __ip6_tnl_parm p;
-	struct ip6_tnl *t;
+	struct ip6gre_net *ign;
 
+	ign = net_generic(t->net, ip6gre_net_id);
 	t = ip6gre_changelink_common(dev, tb, data, &p, extack);
 	if (IS_ERR(t))
 		return PTR_ERR(t);
diff --git a/net/ipv6/xfrm6_protocol.c b/net/ipv6/xfrm6_protocol.c
index ea2f805d3b01..9b586fcec485 100644
--- a/net/ipv6/xfrm6_protocol.c
+++ b/net/ipv6/xfrm6_protocol.c
@@ -88,8 +88,10 @@ int xfrm6_rcv_encap(struct sk_buff *skb, int nexthdr, __be32 spi,
 
 		dst = ip6_route_input_lookup(dev_net(skb->dev), skb->dev, &fl6,
 					     skb, flags);
-		if (dst->error)
+		if (dst->error) {
+			dst_release(dst);
 			goto drop;
+		}
 		skb_dst_set(skb, dst);
 	}
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 810bea1aacc5..6a0e2896b54c 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -9053,7 +9053,7 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_bss *bss = (void *)cbss->priv;
 	struct sta_info *new_sta = NULL;
 	struct ieee80211_link_data *link;
-	bool have_sta = false;
+	struct sta_info *have_sta = NULL;
 	bool mlo;
 	int err;
 	u16 new_links;
@@ -9072,11 +9072,8 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 		mlo = false;
 	}
 
-	if (assoc) {
-		rcu_read_lock();
+	if (assoc)
 		have_sta = sta_info_get(sdata, ap_mld_addr);
-		rcu_read_unlock();
-	}
 
 	if (mlo && !have_sta &&
 	    WARN_ON(sdata->vif.valid_links || sdata->vif.active_links))
@@ -9239,6 +9236,8 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 out_release_chan:
 	ieee80211_link_release_channel(link);
 out_err:
+	if (mlo && have_sta)
+		WARN_ON(__sta_info_destroy(have_sta));
 	ieee80211_vif_set_links(sdata, 0, 0);
 	return err;
 }
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 11d6c56c9d7e..7a8c964b0ae6 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4928,7 +4928,7 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 	struct sk_buff *skb = rx->skb;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
-	static ieee80211_rx_result res;
+	ieee80211_rx_result res;
 	int orig_len = skb->len;
 	int hdrlen = ieee80211_hdrlen(hdr->frame_control);
 	int snap_offs = hdrlen;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index b2e6c8b98381..6cceaf4bc0d9 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3623,11 +3623,11 @@ void ieee80211_dfs_radar_detected_work(struct wiphy *wiphy,
 	struct ieee80211_local *local =
 		container_of(work, struct ieee80211_local, radar_detected_work);
 	struct cfg80211_chan_def chandef;
-	struct ieee80211_chanctx *ctx;
+	struct ieee80211_chanctx *ctx, *tmp;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	list_for_each_entry(ctx, &local->chanctx_list, list) {
+	list_for_each_entry_safe(ctx, tmp, &local->chanctx_list, list) {
 		if (ctx->replace_state == IEEE80211_CHANCTX_REPLACES_OTHER)
 			continue;
 
diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 82ec15bcfd7f..082c46c0f50e 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -12,6 +12,7 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	struct sock *sk, *ssk;
 	struct sk_buff *skb;
 	struct tcp_sock *tp;
+	bool has_rxtstamp;
 
 	/* on early fallback the subflow context is deleted by
 	 * subflow_syn_recv_sock()
@@ -40,12 +41,13 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	 */
 	tp->copied_seq += skb->len;
 	subflow->ssn_offset += skb->len;
+	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
 
 	/* Only the sequence delta is relevant */
 	MPTCP_SKB_CB(skb)->map_seq = -skb->len;
 	MPTCP_SKB_CB(skb)->end_seq = 0;
 	MPTCP_SKB_CB(skb)->offset = 0;
-	MPTCP_SKB_CB(skb)->has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
+	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
 	MPTCP_SKB_CB(skb)->cant_coalesce = 1;
 
 	mptcp_data_lock(sk);
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 57a456690406..3c152bf66cd5 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -16,6 +16,7 @@ struct mptcp_pm_add_entry {
 	struct list_head	list;
 	struct mptcp_addr_info	addr;
 	u8			retrans_times;
+	bool			timer_done;
 	struct timer_list	add_timer;
 	struct mptcp_sock	*sock;
 	struct rcu_head		rcu;
@@ -283,6 +284,9 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct mptcp_addr_info local, remote;
 
+		if (!__mptcp_subflow_active(subflow))
+			continue;
+
 		mptcp_local_address((struct sock_common *)ssk, &local);
 		if (!mptcp_addresses_equal(&local, addr, addr->port))
 			continue;
@@ -305,18 +309,31 @@ static unsigned int mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk)
 	const struct net *net = sock_net((struct sock *)msk);
 	unsigned int rto = mptcp_get_add_addr_timeout(net);
 	struct mptcp_subflow_context *subflow;
-	unsigned int max = 0;
+	unsigned int max = 0, max_stale = 0;
+
+	if (!rto)
+		return 0;
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct inet_connection_sock *icsk = inet_csk(ssk);
 
-		if (icsk->icsk_rto > max)
+		if (!__mptcp_subflow_active(subflow))
+			continue;
+
+		if (unlikely(subflow->stale)) {
+			if (icsk->icsk_rto > max_stale)
+				max_stale = icsk->icsk_rto;
+		} else if (icsk->icsk_rto > max) {
 			max = icsk->icsk_rto;
+		}
 	}
 
-	if (max && max < rto)
-		rto = max;
+	if (max)
+		return min(max, rto);
+
+	if (max_stale)
+		return min(max_stale, rto);
 
 	return rto;
 }
@@ -327,26 +344,22 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 							      add_timer);
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
-	unsigned int timeout;
+	unsigned int timeout = 0;
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!msk)
-		return;
-
-	if (inet_sk_state_load(sk) == TCP_CLOSE)
-		return;
-
-	if (!entry->addr.id)
-		return;
+	bh_lock_sock(sk);
+	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
+		goto out;
 
-	if (mptcp_pm_should_add_signal_addr(msk)) {
-		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX / 8);
+	if (sock_owned_by_user(sk)) {
+		/* Try again later. */
+		timeout = HZ / 20;
 		goto out;
 	}
 
 	timeout = mptcp_adjust_add_addr_timeout(msk);
-	if (!timeout)
+	if (!timeout || mptcp_pm_should_add_signal_addr(msk))
 		goto out;
 
 	spin_lock_bh(&msk->pm.lock);
@@ -359,8 +372,9 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	}
 
 	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
-		sk_reset_timer(sk, timer,
-			       jiffies + (timeout << entry->retrans_times));
+		timeout <<= entry->retrans_times;
+	else
+		timeout = 0;
 
 	spin_unlock_bh(&msk->pm.lock);
 
@@ -368,7 +382,13 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		mptcp_pm_subflow_established(msk);
 
 out:
-	__sock_put(sk);
+	if (timeout)
+		sk_reset_timer(sk, timer, jiffies + timeout);
+	else
+		/* if sock_put calls sk_free: avoid waiting for this timer */
+		entry->timer_done = true;
+	bh_unlock_sock(sk);
+	sock_put(sk);
 }
 
 struct mptcp_pm_add_entry *
@@ -431,6 +451,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
 reset_timer:
+	add_entry->timer_done = false;
 	timeout = mptcp_adjust_add_addr_timeout(msk);
 	if (timeout)
 		sk_reset_timer(sk, &add_entry->add_timer, jiffies + timeout);
@@ -451,7 +472,8 @@ static void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 
 	list_for_each_entry_safe(entry, tmp, &free_list, list) {
-		sk_stop_timer_sync(sk, &entry->add_timer);
+		if (!entry->timer_done)
+			sk_stop_timer_sync(sk, &entry->add_timer);
 		kfree_rcu(entry, rcu);
 	}
 }
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 0ebf43be9939..fc818b63752e 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -347,6 +347,8 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 	/* check first for announce */
 	if (msk->pm.add_addr_signaled < endp_signal_max) {
+		u8 endp_id;
+
 		/* due to racing events on both ends we can reach here while
 		 * previous add address is still running: if we invoke now
 		 * mptcp_pm_announce_addr(), that will fail and the
@@ -360,19 +362,20 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		if (!select_signal_address(pernet, msk, &local))
 			goto subflow;
 
+		/* Special case for ID0: set the correct ID */
+		endp_id = local.addr.id;
+		if (endp_id == msk->mpc_endpoint_id)
+			local.addr.id = 0;
+
 		/* If the alloc fails, we are on memory pressure, not worth
 		 * continuing, and trying to create subflows.
 		 */
 		if (!mptcp_pm_alloc_anno_list(msk, &local.addr))
 			return;
 
-		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
+		__clear_bit(endp_id, msk->pm.id_avail_bitmap);
 		msk->pm.add_addr_signaled++;
 
-		/* Special case for ID0: set the correct ID */
-		if (local.addr.id == msk->mpc_endpoint_id)
-			local.addr.id = 0;
-
 		mptcp_pm_announce_addr(msk, &local.addr, false);
 		mptcp_pm_addr_send_ack(msk);
 
@@ -1278,6 +1281,7 @@ static void __reset_counters(struct pm_nl_pernet *pernet)
 	WRITE_ONCE(pernet->endp_signal_max, 0);
 	WRITE_ONCE(pernet->endp_subflow_max, 0);
 	WRITE_ONCE(pernet->endp_laminar_max, 0);
+	WRITE_ONCE(pernet->endp_fullmesh_max, 0);
 	pernet->endpoints = 0;
 }
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ce5e05ec3436..1a73d2461c7b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3279,7 +3279,8 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		goto cleanup;
 	}
 
-	if (mptcp_data_avail(msk) || timeout < 0) {
+	if (mptcp_data_avail(msk) || timeout < 0 ||
+	    (sock_flag(sk, SOCK_LINGER) && !sk->sk_lingertime)) {
 		/* If the msk has read data, or the caller explicitly ask it,
 		 * do the MPTCP equivalent of TCP reset, aka MPTCP fastclose
 		 */
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index de90a2897d2d..1cf608e7357b 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -159,10 +159,10 @@ static int mptcp_setsockopt_sol_socket_tstamp(struct mptcp_sock *msk, int optnam
 	lock_sock(sk);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		bool slow = lock_sock_fast(ssk);
 
-		sock_set_timestamp(sk, optname, !!val);
-		unlock_sock_fast(ssk, slow);
+		lock_sock(ssk);
+		sock_set_timestamp(ssk, optname, !!val);
+		release_sock(ssk);
 	}
 
 	release_sock(sk);
@@ -235,10 +235,10 @@ static int mptcp_setsockopt_sol_socket_timestamping(struct mptcp_sock *msk,
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		bool slow = lock_sock_fast(ssk);
 
-		sock_set_timestamping(sk, optname, timestamping);
-		unlock_sock_fast(ssk, slow);
+		lock_sock(ssk);
+		sock_set_timestamping(ssk, optname, timestamping);
+		release_sock(ssk);
 	}
 
 	release_sock(sk);
@@ -812,6 +812,10 @@ static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
 		if (ret)
 			break;
 	}
+
+	if (!ret)
+		sockopt_seq_inc(msk);
+
 	return ret;
 }
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 4ff5863aa9fd..84566553ac44 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -581,7 +581,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 			 subflow->backup);
 
 		if (!subflow_thmac_valid(subflow)) {
-			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINACKMAC);
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKMAC);
 			subflow->reset_reason = MPTCP_RST_EMPTCP;
 			goto do_reset;
 		}
@@ -908,7 +908,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 
 			if (!subflow_hmac_valid(subflow_req, &mp_opt)) {
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
-				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
+				subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
 				goto dispose_child;
 			}
 
diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-netdev.c
index 12055af832dc..a1df551e915b 100644
--- a/net/openvswitch/vport-netdev.c
+++ b/net/openvswitch/vport-netdev.c
@@ -196,9 +196,13 @@ void ovs_netdev_tunnel_destroy(struct vport *vport)
 	 */
 	if (vport->dev->reg_state == NETREG_REGISTERED)
 		rtnl_delete_link(vport->dev, 0, NULL);
-	rtnl_unlock();
 
+	/* We can't put the device reference yet, since it can still be in
+	 * use, but rtnl_unlock()->netdev_run_todo() will block until all
+	 * the references are released, so the RCU call must be before it.
+	 */
 	call_rcu(&vport->rcu, vport_netdev_free);
+	rtnl_unlock();
 }
 EXPORT_SYMBOL_GPL(ovs_netdev_tunnel_destroy);
 
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index d4c04c923c5a..956f3ff0c22a 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -263,15 +263,16 @@ EXPORT_SYMBOL(psp_dev_encapsulate);
 
 /* Receive handler for PSP packets.
  *
- * Presently it accepts only already-authenticated packets and does not
- * support optional fields, such as virtualization cookies. The caller should
- * ensure that skb->data is pointing to the mac header, and that skb->mac_len
- * is set. This function does not currently adjust skb->csum (CHECKSUM_COMPLETE
- * is not supported).
+ * Accepts only already-authenticated packets. The full PSP header is
+ * stripped according to psph->hdrlen; any optional fields it advertises
+ * (virtualization cookies, etc.) are ignored and discarded along with the
+ * rest of the header. The caller should ensure that skb->data is pointing
+ * to the mac header, and that skb->mac_len is set. This function does not
+ * currently adjust skb->csum (CHECKSUM_COMPLETE is not supported).
  */
 int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
 {
-	int l2_hlen = 0, l3_hlen, encap;
+	int l2_hlen = 0, l3_hlen, encap, psp_hlen;
 	struct psp_skb_ext *pse;
 	struct psphdr *psph;
 	struct ethhdr *eth;
@@ -312,18 +313,36 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
 	if (unlikely(uh->dest != htons(PSP_DEFAULT_UDP_PORT)))
 		return -EINVAL;
 
-	pse = skb_ext_add(skb, SKB_EXT_PSP);
-	if (!pse)
+	psph = (struct psphdr *)(skb->data + l2_hlen + l3_hlen +
+				 sizeof(struct udphdr));
+
+	/* Strip the full PSP header per psph->hdrlen; VC/options are pulled
+	 * into the linear region only so they can be discarded with the
+	 * rest of the header.
+	 */
+	psp_hlen = (psph->hdrlen + 1) * 8;
+
+	if (unlikely(psp_hlen < sizeof(struct psphdr)))
+		return -EINVAL;
+
+	if (psp_hlen > sizeof(struct psphdr) &&
+	    !pskb_may_pull(skb, l2_hlen + l3_hlen +
+				sizeof(struct udphdr) + psp_hlen))
 		return -EINVAL;
 
 	psph = (struct psphdr *)(skb->data + l2_hlen + l3_hlen +
 				 sizeof(struct udphdr));
+
+	pse = skb_ext_add(skb, SKB_EXT_PSP);
+	if (!pse)
+		return -EINVAL;
+
 	pse->spi = psph->spi;
 	pse->dev_id = dev_id;
 	pse->generation = generation;
 	pse->version = FIELD_GET(PSPHDR_VERFL_VERSION, psph->verfl);
 
-	encap = PSP_ENCAP_HLEN;
+	encap = sizeof(struct udphdr) + psp_hlen;
 	encap += strip_icv ? PSP_TRL_SIZE : 0;
 
 	if (proto == htons(ETH_P_IP)) {
@@ -340,8 +359,9 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
 		ipv6h->payload_len = htons(ntohs(ipv6h->payload_len) - encap);
 	}
 
-	memmove(skb->data + PSP_ENCAP_HLEN, skb->data, l2_hlen + l3_hlen);
-	skb_pull(skb, PSP_ENCAP_HLEN);
+	memmove(skb->data + sizeof(struct udphdr) + psp_hlen,
+		skb->data, l2_hlen + l3_hlen);
+	skb_pull(skb, sizeof(struct udphdr) + psp_hlen);
 
 	if (strip_icv)
 		pskb_trim(skb, skb->len - PSP_TRL_SIZE);
diff --git a/net/rds/message.c b/net/rds/message.c
index eaa6f22601a4..25fedcb3cd00 100644
--- a/net/rds/message.c
+++ b/net/rds/message.c
@@ -131,24 +131,34 @@ static void rds_rm_zerocopy_callback(struct rds_sock *rs,
  */
 static void rds_message_purge(struct rds_message *rm)
 {
+	struct rds_znotifier *znotifier;
 	unsigned long i, flags;
-	bool zcopy = false;
+	bool zcopy;
 
 	if (unlikely(test_bit(RDS_MSG_PAGEVEC, &rm->m_flags)))
 		return;
 
 	spin_lock_irqsave(&rm->m_rs_lock, flags);
+	znotifier = rm->data.op_mmp_znotifier;
+	rm->data.op_mmp_znotifier = NULL;
+	zcopy = !!znotifier;
+
 	if (rm->m_rs) {
 		struct rds_sock *rs = rm->m_rs;
 
-		if (rm->data.op_mmp_znotifier) {
-			zcopy = true;
-			rds_rm_zerocopy_callback(rs, rm->data.op_mmp_znotifier);
+		if (znotifier) {
+			rds_rm_zerocopy_callback(rs, znotifier);
 			rds_wake_sk_sleep(rs);
-			rm->data.op_mmp_znotifier = NULL;
 		}
 		sock_put(rds_rs_to_sk(rs));
 		rm->m_rs = NULL;
+	} else if (znotifier) {
+		/*
+		 * Zerocopy can fail before the message is queued on the
+		 * socket, so there is no rs to carry the notification.
+		 */
+		mm_unaccount_pinned_pages(&znotifier->z_mmp);
+		kfree(rds_info_from_znotifier(znotifier));
 	}
 	spin_unlock_irqrestore(&rm->m_rs_lock, flags);
 
diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index 479c42d11083..68ee41ce78c5 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -155,7 +155,7 @@ static struct sk_buff *red_dequeue(struct Qdisc *sch)
 	struct red_sched_data *q = qdisc_priv(sch);
 	struct Qdisc *child = q->qdisc;
 
-	skb = child->dequeue(child);
+	skb = qdisc_dequeue_peeked(child);
 	if (skb) {
 		qdisc_bstats_update(sch, skb);
 		qdisc_qstats_backlog_dec(sch, skb);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index b23c33df8b46..09d43b4813b1 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -3300,6 +3300,9 @@ static int unix_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 			struct sk_buff *skb;
 			int answ = 0;
 
+			if (sk->sk_type != SOCK_STREAM)
+				return -EOPNOTSUPP;
+
 			mutex_lock(&u->iolock);
 
 			skb = skb_peek(&sk->sk_receive_queue);
diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 069386a74557..d5b0fd0a8897 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -375,10 +375,10 @@ static void hvs_open_connection(struct vmbus_channel *chan)
 	} else {
 		sndbuf = max_t(int, sk->sk_sndbuf, RINGBUFFER_HVS_SND_SIZE);
 		sndbuf = min_t(int, sndbuf, RINGBUFFER_HVS_MAX_SIZE);
-		sndbuf = ALIGN(sndbuf, HV_HYP_PAGE_SIZE);
+		sndbuf = VMBUS_RING_SIZE(sndbuf);
 		rcvbuf = max_t(int, sk->sk_rcvbuf, RINGBUFFER_HVS_RCV_SIZE);
 		rcvbuf = min_t(int, rcvbuf, RINGBUFFER_HVS_MAX_SIZE);
-		rcvbuf = ALIGN(rcvbuf, HV_HYP_PAGE_SIZE);
+		rcvbuf = VMBUS_RING_SIZE(rcvbuf);
 	}
 
 	chan->max_pkt_size = HVS_MAX_PKT_SIZE;
@@ -694,7 +694,6 @@ static ssize_t hvs_stream_enqueue(struct vsock_sock *vsk, struct msghdr *msg,
 static s64 hvs_stream_has_data(struct vsock_sock *vsk)
 {
 	struct hvsock *hvs = vsk->trans;
-	bool need_refill;
 	s64 ret;
 
 	if (hvs->recv_data_len > 0)
@@ -702,9 +701,31 @@ static s64 hvs_stream_has_data(struct vsock_sock *vsk)
 
 	switch (hvs_channel_readable_payload(hvs->chan)) {
 	case 1:
-		need_refill = !hvs->recv_desc;
-		if (!need_refill)
-			return -EIO;
+		if (hvs->recv_desc) {
+			/* Here hvs->recv_data_len is 0, so hvs->recv_desc must
+			 * be NULL unless it points to the 0-byte-payload FIN
+			 * packet or a malformed/short packet: see
+			 * hvs_update_recv_data().
+			 *
+			 * If hvs->recv_desc points to the FIN packet, here all
+			 * the payload has been dequeued and the peer_shutdown
+			 * flag is set, but hvs_channel_readable_payload() still
+			 * returns 1, because the VMBus ringbuffer's read_index
+			 * is not updated for the FIN packet:
+			 * hvs_stream_dequeue() -> hv_pkt_iter_next() updates
+			 * the cached priv_read_index but has no opportunity to
+			 * update the read_index in hv_pkt_iter_close() as
+			 * hvs_stream_has_data() returns 0 for the FIN packet,
+			 * so it won't get dequeued.
+			 *
+			 * In case hvs->recv_desc points to a malformed/short
+			 * packet, return -EIO.
+			 */
+			if (!(vsk->peer_shutdown & SEND_SHUTDOWN))
+				return -EIO;
+
+			return 0;
+		}
 
 		hvs->recv_desc = hv_pkt_iter_first(hvs->chan);
 		if (!hvs->recv_desc)
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 1748d374abca..686014d39429 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -818,17 +818,17 @@ int __xfrm_state_delete(struct xfrm_state *x)
 
 		spin_lock(&net->xfrm.xfrm_state_lock);
 		list_del(&x->km.all);
-		hlist_del_rcu(&x->bydst);
-		hlist_del_rcu(&x->bysrc);
-		if (x->km.seq)
-			hlist_del_rcu(&x->byseq);
+		hlist_del_init_rcu(&x->bydst);
+		hlist_del_init_rcu(&x->bysrc);
+		if (!hlist_unhashed(&x->byseq))
+			hlist_del_init_rcu(&x->byseq);
 		if (!hlist_unhashed(&x->state_cache))
 			hlist_del_rcu(&x->state_cache);
 		if (!hlist_unhashed(&x->state_cache_input))
 			hlist_del_rcu(&x->state_cache_input);
 
-		if (x->id.spi)
-			hlist_del_rcu(&x->byspi);
+		if (!hlist_unhashed(&x->byspi))
+			hlist_del_init_rcu(&x->byspi);
 		net->xfrm.state_num--;
 		xfrm_nat_keepalive_state_updated(x);
 		spin_unlock(&net->xfrm.xfrm_state_lock);
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index d56450f61669..38a90e5ee3d9 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3323,6 +3323,7 @@ const int xfrm_msg_min[XFRM_NR_MSGTYPES] = {
 	[XFRM_MSG_GETSADINFO  - XFRM_MSG_BASE] = sizeof(u32),
 	[XFRM_MSG_NEWSPDINFO  - XFRM_MSG_BASE] = sizeof(u32),
 	[XFRM_MSG_GETSPDINFO  - XFRM_MSG_BASE] = sizeof(u32),
+	[XFRM_MSG_MAPPING     - XFRM_MSG_BASE] = XMSGSIZE(xfrm_user_mapping),
 	[XFRM_MSG_SETDEFAULT  - XFRM_MSG_BASE] = XMSGSIZE(xfrm_userpolicy_default),
 	[XFRM_MSG_GETDEFAULT  - XFRM_MSG_BASE] = XMSGSIZE(xfrm_userpolicy_default),
 };
diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index d49a9ba02635..41ca5f63f0e5 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -207,8 +207,17 @@ pub fn new(dev: &drm::Device<T::Driver>, size: usize) -> Result<ARef<Self>> {
         // SAFETY: `obj.as_raw()` is guaranteed to be valid by the initialization above.
         unsafe { (*obj.as_raw()).funcs = &Self::OBJECT_FUNCS };
 
-        // SAFETY: The arguments are all valid per the type invariants.
-        to_result(unsafe { bindings::drm_gem_object_init(dev.as_raw(), obj.obj.get(), size) })?;
+        if let Err(err) =
+            // SAFETY: The arguments are all valid per the type invariants.
+            to_result(unsafe {
+                bindings::drm_gem_object_init(dev.as_raw(), obj.obj.get(), size)
+            })
+        {
+            // SAFETY: `drm_gem_object_init()` initializes the private GEM object state before
+            // failing, so `drm_gem_private_object_fini()` is the matching cleanup.
+            unsafe { bindings::drm_gem_private_object_fini(obj.obj.get()) };
+            return Err(err);
+        }
 
         // SAFETY: We will never move out of `Self` as `ARef<Self>` is always treated as pinned.
         let ptr = KBox::into_raw(unsafe { Pin::into_inner_unchecked(obj) });
diff --git a/rust/pin-init/internal/src/init.rs b/rust/pin-init/internal/src/init.rs
index 2fe918f4d82a..bda2ae923c78 100644
--- a/rust/pin-init/internal/src/init.rs
+++ b/rust/pin-init/internal/src/init.rs
@@ -243,22 +243,6 @@ fn init_fields(
                 });
                 // Again span for better diagnostics
                 let write = quote_spanned!(ident.span()=> ::core::ptr::write);
-                // NOTE: the field accessor ensures that the initialized field is properly aligned.
-                // Unaligned fields will cause the compiler to emit E0793. We do not support
-                // unaligned fields since `Init::__init` requires an aligned pointer; the call to
-                // `ptr::write` below has the same requirement.
-                let accessor = if pinned {
-                    let project_ident = format_ident!("__project_{ident}");
-                    quote! {
-                        // SAFETY: TODO
-                        unsafe { #data.#project_ident(&mut (*#slot).#ident) }
-                    }
-                } else {
-                    quote! {
-                        // SAFETY: TODO
-                        unsafe { &mut (*#slot).#ident }
-                    }
-                };
                 quote! {
                     #(#attrs)*
                     {
@@ -266,51 +250,31 @@ fn init_fields(
                         // SAFETY: TODO
                         unsafe { #write(::core::ptr::addr_of_mut!((*#slot).#ident), #value_ident) };
                     }
-                    #(#cfgs)*
-                    #[allow(unused_variables)]
-                    let #ident = #accessor;
                 }
             }
             InitializerKind::Init { ident, value, .. } => {
                 // Again span for better diagnostics
                 let init = format_ident!("init", span = value.span());
-                // NOTE: the field accessor ensures that the initialized field is properly aligned.
-                // Unaligned fields will cause the compiler to emit E0793. We do not support
-                // unaligned fields since `Init::__init` requires an aligned pointer; the call to
-                // `ptr::write` below has the same requirement.
-                let (value_init, accessor) = if pinned {
-                    let project_ident = format_ident!("__project_{ident}");
-                    (
-                        quote! {
-                            // SAFETY:
-                            // - `slot` is valid, because we are inside of an initializer closure, we
-                            //   return when an error/panic occurs.
-                            // - We also use `#data` to require the correct trait (`Init` or `PinInit`)
-                            //   for `#ident`.
-                            unsafe { #data.#ident(::core::ptr::addr_of_mut!((*#slot).#ident), #init)? };
-                        },
-                        quote! {
-                            // SAFETY: TODO
-                            unsafe { #data.#project_ident(&mut (*#slot).#ident) }
-                        },
-                    )
+                let value_init = if pinned {
+                    quote! {
+                        // SAFETY:
+                        // - `slot` is valid, because we are inside of an initializer closure, we
+                        //   return when an error/panic occurs.
+                        // - We also use `#data` to require the correct trait (`Init` or `PinInit`)
+                        //   for `#ident`.
+                        unsafe { #data.#ident(::core::ptr::addr_of_mut!((*#slot).#ident), #init)? };
+                    }
                 } else {
-                    (
-                        quote! {
-                            // SAFETY: `slot` is valid, because we are inside of an initializer
-                            // closure, we return when an error/panic occurs.
-                            unsafe {
-                                ::pin_init::Init::__init(
-                                    #init,
-                                    ::core::ptr::addr_of_mut!((*#slot).#ident),
-                                )?
-                            };
-                        },
-                        quote! {
-                            // SAFETY: TODO
-                            unsafe { &mut (*#slot).#ident }
-                        },
-                    )
+                    quote! {
+                        // SAFETY: `slot` is valid, because we are inside of an initializer
+                        // closure, we return when an error/panic occurs.
+                        unsafe {
+                            ::pin_init::Init::__init(
+                                #init,
+                                ::core::ptr::addr_of_mut!((*#slot).#ident),
+                            )?
+                        };
+                    }
                 };
                 quote! {
                     #(#attrs)*
@@ -318,9 +282,6 @@ fn init_fields(
                         let #init = #value;
                         #value_init
                     }
-                    #(#cfgs)*
-                    #[allow(unused_variables)]
-                    let #ident = #accessor;
                 }
             }
             InitializerKind::Code { block: value, .. } => quote! {
@@ -333,18 +294,41 @@ fn init_fields(
         if let Some(ident) = kind.ident() {
             // `mixed_site` ensures that the guard is not accessible to the user-controlled code.
             let guard = format_ident!("__{ident}_guard", span = Span::mixed_site());
+
+            // NOTE: The reference is derived from the guard so that it only lives as long as the
+            // guard does and cannot escape the scope. If it's created via `&mut (*#slot).#ident`
+            // like the unaligned field guard, it will become effectively `'static`.
+            let accessor = if pinned {
+                let project_ident = format_ident!("__project_{ident}");
+                quote! {
+                    // SAFETY: the initialization is pinned.
+                    unsafe { #data.#project_ident(#guard.let_binding()) }
+                }
+            } else {
+                quote! {
+                    #guard.let_binding()
+                }
+            };
+
             res.extend(quote! {
                 #(#cfgs)*
-                // Create the drop guard:
+                // Create the drop guard.
                 //
-                // We rely on macro hygiene to make it impossible for users to access this local
-                // variable.
-                // SAFETY: We forget the guard later when initialization has succeeded.
-                let #guard = unsafe {
+                // SAFETY:
+                // - `&raw mut (*slot).#ident` is valid.
+                // - `make_field_check` checks that `&raw mut (*slot).#ident` is properly aligned.
+                // - `(*slot).#ident` has been initialized above.
+                // - We only need the ownership to the pointee back when initialization has
+                //   succeeded, where we `forget` the guard.
+                let mut #guard = unsafe {
                     ::pin_init::__internal::DropGuard::new(
                         ::core::ptr::addr_of_mut!((*slot).#ident)
                     )
                 };
+
+                #(#cfgs)*
+                #[allow(unused_variables)]
+                let #ident = #accessor;
             });
             guards.push(guard);
             guard_attrs.push(cfgs);
@@ -361,49 +345,49 @@ fn init_fields(
     }
 }
 
-/// Generate the check for ensuring that every field has been initialized.
+/// Generate the check for ensuring that every field has been initialized and aligned.
 fn make_field_check(
     fields: &Punctuated<InitializerField, Token![,]>,
     init_kind: InitKind,
     path: &Path,
 ) -> TokenStream {
-    let field_attrs = fields
+    let field_attrs: Vec<_> = fields
         .iter()
-        .filter_map(|f| f.kind.ident().map(|_| &f.attrs));
-    let field_name = fields.iter().filter_map(|f| f.kind.ident());
-    match init_kind {
-        InitKind::Normal => quote! {
-            // We use unreachable code to ensure that all fields have been mentioned exactly once,
-            // this struct initializer will still be type-checked and complain with a very natural
-            // error message if a field is forgotten/mentioned more than once.
-            #[allow(unreachable_code, clippy::diverging_sub_expression)]
-            // SAFETY: this code is never executed.
-            let _ = || unsafe {
-                ::core::ptr::write(slot, #path {
-                    #(
-                        #(#field_attrs)*
-                        #field_name: ::core::panic!(),
-                    )*
-                })
-            };
-        },
-        InitKind::Zeroing => quote! {
-            // We use unreachable code to ensure that all fields have been mentioned at most once.
-            // Since the user specified `..Zeroable::zeroed()` at the end, all missing fields will
-            // be zeroed. This struct initializer will still be type-checked and complain with a
-            // very natural error message if a field is mentioned more than once, or doesn't exist.
-            #[allow(unreachable_code, clippy::diverging_sub_expression, unused_assignments)]
-            // SAFETY: this code is never executed.
-            let _ = || unsafe {
-                ::core::ptr::write(slot, #path {
-                    #(
-                        #(#field_attrs)*
-                        #field_name: ::core::panic!(),
-                    )*
-                    ..::core::mem::zeroed()
-                })
-            };
-        },
+        .filter_map(|f| f.kind.ident().map(|_| &f.attrs))
+        .collect();
+    let field_name: Vec<_> = fields.iter().filter_map(|f| f.kind.ident()).collect();
+    let zeroing_trailer = match init_kind {
+        InitKind::Normal => None,
+        InitKind::Zeroing => Some(quote! {
+            ..::core::mem::zeroed()
+        }),
+    };
+    quote! {
+        #[allow(unreachable_code, clippy::diverging_sub_expression)]
+        // We use unreachable code to perform field checks. They're still checked by the compiler.
+        // SAFETY: this code is never executed.
+        let _ = || unsafe {
+            // Create references to ensure that the initialized field is properly aligned.
+            // Unaligned fields will cause the compiler to emit E0793. We do not support
+            // unaligned fields since `Init::__init` requires an aligned pointer; the call to
+            // `ptr::write` for value-initialization case has the same requirement.
+            #(
+                #(#field_attrs)*
+                let _ = &(*slot).#field_name;
+            )*
+
+            // If the zeroing trailer is not present, this checks that all fields have been
+            // mentioned exactly once. If the zeroing trailer is present, all missing fields will be
+            // zeroed, so this checks that all fields have been mentioned at most once. The use of
+            // struct initializer will still generate very natural error messages for any misuse.
+            ::core::ptr::write(slot, #path {
+                #(
+                    #(#field_attrs)*
+                    #field_name: ::core::panic!(),
+                )*
+                #zeroing_trailer
+            })
+        };
     }
 }
 
diff --git a/rust/pin-init/src/__internal.rs b/rust/pin-init/src/__internal.rs
index 90adbdc1893b..5720a621aed7 100644
--- a/rust/pin-init/src/__internal.rs
+++ b/rust/pin-init/src/__internal.rs
@@ -238,32 +238,42 @@ struct Foo {
 /// When a value of this type is dropped, it drops a `T`.
 ///
 /// Can be forgotten to prevent the drop.
+///
+/// # Invariants
+///
+/// - `ptr` is valid and properly aligned.
+/// - `*ptr` is initialized and owned by this guard.
 pub struct DropGuard<T: ?Sized> {
     ptr: *mut T,
 }
 
 impl<T: ?Sized> DropGuard<T> {
-    /// Creates a new [`DropGuard<T>`]. It will [`ptr::drop_in_place`] `ptr` when it gets dropped.
+    /// Creates a drop guard and transfer the ownership of the pointer content.
     ///
-    /// # Safety
+    /// The ownership is only relinguished if the guard is forgotten via [`core::mem::forget`].
     ///
-    /// `ptr` must be a valid pointer.
+    /// # Safety
     ///
-    /// It is the callers responsibility that `self` will only get dropped if the pointee of `ptr`:
-    /// - has not been dropped,
-    /// - is not accessible by any other means,
-    /// - will not be dropped by any other means.
+    /// - `ptr` is valid and properly aligned.
+    /// - `*ptr` is initialized, and the ownership is transferred to this guard.
     #[inline]
     pub unsafe fn new(ptr: *mut T) -> Self {
+        // INVARIANT: By safety requirement.
         Self { ptr }
     }
+
+    /// Create a let binding for accessor use.
+    #[inline]
+    pub fn let_binding(&mut self) -> &mut T {
+        // SAFETY: Per type invariant.
+        unsafe { &mut *self.ptr }
+    }
 }
 
 impl<T: ?Sized> Drop for DropGuard<T> {
     #[inline]
     fn drop(&mut self) {
-        // SAFETY: A `DropGuard` can only be constructed using the unsafe `new` function
-        // ensuring that this operation is safe.
+        // SAFETY: `self.ptr` is valid, properly aligned and `*self.ptr` is owned by this guard.
         unsafe { ptr::drop_in_place(self.ptr) }
     }
 }
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 76e0fb7dcb36..6c154a4d94b9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2965,7 +2965,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 {
 	const struct cred_security_struct *crsec = selinux_cred(current_cred());
 	struct superblock_security_struct *sbsec;
-	struct xattr *xattr = lsm_get_xattr_slot(xattrs, xattr_count);
+	struct xattr *xattr;
 	u32 newsid, clen;
 	u16 newsclass;
 	int rc;
@@ -2991,6 +2991,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	    !(sbsec->flags & SBLABEL_MNT))
 		return -EOPNOTSUPP;
 
+	xattr = lsm_get_xattr_slot(xattrs, xattr_count);
 	if (xattr) {
 		rc = security_sid_to_context_force(newsid,
 						   &context, &clen);
@@ -3207,15 +3208,13 @@ static inline int task_avdcache_search(struct task_security_struct *tsec,
  * @tsec: the task's security state
  * @isec: the inode associated with the cache entry
  * @avd: the AVD to cache
- * @audited: the permission audit bitmask to cache
  *
- * Update the AVD cache in @tsec with the @avdc and @audited info associated
+ * Update the AVD cache in @tsec with the @avd info associated
  * with @isec.
  */
 static inline void task_avdcache_update(struct task_security_struct *tsec,
 					struct inode_security_struct *isec,
-					struct av_decision *avd,
-					u32 audited)
+					struct av_decision *avd)
 {
 	int spot;
 
@@ -3227,9 +3226,7 @@ static inline void task_avdcache_update(struct task_security_struct *tsec,
 	spot = (tsec->avdcache.dir_spot + 1) & (TSEC_AVDC_DIR_SIZE - 1);
 	tsec->avdcache.dir_spot = spot;
 	tsec->avdcache.dir[spot].isid = isec->sid;
-	tsec->avdcache.dir[spot].audited = audited;
-	tsec->avdcache.dir[spot].allowed = avd->allowed;
-	tsec->avdcache.dir[spot].permissive = avd->flags & AVD_FLAGS_PERMISSIVE;
+	tsec->avdcache.dir[spot].avd = *avd;
 	tsec->avdcache.permissive_neveraudit =
 		(avd->flags == (AVD_FLAGS_PERMISSIVE|AVD_FLAGS_NEVERAUDIT));
 }
@@ -3250,6 +3247,7 @@ static int selinux_inode_permission(struct inode *inode, int requested)
 	struct task_security_struct *tsec;
 	struct inode_security_struct *isec;
 	struct avdc_entry *avdc;
+	struct av_decision avd, *avdp = &avd;
 	int rc, rc2;
 	u32 audited, denied;
 
@@ -3271,23 +3269,21 @@ static int selinux_inode_permission(struct inode *inode, int requested)
 	rc = task_avdcache_search(tsec, isec, &avdc);
 	if (likely(!rc)) {
 		/* Cache hit. */
-		audited = perms & avdc->audited;
-		denied = perms & ~avdc->allowed;
-		if (unlikely(denied && enforcing_enabled() &&
-			     !avdc->permissive))
+		avdp = &avdc->avd;
+		denied = perms & ~avdp->allowed;
+		if (unlikely(denied) && enforcing_enabled() &&
+			!(avdp->flags & AVD_FLAGS_PERMISSIVE))
 			rc = -EACCES;
 	} else {
-		struct av_decision avd;
-
 		/* Cache miss. */
 		rc = avc_has_perm_noaudit(sid, isec->sid, isec->sclass,
-					  perms, 0, &avd);
-		audited = avc_audit_required(perms, &avd, rc,
-			(requested & MAY_ACCESS) ? FILE__AUDIT_ACCESS : 0,
-			&denied);
-		task_avdcache_update(tsec, isec, &avd, audited);
+					  perms, 0, avdp);
+		task_avdcache_update(tsec, isec, avdp);
 	}
 
+	audited = avc_audit_required(perms, avdp, rc,
+				     (requested & MAY_ACCESS) ?
+				     FILE__AUDIT_ACCESS : 0, &denied);
 	if (likely(!audited))
 		return rc;
 
@@ -4919,7 +4915,7 @@ static bool sock_skip_has_perm(u32 sid)
 
 static int sock_has_perm(struct sock *sk, u32 perms)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct common_audit_data ad;
 	struct lsm_network_audit net;
 
@@ -6226,7 +6222,7 @@ static unsigned int selinux_ip_postroute(void *priv,
 
 static int nlmsg_sock_has_extended_perms(struct sock *sk, u32 perms, u16 nlmsg_type)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct common_audit_data ad;
 	u8 driver;
 	u8 xperm;
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index b19e5d978e82..3c0a16ec978b 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -32,9 +32,7 @@
 
 struct avdc_entry {
 	u32 isid; /* inode SID */
-	u32 allowed; /* allowed permission bitmask */
-	u32 audited; /* audited permission bitmask */
-	bool permissive; /* AVC permissive flag */
+	struct av_decision avd; /* av decision */
 };
 
 struct cred_security_struct {
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index d1f16d7f684d..0babb8992181 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -312,8 +312,6 @@ int security_context_to_sid_default(const char *scontext, u32 scontext_len,
 int security_context_to_sid_force(const char *scontext, u32 scontext_len,
 				  u32 *sid);
 
-int security_get_user_sids(u32 fromsid, const char *username, u32 **sids, u32 *nel);
-
 int security_port_sid(u8 protocol, u16 port, u32 *out_sid);
 
 int security_ib_pkey_sid(u64 subnet_prefix, u16 pkey_num, u32 *out_sid);
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 3245cc531555..35aa25b03852 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -76,7 +76,6 @@ struct selinux_fs_info {
 	int *bool_pending_values;
 	struct dentry *class_dir;
 	unsigned long last_class_ino;
-	bool policy_opened;
 	unsigned long last_ino;
 	struct super_block *sb;
 };
@@ -272,35 +271,13 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
 				 size_t count, loff_t *ppos)
 
 {
-	char *page;
-	ssize_t length;
-	int new_value;
-
-	if (count >= PAGE_SIZE)
-		return -ENOMEM;
-
-	/* No partial writes. */
-	if (*ppos != 0)
-		return -EINVAL;
-
-	page = memdup_user_nul(buf, count);
-	if (IS_ERR(page))
-		return PTR_ERR(page);
-
-	if (sscanf(page, "%d", &new_value) != 1) {
-		length = -EINVAL;
-		goto out;
-	}
-	length = count;
-
-	if (new_value) {
-		pr_err("SELinux: https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-runtime-disable\n");
-		pr_err("SELinux: Runtime disable is not supported, use selinux=0 on the kernel cmdline.\n");
-	}
-
-out:
-	kfree(page);
-	return length;
+	/*
+	 * Setting disable is no longer supported, see
+	 * https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-runtime-disable
+	 */
+	pr_err_once("SELinux: %s (%d) wrote to disable. This is no longer supported.\n",
+		    current->comm, current->pid);
+	return count;
 }
 
 static const struct file_operations sel_disable_ops = {
@@ -362,44 +339,31 @@ struct policy_load_memory {
 
 static int sel_open_policy(struct inode *inode, struct file *filp)
 {
-	struct selinux_fs_info *fsi = inode->i_sb->s_fs_info;
 	struct policy_load_memory *plm = NULL;
 	int rc;
 
-	BUG_ON(filp->private_data);
-
-	mutex_lock(&selinux_state.policy_mutex);
-
 	rc = avc_has_perm(current_sid(), SECINITSID_SECURITY,
 			  SECCLASS_SECURITY, SECURITY__READ_POLICY, NULL);
 	if (rc)
-		goto err;
-
-	rc = -EBUSY;
-	if (fsi->policy_opened)
-		goto err;
+		return rc;
 
-	rc = -ENOMEM;
 	plm = kzalloc_obj(*plm);
 	if (!plm)
-		goto err;
+		return -ENOMEM;
 
+	mutex_lock(&selinux_state.policy_mutex);
 	rc = security_read_policy(&plm->data, &plm->len);
 	if (rc)
 		goto err;
-
 	if ((size_t)i_size_read(inode) != plm->len) {
 		inode_lock(inode);
 		i_size_write(inode, plm->len);
 		inode_unlock(inode);
 	}
-
-	fsi->policy_opened = 1;
+	mutex_unlock(&selinux_state.policy_mutex);
 
 	filp->private_data = plm;
 
-	mutex_unlock(&selinux_state.policy_mutex);
-
 	return 0;
 err:
 	mutex_unlock(&selinux_state.policy_mutex);
@@ -412,13 +376,8 @@ static int sel_open_policy(struct inode *inode, struct file *filp)
 
 static int sel_release_policy(struct inode *inode, struct file *filp)
 {
-	struct selinux_fs_info *fsi = inode->i_sb->s_fs_info;
 	struct policy_load_memory *plm = filp->private_data;
 
-	BUG_ON(!plm);
-
-	fsi->policy_opened = 0;
-
 	vfree(plm->data);
 	kfree(plm);
 
@@ -594,34 +553,31 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	if (!count)
 		return -EINVAL;
 
-	mutex_lock(&selinux_state.policy_mutex);
-
 	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__LOAD_POLICY, NULL);
 	if (length)
-		goto out;
+		return length;
 
 	data = vmalloc(count);
-	if (!data) {
-		length = -ENOMEM;
-		goto out;
-	}
+	if (!data)
+		return -ENOMEM;
 	if (copy_from_user(data, buf, count) != 0) {
 		length = -EFAULT;
 		goto out;
 	}
 
+	mutex_lock(&selinux_state.policy_mutex);
 	length = security_load_policy(data, count, &load_state);
 	if (length) {
 		pr_warn_ratelimited("SELinux: failed to load policy\n");
-		goto out;
+		goto out_unlock;
 	}
 	fsi = file_inode(file)->i_sb->s_fs_info;
 	length = sel_make_policy_nodes(fsi, load_state.policy);
 	if (length) {
 		pr_warn_ratelimited("SELinux: failed to initialize selinuxfs\n");
 		selinux_policy_cancel(&load_state);
-		goto out;
+		goto out_unlock;
 	}
 
 	selinux_policy_commit(&load_state);
@@ -631,8 +587,9 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 		from_kuid(&init_user_ns, audit_get_loginuid(current)),
 		audit_get_sessionid(current));
 
-out:
+out_unlock:
 	mutex_unlock(&selinux_state.policy_mutex);
+out:
 	vfree(data);
 	return length;
 }
@@ -689,46 +646,13 @@ static ssize_t sel_read_checkreqprot(struct file *filp, char __user *buf,
 static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 				      size_t count, loff_t *ppos)
 {
-	char *page;
-	ssize_t length;
-	unsigned int new_value;
-
-	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
-			      SECCLASS_SECURITY, SECURITY__SETCHECKREQPROT,
-			      NULL);
-	if (length)
-		return length;
-
-	if (count >= PAGE_SIZE)
-		return -ENOMEM;
-
-	/* No partial writes. */
-	if (*ppos != 0)
-		return -EINVAL;
-
-	page = memdup_user_nul(buf, count);
-	if (IS_ERR(page))
-		return PTR_ERR(page);
-
-	if (sscanf(page, "%u", &new_value) != 1) {
-		length = -EINVAL;
-		goto out;
-	}
-	length = count;
-
-	if (new_value) {
-		char comm[sizeof(current->comm)];
-
-		strscpy(comm, current->comm);
-		pr_err("SELinux: %s (%d) set checkreqprot to 1. This is no longer supported.\n",
-		       comm, current->pid);
-	}
-
-	selinux_ima_measure_state();
-
-out:
-	kfree(page);
-	return length;
+	/*
+	 * Setting checkreqprot is no longer supported, see
+	 * https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-checkreqprot
+	 */
+	pr_err_once("SELinux: %s (%d) wrote to checkreqprot. This is no longer supported.\n",
+		    current->comm, current->pid);
+	return count;
 }
 static const struct file_operations sel_checkreqprot_ops = {
 	.read		= sel_read_checkreqprot,
@@ -1073,69 +997,11 @@ static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
 
 static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 {
-	char *con = NULL, *user = NULL, *ptr;
-	u32 sid, *sids = NULL;
-	ssize_t length;
-	char *newcon;
-	int rc;
-	u32 i, len, nsids;
-
-	pr_warn_ratelimited("SELinux: %s (%d) wrote to /sys/fs/selinux/user!"
-		" This will not be supported in the future; please update your"
-		" userspace.\n", current->comm, current->pid);
-	ssleep(5);
-
-	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
-			      SECCLASS_SECURITY, SECURITY__COMPUTE_USER,
-			      NULL);
-	if (length)
-		goto out;
-
-	length = -ENOMEM;
-	con = kzalloc(size + 1, GFP_KERNEL);
-	if (!con)
-		goto out;
-
-	length = -ENOMEM;
-	user = kzalloc(size + 1, GFP_KERNEL);
-	if (!user)
-		goto out;
-
-	length = -EINVAL;
-	if (sscanf(buf, "%s %s", con, user) != 2)
-		goto out;
-
-	length = security_context_str_to_sid(con, &sid, GFP_KERNEL);
-	if (length)
-		goto out;
-
-	length = security_get_user_sids(sid, user, &sids, &nsids);
-	if (length)
-		goto out;
-
-	length = sprintf(buf, "%u", nsids) + 1;
-	ptr = buf + length;
-	for (i = 0; i < nsids; i++) {
-		rc = security_sid_to_context(sids[i], &newcon, &len);
-		if (rc) {
-			length = rc;
-			goto out;
-		}
-		if ((length + len) >= SIMPLE_TRANSACTION_LIMIT) {
-			kfree(newcon);
-			length = -ERANGE;
-			goto out;
-		}
-		memcpy(ptr, newcon, len);
-		kfree(newcon);
-		ptr += len;
-		length += len;
-	}
-out:
-	kfree(sids);
-	kfree(user);
-	kfree(con);
-	return length;
+	pr_err_once("SELinux: %s (%d) wrote to user. This is no longer supported.\n",
+		    current->comm, current->pid);
+	buf[0] = '0';
+	buf[1] = 0;
+	return 2;
 }
 
 static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index e8e7ccbd1e44..143021c5e326 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2746,131 +2746,6 @@ int security_node_sid(u16 domain,
 	return rc;
 }
 
-#define SIDS_NEL 25
-
-/**
- * security_get_user_sids - Obtain reachable SIDs for a user.
- * @fromsid: starting SID
- * @username: username
- * @sids: array of reachable SIDs for user
- * @nel: number of elements in @sids
- *
- * Generate the set of SIDs for legal security contexts
- * for a given user that can be reached by @fromsid.
- * Set *@sids to point to a dynamically allocated
- * array containing the set of SIDs.  Set *@nel to the
- * number of elements in the array.
- */
-
-int security_get_user_sids(u32 fromsid,
-			   const char *username,
-			   u32 **sids,
-			   u32 *nel)
-{
-	struct selinux_policy *policy;
-	struct policydb *policydb;
-	struct sidtab *sidtab;
-	struct context *fromcon, usercon;
-	u32 *mysids = NULL, *mysids2, sid;
-	u32 i, j, mynel, maxnel = SIDS_NEL;
-	struct user_datum *user;
-	struct role_datum *role;
-	struct ebitmap_node *rnode, *tnode;
-	int rc;
-
-	*sids = NULL;
-	*nel = 0;
-
-	if (!selinux_initialized())
-		return 0;
-
-	mysids = kcalloc(maxnel, sizeof(*mysids), GFP_KERNEL);
-	if (!mysids)
-		return -ENOMEM;
-
-retry:
-	mynel = 0;
-	rcu_read_lock();
-	policy = rcu_dereference(selinux_state.policy);
-	policydb = &policy->policydb;
-	sidtab = policy->sidtab;
-
-	context_init(&usercon);
-
-	rc = -EINVAL;
-	fromcon = sidtab_search(sidtab, fromsid);
-	if (!fromcon)
-		goto out_unlock;
-
-	rc = -EINVAL;
-	user = symtab_search(&policydb->p_users, username);
-	if (!user)
-		goto out_unlock;
-
-	usercon.user = user->value;
-
-	ebitmap_for_each_positive_bit(&user->roles, rnode, i) {
-		role = policydb->role_val_to_struct[i];
-		usercon.role = i + 1;
-		ebitmap_for_each_positive_bit(&role->types, tnode, j) {
-			usercon.type = j + 1;
-
-			if (mls_setup_user_range(policydb, fromcon, user,
-						 &usercon))
-				continue;
-
-			rc = sidtab_context_to_sid(sidtab, &usercon, &sid);
-			if (rc == -ESTALE) {
-				rcu_read_unlock();
-				goto retry;
-			}
-			if (rc)
-				goto out_unlock;
-			if (mynel < maxnel) {
-				mysids[mynel++] = sid;
-			} else {
-				rc = -ENOMEM;
-				maxnel += SIDS_NEL;
-				mysids2 = kcalloc(maxnel, sizeof(*mysids2), GFP_ATOMIC);
-				if (!mysids2)
-					goto out_unlock;
-				memcpy(mysids2, mysids, mynel * sizeof(*mysids2));
-				kfree(mysids);
-				mysids = mysids2;
-				mysids[mynel++] = sid;
-			}
-		}
-	}
-	rc = 0;
-out_unlock:
-	rcu_read_unlock();
-	if (rc || !mynel) {
-		kfree(mysids);
-		return rc;
-	}
-
-	rc = -ENOMEM;
-	mysids2 = kcalloc(mynel, sizeof(*mysids2), GFP_KERNEL);
-	if (!mysids2) {
-		kfree(mysids);
-		return rc;
-	}
-	for (i = 0, j = 0; i < mynel; i++) {
-		struct av_decision dummy_avd;
-		rc = avc_has_perm_noaudit(fromsid, mysids[i],
-					  SECCLASS_PROCESS, /* kernel value */
-					  PROCESS__TRANSITION, AVC_STRICT,
-					  &dummy_avd);
-		if (!rc)
-			mysids2[j++] = mysids[i];
-		cond_resched();
-	}
-	kfree(mysids);
-	*sids = mysids2;
-	*nel = j;
-	return 0;
-}
-
 /**
  * __security_genfs_sid - Helper to obtain a SID for a file in a filesystem
  * @policy: policy
diff --git a/sound/core/misc.c b/sound/core/misc.c
index 5aca09edf971..833124c8e4fa 100644
--- a/sound/core/misc.c
+++ b/sound/core/misc.c
@@ -148,9 +148,11 @@ EXPORT_SYMBOL_GPL(snd_fasync_helper);
 
 void snd_kill_fasync(struct snd_fasync *fasync, int signal, int poll)
 {
-	if (!fasync || !fasync->on)
+	if (!fasync)
 		return;
 	guard(spinlock_irqsave)(&snd_fasync_lock);
+	if (!fasync->on)
+		return;
 	fasync->signal = signal;
 	fasync->poll = poll;
 	list_move(&fasync->list, &snd_fasync_list);
@@ -163,8 +165,10 @@ void snd_fasync_free(struct snd_fasync *fasync)
 	if (!fasync)
 		return;
 
-	scoped_guard(spinlock_irq, &snd_fasync_lock)
+	scoped_guard(spinlock_irq, &snd_fasync_lock) {
+		fasync->on = 0;
 		list_del_init(&fasync->list);
+	}
 
 	flush_work(&snd_fasync_work);
 	kfree(fasync);
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index d4fd4dfc7fc3..6af26ec2ecfd 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -2149,10 +2149,16 @@ static int snd_pcm_oss_get_trigger(struct snd_pcm_oss_file *pcm_oss_file)
 
 	psubstream = pcm_oss_file->streams[SNDRV_PCM_STREAM_PLAYBACK];
 	csubstream = pcm_oss_file->streams[SNDRV_PCM_STREAM_CAPTURE];
-	if (psubstream && psubstream->runtime && psubstream->runtime->oss.trigger)
-		result |= PCM_ENABLE_OUTPUT;
-	if (csubstream && csubstream->runtime && csubstream->runtime->oss.trigger)
-		result |= PCM_ENABLE_INPUT;
+	if (psubstream && psubstream->runtime) {
+		guard(mutex)(&psubstream->runtime->oss.params_lock);
+		if (psubstream->runtime->oss.trigger)
+			result |= PCM_ENABLE_OUTPUT;
+	}
+	if (csubstream && csubstream->runtime) {
+		guard(mutex)(&csubstream->runtime->oss.params_lock);
+		if (csubstream->runtime->oss.trigger)
+			result |= PCM_ENABLE_INPUT;
+	}
 	return result;
 }
 
@@ -2826,6 +2832,17 @@ static int snd_pcm_oss_capture_ready(struct snd_pcm_substream *substream)
 						runtime->oss.period_frames;
 }
 
+static bool need_input_retrigger(struct snd_pcm_runtime *runtime)
+{
+	bool ret;
+
+	guard(mutex)(&runtime->oss.params_lock);
+	ret = runtime->oss.trigger;
+	if (ret)
+		runtime->oss.trigger = 0;
+	return ret;
+}
+
 static __poll_t snd_pcm_oss_poll(struct file *file, poll_table * wait)
 {
 	struct snd_pcm_oss_file *pcm_oss_file;
@@ -2858,11 +2875,11 @@ static __poll_t snd_pcm_oss_poll(struct file *file, poll_table * wait)
 			    snd_pcm_oss_capture_ready(csubstream))
 				mask |= EPOLLIN | EPOLLRDNORM;
 		}
-		if (ostate != SNDRV_PCM_STATE_RUNNING && runtime->oss.trigger) {
+		if (ostate != SNDRV_PCM_STATE_RUNNING &&
+		    need_input_retrigger(runtime)) {
 			struct snd_pcm_oss_file ofile;
 			memset(&ofile, 0, sizeof(ofile));
 			ofile.streams[SNDRV_PCM_STREAM_CAPTURE] = pcm_oss_file->streams[SNDRV_PCM_STREAM_CAPTURE];
-			runtime->oss.trigger = 0;
 			snd_pcm_oss_set_trigger(&ofile, PCM_ENABLE_INPUT);
 		}
 	}
diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 75a7a2af9d8c..5719637575a9 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1253,7 +1253,7 @@ static int snd_seq_ioctl_set_client_info(struct snd_seq_client *client,
 	if (client->user_pversion >= SNDRV_PROTOCOL_VERSION(1, 0, 3))
 		client->midi_version = client_info->midi_version;
 	memcpy(client->event_filter, client_info->event_filter, 32);
-	client->group_filter = client_info->group_filter;
+	client->group_filter = client_info->group_filter & SND_SEQ_GROUP_FILTER_MASK;
 
 	/* notify the change */
 	snd_seq_system_client_ev_client_change(client->number);
diff --git a/sound/core/seq/seq_clientmgr.h b/sound/core/seq/seq_clientmgr.h
index ece02c58db70..feea8bb7d987 100644
--- a/sound/core/seq/seq_clientmgr.h
+++ b/sound/core/seq/seq_clientmgr.h
@@ -14,6 +14,9 @@
 
 /* client manager */
 
+#define SND_SEQ_GROUP_FILTER_MASK	GENMASK(SNDRV_UMP_MAX_GROUPS, 0)
+#define SND_SEQ_GROUP_FILTER_GROUPS	GENMASK(SNDRV_UMP_MAX_GROUPS, 1)
+
 struct snd_seq_user_client {
 	struct file *file;	/* file struct of client */
 	/* ... */
@@ -40,7 +43,7 @@ struct snd_seq_client {
 	int number;		/* client number */
 	unsigned int filter;	/* filter flags */
 	DECLARE_BITMAP(event_filter, 256);
-	unsigned short group_filter;
+	unsigned int group_filter;
 	snd_use_lock_t use_lock;
 	int event_lost;
 	/* ports */
diff --git a/sound/core/seq/seq_ump_client.c b/sound/core/seq/seq_ump_client.c
index fdc76f23e03f..9079ccfdc866 100644
--- a/sound/core/seq/seq_ump_client.c
+++ b/sound/core/seq/seq_ump_client.c
@@ -369,7 +369,7 @@ static void setup_client_group_filter(struct seq_ump_client *client)
 	cptr = snd_seq_kernel_client_get(client->seq_client);
 	if (!cptr)
 		return;
-	filter = ~(1U << 0); /* always allow groupless messages */
+	filter = SND_SEQ_GROUP_FILTER_GROUPS; /* always allow groupless messages */
 	for (p = 0; p < SNDRV_UMP_MAX_GROUPS; p++) {
 		if (client->ump->groups[p].active)
 			filter &= ~(1U << (p + 1));
diff --git a/sound/firewire/tascam/tascam-hwdep.c b/sound/firewire/tascam/tascam-hwdep.c
index 867b4ea1096e..6270263e7bf4 100644
--- a/sound/firewire/tascam/tascam-hwdep.c
+++ b/sound/firewire/tascam/tascam-hwdep.c
@@ -73,6 +73,7 @@ static long tscm_hwdep_read_queue(struct snd_tscm *tscm, char __user *buf,
 			length = rounddown(remained, sizeof(*entries));
 		if (length == 0)
 			break;
+		tail_pos = head_pos + length / sizeof(*entries);
 
 		spin_unlock_irq(&tscm->lock);
 		if (copy_to_user(pos, &entries[head_pos], length))
diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 3c02f50626ed..ded6e78142a0 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -3397,6 +3397,19 @@ static void alc256_fixup_mic_no_presence_and_resume(struct hda_codec *codec,
 	}
 }
 
+static void alc256_fixup_xiaomi_pro15_resume(struct hda_codec *codec,
+					     const struct hda_fixup *fix,
+					     int action)
+{
+	/*
+	 * On the Xiaomi Mi Laptop Pro 15 (TM1905, SSID 1d72:1905) the ALC256
+	 * codec sets coefficient 0x10 bit 9 to 1 after S3 resume, silencing
+	 * the internal speaker. Bluetooth and HDMI audio are unaffected.
+	 * Clear the bit so the speaker keeps working across suspend cycles.
+	 */
+	alc_update_coef_idx(codec, 0x10, 1<<9, 0);
+}
+
 static void alc256_decrease_headphone_amp_val(struct hda_codec *codec,
 					      const struct hda_fixup *fix, int action)
 {
@@ -4054,6 +4067,7 @@ enum {
 	ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
 	ALC233_FIXUP_NO_AUDIO_JACK,
 	ALC256_FIXUP_MIC_NO_PRESENCE_AND_RESUME,
+	ALC256_FIXUP_XIAOMI_PRO15_RESUME,
 	ALC285_FIXUP_LEGION_Y9000X_SPEAKERS,
 	ALC285_FIXUP_LEGION_Y9000X_AUTOMUTE,
 	ALC287_FIXUP_LEGION_16ACHG6,
@@ -6241,6 +6255,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
 	},
+	[ALC256_FIXUP_XIAOMI_PRO15_RESUME] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc256_fixup_xiaomi_pro15_resume,
+	},
 	[ALC287_FIXUP_LEGION_16ACHG6] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc287_fixup_legion_16achg6_speakers,
@@ -7751,6 +7769,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d72, 0x1602, "RedmiBook", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1701, "XiaomiNotebook Pro", ALC298_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1d72, 0x1901, "RedmiBook 14", ALC256_FIXUP_ASUS_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1d72, 0x1905, "Xiaomi Mi Laptop Pro 15", ALC256_FIXUP_XIAOMI_PRO15_RESUME),
 	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1e39, 0xca14, "MEDION NM14LNL", ALC233_FIXUP_MEDION_MTL_SPK),
diff --git a/sound/hda/codecs/side-codecs/cs35l56_hda.c b/sound/hda/codecs/side-codecs/cs35l56_hda.c
index 1ace4beef508..dc25960a4f23 100644
--- a/sound/hda/codecs/side-codecs/cs35l56_hda.c
+++ b/sound/hda/codecs/side-codecs/cs35l56_hda.c
@@ -180,11 +180,15 @@ static int cs35l56_hda_mixer_get(struct snd_kcontrol *kcontrol,
 {
 	struct cs35l56_hda *cs35l56 = snd_kcontrol_chip(kcontrol);
 	unsigned int reg_val;
-	int i;
+	int i, ret;
 
 	cs35l56_hda_wait_dsp_ready(cs35l56);
 
-	regmap_read(cs35l56->base.regmap, kcontrol->private_value, &reg_val);
+	ret = regmap_read(cs35l56->base.regmap, kcontrol->private_value,
+			  &reg_val);
+	if (ret)
+		return ret;
+
 	reg_val &= CS35L56_ASP_TXn_SRC_MASK;
 
 	for (i = 0; i < CS35L56_NUM_INPUT_SRC; ++i) {
@@ -203,15 +207,20 @@ static int cs35l56_hda_mixer_put(struct snd_kcontrol *kcontrol,
 	struct cs35l56_hda *cs35l56 = snd_kcontrol_chip(kcontrol);
 	unsigned int item = ucontrol->value.enumerated.item[0];
 	bool changed;
+	int ret;
 
 	if (item >= CS35L56_NUM_INPUT_SRC)
 		return -EINVAL;
 
 	cs35l56_hda_wait_dsp_ready(cs35l56);
 
-	regmap_update_bits_check(cs35l56->base.regmap, kcontrol->private_value,
-				 CS35L56_INPUT_MASK, cs35l56_tx_input_values[item],
-				 &changed);
+	ret = regmap_update_bits_check(cs35l56->base.regmap,
+				       kcontrol->private_value,
+				       CS35L56_INPUT_MASK,
+				       cs35l56_tx_input_values[item],
+				       &changed);
+	if (ret)
+		return ret;
 
 	return changed;
 }
diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index aa6200933182..2f7a51d7eb11 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -52,6 +52,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP Laptop 15-fc0xxx"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "OMEN Gaming Laptop 16-ap0xxx"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
@@ -654,6 +661,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8EE4"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8E35"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
diff --git a/sound/soc/codecs/es8389.c b/sound/soc/codecs/es8389.c
index 8d418cae371a..449d9574b03a 100644
--- a/sound/soc/codecs/es8389.c
+++ b/sound/soc/codecs/es8389.c
@@ -892,7 +892,7 @@ static int es8389_probe(struct snd_soc_component *component)
 		return ret;
 	}
 
-	es8389->mclk = devm_clk_get(component->dev, "mclk");
+	es8389->mclk = devm_clk_get_optional(component->dev, "mclk");
 	if (IS_ERR(es8389->mclk))
 		return dev_err_probe(component->dev, PTR_ERR(es8389->mclk),
 			"ES8389 is unable to get mclk\n");
diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index 6c56134c60cc..599e439b359a 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -1286,7 +1286,7 @@ static int fsl_easrc_request_context(int channels, struct fsl_asrc_pair *ctx)
 /*
  * Release the context
  *
- * This funciton is mainly doing the revert thing in request context
+ * This function is mainly doing the revert thing in request context
  */
 static void fsl_easrc_release_context(struct fsl_asrc_pair *ctx)
 {
diff --git a/sound/soc/intel/boards/bytcr_wm5102.c b/sound/soc/intel/boards/bytcr_wm5102.c
index 4879f79aef29..4aa0cf49b033 100644
--- a/sound/soc/intel/boards/bytcr_wm5102.c
+++ b/sound/soc/intel/boards/bytcr_wm5102.c
@@ -170,6 +170,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 		ret = byt_wm5102_prepare_and_enable_pll1(codec_dai, 48000);
 		if (ret) {
 			dev_err(card->dev, "Error setting codec sysclk: %d\n", ret);
+			clk_disable_unprepare(priv->mclk);
 			return ret;
 		}
 	} else {
diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index 168c166c960d..fd4f24ff1eac 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -317,6 +317,7 @@ static int q6apm_dai_trigger(struct snd_soc_component *component,
 	case SNDRV_PCM_TRIGGER_STOP:
 		/* TODO support be handled via SoftPause Module */
 		prtd->state = Q6APM_STREAM_STOPPED;
+		prtd->queue_ptr = 0;
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
diff --git a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
index 5be37eeea329..ba64117b8cfe 100644
--- a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
+++ b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
@@ -181,7 +181,7 @@ static int q6apm_lpass_dai_prepare(struct snd_pcm_substream *substream, struct s
 	 * It is recommend to load DSP with source graph first and then sink
 	 * graph, so sequence for playback and capture will be different
 	 */
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK && dai_data->graph[dai->id] == NULL) {
 		graph = q6apm_graph_open(dai->dev, NULL, dai->dev, graph_id);
 		if (IS_ERR(graph)) {
 			dev_err(dai->dev, "Failed to open graph (%d)\n", graph_id);
diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 069048db5367..5751e80b3b92 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -215,6 +215,8 @@ int q6apm_map_memory_regions(struct q6apm_graph *graph, unsigned int dir, phys_a
 
 	mutex_lock(&graph->lock);
 
+	data->dsp_buf = 0;
+
 	if (data->buf) {
 		mutex_unlock(&graph->lock);
 		return 0;
@@ -762,6 +764,7 @@ static int apm_probe(gpr_device_t *gdev)
 
 static void apm_remove(gpr_device_t *gdev)
 {
+	of_platform_depopulate(&gdev->dev);
 	snd_soc_unregister_component(&gdev->dev);
 }
 
diff --git a/sound/soc/sof/compress.c b/sound/soc/sof/compress.c
index 96570121aae0..90f056eae1c3 100644
--- a/sound/soc/sof/compress.c
+++ b/sound/soc/sof/compress.c
@@ -379,6 +379,9 @@ static int sof_compr_pointer(struct snd_soc_component *component,
 	if (!spcm)
 		return -EINVAL;
 
+	if (!sstream->channels || !sstream->sample_container_bytes)
+		return -EBUSY;
+
 	tstamp->sampling_rate = sstream->sampling_rate;
 	tstamp->copied_total = sstream->copied_total;
 	tstamp->pcm_io_frames = div_u64(spcm->stream[cstream->direction].posn.dai_posn,
diff --git a/sound/usb/midi2.c b/sound/usb/midi2.c
index ef602e81576d..d700022f3cf8 100644
--- a/sound/usb/midi2.c
+++ b/sound/usb/midi2.c
@@ -227,7 +227,7 @@ static void kill_midi_urbs(struct snd_usb_midi2_endpoint *ep, bool suspending)
 	if (!ep)
 		return;
 	if (suspending)
-		ep->suspended = ep->running;
+		atomic_set(&ep->suspended, atomic_read(&ep->running));
 	atomic_set(&ep->running, 0);
 	for (i = 0; i < ep->num_urbs; i++) {
 		if (!ep->urbs[i].urb)
@@ -1190,10 +1190,11 @@ void snd_usb_midi_v2_suspend_all(struct snd_usb_audio *chip)
 
 static void resume_midi2_endpoint(struct snd_usb_midi2_endpoint *ep)
 {
-	ep->running = ep->suspended;
-	if (ep->direction == STR_IN)
+	atomic_set(&ep->running, atomic_read(&ep->suspended));
+	atomic_set(&ep->suspended, 0);
+
+	if (ep->direction == STR_IN || atomic_read(&ep->running))
 		submit_io_urbs(ep);
-	/* FIXME: does it all? */
 }
 
 void snd_usb_midi_v2_resume_all(struct snd_usb_audio *chip)
diff --git a/sound/usb/misc/ua101.c b/sound/usb/misc/ua101.c
index 49b3dd8d827d..d129b42eb979 100644
--- a/sound/usb/misc/ua101.c
+++ b/sound/usb/misc/ua101.c
@@ -974,6 +974,13 @@ static int detect_usb_format(struct ua101 *ua)
 
 	ua->capture.channels = fmt_capture->bNrChannels;
 	ua->playback.channels = fmt_playback->bNrChannels;
+	if (!ua->capture.channels || !ua->playback.channels) {
+		dev_err(&ua->dev->dev,
+			"invalid channel count: capture %u, playback %u\n",
+			ua->capture.channels, ua->playback.channels);
+		return -EINVAL;
+	}
+
 	ua->capture.frame_bytes =
 		fmt_capture->bSubframeSize * ua->capture.channels;
 	ua->playback.frame_bytes =
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index d38c39e28f38..b07e2ec661c1 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -352,6 +352,8 @@ snd_pcm_chmap_elem *convert_chmap_v3(struct uac3_cluster_header_descriptor
 		if (len < sizeof(*cs_desc))
 			break;
 		cs_len = le16_to_cpu(cs_desc->wLength);
+		if (cs_len < sizeof(*cs_desc))
+			break;
 		if (len < cs_len)
 			break;
 		cs_type = cs_desc->bSegmentType;
@@ -995,7 +997,7 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
 	 * and request Cluster Descriptor
 	 */
 	wLength = le16_to_cpu(hc_header.wLength);
-	if (wLength < sizeof(cluster))
+	if (wLength < sizeof(*cluster))
 		return NULL;
 	cluster = kzalloc(wLength, GFP_KERNEL);
 	if (!cluster)
diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 6673601246b3..eff29645719b 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -793,9 +793,10 @@
 #define MSR_AMD64_LBR_SELECT			0xc000010e
 
 /* Zen4 */
-#define MSR_ZEN4_BP_CFG                 0xc001102e
+#define MSR_ZEN4_BP_CFG			0xc001102e
 #define MSR_ZEN4_BP_CFG_BP_SPEC_REDUCE_BIT 4
 #define MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT 5
+#define MSR_ZEN2_BP_CFG_BUG_FIX_BIT	33
 
 /* Fam 19h MSRs */
 #define MSR_F19H_UMC_PERF_CTL           0xc0010800
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 5fea7e7df628..989a5975dcea 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -474,20 +474,24 @@ mptcp_lib_wait_local_port_listen() {
 	wait_local_port_listen "${@}" "tcp"
 }
 
+# $1: error file, $2: cmd, $3: expected msg, [$4: expected error]
 mptcp_lib_check_output() {
 	local err="${1}"
 	local cmd="${2}"
 	local expected="${3}"
+	local exp_error="${4:-0}"
 	local cmd_ret=0
 	local out
 
-	if ! out=$(${cmd} 2>"${err}"); then
-		cmd_ret=${?}
-	fi
+	out=$(${cmd} 2>"${err}") || cmd_ret=1
 
-	if [ ${cmd_ret} -ne 0 ]; then
-		mptcp_lib_pr_fail "command execution '${cmd}' stderr"
-		cat "${err}"
+	if [ "${cmd_ret}" != "${exp_error}" ]; then
+		mptcp_lib_pr_fail "unexpected returned code for '${cmd}', info:"
+		if [ "${exp_error}" = 0 ]; then
+			cat "${err}"
+		else
+			echo "${out}"
+		fi
 		return 2
 	elif [ "${out}" = "${expected}" ]; then
 		return 0
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 123d9d7a0278..04594dfc22b1 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -122,10 +122,12 @@ check()
 	local cmd="$1"
 	local expected="$2"
 	local msg="$3"
+	local exp_error="$4"
 	local rc=0
 
 	mptcp_lib_print_title "$msg"
-	mptcp_lib_check_output "${err}" "${cmd}" "${expected}" || rc=${?}
+	mptcp_lib_check_output "${err}" "${cmd}" "${expected}" "${exp_error}" ||
+		rc=${?}
 	if [ ${rc} -eq 2 ]; then
 		mptcp_lib_result_fail "${msg} # error ${rc}"
 		ret=${KSFT_FAIL}
@@ -158,13 +160,13 @@ check "show_endpoints" \
 			    "3,10.0.1.3,signal backup")" "dump addrs"
 
 del_endpoint 2
-check "get_endpoint 2" "" "simple del addr"
+check "get_endpoint 2" "" "simple del addr" 1
 check "show_endpoints" \
 	"$(format_endpoints "1,10.0.1.1" \
 			    "3,10.0.1.3,signal backup")" "dump addrs after del"
 
 add_endpoint 10.0.1.3 2>/dev/null
-check "get_endpoint 4" "" "duplicate addr"
+check "get_endpoint 4" "" "duplicate addr" 1
 
 add_endpoint 10.0.1.4 flags signal
 check "get_endpoint 4" "$(format_endpoints "4,10.0.1.4,signal")" "id addr increment"
@@ -173,7 +175,7 @@ for i in $(seq 5 9); do
 	add_endpoint "10.0.1.${i}" flags signal >/dev/null 2>&1
 done
 check "get_endpoint 9" "$(format_endpoints "9,10.0.1.9,signal")" "hard addr limit"
-check "get_endpoint 10" "" "above hard addr limit"
+check "get_endpoint 10" "" "above hard addr limit" 1
 
 del_endpoint 9
 for i in $(seq 10 255); do
@@ -192,9 +194,13 @@ check "show_endpoints" \
 flush_endpoint
 check "show_endpoints" "" "flush addrs"
 
-add_endpoint 10.0.1.1 flags unknown
-check "show_endpoints" "$(format_endpoints "1,10.0.1.1")" "ignore unknown flags"
-flush_endpoint
+# "unknown" flag is only supported by pm_nl_ctl
+if ! mptcp_lib_is_ip_mptcp; then
+	add_endpoint 10.0.1.1 flags unknown
+	check "show_endpoints" "$(format_endpoints "1,10.0.1.1")" \
+	      "ignore unknown flags"
+	flush_endpoint
+fi
 
 set_limits 9 1 2>/dev/null
 check "get_limits" "${default_limits}" "rcv addrs above hard limit"
diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index 4ef90823b652..50d69e22ee7a 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -14,14 +14,20 @@ LDLIBS += -lpthread -ldl
 # still track changes to header files and depend on shared object.
 OVERRIDE_TARGETS = 1
 
-TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test param_test \
-		param_test_benchmark param_test_compare_twice param_test_mm_cid \
-		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice \
-		syscall_errors_test slice_test
+TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test \
+		 param_test_benchmark param_test_mm_cid_benchmark
 
-TEST_GEN_PROGS_EXTENDED = librseq.so
+TEST_GEN_PROGS_EXTENDED = librseq.so \
+	param_test \
+	param_test_compare_twice \
+	param_test_mm_cid \
+	param_test_mm_cid_compare_twice \
+	syscall_errors_test \
+	legacy_check \
+	slice_test \
+	check_optimized
 
-TEST_PROGS = run_param_test.sh run_syscall_errors_test.sh
+TEST_PROGS = run_param_test.sh run_syscall_errors_test.sh run_legacy_check.sh run_timeslice_test.sh
 
 TEST_FILES := settings
 
@@ -62,3 +68,6 @@ $(OUTPUT)/syscall_errors_test: syscall_errors_test.c $(TEST_GEN_PROGS_EXTENDED)
 
 $(OUTPUT)/slice_test: slice_test.c $(TEST_GEN_PROGS_EXTENDED) rseq.h rseq-*.h
 	$(CC) $(CFLAGS) $< $(LDLIBS) -lrseq -o $@
+
+$(OUTPUT)/check_optimized: check_optimized.c $(TEST_GEN_PROGS_EXTENDED) rseq.h rseq-*.h
+	$(CC) $(CFLAGS) $< $(LDLIBS) -lrseq -o $@
diff --git a/tools/testing/selftests/rseq/check_optimized.c b/tools/testing/selftests/rseq/check_optimized.c
new file mode 100644
index 000000000000..a13e3f2c8fc6
--- /dev/null
+++ b/tools/testing/selftests/rseq/check_optimized.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: LGPL-2.1
+#define _GNU_SOURCE
+#include <assert.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/time.h>
+
+#include "rseq.h"
+
+int main(int argc, char **argv)
+{
+	if (__rseq_register_current_thread(true, false))
+		return -1;
+	return 0;
+}
diff --git a/tools/testing/selftests/rseq/legacy_check.c b/tools/testing/selftests/rseq/legacy_check.c
new file mode 100644
index 000000000000..3f7de4e28303
--- /dev/null
+++ b/tools/testing/selftests/rseq/legacy_check.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+
+#include <errno.h>
+#include <signal.h>
+#include <stdint.h>
+#include <unistd.h>
+
+#include "rseq.h"
+
+#include "../kselftest_harness.h"
+
+FIXTURE(legacy)
+{
+};
+
+static int cpu_id_in_sigfn = -1;
+
+static void sigfn(int sig)
+{
+	struct rseq_abi *rs = rseq_get_abi();
+
+	cpu_id_in_sigfn = rs->cpu_id_start;
+}
+
+FIXTURE_SETUP(legacy)
+{
+	int res = __rseq_register_current_thread(true, true);
+
+	switch (res) {
+	case -ENOSYS:
+		SKIP(return, "RSEQ not enabled\n");
+	case -EBUSY:
+		SKIP(return, "GLIBC owns RSEQ. Disable GLIBC RSEQ registration\n");
+	default:
+		ASSERT_EQ(res, 0);
+	}
+
+	ASSERT_NE(signal(SIGUSR1, sigfn), SIG_ERR);
+}
+
+FIXTURE_TEARDOWN(legacy)
+{
+}
+
+TEST_F(legacy, legacy_test)
+{
+	struct rseq_abi *rs = rseq_get_abi();
+
+	ASSERT_NE(rs, NULL);
+
+	/* Overwrite rs::cpu_id_start */
+	rs->cpu_id_start = -1;
+	sleep(1);
+	ASSERT_NE(rs->cpu_id_start, -1);
+
+	rs->cpu_id_start = -1;
+	ASSERT_EQ(raise(SIGUSR1), 0);
+	ASSERT_NE(rs->cpu_id_start, -1);
+	ASSERT_NE(cpu_id_in_sigfn, -1);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index 05d03e679e06..e1e98dbabe4b 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -38,7 +38,7 @@ static int opt_modulo, verbose;
 static int opt_yield, opt_signal, opt_sleep,
 		opt_disable_rseq, opt_threads = 200,
 		opt_disable_mod = 0, opt_test = 's';
-
+static bool opt_rseq_legacy;
 static long long opt_reps = 5000;
 
 static __thread __attribute__((tls_model("initial-exec")))
@@ -281,9 +281,12 @@ unsigned int yield_mod_cnt, nr_abort;
 	} \
 }
 
+#define rseq_no_glibc			true
+
 #else
 
 #define printf_verbose(fmt, ...)
+#define rseq_no_glibc			false
 
 #endif /* BENCHMARK */
 
@@ -481,7 +484,7 @@ void *test_percpu_spinlock_thread(void *arg)
 	long long i, reps;
 
 	if (!opt_disable_rseq && thread_data->reg &&
-	    rseq_register_current_thread())
+	    __rseq_register_current_thread(rseq_no_glibc, opt_rseq_legacy))
 		abort();
 	reps = thread_data->reps;
 	for (i = 0; i < reps; i++) {
@@ -558,7 +561,7 @@ void *test_percpu_inc_thread(void *arg)
 	long long i, reps;
 
 	if (!opt_disable_rseq && thread_data->reg &&
-	    rseq_register_current_thread())
+	    __rseq_register_current_thread(rseq_no_glibc, opt_rseq_legacy))
 		abort();
 	reps = thread_data->reps;
 	for (i = 0; i < reps; i++) {
@@ -712,7 +715,7 @@ void *test_percpu_list_thread(void *arg)
 	long long i, reps;
 	struct percpu_list *list = (struct percpu_list *)arg;
 
-	if (!opt_disable_rseq && rseq_register_current_thread())
+	if (!opt_disable_rseq && __rseq_register_current_thread(rseq_no_glibc, opt_rseq_legacy))
 		abort();
 
 	reps = opt_reps;
@@ -895,7 +898,7 @@ void *test_percpu_buffer_thread(void *arg)
 	long long i, reps;
 	struct percpu_buffer *buffer = (struct percpu_buffer *)arg;
 
-	if (!opt_disable_rseq && rseq_register_current_thread())
+	if (!opt_disable_rseq && __rseq_register_current_thread(rseq_no_glibc, opt_rseq_legacy))
 		abort();
 
 	reps = opt_reps;
@@ -1105,7 +1108,7 @@ void *test_percpu_memcpy_buffer_thread(void *arg)
 	long long i, reps;
 	struct percpu_memcpy_buffer *buffer = (struct percpu_memcpy_buffer *)arg;
 
-	if (!opt_disable_rseq && rseq_register_current_thread())
+	if (!opt_disable_rseq && __rseq_register_current_thread(rseq_no_glibc, opt_rseq_legacy))
 		abort();
 
 	reps = opt_reps;
@@ -1258,7 +1261,7 @@ void *test_membarrier_worker_thread(void *arg)
 	const int iters = opt_reps;
 	int i;
 
-	if (rseq_register_current_thread()) {
+	if (__rseq_register_current_thread(rseq_no_glibc, opt_rseq_legacy)) {
 		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n",
 			errno, strerror(errno));
 		abort();
@@ -1323,7 +1326,7 @@ void *test_membarrier_manager_thread(void *arg)
 	intptr_t expect_a = 0, expect_b = 0;
 	int cpu_a = 0, cpu_b = 0;
 
-	if (rseq_register_current_thread()) {
+	if (__rseq_register_current_thread(rseq_no_glibc, opt_rseq_legacy)) {
 		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n",
 			errno, strerror(errno));
 		abort();
@@ -1475,6 +1478,7 @@ static void show_usage(int argc, char **argv)
 	printf("	[-D M] Disable rseq for each M threads\n");
 	printf("	[-T test] Choose test: (s)pinlock, (l)ist, (b)uffer, (m)emcpy, (i)ncrement, membarrie(r)\n");
 	printf("	[-M] Push into buffer and memcpy buffer with memory barriers.\n");
+	printf("	[-O] Test with optimized RSEQ\n");
 	printf("	[-v] Verbose output.\n");
 	printf("	[-h] Show this help.\n");
 	printf("\n");
@@ -1602,6 +1606,9 @@ int main(int argc, char **argv)
 		case 'M':
 			opt_mo = RSEQ_MO_RELEASE;
 			break;
+		case 'L':
+			opt_rseq_legacy = true;
+			break;
 		default:
 			show_usage(argc, argv);
 			goto error;
@@ -1618,7 +1625,7 @@ int main(int argc, char **argv)
 	if (set_signal_handler())
 		goto error;
 
-	if (!opt_disable_rseq && rseq_register_current_thread())
+	if (!opt_disable_rseq && __rseq_register_current_thread(rseq_no_glibc, opt_rseq_legacy))
 		goto error;
 	if (!opt_disable_rseq && !rseq_validate_cpu_id()) {
 		fprintf(stderr, "Error: cpu id getter unavailable\n");
diff --git a/tools/testing/selftests/rseq/rseq-abi.h b/tools/testing/selftests/rseq/rseq-abi.h
index ecef315204b2..5f4ea2152c2f 100644
--- a/tools/testing/selftests/rseq/rseq-abi.h
+++ b/tools/testing/selftests/rseq/rseq-abi.h
@@ -191,10 +191,15 @@ struct rseq_abi {
 	 */
 	struct rseq_abi_slice_ctrl slice_ctrl;
 
+	/*
+	 * Place holder to push the size above 32 bytes.
+	 */
+	__u8 __reserved;
+
 	/*
 	 * Flexible array member at end of structure, after last feature field.
 	 */
 	char end[];
-} __attribute__((aligned(4 * sizeof(__u64))));
+} __attribute__((aligned(256)));
 
 #endif /* _RSEQ_ABI_H */
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index a736727b83c1..be0d0a97031e 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -56,6 +56,7 @@ ptrdiff_t rseq_offset;
  * unsuccessful.
  */
 unsigned int rseq_size = -1U;
+static unsigned int rseq_alloc_size;
 
 /* Flags used during rseq registration.  */
 unsigned int rseq_flags;
@@ -115,29 +116,17 @@ bool rseq_available(void)
 	}
 }
 
-/* The rseq areas need to be at least 32 bytes. */
-static
-unsigned int get_rseq_min_alloc_size(void)
-{
-	unsigned int alloc_size = rseq_size;
-
-	if (alloc_size < ORIG_RSEQ_ALLOC_SIZE)
-		alloc_size = ORIG_RSEQ_ALLOC_SIZE;
-	return alloc_size;
-}
-
 /*
  * Return the feature size supported by the kernel.
  *
  * Depending on the value returned by getauxval(AT_RSEQ_FEATURE_SIZE):
  *
- * 0:   Return ORIG_RSEQ_FEATURE_SIZE (20)
+ *   0: Return ORIG_RSEQ_FEATURE_SIZE (20)
  * > 0: Return the value from getauxval(AT_RSEQ_FEATURE_SIZE).
  *
  * It should never return a value below ORIG_RSEQ_FEATURE_SIZE.
  */
-static
-unsigned int get_rseq_kernel_feature_size(void)
+static unsigned int get_rseq_kernel_feature_size(void)
 {
 	unsigned long auxv_rseq_feature_size, auxv_rseq_align;
 
@@ -152,15 +141,24 @@ unsigned int get_rseq_kernel_feature_size(void)
 		return ORIG_RSEQ_FEATURE_SIZE;
 }
 
-int rseq_register_current_thread(void)
+int __rseq_register_current_thread(bool nolibc, bool legacy)
 {
+	unsigned int size;
 	int rc;
 
 	if (!rseq_ownership) {
 		/* Treat libc's ownership as a successful registration. */
-		return 0;
+		return nolibc ? -EBUSY : 0;
 	}
-	rc = sys_rseq(&__rseq.abi, get_rseq_min_alloc_size(), 0, RSEQ_SIG);
+
+	/* The minimal allocation size is 32, which is the legacy allocation size */
+	size = get_rseq_kernel_feature_size();
+	if (legacy || size < ORIG_RSEQ_ALLOC_SIZE)
+		rseq_alloc_size = ORIG_RSEQ_ALLOC_SIZE;
+	else
+		rseq_alloc_size = size;
+
+	rc = sys_rseq(&__rseq.abi, rseq_alloc_size, 0, RSEQ_SIG);
 	if (rc) {
 		/*
 		 * After at least one thread has registered successfully
@@ -179,9 +177,8 @@ int rseq_register_current_thread(void)
 	 * The first thread to register sets the rseq_size to mimic the libc
 	 * behavior.
 	 */
-	if (RSEQ_READ_ONCE(rseq_size) == 0) {
-		RSEQ_WRITE_ONCE(rseq_size, get_rseq_kernel_feature_size());
-	}
+	if (RSEQ_READ_ONCE(rseq_size) == 0)
+		RSEQ_WRITE_ONCE(rseq_size, size);
 
 	return 0;
 }
@@ -194,7 +191,7 @@ int rseq_unregister_current_thread(void)
 		/* Treat libc's ownership as a successful unregistration. */
 		return 0;
 	}
-	rc = sys_rseq(&__rseq.abi, get_rseq_min_alloc_size(), RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG);
+	rc = sys_rseq(&__rseq.abi, rseq_alloc_size, RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG);
 	if (rc)
 		return -1;
 	return 0;
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index f51a5fdb0444..c62ebb9290c0 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -8,6 +8,7 @@
 #ifndef RSEQ_H
 #define RSEQ_H
 
+#include <assert.h>
 #include <stdint.h>
 #include <stdbool.h>
 #include <pthread.h>
@@ -142,7 +143,12 @@ static inline struct rseq_abi *rseq_get_abi(void)
  * succeed. A restartable sequence executed from a non-registered
  * thread will always fail.
  */
-int rseq_register_current_thread(void);
+int __rseq_register_current_thread(bool nolibc, bool legacy);
+
+static inline int rseq_register_current_thread(void)
+{
+	return __rseq_register_current_thread(false, false);
+}
 
 /*
  * Unregister rseq for current thread.
diff --git a/tools/testing/selftests/rseq/run_legacy_check.sh b/tools/testing/selftests/rseq/run_legacy_check.sh
new file mode 100755
index 000000000000..5577b46ea092
--- /dev/null
+++ b/tools/testing/selftests/rseq/run_legacy_check.sh
@@ -0,0 +1,4 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+GLIBC_TUNABLES="${GLIBC_TUNABLES:-}:glibc.pthread.rseq=0" ./legacy_check
diff --git a/tools/testing/selftests/rseq/run_param_test.sh b/tools/testing/selftests/rseq/run_param_test.sh
index 8d31426ab41f..69a3fa049929 100755
--- a/tools/testing/selftests/rseq/run_param_test.sh
+++ b/tools/testing/selftests/rseq/run_param_test.sh
@@ -34,6 +34,11 @@ REPS=1000
 SLOW_REPS=100
 NR_THREADS=$((6*${NR_CPUS}))
 
+# Prevent GLIBC from registering RSEQ so the selftest can run in legacy and
+# performance optimized mode.
+GLIBC_TUNABLES="${GLIBC_TUNABLES:-}:glibc.pthread.rseq=0"
+export GLIBC_TUNABLES
+
 function do_tests()
 {
 	local i=0
@@ -103,6 +108,40 @@ function inject_blocking()
 	NR_LOOPS=
 }
 
+echo "Testing in legacy RSEQ mode"
+echo "Yield injection (25%)"
+inject_blocking -m 4 -y -L
+
+echo "Yield injection (50%)"
+inject_blocking -m 2 -y -L
+
+echo "Yield injection (100%)"
+inject_blocking -m 1 -y -L
+
+echo "Kill injection (25%)"
+inject_blocking -m 4 -k -L
+
+echo "Kill injection (50%)"
+inject_blocking -m 2 -k -L
+
+echo "Kill injection (100%)"
+inject_blocking -m 1 -k -L
+
+echo "Sleep injection (1ms, 25%)"
+inject_blocking -m 4 -s 1 -L
+
+echo "Sleep injection (1ms, 50%)"
+inject_blocking -m 2 -s 1 -L
+
+echo "Sleep injection (1ms, 100%)"
+inject_blocking -m 1 -s 1 -L
+
+./check_optimized || {
+    echo "Skipping optimized RSEQ mode test. Not supported";
+    exit 0
+}
+
+echo "Testing in optimized RSEQ mode"
 echo "Yield injection (25%)"
 inject_blocking -m 4 -y
 
diff --git a/tools/testing/selftests/rseq/run_timeslice_test.sh b/tools/testing/selftests/rseq/run_timeslice_test.sh
new file mode 100755
index 000000000000..551ebed71ec6
--- /dev/null
+++ b/tools/testing/selftests/rseq/run_timeslice_test.sh
@@ -0,0 +1,14 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+
+# Prevent GLIBC from registering RSEQ so the selftest can run in legacy
+# and performance optimized mode.
+GLIBC_TUNABLES="${GLIBC_TUNABLES:-}:glibc.pthread.rseq=0"
+export GLIBC_TUNABLES
+
+./check_optimized || {
+    echo "Skipping optimized RSEQ mode test. Not supported";
+    exit 0
+}
+
+./slice_test
diff --git a/tools/testing/selftests/rseq/slice_test.c b/tools/testing/selftests/rseq/slice_test.c
index 357122dcb487..e402d4440bc2 100644
--- a/tools/testing/selftests/rseq/slice_test.c
+++ b/tools/testing/selftests/rseq/slice_test.c
@@ -124,6 +124,13 @@ FIXTURE_SETUP(slice_ext)
 {
 	cpu_set_t affinity;
 
+	if (__rseq_register_current_thread(true, false))
+		SKIP(return, "RSEQ not supported\n");
+
+	if (prctl(PR_RSEQ_SLICE_EXTENSION, PR_RSEQ_SLICE_EXTENSION_SET,
+		  PR_RSEQ_SLICE_EXT_ENABLE, 0, 0))
+		SKIP(return, "Time slice extension not supported\n");
+
 	ASSERT_EQ(sched_getaffinity(0, sizeof(affinity), &affinity), 0);
 
 	/* Pin it on a single CPU. Avoid CPU 0 */
@@ -137,11 +144,6 @@ FIXTURE_SETUP(slice_ext)
 		break;
 	}
 
-	ASSERT_EQ(rseq_register_current_thread(), 0);
-
-	ASSERT_EQ(prctl(PR_RSEQ_SLICE_EXTENSION, PR_RSEQ_SLICE_EXTENSION_SET,
-			PR_RSEQ_SLICE_EXT_ENABLE, 0, 0), 0);
-
 	self->noise_params.noise_nsecs = variant->noise_nsecs;
 	self->noise_params.sleep_nsecs = variant->sleep_nsecs;
 	self->noise_params.run = 1;

