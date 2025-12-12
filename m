Return-Path: <stable+bounces-200938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4471CCB9916
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 19:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5B01301396A
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 18:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62493090C6;
	Fri, 12 Dec 2025 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N8xEvMul"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C3C308F33
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765564347; cv=none; b=KQRhwtM98yRFEkueWmb19ULjFc4YgnfAGl4qHTnfoNwUYwN0+xch8HeU99NCPx3iXYHaGVn34G9noL+I8Lt0IZqS8m/yUJFbzkNkcm4xg1pqe5TA5LTP4zhqNWtmMWWyHaAHVARjS0wH7/c/vRBZjLzN+0qCets02a1peQ1RMIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765564347; c=relaxed/simple;
	bh=sX0TzwrQtYiV3zBkNA0USI+pMzU83oS0G0UzV3jMIQY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=inahc0hhulLS1NHbV0S0FH5rMuaJZF2NPAbFaLM581pPHIBsOpOsoNlNvDESB3qfjEn0KKwZUDqKSivb7fyk3o4glPiZHALouK79EsGILrEpemajYXvy7RdDAirzby7xjFtVj+Xj6S1Jx5/Z0kT6bh7a69q/DrIdPUE/XiDX6vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N8xEvMul; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7dd05696910so1794575b3a.2
        for <stable@vger.kernel.org>; Fri, 12 Dec 2025 10:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765564345; x=1766169145; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T/s9FeJOSMjA6/j6jq/9mb0CpNCTtxRCvkbabRq0HCM=;
        b=N8xEvMul+napNTZR9feP/tTuE6n5zLQbw6Wuon9k5GFWJBvnguGY7UH6OMQagzIAx3
         lgBkAbMOWkuq4OJEVHd9a4VKDpDH2kJDFARk7PWWPZ4EENyEaZMAm2S8+/wp0qWd7YT+
         8meFe1K2fctJb2JoPkflB1SOzbQog87ZoqyR0ZysvS1QFSMfP3msr7rL5KEK1hLu/7cz
         6OVzkQ2TNJ+kW0tKilG2ofm1ohRYgwb/QNKCNFdL/S9OW09H6ioupa31mbN++v49QtC6
         jQpGDqX10Ab30CSsNGSpnkR+oHs7xKvz7QkA8ekUw9/pCIKC8kkTxF3BgcITEI6PKDjv
         6LbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765564345; x=1766169145;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/s9FeJOSMjA6/j6jq/9mb0CpNCTtxRCvkbabRq0HCM=;
        b=RcJy9K/3EWro1HOXnDK8IPeaF8+sJUK41zZXtOqkDuRqltRLgi9RCu81m1yasrWyse
         pOfKmrFvjSdeEtTVa3X/2y6GPRlG0+RATryJdMXPjajaymZnnK/ckrgq5Dnp2+3yaelC
         IiIxwXf3gZN++NyIS9wyvKY1A3VHzjDfrfL9vMU2tMxQQXUPcBsPQtynXvuLUu1QAqQ4
         SCnayZqZBDlG+IBvEN4P0Pw5Piu31MkAFFPp9HR9rzAjxQ2zuJdKZMC3r10CV7WWZygq
         NhN56FLnhULWnxHVM+UbPzgz+aaXJl8oXsIgO0OBn5JQZkPm+eUTYEOn/hj8mhgf+/MU
         2jGQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+Z5xi7FDA4aX2XKfsRfVfgPhjAHB++hogCi29+q0PG6f432az/xYxOh1EBIfuooIMqUSBMD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWC/67lshWfjgbYoF6IFqEqBPnElXlEpAYt261PDY7aSzTAyHs
	HAR3XkIzhHsX3gkNMORExUjeXp/AKsQ37eHWmsygiJY3sq7ZWK4mL1hjihdPCtmMmr60GZkp4/s
	l65rwFA==
X-Google-Smtp-Source: AGHT+IG9IYDkz8u1bbgxa6iFV/lfrltypfsubC45S38kfEVEj3Vh79p38ebTwcVynjMWyR/d6kxZi2LxQRI=
X-Received: from pjbgn5.prod.google.com ([2002:a17:90a:c785:b0:34a:4a21:bc22])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9988:b0:35d:5d40:6d78
 with SMTP id adf61e73a8af0-369b69afd72mr2796296637.46.1765564345243; Fri, 12
 Dec 2025 10:32:25 -0800 (PST)
