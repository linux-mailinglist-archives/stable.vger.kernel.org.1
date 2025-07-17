Return-Path: <stable+bounces-163287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD230B092AF
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 19:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB011739D4
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 17:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6ECA2FD88E;
	Thu, 17 Jul 2025 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x+Z2hQ1d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5324F2FD86E;
	Thu, 17 Jul 2025 17:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771866; cv=none; b=C6hh96tziLXtQcSn4hfPH7Ttemm/EwpLFtBrET9beoWpA3quhxQ1WTHJ3jr9S8zvwbKaKQYDIJQSf/tOrn182iKIznkIFbVWJOjne47rsJi7+Az5MiJxERZD8wQiPDXfL1kaG9d6Zyb7UtcQnZl6c+8BmBECITVDcRqXXAiyYnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771866; c=relaxed/simple;
	bh=5CmHYadCC5YgRBsLnYbZ0OrbrXQZrVjhMxke3yWYjDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHxFhOemHmysYqCXkQfOkT2+3VVoS98KQKO+NPEv+F9uvJYXWFf6bvrjJvBvJr18CWhF8Ts7bJ+7kl37pj0kBIU0tn2jAk5VcPh42u4/Ao4NjQgHq12Xv9LVFRZGBFfI9i+smfXZ+0/McJUgyy4tx+70yhcLDpAZ1foJnqhUtxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x+Z2hQ1d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779F4C4CEE3;
	Thu, 17 Jul 2025 17:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752771865;
	bh=5CmHYadCC5YgRBsLnYbZ0OrbrXQZrVjhMxke3yWYjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x+Z2hQ1dzXBqJqHWnsyYhTZ6kjLXFiM8xwB3eizkZxUFU25WpsVSK6SFrU1lgx6+E
	 Gtvb1LUAmH1YnVQAGyMuubQIxh2+QfVcRKlNkv+VY0kQMFKYRZUlCmyvwP6FWVHB6Z
	 go9ppu/JG5pmjMxLor/ZBjPvRvxcWbP/mWxV84UE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.39
Date: Thu, 17 Jul 2025 19:04:16 +0200
Message-ID: <2025071716-nativity-ripcord-29f3@gregkh>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025071716-try-static-9924@gregkh>
References: <2025071716-try-static-9924@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/bpf/map_hash.rst b/Documentation/bpf/map_hash.rst
index d2343952f2cb..8606bf958a8c 100644
--- a/Documentation/bpf/map_hash.rst
+++ b/Documentation/bpf/map_hash.rst
@@ -233,10 +233,16 @@ attempts in order to enforce the LRU property which have increasing impacts on
 other CPUs involved in the following operation attempts:
 
 - Attempt to use CPU-local state to batch operations
-- Attempt to fetch free nodes from global lists
+- Attempt to fetch ``target_free`` free nodes from global lists
 - Attempt to pull any node from a global list and remove it from the hashmap
 - Attempt to pull any node from any CPU's list and remove it from the hashmap
 
+The number of nodes to borrow from the global list in a batch, ``target_free``,
+depends on the size of the map. Larger batch size reduces lock contention, but
+may also exhaust the global structure. The value is computed at map init to
+avoid exhaustion, by limiting aggregate reservation by all CPUs to half the map
+size. With a minimum of a single element and maximum budget of 128 at a time.
+
 This algorithm is described visually in the following diagram. See the
 description in commit 3a08c2fd7634 ("bpf: LRU List") for a full explanation of
 the corresponding operations:
diff --git a/Documentation/bpf/map_lru_hash_update.dot b/Documentation/bpf/map_lru_hash_update.dot
index a0fee349d29c..ab10058f5b79 100644
--- a/Documentation/bpf/map_lru_hash_update.dot
+++ b/Documentation/bpf/map_lru_hash_update.dot
@@ -35,18 +35,18 @@ digraph {
   fn_bpf_lru_list_pop_free_to_local [shape=rectangle,fillcolor=2,
     label="Flush local pending,
     Rotate Global list, move
-    LOCAL_FREE_TARGET
+    target_free
     from global -> local"]
   // Also corresponds to:
   // fn__local_list_flush()
   // fn_bpf_lru_list_rotate()
   fn___bpf_lru_node_move_to_free[shape=diamond,fillcolor=2,
-    label="Able to free\nLOCAL_FREE_TARGET\nnodes?"]
+    label="Able to free\ntarget_free\nnodes?"]
 
   fn___bpf_lru_list_shrink_inactive [shape=rectangle,fillcolor=3,
     label="Shrink inactive list
       up to remaining
-      LOCAL_FREE_TARGET
+      target_free
       (global LRU -> local)"]
   fn___bpf_lru_list_shrink [shape=diamond,fillcolor=2,
     label="> 0 entries in\nlocal free list?"]
diff --git a/Makefile b/Makefile
index 28c9acdd9b35..ba6054d96398 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 38
+SUBLEVEL = 39
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 05ccf4ec278f..9ca5ffd8d817 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2959,6 +2959,13 @@ static bool has_sve_feature(const struct arm64_cpu_capabilities *cap, int scope)
 }
 #endif
 
+#ifdef CONFIG_ARM64_SME
+static bool has_sme_feature(const struct arm64_cpu_capabilities *cap, int scope)
+{
+	return system_supports_sme() && has_user_cpuid_feature(cap, scope);
+}
+#endif
+
 static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64ISAR0_EL1, AES, PMULL, CAP_HWCAP, KERNEL_HWCAP_PMULL),
 	HWCAP_CAP(ID_AA64ISAR0_EL1, AES, AES, CAP_HWCAP, KERNEL_HWCAP_AES),
@@ -3037,25 +3044,25 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64ISAR2_EL1, BC, IMP, CAP_HWCAP, KERNEL_HWCAP_HBC),
 #ifdef CONFIG_ARM64_SME
 	HWCAP_CAP(ID_AA64PFR1_EL1, SME, IMP, CAP_HWCAP, KERNEL_HWCAP_SME),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, FA64, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_FA64),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, LUTv2, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_LUTV2),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, SMEver, SME2p1, CAP_HWCAP, KERNEL_HWCAP_SME2P1),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, SMEver, SME2, CAP_HWCAP, KERNEL_HWCAP_SME2),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, I16I64, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I16I64),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, F64F64, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F64F64),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, I16I32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I16I32),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, B16B16, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_B16B16),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, F16F16, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F16F16),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, F8F16, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F8F16),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, F8F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F8F32),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, I8I32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I8I32),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, F16F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F16F32),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, B16F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_B16F32),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, BI32I32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_BI32I32),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, F32F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F32F32),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, SF8FMA, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8FMA),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, SF8DP4, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8DP4),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, SF8DP2, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8DP2),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, FA64, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_FA64),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, LUTv2, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_LUTV2),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, SMEver, SME2p1, CAP_HWCAP, KERNEL_HWCAP_SME2P1),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, SMEver, SME2, CAP_HWCAP, KERNEL_HWCAP_SME2),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, I16I64, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I16I64),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, F64F64, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F64F64),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, I16I32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I16I32),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, B16B16, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_B16B16),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, F16F16, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F16F16),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, F8F16, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F8F16),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, F8F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F8F32),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, I8I32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I8I32),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, F16F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F16F32),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, B16F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_B16F32),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, BI32I32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_BI32I32),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, F32F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F32F32),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, SF8FMA, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8FMA),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, SF8DP4, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8DP4),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, SF8DP2, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8DP2),
 #endif /* CONFIG_ARM64_SME */
 	HWCAP_CAP(ID_AA64FPFR0_EL1, F8CVT, IMP, CAP_HWCAP, KERNEL_HWCAP_F8CVT),
 	HWCAP_CAP(ID_AA64FPFR0_EL1, F8FMA, IMP, CAP_HWCAP, KERNEL_HWCAP_F8FMA),
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 2bbcbb11d844..2edf88c1c695 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -544,6 +544,11 @@ static void permission_overlay_switch(struct task_struct *next)
 	current->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);
 	if (current->thread.por_el0 != next->thread.por_el0) {
 		write_sysreg_s(next->thread.por_el0, SYS_POR_EL0);
+		/*
+		 * No ISB required as we can tolerate spurious Overlay faults -
+		 * the fault handler will check again based on the new value
+		 * of POR_EL0.
+		 */
 	}
 }
 
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 8b281cf308b3..850307b49bab 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -487,17 +487,29 @@ static void do_bad_area(unsigned long far, unsigned long esr,
 	}
 }
 
-static bool fault_from_pkey(unsigned long esr, struct vm_area_struct *vma,
-			unsigned int mm_flags)
+static bool fault_from_pkey(struct vm_area_struct *vma, unsigned int mm_flags)
 {
-	unsigned long iss2 = ESR_ELx_ISS2(esr);
-
 	if (!system_supports_poe())
 		return false;
 
-	if (esr_fsc_is_permission_fault(esr) && (iss2 & ESR_ELx_Overlay))
-		return true;
-
+	/*
+	 * We do not check whether an Overlay fault has occurred because we
+	 * cannot make a decision based solely on its value:
+	 *
+	 * - If Overlay is set, a fault did occur due to POE, but it may be
+	 *   spurious in those cases where we update POR_EL0 without ISB (e.g.
+	 *   on context-switch). We would then need to manually check POR_EL0
+	 *   against vma_pkey(vma), which is exactly what
+	 *   arch_vma_access_permitted() does.
+	 *
+	 * - If Overlay is not set, we may still need to report a pkey fault.
+	 *   This is the case if an access was made within a mapping but with no
+	 *   page mapped, and POR_EL0 forbids the access (according to
+	 *   vma_pkey()). Such access will result in a SIGSEGV regardless
+	 *   because core code checks arch_vma_access_permitted(), but in order
+	 *   to report the correct error code - SEGV_PKUERR - we must handle
+	 *   that case here.
+	 */
 	return !arch_vma_access_permitted(vma,
 			mm_flags & FAULT_FLAG_WRITE,
 			mm_flags & FAULT_FLAG_INSTRUCTION,
@@ -595,7 +607,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 		goto bad_area;
 	}
 
-	if (fault_from_pkey(esr, vma, mm_flags)) {
+	if (fault_from_pkey(vma, mm_flags)) {
 		pkey = vma_pkey(vma);
 		vma_end_read(vma);
 		fault = 0;
@@ -639,7 +651,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 		goto bad_area;
 	}
 
-	if (fault_from_pkey(esr, vma, mm_flags)) {
+	if (fault_from_pkey(vma, mm_flags)) {
 		pkey = vma_pkey(vma);
 		mmap_read_unlock(mm);
 		fault = 0;
diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/vdso.lds.S
index cbe2a179331d..99e51f775539 100644
--- a/arch/riscv/kernel/vdso/vdso.lds.S
+++ b/arch/riscv/kernel/vdso/vdso.lds.S
@@ -31,7 +31,7 @@ SECTIONS
 		*(.data .data.* .gnu.linkonce.d.*)
 		*(.dynbss)
 		*(.bss .bss.* .gnu.linkonce.b.*)
-	}
+	}						:text
 
 	.note		: { *(.note.*) }		:text	:note
 
diff --git a/arch/s390/crypto/sha1_s390.c b/arch/s390/crypto/sha1_s390.c
index bc3a22704e09..10950953429e 100644
--- a/arch/s390/crypto/sha1_s390.c
+++ b/arch/s390/crypto/sha1_s390.c
@@ -38,6 +38,7 @@ static int s390_sha1_init(struct shash_desc *desc)
 	sctx->state[4] = SHA1_H4;
 	sctx->count = 0;
 	sctx->func = CPACF_KIMD_SHA_1;
+	sctx->first_message_part = 0;
 
 	return 0;
 }
@@ -62,6 +63,7 @@ static int s390_sha1_import(struct shash_desc *desc, const void *in)
 	memcpy(sctx->state, ictx->state, sizeof(ictx->state));
 	memcpy(sctx->buf, ictx->buffer, sizeof(ictx->buffer));
 	sctx->func = CPACF_KIMD_SHA_1;
+	sctx->first_message_part = 0;
 	return 0;
 }
 
diff --git a/arch/s390/crypto/sha256_s390.c b/arch/s390/crypto/sha256_s390.c
index 6f1ccdf93d3e..0204d4bca340 100644
--- a/arch/s390/crypto/sha256_s390.c
+++ b/arch/s390/crypto/sha256_s390.c
@@ -31,6 +31,7 @@ static int s390_sha256_init(struct shash_desc *desc)
 	sctx->state[7] = SHA256_H7;
 	sctx->count = 0;
 	sctx->func = CPACF_KIMD_SHA_256;
+	sctx->first_message_part = 0;
 
 	return 0;
 }
@@ -55,6 +56,7 @@ static int sha256_import(struct shash_desc *desc, const void *in)
 	memcpy(sctx->state, ictx->state, sizeof(ictx->state));
 	memcpy(sctx->buf, ictx->buf, sizeof(ictx->buf));
 	sctx->func = CPACF_KIMD_SHA_256;
+	sctx->first_message_part = 0;
 	return 0;
 }
 
@@ -90,6 +92,7 @@ static int s390_sha224_init(struct shash_desc *desc)
 	sctx->state[7] = SHA224_H7;
 	sctx->count = 0;
 	sctx->func = CPACF_KIMD_SHA_256;
+	sctx->first_message_part = 0;
 
 	return 0;
 }
diff --git a/arch/s390/crypto/sha512_s390.c b/arch/s390/crypto/sha512_s390.c
index 04f11c407763..b53a7793bd24 100644
--- a/arch/s390/crypto/sha512_s390.c
+++ b/arch/s390/crypto/sha512_s390.c
@@ -32,6 +32,7 @@ static int sha512_init(struct shash_desc *desc)
 	*(__u64 *)&ctx->state[14] = SHA512_H7;
 	ctx->count = 0;
 	ctx->func = CPACF_KIMD_SHA_512;
+	ctx->first_message_part = 0;
 
 	return 0;
 }
@@ -60,6 +61,7 @@ static int sha512_import(struct shash_desc *desc, const void *in)
 	memcpy(sctx->state, ictx->state, sizeof(ictx->state));
 	memcpy(sctx->buf, ictx->buf, sizeof(ictx->buf));
 	sctx->func = CPACF_KIMD_SHA_512;
+	sctx->first_message_part = 0;
 	return 0;
 }
 
@@ -97,6 +99,7 @@ static int sha384_init(struct shash_desc *desc)
 	*(__u64 *)&ctx->state[14] = SHA384_H7;
 	ctx->count = 0;
 	ctx->func = CPACF_KIMD_SHA_512;
+	ctx->first_message_part = 0;
 
 	return 0;
 }
diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 64c09db392c1..7a88b13d289f 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1592,35 +1592,19 @@ static void vector_eth_configure(
 
 	device->dev = dev;
 
-	*vp = ((struct vector_private)
-		{
-		.list			= LIST_HEAD_INIT(vp->list),
-		.dev			= dev,
-		.unit			= n,
-		.options		= get_transport_options(def),
-		.rx_irq			= 0,
-		.tx_irq			= 0,
-		.parsed			= def,
-		.max_packet		= get_mtu(def) + ETH_HEADER_OTHER,
-		/* TODO - we need to calculate headroom so that ip header
-		 * is 16 byte aligned all the time
-		 */
-		.headroom		= get_headroom(def),
-		.form_header		= NULL,
-		.verify_header		= NULL,
-		.header_rxbuffer	= NULL,
-		.header_txbuffer	= NULL,
-		.header_size		= 0,
-		.rx_header_size		= 0,
-		.rexmit_scheduled	= false,
-		.opened			= false,
-		.transport_data		= NULL,
-		.in_write_poll		= false,
-		.coalesce		= 2,
-		.req_size		= get_req_size(def),
-		.in_error		= false,
-		.bpf			= NULL
-	});
+	INIT_LIST_HEAD(&vp->list);
+	vp->dev		= dev;
+	vp->unit	= n;
+	vp->options	= get_transport_options(def);
+	vp->parsed	= def;
+	vp->max_packet	= get_mtu(def) + ETH_HEADER_OTHER;
+	/*
+	 * TODO - we need to calculate headroom so that ip header
+	 * is 16 byte aligned all the time
+	 */
+	vp->headroom	= get_headroom(def);
+	vp->coalesce	= 2;
+	vp->req_size	= get_req_size(def);
 
 	dev->features = dev->hw_features = (NETIF_F_SG | NETIF_F_FRAGLIST);
 	INIT_WORK(&vp->reset_tx, vector_reset_tx);
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index dfa334e3d1a0..2df0ae2a5e5d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -137,7 +137,7 @@ config X86
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_WANT_GENERAL_HUGETLB
-	select ARCH_WANT_HUGE_PMD_SHARE
+	select ARCH_WANT_HUGE_PMD_SHARE		if X86_64
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANT_OPTIMIZE_DAX_VMEMMAP	if X86_64
 	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP	if X86_64
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index ac25f9eb5912..7ebe76f69417 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -621,6 +621,7 @@
 #define MSR_AMD64_OSVW_STATUS		0xc0010141
 #define MSR_AMD_PPIN_CTL		0xc00102f0
 #define MSR_AMD_PPIN			0xc00102f1
+#define MSR_AMD64_CPUID_FN_7		0xc0011002
 #define MSR_AMD64_CPUID_FN_1		0xc0011004
 #define MSR_AMD64_LS_CFG		0xc0011020
 #define MSR_AMD64_DC_CFG		0xc0011022
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index b42307200e98..efd42ee9d1cc 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -977,6 +977,13 @@ static void init_amd_zen2(struct cpuinfo_x86 *c)
 	init_spectral_chicken(c);
 	fix_erratum_1386(c);
 	zen2_zenbleed_check(c);
+
+	/* Disable RDSEED on AMD Cyan Skillfish because of an error. */
+	if (c->x86_model == 0x47 && c->x86_stepping == 0x0) {
+		clear_cpu_cap(c, X86_FEATURE_RDSEED);
+		msr_clear_bit(MSR_AMD64_CPUID_FN_7, 18);
+		pr_emerg("RDSEED is not reliable on this platform; disabling.\n");
+	}
 }
 
 static void init_amd_zen3(struct cpuinfo_x86 *c)
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 14bf8c232e45..dac4564e1d7c 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -327,7 +327,6 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 
 struct thresh_restart {
 	struct threshold_block	*b;
-	int			reset;
 	int			set_lvt_off;
 	int			lvt_off;
 	u16			old_limit;
@@ -422,13 +421,13 @@ static void threshold_restart_bank(void *_tr)
 
 	rdmsr(tr->b->address, lo, hi);
 
-	if (tr->b->threshold_limit < (hi & THRESHOLD_MAX))
-		tr->reset = 1;	/* limit cannot be lower than err count */
-
-	if (tr->reset) {		/* reset err count and overflow bit */
-		hi =
-		    (hi & ~(MASK_ERR_COUNT_HI | MASK_OVERFLOW_HI)) |
-		    (THRESHOLD_MAX - tr->b->threshold_limit);
+	/*
+	 * Reset error count and overflow bit.
+	 * This is done during init or after handling an interrupt.
+	 */
+	if (hi & MASK_OVERFLOW_HI || tr->set_lvt_off) {
+		hi &= ~(MASK_ERR_COUNT_HI | MASK_OVERFLOW_HI);
+		hi |= THRESHOLD_MAX - tr->b->threshold_limit;
 	} else if (tr->old_limit) {	/* change limit w/o reset */
 		int new_count = (hi & THRESHOLD_MAX) +
 		    (tr->old_limit - tr->b->threshold_limit);
@@ -1099,13 +1098,20 @@ static const char *get_name(unsigned int cpu, unsigned int bank, struct threshol
 	}
 
 	bank_type = smca_get_bank_type(cpu, bank);
-	if (bank_type >= N_SMCA_BANK_TYPES)
-		return NULL;
 
 	if (b && (bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2)) {
 		if (b->block < ARRAY_SIZE(smca_umc_block_names))
 			return smca_umc_block_names[b->block];
-		return NULL;
+	}
+
+	if (b && b->block) {
+		snprintf(buf_mcatype, MAX_MCATYPE_NAME_LEN, "th_block_%u", b->block);
+		return buf_mcatype;
+	}
+
+	if (bank_type >= N_SMCA_BANK_TYPES) {
+		snprintf(buf_mcatype, MAX_MCATYPE_NAME_LEN, "th_bank_%u", bank);
+		return buf_mcatype;
 	}
 
 	if (per_cpu(smca_bank_counts, cpu)[bank_type] == 1)
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2a938f429c4d..d8f3d9af8acf 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1688,6 +1688,11 @@ static void mc_poll_banks_default(void)
 
 void (*mc_poll_banks)(void) = mc_poll_banks_default;
 
+static bool should_enable_timer(unsigned long iv)
+{
+	return !mca_cfg.ignore_ce && iv;
+}
+
 static void mce_timer_fn(struct timer_list *t)
 {
 	struct timer_list *cpu_t = this_cpu_ptr(&mce_timer);
@@ -1711,7 +1716,7 @@ static void mce_timer_fn(struct timer_list *t)
 
 	if (mce_get_storm_mode()) {
 		__start_timer(t, HZ);
-	} else {
+	} else if (should_enable_timer(iv)) {
 		__this_cpu_write(mce_next_interval, iv);
 		__start_timer(t, iv);
 	}
@@ -2111,11 +2116,10 @@ static void mce_start_timer(struct timer_list *t)
 {
 	unsigned long iv = check_interval * HZ;
 
-	if (mca_cfg.ignore_ce || !iv)
-		return;
-
-	this_cpu_write(mce_next_interval, iv);
-	__start_timer(t, iv);
+	if (should_enable_timer(iv)) {
+		this_cpu_write(mce_next_interval, iv);
+		__start_timer(t, iv);
+	}
 }
 
 static void __mcheck_cpu_setup_timer(void)
@@ -2756,15 +2760,9 @@ static int mce_cpu_dead(unsigned int cpu)
 static int mce_cpu_online(unsigned int cpu)
 {
 	struct timer_list *t = this_cpu_ptr(&mce_timer);
-	int ret;
 
 	mce_device_create(cpu);
-
-	ret = mce_threshold_create_device(cpu);
-	if (ret) {
-		mce_device_remove(cpu);
-		return ret;
-	}
+	mce_threshold_create_device(cpu);
 	mce_reenable_cpu();
 	mce_start_timer(t);
 	return 0;
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index f6103e6bf69a..bb0a60b1ed63 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -477,6 +477,7 @@ void mce_intel_feature_init(struct cpuinfo_x86 *c)
 void mce_intel_feature_clear(struct cpuinfo_x86 *c)
 {
 	intel_clear_lmce();
+	cmci_clear();
 }
 
 bool intel_filter_mce(struct mce *m)
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 02196db26a08..8f587c5bb6bc 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -822,6 +822,7 @@ void kvm_set_cpu_caps(void)
 	kvm_cpu_cap_check_and_set(X86_FEATURE_SBPB);
 	kvm_cpu_cap_check_and_set(X86_FEATURE_IBPB_BRTYPE);
 	kvm_cpu_cap_check_and_set(X86_FEATURE_SRSO_NO);
+	kvm_cpu_cap_check_and_set(X86_FEATURE_VERW_CLEAR);
 
 	kvm_cpu_cap_init_kvm_defined(CPUID_8000_0022_EAX,
 		F(PERFMON_V2)
@@ -831,6 +832,9 @@ void kvm_set_cpu_caps(void)
 		F(TSA_SQ_NO) | F(TSA_L1_NO)
 	);
 
+	kvm_cpu_cap_check_and_set(X86_FEATURE_TSA_SQ_NO);
+	kvm_cpu_cap_check_and_set(X86_FEATURE_TSA_L1_NO);
+
 	/*
 	 * Synthesize "LFENCE is serializing" into the AMD-defined entry in
 	 * KVM's supported CPUID if the feature is reported as supported by the
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 6154cb450b44..c4ae73541fc5 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2058,6 +2058,10 @@ static int sev_check_source_vcpus(struct kvm *dst, struct kvm *src)
 	struct kvm_vcpu *src_vcpu;
 	unsigned long i;
 
+	if (src->created_vcpus != atomic_read(&src->online_vcpus) ||
+	    dst->created_vcpus != atomic_read(&dst->online_vcpus))
+		return -EBUSY;
+
 	if (!sev_es_guest(src))
 		return 0;
 
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 622fe24da910..759cc3e9c0fa 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1916,8 +1916,19 @@ int kvm_xen_setup_evtchn(struct kvm *kvm,
 {
 	struct kvm_vcpu *vcpu;
 
-	if (ue->u.xen_evtchn.port >= max_evtchn_port(kvm))
-		return -EINVAL;
+	/*
+	 * Don't check for the port being within range of max_evtchn_port().
+	 * Userspace can configure what ever targets it likes; events just won't
+	 * be delivered if/while the target is invalid, just like userspace can
+	 * configure MSIs which target non-existent APICs.
+	 *
+	 * This allow on Live Migration and Live Update, the IRQ routing table
+	 * can be restored *independently* of other things like creating vCPUs,
+	 * without imposing an ordering dependency on userspace.  In this
+	 * particular case, the problematic ordering would be with setting the
+	 * Xen 'long mode' flag, which changes max_evtchn_port() to allow 4096
+	 * instead of 1024 event channels.
+	 */
 
 	/* We only support 2 level event channels for now */
 	if (ue->u.xen_evtchn.priority != KVM_IRQ_ROUTING_XEN_EVTCHN_PRIO_2LEVEL)
diff --git a/crypto/ecc.c b/crypto/ecc.c
index 50ad2d4ed672..6cf9a945fc6c 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -71,7 +71,7 @@ EXPORT_SYMBOL(ecc_get_curve);
 void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
 			   u64 *out, unsigned int ndigits)
 {
-	int diff = ndigits - DIV_ROUND_UP(nbytes, sizeof(u64));
+	int diff = ndigits - DIV_ROUND_UP_POW2(nbytes, sizeof(u64));
 	unsigned int o = nbytes & 7;
 	__be64 msd = 0;
 
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 6a7ac34d73bd..65fa3444367a 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -243,23 +243,10 @@ static int acpi_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 	case POWER_SUPPLY_PROP_POWER_NOW:
-		if (battery->rate_now == ACPI_BATTERY_VALUE_UNKNOWN) {
+		if (battery->rate_now == ACPI_BATTERY_VALUE_UNKNOWN)
 			ret = -ENODEV;
-			break;
-		}
-
-		val->intval = battery->rate_now * 1000;
-		/*
-		 * When discharging, the current should be reported as a
-		 * negative number as per the power supply class interface
-		 * definition.
-		 */
-		if (psp == POWER_SUPPLY_PROP_CURRENT_NOW &&
-		    (battery->state & ACPI_BATTERY_STATE_DISCHARGING) &&
-		    acpi_battery_handle_discharging(battery)
-				== POWER_SUPPLY_STATUS_DISCHARGING)
-			val->intval = -val->intval;
-
+		else
+			val->intval = battery->rate_now * 1000;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
 	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
index a876024d8a05..63d41320cd5c 100644
--- a/drivers/atm/idt77252.c
+++ b/drivers/atm/idt77252.c
@@ -852,6 +852,8 @@ queue_skb(struct idt77252_dev *card, struct vc_map *vc,
 
 	IDT77252_PRV_PADDR(skb) = dma_map_single(&card->pcidev->dev, skb->data,
 						 skb->len, DMA_TO_DEVICE);
+	if (dma_mapping_error(&card->pcidev->dev, IDT77252_PRV_PADDR(skb)))
+		return -ENOMEM;
 
 	error = -EINVAL;
 
@@ -1857,6 +1859,8 @@ add_rx_skb(struct idt77252_dev *card, int queue,
 		paddr = dma_map_single(&card->pcidev->dev, skb->data,
 				       skb_end_pointer(skb) - skb->data,
 				       DMA_FROM_DEVICE);
+		if (dma_mapping_error(&card->pcidev->dev, paddr))
+			goto outpoolrm;
 		IDT77252_PRV_PADDR(skb) = paddr;
 
 		if (push_rx_skb(card, skb, queue)) {
@@ -1871,6 +1875,7 @@ add_rx_skb(struct idt77252_dev *card, int queue,
 	dma_unmap_single(&card->pcidev->dev, IDT77252_PRV_PADDR(skb),
 			 skb_end_pointer(skb) - skb->data, DMA_FROM_DEVICE);
 
+outpoolrm:
 	handle = IDT77252_PRV_POOL(skb);
 	card->sbpool[POOL_QUEUE(handle)].skb[POOL_INDEX(handle)] = NULL;
 
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 450458267e6e..c705acc4d6f4 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2136,9 +2136,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 				goto out;
 		}
 	}
-	ret = nbd_start_device(nbd);
-	if (ret)
-		goto out;
+
 	if (info->attrs[NBD_ATTR_BACKEND_IDENTIFIER]) {
 		nbd->backend = nla_strdup(info->attrs[NBD_ATTR_BACKEND_IDENTIFIER],
 					  GFP_KERNEL);
@@ -2154,6 +2152,8 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 	set_bit(NBD_RT_HAS_BACKEND_FILE, &config->runtime_flags);
+
+	ret = nbd_start_device(nbd);
 out:
 	mutex_unlock(&nbd->config_lock);
 	if (!ret) {
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 746ef36e58df..3b1a5cdd6311 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2457,7 +2457,8 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	if (copy_from_user(&info, argp, sizeof(info)))
 		return -EFAULT;
 
-	if (info.queue_depth > UBLK_MAX_QUEUE_DEPTH || info.nr_hw_queues > UBLK_MAX_NR_QUEUES)
+	if (info.queue_depth > UBLK_MAX_QUEUE_DEPTH || !info.queue_depth ||
+	    info.nr_hw_queues > UBLK_MAX_NR_QUEUES || !info.nr_hw_queues)
 		return -EINVAL;
 
 	if (capable(CAP_SYS_ADMIN))
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 025b9a07c087..e6ad01d5e1d5 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2363,10 +2363,17 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			 */
 			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev,
 								   "bluetooth");
-			if (IS_ERR(qcadev->bt_power->pwrseq))
-				return PTR_ERR(qcadev->bt_power->pwrseq);
 
-			break;
+			/*
+			 * Some modules have BT_EN enabled via a hardware pull-up,
+			 * meaning it is not defined in the DTS and is not controlled
+			 * through the power sequence. In such cases, fall through
+			 * to follow the legacy flow.
+			 */
+			if (IS_ERR(qcadev->bt_power->pwrseq))
+				qcadev->bt_power->pwrseq = NULL;
+			else
+				break;
 		}
 		fallthrough;
 	case QCA_WCN3988:
diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index e12b531f5c2f..6a4a8ecd0edd 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -1241,7 +1241,7 @@ int ipmi_create_user(unsigned int          if_num,
 	}
 	/* Not found, return an error */
 	rv = -EINVAL;
-	goto out_kfree;
+	goto out_unlock;
 
  found:
 	if (atomic_add_return(1, &intf->nr_users) > max_users) {
@@ -1283,6 +1283,7 @@ int ipmi_create_user(unsigned int          if_num,
 
 out_kfree:
 	atomic_dec(&intf->nr_users);
+out_unlock:
 	srcu_read_unlock(&ipmi_interfaces_srcu, index);
 	vfree(new_user);
 	return rv;
diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index 15510c2ff21c..1b1561c84127 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -404,6 +404,7 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 	const struct scmi_handle *handle = sdev->handle;
 	struct scmi_protocol_handle *ph;
 	const struct clk_ops *scmi_clk_ops_db[SCMI_MAX_CLK_OPS] = {};
+	struct scmi_clk *sclks;
 
 	if (!handle)
 		return -ENODEV;
@@ -430,18 +431,21 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 	transport_is_atomic = handle->is_transport_atomic(handle,
 							  &atomic_threshold_us);
 
+	sclks = devm_kcalloc(dev, count, sizeof(*sclks), GFP_KERNEL);
+	if (!sclks)
+		return -ENOMEM;
+
+	for (idx = 0; idx < count; idx++)
+		hws[idx] = &sclks[idx].hw;
+
 	for (idx = 0; idx < count; idx++) {
-		struct scmi_clk *sclk;
+		struct scmi_clk *sclk = &sclks[idx];
 		const struct clk_ops *scmi_ops;
 
-		sclk = devm_kzalloc(dev, sizeof(*sclk), GFP_KERNEL);
-		if (!sclk)
-			return -ENOMEM;
-
 		sclk->info = scmi_proto_clk_ops->info_get(ph, idx);
 		if (!sclk->info) {
 			dev_dbg(dev, "invalid clock info for idx %d\n", idx);
-			devm_kfree(dev, sclk);
+			hws[idx] = NULL;
 			continue;
 		}
 
@@ -479,13 +483,11 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 		if (err) {
 			dev_err(dev, "failed to register clock %d\n", idx);
 			devm_kfree(dev, sclk->parent_data);
-			devm_kfree(dev, sclk);
 			hws[idx] = NULL;
 		} else {
 			dev_dbg(dev, "Registered clock:%s%s\n",
 				sclk->info->name,
 				scmi_ops->enable ? " (atomic ops)" : "");
-			hws[idx] = &sclk->hw;
 		}
 	}
 
diff --git a/drivers/clk/imx/clk-imx95-blk-ctl.c b/drivers/clk/imx/clk-imx95-blk-ctl.c
index 19a62da74be4..564e9f3f7508 100644
--- a/drivers/clk/imx/clk-imx95-blk-ctl.c
+++ b/drivers/clk/imx/clk-imx95-blk-ctl.c
@@ -219,11 +219,15 @@ static const struct imx95_blk_ctl_dev_data lvds_csr_dev_data = {
 	.clk_reg_offset = 0,
 };
 
+static const char * const disp_engine_parents[] = {
+	"videopll1", "dsi_pll", "ldb_pll_div7"
+};
+
 static const struct imx95_blk_ctl_clk_dev_data dispmix_csr_clk_dev_data[] = {
 	[IMX95_CLK_DISPMIX_ENG0_SEL] = {
 		.name = "disp_engine0_sel",
-		.parent_names = (const char *[]){"videopll1", "dsi_pll", "ldb_pll_div7", },
-		.num_parents = 4,
+		.parent_names = disp_engine_parents,
+		.num_parents = ARRAY_SIZE(disp_engine_parents),
 		.reg = 0,
 		.bit_idx = 0,
 		.bit_width = 2,
@@ -232,8 +236,8 @@ static const struct imx95_blk_ctl_clk_dev_data dispmix_csr_clk_dev_data[] = {
 	},
 	[IMX95_CLK_DISPMIX_ENG1_SEL] = {
 		.name = "disp_engine1_sel",
-		.parent_names = (const char *[]){"videopll1", "dsi_pll", "ldb_pll_div7", },
-		.num_parents = 4,
+		.parent_names = disp_engine_parents,
+		.num_parents = ARRAY_SIZE(disp_engine_parents),
 		.reg = 0,
 		.bit_idx = 2,
 		.bit_width = 2,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a55e611605fc..24e41b42c638 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4144,7 +4144,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->grbm_idx_mutex);
 	mutex_init(&adev->mn_lock);
 	mutex_init(&adev->virt.vf_errors.lock);
-	mutex_init(&adev->virt.rlcg_reg_lock);
 	hash_init(adev->mn_hash);
 	mutex_init(&adev->psp.mutex);
 	mutex_init(&adev->notifier_lock);
@@ -4170,6 +4169,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	spin_lock_init(&adev->se_cac_idx_lock);
 	spin_lock_init(&adev->audio_endpt_idx_lock);
 	spin_lock_init(&adev->mm_stats.lock);
+	spin_lock_init(&adev->virt.rlcg_reg_lock);
 	spin_lock_init(&adev->wb.lock);
 
 	INIT_LIST_HEAD(&adev->reset_list);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 34d41e3ce347..eee434743deb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -112,6 +112,14 @@
 #endif
 
 MODULE_FIRMWARE("amdgpu/ip_discovery.bin");
+MODULE_FIRMWARE("amdgpu/vega10_ip_discovery.bin");
+MODULE_FIRMWARE("amdgpu/vega12_ip_discovery.bin");
+MODULE_FIRMWARE("amdgpu/vega20_ip_discovery.bin");
+MODULE_FIRMWARE("amdgpu/raven_ip_discovery.bin");
+MODULE_FIRMWARE("amdgpu/raven2_ip_discovery.bin");
+MODULE_FIRMWARE("amdgpu/picasso_ip_discovery.bin");
+MODULE_FIRMWARE("amdgpu/arcturus_ip_discovery.bin");
+MODULE_FIRMWARE("amdgpu/aldebaran_ip_discovery.bin");
 
 #define mmIP_DISCOVERY_VERSION  0x16A00
 #define mmRCC_CONFIG_MEMSIZE	0xde3
@@ -400,7 +408,27 @@ static const char *amdgpu_discovery_get_fw_name(struct amdgpu_device *adev)
 	if (amdgpu_discovery == 2)
 		return "amdgpu/ip_discovery.bin";
 
-	return NULL;
+	switch (adev->asic_type) {
+	case CHIP_VEGA10:
+		return "amdgpu/vega10_ip_discovery.bin";
+	case CHIP_VEGA12:
+		return "amdgpu/vega12_ip_discovery.bin";
+	case CHIP_RAVEN:
+		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
+			return "amdgpu/raven2_ip_discovery.bin";
+		else if (adev->apu_flags & AMD_APU_IS_PICASSO)
+			return "amdgpu/picasso_ip_discovery.bin";
+		else
+			return "amdgpu/raven_ip_discovery.bin";
+	case CHIP_VEGA20:
+		return "amdgpu/vega20_ip_discovery.bin";
+	case CHIP_ARCTURUS:
+		return "amdgpu/arcturus_ip_discovery.bin";
+	case CHIP_ALDEBARAN:
+		return "amdgpu/aldebaran_ip_discovery.bin";
+	default:
+		return NULL;
+	}
 }
 
 static int amdgpu_discovery_init(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index b6397d3229e1..01dccd489a80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1010,6 +1010,7 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
 	void *scratch_reg2;
 	void *scratch_reg3;
 	void *spare_int;
+	unsigned long flags;
 
 	if (!adev->gfx.rlc.rlcg_reg_access_supported) {
 		dev_err(adev->dev,
@@ -1031,7 +1032,7 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
 	scratch_reg2 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg2;
 	scratch_reg3 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg3;
 
-	mutex_lock(&adev->virt.rlcg_reg_lock);
+	spin_lock_irqsave(&adev->virt.rlcg_reg_lock, flags);
 
 	if (reg_access_ctrl->spare_int)
 		spare_int = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->spare_int;
@@ -1090,7 +1091,7 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
 
 	ret = readl(scratch_reg0);
 
-	mutex_unlock(&adev->virt.rlcg_reg_lock);
+	spin_unlock_irqrestore(&adev->virt.rlcg_reg_lock, flags);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index b650a2032c42..6a2087abfb7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -275,7 +275,8 @@ struct amdgpu_virt {
 	/* the ucode id to signal the autoload */
 	uint32_t autoload_ucode_id;
 
-	struct mutex rlcg_reg_lock;
+	/* Spinlock to protect access to the RLCG register interface */
+	spinlock_t rlcg_reg_lock;
 };
 
 struct amdgpu_video_codec_info;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index f00d41be7fca..3e9e0f36cd3f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1170,13 +1170,12 @@ svm_range_split_head(struct svm_range *prange, uint64_t new_start,
 }
 
 static void
-svm_range_add_child(struct svm_range *prange, struct mm_struct *mm,
-		    struct svm_range *pchild, enum svm_work_list_ops op)
+svm_range_add_child(struct svm_range *prange, struct svm_range *pchild, enum svm_work_list_ops op)
 {
 	pr_debug("add child 0x%p [0x%lx 0x%lx] to prange 0x%p child list %d\n",
 		 pchild, pchild->start, pchild->last, prange, op);
 
-	pchild->work_item.mm = mm;
+	pchild->work_item.mm = NULL;
 	pchild->work_item.op = op;
 	list_add_tail(&pchild->child_list, &prange->child_list);
 }
@@ -2384,15 +2383,17 @@ svm_range_add_list_work(struct svm_range_list *svms, struct svm_range *prange,
 		    prange->work_item.op != SVM_OP_UNMAP_RANGE)
 			prange->work_item.op = op;
 	} else {
-		prange->work_item.op = op;
-
-		/* Pairs with mmput in deferred_list_work */
-		mmget(mm);
-		prange->work_item.mm = mm;
-		list_add_tail(&prange->deferred_list,
-			      &prange->svms->deferred_range_list);
-		pr_debug("add prange 0x%p [0x%lx 0x%lx] to work list op %d\n",
-			 prange, prange->start, prange->last, op);
+		/* Pairs with mmput in deferred_list_work.
+		 * If process is exiting and mm is gone, don't update mmu notifier.
+		 */
+		if (mmget_not_zero(mm)) {
+			prange->work_item.mm = mm;
+			prange->work_item.op = op;
+			list_add_tail(&prange->deferred_list,
+				      &prange->svms->deferred_range_list);
+			pr_debug("add prange 0x%p [0x%lx 0x%lx] to work list op %d\n",
+				 prange, prange->start, prange->last, op);
+		}
 	}
 	spin_unlock(&svms->deferred_list_lock);
 }
@@ -2406,8 +2407,7 @@ void schedule_deferred_list_work(struct svm_range_list *svms)
 }
 
 static void
-svm_range_unmap_split(struct mm_struct *mm, struct svm_range *parent,
-		      struct svm_range *prange, unsigned long start,
+svm_range_unmap_split(struct svm_range *parent, struct svm_range *prange, unsigned long start,
 		      unsigned long last)
 {
 	struct svm_range *head;
@@ -2428,12 +2428,12 @@ svm_range_unmap_split(struct mm_struct *mm, struct svm_range *parent,
 		svm_range_split(tail, last + 1, tail->last, &head);
 
 	if (head != prange && tail != prange) {
-		svm_range_add_child(parent, mm, head, SVM_OP_UNMAP_RANGE);
-		svm_range_add_child(parent, mm, tail, SVM_OP_ADD_RANGE);
+		svm_range_add_child(parent, head, SVM_OP_UNMAP_RANGE);
+		svm_range_add_child(parent, tail, SVM_OP_ADD_RANGE);
 	} else if (tail != prange) {
-		svm_range_add_child(parent, mm, tail, SVM_OP_UNMAP_RANGE);
+		svm_range_add_child(parent, tail, SVM_OP_UNMAP_RANGE);
 	} else if (head != prange) {
-		svm_range_add_child(parent, mm, head, SVM_OP_UNMAP_RANGE);
+		svm_range_add_child(parent, head, SVM_OP_UNMAP_RANGE);
 	} else if (parent != prange) {
 		prange->work_item.op = SVM_OP_UNMAP_RANGE;
 	}
@@ -2510,14 +2510,14 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 		l = min(last, pchild->last);
 		if (l >= s)
 			svm_range_unmap_from_gpus(pchild, s, l, trigger);
-		svm_range_unmap_split(mm, prange, pchild, start, last);
+		svm_range_unmap_split(prange, pchild, start, last);
 		mutex_unlock(&pchild->lock);
 	}
 	s = max(start, prange->start);
 	l = min(last, prange->last);
 	if (l >= s)
 		svm_range_unmap_from_gpus(prange, s, l, trigger);
-	svm_range_unmap_split(mm, prange, prange, start, last);
+	svm_range_unmap_split(prange, prange, start, last);
 
 	if (unmap_parent)
 		svm_range_add_list_work(svms, prange, mm, SVM_OP_UNMAP_RANGE);
@@ -2560,8 +2560,6 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
 
 	if (range->event == MMU_NOTIFY_RELEASE)
 		return true;
-	if (!mmget_not_zero(mni->mm))
-		return true;
 
 	start = mni->interval_tree.start;
 	last = mni->interval_tree.last;
@@ -2588,7 +2586,6 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
 	}
 
 	svm_range_unlock(prange);
-	mmput(mni->mm);
 
 	return true;
 }
diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index 888aadb6a4ac..d6550b54fac1 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -860,11 +860,23 @@ void drm_framebuffer_free(struct kref *kref)
 int drm_framebuffer_init(struct drm_device *dev, struct drm_framebuffer *fb,
 			 const struct drm_framebuffer_funcs *funcs)
 {
+	unsigned int i;
 	int ret;
+	bool exists;
 
 	if (WARN_ON_ONCE(fb->dev != dev || !fb->format))
 		return -EINVAL;
 
+	for (i = 0; i < fb->format->num_planes; i++) {
+		if (drm_WARN_ON_ONCE(dev, fb->internal_flags & DRM_FRAMEBUFFER_HAS_HANDLE_REF(i)))
+			fb->internal_flags &= ~DRM_FRAMEBUFFER_HAS_HANDLE_REF(i);
+		if (fb->obj[i]) {
+			exists = drm_gem_object_handle_get_if_exists_unlocked(fb->obj[i]);
+			if (exists)
+				fb->internal_flags |= DRM_FRAMEBUFFER_HAS_HANDLE_REF(i);
+		}
+	}
+
 	INIT_LIST_HEAD(&fb->filp_head);
 
 	fb->funcs = funcs;
@@ -873,7 +885,7 @@ int drm_framebuffer_init(struct drm_device *dev, struct drm_framebuffer *fb,
 	ret = __drm_mode_object_add(dev, &fb->base, DRM_MODE_OBJECT_FB,
 				    false, drm_framebuffer_free);
 	if (ret)
-		goto out;
+		goto err;
 
 	mutex_lock(&dev->mode_config.fb_lock);
 	dev->mode_config.num_fb++;
@@ -881,7 +893,16 @@ int drm_framebuffer_init(struct drm_device *dev, struct drm_framebuffer *fb,
 	mutex_unlock(&dev->mode_config.fb_lock);
 
 	drm_mode_object_register(dev, &fb->base);
-out:
+
+	return 0;
+
+err:
+	for (i = 0; i < fb->format->num_planes; i++) {
+		if (fb->internal_flags & DRM_FRAMEBUFFER_HAS_HANDLE_REF(i)) {
+			drm_gem_object_handle_put_unlocked(fb->obj[i]);
+			fb->internal_flags &= ~DRM_FRAMEBUFFER_HAS_HANDLE_REF(i);
+		}
+	}
 	return ret;
 }
 EXPORT_SYMBOL(drm_framebuffer_init);
@@ -958,6 +979,12 @@ EXPORT_SYMBOL(drm_framebuffer_unregister_private);
 void drm_framebuffer_cleanup(struct drm_framebuffer *fb)
 {
 	struct drm_device *dev = fb->dev;
+	unsigned int i;
+
+	for (i = 0; i < fb->format->num_planes; i++) {
+		if (fb->internal_flags & DRM_FRAMEBUFFER_HAS_HANDLE_REF(i))
+			drm_gem_object_handle_put_unlocked(fb->obj[i]);
+	}
 
 	mutex_lock(&dev->mode_config.fb_lock);
 	list_del(&fb->head);
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 426d0867882d..9e8a4da313a0 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -186,6 +186,46 @@ void drm_gem_private_object_fini(struct drm_gem_object *obj)
 }
 EXPORT_SYMBOL(drm_gem_private_object_fini);
 
+static void drm_gem_object_handle_get(struct drm_gem_object *obj)
+{
+	struct drm_device *dev = obj->dev;
+
+	drm_WARN_ON(dev, !mutex_is_locked(&dev->object_name_lock));
+
+	if (obj->handle_count++ == 0)
+		drm_gem_object_get(obj);
+}
+
+/**
+ * drm_gem_object_handle_get_if_exists_unlocked - acquire reference on user-space handle, if any
+ * @obj: GEM object
+ *
+ * Acquires a reference on the GEM buffer object's handle. Required to keep
+ * the GEM object alive. Call drm_gem_object_handle_put_if_exists_unlocked()
+ * to release the reference. Does nothing if the buffer object has no handle.
+ *
+ * Returns:
+ * True if a handle exists, or false otherwise
+ */
+bool drm_gem_object_handle_get_if_exists_unlocked(struct drm_gem_object *obj)
+{
+	struct drm_device *dev = obj->dev;
+
+	guard(mutex)(&dev->object_name_lock);
+
+	/*
+	 * First ref taken during GEM object creation, if any. Some
+	 * drivers set up internal framebuffers with GEM objects that
+	 * do not have a GEM handle. Hence, this counter can be zero.
+	 */
+	if (!obj->handle_count)
+		return false;
+
+	drm_gem_object_handle_get(obj);
+
+	return true;
+}
+
 /**
  * drm_gem_object_handle_free - release resources bound to userspace handles
  * @obj: GEM object to clean up.
@@ -216,20 +256,26 @@ static void drm_gem_object_exported_dma_buf_free(struct drm_gem_object *obj)
 	}
 }
 
-static void
-drm_gem_object_handle_put_unlocked(struct drm_gem_object *obj)
+/**
+ * drm_gem_object_handle_put_unlocked - releases reference on user-space handle
+ * @obj: GEM object
+ *
+ * Releases a reference on the GEM buffer object's handle. Possibly releases
+ * the GEM buffer object and associated dma-buf objects.
+ */
+void drm_gem_object_handle_put_unlocked(struct drm_gem_object *obj)
 {
 	struct drm_device *dev = obj->dev;
 	bool final = false;
 
-	if (WARN_ON(READ_ONCE(obj->handle_count) == 0))
+	if (drm_WARN_ON(dev, READ_ONCE(obj->handle_count) == 0))
 		return;
 
 	/*
-	* Must bump handle count first as this may be the last
-	* ref, in which case the object would disappear before we
-	* checked for a name
-	*/
+	 * Must bump handle count first as this may be the last
+	 * ref, in which case the object would disappear before
+	 * we checked for a name.
+	 */
 
 	mutex_lock(&dev->object_name_lock);
 	if (--obj->handle_count == 0) {
@@ -253,6 +299,9 @@ drm_gem_object_release_handle(int id, void *ptr, void *data)
 	struct drm_file *file_priv = data;
 	struct drm_gem_object *obj = ptr;
 
+	if (drm_WARN_ON(obj->dev, !data))
+		return 0;
+
 	if (obj->funcs->close)
 		obj->funcs->close(obj, file_priv);
 
@@ -363,8 +412,8 @@ drm_gem_handle_create_tail(struct drm_file *file_priv,
 	int ret;
 
 	WARN_ON(!mutex_is_locked(&dev->object_name_lock));
-	if (obj->handle_count++ == 0)
-		drm_gem_object_get(obj);
+
+	drm_gem_object_handle_get(obj);
 
 	/*
 	 * Get the user-visible handle using idr.  Preload and perform
@@ -373,7 +422,7 @@ drm_gem_handle_create_tail(struct drm_file *file_priv,
 	idr_preload(GFP_KERNEL);
 	spin_lock(&file_priv->table_lock);
 
-	ret = idr_alloc(&file_priv->object_idr, obj, 1, 0, GFP_NOWAIT);
+	ret = idr_alloc(&file_priv->object_idr, NULL, 1, 0, GFP_NOWAIT);
 
 	spin_unlock(&file_priv->table_lock);
 	idr_preload_end();
@@ -394,6 +443,11 @@ drm_gem_handle_create_tail(struct drm_file *file_priv,
 			goto err_revoke;
 	}
 
+	/* mirrors drm_gem_handle_delete to avoid races */
+	spin_lock(&file_priv->table_lock);
+	obj = idr_replace(&file_priv->object_idr, obj, handle);
+	WARN_ON(obj != NULL);
+	spin_unlock(&file_priv->table_lock);
 	*handlep = handle;
 	return 0;
 
diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
index 1705bfc90b1e..98b73c581c42 100644
--- a/drivers/gpu/drm/drm_internal.h
+++ b/drivers/gpu/drm/drm_internal.h
@@ -153,6 +153,8 @@ void drm_sysfs_lease_event(struct drm_device *dev);
 
 /* drm_gem.c */
 int drm_gem_init(struct drm_device *dev);
+bool drm_gem_object_handle_get_if_exists_unlocked(struct drm_gem_object *obj);
+void drm_gem_object_handle_put_unlocked(struct drm_gem_object *obj);
 int drm_gem_handle_create_tail(struct drm_file *file_priv,
 			       struct drm_gem_object *obj,
 			       u32 *handlep);
diff --git a/drivers/gpu/drm/exynos/exynos7_drm_decon.c b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
index 0d185c0564b9..9eeba254cf45 100644
--- a/drivers/gpu/drm/exynos/exynos7_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
@@ -601,6 +601,10 @@ static irqreturn_t decon_irq_handler(int irq, void *dev_id)
 	if (!ctx->drm_dev)
 		goto out;
 
+	/* check if crtc and vblank have been initialized properly */
+	if (!drm_dev_has_vblank(ctx->drm_dev))
+		goto out;
+
 	if (!ctx->i80_if) {
 		drm_crtc_handle_vblank(&ctx->crtc->base);
 
diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/imagination/pvr_power.c
index ba7816fd28ec..850b318605da 100644
--- a/drivers/gpu/drm/imagination/pvr_power.c
+++ b/drivers/gpu/drm/imagination/pvr_power.c
@@ -363,13 +363,13 @@ pvr_power_reset(struct pvr_device *pvr_dev, bool hard_reset)
 		if (!err) {
 			if (hard_reset) {
 				pvr_dev->fw_dev.booted = false;
-				WARN_ON(pm_runtime_force_suspend(from_pvr_device(pvr_dev)->dev));
+				WARN_ON(pvr_power_device_suspend(from_pvr_device(pvr_dev)->dev));
 
 				err = pvr_fw_hard_reset(pvr_dev);
 				if (err)
 					goto err_device_lost;
 
-				err = pm_runtime_force_resume(from_pvr_device(pvr_dev)->dev);
+				err = pvr_power_device_resume(from_pvr_device(pvr_dev)->dev);
 				pvr_dev->fw_dev.booted = true;
 				if (err)
 					goto err_device_lost;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
index fc84ca214f24..3ad4f6e9a8ac 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
@@ -1454,7 +1454,6 @@ r535_gsp_acpi_caps(acpi_handle handle, CAPS_METHOD_DATA *caps)
 	union acpi_object argv4 = {
 		.buffer.type    = ACPI_TYPE_BUFFER,
 		.buffer.length  = 4,
-		.buffer.pointer = kmalloc(argv4.buffer.length, GFP_KERNEL),
 	}, *obj;
 
 	caps->status = 0xffff;
@@ -1462,17 +1461,22 @@ r535_gsp_acpi_caps(acpi_handle handle, CAPS_METHOD_DATA *caps)
 	if (!acpi_check_dsm(handle, &NVOP_DSM_GUID, NVOP_DSM_REV, BIT_ULL(0x1a)))
 		return;
 
+	argv4.buffer.pointer = kmalloc(argv4.buffer.length, GFP_KERNEL);
+	if (!argv4.buffer.pointer)
+		return;
+
 	obj = acpi_evaluate_dsm(handle, &NVOP_DSM_GUID, NVOP_DSM_REV, 0x1a, &argv4);
 	if (!obj)
-		return;
+		goto done;
 
 	if (WARN_ON(obj->type != ACPI_TYPE_BUFFER) ||
 	    WARN_ON(obj->buffer.length != 4))
-		return;
+		goto done;
 
 	caps->status = 0;
 	caps->optimusCaps = *(u32 *)obj->buffer.pointer;
 
+done:
 	ACPI_FREE(obj);
 
 	kfree(argv4.buffer.pointer);
@@ -1489,24 +1493,28 @@ r535_gsp_acpi_jt(acpi_handle handle, JT_METHOD_DATA *jt)
 	union acpi_object argv4 = {
 		.buffer.type    = ACPI_TYPE_BUFFER,
 		.buffer.length  = sizeof(caps),
-		.buffer.pointer = kmalloc(argv4.buffer.length, GFP_KERNEL),
 	}, *obj;
 
 	jt->status = 0xffff;
 
+	argv4.buffer.pointer = kmalloc(argv4.buffer.length, GFP_KERNEL);
+	if (!argv4.buffer.pointer)
+		return;
+
 	obj = acpi_evaluate_dsm(handle, &JT_DSM_GUID, JT_DSM_REV, 0x1, &argv4);
 	if (!obj)
-		return;
+		goto done;
 
 	if (WARN_ON(obj->type != ACPI_TYPE_BUFFER) ||
 	    WARN_ON(obj->buffer.length != 4))
-		return;
+		goto done;
 
 	jt->status = 0;
 	jt->jtCaps = *(u32 *)obj->buffer.pointer;
 	jt->jtRevId = (jt->jtCaps & 0xfff00000) >> 20;
 	jt->bSBIOSCaps = 0;
 
+done:
 	ACPI_FREE(obj);
 
 	kfree(argv4.buffer.pointer);
diff --git a/drivers/gpu/drm/tegra/nvdec.c b/drivers/gpu/drm/tegra/nvdec.c
index 4860790666af..14ef61b44f47 100644
--- a/drivers/gpu/drm/tegra/nvdec.c
+++ b/drivers/gpu/drm/tegra/nvdec.c
@@ -261,10 +261,8 @@ static int nvdec_load_falcon_firmware(struct nvdec *nvdec)
 
 	if (!client->group) {
 		virt = dma_alloc_coherent(nvdec->dev, size, &iova, GFP_KERNEL);
-
-		err = dma_mapping_error(nvdec->dev, iova);
-		if (err < 0)
-			return err;
+		if (!virt)
+			return -ENOMEM;
 	} else {
 		virt = tegra_drm_alloc(tegra, size, &iova);
 		if (IS_ERR(virt))
diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index 3c07f4712d5c..b600be2a5c84 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -254,6 +254,13 @@ static int ttm_buffer_object_transfer(struct ttm_buffer_object *bo,
 	ret = dma_resv_trylock(&fbo->base.base._resv);
 	WARN_ON(!ret);
 
+	ret = dma_resv_reserve_fences(&fbo->base.base._resv, 1);
+	if (ret) {
+		dma_resv_unlock(&fbo->base.base._resv);
+		kfree(fbo);
+		return ret;
+	}
+
 	if (fbo->base.resource) {
 		ttm_resource_set_bo(fbo->base.resource, &fbo->base);
 		bo->resource = NULL;
@@ -262,12 +269,6 @@ static int ttm_buffer_object_transfer(struct ttm_buffer_object *bo,
 		fbo->base.bulk_move = NULL;
 	}
 
-	ret = dma_resv_reserve_fences(&fbo->base.base._resv, 1);
-	if (ret) {
-		kfree(fbo);
-		return ret;
-	}
-
 	ttm_bo_get(bo);
 	fbo->bo = bo;
 
diff --git a/drivers/gpu/drm/xe/xe_gt_pagefault.c b/drivers/gpu/drm/xe/xe_gt_pagefault.c
index db540c8be6c7..656c2ab6ca9f 100644
--- a/drivers/gpu/drm/xe/xe_gt_pagefault.c
+++ b/drivers/gpu/drm/xe/xe_gt_pagefault.c
@@ -432,6 +432,7 @@ static int xe_alloc_pf_queue(struct xe_gt *gt, struct pf_queue *pf_queue)
 #define PF_MULTIPLIER	8
 	pf_queue->num_dw =
 		(num_eus + XE_NUM_HW_ENGINES) * PF_MSG_LEN_DW * PF_MULTIPLIER;
+	pf_queue->num_dw = roundup_pow_of_two(pf_queue->num_dw);
 #undef PF_MULTIPLIER
 
 	pf_queue->gt = gt;
diff --git a/drivers/gpu/drm/xe/xe_lmtt.c b/drivers/gpu/drm/xe/xe_lmtt.c
index 8999ac511555..485658f69fba 100644
--- a/drivers/gpu/drm/xe/xe_lmtt.c
+++ b/drivers/gpu/drm/xe/xe_lmtt.c
@@ -78,6 +78,9 @@ static struct xe_lmtt_pt *lmtt_pt_alloc(struct xe_lmtt *lmtt, unsigned int level
 	}
 
 	lmtt_assert(lmtt, xe_bo_is_vram(bo));
+	lmtt_debug(lmtt, "level=%u addr=%#llx\n", level, (u64)xe_bo_main_addr(bo, XE_PAGE_SIZE));
+
+	xe_map_memset(lmtt_to_xe(lmtt), &bo->vmap, 0, 0, bo->size);
 
 	pt->level = level;
 	pt->bo = bo;
@@ -91,6 +94,9 @@ static struct xe_lmtt_pt *lmtt_pt_alloc(struct xe_lmtt *lmtt, unsigned int level
 
 static void lmtt_pt_free(struct xe_lmtt_pt *pt)
 {
+	lmtt_debug(&pt->bo->tile->sriov.pf.lmtt, "level=%u addr=%llx\n",
+		   pt->level, (u64)xe_bo_main_addr(pt->bo, XE_PAGE_SIZE));
+
 	xe_bo_unpin_map_no_vm(pt->bo);
 	kfree(pt);
 }
@@ -226,9 +232,14 @@ static void lmtt_write_pte(struct xe_lmtt *lmtt, struct xe_lmtt_pt *pt,
 
 	switch (lmtt->ops->lmtt_pte_size(level)) {
 	case sizeof(u32):
+		lmtt_assert(lmtt, !overflows_type(pte, u32));
+		lmtt_assert(lmtt, !pte || !iosys_map_rd(&pt->bo->vmap, idx * sizeof(u32), u32));
+
 		xe_map_wr(lmtt_to_xe(lmtt), &pt->bo->vmap, idx * sizeof(u32), u32, pte);
 		break;
 	case sizeof(u64):
+		lmtt_assert(lmtt, !pte || !iosys_map_rd(&pt->bo->vmap, idx * sizeof(u64), u64));
+
 		xe_map_wr(lmtt_to_xe(lmtt), &pt->bo->vmap, idx * sizeof(u64), u64, pte);
 		break;
 	default:
diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
index 6431697c6169..c2da2691fd2b 100644
--- a/drivers/gpu/drm/xe/xe_migrate.c
+++ b/drivers/gpu/drm/xe/xe_migrate.c
@@ -860,7 +860,7 @@ struct dma_fence *xe_migrate_copy(struct xe_migrate *m,
 		if (src_is_vram && xe_migrate_allow_identity(src_L0, &src_it))
 			xe_res_next(&src_it, src_L0);
 		else
-			emit_pte(m, bb, src_L0_pt, src_is_vram, copy_system_ccs,
+			emit_pte(m, bb, src_L0_pt, src_is_vram, copy_system_ccs || use_comp_pat,
 				 &src_it, src_L0, src);
 
 		if (dst_is_vram && xe_migrate_allow_identity(src_L0, &dst_it))
diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index 23028afbbe1d..da09c26249f5 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -164,7 +164,6 @@ static const struct xe_graphics_desc graphics_xelpg = {
 	.has_asid = 1, \
 	.has_atomic_enable_pte_bit = 1, \
 	.has_flat_ccs = 1, \
-	.has_indirect_ring_state = 1, \
 	.has_range_tlb_invalidation = 1, \
 	.has_usm = 1, \
 	.va_bits = 48, \
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 06f50aa31326..46c73ff10c74 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -682,11 +682,13 @@ void xe_pm_assert_unbounded_bridge(struct xe_device *xe)
 }
 
 /**
- * xe_pm_set_vram_threshold - Set a vram threshold for allowing/blocking D3Cold
+ * xe_pm_set_vram_threshold - Set a VRAM threshold for allowing/blocking D3Cold
  * @xe: xe device instance
- * @threshold: VRAM size in bites for the D3cold threshold
+ * @threshold: VRAM size in MiB for the D3cold threshold
  *
- * Returns 0 for success, negative error code otherwise.
+ * Return:
+ * * 0		- success
+ * * -EINVAL	- invalid argument
  */
 int xe_pm_set_vram_threshold(struct xe_device *xe, u32 threshold)
 {
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index c6424f625948..b472140421f5 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -311,6 +311,8 @@
 #define USB_DEVICE_ID_ASUS_AK1D		0x1125
 #define USB_DEVICE_ID_CHICONY_TOSHIBA_WT10A	0x1408
 #define USB_DEVICE_ID_CHICONY_ACER_SWITCH12	0x1421
+#define USB_DEVICE_ID_CHICONY_HP_5MP_CAMERA	0xb824
+#define USB_DEVICE_ID_CHICONY_HP_5MP_CAMERA2	0xb82c
 
 #define USB_VENDOR_ID_CHUNGHWAT		0x2247
 #define USB_DEVICE_ID_CHUNGHWAT_MULTITOUCH	0x0001
@@ -814,6 +816,7 @@
 #define USB_DEVICE_ID_LENOVO_TPPRODOCK	0x6067
 #define USB_DEVICE_ID_LENOVO_X1_COVER	0x6085
 #define USB_DEVICE_ID_LENOVO_X1_TAB	0x60a3
+#define USB_DEVICE_ID_LENOVO_X1_TAB2	0x60a4
 #define USB_DEVICE_ID_LENOVO_X1_TAB3	0x60b5
 #define USB_DEVICE_ID_LENOVO_X12_TAB	0x60fe
 #define USB_DEVICE_ID_LENOVO_X12_TAB2	0x61ae
@@ -1518,4 +1521,7 @@
 #define USB_VENDOR_ID_SIGNOTEC			0x2133
 #define USB_DEVICE_ID_SIGNOTEC_VIEWSONIC_PD1011	0x0018
 
+#define USB_VENDOR_ID_SMARTLINKTECHNOLOGY              0x4c4a
+#define USB_DEVICE_ID_SMARTLINKTECHNOLOGY_4155         0x4155
+
 #endif
diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 56e530860cae..8482852c662d 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -473,6 +473,7 @@ static int lenovo_input_mapping(struct hid_device *hdev,
 		return lenovo_input_mapping_tp10_ultrabook_kbd(hdev, hi, field,
 							       usage, bit, max);
 	case USB_DEVICE_ID_LENOVO_X1_TAB:
+	case USB_DEVICE_ID_LENOVO_X1_TAB2:
 	case USB_DEVICE_ID_LENOVO_X1_TAB3:
 		return lenovo_input_mapping_x1_tab_kbd(hdev, hi, field, usage, bit, max);
 	default:
@@ -587,6 +588,7 @@ static ssize_t attr_fn_lock_store(struct device *dev,
 		break;
 	case USB_DEVICE_ID_LENOVO_TP10UBKBD:
 	case USB_DEVICE_ID_LENOVO_X1_TAB:
+	case USB_DEVICE_ID_LENOVO_X1_TAB2:
 	case USB_DEVICE_ID_LENOVO_X1_TAB3:
 		ret = lenovo_led_set_tp10ubkbd(hdev, TP10UBKBD_FN_LOCK_LED, value);
 		if (ret)
@@ -781,6 +783,7 @@ static int lenovo_event(struct hid_device *hdev, struct hid_field *field,
 		return lenovo_event_cptkbd(hdev, field, usage, value);
 	case USB_DEVICE_ID_LENOVO_TP10UBKBD:
 	case USB_DEVICE_ID_LENOVO_X1_TAB:
+	case USB_DEVICE_ID_LENOVO_X1_TAB2:
 	case USB_DEVICE_ID_LENOVO_X1_TAB3:
 		return lenovo_event_tp10ubkbd(hdev, field, usage, value);
 	default:
@@ -1062,6 +1065,7 @@ static int lenovo_led_brightness_set(struct led_classdev *led_cdev,
 		break;
 	case USB_DEVICE_ID_LENOVO_TP10UBKBD:
 	case USB_DEVICE_ID_LENOVO_X1_TAB:
+	case USB_DEVICE_ID_LENOVO_X1_TAB2:
 	case USB_DEVICE_ID_LENOVO_X1_TAB3:
 		ret = lenovo_led_set_tp10ubkbd(hdev, tp10ubkbd_led[led_nr], value);
 		break;
@@ -1293,6 +1297,7 @@ static int lenovo_probe(struct hid_device *hdev,
 		break;
 	case USB_DEVICE_ID_LENOVO_TP10UBKBD:
 	case USB_DEVICE_ID_LENOVO_X1_TAB:
+	case USB_DEVICE_ID_LENOVO_X1_TAB2:
 	case USB_DEVICE_ID_LENOVO_X1_TAB3:
 		ret = lenovo_probe_tp10ubkbd(hdev);
 		break;
@@ -1380,6 +1385,7 @@ static void lenovo_remove(struct hid_device *hdev)
 		break;
 	case USB_DEVICE_ID_LENOVO_TP10UBKBD:
 	case USB_DEVICE_ID_LENOVO_X1_TAB:
+	case USB_DEVICE_ID_LENOVO_X1_TAB2:
 	case USB_DEVICE_ID_LENOVO_X1_TAB3:
 		lenovo_remove_tp10ubkbd(hdev);
 		break;
@@ -1430,6 +1436,8 @@ static const struct hid_device_id lenovo_devices[] = {
 	 */
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_X1_TAB) },
+	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
+		     USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_X1_TAB2) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_X1_TAB3) },
 	{ }
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 93b5c648ef82..641292cfdaa6 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2116,12 +2116,18 @@ static const struct hid_device_id mt_devices[] = {
 		HID_DEVICE(BUS_I2C, HID_GROUP_GENERIC,
 			USB_VENDOR_ID_LG, I2C_DEVICE_ID_LG_7010) },
 
-	/* Lenovo X1 TAB Gen 2 */
+	/* Lenovo X1 TAB Gen 1 */
 	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
 		HID_DEVICE(BUS_USB, HID_GROUP_MULTITOUCH_WIN_8,
 			   USB_VENDOR_ID_LENOVO,
 			   USB_DEVICE_ID_LENOVO_X1_TAB) },
 
+	/* Lenovo X1 TAB Gen 2 */
+	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
+		HID_DEVICE(BUS_USB, HID_GROUP_MULTITOUCH_WIN_8,
+			   USB_VENDOR_ID_LENOVO,
+			   USB_DEVICE_ID_LENOVO_X1_TAB2) },
+
 	/* Lenovo X1 TAB Gen 3 */
 	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
 		HID_DEVICE(BUS_USB, HID_GROUP_MULTITOUCH_WIN_8,
diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 55153a2f7988..2a3ae1068739 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -308,6 +308,7 @@ enum joycon_ctlr_state {
 	JOYCON_CTLR_STATE_INIT,
 	JOYCON_CTLR_STATE_READ,
 	JOYCON_CTLR_STATE_REMOVED,
+	JOYCON_CTLR_STATE_SUSPENDED,
 };
 
 /* Controller type received as part of device info */
@@ -2754,14 +2755,46 @@ static void nintendo_hid_remove(struct hid_device *hdev)
 
 static int nintendo_hid_resume(struct hid_device *hdev)
 {
-	int ret = joycon_init(hdev);
+	struct joycon_ctlr *ctlr = hid_get_drvdata(hdev);
+	int ret;
+
+	hid_dbg(hdev, "resume\n");
+	if (!joycon_using_usb(ctlr)) {
+		hid_dbg(hdev, "no-op resume for bt ctlr\n");
+		ctlr->ctlr_state = JOYCON_CTLR_STATE_READ;
+		return 0;
+	}
 
+	ret = joycon_init(hdev);
 	if (ret)
-		hid_err(hdev, "Failed to restore controller after resume");
+		hid_err(hdev,
+			"Failed to restore controller after resume: %d\n",
+			ret);
+	else
+		ctlr->ctlr_state = JOYCON_CTLR_STATE_READ;
 
 	return ret;
 }
 
+static int nintendo_hid_suspend(struct hid_device *hdev, pm_message_t message)
+{
+	struct joycon_ctlr *ctlr = hid_get_drvdata(hdev);
+
+	hid_dbg(hdev, "suspend: %d\n", message.event);
+	/*
+	 * Avoid any blocking loops in suspend/resume transitions.
+	 *
+	 * joycon_enforce_subcmd_rate() can result in repeated retries if for
+	 * whatever reason the controller stops providing input reports.
+	 *
+	 * This has been observed with bluetooth controllers which lose
+	 * connectivity prior to suspend (but not long enough to result in
+	 * complete disconnection).
+	 */
+	ctlr->ctlr_state = JOYCON_CTLR_STATE_SUSPENDED;
+	return 0;
+}
+
 #endif
 
 static const struct hid_device_id nintendo_hid_devices[] = {
@@ -2800,6 +2833,7 @@ static struct hid_driver nintendo_hid_driver = {
 
 #ifdef CONFIG_PM
 	.resume		= nintendo_hid_resume,
+	.suspend	= nintendo_hid_suspend,
 #endif
 };
 static int __init nintendo_init(void)
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 73979643315b..80372342c176 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -747,6 +747,8 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AVERMEDIA, USB_DEVICE_ID_AVER_FM_MR800) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AXENTIA, USB_DEVICE_ID_AXENTIA_FM_RADIO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BERKSHIRE, USB_DEVICE_ID_BERKSHIRE_PCWD) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_HP_5MP_CAMERA) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_HP_5MP_CAMERA2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CIDC, 0x0103) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYGNAL, USB_DEVICE_ID_CYGNAL_RADIO_SI470X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYGNAL, USB_DEVICE_ID_CYGNAL_RADIO_SI4713) },
@@ -894,6 +896,7 @@ static const struct hid_device_id hid_ignore_list[] = {
 #endif
 	{ HID_USB_DEVICE(USB_VENDOR_ID_YEALINK, USB_DEVICE_ID_YEALINK_P1K_P4K_B2K) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_HP_5MP_CAMERA_5473) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SMARTLINKTECHNOLOGY, USB_DEVICE_ID_SMARTLINKTECHNOLOGY_4155) },
 	{ }
 };
 
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index c1f304836008..a799a89195c5 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -71,6 +71,7 @@ config ARM_VIC_NR
 
 config IRQ_MSI_LIB
 	bool
+	select GENERIC_MSI_IRQ
 
 config ARMADA_370_XP_IRQ
 	bool
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index c12359fd3a42..0da1d0723f88 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2355,8 +2355,7 @@ static int bitmap_get_stats(void *data, struct md_bitmap_stats *stats)
 
 	if (!bitmap)
 		return -ENOENT;
-	if (!bitmap->mddev->bitmap_info.external &&
-	    !bitmap->storage.sb_page)
+	if (!bitmap->storage.sb_page)
 		return -EINVAL;
 	sb = kmap_local_page(bitmap->storage.sb_page);
 	stats->sync_size = le64_to_cpu(sb->sync_size);
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 6b6cd753d61a..fe1599db69c8 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -3380,6 +3380,7 @@ static int raid1_reshape(struct mddev *mddev)
 	/* ok, everything is stopped */
 	oldpool = conf->r1bio_pool;
 	conf->r1bio_pool = newpool;
+	init_waitqueue_head(&conf->r1bio_pool.wait);
 
 	for (d = d2 = 0; d < conf->raid_disks; d++) {
 		struct md_rdev *rdev = conf->mirrors[d].rdev;
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index cc194f6ec18d..5cdc599fcad3 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1181,8 +1181,11 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 		}
 	}
 
-	if (!regular_request_wait(mddev, conf, bio, r10_bio->sectors))
+	if (!regular_request_wait(mddev, conf, bio, r10_bio->sectors)) {
+		raid_end_bio_io(r10_bio);
 		return;
+	}
+
 	rdev = read_balance(conf, r10_bio, &max_sectors);
 	if (!rdev) {
 		if (err_rdev) {
@@ -1368,8 +1371,11 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 	}
 
 	sectors = r10_bio->sectors;
-	if (!regular_request_wait(mddev, conf, bio, sectors))
+	if (!regular_request_wait(mddev, conf, bio, sectors)) {
+		raid_end_bio_io(r10_bio);
 		return;
+	}
+
 	if (test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery) &&
 	    (mddev->reshape_backwards
 	     ? (bio->bi_iter.bi_sector < conf->reshape_safe &&
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index dbd4d8796f9b..dbcf17fb3ef2 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -665,7 +665,7 @@ static int m_can_handle_lost_msg(struct net_device *dev)
 	struct can_frame *frame;
 	u32 timestamp = 0;
 
-	netdev_err(dev, "msg lost in rxf0\n");
+	netdev_dbg(dev, "msg lost in rxf0\n");
 
 	stats->rx_errors++;
 	stats->rx_over_errors++;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ad4aec522f4f..f4bafc71a739 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11061,11 +11061,9 @@ static void bnxt_free_irq(struct bnxt *bp)
 
 static int bnxt_request_irq(struct bnxt *bp)
 {
+	struct cpu_rmap *rmap = NULL;
 	int i, j, rc = 0;
 	unsigned long flags = 0;
-#ifdef CONFIG_RFS_ACCEL
-	struct cpu_rmap *rmap;
-#endif
 
 	rc = bnxt_setup_int_mode(bp);
 	if (rc) {
@@ -11080,15 +11078,15 @@ static int bnxt_request_irq(struct bnxt *bp)
 		int map_idx = bnxt_cp_num_to_irq_num(bp, i);
 		struct bnxt_irq *irq = &bp->irq_tbl[map_idx];
 
-#ifdef CONFIG_RFS_ACCEL
-		if (rmap && bp->bnapi[i]->rx_ring) {
+		if (IS_ENABLED(CONFIG_RFS_ACCEL) &&
+		    rmap && bp->bnapi[i]->rx_ring) {
 			rc = irq_cpu_rmap_add(rmap, irq->vector);
 			if (rc)
 				netdev_warn(bp->dev, "failed adding irq rmap for ring %d\n",
 					    j);
 			j++;
 		}
-#endif
+
 		rc = request_irq(irq->vector, irq->handler, flags, irq->name,
 				 bp->bnapi[i]);
 		if (rc)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
index 0dbb880a7aa0..71e14be2507e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
@@ -487,7 +487,9 @@ static int bnxt_ets_validate(struct bnxt *bp, struct ieee_ets *ets, u8 *tc)
 
 		if ((ets->tc_tx_bw[i] || ets->tc_tsa[i]) && i > bp->max_tc)
 			return -EINVAL;
+	}
 
+	for (i = 0; i < max_tc; i++) {
 		switch (ets->tc_tsa[i]) {
 		case IEEE_8021QAZ_TSA_STRICT:
 			break;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 8726657f5cb9..844812bd6536 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -115,7 +115,7 @@ static void __bnxt_xmit_xdp_redirect(struct bnxt *bp,
 	tx_buf->action = XDP_REDIRECT;
 	tx_buf->xdpf = xdpf;
 	dma_unmap_addr_set(tx_buf, mapping, mapping);
-	dma_unmap_len_set(tx_buf, len, 0);
+	dma_unmap_len_set(tx_buf, len, len);
 }
 
 void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
index a189038d88df..246ddce753f9 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.h
+++ b/drivers/net/ethernet/ibm/ibmvnic.h
@@ -211,7 +211,6 @@ struct ibmvnic_statistics {
 	u8 reserved[72];
 } __packed __aligned(8);
 
-#define NUM_TX_STATS 3
 struct ibmvnic_tx_queue_stats {
 	u64 batched_packets;
 	u64 direct_packets;
@@ -219,13 +218,18 @@ struct ibmvnic_tx_queue_stats {
 	u64 dropped_packets;
 };
 
-#define NUM_RX_STATS 3
+#define NUM_TX_STATS \
+	(sizeof(struct ibmvnic_tx_queue_stats) / sizeof(u64))
+
 struct ibmvnic_rx_queue_stats {
 	u64 packets;
 	u64 bytes;
 	u64 interrupts;
 };
 
+#define NUM_RX_STATS \
+	(sizeof(struct ibmvnic_rx_queue_stats) / sizeof(u64))
+
 struct ibmvnic_acl_buffer {
 	__be32 len;
 	__be32 version;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
index 1e8b7d330701..b5aac0e1a68e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
@@ -18,7 +18,8 @@ enum {
 
 enum {
 	MLX5E_TC_PRIO = 0,
-	MLX5E_NIC_PRIO
+	MLX5E_PROMISC_PRIO,
+	MLX5E_NIC_PRIO,
 };
 
 struct mlx5e_flow_table {
@@ -68,9 +69,13 @@ struct mlx5e_l2_table {
 				 MLX5_HASH_FIELD_SEL_DST_IP   |\
 				 MLX5_HASH_FIELD_SEL_IPSEC_SPI)
 
-/* NIC prio FTS */
+/* NIC promisc FT level */
 enum {
 	MLX5E_PROMISC_FT_LEVEL,
+};
+
+/* NIC prio FTS */
+enum {
 	MLX5E_VLAN_FT_LEVEL,
 	MLX5E_L2_FT_LEVEL,
 	MLX5E_TTC_FT_LEVEL,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
index 298bb74ec5e9..d1d629697e28 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
@@ -113,7 +113,7 @@ int mlx5e_dim_rx_change(struct mlx5e_rq *rq, bool enable)
 		__set_bit(MLX5E_RQ_STATE_DIM, &rq->state);
 	} else {
 		__clear_bit(MLX5E_RQ_STATE_DIM, &rq->state);
-
+		synchronize_net();
 		mlx5e_dim_disable(rq->dim);
 		rq->dim = NULL;
 	}
@@ -140,7 +140,7 @@ int mlx5e_dim_tx_change(struct mlx5e_txqsq *sq, bool enable)
 		__set_bit(MLX5E_SQ_STATE_DIM, &sq->state);
 	} else {
 		__clear_bit(MLX5E_SQ_STATE_DIM, &sq->state);
-
+		synchronize_net();
 		mlx5e_dim_disable(sq->dim);
 		sq->dim = NULL;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
index 05058710d2c7..537e732085b2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
@@ -776,7 +776,7 @@ static int mlx5e_create_promisc_table(struct mlx5e_flow_steering *fs)
 	ft_attr.max_fte = MLX5E_PROMISC_TABLE_SIZE;
 	ft_attr.autogroup.max_num_groups = 1;
 	ft_attr.level = MLX5E_PROMISC_FT_LEVEL;
-	ft_attr.prio = MLX5E_NIC_PRIO;
+	ft_attr.prio = MLX5E_PROMISC_PRIO;
 
 	ft->t = mlx5_create_auto_grouped_flow_table(fs->ns, &ft_attr);
 	if (IS_ERR(ft->t)) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 1bc88743d2df..7ef0a4af89e4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -113,13 +113,16 @@
 #define ETHTOOL_PRIO_NUM_LEVELS 1
 #define ETHTOOL_NUM_PRIOS 11
 #define ETHTOOL_MIN_LEVEL (KERNEL_MIN_LEVEL + ETHTOOL_NUM_PRIOS)
-/* Promiscuous, Vlan, mac, ttc, inner ttc, {UDP/ANY/aRFS/accel/{esp, esp_err}}, IPsec policy,
+/* Vlan, mac, ttc, inner ttc, {UDP/ANY/aRFS/accel/{esp, esp_err}}, IPsec policy,
  * {IPsec RoCE MPV,Alias table},IPsec RoCE policy
  */
-#define KERNEL_NIC_PRIO_NUM_LEVELS 11
+#define KERNEL_NIC_PRIO_NUM_LEVELS 10
 #define KERNEL_NIC_NUM_PRIOS 1
-/* One more level for tc */
-#define KERNEL_MIN_LEVEL (KERNEL_NIC_PRIO_NUM_LEVELS + 1)
+/* One more level for tc, and one more for promisc */
+#define KERNEL_MIN_LEVEL (KERNEL_NIC_PRIO_NUM_LEVELS + 2)
+
+#define KERNEL_NIC_PROMISC_NUM_PRIOS 1
+#define KERNEL_NIC_PROMISC_NUM_LEVELS 1
 
 #define KERNEL_NIC_TC_NUM_PRIOS  1
 #define KERNEL_NIC_TC_NUM_LEVELS 3
@@ -187,6 +190,8 @@ static struct init_tree_node {
 			   ADD_NS(MLX5_FLOW_TABLE_MISS_ACTION_DEF,
 				  ADD_MULTIPLE_PRIO(KERNEL_NIC_TC_NUM_PRIOS,
 						    KERNEL_NIC_TC_NUM_LEVELS),
+				  ADD_MULTIPLE_PRIO(KERNEL_NIC_PROMISC_NUM_PRIOS,
+						    KERNEL_NIC_PROMISC_NUM_LEVELS),
 				  ADD_MULTIPLE_PRIO(KERNEL_NIC_NUM_PRIOS,
 						    KERNEL_NIC_PRIO_NUM_LEVELS))),
 		  ADD_PRIO(0, BY_PASS_MIN_LEVEL, 0, FS_CHAINING_CAPS,
diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 9bac4083d8a0..876de6db63c4 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -28,6 +28,9 @@ static void mana_gd_init_pf_regs(struct pci_dev *pdev)
 	gc->db_page_base = gc->bar0_va +
 				mana_gd_r64(gc, GDMA_PF_REG_DB_PAGE_OFF);
 
+	gc->phys_db_page_base = gc->bar0_pa +
+				mana_gd_r64(gc, GDMA_PF_REG_DB_PAGE_OFF);
+
 	sriov_base_off = mana_gd_r64(gc, GDMA_SRIOV_REG_CFG_BASE_OFF);
 
 	sriov_base_va = gc->bar0_va + sriov_base_off;
diff --git a/drivers/net/ethernet/renesas/rtsn.c b/drivers/net/ethernet/renesas/rtsn.c
index 6b3f7fca8d15..05c4b6c8c9c3 100644
--- a/drivers/net/ethernet/renesas/rtsn.c
+++ b/drivers/net/ethernet/renesas/rtsn.c
@@ -1259,7 +1259,12 @@ static int rtsn_probe(struct platform_device *pdev)
 	priv = netdev_priv(ndev);
 	priv->pdev = pdev;
 	priv->ndev = ndev;
+
 	priv->ptp_priv = rcar_gen4_ptp_alloc(pdev);
+	if (!priv->ptp_priv) {
+		ret = -ENOMEM;
+		goto error_free;
+	}
 
 	spin_lock_init(&priv->lock);
 	platform_set_drvdata(pdev, priv);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 7840bc403788..5dcc95bc0ad2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -364,19 +364,17 @@ static int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
 	}
 
 	/* TX/RX NORMAL interrupts */
-	if (likely(intr_status & XGMAC_NIS)) {
-		if (likely(intr_status & XGMAC_RI)) {
-			u64_stats_update_begin(&stats->syncp);
-			u64_stats_inc(&stats->rx_normal_irq_n[chan]);
-			u64_stats_update_end(&stats->syncp);
-			ret |= handle_rx;
-		}
-		if (likely(intr_status & (XGMAC_TI | XGMAC_TBU))) {
-			u64_stats_update_begin(&stats->syncp);
-			u64_stats_inc(&stats->tx_normal_irq_n[chan]);
-			u64_stats_update_end(&stats->syncp);
-			ret |= handle_tx;
-		}
+	if (likely(intr_status & XGMAC_RI)) {
+		u64_stats_update_begin(&stats->syncp);
+		u64_stats_inc(&stats->rx_normal_irq_n[chan]);
+		u64_stats_update_end(&stats->syncp);
+		ret |= handle_rx;
+	}
+	if (likely(intr_status & (XGMAC_TI | XGMAC_TBU))) {
+		u64_stats_update_begin(&stats->syncp);
+		u64_stats_inc(&stats->tx_normal_irq_n[chan]);
+		u64_stats_update_end(&stats->syncp);
+		ret |= handle_tx;
 	}
 
 	/* Clear interrupts */
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 393cc5192e90..6b5cff087686 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -612,8 +612,6 @@ static struct sk_buff *am65_cpsw_build_skb(void *page_addr,
 {
 	struct sk_buff *skb;
 
-	len += AM65_CPSW_HEADROOM;
-
 	skb = build_skb(page_addr, len);
 	if (unlikely(!skb))
 		return NULL;
@@ -1217,7 +1215,7 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_rx_flow *flow,
 	}
 
 	skb = am65_cpsw_build_skb(page_addr, ndev,
-				  AM65_CPSW_MAX_PACKET_SIZE, headroom);
+				  PAGE_SIZE, headroom);
 	if (unlikely(!skb)) {
 		new_page = page;
 		goto requeue;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index ea2123ea6e38..e711797a3a8c 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1624,7 +1624,7 @@ static void wx_set_num_queues(struct wx *wx)
  */
 static int wx_acquire_msix_vectors(struct wx *wx)
 {
-	struct irq_affinity affd = { .pre_vectors = 1 };
+	struct irq_affinity affd = { .post_vectors = 1 };
 	int nvecs, i;
 
 	/* We start by asking for one vector per queue pair */
@@ -1661,16 +1661,17 @@ static int wx_acquire_msix_vectors(struct wx *wx)
 		return nvecs;
 	}
 
-	wx->msix_entry->entry = 0;
-	wx->msix_entry->vector = pci_irq_vector(wx->pdev, 0);
 	nvecs -= 1;
 	for (i = 0; i < nvecs; i++) {
 		wx->msix_q_entries[i].entry = i;
-		wx->msix_q_entries[i].vector = pci_irq_vector(wx->pdev, i + 1);
+		wx->msix_q_entries[i].vector = pci_irq_vector(wx->pdev, i);
 	}
 
 	wx->num_q_vectors = nvecs;
 
+	wx->msix_entry->entry = nvecs;
+	wx->msix_entry->vector = pci_irq_vector(wx->pdev, nvecs);
+
 	return 0;
 }
 
@@ -2120,7 +2121,6 @@ static void wx_set_ivar(struct wx *wx, s8 direction,
 		wr32(wx, WX_PX_MISC_IVAR, ivar);
 	} else {
 		/* tx or rx causes */
-		msix_vector += 1; /* offset for queue vectors */
 		msix_vector |= WX_PX_IVAR_ALLOC_VAL;
 		index = ((16 * (queue & 1)) + (8 * direction));
 		ivar = rd32(wx, WX_PX_IVAR(queue >> 1));
@@ -2151,7 +2151,7 @@ void wx_write_eitr(struct wx_q_vector *q_vector)
 
 	itr_reg |= WX_PX_ITR_CNT_WDIS;
 
-	wr32(wx, WX_PX_ITR(v_idx + 1), itr_reg);
+	wr32(wx, WX_PX_ITR(v_idx), itr_reg);
 }
 
 /**
@@ -2197,9 +2197,9 @@ void wx_configure_vectors(struct wx *wx)
 		wx_write_eitr(q_vector);
 	}
 
-	wx_set_ivar(wx, -1, 0, 0);
+	wx_set_ivar(wx, -1, 0, v_idx);
 	if (pdev->msix_enabled)
-		wr32(wx, WX_PX_ITR(0), 1950);
+		wr32(wx, WX_PX_ITR(v_idx), 1950);
 }
 EXPORT_SYMBOL(wx_configure_vectors);
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index b54bffda027b..dbac133eacfc 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1136,7 +1136,7 @@ struct wx {
 };
 
 #define WX_INTR_ALL (~0ULL)
-#define WX_INTR_Q(i) BIT((i) + 1)
+#define WX_INTR_Q(i) BIT((i))
 
 /* register operations */
 #define wr32(a, reg, value)	writel((value), ((a)->hw_addr + (reg)))
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 1be2a5cc4a83..d2fb77f1d876 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -154,7 +154,7 @@ static void ngbe_irq_enable(struct wx *wx, bool queues)
 	if (queues)
 		wx_intr_enable(wx, NGBE_INTR_ALL);
 	else
-		wx_intr_enable(wx, NGBE_INTR_MISC);
+		wx_intr_enable(wx, NGBE_INTR_MISC(wx));
 }
 
 /**
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
index f48ed7fc1805..f4dc4acbedae 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
@@ -80,7 +80,7 @@
 				NGBE_PX_MISC_IEN_GPIO)
 
 #define NGBE_INTR_ALL				0x1FF
-#define NGBE_INTR_MISC				BIT(0)
+#define NGBE_INTR_MISC(A)			BIT((A)->num_q_vectors)
 
 #define NGBE_PHY_CONFIG(reg_offset)		(0x14000 + ((reg_offset) * 4))
 #define NGBE_CFG_LAN_SPEED			0x14440
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index c698f4ec751a..76d33c042eee 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
@@ -21,7 +21,7 @@ void txgbe_irq_enable(struct wx *wx, bool queues)
 	wr32(wx, WX_PX_MISC_IEN, TXGBE_PX_MISC_IEN_MASK);
 
 	/* unmask interrupt */
-	wx_intr_enable(wx, TXGBE_INTR_MISC);
+	wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
 	if (queues)
 		wx_intr_enable(wx, TXGBE_INTR_QALL(wx));
 }
@@ -147,7 +147,7 @@ static irqreturn_t txgbe_misc_irq_thread_fn(int irq, void *data)
 		nhandled++;
 	}
 
-	wx_intr_enable(wx, TXGBE_INTR_MISC);
+	wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
 	return (nhandled > 0 ? IRQ_HANDLED : IRQ_NONE);
 }
 
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 8ea413a7abe9..5fe415f3f2ca 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -264,8 +264,8 @@ struct txgbe_fdir_filter {
 #define TXGBE_DEFAULT_RX_WORK           128
 #endif
 
-#define TXGBE_INTR_MISC       BIT(0)
-#define TXGBE_INTR_QALL(A)    GENMASK((A)->num_q_vectors, 1)
+#define TXGBE_INTR_MISC(A)    BIT((A)->num_q_vectors)
+#define TXGBE_INTR_QALL(A)    (TXGBE_INTR_MISC(A) - 1)
 
 #define TXGBE_MAX_EITR        GENMASK(11, 3)
 
diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index 1072e2210aed..6b93418224e7 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -1309,7 +1309,7 @@ ll_temac_ethtools_set_ringparam(struct net_device *ndev,
 	if (ering->rx_pending > RX_BD_NUM_MAX ||
 	    ering->rx_mini_pending ||
 	    ering->rx_jumbo_pending ||
-	    ering->rx_pending > TX_BD_NUM_MAX)
+	    ering->tx_pending > TX_BD_NUM_MAX)
 		return -EINVAL;
 
 	if (netif_running(ndev))
diff --git a/drivers/net/phy/microchip.c b/drivers/net/phy/microchip.c
index e3a5961dced9..ffca1cec4ec9 100644
--- a/drivers/net/phy/microchip.c
+++ b/drivers/net/phy/microchip.c
@@ -332,7 +332,7 @@ static void lan88xx_link_change_notify(struct phy_device *phydev)
 	 * As workaround, set to 10 before setting to 100
 	 * at forced 100 F/H mode.
 	 */
-	if (!phydev->autoneg && phydev->speed == 100) {
+	if (phydev->state == PHY_NOLINK && !phydev->autoneg && phydev->speed == 100) {
 		/* disable phy interrupt */
 		temp = phy_read(phydev, LAN88XX_INT_MASK);
 		temp &= ~LAN88XX_INT_MASK_MDINTPIN_EN_;
@@ -486,6 +486,7 @@ static struct phy_driver microchip_phy_driver[] = {
 	.config_init	= lan88xx_config_init,
 	.config_aneg	= lan88xx_config_aneg,
 	.link_change_notify = lan88xx_link_change_notify,
+	.soft_reset	= genphy_soft_reset,
 
 	/* Interrupt handling is broken, do not define related
 	 * functions to force polling.
diff --git a/drivers/net/phy/qcom/at803x.c b/drivers/net/phy/qcom/at803x.c
index 105602581a03..ac909ad8a87b 100644
--- a/drivers/net/phy/qcom/at803x.c
+++ b/drivers/net/phy/qcom/at803x.c
@@ -26,9 +26,6 @@
 
 #define AT803X_LED_CONTROL			0x18
 
-#define AT803X_PHY_MMD3_WOL_CTRL		0x8012
-#define AT803X_WOL_EN				BIT(5)
-
 #define AT803X_REG_CHIP_CONFIG			0x1f
 #define AT803X_BT_BX_REG_SEL			0x8000
 
@@ -866,30 +863,6 @@ static int at8031_config_init(struct phy_device *phydev)
 	return at803x_config_init(phydev);
 }
 
-static int at8031_set_wol(struct phy_device *phydev,
-			  struct ethtool_wolinfo *wol)
-{
-	int ret;
-
-	/* First setup MAC address and enable WOL interrupt */
-	ret = at803x_set_wol(phydev, wol);
-	if (ret)
-		return ret;
-
-	if (wol->wolopts & WAKE_MAGIC)
-		/* Enable WOL function for 1588 */
-		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
-				     AT803X_PHY_MMD3_WOL_CTRL,
-				     0, AT803X_WOL_EN);
-	else
-		/* Disable WoL function for 1588 */
-		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
-				     AT803X_PHY_MMD3_WOL_CTRL,
-				     AT803X_WOL_EN, 0);
-
-	return ret;
-}
-
 static int at8031_config_intr(struct phy_device *phydev)
 {
 	struct at803x_priv *priv = phydev->priv;
diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
index 5048304ccc9e..c3aad0e6b700 100644
--- a/drivers/net/phy/qcom/qca808x.c
+++ b/drivers/net/phy/qcom/qca808x.c
@@ -633,7 +633,7 @@ static struct phy_driver qca808x_driver[] = {
 	.handle_interrupt	= at803x_handle_interrupt,
 	.get_tunable		= at803x_get_tunable,
 	.set_tunable		= at803x_set_tunable,
-	.set_wol		= at803x_set_wol,
+	.set_wol		= at8031_set_wol,
 	.get_wol		= at803x_get_wol,
 	.get_features		= qca808x_get_features,
 	.config_aneg		= qca808x_config_aneg,
diff --git a/drivers/net/phy/qcom/qcom-phy-lib.c b/drivers/net/phy/qcom/qcom-phy-lib.c
index d28815ef56bb..af7d0d8e81be 100644
--- a/drivers/net/phy/qcom/qcom-phy-lib.c
+++ b/drivers/net/phy/qcom/qcom-phy-lib.c
@@ -115,6 +115,31 @@ int at803x_set_wol(struct phy_device *phydev,
 }
 EXPORT_SYMBOL_GPL(at803x_set_wol);
 
+int at8031_set_wol(struct phy_device *phydev,
+		   struct ethtool_wolinfo *wol)
+{
+	int ret;
+
+	/* First setup MAC address and enable WOL interrupt */
+	ret = at803x_set_wol(phydev, wol);
+	if (ret)
+		return ret;
+
+	if (wol->wolopts & WAKE_MAGIC)
+		/* Enable WOL function for 1588 */
+		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
+				     AT803X_PHY_MMD3_WOL_CTRL,
+				     0, AT803X_WOL_EN);
+	else
+		/* Disable WoL function for 1588 */
+		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
+				     AT803X_PHY_MMD3_WOL_CTRL,
+				     AT803X_WOL_EN, 0);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(at8031_set_wol);
+
 void at803x_get_wol(struct phy_device *phydev,
 		    struct ethtool_wolinfo *wol)
 {
diff --git a/drivers/net/phy/qcom/qcom.h b/drivers/net/phy/qcom/qcom.h
index 4bb541728846..7f7151c8baca 100644
--- a/drivers/net/phy/qcom/qcom.h
+++ b/drivers/net/phy/qcom/qcom.h
@@ -172,6 +172,9 @@
 #define AT803X_LOC_MAC_ADDR_16_31_OFFSET	0x804B
 #define AT803X_LOC_MAC_ADDR_32_47_OFFSET	0x804A
 
+#define AT803X_PHY_MMD3_WOL_CTRL		0x8012
+#define AT803X_WOL_EN				BIT(5)
+
 #define AT803X_DEBUG_ADDR			0x1D
 #define AT803X_DEBUG_DATA			0x1E
 
@@ -215,6 +218,8 @@ int at803x_debug_reg_mask(struct phy_device *phydev, u16 reg,
 int at803x_debug_reg_write(struct phy_device *phydev, u16 reg, u16 data);
 int at803x_set_wol(struct phy_device *phydev,
 		   struct ethtool_wolinfo *wol);
+int at8031_set_wol(struct phy_device *phydev,
+		   struct ethtool_wolinfo *wol);
 void at803x_get_wol(struct phy_device *phydev,
 		    struct ethtool_wolinfo *wol);
 int at803x_ack_interrupt(struct phy_device *phydev);
diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index 150aea7c9c36..6a43f6d6e85c 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -155,10 +155,29 @@ static int smsc_phy_reset(struct phy_device *phydev)
 
 static int lan87xx_config_aneg(struct phy_device *phydev)
 {
-	int rc;
+	u8 mdix_ctrl;
 	int val;
+	int rc;
+
+	/* When auto-negotiation is disabled (forced mode), the PHY's
+	 * Auto-MDIX will continue toggling the TX/RX pairs.
+	 *
+	 * To establish a stable link, we must select a fixed MDI mode.
+	 * If the user has not specified a fixed MDI mode (i.e., mdix_ctrl is
+	 * 'auto'), we default to ETH_TP_MDI. This choice of a ETH_TP_MDI mode
+	 * mirrors the behavior the hardware would exhibit if the AUTOMDIX_EN
+	 * strap were configured for a fixed MDI connection.
+	 */
+	if (phydev->autoneg == AUTONEG_DISABLE) {
+		if (phydev->mdix_ctrl == ETH_TP_MDI_AUTO)
+			mdix_ctrl = ETH_TP_MDI;
+		else
+			mdix_ctrl = phydev->mdix_ctrl;
+	} else {
+		mdix_ctrl = phydev->mdix_ctrl;
+	}
 
-	switch (phydev->mdix_ctrl) {
+	switch (mdix_ctrl) {
 	case ETH_TP_MDI:
 		val = SPECIAL_CTRL_STS_OVRRD_AMDIX_;
 		break;
@@ -167,7 +186,8 @@ static int lan87xx_config_aneg(struct phy_device *phydev)
 			SPECIAL_CTRL_STS_AMDIX_STATE_;
 		break;
 	case ETH_TP_MDI_AUTO:
-		val = SPECIAL_CTRL_STS_AMDIX_ENABLE_;
+		val = SPECIAL_CTRL_STS_OVRRD_AMDIX_ |
+			SPECIAL_CTRL_STS_AMDIX_ENABLE_;
 		break;
 	default:
 		return genphy_config_aneg(phydev);
@@ -183,7 +203,7 @@ static int lan87xx_config_aneg(struct phy_device *phydev)
 	rc |= val;
 	phy_write(phydev, SPECIAL_CTRL_STS, rc);
 
-	phydev->mdix = phydev->mdix_ctrl;
+	phydev->mdix = mdix_ctrl;
 	return genphy_config_aneg(phydev);
 }
 
@@ -261,6 +281,33 @@ int lan87xx_read_status(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(lan87xx_read_status);
 
+static int lan87xx_phy_config_init(struct phy_device *phydev)
+{
+	int rc;
+
+	/* The LAN87xx PHY's initial MDI-X mode is determined by the AUTOMDIX_EN
+	 * hardware strap, but the driver cannot read the strap's status. This
+	 * creates an unpredictable initial state.
+	 *
+	 * To ensure consistent and reliable behavior across all boards,
+	 * override the strap configuration on initialization and force the PHY
+	 * into a known state with Auto-MDIX enabled, which is the expected
+	 * default for modern hardware.
+	 */
+	rc = phy_modify(phydev, SPECIAL_CTRL_STS,
+			SPECIAL_CTRL_STS_OVRRD_AMDIX_ |
+			SPECIAL_CTRL_STS_AMDIX_ENABLE_ |
+			SPECIAL_CTRL_STS_AMDIX_STATE_,
+			SPECIAL_CTRL_STS_OVRRD_AMDIX_ |
+			SPECIAL_CTRL_STS_AMDIX_ENABLE_);
+	if (rc < 0)
+		return rc;
+
+	phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
+
+	return smsc_phy_config_init(phydev);
+}
+
 static int lan874x_phy_config_init(struct phy_device *phydev)
 {
 	u16 val;
@@ -694,7 +741,7 @@ static struct phy_driver smsc_phy_driver[] = {
 
 	/* basic functions */
 	.read_status	= lan87xx_read_status,
-	.config_init	= smsc_phy_config_init,
+	.config_init	= lan87xx_phy_config_init,
 	.soft_reset	= smsc_phy_reset,
 	.config_aneg	= lan87xx_config_aneg,
 
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 944a33361dae..7e0608f56835 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1426,6 +1426,7 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x22de, 0x9051, 2)}, /* Hucom Wireless HM-211S/K */
 	{QMI_FIXED_INTF(0x22de, 0x9061, 3)},	/* WeTelecom WPD-600N */
 	{QMI_QUIRK_SET_DTR(0x1e0e, 0x9001, 5)},	/* SIMCom 7100E, 7230E, 7600E ++ */
+	{QMI_QUIRK_SET_DTR(0x1e0e, 0x9071, 3)},	/* SIMCom 8230C ++ */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0121, 4)},	/* Quectel EC21 Mini PCIe */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0191, 4)},	/* Quectel EG91 */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0195, 4)},	/* Quectel EG95 */
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index 1f1f6280a0f2..86e20edb593b 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -477,7 +477,9 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
 				    "auth: receive authentication from %pM\n",
 				    ieee_hdr->addr3);
 		} else {
-			if (!priv->wdev.connected)
+			if (!priv->wdev.connected ||
+			    !ether_addr_equal(ieee_hdr->addr3,
+					      priv->curr_bss_params.bss_descriptor.mac_address))
 				return 0;
 
 			if (ieee80211_is_deauth(ieee_hdr->frame_control)) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 452579ccc492..a6324f6ead78 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1696,8 +1696,8 @@ int mt76_connac_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		if (!sreq->ssids[i].ssid_len)
 			continue;
 
-		req->ssids[i].ssid_len = cpu_to_le32(sreq->ssids[i].ssid_len);
-		memcpy(req->ssids[i].ssid, sreq->ssids[i].ssid,
+		req->ssids[n_ssids].ssid_len = cpu_to_le32(sreq->ssids[i].ssid_len);
+		memcpy(req->ssids[n_ssids].ssid, sreq->ssids[i].ssid,
 		       sreq->ssids[i].ssid_len);
 		n_ssids++;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 9c245c23a2d7..5b832f1aa00d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1173,6 +1173,9 @@ static void mt7921_sta_set_decap_offload(struct ieee80211_hw *hw,
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
+	if (!msta->deflink.wcid.sta)
+		return;
+
 	mt792x_mutex_acquire(dev);
 
 	if (enabled)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index 14553dcc61c5..02899320da5c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -52,6 +52,8 @@ static int mt7925_thermal_init(struct mt792x_phy *phy)
 
 	name = devm_kasprintf(&wiphy->dev, GFP_KERNEL, "mt7925_%s",
 			      wiphy_name(wiphy));
+	if (!name)
+		return -ENOMEM;
 
 	hwmon = devm_hwmon_device_register_with_groups(&wiphy->dev, name, phy,
 						       mt7925_hwmon_groups);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index d2a98c92e114..ca5f1dc05815 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1565,6 +1565,9 @@ static void mt7925_sta_set_decap_offload(struct ieee80211_hw *hw,
 	unsigned long valid = mvif->valid_links;
 	u8 i;
 
+	if (!msta->vif)
+		return;
+
 	mt792x_mutex_acquire(dev);
 
 	valid = ieee80211_vif_is_mld(vif) ? mvif->valid_links : BIT(0);
@@ -1579,6 +1582,9 @@ static void mt7925_sta_set_decap_offload(struct ieee80211_hw *hw,
 		else
 			clear_bit(MT_WCID_FLAG_HDR_TRANS, &mlink->wcid.flags);
 
+		if (!mlink->wcid.sta)
+			continue;
+
 		mt7925_mcu_wtbl_update_hdr_trans(dev, vif, sta, i);
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 57a1db394dda..2aeb9ba4256a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2823,8 +2823,8 @@ int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		if (!sreq->ssids[i].ssid_len)
 			continue;
 
-		ssid->ssids[i].ssid_len = cpu_to_le32(sreq->ssids[i].ssid_len);
-		memcpy(ssid->ssids[i].ssid, sreq->ssids[i].ssid,
+		ssid->ssids[n_ssids].ssid_len = cpu_to_le32(sreq->ssids[i].ssid_len);
+		memcpy(ssid->ssids[n_ssids].ssid, sreq->ssids[i].ssid,
 		       sreq->ssids[i].ssid_len);
 		n_ssids++;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/regs.h b/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
index 547489092c29..341987e47f67 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
@@ -58,7 +58,7 @@
 
 #define MT_INT_TX_DONE_MCU		(MT_INT_TX_DONE_MCU_WM |	\
 					 MT_INT_TX_DONE_FWDL)
-#define MT_INT_TX_DONE_ALL		(MT_INT_TX_DONE_MCU_WM |	\
+#define MT_INT_TX_DONE_ALL		(MT_INT_TX_DONE_MCU |	\
 					 MT_INT_TX_DONE_BAND0 |	\
 					GENMASK(18, 4))
 
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00soc.c b/drivers/net/wireless/ralink/rt2x00/rt2x00soc.c
index eface610178d..f7f3a2340c39 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00soc.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00soc.c
@@ -108,7 +108,7 @@ int rt2x00soc_probe(struct platform_device *pdev, const struct rt2x00_ops *ops)
 }
 EXPORT_SYMBOL_GPL(rt2x00soc_probe);
 
-int rt2x00soc_remove(struct platform_device *pdev)
+void rt2x00soc_remove(struct platform_device *pdev)
 {
 	struct ieee80211_hw *hw = platform_get_drvdata(pdev);
 	struct rt2x00_dev *rt2x00dev = hw->priv;
@@ -119,8 +119,6 @@ int rt2x00soc_remove(struct platform_device *pdev)
 	rt2x00lib_remove_dev(rt2x00dev);
 	rt2x00soc_free_reg(rt2x00dev);
 	ieee80211_free_hw(hw);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(rt2x00soc_remove);
 
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00soc.h b/drivers/net/wireless/ralink/rt2x00/rt2x00soc.h
index 021fd06b3627..d6226b8a10e0 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00soc.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00soc.h
@@ -17,7 +17,7 @@
  * SoC driver handlers.
  */
 int rt2x00soc_probe(struct platform_device *pdev, const struct rt2x00_ops *ops);
-int rt2x00soc_remove(struct platform_device *pdev);
+void rt2x00soc_remove(struct platform_device *pdev);
 #ifdef CONFIG_PM
 int rt2x00soc_suspend(struct platform_device *pdev, pm_message_t state);
 int rt2x00soc_resume(struct platform_device *pdev);
diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_mac.c b/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
index f90c33d19b39..8fd7be37e209 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
@@ -583,7 +583,11 @@ void zd_mac_tx_to_dev(struct sk_buff *skb, int error)
 
 		skb_queue_tail(q, skb);
 		while (skb_queue_len(q) > ZD_MAC_MAX_ACK_WAITERS) {
-			zd_mac_tx_status(hw, skb_dequeue(q),
+			skb = skb_dequeue(q);
+			if (!skb)
+				break;
+
+			zd_mac_tx_status(hw, skb,
 					 mac->ack_pending ? mac->ack_signal : 0,
 					 NULL);
 			mac->ack_pending = 0;
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index b78e0e417324..af370628e583 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1676,19 +1676,24 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		return NULL;
 
 	root_ops = kzalloc(sizeof(*root_ops), GFP_KERNEL);
-	if (!root_ops)
-		goto free_ri;
+	if (!root_ops) {
+		kfree(ri);
+		return NULL;
+	}
 
 	ri->cfg = pci_acpi_setup_ecam_mapping(root);
-	if (!ri->cfg)
-		goto free_root_ops;
+	if (!ri->cfg) {
+		kfree(ri);
+		kfree(root_ops);
+		return NULL;
+	}
 
 	root_ops->release_info = pci_acpi_generic_release_info;
 	root_ops->prepare_resources = pci_acpi_root_prepare_resources;
 	root_ops->pci_ops = (struct pci_ops *)&ri->cfg->ops->pci_ops;
 	bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
 	if (!bus)
-		goto free_cfg;
+		return NULL;
 
 	/* If we must preserve the resource configuration, claim now */
 	host = pci_find_host_bridge(bus);
@@ -1705,14 +1710,6 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		pcie_bus_configure_settings(child);
 
 	return bus;
-
-free_cfg:
-	pci_ecam_free(ri->cfg);
-free_root_ops:
-	kfree(root_ops);
-free_ri:
-	kfree(ri);
-	return NULL;
 }
 
 void pcibios_add_bus(struct pci_bus *bus)
diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index a12766b3bc8a..debf36ce5785 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -933,6 +933,17 @@ static int amd_gpio_suspend_hibernate_common(struct device *dev, bool is_suspend
 				  pin, is_suspend ? "suspend" : "hibernate");
 		}
 
+		/*
+		 * debounce enabled over suspend has shown issues with a GPIO
+		 * being unable to wake the system, as we're only interested in
+		 * the actual wakeup event, clear it.
+		 */
+		if (gpio_dev->saved_regs[i] & (DB_CNTRl_MASK << DB_CNTRL_OFF)) {
+			amd_gpio_set_debounce(gpio_dev, pin, 0);
+			pm_pr_dbg("Clearing debounce for GPIO #%d during %s.\n",
+				  pin, is_suspend ? "suspend" : "hibernate");
+		}
+
 		raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
 	}
 
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 018e96d921c0..553232809789 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1035,6 +1035,25 @@ static bool msm_gpio_needs_dual_edge_parent_workaround(struct irq_data *d,
 	       test_bit(d->hwirq, pctrl->skip_wake_irqs);
 }
 
+static void msm_gpio_irq_init_valid_mask(struct gpio_chip *gc,
+					 unsigned long *valid_mask,
+					 unsigned int ngpios)
+{
+	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
+	const struct msm_pingroup *g;
+	int i;
+
+	bitmap_fill(valid_mask, ngpios);
+
+	for (i = 0; i < ngpios; i++) {
+		g = &pctrl->soc->groups[i];
+
+		if (g->intr_detection_width != 1 &&
+		    g->intr_detection_width != 2)
+			clear_bit(i, valid_mask);
+	}
+}
+
 static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
@@ -1438,6 +1457,7 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 	girq->default_type = IRQ_TYPE_NONE;
 	girq->handler = handle_bad_irq;
 	girq->parents[0] = pctrl->irq;
+	girq->init_valid_mask = msm_gpio_irq_init_valid_mask;
 
 	ret = gpiochip_add_data(&pctrl->chip, pctrl);
 	if (ret) {
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 174939359ae3..3697781c0179 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -148,7 +148,7 @@ static bool pwm_state_valid(const struct pwm_state *state)
 	 * and supposed to be ignored. So also ignore any strange values and
 	 * consider the state ok.
 	 */
-	if (state->enabled)
+	if (!state->enabled)
 		return true;
 
 	if (!state->period)
diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 7eaab5831499..33d3554b9197 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -130,8 +130,10 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		return ret;
 
 	clk_rate = clk_get_rate(pc->clk_pwms[pwm->hwpwm]);
-	if (!clk_rate)
-		return -EINVAL;
+	if (!clk_rate) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	/* Make sure we use the bus clock and not the 26MHz clock */
 	if (pc->soc->has_ck_26m_sel)
@@ -150,9 +152,9 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	if (clkdiv > PWM_CLK_DIV_MAX) {
-		pwm_mediatek_clk_disable(chip, pwm);
 		dev_err(pwmchip_parent(chip), "period of %d ns not supported\n", period_ns);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	if (pc->soc->pwm45_fixup && pwm->hwpwm > 2) {
@@ -169,9 +171,10 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	pwm_mediatek_writel(pc, pwm->hwpwm, reg_width, cnt_period);
 	pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, cnt_duty);
 
+out:
 	pwm_mediatek_clk_disable(chip, pwm);
 
-	return 0;
+	return ret;
 }
 
 static int pwm_mediatek_enable(struct pwm_chip *chip, struct pwm_device *pwm)
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index be5564ed8c01..5b09ce71345b 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4566,6 +4566,7 @@ void do_unblank_screen(int leaving_gfx)
 	set_palette(vc);
 	set_cursor(vc);
 	vt_event_post(VT_EVENT_UNBLANK, vc->vc_num, vc->vc_num);
+	notify_update(vc);
 }
 EXPORT_SYMBOL(do_unblank_screen);
 
diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 53d9fc41acc5..2412f81f4412 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -294,8 +294,8 @@ __acquires(&port->port_lock)
 			break;
 	}
 
-	if (do_tty_wake && port->port.tty)
-		tty_wakeup(port->port.tty);
+	if (do_tty_wake)
+		tty_port_tty_wakeup(&port->port);
 	return status;
 }
 
@@ -543,20 +543,16 @@ static int gs_alloc_requests(struct usb_ep *ep, struct list_head *head,
 static int gs_start_io(struct gs_port *port)
 {
 	struct list_head	*head = &port->read_pool;
-	struct usb_ep		*ep;
+	struct usb_ep		*ep = port->port_usb->out;
 	int			status;
 	unsigned		started;
 
-	if (!port->port_usb || !port->port.tty)
-		return -EIO;
-
 	/* Allocate RX and TX I/O buffers.  We can't easily do this much
 	 * earlier (with GFP_KERNEL) because the requests are coupled to
 	 * endpoints, as are the packet sizes we'll be using.  Different
 	 * configurations may use different endpoints with a given port;
 	 * and high speed vs full speed changes packet sizes too.
 	 */
-	ep = port->port_usb->out;
 	status = gs_alloc_requests(ep, head, gs_read_complete,
 		&port->read_allocated);
 	if (status)
@@ -577,7 +573,7 @@ static int gs_start_io(struct gs_port *port)
 		gs_start_tx(port);
 		/* Unblock any pending writes into our circular buffer, in case
 		 * we didn't in gs_start_tx() */
-		tty_wakeup(port->port.tty);
+		tty_port_tty_wakeup(&port->port);
 	} else {
 		/* Free reqs only if we are still connected */
 		if (port->port_usb) {
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 7ba50e133921..308abbf8855b 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1104,11 +1104,21 @@ static int populate_free_space_tree(struct btrfs_trans_handle *trans,
 	ret = btrfs_search_slot_for_read(extent_root, &key, path, 1, 0);
 	if (ret < 0)
 		goto out_locked;
-	ASSERT(ret == 0);
+	/*
+	 * If ret is 1 (no key found), it means this is an empty block group,
+	 * without any extents allocated from it and there's no block group
+	 * item (key BTRFS_BLOCK_GROUP_ITEM_KEY) located in the extent tree
+	 * because we are using the block group tree feature, so block group
+	 * items are stored in the block group tree. It also means there are no
+	 * extents allocated for block groups with a start offset beyond this
+	 * block group's end offset (this is the last, highest, block group).
+	 */
+	if (!btrfs_fs_compat_ro(trans->fs_info, BLOCK_GROUP_TREE))
+		ASSERT(ret == 0);
 
 	start = block_group->start;
 	end = block_group->start + block_group->length;
-	while (1) {
+	while (ret == 0) {
 		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
 
 		if (key.type == BTRFS_EXTENT_ITEM_KEY ||
@@ -1138,8 +1148,6 @@ static int populate_free_space_tree(struct btrfs_trans_handle *trans,
 		ret = btrfs_next_item(extent_root, path);
 		if (ret < 0)
 			goto out_locked;
-		if (ret)
-			break;
 	}
 	if (start < end) {
 		ret = __add_to_free_space_tree(trans, block_group, path2,
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 722151d3fee8..91182d5e3a66 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -240,9 +240,11 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 
 /*
  * bit 30: I/O error occurred on this folio
+ * bit 29: CPU has dirty data in D-cache (needs aliasing handling);
  * bit 0 - 29: remaining parts to complete this folio
  */
-#define EROFS_ONLINEFOLIO_EIO			(1 << 30)
+#define EROFS_ONLINEFOLIO_EIO		30
+#define EROFS_ONLINEFOLIO_DIRTY		29
 
 void erofs_onlinefolio_init(struct folio *folio)
 {
@@ -259,19 +261,23 @@ void erofs_onlinefolio_split(struct folio *folio)
 	atomic_inc((atomic_t *)&folio->private);
 }
 
-void erofs_onlinefolio_end(struct folio *folio, int err)
+void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
 {
 	int orig, v;
 
 	do {
 		orig = atomic_read((atomic_t *)&folio->private);
-		v = (orig - 1) | (err ? EROFS_ONLINEFOLIO_EIO : 0);
+		DBG_BUGON(orig <= 0);
+		v = dirty << EROFS_ONLINEFOLIO_DIRTY;
+		v |= (orig - 1) | (!!err << EROFS_ONLINEFOLIO_EIO);
 	} while (atomic_cmpxchg((atomic_t *)&folio->private, orig, v) != orig);
 
-	if (v & ~EROFS_ONLINEFOLIO_EIO)
+	if (v & (BIT(EROFS_ONLINEFOLIO_DIRTY) - 1))
 		return;
 	folio->private = 0;
-	folio_end_read(folio, !(v & EROFS_ONLINEFOLIO_EIO));
+	if (v & BIT(EROFS_ONLINEFOLIO_DIRTY))
+		flush_dcache_folio(folio);
+	folio_end_read(folio, !(v & BIT(EROFS_ONLINEFOLIO_EIO)));
 }
 
 static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
@@ -378,11 +384,16 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
  */
 static int erofs_read_folio(struct file *file, struct folio *folio)
 {
+	trace_erofs_read_folio(folio, true);
+
 	return iomap_read_folio(folio, &erofs_iomap_ops);
 }
 
 static void erofs_readahead(struct readahead_control *rac)
 {
+	trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
+					readahead_count(rac), true);
+
 	return iomap_readahead(rac, &erofs_iomap_ops);
 }
 
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index eb318c7ddd80..dc61a6a8f696 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -331,13 +331,11 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 		cur = min(cur, rq->outputsize);
 		if (cur && rq->out[0]) {
 			kin = kmap_local_page(rq->in[nrpages_in - 1]);
-			if (rq->out[0] == rq->in[nrpages_in - 1]) {
+			if (rq->out[0] == rq->in[nrpages_in - 1])
 				memmove(kin + rq->pageofs_out, kin + pi, cur);
-				flush_dcache_page(rq->out[0]);
-			} else {
+			else
 				memcpy_to_page(rq->out[0], rq->pageofs_out,
 					       kin + pi, cur);
-			}
 			kunmap_local(kin);
 		}
 		rq->outputsize -= cur;
@@ -355,14 +353,12 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 			po = (rq->pageofs_out + cur + pi) & ~PAGE_MASK;
 			DBG_BUGON(no >= nrpages_out);
 			cnt = min(insz - pi, PAGE_SIZE - po);
-			if (rq->out[no] == rq->in[ni]) {
+			if (rq->out[no] == rq->in[ni])
 				memmove(kin + po,
 					kin + rq->pageofs_in + pi, cnt);
-				flush_dcache_page(rq->out[no]);
-			} else if (rq->out[no]) {
+			else if (rq->out[no])
 				memcpy_to_page(rq->out[no], po,
 					       kin + rq->pageofs_in + pi, cnt);
-			}
 			pi += cnt;
 		} while (pi < insz);
 		kunmap_local(kin);
diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index 12e709d93445..c865a7a61030 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -38,7 +38,7 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
 	} else {
 		bio_for_each_folio_all(fi, &rq->bio) {
 			DBG_BUGON(folio_test_uptodate(fi.folio));
-			erofs_onlinefolio_end(fi.folio, ret);
+			erofs_onlinefolio_end(fi.folio, ret, false);
 		}
 	}
 	bio_uninit(&rq->bio);
@@ -158,7 +158,7 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
 		}
 		cur += len;
 	}
-	erofs_onlinefolio_end(folio, err);
+	erofs_onlinefolio_end(folio, err, false);
 	return err;
 }
 
@@ -180,7 +180,7 @@ static void erofs_fileio_readahead(struct readahead_control *rac)
 	struct folio *folio;
 	int err;
 
-	trace_erofs_readpages(inode, readahead_index(rac),
+	trace_erofs_readahead(inode, readahead_index(rac),
 			      readahead_count(rac), true);
 	while ((folio = readahead_folio(rac))) {
 		err = erofs_fileio_scan_folio(&io, folio);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 2c11e8f3048e..3d06fda70f31 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -405,7 +405,7 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map);
 void erofs_onlinefolio_init(struct folio *folio);
 void erofs_onlinefolio_split(struct folio *folio);
-void erofs_onlinefolio_end(struct folio *folio, int err);
+void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty);
 struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid);
 int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		  struct kstat *stat, u32 request_mask,
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 74521d7dbee1..94c1e2d64df9 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -12,12 +12,6 @@
 #define Z_EROFS_PCLUSTER_MAX_PAGES	(Z_EROFS_PCLUSTER_MAX_SIZE / PAGE_SIZE)
 #define Z_EROFS_INLINE_BVECS		2
 
-/*
- * let's leave a type here in case of introducing
- * another tagged pointer later.
- */
-typedef void *z_erofs_next_pcluster_t;
-
 struct z_erofs_bvec {
 	struct page *page;
 	int offset;
@@ -48,7 +42,7 @@ struct z_erofs_pcluster {
 	struct lockref lockref;
 
 	/* A: point to next chained pcluster or TAILs */
-	z_erofs_next_pcluster_t next;
+	struct z_erofs_pcluster *next;
 
 	/* I: start block address of this pcluster */
 	erofs_off_t index;
@@ -91,12 +85,11 @@ struct z_erofs_pcluster {
 
 /* the end of a chain of pclusters */
 #define Z_EROFS_PCLUSTER_TAIL           ((void *) 0x700 + POISON_POINTER_DELTA)
-#define Z_EROFS_PCLUSTER_NIL            (NULL)
 
 struct z_erofs_decompressqueue {
 	struct super_block *sb;
+	struct z_erofs_pcluster *head;
 	atomic_t pending_bios;
-	z_erofs_next_pcluster_t head;
 
 	union {
 		struct completion done;
@@ -460,39 +453,32 @@ int __init z_erofs_init_subsystem(void)
 }
 
 enum z_erofs_pclustermode {
+	/* It has previously been linked into another processing chain */
 	Z_EROFS_PCLUSTER_INFLIGHT,
 	/*
-	 * a weak form of Z_EROFS_PCLUSTER_FOLLOWED, the difference is that it
-	 * could be dispatched into bypass queue later due to uptodated managed
-	 * pages. All related online pages cannot be reused for inplace I/O (or
-	 * bvpage) since it can be directly decoded without I/O submission.
+	 * A weaker form of Z_EROFS_PCLUSTER_FOLLOWED; the difference is that it
+	 * may be dispatched to the bypass queue later due to uptodated managed
+	 * folios.  All file-backed folios related to this pcluster cannot be
+	 * reused for in-place I/O (or bvpage) since the pcluster may be decoded
+	 * in a separate queue (and thus out of order).
 	 */
 	Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE,
 	/*
-	 * The pcluster was just linked to a decompression chain by us.  It can
-	 * also be linked with the remaining pclusters, which means if the
-	 * processing page is the tail page of a pcluster, this pcluster can
-	 * safely use the whole page (since the previous pcluster is within the
-	 * same chain) for in-place I/O, as illustrated below:
-	 *  ___________________________________________________
-	 * |  tail (partial) page  |    head (partial) page    |
-	 * |  (of the current pcl) |   (of the previous pcl)   |
-	 * |___PCLUSTER_FOLLOWED___|_____PCLUSTER_FOLLOWED_____|
-	 *
-	 * [  (*) the page above can be used as inplace I/O.   ]
+	 * The pcluster has just been linked to our processing chain.
+	 * File-backed folios (except for the head page) related to it can be
+	 * used for in-place I/O (or bvpage).
 	 */
 	Z_EROFS_PCLUSTER_FOLLOWED,
 };
 
-struct z_erofs_decompress_frontend {
+struct z_erofs_frontend {
 	struct inode *const inode;
 	struct erofs_map_blocks map;
 	struct z_erofs_bvec_iter biter;
 
 	struct page *pagepool;
 	struct page *candidate_bvpage;
-	struct z_erofs_pcluster *pcl;
-	z_erofs_next_pcluster_t owned_head;
+	struct z_erofs_pcluster *pcl, *head;
 	enum z_erofs_pclustermode mode;
 
 	erofs_off_t headoffset;
@@ -501,11 +487,11 @@ struct z_erofs_decompress_frontend {
 	unsigned int icur;
 };
 
-#define DECOMPRESS_FRONTEND_INIT(__i) { \
-	.inode = __i, .owned_head = Z_EROFS_PCLUSTER_TAIL, \
-	.mode = Z_EROFS_PCLUSTER_FOLLOWED }
+#define Z_EROFS_DEFINE_FRONTEND(fe, i, ho) struct z_erofs_frontend fe = { \
+	.inode = i, .head = Z_EROFS_PCLUSTER_TAIL, \
+	.mode = Z_EROFS_PCLUSTER_FOLLOWED, .headoffset = ho }
 
-static bool z_erofs_should_alloc_cache(struct z_erofs_decompress_frontend *fe)
+static bool z_erofs_should_alloc_cache(struct z_erofs_frontend *fe)
 {
 	unsigned int cachestrategy = EROFS_I_SB(fe->inode)->opt.cache_strategy;
 
@@ -522,7 +508,7 @@ static bool z_erofs_should_alloc_cache(struct z_erofs_decompress_frontend *fe)
 	return false;
 }
 
-static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe)
+static void z_erofs_bind_cache(struct z_erofs_frontend *fe)
 {
 	struct address_space *mc = MNGD_MAPPING(EROFS_I_SB(fe->inode));
 	struct z_erofs_pcluster *pcl = fe->pcl;
@@ -679,7 +665,7 @@ int z_erofs_init_super(struct super_block *sb)
 }
 
 /* callers must be with pcluster lock held */
-static int z_erofs_attach_page(struct z_erofs_decompress_frontend *fe,
+static int z_erofs_attach_page(struct z_erofs_frontend *fe,
 			       struct z_erofs_bvec *bvec, bool exclusive)
 {
 	struct z_erofs_pcluster *pcl = fe->pcl;
@@ -725,7 +711,7 @@ static bool z_erofs_get_pcluster(struct z_erofs_pcluster *pcl)
 	return true;
 }
 
-static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
+static int z_erofs_register_pcluster(struct z_erofs_frontend *fe)
 {
 	struct erofs_map_blocks *map = &fe->map;
 	struct super_block *sb = fe->inode->i_sb;
@@ -750,9 +736,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 	pcl->algorithmformat = map->m_algorithmformat;
 	pcl->length = 0;
 	pcl->partial = true;
-
-	/* new pclusters should be claimed as type 1, primary and followed */
-	pcl->next = fe->owned_head;
+	pcl->next = fe->head;
 	pcl->pageofs_out = map->m_la & ~PAGE_MASK;
 	fe->mode = Z_EROFS_PCLUSTER_FOLLOWED;
 
@@ -788,8 +772,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 			goto err_out;
 		}
 	}
-	fe->owned_head = &pcl->next;
-	fe->pcl = pcl;
+	fe->head = fe->pcl = pcl;
 	return 0;
 
 err_out:
@@ -798,7 +781,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 	return err;
 }
 
-static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
+static int z_erofs_pcluster_begin(struct z_erofs_frontend *fe)
 {
 	struct erofs_map_blocks *map = &fe->map;
 	struct super_block *sb = fe->inode->i_sb;
@@ -808,7 +791,7 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
 
 	DBG_BUGON(fe->pcl);
 	/* must be Z_EROFS_PCLUSTER_TAIL or pointed to previous pcluster */
-	DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_NIL);
+	DBG_BUGON(!fe->head);
 
 	if (!(map->m_flags & EROFS_MAP_META)) {
 		while (1) {
@@ -836,10 +819,9 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
 	if (ret == -EEXIST) {
 		mutex_lock(&fe->pcl->lock);
 		/* check if this pcluster hasn't been linked into any chain. */
-		if (cmpxchg(&fe->pcl->next, Z_EROFS_PCLUSTER_NIL,
-			    fe->owned_head) == Z_EROFS_PCLUSTER_NIL) {
+		if (!cmpxchg(&fe->pcl->next, NULL, fe->head)) {
 			/* .. so it can be attached to our submission chain */
-			fe->owned_head = &fe->pcl->next;
+			fe->head = fe->pcl;
 			fe->mode = Z_EROFS_PCLUSTER_FOLLOWED;
 		} else {	/* otherwise, it belongs to an inflight chain */
 			fe->mode = Z_EROFS_PCLUSTER_INFLIGHT;
@@ -872,24 +854,16 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
 	return 0;
 }
 
-/*
- * keep in mind that no referenced pclusters will be freed
- * only after a RCU grace period.
- */
 static void z_erofs_rcu_callback(struct rcu_head *head)
 {
-	z_erofs_free_pcluster(container_of(head,
-			struct z_erofs_pcluster, rcu));
+	z_erofs_free_pcluster(container_of(head, struct z_erofs_pcluster, rcu));
 }
 
-static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
+static bool __erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
 					  struct z_erofs_pcluster *pcl)
 {
-	int free = false;
-
-	spin_lock(&pcl->lockref.lock);
 	if (pcl->lockref.count)
-		goto out;
+		return false;
 
 	/*
 	 * Note that all cached folios should be detached before deleted from
@@ -897,7 +871,7 @@ static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
 	 * orphan old pcluster when the new one is available in the tree.
 	 */
 	if (erofs_try_to_free_all_cached_folios(sbi, pcl))
-		goto out;
+		return false;
 
 	/*
 	 * It's impossible to fail after the pcluster is freezed, but in order
@@ -906,8 +880,16 @@ static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
 	DBG_BUGON(__xa_erase(&sbi->managed_pslots, pcl->index) != pcl);
 
 	lockref_mark_dead(&pcl->lockref);
-	free = true;
-out:
+	return true;
+}
+
+static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
+					  struct z_erofs_pcluster *pcl)
+{
+	bool free;
+
+	spin_lock(&pcl->lockref.lock);
+	free = __erofs_try_to_release_pcluster(sbi, pcl);
 	spin_unlock(&pcl->lockref.lock);
 	if (free) {
 		atomic_long_dec(&erofs_global_shrink_cnt);
@@ -916,8 +898,7 @@ static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
 	return free;
 }
 
-unsigned long z_erofs_shrink_scan(struct erofs_sb_info *sbi,
-				  unsigned long nr_shrink)
+unsigned long z_erofs_shrink_scan(struct erofs_sb_info *sbi, unsigned long nr)
 {
 	struct z_erofs_pcluster *pcl;
 	unsigned long index, freed = 0;
@@ -930,7 +911,7 @@ unsigned long z_erofs_shrink_scan(struct erofs_sb_info *sbi,
 		xa_unlock(&sbi->managed_pslots);
 
 		++freed;
-		if (!--nr_shrink)
+		if (!--nr)
 			return freed;
 		xa_lock(&sbi->managed_pslots);
 	}
@@ -938,19 +919,28 @@ unsigned long z_erofs_shrink_scan(struct erofs_sb_info *sbi,
 	return freed;
 }
 
-static void z_erofs_put_pcluster(struct z_erofs_pcluster *pcl)
+static void z_erofs_put_pcluster(struct erofs_sb_info *sbi,
+		struct z_erofs_pcluster *pcl, bool try_free)
 {
+	bool free = false;
+
 	if (lockref_put_or_lock(&pcl->lockref))
 		return;
 
 	DBG_BUGON(__lockref_is_dead(&pcl->lockref));
-	if (pcl->lockref.count == 1)
-		atomic_long_inc(&erofs_global_shrink_cnt);
-	--pcl->lockref.count;
+	if (!--pcl->lockref.count) {
+		if (try_free && xa_trylock(&sbi->managed_pslots)) {
+			free = __erofs_try_to_release_pcluster(sbi, pcl);
+			xa_unlock(&sbi->managed_pslots);
+		}
+		atomic_long_add(!free, &erofs_global_shrink_cnt);
+	}
 	spin_unlock(&pcl->lockref.lock);
+	if (free)
+		call_rcu(&pcl->rcu, z_erofs_rcu_callback);
 }
 
-static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
+static void z_erofs_pcluster_end(struct z_erofs_frontend *fe)
 {
 	struct z_erofs_pcluster *pcl = fe->pcl;
 
@@ -963,13 +953,9 @@ static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
 	if (fe->candidate_bvpage)
 		fe->candidate_bvpage = NULL;
 
-	/*
-	 * if all pending pages are added, don't hold its reference
-	 * any longer if the pcluster isn't hosted by ourselves.
-	 */
+	/* Drop refcount if it doesn't belong to our processing chain */
 	if (fe->mode < Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE)
-		z_erofs_put_pcluster(pcl);
-
+		z_erofs_put_pcluster(EROFS_I_SB(fe->inode), pcl, false);
 	fe->pcl = NULL;
 }
 
@@ -998,7 +984,7 @@ static int z_erofs_read_fragment(struct super_block *sb, struct folio *folio,
 	return 0;
 }
 
-static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *f,
+static int z_erofs_scan_folio(struct z_erofs_frontend *f,
 			      struct folio *folio, bool ra)
 {
 	struct inode *const inode = f->inode;
@@ -1087,7 +1073,7 @@ static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *f,
 			tight = (bs == PAGE_SIZE);
 		}
 	} while ((end = cur) > 0);
-	erofs_onlinefolio_end(folio, err);
+	erofs_onlinefolio_end(folio, err, false);
 	return err;
 }
 
@@ -1111,7 +1097,7 @@ static bool z_erofs_page_is_invalidated(struct page *page)
 	return !page_folio(page)->mapping && !z_erofs_is_shortlived_page(page);
 }
 
-struct z_erofs_decompress_backend {
+struct z_erofs_backend {
 	struct page *onstack_pages[Z_EROFS_ONSTACK_PAGES];
 	struct super_block *sb;
 	struct z_erofs_pcluster *pcl;
@@ -1132,7 +1118,7 @@ struct z_erofs_bvec_item {
 	struct list_head list;
 };
 
-static void z_erofs_do_decompressed_bvec(struct z_erofs_decompress_backend *be,
+static void z_erofs_do_decompressed_bvec(struct z_erofs_backend *be,
 					 struct z_erofs_bvec *bvec)
 {
 	int poff = bvec->offset + be->pcl->pageofs_out;
@@ -1157,8 +1143,7 @@ static void z_erofs_do_decompressed_bvec(struct z_erofs_decompress_backend *be,
 	list_add(&item->list, &be->decompressed_secondary_bvecs);
 }
 
-static void z_erofs_fill_other_copies(struct z_erofs_decompress_backend *be,
-				      int err)
+static void z_erofs_fill_other_copies(struct z_erofs_backend *be, int err)
 {
 	unsigned int off0 = be->pcl->pageofs_out;
 	struct list_head *p, *n;
@@ -1193,13 +1178,13 @@ static void z_erofs_fill_other_copies(struct z_erofs_decompress_backend *be,
 			cur += len;
 		}
 		kunmap_local(dst);
-		erofs_onlinefolio_end(page_folio(bvi->bvec.page), err);
+		erofs_onlinefolio_end(page_folio(bvi->bvec.page), err, true);
 		list_del(p);
 		kfree(bvi);
 	}
 }
 
-static void z_erofs_parse_out_bvecs(struct z_erofs_decompress_backend *be)
+static void z_erofs_parse_out_bvecs(struct z_erofs_backend *be)
 {
 	struct z_erofs_pcluster *pcl = be->pcl;
 	struct z_erofs_bvec_iter biter;
@@ -1224,8 +1209,7 @@ static void z_erofs_parse_out_bvecs(struct z_erofs_decompress_backend *be)
 		z_erofs_put_shortlivedpage(be->pagepool, old_bvpage);
 }
 
-static int z_erofs_parse_in_bvecs(struct z_erofs_decompress_backend *be,
-				  bool *overlapped)
+static int z_erofs_parse_in_bvecs(struct z_erofs_backend *be, bool *overlapped)
 {
 	struct z_erofs_pcluster *pcl = be->pcl;
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
@@ -1260,8 +1244,7 @@ static int z_erofs_parse_in_bvecs(struct z_erofs_decompress_backend *be,
 	return err;
 }
 
-static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
-				       int err)
+static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, int err)
 {
 	struct erofs_sb_info *const sbi = EROFS_SB(be->sb);
 	struct z_erofs_pcluster *pcl = be->pcl;
@@ -1271,6 +1254,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	int i, j, jtop, err2;
 	struct page *page;
 	bool overlapped;
+	bool try_free = true;
 
 	mutex_lock(&pcl->lock);
 	be->nr_pages = PAGE_ALIGN(pcl->length + pcl->pageofs_out) >> PAGE_SHIFT;
@@ -1328,9 +1312,12 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 		/* managed folios are still left in compressed_bvecs[] */
 		for (i = 0; i < pclusterpages; ++i) {
 			page = be->compressed_pages[i];
-			if (!page ||
-			    erofs_folio_is_managed(sbi, page_folio(page)))
+			if (!page)
 				continue;
+			if (erofs_folio_is_managed(sbi, page_folio(page))) {
+				try_free = false;
+				continue;
+			}
 			(void)z_erofs_put_shortlivedpage(be->pagepool, page);
 			WRITE_ONCE(pcl->compressed_bvecs[i].page, NULL);
 		}
@@ -1348,7 +1335,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 
 		DBG_BUGON(z_erofs_page_is_invalidated(page));
 		if (!z_erofs_is_shortlived_page(page)) {
-			erofs_onlinefolio_end(page_folio(page), err);
+			erofs_onlinefolio_end(page_folio(page), err, true);
 			continue;
 		}
 		if (pcl->algorithmformat != Z_EROFS_COMPRESSION_LZ4) {
@@ -1373,34 +1360,33 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	pcl->vcnt = 0;
 
 	/* pcluster lock MUST be taken before the following line */
-	WRITE_ONCE(pcl->next, Z_EROFS_PCLUSTER_NIL);
+	WRITE_ONCE(pcl->next, NULL);
 	mutex_unlock(&pcl->lock);
+
+	if (z_erofs_is_inline_pcluster(pcl))
+		z_erofs_free_pcluster(pcl);
+	else
+		z_erofs_put_pcluster(sbi, pcl, try_free);
 	return err;
 }
 
 static int z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 				    struct page **pagepool)
 {
-	struct z_erofs_decompress_backend be = {
+	struct z_erofs_backend be = {
 		.sb = io->sb,
 		.pagepool = pagepool,
 		.decompressed_secondary_bvecs =
 			LIST_HEAD_INIT(be.decompressed_secondary_bvecs),
+		.pcl = io->head,
 	};
-	z_erofs_next_pcluster_t owned = io->head;
+	struct z_erofs_pcluster *next;
 	int err = io->eio ? -EIO : 0;
 
-	while (owned != Z_EROFS_PCLUSTER_TAIL) {
-		DBG_BUGON(owned == Z_EROFS_PCLUSTER_NIL);
-
-		be.pcl = container_of(owned, struct z_erofs_pcluster, next);
-		owned = READ_ONCE(be.pcl->next);
-
+	for (; be.pcl != Z_EROFS_PCLUSTER_TAIL; be.pcl = next) {
+		DBG_BUGON(!be.pcl);
+		next = READ_ONCE(be.pcl->next);
 		err = z_erofs_decompress_pcluster(&be, err) ?: err;
-		if (z_erofs_is_inline_pcluster(be.pcl))
-			z_erofs_free_pcluster(be.pcl);
-		else
-			z_erofs_put_pcluster(be.pcl);
 	}
 	return err;
 }
@@ -1465,7 +1451,7 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 }
 
 static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
-				 struct z_erofs_decompress_frontend *f,
+				 struct z_erofs_frontend *f,
 				 struct z_erofs_pcluster *pcl,
 				 unsigned int nr,
 				 struct address_space *mc)
@@ -1609,18 +1595,13 @@ enum {
 	NR_JOBQUEUES,
 };
 
-static void move_to_bypass_jobqueue(struct z_erofs_pcluster *pcl,
-				    z_erofs_next_pcluster_t qtail[],
-				    z_erofs_next_pcluster_t owned_head)
+static void z_erofs_move_to_bypass_queue(struct z_erofs_pcluster *pcl,
+					 struct z_erofs_pcluster *next,
+					 struct z_erofs_pcluster **qtail[])
 {
-	z_erofs_next_pcluster_t *const submit_qtail = qtail[JQ_SUBMIT];
-	z_erofs_next_pcluster_t *const bypass_qtail = qtail[JQ_BYPASS];
-
 	WRITE_ONCE(pcl->next, Z_EROFS_PCLUSTER_TAIL);
-
-	WRITE_ONCE(*submit_qtail, owned_head);
-	WRITE_ONCE(*bypass_qtail, &pcl->next);
-
+	WRITE_ONCE(*qtail[JQ_SUBMIT], next);
+	WRITE_ONCE(*qtail[JQ_BYPASS], pcl);
 	qtail[JQ_BYPASS] = &pcl->next;
 }
 
@@ -1649,15 +1630,15 @@ static void z_erofs_endio(struct bio *bio)
 		bio_put(bio);
 }
 
-static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
+static void z_erofs_submit_queue(struct z_erofs_frontend *f,
 				 struct z_erofs_decompressqueue *fgq,
 				 bool *force_fg, bool readahead)
 {
 	struct super_block *sb = f->inode->i_sb;
 	struct address_space *mc = MNGD_MAPPING(EROFS_SB(sb));
-	z_erofs_next_pcluster_t qtail[NR_JOBQUEUES];
+	struct z_erofs_pcluster **qtail[NR_JOBQUEUES];
 	struct z_erofs_decompressqueue *q[NR_JOBQUEUES];
-	z_erofs_next_pcluster_t owned_head = f->owned_head;
+	struct z_erofs_pcluster *pcl, *next;
 	/* bio is NULL initially, so no need to initialize last_{index,bdev} */
 	erofs_off_t last_pa;
 	unsigned int nr_bios = 0;
@@ -1673,22 +1654,19 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 	qtail[JQ_SUBMIT] = &q[JQ_SUBMIT]->head;
 
 	/* by default, all need io submission */
-	q[JQ_SUBMIT]->head = owned_head;
+	q[JQ_SUBMIT]->head = next = f->head;
 
 	do {
 		struct erofs_map_dev mdev;
-		struct z_erofs_pcluster *pcl;
 		erofs_off_t cur, end;
 		struct bio_vec bvec;
 		unsigned int i = 0;
 		bool bypass = true;
 
-		DBG_BUGON(owned_head == Z_EROFS_PCLUSTER_NIL);
-		pcl = container_of(owned_head, struct z_erofs_pcluster, next);
-		owned_head = READ_ONCE(pcl->next);
-
+		pcl = next;
+		next = READ_ONCE(pcl->next);
 		if (z_erofs_is_inline_pcluster(pcl)) {
-			move_to_bypass_jobqueue(pcl, qtail, owned_head);
+			z_erofs_move_to_bypass_queue(pcl, next, qtail);
 			continue;
 		}
 
@@ -1760,8 +1738,8 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 		if (!bypass)
 			qtail[JQ_SUBMIT] = &pcl->next;
 		else
-			move_to_bypass_jobqueue(pcl, qtail, owned_head);
-	} while (owned_head != Z_EROFS_PCLUSTER_TAIL);
+			z_erofs_move_to_bypass_queue(pcl, next, qtail);
+	} while (next != Z_EROFS_PCLUSTER_TAIL);
 
 	if (bio) {
 		if (erofs_is_fileio_mode(EROFS_SB(sb)))
@@ -1785,17 +1763,16 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 	z_erofs_decompress_kickoff(q[JQ_SUBMIT], nr_bios);
 }
 
-static int z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
-			    unsigned int ra_folios)
+static int z_erofs_runqueue(struct z_erofs_frontend *f, unsigned int rapages)
 {
 	struct z_erofs_decompressqueue io[NR_JOBQUEUES];
 	struct erofs_sb_info *sbi = EROFS_I_SB(f->inode);
-	bool force_fg = z_erofs_is_sync_decompress(sbi, ra_folios);
+	bool force_fg = z_erofs_is_sync_decompress(sbi, rapages);
 	int err;
 
-	if (f->owned_head == Z_EROFS_PCLUSTER_TAIL)
+	if (f->head == Z_EROFS_PCLUSTER_TAIL)
 		return 0;
-	z_erofs_submit_queue(f, io, &force_fg, !!ra_folios);
+	z_erofs_submit_queue(f, io, &force_fg, !!rapages);
 
 	/* handle bypass queue (no i/o pclusters) immediately */
 	err = z_erofs_decompress_queue(&io[JQ_BYPASS], &f->pagepool);
@@ -1813,7 +1790,7 @@ static int z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
  * Since partial uptodate is still unimplemented for now, we have to use
  * approximate readmore strategies as a start.
  */
-static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
+static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
 		struct readahead_control *rac, bool backmost)
 {
 	struct inode *inode = f->inode;
@@ -1868,12 +1845,10 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 static int z_erofs_read_folio(struct file *file, struct folio *folio)
 {
 	struct inode *const inode = folio->mapping->host;
-	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
+	Z_EROFS_DEFINE_FRONTEND(f, inode, folio_pos(folio));
 	int err;
 
 	trace_erofs_read_folio(folio, false);
-	f.headoffset = (erofs_off_t)folio->index << PAGE_SHIFT;
-
 	z_erofs_pcluster_readmore(&f, NULL, true);
 	err = z_erofs_scan_folio(&f, folio, false);
 	z_erofs_pcluster_readmore(&f, NULL, false);
@@ -1893,17 +1868,13 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 static void z_erofs_readahead(struct readahead_control *rac)
 {
 	struct inode *const inode = rac->mapping->host;
-	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
+	Z_EROFS_DEFINE_FRONTEND(f, inode, readahead_pos(rac));
+	unsigned int nrpages = readahead_count(rac);
 	struct folio *head = NULL, *folio;
-	unsigned int nr_folios;
 	int err;
 
-	f.headoffset = readahead_pos(rac);
-
+	trace_erofs_readahead(inode, readahead_index(rac), nrpages, false);
 	z_erofs_pcluster_readmore(&f, rac, true);
-	nr_folios = readahead_count(rac);
-	trace_erofs_readpages(inode, readahead_index(rac), nr_folios, false);
-
 	while ((folio = readahead_folio(rac))) {
 		folio->private = head;
 		head = folio;
@@ -1922,7 +1893,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	z_erofs_pcluster_readmore(&f, rac, false);
 	z_erofs_pcluster_end(&f);
 
-	(void)z_erofs_runqueue(&f, nr_folios);
+	(void)z_erofs_runqueue(&f, nrpages);
 	erofs_put_metabuf(&f.map.buf);
 	erofs_release_pages(&f.pagepool);
 }
diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
index 75704f58ecfa..0dd65cefce33 100644
--- a/fs/erofs/zutil.c
+++ b/fs/erofs/zutil.c
@@ -230,9 +230,10 @@ void erofs_shrinker_unregister(struct super_block *sb)
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 
 	mutex_lock(&sbi->umount_mutex);
-	/* clean up all remaining pclusters in memory */
-	z_erofs_shrink_scan(sbi, ~0UL);
-
+	while (!xa_empty(&sbi->managed_pslots)) {
+		z_erofs_shrink_scan(sbi, ~0UL);
+		cond_resched();
+	}
 	spin_lock(&erofs_sb_list_lock);
 	list_del(&sbi->list);
 	spin_unlock(&erofs_sb_list_lock);
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1a06e462b6ef..99eed91d03eb 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -854,7 +854,7 @@ static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
 	kfree_rcu(epi, rcu);
 
 	percpu_counter_dec(&ep->user->epoll_watches);
-	return ep_refcount_dec_and_test(ep);
+	return true;
 }
 
 /*
@@ -862,14 +862,14 @@ static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
  */
 static void ep_remove_safe(struct eventpoll *ep, struct epitem *epi)
 {
-	WARN_ON_ONCE(__ep_remove(ep, epi, false));
+	if (__ep_remove(ep, epi, false))
+		WARN_ON_ONCE(ep_refcount_dec_and_test(ep));
 }
 
 static void ep_clear_and_put(struct eventpoll *ep)
 {
 	struct rb_node *rbp, *next;
 	struct epitem *epi;
-	bool dispose;
 
 	/* We need to release all tasks waiting for these file */
 	if (waitqueue_active(&ep->poll_wait))
@@ -902,10 +902,8 @@ static void ep_clear_and_put(struct eventpoll *ep)
 		cond_resched();
 	}
 
-	dispose = ep_refcount_dec_and_test(ep);
 	mutex_unlock(&ep->mtx);
-
-	if (dispose)
+	if (ep_refcount_dec_and_test(ep))
 		ep_free(ep);
 }
 
@@ -1108,7 +1106,7 @@ void eventpoll_release_file(struct file *file)
 		dispose = __ep_remove(ep, epi, true);
 		mutex_unlock(&ep->mtx);
 
-		if (dispose)
+		if (dispose && ep_refcount_dec_and_test(ep))
 			ep_free(ep);
 		goto again;
 	}
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 7cb21da40a0a..a968688a7323 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -285,7 +285,7 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 			trace_netfs_sreq_ref(wreq->debug_id, subreq->debug_index,
 					     refcount_read(&subreq->ref),
 					     netfs_sreq_trace_new);
-			netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
+			trace_netfs_sreq(subreq, netfs_sreq_trace_split);
 
 			list_add(&subreq->rreq_link, &to->rreq_link);
 			to = list_next_entry(to, rreq_link);
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index a3eb3b740f76..3604b616311c 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -42,7 +42,7 @@ static void proc_evict_inode(struct inode *inode)
 
 	head = ei->sysctl;
 	if (head) {
-		RCU_INIT_POINTER(ei->sysctl, NULL);
+		WRITE_ONCE(ei->sysctl, NULL);
 		proc_sys_evict_inode(inode, head);
 	}
 }
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index d11ebc055ce0..e785db5fa499 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -911,17 +911,21 @@ static int proc_sys_compare(const struct dentry *dentry,
 	struct ctl_table_header *head;
 	struct inode *inode;
 
-	/* Although proc doesn't have negative dentries, rcu-walk means
-	 * that inode here can be NULL */
-	/* AV: can it, indeed? */
-	inode = d_inode_rcu(dentry);
-	if (!inode)
-		return 1;
 	if (name->len != len)
 		return 1;
 	if (memcmp(name->name, str, len))
 		return 1;
-	head = rcu_dereference(PROC_I(inode)->sysctl);
+
+	// false positive is fine here - we'll recheck anyway
+	if (d_in_lookup(dentry))
+		return 0;
+
+	inode = d_inode_rcu(dentry);
+	// we just might have run into dentry in the middle of __dentry_kill()
+	if (!inode)
+		return 1;
+
+	head = READ_ONCE(PROC_I(inode)->sysctl);
 	return !head || !sysctl_is_seen(head);
 }
 
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 96fe904b2ac5..72a58681f031 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -36,9 +36,9 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
 	unsigned long text, lib, swap, anon, file, shmem;
 	unsigned long hiwater_vm, total_vm, hiwater_rss, total_rss;
 
-	anon = get_mm_counter(mm, MM_ANONPAGES);
-	file = get_mm_counter(mm, MM_FILEPAGES);
-	shmem = get_mm_counter(mm, MM_SHMEMPAGES);
+	anon = get_mm_counter_sum(mm, MM_ANONPAGES);
+	file = get_mm_counter_sum(mm, MM_FILEPAGES);
+	shmem = get_mm_counter_sum(mm, MM_SHMEMPAGES);
 
 	/*
 	 * Note: to minimize their overhead, mm maintains hiwater_vm and
@@ -59,7 +59,7 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
 	text = min(text, mm->exec_vm << PAGE_SHIFT);
 	lib = (mm->exec_vm << PAGE_SHIFT) - text;
 
-	swap = get_mm_counter(mm, MM_SWAPENTS);
+	swap = get_mm_counter_sum(mm, MM_SWAPENTS);
 	SEQ_PUT_DEC("VmPeak:\t", hiwater_vm);
 	SEQ_PUT_DEC(" kB\nVmSize:\t", total_vm);
 	SEQ_PUT_DEC(" kB\nVmLck:\t", mm->locked_vm);
@@ -92,12 +92,12 @@ unsigned long task_statm(struct mm_struct *mm,
 			 unsigned long *shared, unsigned long *text,
 			 unsigned long *data, unsigned long *resident)
 {
-	*shared = get_mm_counter(mm, MM_FILEPAGES) +
-			get_mm_counter(mm, MM_SHMEMPAGES);
+	*shared = get_mm_counter_sum(mm, MM_FILEPAGES) +
+			get_mm_counter_sum(mm, MM_SHMEMPAGES);
 	*text = (PAGE_ALIGN(mm->end_code) - (mm->start_code & PAGE_MASK))
 								>> PAGE_SHIFT;
 	*data = mm->data_vm + mm->stack_vm;
-	*resident = *shared + get_mm_counter(mm, MM_ANONPAGES);
+	*resident = *shared + get_mm_counter_sum(mm, MM_ANONPAGES);
 	return mm->total_vm;
 }
 
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 5d2324c09a07..a97a2885730d 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -8517,11 +8517,6 @@ static void smb20_oplock_break_ack(struct ksmbd_work *work)
 		goto err_out;
 	}
 
-	opinfo->op_state = OPLOCK_STATE_NONE;
-	wake_up_interruptible_all(&opinfo->oplock_q);
-	opinfo_put(opinfo);
-	ksmbd_fd_put(work, fp);
-
 	rsp->StructureSize = cpu_to_le16(24);
 	rsp->OplockLevel = rsp_oplevel;
 	rsp->Reserved = 0;
@@ -8529,16 +8524,15 @@ static void smb20_oplock_break_ack(struct ksmbd_work *work)
 	rsp->VolatileFid = volatile_id;
 	rsp->PersistentFid = persistent_id;
 	ret = ksmbd_iov_pin_rsp(work, rsp, sizeof(struct smb2_oplock_break));
-	if (!ret)
-		return;
-
+	if (ret) {
 err_out:
+		smb2_set_err_rsp(work);
+	}
+
 	opinfo->op_state = OPLOCK_STATE_NONE;
 	wake_up_interruptible_all(&opinfo->oplock_q);
-
 	opinfo_put(opinfo);
 	ksmbd_fd_put(work, fp);
-	smb2_set_err_rsp(work);
 }
 
 static int check_lease_state(struct lease *lease, __le32 req_state)
@@ -8668,11 +8662,6 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
 	}
 
 	lease_state = lease->state;
-	opinfo->op_state = OPLOCK_STATE_NONE;
-	wake_up_interruptible_all(&opinfo->oplock_q);
-	atomic_dec(&opinfo->breaking_cnt);
-	wake_up_interruptible_all(&opinfo->oplock_brk);
-	opinfo_put(opinfo);
 
 	rsp->StructureSize = cpu_to_le16(36);
 	rsp->Reserved = 0;
@@ -8681,16 +8670,16 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
 	rsp->LeaseState = lease_state;
 	rsp->LeaseDuration = 0;
 	ret = ksmbd_iov_pin_rsp(work, rsp, sizeof(struct smb2_lease_ack));
-	if (!ret)
-		return;
-
+	if (ret) {
 err_out:
+		smb2_set_err_rsp(work);
+	}
+
+	opinfo->op_state = OPLOCK_STATE_NONE;
 	wake_up_interruptible_all(&opinfo->oplock_q);
 	atomic_dec(&opinfo->breaking_cnt);
 	wake_up_interruptible_all(&opinfo->oplock_brk);
-
 	opinfo_put(opinfo);
-	smb2_set_err_rsp(work);
 }
 
 /**
diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 6921d62934bc..3ab8c04f72e4 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -432,7 +432,8 @@ static void free_transport(struct smb_direct_transport *t)
 	if (t->qp) {
 		ib_drain_qp(t->qp);
 		ib_mr_pool_destroy(t->qp, &t->qp->rdma_mrs);
-		ib_destroy_qp(t->qp);
+		t->qp = NULL;
+		rdma_destroy_qp(t->cm_id);
 	}
 
 	ksmbd_debug(RDMA, "drain the reassembly queue\n");
@@ -1939,8 +1940,8 @@ static int smb_direct_create_qpair(struct smb_direct_transport *t,
 	return 0;
 err:
 	if (t->qp) {
-		ib_destroy_qp(t->qp);
 		t->qp = NULL;
+		rdma_destroy_qp(t->cm_id);
 	}
 	if (t->recv_cq) {
 		ib_destroy_cq(t->recv_cq);
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 59ae63ab8685..a662aae5126c 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1298,6 +1298,7 @@ int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
 
 		err = ksmbd_vfs_lock_parent(parent_path->dentry, path->dentry);
 		if (err) {
+			mnt_drop_write(parent_path->mnt);
 			path_put(path);
 			path_put(parent_path);
 		}
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 8c0030c77308..2bc88d2d4a84 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -300,6 +300,9 @@ struct drm_file {
 	 *
 	 * Mapping of mm object handles to object pointers. Used by the GEM
 	 * subsystem. Protected by @table_lock.
+	 *
+	 * Note that allocated entries might be NULL as a transient state when
+	 * creating or deleting a handle.
 	 */
 	struct idr object_idr;
 
diff --git a/include/drm/drm_framebuffer.h b/include/drm/drm_framebuffer.h
index 668077009fce..38b24fc8978d 100644
--- a/include/drm/drm_framebuffer.h
+++ b/include/drm/drm_framebuffer.h
@@ -23,6 +23,7 @@
 #ifndef __DRM_FRAMEBUFFER_H__
 #define __DRM_FRAMEBUFFER_H__
 
+#include <linux/bits.h>
 #include <linux/ctype.h>
 #include <linux/list.h>
 #include <linux/sched.h>
@@ -100,6 +101,8 @@ struct drm_framebuffer_funcs {
 		     unsigned num_clips);
 };
 
+#define DRM_FRAMEBUFFER_HAS_HANDLE_REF(_i)	BIT(0u + (_i))
+
 /**
  * struct drm_framebuffer - frame buffer object
  *
@@ -188,6 +191,10 @@ struct drm_framebuffer {
 	 * DRM_MODE_FB_MODIFIERS.
 	 */
 	int flags;
+	/**
+	 * @internal_flags: Framebuffer flags like DRM_FRAMEBUFFER_HAS_HANDLE_REF.
+	 */
+	unsigned int internal_flags;
 	/**
 	 * @filp_head: Placed on &drm_file.fbs, protected by &drm_file.fbs_lock.
 	 */
diff --git a/include/drm/spsc_queue.h b/include/drm/spsc_queue.h
index 125f096c88cb..ee9df8cc67b7 100644
--- a/include/drm/spsc_queue.h
+++ b/include/drm/spsc_queue.h
@@ -70,9 +70,11 @@ static inline bool spsc_queue_push(struct spsc_queue *queue, struct spsc_node *n
 
 	preempt_disable();
 
+	atomic_inc(&queue->job_count);
+	smp_mb__after_atomic();
+
 	tail = (struct spsc_node **)atomic_long_xchg(&queue->tail, (long)&node->next);
 	WRITE_ONCE(*tail, node);
-	atomic_inc(&queue->job_count);
 
 	/*
 	 * In case of first element verify new node will be visible to the consumer
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index d07c1f0ad3de..7ecdde54e1ed 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -662,18 +662,6 @@ static inline bool ieee80211_s1g_has_cssid(__le16 fc)
 		(fc & cpu_to_le16(IEEE80211_S1G_BCN_CSSID));
 }
 
-/**
- * ieee80211_is_s1g_short_beacon - check if frame is an S1G short beacon
- * @fc: frame control bytes in little-endian byteorder
- * Return: whether or not the frame is an S1G short beacon,
- *	i.e. it is an S1G beacon with 'next TBTT' flag set
- */
-static inline bool ieee80211_is_s1g_short_beacon(__le16 fc)
-{
-	return ieee80211_is_s1g_beacon(fc) &&
-		(fc & cpu_to_le16(IEEE80211_S1G_BCN_NEXT_TBTT));
-}
-
 /**
  * ieee80211_is_atim - check if IEEE80211_FTYPE_MGMT && IEEE80211_STYPE_ATIM
  * @fc: frame control bytes in little-endian byteorder
@@ -4863,6 +4851,39 @@ static inline bool ieee80211_is_ftm(struct sk_buff *skb)
 	return false;
 }
 
+/**
+ * ieee80211_is_s1g_short_beacon - check if frame is an S1G short beacon
+ * @fc: frame control bytes in little-endian byteorder
+ * @variable: pointer to the beacon frame elements
+ * @variable_len: length of the frame elements
+ * Return: whether or not the frame is an S1G short beacon. As per
+ *	IEEE80211-2024 11.1.3.10.1, The S1G beacon compatibility element shall
+ *	always be present as the first element in beacon frames generated at a
+ *	TBTT (Target Beacon Transmission Time), so any frame not containing
+ *	this element must have been generated at a TSBTT (Target Short Beacon
+ *	Transmission Time) that is not a TBTT. Additionally, short beacons are
+ *	prohibited from containing the S1G beacon compatibility element as per
+ *	IEEE80211-2024 9.3.4.3 Table 9-76, so if we have an S1G beacon with
+ *	either no elements or the first element is not the beacon compatibility
+ *	element, we have a short beacon.
+ */
+static inline bool ieee80211_is_s1g_short_beacon(__le16 fc, const u8 *variable,
+						 size_t variable_len)
+{
+	if (!ieee80211_is_s1g_beacon(fc))
+		return false;
+
+	/*
+	 * If the frame does not contain at least 1 element (this is perfectly
+	 * valid in a short beacon) and is an S1G beacon, we have a short
+	 * beacon.
+	 */
+	if (variable_len < 2)
+		return true;
+
+	return variable[0] != WLAN_EID_S1G_BCN_COMPAT;
+}
+
 struct element {
 	u8 id;
 	u8 datalen;
diff --git a/include/linux/math.h b/include/linux/math.h
index f5f18dc3616b..0198c92cbe3e 100644
--- a/include/linux/math.h
+++ b/include/linux/math.h
@@ -34,6 +34,18 @@
  */
 #define round_down(x, y) ((x) & ~__round_mask(x, y))
 
+/**
+ * DIV_ROUND_UP_POW2 - divide and round up
+ * @n: numerator
+ * @d: denominator (must be a power of 2)
+ *
+ * Divides @n by @d and rounds up to next multiple of @d (which must be a power
+ * of 2). Avoids integer overflows that may occur with __KERNEL_DIV_ROUND_UP().
+ * Performance is roughly equivalent to __KERNEL_DIV_ROUND_UP().
+ */
+#define DIV_ROUND_UP_POW2(n, d) \
+	((n) / (d) + !!((n) & ((d) - 1)))
+
 #define DIV_ROUND_UP __KERNEL_DIV_ROUND_UP
 
 #define DIV_ROUND_DOWN_ULL(ll, d) \
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 059ca4767e14..deeb535f920c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2592,6 +2592,11 @@ static inline unsigned long get_mm_counter(struct mm_struct *mm, int member)
 	return percpu_counter_read_positive(&mm->rss_stat[member]);
 }
 
+static inline unsigned long get_mm_counter_sum(struct mm_struct *mm, int member)
+{
+	return percpu_counter_sum_positive(&mm->rss_stat[member]);
+}
+
 void mm_trace_rss_stat(struct mm_struct *mm, int member);
 
 static inline void add_mm_counter(struct mm_struct *mm, int member, long value)
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index 903ddfea8585..613a8209bed2 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -594,6 +594,7 @@ struct sev_data_snp_addr {
  * @imi_en: launch flow is launching an IMI (Incoming Migration Image) for the
  *          purpose of guest-assisted migration.
  * @rsvd: reserved
+ * @desired_tsc_khz: hypervisor desired mean TSC freq in kHz of the guest
  * @gosvw: guest OS-visible workarounds, as defined by hypervisor
  */
 struct sev_data_snp_launch_start {
@@ -603,6 +604,7 @@ struct sev_data_snp_launch_start {
 	u32 ma_en:1;				/* In */
 	u32 imi_en:1;				/* In */
 	u32 rsvd:30;
+	u32 desired_tsc_khz;			/* In */
 	u8 gosvw[16];				/* In */
 } __packed;
 
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 9e85424c8343..70302c92d329 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -242,8 +242,8 @@ int __vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
 int vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
 			size_t len, int flags);
 
-#ifdef CONFIG_BPF_SYSCALL
 extern struct proto vsock_proto;
+#ifdef CONFIG_BPF_SYSCALL
 int vsock_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore);
 void __init vsock_bpf_build_proto(void);
 #else
diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index b63d53bb9dd6..1a6fca013165 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -369,7 +369,7 @@ static inline __be16 __nf_flow_pppoe_proto(const struct sk_buff *skb)
 
 static inline bool nf_flow_pppoe_proto(struct sk_buff *skb, __be16 *inner_proto)
 {
-	if (!pskb_may_pull(skb, PPPOE_SES_HLEN))
+	if (!pskb_may_pull(skb, ETH_HLEN + PPPOE_SES_HLEN))
 		return false;
 
 	*inner_proto = __nf_flow_pppoe_proto(skb);
diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index 60d3b86a4660..6293ab852c14 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -10,6 +10,7 @@
 #include <linux/acpi.h>
 #include <linux/mod_devicetable.h>
 #include <linux/soundwire/sdw.h>
+#include <sound/soc.h>
 
 struct snd_soc_acpi_package_context {
 	char *name;           /* package name */
@@ -189,6 +190,15 @@ struct snd_soc_acpi_link_adr {
  *  is not constant since this field may be updated at run-time
  * @sof_tplg_filename: Sound Open Firmware topology file name, if enabled
  * @tplg_quirk_mask: quirks to select different topology files dynamically
+ * @get_function_tplg_files: This is an optional callback, if specified then instead of
+ *	the single sof_tplg_filename the callback will return the list of function topology
+ *	files to be loaded.
+ *	Return value: The number of the files or negative ERRNO. 0 means that the single topology
+ *		      file should be used, no function topology split can be used on the machine.
+ *	@card: the pointer of the card
+ *	@mach: the pointer of the machine driver
+ *	@prefix: the prefix of the topology file name. Typically, it is the path.
+ *	@tplg_files: the pointer of the array of the topology file names.
  */
 /* Descriptor for SST ASoC machine driver */
 struct snd_soc_acpi_mach {
@@ -207,6 +217,9 @@ struct snd_soc_acpi_mach {
 	struct snd_soc_acpi_mach_params mach_params;
 	const char *sof_tplg_filename;
 	const u32 tplg_quirk_mask;
+	int (*get_function_tplg_files)(struct snd_soc_card *card,
+				       const struct snd_soc_acpi_mach *mach,
+				       const char *prefix, const char ***tplg_files);
 };
 
 #define SND_SOC_ACPI_MAX_CODECS 3
diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
index ad79f1ca4fb5..198a0c644bea 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -113,7 +113,7 @@ TRACE_EVENT(erofs_read_folio,
 		__entry->raw)
 );
 
-TRACE_EVENT(erofs_readpages,
+TRACE_EVENT(erofs_readahead,
 
 	TP_PROTO(struct inode *inode, pgoff_t start, unsigned int nrpage,
 		bool raw),
diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index a2be3bbca5ff..5dc1cba158a0 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -214,6 +214,7 @@ const struct io_issue_def io_issue_defs[] = {
 	},
 	[IORING_OP_FALLOCATE] = {
 		.needs_file		= 1,
+		.hash_reg_file          = 1,
 		.prep			= io_fallocate_prep,
 		.issue			= io_fallocate,
 	},
diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
index 3dabdd137d10..2d6e1c98d8ad 100644
--- a/kernel/bpf/bpf_lru_list.c
+++ b/kernel/bpf/bpf_lru_list.c
@@ -337,12 +337,12 @@ static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
 				 list) {
 		__bpf_lru_node_move_to_free(l, node, local_free_list(loc_l),
 					    BPF_LRU_LOCAL_LIST_T_FREE);
-		if (++nfree == LOCAL_FREE_TARGET)
+		if (++nfree == lru->target_free)
 			break;
 	}
 
-	if (nfree < LOCAL_FREE_TARGET)
-		__bpf_lru_list_shrink(lru, l, LOCAL_FREE_TARGET - nfree,
+	if (nfree < lru->target_free)
+		__bpf_lru_list_shrink(lru, l, lru->target_free - nfree,
 				      local_free_list(loc_l),
 				      BPF_LRU_LOCAL_LIST_T_FREE);
 
@@ -577,6 +577,9 @@ static void bpf_common_lru_populate(struct bpf_lru *lru, void *buf,
 		list_add(&node->list, &l->lists[BPF_LRU_LIST_T_FREE]);
 		buf += elem_size;
 	}
+
+	lru->target_free = clamp((nr_elems / num_possible_cpus()) / 2,
+				 1, LOCAL_FREE_TARGET);
 }
 
 static void bpf_percpu_lru_populate(struct bpf_lru *lru, void *buf,
diff --git a/kernel/bpf/bpf_lru_list.h b/kernel/bpf/bpf_lru_list.h
index cbd8d3720c2b..fe2661a58ea9 100644
--- a/kernel/bpf/bpf_lru_list.h
+++ b/kernel/bpf/bpf_lru_list.h
@@ -58,6 +58,7 @@ struct bpf_lru {
 	del_from_htab_func del_from_htab;
 	void *del_arg;
 	unsigned int hash_offset;
+	unsigned int target_free;
 	unsigned int nr_scans;
 	bool percpu;
 };
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7210104b3345..dd745485b0f4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -905,8 +905,6 @@ static void perf_cgroup_switch(struct task_struct *task)
 	if (READ_ONCE(cpuctx->cgrp) == NULL)
 		return;
 
-	WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
-
 	cgrp = perf_cgroup_from_task(task, NULL);
 	if (READ_ONCE(cpuctx->cgrp) == cgrp)
 		return;
@@ -918,6 +916,8 @@ static void perf_cgroup_switch(struct task_struct *task)
 	if (READ_ONCE(cpuctx->cgrp) == NULL)
 		return;
 
+	WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
+
 	perf_ctx_disable(&cpuctx->ctx, true);
 
 	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
@@ -10737,7 +10737,7 @@ static int perf_uprobe_event_init(struct perf_event *event)
 	if (event->attr.type != perf_uprobe.type)
 		return -ENOENT;
 
-	if (!perfmon_capable())
+	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
 	/*
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 9de6e35fe679..23894ba8250c 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -149,6 +149,29 @@ static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 	return 0;
 }
 
+/*
+ * Get the user-space pointer value stored in the 'rseq_cs' field.
+ */
+static int rseq_get_rseq_cs_ptr_val(struct rseq __user *rseq, u64 *rseq_cs)
+{
+	if (!rseq_cs)
+		return -EFAULT;
+
+#ifdef CONFIG_64BIT
+	if (get_user(*rseq_cs, &rseq->rseq_cs))
+		return -EFAULT;
+#else
+	if (copy_from_user(rseq_cs, &rseq->rseq_cs, sizeof(*rseq_cs)))
+		return -EFAULT;
+#endif
+
+	return 0;
+}
+
+/*
+ * If the rseq_cs field of 'struct rseq' contains a valid pointer to
+ * user-space, copy 'struct rseq_cs' from user-space and validate its fields.
+ */
 static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
 {
 	struct rseq_cs __user *urseq_cs;
@@ -157,17 +180,16 @@ static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
 	u32 sig;
 	int ret;
 
-#ifdef CONFIG_64BIT
-	if (get_user(ptr, &t->rseq->rseq_cs))
-		return -EFAULT;
-#else
-	if (copy_from_user(&ptr, &t->rseq->rseq_cs, sizeof(ptr)))
-		return -EFAULT;
-#endif
+	ret = rseq_get_rseq_cs_ptr_val(t->rseq, &ptr);
+	if (ret)
+		return ret;
+
+	/* If the rseq_cs pointer is NULL, return a cleared struct rseq_cs. */
 	if (!ptr) {
 		memset(rseq_cs, 0, sizeof(*rseq_cs));
 		return 0;
 	}
+	/* Check that the pointer value fits in the user-space process space. */
 	if (ptr >= TASK_SIZE)
 		return -EINVAL;
 	urseq_cs = (struct rseq_cs __user *)(unsigned long)ptr;
@@ -243,7 +265,7 @@ static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
 	return !!event_mask;
 }
 
-static int clear_rseq_cs(struct task_struct *t)
+static int clear_rseq_cs(struct rseq __user *rseq)
 {
 	/*
 	 * The rseq_cs field is set to NULL on preemption or signal
@@ -254,9 +276,9 @@ static int clear_rseq_cs(struct task_struct *t)
 	 * Set rseq_cs to NULL.
 	 */
 #ifdef CONFIG_64BIT
-	return put_user(0UL, &t->rseq->rseq_cs);
+	return put_user(0UL, &rseq->rseq_cs);
 #else
-	if (clear_user(&t->rseq->rseq_cs, sizeof(t->rseq->rseq_cs)))
+	if (clear_user(&rseq->rseq_cs, sizeof(rseq->rseq_cs)))
 		return -EFAULT;
 	return 0;
 #endif
@@ -288,11 +310,11 @@ static int rseq_ip_fixup(struct pt_regs *regs)
 	 * Clear the rseq_cs pointer and return.
 	 */
 	if (!in_rseq_cs(ip, &rseq_cs))
-		return clear_rseq_cs(t);
+		return clear_rseq_cs(t->rseq);
 	ret = rseq_need_restart(t, rseq_cs.flags);
 	if (ret <= 0)
 		return ret;
-	ret = clear_rseq_cs(t);
+	ret = clear_rseq_cs(t->rseq);
 	if (ret)
 		return ret;
 	trace_rseq_ip_fixup(ip, rseq_cs.start_ip, rseq_cs.post_commit_offset,
@@ -366,6 +388,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		int, flags, u32, sig)
 {
 	int ret;
+	u64 rseq_cs;
 
 	if (flags & RSEQ_FLAG_UNREGISTER) {
 		if (flags & ~RSEQ_FLAG_UNREGISTER)
@@ -420,6 +443,19 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		return -EINVAL;
 	if (!access_ok(rseq, rseq_len))
 		return -EFAULT;
+
+	/*
+	 * If the rseq_cs pointer is non-NULL on registration, clear it to
+	 * avoid a potential segfault on return to user-space. The proper thing
+	 * to do would have been to fail the registration but this would break
+	 * older libcs that reuse the rseq area for new threads without
+	 * clearing the fields.
+	 */
+	if (rseq_get_rseq_cs_ptr_val(rseq, &rseq_cs))
+	        return -EFAULT;
+	if (rseq_cs && clear_rseq_cs(rseq))
+		return -EFAULT;
+
 	current->rseq = rseq;
 	current->rseq_len = rseq_len;
 	current->rseq_sig = sig;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 50531e462a4b..4b1953b6c76a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3891,6 +3891,11 @@ static inline bool ttwu_queue_cond(struct task_struct *p, int cpu)
 	if (task_on_scx(p))
 		return false;
 
+#ifdef CONFIG_SMP
+	if (p->sched_class == &stop_sched_class)
+		return false;
+#endif
+
 	/*
 	 * Do not complicate things with the async wake_list while the CPU is
 	 * in hotplug state.
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 5e7ae404c8d2..0a47e5155897 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1485,7 +1485,9 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 	if (dl_entity_is_special(dl_se))
 		return;
 
-	scaled_delta_exec = dl_scaled_delta_exec(rq, dl_se, delta_exec);
+	scaled_delta_exec = delta_exec;
+	if (!dl_server(dl_se))
+		scaled_delta_exec = dl_scaled_delta_exec(rq, dl_se, delta_exec);
 
 	dl_se->runtime -= scaled_delta_exec;
 
@@ -1592,7 +1594,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
  */
 void dl_server_update_idle_time(struct rq *rq, struct task_struct *p)
 {
-	s64 delta_exec, scaled_delta_exec;
+	s64 delta_exec;
 
 	if (!rq->fair_server.dl_defer)
 		return;
@@ -1605,9 +1607,7 @@ void dl_server_update_idle_time(struct rq *rq, struct task_struct *p)
 	if (delta_exec < 0)
 		return;
 
-	scaled_delta_exec = dl_scaled_delta_exec(rq, &rq->fair_server, delta_exec);
-
-	rq->fair_server.runtime -= scaled_delta_exec;
+	rq->fair_server.runtime -= delta_exec;
 
 	if (rq->fair_server.runtime < 0) {
 		rq->fair_server.dl_defer_running = 0;
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index da821ce258ea..d758e66ad59e 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -82,18 +82,15 @@ static void cpu_stop_signal_done(struct cpu_stop_done *done)
 }
 
 static void __cpu_stop_queue_work(struct cpu_stopper *stopper,
-					struct cpu_stop_work *work,
-					struct wake_q_head *wakeq)
+				  struct cpu_stop_work *work)
 {
 	list_add_tail(&work->list, &stopper->works);
-	wake_q_add(wakeq, stopper->thread);
 }
 
 /* queue @work to @stopper.  if offline, @work is completed immediately */
 static bool cpu_stop_queue_work(unsigned int cpu, struct cpu_stop_work *work)
 {
 	struct cpu_stopper *stopper = &per_cpu(cpu_stopper, cpu);
-	DEFINE_WAKE_Q(wakeq);
 	unsigned long flags;
 	bool enabled;
 
@@ -101,12 +98,13 @@ static bool cpu_stop_queue_work(unsigned int cpu, struct cpu_stop_work *work)
 	raw_spin_lock_irqsave(&stopper->lock, flags);
 	enabled = stopper->enabled;
 	if (enabled)
-		__cpu_stop_queue_work(stopper, work, &wakeq);
+		__cpu_stop_queue_work(stopper, work);
 	else if (work->done)
 		cpu_stop_signal_done(work->done);
 	raw_spin_unlock_irqrestore(&stopper->lock, flags);
 
-	wake_up_q(&wakeq);
+	if (enabled)
+		wake_up_process(stopper->thread);
 	preempt_enable();
 
 	return enabled;
@@ -263,7 +261,6 @@ static int cpu_stop_queue_two_works(int cpu1, struct cpu_stop_work *work1,
 {
 	struct cpu_stopper *stopper1 = per_cpu_ptr(&cpu_stopper, cpu1);
 	struct cpu_stopper *stopper2 = per_cpu_ptr(&cpu_stopper, cpu2);
-	DEFINE_WAKE_Q(wakeq);
 	int err;
 
 retry:
@@ -299,8 +296,8 @@ static int cpu_stop_queue_two_works(int cpu1, struct cpu_stop_work *work1,
 	}
 
 	err = 0;
-	__cpu_stop_queue_work(stopper1, work1, &wakeq);
-	__cpu_stop_queue_work(stopper2, work2, &wakeq);
+	__cpu_stop_queue_work(stopper1, work1);
+	__cpu_stop_queue_work(stopper2, work2);
 
 unlock:
 	raw_spin_unlock(&stopper2->lock);
@@ -315,7 +312,10 @@ static int cpu_stop_queue_two_works(int cpu1, struct cpu_stop_work *work1,
 		goto retry;
 	}
 
-	wake_up_q(&wakeq);
+	if (!err) {
+		wake_up_process(stopper1->thread);
+		wake_up_process(stopper2->thread);
+	}
 	preempt_enable();
 
 	return err;
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 81e5f9a70f22..e76c40bf29d0 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -113,6 +113,9 @@ size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sl
 	struct codetag_bytes n;
 	unsigned int i, nr = 0;
 
+	if (IS_ERR_OR_NULL(alloc_tag_cttype))
+		return 0;
+
 	if (can_sleep)
 		codetag_lock_module_list(alloc_tag_cttype, true);
 	else if (!codetag_trylock_module_list(alloc_tag_cttype))
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 44441ec5b0af..59f83ece2024 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5335,6 +5335,7 @@ static void mt_destroy_walk(struct maple_enode *enode, struct maple_tree *mt,
 	struct maple_enode *start;
 
 	if (mte_is_leaf(enode)) {
+		mte_set_node_dead(enode);
 		node->type = mte_node_type(enode);
 		goto free_leaf;
 	}
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index c7c0083203cb..5675d6a412ef 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -398,17 +398,8 @@ static void print_address_description(void *addr, u8 tag,
 	}
 
 	if (is_vmalloc_addr(addr)) {
-		struct vm_struct *va = find_vm_area(addr);
-
-		if (va) {
-			pr_err("The buggy address belongs to the virtual mapping at\n"
-			       " [%px, %px) created by:\n"
-			       " %pS\n",
-			       va->addr, va->addr + va->size, va->caller);
-			pr_err("\n");
-
-			page = vmalloc_to_page(addr);
-		}
+		pr_err("The buggy address %px belongs to a vmalloc virtual mapping\n", addr);
+		page = vmalloc_to_page(addr);
 	}
 
 	if (page) {
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 7888600b6a79..3519c4e4f841 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -487,6 +487,7 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
 		pgtbl_mod_mask *mask)
 {
+	int err = 0;
 	pte_t *pte;
 
 	/*
@@ -500,18 +501,25 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 	do {
 		struct page *page = pages[*nr];
 
-		if (WARN_ON(!pte_none(ptep_get(pte))))
-			return -EBUSY;
-		if (WARN_ON(!page))
-			return -ENOMEM;
-		if (WARN_ON(!pfn_valid(page_to_pfn(page))))
-			return -EINVAL;
+		if (WARN_ON(!pte_none(ptep_get(pte)))) {
+			err = -EBUSY;
+			break;
+		}
+		if (WARN_ON(!page)) {
+			err = -ENOMEM;
+			break;
+		}
+		if (WARN_ON(!pfn_valid(page_to_pfn(page)))) {
+			err = -EINVAL;
+			break;
+		}
 
 		set_pte_at(&init_mm, addr, pte, mk_pte(page, prot));
 		(*nr)++;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	*mask |= PGTBL_PTE_MODIFIED;
-	return 0;
+
+	return err;
 }
 
 static int vmap_pages_pmd_range(pud_t *pud, unsigned long addr,
diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index b068651984fe..fa7f002b14fa 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -576,6 +576,7 @@ static int atrtr_create(struct rtentry *r, struct net_device *devhint)
 
 	/* Fill in the routing entry */
 	rt->target  = ta->sat_addr;
+	dev_put(rt->dev); /* Release old device */
 	dev_hold(devhint);
 	rt->dev     = devhint;
 	rt->flags   = r->rt_flags;
diff --git a/net/atm/clip.c b/net/atm/clip.c
index 0d7744442b25..ebba0d6ae324 100644
--- a/net/atm/clip.c
+++ b/net/atm/clip.c
@@ -45,7 +45,8 @@
 #include <net/atmclip.h>
 
 static struct net_device *clip_devs;
-static struct atm_vcc *atmarpd;
+static struct atm_vcc __rcu *atmarpd;
+static DEFINE_MUTEX(atmarpd_lock);
 static struct timer_list idle_timer;
 static const struct neigh_ops clip_neigh_ops;
 
@@ -53,24 +54,35 @@ static int to_atmarpd(enum atmarp_ctrl_type type, int itf, __be32 ip)
 {
 	struct sock *sk;
 	struct atmarp_ctrl *ctrl;
+	struct atm_vcc *vcc;
 	struct sk_buff *skb;
+	int err = 0;
 
 	pr_debug("(%d)\n", type);
-	if (!atmarpd)
-		return -EUNATCH;
+
+	rcu_read_lock();
+	vcc = rcu_dereference(atmarpd);
+	if (!vcc) {
+		err = -EUNATCH;
+		goto unlock;
+	}
 	skb = alloc_skb(sizeof(struct atmarp_ctrl), GFP_ATOMIC);
-	if (!skb)
-		return -ENOMEM;
+	if (!skb) {
+		err = -ENOMEM;
+		goto unlock;
+	}
 	ctrl = skb_put(skb, sizeof(struct atmarp_ctrl));
 	ctrl->type = type;
 	ctrl->itf_num = itf;
 	ctrl->ip = ip;
-	atm_force_charge(atmarpd, skb->truesize);
+	atm_force_charge(vcc, skb->truesize);
 
-	sk = sk_atm(atmarpd);
+	sk = sk_atm(vcc);
 	skb_queue_tail(&sk->sk_receive_queue, skb);
 	sk->sk_data_ready(sk);
-	return 0;
+unlock:
+	rcu_read_unlock();
+	return err;
 }
 
 static void link_vcc(struct clip_vcc *clip_vcc, struct atmarp_entry *entry)
@@ -417,6 +429,8 @@ static int clip_mkip(struct atm_vcc *vcc, int timeout)
 
 	if (!vcc->push)
 		return -EBADFD;
+	if (vcc->user_back)
+		return -EINVAL;
 	clip_vcc = kmalloc(sizeof(struct clip_vcc), GFP_KERNEL);
 	if (!clip_vcc)
 		return -ENOMEM;
@@ -607,17 +621,27 @@ static void atmarpd_close(struct atm_vcc *vcc)
 {
 	pr_debug("\n");
 
-	rtnl_lock();
-	atmarpd = NULL;
+	mutex_lock(&atmarpd_lock);
+	RCU_INIT_POINTER(atmarpd, NULL);
+	mutex_unlock(&atmarpd_lock);
+
+	synchronize_rcu();
 	skb_queue_purge(&sk_atm(vcc)->sk_receive_queue);
-	rtnl_unlock();
 
 	pr_debug("(done)\n");
 	module_put(THIS_MODULE);
 }
 
+static int atmarpd_send(struct atm_vcc *vcc, struct sk_buff *skb)
+{
+	atm_return_tx(vcc, skb);
+	dev_kfree_skb_any(skb);
+	return 0;
+}
+
 static const struct atmdev_ops atmarpd_dev_ops = {
-	.close = atmarpd_close
+	.close = atmarpd_close,
+	.send = atmarpd_send
 };
 
 
@@ -631,15 +655,18 @@ static struct atm_dev atmarpd_dev = {
 
 static int atm_init_atmarp(struct atm_vcc *vcc)
 {
-	rtnl_lock();
+	if (vcc->push == clip_push)
+		return -EINVAL;
+
+	mutex_lock(&atmarpd_lock);
 	if (atmarpd) {
-		rtnl_unlock();
+		mutex_unlock(&atmarpd_lock);
 		return -EADDRINUSE;
 	}
 
 	mod_timer(&idle_timer, jiffies + CLIP_CHECK_INTERVAL * HZ);
 
-	atmarpd = vcc;
+	rcu_assign_pointer(atmarpd, vcc);
 	set_bit(ATM_VF_META, &vcc->flags);
 	set_bit(ATM_VF_READY, &vcc->flags);
 	    /* allow replies and avoid getting closed if signaling dies */
@@ -648,13 +675,14 @@ static int atm_init_atmarp(struct atm_vcc *vcc)
 	vcc->push = NULL;
 	vcc->pop = NULL; /* crash */
 	vcc->push_oam = NULL; /* crash */
-	rtnl_unlock();
+	mutex_unlock(&atmarpd_lock);
 	return 0;
 }
 
 static int clip_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 {
 	struct atm_vcc *vcc = ATM_SD(sock);
+	struct sock *sk = sock->sk;
 	int err = 0;
 
 	switch (cmd) {
@@ -675,14 +703,18 @@ static int clip_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 		err = clip_create(arg);
 		break;
 	case ATMARPD_CTRL:
+		lock_sock(sk);
 		err = atm_init_atmarp(vcc);
 		if (!err) {
 			sock->state = SS_CONNECTED;
 			__module_get(THIS_MODULE);
 		}
+		release_sock(sk);
 		break;
 	case ATMARP_MKIP:
+		lock_sock(sk);
 		err = clip_mkip(vcc, arg);
+		release_sock(sk);
 		break;
 	case ATMARP_SETENTRY:
 		err = clip_setentry(vcc, (__force __be32)arg);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7fdf17351e4a..b7dcebc70189 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6945,7 +6945,10 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 		bis->iso_qos.bcast.in.sdu = le16_to_cpu(ev->max_pdu);
 
 		if (!ev->status) {
+			bis->state = BT_CONNECTED;
 			set_bit(HCI_CONN_BIG_SYNC, &bis->flags);
+			hci_debugfs_create_conn(bis);
+			hci_conn_add_sysfs(bis);
 			hci_iso_setup_path(bis);
 		}
 	}
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 79d1a6ed08b2..bc01135e43f3 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1345,7 +1345,7 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 	 * Command Disallowed error, so we must first disable the
 	 * instance if it is active.
 	 */
-	if (adv && !adv->pending) {
+	if (adv) {
 		err = hci_disable_ext_adv_instance_sync(hdev, instance);
 		if (err)
 			return err;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b731a4a8f2b0..156da81bce06 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1145,7 +1145,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 		goto do_error;
 
 	while (msg_data_left(msg)) {
-		ssize_t copy = 0;
+		int copy = 0;
 
 		skb = tcp_write_queue_tail(sk);
 		if (skb)
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 16ba3bb12fc4..be51b8792b96 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3548,11 +3548,9 @@ static void addrconf_gre_config(struct net_device *dev)
 
 	ASSERT_RTNL();
 
-	idev = ipv6_find_idev(dev);
-	if (IS_ERR(idev)) {
-		pr_debug("%s: add_dev failed\n", __func__);
+	idev = addrconf_add_dev(dev);
+	if (IS_ERR(idev))
 		return;
-	}
 
 	/* Generate the IPv6 link-local address using addrconf_addr_gen(),
 	 * unless we have an IPv4 GRE device not bound to an IP address and
@@ -3566,9 +3564,6 @@ static void addrconf_gre_config(struct net_device *dev)
 	}
 
 	add_v4_addrs(idev);
-
-	if (dev->flags & IFF_POINTOPOINT)
-		addrconf_add_mroute(dev);
 }
 #endif
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 16bb3db67eaa..fd7434995a47 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6702,6 +6702,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	struct ieee80211_bss_conf *bss_conf = link->conf;
 	struct ieee80211_vif_cfg *vif_cfg = &sdata->vif.cfg;
 	struct ieee80211_mgmt *mgmt = (void *) hdr;
+	struct ieee80211_ext *ext = NULL;
 	size_t baselen;
 	struct ieee802_11_elems *elems;
 	struct ieee80211_local *local = sdata->local;
@@ -6727,7 +6728,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	/* Process beacon from the current BSS */
 	bssid = ieee80211_get_bssid(hdr, len, sdata->vif.type);
 	if (ieee80211_is_s1g_beacon(mgmt->frame_control)) {
-		struct ieee80211_ext *ext = (void *) mgmt;
+		ext = (void *)mgmt;
 		variable = ext->u.s1g_beacon.variable +
 			   ieee80211_s1g_optional_len(ext->frame_control);
 	}
@@ -6914,7 +6915,9 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	}
 
 	if ((ncrc == link->u.mgd.beacon_crc && link->u.mgd.beacon_crc_valid) ||
-	    ieee80211_is_s1g_short_beacon(mgmt->frame_control))
+	    (ext && ieee80211_is_s1g_short_beacon(ext->frame_control,
+						  parse_params.start,
+						  parse_params.len)))
 		goto free;
 	link->u.mgd.beacon_crc = ncrc;
 	link->u.mgd.beacon_crc_valid = true;
diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 6da39c864f45..922ea9a6e241 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -758,7 +758,6 @@ static size_t ieee802_11_find_bssid_profile(const u8 *start, size_t len,
 {
 	const struct element *elem, *sub;
 	size_t profile_len = 0;
-	bool found = false;
 
 	if (!bss || !bss->transmitted_bss)
 		return profile_len;
@@ -809,15 +808,14 @@ static size_t ieee802_11_find_bssid_profile(const u8 *start, size_t len,
 					       index[2],
 					       new_bssid);
 			if (ether_addr_equal(new_bssid, bss->bssid)) {
-				found = true;
 				elems->bssid_index_len = index[1];
 				elems->bssid_index = (void *)&index[2];
-				break;
+				return profile_len;
 			}
 		}
 	}
 
-	return found ? profile_len : 0;
+	return 0;
 }
 
 static void
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 775d707ec708..b02fb75f8d4f 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -387,7 +387,6 @@ static void netlink_skb_set_owner_r(struct sk_buff *skb, struct sock *sk)
 	WARN_ON(skb->sk != NULL);
 	skb->sk = sk;
 	skb->destructor = netlink_skb_destructor;
-	atomic_add(skb->truesize, &sk->sk_rmem_alloc);
 	sk_mem_charge(sk, skb->truesize);
 }
 
@@ -1216,41 +1215,48 @@ struct sk_buff *netlink_alloc_large_skb(unsigned int size, int broadcast)
 int netlink_attachskb(struct sock *sk, struct sk_buff *skb,
 		      long *timeo, struct sock *ssk)
 {
+	DECLARE_WAITQUEUE(wait, current);
 	struct netlink_sock *nlk;
+	unsigned int rmem;
 
 	nlk = nlk_sk(sk);
+	rmem = atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
 
-	if ((atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf ||
-	     test_bit(NETLINK_S_CONGESTED, &nlk->state))) {
-		DECLARE_WAITQUEUE(wait, current);
-		if (!*timeo) {
-			if (!ssk || netlink_is_kernel(ssk))
-				netlink_overrun(sk);
-			sock_put(sk);
-			kfree_skb(skb);
-			return -EAGAIN;
-		}
-
-		__set_current_state(TASK_INTERRUPTIBLE);
-		add_wait_queue(&nlk->wait, &wait);
+	if ((rmem == skb->truesize || rmem < READ_ONCE(sk->sk_rcvbuf)) &&
+	    !test_bit(NETLINK_S_CONGESTED, &nlk->state)) {
+		netlink_skb_set_owner_r(skb, sk);
+		return 0;
+	}
 
-		if ((atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf ||
-		     test_bit(NETLINK_S_CONGESTED, &nlk->state)) &&
-		    !sock_flag(sk, SOCK_DEAD))
-			*timeo = schedule_timeout(*timeo);
+	atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
 
-		__set_current_state(TASK_RUNNING);
-		remove_wait_queue(&nlk->wait, &wait);
+	if (!*timeo) {
+		if (!ssk || netlink_is_kernel(ssk))
+			netlink_overrun(sk);
 		sock_put(sk);
+		kfree_skb(skb);
+		return -EAGAIN;
+	}
 
-		if (signal_pending(current)) {
-			kfree_skb(skb);
-			return sock_intr_errno(*timeo);
-		}
-		return 1;
+	__set_current_state(TASK_INTERRUPTIBLE);
+	add_wait_queue(&nlk->wait, &wait);
+	rmem = atomic_read(&sk->sk_rmem_alloc);
+
+	if (((rmem && rmem + skb->truesize > READ_ONCE(sk->sk_rcvbuf)) ||
+	     test_bit(NETLINK_S_CONGESTED, &nlk->state)) &&
+	    !sock_flag(sk, SOCK_DEAD))
+		*timeo = schedule_timeout(*timeo);
+
+	__set_current_state(TASK_RUNNING);
+	remove_wait_queue(&nlk->wait, &wait);
+	sock_put(sk);
+
+	if (signal_pending(current)) {
+		kfree_skb(skb);
+		return sock_intr_errno(*timeo);
 	}
-	netlink_skb_set_owner_r(skb, sk);
-	return 0;
+
+	return 1;
 }
 
 static int __netlink_sendskb(struct sock *sk, struct sk_buff *skb)
@@ -1310,6 +1316,7 @@ static int netlink_unicast_kernel(struct sock *sk, struct sk_buff *skb,
 	ret = -ECONNREFUSED;
 	if (nlk->netlink_rcv != NULL) {
 		ret = skb->len;
+		atomic_add(skb->truesize, &sk->sk_rmem_alloc);
 		netlink_skb_set_owner_r(skb, sk);
 		NETLINK_CB(skb).sk = ssk;
 		netlink_deliver_tap_kernel(sk, ssk, skb);
@@ -1386,13 +1393,19 @@ EXPORT_SYMBOL_GPL(netlink_strict_get_check);
 static int netlink_broadcast_deliver(struct sock *sk, struct sk_buff *skb)
 {
 	struct netlink_sock *nlk = nlk_sk(sk);
+	unsigned int rmem, rcvbuf;
 
-	if (atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf &&
+	rmem = atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
+	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
+
+	if ((rmem == skb->truesize || rmem <= rcvbuf) &&
 	    !test_bit(NETLINK_S_CONGESTED, &nlk->state)) {
 		netlink_skb_set_owner_r(skb, sk);
 		__netlink_sendskb(sk, skb);
-		return atomic_read(&sk->sk_rmem_alloc) > (sk->sk_rcvbuf >> 1);
+		return rmem > (rcvbuf >> 1);
 	}
+
+	atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
 	return -1;
 }
 
@@ -2248,6 +2261,7 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 	struct netlink_ext_ack extack = {};
 	struct netlink_callback *cb;
 	struct sk_buff *skb = NULL;
+	unsigned int rmem, rcvbuf;
 	size_t max_recvmsg_len;
 	struct module *module;
 	int err = -ENOBUFS;
@@ -2261,9 +2275,6 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 		goto errout_skb;
 	}
 
-	if (atomic_read(&sk->sk_rmem_alloc) >= sk->sk_rcvbuf)
-		goto errout_skb;
-
 	/* NLMSG_GOODSIZE is small to avoid high order allocations being
 	 * required, but it makes sense to _attempt_ a 16K bytes allocation
 	 * to reduce number of system calls on dump operations, if user
@@ -2286,6 +2297,13 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 	if (!skb)
 		goto errout_skb;
 
+	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
+	rmem = atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
+	if (rmem != skb->truesize && rmem >= rcvbuf) {
+		atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
+		goto errout_skb;
+	}
+
 	/* Trim skb to allocated size. User is expected to provide buffer as
 	 * large as max(min_dump_alloc, 16KiB (mac_recvmsg_len capped at
 	 * netlink_recvmsg())). dump will pack as many smaller messages as
diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index 0f5a1d77b890..773bdb2e37da 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -149,6 +149,7 @@ static int rxrpc_service_prealloc_one(struct rxrpc_sock *rx,
 
 id_in_use:
 	write_unlock(&rx->call_lock);
+	rxrpc_prefail_call(call, RXRPC_CALL_LOCAL_ERROR, -EBADSLT);
 	rxrpc_cleanup_call(call);
 	_leave(" = -EBADSLT");
 	return -EBADSLT;
@@ -253,6 +254,9 @@ static struct rxrpc_call *rxrpc_alloc_incoming_call(struct rxrpc_sock *rx,
 	unsigned short call_tail, conn_tail, peer_tail;
 	unsigned short call_count, conn_count;
 
+	if (!b)
+		return NULL;
+
 	/* #calls >= #conns >= #peers must hold true. */
 	call_head = smp_load_acquire(&b->call_backlog_head);
 	call_tail = b->call_backlog_tail;
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 26378eac1bd0..c56a01992cb2 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -334,17 +334,22 @@ struct Qdisc *qdisc_lookup_rcu(struct net_device *dev, u32 handle)
 	return q;
 }
 
-static struct Qdisc *qdisc_leaf(struct Qdisc *p, u32 classid)
+static struct Qdisc *qdisc_leaf(struct Qdisc *p, u32 classid,
+				struct netlink_ext_ack *extack)
 {
 	unsigned long cl;
 	const struct Qdisc_class_ops *cops = p->ops->cl_ops;
 
-	if (cops == NULL)
-		return NULL;
+	if (cops == NULL) {
+		NL_SET_ERR_MSG(extack, "Parent qdisc is not classful");
+		return ERR_PTR(-EOPNOTSUPP);
+	}
 	cl = cops->find(p, classid);
 
-	if (cl == 0)
-		return NULL;
+	if (cl == 0) {
+		NL_SET_ERR_MSG(extack, "Specified class not found");
+		return ERR_PTR(-ENOENT);
+	}
 	return cops->leaf(p, cl);
 }
 
@@ -1526,7 +1531,7 @@ static int tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 					NL_SET_ERR_MSG(extack, "Failed to find qdisc with specified classid");
 					return -ENOENT;
 				}
-				q = qdisc_leaf(p, clid);
+				q = qdisc_leaf(p, clid, extack);
 			} else if (dev_ingress_queue(dev)) {
 				q = rtnl_dereference(dev_ingress_queue(dev)->qdisc_sleeping);
 			}
@@ -1537,6 +1542,8 @@ static int tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 			NL_SET_ERR_MSG(extack, "Cannot find specified qdisc on specified device");
 			return -ENOENT;
 		}
+		if (IS_ERR(q))
+			return PTR_ERR(q);
 
 		if (tcm->tcm_handle && q->handle != tcm->tcm_handle) {
 			NL_SET_ERR_MSG(extack, "Invalid handle");
@@ -1630,7 +1637,9 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 					NL_SET_ERR_MSG(extack, "Failed to find specified qdisc");
 					return -ENOENT;
 				}
-				q = qdisc_leaf(p, clid);
+				q = qdisc_leaf(p, clid, extack);
+				if (IS_ERR(q))
+					return PTR_ERR(q);
 			} else if (dev_ingress_queue_create(dev)) {
 				q = rtnl_dereference(dev_ingress_queue(dev)->qdisc_sleeping);
 			}
diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index 8ee0c07d00e9..ffe577bf6b51 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -704,8 +704,10 @@ static void tipc_topsrv_stop(struct net *net)
 	for (id = 0; srv->idr_in_use; id++) {
 		con = idr_find(&srv->conn_idr, id);
 		if (con) {
+			conn_get(con);
 			spin_unlock_bh(&srv->idr_lock);
 			tipc_conn_close(con);
+			conn_put(con);
 			spin_lock_bh(&srv->idr_lock);
 		}
 	}
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index d08f205b33dc..08565e41b8e9 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -407,6 +407,8 @@ EXPORT_SYMBOL_GPL(vsock_enqueue_accept);
 
 static bool vsock_use_local_transport(unsigned int remote_cid)
 {
+	lockdep_assert_held(&vsock_register_mutex);
+
 	if (!transport_local)
 		return false;
 
@@ -464,6 +466,8 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 
 	remote_flags = vsk->remote_addr.svm_flags;
 
+	mutex_lock(&vsock_register_mutex);
+
 	switch (sk->sk_type) {
 	case SOCK_DGRAM:
 		new_transport = transport_dgram;
@@ -479,12 +483,15 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 			new_transport = transport_h2g;
 		break;
 	default:
-		return -ESOCKTNOSUPPORT;
+		ret = -ESOCKTNOSUPPORT;
+		goto err;
 	}
 
 	if (vsk->transport) {
-		if (vsk->transport == new_transport)
-			return 0;
+		if (vsk->transport == new_transport) {
+			ret = 0;
+			goto err;
+		}
 
 		/* transport->release() must be called with sock lock acquired.
 		 * This path can only be taken during vsock_connect(), where we
@@ -508,8 +515,16 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 	/* We increase the module refcnt to prevent the transport unloading
 	 * while there are open sockets assigned to it.
 	 */
-	if (!new_transport || !try_module_get(new_transport->module))
-		return -ENODEV;
+	if (!new_transport || !try_module_get(new_transport->module)) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	/* It's safe to release the mutex after a successful try_module_get().
+	 * Whichever transport `new_transport` points at, it won't go away until
+	 * the last module_put() below or in vsock_deassign_transport().
+	 */
+	mutex_unlock(&vsock_register_mutex);
 
 	if (sk->sk_type == SOCK_SEQPACKET) {
 		if (!new_transport->seqpacket_allow ||
@@ -528,12 +543,31 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 	vsk->transport = new_transport;
 
 	return 0;
+err:
+	mutex_unlock(&vsock_register_mutex);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(vsock_assign_transport);
 
+/*
+ * Provide safe access to static transport_{h2g,g2h,dgram,local} callbacks.
+ * Otherwise we may race with module removal. Do not use on `vsk->transport`.
+ */
+static u32 vsock_registered_transport_cid(const struct vsock_transport **transport)
+{
+	u32 cid = VMADDR_CID_ANY;
+
+	mutex_lock(&vsock_register_mutex);
+	if (*transport)
+		cid = (*transport)->get_local_cid();
+	mutex_unlock(&vsock_register_mutex);
+
+	return cid;
+}
+
 bool vsock_find_cid(unsigned int cid)
 {
-	if (transport_g2h && cid == transport_g2h->get_local_cid())
+	if (cid == vsock_registered_transport_cid(&transport_g2h))
 		return true;
 
 	if (transport_h2g && cid == VMADDR_CID_HOST)
@@ -2502,18 +2536,19 @@ static long vsock_dev_do_ioctl(struct file *filp,
 			       unsigned int cmd, void __user *ptr)
 {
 	u32 __user *p = ptr;
-	u32 cid = VMADDR_CID_ANY;
 	int retval = 0;
+	u32 cid;
 
 	switch (cmd) {
 	case IOCTL_VM_SOCKETS_GET_LOCAL_CID:
 		/* To be compatible with the VMCI behavior, we prioritize the
 		 * guest CID instead of well-know host CID (VMADDR_CID_HOST).
 		 */
-		if (transport_g2h)
-			cid = transport_g2h->get_local_cid();
-		else if (transport_h2g)
-			cid = transport_h2g->get_local_cid();
+		cid = vsock_registered_transport_cid(&transport_g2h);
+		if (cid == VMADDR_CID_ANY)
+			cid = vsock_registered_transport_cid(&transport_h2g);
+		if (cid == VMADDR_CID_ANY)
+			cid = vsock_registered_transport_cid(&transport_local);
 
 		if (put_user(cid, p) != 0)
 			retval = -EFAULT;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index c778ffa1c8ef..4eb44821c70d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -229,6 +229,7 @@ static int validate_beacon_head(const struct nlattr *attr,
 	unsigned int len = nla_len(attr);
 	const struct element *elem;
 	const struct ieee80211_mgmt *mgmt = (void *)data;
+	const struct ieee80211_ext *ext;
 	unsigned int fixedlen, hdrlen;
 	bool s1g_bcn;
 
@@ -237,8 +238,10 @@ static int validate_beacon_head(const struct nlattr *attr,
 
 	s1g_bcn = ieee80211_is_s1g_beacon(mgmt->frame_control);
 	if (s1g_bcn) {
-		fixedlen = offsetof(struct ieee80211_ext,
-				    u.s1g_beacon.variable);
+		ext = (struct ieee80211_ext *)mgmt;
+		fixedlen =
+			offsetof(struct ieee80211_ext, u.s1g_beacon.variable) +
+			ieee80211_s1g_optional_len(ext->frame_control);
 		hdrlen = offsetof(struct ieee80211_ext, u.s1g_beacon);
 	} else {
 		fixedlen = offsetof(struct ieee80211_mgmt,
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 18585b1416c6..b115489a846f 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -820,6 +820,52 @@ bool ieee80211_is_valid_amsdu(struct sk_buff *skb, u8 mesh_hdr)
 }
 EXPORT_SYMBOL(ieee80211_is_valid_amsdu);
 
+
+/*
+ * Detects if an MSDU frame was maliciously converted into an A-MSDU
+ * frame by an adversary. This is done by parsing the received frame
+ * as if it were a regular MSDU, even though the A-MSDU flag is set.
+ *
+ * For non-mesh interfaces, detection involves checking whether the
+ * payload, when interpreted as an MSDU, begins with a valid RFC1042
+ * header. This is done by comparing the A-MSDU subheader's destination
+ * address to the start of the RFC1042 header.
+ *
+ * For mesh interfaces, the MSDU includes a 6-byte Mesh Control field
+ * and an optional variable-length Mesh Address Extension field before
+ * the RFC1042 header. The position of the RFC1042 header must therefore
+ * be calculated based on the mesh header length.
+ *
+ * Since this function intentionally parses an A-MSDU frame as an MSDU,
+ * it only assumes that the A-MSDU subframe header is present, and
+ * beyond this it performs its own bounds checks under the assumption
+ * that the frame is instead parsed as a non-aggregated MSDU.
+ */
+static bool
+is_amsdu_aggregation_attack(struct ethhdr *eth, struct sk_buff *skb,
+			    enum nl80211_iftype iftype)
+{
+	int offset;
+
+	/* Non-mesh case can be directly compared */
+	if (iftype != NL80211_IFTYPE_MESH_POINT)
+		return ether_addr_equal(eth->h_dest, rfc1042_header);
+
+	offset = __ieee80211_get_mesh_hdrlen(eth->h_dest[0]);
+	if (offset == 6) {
+		/* Mesh case with empty address extension field */
+		return ether_addr_equal(eth->h_source, rfc1042_header);
+	} else if (offset + ETH_ALEN <= skb->len) {
+		/* Mesh case with non-empty address extension field */
+		u8 temp[ETH_ALEN];
+
+		skb_copy_bits(skb, offset, temp, ETH_ALEN);
+		return ether_addr_equal(temp, rfc1042_header);
+	}
+
+	return false;
+}
+
 void ieee80211_amsdu_to_8023s(struct sk_buff *skb, struct sk_buff_head *list,
 			      const u8 *addr, enum nl80211_iftype iftype,
 			      const unsigned int extra_headroom,
@@ -861,8 +907,10 @@ void ieee80211_amsdu_to_8023s(struct sk_buff *skb, struct sk_buff_head *list,
 		/* the last MSDU has no padding */
 		if (subframe_len > remaining)
 			goto purge;
-		/* mitigate A-MSDU aggregation injection attacks */
-		if (ether_addr_equal(hdr.eth.h_dest, rfc1042_header))
+		/* mitigate A-MSDU aggregation injection attacks, to be
+		 * checked when processing first subframe (offset == 0).
+		 */
+		if (offset == 0 && is_amsdu_aggregation_attack(&hdr.eth, skb, iftype))
 			goto purge;
 
 		offset += sizeof(struct ethhdr);
diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
index b7213962a6a5..e530028bb9ed 100644
--- a/rust/kernel/init/macros.rs
+++ b/rust/kernel/init/macros.rs
@@ -924,6 +924,7 @@ impl<'__pin, $($impl_generics)*> ::core::marker::Unpin for $name<$($ty_generics)
         // We prevent this by creating a trait that will be implemented for all types implementing
         // `Drop`. Additionally we will implement this trait for the struct leading to a conflict,
         // if it also implements `Drop`
+        #[allow(dead_code)]
         trait MustNotImplDrop {}
         #[expect(drop_bounds)]
         impl<T: ::core::ops::Drop> MustNotImplDrop for T {}
@@ -932,6 +933,7 @@ impl<$($impl_generics)*> MustNotImplDrop for $name<$($ty_generics)*>
         // We also take care to prevent users from writing a useless `PinnedDrop` implementation.
         // They might implement `PinnedDrop` correctly for the struct, but forget to give
         // `PinnedDrop` as the parameter to `#[pin_data]`.
+        #[allow(dead_code)]
         #[expect(non_camel_case_types)]
         trait UselessPinnedDropImpl_you_need_to_specify_PinnedDrop {}
         impl<T: $crate::init::PinnedDrop>
diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index fd6bd69c5096..f795302ddfa8 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -20,6 +20,7 @@
 #include <linux/of_fdt.h>
 #include <linux/page_ext.h>
 #include <linux/radix-tree.h>
+#include <linux/maple_tree.h>
 #include <linux/slab.h>
 #include <linux/threads.h>
 #include <linux/vmalloc.h>
@@ -93,6 +94,12 @@ LX_GDBPARSED(RADIX_TREE_MAP_SIZE)
 LX_GDBPARSED(RADIX_TREE_MAP_SHIFT)
 LX_GDBPARSED(RADIX_TREE_MAP_MASK)
 
+/* linux/maple_tree.h */
+LX_VALUE(MAPLE_NODE_SLOTS)
+LX_VALUE(MAPLE_RANGE64_SLOTS)
+LX_VALUE(MAPLE_ARANGE64_SLOTS)
+LX_GDBPARSED(MAPLE_NODE_MASK)
+
 /* linux/vmalloc.h */
 LX_VALUE(VM_IOREMAP)
 LX_VALUE(VM_ALLOC)
diff --git a/scripts/gdb/linux/interrupts.py b/scripts/gdb/linux/interrupts.py
index 616a5f26377a..f4f715a8f0e3 100644
--- a/scripts/gdb/linux/interrupts.py
+++ b/scripts/gdb/linux/interrupts.py
@@ -7,7 +7,7 @@ import gdb
 from linux import constants
 from linux import cpus
 from linux import utils
-from linux import radixtree
+from linux import mapletree
 
 irq_desc_type = utils.CachedType("struct irq_desc")
 
@@ -23,12 +23,12 @@ def irqd_is_level(desc):
 def show_irq_desc(prec, irq):
     text = ""
 
-    desc = radixtree.lookup(gdb.parse_and_eval("&irq_desc_tree"), irq)
+    desc = mapletree.mtree_load(gdb.parse_and_eval("&sparse_irqs"), irq)
     if desc is None:
         return text
 
-    desc = desc.cast(irq_desc_type.get_type())
-    if desc is None:
+    desc = desc.cast(irq_desc_type.get_type().pointer())
+    if desc == 0:
         return text
 
     if irq_settings_is_hidden(desc):
@@ -110,7 +110,7 @@ def x86_show_mce(prec, var, pfx, desc):
     pvar = gdb.parse_and_eval(var)
     text = "%*s: " % (prec, pfx)
     for cpu in cpus.each_online_cpu():
-        text += "%10u " % (cpus.per_cpu(pvar, cpu))
+        text += "%10u " % (cpus.per_cpu(pvar, cpu).dereference())
     text += "  %s\n" % (desc)
     return text
 
@@ -142,7 +142,7 @@ def x86_show_interupts(prec):
 
     if constants.LX_CONFIG_X86_MCE:
         text += x86_show_mce(prec, "&mce_exception_count", "MCE", "Machine check exceptions")
-        text == x86_show_mce(prec, "&mce_poll_count", "MCP", "Machine check polls")
+        text += x86_show_mce(prec, "&mce_poll_count", "MCP", "Machine check polls")
 
     text += show_irq_err_count(prec)
 
@@ -221,8 +221,8 @@ class LxInterruptList(gdb.Command):
             gdb.write("CPU%-8d" % cpu)
         gdb.write("\n")
 
-        if utils.gdb_eval_or_none("&irq_desc_tree") is None:
-            return
+        if utils.gdb_eval_or_none("&sparse_irqs") is None:
+            raise gdb.GdbError("Unable to find the sparse IRQ tree, is CONFIG_SPARSE_IRQ enabled?")
 
         for irq in range(nr_irqs):
             gdb.write(show_irq_desc(prec, irq))
diff --git a/scripts/gdb/linux/mapletree.py b/scripts/gdb/linux/mapletree.py
new file mode 100644
index 000000000000..d52d51c0a03f
--- /dev/null
+++ b/scripts/gdb/linux/mapletree.py
@@ -0,0 +1,252 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+#  Maple tree helpers
+#
+# Copyright (c) 2025 Broadcom
+#
+# Authors:
+#  Florian Fainelli <florian.fainelli@broadcom.com>
+
+import gdb
+
+from linux import utils
+from linux import constants
+from linux import xarray
+
+maple_tree_root_type = utils.CachedType("struct maple_tree")
+maple_node_type = utils.CachedType("struct maple_node")
+maple_enode_type = utils.CachedType("void")
+
+maple_dense = 0
+maple_leaf_64 = 1
+maple_range_64 = 2
+maple_arange_64 = 3
+
+class Mas(object):
+    ma_active = 0
+    ma_start = 1
+    ma_root = 2
+    ma_none = 3
+    ma_pause = 4
+    ma_overflow = 5
+    ma_underflow = 6
+    ma_error = 7
+
+    def __init__(self, mt, first, end):
+        if mt.type == maple_tree_root_type.get_type().pointer():
+            self.tree = mt.dereference()
+        elif mt.type != maple_tree_root_type.get_type():
+            raise gdb.GdbError("must be {} not {}"
+                               .format(maple_tree_root_type.get_type().pointer(), mt.type))
+        self.tree = mt
+        self.index = first
+        self.last = end
+        self.node = None
+        self.status = self.ma_start
+        self.min = 0
+        self.max = -1
+
+    def is_start(self):
+        # mas_is_start()
+        return self.status == self.ma_start
+
+    def is_ptr(self):
+        # mas_is_ptr()
+        return self.status == self.ma_root
+
+    def is_none(self):
+        # mas_is_none()
+        return self.status == self.ma_none
+
+    def root(self):
+        # mas_root()
+        return self.tree['ma_root'].cast(maple_enode_type.get_type().pointer())
+
+    def start(self):
+        # mas_start()
+        if self.is_start() is False:
+            return None
+
+        self.min = 0
+        self.max = ~0
+
+        while True:
+            self.depth = 0
+            root = self.root()
+            if xarray.xa_is_node(root):
+                self.depth = 0
+                self.status = self.ma_active
+                self.node = mte_safe_root(root)
+                self.offset = 0
+                if mte_dead_node(self.node) is True:
+                    continue
+
+                return None
+
+            self.node = None
+            # Empty tree
+            if root is None:
+                self.status = self.ma_none
+                self.offset = constants.LX_MAPLE_NODE_SLOTS
+                return None
+
+            # Single entry tree
+            self.status = self.ma_root
+            self.offset = constants.LX_MAPLE_NODE_SLOTS
+
+            if self.index != 0:
+                return None
+
+            return root
+
+        return None
+
+    def reset(self):
+        # mas_reset()
+        self.status = self.ma_start
+        self.node = None
+
+def mte_safe_root(node):
+    if node.type != maple_enode_type.get_type().pointer():
+        raise gdb.GdbError("{} must be {} not {}"
+                           .format(mte_safe_root.__name__, maple_enode_type.get_type().pointer(), node.type))
+    ulong_type = utils.get_ulong_type()
+    indirect_ptr = node.cast(ulong_type) & ~0x2
+    val = indirect_ptr.cast(maple_enode_type.get_type().pointer())
+    return val
+
+def mte_node_type(entry):
+    ulong_type = utils.get_ulong_type()
+    val = None
+    if entry.type == maple_enode_type.get_type().pointer():
+        val = entry.cast(ulong_type)
+    elif entry.type == ulong_type:
+        val = entry
+    else:
+        raise gdb.GdbError("{} must be {} not {}"
+                           .format(mte_node_type.__name__, maple_enode_type.get_type().pointer(), entry.type))
+    return (val >> 0x3) & 0xf
+
+def ma_dead_node(node):
+    if node.type != maple_node_type.get_type().pointer():
+        raise gdb.GdbError("{} must be {} not {}"
+                           .format(ma_dead_node.__name__, maple_node_type.get_type().pointer(), node.type))
+    ulong_type = utils.get_ulong_type()
+    parent = node['parent']
+    indirect_ptr = node['parent'].cast(ulong_type) & ~constants.LX_MAPLE_NODE_MASK
+    return indirect_ptr == node
+
+def mte_to_node(enode):
+    ulong_type = utils.get_ulong_type()
+    if enode.type == maple_enode_type.get_type().pointer():
+        indirect_ptr = enode.cast(ulong_type)
+    elif enode.type == ulong_type:
+        indirect_ptr = enode
+    else:
+        raise gdb.GdbError("{} must be {} not {}"
+                           .format(mte_to_node.__name__, maple_enode_type.get_type().pointer(), enode.type))
+    indirect_ptr = indirect_ptr & ~constants.LX_MAPLE_NODE_MASK
+    return indirect_ptr.cast(maple_node_type.get_type().pointer())
+
+def mte_dead_node(enode):
+    if enode.type != maple_enode_type.get_type().pointer():
+        raise gdb.GdbError("{} must be {} not {}"
+                           .format(mte_dead_node.__name__, maple_enode_type.get_type().pointer(), enode.type))
+    node = mte_to_node(enode)
+    return ma_dead_node(node)
+
+def ma_is_leaf(tp):
+    result = tp < maple_range_64
+    return tp < maple_range_64
+
+def mt_pivots(t):
+    if t == maple_dense:
+        return 0
+    elif t == maple_leaf_64 or t == maple_range_64:
+        return constants.LX_MAPLE_RANGE64_SLOTS - 1
+    elif t == maple_arange_64:
+        return constants.LX_MAPLE_ARANGE64_SLOTS - 1
+
+def ma_pivots(node, t):
+    if node.type != maple_node_type.get_type().pointer():
+        raise gdb.GdbError("{}: must be {} not {}"
+                           .format(ma_pivots.__name__, maple_node_type.get_type().pointer(), node.type))
+    if t == maple_arange_64:
+        return node['ma64']['pivot']
+    elif t == maple_leaf_64 or t == maple_range_64:
+        return node['mr64']['pivot']
+    else:
+        return None
+
+def ma_slots(node, tp):
+    if node.type != maple_node_type.get_type().pointer():
+        raise gdb.GdbError("{}: must be {} not {}"
+                           .format(ma_slots.__name__, maple_node_type.get_type().pointer(), node.type))
+    if tp == maple_arange_64:
+        return node['ma64']['slot']
+    elif tp == maple_range_64 or tp == maple_leaf_64:
+        return node['mr64']['slot']
+    elif tp == maple_dense:
+        return node['slot']
+    else:
+        return None
+
+def mt_slot(mt, slots, offset):
+    ulong_type = utils.get_ulong_type()
+    return slots[offset].cast(ulong_type)
+
+def mtree_lookup_walk(mas):
+    ulong_type = utils.get_ulong_type()
+    n = mas.node
+
+    while True:
+        node = mte_to_node(n)
+        tp = mte_node_type(n)
+        pivots = ma_pivots(node, tp)
+        end = mt_pivots(tp)
+        offset = 0
+        while True:
+            if pivots[offset] >= mas.index:
+                break
+            if offset >= end:
+                break
+            offset += 1
+
+        slots = ma_slots(node, tp)
+        n = mt_slot(mas.tree, slots, offset)
+        if ma_dead_node(node) is True:
+            mas.reset()
+            return None
+            break
+
+        if ma_is_leaf(tp) is True:
+            break
+
+    return n
+
+def mtree_load(mt, index):
+    ulong_type = utils.get_ulong_type()
+    # MT_STATE(...)
+    mas = Mas(mt, index, index)
+    entry = None
+
+    while True:
+        entry = mas.start()
+        if mas.is_none():
+            return None
+
+        if mas.is_ptr():
+            if index != 0:
+                entry = None
+            return entry
+
+        entry = mtree_lookup_walk(mas)
+        if entry is None and mas.is_start():
+            continue
+        else:
+            break
+
+    if xarray.xa_is_zero(entry):
+        return None
+
+    return entry
diff --git a/scripts/gdb/linux/xarray.py b/scripts/gdb/linux/xarray.py
new file mode 100644
index 000000000000..f4477b5def75
--- /dev/null
+++ b/scripts/gdb/linux/xarray.py
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+#  Xarray helpers
+#
+# Copyright (c) 2025 Broadcom
+#
+# Authors:
+#  Florian Fainelli <florian.fainelli@broadcom.com>
+
+import gdb
+
+from linux import utils
+from linux import constants
+
+def xa_is_internal(entry):
+    ulong_type = utils.get_ulong_type()
+    return ((entry.cast(ulong_type) & 3) == 2)
+
+def xa_mk_internal(v):
+    return ((v << 2) | 2)
+
+def xa_is_zero(entry):
+    ulong_type = utils.get_ulong_type()
+    return entry.cast(ulong_type) == xa_mk_internal(257)
+
+def xa_is_node(entry):
+    ulong_type = utils.get_ulong_type()
+    return xa_is_internal(entry) and (entry.cast(ulong_type) > 4096)
diff --git a/sound/isa/ad1816a/ad1816a.c b/sound/isa/ad1816a/ad1816a.c
index 99006dc4777e..5c9e2d41d900 100644
--- a/sound/isa/ad1816a/ad1816a.c
+++ b/sound/isa/ad1816a/ad1816a.c
@@ -98,7 +98,7 @@ static int snd_card_ad1816a_pnp(int dev, struct pnp_card_link *card,
 	pdev = pnp_request_card_device(card, id->devs[1].id, NULL);
 	if (pdev == NULL) {
 		mpu_port[dev] = -1;
-		dev_warn(&pdev->dev, "MPU401 device busy, skipping.\n");
+		pr_warn("MPU401 device busy, skipping.\n");
 		return 0;
 	}
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 30e9e26c5b2a..e98823bd3634 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2658,6 +2658,7 @@ static const struct hda_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x147b, 0x107a, "Abit AW9D-MAX", ALC882_FIXUP_ABIT_AW9D_MAX),
 	SND_PCI_QUIRK(0x1558, 0x3702, "Clevo X370SN[VW]", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
 	SND_PCI_QUIRK(0x1558, 0x50d3, "Clevo PC50[ER][CDF]", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
+	SND_PCI_QUIRK(0x1558, 0x5802, "Clevo X58[05]WN[RST]", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
 	SND_PCI_QUIRK(0x1558, 0x65d1, "Clevo PB51[ER][CDF]", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
 	SND_PCI_QUIRK(0x1558, 0x65d2, "Clevo PB51R[CDF]", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
 	SND_PCI_QUIRK(0x1558, 0x65e1, "Clevo PB51[ED][DF]", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
@@ -6611,6 +6612,7 @@ static void alc294_fixup_bass_speaker_15(struct hda_codec *codec,
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		static const hda_nid_t conn[] = { 0x02, 0x03 };
 		snd_hda_override_conn_list(codec, 0x15, ARRAY_SIZE(conn), conn);
+		snd_hda_gen_add_micmute_led_cdev(codec, NULL);
 	}
 }
 
@@ -10654,6 +10656,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8975, "HP EliteBook x360 840 Aero G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x897d, "HP mt440 Mobile Thin Client U74", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8981, "HP Elite Dragonfly G3", ALC245_FIXUP_CS35L41_SPI_4),
+	SND_PCI_QUIRK(0x103c, 0x898a, "HP Pavilion 15-eg100", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x898e, "HP EliteBook 835 G9", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x898f, "HP EliteBook 835 G9", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8991, "HP EliteBook 845 G9", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
@@ -11044,6 +11047,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1558, 0x14a1, "Clevo L141MU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x2624, "Clevo L240TU", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x28c1, "Clevo V370VND", ALC2XX_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1558, 0x35a1, "Clevo V3[56]0EN[CDE]", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1558, 0x35b1, "Clevo V3[57]0WN[MNP]Q", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x4018, "Clevo NV40M[BE]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x4019, "Clevo NV40MZ", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x4020, "Clevo NV40MB", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
@@ -11071,6 +11076,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1558, 0x51b1, "Clevo NS50AU", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x51b3, "Clevo NS70AU", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x5630, "Clevo NP50RNJS", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1558, 0x5700, "Clevo X560WN[RST]", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x70a1, "Clevo NB70T[HJK]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x70b3, "Clevo NK70SB", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x70f2, "Clevo NH79EPY", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
@@ -11110,6 +11116,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1558, 0xa650, "Clevo NP[567]0SN[CD]", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xa671, "Clevo NP70SN[CDE]", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xa741, "Clevo V54x_6x_TNE", ALC245_FIXUP_CLEVO_NOISY_MIC),
+	SND_PCI_QUIRK(0x1558, 0xa743, "Clevo V54x_6x_TU", ALC245_FIXUP_CLEVO_NOISY_MIC),
 	SND_PCI_QUIRK(0x1558, 0xa763, "Clevo V54x_6x_TU", ALC245_FIXUP_CLEVO_NOISY_MIC),
 	SND_PCI_QUIRK(0x1558, 0xb018, "Clevo NP50D[BE]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xb019, "Clevo NH77D[BE]Q", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 723cb7bc1285..1689b6b22598 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -346,6 +346,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "RB"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Nitro ANV15-41"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 195841a567c3..9007484b31c7 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -811,7 +811,7 @@ int cs35l56_hw_init(struct cs35l56_base *cs35l56_base)
 		break;
 	default:
 		dev_err(cs35l56_base->dev, "Unknown device %x\n", devid);
-		return ret;
+		return -ENODEV;
 	}
 
 	cs35l56_base->type = devid & 0xFF;
diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index bd5c46d763c0..ffd4a6ca5f3c 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -517,7 +517,8 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair, bool use_ideal_rate)
 	regmap_update_bits(asrc->regmap, REG_ASRCTR,
 			   ASRCTR_ATSi_MASK(index), ASRCTR_ATS(index));
 	regmap_update_bits(asrc->regmap, REG_ASRCTR,
-			   ASRCTR_USRi_MASK(index), 0);
+			   ASRCTR_IDRi_MASK(index) | ASRCTR_USRi_MASK(index),
+			   ASRCTR_USR(index));
 
 	/* Set the input and output clock sources */
 	regmap_update_bits(asrc->regmap, REG_ASRCSR,
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index c5efbceb06d1..25d4b27f5b76 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -771,13 +771,15 @@ static void fsl_sai_config_disable(struct fsl_sai *sai, int dir)
 	 * anymore. Add software reset to fix this issue.
 	 * This is a hardware bug, and will be fix in the
 	 * next sai version.
+	 *
+	 * In consumer mode, this can happen even after a
+	 * single open/close, especially if both tx and rx
+	 * are running concurrently.
 	 */
-	if (!sai->is_consumer_mode[tx]) {
-		/* Software Reset */
-		regmap_write(sai->regmap, FSL_SAI_xCSR(tx, ofs), FSL_SAI_CSR_SR);
-		/* Clear SR bit to finish the reset */
-		regmap_write(sai->regmap, FSL_SAI_xCSR(tx, ofs), 0);
-	}
+	/* Software Reset */
+	regmap_write(sai->regmap, FSL_SAI_xCSR(tx, ofs), FSL_SAI_CSR_SR);
+	/* Clear SR bit to finish the reset */
+	regmap_write(sai->regmap, FSL_SAI_xCSR(tx, ofs), 0);
 }
 
 static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index cc10ae58b0c7..8dee46abf346 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -42,6 +42,7 @@ config SND_SOC_INTEL_SOF_NUVOTON_COMMON
 	tristate
 
 config SND_SOC_INTEL_SOF_BOARD_HELPERS
+	select SND_SOC_ACPI_INTEL_MATCH
 	tristate
 
 if SND_SOC_INTEL_CATPT
diff --git a/sound/soc/intel/common/Makefile b/sound/soc/intel/common/Makefile
index 91e146e2487d..a9a740e24969 100644
--- a/sound/soc/intel/common/Makefile
+++ b/sound/soc/intel/common/Makefile
@@ -14,7 +14,7 @@ snd-soc-acpi-intel-match-y := soc-acpi-intel-byt-match.o soc-acpi-intel-cht-matc
 	soc-acpi-intel-lnl-match.o \
 	soc-acpi-intel-ptl-match.o \
 	soc-acpi-intel-hda-match.o \
-	soc-acpi-intel-sdw-mockup-match.o
+	soc-acpi-intel-sdw-mockup-match.o sof-function-topology-lib.o
 
 snd-soc-acpi-intel-match-y += soc-acpi-intel-ssp-common.o
 
diff --git a/sound/soc/intel/common/soc-acpi-intel-arl-match.c b/sound/soc/intel/common/soc-acpi-intel-arl-match.c
index 24d850df77ca..1ad704ca2c5f 100644
--- a/sound/soc/intel/common/soc-acpi-intel-arl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-arl-match.c
@@ -8,6 +8,7 @@
 #include <sound/soc-acpi.h>
 #include <sound/soc-acpi-intel-match.h>
 #include <sound/soc-acpi-intel-ssp-common.h>
+#include "sof-function-topology-lib.h"
 
 static const struct snd_soc_acpi_endpoint single_endpoint = {
 	.num = 0,
@@ -138,7 +139,7 @@ static const struct snd_soc_acpi_adr_device cs35l56_2_r1_adr[] = {
 	},
 };
 
-static const struct snd_soc_acpi_adr_device cs35l56_3_l1_adr[] = {
+static const struct snd_soc_acpi_adr_device cs35l56_3_l3_adr[] = {
 	{
 		.adr = 0x00033301fa355601ull,
 		.num_endpoints = 1,
@@ -147,6 +148,24 @@ static const struct snd_soc_acpi_adr_device cs35l56_3_l1_adr[] = {
 	},
 };
 
+static const struct snd_soc_acpi_adr_device cs35l56_2_r3_adr[] = {
+	{
+		.adr = 0x00023301fa355601ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_r_endpoint,
+		.name_prefix = "AMP2"
+	},
+};
+
+static const struct snd_soc_acpi_adr_device cs35l56_3_l1_adr[] = {
+	{
+		.adr = 0x00033101fa355601ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_l_endpoint,
+		.name_prefix = "AMP1"
+	},
+};
+
 static const struct snd_soc_acpi_endpoint cs42l43_endpoints[] = {
 	{ /* Jack Playback Endpoint */
 		.num = 0,
@@ -304,6 +323,25 @@ static const struct snd_soc_acpi_link_adr arl_cs42l43_l0_cs35l56_2_l23[] = {
 		.num_adr = ARRAY_SIZE(cs35l56_2_r1_adr),
 		.adr_d = cs35l56_2_r1_adr,
 	},
+	{
+		.mask = BIT(3),
+		.num_adr = ARRAY_SIZE(cs35l56_3_l3_adr),
+		.adr_d = cs35l56_3_l3_adr,
+	},
+	{}
+};
+
+static const struct snd_soc_acpi_link_adr arl_cs42l43_l0_cs35l56_3_l23[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(cs42l43_0_adr),
+		.adr_d = cs42l43_0_adr,
+	},
+	{
+		.mask = BIT(2),
+		.num_adr = ARRAY_SIZE(cs35l56_2_r3_adr),
+		.adr_d = cs35l56_2_r3_adr,
+	},
 	{
 		.mask = BIT(3),
 		.num_adr = ARRAY_SIZE(cs35l56_3_l1_adr),
@@ -399,36 +437,49 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_arl_sdw_machines[] = {
 		.links = arl_cs42l43_l0_cs35l56_l23,
 		.drv_name = "sof_sdw",
 		.sof_tplg_filename = "sof-arl-cs42l43-l0-cs35l56-l23.tplg",
+		.get_function_tplg_files = sof_sdw_get_tplg_files,
 	},
 	{
 		.link_mask = BIT(0) | BIT(2) | BIT(3),
 		.links = arl_cs42l43_l0_cs35l56_2_l23,
 		.drv_name = "sof_sdw",
 		.sof_tplg_filename = "sof-arl-cs42l43-l0-cs35l56-l23.tplg",
+		.get_function_tplg_files = sof_sdw_get_tplg_files,
+	},
+	{
+		.link_mask = BIT(0) | BIT(2) | BIT(3),
+		.links = arl_cs42l43_l0_cs35l56_3_l23,
+		.drv_name = "sof_sdw",
+		.sof_tplg_filename = "sof-arl-cs42l43-l0-cs35l56-l23.tplg",
+		.get_function_tplg_files = sof_sdw_get_tplg_files,
 	},
 	{
 		.link_mask = BIT(0) | BIT(2),
 		.links = arl_cs42l43_l0_cs35l56_l2,
 		.drv_name = "sof_sdw",
 		.sof_tplg_filename = "sof-arl-cs42l43-l0-cs35l56-l2.tplg",
+		.get_function_tplg_files = sof_sdw_get_tplg_files,
 	},
 	{
 		.link_mask = BIT(0),
 		.links = arl_cs42l43_l0,
 		.drv_name = "sof_sdw",
 		.sof_tplg_filename = "sof-arl-cs42l43-l0.tplg",
-	},
-	{
-		.link_mask = BIT(2),
-		.links = arl_cs42l43_l2,
-		.drv_name = "sof_sdw",
-		.sof_tplg_filename = "sof-arl-cs42l43-l2.tplg",
+		.get_function_tplg_files = sof_sdw_get_tplg_files,
 	},
 	{
 		.link_mask = BIT(2) | BIT(3),
 		.links = arl_cs42l43_l2_cs35l56_l3,
 		.drv_name = "sof_sdw",
 		.sof_tplg_filename = "sof-arl-cs42l43-l2-cs35l56-l3.tplg",
+		.get_function_tplg_files = sof_sdw_get_tplg_files,
+	},
+	{
+		.link_mask = BIT(2),
+		.links = arl_cs42l43_l2,
+		.drv_name = "sof_sdw",
+		.sof_tplg_filename = "sof-arl-cs42l43-l2.tplg",
+		.get_function_tplg_files = sof_sdw_get_tplg_files,
 	},
 	{
 		.link_mask = 0x1, /* link0 required */
@@ -447,6 +498,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_arl_sdw_machines[] = {
 		.links = arl_rt722_l0_rt1320_l2,
 		.drv_name = "sof_sdw",
 		.sof_tplg_filename = "sof-arl-rt722-l0_rt1320-l2.tplg",
+		.get_function_tplg_files = sof_sdw_get_tplg_files,
 	},
 	{},
 };
diff --git a/sound/soc/intel/common/sof-function-topology-lib.c b/sound/soc/intel/common/sof-function-topology-lib.c
new file mode 100644
index 000000000000..3cc81dcf047e
--- /dev/null
+++ b/sound/soc/intel/common/sof-function-topology-lib.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license.  When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2025 Intel Corporation.
+//
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/firmware.h>
+#include <sound/soc.h>
+#include <sound/soc-acpi.h>
+#include "sof-function-topology-lib.h"
+
+enum tplg_device_id {
+	TPLG_DEVICE_SDCA_JACK,
+	TPLG_DEVICE_SDCA_AMP,
+	TPLG_DEVICE_SDCA_MIC,
+	TPLG_DEVICE_INTEL_PCH_DMIC,
+	TPLG_DEVICE_HDMI,
+	TPLG_DEVICE_MAX
+};
+
+#define SDCA_DEVICE_MASK (BIT(TPLG_DEVICE_SDCA_JACK) | BIT(TPLG_DEVICE_SDCA_AMP) | \
+			  BIT(TPLG_DEVICE_SDCA_MIC))
+
+#define SOF_INTEL_PLATFORM_NAME_MAX 4
+
+int sof_sdw_get_tplg_files(struct snd_soc_card *card, const struct snd_soc_acpi_mach *mach,
+			   const char *prefix, const char ***tplg_files)
+{
+	struct snd_soc_acpi_mach_params mach_params = mach->mach_params;
+	struct snd_soc_dai_link *dai_link;
+	const struct firmware *fw;
+	char platform[SOF_INTEL_PLATFORM_NAME_MAX];
+	unsigned long tplg_mask = 0;
+	int tplg_num = 0;
+	int tplg_dev;
+	int ret;
+	int i;
+
+	ret = sscanf(mach->sof_tplg_filename, "sof-%3s-*.tplg", platform);
+	if (ret != 1) {
+		dev_err(card->dev, "Invalid platform name %s of tplg %s\n",
+			platform, mach->sof_tplg_filename);
+		return -EINVAL;
+	}
+
+	for_each_card_prelinks(card, i, dai_link) {
+		char *tplg_dev_name;
+
+		dev_dbg(card->dev, "dai_link %s id %d\n", dai_link->name, dai_link->id);
+		if (strstr(dai_link->name, "SimpleJack")) {
+			tplg_dev = TPLG_DEVICE_SDCA_JACK;
+			tplg_dev_name = "sdca-jack";
+		} else if (strstr(dai_link->name, "SmartAmp")) {
+			tplg_dev = TPLG_DEVICE_SDCA_AMP;
+			tplg_dev_name = devm_kasprintf(card->dev, GFP_KERNEL,
+						       "sdca-%damp", dai_link->num_cpus);
+			if (!tplg_dev_name)
+				return -ENOMEM;
+		} else if (strstr(dai_link->name, "SmartMic")) {
+			tplg_dev = TPLG_DEVICE_SDCA_MIC;
+			tplg_dev_name = "sdca-mic";
+		} else if (strstr(dai_link->name, "dmic")) {
+			switch (mach_params.dmic_num) {
+			case 2:
+				tplg_dev_name = "dmic-2ch";
+				break;
+			case 4:
+				tplg_dev_name = "dmic-4ch";
+				break;
+			default:
+				dev_warn(card->dev,
+					 "unsupported number of dmics: %d\n",
+					 mach_params.dmic_num);
+				continue;
+			}
+			tplg_dev = TPLG_DEVICE_INTEL_PCH_DMIC;
+		} else if (strstr(dai_link->name, "iDisp")) {
+			tplg_dev = TPLG_DEVICE_HDMI;
+			tplg_dev_name = "hdmi-pcm5";
+
+		} else {
+			/* The dai link is not supported by separated tplg yet */
+			dev_dbg(card->dev,
+				"dai_link %s is not supported by separated tplg yet\n",
+				dai_link->name);
+			return 0;
+		}
+		if (tplg_mask & BIT(tplg_dev))
+			continue;
+
+		tplg_mask |= BIT(tplg_dev);
+
+		/*
+		 * The tplg file naming rule is sof-<platform>-<function>-id<BE id number>.tplg
+		 * where <platform> is only required for the DMIC function as the nhlt blob
+		 * is platform dependent.
+		 */
+		switch (tplg_dev) {
+		case TPLG_DEVICE_INTEL_PCH_DMIC:
+			(*tplg_files)[tplg_num] = devm_kasprintf(card->dev, GFP_KERNEL,
+								 "%s/sof-%s-%s-id%d.tplg",
+								 prefix, platform,
+								 tplg_dev_name, dai_link->id);
+			break;
+		default:
+			(*tplg_files)[tplg_num] = devm_kasprintf(card->dev, GFP_KERNEL,
+								 "%s/sof-%s-id%d.tplg",
+								 prefix, tplg_dev_name,
+								 dai_link->id);
+			break;
+		}
+		if (!(*tplg_files)[tplg_num])
+			return -ENOMEM;
+		tplg_num++;
+	}
+
+	dev_dbg(card->dev, "tplg_mask %#lx tplg_num %d\n", tplg_mask, tplg_num);
+
+	/* Check presence of sub-topologies */
+	for (i = 0; i < tplg_num; i++) {
+		ret = firmware_request_nowarn(&fw, (*tplg_files)[i], card->dev);
+		if (!ret) {
+			release_firmware(fw);
+		} else {
+			dev_dbg(card->dev, "Failed to open topology file: %s\n", (*tplg_files)[i]);
+			return 0;
+		}
+	}
+
+	return tplg_num;
+}
+
diff --git a/sound/soc/intel/common/sof-function-topology-lib.h b/sound/soc/intel/common/sof-function-topology-lib.h
new file mode 100644
index 000000000000..e7d0c39d0788
--- /dev/null
+++ b/sound/soc/intel/common/sof-function-topology-lib.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * soc-acpi-intel-get-tplg.h - get-tplg-files ops
+ *
+ * Copyright (c) 2025, Intel Corporation.
+ *
+ */
+
+#ifndef _SND_SOC_ACPI_INTEL_GET_TPLG_H
+#define _SND_SOC_ACPI_INTEL_GET_TPLG_H
+
+int sof_sdw_get_tplg_files(struct snd_soc_card *card, const struct snd_soc_acpi_mach *mach,
+			   const char *prefix, const char ***tplg_files);
+
+#endif
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 9c8f79e55ec5..624598c9e2df 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -1209,11 +1209,11 @@ static int check_tplg_quirk_mask(struct snd_soc_acpi_mach *mach)
 	return 0;
 }
 
-static char *remove_file_ext(const char *tplg_filename)
+static char *remove_file_ext(struct device *dev, const char *tplg_filename)
 {
 	char *filename, *tmp;
 
-	filename = kstrdup(tplg_filename, GFP_KERNEL);
+	filename = devm_kstrdup(dev, tplg_filename, GFP_KERNEL);
 	if (!filename)
 		return NULL;
 
@@ -1297,7 +1297,7 @@ struct snd_soc_acpi_mach *hda_machine_select(struct snd_sof_dev *sdev)
 		 */
 		if (!sof_pdata->tplg_filename) {
 			/* remove file extension if it exists */
-			tplg_filename = remove_file_ext(mach->sof_tplg_filename);
+			tplg_filename = remove_file_ext(sdev->dev, mach->sof_tplg_filename);
 			if (!tplg_filename)
 				return NULL;
 
diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 3ae84c3b8e6d..3deb6c11f134 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -612,6 +612,7 @@
 #define MSR_AMD64_OSVW_STATUS		0xc0010141
 #define MSR_AMD_PPIN_CTL		0xc00102f0
 #define MSR_AMD_PPIN			0xc00102f1
+#define MSR_AMD64_CPUID_FN_7		0xc0011002
 #define MSR_AMD64_CPUID_FN_1		0xc0011004
 #define MSR_AMD64_LS_CFG		0xc0011020
 #define MSR_AMD64_DC_CFG		0xc0011022
diff --git a/tools/include/linux/kallsyms.h b/tools/include/linux/kallsyms.h
index 5a37ccbec54f..f61a01dd7eb7 100644
--- a/tools/include/linux/kallsyms.h
+++ b/tools/include/linux/kallsyms.h
@@ -18,6 +18,7 @@ static inline const char *kallsyms_lookup(unsigned long addr,
 	return NULL;
 }
 
+#ifdef HAVE_BACKTRACE_SUPPORT
 #include <execinfo.h>
 #include <stdlib.h>
 static inline void print_ip_sym(const char *loglvl, unsigned long ip)
@@ -30,5 +31,8 @@ static inline void print_ip_sym(const char *loglvl, unsigned long ip)
 
 	free(name);
 }
+#else
+static inline void print_ip_sym(const char *loglvl, unsigned long ip) {}
+#endif
 
 #endif
diff --git a/tools/testing/selftests/bpf/test_lru_map.c b/tools/testing/selftests/bpf/test_lru_map.c
index fda7589c5023..0921939532c6 100644
--- a/tools/testing/selftests/bpf/test_lru_map.c
+++ b/tools/testing/selftests/bpf/test_lru_map.c
@@ -138,6 +138,18 @@ static int sched_next_online(int pid, int *next_to_try)
 	return ret;
 }
 
+/* Derive target_free from map_size, same as bpf_common_lru_populate */
+static unsigned int __tgt_size(unsigned int map_size)
+{
+	return (map_size / nr_cpus) / 2;
+}
+
+/* Inverse of how bpf_common_lru_populate derives target_free from map_size. */
+static unsigned int __map_size(unsigned int tgt_free)
+{
+	return tgt_free * nr_cpus * 2;
+}
+
 /* Size of the LRU map is 2
  * Add key=1 (+1 key)
  * Add key=2 (+1 key)
@@ -231,11 +243,11 @@ static void test_lru_sanity0(int map_type, int map_flags)
 	printf("Pass\n");
 }
 
-/* Size of the LRU map is 1.5*tgt_free
- * Insert 1 to tgt_free (+tgt_free keys)
- * Lookup 1 to tgt_free/2
- * Insert 1+tgt_free to 2*tgt_free (+tgt_free keys)
- * => 1+tgt_free/2 to LOCALFREE_TARGET will be removed by LRU
+/* Verify that unreferenced elements are recycled before referenced ones.
+ * Insert elements.
+ * Reference a subset of these.
+ * Insert more, enough to trigger recycling.
+ * Verify that unreferenced are recycled.
  */
 static void test_lru_sanity1(int map_type, int map_flags, unsigned int tgt_free)
 {
@@ -257,7 +269,7 @@ static void test_lru_sanity1(int map_type, int map_flags, unsigned int tgt_free)
 	batch_size = tgt_free / 2;
 	assert(batch_size * 2 == tgt_free);
 
-	map_size = tgt_free + batch_size;
+	map_size = __map_size(tgt_free) + batch_size;
 	lru_map_fd = create_map(map_type, map_flags, map_size);
 	assert(lru_map_fd != -1);
 
@@ -266,13 +278,13 @@ static void test_lru_sanity1(int map_type, int map_flags, unsigned int tgt_free)
 
 	value[0] = 1234;
 
-	/* Insert 1 to tgt_free (+tgt_free keys) */
-	end_key = 1 + tgt_free;
+	/* Insert map_size - batch_size keys */
+	end_key = 1 + __map_size(tgt_free);
 	for (key = 1; key < end_key; key++)
 		assert(!bpf_map_update_elem(lru_map_fd, &key, value,
 					    BPF_NOEXIST));
 
-	/* Lookup 1 to tgt_free/2 */
+	/* Lookup 1 to batch_size */
 	end_key = 1 + batch_size;
 	for (key = 1; key < end_key; key++) {
 		assert(!bpf_map_lookup_elem_with_ref_bit(lru_map_fd, key, value));
@@ -280,12 +292,13 @@ static void test_lru_sanity1(int map_type, int map_flags, unsigned int tgt_free)
 					    BPF_NOEXIST));
 	}
 
-	/* Insert 1+tgt_free to 2*tgt_free
-	 * => 1+tgt_free/2 to LOCALFREE_TARGET will be
+	/* Insert another map_size - batch_size keys
+	 * Map will contain 1 to batch_size plus these latest, i.e.,
+	 * => previous 1+batch_size to map_size - batch_size will have been
 	 * removed by LRU
 	 */
-	key = 1 + tgt_free;
-	end_key = key + tgt_free;
+	key = 1 + __map_size(tgt_free);
+	end_key = key + __map_size(tgt_free);
 	for (; key < end_key; key++) {
 		assert(!bpf_map_update_elem(lru_map_fd, &key, value,
 					    BPF_NOEXIST));
@@ -301,17 +314,8 @@ static void test_lru_sanity1(int map_type, int map_flags, unsigned int tgt_free)
 	printf("Pass\n");
 }
 
-/* Size of the LRU map 1.5 * tgt_free
- * Insert 1 to tgt_free (+tgt_free keys)
- * Update 1 to tgt_free/2
- *   => The original 1 to tgt_free/2 will be removed due to
- *      the LRU shrink process
- * Re-insert 1 to tgt_free/2 again and do a lookup immeidately
- * Insert 1+tgt_free to tgt_free*3/2
- * Insert 1+tgt_free*3/2 to tgt_free*5/2
- *   => Key 1+tgt_free to tgt_free*3/2
- *      will be removed from LRU because it has never
- *      been lookup and ref bit is not set
+/* Verify that insertions exceeding map size will recycle the oldest.
+ * Verify that unreferenced elements are recycled before referenced.
  */
 static void test_lru_sanity2(int map_type, int map_flags, unsigned int tgt_free)
 {
@@ -334,7 +338,7 @@ static void test_lru_sanity2(int map_type, int map_flags, unsigned int tgt_free)
 	batch_size = tgt_free / 2;
 	assert(batch_size * 2 == tgt_free);
 
-	map_size = tgt_free + batch_size;
+	map_size = __map_size(tgt_free) + batch_size;
 	lru_map_fd = create_map(map_type, map_flags, map_size);
 	assert(lru_map_fd != -1);
 
@@ -343,8 +347,8 @@ static void test_lru_sanity2(int map_type, int map_flags, unsigned int tgt_free)
 
 	value[0] = 1234;
 
-	/* Insert 1 to tgt_free (+tgt_free keys) */
-	end_key = 1 + tgt_free;
+	/* Insert map_size - batch_size keys */
+	end_key = 1 + __map_size(tgt_free);
 	for (key = 1; key < end_key; key++)
 		assert(!bpf_map_update_elem(lru_map_fd, &key, value,
 					    BPF_NOEXIST));
@@ -357,8 +361,7 @@ static void test_lru_sanity2(int map_type, int map_flags, unsigned int tgt_free)
 	 * shrink the inactive list to get tgt_free
 	 * number of free nodes.
 	 *
-	 * Hence, the oldest key 1 to tgt_free/2
-	 * are removed from the LRU list.
+	 * Hence, the oldest key is removed from the LRU list.
 	 */
 	key = 1;
 	if (map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
@@ -370,8 +373,7 @@ static void test_lru_sanity2(int map_type, int map_flags, unsigned int tgt_free)
 					   BPF_EXIST));
 	}
 
-	/* Re-insert 1 to tgt_free/2 again and do a lookup
-	 * immeidately.
+	/* Re-insert 1 to batch_size again and do a lookup immediately.
 	 */
 	end_key = 1 + batch_size;
 	value[0] = 4321;
@@ -387,17 +389,18 @@ static void test_lru_sanity2(int map_type, int map_flags, unsigned int tgt_free)
 
 	value[0] = 1234;
 
-	/* Insert 1+tgt_free to tgt_free*3/2 */
-	end_key = 1 + tgt_free + batch_size;
-	for (key = 1 + tgt_free; key < end_key; key++)
+	/* Insert batch_size new elements */
+	key = 1 + __map_size(tgt_free);
+	end_key = key + batch_size;
+	for (; key < end_key; key++)
 		/* These newly added but not referenced keys will be
 		 * gone during the next LRU shrink.
 		 */
 		assert(!bpf_map_update_elem(lru_map_fd, &key, value,
 					    BPF_NOEXIST));
 
-	/* Insert 1+tgt_free*3/2 to  tgt_free*5/2 */
-	end_key = key + tgt_free;
+	/* Insert map_size - batch_size elements */
+	end_key += __map_size(tgt_free);
 	for (; key < end_key; key++) {
 		assert(!bpf_map_update_elem(lru_map_fd, &key, value,
 					    BPF_NOEXIST));
@@ -413,12 +416,12 @@ static void test_lru_sanity2(int map_type, int map_flags, unsigned int tgt_free)
 	printf("Pass\n");
 }
 
-/* Size of the LRU map is 2*tgt_free
- * It is to test the active/inactive list rotation
- * Insert 1 to 2*tgt_free (+2*tgt_free keys)
- * Lookup key 1 to tgt_free*3/2
- * Add 1+2*tgt_free to tgt_free*5/2 (+tgt_free/2 keys)
- *  => key 1+tgt_free*3/2 to 2*tgt_free are removed from LRU
+/* Test the active/inactive list rotation
+ *
+ * Fill the whole map, deplete the free list.
+ * Reference all except the last lru->target_free elements.
+ * Insert lru->target_free new elements. This triggers one shrink.
+ * Verify that the non-referenced elements are replaced.
  */
 static void test_lru_sanity3(int map_type, int map_flags, unsigned int tgt_free)
 {
@@ -437,8 +440,7 @@ static void test_lru_sanity3(int map_type, int map_flags, unsigned int tgt_free)
 
 	assert(sched_next_online(0, &next_cpu) != -1);
 
-	batch_size = tgt_free / 2;
-	assert(batch_size * 2 == tgt_free);
+	batch_size = __tgt_size(tgt_free);
 
 	map_size = tgt_free * 2;
 	lru_map_fd = create_map(map_type, map_flags, map_size);
@@ -449,23 +451,21 @@ static void test_lru_sanity3(int map_type, int map_flags, unsigned int tgt_free)
 
 	value[0] = 1234;
 
-	/* Insert 1 to 2*tgt_free (+2*tgt_free keys) */
-	end_key = 1 + (2 * tgt_free);
+	/* Fill the map */
+	end_key = 1 + map_size;
 	for (key = 1; key < end_key; key++)
 		assert(!bpf_map_update_elem(lru_map_fd, &key, value,
 					    BPF_NOEXIST));
 
-	/* Lookup key 1 to tgt_free*3/2 */
-	end_key = tgt_free + batch_size;
+	/* Reference all but the last batch_size */
+	end_key = 1 + map_size - batch_size;
 	for (key = 1; key < end_key; key++) {
 		assert(!bpf_map_lookup_elem_with_ref_bit(lru_map_fd, key, value));
 		assert(!bpf_map_update_elem(expected_map_fd, &key, value,
 					    BPF_NOEXIST));
 	}
 
-	/* Add 1+2*tgt_free to tgt_free*5/2
-	 * (+tgt_free/2 keys)
-	 */
+	/* Insert new batch_size: replaces the non-referenced elements */
 	key = 2 * tgt_free + 1;
 	end_key = key + batch_size;
 	for (; key < end_key; key++) {
@@ -500,7 +500,8 @@ static void test_lru_sanity4(int map_type, int map_flags, unsigned int tgt_free)
 		lru_map_fd = create_map(map_type, map_flags,
 					3 * tgt_free * nr_cpus);
 	else
-		lru_map_fd = create_map(map_type, map_flags, 3 * tgt_free);
+		lru_map_fd = create_map(map_type, map_flags,
+					3 * __map_size(tgt_free));
 	assert(lru_map_fd != -1);
 
 	expected_map_fd = create_map(BPF_MAP_TYPE_HASH, 0,
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index c992e385159c..195360082d94 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -48,7 +48,6 @@ declare -A NETIFS=(
 : "${WAIT_TIME:=5}"
 
 # Whether to pause on, respectively, after a failure and before cleanup.
-: "${PAUSE_ON_FAIL:=no}"
 : "${PAUSE_ON_CLEANUP:=no}"
 
 # Whether to create virtual interfaces, and what netdevice type they should be.
@@ -446,22 +445,6 @@ done
 ##############################################################################
 # Helpers
 
-# Exit status to return at the end. Set in case one of the tests fails.
-EXIT_STATUS=0
-# Per-test return value. Clear at the beginning of each test.
-RET=0
-
-ret_set_ksft_status()
-{
-	local ksft_status=$1; shift
-	local msg=$1; shift
-
-	RET=$(ksft_status_merge $RET $ksft_status)
-	if (( $? )); then
-		retmsg=$msg
-	fi
-}
-
 # Whether FAILs should be interpreted as XFAILs. Internal.
 FAIL_TO_XFAIL=
 
@@ -535,102 +518,6 @@ xfail_on_veth()
 	fi
 }
 
-log_test_result()
-{
-	local test_name=$1; shift
-	local opt_str=$1; shift
-	local result=$1; shift
-	local retmsg=$1; shift
-
-	printf "TEST: %-60s  [%s]\n" "$test_name $opt_str" "$result"
-	if [[ $retmsg ]]; then
-		printf "\t%s\n" "$retmsg"
-	fi
-}
-
-pause_on_fail()
-{
-	if [[ $PAUSE_ON_FAIL == yes ]]; then
-		echo "Hit enter to continue, 'q' to quit"
-		read a
-		[[ $a == q ]] && exit 1
-	fi
-}
-
-handle_test_result_pass()
-{
-	local test_name=$1; shift
-	local opt_str=$1; shift
-
-	log_test_result "$test_name" "$opt_str" " OK "
-}
-
-handle_test_result_fail()
-{
-	local test_name=$1; shift
-	local opt_str=$1; shift
-
-	log_test_result "$test_name" "$opt_str" FAIL "$retmsg"
-	pause_on_fail
-}
-
-handle_test_result_xfail()
-{
-	local test_name=$1; shift
-	local opt_str=$1; shift
-
-	log_test_result "$test_name" "$opt_str" XFAIL "$retmsg"
-	pause_on_fail
-}
-
-handle_test_result_skip()
-{
-	local test_name=$1; shift
-	local opt_str=$1; shift
-
-	log_test_result "$test_name" "$opt_str" SKIP "$retmsg"
-}
-
-log_test()
-{
-	local test_name=$1
-	local opt_str=$2
-
-	if [[ $# -eq 2 ]]; then
-		opt_str="($opt_str)"
-	fi
-
-	if ((RET == ksft_pass)); then
-		handle_test_result_pass "$test_name" "$opt_str"
-	elif ((RET == ksft_xfail)); then
-		handle_test_result_xfail "$test_name" "$opt_str"
-	elif ((RET == ksft_skip)); then
-		handle_test_result_skip "$test_name" "$opt_str"
-	else
-		handle_test_result_fail "$test_name" "$opt_str"
-	fi
-
-	EXIT_STATUS=$(ksft_exit_status_merge $EXIT_STATUS $RET)
-	return $RET
-}
-
-log_test_skip()
-{
-	RET=$ksft_skip retmsg= log_test "$@"
-}
-
-log_test_xfail()
-{
-	RET=$ksft_xfail retmsg= log_test "$@"
-}
-
-log_info()
-{
-	local msg=$1
-
-	echo "INFO: $msg"
-}
-
 not()
 {
 	"$@"
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index be8707bfb46e..bb4d2f8d50d6 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -6,6 +6,9 @@
 
 : "${WAIT_TIMEOUT:=20}"
 
+# Whether to pause on after a failure.
+: "${PAUSE_ON_FAIL:=no}"
+
 BUSYWAIT_TIMEOUT=$((WAIT_TIMEOUT * 1000)) # ms
 
 # Kselftest framework constants.
@@ -17,6 +20,11 @@ ksft_skip=4
 # namespace list created by setup_ns
 NS_LIST=()
 
+# Exit status to return at the end. Set in case one of the tests fails.
+EXIT_STATUS=0
+# Per-test return value. Clear at the beginning of each test.
+RET=0
+
 ##############################################################################
 # Helpers
 
@@ -233,3 +241,110 @@ tc_rule_handle_stats_get()
 	    | jq ".[] | select(.options.handle == $handle) | \
 		  .options.actions[0].stats$selector"
 }
+
+ret_set_ksft_status()
+{
+	local ksft_status=$1; shift
+	local msg=$1; shift
+
+	RET=$(ksft_status_merge $RET $ksft_status)
+	if (( $? )); then
+		retmsg=$msg
+	fi
+}
+
+log_test_result()
+{
+	local test_name=$1; shift
+	local opt_str=$1; shift
+	local result=$1; shift
+	local retmsg=$1
+
+	printf "TEST: %-60s  [%s]\n" "$test_name $opt_str" "$result"
+	if [[ $retmsg ]]; then
+		printf "\t%s\n" "$retmsg"
+	fi
+}
+
+pause_on_fail()
+{
+	if [[ $PAUSE_ON_FAIL == yes ]]; then
+		echo "Hit enter to continue, 'q' to quit"
+		read a
+		[[ $a == q ]] && exit 1
+	fi
+}
+
+handle_test_result_pass()
+{
+	local test_name=$1; shift
+	local opt_str=$1; shift
+
+	log_test_result "$test_name" "$opt_str" " OK "
+}
+
+handle_test_result_fail()
+{
+	local test_name=$1; shift
+	local opt_str=$1; shift
+
+	log_test_result "$test_name" "$opt_str" FAIL "$retmsg"
+	pause_on_fail
+}
+
+handle_test_result_xfail()
+{
+	local test_name=$1; shift
+	local opt_str=$1; shift
+
+	log_test_result "$test_name" "$opt_str" XFAIL "$retmsg"
+	pause_on_fail
+}
+
+handle_test_result_skip()
+{
+	local test_name=$1; shift
+	local opt_str=$1; shift
+
+	log_test_result "$test_name" "$opt_str" SKIP "$retmsg"
+}
+
+log_test()
+{
+	local test_name=$1
+	local opt_str=$2
+
+	if [[ $# -eq 2 ]]; then
+		opt_str="($opt_str)"
+	fi
+
+	if ((RET == ksft_pass)); then
+		handle_test_result_pass "$test_name" "$opt_str"
+	elif ((RET == ksft_xfail)); then
+		handle_test_result_xfail "$test_name" "$opt_str"
+	elif ((RET == ksft_skip)); then
+		handle_test_result_skip "$test_name" "$opt_str"
+	else
+		handle_test_result_fail "$test_name" "$opt_str"
+	fi
+
+	EXIT_STATUS=$(ksft_exit_status_merge $EXIT_STATUS $RET)
+	return $RET
+}
+
+log_test_skip()
+{
+	RET=$ksft_skip retmsg= log_test "$@"
+}
+
+log_test_xfail()
+{
+	RET=$ksft_xfail retmsg= log_test "$@"
+}
+
+log_info()
+{
+	local msg=$1
+
+	echo "INFO: $msg"
+}
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b99de3b5ffbc..aba4078ae225 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2557,6 +2557,8 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 		r = xa_reserve(&kvm->mem_attr_array, i, GFP_KERNEL_ACCOUNT);
 		if (r)
 			goto out_unlock;
+
+		cond_resched();
 	}
 
 	kvm_handle_gfn_range(kvm, &pre_set_range);
@@ -2565,6 +2567,7 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 		r = xa_err(xa_store(&kvm->mem_attr_array, i, entry,
 				    GFP_KERNEL_ACCOUNT));
 		KVM_BUG_ON(r, kvm);
+		cond_resched();
 	}
 
 	kvm_handle_gfn_range(kvm, &post_set_range);

