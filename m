Return-Path: <stable+bounces-135243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE37BA9806E
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 09:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66FDA3B8280
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 07:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F9A2676F6;
	Wed, 23 Apr 2025 07:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NQ8+cnkG"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823771804A;
	Wed, 23 Apr 2025 07:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745392799; cv=none; b=EXCQAeM49nC0O5NCAOhsp8Zk2Q8j1wS2E1FeSfuo8SUbpUhKMIie0LgIQsP4iK432SKOA3CzaB5Y4SVckxmT/w4nIXVnQhDBi7uSccHNF4OQitDZ2HZSc2twUS8fM0RXhkx8gZFNlXspQvHggo3wmqWRTjd2fQdvt0rojgPGcr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745392799; c=relaxed/simple;
	bh=ZqKb4KfZdHLqN8QcKD/n4J4k5vR2V9otqeu0Vg3KTbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNcSyaeAwbsNSzuRNCUifeOXY/hIatZPH5M+Fme/ODosmzs23imL6rnOUe9gmmqeun6450x4bZ594SzSUbX2vT8GiiIBL6QnP50ChA6JfbMEFMzPMUuJUsn1DGVFjgQQk5VlrHcnT3jqGgFZ0gF+aBKk7v/tAweaRrgOGBAU+QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NQ8+cnkG; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9285540E01F6;
	Wed, 23 Apr 2025 07:19:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cHymMcxZwE16; Wed, 23 Apr 2025 07:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1745392782; bh=ftPP4S08awu8zTTxtnw7w5uCGyDy/BG+0Tm6c4TrMFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NQ8+cnkGkVthrltApFRLpqFTwWHXryWzaqt19jJgWuWJwEkW5aUeGTlM2pJ2vcMmE
	 8nn7LQnVAuR/+XdNKrYRKXFyEAzKmHleVb4QhQHRYFKwBUWSEpHJ8zPreqb7KqQ5Vb
	 358tc/7hJTrKtAkv5rGqIybklmU77y/hNzyHv6OWjYzYDNgubM0fV3xgDgmb7YGTFp
	 mZOovIIHYymKopahGdDVMMPyQkulQ9qfHZtbqODBt9iMCBAVtM/TdxFIf/KY8Q0LgV
	 6SHIZFLHGV3GDUYiOh6XNtqPvbjfpjPZfa6Ix3CNQ1s6DBFV5Sqri+CCc5nxKZNFe0
	 4u5YvXFi2Hx/0yAHVlcgxbLNoa2Mz18UA/kmHvS9b6D8+dkQIHwY5Nq0DCQMsiUNDR
	 q3zF3eII5seRUoy4+MHu0jjg9DsK0b4QZd1etBl4XMeHgxDkuDYOdPVxIRt/jygCxq
	 ivK3rYJfmCZzVuzWwatkFO6V3qZ34wEAqtwuY9OVGRKjfg72wOHS8SNoHv7hnZEQdH
	 xZfktkmoLZa69BVhvhkNVm78QqBa4MXb1t5zGQeqVe24TNvWxsVmKDF1dpQl6IxXG0
	 oXkch8Vet7YREH+VgT2qVMg3a5tiNpmtXfE8PhmTj5iZAN4wDfALUitnuFRu9cmb3/
	 KNn9wxuQAGJ9uZT/Z7x4oeA4=
Received: from rn.tnic (unknown [IPv6:2a02:3037:313:bdc3:3c28:7053:13ff:2420])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id C1F5540E01FE;
	Wed, 23 Apr 2025 07:19:22 +0000 (UTC)
Date: Wed, 23 Apr 2025 09:20:17 +0200
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
Message-ID: <20250423072017.GAaAiUsYzDOdt7cmp2@renoirsky.local>
References: <20250331143710.1686600-1-sashal@kernel.org>
 <20250331143710.1686600-2-sashal@kernel.org>
 <aAKDyGpzNOCdGmN2@duo.ucw.cz>
 <aAKJkrQxp5on46nC@google.com>
 <20250418173643.GEaAKNq_1Nq9PAYf4_@fat_crate.local>
 <aAKaf1liTsIA81r_@google.com>
 <20250418191224.GFaAKkGBnb01tGUVhW@fat_crate.local>
 <aAfQbiqp_yIV3OOC@google.com>
 <20250422173355.GDaAfTA8GqnGBfDk7G@renoirsky.local>
 <aAfynEK3wcfQa1qQ@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aAfynEK3wcfQa1qQ@google.com>

