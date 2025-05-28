Return-Path: <stable+bounces-147990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C004AC6F5B
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 19:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334539E5F55
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 17:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D539C28689D;
	Wed, 28 May 2025 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AerQ9T1a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EE44A1D;
	Wed, 28 May 2025 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748453247; cv=none; b=Nn/0SCIaOrU0XHlbqMpVXagvwq9cn2Rhk3jIZFoFYVwuXYo5G1Y5vx9q0HSJr0OuiMPcts9i5wPrLcRVWlgsN9b79jfAwoI4qpMjXrqEMRFqsNydtFTrldmp+E79MyxPGjYQTwSt5wqSrVIV+MTBcA993LG78biMV/9kKTceiwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748453247; c=relaxed/simple;
	bh=BvuHSqastd/tLDidor2pHbxYqt/EefP7zS28DYrkHP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M80xBlYHU/rt8/ElPIBSbOujqg8WgeGRUQefJs5timkVIBEq0eAd2c7k05sl+X33LwiMcQGUqPT/yUQ3j09SwGQIqwOQY5uwsmjrHKDd8VBdJKA/juCfUgaQkxFRXIYxg87Hq+WyuUouNE6MXI5o1PetnW7DH2WI1A+xSwiiJmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AerQ9T1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B6DC4CEE3;
	Wed, 28 May 2025 17:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748453247;
	bh=BvuHSqastd/tLDidor2pHbxYqt/EefP7zS28DYrkHP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AerQ9T1ac0tlxfxcul8JTWvqk40fxhxUYpFoH+o4D07uPLYJYadzp7VPL/u9ikHAN
	 +ihvq98iO93/HZ3oz71vrJLfgCt/Q9B6izW9boUlpn2PXFDF6b7KplO5psqaO5FuU+
	 AkpqQCgrtAtHlONXpnG+rUuFXoxZpJhLg1yp5zgx7hROHWO+kgysaMQsU5muA0WFJG
	 jV9MvBPQbxt6xsGRqN5LMe3v8HfqwwainaBC4mE/GNb6ZmemYd8OKXL6s8UvjUJQ51
	 aD8rdhXv9XEA8sFOtOXv+xQ7K0XZTVVpUYnpZjwiLMwJRsHXcP75UDgGyy8h2uhshg
	 MJ8fLFYcf3lWQ==
Date: Wed, 28 May 2025 20:27:19 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, xin@zytor.com,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] x86/execmem: don't use PAGE_KERNEL protection for
 code pages
Message-ID: <aDdHdwf8REvdu5FF@kernel.org>
References: <20250528123557.12847-1-jgross@suse.com>
 <20250528123557.12847-2-jgross@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528123557.12847-2-jgross@suse.com>

On Wed, May 28, 2025 at 02:35:55PM +0200, Juergen Gross wrote:
> In case X86_FEATURE_PSE isn't available (e.g. when running as a Xen
> PV guest), execmem_arch_setup() will fall back to use PAGE_KERNEL
> protection for the EXECMEM_MODULE_TEXT range.
> 
> This will result in attempts to execute code with the NX bit set in
> case of ITS mitigation being applied.
> 
> Avoid this problem by using PAGE_KERNEL_EXEC protection instead,
> which will not set the NX bit.
> 
> Cc: <stable@vger.kernel.org>
> Reported-by: Xin Li <xin@zytor.com>
> Fixes: 5185e7f9f3bd ("x86/module: enable ROX caches for module text on 64 bit")
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index 7456df985d96..f5012ae31d8b 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -1089,7 +1089,7 @@ struct execmem_info __init *execmem_arch_setup(void)
>  		pgprot = PAGE_KERNEL_ROX;
>  		flags = EXECMEM_KASAN_SHADOW | EXECMEM_ROX_CACHE;
>  	} else {
> -		pgprot = PAGE_KERNEL;
> +		pgprot = PAGE_KERNEL_EXEC;

Please don't. Everything except ITS can work with PAGE_KENREL so the fix
should be on ITS side. 

>  		flags = EXECMEM_KASAN_SHADOW;
>  	}
>  
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.

