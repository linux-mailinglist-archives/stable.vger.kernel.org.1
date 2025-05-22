Return-Path: <stable+bounces-146139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC26AC1715
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 01:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243D01C03BCF
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 23:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE1B2BF3DE;
	Thu, 22 May 2025 23:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMfATcO8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF1FCA52;
	Thu, 22 May 2025 23:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747954866; cv=none; b=OhOD3dvMcEOcmhRb4wImZROxTIypVL/rTmgeyTwBB/IXYBxP8VEjt78LKRpyGQFVT6/3Bq2HGH1sGELbdyNsUu56+gbsYf00Ot1Jd3UeBHo/Q0WX/7xUbpWjC031S36J7Sv1q1bZ98rvMnftc7qZZOg6UH3yWQwLob5wO+T3AfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747954866; c=relaxed/simple;
	bh=3fRB2zOy7dZMiB2pgHhbWuTftCpMtbw7N8zj6z8r4Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ho2K2OAKzWUf0nkpRt0N80aiVSUKv8Gtgg6hFKvD5LszQxVd2wTITFfpKfSWDkrJwAraiIkIcyvpNUFTGjbxXYfMbxBJ+B86DRddKHcJa1hRBgaa2NtIBTr11rffdPm6kEqBVcBj4ArRtWDepD4r/YLf83vrZRdHtu13Ekw0IF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMfATcO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E67C4CEE4;
	Thu, 22 May 2025 23:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747954866;
	bh=3fRB2zOy7dZMiB2pgHhbWuTftCpMtbw7N8zj6z8r4Qc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BMfATcO8CnYfsabtv73NyLu8Q/VgTqoeRF1Yql2xHfLMvR3wQ3UMVSjyltQmbtEGZ
	 q7TYahpbsxmn92DCKkDaxKLNV4vinG4feRA87uhU1zYiskVyhBVJQf5wWiLDWO9SPr
	 GIlw/JnfG2LP0Dm67xtrhRkevVCOG1/3TgukVTzC/ZDVm+YKDu5KHxkR0vfE6UxKsb
	 ZrgfX+kd/rvVGUNPIi1xCP+tQKq2La8dZIbKdAupGql0H1ojiymbEw1mkTojEw3nTO
	 X8/zx9UdIInjycFlHWCbj+LWUnaoSNzTutvlLNSqy2smnFhU4XtvNJDLkSkAE52Np2
	 g51Q7Pz+p7Pyw==
Date: Thu, 22 May 2025 16:01:01 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Cc: stable-commits@vger.kernel.org, brgerst@gmail.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: Patch "x86/relocs: Handle R_X86_64_REX_GOTPCRELX relocations"
 has been added to the 6.14-stable tree
Message-ID: <20250522230101.GA1911411@ax162>
References: <20250522213009.3137023-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522213009.3137023-1-sashal@kernel.org>

On Thu, May 22, 2025 at 05:30:09PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     x86/relocs: Handle R_X86_64_REX_GOTPCRELX relocations
> 
> to the 6.14-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      x86-relocs-handle-r_x86_64_rex_gotpcrelx-relocations.patch
> and it can be found in the queue-6.14 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit d8e603969259e50aa632d1a3fde8883f41e26150
> Author: Brian Gerst <brgerst@gmail.com>
> Date:   Thu Jan 23 14:07:37 2025 -0500
> 
>     x86/relocs: Handle R_X86_64_REX_GOTPCRELX relocations
>     
>     [ Upstream commit cb7927fda002ca49ae62e2782c1692acc7b80c67 ]
>     
>     Clang may produce R_X86_64_REX_GOTPCRELX relocations when redefining the
>     stack protector location.  Treat them as another type of PC-relative
>     relocation.
>     
>     Signed-off-by: Brian Gerst <brgerst@gmail.com>
>     Signed-off-by: Ingo Molnar <mingo@kernel.org>
>     Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
>     Cc: Linus Torvalds <torvalds@linux-foundation.org>
>     Link: https://lore.kernel.org/r/20250123190747.745588-6-brgerst@gmail.com
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
> index e937be979ec86..92a1e503305ef 100644
> --- a/arch/x86/tools/relocs.c
> +++ b/arch/x86/tools/relocs.c
> @@ -32,6 +32,11 @@ static struct relocs		relocs32;
>  static struct relocs		relocs32neg;
>  static struct relocs		relocs64;
>  # define FMT PRIu64
> +
> +#ifndef R_X86_64_REX_GOTPCRELX
> +# define R_X86_64_REX_GOTPCRELX 42
> +#endif
> +
>  #else
>  # define FMT PRIu32
>  #endif
> @@ -227,6 +232,7 @@ static const char *rel_type(unsigned type)
>  		REL_TYPE(R_X86_64_PC16),
>  		REL_TYPE(R_X86_64_8),
>  		REL_TYPE(R_X86_64_PC8),
> +		REL_TYPE(R_X86_64_REX_GOTPCRELX),
>  #else
>  		REL_TYPE(R_386_NONE),
>  		REL_TYPE(R_386_32),
> @@ -861,6 +867,7 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
>  
>  	case R_X86_64_PC32:
>  	case R_X86_64_PLT32:
> +	case R_X86_64_REX_GOTPCRELX:
>  		/*
>  		 * PC relative relocations don't need to be adjusted unless
>  		 * referencing a percpu symbol.

Didn't Ard just say this has no purpose in stable?

https://lore.kernel.org/CAMj1kXGtasdqRPn8koNN095VEEU4K409QvieMdgGXNUK0kPgkw@mail.gmail.com/

Cheers,
Nathan

