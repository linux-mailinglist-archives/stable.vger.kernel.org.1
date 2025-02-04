Return-Path: <stable+bounces-112145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97A1A270B0
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 12:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A2913A4899
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 11:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5965720CCE6;
	Tue,  4 Feb 2025 11:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csyVMxbT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0A320B1EF;
	Tue,  4 Feb 2025 11:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738670073; cv=none; b=IENJBlc6YqKXwFOV1LVWzI6rWqjBuME2OMRyH3btISvTsHXnJz2JQONpjlQBnlnRdV8IONN9keozeNz+Ri9g1KCv3hPU5ySGj2Ga2kA7UJ4OVtoRXszZAGq7labnhVFEVhgJ1vdXcbhGiuLiwAT8UsMZpRcWgUQeBct2+KjkQsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738670073; c=relaxed/simple;
	bh=cT2RxHJJvfh2ykj3Hm8+RhZNJZwL1VMP4Vlog4g2ZdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecjaYjJ9TH43FYika1Y13IyUamBXQmlIvkFBQ6CBAu3j8vp046OQ1CKteQmOUwPHBia6icuI0T8OXIJwwlSdA/koHSxTVxWZ7h3y6eMznj9yQwzAD1rPQhEscgen8oCb54UpffFsoEdVHdHczAzTOwD++qcR9ZoHMWSGntExziA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csyVMxbT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57E3C4CEE4;
	Tue,  4 Feb 2025 11:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738670072;
	bh=cT2RxHJJvfh2ykj3Hm8+RhZNJZwL1VMP4Vlog4g2ZdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=csyVMxbTBOzapoMihhQvE3yBB8ppc3ebVwM/lxds5TbEb0QskmNEuc5MVFo6Xx+P5
	 GOKGaVz6BDEjZ/op7qMjXlQDHZC4ZANHFYoGmF4fAmyqejfrps2lzmH4uL2R3ZfF3h
	 530fpeFMTxa6u5klDBJ7K8PpMknYVepim2CnzVVrga7vONzOJl7DZIhORsTIchBZBh
	 UjxCk8o65nAOIhrYdYArgTKr370ez30ggERV9Gx5ezQvtxHHLk3H2uxcRM0Tbb9nqi
	 dcv4lN+OIJuQkx38F6IUBGMSX7u8RoAPeIdGog3AzZusfSP49GoSHYB9HsCU6MqDk4
	 hCCLR03KTdAwg==
Date: Tue, 4 Feb 2025 11:54:28 +0000
From: Will Deacon <will@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: Handle .ARM.attributes section in linker scripts
Message-ID: <20250204115427.GE893@willie-the-truck>
References: <20250124-arm64-handle-arm-attributes-in-linker-script-v1-1-74135b6cf349@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124-arm64-handle-arm-attributes-in-linker-script-v1-1-74135b6cf349@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Jan 24, 2025 at 06:31:57AM -0700, Nathan Chancellor wrote:
> A recent LLVM commit [1] started generating an .ARM.attributes section
> similar to the one that exists for 32-bit, which results in orphan
> section warnings (or errors if CONFIG_WERROR is enabled) from the linker
> because it is not handled in the arm64 linker scripts.
> 
>   ld.lld: error: arch/arm64/kernel/vdso/vgettimeofday.o:(.ARM.attributes) is being placed in '.ARM.attributes'
>   ld.lld: error: arch/arm64/kernel/vdso/vgetrandom.o:(.ARM.attributes) is being placed in '.ARM.attributes'
> 
>   ld.lld: error: vmlinux.a(lib/vsprintf.o):(.ARM.attributes) is being placed in '.ARM.attributes'
>   ld.lld: error: vmlinux.a(lib/win_minmax.o):(.ARM.attributes) is being placed in '.ARM.attributes'
>   ld.lld: error: vmlinux.a(lib/xarray.o):(.ARM.attributes) is being placed in '.ARM.attributes'
> 
> Add this new section to the necessary linker scripts to resolve the warnings.
> 
> Cc: stable@vger.kernel.org
> Fixes: b3e5d80d0c48 ("arm64/build: Warn on orphan section placement")
> Link: https://github.com/llvm/llvm-project/commit/ee99c4d4845db66c4daa2373352133f4b237c942 [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/arm64/kernel/vdso/vdso.lds.S | 1 +
>  arch/arm64/kernel/vmlinux.lds.S   | 1 +
>  2 files changed, 2 insertions(+)

Hmm. I wonder what this new attributes section is for and how it will
co-exist with .note.gnu.property in future? For example, the spec linked
form the above commit:

https://github.com/ARM-software/abi-aa/pull/230

has references to GCS, which I don't think has a corresponding feature
bit for the ELF note (at least, Linux doesn't know about it if it does).

> diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
> index 4ec32e86a8da..f8418a3a2758 100644
> --- a/arch/arm64/kernel/vdso/vdso.lds.S
> +++ b/arch/arm64/kernel/vdso/vdso.lds.S
> @@ -75,6 +75,7 @@ SECTIONS
>  
>  	DWARF_DEBUG
>  	ELF_DETAILS
> +	.ARM.attributes 0 : { *(.ARM.attributes) }

Let's just add this to the /DISCARD/ section higher up, where we chuck
away .note.gnu.property.

> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index f84c71f04d9e..c94942e9eb46 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -335,6 +335,7 @@ SECTIONS
>  	STABS_DEBUG
>  	DWARF_DEBUG
>  	ELF_DETAILS
> +	.ARM.attributes 0 : { *(.ARM.attributes) }

I think we should discard this too (afaict, RO_DATA() discards
.note.gnu.property via NOTES()).

Will

