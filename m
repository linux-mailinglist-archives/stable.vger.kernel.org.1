Return-Path: <stable+bounces-216050-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eA3BE18Ij2ltHQEAu9opvQ
	(envelope-from <stable+bounces-216050-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 12:17:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B74B0135A46
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 12:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97193305FC52
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 11:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC5C352936;
	Fri, 13 Feb 2026 11:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e9NXA0As"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BCF2D7D59
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 11:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980875; cv=pass; b=ahYzSjb6g6WyLN3xxzRvJzkz0cFAt/cechRCoa9fJvbO09o4lGeXBQjWvJKVr6yV32YDE3DFgDv3YVm2pO++qblTM/Dfc/iRSnaUxi0o9WCAw/+4wkQuXL+/Ai5bpvZ479g24Wm6B6NLPAcq4xv0tIal05UXUt2TT4g3c+ZCbNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980875; c=relaxed/simple;
	bh=S4Ba0KXNuJGSXiTRArril8r2Pr+NJQGRneQ2XA75mB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gc8S6EoeYejOgcscA1G8M1Ps+Xccvwao5DzQARNVUDmQ1ZksNg13dC1licdd9VqIH1UTZDgghkt1J/nbz4wY/FxWFrYi8wR8yG10rC3FhL+K/4NSPYMn1bTayRDGm0QOYMAtjVJcQkJKIO/uW9O0fY/ueF7GJ9d1rZW7PbgvLEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e9NXA0As; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-506a355aedfso369601cf.0
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 03:07:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770980873; cv=none;
        d=google.com; s=arc-20240605;
        b=XA5+FkoLyM7HGk4utcqepCxBt4a8izKseoGw3Q1v5kvBXY6B2QZ3VJBsls1qh84pAu
         uSQ39Qb4wc3aEJUH5ePUHlGCBuyNLTehFKRd+5qeNfJ0XQ1szdq34RxIRI0vpkjCdjho
         iRGEQJpitX0Pk43zSawxUyX5eJf0L18mn68Og3QYoTt7La+A+ItWXvJ7Oko3n1Ly/1Y+
         lY93eCLdA6TMt0X0mUpTkZDj7AmZoPyEsjKCRjYhr78pSjUCnHt7LELRxII8nmUORlvi
         NsAZ6awNs0sx2xMXYl0uXLBxyPAywkhWmhcbjZXb9ud5f44EDAAMhN9G6JDL8u4rf64x
         ooxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BhioMr+TlEkKghKMNX83e9mEkIV+C0EY/uR4/Y90u/g=;
        fh=c3fbpCCSvPwEcm48X1GGrvzRQ2jX0FACIyHpL3wqSnk=;
        b=aAbYx00KZHY3Ul0uLqF5Xsb1cRYfw/yg3fkoOeD6nSAnooCOPwRU3BoqqekMyG7rLe
         qO9NdhsuWUKmg9hAho8JzDU3K57HPwzLEL2SLUo0YOVRPAYtJzMV3JXGtlWexA1zd4Ft
         zFjWZFCwZfxX4smYEfyHrqWu4NhV5gQpdiEOpDaRymXzwjNCY9w57M4afw5n09tcEjtH
         flJdq5qI4hsMSI3wS7RRYZcHBzAJdVmkf/pn2l4xI6IQtzufNduqn4dt9DEGA+XLhTl9
         8OIG5ggRd3xMFATMlhiwDX8h77iMuaWYPZyAHV4pVvnOWk+uQ0oDNmh4Q+gYqTnsX0iB
         slOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770980873; x=1771585673; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BhioMr+TlEkKghKMNX83e9mEkIV+C0EY/uR4/Y90u/g=;
        b=e9NXA0AsdNmqfk0ZPqV8h1TxMbtS1ZZC/0uN7M7tjvsETSqzDWE0psY2pE+QrfYh8b
         7sNqsRt9QSiOXoBmo9TGrQVNtFt/N6AtGv5WJeBR/ki3yEhpZFuY1fzTKHPRbGVTOYAy
         nXRRw9obe+1652aTANYgeyOEhfpRn3NBWIfWTO6QbeB35IT9Il8fZf3t+dcVIakQXS0z
         JFHKW5wvm9d3u+6reSNCKx1jgKbYzeRFNnVqXiFZ9FxnfUfxvV/VFqxY+wviS1AllEbl
         g2odT9xBgzNe/SkmwaR0M+W1Omn27QQbw8YAG4ANpGJA+n62i3EKTApG1ZdB329BPbYS
         aTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770980873; x=1771585673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhioMr+TlEkKghKMNX83e9mEkIV+C0EY/uR4/Y90u/g=;
        b=n6iFLSWUDLE3aTSWudHCkkfTcFfDxMZ7y51XXRqSEV9fWBKAA/mzzMuuj5WitxSL1S
         yuJATDv5T5XcOfaycRgixWI9pnzkYzRHGtn/gvwARJialqbRBWzAj0e1VUMUc75qnJWh
         vfbOnileHycWijGfG2NTZI1MEbi4FGME0j3LCKQCz9lPkuse/XXJN8dNGOq6Gb2AbFrU
         AcEs2DwrGGWl2weswUh69G7I1ISjI5tEHUqE1XNU/yslU2EbOzeKT+yYrCwckNgxLYD5
         sU2orCU3z6ZW3hYL0imDG4aF0Esr+lQjUEKKv33p6H1H3AS5W18ZGnNPkQtf2LTfsfte
         cBEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj0r+A045iZ1BytxeNxx/rR9zTxGtPNzslweAHDgOBOCh883zI3bSU85bgVi9IK4WbtLpC7NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy9eEVGKpKtRCESgvlzO7TTyXgkx9ZCYIVD4VHk3yjeA10JLmF
	WeLc0kJpxwG2fPDiXiyaGSvU3vAkOvxuHWvy3+q09T7pGdSfL10gmWk2HshDZSmvAn3gxo4UaKO
	VtZjRtTzBG7OKhXdzdhbi84uOFImDnuCQ0+uQSl89
X-Gm-Gg: AZuq6aKfoEEXnzJC+Xnq/68HGC+F/dt07iNBE3yE4LXABRuKupToU4zwCz0mu8jdz+l
	pNQbpph4G5AVNoPrBK1QEHbB/D0m7PAb9WySVmXfA7yq8LPdmPKkBOX0igy1t4qmbvYBs/xzrgL
	3lJYT2QSV6JZWWXQDVrunAcDl4iMbUSSzy916GTvaV+WKwXKt3q3zHI/VBCjhL9Jk0S1vY1r/GA
	Pv5ir7NbpfGR35J5t6mJ3xhxezKG2SYF4Y8eS9g4/JLSWCHLv7bcqIsld8D3QFUOc2d3oPUMJyU
	S3dS7iNU
X-Received: by 2002:ac8:5794:0:b0:4ff:bfd9:dd31 with SMTP id
 d75a77b69052e-506a8434debmr6596891cf.5.1770980872383; Fri, 13 Feb 2026
 03:07:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212090252.158689-1-tabba@google.com> <20260212090252.158689-3-tabba@google.com>
 <86ecmoc3dk.wl-maz@kernel.org>
In-Reply-To: <86ecmoc3dk.wl-maz@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 13 Feb 2026 11:07:16 +0000
X-Gm-Features: AZwV_QgSdg6ZxR7oLi_wuOeoAvMjVYMSeO2-E9Trn8UZX41x8tt3ScmTFjatuKs
Message-ID: <CA+EHjTx1xjPCd0w56YDF42W=-HtKm9DYxUwGPd+2u-zmiSw9CQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] KVM: arm64: Fix ID register initialization for
 non-protected pKVM guests
