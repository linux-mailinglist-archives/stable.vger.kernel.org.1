Return-Path: <stable+bounces-194543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C6746C4FF90
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 23:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A08D84E36BA
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 22:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315DB27A107;
	Tue, 11 Nov 2025 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b5lGd+Nd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8293A26CE05
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 22:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762900262; cv=none; b=c95bTEhHapKDOHQbmEopT662uEFEvDW6rARQ9ipedLoAzv+plXR7reMd0w9BLX1W2j4onga2Y8ZKJViZISu/aMGPp+2Q1yg/5RDX54KtGFAvoPeCHE3Lp0eIB5dP07IPbeA4YVzZHuXpyHccxkmHlFz4wztmpQzJ/FytTnIfW2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762900262; c=relaxed/simple;
	bh=nBOmB4ONg8kALGVCz8jrfhPIlcVdJM+IcFGCif8wqF0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qcTF+0dP/t2eAYEJ5hHrMFsHmfLU9vWUrBw93se9UkboIawfFLqooGSjVQxceVlWtuYEo5L5HSJDGStB/dfndOsMhB3Y0Dc4obSqxPGvYmo38wFaexfvtid/e3/a7rJn6wNAGUONKcJRPLmJl+0HGrW0MSfNYAP1ODMV0ZpQz3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b5lGd+Nd; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7b0e73b0f52so171154b3a.1
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 14:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762900260; x=1763505060; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+O8RYt755g+phSGczRrtxqFHw21U9A5DwYjvKLhqMbA=;
        b=b5lGd+NdRKiKKKuMQzLLTIJ5dpTIPVw8mAULHAFjGv4YmTQbBuHAy1XUaZoUbPAAIq
         o2iOvA4kyFciRA+WEsMnVwCoo2ZMm2aLzFXBCeF/J015lNuDt2YaVexyKMcJ+9wpcr6K
         U8lBuCPqb68Jm5Rk5D7v+V651LjhUyDM6YLw7xPo+KcpBabWDvojuI7FylGCx584v3fJ
         8SIbVC9vOxkS9zQNzip5dBTe+TGvwtWhT70WcXbFmpvT+o+TplsdyIL8eUPSuKeaO6nj
         IZWOxkQO8sxBSFYQxa2hTe4oCdWfMd1SLV9JwrjPUKcMWIfbP3VwgHfuYxd7/521UMnx
         +4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762900260; x=1763505060;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+O8RYt755g+phSGczRrtxqFHw21U9A5DwYjvKLhqMbA=;
        b=XM2eT0UVrsVGVeHxZ3idGLb9soSzizkHrJoINSB+sTDQ2DyPjaYbUt1rySwwUNXu6f
         OFJSZS0XJ52LedC9irinOYomRJRE7PZ0aIW6NILaSaD6zpDr2jYxvExyXMDK1eHg+uvN
         AOeSx18f0WUVGDUE5U+jlMWZQChIUwQl1cj918mDd6Q3jvST/PMhqQj2ReJ1cclzthKQ
         yYzdMSCVMF2+Nz3CfmMu474Qo8RnAoeTZh+KNxxxeC0b3WRNsY+Gjb00z4hk6mF4ATPw
         aaiG/+3zhhDX7tzM7KyuB+qKes3P8rhejDWtHHj7EwLmk7GeKYCA+ow8mtxDsoWxdBOy
         xFjA==
X-Forwarded-Encrypted: i=1; AJvYcCVNOwQuhYzQkv4qtuwoLzzLt0UD6E2CXtCjHMd2ZoUgVNPbyXwQ/qZodz16Brk/AB5b9GQGlEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Elkha7V513OEu1l1STi2tdO+MeS48PFNJMFu59lYp4vdiOlv
	30bCajDrbZkeNjGOq8fUOBXZPc6hDGhoUXN3BZRp0EYFTAT72fAEwsXxWE+XcI2LAFgcVAlGvwj
	SUeRICg==
