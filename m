Return-Path: <stable+bounces-57908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8DA925EE5
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FAB12A4447
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E001176ADE;
	Wed,  3 Jul 2024 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="brKdN12S"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B692174EF3
	for <stable@vger.kernel.org>; Wed,  3 Jul 2024 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720006756; cv=none; b=LOvb4oJP0/gBYYR+8qsBNst0iJlgHUwWeO/tEhD5+nCkZqxiJmjs/U5q66acVZ7gFhMTb2+j0U7l8kMiZWiuI7nGX4s49Xw9ySmkSXTfiuZW/Aod23bNIx5/vyEBxixBilFxesKCgfn64tE/FPSqlLj9Hgsw8LUlIG8u08U5nBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720006756; c=relaxed/simple;
	bh=xM+Xs/O0bLLEev58CiCCL/RgCfgNjFzsbVPVrcEZ8M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XED9nSnxcu2alVuQhnfbW5JBZaRzN+0s8xXpsrrVLCuyG1hG4UAo4PcgnedQ4YtZqFruo1ocWygeBTaVPg46voDsjmjEqo/YWo8rBz4GM4QVWTwbS8+hib70DPJgbNmw+6FdBfA4uY7k81uj9qx16qiYdkOsZQK4LKuuIkBBdeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=brKdN12S; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-36796bbf687so149224f8f.0
        for <stable@vger.kernel.org>; Wed, 03 Jul 2024 04:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720006752; x=1720611552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H9Mr0geIZFa+syumwo+K6Slsk1HPoK/hxQsISbhV0KQ=;
        b=brKdN12SNYXMNwXyNyEHNL+0emoJCTxSMVWpDhwrLbnKUBgH6M9sT2brHqv7AOyltm
         9saJWuw/1AqLu/CVtISmi/cWGBbZ5cQxn6s2G8sZIrrou3QgaH1zlt2caY9Q8ggbB9lC
         PCXvTh6oWX7PDruZwiBIJlg7ukLWRKmSVAw+7CuAvvoovPnA7QtjAqsIEY04A6FUvIQ5
         WEQ5EFfqDiogNwUsQjtgxr7GW31XFm01LOnWidVjUNdBHeKMN0ilCNDJYYy7iB3okdvV
         tQaxzHLPwYxRtJsjR6hNFLG+QIHdGo4Xca37LJG622UNODhNa8GX1QQGDsdMzPeuhHNX
         8s3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720006752; x=1720611552;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H9Mr0geIZFa+syumwo+K6Slsk1HPoK/hxQsISbhV0KQ=;
        b=i+04CfeGQOF1b/sJ/muXIjD/1uN7xU8CJoVJJivtDXeEvgsa0ylTkeOFbgZ3+7C4gd
         nCTQHYuXL0F+qahS3dKWgCpCNYFgGYf10J9iY8mKTpE/e4Usrmq4Zj5YRygUGaIGoPAj
         0j7t31QYK7Bf7vdgyKkG15Vpb2jBNjMECkq/lKiQ42DSC136TPhas7lgR5dY/gIY+M2F
         g9tKzDKH5pFNkbehqz4duwMUzSV9T0iQaWY9bvOkMouMUPvXkY7q7l4mXsf9UX1ycipn
         6X5Qq4/FnAXPBKs1jWvUbcJDv7HzzrkbtN9shHCRigY9X6rlFctPGR/OwGx8jJd5Ybme
         wC9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUF4baQyzzG2g4fZXDqVlPSXsalLqxLyg2LbMymW4wDuMJqxAZG8SAQ78oKjTQ3s4wxyyiilhsKxTaQ3iSP5DpjaAfROawc
X-Gm-Message-State: AOJu0Yw93r489NhAq2TVy7NU8OymN+wn9+6AlJbaz8euwHpxyZpgv8wo
	ocN2kKG6jghMUjok3mbFxsSAk6JhxCW+0xwGXVr9X5quByjp778cl1kXnMSGucI=
