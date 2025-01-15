Return-Path: <stable+bounces-108704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5464CA11F30
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331F33A345E
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A231A1E7C22;
	Wed, 15 Jan 2025 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z6yTVJXN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED8D1E7C3A;
	Wed, 15 Jan 2025 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736936645; cv=none; b=f0iH5ApSW20e5ZWeDuTb8qpWMffyyDemyEJpKr1w86OMmXcICKfb+Kk9L6LuAN07q9OjARaqAMheoQT2wMtil9WwFraGfNGta/3aTV0q+8UW5Vq5Lh8YavjsWsUMJJdQqWzq40M6RZC0W5+5XV2Ae5X1RKsOJLQM6pT1cmOcgNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736936645; c=relaxed/simple;
	bh=mrQ1OaXlc6bMXEK7JY3n2o9PU+VRgTF8F5mJ7Od9uCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIGZnqIyb1OF7LcsBzoGbH+4nS+KDDb4KQnKbEPSHPNncSAPNhj9eN/5O8fWa5Q/O93m1RfrQjmhjNH7TdZG/AMbaksA6bQHsyey4lXWkSu47KCBpGTLydhbk+BQXSCfu0BUqpUTpFka+HDpvnEqigh6Tv5Ah1MoMp7Jh6I/k5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z6yTVJXN; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736936643; x=1768472643;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mrQ1OaXlc6bMXEK7JY3n2o9PU+VRgTF8F5mJ7Od9uCc=;
  b=Z6yTVJXNR9bXnKYuQgOxHDOiqLlK5Z94RqRtyrEtWC934O+jI1KZV8t4
   xwnXrsAavhvuPhtWJfrKruF4mUS82Ua6WR84oU7AZ2+R9IYH1brfwC1Rb
   eF9OXLcqr6+tOyvuQYxjh0JumWDglY7N8aCHCwHxF5RPlExL7R/rGnpqN
   Ay+G7Ifr/C9kCmJbQ+3QehGe8Svx5+WoCvk5iKPDYVDjmFon2UGhOCSUr
   dhWSKLuKuTvvCZ3RL6kAVz6E/az6Y8urs/GPmxR01GOsr40zs0VYzdSUs
   G2MfPrQ/OT15f+Ug/K4RUBWHkbd97L/yaUCe+ZV/T2ccmZXpyztHtzC60
   Q==;
X-CSE-ConnectionGUID: GJ/K+0ggQFKQzqfm1F39kQ==
X-CSE-MsgGUID: E5WOGYPgRBaVdxn1TlSPmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="37145725"
X-IronPort-AV: E=Sophos;i="6.12,317,1728975600"; 
   d="scan'208";a="37145725"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 02:24:02 -0800
X-CSE-ConnectionGUID: GxpqY8wrS2qpNAwLOm9Oyg==
X-CSE-MsgGUID: eM68aTCeRJitcfICEUNamQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="135949783"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 15 Jan 2025 02:23:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id E2AA740B; Wed, 15 Jan 2025 12:23:54 +0200 (EET)
Date: Wed, 15 Jan 2025 12:23:54 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexei Starovoitov <ast@kernel.org>, 
	Andrea Parri <parri.andrea@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eric Chan <ericchancf@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kai Huang <kai.huang@intel.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Russell King <linux@armlinux.org.uk>, Samuel Holland <samuel.holland@sifive.com>, 
	Suren Baghdasaryan <surenb@google.com>, Yuntao Wang <ytcoode@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	stable@vger.kernel.org, Ashish Kalra <ashish.kalra@amd.com>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCHv3 2/2] x86/mm: Make memremap(MEMREMAP_WB) map memory as
 encrypted by default
Message-ID: <mvosqsybplnqfh6wadw5ue7u3plqnfo5ojusvaq6htzzhtfce2@bbgogdund3ho>
References: <ff8daeb1-4839-b070-dd94-a7692ac94008@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff8daeb1-4839-b070-dd94-a7692ac94008@amd.com>