To: Marc Zyngier <maz@kernel.org>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tabba@google.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-216050-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: B74B0135A46
X-Rspamd-Action: no action

On Fri, 13 Feb 2026 at 11:03, Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 12 Feb 2026 09:02:51 +0000,
> Fuad Tabba <tabba@google.com> wrote:
> >
> > In protected mode, the hypervisor maintains a separate instance of
> > the `kvm` structure for each VM. For non-protected VMs, this structure is
> > initialized from the host's `kvm` state.
> >
> > Currently, `pkvm_init_features_from_host()` copies the
> > `KVM_ARCH_FLAG_ID_REGS_INITIALIZED` flag from the host without the
> > underlying `id_regs` data being initialized. This results in the
> > hypervisor seeing the flag as set while the ID registers remain zeroed.
> >
> > Consequently, `kvm_has_feat()` checks at EL2 fail (return 0) for
> > non-protected VMs. This breaks logic that relies on feature detection,
> > such as `ctxt_has_tcrx()` for TCR2_EL1 support. As a result, certain
> > system registers (e.g., TCR2_EL1, PIR_EL1, POR_EL1) are not
> > saved/restored during the world switch, which could lead to state
> > corruption.
> >
> > Fix this by explicitly copying the ID registers from the host `kvm` to
> > the hypervisor `kvm` for non-protected VMs during vCPU initialization,
> > since we trust the host with its non-protected guests' features. Also
> > ensure `KVM_ARCH_FLAG_ID_REGS_INITIALIZED` is cleared initially in
> > `pkvm_init_features_from_host` so that `vm_copy_id_regs` can properly
> > initialize them and set the flag once done.
> >
> > Fixes: 41d6028e28bd ("KVM: arm64: Convert the SVE guest vcpu flag to a vm flag")
> > Signed-off-by: Fuad Tabba <tabba@google.com>
> > ---
> >  arch/arm64/kvm/hyp/nvhe/pkvm.c | 37 ++++++++++++++++++++++++++++++++--
> >  1 file changed, 35 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
> > index 12b2acfbcfd1..267854ed29c8 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
> > @@ -344,6 +344,8 @@ static void pkvm_init_features_from_host(struct pkvm_hyp_vm *hyp_vm, const struc
> >
> >       /* No restrictions for non-protected VMs. */
> >       if (!kvm_vm_is_protected(kvm)) {
> > +             clear_bit(KVM_ARCH_FLAG_ID_REGS_INITIALIZED, &host_arch_flags);
> > +
> >               hyp_vm->kvm.arch.flags = host_arch_flags;
>
> Can't you just have
>
>                 hyp_vm->kvm.arch.flags &= ~BIT_ULL(KVM_ARCH_FLAG_ID_REGS_INITIALIZED);
>
> since there are no atomicity requirements here?

I'll fix this.

> >
> >               bitmap_copy(kvm->arch.vcpu_features,
> > @@ -471,6 +473,36 @@ static int pkvm_vcpu_init_sve(struct pkvm_hyp_vcpu *hyp_vcpu, struct kvm_vcpu *h
> >       return ret;
> >  }
> >
> > +static int vm_copy_id_regs(struct pkvm_hyp_vcpu *hyp_vcpu)
> > +{
> > +     struct pkvm_hyp_vm *hyp_vm = pkvm_hyp_vcpu_to_hyp_vm(hyp_vcpu);
> > +     const struct kvm *host_kvm = hyp_vm->host_kvm;
> > +     struct kvm *kvm = &hyp_vm->kvm;
> > +
> > +     if (!test_bit(KVM_ARCH_FLAG_ID_REGS_INITIALIZED, &host_kvm->arch.flags))
> > +             return -EINVAL;
> > +
> > +     if (test_bit(KVM_ARCH_FLAG_ID_REGS_INITIALIZED, &kvm->arch.flags))
> > +             return 0;
> > +
> > +     memcpy(kvm->arch.id_regs, host_kvm->arch.id_regs, sizeof(kvm->arch.id_regs));
> > +     set_bit(KVM_ARCH_FLAG_ID_REGS_INITIALIZED, &kvm->arch.flags);
>
> This looks a bit odd. Can you have another vcpu doing this in
> parallel? You seem to be holding vm_table_lock at this stage, so
> that's probably OK,  but I'd have expected something like:

You're right, it cannot happen in parallel, but another vCPU could
have beaten this one to it.

>
>         if (test_and_set_bit(KVM_ARCH_FLAG_ID_REGS_INITIALIZED, &kvm->arch.flags))
>                 return 0;
>
>         memcpy(kvm->arch.id_regs, host_kvm->arch.id_regs, sizeof(kvm->arch.id_regs));
>
> which makes the intent slightly clearer.

I agree. I'll fix this too.

Thanks,
/fuad

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

