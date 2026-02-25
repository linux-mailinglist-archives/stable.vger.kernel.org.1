Return-Path: <stable+bounces-218033-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJouDbxInmnXUQQAu9opvQ
	(envelope-from <stable+bounces-218033-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:56:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AED18E6D0
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE556300DCCA
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 00:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8766C1E5B63;
	Wed, 25 Feb 2026 00:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eyc/bi5y"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104AC239086
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 00:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771980985; cv=none; b=IjTeJgLnLXjTwj3GaHRzxr63QtcIjvciWIMGmIR8OLyGofsArZ0Z4kumIwcYwOFE1TxLdEWYcKmntc7SIKuMWzet+nGDfsJRd0q4qrCmh1zV92K6jyIxQCvYEA40CPt2Jv0LVJ7C1nZFdwXO+iiHuPUGq8iTxQgMtTU+ALMpb7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771980985; c=relaxed/simple;
	bh=HUsEH3vAov9bqqGGvpXRRVwKKLNpfbdx08NYR/odYGw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gh1PaTHQRCDUaHNO9eK2zR+w1pIW4adJ0EkerwjSbpKqn2ZgqoKwoorOoy5sQpjqgudjP3vDq3+y59qzZsIgoz6d9SHf7u9UWvDlA4gUouZSGh/sIB286zosDcbb8c4m1YD6eHJmFnvIWiYQXVx0cbQleMhkP2hyj3DUcB+cE20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eyc/bi5y; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-824f7591956so22028366b3a.1
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 16:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771980983; x=1772585783; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wj9sDKWv3dHqZ+EDUSj6kle5HwXIpR1sWpYbztdJ+So=;
        b=eyc/bi5yeuFSpipPXd/fSm/F8P0/wG9bDy+tODzdpTEFv2qHaa7t9RvVVeD0prMzxI
         bHglwQ7EZla4Wf8weXBdwovBI3aI3kGFHoGd37fWcSTTFkah9AXUicqE1TXy2wvcrGKs
         ANbvGdEdlkgeFh62R+8DqasDMkMNFd9sZs3jhpEu5Yu9Pa+A/yCzC9OYIEoCcU0WtNEB
         TfpXuQHEzKbGr81eZO5MEZe5QijE8bNp2KZ66B0m6ptHL/7zqQSfV3l5oVl4repAsjqv
         tupZyG7aSTLNUcmLUCjsRMRUI/m0bSL6NGY2olqmDVmXU7TvVyiCxPBbxS3w8Wp9x5jT
         2Dhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771980983; x=1772585783;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wj9sDKWv3dHqZ+EDUSj6kle5HwXIpR1sWpYbztdJ+So=;
        b=h8vHtyZaPwmsbAFhirjRvlnSaeqylfysp6isIngproKhC/xgyLnOatjwM1ziJdE/oa
         MO8+eXh7OgAgIu8V8nTzrd8DSHgDQ2H9KklVf0WOgrSAWRxpOq3/PPFdnsPpxk71JX04
         fplL/Au9CPivZZTD4xk4GOG+BBA4mDUgcMa0B/1Pog4TyxEu6K7y3zsQekapcu1jEfkx
         /rzKkemdoWGyfi4snDgwIXXDH6QAcWYjFzd1sqa6e9bk2vujNjamYjQGz5/dcuKcIzbr
         y5VgFDOpn7Y8hhmcD++Gb5ORbWRVrX+/00/Z7wsO0FvvnOG399ocvbCnfQKz7tB67TiZ
         EFaA==
X-Forwarded-Encrypted: i=1; AJvYcCVjABY+c3Iq1ktolCGMdBjVJBUJ9/zRNQ+rvkZCZ+po+6obVv8s3AZORRnfe0YeIxnkuJecj4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8EsIz0VkKzANaMUz3zKJhHPJd6yywHrVyTitSt53lVSkmBIY4
	POjdcbRN+gFaIlMeC6Son6mp+I/KNx7HsbyF7/XHibW8uCDiMEvODk8GxjsFS/q8Hoxjj3oh+NX
	1e/nkDQ==
X-Received: from pfqy30.prod.google.com ([2002:aa7:9e1e:0:b0:806:cdd:6793])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1944:b0:821:7d7e:41cd
 with SMTP id d2e1a72fcca58-827249d0e01mr404507b3a.10.1771980983105; Tue, 24
 Feb 2026 16:56:23 -0800 (PST)
Date: Tue, 24 Feb 2026 16:56:21 -0800
In-Reply-To: <CAO9r8zPsAMaiU794xoXDso3sdAM0_EN2PyE13vR4NqqEh9e2=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260223154636.116671-1-yosry@kernel.org> <20260223154636.116671-3-yosry@kernel.org>
 <CAO9r8zPsAMaiU794xoXDso3sdAM0_EN2PyE13vR4NqqEh9e2=g@mail.gmail.com>
Message-ID: <aZ5ItfEUtIlVbzuQ@google.com>
Subject: Re: [PATCH v1 2/4] KVM: nSVM: Delay stuffing L2's current RIP into
 NextRIP until vCPU run
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-218033-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7AED18E6D0
X-Rspamd-Action: no action

On Tue, Feb 24, 2026, Yosry Ahmed wrote:
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index 8f8bc863e2143..e084b9688f556 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -1413,6 +1413,24 @@ static void svm_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
> >                 sd->bp_spec_reduce_set = true;
> >                 msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_BP_SPEC_REDUCE_BIT);
> >         }
> > +
> > +       /*
> > +        * If nrips is supported in hardware but not exposed to L1, stuff the
> > +        * actual L2 RIP to emulate what a nrips=0 CPU would do (L1 is
> > +        * responsible for advancing RIP prior to injecting the event). Once L2
> > +        * runs after L1 executes VMRUN, NextRIP is updated by the CPU and/or
> > +        * KVM, and this is no longer needed.
> > +        *
> > +        * This is done here (as opposed to when preparing vmcb02) to use the
> > +        * most up-to-date value of RIP regardless of the order of restoring
> > +        * registers and nested state in the vCPU save+restore path.
> > +        */
> > +       if (is_guest_mode(vcpu) && svm->nested.nested_run_pending) {
> > +               if (boot_cpu_has(X86_FEATURE_NRIPS) &&
> > +                   !guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
> > +                       svm->vmcb->control.next_rip = kvm_rip_read(vcpu);
> > +       }
> > +
> 
> Doing this in svm_prepare_switch_to_guest() is wrong, or at least
> after the svm->guest_state_loaded check. It's possible to emulate the
> nested VMRUN without doing a vcpu_put(), which means
> svm->guest_state_loaded will remain true and this code will be
> skipped.
> 
> In fact, this breaks the svm_nested_soft_inject_test test. Funny
> enough, I was only running it with my repro changes, which papered
> over the bug because it forced an exit to userspace after VMRUN due to
> single-stepping, so svm->guest_state_loaded got cleared and the code
> was executed on the next KVM_RUN, before L2 runs.
> 
> I can move it above the svm->guest_state_loaded check, but I think I
> will just put it in pre_svm_run() instead.

I would rather not expand pre_svm_run(), and instead just open code it in
svm_vcpu_run().  pre_svm_run() probably should never have been added, because
it's far from a generic "pre run" API.  E.g. if we want to keep the helper around,
it should probably be named something something ASID.

