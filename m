Return-Path: <stable+bounces-127286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0CBA7743A
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 07:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF3D168B5B
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 05:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE5F53AC;
	Tue,  1 Apr 2025 05:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IWkaayUf"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FF7132103
	for <stable@vger.kernel.org>; Tue,  1 Apr 2025 05:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743487070; cv=none; b=IVeeRWfUZroj2Kd0TldTXyEfjtCIUJcrRZjdOOr4p+0Mgx17s93rj5zRD5a5b6ow2elMqTOdE/qmpA1KUiVp+bMwUs2C1wf/8NscJG56PLAXv6k/Lvok7drxcJt1Rb6UkrmuVM/gaG4piWkZVk4WamtE6BUmzy2UkSes9JuXBJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743487070; c=relaxed/simple;
	bh=Tg8NE179pIoKTkYxqXdaqoZpP1MRgabt/Ct3QXaY8tU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f3UHlaHELHvWMX9vsgp8fVVU4BfEESBfmdpgdsE5+CeULBjbP/6EbMsOYTt4kuguPr0ZdjxRGTC11W6CCh/S1YaJlxY4Xk5pogtI+2MzszhMoIlx/zYZm2KgwTFmU4P5pGaD8m//n/OziFQu9TE3iLb/4GSJTWSmj7RlyboTYFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IWkaayUf; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abbb12bea54so1067585666b.0
        for <stable@vger.kernel.org>; Mon, 31 Mar 2025 22:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743487066; x=1744091866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lccw6A9vzMJ6BKh7gXq9qnm3AIfT4fRlC/uJQrdTuVc=;
        b=IWkaayUf7K+nJjIT5tcIudK2UPmU5lvfiJBFf796/Yq/fYUJKemQGqvA5bvM4ZMA4/
         OBkGc4Hn3/181wMUPltDWO4dvHtn1x4AjdSsrY2etzR0nBvwf7KgeYHqSAj6VGERBYRA
         gN87Xn6eQ8by43PU+Kk68pUdy88q8qWnsNAd1eg1WYLL4mU+rLUpsKg6Pel3d+9tguyF
         T5qSqXXwjVkdujDfKSzOb/snJOPgJ3NOck5ccj/SppMSt3agbEuDmpIxz0sxRk02uc0s
         CMpCWg13mMQBzuRdUQ95qNYMc5PADeA1/ACnrieAO1BpXePpcr/MSxgT+O1Y49g/UZyd
         by0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743487066; x=1744091866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lccw6A9vzMJ6BKh7gXq9qnm3AIfT4fRlC/uJQrdTuVc=;
        b=E6xDb2q9JZe9mzYHaEKWGeppeLcg8Tr6QCGz9WBpYa1yNYw1qBd98XoSVEwAbWCbmZ
         D6HDlW+ZebCKtPE6mwj0wOARM9CXXIEhLnvoLjXBiUG5uQqL7Ot6qfG735YQuSdOtlr0
         EkLk/osqNzJEv+tWVmhs5TBNN4xU2nNkxXGZRj6l+5lKH1PjBUq2UBXkFLXjuN6rkOqj
         NpKo/CSeP7o41tkTUBj4w/6hAp63XryfV5f3hnYMB75nK7CgaqZUht3AUg1erwfdhcC2
         vfAb2If2mMBHCfMjOSTgpN2KWxBQBRJQF75P9lqUUy2GYuMpqpS/TGlTP3b5toEfGuQ4
         PtIg==
X-Forwarded-Encrypted: i=1; AJvYcCWDYM0nnUWwppkhX9hOCLE2exaOmX/VPBPPu9nHcrF97jG6XF8/wGuI5btlPfAw26NSrj0SgqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2qeTaYXX6wcgB+Ks0cKG2DhQpub8nILVL6BMqI5mwUYwgTWdM
	f6jTFLbqVXs2+bk0yFp3SRpunS3wZnP7fIyElXUX8BdM1yFML4z3r4QaCkmyZqw=
