Return-Path: <stable+bounces-244216-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HBQJu4j+mnyKAMAu9opvQ
	(envelope-from <stable+bounces-244216-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:07:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DBC4D1C9A
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 074703037988
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 17:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C6E49251B;
	Tue,  5 May 2026 17:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IZprpnhB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F92C353EF3
	for <stable@vger.kernel.org>; Tue,  5 May 2026 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778000719; cv=none; b=BHH/HW2C5lpX3gHY1yJfM0PlNdRpW4c83M4coV6Pw8aLT+no9jjqfpJsqlWz/are4vFvSzeVmRhccotcUEBi3Km5NbTwW7ximqUBTpUmQPrOojL+kBEa/71tDhuerjXZmsDKYekXVVhLGoclUKevGBah+X25fB9dBx+gAHQaZ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778000719; c=relaxed/simple;
	bh=LlXGiT8km7O3+s8Me6WlqDhDtU9jqmDQ3ztOup/45zg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DFX9pr8g0d1kCpkE/bKqBeVzno3Xtojm0c13BX3lj60XhTWDS9MUPK/X3N1LUUk6S2A7MEhay60vuRpqsMXYrSgd/tafSRn39U/tnNE+6rOj0lX7+jhOGFYiS2itPYRBSw4Kpfup9vfREweMN7+WqDg0Vc9m77H2mZLjgk+/qZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IZprpnhB; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fa860e71eso2770937b3a.0
        for <stable@vger.kernel.org>; Tue, 05 May 2026 10:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778000718; x=1778605518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m3ZWo/jJEgMHbppCM8fWNjqKfThN79PtinobDbAzSRU=;
        b=IZprpnhB9X68uMgUxPxRTXuDWc3tdD8mYIGb7kcYbYlOGJNZ7d0CfkvMhFt1IShm3p
         dGZNfQs9VxrIF1dllB0raZNrzPI4QgmVZTbRP5wwqhn3S6KkFUQR6zobH1QqA1Ta6dqU
         B6lHVU0e8q3iyzn1OYcX1Um8WVID54YspuNo6l+jiUPrkiir1P9qQFb2NqUQq1c19kVb
         5cjEyGdu6x4MzrQDs8No7cz2E/gCILM3WnmmI0PhKKb9S+BRrWlSbsDd8Z0UxXbK6Ebw
         p4EowGc6KpC1EK8lfzMioMAso4BZefAEkNormaQU67h/173fs2FU164LevzYYZKol+59
         I7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778000718; x=1778605518;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m3ZWo/jJEgMHbppCM8fWNjqKfThN79PtinobDbAzSRU=;
        b=WNkTPKm3AF4a0Pb6PXM/JC7JS3mhSXNsPFKE98RvwP2PDbCOZOWcAJbVMuRusXxUrI
         MX07HbMt5lMHkNNfJUnvAN6aIpYvzJ+gEYZIAda9nyKSQNJGTV4Eirz7O44ftLEwqQPg
         wr537sjcCKL1TbQvf91iWkl1ZI11wvRybUfbe3/pg2Y04tyixxSL7lUkdOChdC63Tk2G
         J5uSuCRBPRh41fqhmL+GPjJfC6q6EIwhQOZrtINWvDtGerXAfUgzTNiMfM+doCI7zS0g
         6Rf4GZDOMdvKJ50ljj0tOkeKAHhDrpYICNmKZttN74IMlmFDYIH4qCyuOCSXWvLJciu+
         9AXA==
X-Forwarded-Encrypted: i=1; AFNElJ8xlM7TEXYRCp7Q/xUYvLzrnlUvxI/b0+NQIylpHh6DbK7vRnKIEWVVJjrTkS3caX0WqUAoPjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwffKb4g7Nx5FWGLCMxjSkafikVmcHwI/htk60DfnlNd1TGAYWn
	NyTszGwTjnBHw+1I5W5t0DymDSlSSD0D48+YG9KGKMtUelxqQud7oI48J2O3XIgEXDW6H2puPDu
	QUAzJbg==
X-Received: from pfblm11.prod.google.com ([2002:a05:6a00:3c8b:b0:82c:e899:f089])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:368c:b0:82c:e1a3:986f
 with SMTP id d2e1a72fcca58-839247bfb7bmr3652379b3a.43.1778000717292; Tue, 05
 May 2026 10:05:17 -0700 (PDT)
Date: Tue, 5 May 2026 10:05:15 -0700
In-Reply-To: <20260504231048.1184273-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504224213.1049426-2-jthoughton@google.com> <20260504231048.1184273-1-jthoughton@google.com>
Message-ID: <afohshVlK9YcBk-f@google.com>
Subject: Re: [PATCH 1/5] KVM: arm64: Grab KVM MMU write lock in kvm_arch_flush_shadow_all()
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: chenhuacai@kernel.org, gshan@redhat.com, jhogan@kernel.org, 
	joey.gouly@arm.com, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, loongarch@lists.linux.dev, maobibo@loongson.cn, 
	maz@kernel.org, oupton@kernel.org, pbonzini@redhat.com, ricarkol@google.com, 
	shahuang@redhat.com, stable@vger.kernel.org, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, zhaotianrui@loongson.cn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 38DBC4D1C9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244216-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, May 04, 2026, James Houghton wrote:
> On Mon, May 4, 2026 at 3:42=E2=80=AFPM James Houghton <jthoughton@google.=
com> wrote:
> >
> > kvm_arch_flush_shadow_all() may sometimes be called on the same `kvm`
> > concurrently in the event that the KVM's `mm` is __mmput() at the
> > same time that last reference to the KVM is being dropped.
> >
> > T1              T2
> > KVM_CREATE_VM
> >                 Get VM file from T1
> > close VM
> > exit_mm()       close VM
> >
> > T1: exit_mm() -> kvm_mmu_notifier_release() -> kvm_flush_shadow_all(),
> >     with only the KVM srcu read lock held.
> >
> > T2: kvm_vm_release() ---> mmu_notifier_unregister() ->
> >     kvm_mmu_notifier_release() -> kvm_flush_shadow_all(),
> >     again, with only the KVM srcu read lock held.
> >
> > This leads to a potential double-free of
> > kvm->arch.kvm_mmu_free_memory_cache and now with NV
> > kvm->arch.nested_mmus.

...

> >  void kvm_uninit_stage2_mmu(struct kvm *kvm)
> >  {
> > -       kvm_free_stage2_pgd(&kvm->arch.mmu);
> > +       lockdep_assert_held_write(&kvm->mmu_lock);
>=20
> *facepalm*.... this doesn't account for the other callers of
> kvm_uninit_stage2_mmu(). They will get lockdep warnings.
>=20
> I've attached a diff to the bottom of this reply that *does* deal with th=
em.
> :( Sorry.

...

> > diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
> > index 883b6c1008fb..977598bff5e6 100644
> > --- a/arch/arm64/kvm/nested.c
> > +++ b/arch/arm64/kvm/nested.c
> > @@ -1190,11 +1190,13 @@ void kvm_arch_flush_shadow_all(struct kvm *kvm)
> >  {
> >         int i;
> >
> > +       guard(write_lock)(&kvm->mmu_lock);
> > +
> >         for (i =3D 0; i < kvm->arch.nested_mmus_size; i++) {
> >                 struct kvm_s2_mmu *mmu =3D &kvm->arch.nested_mmus[i];
> >
> >                 if (!WARN_ON(atomic_read(&mmu->refcnt)))
> > -                       kvm_free_stage2_pgd(mmu);
> > +                       kvm_free_stage2_pgd_locked(mmu);
> >         }
> >         kvfree(kvm->arch.nested_mmus);
> >         kvm->arch.nested_mmus =3D NULL;
> > --
> > 2.54.0.545.g6539524ca2-goog
>=20
> And here is the diff that should fix this patch. (Sorry!!)

There are more issues.  kvm->arch.mmu.split_page_cache can be freed by
kvm_arch_commit_memory_region(), which holds slots_lock and slots_arch_lock=
,
but not mmu_lock.

IMO, the handling of kvm->arch.mmu.split_page_cache should be reworked.  I =
don't
entirely get the motivation for aggressively freeing the cache.  The cache =
will
only be filled if KVM actually does eager page splitting, so it's not like =
KVM is
burning pages for setups that will never use the cache.

Maybe I'm underestimating how many pages arm64 needs in the worst case scen=
ario?
(I can't follow the math, too many macros).  But if KVM is configuring the =
cache
with a capacity that's _so_ high that the "wasted" memory is problematic, t=
hen we
probably should we revisit the capacity and algorithm.  E.g. if KVM is spli=
tting
from 1GiB =3D> 4KiB in a single pass (I can't tell if KVM does this on arm6=
4), then
we could break that into a 1GiB =3D> 2MiB =3D> 4KiB sequence.

