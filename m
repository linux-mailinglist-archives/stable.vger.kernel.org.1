Return-Path: <stable+bounces-222935-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDOtIQwzp2kjfwAAu9opvQ
	(envelope-from <stable+bounces-222935-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 20:14:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1D91F5C41
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 20:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C6D83043DE2
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 19:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453E34F7997;
	Tue,  3 Mar 2026 19:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bR0ZDsBE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7724F797E
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 19:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772565255; cv=none; b=CB2AfEvh/E0WKtmuDJfVNYs0q5SHZOM/ET/RlJqT5wUFSNnQ2gi9E4O8qISC4aPLuPAkoFszjUKL3kOwKRYlqaQ/1dg3Fy9jbXPCp8RpCMYjE3dsROzpNSR78y3XtDng78mlZjb9uTapSqfmZ0lciocFMv/NWLjpAphfhjzW3Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772565255; c=relaxed/simple;
	bh=NVWdehTmvpfKienX9tiFsI0nTve1Ag9Jb3YnzqPy8xU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fnCJqulS4rcL2/arGDarPT6XXvgPi5ap2Oykc3uD6U60JVL2z1QRlHpaxGb8s202b+7uBtKZV3++bj/Li5MaD1U89mD1+FJurUP9p1kZOrlJuEIus6WhABVnI0w4EHhmreuYI1dd2OdYwpfSL+91g5TIn1iow1SjSSDzuUBEqeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bR0ZDsBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC40C2BCAF
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 19:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772565254;
	bh=NVWdehTmvpfKienX9tiFsI0nTve1Ag9Jb3YnzqPy8xU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bR0ZDsBEN+Lal/QOCtTC+bmkX9WLgQUGym/yGLSkogVZem6lC5qTU+eaSVcgXWLRN
	 3DfNFse3s+ESxoP4hyVf1U77kLcQaYZCA2QChMPug4stDWXPXcJqjqX7ZgPK6u5GKM
	 gsf/ETxNk6jDfsT1FZZSHWJO2wWCUtyFCEjamJ/GX7qTukVVphV7nmCbIfk3MnQ05f
	 x+B9Oe/6JisvCwlGZ3jdPEDnbWKEmZwkGb9+dfc5JjUE8ZVddrJTbq9WFRmzmBwwAd
	 RtutqIvRo/yKK0KHIVAvKhvmhjKWLZrgVceqH9ajRlBON9zhgMnBlLe5R+QTGZPDbo
	 IZNWaDWaqLLjg==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9361c771e9so964558966b.3
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 11:14:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1FGKKBedFLEEEW9ZJaGtzAVBS+Z0OjuTmY+Y49E5t4y87OywhFDRXa9S6OcIOQUCJhRsUPPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO/Lia4mdwLQPfWVFzgtlXmeNhkQd/u3wGXZ/bsfMJNW86sYqm
	SftUzP0M5tyS49MktbemBHvOsfEU5pBeGh6j8eGbVFAAEf4QKXVmLkMDri08uGKQMTkA/G/+NCG
	cLhvr0x9XAvqBKunSizXYKctDSulG/X0=
X-Received: by 2002:a17:907:8688:b0:b93:8e7f:3d3f with SMTP id
 a640c23a62f3a-b938e7f591fmr817038766b.32.1772565253676; Tue, 03 Mar 2026
 11:14:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303003421.2185681-1-yosry@kernel.org> <20260303003421.2185681-4-yosry@kernel.org>
 <aacOPmIS7HUtzJA6@google.com>
In-Reply-To: <aacOPmIS7HUtzJA6@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 3 Mar 2026 11:14:01 -0800
X-Gmail-Original-Message-ID: <CAO9r8zMDQkHAMKVewDgvH6_WAHo5eL4=Xwf7h=87JPOJPYQAFQ@mail.gmail.com>
X-Gm-Features: AaiRm52MlN35dUDlnEHTSp6ynab3akKubQo3EDhv0kDthDY5ZZKzjmt0ntrWLfE
Message-ID: <CAO9r8zMDQkHAMKVewDgvH6_WAHo5eL4=Xwf7h=87JPOJPYQAFQ@mail.gmail.com>
Subject: Re: [PATCH v7 03/26] KVM: SVM: Add missing save/restore handling of
 LBR MSRs
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 2C1D91F5C41
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222935-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

> > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > index f7d5db0af69ac..3bf758c9cb85c 100644
> > --- a/arch/x86/kvm/svm/nested.c
> > +++ b/arch/x86/kvm/svm/nested.c
> > @@ -1100,6 +1100,11 @@ void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
> >               to_save->isst_addr = from_save->isst_addr;
> >               to_save->ssp = from_save->ssp;
> >       }
> > +
> > +     if (lbrv) {
>
> Tomato, tomato, but maybe make this
>
>         if (kvm_cpu_cap_has(X86_FEATURE_LBRV)) {
>
> to capture that this requires nested support.  I can't imagine we'll ever disable
> X86_FEATURE_LBRV when nested=1 && lbrv=1, but I don't see any harm in being
> paranoid in this case.

Sounds good.

>
> > +             svm_copy_lbrs(to_save, from_save);
> > +             to_save->dbgctl &= ~DEBUGCTL_RESERVED_BITS;
> > +     }
> >  }
> >
> >  void svm_copy_vmloadsave_state(struct vmcb *to_vmcb, struct vmcb *from_vmcb)
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index f52e588317fcf..cb53174583a26 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -3071,6 +3071,30 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
> >               vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
> >               svm_update_lbrv(vcpu);
> >               break;
> > +     case MSR_IA32_LASTBRANCHFROMIP:
>
> Shouldn't these be gated on lbrv?  If LBRV is truly unsupported, KVM would be
> writing "undefined" fields and clearing "unknown" clean bits.
>
> Specifically, if we do:
>
>                 if (!lbrv)
>                         return KVM_MSR_RET_UNSUPPORTED;
>
> then kvm_do_msr_access() will allow writes of '0' from the host, via this code:
>
>         if (host_initiated && !*data && kvm_is_advertised_msr(msr))
>                 return 0;
>
> And then in the read side, do e.g.:
>
>         msr_info->data = lbrv ? svm->vmcb->save.dbgctl : 0;
>
> to ensure KVM won't feed userspace garbage (the VMCB fields should be '0', but
> there's no reason to risk that).

