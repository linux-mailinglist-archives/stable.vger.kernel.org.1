Return-Path: <stable+bounces-135163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04778A9738D
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 19:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48CE21898E44
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 17:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA02F296160;
	Tue, 22 Apr 2025 17:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N8rc310s"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F65F20E6F9
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745342578; cv=none; b=ae3QxGPFcLBrL7c8ZTMNidZPomJcrrQx7Zs4JwBf5Euepta4YbafvSFyrpHeH+eoTr8zKsRf7/MXjXZpycyKyY+IFgIaSXi4UnO53c9us+p88VVtbgFBNadAcyDZnAdm5zvJm4C9Q1haM/72DWvhfBjadiRd3ZkeMhu/NJrshLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745342578; c=relaxed/simple;
	bh=Qr1Rn1Gw8HPlXNP84l9SBWdiWFex1cDl2x/hEm+oxLk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o6Iv/Jo4v2pngG1tjX5ltaB6r9OHe13U9J3O3orA/zMweIDX6zomxsf6Ud0alAFoucDecv2bLqGv50a+A1ZlVEr7JuzrTvgTk8yxM1dPJr7FSuKWMVmhASksSA6m/v2OeqBK6szOPr1Jzhqp/j0cKl+ZksJgp7LdY1GEsr31Le8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N8rc310s; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3011bee1751so4893526a91.1
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 10:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745342576; x=1745947376; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+fbHIfH/VhDWabe05jkOaAOJ71KncMy1Sa68MUh9AoU=;
        b=N8rc310s08uMsW6+gsmFNKpU3rA+vd+xPqrwJvBE2DyBnGRz9pfgwA11qAcpLBqHnG
         Bl+si5YM+X1vWOeFV4eJ88mxYKCW6U7JsPMasPgHN9Boe0GuVs7KICeecNfiDU48jzr3
         D40SnCZ2sMt7P9rrj2Nt+hENOfGcamwfQHU3YNBJxv8Vpy0hzNC/F7vbMVbkMrJPuL30
         e/p8jmtjgXPRRCEQRZ2npWCO0dEBuNukGLE4Kb+4Tb8IMErzUrqxXX3HrFzqJGv7/K2I
         FAWRZsK6E6XrNKChlINaQZ9Gtd1QXzA0a1aYxsb1I9LrsWpRe/1cMjJ0wNP31XsZ4yas
         Vk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745342576; x=1745947376;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+fbHIfH/VhDWabe05jkOaAOJ71KncMy1Sa68MUh9AoU=;
        b=oP+4B7pODWAJTD1X7dPw/eJBHDvsE2t2PHC8/hNugHdHbyq0yWLx/9/Opu1DgSenH2
         Lsa2Eqr58Q5y5LQYx5eS0cI2du35pLavY+SwQaa4kqgeZZs6C7O0vRaa7WneDoTRJPNk
         /0a2MPtp2UfYq9EtB39CLlCO8D+CCQC+T39YUuKVrGuTDlkWwyZC8WZnjJuN9t90kBIo
         oBe5C+j64OU1xwWCp78Rl0NuMpFFSmyRNskOpWLNhX8MqN5LLnkfhC2J0F/jhWBQQj4A
         MRFLz2iEAXd/BlRS9JDkArD0XLPVf2hosGAZnDKkOGCWj3bRyt6zw+PlcOUnhfVfuBte
         KSAA==
X-Forwarded-Encrypted: i=1; AJvYcCU9IquZoKzmqVLt3/RE9lawa9Rv9cwcXGR3oMSTq1yN1t6o/GiJVajn/Db8UWYQo1klF3snems=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQV4yQ0F//Zh5YD9CczU63a2JciB7H5XnywVxciNeZ5D/TmP8r
	AGtQwc6Xp7Wz5nJJ/IKAi7U+ivuE6JL5/7NIJh4OwTk0jBBIj9GFlC0bJ83M+KCQiKYWyGbwVmf
	3vA==
X-Google-Smtp-Source: AGHT+IHa5jb9FZXUwvtLFklVwtHpef81Kg/RSVknMgwLGgrvFXB8MhtEF5SZSJEqndiks1m/qfXQMpTNKi4=
X-Received: from pjm11.prod.google.com ([2002:a17:90b:2fcb:b0:308:65f7:9f24])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a4e:b0:301:1d9f:4ba2
 with SMTP id 98e67ed59e1d1-3087bbbd12cmr22675120a91.28.1745342576491; Tue, 22
 Apr 2025 10:22:56 -0700 (PDT)
