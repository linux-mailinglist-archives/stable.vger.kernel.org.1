Return-Path: <stable+bounces-200470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7511CB08E1
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 17:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8599300EDF8
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 16:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CAB3203B5;
	Tue,  9 Dec 2025 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0/mqXHnj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289A230C625
	for <stable@vger.kernel.org>; Tue,  9 Dec 2025 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765297663; cv=none; b=GDj1iYNMGPB1vHQywQve4PabG0owcvfe4d26C/QlHZlttAyUqXsAtn4ammCM0ncxuV1WAGaA3GWyO4x9KoJLWtqI5WgUatad/lcNhUY19woDWdCYqBq8YapnBotZw6GIe57Oa1vP8Vg34iC81YxvOL7wLh5gUPEaMBtE9XNZXDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765297663; c=relaxed/simple;
	bh=SNAnRlA3539bfHq+R+TKZmm2yT4kvTBApZ6O3e/K8Ps=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o4fImJvGy4CSrfhW+JqW9v43RoE4oNACmAhlCgoSRABnBrS3yyho7pOcaaFbydbBKWQ4CtMumn2S4TXaJQIrSn2J2vvi4ugiI8LYwrnnVGwrXZQP/E4QlpeAoZ7cy7BBzI2SEDr5lxCWeRRkRooKmbcT3Dg0O2EYZ6TngXF/AL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0/mqXHnj; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297d50cd8c4so156169365ad.0
        for <stable@vger.kernel.org>; Tue, 09 Dec 2025 08:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765297661; x=1765902461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JotnQXVrfnqC2gVXycm/TKve6hG6i1AVdUdGKhmLaM0=;
        b=0/mqXHnjzEWqIbaPrkNSPntZBOTlWj+3mZr6NRioAOb0nzidQG0an6CEUPvv1rerv4
         LhFG6381zG+MLZ+Jslgw2rh7QpSgCQs/oLmRYE/+ZykmfbDskDFIk5KUnwMXhzqEy2uU
         7NwYlRzOM1zAnfWePK6XvD4Q1ljt39EDltgoSHOcXh7ELz+y1FmTp2RB8sZxb81uq03J
         sygsIfLmqjF1vuXDg2CaeB9k1vixVq4YTX4f2Zy7yid7XnuGmSjvjV0wXtZGd54DZ3bK
         s6xxsZRUo9sFjLea1I0ZiO8tD0rL8ryy1yF08AokUXsttInWykHVCTKm4YJxlvou3oxt
         m/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765297661; x=1765902461;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JotnQXVrfnqC2gVXycm/TKve6hG6i1AVdUdGKhmLaM0=;
        b=G9L8FrBfSP3ezOa+uesf98bVygNCngYvtdo0GFjR/FsFRh9keCd6ueTwwfl5Jm/WH3
         tlUKEoP250S4PU5DtA5NBD0UhkRMY58W07OKrsgJOAEtfusCyS+d3xD7DV0HYu/1K9Ql
         5G030Gu2tTtTQd2/50Pa3v0+gU9QW83We8IDJYZiOmrDwTsdJXL6l8iP7aOH0kpgGAGi
         H26biPGVaGjrKiG66y8OSu6T7KBqoq9Fe9PKjzCzPNixzTFzjWJxGt/r96mAJxt+hkOF
         KoUBDeJPd0Rqv8m2DQe7Qy2O0CTq/gZDYkc+qnb2Sb7t2zaRqFZDSlVk6avYVYIPJuuD
         bhaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtSkeaL5/bUkqM5MSoPmhftK/oBHE/uhtbdUVySsqAM84tsmCRplr/BvDoZ+wEVQw6j2Qloxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwumWaY0A3qxyjHgFcIF9NRXeeGEiPUbMxF/+sQDq+vqzsc5+Bn
	HhO5xPPmpzDVGEb+hb5FmoVOWKSPHBuX9/cpic47ehv0NJaSSPdoDymVadolRtSc22KrAnIxvra
	kSwYvug==
