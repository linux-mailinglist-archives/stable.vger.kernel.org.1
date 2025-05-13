Return-Path: <stable+bounces-144212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988E6AB5C0B
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA713BE10C
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55A52BF3F0;
	Tue, 13 May 2025 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kP+D2Ynl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cv5erCyI"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C7E1E0083;
	Tue, 13 May 2025 18:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747159672; cv=none; b=MMHRNL2ewes93sIUZPgE4ZvrrZAIdoiDtKZCl/KpRaDjGo4eqzq0VmlTI9tc51JHjgqkl/Aymqzl41+muB9wiCfmGaFZS82/2m9onPFXa2CRaBksm3xFoBYWm+ur+obTb/ACE2GEvcQ4hPaOJ1fwpjqqbbXbRv6a1kTlUsB1n9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747159672; c=relaxed/simple;
	bh=/QpeFcl2VthoJ0gjijjEJaJFJbBz/vFy3CjA4vm8phI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ryNEyIkXJUXuWy+9XnjPaMDgPR2FpaMjdf4BAvKo2UJyn2AlHuvLs+KYd8uxEUcDNVd62qAV4BVzhuEGsXpuT/i7NkA24P7iLIfSYC6WKxokwpvTYiNbmWxTGyBGiKDF9M73yVGLVRZ/XKSclrQy7dHfSj9a+bLjP/pCSfPSK9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kP+D2Ynl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cv5erCyI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 May 2025 18:07:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747159668;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aH7ej6N9qJWoZxc+h/McgMIF89aH3zqHZ6RSW5dr/gQ=;
	b=kP+D2YnlPBlK676CQvZBfnSbqnBvF2373Bra07J+q81uNdXsySNt/iId/H/BEEfRs8ovn9
	Qv528TPKzS/0yHxIoqKIeXOP45t6s3yUVFHnfEZKg9ULalD2cCTdBefWwrBaQkWtKztxy5
	jA22myoyZJWlCerhCq/xj4cwwXmLcoE8jANUaHbsneZK183k9CBS+CI7zIZ9iFIRcfK6tg
	Fpuguem78mKYG1cyMrlmmvLLeub4eHuRnBDkUWg2XUX8oIXcYjcUmPrCva6bUVklzPfq/m
	vHKRr/pqduXzGnBk2fSRDlCPcQxRlzZzqK9JXMZIVWxkn4vNYevvlM+q7WfT6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747159668;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aH7ej6N9qJWoZxc+h/McgMIF89aH3zqHZ6RSW5dr/gQ=;
	b=Cv5erCyIaMy8WvC0dyxwukRm9qOEi74AslCT+lsWiutHdVm0peceuRucblXIuiKXhT0Hdn
	NPCf2D5O2guJ5bCQ==
From: "tip-bot2 for Ashish Kalra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sev: Do not touch VMSA pages during SNP guest
 memory kdump
Cc: Ashish Kalra <ashish.kalra@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Srikanth Aithal <sraithal@amd.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250428214151.155464-1-Ashish.Kalra@amd.com>
References: <20250428214151.155464-1-Ashish.Kalra@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174715966762.406.12942579862694214802.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d2062cc1b1c367d5d019f595ef860159e1301351
Gitweb:        https://git.kernel.org/tip/d2062cc1b1c367d5d019f595ef860159e1301351
Author:        Ashish Kalra <ashish.kalra@amd.com>
AuthorDate:    Mon, 28 Apr 2025 21:41:51 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 13 May 2025 19:40:44 +02:00

x86/sev: Do not touch VMSA pages during SNP guest memory kdump

When kdump is running makedumpfile to generate vmcore and dump SNP guest
memory it touches the VMSA page of the vCPU executing kdump.

It then results in unrecoverable #NPF/RMP faults as the VMSA page is
marked busy/in-use when the vCPU is running and subsequently a causes
guest softlockup/hang.

Additionally, other APs may be halted in guest mode and their VMSA pages
are marked busy and touching these VMSA pages during guest memory dump
will also cause #NPF.

Issue AP_DESTROY GHCB calls on other APs to ensure they are kicked out
of guest mode and then clear the VMSA bit on their VMSA pages.

If the vCPU running kdump is an AP, mark it's VMSA page as offline to
ensure that makedumpfile excludes that page while dumping guest memory.

Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Srikanth Aithal <sraithal@amd.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20250428214151.155464-1-Ashish.Kalra@amd.com
---
 arch/x86/coco/sev/core.c | 244 ++++++++++++++++++++++++--------------
 1 file changed, 158 insertions(+), 86 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index b0c1a7a..41060ba 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -959,6 +959,102 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
 }
 
