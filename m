Return-Path: <stable+bounces-227567-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNBnLGluvWme9wIAu9opvQ
	(envelope-from <stable+bounces-227567-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 16:57:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B536C2DCF62
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 16:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE9E63006936
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 15:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E933CD8AF;
	Fri, 20 Mar 2026 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="F4SoQ/1Z"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB013BAD83;
	Fri, 20 Mar 2026 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774022242; cv=none; b=cuEeAyPBjQfBBRgoiEISsxYUJAvH9ONxxwc5tyzIAOlhXfRj3HAzlq7CVTPjLXgSefOaRyhcqshkSGmJ/LTnqtXY2EauNGUTJyFvBWE0L+JEQmEsx/VH/+GvUuHDEol8I53oTcUgmSBEpvkWlnZA+atfLPW5ArB98BAVNrU5WFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774022242; c=relaxed/simple;
	bh=/uQnmQVPBQYiWms+K9BQ1Zj/T4W06ne521hCjoxF/5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWTTZkq+dge/k4OQ2ccTFlBef58m86zldO9oBcy2BZClQdwOgQkEZJwQKRyfmPO2nPd7HFErvULqVP3f+kAtGVYQhNN3jP+HQRmpRhFrTIQI2Wrh3CgzGlrfeUIuLO09mLy9tLsSyKrVuBkqttTfxW5xewURGk6NdSHbYCSdhko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=F4SoQ/1Z; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8CAB940E0251;
	Fri, 20 Mar 2026 15:57:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id i_66GO8Hl-pe; Fri, 20 Mar 2026 15:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1774022234; bh=oK6vwbMjQIiUdNKsZRuAWsUjoKK5vttOS+cqd5buiAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F4SoQ/1ZCCAN46Y/6n7nC9Xgw35pEYUtEmr06Sbu7uWqtgoF+NlFhArtM4fb0EeYg
	 XzQMWFk0LFbHVdcaQ8Y8CuLtK5uQJSDAUI1R/MS52Biv2rtEjO/e8weNxOGjTpF6nq
	 LTpMJe68dgrteo1pGT0mzRtsjo3zLj0CQlpoFHg3hBs4Vjzis6JkPTQF6SrC3Dzcgc
	 /qv0n1FggvdE8Q1HVsUWs25WUAgB3mTvzfWe4mSH96xQrnZbRl6QX192jy/9zb6AEH
	 jFM6ae4kgKhUfppnZ5T6RU2Sb3wZwaDDKeh0RYT79BEfi7AHWGwNxJAliX6j/ig5Gg
	 7jeLbunK8Lg2bbAjkgWHWmhTZHSii0aXLF192MCTXaPw3D9Xs2VFXYf6JzN0WgojUn
	 ht6DyzR0fEW62CUpcUadEjrfQH3zJ1RjcLO8zHQWlRa81arYSo1dKeP54bAw+F5bPT
	 ewypeezs5qhKUXhqu880qTD8jPxmPKPVsuYhcA7ClVfd6PXDXAl4FSN2njJYAJybhK
	 3a/x7d+4W1D9jlb5FX2pBSvk0ZPHMJcc6HzE/48JRlyHgSQkiZDRtVJN6NpmPU8JBV
	 ZuL5TAuABQ8RJZKPV8C7jvmXkKCPhk0WwhD1R8ivJCfAQTPS8F7qI0ocFbnZg4djKK
	 2TlAgM89Jf+bf8aQDDB5a1pQ=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id DB6CD40E024F;
	Fri, 20 Mar 2026 15:57:04 +0000 (UTC)
Date: Fri, 20 Mar 2026 16:56:59 +0100
From: Borislav Petkov <bp@alien8.de>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: tglx@kernel.org, mingo@redhat.com, x86@kernel.org,
	linux-kernel@vger.kernel.org, dvyukov@google.com,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] x86/kexec: Disable KCOV instrumentation after
 load_segments()
