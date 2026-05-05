Return-Path: <stable+bounces-244250-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJDQFZUw+mkGKwMAu9opvQ
	(envelope-from <stable+bounces-244250-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 20:01:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D87F54D2731
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 20:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2EAB306B26D
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 18:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C294A33F2;
	Tue,  5 May 2026 18:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R2iPwoLr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8004A3402
	for <stable@vger.kernel.org>; Tue,  5 May 2026 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778004101; cv=pass; b=fzkfaj7dDxccw7aBgIMnasd1eKO4m9W3DkKpS+0pFH+Dk/oQcX87b8irdZKpDWIwTEbVwaS9ocWgZNFm4PM2vurVn5n6psrWajFAUfraKbh897gvkHj1oGVKFxP2cANFyPW4KWb2FoDo6FaNuR05RiXI1EAAwaWSF0ZEGwb1FbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778004101; c=relaxed/simple;
	bh=f+ypqmN+lQj0IF/Oa+7CTxDcYQldd91C7IUoR3r3pGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aUzFElBRXCXNCeMwiupFLrXkh4eJ/UB2klUvS7vFIEPFB7+cEmtZNLe1UnyExf5+0JNYrasgwghBPlRPWYH/6oUATVolGuZr7kCiyrl1q77Qa9pXe7lWHP/NrGuxyk9h4Rmtr+DgTwvgceyWIIKTn86/VkcAdUtcYqgF6mmclVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R2iPwoLr; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bb3c4d8cc29so885307066b.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 11:01:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778004098; cv=none;
        d=google.com; s=arc-20240605;
        b=NR0qc+gOeD9yGJUcwMZsoJsyqssyCY42FZIYxhu49yDGba7DblP4pvKtQeBaFGtedQ
         8HB8RCfnnojBDgFiF+GUPzvDWqPKqOTmt0lbG+mSECRkYelBiVIG6c5qxFFniLOVd6wG
         qtmgEtFohfgUULKF6fuMZhBYSX2LAVMFN3hYE+DkeYrn8bBnxzJOnMlg5q4MJzLEW61d
         fl1mxEKLLLfhSU3Xh+akNjmEK/wfYhUGh52Am+9a1IukGc4DsBi/SDNGi+dV2K+vbuXS
         KzvupLZiqiq3rnxKD0vh4bDu55bgEpTSHGsZpuNTsxMrGQ6i/CS/+phU+4HdQ0V/kCW0
         wIyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nQUZmjv7aHFLMaMFauN5kz/OKqGsuDJKsdlinZQqRbc=;
        fh=IxFPf/xNOkmclNDO4DAVu1HRKl0HHGVmAgBraRB6o68=;
        b=IFZ6S3jKTAcky57O+15yvpMC/8M/O9fv9aKsybgs8SfoQfusvmllhvsSvnGAHnO1N4
         ZaWRaaBbilOqWSoQqgQqqY48fEAhE3dtlQSwTrM295gxATXNjx0BG0J2np7lFqbaNoyH
         HjUHnCsdzAqFGpQXM3iOkVyrB5AATMpW+KtWp/B6wY3kK9gsscKaZsgViUcQCgZYQial
         eVvGd3zN5Yx0yLaRY9kFCmmGACPaOn7MFUdxPe2xJGRAN3Jv8SJu5y8ahkVlDznctNQ6
         S4sOC84IvMKdciXaAmiptV6GfQw/o23JZyRA2DykWjzdeBVyUNaTK+nbzyAs9APVQHxV
         qonA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778004098; x=1778608898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQUZmjv7aHFLMaMFauN5kz/OKqGsuDJKsdlinZQqRbc=;
        b=R2iPwoLriEdbZIs7QFPcadX0XQOBNAqZKPkb4cQSOmgsII66gC+kw1VRegDRBgGNFx
         aHMgHpysJVtd92bEhROI60a5BN9PlmRal06adw60CmQFseJtTC0RUh7H+/k4tHmr274B
         e9kAAe4deDTS1ByYbJsS/kaRewxd0esQW/FRv/341oaB1D90YQ+7co57XQLf4JYfgFa/
         GuhtEbdiRngj2NpfWlswK6AloDZShpfWaM5YCRRZGlIbUBjBA1BYpk/D7ude5Jsek3tk
         GQsyc5FlbDqcM3e51HpktYcyapenoZF9WqlUIFKU0xnBWWwY0FxnS0yS7PaEuXO2Cqab
         ALqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778004098; x=1778608898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nQUZmjv7aHFLMaMFauN5kz/OKqGsuDJKsdlinZQqRbc=;
        b=gBr7AF1ly6NBs+GVjcPY3xeTXpdfy6bK9ZMBWGN/wPw25rZebUAKPqL7G/WqK7UCr3
         pr0khpScsixT65OkSIFtYAoY4wX+pI71RFLNB/Y/fA6ixZsTdoRPuIfj20wiBaJenx+E
         aggjOidQaI4HQ2bLl5wSjY5o+FhgeByhAj62E8j9dsaHiFesD5fKfRHvJHX3/kNs6DZZ
         4InlL9Sk/ya1ACKy4n4szmNBPvpOZWGDjG+jMHt0IfYGw4BwIdEnCRvgv56avnJZ7PLi
         kPgiMsiYPySBOpQVj9G2Nu2JPfapfqfx596TiF1kr5usYIczRZBNyZ9V+0qZGuhQVMS+
         vxVQ==
X-Forwarded-Encrypted: i=1; AFNElJ985VAPPuVAaHqgwRSAptoJDOKF2JgLxYja24VS5mLHyaPbypDnsrs8ePCa71TtY1/6QiNLrEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSG6nwh0TZhqQi55ri81G/WqY0kYFFTfRdw7AMF1/lOxLosKnZ
	o4D/lDqV/nbi60uFG0Is09D7GODnvPIMiLgJ20jplM8CJ7vP52TgoggVD/Q8OZe4GifpJYcJuhQ
	K1f095ulBEYOQxC0I5HyEPsPvWhYv5qyBdsMMSSeY
X-Gm-Gg: AeBDievDHnUr3oTN1TAD8xfn4/emuFGj33xsRjXHUz4r9v2t1OcBtp5B40qzkR1563a
	jVU6mQLyf42rOQtpjgKYWij6358iTF6VOVAbq5IEO/XoWoRltsLPFG88ZeKu1NScgqWbGJyK9z0
	5Nves2vh9wS3tp/VR580jASqsz5JczThLnEmuDUy0wVRYKDnqcANa2hsJmnWGMZL/UGQlxbdZby
	cWn1fCG9ySdjAMTXF+dYXRemibpepKw3YpYd96C6FIj9hmXgeVRTdVErKgLMkv5H2ljy3UKoTT5
	+W0oOvc6r/srYzVcAS4iCgwvkpUyBsqv4zxhzgixhfRNmeR+TYdXczlmfwdwMpTp69SZFnSAGsu
	bV5CbJHD+8CF1H1YJoPIS2bLRjQ==
X-Received: by 2002:a17:906:9f87:b0:ba7:cc67:488b with SMTP id
 a640c23a62f3a-bbffab33111mr887380266b.5.1778004097049; Tue, 05 May 2026
 11:01:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504224213.1049426-2-jthoughton@google.com>
 <20260504231048.1184273-1-jthoughton@google.com> <afohshVlK9YcBk-f@google.com>
In-Reply-To: <afohshVlK9YcBk-f@google.com>
From: James Houghton <jthoughton@google.com>
Date: Tue, 5 May 2026 11:01:00 -0700
X-Gm-Features: AVHnY4J0Tr074uKX9gnTkNPmv46TNeS2NEyt9u-k5f94BeNvCS-2m8Zf89eFVRE
Message-ID: <CADrL8HX223b3YS8aHr7b=AZZ2J5ga+-SwLQX9Rs9Ep=rMM5wUA@mail.gmail.com>
Subject: Re: [PATCH 1/5] KVM: arm64: Grab KVM MMU write lock in kvm_arch_flush_shadow_all()
To: Sean Christopherson <seanjc@google.com>
Cc: chenhuacai@kernel.org, gshan@redhat.com, jhogan@kernel.org, 
	joey.gouly@arm.com, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, loongarch@lists.linux.dev, maobibo@loongson.cn, 
	maz@kernel.org, oupton@kernel.org, pbonzini@redhat.com, ricarkol@google.com, 
	shahuang@redhat.com, stable@vger.kernel.org, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, zhaotianrui@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D87F54D2731
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244250-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jthoughton@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

On Tue, May 5, 2026 at 10:05=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Mon, May 04, 2026, James Houghton wrote:
> > On Mon, May 4, 2026 at 3:42=E2=80=AFPM James Houghton <jthoughton@googl=
e.com> wrote:
> > >
> > > kvm_arch_flush_shadow_all() may sometimes be called on the same `kvm`
> > > concurrently in the event that the KVM's `mm` is __mmput() at the
> > > same time that last reference to the KVM is being dropped.
> > >
> > > T1              T2
> > > KVM_CREATE_VM
> > >                 Get VM file from T1
> > > close VM
> > > exit_mm()       close VM
> > >
> > > T1: exit_mm() -> kvm_mmu_notifier_release() -> kvm_flush_shadow_all()=
,
> > >     with only the KVM srcu read lock held.
> > >
> > > T2: kvm_vm_release() ---> mmu_notifier_unregister() ->
> > >     kvm_mmu_notifier_release() -> kvm_flush_shadow_all(),
> > >     again, with only the KVM srcu read lock held.
> > >
> > > This leads to a potential double-free of
> > > kvm->arch.kvm_mmu_free_memory_cache and now with NV
> > > kvm->arch.nested_mmus.
>
> ...
>
> > >  void kvm_uninit_stage2_mmu(struct kvm *kvm)
> > >  {
> > > -       kvm_free_stage2_pgd(&kvm->arch.mmu);
> > > +       lockdep_assert_held_write(&kvm->mmu_lock);
> >
> > *facepalm*.... this doesn't account for the other callers of
> > kvm_uninit_stage2_mmu(). They will get lockdep warnings.
> >
> > I've attached a diff to the bottom of this reply that *does* deal with =
them.
> > :( Sorry.
>
> ...
>
> > > diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
> > > index 883b6c1008fb..977598bff5e6 100644
> > > --- a/arch/arm64/kvm/nested.c
> > > +++ b/arch/arm64/kvm/nested.c
> > > @@ -1190,11 +1190,13 @@ void kvm_arch_flush_shadow_all(struct kvm *kv=
m)
> > >  {
> > >         int i;
> > >
> > > +       guard(write_lock)(&kvm->mmu_lock);
> > > +
> > >         for (i =3D 0; i < kvm->arch.nested_mmus_size; i++) {
> > >                 struct kvm_s2_mmu *mmu =3D &kvm->arch.nested_mmus[i];
> > >
> > >                 if (!WARN_ON(atomic_read(&mmu->refcnt)))
> > > -                       kvm_free_stage2_pgd(mmu);
> > > +                       kvm_free_stage2_pgd_locked(mmu);
> > >         }
> > >         kvfree(kvm->arch.nested_mmus);
> > >         kvm->arch.nested_mmus =3D NULL;
> > > --
> > > 2.54.0.545.g6539524ca2-goog
> >
> > And here is the diff that should fix this patch. (Sorry!!)
>
> There are more issues.  kvm->arch.mmu.split_page_cache can be freed by
> kvm_arch_commit_memory_region(), which holds slots_lock and slots_arch_lo=
ck,
> but not mmu_lock.

Thanks. I also noticed that kvm->arch.mmu.split_page_cache is
documented as being protected by kvm->slots_lock; we should be holding
it here. But we cannot take it here because we are already holding the
KVM srcu lock.

> IMO, the handling of kvm->arch.mmu.split_page_cache should be reworked.  =
I don't
> entirely get the motivation for aggressively freeing the cache.  The cach=
e will
> only be filled if KVM actually does eager page splitting, so it's not lik=
e KVM is
> burning pages for setups that will never use the cache.
>
> Maybe I'm underestimating how many pages arm64 needs in the worst case sc=
enario?
> (I can't follow the math, too many macros).  But if KVM is configuring th=
e cache
> with a capacity that's _so_ high that the "wasted" memory is problematic,=
 then we
> probably should we revisit the capacity and algorithm.  E.g. if KVM is sp=
litting
> from 1GiB =3D> 4KiB in a single pass (I can't tell if KVM does this on ar=
m64), then
> we could break that into a 1GiB =3D> 2MiB =3D> 4KiB sequence.

I'm not sure I've fully understood the point you're making, but I
*think* we can just drop the
    kvm_mmu_free_memory_cache(&kvm->arch.mmu.split_page_cache);
line from kvm_uninit_stage2_mmu(). It will get freed when the VM is
destroyed anyway.

So I'm thinking of splitting this patch into two (unless someone tells
me otherwise):

1. Drop the kvm_mmu_free_memory_cache() from kvm_uninit_stage2_mmu()
    Fixes: e7bf7a490c68 ("KVM: arm64: Split huge pages when dirty
logging is enabled")

2. Grab the MMU write lock around the kvfree(nested_mmus) bit in
kvm_arch_flush_shadow_all(); do the kvfree() without holding the the
lock.
    Fixes: 4f128f8e1aaac ("KVM: arm64: nv: Support multiple nested
Stage-2 mmu structures")

