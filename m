Return-Path: <stable+bounces-136616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68444A9B5F1
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 20:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B2497AEFFC
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 18:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FCE28E60C;
	Thu, 24 Apr 2025 18:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SdJsuIVA"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8891C1C84A6;
	Thu, 24 Apr 2025 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745517939; cv=none; b=qqbocCC32CUBAxWc2F5k9XtFW7tLdC+oGf48hBpth/Sz++5/bVR+RmpqYyJcHyJhi/+nXSFygEPScJ9VTtKscSoaNx8mUu7zDqKPi5fefo7AuoadRVORSwv6kQgtrfk8cGTnfuOoB5qqzOXzZVzycVVqIIsWWlCyrPJkTQpgM6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745517939; c=relaxed/simple;
	bh=BlefwC/6oJHckCLGl/p/nqsuA+BCc0YqQJPKdv59T98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4717kFZgaiYVH6wC4L62ubSUBzbXaKqdPmbAI3vpk7bbvPN7aE4XD8KePJBEotZlcnN70doerxwz4ILr5NC64M5EWaLaVxzXst2q2/eSHI+PB+9YZfqf+TgoaWFiubloFwIUsxiG1tqugIlt0IuSAemzKmW3cc7dcQMHb2Oq6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SdJsuIVA; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EEBC540E01ED;
	Thu, 24 Apr 2025 18:05:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CzelB82LjjVl; Thu, 24 Apr 2025 18:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1745517925; bh=16C+CMlwuJTJNLJcpZRsMxg5qIZZPBa2XS+2PdH4qcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SdJsuIVACbQsR1GAyrsVH0sKjey7DenJ9UvFCn7gYThixDi50tgIr1W2L6D/qGCtn
	 6E9Tr/lhNWvFaYhoDwYZ4ODeHJQQzTpV8t0Jn3y7qZGppLzg4+JAjTm+64uq/QJzq3
	 2bGyO1J9KqqFKV1DGcfFrtTwHWhlMc8PYZjWCyIR4jldXUqeHoST40hzIB/pFCXBqc
	 /df1PVZaICMmWmZ8T3YO1UuiEHQJlz7fRLmqkoWo0NZZwPJs6hP/kPICWYY5zv+ySV
	 m5L3lqdEteucU0bwfCem9H5YeKdaDwR0TCnuEDm0uAMCGOl82n8l+Qh2Qrbqe/dJmZ
	 BRK6D7gAnhp9yCk0MNDIDX8fFJR8OppCTQ3n9HUWnsO2wVIITDLaJf4ptSpYmgeFuf
	 42fWI3aHy8R+zQdgaL49bkZdufiTpsQvXbNHMfVif1AHfRVoFWvL3ukYyHKrDt013S
	 uQ/WM2T072lRt7d/j26upMLCHhfLuW2945HZ3mzkgRTOBuBmoIgXcfS4fJ9dopH+Fr
	 5Kw7XBJ3/+Wk9Rx0/iRnflE5/4E5tEhl7OERM198oT9qPzqESouxgzzRzpPD85//8Y
	 h1oqL6kvEqGnPXXRR0k1omLV9aNUw8tysS5iT30nSuT4GwHnlbuzr7PgyYPCwmy63B
	 f1xdS75vX2XThK+CbOvbAxXQ=
