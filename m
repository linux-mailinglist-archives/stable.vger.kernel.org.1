Return-Path: <stable+bounces-135289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0F4A98C75
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 16:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E510B3A8959
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E0B27979C;
	Wed, 23 Apr 2025 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S+2I8o4R"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CEC57C9F
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745417420; cv=none; b=CFhXlTqrI/HL1Bk09+/R3mAfcArpPPnO7he2fbyfA1RI8FqpmKoxxR/D9DDcDu3G9/PaQnu6aev6Nq3f+In6WJc/BXSK/my4d9c/xDOjHe65kHCI7IV1NLUQu5AyCCG/jJc8guEo5Rmidv9yT+0CsjpvThWfXBSWy3PdU7JhCJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745417420; c=relaxed/simple;
	bh=Dz89GFlN2JljQrIc14AWHN1O2IwJFShFDlgptdkGrjs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ALBRDhAHpaNIa50psUekbfVjKQuAsTPj5uENJZ0gaS9TCBYk3IxOvlGQj4sssaFN52qsZrcIvghtqcO9ugXhpq7bHg+H5fS7fH94kHAu/vIdfRnl8EOOtCWixnV72osI+ldeHA44MJf1OpICPdsTIRxZY9XNvVwPl+qjj+Aolok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S+2I8o4R; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff798e8c90so5934806a91.1
        for <stable@vger.kernel.org>; Wed, 23 Apr 2025 07:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745417418; x=1746022218; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JRPtkANxs/lxTlYEyf3yKr1v4372m0NJkPrJwTq5HVg=;
        b=S+2I8o4RHeGcNjW/wa0UHw5nIRfngDWFZTdIxsu8rQ4ZaDzsiVvMLcSUaiCVr0jn//
         aH+zQxS8XQgk3EFWI2mUD6YqX9GVK+g9LNzyfxr7LAej19LDYD8FOxzVhdXU6TbALyEC
         n8W1SoSbA6F8WKicjqAbiEcdKRGB3fAHA6BdiUxhwj3wVhWFVFBuV69RJI6EUDpRO6eD
         wTAqlbdF8nWRqtXVvRAvFj+MPZVRIUDk/LwKceL1vNazRSS9D1EN4f2sY+RCdrjO7M80
         A+R12MKTU+mr3UnpyA5dU10GceNj5f6GozPtRjLG3BPNg6Q3Ezr/j1wXKn8y6CoCNUVv
         Tbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745417418; x=1746022218;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JRPtkANxs/lxTlYEyf3yKr1v4372m0NJkPrJwTq5HVg=;
        b=tD9arm0NIwQE5yXoGkUNlA8mJhcoWOTdwGuPdGWvkbs0urUTbGTHqsTwu6KdBjcFR9
         MW80kmdOqhe5V3eLCfrJMlWCKrnGU7ABbnNSHVjFlWqcO3JPvRUSmeZuGrpj+335K37s
         saoTuBQKtQVKCeANM+ePEkgstpSj5AZtLCeIw0JYYspSN6ltyD79/y5V2kiFAusacuxG
         CJlY43M0igkM+sLx7X7oZ45niFpRN4IBj7afQZDjU3l0mzLxDI3LSHGX/hEQZ+VFq1cl
         yXHBgQM7lLufbWv/wA3XYnuf5wHWfsQ3RTsjpfAxsO+fz1lM0ltWyoXonLMUT/X65zES
         0o7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUElC4LrvqFt0GDuMiHzzhpUzApQ1BZH884zKVwba/Shrhz5ItiArvN3r+LjQSBYItzTZn4PI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfhQ0W/CCB6mTPhbBulzxlaCXZqjg95Iv9mubMWBVx6bOSiXk5
	X4wVBxF7hzjM68J2SFWwaC1jUqF+e3tfvARUqj5krDXB/mcSQ7xGAhFEYGF0wbtuvl75u2qKPaO
	BHA==
