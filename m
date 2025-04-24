Return-Path: <stable+bounces-136621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D994A9B82E
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 21:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52D6816FDBD
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 19:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312E628E611;
	Thu, 24 Apr 2025 19:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gxytKyZq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684C928EB
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 19:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745522334; cv=none; b=gmxk764rTCcamfNn1V3yEFQbVeEXzywN6n74F5zkoFb7DqHADZQ8leHf8fDGRDhTBec2p4h8AqwPMMqfYRZNz3rkZtEzyUKD/v5v+1bnSmDiXlj2Y4AFwuCH9MTRwqnFda9cW0xIO31/W2MiDvGWa85VUorbjP020A8yZRUUwyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745522334; c=relaxed/simple;
	bh=CNqJAhaPW3biEFXxsysRoh2Kl5MnjeIup+Zj4mxMEr0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PK0cXfDy7Op6jS7MNI0WUVll9Bpd5/e3+sh5Fc+ZmoiT6HKwbdSL79zX/WfztmEn3lMarodElx8qnZSvV4BI7WqiUtP6Kpx7fsyo6uY5VQCdwIkkm5cir52CQRIuVmMe8P0LA3ae2WtroeljZmuSaH8dSI12LQJ7EDgFn4tj/RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gxytKyZq; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-306b51e30ffso1245701a91.1
        for <stable@vger.kernel.org>; Thu, 24 Apr 2025 12:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745522331; x=1746127131; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=70v12mDUmlFvJZJFlpkmDmUBkvzpwiKi4qrZR0uczEU=;
        b=gxytKyZqOsXHV9TkyBqP620IQNp2PteJ9EPL3L2JBXJddKIRmbU9il928WYk6fUetZ
         lhceFnhMDoI1uyMyB+XYEqPjf2ZS1SCRhddTIx1/hZPHKDifPKQxFQyw4UMy7rEgoMYj
         wdkhfH0k8wovhwTlhsn7jJsuo+BNNOnH3s326ozm/REhu+DIRTpLb9kHOwt/Tq+LS7p6
         IrmiKiQDn6LEhi8F34NTarwc9u2nXJ2pVDRcbClDRMnVFpSmPjaFZ6acV/BXzPY8G9Ve
         TSsFXbn5X7D0MvIo7nOsu82uKnHJCWZPWu1oLoYcHVVzaDSPF4gB0YkIzP854WLrwWkP
         D62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745522331; x=1746127131;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=70v12mDUmlFvJZJFlpkmDmUBkvzpwiKi4qrZR0uczEU=;
        b=dTqIP0r1TwI4oZJdedVR/Fnx8s7W2Sz5r5ousHhcJeeifFyR37y3rbWmyLs+r3A47x
         uA9vOVNV+9py29enpLnZCfdipF6mazBL6ja9NxSZIIABUyokhWPCVmixbMT7Z/24Bd2P
         sCFs1MoijQPJX164/zxQLtKkjMIJZbn/KO5R32mGuSpO2/ebzJwU3tWgsYhFvSR+43s6
         FhNtdAIiqeDHFry/UZIECqGWQTSjJZS3GEaLvYCCGD5LJItGkvAtMj3lgkZpGe0zn0EQ
         8MAuMai4kUOYzeO2bR/JumbhDJO5krqeW3D2jU31Q2wIdeuDD0D3VxrTgA45wrKvuCC2
         +Ocg==
X-Forwarded-Encrypted: i=1; AJvYcCUDReO+5jUsU8KUe6vwlfhegMUy4Sf0qb+1NxghuipIX0085qs5dy0oYPqmkVo2X0nU9ogxU2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9vqUhtzoKzqmN640Lp8gYlTg/05c7cX7ZIgmtC6eoN7ahoIlI
	Mh0BjkKDH91X81ypqAoFuzis2LVZFoRJkxWf3/wIlnaEPKY5SywTdFRf+Z9dYTOFuT22NdiPj1H
	1aw==
X-Google-Smtp-Source: AGHT+IFt+KQNer0HsT1+wyzNJuRXokrit8ZoX5QLwZzULjrNKOxXmFCFh9efFkgrYlVR68PULGJxjztoj4U=
X-Received: from pjtu6.prod.google.com ([2002:a17:90a:c886:b0:2ef:d283:5089])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:50cf:b0:2ff:6e72:b8e9
 with SMTP id 98e67ed59e1d1-309f56b55cfmr1082807a91.25.1745522331596; Thu, 24
 Apr 2025 12:18:51 -0700 (PDT)