X-Gm-Gg: ASbGnct5/fd0ZT+Jqjh04oqliF8lP7u1+f38xakaqnBWDw/VEClY9ptBF/iMHjv7d9v
	lKfRUz9lMvo8JH/HMPaPiMS7fkvtfcWkyVQu/3dt1RA1dqZcXF6MpKoLTQLw2w605ej5ovouz5A
	uMRNkuO09mVUOAtZrbf2UH5a/gJj06C5ldrf8FjaJ4My1oQ3nmn79htbSYtKsefSdg522mxIElP
	mztsm1G4Kf/9ReBG/RIGtps/5t1/hhqR/OTrKMTdsfig/pZsorFOeuv4DvrAZeKV7Qoz+B1ZBsf
	O7/JOSPgoyo93HJQIov6lois1j/D0R5VOf5Y/UIiZ5YI4iXOTQ==
X-Google-Smtp-Source: AGHT+IEvjpcJpp5uC9FTtLHiwqjKE2oXvU4sQc9FlSK9mFcbcVYySdPLAbEWl4XwZWiv4tvHpzpGlQ==
X-Received: by 2002:a17:907:c920:b0:ac3:bbc8:ecab with SMTP id a640c23a62f3a-ac738a151e3mr799397666b.11.1743487065692;
        Mon, 31 Mar 2025 22:57:45 -0700 (PDT)
Received: from [192.168.0.20] ([212.21.159.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71927b21fsm720158866b.71.2025.03.31.22.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 22:57:45 -0700 (PDT)
Message-ID: <7ed9418b-db12-4678-bf7a-634daf66282d@suse.com>
Date: Tue, 1 Apr 2025 08:57:44 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/ioremap: Maintain consistent IORES_MAP_ENCRYPTED for
 BIOS data
To: Dan Williams <dan.j.williams@intel.com>, dave.hansen@linux.intel.com
Cc: x86@kernel.org, Vishal Annapurve <vannapurve@google.com>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>, stable@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <174346288005.2166708.14425674491111625620.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <174346288005.2166708.14425674491111625620.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1.04.25 г. 2:14 ч., Dan Williams wrote:
> Nikolay reports [1] that accessing BIOS data (first 1MB of the physical
> address space) via /dev/mem results in an SEPT violation.
> 
> The cause is ioremap() (via xlate_dev_mem_ptr()) establishing an
> unencrypted mapping where the kernel had established an encrypted
> mapping previously.
> 
> Teach __ioremap_check_other() that this address space shall always be
> mapped as encrypted as historically it is memory resident data, not MMIO
> with side-effects.
> 
> Cc: <x86@kernel.org>
> Cc: Vishal Annapurve <vannapurve@google.com>
> Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: Nikolay Borisov <nik.borisov@suse.com>
> Closes: http://lore.kernel.org/20250318113604.297726-1-nik.borisov@suse.com [1]
> Tested-by: Nikolay Borisov <nik.borisov@suse.com>
> Fixes: 9aa6ea69852c ("x86/tdx: Make pages shared in ioremap()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

> ---
>   arch/x86/mm/ioremap.c |    4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 42c90b420773..9e81286a631e 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -122,6 +122,10 @@ static void __ioremap_check_other(resource_size_t addr, struct ioremap_desc *des
>   		return;
>   	}
>   
> +	/* Ensure BIOS data (see devmem_is_allowed()) is consistently mapped */
> +	if (PHYS_PFN(addr) < 256)
> +		desc->flags |= IORES_MAP_ENCRYPTED;

Side question: Is it guaranteed that this region will be mapped with 4k 
pages and not some larger size? I.e should the 256 constant be dependent 
on the current page size?

> +
>   	if (!IS_ENABLED(CONFIG_EFI))
>   		return;
>   
> 