X-Google-Smtp-Source: AGHT+IGP6Lom1BPKavrHj+L/hYk1rz8ce5XJ1ZecFXItOld7t2WKEYU5e7ilQVFK+tWjHPvfJX12j9p9nXY=
X-Received: from pjbqd3.prod.google.com ([2002:a17:90b:3cc3:b0:2ff:6e58:8a0a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3146:b0:2ee:e113:815d
 with SMTP id 98e67ed59e1d1-3087bb5341amr27709612a91.8.1745417418541; Wed, 23
 Apr 2025 07:10:18 -0700 (PDT)
Date: Wed, 23 Apr 2025 07:10:17 -0700
In-Reply-To: <20250423072017.GAaAiUsYzDOdt7cmp2@renoirsky.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250331143710.1686600-2-sashal@kernel.org> <aAKDyGpzNOCdGmN2@duo.ucw.cz>
 <aAKJkrQxp5on46nC@google.com> <20250418173643.GEaAKNq_1Nq9PAYf4_@fat_crate.local>
 <aAKaf1liTsIA81r_@google.com> <20250418191224.GFaAKkGBnb01tGUVhW@fat_crate.local>
 <aAfQbiqp_yIV3OOC@google.com> <20250422173355.GDaAfTA8GqnGBfDk7G@renoirsky.local>
 <aAfynEK3wcfQa1qQ@google.com> <20250423072017.GAaAiUsYzDOdt7cmp2@renoirsky.local>
Message-ID: <aAj0ySpCnHf_SX2J@google.com>
Subject: Re: CONFIG_X86_HYPERVISOR (was: Re: [PATCH AUTOSEL 5.10 2/6] x86/cpu:
 Don't clear X86_FEATURE_LAHF_LM flag in init_amd_k8() on AMD when running in
 a virtual machine)
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Pavel Machek <pavel@denx.de>, Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Max Grobecker <max@grobecker.info>, Ingo Molnar <mingo@kernel.org>, 
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, 
	x86@kernel.org, thomas.lendacky@amd.com, perry.yuan@amd.com, 
	mario.limonciello@amd.com, riel@surriel.com, mjguzik@gmail.com, 
	darwi@linutronix.de, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 23, 2025, Borislav Petkov wrote:
> > Eww.  Optimization to lessen the pain of DR7 interception.  It'd be nice to clean
> > this up at some point, especially with things like SEV-ES with DebugSwap, where
> > DR7 is never intercepted.
> >   arch/x86/include/asm/debugreg.h:        if (static_cpu_has(X86_FEATURE_HYPERVISOR) && !hw_breakpoint_active())
> >   arch/x86/kernel/hw_breakpoint.c:                 * When in guest (X86_FEATURE_HYPERVISOR), local_db_save()
> 
> Patch adding it says "Because DRn access is 'difficult' with virt;..."
> so yeah. I guess we need to agree how to do debug exceptions in guests.
> Probably start documenting it and then have guest and host adhere to
> that. I'm talking completely without having looked at what the code does
> but the "handshake" agreement should be something like this and then we
> can start simplifying code...

I don't know that we'll be able to simplify the code.

#DBs in the guest are complex because DR[0-3] aren't context switched by hardware,
and running with active breakpoints is uncommon.  As a result, loading the guest's
DRs into hardware on every VM-Enter is undesirable, because it would add significant
latency (load DRs on entry, save DRs on exit) for a relatively rare situation
(guest has active breakpoints).

KVM (and presumably other hypervisors) intercepts DR accesses so that it can
detect when the guest has active breakpoints (DR7 bits enabled), at which point
KVM does load the guest's DRs into hardware and disables DR interception until
the next VM-Exit.

KVM also allows the host user to utilize hardware breakpoints to debug the guest,
which further adds to the madness, and that's not something the guest can change
or even influence.

So removing the "am I guest logic" entirely probably isn't feasible, because in
the common case where there are no active breakpoints, reading cpu_dr7 instead
of DR7 is a significant performance boost for "normal" VMs.

I mentioned SEV-ES+ DebugSwap because in that case DR7 is effectively guaranteed
to not be intercepted, and so the native behavior of reading DR7 instead of the
per-CPU variable is likely desirable.  I believe TDX has similar functionality
(I forget if it's always on, or opt-in).

