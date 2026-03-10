Return-Path: <stable+bounces-224586-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBpLOGCRsGkukgIAu9opvQ
	(envelope-from <stable+bounces-224586-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 22:47:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 65656258743
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 22:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 128AD3088710
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 21:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5401EE033;
	Tue, 10 Mar 2026 21:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CD3N/4AD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A1F3F0ABA
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 21:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773179226; cv=none; b=Ad8fF42zU84y5XNclHpukx3FWWM8A9okeHJ/RkVjC7mbEJtotQs7J8zV4QIAb1Myy3O22/zHAKoiefVQuqmzHvhmSMRnfeaLPSotnnarP6/aDV/dtBpZUC0saHwUa8i64zgmZ/2xg/MTC38R0lUxQp30zH4yNkq7zaqsgHYWEio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773179226; c=relaxed/simple;
	bh=8526QoqJKS1zLcrD5V8hkYHwRN+JCTJdADTbBkhzpO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCfGOTGhAufX+7nlfyQ4YN01TmjtuKToFv3vVChH+PHgc00GAqDp3PWxpbYcvc+NZ95utaIiGpdNLChUQFYKHSVsoiNKNDKi1ovbuSSNCRrylP6OWl4J14KtSDl7G+sD4y3t5Tf+2uBIWpNVlU10jQjkUQ2pn7rdL/SEaGNGles=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CD3N/4AD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8A6C2BCB1
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 21:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773179226;
	bh=8526QoqJKS1zLcrD5V8hkYHwRN+JCTJdADTbBkhzpO4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CD3N/4ADjoXBzmpBpWwKYdc4MLHPYuz2mncJ67Nv4DEAp8LGEToQyDenlz9/DpGQB
	 ZxRutjBd4zyZszaAxKO4Ehj0cCUZH4EiEPME19KM39fKENy/LKzHysVDxJLVgMdf9O
	 4aZVGy7bbDrZYJ9yfqZiZrGoT2micvBeFmwH7J30M/3GyECETyRtDsVGaS6VSeavLd
	 BndWFwj6c2kSwvzfBWKVIcN/O7JrksRCWg2Z4sEaJY/ZJxkH+tS4HuUiIRzg8fwSGX
	 zXiXxWHzKsXtAM1HY21BGHZQCwpFE1Po0NRWNKXLHoyRyHIYuvmSjN6cIPSjEPnuGj
	 muaN9SNRPR96g==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6615c461d3fso8800163a12.2
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 14:47:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3/2IDvrU+3M+y4eOgwkWYWUBC2ekVvsv+/MXNE6KrbntscSy+tUB6G8GzK9xESaestdlafkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/FRsjpG+F2HfQwgepIn8tLbgySgxXgSOY4bfXergZisY2/oGk
	/1gqsHMvRR8Q5/WMHKcHRjz3HmMfbkRT/IitNahkHI8UncL3WDfxiS/zTmxIyriHb2vQrLtVczR
	qhb4P66Wv6MEklm48tSRCJDXb1N4BKFw=
X-Received: by 2002:a17:906:fd84:b0:b94:1913:77fc with SMTP id
 a640c23a62f3a-b972e5f420emr6614566b.30.1773179224774; Tue, 10 Mar 2026
 14:47:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310202414.406078-1-pbonzini@redhat.com> <20260310202414.406078-3-pbonzini@redhat.com>
 <CAO9r8zOLc030xTsnkYWvp5yUtnzQgVZnXXhvKZWC__1wRSP61A@mail.gmail.com> <abCRA_B2kHp6T7Zn@google.com>
In-Reply-To: <abCRA_B2kHp6T7Zn@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 10 Mar 2026 14:46:53 -0700
X-Gmail-Original-Message-ID: <CAO9r8zN9AdZyzdBHAVbBG1VFn=c5doWUNNPJ7Wp8VYGUy+mO=Q@mail.gmail.com>
X-Gm-Features: AaiRm50aPeii-M5-ztr8u-o-c3IWzYGO-EcgvUjlNIvlSE5IEosX_x5-sVN2Mt0
Message-ID: <CAO9r8zN9AdZyzdBHAVbBG1VFn=c5doWUNNPJ7Wp8VYGUy+mO=Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] KVM: SVM: check validity of VMCB when returning from SMM
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	xinyang@anthropic.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 65656258743
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224586-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 2:45=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Mar 10, 2026, Yosry Ahmed wrote:
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > ---
> > >  arch/x86/kvm/svm/nested.c | 12 ++++++++++--
> > >  arch/x86/kvm/svm/svm.c    |  4 ++++
> > >  arch/x86/kvm/svm/svm.h    |  1 +
> > >  3 files changed, 15 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > > index 7b61124051a7..de9906adb73b 100644
> > > --- a/arch/x86/kvm/svm/nested.c
> > > +++ b/arch/x86/kvm/svm/nested.c
> > > @@ -419,6 +419,15 @@ static bool nested_vmcb_check_controls(struct kv=
m_vcpu *vcpu)
> > >         return __nested_vmcb_check_controls(vcpu, ctl);
> > >  }
> > >
> > > +int nested_svm_check_cached_vmcb12(struct kvm_vcpu *vcpu)
> > > +{
> > > +       if (!nested_vmcb_check_save(vcpu) ||
> > > +           !nested_vmcb_check_controls(vcpu))
> > > +               return -EINVAL;
> > > +
> > > +       return 0;
> > > +}
> >
> > Nit: if we make this a boolean we could just do:
> >
> > bool nested_svm_check_cached_vmcb12(struct kvm_vcpu *vcpu)
> > {
> >        return nested_vmcb_check_save(vcpu) && nested_vmcb_check_control=
s(vcpu);
>
> I don't care one way or the other for this particular patch, but once the=
 dust
> settles on nSVM (assuming it ever does) I do think we should align the "n=
ested
> check" return types across nVMX and nSVM (which is likely why Paolo ended=
 up with
> the above; I requested using -EINVAL for the nVMXx) patch.
>
> My fairly strong preference is to use 0/-errno as "return -EINVAL" is mor=
e
> obviously an error than "return true".  But we can bikeshed later :-)

No objections, I was strictly going for more concise code and it
happened to also keep the existing return type (instead of translating
boolean to int).

