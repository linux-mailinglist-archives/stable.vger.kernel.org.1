Return-Path: <stable+bounces-208386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19969D217E4
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 23:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FE93301DB89
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 22:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E733B52FB;
	Wed, 14 Jan 2026 22:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lggvkHTT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4C63B52E3
	for <stable@vger.kernel.org>; Wed, 14 Jan 2026 22:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768428459; cv=none; b=D9SCwrswqfxxzgtbrcUJB/jW/bhVpU8oub+nSQPMFnp3NIjJ4ajXhbR2SmHQ52dcPky8bKpKpSVDfPRMAr5fEGdbIZob+hLVUBZdZMzCSjR/8Hgceehg4Mplw7f65IVxG8tyCo4eLpsKCkAh+NWrpuJYhesRa5fsYzAedrnDKEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768428459; c=relaxed/simple;
	bh=ElI84M0BIOSftAGLVaXtQEldUGCc1BnYArgvHMyYoKk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZkXJ+44HGsG+uflPsnm9K/aXk4lYv55bEEkuPP6e6Im9XqODYe4hEeZstwmJUin2BJkaOcLTRFLv4spc0o2qdmH4G8kWGTJt4CB/ITtQB8cBWYyROiZQJ5XEg7Sd/4b8ONtFzfmA/+6l+WkmhtqxdAMdQIUyLVlPzTk0R6REu3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lggvkHTT; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a377e15716so5676875ad.3
        for <stable@vger.kernel.org>; Wed, 14 Jan 2026 14:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768428432; x=1769033232; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DATGHMH+tRYW0PdOYhPY0pT6PT3USRJNw+EAenWZUkM=;
        b=lggvkHTTXWatg+m8O6ODY7bpqmWLFpEhqIZIHVjHdZN98ybVpa1ArteiwNiXMFcQoD
         i4Cs0YTeIgmVgvO3Y7nkTrfoZA63OQ1j4tWmNj43jtXloU85CvPUmLs3aaaUdHfvGNOw
         2r4Tts2+MHVSvy6uhb6CDt/pbXDSsrV0sqx7zIKCGQEnuIZc7DGTuGIHXu4tWqmzvjtE
         W/Fu4HQurj8e3pZGOpgN5O1yNG0+ADSObWz64MLd3HqNBFX33aUSptlNXlWgYn9nGocU
         w8YNCLO0S+NlcT6RPT08RoLxtymf8KdHA7E4P+36/FVywHXEkSAgA6w7cKkhSZyxaZTf
         2M7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768428432; x=1769033232;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DATGHMH+tRYW0PdOYhPY0pT6PT3USRJNw+EAenWZUkM=;
        b=tm/olk2o8Cg10CqFBRhw/3pUbA5lN7lPPSeod3SCMe0aKBi9L4dP3OmesUDXygg3Rq
         n50nUDl4/yVQn3blk9qJv+C5nl4jmSXqPxxUvgfsJ2dPJ0FXKlzzOGTzTmzqS7Gg9ULE
         e86608V0qY3kD39MW37TlQ8Vmoml7+dPCirwAUji9JWMi1b8dH6iUM9cpndw6Oxal+Hy
         Z4t/7Y/Ro2PSWy/uHwo9JVrKkdzzXjtt0hYu38LbFUZtbDxwc5Gytl+NGfDyuY5XGN2r
         nPHnHbymgI6zXJwEHspAioMzAQC2Q7CtsBAYPKrIMvGVKB4+JcP6N2AIjm9Ije2ytzxI
         JYOw==
X-Forwarded-Encrypted: i=1; AJvYcCXWcNtj0WrodBmrfMKKbkJW9mH917ClUJeCJbeI9pak4ZgnatTxL6v/nt9Szdx7fwbTjQ5nPI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvmnvYT7Iyiy8HkKYMBXdUbHqNa1VWGXvOJ5Q7KX3m59sKltzs
	GDJYl6+uLBuCLlFtNpeLnFUcsh3cCnA7L4lFpFzldmt44ppwdw6IdkEbPdYv1Ir9eQRQCBwcOqN
	qNlAnZw==
X-Received: from plqs2.prod.google.com ([2002:a17:902:a502:b0:2a5:8c4f:4c6d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e78b:b0:29d:65ed:f481
 with SMTP id d9443c01a7336-2a599cbac4bmr36340125ad.0.1768428431740; Wed, 14
 Jan 2026 14:07:11 -0800 (PST)
Date: Wed, 14 Jan 2026 14:07:10 -0800
In-Reply-To: <rlwgjee2tjf26jyvdwipdwejqgsira63nvn2r3zczehz3argi4@uarbt5af3wv2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251215192722.3654335-1-yosry.ahmed@linux.dev>
 <3rdy3n6phleyz2eltr5fkbsavlpfncgrnee7kep2jkh2air66c@euczg54kpt47>
 <aUBjmHBHx1jsIcWJ@google.com> <rlwgjee2tjf26jyvdwipdwejqgsira63nvn2r3zczehz3argi4@uarbt5af3wv2>
Message-ID: <aWgTjoAXdRrA99Dn@google.com>
Subject: Re: [PATCH] KVM: SVM: Fix redundant updates of LBR MSR intercepts
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Dec 15, 2025, Yosry Ahmed wrote:
> On Mon, Dec 15, 2025 at 11:38:00AM -0800, Sean Christopherson wrote:
> > On Mon, Dec 15, 2025, Yosry Ahmed wrote:
> > > On Mon, Dec 15, 2025 at 07:26:54PM +0000, Yosry Ahmed wrote:
> > > > svm_update_lbrv() always updates LBR MSRs intercepts, even when they are
> > > > already set correctly. This results in force_msr_bitmap_recalc always
> > > > being set to true on every nested transition, essentially undoing the
> > > > hyperv optimization in nested_svm_merge_msrpm().
> > > > 
> > > > Fix it by keeping track of whether LBR MSRs are intercepted or not and
> > > > only doing the update if needed, similar to x2avic_msrs_intercepted.
> > > > 
> > > > Avoid using svm_test_msr_bitmap_*() to check the status of the
> > > > intercepts, as an arbitrary MSR will need to be chosen as a
> > > > representative of all LBR MSRs, and this could theoretically break if
> > > > some of the MSRs intercepts are handled differently from the rest.
> > > > 
> > > > Also, using svm_test_msr_bitmap_*() makes backports difficult as it was
> > > > only recently introduced with no direct alternatives in older kernels.
> > > > 
> > > > Fixes: fbe5e5f030c2 ("KVM: nSVM: Always recalculate LBR MSR intercepts in svm_update_lbrv()")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> > > 
> > > Sigh.. I had this patch file in my working directory and it was sent by
> > > mistake with the series, as the cover letter nonetheless. Sorry about
> > > that. Let me know if I should resend.
> > 
> > Eh, it's fine for now.  The important part is clarfying that this patch should
> > be ignored, which you've already done.
> 
> FWIW that patch is already in Linus's tree so even if someone applies
> it, it should be fine.

Narrator: it wasn't fine.

Please resend this series.  The base-commit is garbage because your working tree
was polluted with non-public patches, I can't quickly figure out what your "real"
base was, and I don't have the bandwidth to manually work through the mess.

In the future, please, please don't post patches against a non-public base.  It
adds a lot of friction on my end, and your series are quite literally the only
ones I've had problems with in the last ~6 months.

