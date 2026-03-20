Return-Path: <stable+bounces-227433-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PqXG+bHvGlS2wIAu9opvQ
	(envelope-from <stable+bounces-227433-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 05:07:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CC32D5B4F
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 05:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18AC7300A502
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 04:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035372D5C74;
	Fri, 20 Mar 2026 04:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLp6M1hg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CAF2D0C7E
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 04:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773979617; cv=none; b=Wq04ePWMGA0dVxnK6jwbRwXqzBPPpHF8sdD3YxQ1SeexeyUhayJrPlhikdB+BVHMyd2dy/sy3CpDViFVjCajX36gg2iNgxIq4BwT7JQ+xQL+AepW4WaD7NNfKk2VcvKx19/45hRuLjLf4qZMFCocIt6oGrywMMI7CpM5WhT6ijo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773979617; c=relaxed/simple;
	bh=RFioRWZ3eq8wc0ErrSkCtZOyQdTf4WqNRA36GtmIKuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kww+kkTNFtH+ly0NKI0tyB37sIqBCOcPZ//avhVpJZN8q11OI490tRDuXD9YFCnYhl/92/7Gx10jTKuF1LxPVnzL26xMbhdAlU03anP0LaEbn3JLpSEqfunavLPskqzx6mwgnUCO/j8zfIJs7hUPb4ktRlme7JWrBO1V12rW1Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLp6M1hg; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82735a41920so701092b3a.2
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 21:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773979615; x=1774584415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=grz9eWJ1ps3EBDuJN2bzyVHKIzdPvtiDT74qagFiumU=;
        b=KLp6M1hgpC/l5WjXPjezZ4qApxvUirp0cLPpwNJ/cQpYkukeVX5qCeC1eg4tRNozWk
         JdfhJPEYERx043wwjblQhBfHJfpShpIlTIzhHUIva+ystiVt2yM9eGap4Cyjbu4C47Iy
         knNgDiUDxuVY10vpGeV+FT6GTsu/JSqNCDS27QNHReuahyla7IvY5e8UPYYaDR65XYEK
         GG1fnH0lyG8jaEffpKgqUClzDAcK0wO8DThEMnjQJ4LsTtvf2UAysRcnRc2E2O2/iyra
         1QsMK+jG6guYv+T/iyr1mCndrBJGTHZOMkbKXf0ml23lnPqBF8VB5I53IZqab9gFrfss
         bNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773979615; x=1774584415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=grz9eWJ1ps3EBDuJN2bzyVHKIzdPvtiDT74qagFiumU=;
        b=lfhTxPm7ZuOm/gW6snHUsuJyKNGlyzZIoHDODYqerU8q5+LyaRXNPDRrCe6mSvMBOM
         xPu+l4aJicRDwM6A7KnojkFobTD8fFt9KZPZ2SdFC8i1GGpdKpHKEkAu2YaG4Ktzyudu
         bVa5qGBi6fS9guts5fxNIUrXFqild1jYELWe3Wnl5Aean7uKNw0FbHfAWMit3jdIvb4d
         AhaHy8/zRf2G5sz159IOxACsCsFWmDVDjbAsKh1JkWBafE6sJV+Zu8csFKjZ08SqCDiN
         jbbdNXMw3t8vIRh8Xllgj3c52THinCmZojP3hrHrsoL/y3mUr8rUnB0JTStOBdzQMrdv
         eyjA==
X-Forwarded-Encrypted: i=1; AJvYcCXfrGHo7va/URdFsnr1b6ACngCugJELoYEbtXyFb3UGdOEv/eBpVxai8PiXVxhJkNR0Fjlti9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSNICDZVKEassVL0O2WJECcDFVICkcXdq4RDTpYTclCYy832cy
	DbJX55sWXpTaNAyVNcsjfztXYh6cGD1f/8GvRrtVvTClXCxJdVMJCSxJ
X-Gm-Gg: ATEYQzwUEWzlTT/0xONM3tREUWQHA2Lw7IIk+XiU2Mcwrus7hOFEDve59lrpAtMnwLe
	mxcSz4DUmwrAhjiZOGq7ZNPSwEDfiPo8s7YUGs8zIN7IAoOtrDJoRyNQuRr0Ztk89ZlsRZH+qjp
	c4izd6Qbc8okfTMN+2jQ8lnd6fa36FMMydRCBS0u13DuO68+F1s/iNK6ldLsf7+B9JlqokBrKQ8
	4khSxKfr45LjWHqvP/Ka3vrQv+JT0M4DaXP9AeNNCvIMRMvP3zAFHA3LuPwcUoaSreMyL11lBK+
	869RS4q5DPzm2ZbMyZmTW1QjedeWCDQO71UNG7C439u2yH8BKT/CKmUaDQp1MmAjMo6SHMCdyNQ
	eek4NPc6xSlRmMdhIvP/qLfaHjN4xczW/9dHZtSTKG3c9EnNkpsJZATXu3nj3FmvpFFOyrPngAO
	BOoKObhwxzYHrsw4nI5LKwZ4lTubxEqoOB4+fB
X-Received: by 2002:a05:6a20:7f8d:b0:398:71e4:6282 with SMTP id adf61e73a8af0-39bce9b7e04mr1530953637.4.1773979614683;
        Thu, 19 Mar 2026 21:06:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c74443ccb56sm650198a12.25.2026.03.19.21.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 21:06:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 19 Mar 2026 21:06:52 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Mike Rapoport <rppt@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@kernel.org>, linux-efi@vger.kernel.org,
	linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] x86/efi: defer freeing of boot services memory