On Tue, Apr 22, 2025 at 12:48:44PM -0700, Sean Christopherson wrote:
> I did a quick pass.

You couldn't resist, I know. Doing something else for a change is
always cool.

:-P

> Most of the usage is "fine".  E.g. explicit PV code, cases
> where checking for HYPERVISOR is the least awful option, etc.
> 
> Looks sketchy, might be worth investigating?

Oh, I will, it is on my
do-this-while-waiting-for-compile/test-to-finish. ;-P

> --------------------------------------------
>   arch/x86/kernel/cpu/amd.c:              if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&

So that first one is to set CC_ATTR_HOST_SEV_SNP when we really are
a SNP host. I'll go through the rest slowly.

>   arch/x86/kernel/cpu/amd.c:      if (!cpu_has(c, X86_FEATURE_HYPERVISOR) && !cpu_has(c, X86_FEATURE_IBPB_BRTYPE)) {
>   arch/x86/kernel/cpu/amd.c:      if (c->x86_model < 0x14 && cpu_has(c, X86_FEATURE_LAHF_LM) && !cpu_has(c, X86_FEATURE_HYPERVISOR)) {
>   arch/x86/kernel/cpu/amd.c:      if (!cpu_has(c, X86_FEATURE_HYPERVISOR)) {
>   arch/x86/kernel/cpu/amd.c:      if (!cpu_has(c, X86_FEATURE_HYPERVISOR)) {
>   arch/x86/kernel/cpu/amd.c:      if (cpu_has(c, X86_FEATURE_HYPERVISOR))
>   arch/x86/kernel/cpu/amd.c:      if (!cpu_has(c, X86_FEATURE_HYPERVISOR)) {
>   arch/x86/kernel/cpu/amd.c:      if (!cpu_has(c, X86_FEATURE_HYPERVISOR))
>   arch/x86/kernel/cpu/topology_amd.c:             if (!boot_cpu_has(X86_FEATURE_HYPERVISOR) && tscan->c->x86_model <= 0x3) {
>   arch/x86/mm/init_64.c:  if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
>   arch/x86/mm/pat/set_memory.c:   return !cpu_feature_enabled(X86_FEATURE_HYPERVISOR);
>   drivers/platform/x86/intel/pmc/pltdrv.c:        if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR) && !xen_initial_domain())
>   drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c: if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
> --------------------------------------
> 
> 
> Could do with some love, but not horrible.
> ------------------------------------------
> Eww.  Optimization to lessen the pain of DR7 interception.  It'd be nice to clean
> this up at some point, especially with things like SEV-ES with DebugSwap, where
> DR7 is never intercepted.
>   arch/x86/include/asm/debugreg.h:        if (static_cpu_has(X86_FEATURE_HYPERVISOR) && !hw_breakpoint_active())
>   arch/x86/kernel/hw_breakpoint.c:                 * When in guest (X86_FEATURE_HYPERVISOR), local_db_save()

Patch adding it says "Because DRn access is 'difficult' with virt;..."
so yeah. I guess we need to agree how to do debug exceptions in guests.
Probably start documenting it and then have guest and host adhere to
that. I'm talking completely without having looked at what the code does
but the "handshake" agreement should be something like this and then we
can start simplifying code...

> This usage should be restricted to just the FMS matching, but unfortunately
> needs to be kept for that check.
>   arch/x86/kernel/cpu/bus_lock.c: if (boot_cpu_has(X86_FEATURE_HYPERVISOR))

I have no idea why that was added - perhaps to avoid split-lock related
#ACs on guests...

/does more git archeology...

Aha, I see it: 6650cdd9a8ccf

Although this doesn't explicitly comment on the guest aspect...

Anyway, thanks for the initial run-thru - I'll keep coming back to this
as time provides and we can talk.

Others reading are ofc more than welcome to do patches...

;-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

