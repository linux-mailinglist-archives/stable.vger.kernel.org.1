Return-Path: <stable+bounces-260037-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9QjuDTUNIGp0vAAAu9opvQ
	(envelope-from <stable+bounces-260037-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 13:17:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82424636F20
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 13:17:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=bCqKrG9F;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260037-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260037-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 453CF3169AFF
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 11:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FCC38D3EA;
	Wed,  3 Jun 2026 11:06:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1F8425CFF
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 11:06:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484816; cv=none; b=aJOZpFwO68e9pus2S0rj1pfNEo+/zu+jlWzifJTd1rNLvk9cFAAbQskAtAufDneGEUa1NK0RLf6Uqsktp4TkONJrDJSDSsHsU7/AlqtTbgcg6w21HZlFbOvlYskWfUWde0C55TS7l/Xu/nFIFnPKBnsegjkc2X2B1oosA/RutJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484816; c=relaxed/simple;
	bh=dwKF6asnI4Nz/0NcbHxVhCnTbuO1SB5AwRyCRXRSQfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nh2AAbKUCOagLUTZde1BM0PllZw2eibpRJd6wueEMBO2OMwpKiS19t70qgryTOx7xWg45tFcEMx+rqePTHubpPFOdegFUb2RD5KGB7zMYeMFK0uKGBm4IKc/+3WRBWP3bqbcjJ59iIrxPiPaT6jIYatsDaygBMehSHpYEzyq6o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bCqKrG9F; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E75D549E3;
	Wed,  3 Jun 2026 04:06:49 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1F87C3F86F;
	Wed,  3 Jun 2026 04:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780484814; bh=dwKF6asnI4Nz/0NcbHxVhCnTbuO1SB5AwRyCRXRSQfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bCqKrG9FdRKVL1q7Y00NHyws5ey4qj6hkFCVUsM5+XWOR8Daw0eNbjgjKGveLG+ig
	 sOZGAUxTOcvUwEsml+EEwU2u8IUnKMi4zkpoIzLyPgMAqVevoygg17Q6SDl8zOdSDe
	 q4K2g0PC3qv+nxCsS7trD9cleWDJyPVP2m6wuiMA=
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev
Cc: broonie@kernel.org,
	catalin.marinas@arm.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	maz@kernel.org,
	oupton@kernel.org,
	stable@vger.kernel.org,
	tabba@google.com,
	vladimir.murzin@arm.com,
	will@kernel.org
Subject: [PATCH v4 06/20] KVM: arm64: pkvm: Remove struct cpu_sve_state
Date: Wed,  3 Jun 2026 12:06:16 +0100
Message-Id: <20260603110630.1027435-7-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260603110630.1027435-1-mark.rutland@arm.com>
References: <20260603110630.1027435-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-260037-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-arm-kernel@lists.infradead.org,m:kvmarm@lists.linux.dev,m:broonie@kernel.org,m:catalin.marinas@arm.com,m:james.morse@arm.com,m:mark.rutland@arm.com,m:maz@kernel.org,m:oupton@kernel.org,m:stable@vger.kernel.org,m:tabba@google.com,m:vladimir.murzin@arm.com,m:will@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mark.rutland@arm.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[mark.rutland@arm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:mid,arm.com:dkim,arm.com:from_mime,arm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82424636F20

There's no need for struct cpu_sve_state. Code would be simpler and more
robust without it, and removing it will simplify further cleanups (e.g.
adding an opaque type for the sve register state).

Protected KVM stores most of the host's system register state in
kvm_host_data::host_ctxt, which is an instance of struct
kvm_cpu_context. As kvm_cpu_context::sys_regs[] has a slot for ZCR_EL1,
we can store the host's ZCR_EL1 there.

While kvm_cpu_context::sys_regs doesn't have slots for FPSR and FPCR,
these are usually expected to be stored in struct user_fpsimd_state.
For historical reasons, __sve_save_state and __sve_restore_state()
expect a pointer to fpsr *within* struct user_fpsimd_state, assuming the
fpcr will immediately follow, as per the order within struct
user_fpsimd_state. We currently match this ordering in struct
cpu_sve_state, but it would be simpler and more robust to use struct
user_fpsimd_state directly.

After moving ZCR_EL1, FPSR, and FPCR out of struct cpu_sve_state, all
that's left is sve_regs, which can be represented as a pointer without
need for a container struct. This is kept as a pointer to u8 (matching
the array type), as this permits the compiler to catch unbalanced
referencing/dereferencing, which is not possible for pointers to void.

Apply the above changes, and remove cpu_sve_state.

I've dropped the comment regarding buffer alignment as AFAICT this was
never necessary. The LDR/STR (vector) instructions only require this
alignment when SCTLR_ELx.A==1, which is not the case for the kernel or
hyp code. Nothing else depends on the alignment.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Fuad Tabba <tabba@google.com>
Cc: James Morse <james.morse@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h       | 18 ++----------------
 arch/arm64/include/asm/kvm_pkvm.h       |  3 +--
 arch/arm64/kvm/arm.c                    | 16 ++++++++--------
 arch/arm64/kvm/hyp/include/hyp/switch.h |  9 +++++----
 arch/arm64/kvm/hyp/nvhe/hyp-main.c      |  9 +++++----
 arch/arm64/kvm/hyp/nvhe/setup.c         |  4 ++--
 6 files changed, 23 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 42b1c4764a4bf..ae24617380b8f 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -732,20 +732,6 @@ struct kvm_cpu_context {
 	u64 *vncr_array;
 };
 
-struct cpu_sve_state {
-	__u64 zcr_el1;
-
-	/*
-	 * Ordering is important since __sve_save_state/__sve_restore_state
-	 * relies on it.
-	 */
-	__u32 fpsr;
-	__u32 fpcr;
-
-	/* Must be SVE_VQ_BYTES (128 bit) aligned. */
-	__u8 sve_regs[];
-};
-
 /*
  * This structure is instantiated on a per-CPU basis, and contains
  * data that is:
@@ -771,9 +757,9 @@ struct kvm_host_data {
 
 	/*
 	 * Hyp VA.
-	 * sve_state is only used in pKVM and if system_supports_sve().
+	 * sve_regs is only used in pKVM and if system_supports_sve().
 	 */
-	struct cpu_sve_state *sve_state;
+	u8	*sve_regs;
 
 	/* Ownership of the FP regs */
 	enum {
diff --git a/arch/arm64/include/asm/kvm_pkvm.h b/arch/arm64/include/asm/kvm_pkvm.h
index 2954b311128c7..74fedd9c5ff02 100644
--- a/arch/arm64/include/asm/kvm_pkvm.h
+++ b/arch/arm64/include/asm/kvm_pkvm.h
@@ -188,8 +188,7 @@ static inline size_t pkvm_host_sve_state_size(void)
 	if (!system_supports_sve())
 		return 0;
 
-	return size_add(sizeof(struct cpu_sve_state),
-			SVE_SIG_REGS_SIZE(sve_vq_from_vl(kvm_host_sve_max_vl)));
+	return SVE_SIG_REGS_SIZE(sve_vq_from_vl(kvm_host_sve_max_vl));
 }
 
 struct pkvm_mapping {
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 8bb2c7422cc8b..f9fc85a0344e1 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -2499,10 +2499,10 @@ static void __init teardown_hyp_mode(void)
 			continue;
 
 		if (free_sve) {
-			struct cpu_sve_state *sve_state;
+			u8 *sve_regs;
 
-			sve_state = per_cpu_ptr_nvhe_sym(kvm_host_data, cpu)->sve_state;
-			free_pages((unsigned long) sve_state, pkvm_host_sve_state_order());
+			sve_regs = per_cpu_ptr_nvhe_sym(kvm_host_data, cpu)->sve_regs;
+			free_pages((unsigned long) sve_regs, pkvm_host_sve_state_order());
 		}
 
 		free_pages(kvm_nvhe_sym(kvm_arm_hyp_percpu_base)[cpu], nvhe_percpu_order());
@@ -2627,7 +2627,7 @@ static int init_pkvm_host_sve_state(void)
 		if (!page)
 			return -ENOMEM;
 
-		per_cpu_ptr_nvhe_sym(kvm_host_data, cpu)->sve_state = page_address(page);
+		per_cpu_ptr_nvhe_sym(kvm_host_data, cpu)->sve_regs = page_address(page);
 	}
 
 	/*
@@ -2648,11 +2648,11 @@ static void finalize_init_hyp_mode(void)
 
 	if (system_supports_sve() && is_protected_kvm_enabled()) {
 		for_each_possible_cpu(cpu) {
-			struct cpu_sve_state *sve_state;
+			u8 *sve_regs;
 
-			sve_state = per_cpu_ptr_nvhe_sym(kvm_host_data, cpu)->sve_state;
-			per_cpu_ptr_nvhe_sym(kvm_host_data, cpu)->sve_state =
-				kern_hyp_va(sve_state);
+			sve_regs = per_cpu_ptr_nvhe_sym(kvm_host_data, cpu)->sve_regs;
+			per_cpu_ptr_nvhe_sym(kvm_host_data, cpu)->sve_regs =
+				kern_hyp_va(sve_regs);
 		}
 	}
 }
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index cc4d011a2b380..6512dd3f75ae4 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -484,12 +484,13 @@ static inline void __hyp_sve_restore_guest(struct kvm_vcpu *vcpu)
 
 static inline void __hyp_sve_save_host(void)
 {
-	struct cpu_sve_state *sve_state = *host_data_ptr(sve_state);
+	struct kvm_cpu_context *hctxt = host_data_ptr(host_ctxt);
+	u8 *sve_regs = *host_data_ptr(sve_regs);
 
-	sve_state->zcr_el1 = read_sysreg_el1(SYS_ZCR);
+	ctxt_sys_reg(hctxt, ZCR_EL1) = read_sysreg_el1(SYS_ZCR);
 	write_sysreg_s(sve_vq_from_vl(kvm_host_sve_max_vl) - 1, SYS_ZCR_EL2);
-	__sve_save_state(sve_state->sve_regs + sve_ffr_offset(kvm_host_sve_max_vl),
-			 &sve_state->fpsr,
+	__sve_save_state(sve_regs + sve_ffr_offset(kvm_host_sve_max_vl),
+			 &hctxt->fp_regs.fpsr,
 			 true);
 }
 
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index db60f770060e5..04a6d2e0ea73f 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -41,7 +41,8 @@ static void __hyp_sve_save_guest(struct kvm_vcpu *vcpu)
 
 static void __hyp_sve_restore_host(void)
 {
-	struct cpu_sve_state *sve_state = *host_data_ptr(sve_state);
+	struct kvm_cpu_context *hctxt = host_data_ptr(host_ctxt);
+	u8 *sve_regs = *host_data_ptr(sve_regs);
 
 	/*
 	 * On saving/restoring host sve state, always use the maximum VL for
@@ -53,10 +54,10 @@ static void __hyp_sve_restore_host(void)
 	 * need to be revisited.
 	 */
 	write_sysreg_s(sve_vq_from_vl(kvm_host_sve_max_vl) - 1, SYS_ZCR_EL2);
-	__sve_restore_state(sve_state->sve_regs + sve_ffr_offset(kvm_host_sve_max_vl),
-			    &sve_state->fpsr,
+	__sve_restore_state(sve_regs + sve_ffr_offset(kvm_host_sve_max_vl),
+			    &hctxt->fp_regs.fpsr,
 			    true);
-	write_sysreg_el1(sve_state->zcr_el1, SYS_ZCR);
+	write_sysreg_el1(ctxt_sys_reg(hctxt, ZCR_EL1), SYS_ZCR);
 }
 
 static void fpsimd_sve_flush(void)
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index d461981616d90..cdaf53c833409 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -82,9 +82,9 @@ static int pkvm_create_host_sve_mappings(void)
 
 	for (i = 0; i < hyp_nr_cpus; i++) {
 		struct kvm_host_data *host_data = per_cpu_ptr(&kvm_host_data, i);
-		struct cpu_sve_state *sve_state = host_data->sve_state;
+		u8 *sve_regs = host_data->sve_regs;
 
-		start = kern_hyp_va(sve_state);
+		start = kern_hyp_va(sve_regs);
 		end = start + PAGE_ALIGN(pkvm_host_sve_state_size());
 		ret = pkvm_create_mappings(start, end, PAGE_HYP);
 		if (ret)
-- 
2.30.2