Date: Fri, 12 Dec 2025 10:32:23 -0800
In-Reply-To: <pit2u5dpjpchsbz3pyujk62smysco5z37i3z3qosdscx6bddqj@i6fjafx5fxlz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110222922.613224-1-yosry.ahmed@linux.dev>
 <20251110222922.613224-5-yosry.ahmed@linux.dev> <aThN-xUbQeFSy_F7@google.com>
 <nyuyxccvnhscbo7qtlbsfl2fgxwood24nn4bvskhfqghgli3jo@xsv4zbdkolij>
 <aThp19OAXDoZlk3k@google.com> <fg5ipm56ejqp7p2j2lo5i5ouktzqggo3663eu4tna74u6paxpg@lque35ixlzje>
 <aThtjYG3OZTtdwUA@google.com> <pit2u5dpjpchsbz3pyujk62smysco5z37i3z3qosdscx6bddqj@i6fjafx5fxlz>
Message-ID: <aTxftw3XcIrwyTzK@google.com>
Subject: Re: [PATCH v2 04/13] KVM: nSVM: Fix consistency checks for NP_ENABLE
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Dec 09, 2025, Yosry Ahmed wrote:
> On Tue, Dec 09, 2025 at 10:42:21AM -0800, Sean Christopherson wrote:
> > On Tue, Dec 09, 2025, Yosry Ahmed wrote:
> > > On Tue, Dec 09, 2025 at 10:26:31AM -0800, Sean Christopherson wrote:
> > > > On Tue, Dec 09, 2025, Yosry Ahmed wrote:
> > > > > > > diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> > > > > > > index f6fb70ddf7272..3e805a43ffcdb 100644
> > > > > > > --- a/arch/x86/kvm/svm/svm.h
> > > > > > > +++ b/arch/x86/kvm/svm/svm.h
> > > > > > > @@ -552,7 +552,8 @@ static inline bool gif_set(struct vcpu_svm *svm)
> > > > > > >  
> > > > > > >  static inline bool nested_npt_enabled(struct vcpu_svm *svm)
> > > > > > >  {
> > > > > > > -	return svm->nested.ctl.nested_ctl & SVM_NESTED_CTL_NP_ENABLE;
> > > > > > > +	return guest_cpu_cap_has(&svm->vcpu, X86_FEATURE_NPT) &&
> > > > > > > +		svm->nested.ctl.nested_ctl & SVM_NESTED_CTL_NP_ENABLE;
> > > > > > 
> > > > > > I would rather rely on Kevin's patch to clear unsupported features.
> > > > > 
> > > > > Not sure how Kevin's patch is relevant here, could you please clarify?
> > > > 
> > > > Doh, Kevin's patch only touches intercepts.  What I was trying to say is that I
> > > > would rather sanitize the snapshot (the approach Kevin's patch takes with the
> > > > intercepts), as opposed to guarding the accessor.  That way we can't have bugs
> > > > where KVM checks svm->nested.ctl.nested_ctl directly and bypasses the caps check.
> > > 
> > > I see, so clear SVM_NESTED_CTL_NP_ENABLE in
> > > __nested_copy_vmcb_control_to_cache() instead.
> > > 
> > > If I drop the guest_cpu_cap_has() check here I will want to leave a
> > > comment so that it's obvious to readers that SVM_NESTED_CTL_NP_ENABLE is
> > > sanitized elsewhere if the guest cannot use NPTs. Alternatively, I can
> > > just keep the guest_cpu_cap_has() check as documentation and a second
> > > line of defense.
> > > 
> > > Any preferences?
> > 
> > Honestly, do nothing.  I want to solidify sanitizing the cache as standard behavior,
> > at which point adding a comment implies that nested_npt_enabled() is somehow special,
> > i.e. that it _doesn't_ follow the standard.
> 
> Does this apply to patch 12 as well? In that patch I int_vector,

I <something>?

> int_state, and event_inj when copying them to VMCB02 in
> nested_vmcb02_prepare_control(). Mainly because
> nested_vmcb02_prepare_control() already kinda filters what to copy from
> VMCB12 (e.g. int_ctl), so it seemed like a better fit.
> 
> Do I keep that as-is, or do you prefer that I also sanitize these fields
> when copying to the cache in nested_copy_vmcb_control_to_cache()?

I don't think I follow.  What would the sanitization look like?  Note, I don't
think we need to completely sanitize _every_ field.  The key fields are ones
where KVM consumes and/or acts on the field.

