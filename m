Return-Path: <stable+bounces-217795-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNAdExyInGm7IwQAu9opvQ
	(envelope-from <stable+bounces-217795-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:02:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8EE17A454
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CC8E308C595
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 16:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8744032470D;
	Mon, 23 Feb 2026 16:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DyWJVd01"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B3F31B839
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 16:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771865981; cv=none; b=RsM2GzQPGGT5TQG5z2V7yZ/JmggTPvq5rOCSoovOkAndnYtKgEyQrlH4MtzhBrPCY+oJgEmuD6sSLhDM0cgMq2F8te7m+VStV2ZtjxdaS/1J4z6k7EPUy4onWlGOKGsr6lt8zHO5bfT1cgMQ9p6x/JzV8QRnT9FZzxg3NRiHFVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771865981; c=relaxed/simple;
	bh=+dsoE7weZlfxZS1dnelJZwlS6ZQeOrbFErLKEQkTXX0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IrCW3L+Wlb1GguV9jdR2HZMksFWDzI0Y1DXkhlrCYQinawdTR5dr+9WKiKI/mYCH3PsmcO6IB+inNgV4E4zP4njc0ED/ejU3H4BEYASMWkr7Qu7+oooMLTemdRpjjOLUDHSn67OrjunNuEAn+LkDYdgEecZj/W403BMv35mSLSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DyWJVd01; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c70b6a624bfso1431612a12.1
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 08:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771865978; x=1772470778; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cFcdxHavVfrpwI540piZzgBIy8xP7SV6WzTjsn6ue8w=;
        b=DyWJVd01HptGiu5LhtwqeFo5vPP0oov55oeT/M4K0+OxmMKyvkuq3Pq5lcIcgw2JJu
         HvZwVtx8psKxnwYEHHokKI9SVtWj/Ntii85G6Lu4O/zSR4RbCIeBApDjFRJhH4JVg3O3
         bmjIsfDV6Xba8iiNiF3ep21Y//Tqs4CtRZ+vzwu/I9sstOv+TFajABbPZwxtCgJFCoJL
         gw5kIuA1lwbZFkqCQ+sGH5WqHcFfrE0hcT6fXzzorM6WepDq227afeoRSCM+GLewKtYM
         CVfTavCcIhNaZ5EVPd3j9t5Ev9pDZbN0TrHELnh0eV8sTwSOxR0As7EZKa9Cm4jqGuLZ
         +K7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771865978; x=1772470778;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cFcdxHavVfrpwI540piZzgBIy8xP7SV6WzTjsn6ue8w=;
        b=jblh9RO6l8WJ0tXAl3WkfbYhgovGiC6ExHwF/ad+n64uJyaw9+n7r0ECH6PxglgDot
         hJufrwQTuIYxMrnqhyw2wY0UrALd+Y/npt5ceTI4TruW7m0nBJ55tQzQQGUulh/9u7tA
         qcVqbI31+kWQpGE8tBan4WLli7Z0ptWljDhx78mJaykB9zR0UW/mIZW7dd4Cf1gCxd2Q
         RUghoHXBV16CgXuny/F+YmRJNXErvtHeB9fiTyZIh2gWgF1QGqL+N/m45/RcQ+ZQhQjg
         gVcrBoOp/AKoF0kET3yPe3itYzX+xTSRVtDNDrWbY7zgWa8b0jZaI1ItT0qqX4i9wVbe
         cbyw==
X-Forwarded-Encrypted: i=1; AJvYcCUnqdoaYs89+GYdWdDrn/NxjvK1iTXN1JqRPwKKcfBBtr9CiOLxIz4qga4VikRhgW6zEz264lM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwPJZow8aqQ9Fa5REesnbv0Knf+kyiaw8xvcwIDruT+EwZKiOn
	x/QWbjompO7ALsUEC/W+C6W0F1NZempTq5cE6ZrYOSGYis/JPtvgiht2gOD0ItyhVVXYwZ9KxVR
	Fbh0PXw==
X-Received: from plsu2.prod.google.com ([2002:a17:902:bf42:b0:2aa:d1fe:fa78])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce0a:b0:2a7:c188:bd1b
 with SMTP id d9443c01a7336-2ad742e44efmr89226295ad.25.1771865977618; Mon, 23
 Feb 2026 08:59:37 -0800 (PST)
Date: Mon, 23 Feb 2026 08:59:36 -0800
In-Reply-To: <ftjb625b4wsz5vdty3fcxqanuxriiqcewqkzp2ml2hc4eojuoc@ewhboiiqmcd4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aYqOkvHs3L-AX-CG@google.com> <4g25s35ty23lx2je4aknn6dg4ohviqhkbvvel4wkc4chhgp6af@kbqz3lnezo3j>
 <aYuE8xQdE5pQrmUs@google.com> <ck57mmdt5phh64cadoqxylw5q2b72ffmabmlzmpphaf27lbtxw@4kscovf6ahve>
 <aYvIpwjsJ50Ns4ho@google.com> <mxn6y6og34ejncnsvdapcoep4ewcnwnheszhwkp2undkqcu5zv@bpmseexuug5z>
 <aYvPwH8JcRItaQRI@google.com> <smsla7jgdncodh57uh7dihumnteu5sgxyzby2jc6lcp3moayzf@ixqj4ivmlgb2>
 <aZj2V9-noq10b5CM@google.com> <ftjb625b4wsz5vdty3fcxqanuxriiqcewqkzp2ml2hc4eojuoc@ewhboiiqmcd4>
Message-ID: <aZyHeKp2Dzzrjb5C@google.com>
Subject: Re: [PATCH 1/4] KVM: nSVM: Sync next_rip to cached vmcb12 after VMRUN
 of L2
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-217795-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB8EE17A454
X-Rspamd-Action: no action

On Sat, Feb 21, 2026, Yosry Ahmed wrote:
> [..]
> > > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > > index de90b104a0dd..0a73dd8f9163 100644
> > > --- a/arch/x86/kvm/svm/nested.c
> > > +++ b/arch/x86/kvm/svm/nested.c
> > > @@ -1343,10 +1343,17 @@ static void nested_svm_triple_fault(struct kvm_vcpu *vcpu)
> > >         nested_svm_simple_vmexit(to_svm(vcpu), SVM_EXIT_SHUTDOWN);
> > >  }
> > > 
> > > +static const struct vmcb_ctrl_area_cached *svm_cached_vmcb12_control(struct vcpu_svm *svm) {
> > > +       return &svm->nested.ctl;
> > > +}
> > 
> > ...
> > 
> > > Is this sufficient?
> > 
> > It's certainly better, but unless a sea of helpers is orders of magnitude worse,
> > I would prefer to make it even harder to put hole in our foot.
> > 
> > E.g. unless we're hyper diligent about constifying everything, it's not _that_
> > hard to imagine a chain of events where we end up with a "live" pointer to the
> > cache.
> > 
> >   1. A helper like __nested_vmcb_check_controls() isn't const, so we cast to strip
> >      the const.
> 
> I would argue that casting to strip the const is a red flag and this
> scenario should have stopped here :P

