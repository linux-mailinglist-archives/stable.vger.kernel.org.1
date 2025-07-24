Return-Path: <stable+bounces-164547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6937EB0FF1E
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 05:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E591C86678
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 03:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC3B1DE2BF;
	Thu, 24 Jul 2025 03:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfcMkPZH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3E618E1F
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 03:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753327232; cv=none; b=Xihp0Fx3W5oCujD3xtkcSs8AXMUk+6D6l0uCEWMhAUzmzYGJRfGnHp4e2ftBLUqVP62o21EJjmBDhz4fHFcMNGpWXT9FkvlnvuY3XtPUSVbu5M1DVNkuj2x64mgN2W3ql3/hvwhiReHQ5M5qIwHnebNT7ddiYK93DpYXk6/ojDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753327232; c=relaxed/simple;
	bh=toSgUy7lGORU+V8glD9elgdwsO3+rh8eCko8WOc6OV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uhAnlGFdAjqcF2ZMuwN6lkiYjn+3nZ3GK9ptu8T8221BN9NEet6HPA/q2T+7ooYHx9nz3qNMaWAoHXTKNN7oLAicj8PgJgKAnm7btTL6d1bLL/o4qKkIrrHzXLY3wApO1mn2ieRLFbqAtfSYdsfGyIdL9+0uflUGli9AV6PFP/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfcMkPZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0344C4CEED;
	Thu, 24 Jul 2025 03:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753327231;
	bh=toSgUy7lGORU+V8glD9elgdwsO3+rh8eCko8WOc6OV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sfcMkPZHGKRwFd111aokSK0ohj7k50DmzINSja1kQMvTfF6gz3+ObNLcN7ypEYPGo
	 TytUi5Uc06TkdiU39dMizZToK1QnrTtsLEpwzzjoj2QtGnzt2kwAWeuuwZLj1kLafq
	 JF9YzJLq6v4+Da2emX/PFU7+u7D8XTZjtP3N5jp+RIjRDCokW8k4IFgy/knsHy6yqb
	 FIq3tw50RlJ7ya2WWqGBoPXZHnHGgwVLQqfmPAQv0wa+ln9b6g1+3Y7esyrT+gXRYY
	 2ZdA5apc1hQY8pkJhOxe/B3kNBsdpKT5B6+nmqur8XnrchifwoarSFQTgSBoQI44Kq
	 062AlODIXnbZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Roman Kisel <romank@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] x86/hyperv: Fix APIC ID and VP index confusion in hv_snp_boot_ap()
Date: Wed, 23 Jul 2025 23:20:27 -0400
Message-Id: <20250724032027.1283644-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025061756-shale-squiggly-9c9a@gregkh>
References: <2025061756-shale-squiggly-9c9a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Roman Kisel <romank@linux.microsoft.com>

[ Upstream commit 86c48271e0d60c82665e9fd61277002391efcef7 ]

To start an application processor in SNP-isolated guest, a hypercall
is used that takes a virtual processor index. The hv_snp_boot_ap()
function uses that START_VP hypercall but passes as VP index to it
what it receives as a wakeup_secondary_cpu_64 callback: the APIC ID.

As those two aren't generally interchangeable, that may lead to hung
APs if the VP index and the APIC ID don't match up.

Update the parameter names to avoid confusion as to what the parameter
is. Use the APIC ID to the VP index conversion to provide the correct
input to the hypercall.

Cc: stable@vger.kernel.org
Fixes: 44676bb9d566 ("x86/hyperv: Add smp support for SEV-SNP guest")
Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Link: https://lore.kernel.org/r/20250507182227.7421-2-romank@linux.microsoft.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <20250507182227.7421-2-romank@linux.microsoft.com>
[ changed HVCALL_GET_VP_INDEX_FROM_APIC_ID to HVCALL_GET_VP_ID_FROM_APIC_ID ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/hyperv/hv_init.c       | 33 +++++++++++++++++++++++++
 arch/x86/hyperv/hv_vtl.c        | 44 +++++----------------------------
 arch/x86/hyperv/ivm.c           | 22 +++++++++++++++--
 arch/x86/include/asm/mshyperv.h |  6 +++--
 4 files changed, 63 insertions(+), 42 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 95eada2994e15..239f612816e6d 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -730,3 +730,36 @@ bool hv_is_hyperv_initialized(void)
 	return hypercall_msr.enable;
 }
 EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
+
+int hv_apicid_to_vp_index(u32 apic_id)
+{
+	u64 control;
+	u64 status;
+	unsigned long irq_flags;
+	struct hv_get_vp_from_apic_id_in *input;
+	u32 *output, ret;
+
+	local_irq_save(irq_flags);
+
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+	input->partition_id = HV_PARTITION_ID_SELF;
+	input->apic_ids[0] = apic_id;
+
+	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+
+	control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_ID_FROM_APIC_ID;
+	status = hv_do_hypercall(control, input, output);
+	ret = output[0];
+
+	local_irq_restore(irq_flags);
+
+	if (!hv_result_success(status)) {
+		pr_err("failed to get vp index from apic id %d, status %#llx\n",
+		       apic_id, status);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hv_apicid_to_vp_index);
diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index d04ccd4b3b4af..2510e91b29b08 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -175,41 +175,9 @@ static int hv_vtl_bringup_vcpu(u32 target_vp_index, int cpu, u64 eip_ignored)
 	return ret;
 }
 
