Return-Path: <stable+bounces-152880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDCFADD009
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218783A4B3F
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 14:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD1A2E3B06;
	Tue, 17 Jun 2025 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iN1oUpOs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6002E3AFB
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750170608; cv=none; b=JWGTSO8lsQJL+Tr1Q6oDPr+4OGKmsIfTmNh7Fbbr7sCqEf7PRLvV5DrRrotLEI5CYpU2JpQB5/XtHluFnX9TjSjCONT4TNv1/lsK3dauNRmkTjO+5eUWV1TF8bAsD3rVCMyAsuJ/URSefWNLSANAAf2J1cLvPQx8ozyR6/QWOb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750170608; c=relaxed/simple;
	bh=B9WS4O+bNtYBQmB33VqJCUf5h8VgOS2mhyNgeL+udMY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cNnLE+/Rlfwoxet/pxzM/bhzi3rBSq/HpHE00+z2yN6HnuEECwCQcjWFBpSO6GWkDMNl2ZnOXGIeBQztXUlHwzkqywH7V3gpF/Ux0rcsHX5NZ8eHU+4WoEMnIHkTwlefDTmaycWpd8hq3rVBNZ0lCzUXh7G+rIkmik+akSXdM90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iN1oUpOs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C9EC4CEE7;
	Tue, 17 Jun 2025 14:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750170608;
	bh=B9WS4O+bNtYBQmB33VqJCUf5h8VgOS2mhyNgeL+udMY=;
	h=Subject:To:Cc:From:Date:From;
	b=iN1oUpOsqeK2e0roY7aRWkjQLeCU0ghgA4nhlUvSMZkaddeWRxsSTh1rLfoE7tDqj
	 7BV7r+MP0/2zZQfTwZlD4fo5FGQhTlVDnrj5tymRUZRXPTamCyzwrxbCYlDQdrto49
	 cMYimFiiulcu36gVtnCMNz5WOmgw2dAaJzlNDNaY=
Subject: FAILED: patch "[PATCH] x86/hyperv: Fix APIC ID and VP index confusion in" failed to apply to 6.6-stable tree
To: romank@linux.microsoft.com,mhklinux@outlook.com,wei.liu@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Jun 2025 16:29:57 +0200
Message-ID: <2025061757-refusing-outmatch-70b7@gregkh>
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
git cherry-pick -x 86c48271e0d60c82665e9fd61277002391efcef7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025061757-refusing-outmatch-70b7@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 86c48271e0d60c82665e9fd61277002391efcef7 Mon Sep 17 00:00:00 2001
From: Roman Kisel <romank@linux.microsoft.com>
Date: Wed, 7 May 2025 11:22:25 -0700
Subject: [PATCH] x86/hyperv: Fix APIC ID and VP index confusion in
 hv_snp_boot_ap()

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

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 3b569291dfed..9a8fc144e195 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -672,3 +672,36 @@ bool hv_is_hyperv_initialized(void)
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
+	control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_INDEX_FROM_APIC_ID;
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
index ac3d27a766d5..2f32ac1ae40e 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -211,41 +211,9 @@ static int hv_vtl_bringup_vcpu(u32 target_vp_index, int cpu, u64 eip_ignored)
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
-	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
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
@@ -256,18 +224,18 @@ static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
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
index 77bf05f06b9e..0cc239cdb4da 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -9,6 +9,7 @@
 #include <linux/bitfield.h>
 #include <linux/types.h>
 #include <linux/slab.h>
+#include <linux/cpu.h>
 #include <asm/svm.h>
 #include <asm/sev.h>
 #include <asm/io.h>
@@ -288,7 +289,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa)
 		free_page((unsigned long)vmsa);
 }
 
-int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
+int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip)
 {
 	struct sev_es_save_area *vmsa = (struct sev_es_save_area *)
 		__get_free_page(GFP_KERNEL | __GFP_ZERO);
@@ -297,10 +298,27 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
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
@@ -348,7 +366,7 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
 	start_vp_input = (struct hv_enable_vp_vtl *)ap_start_input_arg;
 	memset(start_vp_input, 0, sizeof(*start_vp_input));
 	start_vp_input->partition_id = -1;
-	start_vp_input->vp_index = cpu;
+	start_vp_input->vp_index = vp_index;
 	start_vp_input->target_vtl.target_vtl = ms_hyperv.vtl;
 	*(u64 *)&start_vp_input->vp_context = __pa(vmsa) | 1;
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index bab5ccfc60a7..0b9a3a307d06 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -268,11 +268,11 @@ int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
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
@@ -306,6 +306,7 @@ static __always_inline u64 hv_raw_get_msr(unsigned int reg)
 {
 	return __rdmsr(reg);
 }
+int hv_apicid_to_vp_index(u32 apic_id);
 
 #else /* CONFIG_HYPERV */
 static inline void hyperv_init(void) {}
@@ -327,6 +328,7 @@ static inline void hv_set_msr(unsigned int reg, u64 value) { }
 static inline u64 hv_get_msr(unsigned int reg) { return 0; }
 static inline void hv_set_non_nested_msr(unsigned int reg, u64 value) { }
 static inline u64 hv_get_non_nested_msr(unsigned int reg) { return 0; }
+static inline int hv_apicid_to_vp_index(u32 apic_id) { return -EINVAL; }
 #endif /* CONFIG_HYPERV */
 
 
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index cf0923dc727d..2d431b53f587 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -475,7 +475,7 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 #define HVCALL_CREATE_PORT				0x0095
 #define HVCALL_CONNECT_PORT				0x0096
 #define HVCALL_START_VP					0x0099
-#define HVCALL_GET_VP_ID_FROM_APIC_ID			0x009a
+#define HVCALL_GET_VP_INDEX_FROM_APIC_ID			0x009a
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE	0x00af
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0
 #define HVCALL_SIGNAL_EVENT_DIRECT			0x00c0