X-Google-Smtp-Source: AGHT+IF9bUonTx6Qi/+WkiXqdze4hvoZYrS0c+X5zrYn9/a52y1TrmwyPD7ieagysH13jDZunzhpDQ==
X-Received: by 2002:a5d:6b8e:0:b0:367:9769:35a5 with SMTP id ffacd0b85a97d-36797693993mr271738f8f.7.1720006751689;
        Wed, 03 Jul 2024 04:39:11 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:757f:69b1:bdb0:82db:8b8b? ([2a10:bac0:b000:757f:69b1:bdb0:82db:8b8b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fb92fsm15784226f8f.88.2024.07.03.04.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 04:39:11 -0700 (PDT)
Message-ID: <05d0b24a-2e21-48c0-85b7-a9dd935ac449@suse.com>
Date: Wed, 3 Jul 2024 14:39:09 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 3/4] x86/tdx: Dynamically disable SEPT violations from
 causing #VEs
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240624114149.377492-1-kirill.shutemov@linux.intel.com>
 <20240624114149.377492-4-kirill.shutemov@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240624114149.377492-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 24.06.24 г. 14:41 ч., Kirill A. Shutemov wrote:
> Memory access #VE's are hard for Linux to handle in contexts like the
> entry code or NMIs.  But other OSes need them for functionality.
> There's a static (pre-guest-boot) way for a VMM to choose one or the
> other.  But VMMs don't always know which OS they are booting, so they
> choose to deliver those #VE's so the "other" OSes will work.  That,
> unfortunately has left us in the lurch and exposed to these
> hard-to-handle #VEs.
> 
> The TDX module has introduced a new feature.  Even if the static
> configuration is "send nasty #VE's", the kernel can dynamically request
> that they be disabled.
> 
> Check if the feature is available and disable SEPT #VE if possible.
> 
> If the TD allowed to disable/enable SEPT #VEs, the ATTR_SEPT_VE_DISABLE
> attribute is no longer reliable. It reflects the initial state of the
> control for the TD, but it will not be updated if someone (e.g. bootloader)
> changes it before the kernel starts. Kernel must check TDCS_TD_CTLS bit to
> determine if SEPT #VEs are enabled or disabled.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: 373e715e31bf ("x86/tdx: Panic on bad configs that #VE on "private" memory access")
> Cc: stable@vger.kernel.org
> ---
>   arch/x86/coco/tdx/tdx.c           | 76 ++++++++++++++++++++++++-------
>   arch/x86/include/asm/shared/tdx.h | 10 +++-
>   2 files changed, 69 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 08ce488b54d0..ba3103877b21 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -78,7 +78,7 @@ static inline void tdcall(u64 fn, struct tdx_module_args *args)
>   }
>   
>   /* Read TD-scoped metadata */
> -static inline u64 __maybe_unused tdg_vm_rd(u64 field, u64 *value)
> +static inline u64 tdg_vm_rd(u64 field, u64 *value)
>   {
>   	struct tdx_module_args args = {
>   		.rdx = field,
> @@ -193,6 +193,62 @@ static void __noreturn tdx_panic(const char *msg)
>   		__tdx_hypercall(&args);
>   }
>   
> +/*
> + * The kernel cannot handle #VEs when accessing normal kernel memory. Ensure
> + * that no #VE will be delivered for accesses to TD-private memory.
> + *
> + * TDX 1.0 does not allow the guest to disable SEPT #VE on its own. The VMM
> + * controls if the guest will receive such #VE with TD attribute
> + * ATTR_SEPT_VE_DISABLE.
> + *
> + * Newer TDX module allows the guest to control if it wants to receive SEPT
> + * violation #VEs.
> + *
> + * Check if the feature is available and disable SEPT #VE if possible.
> + *
> + * If the TD allowed to disable/enable SEPT #VEs, the ATTR_SEPT_VE_DISABLE
> + * attribute is no longer reliable. It reflects the initial state of the
> + * control for the TD, but it will not be updated if someone (e.g. bootloader)
> + * changes it before the kernel starts. Kernel must check TDCS_TD_CTLS bit to
> + * determine if SEPT #VEs are enabled or disabled.
> + */
> +static void disable_sept_ve(u64 td_attr)
> +{
> +	const char *msg = "TD misconfiguration: SEPT #VE has to be disabled";
> +	bool debug = td_attr & ATTR_DEBUG;
> +	u64 config, controls;
> +
> +	/* Is this TD allowed to disable SEPT #VE */
> +	tdg_vm_rd(TDCS_CONFIG_FLAGS, &config);
> +	if (!(config & TDCS_CONFIG_FLEXIBLE_PENDING_VE)) {
> +		/* No SEPT #VE controls for the guest: check the attribute */
> +		if (td_attr & ATTR_SEPT_VE_DISABLE)
> +			return;
> +
> +		/* Relax SEPT_VE_DISABLE check for debug TD for backtraces */
> +		if (debug)
> +			pr_warn("%s\n", msg);
> +		else
> +			tdx_panic(msg);
> +		return;
> +	}
> +
> +	/* Check if SEPT #VE has been disabled before us */
> +	tdg_vm_rd(TDCS_TD_CTLS, &controls);
> +	if (controls & TD_CTLS_PENDING_VE_DISABLE)
> +		return;
> +
> +	/* Keep #VEs enabled for splats in debugging environments */
> +	if (debug)
> +		return;
> +
> +	/* Disable SEPT #VEs */
> +	tdg_vm_wr(TDCS_TD_CTLS, TD_CTLS_PENDING_VE_DISABLE,
> +		  TD_CTLS_PENDING_VE_DISABLE);
> +
> +	return;
> +}
> +
>   static void tdx_setup(u64 *cc_mask)
>   {
>   	struct tdx_module_args args = {};
> @@ -218,24 +274,12 @@ static void tdx_setup(u64 *cc_mask)
>   	gpa_width = args.rcx & GENMASK(5, 0);
>   	*cc_mask = BIT_ULL(gpa_width - 1);
>   
> +	td_attr = args.rdx;
> +
>   	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
>   	tdg_vm_wr(TDCS_NOTIFY_ENABLES, 0, -1ULL);
>   
> -	/*
> -	 * The kernel can not handle #VE's when accessing normal kernel
> -	 * memory.  Ensure that no #VE will be delivered for accesses to
> -	 * TD-private memory.  Only VMM-shared memory (MMIO) will #VE.
> -	 */
> -	td_attr = args.rdx;
> -	if (!(td_attr & ATTR_SEPT_VE_DISABLE)) {
> -		const char *msg = "TD misconfiguration: SEPT_VE_DISABLE attribute must be set.";
> -
> -		/* Relax SEPT_VE_DISABLE check for debug TD. */
> -		if (td_attr & ATTR_DEBUG)
> -			pr_warn("%s\n", msg);
> -		else
> -			tdx_panic(msg);
> -	}
> +	disable_sept_ve(td_attr);
>   }
>   
>   /*
> diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
> index 7e12cfa28bec..fecb2a6e864b 100644
> --- a/arch/x86/include/asm/shared/tdx.h
> +++ b/arch/x86/include/asm/shared/tdx.h
> @@ -19,9 +19,17 @@
>   #define TDG_VM_RD			7
>   #define TDG_VM_WR			8
>   
> -/* TDCS fields. To be used by TDG.VM.WR and TDG.VM.RD module calls */
> +/* TDX TD-Scope Metadata. To be used by TDG.VM.WR and TDG.VM.RD */
> +#define TDCS_CONFIG_FLAGS		0x1110000300000016
0x9110000300000016
> +#define TDCS_TD_CTLS			0x1110000300000017
0x9110000300000017
>   #define TDCS_NOTIFY_ENABLES		0x9100000000000010
>   
> +/* TDCS_CONFIG_FLAGS bits */
> +#define TDCS_CONFIG_FLEXIBLE_PENDING_VE	BIT_ULL(1)
> +
> +/* TDCS_TD_CTLS bits */
> +#define TD_CTLS_PENDING_VE_DISABLE	BIT_ULL(0)
> +
>   /* TDX hypercall Leaf IDs */
>   #define TDVMCALL_MAP_GPA		0x10001
>   #define TDVMCALL_GET_QUOTE		0x10002