On Tue, Jan 14, 2025 at 10:54:53AM -0600, Tom Lendacky wrote:
> On 1/14/25 09:06, Tom Lendacky wrote:
> > On 1/14/25 08:44, Kirill A. Shutemov wrote:
> >> On Tue, Jan 14, 2025 at 08:33:39AM -0600, Tom Lendacky wrote:
> >>> On 1/14/25 01:27, Kirill A. Shutemov wrote:
> >>>> On Mon, Jan 13, 2025 at 02:47:56PM -0600, Tom Lendacky wrote:
> >>>>> On 1/13/25 07:14, Kirill A. Shutemov wrote:
> >>>>>> Currently memremap(MEMREMAP_WB) can produce decrypted/shared mapping:
> >>>>>>
> >>>>>> memremap(MEMREMAP_WB)
> >>>>>>   arch_memremap_wb()
> >>>>>>     ioremap_cache()
> >>>>>>       __ioremap_caller(.encrytped = false)
> >>>>>>
> >>>>>> In such cases, the IORES_MAP_ENCRYPTED flag on the memory will determine
> >>>>>> if the resulting mapping is encrypted or decrypted.
> >>>>>>
> >>>>>> Creating a decrypted mapping without explicit request from the caller is
> >>>>>> risky:
> >>>>>>
> >>>>>>   - It can inadvertently expose the guest's data and compromise the
> >>>>>>     guest.
> >>>>>>
> >>>>>>   - Accessing private memory via shared/decrypted mapping on TDX will
> >>>>>>     either trigger implicit conversion to shared or #VE (depending on
> >>>>>>     VMM implementation).
> >>>>>>
> >>>>>>     Implicit conversion is destructive: subsequent access to the same
> >>>>>>     memory via private mapping will trigger a hard-to-debug #VE crash.
> >>>>>>
> >>>>>> The kernel already provides a way to request decrypted mapping
> >>>>>> explicitly via the MEMREMAP_DEC flag.
> >>>>>>
> >>>>>> Modify memremap(MEMREMAP_WB) to produce encrypted/private mapping by
> >>>>>> default unless MEMREMAP_DEC is specified.
> >>>>>>
> >>>>>> Fix the crash due to #VE on kexec in TDX guests if CONFIG_EISA is enabled.
> >>>>>
> >>>>> This patch causes my bare-metal system to crash during boot when using
> >>>>> mem_encrypt=on:
> >>>>>
> >>>>> [    2.392934] efi: memattr: Entry type should be RuntimeServiceCode/Data
> >>>>> [    2.393731] efi: memattr: ! 0x214c42f01f1162a-0xee70ac7bd1a9c629 [type=2028324321|attr=0x6590648fa4209879]
> >>>>
> >>>> Could you try if this helps?
> >>>>
> >>>> diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
> >>>> index c38b1a335590..b5051dcb7c1d 100644
> >>>> --- a/drivers/firmware/efi/memattr.c
> >>>> +++ b/drivers/firmware/efi/memattr.c
> >>>> @@ -160,7 +160,7 @@ int __init efi_memattr_apply_permissions(struct mm_struct *mm,
> >>>>  	if (WARN_ON(!efi_enabled(EFI_MEMMAP)))
> >>>>  		return 0;
> >>>>  
> >>>> -	tbl = memremap(efi_mem_attr_table, tbl_size, MEMREMAP_WB);
> >>>> +	tbl = memremap(efi_mem_attr_table, tbl_size, MEMREMAP_WB | MEMREMAP_DEC);
> >>>
> >>> Well that would work for SME where EFI tables/data are not encrypted,
> >>> but will break for SEV where EFI tables/data are encrypted.
> >>
> >> Hm. Why would it break for SEV? It brings the situation back to what it
> >> was before the patch.
> > 
> > Ah, true. I can try it and see how much further SME gets. Hopefully it
> > doesn't turn into a whack-a-mole thing.
> 
> Unfortunately, it is turning into a whack-a-mole thing.
> 
> But it looks the following works for SME:
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 3c36f3f5e688..ff3cd5fc8508 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -505,7 +505,7 @@ EXPORT_SYMBOL(iounmap);
>  
>  void *arch_memremap_wb(phys_addr_t phys_addr, size_t size, unsigned long flags)
>  {
> -	if (flags & MEMREMAP_DEC)
> +	if (flags & MEMREMAP_DEC || cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
>  		return (void __force *)ioremap_cache(phys_addr, size);
>  
>  	return (void __force *)ioremap_encrypted(phys_addr, size);
> 
> 
> I haven't had a chance to test the series on SEV, yet.

Please do.

I am okay with the change above. Borislav, is it acceptable direction for
you?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

