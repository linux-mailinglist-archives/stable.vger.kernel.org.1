Return-Path: <stable+bounces-136625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469FBA9B935
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 22:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6AC3BDBAF
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 20:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737801F3D54;
	Thu, 24 Apr 2025 20:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bQsFBvl+"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA32F1D2F42;
	Thu, 24 Apr 2025 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745526642; cv=none; b=F+QDncOn/CntH9so4nLw2RjrGpAMk9+7PXCJwgQJfGse6Q35aXwb2y7iKduvrEBtj/jE891Vl0Mtfkt2xBaX8tsvOWEXCecERA3Zf/nV8lqeqFwEL4qQFzZpaRVMfjLyhvPKmtnPqQkQTbJAWtZgWC8GUUMf0zazBQVGNmZ+OFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745526642; c=relaxed/simple;
	bh=gAKWSAUQ7FLOWukceix3heMfrJNXJb1HPXDD4pZrSX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKUt+OaiUGO2mkeV7qsRa/+XvQPCz/wBuHz70WpsstEqrlaGQTqjY1kHg01635x/uVLkwi1CcrgqeSU363SokoWtmaSo9BI/bM3YxgTOuXIILA6r2oiCvfW8JxLbboJaZp2XVoN8q6Y1mqt00bH2FK1jI3k91LygHs9uue1MBjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bQsFBvl+; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 941A240E0219;
	Thu, 24 Apr 2025 20:30:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WiFye442yIhk; Thu, 24 Apr 2025 20:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1745526631; bh=Ib1wSk3a9DIy+unIt6p2W4sLFO/o2s9rqJW+y1qXwcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bQsFBvl+AkSM4x7SBRcn+dKyr57ofnWcEz0uqeBqaXKbiq01y1Seu0XuRLRuMi9dy
	 epOk8CxYLES0MwOmFnLCojwU3jWOURQ+RaCQqlIbTcs9wzEMfin9zdVFCqj1319uKK
	 Q0IwA0bTi7+Qnoj+ObkAunMvEzIMG8WTA9sDTCfLqUpm2Q0oygJx3ctm0uNQGZ6ScJ
	 bbdsPowBejEQf1ldO50BEU3HEMX6KfEyLxFOTzQuaSQuUh4WLWm8DvIS2BzPdB76eR
	 8XjdKbe7vJ3A7WbEIaZHbOPuMsMUUT8EokXL3dJijXuCTMzj/FGNST1w8/j5qN8eP9
	 5GCKTzzJSiZj42vZlF6P0ga0mfRMsw6+lR0UUidUjUoaw94PsEpnjfsKxuFe+8B4Ij
	 bG/4Avr9+ZbrUZ7vEOqAYoqoQDwnnKaV+WrSRVkgsnocEwarvFZsF80KsQti1LmQwR
	 saidlImrtAqHPKOpHF1P4YgIoXZc/GoGv0YEO7wvhZkWoMTHCdzrolVZucrznBDmff
	 +QCggn8pxoFwrwA1KZq0Txx5XrmyzeF++NcX14gWjykwQPR2jvBB2fqMEBjpCsNl4r
	 UpeQMjNtMkTZwvmayyTX1DIi8b999aMkcmrxXr70yxbqZHC40HOJBDYoUt9+5pCdxR
	 2ZCqsg3CVN5hR74hLKyx3TCQ=
Received: from rn.tnic (unknown [IPv6:2a02:3031:201:2677:b4a0:48b8:e35c:ca37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 010D440E01FF;
	Thu, 24 Apr 2025 20:30:12 +0000 (UTC)
Date: Thu, 24 Apr 2025 22:31:10 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Pavel Machek <pavel@denx.de>, Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Max Grobecker <max@grobecker.info>, Ingo Molnar <mingo@kernel.org>,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, thomas.lendacky@amd.com, perry.yuan@amd.com,
	mario.limonciello@amd.com, riel@surriel.com, mjguzik@gmail.com,
	darwi@linutronix.de, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: CONFIG_X86_HYPERVISOR (was: Re: [PATCH AUTOSEL 5.10 2/6]
 x86/cpu: Don't clear X86_FEATURE_LAHF_LM flag in init_amd_k8() on AMD when
 running in a virtual machine)
Message-ID: <20250424203110.GCaAqfjnr-fogRgnt7@renoirsky.local>
References: <20250418173643.GEaAKNq_1Nq9PAYf4_@fat_crate.local>
 <aAKaf1liTsIA81r_@google.com>
 <20250418191224.GFaAKkGBnb01tGUVhW@fat_crate.local>
 <aAfQbiqp_yIV3OOC@google.com>
 <20250422173355.GDaAfTA8GqnGBfDk7G@renoirsky.local>
 <aAfynEK3wcfQa1qQ@google.com>
 <20250423072017.GAaAiUsYzDOdt7cmp2@renoirsky.local>
 <aAj0ySpCnHf_SX2J@google.com>
 <20250423184326.GCaAk0zinljkNHa_M7@renoirsky.local>
 <aAqOmjQ_bNy8NhDh@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aAqOmjQ_bNy8NhDh@google.com>

On Thu, Apr 24, 2025 at 12:18:50PM -0700, Sean Christopherson wrote:
> Not quite.  KVM supports all of those seamlessly, with some caveats.  E.g. if
> host userspace and guest kernel are trying to use the same DRx, the guest will
> "lose" and not get its #DBs.

Pff, so cloud providers have big fat signs over their workstations
saying: you're not allowed to use breakpoints on production systems?

With my silly thinking, I'd prefer to reglement this more explicitly and
actually have the kernel enforce policy:

HV userspace has higher prio with #DB or guests do. But the "losing" bit
sounds weird and not nice.

> Definitely not.  All I was thinking was something like:
> 
> diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
> index fdbbbfec745a..a218c5170ecd 100644
> --- a/arch/x86/include/asm/debugreg.h
> +++ b/arch/x86/include/asm/debugreg.h
> @@ -121,7 +121,7 @@ static __always_inline unsigned long local_db_save(void)
>  {
>         unsigned long dr7;
>  
> -       if (static_cpu_has(X86_FEATURE_HYPERVISOR) && !hw_breakpoint_active())
> +       if (static_cpu_has(X86_FEATURE_DRS_MAY_VMEXIT) && !hw_breakpoint_active())
>                 return 0;
>  
>         get_debugreg(dr7, 7);
> 
> Where X86_FEATURE_DRS_MAY_VMEXIT is set if HYPERVISOR is detected, but then
> cleared by SEV-ES+ and TDX guests with guaranteed access to DRs.  That said,
> even that much infrastructure probably isn't worth the marginal benefits.

Btw you can replace that X86_FEATURE_DRS_MAY_VMEXIT with a cc_platform
flag which gets properly set on all those coco guest types as those
flags are exactly for that stuff.

In any case, I don't see why not. It is easy enough and doesn't make
things worse, API-wise.

Care to send a proper patch with rationale why?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

