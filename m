Return-Path: <stable+bounces-166888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2A1B1F072
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 23:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 060ABA053A4
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 21:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28B528A1F8;
	Fri,  8 Aug 2025 21:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKeUBHur"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C8528A1D3;
	Fri,  8 Aug 2025 21:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754689988; cv=none; b=SjdwNvVNZCg1/PApRAR+56LCi9iXqcquExSlBj3tZiXXdmb8Vza0cEkL40AZ9e9hzX57zGftczkIenaQoEHTb1FwEPIYTqwrgfZ6WmUGPGbTSQPPeTRLX5qJvemzUwHIicJPhiBKtqUylwMRwVIi6k+f46yy82qzIT9juI0WlR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754689988; c=relaxed/simple;
	bh=ATwyecHxTopAmdm8049OI8LQGrc6qa1zmAS8EZn7Zt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrOpntumMWguKXg/aGTaj6wybJq93IWrLKYoz2Gnpqhi4V9R7oQtbrshGFqVOxITYQsn2ugPDiGqrQz3BVPEGKlJHqzcnFZ5S4n84EQtI1hP4yzsgCNYGkVqnqd+7Ex0DvT22UmIROHllc5qNxNvdTgZR6nVd4SIm1Y90ChTrBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKeUBHur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBF9C4CEF7;
	Fri,  8 Aug 2025 21:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754689988;
	bh=ATwyecHxTopAmdm8049OI8LQGrc6qa1zmAS8EZn7Zt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GKeUBHurZI5lwaUwpKrVDYzX+jl120VmMnO8rd1hLSEncWyHHLlvSQUQ0V6RrAGvh
	 k8PX1UOMHjoewQLicxQpKX0t/aTlT7BsLimcG8SiAsT8mxzmVXhAwmMl2OO3OFXTg7
	 r5bfqx8yWCP4X7gJPUhnOLaegu0pWWFsNxjyv4Ila6q+KCVAY+hg+7x/fbq7mM9Kqm
	 Dfif4kc4qvab5OIFditOH5flk6ovpuod7PMkVMGLBfQcmS9EpjNdJ/2NJ9hvZoJfpC
	 6jwDq7oiF9stAZmPTDQZFX2a5KZPhOFidvwgKfP5JjhcaYJQc5MsobHP8yE6kMQLLP
	 Fki4vJFUinaEA==
Date: Fri, 8 Aug 2025 14:53:03 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>
Cc: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] riscv: Only allow LTO with CMODEL_MEDANY
Message-ID: <20250808215303.GA3695089@ax162>
References: <20250710-riscv-restrict-lto-to-medany-v1-1-b1dac9871ecf@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-riscv-restrict-lto-to-medany-v1-1-b1dac9871ecf@kernel.org>

Ping? This is still getting hit.

On Thu, Jul 10, 2025 at 01:25:26PM -0700, Nathan Chancellor wrote:
> When building with CONFIG_CMODEL_MEDLOW and CONFIG_LTO_CLANG, there is a
> series of errors due to some files being unconditionally compiled with
> '-mcmodel=medany', mismatching with the rest of the kernel built with
> '-mcmodel=medlow':
> 
>   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 899908), and 'i32 1' from vmlinux.a(net-traces.o at 1014628)
> 
> Only allow LTO to be performed when CONFIG_CMODEL_MEDANY is enabled to
> ensure there will be no code model mismatch errors. An alternative
> solution would be disabling LTO for the files with a different code
> model than the main kernel like some specialized areas of the kernel do
> but doing that for individual files is not as sustainable than
> forbidding the combination altogether.
> 
> Cc: stable@vger.kernel.org
> Fixes: 021d23428bdb ("RISC-V: build: Allow LTO to be selected")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506290255.KBVM83vZ-lkp@intel.com/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/riscv/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 36061f4732b7..4eee737a050f 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -68,7 +68,7 @@ config RISCV
>  	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
>  	select ARCH_SUPPORTS_HUGETLBFS if MMU
>  	# LLD >= 14: https://github.com/llvm/llvm-project/issues/50505
> -	select ARCH_SUPPORTS_LTO_CLANG if LLD_VERSION >= 140000
> +	select ARCH_SUPPORTS_LTO_CLANG if LLD_VERSION >= 140000 && CMODEL_MEDANY
>  	select ARCH_SUPPORTS_LTO_CLANG_THIN if LLD_VERSION >= 140000
>  	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS if 64BIT && MMU
>  	select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
> 
> ---
> base-commit: fda589c286040d9ba2d72a0eaf0a13945fc48026
> change-id: 20250710-riscv-restrict-lto-to-medany-f1b7dd5c9bba
> 
> Best regards,
> --  
> Nathan Chancellor <nathan@kernel.org>
> 