+static int vmgexit_ap_control(u64 event, struct sev_es_save_area *vmsa, u32 apic_id)
+{
+	bool create = event != SVM_VMGEXIT_AP_DESTROY;
+	struct ghcb_state state;
+	unsigned long flags;
+	struct ghcb *ghcb;
+	int ret = 0;
+
+	local_irq_save(flags);
+
+	ghcb = __sev_get_ghcb(&state);
+
+	vc_ghcb_invalidate(ghcb);
+
+	if (create)
+		ghcb_set_rax(ghcb, vmsa->sev_features);
+
+	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_CREATION);
+	ghcb_set_sw_exit_info_1(ghcb,
+				((u64)apic_id << 32)	|
+				((u64)snp_vmpl << 16)	|
+				event);
+	ghcb_set_sw_exit_info_2(ghcb, __pa(vmsa));
+
+	sev_es_wr_ghcb_msr(__pa(ghcb));
+	VMGEXIT();
+
+	if (!ghcb_sw_exit_info_1_is_valid(ghcb) ||
+	    lower_32_bits(ghcb->save.sw_exit_info_1)) {
+		pr_err("SNP AP %s error\n", (create ? "CREATE" : "DESTROY"));
+		ret = -EINVAL;
+	}
+
+	__sev_put_ghcb(&state);
+
+	local_irq_restore(flags);
+
+	return ret;
+}
+
+static int snp_set_vmsa(void *va, void *caa, int apic_id, bool make_vmsa)
+{
+	int ret;
+
+	if (snp_vmpl) {
+		struct svsm_call call = {};
+		unsigned long flags;
+
+		local_irq_save(flags);
+
+		call.caa = this_cpu_read(svsm_caa);
+		call.rcx = __pa(va);
+
+		if (make_vmsa) {
+			/* Protocol 0, Call ID 2 */
+			call.rax = SVSM_CORE_CALL(SVSM_CORE_CREATE_VCPU);
+			call.rdx = __pa(caa);
+			call.r8  = apic_id;
+		} else {
+			/* Protocol 0, Call ID 3 */
+			call.rax = SVSM_CORE_CALL(SVSM_CORE_DELETE_VCPU);
+		}
+
+		ret = svsm_perform_call_protocol(&call);
+
+		local_irq_restore(flags);
+	} else {
+		/*
+		 * If the kernel runs at VMPL0, it can change the VMSA
+		 * bit for a page using the RMPADJUST instruction.
+		 * However, for the instruction to succeed it must
+		 * target the permissions of a lesser privileged (higher
+		 * numbered) VMPL level, so use VMPL1.
+		 */
+		u64 attrs = 1;
+
+		if (make_vmsa)
+			attrs |= RMPADJUST_VMSA_PAGE_BIT;
+
+		ret = rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
+	}
+
+	return ret;
+}
+
+static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa, int apic_id)
+{
+	int err;
+
+	err = snp_set_vmsa(vmsa, NULL, apic_id, false);
+	if (err)
+		pr_err("clear VMSA page failed (%u), leaking page\n", err);
+	else
+		free_page((unsigned long)vmsa);
+}
+
 static void set_pte_enc(pte_t *kpte, int level, void *va)
 {
 	struct pte_enc_desc d = {
@@ -1055,6 +1151,65 @@ void snp_kexec_begin(void)
 		pr_warn("Failed to stop shared<->private conversions\n");
 }
 
+/*
+ * Shutdown all APs except the one handling kexec/kdump and clearing
+ * the VMSA tag on AP's VMSA pages as they are not being used as
+ * VMSA page anymore.
+ */
+static void shutdown_all_aps(void)
+{
+	struct sev_es_save_area *vmsa;
+	int apic_id, this_cpu, cpu;
+
+	this_cpu = get_cpu();
+
+	/*
+	 * APs are already in HLT loop when enc_kexec_finish() callback
+	 * is invoked.
+	 */
+	for_each_present_cpu(cpu) {
+		vmsa = per_cpu(sev_vmsa, cpu);
+
+		/*
+		 * The BSP or offlined APs do not have guest allocated VMSA
+		 * and there is no need  to clear the VMSA tag for this page.
+		 */
+		if (!vmsa)
+			continue;
+
+		/*
+		 * Cannot clear the VMSA tag for the currently running vCPU.
+		 */
+		if (this_cpu == cpu) {
+			unsigned long pa;
+			struct page *p;
+
+			pa = __pa(vmsa);
+			/*
+			 * Mark the VMSA page of the running vCPU as offline
+			 * so that is excluded and not touched by makedumpfile
+			 * while generating vmcore during kdump.
+			 */
+			p = pfn_to_online_page(pa >> PAGE_SHIFT);
+			if (p)
+				__SetPageOffline(p);
+			continue;
+		}
+
+		apic_id = cpuid_to_apicid[cpu];
+
+		/*
+		 * Issue AP destroy to ensure AP gets kicked out of guest mode
+		 * to allow using RMPADJUST to remove the VMSA tag on it's
+		 * VMSA page.
+		 */
+		vmgexit_ap_control(SVM_VMGEXIT_AP_DESTROY, vmsa, apic_id);
+		snp_cleanup_vmsa(vmsa, apic_id);
+	}
+
+	put_cpu();
+}
+
 void snp_kexec_finish(void)
 {
 	struct sev_es_runtime_data *data;
@@ -1069,6 +1224,8 @@ void snp_kexec_finish(void)
 	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
 		return;
 
+	shutdown_all_aps();
+
 	unshare_all_memory();
 
 	/*
@@ -1090,51 +1247,6 @@ void snp_kexec_finish(void)
 	}
 }
 
-static int snp_set_vmsa(void *va, void *caa, int apic_id, bool make_vmsa)
-{
-	int ret;
-
-	if (snp_vmpl) {
-		struct svsm_call call = {};
-		unsigned long flags;
-
-		local_irq_save(flags);
-
-		call.caa = this_cpu_read(svsm_caa);
-		call.rcx = __pa(va);
-
-		if (make_vmsa) {
-			/* Protocol 0, Call ID 2 */
-			call.rax = SVSM_CORE_CALL(SVSM_CORE_CREATE_VCPU);
-			call.rdx = __pa(caa);
-			call.r8  = apic_id;
-		} else {
-			/* Protocol 0, Call ID 3 */
-			call.rax = SVSM_CORE_CALL(SVSM_CORE_DELETE_VCPU);
-		}
-
-		ret = svsm_perform_call_protocol(&call);
-
-		local_irq_restore(flags);
-	} else {
-		/*
-		 * If the kernel runs at VMPL0, it can change the VMSA
-		 * bit for a page using the RMPADJUST instruction.
-		 * However, for the instruction to succeed it must
-		 * target the permissions of a lesser privileged (higher
-		 * numbered) VMPL level, so use VMPL1.
-		 */
-		u64 attrs = 1;
-
-		if (make_vmsa)
-			attrs |= RMPADJUST_VMSA_PAGE_BIT;
-
-		ret = rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
-	}
-
-	return ret;
-}
-
 #define __ATTR_BASE		(SVM_SELECTOR_P_MASK | SVM_SELECTOR_S_MASK)
 #define INIT_CS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_READ_MASK | SVM_SELECTOR_CODE_MASK)
 #define INIT_DS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_WRITE_MASK)
