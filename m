Return-Path: <stable+bounces-134646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF05A93CCC
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 20:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895868E185A
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 18:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979E12253F8;
	Fri, 18 Apr 2025 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xqiS7Kwe"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69CE224887
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745001093; cv=none; b=ts9n8Hk+78PtRjnmc0mXedOSOPsjSy2Me3wPK0BICfTLNrOqr4CJB2ZGzMU6fbTp6kTPRXJ50E0Twa6U7L9W45mMujyp/PoA/4Fm0dimOJUfXxWtKAOTK5O3VLU93zn/Z5rzIDgTvm9YIrA/WlZebh4HAMjiCAtKrdx3ON0uipI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745001093; c=relaxed/simple;
	bh=2taYhddMq9lQ/8Z3JTMNETe26ib85UWNUSe1GA+eGfo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oxSLSG/s7PuukfVQGW3ld5koWknXF7l+bUjRLnM8MDfqafAVtUo0DDZs264mgFb2o6EzLjGTR/Y1Misea9AZOVqCLHnY1N8gnblh2K2ve/4ZS4anJ/KMhBC1sUEwGuwFyQdEwXSQZj02UOp836thFfdW6FMlqqnB/rZyrKVDj5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xqiS7Kwe; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30364fc706fso1842743a91.3
        for <stable@vger.kernel.org>; Fri, 18 Apr 2025 11:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745001089; x=1745605889; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R7DfmVsirgcNwyXXhOnkR2OGGl5DWqAfaV1SkVbAhuI=;
        b=xqiS7Kwevj1HZKPQdCHxR6AxFzi02GraH7CH3PjQGrWLlxyYpez3TBP9Rt0s3fTDVI
         2oF9eMBi+M3XM4fA5WqH2LkQJvyhhE5fyXfzoZNYf0c7bmIOVwUDKIlvcFQJs02J+lXK
         aTU3V81XS71LVo4+n+24oRxujFUTQT0Fo3p0/ihmzMs1isfBN4Fv8Nx0caY3tMm5s05q
         Xl45VD71MUKr2ns5sKaaTpv/tniFTrsVEsALJPzdkjLShGGnFQD86c5pifaLpoNHem80
         Nqbt7r5zN3jDJkLRoYGslZlkhxX6ReH9g5HBrSw9hV36kOq7gxEbvXHxAGVUDoYdB0ET
         cdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745001089; x=1745605889;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R7DfmVsirgcNwyXXhOnkR2OGGl5DWqAfaV1SkVbAhuI=;
        b=k0eAuvPIHlHHJ88CLFgq0CRi8DF51lWPHy4jdClCBUHOKWzppdhPqE/Nyfb9qNu9Z3
         i7TWTEiWc8Lewsf1korNNaXrKgTPltYvofB1iZGrHoaH/3LdF/L8U+YiTUiczQMLcA5N
         /jL7/lfSh4CQerbi4tVv6rca6Wny5z9F+twksmWGUY7LEKF2q0minC8XNDR48znCYCd8
         ThSPr+ctwX5T5YOFAphxZH0N9BkqbTSIcigDoEiKAl0xS+b8Fh1ytW78VI7XSioihuWO
         UzfTr+D+rfp9lLC8RI4p0r7nfBggmEtsqDk3+SYL7KPzk+EqG+sFGJeI7LNxNrr+RfQ3
         wgJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW112j5v5tRwPrX/aO+87EMcbTff55pz6heGLBgNlHPv0Alww8YJiCJ2hRFRsPttHi4OqrtPKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH8mLhooHVTrYB4pvXGiLNCKt8tI+NeoJQHQVvRssfnZemHmk4
	RxByD4KtxFDPDsJ/Asxpk0IMEI309cj6ejfytw5c1EGc37StqKgZNz8Lna+bDtJdZGqR8T26++L
	GtA==