Message-ID: <100b9ae1-74cc-48b3-ba63-1a72cfa2ebbd@roeck-us.net>
References: <20260225065555.2471844-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225065555.2471844-1-rppt@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227433-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	DMARC_NA(0.00)[roeck-us.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,roeck-us.net:mid]
X-Rspamd-Queue-Id: 30CC32D5B4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Wed, Feb 25, 2026 at 08:55:55AM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> efi_free_boot_services() frees memory occupied by EFI_BOOT_SERVICES_CODE
> and EFI_BOOT_SERVICES_DATA using memblock_free_late().
> 
> There are two issue with that: memblock_free_late() should be used for
> memory allocated with memblock_alloc() while the memory reserved with
> memblock_reserve() should be freed with free_reserved_area().
> 
> More acutely, with CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
> efi_free_boot_services() is called before deferred initialization of the
> memory map is complete.
> 
> Benjamin Herrenschmidt reports that this causes a leak of ~140MB of
> RAM on EC2 t3a.nano instances which only have 512MB or RAM.
> 
> If the freed memory resides in the areas that memory map for them is
> still uninitialized, they won't be actually freed because
> memblock_free_late() calls memblock_free_pages() and the latter skips
> uninitialized pages.
> 
> Using free_reserved_area() at this point is also problematic because
> __free_page() accesses the buddy of the freed page and that again might
> end up in uninitialized part of the memory map.
> 
> Delaying the entire efi_free_boot_services() could be problematic
> because in addition to freeing boot services memory it updates
> efi.memmap without any synchronization and that's undesirable late in
> boot when there is concurrency.
> 
> More robust approach is to only defer freeing of the EFI boot services
> memory.
> 
> Split efi_free_boot_services() in two. First efi_unmap_boot_services()
> collects ranges that should be freed into an array then
> efi_free_boot_services() later frees them after deferred init is complete.
> 
> Link: https://lore.kernel.org/all/ec2aaef14783869b3be6e3c253b2dcbf67dbc12a.camel@kernel.crashing.org
> Fixes: 916f676f8dc0 ("x86, efi: Retain boot service code until after switching to virtual mode")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> v1: https://lore.kernel.org/all/20260223075219.2348035-1-rppt@kernel.org
> * update the commit message with correct function names (Ben)
> 
>  arch/x86/include/asm/efi.h          |  2 +-
>  arch/x86/platform/efi/efi.c         |  2 +-
>  arch/x86/platform/efi/quirks.c      | 55 +++++++++++++++++++++++++++--
>  drivers/firmware/efi/mokvar-table.c |  2 +-
>  4 files changed, 55 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> index f227a70ac91f..51b4cdbea061 100644
> --- a/arch/x86/include/asm/efi.h
> +++ b/arch/x86/include/asm/efi.h
> @@ -138,7 +138,7 @@ extern void __init efi_apply_memmap_quirks(void);
>  extern int __init efi_reuse_config(u64 tables, int nr_tables);
>  extern void efi_delete_dummy_variable(void);
>  extern void efi_crash_gracefully_on_page_fault(unsigned long phys_addr);
> -extern void efi_free_boot_services(void);
> +extern void efi_unmap_boot_services(void);
>  
>  void arch_efi_call_virt_setup(void);
>  void arch_efi_call_virt_teardown(void);
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index d00c6de7f3b7..d84c6020dda1 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -836,7 +836,7 @@ static void __init __efi_enter_virtual_mode(void)
>  	}
>  
>  	efi_check_for_embedded_firmwares();
> -	efi_free_boot_services();
> +	efi_unmap_boot_services();
>  
>  	if (!efi_is_mixed())
>  		efi_native_runtime_setup();
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index 553f330198f2..35caa5746115 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -341,7 +341,7 @@ void __init efi_reserve_boot_services(void)
>  
>  		/*
>  		 * Because the following memblock_reserve() is paired
> -		 * with memblock_free_late() for this region in
> +		 * with free_reserved_area() for this region in
>  		 * efi_free_boot_services(), we must be extremely
>  		 * careful not to reserve, and subsequently free,
>  		 * critical regions of memory (like the kernel image) or
> @@ -404,17 +404,33 @@ static void __init efi_unmap_pages(efi_memory_desc_t *md)
>  		pr_err("Failed to unmap VA mapping for 0x%llx\n", va);
>  }
>  
> -void __init efi_free_boot_services(void)
> +struct efi_freeable_range {
> +	u64 start;
> +	u64 end;
> +};
> +
> +static struct efi_freeable_range *ranges_to_free;
> +
> +void __init efi_unmap_boot_services(void)
>  {
>  	struct efi_memory_map_data data = { 0 };
>  	efi_memory_desc_t *md;
>  	int num_entries = 0;
> +	int idx = 0;
> +	size_t sz;
>  	void *new, *new_md;
>  
>  	/* Keep all regions for /sys/kernel/debug/efi */
>  	if (efi_enabled(EFI_DBG))
>  		return;
>  
> +	sz = sizeof(*ranges_to_free) * efi.memmap.nr_map + 1;