@@ -1166,24 +1278,10 @@ static void *snp_alloc_vmsa_page(int cpu)
 	return page_address(p + 1);
 }
 
-static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa, int apic_id)
-{
-	int err;
-
-	err = snp_set_vmsa(vmsa, NULL, apic_id, false);
-	if (err)
-		pr_err("clear VMSA page failed (%u), leaking page\n", err);
-	else
-		free_page((unsigned long)vmsa);
-}
-
 static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
 {
 	struct sev_es_save_area *cur_vmsa, *vmsa;
-	struct ghcb_state state;
 	struct svsm_ca *caa;
-	unsigned long flags;
-	struct ghcb *ghcb;
 	u8 sipi_vector;
 	int cpu, ret;
 	u64 cr4;
@@ -1297,33 +1395,7 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
 	}
 
 	/* Issue VMGEXIT AP Creation NAE event */
-	local_irq_save(flags);
-
-	ghcb = __sev_get_ghcb(&state);
-
-	vc_ghcb_invalidate(ghcb);
-	ghcb_set_rax(ghcb, vmsa->sev_features);
-	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_CREATION);
-	ghcb_set_sw_exit_info_1(ghcb,
-				((u64)apic_id << 32)	|
-				((u64)snp_vmpl << 16)	|
-				SVM_VMGEXIT_AP_CREATE);
-	ghcb_set_sw_exit_info_2(ghcb, __pa(vmsa));
-
-	sev_es_wr_ghcb_msr(__pa(ghcb));
-	VMGEXIT();
-
-	if (!ghcb_sw_exit_info_1_is_valid(ghcb) ||
-	    lower_32_bits(ghcb->save.sw_exit_info_1)) {
-		pr_err("SNP AP Creation error\n");
-		ret = -EINVAL;
-	}
-
-	__sev_put_ghcb(&state);
-
-	local_irq_restore(flags);
-
-	/* Perform cleanup if there was an error */
+	ret = vmgexit_ap_control(SVM_VMGEXIT_AP_CREATE, vmsa, apic_id);
 	if (ret) {
 		snp_cleanup_vmsa(vmsa, apic_id);
 		vmsa = NULL;

