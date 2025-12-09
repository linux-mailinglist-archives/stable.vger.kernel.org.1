Return-Path: <stable+bounces-200475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB93CB0D6E
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 19:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBBCF3013EB6
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 18:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B802FBDF5;
	Tue,  9 Dec 2025 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hH2Fyrz5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04B62EE262
	for <stable@vger.kernel.org>; Tue,  9 Dec 2025 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765304795; cv=none; b=pdAuN6tRan1PsRGbJcHA31dlf8LFFJDIV9pk5MR8mJooKzpVlwcsCX/+2Kt25pwq56QCzTjrNH+iqSKaY7C0sChY+wQBIpOFcRyw7B2+Oaj2jMt/jIDOzbMe+N+B9fFuepkVE1W2sHYI4x7sN6JDQf2s8ydkG3/V2cXmws9Fals=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765304795; c=relaxed/simple;
	bh=nl3prqAPdUFLhr/YxSYqMVw69tQOJIma2pVVbrbh130=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XnaFoN6etjITdnG55XFNj/Xk66rGc6DR+UkA3idqWmbxuvmxCR1Q/N/jEbke71ttYGn34n9P7nG0+o1K2WRfQhrXhkPnC1kPKmETWrPl++esnX3hrStCeC/qpKwmSKM9H9hbbWptu238ose2b0cD0GPksZs008o2o7BR+zlghKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hH2Fyrz5; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-349a2f509acso6052268a91.1
        for <stable@vger.kernel.org>; Tue, 09 Dec 2025 10:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765304793; x=1765909593; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=chxjnCbu+CsaovuIX/QetPvLM5FaBl5fhlMK8A/Bgj8=;
        b=hH2Fyrz5z+s/kERuijL2B+DrQNFFRL+XPHrzTUkpEfHW16VsEdFFfgAo1k9QVx/XBc
         r6F9jLZ0lqxEc4za6v7f++A2Bpvo+kZUQ+p5WdwXv+4TBrPchdyaPp+knG74qV6no3O1
         xWrwq+zbzIqTsbZafB9OGw9BfQiRjIKABpnTS7UfhHkaTjKQRE0kejS1mJLdchRFoCpV
         IddUT0NjW0+biGt1gbTE32jVwuOJJ+HDXaTX/xRbFQGIYb4dh1v+8VqBftJ68dsGrbSg
         ZjFd1XFAheBgdapX9RVfGVNpnJ1YIi+wOnqcopePZC+kiJMUhqDJNAoPGu/IXoD76xa/
         uZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765304793; x=1765909593;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=chxjnCbu+CsaovuIX/QetPvLM5FaBl5fhlMK8A/Bgj8=;
        b=sZNeKuxGYYBvVI9PoD6wQ3dMex8BwUmFvsNOJNsFMaq4uDi1jjIPjAaOQkL0OZKW92
         pDQSn5tvqWH2qmQzH4L9Kds/CaVp/hoql6F6HtG9fAY5pbVmxpgmo8Ek3eytfO3X43gk
         8YSCZSLBv3Sj84wj8yOURXfF9j1B5YBEFH0HOk3nJkfsxVm6krT6WkbFb+PXYLmMXItM
         a9872gpR8Lx6rkVf1jiYh/6u42Lu4/hbW8NTlHWlzun2iuWE7PGzqGC3BaNLoi32S1xP
         x53j373vMC6Zr4aV/UKGaELjw+Mng/fTzv2JvzEiiI2/pYL889gHV6NljVh8YWNYCdIt
         RcyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF6FJznhW3EHcWC81cF0oqUKRNzmLtCeZfsT+mBQh9hGDzpZqZsu/bioJq1WMDhSbom2I09AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBkyotJBNiKdvJ9gOHFMns+pgem5oONcA1S/MWowh+zgn94wBs
	0Ijvft68J8nPL/o0qTvyPI6X/IOoc3h/VOKlcUDS7gGPai6j6ErYBY8eEjJFLzPTIUqS1VUsYOR
	XawAjQA==
