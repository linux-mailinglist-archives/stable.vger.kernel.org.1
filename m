Return-Path: <stable+bounces-25879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14C386FF2C
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 11:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01FA01C20E72
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 10:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CDB36AFF;
	Mon,  4 Mar 2024 10:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="zoVXZ/OH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KNijUNDI"
X-Original-To: stable@vger.kernel.org
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35B9364D5
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709548629; cv=none; b=qnBPH19Do1dHYHS+kOL+kMgSb1fdvP59QASWuN3v9qjbOYdC1FL56CFHHVJs6Q7I0xj2Q6RBkF/4rUI4lHzW/Ti9rH/gs0Jx2YbSGWWrqR3iyivDVlmY+TG4c51z8bj7pXW/mPVz94gkRwK/Yaafk86ZcZhB4Xdkk5jnvSWDlmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709548629; c=relaxed/simple;
	bh=zhQyH3PnjwIyrG83fDqHO+e7XIlHfiIfbTaeiINM8Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+t9ZwVmbaSFYInfqLlXtVgSc9SLeO8/30AYDyJsObFzaNCVRJuHDHfJHyRzzW0nlYoR0T9cMh7Xzfz5Ks8/Kny+Vf93YJQ3fCH+MkTwrM+MhePhxj0+fLkhCpe/wahSYa9pTSfg9n5q/l9cFKs/hxk8+BG3rrbTWF60CDZpWrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=zoVXZ/OH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KNijUNDI; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 5416B1800085;
	Mon,  4 Mar 2024 05:37:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 04 Mar 2024 05:37:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709548624; x=1709635024; bh=RK7dVJsLFj
	TvXwWNCoQg0BnmDkjHL/XjNMG+W1k2Yv0=; b=zoVXZ/OHQZIkndlMtB45GLyEO4
	hPxVu+ykIGkD87PXyCB3GH20UYNWKOfNmfcGD7AE0yzr75WOiCM2poP6TPq8yAux
	3zLBWXcZeWqR6TTzxFj9kMAsmS43YUt/JQMJQR2Q/hjKjxohLym3W0VFiUQKaKVW
	5fvSPnvSQG4auyHew69fDGJFHunD1Tjwv2K+SyboJ7hxHs6l8PKnO9BMqn/fBAzG
	c1RUFNL8QYg+rtLq16fQmOwxdtWckVCH77c+BdwR9vh/0C/JQy6Cv/4AioRO0ASR
	o3V3v42Ke40KsGyYK758KJeHFKtpOrhH3zxbh/sCx6Tt66+jTzM9Y90nadsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709548624; x=1709635024; bh=RK7dVJsLFjTvXwWNCoQg0BnmDkjH
	L/XjNMG+W1k2Yv0=; b=KNijUNDIXeSEV73/absdLuYt+21tDv8w0nHZsqa1MWvJ
	xyfA2koMCxKQPBr4Fj8JILCqrPlMVesjEZTrxDh73+j9Wt3Aqmh/ZVwvlS9+nz90
	NdroAY9hNefaSW+fjvTCui0jcvX6Yg2OoYztijBBueYDtdmXFFdEfp8aUaHl31TR
	DjWwemG2uQ8/VU9BdjJXe/8dxJ78bLnDsyq1gFyD9urH/sD1JulPpFqGUjdTNCns
	6aT48C6pdLl+JXxAy5nnoVMUk+j2Xm+fBLNelMvLREua7EzvssL05+QssqR0Wm6p
	bRtsjTgZKwS429NBc7FBQ2DOViYYpJTaO+xCer/slA==
X-ME-Sender: <xms:UKTlZX_wDlyLWaiJKsa8tb_8d-FDF4ccdjRjH0SGJgHMs5XuHkqNMQ>
    <xme:UKTlZTuceL11uSqtT9DpRrlB-1Hr0R4dtZVze1uy30WehNtBneHdcDwVdlT798k1o
    F7sFPY_MunHJg>