Date: Tue, 22 Apr 2025 10:22:54 -0700
In-Reply-To: <20250418191224.GFaAKkGBnb01tGUVhW@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250331143710.1686600-1-sashal@kernel.org> <20250331143710.1686600-2-sashal@kernel.org>
 <aAKDyGpzNOCdGmN2@duo.ucw.cz> <aAKJkrQxp5on46nC@google.com>
 <20250418173643.GEaAKNq_1Nq9PAYf4_@fat_crate.local> <aAKaf1liTsIA81r_@google.com>
 <20250418191224.GFaAKkGBnb01tGUVhW@fat_crate.local>
Message-ID: <aAfQbiqp_yIV3OOC@google.com>
Subject: Re: [PATCH AUTOSEL 5.10 2/6] x86/cpu: Don't clear X86_FEATURE_LAHF_LM
 flag in init_amd_k8() on AMD when running in a virtual machine
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Pavel Machek <pavel@denx.de>, Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Max Grobecker <max@grobecker.info>, Ingo Molnar <mingo@kernel.org>, 
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, 
	x86@kernel.org, thomas.lendacky@amd.com, perry.yuan@amd.com, 
	mario.limonciello@amd.com, riel@surriel.com, mjguzik@gmail.com, 
	darwi@linutronix.de, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

+Paolo

On Fri, Apr 18, 2025, Borislav Petkov wrote:
> On Fri, Apr 18, 2025 at 11:31:27AM -0700, Sean Christopherson wrote:
> > IMO, this is blatantly a QEMU bug (I verified the behavior when using "kvm64" on AMD).
> > As per QEMU commit d1cd4bf419 ("introduce kvm64 CPU"), the vendor + FMS enumerates
> > an Intel P4:
> > 
> >         .name = "kvm64",
> >         .level = 0xd,
> >         .vendor = CPUID_VENDOR_INTEL,
> >         .family = 15,
> >         .model = 6,
> > 
> > Per x86_cpu_load_model(), QEMU overrides the vendor when using KVM (at a glance,
> > I can't find the code that actually overrides the vendor, gotta love QEMU's object
> > model):
> 
> LOL, I thought I was the only one who thought this is madness. :-P

Yeah, I've got backtraces and I still don't entirely understand who's doing what.

> >     /*
> >      * vendor property is set here but then overloaded with the
> >      * host cpu vendor for KVM and HVF.
> >      */
> >     object_property_set_str(OBJECT(cpu), "vendor", def->vendor, &error_abort);
> > 
> > Overriding the vendor but using Intel's P4 FMS is flat out wrong.  IMO, QEMU
> > should use the same FMS as qemu64 for kvm64 when running on AMD.
> > 
> >         .name = "qemu64",
> >         .level = 0xd,
> >         .vendor = CPUID_VENDOR_AMD,
> >         .family = 15,
> >         .model = 107,
> >         .stepping = 1,
> > 
> > Yeah, scraping FMS information is a bad idea, but what QEMU is doing is arguably
> > far worse.
> 
> Ok, let's fix qemu. I don't have a clue, though, how to go about that so I'd
> rely on your guidance here.

I have no idea how to fix the QEMU code.


Paolo,

The TL;DR of the problem is that QEMU's "kvm64" CPU type sets FMS to Intel P4,
and doesn't swizzle the FMS to something sane when running on AMD.  This results
in QEMU advertising the CPU as an ancient K8, which causes at least one *known*
problem due software making decisions on the funky FMS.

My stance is that QEMU is buggy/flawed and should stuff a FMS that is sane for
the underlying vendor for kvm64.  I'd send an RFC patch, but for the life of me
I can't figure what that would even look like.

> Because I really hate wagging the dog and "fixing" the kernel because something
> else can't be bothered. I didn't object stronger to that fix because it is
> meh, more of those "if I'm a guest" gunk which we sprinkle nowadays and that's
> apparently not that awful-ish...

FWIW, I think splattering X86_FEATURE_HYPERVISOR everywhere is quite awful.  There
are definitely cases where the kernel needs to know if it's running as a guest,
because the behavior of "hardware" fundamentally changes in ways that can't be
enumerated otherwise.  E.g. that things like the HPET are fully emulated and thus
will be prone to significant jitter.

But when it comes to feature enumeration, IMO sprinkling HYPERVISOR everywhere is
unnecessary because it's the hypervisor/VMM's responsibility to present a sane
model.  And I also think it's outright dangerous, because everywhere the kernel
does X for bare metal and Y for guest results in reduced test coverage.

E.g. things like syzkaller and other bots will largely be testing the HYPERVISOR
code, while humans will largely be testing and using the bare metal code.

