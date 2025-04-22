Return-Path: <stable+bounces-135190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47089A975F7
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 21:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9FC43BBD3C
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 19:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED22B291140;
	Tue, 22 Apr 2025 19:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YCpwsc0h"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD04284B21
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 19:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745351328; cv=none; b=JmzS2TTdGzvYr1tbyNo9DdTfU/hBuCvCFMTQQfP7OuS8ls7t7FN5znyrQRzqL/Qh87NDZekQalng8ZzS5PXgg32mlUcQiYimHOWIM6ZC1ctpT/CK9mivCzbcITY2D/O6opyMWj91ZD5FgpuT7kzFgRFyC55yOHfehDaVQL3n30s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745351328; c=relaxed/simple;
	bh=gxTbnWTJB50n3KzhRveyIpup2aByT+oX6qk2Z9xPy5A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S17OH18HkCDodSNWJL7ewZFL+5NNKx6+VQYOGrg99omFsO/v6fTmo9V1edtA76NDhEugnz803+Kq4afcT4QnJLp4kPZWz6E7xg2MHqL5UJtAuzE4XRbOMFNGXX2bZQqSYU8NECGQumYZXGWuCtGo6EhVbT/P/SB1cXJzYmS4/yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YCpwsc0h; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af972dd0cd6so3271945a12.1
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 12:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745351326; x=1745956126; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TYP8FWYioRIH49o2SbBA+hnHBHTmzAHRk/jhuz8dPh0=;
        b=YCpwsc0h4QS3vP3MBV5hcuYFMjvfLFlWAsR2l9A+I19m9Z/0jG1uuW8jaywFiWGY50
         NuQX32XyPvHjKm7Pm9GrWHddY4at3JrjK+KG1OJ890qPb0Dp1185mxQWmD9e6avP80R2
         hMLAq4dVgQ1ZKClsyQna/00DUAK+CWfKzDSI9UHGqvLvLx/Hqo2flqtrtkIYYLSRuv1u
         aOLyeJbDMSVLwzXRDivjXrdHLJw6vthnd4za6jvNkmaz+1/79XJIHftgScMjr70L9DD3
         Lq0FlSPcoFag9ikg1prBoSdfO902ARI/Egm5pZv3Y5RzWFKRWcqswqzsUtH6XHDqtFdn
         aYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745351326; x=1745956126;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TYP8FWYioRIH49o2SbBA+hnHBHTmzAHRk/jhuz8dPh0=;
        b=E4SxpKrarxFOi+uPDzULjP6ryYgXcrh+7RHr384+ctzHa3RxUoExCGjfGSyplwzPZG
         V6LZJTdMyvZ9vMdPJzoazaZipmS9SO5ySV1S5TAgkT5Z+G41b3Is78noH1SiQctrt0oi
         xiBQFm+0TO7OCJpWqrBTBYdobHVqYJ/ipjRKY5kC7dOrffGrss4zLVb33jug7/W+O6jj
         L207jHHtEN1wVA278zYSzcMa3eHnwN8We8Fx344+vI1LIzsQ22ZhDXL4ndyL2yPmgeeV
         H/HfV06ir9Bwbd4BxpOs5aC8eef7eRQjbbaakwDKfxgY1LwqHZkhs6SiraFyLSFz3BLs
         ot9g==
X-Forwarded-Encrypted: i=1; AJvYcCUNAPhVG2QKY/uMIQgJgud4NyVYN8NMFAx5zZhFo7GAy6M/R7E4tdFgrSYCXBJh41BF0YeEJ4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys1gBb6XBeL10SXfa9uQsh59HASCDF+hD+tvffItois6MToU2f
	+Tm1/lD6AWfow5jFPisjKK0B24QNsBfXNaUeLce4N1FfheyKMrrtdRRJgeRFd7cEt565GjIE59T
	lpQ==
