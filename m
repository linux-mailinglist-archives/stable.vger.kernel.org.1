Return-Path: <stable+bounces-219724-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AM2jL117n2lmcQQAu9opvQ
	(envelope-from <stable+bounces-219724-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 23:44:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A3E19E6CB
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 23:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1AD23064BE6
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 22:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D5034D392;
	Wed, 25 Feb 2026 22:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdmvKaFH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571BA31690E
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 22:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772059456; cv=none; b=q7Qi2Z1+AzP/L4AGPEC55BTaGqmolj8V8fYEa83ww7Ek7WHXn6EW1JS6XxB2ce+HNhbWxM8M8v+Df8DsY02+tb53bziAefYcqWh2Vv8AKnBolApS+tChExK9jJZx15cZCMOwYrTAaFReVb0SdngpLjLU4u+cak+Us8RB3To5Iwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772059456; c=relaxed/simple;
	bh=g/KGEimT/X+0VqaoMce6mZB36StxBuHTz74wXUXwxPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTF9NynILwXTlspTZ0Z+No8Lv7B8zpwTGQdZnR9GHsm4UBtC69cH3pYWL14V8u2lXgR7gVHPOYtacZ1BIGpSE+9qty/zaJTb+I6LHl2EDJui9VtiLbmYdiJanm3JzkVMSPaOiJPDoUGdI8SkLQnsIRz0Bals1jRHwt8IGW4N3j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdmvKaFH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0266DC116D0
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 22:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772059456;
	bh=g/KGEimT/X+0VqaoMce6mZB36StxBuHTz74wXUXwxPg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BdmvKaFHhqVyMXncCB0L6IYQawHQvnmP2puA1ugyu/9IFABsz1cBFvRSW++lH7BOF
	 qibtJZ4FRTd6yRxDUnwgGdiZi1R5CFniCn2PyS8cz5Gk7cocpKbtwPSFrWn8Zu1Jsr
	 L2qzbG5JTfa6jDBzmBhtMmHZ7iJ1LnFml6PQp95VoRt0fUqDATHsliWpTpxiHBVfy9
	 +tFY53nklCGN3h7vZrgZez8EAx05onI8FZ3w7RMTJMcXhx2ek6U7yLoiECrg1UE1SI
	 AMUpSncMgsLzd9G4eR2rdCesjnKp7c3NOf14b54daEoOuec8pDkQ7j1QIVVwRjpTIf
	 WZvGeYhMwEWtw==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65a2fea1a1eso2168286a12.0
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 14:44:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVqJyVmRIV9HcrbHCj47NdnXR4NUhc4Yolk29xliiESWLYsVhtD4xL29NZccOvOSoAgmXbKpHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBsguDIF77uony+Txpt2g9jIOZOLNGUn3T4cCihBwuN+F2eAei
	Pei7dXcdp2+i2FDvUAjWyx7QJMrxeEfXG5iv7GGrqJc4DCkD0yF8q0fy9ZTmAeu5/9Nl4KyuohA
	0Zdg1efu5GUs87G9P2xNFxDViqNf08mE=
X-Received: by 2002:a17:907:3e82:b0:b8f:c684:db28 with SMTP id
 a640c23a62f3a-b9356f99d4cmr45998766b.12.1772059454826; Wed, 25 Feb 2026
 14:44:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224223405.3270433-1-yosry@kernel.org> <20260224223405.3270433-17-yosry@kernel.org>
In-Reply-To: <20260224223405.3270433-17-yosry@kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 25 Feb 2026 14:44:03 -0800
X-Gmail-Original-Message-ID: <CAO9r8zP3-=M+3hyve4-0uGXCsKrhwmx+YPXzw0b-+WfTRS-M1g@mail.gmail.com>
X-Gm-Features: AaiRm50piw7sYl7IlcOqh1IjoW7ZIltJcKpNFA31qLSldsYHKfqSuGLBfbMNb-c
Message-ID: <CAO9r8zP3-=M+3hyve4-0uGXCsKrhwmx+YPXzw0b-+WfTRS-M1g@mail.gmail.com>
Subject: Re: [PATCH v6 16/31] KVM: nSVM: Unify handling of VMRUN failures with
 proper cleanup
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219724-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39A3E19E6CB
X-Rspamd-Action: no action

> @@ -939,22 +939,19 @@ int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb12_gpa,
>                                     vmcb12->control.intercepts[INTERCEPT_WORD4],
>                                     vmcb12->control.intercepts[INTERCEPT_WORD5]);
>
> -
>         svm->nested.vmcb12_gpa = vmcb12_gpa;
>
>         WARN_ON(svm->vmcb == svm->nested.vmcb02.ptr);
>
>         enter_guest_mode(vcpu);
>
> +       if (!nested_vmcb_check_save(vcpu, &svm->nested.save) ||
> +           !nested_vmcb_check_controls(vcpu, &svm->nested.ctl))
> +               return -EINVAL;
> +
>         if (nested_npt_enabled(svm))
>                 nested_svm_init_mmu_context(vcpu);
>
> -       nested_svm_copy_common_state(svm->vmcb01.ptr, svm->nested.vmcb02.ptr);
> -
> -       svm_switch_vmcb(svm, &svm->nested.vmcb02);
> -       nested_vmcb02_prepare_control(svm, vmcb12->save.rip, vmcb12->save.cs.base);
> -       nested_vmcb02_prepare_save(svm, vmcb12);
> -
>         ret = nested_svm_load_cr3(&svm->vcpu, svm->nested.save.cr3,
>                                   nested_npt_enabled(svm), from_vmrun);
>         if (ret)

I think the above is wrong (as pointed out by an internal AI bot).
nested_vmcb02_prepare_save() also initializes architectural state to
L2's, moving it after nested_svm_load_cr3() means that
nested_svm_load_cr3() will use L1's architectural state (e.g. in
is_pae_paging(), but more importantly in kvm_init_mmu()).

The only clean-ish solution I can think of is to refactor loading L2's
architectural state out of nested_vmcb02_prepare_save(), and keep it
before nested_svm_load_cr3(). Then, also refactor restoring L1's
architectural state out of nested_svm_vmexit() and also do it in
nested_svm_vmrun_error_vmexit().

We can probably move it to __nested_svm_vmexit(), assuming nothing
else in nested_svm_vmexit() relies on it.

That being said, I am open to suggestions for better options.

> @@ -966,6 +963,17 @@ int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb12_gpa,
>                         return ret;
>         }
>
> +       /*
> +        * Any VMRUN failure needs to happen before this point, such that the
> +        * nested #VMEXIT is injected properly by nested_svm_vmrun_error_vmexit().
> +        */
> +
> +       nested_svm_copy_common_state(svm->vmcb01.ptr, svm->nested.vmcb02.ptr);
> +
> +       svm_switch_vmcb(svm, &svm->nested.vmcb02);
> +       nested_vmcb02_prepare_control(svm, vmcb12->save.rip, vmcb12->save.cs.base);
> +       nested_vmcb02_prepare_save(svm, vmcb12);
> +

Another problem here, hidden above the context lines is a call to
nested_svm_merge_msrpm(), which updates msrpm_base_pa in the active
VMCB, which should be vmcb02, but will be vmcb01 because we moved the
VMCB switch below it.

I think the easiest thing to do here is make nested_svm_merge_msrpm()
explicitly update msrpm_base_pa in vmcb02, I think this is probably
better anyway.

