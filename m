Return-Path: <stable+bounces-222938-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJANCtwzp2k9fwAAu9opvQ
	(envelope-from <stable+bounces-222938-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 20:17:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 932441F5D47
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 20:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6756030603F2
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 19:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C321F39656E;
	Tue,  3 Mar 2026 19:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KP3h890R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D69396564
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 19:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772565463; cv=none; b=YcnmYqmnFoYVpydP5+5z4KyVwCRO+QEQ0TXKJKs8Ko/Jye+M69pDavxom8pxOyJ/9IdGkg2Ar6oJAiCPdDzS+fnnlLTmkJ1Czlie55GgGaMo9WojXskl0QfXMaZmvc3ZvHjyUMyrOB64JIqVhfQwOnkiU4DohX2t0iZI45QMI4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772565463; c=relaxed/simple;
	bh=yjtw1Psq4vZHIIZX0uC8+vtVWzPHPxJVXn9G4aTgN7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HVXT0ZqJGCr/hb9akAQaFlCJIXSs0iylV6fXpQ+YpqNpjBiuXwiYJOXM2gSG8VQPxW6qLbR5Qmr70yCteKo0PWsa6ydhdxmm8GEv9sl3L3Yb+QdM2Rt2SxNXZUj57pYy55m/icKJotkrzYcV8dZAMcj9Qts/ZGfY6pCYQi94NCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KP3h890R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAB3C2BCB0
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 19:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772565463;
	bh=yjtw1Psq4vZHIIZX0uC8+vtVWzPHPxJVXn9G4aTgN7M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KP3h890RzDVKUWNvlNOqqqTvgIxIPMulrSpJdfknBLveJ2a2HGWM/1ESYRWba8wnu
	 7/z7/KwCZJjRGQXnQIpVVHH56ma4EXJOaBtFIJ9baHfVI63UeXYIWLkfbk5+bltcbr
	 gFa7Mhqzqeaum9Wn+i0GODEIgUIrg1fexHqkS+LXb6UPfxqE+PpQy3CghphD3Mc15A
	 cba+Fso5jJpQoAYbwGA2N9N/KTpD3AwMVWm6yW5hXlkDEszUT6rq6tek6ASBSjOzW8
	 IGhMPlYEmsKebNO3aVttVLWqio3m6dgjcwCsDVxr9kQl+OJs3tajCPsNeSJwFrZMSG
	 1hFeaOdFjpNlw==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65f771c6b89so9096136a12.3
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 11:17:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUiMYACURHof+7gsP0dUwWlRa97alcw7+gIsd3QcvAjMVvXTRKeOy2JxZzaZseegV9k2mAjCR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTgovZWpKnypcnNTuob9kFK9Px9BHNw1WjWgxi5P9OoA0GErn1
	lWE8sjCa/V0j0zkLkkMqStQRYr5IKsTtotmkYU3p+zfMFO+Tnii6iTP7u9JNovcFJ4hsEpXJWY0
	ihs3aqN8g6wxAR0+lSBNpaJRIIINjTPQ=
X-Received: by 2002:a17:906:3b89:b0:b88:5e4c:f842 with SMTP id
 a640c23a62f3a-b9376568f73mr734490966b.47.1772565462016; Tue, 03 Mar 2026
 11:17:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303003421.2185681-1-yosry@kernel.org> <20260303003421.2185681-16-yosry@kernel.org>
 <aacSr2LanhJczBs-@google.com>
In-Reply-To: <aacSr2LanhJczBs-@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 3 Mar 2026 11:17:30 -0800
X-Gmail-Original-Message-ID: <CAO9r8zO6YY1LRxef1UiSiSG8TxPAOq15HEEWnvg-HpxMYdteDg@mail.gmail.com>
X-Gm-Features: AaiRm53hbrjB16JldiahylPsdwMCF5i7REQR1tdtfPzUJPo0cLkIQ-lmWt2uE8o
Message-ID: <CAO9r8zO6YY1LRxef1UiSiSG8TxPAOq15HEEWnvg-HpxMYdteDg@mail.gmail.com>
Subject: Re: [PATCH v7 15/26] KVM: nSVM: Add missing consistency check for
 nCR3 validity
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 932441F5D47
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222938-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 8:56=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Tue, Mar 03, 2026, Yosry Ahmed wrote:
> > >From the APM Volume #2, 15.25.4 (24593=E2=80=94Rev. 3.42=E2=80=94March=
 2024):
> >
> >       When VMRUN is executed with nested paging enabled
> >       (NP_ENABLE =3D 1), the following conditions are considered illega=
l
> >       state combinations, in addition to those mentioned in
> >       =E2=80=9CCanonicalization and Consistency Checks=E2=80=9D:
> >       =E2=80=A2 Any MBZ bit of nCR3 is set.
> >       =E2=80=A2 Any G_PAT.PA field has an unsupported type encoding or =
any
> >       reserved field in G_PAT has a nonzero value.
> >
> > Add the consistency check for nCR3 being a legal GPA with no MBZ bits
> > set. The G_PAT.PA check was proposed separately [*].
> >
> > [*]https://lore.kernel.org/kvm/20260205214326.1029278-3-jmattson@google=
.com/
> >
> > Fixes: 4b16184c1cca ("KVM: SVM: Initialize Nested Nested MMU context on=
 VMRUN")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > ---
> >  arch/x86/kvm/svm/nested.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > index 613d5e2e7c3d1..3aaa4f0bb31ab 100644
> > --- a/arch/x86/kvm/svm/nested.c
> > +++ b/arch/x86/kvm/svm/nested.c
> > @@ -348,6 +348,11 @@ static bool nested_vmcb_check_controls(struct kvm_=
vcpu *vcpu,
> >       if (CC(control->asid =3D=3D 0))
> >               return false;
> >
> > +     if (control->nested_ctl & SVM_NESTED_CTL_NP_ENABLE) {
> > +             if (CC(!kvm_vcpu_is_legal_gpa(vcpu, control->nested_cr3))=
)
> > +                     return false;
>
> Put the full if-statement in CC(), that way the tracepoint will capture t=
he entire
> clause, i.e. will help the reader understand than nested_cr3 was checked
> specifically because NPT was enabled.

I had it this way in v6 because there was another consistency check
dependent on NPT being enabled:
https://lore.kernel.org/kvm/20260224223405.3270433-21-yosry@kernel.org/.

I dropped the patch in v7 as I realized L1's CR0.PG was already being
checked, but it didn't occur to me to go back and update this. Good
catch.

>
>         if (CC((control->nested_ctl & SVM_NESTED_CTL_NP_ENABLE) &&
>                !kvm_vcpu_is_legal_gpa(vcpu, control->nested_cr3)))
>                 return false;