X-Google-Smtp-Source: AGHT+IHwSsIYgf8vWT+jRC6Pvxw4AVQcEw1SpJ2dRt6hC00hrYnmArGpQ4+avg4Rfx1Mpw65htDaczncQaU=
X-Received: from pjbdj15.prod.google.com ([2002:a17:90a:d2cf:b0:2ff:5752:a78f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ed0:b0:2ea:3f34:f18f
 with SMTP id 98e67ed59e1d1-3087bb69c30mr20376842a91.19.1745351326271; Tue, 22
 Apr 2025 12:48:46 -0700 (PDT)
Date: Tue, 22 Apr 2025 12:48:44 -0700
In-Reply-To: <20250422173355.GDaAfTA8GqnGBfDk7G@renoirsky.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250331143710.1686600-1-sashal@kernel.org> <20250331143710.1686600-2-sashal@kernel.org>
 <aAKDyGpzNOCdGmN2@duo.ucw.cz> <aAKJkrQxp5on46nC@google.com>
 <20250418173643.GEaAKNq_1Nq9PAYf4_@fat_crate.local> <aAKaf1liTsIA81r_@google.com>
 <20250418191224.GFaAKkGBnb01tGUVhW@fat_crate.local> <aAfQbiqp_yIV3OOC@google.com>
 <20250422173355.GDaAfTA8GqnGBfDk7G@renoirsky.local>
Message-ID: <aAfynEK3wcfQa1qQ@google.com>
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

On Tue, Apr 22, 2025, Borislav Petkov wrote:
> On Tue, Apr 22, 2025 at 10:22:54AM -0700, Sean Christopherson wrote:
> > > Because I really hate wagging the dog and "fixing" the kernel because something
> > > else can't be bothered. I didn't object stronger to that fix because it is
> > > meh, more of those "if I'm a guest" gunk which we sprinkle nowadays and that's
> > > apparently not that awful-ish...
> > 
> > FWIW, I think splattering X86_FEATURE_HYPERVISOR everywhere is quite awful.  There
> > are definitely cases where the kernel needs to know if it's running as a guest,
> > because the behavior of "hardware" fundamentally changes in ways that can't be
> > enumerated otherwise.  E.g. that things like the HPET are fully emulated and thus
> > will be prone to significant jitter.
> > 
> > But when it comes to feature enumeration, IMO sprinkling HYPERVISOR everywhere is
> > unnecessary because it's the hypervisor/VMM's responsibility to present a sane
> > model.  And I also think it's outright dangerous, because everywhere the kernel
> > does X for bare metal and Y for guest results in reduced test coverage.
> > 
> > E.g. things like syzkaller and other bots will largely be testing the HYPERVISOR
> > code, while humans will largely be testing and using the bare metal code.
> 
> All valid points...
> 
> At least one case justifies the X86_FEATURE_HYPERVISOR check: microcode loading
> and we've chewed that topic back then with Xen ad nauseam.

Yeah, from my perspective, ucode loading falls into the "fundamentally different"
bucket.

> 
> But I'd love to whack as many of such checks as possible.
> 
> $ git grep X86_FEATURE_HYPERVISOR | wc -l
> 60
> 
> I think I should start whacking at those and CC you if I'm not sure.
> It'll be a long-term, low prio thing but it'll be a good cleanup.

I did a quick pass.  Most of the usage is "fine".  E.g. explicit PV code, cases
where checking for HYPERVISOR is the least awful option, etc.

Looks sketchy, might be worth investigating?
--------------------------------------------
  arch/x86/kernel/cpu/amd.c:              if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
  arch/x86/kernel/cpu/amd.c:      if (!cpu_has(c, X86_FEATURE_HYPERVISOR) && !cpu_has(c, X86_FEATURE_IBPB_BRTYPE)) {
  arch/x86/kernel/cpu/amd.c:      if (c->x86_model < 0x14 && cpu_has(c, X86_FEATURE_LAHF_LM) && !cpu_has(c, X86_FEATURE_HYPERVISOR)) {
  arch/x86/kernel/cpu/amd.c:      if (!cpu_has(c, X86_FEATURE_HYPERVISOR)) {
  arch/x86/kernel/cpu/amd.c:      if (!cpu_has(c, X86_FEATURE_HYPERVISOR)) {
  arch/x86/kernel/cpu/amd.c:      if (cpu_has(c, X86_FEATURE_HYPERVISOR))
  arch/x86/kernel/cpu/amd.c:      if (!cpu_has(c, X86_FEATURE_HYPERVISOR)) {
  arch/x86/kernel/cpu/amd.c:      if (!cpu_has(c, X86_FEATURE_HYPERVISOR))
  arch/x86/kernel/cpu/topology_amd.c:             if (!boot_cpu_has(X86_FEATURE_HYPERVISOR) && tscan->c->x86_model <= 0x3) {
  arch/x86/mm/init_64.c:  if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
  arch/x86/mm/pat/set_memory.c:   return !cpu_feature_enabled(X86_FEATURE_HYPERVISOR);
  drivers/platform/x86/intel/pmc/pltdrv.c:        if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR) && !xen_initial_domain())
  drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c: if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
--------------------------------------


Could do with some love, but not horrible.
------------------------------------------
Eww.  Optimization to lessen the pain of DR7 interception.  It'd be nice to clean
this up at some point, especially with things like SEV-ES with DebugSwap, where
DR7 is never intercepted.
  arch/x86/include/asm/debugreg.h:        if (static_cpu_has(X86_FEATURE_HYPERVISOR) && !hw_breakpoint_active())
  arch/x86/kernel/hw_breakpoint.c:                 * When in guest (X86_FEATURE_HYPERVISOR), local_db_save()

This usage should be restricted to just the FMS matching, but unfortunately
needs to be kept for that check.
  arch/x86/kernel/cpu/bus_lock.c: if (boot_cpu_has(X86_FEATURE_HYPERVISOR))

Most of these look sane, e.g. are just being transparent about the state of
mitigations when running in a VM.  The use in update_srbds_msr() is the only
one that stands out as somewhat sketchy.
  arch/x86/kernel/cpu/bugs.c:     if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
  arch/x86/kernel/cpu/bugs.c:     else if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
  arch/x86/kernel/cpu/bugs.c:     if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
  arch/x86/kernel/cpu/bugs.c:     if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
  arch/x86/kernel/cpu/bugs.c:     if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
  arch/x86/kernel/cpu/bugs.c:     if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
------------------------------------------


Don't bother
------------------------------------------
Most of these look sane, e.g. are just being transparent about the state of
mitigations when running in a VM.  The use in update_srbds_msr() is the only
one that stands out as somewhat sketchy.
  arch/x86/kernel/cpu/bugs.c:     if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
  arch/x86/kernel/cpu/bugs.c:     else if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
  arch/x86/kernel/cpu/bugs.c:     if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
  arch/x86/kernel/cpu/bugs.c:     if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
  arch/x86/kernel/cpu/bugs.c:     if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
  arch/x86/kernel/cpu/bugs.c:     if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {

Perf, don't bother.  PMUs are notoriously virtualization-unfriendly, and perf
has had to resort to detecting its running in a VM to avoid crashing the kernel,
and I don't see this being fully solved any time soon.
  arch/x86/events/core.c: if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
  arch/x86/events/intel/core.c:   if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
  arch/x86/events/intel/core.c:           int assume = 3 * !boot_cpu_has(X86_FEATURE_HYPERVISOR);
  arch/x86/events/intel/cstate.c: if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
  arch/x86/events/intel/uncore.c: if (boot_cpu_has(X86_FEATURE_HYPERVISOR))

PV code of one form or another.
  arch/x86/include/asm/acrn.h:    if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
  arch/x86/hyperv/ivm.c:  if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
  arch/x86/kernel/cpu/mshyperv.c: if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
  arch/x86/kernel/cpu/vmware.c: * If !boot_cpu_has(X86_FEATURE_HYPERVISOR), vmware_hypercall_mode
  arch/x86/kernel/cpu/vmware.c:   if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
  arch/x86/kernel/jailhouse.c:        !boot_cpu_has(X86_FEATURE_HYPERVISOR))
  arch/x86/kernel/kvm.c:  if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
  arch/x86/kernel/paravirt.c:     if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
  arch/x86/kernel/tsc.c:  if (boot_cpu_has(X86_FEATURE_HYPERVISOR) ||
  arch/x86/kvm/vmx/vmx.c: if (!static_cpu_has(X86_FEATURE_HYPERVISOR) ||
  arch/x86/virt/svm/cmdline.c:                    if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR)) {

Ugh.  Eliding WBINVD when running as a VM.  Probably the least awful option as
there's no sane way to enumerate that WBINVD is a nop, and a "passthrough" setup
can (and should) simply omit HYPERVISOR.
  arch/x86/include/asm/acenv.h:   if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))       \

Skip sanity check on TSC deadline timer.  Makes sense to keep; either the timer
is emulated and thus not subject to hardware errata, or its passed through, in
which case HYPERVSIOR arguably shouldn't be set.
  arch/x86/kernel/apic/apic.c:    if (boot_cpu_has(X86_FEATURE_HYPERVISOR))

This "feature" is awful, but getting rid of it may not be feasible.
https://lore.kernel.org/all/20250201005048.657470-1-seanjc@google.com
  arch/x86/kernel/cpu/mtrr/generic.c:     if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))

Exempting VMs from a gross workaround for old, buggy Intel chipsets.  Fine to keep.
  drivers/acpi/processor_idle.c:  if (boot_cpu_has(X86_FEATURE_HYPERVISOR))

More mitigation crud, probably not worth pursuing.
  arch/x86/kernel/cpu/common.c:        boot_cpu_has(X86_FEATURE_HYPERVISOR)))
  arch/x86/kernel/cpu/common.c:   if (cpu_has(c, X86_FEATURE_HYPERVISOR)) {

LOL.  Skip ucode revision check when detecting bad Spectre mitigation.
  arch/x86/kernel/cpu/intel.c:    if (cpu_has(c, X86_FEATURE_HYPERVISOR))
------------------------------------------

