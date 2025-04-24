Return-Path: <stable+bounces-136516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BDDA9A25F
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 08:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD6627ABD94
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 06:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CB21DD9AB;
	Thu, 24 Apr 2025 06:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsF+jSuj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE182DF49;
	Thu, 24 Apr 2025 06:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745476586; cv=none; b=PtBDbs3aLS1AJzoS+gtyKGPqYh6YQSz2K/ryxaxL1in6z17lBa2+9lmu9e72ZgLoLj4xyON3diXvMlOxUtQcMLPWFNGnzhFzl6RubMG2fbvna1rOwJzuo6DXkVc1U/7JHqA/oOm17waxBOmenDhf74qYZc+Q05wcOCw0Y/g0DPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745476586; c=relaxed/simple;
	bh=MDoN1ZK19bo6rNQIgmavzayzM4Rwo/IkSrito3ddS6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDJuBoeYIAJh1rj4c8VWNAOO3emgu7h98hipa5Wd7ixBXc8Y65GovcJCQX8WS93eJdB3qTaF0q54p+Mn6f9MVklrg3FoWFfYxVPFgzn9QtkzJcof5nmM6R7oe1kXfQLSm28ttwEgBDVb44GWddvgx7lGMVgF+zWLMXisD1xxcGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsF+jSuj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0FAC4CEEB;
	Thu, 24 Apr 2025 06:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745476585;
	bh=MDoN1ZK19bo6rNQIgmavzayzM4Rwo/IkSrito3ddS6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DsF+jSujyWRYe/er8IF/g1XJr0Uhw2Sc0XVs6y0PKvvSojDF323NKajq2oeD65fay
	 wbFqByffiBa/4RTnB68MpiPyLmMKduR/raVqD46hXsjChJWhopM+phdJ5CkUDcHQZ/
	 SoSbFp+D6IdX2+FL4KbiUd5c8Z87OBi0+giQYhYUvgOrMX+vQgOGenZtF+5o0XJYV/
	 pGSDNkqeYubj16wg80O6YI7lXOsRb1XI4DyuQ0jMifseEe2QlwMl2ctm5AWDnnFn1x
	 kF5GIYar/VLB2ReV1m3s6Zct++sRPOsrBZz5ednM7ux6eAH1PnXtdQ9WLDhkPPZrjR
	 fDbgRZ73XvtGg==
Date: Thu, 24 Apr 2025 12:05:57 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: dave.hansen@linux.intel.com, x86@kernel.org, 
	Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Vishal Annapurve <vannapurve@google.com>, Kirill Shutemov <kirill.shutemov@linux.intel.com>, 
	Nikolay Borisov <nik.borisov@suse.com>, stable@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v4 2/2] x86/devmem: Drop /dev/mem access for confidential
 guests
Message-ID: <ma4odvegjsceiwccyhbsz5wn4wjdnx2sfhyigtva5zjiyfmsdw@tyq72l2zavb6>
References: <174491712829.1395340.5054725417641299524.stgit@dwillia2-xfh.jf.intel.com>
 <174500659632.1583227.11220240508166521765.stgit@dwillia2-xfh.jf.intel.com>
 <y3c6mpt3w4pdx7xzaqdlsr3ci33cseuaxwdno4uh3jfb2ddvxp@kicc5stwtcto>
 <68094f51a7b01_71fe294c6@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68094f51a7b01_71fe294c6@dwillia2-xfh.jf.intel.com.notmuch>

[Actually copy Tom]

