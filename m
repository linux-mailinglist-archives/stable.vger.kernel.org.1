Return-Path: <stable+bounces-200476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE2BCB0D9B
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 19:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E32A30185D6
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 18:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BDE302742;
	Tue,  9 Dec 2025 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rnsV+NrX"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4DC22A7E4
	for <stable@vger.kernel.org>; Tue,  9 Dec 2025 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765305320; cv=none; b=LTe15+9UzT/z0mCV/Kl6Pd4YwdZIXCoH7FHkS/9+rBDl+kW/1KrGKdI21ZW1QIJIwCKUyunigLXvzSu0OOd8QLdu9YwWri2VywVQmm4ULAL+HZKF9TCehQfoqBEu78B528RuV9KKLxay7Hufvb1nNp9sPayQ1LEBDKl2dSECxeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765305320; c=relaxed/simple;
	bh=60aZR0yaWEPhwzE2rh3FLrcA0hRrVzZA0cNlad6oEcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W981+dNKCnsZSaE39Ol55ppM+BKIPRrBE1vbENT084I93JqhgwF8c8FG9dSa3ANZ7P03IBleSysTxezkMK1ITIZ/NaTK51UpsQaTGozFw63a4Hh26mLQYlHmWpqyWGR4TOlPjnZQdm89xGEm1xDysQnrFYMDS2A7WMWAKVT0Oc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rnsV+NrX; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 9 Dec 2025 18:35:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765305306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yhEuEXEA6Rz3W2+CSuhlpqKGg8YMOOtDEGEXvgDo3Q0=;
	b=rnsV+NrXEjq3sxhroJie13UetZkhNdA+UEmrGlmIXLgJnTJDAsHl4lu9Kyuu1YUMQ+/YbP
	t4XQrM8CodD05VgT7Thap24E8VNm1FFP99rtr0rPLEs7c4H7h1k4R2dKX/jkRpchAh3+eU
	S7Kg+S5E9YmM3Ek/1b+fHdF6lCh5gkU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 04/13] KVM: nSVM: Fix consistency checks for NP_ENABLE
Message-ID: <fg5ipm56ejqp7p2j2lo5i5ouktzqggo3663eu4tna74u6paxpg@lque35ixlzje>
References: <20251110222922.613224-1-yosry.ahmed@linux.dev>
 <20251110222922.613224-5-yosry.ahmed@linux.dev>
 <aThN-xUbQeFSy_F7@google.com>
 <nyuyxccvnhscbo7qtlbsfl2fgxwood24nn4bvskhfqghgli3jo@xsv4zbdkolij>
 <aThp19OAXDoZlk3k@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aThp19OAXDoZlk3k@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 09, 2025 at 10:26:31AM -0800, Sean Christopherson wrote:
> On Tue, Dec 09, 2025, Yosry Ahmed wrote:
> > On Tue, Dec 09, 2025 at 08:27:39AM -0800, Sean Christopherson wrote:
> > > On Mon, Nov 10, 2025, Yosry Ahmed wrote:
> > > > @@ -400,7 +405,12 @@ static bool nested_vmcb_check_controls(struct kvm_vcpu *vcpu)
> > > >  	struct vcpu_svm *svm = to_svm(vcpu);
> > > >  	struct vmcb_ctrl_area_cached *ctl = &svm->nested.ctl;
> > > >  
> > > > -	return __nested_vmcb_check_controls(vcpu, ctl);
> > > > +	/*
> > > > +	 * Make sure we did not enter guest mode yet, in which case
> > > 
> > > No pronouns.
> > 
> > I thought that rule was for commit logs. 
> 
> In KVM x86, it's a rule everywhere.  Pronouns often add ambiguity, and it's much
> easier to have a hard "no pronouns" rule than to try and enforce an inherently
> subjective "is this ambiguous or not" rule.
> 
> > There are plenty of 'we's in the KVM x86 code (and all x86 code for that
> > matter) :P
> 
> Ya, KVM is an 18+ year old code base.  There's also a ton of bare "unsigned" usage,
> and other things that are frowned upon and/or flagged by checkpatch.  I'm all for
> cleaning things up when touching the code, but I'm staunchly against "tree"-wide
> cleanups just to make checkpatch happy, and so there's quite a few historical
> violations of the current "rules".

Ack.

> 
> > > > diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> > > > index f6fb70ddf7272..3e805a43ffcdb 100644
> > > > --- a/arch/x86/kvm/svm/svm.h
> > > > +++ b/arch/x86/kvm/svm/svm.h
> > > > @@ -552,7 +552,8 @@ static inline bool gif_set(struct vcpu_svm *svm)
> > > >  
> > > >  static inline bool nested_npt_enabled(struct vcpu_svm *svm)
> > > >  {
> > > > -	return svm->nested.ctl.nested_ctl & SVM_NESTED_CTL_NP_ENABLE;
> > > > +	return guest_cpu_cap_has(&svm->vcpu, X86_FEATURE_NPT) &&
> > > > +		svm->nested.ctl.nested_ctl & SVM_NESTED_CTL_NP_ENABLE;
> > > 
> > > I would rather rely on Kevin's patch to clear unsupported features.
> > 
> > Not sure how Kevin's patch is relevant here, could you please clarify?
> 
> Doh, Kevin's patch only touches intercepts.  What I was trying to say is that I
> would rather sanitize the snapshot (the approach Kevin's patch takes with the
> intercepts), as opposed to guarding the accessor.  That way we can't have bugs
> where KVM checks svm->nested.ctl.nested_ctl directly and bypasses the caps check.

I see, so clear SVM_NESTED_CTL_NP_ENABLE in
__nested_copy_vmcb_control_to_cache() instead.

If I drop the guest_cpu_cap_has() check here I will want to leave a
comment so that it's obvious to readers that SVM_NESTED_CTL_NP_ENABLE is
sanitized elsewhere if the guest cannot use NPTs. Alternatively, I can
just keep the guest_cpu_cap_has() check as documentation and a second
line of defense.

Any preferences?