Good call.

>
> The changelog also needs to call out that kvm_set_msr_common() returns
> KVM_MSR_RET_UNSUPPORTED for unhandled MSRs (i.e. for VMX and TDX), and that
> kvm_get_msr_common() explicitly zeros the data for MSR_IA32_LASTxxx (because per
> b5e2fec0ebc3 ("KVM: Ignore DEBUGCTL MSRs with no effect"), old and crust kernels
> would read the MSRs on Intel...).

That was captured (somehow):

For VMX, this also adds save/restore handling of KVM_GET_MSR_INDEX_LIST.
For unspported MSR_IA32_LAST* MSRs, kvm_do_msr_access() should 0 these
MSRs on userspace reads, and ignore KVM_MSR_RET_UNSUPPORTED on userspace
writes.

>
> So all in all (not yet tested), this?  If this is the only issue in the series,
> or at least in the stable@ part of the series, no need for a v8 (I've obviously
> already done the fixup).

Looks good with a minor nit below (could be a followup).

> @@ -3075,6 +3075,38 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>                 vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
>                 svm_update_lbrv(vcpu);
>                 break;
> +       case MSR_IA32_LASTBRANCHFROMIP:
> +               if (!lbrv)
> +                       return KVM_MSR_RET_UNSUPPORTED;
> +               if (!msr->host_initiated)
> +                       return 1;
> +               svm->vmcb->save.br_from = data;
> +               vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
> +               break;
> +       case MSR_IA32_LASTBRANCHTOIP:
> +               if (!lbrv)
> +                       return KVM_MSR_RET_UNSUPPORTED;
> +               if (!msr->host_initiated)
> +                       return 1;
> +               svm->vmcb->save.br_to = data;
> +               vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
> +               break;
> +       case MSR_IA32_LASTINTFROMIP:
> +               if (!lbrv)
> +                       return KVM_MSR_RET_UNSUPPORTED;
> +               if (!msr->host_initiated)
> +                       return 1;
> +               svm->vmcb->save.last_excp_from = data;
> +               vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
> +               break;
> +       case MSR_IA32_LASTINTTOIP:
> +               if (!lbrv)
> +                       return KVM_MSR_RET_UNSUPPORTED;
> +               if (!msr->host_initiated)
> +                       return 1;
> +               svm->vmcb->save.last_excp_to = data;
> +               vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
> +               break;

There's so much repeated code here. We can use gotos to share code,
but I am not sure if that's a strict improvement. We can also use a
helper, perhaps?

static int svm_set_lbr_msr(struct vcpu_svm *svm, struct msr_data *msr,
u64 data, u64 *field)
{
       if (!lbrv)
               return KVM_MSR_RET_UNSUPPORTED;
       if (!msr->host_initiated)
               return 1;
       *field = data;
        vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
        return 0;
}

...

       case MSR_IA32_LASTBRANCHFROMIP:
             ret = svm_set_lbr_msr(svm, msr, data, &svm->vmcb->save.br_from);
             if (ret)
                        return ret;
              break;
...