X-Google-Smtp-Source: AGHT+IF9g3LPB+mmZ2YRjktllEedA1cuQ/18L7dOKJUqmYm9rjvLuinrRy1wx3pD8/5+tBZORwXl/VRl79k=
X-Received: from pjsa5.prod.google.com ([2002:a17:90a:be05:b0:33b:bb95:de6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d92:b0:33b:d74b:179
 with SMTP id 98e67ed59e1d1-349a25cee1emr8372293a91.27.1765304792940; Tue, 09
 Dec 2025 10:26:32 -0800 (PST)
Date: Tue, 9 Dec 2025 10:26:31 -0800
In-Reply-To: <nyuyxccvnhscbo7qtlbsfl2fgxwood24nn4bvskhfqghgli3jo@xsv4zbdkolij>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110222922.613224-1-yosry.ahmed@linux.dev>
 <20251110222922.613224-5-yosry.ahmed@linux.dev> <aThN-xUbQeFSy_F7@google.com> <nyuyxccvnhscbo7qtlbsfl2fgxwood24nn4bvskhfqghgli3jo@xsv4zbdkolij>
Message-ID: <aThp19OAXDoZlk3k@google.com>
Subject: Re: [PATCH v2 04/13] KVM: nSVM: Fix consistency checks for NP_ENABLE
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Dec 09, 2025, Yosry Ahmed wrote:
> On Tue, Dec 09, 2025 at 08:27:39AM -0800, Sean Christopherson wrote:
> > On Mon, Nov 10, 2025, Yosry Ahmed wrote:
> > > @@ -400,7 +405,12 @@ static bool nested_vmcb_check_controls(struct kvm_vcpu *vcpu)
> > >  	struct vcpu_svm *svm = to_svm(vcpu);
> > >  	struct vmcb_ctrl_area_cached *ctl = &svm->nested.ctl;
> > >  
> > > -	return __nested_vmcb_check_controls(vcpu, ctl);
> > > +	/*
> > > +	 * Make sure we did not enter guest mode yet, in which case
> > 
> > No pronouns.
> 
> I thought that rule was for commit logs. 

In KVM x86, it's a rule everywhere.  Pronouns often add ambiguity, and it's much
easier to have a hard "no pronouns" rule than to try and enforce an inherently
subjective "is this ambiguous or not" rule.

> There are plenty of 'we's in the KVM x86 code (and all x86 code for that
> matter) :P

Ya, KVM is an 18+ year old code base.  There's also a ton of bare "unsigned" usage,
and other things that are frowned upon and/or flagged by checkpatch.  I'm all for
cleaning things up when touching the code, but I'm staunchly against "tree"-wide
cleanups just to make checkpatch happy, and so there's quite a few historical
violations of the current "rules".

> > > diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> > > index f6fb70ddf7272..3e805a43ffcdb 100644
> > > --- a/arch/x86/kvm/svm/svm.h
> > > +++ b/arch/x86/kvm/svm/svm.h
> > > @@ -552,7 +552,8 @@ static inline bool gif_set(struct vcpu_svm *svm)
> > >  
> > >  static inline bool nested_npt_enabled(struct vcpu_svm *svm)
> > >  {
> > > -	return svm->nested.ctl.nested_ctl & SVM_NESTED_CTL_NP_ENABLE;
> > > +	return guest_cpu_cap_has(&svm->vcpu, X86_FEATURE_NPT) &&
> > > +		svm->nested.ctl.nested_ctl & SVM_NESTED_CTL_NP_ENABLE;
> > 
> > I would rather rely on Kevin's patch to clear unsupported features.
> 
> Not sure how Kevin's patch is relevant here, could you please clarify?

Doh, Kevin's patch only touches intercepts.  What I was trying to say is that I
would rather sanitize the snapshot (the approach Kevin's patch takes with the
intercepts), as opposed to guarding the accessor.  That way we can't have bugs
where KVM checks svm->nested.ctl.nested_ctl directly and bypasses the caps check.