Key word "should" :-)

> > > > Oh, good point.  In that case, I think it makes sense to add the flag asap, so
> > > > that _if_ it turns out that KVM needs to consume a field that isn't currently
> > > > saved/restored, we'll at least have a better story for KVM's that save/restore
> > > > everything.
> > > 
> > > Not sure I follow. Do you mean start serializing everything and setting
> > > the flag ASAP (which IIUC would be after the rework we discussed), 
> > 
> > Yep.
> 
> I don't think it matters that much when we start doing this. In all
> cases:
> 
> 1. KVM will need to be backward-compatible.
> 
> 2. Any new features that depend on save+restore of those fields will be
> a in a new KVM that does the 'full' save+restore (assuming we don't let
> people add per-field flags).
> 
> The only scenario that I can think of is if a feature can be enabled at
> runtime, and we want to be able to enable it for a running VM after
> migrating from an old KVM to a new KVM. Not sure how likely this is.

The scenario I'm thinking of is where we belatedly realize we should have been
saving+restoring a field for a feature that is already supported, e.g. gpat.  If
KVM saves+restores everything, then we don't have to come up with a hacky solution
for older KVM, because it already provides the desired behavior for the "save",
only the "restore" for the older KVM is broken.

Does that make sense?  It makes sense in my head, but I'm not sure I communicated
the idea very well...

