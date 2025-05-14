Return-Path: <stable+bounces-144331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA672AB6402
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 09:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41CD016DF20
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 07:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3FC205501;
	Wed, 14 May 2025 07:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHY3ujTT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAD51FF7B0;
	Wed, 14 May 2025 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747207264; cv=none; b=P/jNjXqPMelEPf5j+7U/f3MvgB5gikM81NZOYvYUkpx80hPjKEFoyYzK3ZvwpmyZ8t83XNOT+2dY4lqxAme9rc98VlMEOqQSHXdqN5UK8V3KRLAGci3L9JO8pN9mk+kY1rTaMKEnHhQJl1UrdQnc+gQdRsEyJ7EQA02Nak+SSJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747207264; c=relaxed/simple;
	bh=P8AX7jbxVoygV9YOfCd7NneW4qV1TixrkbkMfsHBAhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAH36WYgJBN6RatIdB4d/qB1oXzeyE6sAZL5hzAAtwXjtxux15YwF1G7prcMu5cSvnRVbCrEitVH32niiHiy0KJmFtFOT8dkQm5B/y/33RG7UYbO3NgJo0qgUEUhffqlslqlGGK3rCkNdCnAlX292UpPjeJ/dkZ2Gb3fZ+iOnqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHY3ujTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5262DC4CEE9;
	Wed, 14 May 2025 07:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747207263;
	bh=P8AX7jbxVoygV9YOfCd7NneW4qV1TixrkbkMfsHBAhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uHY3ujTTkXIy/18Z7KbzL4vIqpbusGR1VSr9UwuHKOzryKYe3VBbRVU80kS1fPVX9
	 otlJpDtU46z2WdZWCAEMRlTkHG0RQHVTfMOt+pjbXwnS4mMkuBWroVgzHdxVbTIDBq
	 8f5ZcYwh8QBTY76f3haFBYSll5USRHnGicZOFkH7jdhvB0JYdP1OSTyf2mvPvxzchx
	 mT7oNUvZTyxXBBx7BAUTVLEA5TJOTo35KLlj8F/GTYVfXBLOBxjyP9wzDfRCvNNWz1
	 SIOmi3Xdst6yZF40vIcAqtmzUInG/Od6gv61Q1xszbz3eGupl+OSX0Gmo+3CWRYFrj
	 82hpq0Pq3DIOg==
Date: Wed, 14 May 2025 09:20:58 +0200
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Ashish Kalra <ashish.kalra@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Srikanth Aithal <sraithal@amd.com>, stable@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/sev: Do not touch VMSA pages during SNP
 guest memory kdump
Message-ID: <aCREWka5uQndvTN_@gmail.com>
References: <20250428214151.155464-1-Ashish.Kalra@amd.com>
 <174715966762.406.12942579862694214802.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174715966762.406.12942579862694214802.tip-bot2@tip-bot2>


* tip-bot2 for Ashish Kalra <tip-bot2@linutronix.de> wrote:

> The following commit has been merged into the x86/urgent branch of tip:
> 
> Commit-ID:     d2062cc1b1c367d5d019f595ef860159e1301351
> Gitweb:        https://git.kernel.org/tip/d2062cc1b1c367d5d019f595ef860159e1301351
> Author:        Ashish Kalra <ashish.kalra@amd.com>
> AuthorDate:    Mon, 28 Apr 2025 21:41:51 
> Committer:     Borislav Petkov (AMD) <bp@alien8.de>
> CommitterDate: Tue, 13 May 2025 19:40:44 +02:00
> 
> x86/sev: Do not touch VMSA pages during SNP guest memory kdump
> 
> When kdump is running makedumpfile to generate vmcore and dump SNP guest
> memory it touches the VMSA page of the vCPU executing kdump.
> 
> It then results in unrecoverable #NPF/RMP faults as the VMSA page is
> marked busy/in-use when the vCPU is running and subsequently a causes
> guest softlockup/hang.

s/subsequently a causes
 /subsequently causes

> Additionally, other APs may be halted in guest mode and their VMSA pages
> are marked busy and touching these VMSA pages during guest memory dump
> will also cause #NPF.
> 
> Issue AP_DESTROY GHCB calls on other APs to ensure they are kicked out
> of guest mode and then clear the VMSA bit on their VMSA pages.
> 
> If the vCPU running kdump is an AP, mark it's VMSA page as offline to
> ensure that makedumpfile excludes that page while dumping guest memory.

s/mark it's VMSA page
 /mark its VMSA page

