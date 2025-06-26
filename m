Return-Path: <stable+bounces-158667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8E1AE9844
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 10:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B373AF484
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 08:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F9825A65C;
	Thu, 26 Jun 2025 08:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWmc4kw6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9C817A5BE;
	Thu, 26 Jun 2025 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750926415; cv=none; b=dzmPHQls5vS+Zdzsp0TA+JSvpyOHb8fBbv+szrONgwJNJvykncoAmUXzDN2yIfFPWmLrCqz5kcqar1jZqSyogLuoUAnqXadi1gWTh9xW1r7wbPnlTEyHLt84DIjp2AvL8Va0TZOyfdagBJu+H0syF6quhK0HWYB+4S4p5IbP28I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750926415; c=relaxed/simple;
	bh=4mkRXRBS9NyHpAI7suiC6dJfUOy/CaSWSLhmLqYaAMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhwRXzFVWuNYZhA9/tWVxGdTH5l/nFwTCphUiYot+t5gkp2M3jkEjEatuKvDotVjh7+cQHTV9yoczsrGflEG6FtMXtIqJhdV+Yv6rJeoIiipB9GXbXz1MkoZAF6/hIrIeR5uQbBW3jNE8nXQadPeWr87uUQiK0kzFXxhYQZ+hk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWmc4kw6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6449BC4CEEB;
	Thu, 26 Jun 2025 08:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750926414;
	bh=4mkRXRBS9NyHpAI7suiC6dJfUOy/CaSWSLhmLqYaAMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BWmc4kw62O8r6c8o/R0NHh6IaqRnvVZ2xhDRZcr6s1YZ+MObVGhOjKpPOYuTHPdE7
	 Fu3iEJNMnvaqdwI34wSW2L3ZSrZgIZw8tFjU7AhfhXr2H9u8HCja1kT3lvQYdtvQmh
	 9DWF4iH51sH6Agb3iWlFtyA04/iz3EUL5OU+NZ5PkcEBxsscXSPUYiMMW1NJRMtkJy
	 7b59qwRXx61WAhrh2Gv9ryhqG9LTmk4V6awW5UB6WT0lp7GRdSGPjqYLjlowih3VIU
	 CkMWBs+OF5Jug2p7wr1QX7vxbEheKxLGdzXBh9bcSTOTUZI9pwTnVrPoxnp+23E9vp
	 rlMxzo5dFmHIQ==
Date: Thu, 26 Jun 2025 10:26:50 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Nikunj A Dadhania <nikunj@amd.com>
Cc: linux-kernel@vger.kernel.org, bp@alien8.de, x86@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	thomas.lendacky@amd.com, aik@amd.com, dionnaglaze@google.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] x86/sev: Use TSC_FACTOR for Secure TSC frequency
 calculation
Message-ID: <aF0ESlmxi1uOHkrc@gmail.com>
References: <20250626060142.2443408-1-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626060142.2443408-1-nikunj@amd.com>


* Nikunj A Dadhania <nikunj@amd.com> wrote:

> When using Secure TSC, the GUEST_TSC_FREQ MSR reports a frequency based on
> the nominal P0 frequency, which deviates slightly (typically ~0.2%) from
> the actual mean TSC frequency due to clocking parameters. Over extended VM
> uptime, this discrepancy accumulates, causing clock skew between the
> hypervisor and SEV-SNP VM, leading to early timer interrupts as perceived
> by the guest.
> 
> The guest kernel relies on the reported nominal frequency for TSC-based
> timekeeping, while the actual frequency set during SNP_LAUNCH_START may
> differ. This mismatch results in inaccurate time calculations, causing the
> guest to perceive hrtimers as firing earlier than expected.
> 
> Utilize the TSC_FACTOR from the SEV firmware's secrets page (see "Secrets
> Page Format" in the SNP Firmware ABI Specification) to calculate the mean
> TSC frequency, ensuring accurate timekeeping and mitigating clock skew in
> SEV-SNP VMs.
> 
> Use early_ioremap_encrypted() to map the secrets page as
> ioremap_encrypted() uses kmalloc() which is not available during early TSC
> initialization and causes a panic.
> 
> Fixes: 73bbf3b0fbba ("x86/tsc: Init the TSC for Secure TSC guests")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> 
> ---
> v2:
> * Move the SNP TSC scaling constant to the header (Dionna)
> * Drop the unsigned long cast and add in securetsc_get_tsc_khz (Tom)
> * Drop the RB from Tom as the code has changed
> ---
>  arch/x86/include/asm/sev.h | 18 +++++++++++++++++-
>  arch/x86/coco/sev/core.c   | 16 ++++++++++++++--
>  2 files changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index fbb616fcbfb8..869355367210 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -223,6 +223,19 @@ struct snp_tsc_info_resp {
>  	u8 rsvd2[100];
>  } __packed;
>  
> +
> +/*
> + * Obtain the mean TSC frequency by decreasing the nominal TSC frequency with
> + * TSC_FACTOR as documented in the SNP Firmware ABI specification:
> + *
> + * GUEST_TSC_FREQ * (1 - (TSC_FACTOR * 0.00001))
> + *
> + * which is equivalent to:
> + *
> + * GUEST_TSC_FREQ -= (GUEST_TSC_FREQ * TSC_FACTOR) / 100000;
> + */
> +#define SNP_SCALE_TSC_FREQ(freq, factor) ((freq) - ((freq) * (factor)) / 100000)

Nit: there's really no need to use parentheses in this expression,
'x * y / z' is equivalent and fine.

> +
>  struct snp_guest_req {
>  	void *req_buf;
>  	size_t req_sz;
> @@ -283,8 +296,11 @@ struct snp_secrets_page {
>  	u8 svsm_guest_vmpl;
>  	u8 rsvd3[3];
>  
> +	/* The percentage decrease from nominal to mean TSC frequency. */
> +	u32 tsc_factor;
> +
>  	/* Remainder of page */
> -	u8 rsvd4[3744];
> +	u8 rsvd4[3740];
>  } __packed;
>  
>  struct snp_msg_desc {
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index 8375ca7fbd8a..36f419ff25d4 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -2156,20 +2156,32 @@ void __init snp_secure_tsc_prepare(void)
>  
>  static unsigned long securetsc_get_tsc_khz(void)
>  {
> -	return snp_tsc_freq_khz;
> +	return (unsigned long)snp_tsc_freq_khz;

This forced type cast is a signature of poor type choices. Please 
harmonize the types of snp_tsc_freq_khz and securetsc_get_tsc_khz() to 
avoid the type cast altogether. Does this code even get built and run 
on 32-bit kernels?

Thanks,

	Ingo