-static int hv_vtl_apicid_to_vp_id(u32 apic_id)
-{
-	u64 control;
-	u64 status;
-	unsigned long irq_flags;
-	struct hv_get_vp_from_apic_id_in *input;
-	u32 *output, ret;
-
-	local_irq_save(irq_flags);
-
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	memset(input, 0, sizeof(*input));
-	input->partition_id = HV_PARTITION_ID_SELF;
-	input->apic_ids[0] = apic_id;
-
-	output = (u32 *)input;
-
-	control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_ID_FROM_APIC_ID;
-	status = hv_do_hypercall(control, input, output);
-	ret = output[0];
-
-	local_irq_restore(irq_flags);
-
-	if (!hv_result_success(status)) {
-		pr_err("failed to get vp id from apic id %d, status %#llx\n",
-		       apic_id, status);
-		return -EINVAL;
-	}
-
-	return ret;
-}
-
 static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
 {
-	int vp_id, cpu;
+	int vp_index, cpu;
 
 	/* Find the logical CPU for the APIC ID */
 	for_each_present_cpu(cpu) {
@@ -220,18 +188,18 @@ static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
 		return -EINVAL;
 
 	pr_debug("Bringing up CPU with APIC ID %d in VTL2...\n", apicid);
-	vp_id = hv_vtl_apicid_to_vp_id(apicid);
+	vp_index = hv_apicid_to_vp_index(apicid);
 
-	if (vp_id < 0) {
+	if (vp_index < 0) {
 		pr_err("Couldn't find CPU with APIC ID %d\n", apicid);
 		return -EINVAL;
 	}
-	if (vp_id > ms_hyperv.max_vp_index) {
-		pr_err("Invalid CPU id %d for APIC ID %d\n", vp_id, apicid);
+	if (vp_index > ms_hyperv.max_vp_index) {
+		pr_err("Invalid CPU id %d for APIC ID %d\n", vp_index, apicid);
 		return -EINVAL;
 	}
 
-	return hv_vtl_bringup_vcpu(vp_id, cpu, start_eip);
+	return hv_vtl_bringup_vcpu(vp_index, cpu, start_eip);
 }
 
 int __init hv_vtl_early_init(void)
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 4065f5ef3ae08..af87f440bc2ac 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -10,6 +10,7 @@
 #include <linux/hyperv.h>
 #include <linux/types.h>
 #include <linux/slab.h>
+#include <linux/cpu.h>
 #include <asm/svm.h>
 #include <asm/sev.h>
 #include <asm/io.h>
@@ -289,7 +290,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa)
 		free_page((unsigned long)vmsa);
 }
 
-int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
+int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip)
 {
 	struct sev_es_save_area *vmsa = (struct sev_es_save_area *)
 		__get_free_page(GFP_KERNEL | __GFP_ZERO);
@@ -298,10 +299,27 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
 	u64 ret, retry = 5;
 	struct hv_enable_vp_vtl *start_vp_input;
 	unsigned long flags;
+	int cpu, vp_index;
 
 	if (!vmsa)
 		return -ENOMEM;
 
+	/* Find the Hyper-V VP index which might be not the same as APIC ID */
+	vp_index = hv_apicid_to_vp_index(apic_id);
+	if (vp_index < 0 || vp_index > ms_hyperv.max_vp_index)
+		return -EINVAL;
+
+	/*
+	 * Find the Linux CPU number for addressing the per-CPU data, and it
+	 * might not be the same as APIC ID.
+	 */
+	for_each_present_cpu(cpu) {
+		if (arch_match_cpu_phys_id(cpu, apic_id))
+			break;
+	}
+	if (cpu >= nr_cpu_ids)
+		return -EINVAL;
+
 	native_store_gdt(&gdtr);
 
 	vmsa->gdtr.base = gdtr.address;
@@ -349,7 +367,7 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
 	start_vp_input = (struct hv_enable_vp_vtl *)ap_start_input_arg;
 	memset(start_vp_input, 0, sizeof(*start_vp_input));
 	start_vp_input->partition_id = -1;
-	start_vp_input->vp_index = cpu;
+	start_vp_input->vp_index = vp_index;
 	start_vp_input->target_vtl.target_vtl = ms_hyperv.vtl;
 	*(u64 *)&start_vp_input->vp_context = __pa(vmsa) | 1;
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 5f0bc6a6d0255..a42439c2ed248 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -275,11 +275,11 @@ int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 bool hv_ghcb_negotiate_protocol(void);
 void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason);
-int hv_snp_boot_ap(u32 cpu, unsigned long start_ip);
+int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip);
 #else
 static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
 static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
-static inline int hv_snp_boot_ap(u32 cpu, unsigned long start_ip) { return 0; }
+static inline int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip) { return 0; }
 #endif
 
 #if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
@@ -313,6 +313,7 @@ static __always_inline u64 hv_raw_get_msr(unsigned int reg)
 {
 	return __rdmsr(reg);
 }
+int hv_apicid_to_vp_index(u32 apic_id);
 
 #else /* CONFIG_HYPERV */
 static inline void hyperv_init(void) {}
@@ -334,6 +335,7 @@ static inline void hv_set_msr(unsigned int reg, u64 value) { }
 static inline u64 hv_get_msr(unsigned int reg) { return 0; }
 static inline void hv_set_non_nested_msr(unsigned int reg, u64 value) { }
 static inline u64 hv_get_non_nested_msr(unsigned int reg) { return 0; }
+static inline int hv_apicid_to_vp_index(u32 apic_id) { return -EINVAL; }
 #endif /* CONFIG_HYPERV */
 
 
-- 
2.39.5