X-ME-Received: <xmr:UKTlZVDfezBsnPuAwk1_DpkgEnV6YMwjEZFuUir46bR66VQXcr-TT-hw6XQTt9YOOo-k4DOFDA_7I76UbcgOfqhd7rPgO3-lp4Kkzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeeuveekge
    eukeelvddttedugfduueeuueegueegtdffheekhfdvkeejhfevueevueenucffohhmrghi
    nhepihhnthgvlhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:UKTlZTdhA3LktNxRYI53EiOqWVd7YnAzZtKRRQ8pKEAenzzja97-8A>
    <xmx:UKTlZcOSvyHvNn8AiuRouyozNrHcVJiRuhOE1wr1kGqtwGR5vHfFyw>
    <xmx:UKTlZVlLF2OqYrIWvjO84KUbJaQB47CtcB9IGa9OHSy5Ffuj4vbA8w>
    <xmx:UKTlZdg7Ia-l--R24K1j0zPe9mzpNb26KK0k0Y45h-73oYBGK-wLlxNTIK0>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 05:37:04 -0500 (EST)
Date: Mon, 4 Mar 2024 11:35:40 +0100
From: Greg KH <greg@kroah.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: "# 3.4.x" <stable@vger.kernel.org>,
	Dimitri John Ledkov <xnox@ubuntu.com>, jan.setjeeilers@oracle.com
Subject: Re: EFI/x86 backports for v6.1
Message-ID: <2024030419-booted-dwelled-619b@gregkh>
References: <CAMj1kXE5y+6Fef1SqsePO1p8eGEL_qKR9ZkNPNKb-y6P8-7YmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXE5y+6Fef1SqsePO1p8eGEL_qKR9ZkNPNKb-y6P8-7YmQ@mail.gmail.com>