> 
> Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Tested-by: Srikanth Aithal <sraithal@amd.com>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/20250428214151.155464-1-Ashish.Kalra@amd.com
> ---
>  arch/x86/coco/sev/core.c | 244 ++++++++++++++++++++++++--------------
>  1 file changed, 158 insertions(+), 86 deletions(-)
> 
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index b0c1a7a..41060ba 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -959,6 +959,102 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
>  	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
>  }
>  
> +static int vmgexit_ap_control(u64 event, struct sev_es_save_area *vmsa, u32 apic_id)
> +{
> +	bool create = event != SVM_VMGEXIT_AP_DESTROY;
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
> +
> +	if (create)
> +		ghcb_set_rax(ghcb, vmsa->sev_features);
> +
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
> +		pr_err("SNP AP %s error\n", (create ? "CREATE" : "DESTROY"));
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
> +static int snp_set_vmsa(void *va, void *caa, int apic_id, bool make_vmsa)
> +{
> +	int ret;
> +
> +	if (snp_vmpl) {
> +		struct svsm_call call = {};
> +		unsigned long flags;
> +
> +		local_irq_save(flags);
> +
> +		call.caa = this_cpu_read(svsm_caa);
> +		call.rcx = __pa(va);
> +
> +		if (make_vmsa) {
> +			/* Protocol 0, Call ID 2 */
> +			call.rax = SVSM_CORE_CALL(SVSM_CORE_CREATE_VCPU);
> +			call.rdx = __pa(caa);

This can probably use svsm_caa_pa instead of __pa(), like 
sev_es_init_vc_handling() does, see below.

> +			call.r8  = apic_id;
> +		} else {
> +			/* Protocol 0, Call ID 3 */
> +			call.rax = SVSM_CORE_CALL(SVSM_CORE_DELETE_VCPU);
> +		}
> +
> +		ret = svsm_perform_call_protocol(&call);
> +
> +		local_irq_restore(flags);
> +	} else {
> +		/*
> +		 * If the kernel runs at VMPL0, it can change the VMSA
> +		 * bit for a page using the RMPADJUST instruction.
> +		 * However, for the instruction to succeed it must
> +		 * target the permissions of a lesser privileged (higher
> +		 * numbered) VMPL level, so use VMPL1.
> +		 */
> +		u64 attrs = 1;
> +
> +		if (make_vmsa)
> +			attrs |= RMPADJUST_VMSA_PAGE_BIT;
> +
> +		ret = rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
> +	}
> +
> +	return ret;
> +}
> +
> +static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa, int apic_id)
> +{
> +	int err;
> +
> +	err = snp_set_vmsa(vmsa, NULL, apic_id, false);
> +	if (err)
> +		pr_err("clear VMSA page failed (%u), leaking page\n", err);
> +	else
> +		free_page((unsigned long)vmsa);

So the argument types here are really messy:

 - We pass in a 'struct sev_es_save_area *vmsa' to snp_cleanup_vmsa(), 
   which passes it down to snp_set_vmsa() as a void *, where it's 
   force-type-cast to 'unsigned long' ...

 - While within snp_cleanup_vmsa() we also force-cast it to 'unsigned 
   long' yet again.

It would be much cleaner to do a single, obvious force-cast to a 
virtual address type within snp_cleanup_vmsa():

   unsigned long vmsa_va = (unsigned long)vmsa;

And change snp_set_vmsa()'s parameter to 'unsigned long vmsa_va', to 
get rid of a lot of forced/dangerous type conversions.

Plus the handling of 'caa' pointers it really messy AFAICS:

 - alloc_runtime_data() calculates svsm_caa_pa physical addresses for 
   each CPU:

                per_cpu(svsm_caa_pa, cpu) = __pa(caa);

   Which is used by sev_es_init_vc_handling():

                call.rcx = this_cpu_read(svsm_caa_pa);

   But snp_set_vmsa() calculates the physical address *again* instead 
   of using svsm_caa_pa:

                call.caa = this_cpu_read(svsm_caa);
                ...
                        call.rdx = __pa(caa);

   Same for snp_set_vmsa():

                call.caa = this_cpu_read(svsm_caa);
                call.rcx = __pa(va);

Why? Either this is something subtle and undocumented, or at minimum 
this unnecessarily complicates the code and creates inconsistent 
patterns of implementing the same functionality.

> +}
> +
>  static void set_pte_enc(pte_t *kpte, int level, void *va)
>  {
>  	struct pte_enc_desc d = {
> @@ -1055,6 +1151,65 @@ void snp_kexec_begin(void)
>  		pr_warn("Failed to stop shared<->private conversions\n");
>  }
>  
> +/*
> + * Shutdown all APs except the one handling kexec/kdump and clearing
> + * the VMSA tag on AP's VMSA pages as they are not being used as
> + * VMSA page anymore.

s/Shutdown
  Shut down

'shutdown' is a noun, the verb is 'to shut down'.

> + */
> +static void shutdown_all_aps(void)
> +{
> +	struct sev_es_save_area *vmsa;
> +	int apic_id, this_cpu, cpu;
> +
> +	this_cpu = get_cpu();
> +
> +	/*
> +	 * APs are already in HLT loop when enc_kexec_finish() callback
> +	 * is invoked.
> +	 */
> +	for_each_present_cpu(cpu) {
> +		vmsa = per_cpu(sev_vmsa, cpu);
> +
> +		/*
> +		 * The BSP or offlined APs do not have guest allocated VMSA
> +		 * and there is no need  to clear the VMSA tag for this page.

Whitespace noise:

   s/  / /

> +		 */
> +		if (!vmsa)
> +			continue;
> +
> +		/*
> +		 * Cannot clear the VMSA tag for the currently running vCPU.
> +		 */
> +		if (this_cpu == cpu) {
> +			unsigned long pa;
> +			struct page *p;
> +
> +			pa = __pa(vmsa);
> +			/*
> +			 * Mark the VMSA page of the running vCPU as offline
> +			 * so that is excluded and not touched by makedumpfile
> +			 * while generating vmcore during kdump.

s/so that is excluded
 /so that it is excluded

> +			 */
> +			p = pfn_to_online_page(pa >> PAGE_SHIFT);
> +			if (p)
> +				__SetPageOffline(p);
> +			continue;
> +		}
> +
> +		apic_id = cpuid_to_apicid[cpu];
> +
> +		/*
> +		 * Issue AP destroy to ensure AP gets kicked out of guest mode
> +		 * to allow using RMPADJUST to remove the VMSA tag on it's
> +		 * VMSA page.

s/on it's VMSA page
 /on its VMSA page

> +		 */
> +		vmgexit_ap_control(SVM_VMGEXIT_AP_DESTROY, vmsa, apic_id);
> +		snp_cleanup_vmsa(vmsa, apic_id);

Boris, please don't rush these SEV patches without proper review first! ;-)

Thanks,

	Ingo