X-Google-Smtp-Source: AGHT+IFfK2nurT6ZzsgU/bI8E/KY4lmocV/LPvYRWdHuT81nqm9sMxn2clE0n87juoPHa0lfZqK+VjiQx/s=
X-Received: from plbmq3.prod.google.com ([2002:a17:902:fd43:b0:295:73ce:b93b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3504:b0:298:46a9:df1f
 with SMTP id d9443c01a7336-29df55725b1mr110750925ad.12.1765297661381; Tue, 09
 Dec 2025 08:27:41 -0800 (PST)
Date: Tue, 9 Dec 2025 08:27:39 -0800
In-Reply-To: <20251110222922.613224-5-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110222922.613224-1-yosry.ahmed@linux.dev> <20251110222922.613224-5-yosry.ahmed@linux.dev>
Message-ID: <aThN-xUbQeFSy_F7@google.com>
Subject: Re: [PATCH v2 04/13] KVM: nSVM: Fix consistency checks for NP_ENABLE
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025, Yosry Ahmed wrote:
> KVM currenty fails a nested VMRUN and injects VMEXIT_INVALID (aka
> SVM_EXIT_ERR) if L1 sets NP_ENABLE and the host does not support NPTs.
> On first glance, it seems like the check should actually be for
> guest_cpu_cap_has(X86_FEATURE_NPT) instead, as it is possible for the
> host to support NPTs but the guest CPUID to not advertise it.
>=20
> However, the consistency check is not architectural to begin with. The
> APM does not mention VMEXIT_INVALID if NP_ENABLE is set on a processor
> that does not have X86_FEATURE_NPT. Hence, NP_ENABLE should be ignored
> if X86_FEATURE_NPT is not available for L1. Apart from the consistency
> check, this is currently the case because NP_ENABLE is actually copied
> from VMCB01 to VMCB02, not from VMCB12.
>=20
> On the other hand, the APM does mention two other consistency checks for
> NP_ENABLE, both of which are missing (paraphrased):
>=20
> In Volume #2, 15.25.3 (24593=E2=80=94Rev. 3.42=E2=80=94March 2024):
>=20
>   If VMRUN is executed with hCR0.PG cleared to zero and NP_ENABLE set to
>   1, VMRUN terminates with #VMEXIT(VMEXIT_INVALID)
>=20
> In Volume #2, 15.25.4 (24593=E2=80=94Rev. 3.42=E2=80=94March 2024):
>=20
>   When VMRUN is executed with nested paging enabled (NP_ENABLE =3D 1), th=
e
>   following conditions are considered illegal state combinations, in
>   addition to those mentioned in =E2=80=9CCanonicalization and Consistenc=
y
>   Checks=E2=80=9D:
>     =E2=80=A2 Any MBZ bit of nCR3 is set.
>     =E2=80=A2 Any G_PAT.PA field has an unsupported type encoding or any
>     reserved field in G_PAT has a nonzero value.

This should be three patches, one each for the new consistency checks, and =
one
to the made-up check.  Shortlogs like "Fix all the bugs" are strong hints t=
hat
a patch is doing too much.

> Replace the existing consistency check with consistency checks on
> hCR0.PG and nCR3. Only perform the consistency checks if L1 has
> X86_FEATURE_NPT and NP_ENABLE is set in VMCB12. The G_PAT consistency
> check will be addressed separately.
>=20
> As it is now possible for an L1 to run L2 with NP_ENABLE set but
> ignored, also check that L1 has X86_FEATURE_NPT in nested_npt_enabled().
>=20
> Pass L1's CR0 to __nested_vmcb_check_controls(). In
> nested_vmcb_check_controls(), L1's CR0 is available through
> kvm_read_cr0(), as vcpu->arch.cr0 is not updated to L2's CR0 until later
> through nested_vmcb02_prepare_save() -> svm_set_cr0().
>=20
> In svm_set_nested_state(), L1's CR0 is available in the captured save
> area, as svm_get_nested_state() captures L1's save area when running L2,
> and L1's CR0 is stashed in VMCB01 on nested VMRUN (in
> nested_svm_vmrun()).
>=20
> Fixes: 4b16184c1cca ("KVM: SVM: Initialize Nested Nested MMU context on V=
MRUN")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> ---
>  arch/x86/kvm/svm/nested.c | 21 ++++++++++++++++-----
>  arch/x86/kvm/svm/svm.h    |  3 ++-
>  2 files changed, 18 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 74211c5c68026..87bcc5eff96e8 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -325,7 +325,8 @@ static bool nested_svm_check_bitmap_pa(struct kvm_vcp=
u *vcpu, u64 pa, u32 size)
>  }
> =20
>  static bool __nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
> -					 struct vmcb_ctrl_area_cached *control)
> +					 struct vmcb_ctrl_area_cached *control,
> +					 unsigned long l1_cr0)
>  {
>  	if (CC(!vmcb12_is_intercept(control, INTERCEPT_VMRUN)))
>  		return false;
> @@ -333,8 +334,12 @@ static bool __nested_vmcb_check_controls(struct kvm_=
vcpu *vcpu,
>  	if (CC(control->asid =3D=3D 0))
>  		return false;
> =20
> -	if (CC((control->nested_ctl & SVM_NESTED_CTL_NP_ENABLE) && !npt_enabled=
))
> -		return false;
> +	if (nested_npt_enabled(to_svm(vcpu))) {
> +		if (CC(!kvm_vcpu_is_legal_gpa(vcpu, control->nested_cr3)))
> +			return false;
> +		if (CC(!(l1_cr0 & X86_CR0_PG)))
> +			return false;
> +	}
> =20
>  	if (CC(!nested_svm_check_bitmap_pa(vcpu, control->msrpm_base_pa,
>  					   MSRPM_SIZE)))
> @@ -400,7 +405,12 @@ static bool nested_vmcb_check_controls(struct kvm_vc=
pu *vcpu)
>  	struct vcpu_svm *svm =3D to_svm(vcpu);
>  	struct vmcb_ctrl_area_cached *ctl =3D &svm->nested.ctl;
> =20
> -	return __nested_vmcb_check_controls(vcpu, ctl);
> +	/*
> +	 * Make sure we did not enter guest mode yet, in which case

No pronouns.

> +	 * kvm_read_cr0() could return L2's CR0.
> +	 */
> +	WARN_ON_ONCE(is_guest_mode(vcpu));
> +	return __nested_vmcb_check_controls(vcpu, ctl, kvm_read_cr0(vcpu));
>  }
> =20
>  static
> @@ -1831,7 +1841,8 @@ static int svm_set_nested_state(struct kvm_vcpu *vc=
pu,
> =20
>  	ret =3D -EINVAL;
>  	__nested_copy_vmcb_control_to_cache(vcpu, &ctl_cached, ctl);
> -	if (!__nested_vmcb_check_controls(vcpu, &ctl_cached))
> +	/* 'save' contains L1 state saved from before VMRUN */
> +	if (!__nested_vmcb_check_controls(vcpu, &ctl_cached, save->cr0))
>  		goto out_free;
> =20
>  	/*
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index f6fb70ddf7272..3e805a43ffcdb 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -552,7 +552,8 @@ static inline bool gif_set(struct vcpu_svm *svm)
> =20
>  static inline bool nested_npt_enabled(struct vcpu_svm *svm)
>  {
> -	return svm->nested.ctl.nested_ctl & SVM_NESTED_CTL_NP_ENABLE;
> +	return guest_cpu_cap_has(&svm->vcpu, X86_FEATURE_NPT) &&
> +		svm->nested.ctl.nested_ctl & SVM_NESTED_CTL_NP_ENABLE;

I would rather rely on Kevin's patch to clear unsupported features.

>  }
> =20
>  static inline bool nested_vnmi_enabled(struct vcpu_svm *svm)
> --=20
> 2.51.2.1041.gc1ab5b90ca-goog
>=20