Date: Thu, 24 Apr 2025 12:18:50 -0700
In-Reply-To: <20250423184326.GCaAk0zinljkNHa_M7@renoirsky.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aAKJkrQxp5on46nC@google.com> <20250418173643.GEaAKNq_1Nq9PAYf4_@fat_crate.local>
 <aAKaf1liTsIA81r_@google.com> <20250418191224.GFaAKkGBnb01tGUVhW@fat_crate.local>
 <aAfQbiqp_yIV3OOC@google.com> <20250422173355.GDaAfTA8GqnGBfDk7G@renoirsky.local>
 <aAfynEK3wcfQa1qQ@google.com> <20250423072017.GAaAiUsYzDOdt7cmp2@renoirsky.local>
 <aAj0ySpCnHf_SX2J@google.com> <20250423184326.GCaAk0zinljkNHa_M7@renoirsky.local>
Message-ID: <aAqOmjQ_bNy8NhDh@google.com>
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
> On Wed, Apr 23, 2025 at 07:10:17AM -0700, Sean Christopherson wrote:
> > On Wed, Apr 23, 2025, Borislav Petkov wrote:
> > > > Eww.  Optimization to lessen the pain of DR7 interception.  It'd be nice to clean
> > > > this up at some point, especially with things like SEV-ES with DebugSwap, where
> > > > DR7 is never intercepted.
> > > >   arch/x86/include/asm/debugreg.h:        if (static_cpu_has(X86_FEATURE_HYPERVISOR) && !hw_breakpoint_active())
> > > >   arch/x86/kernel/hw_breakpoint.c:                 * When in guest (X86_FEATURE_HYPERVISOR), local_db_save()
> > > 
> > > Patch adding it says "Because DRn access is 'difficult' with virt;..."
> > > so yeah. I guess we need to agree how to do debug exceptions in guests.
> > > Probably start documenting it and then have guest and host adhere to
> > > that. I'm talking completely without having looked at what the code does
> > > but the "handshake" agreement should be something like this and then we
> > > can start simplifying code...
> > 
> > I don't know that we'll be able to simplify the code.
> > 
> > #DBs in the guest are complex because DR[0-3] aren't context switched by hardware,
> > and running with active breakpoints is uncommon.  As a result, loading the guest's
> > DRs into hardware on every VM-Enter is undesirable, because it would add significant
> > latency (load DRs on entry, save DRs on exit) for a relatively rare situation
> > (guest has active breakpoints).
> > 
> > KVM (and presumably other hypervisors) intercepts DR accesses so that it can
> > detect when the guest has active breakpoints (DR7 bits enabled), at which point
> > KVM does load the guest's DRs into hardware and disables DR interception until
> > the next VM-Exit.
> > 
> > KVM also allows the host user to utilize hardware breakpoints to debug the guest,
> > which further adds to the madness, and that's not something the guest can change
> > or even influence.
> > 
> > So removing the "am I guest logic" entirely probably isn't feasible, because in
> > the common case where there are no active breakpoints, reading cpu_dr7 instead
> > of DR7 is a significant performance boost for "normal" VMs.
> 
> So I see three modes:
> 
> - default off - the usual case
> 
> - host debugs the guest
> 
> - guests are allowed to do breakpoints

Not quite.  KVM supports all of those seamlessly, with some caveats.  E.g. if
host userspace and guest kernel are trying to use the same DRx, the guest will
"lose" and not get its #DBs.

> So depending on what is enabled, the code can behave properly - it just
> needs logic which tells the relevant code - guest or host - which of the
> debugging mode is enabled. And then everything adheres to that and DTRT.
> 
> But before any of that, the even more important question is: do we even
> care to beef it up that much?
> 
> I get the feeling that we don't so it likely is a "whatever's the
> easiest" game.

Definitely not.  All I was thinking was something like:

diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
index fdbbbfec745a..a218c5170ecd 100644
--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -121,7 +121,7 @@ static __always_inline unsigned long local_db_save(void)
 {
        unsigned long dr7;
 
-       if (static_cpu_has(X86_FEATURE_HYPERVISOR) && !hw_breakpoint_active())
+       if (static_cpu_has(X86_FEATURE_DRS_MAY_VMEXIT) && !hw_breakpoint_active())
                return 0;
 
        get_debugreg(dr7, 7);

Where X86_FEATURE_DRS_MAY_VMEXIT is set if HYPERVISOR is detected, but then
cleared by SEV-ES+ and TDX guests with guaranteed access to DRs.  That said,
even that much infrastructure probably isn't worth the marginal benefits.

