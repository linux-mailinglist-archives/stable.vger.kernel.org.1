Return-Path: <stable+bounces-121204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB51A547B3
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 11:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A69803AE4EA
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 10:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE1B1F63E1;
	Thu,  6 Mar 2025 10:24:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from er-systems.de (er-systems.de [162.55.144.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9F81FF7DA
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 10:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.144.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256686; cv=none; b=urW69AzIAB+f1EqUlq/TRTdmPssGzXbVV7CbwURiLtpFqiYdLjyfoLdOUnp3y46NYHHM87Yq4QdMpI8oHLX3Fmz0eQ3gZlDzijue/UtzUxa4LsaSz3zfeqWMr01APB7VluyhpiNnrcgWIjqYW4ptMVH4Kgq8cnQaSQ4SPuh7mFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256686; c=relaxed/simple;
	bh=gRUPigYKtAeXbDkdakCo1FckqcN9hRRrureJb8As0N4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ks6QCo9bIgarknt9xQQF+doAqpvlbViyu+1GWMbBNLhEbmu5ozRH5FiqnWhpo7C816IEK1Ru/G9oQf84EvtxGryeM3H4B6C7B+2eg+MCpcVPrY9ITMnVJ3H1KTF3xVQQXbI5lGdpoIrb1SMvQw61ta+SCe3u9TLOYVLFrn2m7rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lio96.de; spf=pass smtp.mailfrom=lio96.de; arc=none smtp.client-ip=162.55.144.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lio96.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lio96.de
Received: from localhost.localdomain (localhost [127.0.0.1])
	by er-systems.de (Postfix) with ESMTP id 36ED9EC0068;
	Thu,  6 Mar 2025 11:24:39 +0100 (CET)
X-Spam-Level: 
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by er-systems.de (Postfix) with ESMTPS id 1E6BDEC0065;
	Thu,  6 Mar 2025 11:24:39 +0100 (CET)
Date: Thu, 6 Mar 2025 11:24:37 +0100 (CET)
From: Thomas Voegtle <tv@lio96.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
cc: stable <stable@vger.kernel.org>, Xi Ruoyao <xry111@xry111.site>, 
    Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: Please apply f24f669d03f8 ("x86/mm: Don't disable PCID when
 INVLPG has been fixed by microcode")
In-Reply-To: <20250306082316.ca7ozay3yhrltfpp@desk>
Message-ID: <011fdcdd-bdba-a627-defc-aed44d5d2543@lio96.de>
References: <8ce15881-3a46-fc08-72e1-95047b844ec0@lio96.de> <20250306082316.ca7ozay3yhrltfpp@desk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Virus-Status: No
X-Virus-Checker-Version: clamassassin 1.2.4 with clamdscan / ClamAV 1.4.2/27568/Wed Mar  5 10:48:48 2025

On Thu, 6 Mar 2025, Pawan Gupta wrote:

> On Wed, Mar 05, 2025 at 06:39:39PM +0100, Thomas Voegtle wrote:
>>
>> Hi,
>>
>> please apply f24f669d03f8 for 6.12.y.
>> It is already in 6.13.y.
>>
>> Backports of that patch would be needed for 6.6.y down to 5.4.y as it
>> doesn't apply.
>>
>> But I don't know how to backport that fix but I can test anything.
>
> Could you please test the following patch on 6.6.y?


Works on 6.6.81-rc1.
Found pcid in /proc/cpuinfo
No more "Incomplete global flushes, disabling PCID" in dmesg

model name      : 12th Gen Intel(R) Core(TM) i3-12100
with
microcode       : 0x38



>
> ---
> From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Subject: [PATCH 6.6] x86/mm: Don't disable PCID when INVLPG has been fixed by
> microcode
>
> From: Xi Ruoyao <xry111@xry111.site>
>
> commit f24f669d03f884a6ef95cca84317d0f329e93961 upstream.
>
> Per the "Processor Specification Update" documentations referred by
> the intel-microcode-20240312 release note, this microcode release has
> fixed the issue for all affected models.
>
> So don't disable PCID if the microcode is new enough.  The precise
> minimum microcode revision fixing the issue was provided by Pawan
> Intel.
>
> [ dhansen: comment and changelog tweaks ]
> [ pawan: backported to 6.6 ]
>
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Acked-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Link: https://lore.kernel.org/all/168436059559.404.13934972543631851306.tip-bot2@tip-bot2/
> Link: https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20240312
> Link: https://cdrdv2.intel.com/v1/dl/getContent/740518 # RPL042, rev. 13
> Link: https://cdrdv2.intel.com/v1/dl/getContent/682436 # ADL063, rev. 24
> Link: https://lore.kernel.org/all/20240325231300.qrltbzf6twm43ftb@desk/
> Link: https://lore.kernel.org/all/20240522020625.69418-1-xry111%40xry111.site
> ---
> arch/x86/mm/init.c | 23 ++++++++++++++---------
> 1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index 6215dfa23578..71d29dd7ad76 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -262,28 +262,33 @@ static void __init probe_page_size_mask(void)
> }
>
> /*
> - * INVLPG may not properly flush Global entries
> - * on these CPUs when PCIDs are enabled.
> + * INVLPG may not properly flush Global entries on
> + * these CPUs.  New microcode fixes the issue.
>  */
> static const struct x86_cpu_id invlpg_miss_ids[] = {
> -	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,      0),
> -	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,    0),
> -	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT, 0),
> -	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,     0),
> -	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,   0),
> -	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,   0),
> +	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,      0x2e),
> +	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,    0x42c),
> +	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT, 0x11),
> +	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,     0x118),
> +	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,   0x4117),
> +	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,   0x2e),
> 	{}
> };
>
> static void setup_pcid(void)
> {
> +	const struct x86_cpu_id *invlpg_miss_match;
> +
> 	if (!IS_ENABLED(CONFIG_X86_64))
> 		return;
>
> 	if (!boot_cpu_has(X86_FEATURE_PCID))
> 		return;
>
> -	if (x86_match_cpu(invlpg_miss_ids)) {
> +	invlpg_miss_match = x86_match_cpu(invlpg_miss_ids);
> +
> +	if (invlpg_miss_match &&
> +	    boot_cpu_data.microcode < invlpg_miss_match->driver_data) {
> 		pr_info("Incomplete global flushes, disabling PCID");
> 		setup_clear_cpu_cap(X86_FEATURE_PCID);
> 		return;
>

       Thomas

-- 
  Thomas V