Was this possibly supposed to be
	sz = sizeof(*ranges_to_free) * (efi.memmap.nr_map + 1);
				       ^		     ^
?

Thanks,
Guenter

> +	ranges_to_free = kzalloc(sz, GFP_KERNEL);
> +	if (!ranges_to_free) {
> +		pr_err("Failed to allocate storage for freeable EFI regions\n");
> +		return;
> +	}
> +
>  	for_each_efi_memory_desc(md) {
>  		unsigned long long start = md->phys_addr;
>  		unsigned long long size = md->num_pages << EFI_PAGE_SHIFT;
> @@ -471,7 +487,15 @@ void __init efi_free_boot_services(void)
>  			start = SZ_1M;
>  		}
>  
> -		memblock_free_late(start, size);
> +		/*
> +		 * With CONFIG_DEFERRED_STRUCT_PAGE_INIT parts of the memory
> +		 * map are still not initialized and we can't reliably free
> +		 * memory here.
> +		 * Queue the ranges to free at a later point.
> +		 */
> +		ranges_to_free[idx].start = start;
> +		ranges_to_free[idx].end = start + size;
> +		idx++;
>  	}
>  
>  	if (!num_entries)
> @@ -512,6 +536,31 @@ void __init efi_free_boot_services(void)
>  	}
>  }
>  
> +static int __init efi_free_boot_services(void)
> +{
> +	struct efi_freeable_range *range = ranges_to_free;
> +	unsigned long freed = 0;
> +
> +	if (!ranges_to_free)
> +		return 0;
> +
> +	while (range->start) {
> +		void *start = phys_to_virt(range->start);
> +		void *end = phys_to_virt(range->end);
> +
> +		free_reserved_area(start, end, -1, NULL);
> +		freed += (end - start);
> +		range++;
> +	}
> +	kfree(ranges_to_free);
> +
> +	if (freed)
> +		pr_info("Freeing EFI boot services memory: %ldK\n", freed / SZ_1K);
> +
> +	return 0;
> +}
> +arch_initcall(efi_free_boot_services);
> +
>  /*
>   * A number of config table entries get remapped to virtual addresses
>   * after entering EFI virtual mode. However, the kexec kernel requires
> diff --git a/drivers/firmware/efi/mokvar-table.c b/drivers/firmware/efi/mokvar-table.c
> index 4ff0c2926097..6842aa96d704 100644
> --- a/drivers/firmware/efi/mokvar-table.c
> +++ b/drivers/firmware/efi/mokvar-table.c
> @@ -85,7 +85,7 @@ static struct kobject *mokvar_kobj;
>   * as an alternative to ordinary EFI variables, due to platform-dependent
>   * limitations. The memory occupied by this table is marked as reserved.
>   *
> - * This routine must be called before efi_free_boot_services() in order
> + * This routine must be called before efi_unmap_boot_services() in order
>   * to guarantee that it can mark the table as reserved.
>   *
>   * Implicit inputs:
> 
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> -- 
> 2.51.

