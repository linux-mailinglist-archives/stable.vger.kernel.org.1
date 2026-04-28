Return-Path: <stable+bounces-241682-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OG6IElHH8GkqYgEAu9opvQ
	(envelope-from <stable+bounces-241682-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 16:42:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BE748731A
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 16:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E35CB3019076
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 14:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0F138AC9C;
	Tue, 28 Apr 2026 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RsIfGnk0"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1BE38B15F
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777387050; cv=pass; b=ZmlKGseo80ahdB55uD/8n2OwK/29mdLymWEoSyxB13PZ2eEVI6aGUzIL+0pcuIKjq11YK3G/KDjc6VUkWfNbDVmQLcJoFxGDP9Ou8zwCLcXBTrdearkRmggYY0TIqVCe+pEHbryj5NChx6RXSWHt28wARYPzwdY/mNsX4MZIyfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777387050; c=relaxed/simple;
	bh=SQvI3MhcbO6vWHO1VLcGP7Zz8yqLhVBcHIlEieBeTOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EH4fph/IXaAwNr8Q/KVc7JuBS8TwkVDQqMfEhfits0/l3coqxKM5v1dVf4FgyMMKRdeTFcmWxQlQ9BdQQZIxhwEoPcd8OY+0tlC+zzXVc3CZOjBwk13w3oAoj4N98dzvF6237yyWPxobt+p5pUvHlb776m1G5Xu0+1ELybu4Rco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RsIfGnk0; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50e61648f10so671811cf.1
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 07:37:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777387048; cv=none;
        d=google.com; s=arc-20240605;
        b=alg8AvGrWObp2VtSE/SfQU+5Lf7SElfAonavlWqchvSQktBKTLS6L0Pv+0yNYcvat7
         tZ6u/n7enMP+kQruNQDcTq10BUlzoBf/1svMeXdggwQ0kQKsWcY6UPYIvmvKyHHTUCfK
         x/PdeE82Lzpx6D/+7JwPZNBpZT112/TMikznKZUasihFQMl8X2Y77YDrlhuenLNueCU5
         FqUEGH7ud8tTPEPan43Q/hR7SoAqYfXBxrQ62RMhWsdQTO063sooln5hr6PJpTDLkWc1
         aJUha3/qR1eqORb5gsRWWDSGzqQWhasZDQwkwcJzXWoaerAs/ns8zzYNEFJbwmC5/tMp
         Z0hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6dapWbfdaH3qRNQs2tgvGaffgEEHsGjHti7EKce5ja8=;
        fh=hH0oLK4rjnX4UhmpR+ZytcNAXyxJAibXk0A08PIroTM=;
        b=d9tgyHrmRMVcq50g4PkKt+hAeEubAWiFLPKdNE7zxi+6MAsV2IwVgqh4p9Sekwjug3
         atWE/fr3+/3Lqd1rUzXYRL/WuaqoZU2rsX20je/fIshdsayW0Fb78lWECbxAKIln2J6R
         P4aNxVfDyh0c9R1kExfDtDx2hHBS7kPn1HHlNZO6+5izZyJg9sD8SFS909GqQs1h0xl2
         tpInsxaguh67pebTmoOPMhW+CI3EH8Bh4DY9uzCnrDuHe0CeFtWJFe/Gp9pHGNhr5onM
         L0XFjGSIszatod3J+Ii/aNHTINlVDdZvUDPu2dkhVgyI088pgJb7XOu+Z/2wlOms12Vl
         Y9Jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777387048; x=1777991848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dapWbfdaH3qRNQs2tgvGaffgEEHsGjHti7EKce5ja8=;
        b=RsIfGnk0rrsSJK3ytTD43U8f9x0Oypk+2Zw+YTQRHfqNUO9P19AzaTNNwu6lnlPxZC
         Hp06t4bWuhWvfyfprxxhnZngTE+XZgIzYXAxgNu1im8+B42E52tp6KgJxqL3KV9F8DpY
         d+KoSb0hTWv9k1vBq406j1UrS9U7snMZo2wkIbtefxD/z7J3T++HKRrC8RGbWVOIplMj
         2fp0C4LOjyPH2hSGbW/+6u+lZ9Rhr5rk/DjUa1NJY4zcSH+XSRpgr2XPLrioHIZcFWUM
         6stwPF6vH1HlC2BXmyALtM9y5Vl1H4y0b22EFVMZk7u/iu2wA9M90y7KDLTGCRsDtP8k
         aZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777387048; x=1777991848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6dapWbfdaH3qRNQs2tgvGaffgEEHsGjHti7EKce5ja8=;
        b=DGUwE9iA0UlAP90HJDMsaTHuN0T42mJHpi0T1n9UWpKNkvWhqSbMDziG4c2fb64IUu
         UT3i2N4SLAVFhIb18NvzJyPvT52QQRD3PNN20FXsK3oaEwIrrWC9mzsQ8j+Ty+z0yLP9
         F1xJeosilgy7Q3jiZj52BtZyhvwr/oU0Qyvd0D+zszZCOZHwqM6RYknLUyDDpnZD7qY5
         kRVtzeYCdYts3ozu0SkIr2NM2gEvD1FVfxIUVVWtOspbfz2Cvufq5mLQ5ICDOognRI5O
         ExVLfL9IwsvbLWvraE3qC6vwxRxrPxqiqUVsOjLnN1xPoQ6Rrd4NxZi7kbyPdFbltbSG
         33Bw==
X-Forwarded-Encrypted: i=1; AFNElJ8LXdJsl+7Q1kaI0Xu0wVlT6+AjV7G+MTA2Z8/L4UI7MeMwRYfD5wNQ7NxG+DNDnGszInAWlCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk1sjWSdGP0mGrxOZc04YUJ7c7Oe8r0qWl6v3la/viAIcEILkQ
	rkixdstz6r9FWATl+gWridpR/1jBmg0gi0Oa/hdD0UNcxcQB0KmgV7c/PZolzemQmeJGHC2TGNg
	Ofa9OrRJu6/szjcuCaQfNaBMNTdnMVcw1CDMxtS59
X-Gm-Gg: AeBDietFdH2LM32XHbHrjo31VW30j8xuw5xRQGCHcYj8YMleF7xatSl2mfy9WfEu3/J
	g+TmM2ZRj7mV1n9WQRm+SDseLoC1X5d9gXZCWApnoqrZj4j4xHABAgif+CN9KUBuObww2CBsORo
	nYcMr20dw2rMArrtQrWWW12b0YvNlFysCBMUATxm/VmpKkEbdQA8SreNL//pYg2ofeP3QCf6DDJ
	B6STkly/wNisstQhSnEN9IIcbXawdgc7jXSKVKDi4ZqRGJZuUlPOgiE+DPRhAb+YsgT80Bt6Iqg
	znOtO+WzHG54AZHRsCfIhzQdGP68U3zii6qJvr8JnUwdometlu7yIHUmWRUqNuY=
X-Received: by 2002:ac8:5d52:0:b0:509:174d:3224 with SMTP id
 d75a77b69052e-5100ddadccdmr13763831cf.11.1777387040604; Tue, 28 Apr 2026
 07:37:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428103008.696141-1-tabba@google.com> <20260428103008.696141-7-tabba@google.com>
 <afC5_jrTEVRfJ77x@willie-the-truck>
In-Reply-To: <afC5_jrTEVRfJ77x@willie-the-truck>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 28 Apr 2026 15:36:43 +0100
X-Gm-Features: AVHnY4KUvLQVQvqOYoHKFrGRxCQZYRY1ccfXZN-JSVf8ghDHejXfq6Fa9ThLlXs
Message-ID: <CA+EHjTyTy2qLm=CbOOYR6rmjg5tH38PifAV+qAhbZxidY5szxQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] KVM: arm64: Propagate stage-2 map failure on
 host->guest donation
