Return-Path: <stable+bounces-236100-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IA6kHn/73GnXYgkAu9opvQ
	(envelope-from <stable+bounces-236100-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:19:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C373ED3BC
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AE8530E4BE7
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1453D8111;
	Mon, 13 Apr 2026 14:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EX1u4WB7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780703D7D9E
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089269; cv=none; b=acapZwr3dMteujrv8HNRued0cGyEJ27iiGOBTlJv/tM1OXNzxL2/M9Z4oFMYSY6MxRM3gyqyNfXZ8vAi/oUdH8YSx1JoIZWKvlMZeLD4zd6Dsb1uz1lA3EJdJujYzoFcjNCZMobdJc1BqRrBKoATqEaH0co2r4YPmUjyOKYEDJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089269; c=relaxed/simple;
	bh=KCegwX1s5/gviyOP5X7+AaW8J2oV3a2VcKFVoXeCL48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUNF3b0kILBgF5w+Eq88Wma/FpEFbA1No+pHSDaBtJAtfJmzaadtK3Ah02Ds+undeBr5daF5evFHy3opQh3jQ58e1pfLETqFLCIetzTqo93OEMuY/vFeF1r6eBX4n0k+x3IXBrcuTvaFHaNfgXEnTE0cTHcI5Lpfc/vtgnIwubM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EX1u4WB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03188C2BCAF;
	Mon, 13 Apr 2026 14:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776089268;
	bh=KCegwX1s5/gviyOP5X7+AaW8J2oV3a2VcKFVoXeCL48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EX1u4WB7F8nTgbSkE/FjNCeDxBvVzbu8q3QL4viFyGcOoxQSwL940gHXethZIJL9N
	 Az7II03V62+rf53/tq0pcxAh5+AHKGHCyfSkCLpzqg2Q4DSTEQV6BL+ZTROQ4+2nnO
	 tVVwsJakhzCu5dHcaabPE9b+dVkvQ5SCoIHG9ixc43+AGWxn8WLFVEhkh+KImyLaou
	 7JSnOghWhnCeonORF0rx4m6UR+3opP8lt7q+ZtCHluqYF7baYq074wXsAiOw34tMvP
	 Q4ax00c4KhAKb7uFiTAmh04YcNVFU4awhZCjBm31tV6b42kkhOnrLHTwZBmg8BglJd
	 SEw/o0LNxO8hw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Anup Patel <anup@brainfault.org>,
	Bibo Mao <maobibo@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] KVM: Remove subtle "struct kvm_stats_desc" pseudo-overlay
Date: Mon, 13 Apr 2026 10:07:45 -0400
Message-ID: <20260413140746.2904035-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026041318-chowder-paper-ef87@gregkh>
References: <2026041318-chowder-paper-ef87@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236100-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: B4C373ED3BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit da142f3d373a6ddaca0119615a8db2175ddc4121 ]

Remove KVM's internal pseudo-overlay of kvm_stats_desc, which subtly
aliases the flexible name[] in the uAPI definition with a fixed-size array
of the same name.  The unusual embedded structure results in compiler
warnings due to -Wflex-array-member-not-at-end, and also necessitates an
extra level of dereferencing in KVM.  To avoid the "overlay", define the
uAPI structure to have a fixed-size name when building for the kernel.

Opportunistically clean up the indentation for the stats macros, and
replace spaces with tabs.

No functional change intended.

