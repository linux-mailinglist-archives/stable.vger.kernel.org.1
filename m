Return-Path: <stable+bounces-139143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 208C6AA4A94
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 14:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A49C1BA3AE0
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 12:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228C2248F53;
	Wed, 30 Apr 2025 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wj+EOWbl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07BD1DF25A;
	Wed, 30 Apr 2025 12:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746014740; cv=none; b=lmViAx2h+UfGMC++MbEJuxnik0zwwZmyGh+yBcw2Lg1HAMXTchQ1BC5N9IGrTdq+LvvnHfPJkWjJNI50p6gU/EJFDiGy/T9BQsVc/MKN0uD4nEDK7xq3w7qIujh2lo9BkktggLGmHQbnXzeoxCYYSfUK2ycEtFznFHQpjIXfCfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746014740; c=relaxed/simple;
	bh=onkMaIN9HqcgjvElUcKUCB/qk3aGAorGg0wgy9unIdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoHL7/DHSDPizL6WSDJQyKJn9QpwkR+cd0KZQ2vAuB0eLO+TjMcrgzKlt05vhQA/3SpEKn01583AZjUKR9mFm6DH0lM7lEsGLCfO4/TmSwmEoe1d7iIv1A5F9Ku/IsaZDOvehDF29rWw9JVcPtIV4CcIp/0QSl9SgzLO+cxMHI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wj+EOWbl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60880C4CEE9;
	Wed, 30 Apr 2025 12:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746014739;
	bh=onkMaIN9HqcgjvElUcKUCB/qk3aGAorGg0wgy9unIdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wj+EOWblQZck7xAP/A5Sor1ThYJtxSnQIiB/a3pc6v/Ishjl5ICognWHzWsri/jwx
	 GxmoRUyg5qw3/IiadJ/Z0pQkCk+HDugXz5hpPUH47WE27VM15H5DUqsqFlw31DlUD7
	 N/WKlkwGd75FTSysFaidbI7OBGW9kWxREBM6lTSU=
Date: Wed, 30 Apr 2025 09:19:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: dave.hansen@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
	Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
	Kirill Shutemov <kirill.shutemov@linux.intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Naveen N Rao <naveen@kernel.org>,
	Nikolay Borisov <nik.borisov@suse.com>, stable@vger.kernel.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Vishal Annapurve <vannapurve@google.com>, x86@kernel.org,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH v5] x86/devmem: Drop /dev/mem access for confidential
 guests
Message-ID: <2025043025-cathouse-headlamp-7bde@gregkh>
References: <20250430024622.1134277-1-dan.j.williams@intel.com>
 <20250430024622.1134277-3-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430024622.1134277-3-dan.j.williams@intel.com>