Received: from rn.tnic (unknown [IPv6:2a02:3031:201:2677:b4a0:48b8:e35c:ca37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 000FA40E01FF;
	Thu, 24 Apr 2025 18:05:05 +0000 (UTC)
Date: Thu, 24 Apr 2025 20:06:04 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, thomas.lendacky@amd.com, hpa@zytor.com,
	kees@kernel.org, michael.roth@amd.com, nikunj@amd.com,
	seanjc@google.com, ardb@kernel.org, gustavoars@kernel.org,
	sgarzare@redhat.com, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev
Subject: Re: [PATCH v2] x86/sev: Fix SNP guest kdump hang/softlockup/panic
Message-ID: <20250424180604.GAaAp9jG7N9YyYeprz@renoirsky.local>
References: <20250424141536.673522-1-Ashish.Kalra@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250424141536.673522-1-Ashish.Kalra@amd.com>

Rn Thu, Apr 24, 2025 at 02:15:36PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> When kdump is running makedumpfile to generate vmcore and dumping SNP
> guest memory it touches the VMSA page of the vCPU executing kdump which
> then results in unrecoverable #NPF/RMP faults as the VMSA page is
> marked busy/in-use when the vCPU is running.

Definitely better. Thanks.

> This leads to guest softlockup/hang:
> 
> [  117.111097] watchdog: BUG: soft lockup - CPU#0 stuck for 27s! [cp:318]
> [  117.111165] CPU: 0 UID: 0 PID: 318 Comm: cp Not tainted 6.14.0-next-20250328-snp-host-f2a41ff576cc-dirty #414 VOLUNTARY
> [  117.111171] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
> [  117.111176] RIP: 0010:rep_movs_alternative+0x5b/0x70
> [  117.111200] Call Trace:
> [  117.111204]  <TASK>
> [  117.111206]  ? _copy_to_iter+0xc1/0x720
> [  117.111216]  ? srso_return_thunk+0x5/0x5f
> [  117.111220]  ? _raw_spin_unlock+0x27/0x40
> [  117.111234]  ? srso_return_thunk+0x5/0x5f
> [  117.111236]  ? find_vmap_area+0xd6/0xf0
> [  117.111251]  ? srso_return_thunk+0x5/0x5f
> [  117.111253]  ? __check_object_size+0x18d/0x2e0
> [  117.111268]  __copy_oldmem_page.part.0+0x64/0xa0
> [  117.111281]  copy_oldmem_page_encrypted+0x1d/0x30
> [  117.111285]  read_from_oldmem.part.0+0xf4/0x200
> [  117.111306]  read_vmcore+0x206/0x3c0
> [  117.111309]  ? srso_return_thunk+0x5/0x5f
> [  117.111325]  proc_reg_read_iter+0x59/0x90
> [  117.111334]  vfs_read+0x26e/0x350

I ask you again: why is that untrimmed splat needed here?

> Additionally other APs may be halted in guest mode and their VMSA pages
> are marked busy and touching these VMSA pages during guest memory dump
> will also cause #NPF.

So, the title of this patch should be something like "Do not touch VMSA
pages during kdump of SNP guest memory" ?

Because what you have now cannot be any more indeterminate...

> Issue AP_DESTROY GHCB calls on other APs to ensure they are kicked out
> of guest mode and then clear the VMSA bit on their VMSA pages.
> 
> If the vCPU running kdump is an AP, mark it's VMSA page as offline to
> ensure that makedumpfile excludes that page while dumping guest memory.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")

This one and the next one you sent are fixing both one and the same
patch - yours.

So, how much has this one and your other one:

https://lore.kernel.org/all/20250424142739.673666-1-Ashish.Kalra@amd.com

have been tested?

I'd like for those two to be extensively tested before I send them to
Linus in this cycle still so that they don't break anything.

> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/coco/sev/core.c | 129 ++++++++++++++++++++++++++++++---------
>  1 file changed, 101 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index dcfaa698d6cf..870f4994a13d 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -113,6 +113,8 @@ DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
>  DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
>  DEFINE_PER_CPU(u64, svsm_caa_pa);
>  
> +static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa, int apic_id);

No lazy forward declarations. Restructure your code pls so that you
don't need them.

> +
>  static __always_inline bool on_vc_stack(struct pt_regs *regs)
>  {
>  	unsigned long sp = regs->sp;
> @@ -877,6 +879,42 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
>  	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
>  }
>  
> +static int issue_vmgexit_ap_create_destroy(u64 event, struct sev_es_save_area *vmsa, u32 apic_id)

vmgexit_ap_control() or so.

> +{
> +	struct ghcb_state state;
> +	unsigned long flags;
> +	struct ghcb *ghcb;
> +	int ret = 0;
> +
> +	local_irq_save(flags);
> +
> +	ghcb = __sev_get_ghcb(&state);
> +
> +	vc_ghcb_invalidate(ghcb);
> +	ghcb_set_rax(ghcb, vmsa->sev_features);
> +	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_CREATION);
> +	ghcb_set_sw_exit_info_1(ghcb,
> +				((u64)apic_id << 32)	|
> +				((u64)snp_vmpl << 16)	|
> +				event);
> +	ghcb_set_sw_exit_info_2(ghcb, __pa(vmsa));
> +
> +	sev_es_wr_ghcb_msr(__pa(ghcb));
> +	VMGEXIT();
> +
> +	if (!ghcb_sw_exit_info_1_is_valid(ghcb) ||
> +	    lower_32_bits(ghcb->save.sw_exit_info_1)) {
> +		pr_err("SNP AP %s error\n", (event == SVM_VMGEXIT_AP_CREATE ? "CREATE" : "DESTROY"));
> +		ret = -EINVAL;
> +	}
> +
> +	__sev_put_ghcb(&state);
> +
> +	local_irq_restore(flags);
> +
> +	return ret;
> +}
> +
>  static void set_pte_enc(pte_t *kpte, int level, void *va)
>  {
>  	struct pte_enc_desc d = {
> @@ -973,6 +1011,66 @@ void snp_kexec_begin(void)
>  		pr_warn("Failed to stop shared<->private conversions\n");
>  }
>  
> +/*
> + * Shutdown all APs except the one handling kexec/kdump and clearing
> + * the VMSA tag on AP's VMSA pages as they are not being used as
> + * VMSA page anymore.
> + */
> +static void snp_shutdown_all_aps(void)

Static function - no need for "snp_" prefix.

> +{
> +	struct sev_es_save_area *vmsa;
> +	int apic_id, cpu;
> +
> +	/*
> +	 * APs are already in HLT loop when kexec_finish() is invoked.

Which kexec_finish?

$ git grep -w kexec_finish
$

> +	 */

Btw, comment fits on one line.

> +	for_each_present_cpu(cpu) {

What if some CPUs are offlined? Or in this part of kexec that's not
a problem?

> +		vmsa = per_cpu(sev_vmsa, cpu);
> +
> +		/*
> +		 * BSP does not have guest allocated VMSA, so it's in-use/busy
> +		 * VMSA cannot touch a guest page and there is no need to clear
> +		 * the VMSA tag for this page.

This comment's text needs sanitizing.

> +		 */
> +		if (!vmsa)
> +			continue;
> +
> +		/*
> +		 * Cannot clear the VMSA tag for the currently running vCPU.
> +		 */
> +		if (get_cpu() == cpu) {
> +			unsigned long pa;
> +			struct page *p;
> +
> +			pa = __pa(vmsa);
> +			p = pfn_to_online_page(pa >> PAGE_SHIFT);
> +			/*
> +			 * Mark the VMSA page of the running vCPU as Offline

offline

> +			 * so that is excluded and not touched by makedumpfile
> +			 * while generating vmcore during kdump boot.

during kdump. No boot.

> +			 */

Put that comment above the previous line: p = pfn_...

> +			if (p)
> +				__SetPageOffline(p);
> +			put_cpu();
> +			continue;
> +		}
> +		put_cpu();

Restructure your code so that you don't need those two put_cpu()s there.

> +
> +		apic_id = cpuid_to_apicid[cpu];
> +
> +		/*
> +		 * Issue AP destroy on all APs (to ensure they are kicked out
> +		 * of guest mode) to allow using RMPADJUST to remove the VMSA
> +		 * tag on VMSA pages especially for guests that allow HLT to
> +		 * not be intercepted.
> +		 */

This is not "on all" - it is only on this apic_id.

Also, your comment needs splitting into simple sentences as it tries to
say *everything* which is not really necessary.

> +

Superfluous newline.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