Reported-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Closes: https://lore.kernel.org/all/aPfNKRpLfhmhYqfP@kspp
Acked-by: Marc Zyngier <maz@kernel.org>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
[..]
Acked-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Link: https://patch.msgid.link/20251205232655.445294-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: 2619da73bb2f ("KVM: x86: Use __DECLARE_FLEX_ARRAY() for UAPI structures with VLAs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/guest.c    |  4 +-
 arch/loongarch/kvm/vcpu.c |  2 +-
 arch/loongarch/kvm/vm.c   |  2 +-
 arch/mips/kvm/mips.c      |  4 +-
 arch/powerpc/kvm/book3s.c |  4 +-
 arch/powerpc/kvm/booke.c  |  4 +-
 arch/riscv/kvm/vcpu.c     |  2 +-
 arch/riscv/kvm/vm.c       |  2 +-
 arch/s390/kvm/kvm-s390.c  |  4 +-
 arch/x86/kvm/x86.c        |  4 +-
 include/linux/kvm_host.h  | 83 +++++++++++++++++----------------------
 include/uapi/linux/kvm.h  |  8 ++++
 virt/kvm/binary_stats.c   |  2 +-
 virt/kvm/kvm_main.c       | 20 +++++-----
 14 files changed, 70 insertions(+), 75 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 962f985977c2d..e67109b54ae90 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -29,7 +29,7 @@
 
 #include "trace.h"
 
