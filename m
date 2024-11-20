Return-Path: <stable+bounces-94435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAD99D3ED5
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 16:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61EDA281BF2
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 15:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1A81C8797;
	Wed, 20 Nov 2024 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3aS6CeO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CE5149C42;
	Wed, 20 Nov 2024 15:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732115623; cv=none; b=b2eHAj8Mbc32qxhb4XVHZZBjFAigZZw3LTGirdVKHz5FvW+QqdIb/myU3mkDNYecnjhkYmIFXc9u3tm4bw4brOGs147PvSboUFyJSWZi1w4suYsy4QJm2DoNyWuFKYTwHcUzB4MfzMr/BXXElKYrIlOBbZqLfG/w6ikcJgy3FQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732115623; c=relaxed/simple;
	bh=yYsWTQBIMD66SABAUXfCYw2uFwXuceiArk0rR9d0OxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhKz/quvPeZwxWjsKtvp3HZZBdASOv8cR337L4f7afRl2LSq5qMf6vJOLaEg/Fq/T1sv0wFE/pHAP4Wp3zppMM181I55Vb7X+qjkdKVW9X0dnUJ3SRWJyhgvRozt4iMF6rRs2+eO3JB5HiuZ7F698gmsG5cRaUKClzKm4dnz4hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3aS6CeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245D4C4CECD;
	Wed, 20 Nov 2024 15:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732115620;
	bh=yYsWTQBIMD66SABAUXfCYw2uFwXuceiArk0rR9d0OxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g3aS6CeOXkJpy+IgbAMv19UCKWR0mwxWb4lKwmER/FXkWvVOe3dWB/5N3XWRj81XD
	 LTFeVjm2lq/Of7hrUKd9kxfvOk1JL1QS//3XUvmU/7OMCYsRs17cIxOm9qB8u0bs+X
	 JOVkcJ6MJnlrZJJbOo4kMspZU0UvXqxE6cnSmUuYnTcPcyhz0ChVjXvPI57/pc9Wm0
	 CH19C2eqyPZMjZtXoWizJbDurUwIpBCO25n4Fen8Mrp+8nDRWzbQNys/ux+nuanRQw
	 Q42AE1k8INrejX3OP2gNGAq0nWPUKA9yZSQyRrXJWgHRNsUta47UjwgaJRJZNUM6yG
	 BOx8Nvl2eyaeQ==
Date: Wed, 20 Nov 2024 08:13:38 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	kernel test robot <lkp@intel.com>,
	Russell King <rmk+kernel@armlinux.org.uk>, linux@armlinux.org.uk,
	arnd@arndb.de, samitolvanen@google.com,
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH AUTOSEL 6.6 5/6] ARM: 9434/1: cfi: Fix compilation corner
 case
Message-ID: <20241120151338.GA3158726@thelio-3990X>
References: <20241120140647.1768984-1-sashal@kernel.org>
 <20241120140647.1768984-5-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120140647.1768984-5-sashal@kernel.org>

Hi Sasha,

On Wed, Nov 20, 2024 at 09:06:35AM -0500, Sasha Levin wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> [ Upstream commit 4aea16b7cfb76bd3361858ceee6893ef5c9b5570 ]
> 
> When enabling expert mode CONFIG_EXPERT and using that power
> user mode to disable the branch prediction hardening
> !CONFIG_HARDEN_BRANCH_PREDICTOR, the assembly linker
> in CLANG notices that some assembly in proc-v7.S does
> not have corresponding C call sites, i.e. the prototypes
> in proc-v7-bugs.c are enclosed in ifdef
> CONFIG_HARDEN_BRANCH_PREDICTOR so this assembly:
> 
> SYM_TYPED_FUNC_START(cpu_v7_smc_switch_mm)
> SYM_TYPED_FUNC_START(cpu_v7_hvc_switch_mm)
> 
> Results in:
> 
> ld.lld: error: undefined symbol: __kcfi_typeid_cpu_v7_smc_switch_mm
> >>> referenced by proc-v7.S:94 (.../arch/arm/mm/proc-v7.S:94)
> >>> arch/arm/mm/proc-v7.o:(.text+0x108) in archive vmlinux.a
> 
> ld.lld: error: undefined symbol: __kcfi_typeid_cpu_v7_hvc_switch_mm
> >>> referenced by proc-v7.S:105 (.../arch/arm/mm/proc-v7.S:105)
> >>> arch/arm/mm/proc-v7.o:(.text+0x124) in archive vmlinux.a
> 
> Fix this by adding an additional requirement that
> CONFIG_HARDEN_BRANCH_PREDICTOR has to be enabled to compile
> these assembly calls.
> 
> Closes: https://lore.kernel.org/oe-kbuild-all/202411041456.ZsoEiD7T-lkp@intel.com/
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/arm/mm/proc-v7.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index 193c7aeb67039..bea11f9bfe856 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -93,7 +93,7 @@ ENTRY(cpu_v7_dcache_clean_area)
>  	ret	lr
>  ENDPROC(cpu_v7_dcache_clean_area)
>  
> -#ifdef CONFIG_ARM_PSCI
> +#if defined(CONFIG_ARM_PSCI) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
>  	.arch_extension sec
>  ENTRY(cpu_v7_smc_switch_mm)

This patch is unnecessary in branches prior to 6.10 (when ARM started
supporting kCFI) because SYM_TYPED_FUNC_START() is not used here. I
would just drop it for 6.6 and earlier.

>  	stmfd	sp!, {r0 - r3}
> -- 
> 2.43.0
> 

