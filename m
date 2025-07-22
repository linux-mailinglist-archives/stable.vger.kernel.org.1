Return-Path: <stable+bounces-163643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C042CB0D0DF
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 06:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C0F3BF5B2
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 04:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF831DF247;
	Tue, 22 Jul 2025 04:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gwd+R0cO"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B15622EF4;
	Tue, 22 Jul 2025 04:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753158168; cv=none; b=ldfhj+MaWyE5tWAXFAGWOVBf60WFXMjUmMYsX8mIyayQAGUtxaE5OVkZJxquMXDTFqqJicBi34yoZtLxmSaT9s83TxcUd9EG9vP7Cj0MpABgr6JHsLE96Vpci4NaxHCdcjQVYgvYg8//oYNbJpAoiLkx/ZMoqGHLoRRdnM5PZWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753158168; c=relaxed/simple;
	bh=cfPJuk0o4vsCqdMkcZ4oBmnUMIJoiy9Luf/3kfpGLGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gR5yydfgToT5zLwwMz8AdnAYpFMVUM9u4toFRV+it8KTJcyUjfFMFy6DnJeYRoztwepT6NEiDGwGjc8tz6oHrIErY+GsimXPU3+L0a3/wxuInyO4VsQMlHf2M+40YIExbB3D9ROHV3K2L+zObF01I9INxsas5oaTn2IUkmmDaBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gwd+R0cO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 75CE940E0257;
	Tue, 22 Jul 2025 04:22:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id z7Kv2FnvKOfR; Tue, 22 Jul 2025 04:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1753158158; bh=cs3S2e7h0WG904CGjnFsYVwouZTWTl18WW7+GaIg4bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gwd+R0cOL967Jasj3yXDec+XLojDDMC4o7McC/JYeU8kH0rBzFAZNZ8Dt0Bi8IJQ2
	 3aW8/3+Uw0+YacNoLwlJ4rtqQO+BRy/z8W+lDeWmMRPEcqI8zpMa1VvDwghgNRIY+x
	 0rIeRe9Bqipra94r3hgPevf08xAiQDE27ABSo2wmRDKSud3zfCzWO/9irPp3J4fH/N
	 pzsc1PJ9e2upp4cjV9L2l3iS/IqN3Fw5ZOq451mhFLRGKQKLP9b4cdvWNHnnSa1W5y
	 NSsVIJgyyxd/K1JVbVJlEe8ytbXpyADktRTS/vsLyLYonrTK4RjHUjtovLMcHgLGZD
	 cqI8mzu0UxMG5AvvAk9aOU9PZaN9FNc9cJe7WxftDNgQf5W08AsCC7YDMBcwXjKERL
	 1kFUU8+AWg6kTWcpulZ25vnowBkHrGhqbBj8BF/oraJ8oknRKkesKSdAMClF0acX02
	 TIxCwAOsSItkME0yY+SCIdUUVUHVLKboOFGccr/VPAhxwbGoqANwBcSPhgOw2AmKqd
	 KDtOHMs5cPOg4zwFSoByUv4/EbT6y6bnOlRFVOyRMuqnG210uS81CPrIcK9yc/N3n4
	 +q3ijN3tqKdXAD5auSNAMlsZQTjIe+b43X4E3h+boEvHoJDLewOUV/wv3p4bqtEDoQ
	 uJ1xVmpwL2EFQffUh3xgNaag=
Received: from rn.tnic (unknown [78.130.214.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 1458640E021A;
	Tue, 22 Jul 2025 04:22:30 +0000 (UTC)
Date: Tue, 22 Jul 2025 06:24:31 +0200
From: Borislav Petkov <bp@alien8.de>
To: Michael Zhivich <mzhivich@akamai.com>
Cc: stable@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/bugs: Fix use of possibly uninit value in
 amd_check_tsa_microcode()
Message-ID: <20250722042431.GAaH8Sf1CuHB1JRgk9@renoirsky.local>
References: <20250721230712.2093341-1-mzhivich@akamai.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250721230712.2093341-1-mzhivich@akamai.com>

On Mon, Jul 21, 2025 at 07:07:12PM -0400, Michael Zhivich wrote:
> Note: I believe this change only applies to stable backports.

Right, I need to go look in detail which of the 5.10-6.12 stable trees
which got this variant, do have CONFIG_INIT_STACK_NONE.

> For kernels compiled with CONFIG_INIT_STACK_NONE=y, the value of __reserved
> bitfield in zen_patch_rev union on the stack may be garbage.  If so, it will
> prevent correct microcode check when consulting p.ucode_rev, resulting in
> incorrect mitigation selection.

Uuuh, nasty. Good catch.

> Signed-off-by: Michael Zhivich <mzhivich@akamai.com>
> Fixes: 7a0395f6607a ("x86/bugs: Add a Transient Scheduler Attacks mitigation")
> ---
>  arch/x86/kernel/cpu/amd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index efd42ee9d1cc..91b21814ce8c 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -371,7 +371,7 @@ static void bsp_determine_snp(struct cpuinfo_x86 *c)
>  static bool amd_check_tsa_microcode(void)
>  {
>  	struct cpuinfo_x86 *c = &boot_cpu_data;
> -	union zen_patch_rev p;
> +	union zen_patch_rev p = {0};

Instead of doing this...

>  	u32 min_rev = 0;
>  
>  	p.ext_fam	= c->x86 - 0xf;

... you should assign __reserved here to 0 too and put a comment above
it why we're doing that.

This will save us the init writes to 0 which get overwritten with the
actual f/m/s anyway.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