X-Google-Smtp-Source: AGHT+IEpNnwFWShkgziIFpbN6+F14jL/9zInzy8RZBxLo+hx7H5u1bpirdSXSr81pJ98zQK1RP0G511Zo2w=
X-Received: from pjbcz8.prod.google.com ([2002:a17:90a:d448:b0:2fa:15aa:4d1e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:6ce:b0:2f6:dcc9:38e0
 with SMTP id 98e67ed59e1d1-3087ba51b57mr7146208a91.0.1745001089075; Fri, 18
 Apr 2025 11:31:29 -0700 (PDT)
Date: Fri, 18 Apr 2025 11:31:27 -0700
In-Reply-To: <20250418173643.GEaAKNq_1Nq9PAYf4_@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250331143710.1686600-1-sashal@kernel.org> <20250331143710.1686600-2-sashal@kernel.org>
 <aAKDyGpzNOCdGmN2@duo.ucw.cz> <aAKJkrQxp5on46nC@google.com> <20250418173643.GEaAKNq_1Nq9PAYf4_@fat_crate.local>
Message-ID: <aAKaf1liTsIA81r_@google.com>
Subject: Re: [PATCH AUTOSEL 5.10 2/6] x86/cpu: Don't clear X86_FEATURE_LAHF_LM
 flag in init_amd_k8() on AMD when running in a virtual machine
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Pavel Machek <pavel@denx.de>, Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Max Grobecker <max@grobecker.info>, Ingo Molnar <mingo@kernel.org>, 
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, 
	x86@kernel.org, thomas.lendacky@amd.com, perry.yuan@amd.com, 
	mario.limonciello@amd.com, riel@surriel.com, mjguzik@gmail.com, 
	darwi@linutronix.de
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 18, 2025, Borislav Petkov wrote:
> On Fri, Apr 18, 2025 at 10:19:14AM -0700, Sean Christopherson wrote:
> > Uh, and the hypervisor too?  Why is the hypervisor enumerating an old K8 CPU for
> > what appears to be a modern workload?
> > 
> > > I'd say this is not good stable candidate.
> > 
> > Eh, practically speaking, there's no chance of this causing problems.  The setup
> > is all kinds of weird, but AIUI, K8 CPUs don't support virtualization so there's
> > no chance that the underlying CPU is actually affected by the K8 bug, because the
> > underlying CPU can't be K8.  And no bare metal CPU will ever set the HYPERVISOR
> > bit, so there won't be false positives on that front.
> > 
> > I personally object to the patch itself; it's not the kernel's responsibility to
> > deal with a misconfigured VM.  But unless we revert the commit, I don't see any
> > reason to withhold this from stable@.
> 
> I objected back then but it is some obscure VM migration madness (pasting the
> whole reply here because it didn't land on any ML):
> 
> Date: Tue,  17 Dec 2024 21:32:21 +0100
> From: Max Grobecker <max@grobecker.info>
> To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
>  Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Max Grobecker <max@grobecker.info>, x86@kernel.org
> Subject: Re: [PATCH v2] Don't clear X86_FEATURE_LAHF_LM flag in init_amd_k8()
>  on AMD when running in a virtual machine
> Message-ID: <d77caeea-b922-4bf5-8349-4b5acab4d2eb>
> MIME-Version: 1.0
> Content-Transfer-Encoding: 8bit
> Content-Type: text/plain; charset=utf-8
> 
> Hi,
> 
> sorry for my late response, was hit by a flu last days.
> 
> On Tue, 10 Dec 2024 13:51:50 +0100, Borislav Petkov wrote:
> > Lemme get this straight: you - I don't know who "we" is - are running K8
> > models in guests? Why?
> 
> Oh, I see, I missed to explain that, indeed.
> 
> This error happens, when I start a virtual machine using libvirt/QEMU while 
> not passing through the host CPU. I do this, because I want to be 
> able to live-migrate the VM between hosts, that have slightly different CPUs.
> Migration works, but only if I choose the generic "kvm64" CPU preset to be
> used with QEMU using the "-cpu kvm64" parameter:
>  
>   qemu-system-x86_64 -cpu kvm64
>  
> I also explicitly enabled additional features like SSE4.1 or AXV2 to have as
> most features as I can but still being able to do live-migration between hosts.
>   
> By using this config, the CPU is identified as "Common KVM processor"
> inside the VM:
> 
>   processor       : 0
>   vendor_id       : AuthenticAMD
>   cpu family      : 15
>   model           : 6
>   model name      : Common KVM processor
> 
> Also, the model reads as 0x06, which is set by that kvm64 CPU preset,
> but usually does not pose a problem.

IMO, this is blatantly a QEMU bug (I verified the behavior when using "kvm64" on AMD).
As per QEMU commit d1cd4bf419 ("introduce kvm64 CPU"), the vendor + FMS enumerates
an Intel P4:

        .name = "kvm64",
        .level = 0xd,
        .vendor = CPUID_VENDOR_INTEL,
        .family = 15,
        .model = 6,

Per x86_cpu_load_model(), QEMU overrides the vendor when using KVM (at a glance,
I can't find the code that actually overrides the vendor, gotta love QEMU's object
model):

    /*
     * vendor property is set here but then overloaded with the
     * host cpu vendor for KVM and HVF.
     */
    object_property_set_str(OBJECT(cpu), "vendor", def->vendor, &error_abort);

Overriding the vendor but using Intel's P4 FMS is flat out wrong.  IMO, QEMU
should use the same FMS as qemu64 for kvm64 when running on AMD.

        .name = "qemu64",
        .level = 0xd,
        .vendor = CPUID_VENDOR_AMD,
        .family = 15,
        .model = 107,
        .stepping = 1,

Yeah, scraping FMS information is a bad idea, but what QEMU is doing is arguably
far worse.

> The original vendor id of the host CPU is still visible to the guest, and in
> case the host uses an AMD CPU the combination of "AuthenticAMD" and model 0x06
> triggers the bug and the lahf_lm flag vanishes.
> If the guest is running with the same settings on an Intel CPU and therefore 
> reads "GenuineIntel" as the vendor string, the model is still 0x06, but also 
> the lahf_lm flag is still listed in /proc/cpuinfo.
> 
> The CPU is mistakenly identified to be an AMD K8 model, while, in fact, nearly
> all features a modern Epyc or Xeon CPU is offering, are available.


