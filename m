Return-Path: <stable+bounces-217680-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kADpFxFnm2nEzAMAu9opvQ
	(envelope-from <stable+bounces-217680-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 21:29:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 755A81704DA
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 21:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D3D3300B560
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 20:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18473590C3;
	Sun, 22 Feb 2026 20:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D3kiuw89"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614323563E9
	for <stable@vger.kernel.org>; Sun, 22 Feb 2026 20:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771792139; cv=pass; b=jQ9hUZwfVo5NnOqaV5N7nAloogh7M891vTvFZH3BT5vJqgzUgH+nu5gGWdYPUZ6nUtV7aanM0qFonKtUHmOxnRtdp1eyjXGR4giDVDXu/acVyhjIZGjH/8eOofgKfoW7S53fYlgL6OZ7CkVbJF8nJMKyt1izK9OSVa3nleWqqdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771792139; c=relaxed/simple;
	bh=yjt+fj5rpYQBXgVHixsScjBAGfbqYqJIprbU4BqHtNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pMf3tYGEwngGP++2Y3yKKTNZjoDUnzsl5gRsT5DgVUW6dzf5FfmM8tQWWOyRZAmVN/LJoJMdC3NucqwmUmlkqD/KWKNZ/sGOgXSikEKmXxxaaJgyMIEjn5pSUnuT0BnJ2vOLM3iKwuYLPWBxBwzSV/ufokM8v5Zcz6SGqffNnnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D3kiuw89; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5033b64256dso715771cf.0
        for <stable@vger.kernel.org>; Sun, 22 Feb 2026 12:28:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771792137; cv=none;
        d=google.com; s=arc-20240605;
        b=aXYmlicpPmeyozCI6+33Xsu5pxPWk2sqsjoKFfYcOnKP6Hag3LkL+JV0xgt2PjYWve
         pRg60qwXvUn16M6BwlcCb9x5jEFLJ5zj5/7a3rC+yXFdOGzVedGUPEJBr+oqdEJJkV66
         ohHzivtwLQO37zfIGhwJDTY6ndw4PhO5srfWNdNb2jrDBmBEYC61LyLAjybcidob+8YU
         AyvsQFlzpLyaEXaXlpgtYjCCgoOvXlbshT1znxnkt9/HYvKdKP3qt2myZMmsRMXSyE5u
         DMkUv1gcYRvk3q04DY6QOcdXJsOi13XAtucw48JD4SVuktDeKBJYB3nuz3SyurJCCUGu
         CuQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=F2/zSsN0ZphntQc+eR+dJyrmvjXaa4Ou1pt58IXRg+A=;
        fh=pnPjticfK1C2eOYm9mFORoR/TjM2yetx14EJz8VCNV4=;
        b=RMqApuzWhHAv6yArS8aKCV2FBLFNPuHtNbT5AkFsqKXAYMH5SSpGuWNqHqO4Mo4U5Y
         lCvqBDHwCDDJbvZ+fgdf36xbfOi1ko8uJMzL4C6CXwkxPHuJp9g9x8Ijx+5wpQNcYz/y
         r2q9py4EiNxylp8QrNYco9chaYzdikz+qktLCxq9ALjNepvtSWLnm0bN0jD/V5putUnH
         KhuizmtVzq3lA282Evpy5fiO4icAaj9+GMliTK2RpjzlVB61P78ZyyJOAV+YWva80KVs
         yb8vtZcXfhiscJ3W3Z2esd/L8mflXMz09r/YSUx0QWf5dKkBlqH6m9XX6JueyQnu1L3L
         7G5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771792137; x=1772396937; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F2/zSsN0ZphntQc+eR+dJyrmvjXaa4Ou1pt58IXRg+A=;
        b=D3kiuw89fn0WsIuijRrXC5qj8nC1pi/3ZBSeJEyq9qwk0Nj6/UikuSC0MiwkemYYnn
         nwhDvB4czgF4D8MGqEzfr0c3rq3nv6LZoYOba4ay2M3ksZpChJ8AOsOsRupoJAq7DIla
         7z+Ls/GJsMteMmkP4yzWYd3ZYQCAMITIKHXWfyN50s5jrDRR8Y/q5TgdvcMBwzCrCxmB
         HGiEapRDJ+EFfk1A7m/a+NauFgwX01K+bB34SnWrfi3exesEvV9vX3x3ffUVuCF9IU7S
         hxqSt77Ws3Sp0ZNnXBgmdKXaXWcuFqHNSEWGdWBePc/mitzbF6HwzpA0KE3inRS/HSAu
         9dRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771792137; x=1772396937;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2/zSsN0ZphntQc+eR+dJyrmvjXaa4Ou1pt58IXRg+A=;
        b=UjGcAaO9OjhENUIUYp2M/gT4qaSID88cax51HnaQr0PQRPqPZmEKObOb+SF1R2BdIt
         cwKLJ5zH3BdrXE+dMLbqNNhRRS26Eoy7aoOXoNN/svAEO9Qr2EBI+Dnt7kHPHjPsgR5D
         TE1yBbdg97lXDTb1L1T6uxrkqAJCfnBBe899DxEcZ25AgmHoA1hS5sbVqtf4ffE6h58I
         EVwNN63vZ/d4EE/8thkHvhsB4GjdoLB/6LtMx/AWm/byMXVK/6CTwFYhLj1JG5e+7Kuz
         Za6Q2YVEOPGZiC3pIyEVJvCdxRoJfObdmQeeTPkauCgV/j7X6ZKiaxbiELmYYtOboIOH
         Ho+g==
X-Forwarded-Encrypted: i=1; AJvYcCWHCNOvwfX3Uf0zDqnxoMxl5UlXZ8+bxd0/03Sea16w0kC/U26VsXfTJ/eoAWzZi43IXW/DY9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWa9ejxlilstAYAIttenVUxQTbzRFlEhXiWU/1r0ts+DuarJKx
	E2ByGLRuJL9o/SgVpH4SIEKSct7mfnZRGMpEjYs3bm7iRpNFap1bm0N56q9gxXqpM2cx5+LeqYf
	r7T4f4jH9GWMQMGsf9BKeqLM3euQmLSmHdUD7hrhl
X-Gm-Gg: AZuq6aKDl5tDJPE062l4KUusl76LHudwfItYco6C+oMUqvFWtS8sjejOpz01komozOM
	z5M3u3T16cZ4z3eCYyACFwbhgGixp5Sk8k2/6LsS/G0p4d28EynOedqAsWJ1Fvyy+qZCmVESPYt
	K5w1phuu20432jWspmqu2Xc3355k5BIcXC95DXgFkJb5SBW5RXNO9c7waG4KXP5YcTHo5fgispL
	ULey4XflV8p2Wmb6NjDZE/3LTYagUXSunzJJaznXc66Km4jiDR2hqgAiUWd6sxL6Am6OoBngU8W
	0Sfc3Bo5
X-Received: by 2002:ac8:7dc1:0:b0:4f0:2e33:81aa with SMTP id
 d75a77b69052e-5070e893faemr12700351cf.11.1771792136883; Sun, 22 Feb 2026
 12:28:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260222141000.3084258-1-maz@kernel.org> <CA+EHjTy4p-Mbfr86NR9n1LgHC0EWrkdVjYb8O3z7k=Lv1entQg@mail.gmail.com>
 <878qckehh9.wl-maz@kernel.org>
In-Reply-To: <878qckehh9.wl-maz@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Sun, 22 Feb 2026 20:28:19 +0000
X-Gm-Features: AaiRm50cURl-e3Du3IJOwxV9NVX2guzIAipyh62nI0lRBrHVyFZMVoDigEP_TR8
Message-ID: <CA+EHjTxtFZU24rwh3zeiJjHgV2_g_HfJvMFJDC3WNKCLa58kaA@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: Fix protected mode handling of pages larger
 than 4kB
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Quentin Perret <qperret@google.com>, Will Deacon <will@kernel.org>, 
	Vincent Donnefort <vdonnefort@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217680-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tabba@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 755A81704DA
X-Rspamd-Action: no action

On Sun, 22 Feb 2026 at 18:55, Marc Zyngier <maz@kernel.org> wrote:
>
> Hi Fuad,
>
> On Sun, 22 Feb 2026 17:58:00 +0000,
> Fuad Tabba <tabba@google.com> wrote:
> >
> > Hi Marc,
> >
> > On Sun, 22 Feb 2026 at 14:10, Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > Since 3669ddd8fa8b5 ("KVM: arm64: Add a range to pkvm_mappings"),
> > > pKVM tracks the memory that has been mapped into a guest in a
> > > side data structure. Crucially, it uses it to find out whether
> > > a page has already been mapped, and therefore refuses to map it
> > > twice. So far, so good.
> > >
> > > However, this very patch completely breaks non-4kB page support,
> > > with guests being unable to boot. The most obvious symptom is that
> > > we take the same fault repeatedly, and not making forward progress.
> > > A quick investigation shows that this is because of the above
> > > rejection code.
> > >
> > > As it turns out, there are multiple issues at play:
> > >
> > > - while the HPFAR_EL2 register gives you the faulting IPA minus
> > >   the bottom 12 bits, it will still give you the extra bits that
> > >   are part of the page offset for anything larger than 4kB,
> > >   even for a level-3 mapping
> >
> > Matches the ARM ARM.
> >
> > > - pkvm_kvm_pgtable_stage2_map() assumes that the address passed
> > >   as a parameter is aligned to the size of the intended mapping
> >
> > nit: pkvm_kvm_pgtable_stage2_map() -> kvm_pgtable_stage2_map()
>
> Actually, that's pkvm_pgtable_stage2_map(). kvm_pgtable_stage2_map()
> itself isn't affected.

Right, I meant to remove the kvm, not the pkvm. It is indeed
pkvm_pgtable_stage2_map().

> >
> > > - the faulting address is only aligned for a non-page mapping
> > >
> > > When the planets are suitably aligned (pun intended), the guest
> > > faults a page by accessing it past the bottom 4kB, and extra bits
> > > get set in the HPFAR_EL2 register. If this results in a page mapping
> > > (which is likely with large granule sizes), nothing aligns it further
> > > down, and pkvm_mapping_iter_first() finds an intersection that
> > > doesn't really exist. We assume this is a spurious fault and return
> > > -EAGAIN. And again.
> > >
> > > This doesn't hit outside of the protected code, as the page table
> > > code always aligns the IPA down to a page boundary, hiding the issue
> > > for everyone else.
> > >
> > > Fix it by always forcing the alignment on vma_pagesize, irrespective
> > > of the value of vma_pagesize.
> > >
> > > Fixes: 3669ddd8fa8b5 ("KVM: arm64: Add a range to pkvm_mappings")
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > Cc: stable@vger.kernel.org
> > > ---
> > >  arch/arm64/kvm/mmu.c | 12 +++++-------
> > >  1 file changed, 5 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > > index 8c5d259810b2f..aa587f2e28264 100644
> > > --- a/arch/arm64/kvm/mmu.c
> > > +++ b/arch/arm64/kvm/mmu.c
> > > @@ -1753,14 +1753,12 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> > >         }
> > >
> > >         /*
> > > -        * Both the canonical IPA and fault IPA must be hugepage-aligned to
> > > -        * ensure we find the right PFN and lay down the mapping in the right
> > > -        * place.
> > > +        * Both the canonical IPA and fault IPA must be aligned to the
> > > +        * mapping size to ensure we find the right PFN and lay down the
> > > +        * mapping in the right place.
> > >          */
> > > -       if (vma_pagesize == PMD_SIZE || vma_pagesize == PUD_SIZE) {
> > > -               fault_ipa &= ~(vma_pagesize - 1);
> > > -               ipa &= ~(vma_pagesize - 1);
> > > -       }
> > > +       fault_ipa &= ~(vma_pagesize - 1);
> > > +       ipa &= ~(vma_pagesize - 1);
> >
> > nit: Since we're changing this code anyway, should we use the ALIGN
> > macros instead?
>
> That'd be ALIGN_DOWN() then, as ALIGN() really is ALIGN_UP(), and
> that'd be counter-productive.  Something like:
>
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index aa587f2e28264..3952415c4f83b 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1757,8 +1757,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>          * mapping size to ensure we find the right PFN and lay down the
>          * mapping in the right place.
>          */
> -       fault_ipa &= ~(vma_pagesize - 1);
> -       ipa &= ~(vma_pagesize - 1);
> +       fault_ipa = ALIGN_DOWN(fault_ipa, vma_pagesize);
> +       ipa = ALIGN_DOWN(ipa, vma_pagesize);

Yup, that's what I had in mind.

>         gfn = ipa >> PAGE_SHIFT;
>         mte_allowed = kvm_vma_mte_allowed(vma);
>
> > Reviewed-by: Fuad Tabba <tabba@google.com>
> >
> > and using 4, 16, and 64KB pages:
> >
> > Tested-by: Fuad Tabba <tabba@google.com>
>
> Ah, great! I couldn't be bothered with 64kB, and only used 16kB in NV
> to debug quickly and then bare-metal to verify the fix.
>
> Thanks!

Thank you!
/fuad

>
>         M.
>
> --
> Jazz isn't dead. It just smells funny.