-const struct _kvm_stats_desc kvm_vm_stats_desc[] = {
+const struct kvm_stats_desc kvm_vm_stats_desc[] = {
 	KVM_GENERIC_VM_STATS()
 };
 
@@ -42,7 +42,7 @@ const struct kvm_stats_header kvm_vm_stats_header = {
 		       sizeof(kvm_vm_stats_desc),
 };
 
-const struct _kvm_stats_desc kvm_vcpu_stats_desc[] = {
+const struct kvm_stats_desc kvm_vcpu_stats_desc[] = {
 	KVM_GENERIC_VCPU_STATS(),
 	STATS_DESC_COUNTER(VCPU, hvc_exit_stat),
 	STATS_DESC_COUNTER(VCPU, wfe_exit_stat),
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 8579bddb544a7..38d3435d4fe0e 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -14,7 +14,7 @@
 #define CREATE_TRACE_POINTS
 #include "trace.h"
 
-const struct _kvm_stats_desc kvm_vcpu_stats_desc[] = {
+const struct kvm_stats_desc kvm_vcpu_stats_desc[] = {
 	KVM_GENERIC_VCPU_STATS(),
 	STATS_DESC_COUNTER(VCPU, int_exits),
 	STATS_DESC_COUNTER(VCPU, idle_exits),
diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
index fe9e973912d44..06c3fbab8c6fb 100644
--- a/arch/loongarch/kvm/vm.c
+++ b/arch/loongarch/kvm/vm.c
@@ -7,7 +7,7 @@
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_vcpu.h>
 
-const struct _kvm_stats_desc kvm_vm_stats_desc[] = {
+const struct kvm_stats_desc kvm_vm_stats_desc[] = {
 	KVM_GENERIC_VM_STATS(),
 	STATS_DESC_ICOUNTER(VM, pages),
 	STATS_DESC_ICOUNTER(VM, hugepages),
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 60b43ea85c125..3f8d5310bbd27 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -38,7 +38,7 @@
 #define VECTORSPACING 0x100	/* for EI/VI mode */
 #endif
 
-const struct _kvm_stats_desc kvm_vm_stats_desc[] = {
+const struct kvm_stats_desc kvm_vm_stats_desc[] = {
 	KVM_GENERIC_VM_STATS()
 };
 
@@ -51,7 +51,7 @@ const struct kvm_stats_header kvm_vm_stats_header = {
 		       sizeof(kvm_vm_stats_desc),
 };
 
-const struct _kvm_stats_desc kvm_vcpu_stats_desc[] = {
+const struct kvm_stats_desc kvm_vcpu_stats_desc[] = {
 	KVM_GENERIC_VCPU_STATS(),
 	STATS_DESC_COUNTER(VCPU, wait_exits),
 	STATS_DESC_COUNTER(VCPU, cache_exits),
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index ff6c383739575..b6c4c1490a9f8 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -38,7 +38,7 @@
 
 /* #define EXIT_DEBUG */
 
-const struct _kvm_stats_desc kvm_vm_stats_desc[] = {
+const struct kvm_stats_desc kvm_vm_stats_desc[] = {
 	KVM_GENERIC_VM_STATS(),
 	STATS_DESC_ICOUNTER(VM, num_2M_pages),
 	STATS_DESC_ICOUNTER(VM, num_1G_pages)
@@ -53,7 +53,7 @@ const struct kvm_stats_header kvm_vm_stats_header = {
 		       sizeof(kvm_vm_stats_desc),
 };
 
-const struct _kvm_stats_desc kvm_vcpu_stats_desc[] = {
+const struct kvm_stats_desc kvm_vcpu_stats_desc[] = {
 	KVM_GENERIC_VCPU_STATS(),
 	STATS_DESC_COUNTER(VCPU, sum_exits),
 	STATS_DESC_COUNTER(VCPU, mmio_exits),
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 6a5be025a8afb..368b4381fe6b0 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -36,7 +36,7 @@
 
 unsigned long kvmppc_booke_handlers;
 
-const struct _kvm_stats_desc kvm_vm_stats_desc[] = {
+const struct kvm_stats_desc kvm_vm_stats_desc[] = {
 	KVM_GENERIC_VM_STATS(),
 	STATS_DESC_ICOUNTER(VM, num_2M_pages),
 	STATS_DESC_ICOUNTER(VM, num_1G_pages)
@@ -51,7 +51,7 @@ const struct kvm_stats_header kvm_vm_stats_header = {
 		       sizeof(kvm_vm_stats_desc),
 };
 
-const struct _kvm_stats_desc kvm_vcpu_stats_desc[] = {
+const struct kvm_stats_desc kvm_vcpu_stats_desc[] = {
 	KVM_GENERIC_VCPU_STATS(),
 	STATS_DESC_COUNTER(VCPU, sum_exits),
 	STATS_DESC_COUNTER(VCPU, mmio_exits),
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 8d7d381737ee5..da01c81bf4167 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -24,7 +24,7 @@
 #define CREATE_TRACE_POINTS
 #include "trace.h"
 
-const struct _kvm_stats_desc kvm_vcpu_stats_desc[] = {
+const struct kvm_stats_desc kvm_vcpu_stats_desc[] = {
 	KVM_GENERIC_VCPU_STATS(),
 	STATS_DESC_COUNTER(VCPU, ecall_exit_stat),
 	STATS_DESC_COUNTER(VCPU, wfi_exit_stat),
diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
index 7396b8654f454..b7713ffe4c548 100644
--- a/arch/riscv/kvm/vm.c
+++ b/arch/riscv/kvm/vm.c
@@ -12,7 +12,7 @@
 #include <linux/uaccess.h>
 #include <linux/kvm_host.h>
 
-const struct _kvm_stats_desc kvm_vm_stats_desc[] = {
+const struct kvm_stats_desc kvm_vm_stats_desc[] = {
 	KVM_GENERIC_VM_STATS()
 };
 static_assert(ARRAY_SIZE(kvm_vm_stats_desc) ==
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 286a224c81ee4..70d7bbd62120d 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -59,7 +59,7 @@
 #define VCPU_IRQS_MAX_BUF (sizeof(struct kvm_s390_irq) * \
 			   (KVM_MAX_VCPUS + LOCAL_IRQS))
 
-const struct _kvm_stats_desc kvm_vm_stats_desc[] = {
+const struct kvm_stats_desc kvm_vm_stats_desc[] = {
 	KVM_GENERIC_VM_STATS(),
 	STATS_DESC_COUNTER(VM, inject_io),
 	STATS_DESC_COUNTER(VM, inject_float_mchk),
@@ -85,7 +85,7 @@ const struct kvm_stats_header kvm_vm_stats_header = {
 		       sizeof(kvm_vm_stats_desc),
 };
 
-const struct _kvm_stats_desc kvm_vcpu_stats_desc[] = {
+const struct kvm_stats_desc kvm_vcpu_stats_desc[] = {
 	KVM_GENERIC_VCPU_STATS(),
 	STATS_DESC_COUNTER(VCPU, exit_userspace),
 	STATS_DESC_COUNTER(VCPU, exit_null),
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8a52b7bb821a7..693a9961fbec1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -229,7 +229,7 @@ EXPORT_SYMBOL_GPL(allow_smaller_maxphyaddr);
 bool __read_mostly enable_apicv = true;
 EXPORT_SYMBOL_GPL(enable_apicv);
 
-const struct _kvm_stats_desc kvm_vm_stats_desc[] = {
+const struct kvm_stats_desc kvm_vm_stats_desc[] = {
 	KVM_GENERIC_VM_STATS(),
 	STATS_DESC_COUNTER(VM, mmu_shadow_zapped),
 	STATS_DESC_COUNTER(VM, mmu_pte_write),
@@ -255,7 +255,7 @@ const struct kvm_stats_header kvm_vm_stats_header = {
 		       sizeof(kvm_vm_stats_desc),
 };
 
-const struct _kvm_stats_desc kvm_vcpu_stats_desc[] = {
+const struct kvm_stats_desc kvm_vcpu_stats_desc[] = {
 	KVM_GENERIC_VCPU_STATS(),
 	STATS_DESC_COUNTER(VCPU, pf_taken),
 	STATS_DESC_COUNTER(VCPU, pf_fixed),
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index a2ebc37a29ff4..966511b1e70fa 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1877,56 +1877,43 @@ enum kvm_stat_kind {
 
 struct kvm_stat_data {
 	struct kvm *kvm;
-	const struct _kvm_stats_desc *desc;
+	const struct kvm_stats_desc *desc;
 	enum kvm_stat_kind kind;
 };
 
-struct _kvm_stats_desc {
-	struct kvm_stats_desc desc;
-	char name[KVM_STATS_NAME_SIZE];
-};
-
-#define STATS_DESC_COMMON(type, unit, base, exp, sz, bsz)		       \
-	.flags = type | unit | base |					       \
-		 BUILD_BUG_ON_ZERO(type & ~KVM_STATS_TYPE_MASK) |	       \
-		 BUILD_BUG_ON_ZERO(unit & ~KVM_STATS_UNIT_MASK) |	       \
-		 BUILD_BUG_ON_ZERO(base & ~KVM_STATS_BASE_MASK),	       \
-	.exponent = exp,						       \
-	.size = sz,							       \
+#define STATS_DESC_COMMON(type, unit, base, exp, sz, bsz)		\
+	.flags = type | unit | base |					\
+		 BUILD_BUG_ON_ZERO(type & ~KVM_STATS_TYPE_MASK) |       \
+		 BUILD_BUG_ON_ZERO(unit & ~KVM_STATS_UNIT_MASK) |	\
+		 BUILD_BUG_ON_ZERO(base & ~KVM_STATS_BASE_MASK),	\
+	.exponent = exp,						\
+	.size = sz,							\
 	.bucket_size = bsz
 
-#define VM_GENERIC_STATS_DESC(stat, type, unit, base, exp, sz, bsz)	       \
-	{								       \
-		{							       \
-			STATS_DESC_COMMON(type, unit, base, exp, sz, bsz),     \
-			.offset = offsetof(struct kvm_vm_stat, generic.stat)   \
-		},							       \
-		.name = #stat,						       \
-	}
-#define VCPU_GENERIC_STATS_DESC(stat, type, unit, base, exp, sz, bsz)	       \
-	{								       \
-		{							       \
-			STATS_DESC_COMMON(type, unit, base, exp, sz, bsz),     \
-			.offset = offsetof(struct kvm_vcpu_stat, generic.stat) \
-		},							       \
-		.name = #stat,						       \
-	}
-#define VM_STATS_DESC(stat, type, unit, base, exp, sz, bsz)		       \
-	{								       \
-		{							       \
-			STATS_DESC_COMMON(type, unit, base, exp, sz, bsz),     \
-			.offset = offsetof(struct kvm_vm_stat, stat)	       \
-		},							       \
-		.name = #stat,						       \
-	}
-#define VCPU_STATS_DESC(stat, type, unit, base, exp, sz, bsz)		       \
-	{								       \
-		{							       \
-			STATS_DESC_COMMON(type, unit, base, exp, sz, bsz),     \
-			.offset = offsetof(struct kvm_vcpu_stat, stat)	       \
-		},							       \
-		.name = #stat,						       \
-	}
+#define VM_GENERIC_STATS_DESC(stat, type, unit, base, exp, sz, bsz)	\
+{									\
+	STATS_DESC_COMMON(type, unit, base, exp, sz, bsz),		\
+	.offset = offsetof(struct kvm_vm_stat, generic.stat),		\
+	.name = #stat,							\
+}
+#define VCPU_GENERIC_STATS_DESC(stat, type, unit, base, exp, sz, bsz)	\
+{									\
+	STATS_DESC_COMMON(type, unit, base, exp, sz, bsz),		\
+	.offset = offsetof(struct kvm_vcpu_stat, generic.stat),		\
+	.name = #stat,							\
+}
+#define VM_STATS_DESC(stat, type, unit, base, exp, sz, bsz)		\
+{									\
+	STATS_DESC_COMMON(type, unit, base, exp, sz, bsz),		\
+	.offset = offsetof(struct kvm_vm_stat, stat),			\
+	.name = #stat,							\
+}
+#define VCPU_STATS_DESC(stat, type, unit, base, exp, sz, bsz)		\
+{									\
+	STATS_DESC_COMMON(type, unit, base, exp, sz, bsz),		\
+	.offset = offsetof(struct kvm_vcpu_stat, stat),			\
+	.name = #stat,							\
+}
 /* SCOPE: VM, VM_GENERIC, VCPU, VCPU_GENERIC */
 #define STATS_DESC(SCOPE, stat, type, unit, base, exp, sz, bsz)		       \
 	SCOPE##_STATS_DESC(stat, type, unit, base, exp, sz, bsz)
@@ -2003,7 +1990,7 @@ struct _kvm_stats_desc {
 	STATS_DESC_IBOOLEAN(VCPU_GENERIC, blocking)
 
 ssize_t kvm_stats_read(char *id, const struct kvm_stats_header *header,
-		       const struct _kvm_stats_desc *desc,
+		       const struct kvm_stats_desc *desc,
 		       void *stats, size_t size_stats,
 		       char __user *user_buffer, size_t size, loff_t *offset);
 
@@ -2048,9 +2035,9 @@ static inline void kvm_stats_log_hist_update(u64 *data, size_t size, u64 value)
 
 
 extern const struct kvm_stats_header kvm_vm_stats_header;
-extern const struct _kvm_stats_desc kvm_vm_stats_desc[];
+extern const struct kvm_stats_desc kvm_vm_stats_desc[];
 extern const struct kvm_stats_header kvm_vcpu_stats_header;
-extern const struct _kvm_stats_desc kvm_vcpu_stats_desc[];
+extern const struct kvm_stats_desc kvm_vcpu_stats_desc[];
 
 #ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
 static inline int mmu_invalidate_retry(struct kvm *kvm, unsigned long mmu_seq)
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 637efc0551453..03bbe12620e98 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -14,6 +14,10 @@
 #include <linux/ioctl.h>
 #include <asm/kvm.h>
 
+#ifdef __KERNEL__
+#include <linux/kvm_types.h>
+#endif
+
 #define KVM_API_VERSION 12
 
 /*
@@ -1526,7 +1530,11 @@ struct kvm_stats_desc {
 	__u16 size;
 	__u32 offset;
 	__u32 bucket_size;
+#ifdef __KERNEL__
+	char name[KVM_STATS_NAME_SIZE];
+#else
 	char name[];
+#endif
 };
 
 #define KVM_GET_STATS_FD  _IO(KVMIO,  0xce)
diff --git a/virt/kvm/binary_stats.c b/virt/kvm/binary_stats.c
index eefca6c69f519..76ce697c773bf 100644
--- a/virt/kvm/binary_stats.c
+++ b/virt/kvm/binary_stats.c
@@ -50,7 +50,7 @@
  * Return: the number of bytes that has been successfully read
  */
 ssize_t kvm_stats_read(char *id, const struct kvm_stats_header *header,
-		       const struct _kvm_stats_desc *desc,
+		       const struct kvm_stats_desc *desc,
 		       void *stats, size_t size_stats,
 		       char __user *user_buffer, size_t size, loff_t *offset)
 {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 16cb973741f42..833553e0f2cc5 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1013,9 +1013,9 @@ static void kvm_free_memslots(struct kvm *kvm, struct kvm_memslots *slots)
 		kvm_free_memslot(kvm, memslot);
 }
 
-static umode_t kvm_stats_debugfs_mode(const struct _kvm_stats_desc *pdesc)
+static umode_t kvm_stats_debugfs_mode(const struct kvm_stats_desc *desc)
 {
-	switch (pdesc->desc.flags & KVM_STATS_TYPE_MASK) {
+	switch (desc->flags & KVM_STATS_TYPE_MASK) {
 	case KVM_STATS_TYPE_INSTANT:
 		return 0444;
 	case KVM_STATS_TYPE_CUMULATIVE:
@@ -1050,7 +1050,7 @@ static int kvm_create_vm_debugfs(struct kvm *kvm, const char *fdname)
 	struct dentry *dent;
 	char dir_name[ITOA_MAX_LEN * 2];
 	struct kvm_stat_data *stat_data;
-	const struct _kvm_stats_desc *pdesc;
+	const struct kvm_stats_desc *pdesc;
 	int i, ret = -ENOMEM;
 	int kvm_debugfs_num_entries = kvm_vm_stats_header.num_desc +
 				      kvm_vcpu_stats_header.num_desc;
@@ -6164,11 +6164,11 @@ static int kvm_stat_data_get(void *data, u64 *val)
 	switch (stat_data->kind) {
 	case KVM_STAT_VM:
 		r = kvm_get_stat_per_vm(stat_data->kvm,
-					stat_data->desc->desc.offset, val);
+					stat_data->desc->offset, val);
 		break;
 	case KVM_STAT_VCPU:
 		r = kvm_get_stat_per_vcpu(stat_data->kvm,
-					  stat_data->desc->desc.offset, val);
+					  stat_data->desc->offset, val);
 		break;
 	}
 
@@ -6186,11 +6186,11 @@ static int kvm_stat_data_clear(void *data, u64 val)
 	switch (stat_data->kind) {
 	case KVM_STAT_VM:
 		r = kvm_clear_stat_per_vm(stat_data->kvm,
-					  stat_data->desc->desc.offset);
+					  stat_data->desc->offset);
 		break;
 	case KVM_STAT_VCPU:
 		r = kvm_clear_stat_per_vcpu(stat_data->kvm,
-					    stat_data->desc->desc.offset);
+					    stat_data->desc->offset);
 		break;
 	}
 
@@ -6338,7 +6338,7 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
 static void kvm_init_debug(void)
 {
 	const struct file_operations *fops;
-	const struct _kvm_stats_desc *pdesc;
+	const struct kvm_stats_desc *pdesc;
 	int i;
 
 	kvm_debugfs_dir = debugfs_create_dir("kvm", NULL);
@@ -6351,7 +6351,7 @@ static void kvm_init_debug(void)
 			fops = &vm_stat_readonly_fops;
 		debugfs_create_file(pdesc->name, kvm_stats_debugfs_mode(pdesc),
 				kvm_debugfs_dir,
-				(void *)(long)pdesc->desc.offset, fops);
+				(void *)(long)pdesc->offset, fops);
 	}
 
 	for (i = 0; i < kvm_vcpu_stats_header.num_desc; ++i) {
@@ -6362,7 +6362,7 @@ static void kvm_init_debug(void)
 			fops = &vcpu_stat_readonly_fops;
 		debugfs_create_file(pdesc->name, kvm_stats_debugfs_mode(pdesc),
 				kvm_debugfs_dir,
-				(void *)(long)pdesc->desc.offset, fops);
+				(void *)(long)pdesc->offset, fops);
 	}
 }
 
-- 
2.53.0


