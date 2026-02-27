Return-Path: <stable+bounces-219960-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HE1ELKcoWl8ugQAu9opvQ
	(envelope-from <stable+bounces-219960-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 14:31:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B211B7AF7
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 14:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 178C4314C807
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 13:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0E8259C9C;
	Fri, 27 Feb 2026 13:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OENxZMjr"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACEC223339
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772198775; cv=pass; b=oZcXnwrAeHqsIl4qY6fSVdALUbPdUa21/LfE05MeSnk4GFgQGI0F5wPsbinoopKTowXZLNK9AKN7JkQ8MgXQCDSa6EeMraQxZrmWLlYMZL5gSOUjlh6fdCk1ChkuEsBvVWqPoIu+6PsBieHSI9SJ1XjicXuG3NcYJZdHo2LZMwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772198775; c=relaxed/simple;
	bh=VDwNG4v6HLI+nVH5KLdPo0KApT5xPbldBj5L3AF/lQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2FIrk77Y1vHsqbiYk7bV6UeYe9wRKLXxQTaaETuM37tw0FaVM/ywqW+ENimMhKSB3wCF+TjPvEHwrpAMyUiUXoftkXCM0qjulz349VKj7A60wyuzn7QlAHmLEUgWd562vmej3JoIG6MH0MNoRHjtCQaxt9bJOZTv+Yk4lwvx2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OENxZMjr; arc=pass smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-66f747175d8so914684eaf.0
        for <stable@vger.kernel.org>; Fri, 27 Feb 2026 05:26:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772198773; cv=none;
        d=google.com; s=arc-20240605;
        b=fsXTvo0WAF551WJJT6bL03KVMvYzBM8tyjHftiT9Lwk8YJ+eiF8twVEhr6DxiX3FT3
         D9uVtTTV6hE8Ekq52KhB/vt9A51jniT3NAhKFTR5Um0DFYs+yJ9E9U1e1Aeb0xnHtv6j
         gyTOxyYMDhEEQjEmCwkn3JK2hGP9aBmmcV6Gm/AF60nIjGFJjcdEqeWwt2/ELSOq+uOw
         Eb6OJJOrgudMCWYhT6iXCcbwPl0xjcI4j2h/JkDBTk8vchYcvOJ5QQQUEHjwWZt4VVHb
         XdPA9krRZbVknQMZ3nprhmQ1hgfQkTGMxZ+koY4DcPkTFFpc53/8bCS7Jec9kMeVVPDE
         +lcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Mfk4Li2b1DY9WeZ7TXgh8JQ/TGajjPvOz3xaLQNJZoo=;
        fh=GiDG3WI5DWDBsUlvsTTYU1BUWsguzvtM+ATSuoY7mww=;
        b=X41JdyNzBUiNAkcOw0mrDpiorHWNHt4AZmyFFIMrjTNOP0uHA0AsU0r6Ln/sy+4LyL
         3jOeA4DXcRdhZqKbKacK1Ca4ce+yz2uIRZ9JfALH2elwMAtVSaVUG7/k3bDShJEOSVik
         S+utRV7TkieHBAOlojHye2eeBiz1x/0/O7McWrdXzQxUKkzaTSC3P1+u6dCo6WK0UVOH
         9+pudKXTk+uVS1FUfQ7cltFHT9izjBDcG+fYzdGmYmScLt4QdgAs48DzkAvvV0kXyb7c
         DZRIwypYaW19K9aUEqzMtRcK8j98SbtUycBV/34PDIpgmlxCDEEpLkvHCg39A17LkTwE
         c1jQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772198773; x=1772803573; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mfk4Li2b1DY9WeZ7TXgh8JQ/TGajjPvOz3xaLQNJZoo=;
        b=OENxZMjr1+79K6sD+JgekRwhbk2Y+eBZQUmEflcerSMZzuoiF6b0G6kKgu7MDLiJB6
         sWm203tcC7rYM1SrnRyWVy0pfgQ5ovUjqBcbm/CclbMRKYs3k57TJTB14B8iW+taiFYd
         7u6McMjAcr5WM3A1hqQRQJD5n0RPJgWBR9SzXTtJ86uSnr4OH6yD78K4sotRvQw499gs
         7ALFpb/9R19YChpVMehfs6W6iwOR6uBM9KTolrih6cb5yXWN+zPjTTpVurrhayskEG1r
         3IoBPmilWZlOB/Y7hr1LhtmR/LHtzqPh5cG8/XMKdk2olSbF8mDD6Lu4d8F6HlUomiNe
         nhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772198773; x=1772803573;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mfk4Li2b1DY9WeZ7TXgh8JQ/TGajjPvOz3xaLQNJZoo=;
        b=XV8iM74OL0pEsikFsi5RfbMd46BcQkGhzqs3ghwbpii6pH1bauCRsb1W0fpS8ireTA
         XGwg+iWkUR2fqdKAVASTbHRL3RX7e16RGhzmPwv45VM2kAJ/MgwuVgj6fpgVn7u1AVB3
         GX03QKpFvKMHSdffoOJI4dTbk86j1e2Jr/EaVVYtlSyfdrsyMHKy94FhQFBO4UVgxVSx
         Twi0plNc9uQINBXRzFY+xBcKKK6G6W8XUOZNDdJsY9Fy5QTUAHm61B5MetSzEqAVUqjt
         1ItBVkS++zDVhNuZaiQVDkGWkFcG6Ob1ew3zT5k/92qYL0A2/jfxvct9NkwGRIIdQ4ip
         8NKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGJD3dPV0yMldDPfi0na7XBAQ57gCZ1FcS0cET0ts7Zl/E6jzSV2hWf/Ublr0KM+Fuo+AsXNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxirmedOAPI0+iM1xGPqEUwV4/ngXAq5/nV3C51N/+cnyj++vHy
	y66/XBHCzOyvEfxwxBCV7Yl1W7ps+DxmRWcLQM4jzqPHAAZgtjWF4g8ZXYKXfjpibPh9FPB2So/
	gQKyaThmWy6YzSoP2kWHrtG5kXlLm8i7tNzh/zTq4
X-Gm-Gg: ATEYQzxM06n+04d936HbMq706xk3u+m1V58cVIrzXorIqPdDIgVfRE/WPrTH0KUYF5f
	6W7FEnnrjnJK7G31RyqNEFe0qKajba/eAZRIXAvuGeSNtW+AFDw9JzOabpfl4hTW8loYLJ6D5rm
	eD4MSKNG2Eyx16fpsRPM8oeQ3rTZEeLV7/bgezH5eyZxOl5EKXhW1RMhcFWL0crcdIMACMqfFhx
	w1eiK4ujjCEKUTIX3AwoS32lUVsh9nNzWzdCdt29I9DLJEiRVFaQYr31Hvs5iCxFhVc5M9h8++E
	zHjWSVoxax3AijM+tpbsZ1JyHNw5GEVJ1PNoJZYgcHHo/Oat5EI=
X-Received: by 2002:a05:6820:228a:b0:662:b892:40c1 with SMTP id
 006d021491bc7-679faf40534mr1561644eaf.52.1772198772372; Fri, 27 Feb 2026
 05:26:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216173716.2279847-1-nogikh@google.com>
In-Reply-To: <20260216173716.2279847-1-nogikh@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 27 Feb 2026 14:25:57 +0100
X-Gm-Features: AaiRm51FS4k8kOf7uO0kbvfFeX0fSClNoyJTiSSMW0qBp2UPnW3a0tFMNsaTgRQ
Message-ID: <CACT4Y+b1UZpV_i68cSP3XOBsr9EfbX+SAbXRdL3btmAnSvmMBA@mail.gmail.com>
Subject: Re: [PATCH] x86/kexec: Disable KCOV instrumentation after load_segments()
To: Aleksandr Nogikh <nogikh@google.com>
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de, x86@kernel.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219960-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dvyukov@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 94B211B7AF7
X-Rspamd-Action: no action

On Mon, 16 Feb 2026 at 18:37, Aleksandr Nogikh <nogikh@google.com> wrote:
>
> The load_segments() function changes segment registers, invalidating
> GS base (which KCOV relies on for per-cpu data). When CONFIG_KCOV is
> enabled, any subsequent instrumented C code call (e.g.
> native_gdt_invalidate()) begins crashing the kernel in an
> endless loop.
>
> To reproduce the problem, it's sufficient to do kexec on a
> KCOV-instrumented kernel:
> $ kexec -l /boot/otherKernel
> $ kexec -e
>
> (additional problems arise when the kernel is booting into a crash
> kernel)
>
> Disabling instrumentation for the individual functions would be too
> fragile, so let's fix the bug by disabling KCOV instrumentation for
> the whole machine_kexec_64.c and physaddr.c.
>
> The problem is not relevant for 32 bit kernels as CONFIG_KCOV is not
> supported there.
>
> Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  arch/x86/kernel/Makefile | 4 ++++
>  arch/x86/mm/Makefile     | 4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index e9aeeeafad173..5703fa6027866 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -43,6 +43,10 @@ KCOV_INSTRUMENT_dumpstack_$(BITS).o                  := n
>  KCOV_INSTRUMENT_unwind_orc.o                           := n
>  KCOV_INSTRUMENT_unwind_frame.o                         := n
>  KCOV_INSTRUMENT_unwind_guess.o                         := n
> +# When a kexec kernel is loaded, calling load_segments() breaks all
> +# subsequent KCOV instrumentation until new kernel takes control.
> +# Keep KCOV instrumentation disabled to prevent kernel crashes.
> +KCOV_INSTRUMENT_machine_kexec_64.o                     := n
>
>  CFLAGS_head32.o := -fno-stack-protector
>  CFLAGS_head64.o := -fno-stack-protector
> diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
> index 5b9908f13dcfd..a678a38a40266 100644
> --- a/arch/x86/mm/Makefile
> +++ b/arch/x86/mm/Makefile
> @@ -4,6 +4,10 @@ KCOV_INSTRUMENT_tlb.o                  := n
>  KCOV_INSTRUMENT_mem_encrypt.o          := n
>  KCOV_INSTRUMENT_mem_encrypt_amd.o      := n
>  KCOV_INSTRUMENT_pgprot.o               := n
> +# When a kexec kernel is loaded, calling load_segments() breaks all
> +# subsequent KCOV instrumentation until new kernel takes control.
> +# Keep KCOV instrumentation disabled to prevent kernel crashes.
> +KCOV_INSTRUMENT_physaddr.o             := n
>
>  KASAN_SANITIZE_mem_encrypt.o           := n
>  KASAN_SANITIZE_mem_encrypt_amd.o       := n
> --
> 2.53.0.273.g2a3d683680-goog
>