To: Will Deacon <will@kernel.org>
Cc: maz@kernel.org, oliver.upton@linux.dev, james.morse@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, qperret@google.com, 
	vdonnefort@google.com, catalin.marinas@arm.com, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C3BE748731A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241682-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tabba@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi Will,

On Tue, 28 Apr 2026 at 14:45, Will Deacon <will@kernel.org> wrote:
>
> On Tue, Apr 28, 2026 at 11:30:06AM +0100, Fuad Tabba wrote:
> > __pkvm_host_donate_guest() flips the host stage-2 PTE for the donated
> > page to a non-valid annotation (KVM_HOST_INVALID_PTE_TYPE_DONATION,
> > owner =3D PKVM_ID_GUEST) via host_stage2_set_owner_metadata_locked()
> > and then calls kvm_pgtable_stage2_map() to install the matching guest
> > stage-2 mapping. The map's return value was wrapped in WARN_ON() and
> > otherwise discarded.
> >
> > At EL2 in nVHE/pKVM, WARN_ON() is not warn-and-continue: it expands
> > to a BRK that enters the invalid-host-el2 vector and branches to
> > hyp_panic(), declared __noreturn. WARN_ON of a reachable failure at
> > EL2 is a panic primitive, not a debug aid.
> >
> > kvm_pgtable_stage2_map() can fail in reachable ways even at PAGE_SIZE
> > granularity: __pkvm_host_donate_guest() verifies PKVM_NOPAGE for the
> > guest IPA before the map, meaning no valid stage-2 entry exists. The
> > walker must allocate new page-table pages from the vcpu memcache to
> > install the mapping, returning -ENOMEM if exhausted. The host
> > controls the vcpu memcache via the topup interface, so an
> > under-provisioned donation request converts a recoverable error into
> > a fatal hyp panic.
> >
> > Capture the stage-2 map return value and propagate it. The walker
> > may have installed partial leaf entries for the IPA before failing,
> > so unmap the range to clear them; otherwise the guest would retain
> > stage-2 access to a page the host is about to reclaim as
> > PKVM_PAGE_OWNED. Then roll back the host stage-2 mutation: the only
> > forward mutation is host_stage2_set_owner_metadata_locked() flipping
> > the host vmemmap from PKVM_PAGE_OWNED to PKVM_NOPAGE and the host
> > stage-2 PTE from idmap to invalid+annotation.
> > host_stage2_set_owner_locked(_, _, PKVM_ID_HOST) restores both.
> >
> > The rollback calls host_stage2_set_owner_locked() under WARN_ON.
> > This is the correct use: host_stage2_set_owner_metadata_locked()
> > just wrote the host leaf PTE as an invalid+annotation entry, so the
> > reverse idmap rewrite cannot require new page-table allocation =E2=80=
=94 it
> > rewrites the leaf in-place. The WARN_ON asserts an impossible state
> > under correct EL2 execution, semantically distinct from the misuse
> > being fixed.
> >
> > Fixes: 1e579adca177 ("KVM: arm64: Introduce __pkvm_host_donate_guest()"=
)
> > Signed-off-by: Fuad Tabba <tabba@google.com>
> > ---
> >  arch/arm64/kvm/hyp/nvhe/mem_protect.c | 27 ++++++++++++++++++++++++---
> >  1 file changed, 24 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp=
/nvhe/mem_protect.c
> > index 7044913a0758..b8c57a95e9bf 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > @@ -1391,9 +1391,30 @@ int __pkvm_host_donate_guest(u64 pfn, u64 gfn, s=
truct pkvm_hyp_vcpu *vcpu)
> >       meta =3D host_stage2_encode_gfn_meta(vm, gfn);
> >       WARN_ON(host_stage2_set_owner_metadata_locked(phys, PAGE_SIZE,
> >                                                     PKVM_ID_GUEST, meta=
));
> > -     WARN_ON(kvm_pgtable_stage2_map(&vm->pgt, ipa, PAGE_SIZE, phys,
> > -                                    pkvm_mkstate(KVM_PGTABLE_PROT_RWX,=
 PKVM_PAGE_OWNED),
> > -                                    &vcpu->vcpu.arch.pkvm_memcache, 0)=
);
> > +     ret =3D kvm_pgtable_stage2_map(&vm->pgt, ipa, PAGE_SIZE, phys,
> > +                                  pkvm_mkstate(KVM_PGTABLE_PROT_RWX, P=
KVM_PAGE_OWNED),
> > +                                  &vcpu->vcpu.arch.pkvm_memcache, 0);
> > +     if (ret) {
> > +             /*
> > +              * Stage-2 map can fail mid-walk (e.g. -ENOMEM from the
> > +              * memcache), leaving partial leaf entries installed in t=
he
> > +              * guest stage-2. Tear them down before rolling back the =
host
> > +              * stage-2; otherwise the guest would retain access to a =
page
> > +              * the host is about to reclaim as PKVM_PAGE_OWNED.
> > +              */
> > +             kvm_pgtable_stage2_unmap(&vm->pgt, ipa, PAGE_SIZE);
>
> Whoa, whoa, whoa.
>
> First of all, this is mapping a single page, so the comment talking about
> "leaf entries" (plural) is bogus. If an operation to map a single page
> fails, then it makes no sense to try unmapping the mapping which we
> failed to create. What do you expect it to do?
>
> On the other hand, if we extend this to handle ranges in future (which
> presumably we'll want as part of the THP support) then wouldn't this
> mean that a concurrent vCPU could have transiently written to the pages
> that _did_ get mapped, and now we're going to give those back to the
> host? That's really not ok! We're relying on these WARN_ON()s being
> fatal and they shouldn't fail because we perform all the permission
> checks first, in a separate pass.
>
> If you want to improve this, then I think the options are either:
>
>   1. Check that the the memcache is topped up first
>   2. Poison the page (similar to the forced-reclaim path)
>   3. Tell the host about the pages it's lost and maybe it can leak them
>
> (I vote for (1))
>
> But we absolutely cannot do the simple rollback for the ownership
> changes; that's why the code is written to do the checks up-front. Your
> other patches at the end of this series have different flavours of the
> same issue.
>
> If it's just about keeping the LLM happy, then either fix the LLM or
> make these BUG_ON() (in conjunction with (1) above).

You're right, and no, it's not just about keeping em happy :D

The "leaf entries" comment on the single-page donate path is wrong, and
more importantly the rollback model is unsound. The right fix is to tighten
the precondition, not to handle a failure that shouldn't be reachable.

V2 will drop two patches (in addition to the HCR_EL2 one), and will be
as follows:

1. host->guest share and host->guest donate (kept, rewritten): add a
   memcache-sufficiency check during the existing pre-check pass
   (option 1) and return -ENOMEM cleanly without touching any state.
   Restore the WARN_ON() on the subsequent kvm_pgtable_stage2_map() =E2=80=
=94
   with the topup precheck it asserts an established invariant rather
   than ignoring a reachable error.

   For the single-page donate, "topped up" is
   KVM_PGTABLE_LAST_LEVEL - vm->pgt.start_level (mirroring host EL1's
   kvm_mmu_cache_min_pages). For multi-page share I plan to use the
   conservative nr_pages * (LAST_LEVEL - start_level) bound and flag it
   as conservative in the commit message; happy to compute a tighter
   alignment-aware bound if you'd prefer.

2. guest->host share and guest->host unshare (dropped): on reflection
   these shouldn't have been in V1 at all. As I did note in the commit
   message, failure path is not reachable. Again, too eager to make
   use of the new prompts.

I'll repost this as V2 if you agree.

Cheers,
/fuad

>
> Will

