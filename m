Return-Path: <stable+bounces-143040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CDEAB10FC
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 12:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87861C2547C
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 10:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0110C21D3EF;
	Fri,  9 May 2025 10:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="N3fDS+hm"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFABB28F51F;
	Fri,  9 May 2025 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787514; cv=none; b=qEgL9HpN3vDMz+KiMj+CgSdRT1EcFyqXDaBWv1dYJlN+/Iktv4E9rnRvf9OYRRyGQtrq9htkaKVzaH+TG4SrREzdJnCyHnGatL2X95OUGLrOmQI2LsP+az3aVgLMHMHgk/5BOCgDCALmNcCxm4cFB1rHllH08jb3WEwyIYb36bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787514; c=relaxed/simple;
	bh=J0R085KxdN2eA0ziT4kp9Pv3r3T+JFpzEc9TfAOlb3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RU1XiSmUwxr+4icL9t9cKOiRwLZeHXUtYJxbdAoSSawGGteeSOk1DfUjE+8vdYYnhG1cL/hL0s/nMmLCYlOv6vCW6D5Fxv+o7KhkMwO65lQs+EZbXmUsb9eYz+OnJ47uolFCnuOWJ4s+9n2SYQ8LOXwGLarj76XvPeQRY+E+pek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=N3fDS+hm; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DFB7040E01FA;
	Fri,  9 May 2025 10:45:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GdDCXDC1iPDN; Fri,  9 May 2025 10:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1746787503; bh=dwE9OGu7iwJrUb/YEJOzLU4pWDCbvE0L6Byfl3N88FU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N3fDS+hm60VcT0Yx5axAUD6WCNxuAy3xmXFWugxtCLlAwvZxBYA79dgYHn8MwTfyB
	 CheBWQL0E4JGk//ZdyRmfuy9WjF8e/0Z5TfVoz/yYEgHcpGd1UZveRZfN2OgVVshZ5
	 T2hhD+u0V/ZJOxMDDxMbkHpGjSC6nMeJ+TqyAvsPqNYI13gaS5s130pP1vkqssaXb5
	 v6mFBXF48G/U+9RE4TpG7635nQvCF6CQ9gJlyzvJ0/p5EIH7GNrYmSPWUB8d6HZeKl
	 MgeBU9a5tOJoEdJojnb+liu5gtj82xssCw5l0/AHjqlO+o4cvgu7UVm19Ito3Ahlbj
	 PapZAgTnDLRONcFo9OlTEY/eBdrI/h0CIawgo5ZtTyzbibLbEpTZ8wM0sqh7G09gkb
	 b34ZfGXybc1yC7kgftqv6TqDl/JQoAKdHEQFeV5qfkSs39GrLW6oYMaZNnuloIgCZW
	 lI4PqA3cyJA9wwATZWN+0IPoxX5vf0f7uQ4zIStDr66FzcFoHXcQUpxvz+QgCbM/rS
	 W2jslPZpZ/keJ/Q+AIc32ss4HiEfst4+n6lxh8RCn9t+p2aCts1sb+WcMeJd5UOOp1
	 vzPO9WWbj9pV32VRQ/28MuXNEnA/VKYThstiQhozJl+A/d9G8V86twx14dUnPUs7FX
	 3fqm11BJG93clEkUz1t+n0YA=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DB8F440E01CF;
	Fri,  9 May 2025 10:44:51 +0000 (UTC)
Date: Fri, 9 May 2025 12:44:45 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Bernhard Kaindl <bk@suse.de>,
	Andi Kleen <ak@linux.intel.com>, Li Fei <fei1.li@intel.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mtrr: Check if fixed-range MTRR exists in
 `mtrr_save_fixed_ranges`
Message-ID: <20250509104445.GBaB3cnZnqCy-Vv6CR@fat_crate.local>
References: <20250509085612.2236222-2-jiaqing.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250509085612.2236222-2-jiaqing.zhao@linux.intel.com>

On Fri, May 09, 2025 at 08:56:12AM +0000, Jiaqing Zhao wrote:
> When suspending, `save_processor_state` calls `mtrr_save_fixed_ranges`

Put () after the function names and drop the ``.

> to save fixed-range MTRRs. On platforms without MTRR or fixed-range
> MTRR support, accessing MTRR MSRs triggers unchecked MSR access error.
> Make sure fixed-range MTRR is supported before access to prevent such
> error.
> 
> Fixes: 3ebad5905609 ("[PATCH] x86: Save and restore the fixed-range MTRRs of the BSP when suspending")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
> ---
>  arch/x86/kernel/cpu/mtrr/generic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
> index e2c6b471d230..ca37b374d1b0 100644
> --- a/arch/x86/kernel/cpu/mtrr/generic.c
> +++ b/arch/x86/kernel/cpu/mtrr/generic.c
> @@ -593,7 +593,7 @@ static void get_fixed_ranges(mtrr_type *frs)
>  
>  void mtrr_save_fixed_ranges(void *info)
>  {
> -	if (boot_cpu_has(X86_FEATURE_MTRR))
> +	if (boot_cpu_has(X86_FEATURE_MTRR) && mtrr_state.have_fixed)

Does it work too if you check only mtrr_state.have_fixed?

Without the feature check...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

