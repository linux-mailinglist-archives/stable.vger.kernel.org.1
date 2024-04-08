Return-Path: <stable+bounces-36404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F15589BF0E
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 14:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FCC11F21586
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 12:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7304C6AFB9;
	Mon,  8 Apr 2024 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WThrYQl0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ECE657BC
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712579833; cv=none; b=OE82KyaG9lSJb/vMbbUmYNNoP++8y/Hz2ifkgzpzOAF//7amZ77rtB0abpNGcgqGma0Tvt7j6/NLxMj9YYouGZBzRJxsJLD/KjwIIBw+4lN/NWtBs9bUqSdBD1l4dvN2+LjvTI4ULKHuRsz3X9xSReMDifREZynTGhhLBm9cT2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712579833; c=relaxed/simple;
	bh=Y+WQuKNf8NJHyYyBdwJN4WEjbP1Toliw8EOgxRyShH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhCzSIIySurB1S4vPirRuFTaNryu4Ru5jgxIU3HObJANxLH/70uhGRB12Gf7bHhFUBXusR1bBm1rnpzf+1RFgt4sRWdTEDTNy7qBF/fToYtUq/34Psda9UETtGhB/L220Hem+cDjzipg6yZhs0vmMo57+rLLxlZMWejkUVhcTZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WThrYQl0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31264C433C7;
	Mon,  8 Apr 2024 12:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712579832;
	bh=Y+WQuKNf8NJHyYyBdwJN4WEjbP1Toliw8EOgxRyShH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WThrYQl0T9qOe9eYnAh0P8FyOj2oLvSUjKNs2R10ge8BlgSdqMTBZRjilYIL80+CE
	 Fp5gDHwvnEMg3udIkLF8EFd2LiK1sIdSoGEINp0Mafo9RE93wr5k025Rhc26k6ErZV
	 4w7I9rC5H1dKPfuppq6dX0dK5VZigTSJmVE6Tf4E=
Date: Mon, 8 Apr 2024 14:37:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: stable@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH -for-stable-v6.6+ 3/6] x86/boot: Move mem_encrypt=
 parsing to the decompressor
Message-ID: <2024040848-paging-jet-609e@gregkh>
References: <20240408064917.3391405-8-ardb+git@google.com>
 <20240408064917.3391405-11-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408064917.3391405-11-ardb+git@google.com>

On Mon, Apr 08, 2024 at 08:49:21AM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> [ Commit cd0d9d92c8bb46e77de62efd7df13069ddd61e7d upstream ]
> 
> The early SME/SEV code parses the command line very early, in order to
> decide whether or not memory encryption should be enabled, which needs
> to occur even before the initial page tables are created.
> 
> This is problematic for a number of reasons:
> - this early code runs from the 1:1 mapping provided by the decompressor
>   or firmware, which uses a different translation than the one assumed by
>   the linker, and so the code needs to be built in a special way;
> - parsing external input while the entire kernel image is still mapped
>   writable is a bad idea in general, and really does not belong in
>   security minded code;
> - the current code ignores the built-in command line entirely (although
>   this appears to be the case for the entire decompressor)
> 
> Given that the decompressor/EFI stub is an intrinsic part of the x86
> bootable kernel image, move the command line parsing there and out of
> the core kernel. This removes the need to build lib/cmdline.o in a
> special way, or to use RIP-relative LEA instructions in inline asm
> blocks.
> 
> This involves a new xloadflag in the setup header to indicate
> that mem_encrypt=on appeared on the kernel command line.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
> Link: https://lore.kernel.org/r/20240227151907.387873-17-ardb+git@google.com
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/compressed/misc.c         | 15 +++++++++
>  arch/x86/include/uapi/asm/bootparam.h   |  1 +
>  arch/x86/lib/Makefile                   | 13 --------
>  arch/x86/mm/mem_encrypt_identity.c      | 32 ++------------------
>  drivers/firmware/efi/libstub/x86-stub.c |  3 ++
>  5 files changed, 22 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index f711f2a85862..c6136a1be283 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -357,6 +357,19 @@ unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
>  	return entry;
>  }
>  
> +/*
> + * Set the memory encryption xloadflag based on the mem_encrypt= command line
> + * parameter, if provided.
> + */
> +static void parse_mem_encrypt(struct setup_header *hdr)
> +{
> +	int on = cmdline_find_option_bool("mem_encrypt=on");
> +	int off = cmdline_find_option_bool("mem_encrypt=off");
> +
> +	if (on > off)
> +		hdr->xloadflags |= XLF_MEM_ENCRYPTION;
> +}
> +
>  /*
>   * The compressed kernel image (ZO), has been moved so that its position
>   * is against the end of the buffer used to hold the uncompressed kernel
> @@ -387,6 +400,8 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
>  	/* Clear flags intended for solely in-kernel use. */
>  	boot_params->hdr.loadflags &= ~KASLR_FLAG;
>  
> +	parse_mem_encrypt(&boot_params->hdr);
> +
>  	sanitize_boot_params(boot_params);
>  
>  	if (boot_params->screen_info.orig_video_mode == 7) {

This patch didn't apply on 6.6.y, so I applied it by hand, but it turns
out there is no "boot_parms" on 6.6.y, so it breaks the build.

So I've dropped this one from the 6.6.y tree now, if you can submit it
in a form that at least compiles, I'll take it :)

thanks,

greg k-h