On Tue, Apr 29, 2025 at 07:46:22PM -0700, Dan Williams wrote:
> Nikolay reports that accessing BIOS data (first 1MB of the physical
> address space) via /dev/mem results in a "crash" / terminated VM
> (unhandled SEPT violation). See report [1] for details.
> 
> The cause is ioremap() (via xlate_dev_mem_ptr()) establishes an
> unencrypted mapping where the kernel had established an encrypted
> mapping previously. The CPU enforces mapping consistency with a fault
> upon detecting a mismatch. A similar situation arises with devmem access
> to "unaccepted" confidential memory. In summary, it is fraught to allow
> uncoordinated userspace mapping of confidential memory.
> 
> While there is an existing mitigation to simulate and redirect access to
> the BIOS data area with STRICT_DEVMEM=y, it is insufficient.
> Specifically, STRICT_DEVMEM=y traps read(2) access to the BIOS data
> area, and returns a zeroed buffer.  However, it turns out the kernel
> fails to enforce the same via mmap(2), and a direct mapping is
> established. This is a hole, and unfortunately userspace has learned to
> exploit it [2].
> 
> This means the kernel either needs: a mechanism to ensure consistent
> plus accepted "encrypted" mappings of this /dev/mem mmap() hole, close
> the hole by mapping the zero page in the mmap(2) path, block only BIOS
> data access and let typical STRICT_DEVMEM protect the rest, or disable
> /dev/mem altogether.
> 
> The simplest option for now is arrange for /dev/mem to always behave as
> if lockdown is enabled for confidential guests. Require confidential
> guest userspace to jettison legacy dependencies on /dev/mem similar to
> how other legacy mechanisms are jettisoned for confidential operation.
> Recall that modern methods for BIOS data access are available like
> /sys/firmware/dmi/tables.
> 
> Now, this begs the question what to do with PCI sysfs which allows
> userspace mappings of confidential MMIO with similar mapping consistency
> and acceptance expectations? Here, the existing mitigation of
> IO_STRICT_DEVMEM is likely sufficient. The kernel is expected to use
> request_mem_region() when toggling the state of MMIO. With
> IO_STRICT_DEVMEM that enforces kernel-exclusive access until
> release_mem_region(), i.e. mapping conflicts are prevented.
> 
> Cc: <x86@kernel.org>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Vishal Annapurve <vannapurve@google.com>
> Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Link: https://sources.debian.org/src/libdebian-installer/0.125/src/system/subarch-x86-linux.c/?hl=113#L93 [2]
> Reported-by: Nikolay Borisov <nik.borisov@suse.com>
> Closes: http://lore.kernel.org/20250318113604.297726-1-nik.borisov@suse.com [1]
> Fixes: 9aa6ea69852c ("x86/tdx: Make pages shared in ioremap()")
> Cc: <stable@vger.kernel.org>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Acked-by: Naveen N Rao (AMD) <naveen@kernel.org>
> Tested-by: Naveen N Rao (AMD) <naveen@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/x86/Kconfig   |  4 ++++
>  drivers/char/mem.c | 10 ++++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 4b9f378e05f6..36f11aad1ae5 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -891,6 +891,8 @@ config INTEL_TDX_GUEST
>  	depends on X86_X2APIC
>  	depends on EFI_STUB
>  	depends on PARAVIRT
> +	select STRICT_DEVMEM
> +	select IO_STRICT_DEVMEM
>  	select ARCH_HAS_CC_PLATFORM
>  	select X86_MEM_ENCRYPT
>  	select X86_MCE
> @@ -1510,6 +1512,8 @@ config AMD_MEM_ENCRYPT
>  	bool "AMD Secure Memory Encryption (SME) support"
>  	depends on X86_64 && CPU_SUP_AMD
>  	depends on EFI_STUB
> +	select STRICT_DEVMEM
> +	select IO_STRICT_DEVMEM
>  	select DMA_COHERENT_POOL
>  	select ARCH_USE_MEMREMAP_PROT
>  	select INSTRUCTION_DECODER
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index 48839958b0b1..47729606b817 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -30,6 +30,7 @@
>  #include <linux/uio.h>
>  #include <linux/uaccess.h>
>  #include <linux/security.h>
> +#include <linux/cc_platform.h>
>  
>  #define DEVMEM_MINOR	1
>  #define DEVPORT_MINOR	4
> @@ -595,6 +596,15 @@ static int open_port(struct inode *inode, struct file *filp)
>  	if (rc)
>  		return rc;
>  
> +	/*
> +	 * Enforce encrypted mapping consistency and avoid unaccepted
> +	 * memory conflicts, "lockdown" /dev/mem for confidential
> +	 * guests.
> +	 */
> +	if (IS_ENABLED(CONFIG_STRICT_DEVMEM) &&
> +	    cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> +		return -EPERM;

I hate to ask, but why not force the whole "confidential computing"
stuff to enable IO_STRICT_DEVMEM as well?  I don't see why you would
want a cc guest raw access to devmem, do you?

You kind of mention it above in the last paragraph, but forcing that on
for these guests feels like the best, and simplest, solution overall as
the number of different "is this secure, no really is this secure, no
what about this option" chain of tests that we have in this driver is
getting kind of silly.

OR, why not just force all cc guests to enable a security module that
implements this for them?  :)

thanks,

greg k-h

