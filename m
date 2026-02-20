Return-Path: <stable+bounces-217586-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cE2jDcyUmGlaJwMAu9opvQ
	(envelope-from <stable+bounces-217586-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 18:07:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4ED169939
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 18:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8834A300D150
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 17:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B9C3090E8;
	Fri, 20 Feb 2026 17:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kcJclAJ8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEF42D839E
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771607239; cv=none; b=gAmNJOanQCBg8r7i5Ord3Thsqe+qSffhGEBUDy+JyxyZ3VXcovOpbgrVK47sigveT5VrRu0ha2/Ud1WnTA4cnA2X2xrD3/FjmnFzwJeBrjtZ6/fVwfXtSVl07G/in9DjhshLvvO6JCGyAxIAtSl7uHsCYYMh6C3geOB6CQhrBCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771607239; c=relaxed/simple;
	bh=nTvKG2bYwt4WXjBgVLKMsVCflgzXNBIIVlM0LeA9T5k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LTnk+TM2vQjUBrVnCQM9nNy9SMAuzTvVpa+qZ6i0z1Ca35Aw5m5gEEeZOw+lgN8Z1ujEhrCkp4UcbBEklHNhAMyi/4Uav5VvlrEUYaAZFKfYLo1UMvO847Y/Bh54sEBd6h913+yBHpWl/qT0B18mZIJd6youuC5vpRiWVRUQ2XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kcJclAJ8; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2aadeb3dee4so166719505ad.2
        for <stable@vger.kernel.org>; Fri, 20 Feb 2026 09:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771607238; x=1772212038; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FQ61+EII6jhjSoVXf1SpvV9qDNdO2h+UXN+UPcHPg4I=;
        b=kcJclAJ89LbyDGHgJ4QfuBm43MbfCrIIFZbZhoAETJUGDnP9YuUWl2rDosh8iHRixX
         fBYE9RPQRmDRjLpC+klju/2IPojuwDiP1KZckgOB6hTv1VMdz1b0yYa6noo5kS00vEzQ
         JIpvjy4ysKWOWjwQKO4RMQqS5KIszFUcAzgNtqXOMPosTr1agn8jPehLSgQMzR+t72Aj
         lqRzq23VTAiPZSTVM3+V6oNDtNptZLLAv5YN5guhQWt8RrbOV/So2i2cfPFiG06tuW5n
         m+9nW0FbpieTVWtnndNB0ePpOjsV+elj+cVLtznsUCHXYMobUTkA45bmvQT8XZ19OJOo
         XDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771607238; x=1772212038;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FQ61+EII6jhjSoVXf1SpvV9qDNdO2h+UXN+UPcHPg4I=;
        b=LQ62e1sXWcvs862M20/oXOPCylUYaE9mq5Ybm/qDYk91mfKatl9yzVpLLkDzOiyrJJ
         QX3ME7g+P50svenbB5ktCOQGZz4+rMIspfnCBQ3li5Zq8WI3K0o7yMGFEV1XVTAZ2fY7
         dIRL3uwFw1C3erFCJieC3X4rIeWluGhIo8G8xPzl9Irz1xo77oawDwAh4N9ajFlMZa+I
         Vai8TJtRSc30jC9e0iW/ntmjTPNZDH31vqz2npHWMOWBlMbeaaEPUDw5SU076Lz86Tz6
         aPN0x3IqYuCfjSkbEWldDe7tz+7J11MtozQy6KsHOdwpLXCZh3xyf6jPCldScbz8xfBt
         jqww==
X-Forwarded-Encrypted: i=1; AJvYcCUiBZ+wm5Dmrq9vKJdWeazjeE2MFR0GRflf0jn1OLhkRoRQRgKLCT/Fg1x81umdiom0KXIF8JY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP0ijtrYeX9u+0ux6kw5U73o8h5V992aUCQY0iaFwb7JItzzX3
	Xfad2vrRMeowZh3+XzX+7HFsIwhTKauKyk6g6yWJxqai/5WfLKF/lK2E7SMLRaA5bsMk2Ilm6/n
	vpP6B6w==
X-Received: from plbks16.prod.google.com ([2002:a17:903:850:b0:2ab:348e:7201])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e949:b0:2aa:d65f:47a2
 with SMTP id d9443c01a7336-2ad7451cad0mr2076595ad.41.1771607237557; Fri, 20
 Feb 2026 09:07:17 -0800 (PST)
Date: Fri, 20 Feb 2026 09:07:16 -0800
In-Reply-To: <wwa2h5gcb7gfxgmsh3jdwa4d4xurkmgd26dnkwupgzcln3khfu@v3w2w6nf4tq7>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260212230751.1871720-1-yosry.ahmed@linux.dev>
 <20260212230751.1871720-5-yosry.ahmed@linux.dev> <aZZVqQrQ1iCNJhJJ@google.com>
 <wwa2h5gcb7gfxgmsh3jdwa4d4xurkmgd26dnkwupgzcln3khfu@v3w2w6nf4tq7>
Message-ID: <aZiUxBRPovFd4nDd@google.com>
Subject: Re: [RFC PATCH 4/5] KVM: SVM: Recalculate nested RIPs after restoring REGS/SREGS
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217586-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E4ED169939
X-Rspamd-Action: no action

On Thu, Feb 19, 2026, Yosry Ahmed wrote:
> > E.g. after patch 2, completely untested...
> > 
> > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > index aec17c80ed73..6fc1b2e212d2 100644
> > --- a/arch/x86/kvm/svm/nested.c
> > +++ b/arch/x86/kvm/svm/nested.c
> > @@ -863,12 +863,9 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
> 
> Above the context lines we have:
> 
>         /*
>          * next_rip is consumed on VMRUN as the return address pushed on the
>          * stack for injected soft exceptions/interrupts.  If nrips is exposed
>          * to L1, take it verbatim from vmcb12.  If nrips is supported in
>          * hardware but not exposed to L1, stuff the actual L2 RIP to emulate
>          * what a nrips=0 CPU would do (L1 is responsible for advancing RIP
>          * prior to injecting the event).
>          */
>         if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
>                 vmcb02->control.next_rip    = svm->nested.ctl.next_rip;
>         else if (boot_cpu_has(X86_FEATURE_NRIPS))
>                 vmcb02->control.next_rip    = vmcb12_rip;
> 
> The same bug affects vmcb02->control.next_rip when the guest doesn't
> have NRIPS. I think we don't want to move part of the vmcb02
> initialization before VMRUN too. We can keep the initialization here and
> overwrite it before VMRUN if needed, but that's just also ugh..

Aha!  I knew I was missing something, but I couldn't quite get my brain to figure
out what.

I don't have a super strong preference as to copying the code or moving it
wholesale.  Though I would say if the pre-VMRUN logic is _identical_ (and I think
it is?), then we move it, and simply update the comment in
nested_vmcb02_prepare_control() to call that out.

> >         svm->nmi_l1_to_l2 = is_evtinj_nmi(vmcb02->control.event_inj);
> >         if (is_evtinj_soft(vmcb02->control.event_inj)) {
> >                 svm->soft_int_injected = true;
> > -               svm->soft_int_csbase = vmcb12_csbase;
> > -               svm->soft_int_old_rip = vmcb12_rip;
> > +
> >                 if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
> >                         svm->soft_int_next_rip = svm->nested.ctl.next_rip;
> 
> Why not move this too?

For the same reason I think we should keep 

	if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
		vmcb02->control.next_rip    = svm->nested.ctl.next_rip;

where it is.  When NRIPS is exposed to the guest, the incoming nested state is
the one and only source of truth.  By keeping the code different, we'd effectively
be documenting that the host.NRIPS+!guest.NRIPS case is the anomaly.

> > -               else
> > -                       svm->soft_int_next_rip = vmcb12_rip;
> >         }
> >  
> >         /* LBR_CTL_ENABLE_MASK is controlled by svm_update_lbrv() */
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index 8f8bc863e214..358ec940ffc9 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -4322,6 +4322,14 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
> >                 return EXIT_FASTPATH_EXIT_USERSPACE;
> >         }
> >  
> > +       if (is_guest_mode(vcpu) && svm->nested.nested_run_pending &&
> > +           svm->soft_int_injected) {
> > +               svm->soft_int_csbase = svm->vmcb->save.cs.base;
> > +               svm->soft_int_old_rip = kvm_rip_read(vcpu);
> > +               if (!guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
> > +                       svm->soft_int_next_rip = kvm_rip_read(vcpu);
> > +       }
> > +
> 
> I generally dislike adding more is_guest_mode() stuff in svm_vcpu_run(),
> maybe we can refactor them later to pre-run and post-run nested
> callbacks? Anyway, not a big deal, definitely an improvement over the
> current patch assuming we can figure out how to fix next_rip.

I don't love it either, but I want to (a) avoid unnecessarily overwriting the
fields, e.g. if KVM never actually does VMRUN and (b) minimize the probability
of consuming a bad RIP.

In practice, I would expect the nested_run_pending check to be correctly predicted
the overwhelming majority of the time, i.e. I don't anticipate performance issues
due to putting the code in the hot path.

If we want to try and move the update out of svm_vcpu_run(), then we shouldn't
need generic pre/post callbacks for nested, svm_prepare_switch_to_guest() is the
right fit.


