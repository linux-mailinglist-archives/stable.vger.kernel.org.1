Return-Path: <stable+bounces-139485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FD9AA740B
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 15:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 802887BBA40
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 13:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC66255E55;
	Fri,  2 May 2025 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="EDZFm9cR"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F3625522D;
	Fri,  2 May 2025 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746193368; cv=none; b=LrTBS1C1RZD6BomRhOBGINUryJsSXyC5JcXAlyoL7eHedPpLjkWf1C9nUEWM2fSuYHpI+YTOgtGD2Vtg58e8XeAutG5jT9Yq2B+wEgavms5GiMp9Js+AgJ590ONrHdfDIidclmFHE2NuBYmIgnFyDa1SYq535dtQnDRSGd0S6Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746193368; c=relaxed/simple;
	bh=IY0rlxjmEHi/ciqk8neIWDYUSW1yDZpT8KyLguF3h5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkE+V5tijBWyUURlvjD3QpyK66xBavu8sAKV8SQvxme+/kfVAxaLMgakCLA43mUPLJJShwwLp5Ssx06dgjOM9QvO/Jo+AxSJ12GE9rBWmtl6r3jcHXvgykLV3KAUKTXzk1GRC3UzB6eugwyk63TbotSOnZrKMUblxaWo2Vh+q/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=EDZFm9cR; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0527640E0206;
	Fri,  2 May 2025 13:42:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WzojnnI9NbdX; Fri,  2 May 2025 13:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1746193358; bh=3QSMU3KlWQVbxBP3Lk2kvk2uhPllvL0/5lmXwW4VnTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EDZFm9cR668TeU9Ptf2SNcTAWEp3rtT1cZmI77WC6jtdgj9i2zmL42LIfAdwKiFgZ
	 8iy8ppWvEewbVyOAs1Y21gT8oPuK0UzIL+pX4ZTrubob05nuLvdfCUV90pZBd9Oh9S
	 hF+tsSYrqHmd9vPwd4WjWBxGrXQP1iKQodFUXJQv04CMzr6Dxylk9UbLbaZs7+1pAO
	 Omn9+OyWFpLvR9Ud7nh3uOtdCmUgkY+xUyEtjegC0EhBtkT0O5XJTf9H8xxft7wl0l
	 se9L//9FP2LBW3vsA2L38o0xYfDq1W1e19CC6yYTc9Wo9oHSQ+k+/c/U8/rw7o7Zyf
	 r2vTCzoEaI5RsyxB1f7Neq7EoqfOzWOB/HKNvw9DC+hvaRfkg8tdT6tSoTARB7OLQ7
	 WeiGZ6mIXgWDZUoPhdHRehzERbaXLjMvTxLEVi8YqMqo9Tr6Z2HmQ+po/6GQODspSw
	 yOSuUs6OlE10TJsA1CjBVGCX4FL9mflf6AY7aeHAYPTaCZl2K+ksTcf2+Yi8nwQq4v
	 I6ya5FMePn2hloqSX5P9tmLWbAV4ZCbsVQ+3YVhz5LfywB9ULcLODa0G8F6XtxE5Si
	 nXQKFQY0wa8R3Jn1Jcm3ZxR2YKDj6Unve51j46SyGBUNKLWGVTuHz4Ve+teTkky0fa
	 iHntu04tdlxmv+xDHqjxlfAU=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3943A40E01CF;
	Fri,  2 May 2025 13:42:19 +0000 (UTC)
Date: Fri, 2 May 2025 15:42:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, kees@kernel.org, michael.roth@amd.com,
	nikunj@amd.com, seanjc@google.com, ardb@kernel.org,
	gustavoars@kernel.org, sgarzare@redhat.com, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev
Subject: Re: [PATCH v4] x86/sev: Don't touch VMSA pages during kdump of SNP
 guest memory
Message-ID: <20250502134212.GBaBTLtDu8D5Xl6Jqy@fat_crate.local>
References: <20250430215730.369777-1-Ashish.Kalra@amd.com>
 <e7a0cc72-388a-7fa4-601f-371aea369204@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7a0cc72-388a-7fa4-601f-371aea369204@amd.com>

On Thu, May 01, 2025 at 08:29:59AM -0500, Tom Lendacky wrote:
> Just occurred to me that, while we don't use it, there is another create
> event, SVM_VMGEXIT_AP_CREATE_ON_INIT. So maybe change this to
> 
>   bool create = event != SVM_VMGEXIT_AP_DESTROY;

Thx, I have this applied now:

---
From: Ashish Kalra <ashish.kalra@amd.com>
Date: Mon, 28 Apr 2025 21:41:51 +0000
Subject: [PATCH] x86/sev: Do not touch VMSA pages during SNP guest memory kdump

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
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20250428214151.155464-1-Ashish.Kalra@amd.com
---
 arch/x86/coco/sev/core.c | 244 +++++++++++++++++++++++++--------------
 1 file changed, 158 insertions(+), 86 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 2c19396f8186..144e0f8ac042 100644
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
@@ -1061,6 +1157,65 @@ void snp_kexec_begin(void)
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
@@ -1075,6 +1230,8 @@ void snp_kexec_finish(void)
 	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
 		return;
 
+	shutdown_all_aps();
+
 	unshare_all_memory();
 
 	/*
@@ -1100,51 +1257,6 @@ void snp_kexec_finish(void)
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
@@ -1176,24 +1288,10 @@ static void *snp_alloc_vmsa_page(int cpu)
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
@@ -1307,33 +1405,7 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
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
-- 
2.43.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