Message-ID: <20260320155659.GDab1uSxYFWCUGcvbN@fat_crate.local>
References: <20260317220319.788561-1-nogikh@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260317220319.788561-1-nogikh@google.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227567-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[alien8.de:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fat_crate.local:mid,alien8.de:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B536C2DCF62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 11:03:19PM +0100, Aleksandr Nogikh wrote:
> The load_segments() function changes segment registers, invalidating
> GS base (which KCOV relies on for per-cpu data). When CONFIG_KCOV is
> enabled, any subsequent instrumented C code call (e.g.
> native_gdt_invalidate()) begins crashing the kernel in an endless
> loop.
> 
> To reproduce the problem, it's sufficient to do kexec on a
> KCOV-instrumented kernel:
> $ kexec -l /boot/otherKernel
> $ kexec -e
> 
> The real-world context for this problem is enabling crash dump
> collection in syzkaller. For this, the tool loads a panic kernel
> before fuzzing and then calls makedumpfile after the panic. This
> workflow requires both CONFIG_KEXEC and CONFIG_KCOV to be enabled
> simultaneously.
> 
> Adding safeguards directly to the KCOV fast-path
> (__sanitizer_cov_trace_pc()) is also undesirable as it would
> introduce an extra performance overhead.
> 
> Disabling instrumentation for the individual functions would be too
> fragile, so let's fix the bug by disabling KCOV instrumentation for
> the entire machine_kexec_64.c and physaddr.c. If coverage-guided
> fuzzing ever needs these components in the future, we should consider
						     ^^

Please use passive voice in your commit message: no "we" or "I", etc,
and describe your changes in imperative mood.

Also in the comments below.

> other approaches.
> 
> The problem is not relevant for 32 bit kernels as CONFIG_KCOV is not
> supported there.
> 
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
> Cc: stable@vger.kernel.org
> ---
> v2:
> Updated the comments to explain the underlying context.
> 
> v1:
> https://lore.kernel.org/all/20260216173716.2279847-1-nogikh@google.com/
> ---
>  arch/x86/kernel/Makefile | 10 ++++++++++
>  arch/x86/mm/Makefile     | 10 ++++++++++
>  2 files changed, 20 insertions(+)


./scripts/checkpatch.pl /tmp/current.patch 

...
 
WARNING: The commit message has 'stable@', perhaps it also needs a 'Fixes:' tag?

> 
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index e9aeeeafad173..41b1333907ded 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -43,6 +43,16 @@ KCOV_INSTRUMENT_dumpstack_$(BITS).o			:= n
>  KCOV_INSTRUMENT_unwind_orc.o				:= n
>  KCOV_INSTRUMENT_unwind_frame.o				:= n
>  KCOV_INSTRUMENT_unwind_guess.o				:= n
> +# Disable KCOV to prevent crashes during kexec: load_segments() invalidates
> +# the GS base, which KCOV relies on for per-CPU data.
> +# As KCOV && KEXEC compatibility should be preserved (e.g. syzkaller is
> +# using it to collect crash dumps during kernel fuzzing), we could either
> +# selectively disable KCOV instrumentation, which can be fragile, or add
> +# more checks to KCOV, which would slow it down.
> +# As a compromise solution, let's disable KCOV instrumentation for the
> +# whole file. If its coverage is ever needed, we should consider other
> +# approaches.
> +KCOV_INSTRUMENT_machine_kexec_64.o			:= n
>  
>  CFLAGS_head32.o := -fno-stack-protector
>  CFLAGS_head64.o := -fno-stack-protector
> diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
> index 5b9908f13dcfd..ea3a31b54e49e 100644
> --- a/arch/x86/mm/Makefile
> +++ b/arch/x86/mm/Makefile
> @@ -4,6 +4,16 @@ KCOV_INSTRUMENT_tlb.o			:= n
>  KCOV_INSTRUMENT_mem_encrypt.o		:= n
>  KCOV_INSTRUMENT_mem_encrypt_amd.o	:= n
>  KCOV_INSTRUMENT_pgprot.o		:= n
> +# Disable KCOV to prevent crashes during kexec: load_segments() invalidates
> +# the GS base, which KCOV relies on for per-CPU data.
> +# As KCOV && KEXEC compatibility should be preserved (e.g. syzkaller is
> +# using it to collect crash dumps during kernel fuzzing), we could either
> +# selectively disable KCOV instrumentation, which can be fragile, or add
> +# more checks to KCOV, which would slow it down.
> +# As a compromise solution, let's disable KCOV instrumentation for the
> +# whole file. If its coverage is ever needed, we should consider other
> +# approaches.

Instead of repeating this big comment block, just say something along the
lines of:

# See "Disable KCOV" comment in arch/x86/kernel/Makefile

> +KCOV_INSTRUMENT_physaddr.o		:= n
>  
>  KASAN_SANITIZE_mem_encrypt.o		:= n
>  KASAN_SANITIZE_mem_encrypt_amd.o	:= n
> 
> base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
> -- 

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