On Wed, Apr 23, 2025 at 01:36:33PM -0700, Dan Williams wrote:
> Naveen N Rao wrote:
> > On Fri, Apr 18, 2025 at 01:04:02PM -0700, Dan Williams wrote:
> > > Nikolay reports [1] that accessing BIOS data (first 1MB of the physical
> > > address space) via /dev/mem results in an SEPT violation.
> > > 
> > > The cause is ioremap() (via xlate_dev_mem_ptr()) establishes an
> > > unencrypted mapping where the kernel had established an encrypted
> > > mapping previously.
> > > 
> > > Linux traps read(2) access to the BIOS data area, and returns zero.
> > > However, it turns out the kernel fails to enforce the same via mmap(2).
> > > This is a hole, and unfortunately userspace has learned to exploit it
> > > [2].
> > > 
> > > This means the kernel either needs a mechanism to ensure consistent
> > > "encrypted" mappings of this /dev/mem mmap() hole, close the hole by
> > > mapping the zero page in the mmap(2) path, block only BIOS data access
> > > and let typical STRICT_DEVMEM protect the rest, or disable /dev/mem
> > > altogether.
> > > 
> > > The simplest option for now is arrange for /dev/mem to always behave as
> > > if lockdown is enabled for confidential guests. Require confidential
> > > guest userspace to jettison legacy dependencies on /dev/mem similar to
> > > how other legacy mechanisms are jettisoned for confidential operation.
> > > Recall that modern methods for BIOS data access are available like
> > > /sys/firmware/dmi/tables.
> > > 
> > > Cc: <x86@kernel.org>
> > > Cc: Kees Cook <kees@kernel.org>
> > > Cc: Ingo Molnar <mingo@kernel.org>
> > > Cc: "Naveen N Rao" <naveen@kernel.org>
> > > Cc: Vishal Annapurve <vannapurve@google.com>
> > > Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>
> > > Link: https://sources.debian.org/src/libdebian-installer/0.125/src/system/subarch-x86-linux.c/?hl=113#L93 [2]
> > > Reported-by: Nikolay Borisov <nik.borisov@suse.com>
> > > Closes: http://lore.kernel.org/20250318113604.297726-1-nik.borisov@suse.com [1]
> > > Fixes: 9aa6ea69852c ("x86/tdx: Make pages shared in ioremap()")
> > > Cc: <stable@vger.kernel.org>
> > > Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > > Changes since v3
> > > * Fix a 0day kbuild robot report about missing cc_platform.h include.
> > > 
> > >  arch/x86/Kconfig   |    4 ++++
> > >  drivers/char/mem.c |   10 ++++++++++
> > >  2 files changed, 14 insertions(+)
> > > 
> > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > index 4b9f378e05f6..bf4528d9fd0a 100644
> > > --- a/arch/x86/Kconfig
> > > +++ b/arch/x86/Kconfig
> > > @@ -891,6 +891,8 @@ config INTEL_TDX_GUEST
> > >  	depends on X86_X2APIC
> > >  	depends on EFI_STUB
> > >  	depends on PARAVIRT
> > > +	depends on STRICT_DEVMEM
> > > +	depends on IO_STRICT_DEVMEM
> > >  	select ARCH_HAS_CC_PLATFORM
> > >  	select X86_MEM_ENCRYPT
> > >  	select X86_MCE
> > > @@ -1510,6 +1512,8 @@ config AMD_MEM_ENCRYPT
> > 
> > As far as I know, AMD_MEM_ENCRYPT is for the host SME support. Since 
> > this is for encrypted guests, should the below dependencies be added to 
> > CONFIG_SEV_GUEST instead?
> > 
> > Tom?
> 
> The placement rationale here was to have the DEVMEM restrictions next to
> the ARCH_HAS_CC_PLATFORM 'select' statement which is INTEL_TDX_GUEST
> and AMD_MEM_ENCRYPT with SEV_GUEST depending on AMD_MEM_ENCRYPT.
> 
> > >  	bool "AMD Secure Memory Encryption (SME) support"
> > >  	depends on X86_64 && CPU_SUP_AMD
> > >  	depends on EFI_STUB
> > > +	depends on STRICT_DEVMEM
> > > +	depends on IO_STRICT_DEVMEM
> > 
> > Can we use 'select' for the dependency on IO_STRICT_DEVMEM, if not both 
> > the above?
> > 
> > IO_STRICT_DEVMEM in particular is not enabled by default, so applying 
> > this patch and doing a 'make olddefconfig' disabled AMD_MEM_ENCRYPT, 
> > which is not so good. Given that IO_STRICT_DEVMEM only depends on 
> > STRICT_DEVMEM, I think a 'select' is ok.
> 
> Agree, that makes sense, and I do not think it will lead to any select
> dependency problems given STRICT_DEVMEM is "default y" for x86.
> 
> > 
> > >  	select DMA_COHERENT_POOL
> > >  	select ARCH_USE_MEMREMAP_PROT
> > >  	select INSTRUCTION_DECODER
> > > diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> > > index 48839958b0b1..47729606b817 100644
> > > --- a/drivers/char/mem.c
> > > +++ b/drivers/char/mem.c
> > > @@ -30,6 +30,7 @@
> > >  #include <linux/uio.h>
> > >  #include <linux/uaccess.h>
> > >  #include <linux/security.h>
> > > +#include <linux/cc_platform.h>
> > >  
> > >  #define DEVMEM_MINOR	1
> > >  #define DEVPORT_MINOR	4
> > > @@ -595,6 +596,15 @@ static int open_port(struct inode *inode, struct file *filp)
> > >  	if (rc)
> > >  		return rc;
> > >  
> > > +	/*
> > > +	 * Enforce encrypted mapping consistency and avoid unaccepted
> > > +	 * memory conflicts, "lockdown" /dev/mem for confidential
> > > +	 * guests.
> > > +	 */
> > > +	if (IS_ENABLED(CONFIG_STRICT_DEVMEM) &&
> > > +	    cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> > > +		return -EPERM;
> > > +
> > >  	if (iminor(inode) != DEVMEM_MINOR)
> > >  		return 0;
> > >  
> > > 
> > 
> > Otherwise, this looks good to me.
> 
> Thanks Naveen, can I take that as an Acked-by?

Yes. I tested this and it solves the issue we see with SEV-SNP guest 
userspace access to video ROM range. For this patch:
Acked-by: Naveen N Rao (AMD) <naveen@kernel.org>
Tested-by: Naveen N Rao (AMD) <naveen@kernel.org>


Thanks,
Naveen