On Sun, Feb 25, 2024 at 11:02:50AM +0100, Ard Biesheuvel wrote:
> Please consider the patches below for backporting to v6.1. They should
> all apply cleanly in the given order.
> 
> These are prerequisites for NX compat support on x86, but the
> remaining changes do not apply cleanly and will be sent as a patch
> series at a later date.
> By themselves, these changes not only constitute a reasonable cleanup,
> they are also needed for future support of x86s [0] CPUs that are no
> longer able to transition out of long mode.
> 
>  Documentation/x86/boot.rst                 |   2 +-
>  arch/x86/Kconfig                           |  17 +
>  arch/x86/boot/compressed/Makefile          |   8 +-
>  arch/x86/boot/compressed/efi_mixed.S       | 383 +++++++++++++++++++
>  arch/x86/boot/compressed/efi_thunk_64.S    | 195 ----------
>  arch/x86/boot/compressed/head_32.S         |  25 +-
>  arch/x86/boot/compressed/head_64.S         | 566 ++++++-----------------------
>  arch/x86/boot/compressed/mem_encrypt.S     | 152 +++++++-
>  arch/x86/boot/compressed/misc.c            |  34 +-
>  arch/x86/boot/compressed/misc.h            |   2 -
>  arch/x86/boot/compressed/pgtable.h         |  10 +-
>  arch/x86/boot/compressed/pgtable_64.c      |  87 ++---
>  arch/x86/boot/header.S                     |   2 +-
>  arch/x86/boot/tools/build.c                |   2 +
>  drivers/firmware/efi/efi.c                 |  22 ++
>  drivers/firmware/efi/libstub/alignedmem.c  |   5 +-
>  drivers/firmware/efi/libstub/arm64-stub.c  |   6 +-
>  drivers/firmware/efi/libstub/efistub.h     |   6 +-
>  drivers/firmware/efi/libstub/mem.c         |   3 +-
>  drivers/firmware/efi/libstub/randomalloc.c |   5 +-
>  drivers/firmware/efi/libstub/x86-stub.c    |  53 ++-
>  drivers/firmware/efi/vars.c                |  13 +-
>  include/linux/decompress/mm.h              |   2 +-
>  23 files changed, 805 insertions(+), 795 deletions(-)
> 
> [0] https://www.intel.com/content/www/us/en/developer/articles/technical/envisioning-future-simplified-architecture.html
> 
> 
> 9cf42bca30e9 efi: libstub: use EFI_LOADER_CODE region when moving the
> kernel in memory
> cb8bda8ad443 x86/boot/compressed: Rename efi_thunk_64.S to efi-mixed.S
> e2ab9eab324c x86/boot/compressed: Move 32-bit entrypoint code into .text section
> 5c3a85f35b58 x86/boot/compressed: Move bootargs parsing out of 32-bit
> startup code
> 91592b5c0c2f x86/boot/compressed: Move efi32_pe_entry into .text section
> 73a6dec80e2a x86/boot/compressed: Move efi32_entry out of head_64.S
> 7f22ca396778 x86/boot/compressed: Move efi32_pe_entry() out of head_64.S
> 4b52016247ae x86/boot/compressed, efi: Merge multiple definitions of
> image_offset into one
> 630f337f0c4f x86/boot/compressed: Simplify IDT/GDT preserve/restore in
> the EFI thunk
> 6aac80a8da46 x86/boot/compressed: Avoid touching ECX in
> startup32_set_idt_entry()
> d73a257f7f86 x86/boot/compressed: Pull global variable reference into
> startup32_load_idt()
> c6355995ba47 x86/boot/compressed: Move startup32_load_idt() into .text section
> 9ea813be3d34 x86/boot/compressed: Move startup32_load_idt() out of head_64.S
> b5d854cd4b6a x86/boot/compressed: Move startup32_check_sev_cbit() into .text
> 9d7eaae6a071 x86/boot/compressed: Move startup32_check_sev_cbit() out
> of head_64.S
> 30c9ca16a527 x86/boot/compressed: Adhere to calling convention in
> get_sev_encryption_bit()
> 61de13df9590 x86/boot/compressed: Only build mem_encrypt.S if AMD_MEM_ENCRYPT=y
> bad267f9e18f efi: verify that variable services are supported
> 0217a40d7ba6 efi: efivars: prevent double registration
> cc3fdda2876e x86/efi: Make the deprecated EFI handover protocol optional
> 7734a0f31e99 x86/boot: Robustify calling startup_{32,64}() from the
> decompressor code
> d2d7a54f69b6 x86/efistub: Branch straight to kernel entry point from C code
> df9215f15206 x86/efistub: Simplify and clean up handover entry code
> 127920645876 x86/decompressor: Avoid magic offsets for EFI handover entrypoint
> d7156b986d4c x86/efistub: Clear BSS in EFI handover protocol entrypoint
> 8b63cba746f8 x86/decompressor: Store boot_params pointer in callee save register
> 00c6b0978ec1 x86/decompressor: Assign paging related global variables earlier
> e8972a76aa90 x86/decompressor: Call trampoline as a normal function
> 918a7a04e717 x86/decompressor: Use standard calling convention for trampoline
> bd328aa01ff7 x86/decompressor: Avoid the need for a stack in the
> 32-bit trampoline
> 64ef578b6b68 x86/decompressor: Call trampoline directly from C code
> f97b67a773cd x86/decompressor: Only call the trampoline when changing
> paging levels
> cb83cece57e1 x86/decompressor: Pass pgtable address to trampoline directly
> 03dda95137d3 x86/decompressor: Merge trampoline cleanup with switching code
> 24388292e2d7 x86/decompressor: Move global symbol references to C code
> 8217ad0a435f decompress: Use 8 byte alignment

For some reason, not all of these applied cleanly.  But they still build
with just a subset :)

Here are the ones that failed for me:
	0217a40d7ba6 ("efi: efivars: prevent double registration")
	df9215f15206 ("x86/efistub: Simplify and clean up handover entry code")
	127920645876 ("x86/decompressor: Avoid magic offsets for EFI handover entrypoint")
	d7156b986d4c ("x86/efistub: Clear BSS in EFI handover protocol entrypoint")

Can you provide working backports for these 4?  Everything else is now
queued up.

thanks,

greg k-h

