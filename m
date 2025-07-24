Return-Path: <stable+bounces-164654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EDAB11095
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 19:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79DE188B68D
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 17:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B3C2EBDE0;
	Thu, 24 Jul 2025 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="eP3q+ggL"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFCB2E427D;
	Thu, 24 Jul 2025 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753379950; cv=none; b=CrrKNFoNClP/5cGA3J5R4vc19SoVUl5rlr0kuAFG4NFjITOQ2Oyg4TJI7iKgKEKOtdCKR+r8zeSQ1E3B1dzbCAAc2sSqjeits6hgXaGKO8fUZmsIwZXeD+3k377LuiB7/ZgZElkMsM6Lq9DKCXJLgnWJ0vkGm3QAmIcWLddzYHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753379950; c=relaxed/simple;
	bh=1gn4ejENpNBYFDhhYupubr3K+z/QZF3AGVC6dEy8TUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZpqlcyljeuF6y5Yv/denoZ3qtt18UTvssuwog7hwoSfSEsQrQ0OlfEt4eHT+aF6eHyJGgQp+rTa0FcvGuN7V0sn8/RbOSNGaA8zDWr1spF10e9ZPYco0emgXWisQc6w2AyJsXRwCnq/VaLJ6J06oD6YTkrFCUx3ToU0mPr5TYeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=eP3q+ggL; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56OHw7XB1944424
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 24 Jul 2025 10:58:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56OHw7XB1944424
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025072201; t=1753379888;
	bh=eEzOHCEJJZx0Hlut/oEubc76oXo6S4Lrup4+/h3LqJ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eP3q+ggLdGrDbHyTK05IpiMJJ8fktH4aGBJmtzOLa6vyWzmaO30a5Q6TSMqLhCXQ+
	 nZGKm75ZTvWM/PccwhDTdDIC9bLPKyQ48CWOKVZFHA5SBwhCpHWVjr1XzsZODZIHHU
	 7Ar7NnZRJiXg2R8aQtvjlMSx3lrYb2nBahTNS0Le4BMk38Bdpc7HwksdgR43zuRYxY
	 VKyiGp+l4ja8towf/k3r4VhMt43tl42+nqNWS09CrpdY2lKdNenJdTZSao2WEDiB9z
	 un25ZgT9GpRXRtTG+fvDTzcGbk6TgaYl01cnOMNPZD+14TJTM503qZDaIojYGn58dc
	 WrSGlhDqsFK3w==
Message-ID: <e009fd66-420c-4ad6-a68b-9293345d9a8e@zytor.com>
Date: Thu, 24 Jul 2025 10:58:06 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] x86: Clear feature bits disabled at compile-time
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc: xin3.li@intel.com, Farrah Chen <farrah.chen@intel.com>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        linux-kernel@vger.kernel.org
References: <20250724125346.2792543-1-maciej.wieczor-retman@intel.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20250724125346.2792543-1-maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/2025 5:53 AM, Maciej Wieczor-Retman wrote:
> If some config options are disabled during compile time, they still are
> enumerated in macros that use the x86_capability bitmask - cpu_has() or
> this_cpu_has().
> 
> The features are also visible in /proc/cpuinfo even though they are not
> enabled - which is contrary to what the documentation states about the
> file. Examples of such feature flags are lam, fred, sgx, ibrs_enhanced,
> split_lock_detect, user_shstk, avx_vnni and enqcmd.
> 
> Add a DISABLED_MASK_INITIALIZER macro that creates an initializer list
> filled with DISABLED_MASKx bitmasks.
> 
> Initialize the cpu_caps_cleared array with the autogenerated disabled
> bitmask.

It's worth appending:

And apply_forced_caps() will clear the corresponding bits in 
boot_cpu_data.x86_capability[] and APs' cpu_data.x86_capability[].
Thus features disabled at build time won't show up in /proc/cpuinfo.

> 
> Fixes: ea4e3bef4c94 ("Documentation/x86: Add documentation for /proc/cpuinfo feature flags")
> Reported-by: Farrah Chen <farrah.chen@intel.com>
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> Cc: <stable@vger.kernel.org>
> ---
> Changelog v4:
> - Fix macro name to match with the patch message.
> - Add Peter's SoB.
> 
> Changelog v3:
> - Remove Fixes: tags, keep only one at the point where the documentation
>    changed and promised feature bits wouldn't show up if they're not
>    enabled.
> - Don't use a helper to initialize cpu_caps_cleared, just statically
>    initialize it.
> - Remove changes to cpu_caps_set.
> - Rewrite patch message to account for changes.
> 
> Changelog v2:
> - Redo the patch to utilize a more generic solution, not just fix the
>    LAM and FRED feature bits.
> - Note more feature flags that shouldn't be present.
> - Add fixes and cc tags.
> 
>   arch/x86/kernel/cpu/common.c       | 3 ++-
>   arch/x86/tools/cpufeaturemasks.awk | 6 ++++++
>   2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 77afca95cced..a9040038ad9d 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -704,7 +704,8 @@ static const char *table_lookup_model(struct cpuinfo_x86 *c)
>   }
>   
>   /* Aligned to unsigned long to avoid split lock in atomic bitmap ops */
> -__u32 cpu_caps_cleared[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long));
> +__u32 cpu_caps_cleared[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long)) =
> +	DISABLED_MASK_INITIALIZER;
>   __u32 cpu_caps_set[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long));
>   
>   #ifdef CONFIG_X86_32
> diff --git a/arch/x86/tools/cpufeaturemasks.awk b/arch/x86/tools/cpufeaturemasks.awk
> index 173d5bf2d999..1eabbc69f50d 100755
> --- a/arch/x86/tools/cpufeaturemasks.awk
> +++ b/arch/x86/tools/cpufeaturemasks.awk
> @@ -84,5 +84,11 @@ END {
>   		printf "\t) & (1U << ((x) & 31)))\n\n";
>   	}
>   
> +		printf "\n#define DISABLED_MASK_INITIALIZER\t\t\t\\";
> +		printf "\n\t{\t\t\t\t\t\t\\";
> +		for (i = 0; i < ncapints; i++)
> +			printf "\n\t\tDISABLED_MASK%d,\t\t\t\\", i;
> +		printf "\n\t}\n\n";
> +

The indentation is incorrect.

And I think it's no harm to generate both REQUIRED_MASK_INITIALIZER and
DISABLED_MASK_INITIALIZER, so you can put this new code block inside the
above

	for (ns in sets) {
		...
	}

loop.

>   	printf "#endif /* _ASM_X86_CPUFEATUREMASKS_H */\n";
>   }

