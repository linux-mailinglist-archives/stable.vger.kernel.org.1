Return-Path: <stable+bounces-217770-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMeDDWpMnGnYDQQAu9opvQ
	(envelope-from <stable+bounces-217770-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 13:47:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C924C176680
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 13:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B3593034626
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 12:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3133659FA;
	Mon, 23 Feb 2026 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ouCdhy3c"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630C7352C29
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850568; cv=pass; b=dt/OlPfmanoIg04GH+zmSCuNK2PfTGro6AKsm86HdkFJ10AGC4wxDFUHsARuiVtswentjQ+WMwRvx9WanaCTFBfhAYm91RdQFKczYMabh3yB74c0LVZUYp+zyHK/IiFCot6GIc2WFiTGAi8uy6GaS5V4HHS7RCH4tWnLztdpq0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850568; c=relaxed/simple;
	bh=qm91i4n19GGC/5mC0Vlo1bWhkXFyODTXFA6QDJog2Kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3XoCVt3hkoYOVBJ83nQiAsDp0UWtSljgVcrUi5nUm9HjlLvO91AnrDIQ9jQWNIqGu979iPznqA57BpgPd5aRS8fDZxOiUzLvbHeareQq197sB2sy2mRA/s3+WULhQac3idx+1/yMjSNm3N+4UwED6DwQMgvPPd11ayCcLdQYh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ouCdhy3c; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-676815e147dso2155507eaf.3
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 04:42:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771850566; cv=none;
        d=google.com; s=arc-20240605;
        b=l0qRUuBmUOmjGi8sGX58hML0JgHRqxAmYaJB7eYHBFvP39qlwxzTA7VaQl5d8vwDcG
         6UPhq3OrAUmxggX5kEgNMlBj9w89RMtoZXrmubSmRnHSkCAs/PW3GItm4xx61Z7HEkwO
         G83hDd1yO+q5idMguHyV855zXFnne3swujFudgq6vnD16KlvAXFy/zwgWgkOfh2md2l7
         v3ihg7943rMvTh3Hb1+x1ptBdy6gwzRnnSdHaAxx3k7vB441OYdxYHD1Ess8l6YXMMaX
         kSiRPLbJbHjq3X0I9hL7KXosVDiqHHzXmDWTvHwWk51KSwzyTIjZ1YgZqGrxh88GZQHO
         JOxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QwHlGbS3cn9jSgHE96pfHR85LcmhKeNoxRR0LDuTZE8=;
        fh=Pjn9rupKyBVG6CmppJRDLVOmZRsYyukp2syL7UQ3EiM=;
        b=DExrfnsVcKpLE7+rWSSGp258q9z6WasZGfre52XXPDp/IHhFMDnn3xKa00FO6b6sk9
         /+j+YsHQ0QPS4RFvVYsft33xbFIABWsVIg/TFFQDFLpJTALp8+F30SkEQK6y8AHJRBnb
         L1DDi2UX2gVMreYMQqx2xQe+qLrBlKVLEQMI1lL5dphuSOw3L+ofRG5BD7dxVpswvX/+
         Fhro1SYsyfUroMt4Zh9mbep4McdwSW2rV2XK10LbfZrTWbbMJuH8vSanBuOD4JWCKe+t
         1Tr04BAh/v1T2XL2jtTVvyFI/V9Vq6sW1QBhycCbeY3GntBDpXCoxj/DF0AHDRNAgbSk
         zDGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771850566; x=1772455366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwHlGbS3cn9jSgHE96pfHR85LcmhKeNoxRR0LDuTZE8=;
        b=ouCdhy3cs6QJ6jotRy5wKjHVuJd0AtCfUEck5FM5JIgVb8NSOyoi+eHwu3UDmeC2eA
         +PKvzyTjnW7MYjFrBxheyqfc3bDspsX72kwSTi2SFkjMvQ3l/PE/70UrZ2svQcxaZeke
         wKOfZv5WWZvQLswfw3WR3oJF/yk2JC2GALFeYIEAM+d0ME/x/g/comxMckLq7Gh09WGC
         Zh6l/NlxghQLlTzOhRjcYLrdIwqNojYY6EarNJRQbELuJYC6azmH1UQr4M105yB/QFpm
         CtiKfn7DpT4hPB7ZcFf+9r8VZnsw4xxfRcVAefwr6GYFwcgXdEfLiMqjE+JzHDSmZIQF
         BB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771850566; x=1772455366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QwHlGbS3cn9jSgHE96pfHR85LcmhKeNoxRR0LDuTZE8=;
        b=mM6jBumVK+ZordKqPzwDC7z/5lCCDyb4cCNKA1zJaEwZDm1RVQwslqkchsWo5yWLNZ
         V0n8aanmKqreq4fnMOUMO+iOYnZsc0kx5Dv/jUbgxdodqQPr/403dpQFjLwSnESLTJSH
         D0EpCMxS0FHtce866SD/mHAwwSVeJSKtTx8SiCOh7tBHEtdWy0P50vbsdpIF5VXudIOO
         Mo+lDyPpZO2g43HfzJV5m3lKp6RUKzRI0fSfAtlKfOYMl032nL9aqHkMxoAehGUBGJHU
         lIcVJ4sv2MjwLONelMcWHEjSA4Ci5ZdmcBhPuFKqqwxrv89cRRzYZ03ORMLy+NLZT52p
         XWVw==
X-Forwarded-Encrypted: i=1; AJvYcCUyNuOy0zNhlXCWbUzb8KfyUcAEb3M8+qBIrqoDfwUXihL0UzaPZ3loZDEIwIDCWxzjjqPHnIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaiEWXO6ao4VilkA6H/VpuG6CnhA6vaNFIAFcVMCFg36BqEBrK
	2ZNOcFeJzowtFLS9fwrLHeAzLT0ou/GmBsfRxzvZB4cG4W2Yvvwj+5+EKROTHAcrH16yzG5i9DA
	X6P0I60vtBbMs9F7plfuw7vq3GlsUVGnKGVhPTkyO
X-Gm-Gg: AZuq6aL2JPh4XNWhQq3oezy/kuZE+4EeJU7ocN5PDxNZPz/2iaPjdM6f8q91HnYHfCt
	Ol6j7kibBQKUwGHEY9ZRSici1VrVMckU0QB6xhMpSObQ2eCCduDbAACirQub3XtyCOuNaH83dGV
	XLXD3lbEtuKmES/3chgP6Cx0dwbVrNZq/qOP150U+OoxJV98VGgkdyP8ZckaWd8FhP+RVEtC2Nu
	oc5e6jcTWFNluyfeB0QnHQYh4dctOjp2AltwMBnGzq45sBbbnB6uPNOsUKdkaFqD8Qj7CCZXTT7
	AAGSJLbCRZiHSLtb8aaiLzJaC1t3z347o8nabJmZYeCGp02532ov7gj7jkDt9T1aLPe6IvmbBnd
	uYMM3
X-Received: by 2002:a05:6820:4410:b0:678:7266:8e9d with SMTP id
 006d021491bc7-679c46115b0mr3809769eaf.76.1771850565555; Mon, 23 Feb 2026
 04:42:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216173716.2279847-1-nogikh@google.com>
In-Reply-To: <20260216173716.2279847-1-nogikh@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 23 Feb 2026 13:42:33 +0100
X-Gm-Features: AaiRm53XIB_8hrdBUvZtKbbzwwdkFXPuotzr2k9FukKdKsESIA-40mClL6YShhs
Message-ID: <CANp29Y57fyE4H=FZju_AhBkzfeKBPXJKDEumqBKaR+zxKwMYbg@mail.gmail.com>
Subject: Re: [PATCH] x86/kexec: Disable KCOV instrumentation after load_segments()
To: tglx@kernel.org, mingo@redhat.com, bp@alien8.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, dvyukov@google.com, 
	kasan-dev@googlegroups.com, stable@vger.kernel.org, 
	syzkaller <syzkaller@googlegroups.com>, linux-mm <linux-mm@kvack.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217770-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nogikh@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C924C176680
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 6:37=E2=80=AFPM Aleksandr Nogikh <nogikh@google.com=
> wrote:
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
> ---
>  arch/x86/kernel/Makefile | 4 ++++
>  arch/x86/mm/Makefile     | 4 ++++
>  2 files changed, 8 insertions(+)

A gentle ping on this patch.

Should it go through the x86 tree or the mm tree like other kcov patches?

>
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index e9aeeeafad173..5703fa6027866 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -43,6 +43,10 @@ KCOV_INSTRUMENT_dumpstack_$(BITS).o                  :=
=3D n
>  KCOV_INSTRUMENT_unwind_orc.o                           :=3D n
>  KCOV_INSTRUMENT_unwind_frame.o                         :=3D n
>  KCOV_INSTRUMENT_unwind_guess.o                         :=3D n
> +# When a kexec kernel is loaded, calling load_segments() breaks all
> +# subsequent KCOV instrumentation until new kernel takes control.
> +# Keep KCOV instrumentation disabled to prevent kernel crashes.
> +KCOV_INSTRUMENT_machine_kexec_64.o                     :=3D n
>
>  CFLAGS_head32.o :=3D -fno-stack-protector
>  CFLAGS_head64.o :=3D -fno-stack-protector
> diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
> index 5b9908f13dcfd..a678a38a40266 100644
> --- a/arch/x86/mm/Makefile
> +++ b/arch/x86/mm/Makefile
> @@ -4,6 +4,10 @@ KCOV_INSTRUMENT_tlb.o                  :=3D n
>  KCOV_INSTRUMENT_mem_encrypt.o          :=3D n
>  KCOV_INSTRUMENT_mem_encrypt_amd.o      :=3D n
>  KCOV_INSTRUMENT_pgprot.o               :=3D n
> +# When a kexec kernel is loaded, calling load_segments() breaks all
> +# subsequent KCOV instrumentation until new kernel takes control.
> +# Keep KCOV instrumentation disabled to prevent kernel crashes.
> +KCOV_INSTRUMENT_physaddr.o             :=3D n
>
>  KASAN_SANITIZE_mem_encrypt.o           :=3D n
>  KASAN_SANITIZE_mem_encrypt_amd.o       :=3D n
> --
> 2.53.0.273.g2a3d683680-goog
>