X-Google-Smtp-Source: AGHT+IHtFVXr/uGxNz1xOC+oARtDBh6AgJQTtR8J1TlbgEsvQHGkSIKZOzneMX7GY0qygAOFGBUFmCHpdCc=
X-Received: from pfbea28.prod.google.com ([2002:a05:6a00:4c1c:b0:77f:2e96:5d3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a0f:b0:7ab:a41:2874
 with SMTP id d2e1a72fcca58-7b7a2d91dcdmr700837b3a.10.1762900259787; Tue, 11
 Nov 2025 14:30:59 -0800 (PST)
Date: Tue, 11 Nov 2025 14:30:58 -0800
In-Reply-To: <6ving6sg3ywr23epd3fmorzhovdom5uaty4ae4itit2amxafql@iui7as55sb55>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251108004524.1600006-1-yosry.ahmed@linux.dev>
 <20251108004524.1600006-3-yosry.ahmed@linux.dev> <aktjuidgjmdqdlc42mmy4hby5zc2e5at7lgrmkfxavlzusveus@ai7h3sk6j37b>
 <6ving6sg3ywr23epd3fmorzhovdom5uaty4ae4itit2amxafql@iui7as55sb55>
Message-ID: <aRO5ItX_--ZDfnfM@google.com>
Subject: Re: [PATCH 2/6] KVM: nSVM: Always recalculate LBR MSR intercepts in svm_update_lbrv()
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 11, 2025, Yosry Ahmed wrote:
> On Tue, Nov 11, 2025 at 03:11:37AM +0000, Yosry Ahmed wrote:
> > On Sat, Nov 08, 2025 at 12:45:20AM +0000, Yosry Ahmed wrote:
> > > svm_update_lbrv() is called when MSR_IA32_DEBUGCTLMSR is updated, and on
> > > nested transitions where LBRV is used. It checks whether LBRV enablement
> > > needs to be changed in the current VMCB, and if it does, it also
> > > recalculate intercepts to LBR MSRs.
> > > 
> > > However, there are cases where intercepts need to be updated even when
> > > LBRV enablement doesn't. Example scenario:
> > > - L1 has MSR_IA32_DEBUGCTLMSR cleared.
> > > - L1 runs L2 without LBR_CTL_ENABLE (no LBRV).
> > > - L2 sets DEBUGCTLMSR_LBR in MSR_IA32_DEBUGCTLMSR, svm_update_lbrv()
> > >   sets LBR_CTL_ENABLE in VMCB02 and disables intercepts to LBR MSRs.
> > > - L2 exits to L1, svm_update_lbrv() is not called on this transition.
> > > - L1 clears MSR_IA32_DEBUGCTLMSR, svm_update_lbrv() finds that
> > >   LBR_CTL_ENABLE is already cleared in VMCB01 and does nothing.
> > > - Intercepts remain disabled, L1 reads to LBR MSRs read the host MSRs.
> > > 
> > > Fix it by always recalculating intercepts in svm_update_lbrv().
> > 
> > This actually breaks hyperv_svm_test, because svm_update_lbrv() is
> > called on every nested transition, calling
> > svm_recalc_lbr_msr_intercepts() -> svm_set_intercept_for_msr() and
> > setting svm->nested.force_msr_bitmap_recalc to true.
> > 
> > This breaks the hyperv optimization in nested_svm_vmrun_msrpm() AFAICT.
> > 
> > I think there are two ways to fix this:
> > - Add another bool to svm->nested to track LBR intercepts, and only call
> >   svm_set_intercept_for_msr() if the intercepts need to be updated.
> > 
> > - Update svm_set_intercept_for_msr() itself to do nothing if the
> >   intercepts do not need to be changed, which is more clutter but
> >   applies to other callers as well so could shave cycles elsewhere (see
> >   below).
> > 
> > Sean, Paolo, any preferences?
> > 
> > Here's what updating svm_set_intercept_for_msr() looks like:

I am *very* strongly opposed to modifying svm_set_intercept_for_msr() to deal
with whatever mess LBRs has created.  Whatever the problem is (I haven't read
through all of this yet), it needs to be fixed in the LBR code, not in
svm_set_intercept_for_msr().

Recalculating MSR intercepts is supposed to done only as needed, I don't want to
encourage lazy code that works by optimizing paths that should be rare.

