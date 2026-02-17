Return-Path: <stable+bounces-216784-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAZaCmVNlGkNCQIAu9opvQ
	(envelope-from <stable+bounces-216784-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 12:13:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3552E14B37C
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 12:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B4DC30055D7
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 11:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F0E28850B;
	Tue, 17 Feb 2026 11:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePtPvVGJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770FA33031C
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 11:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771326813; cv=none; b=cA2HEfljTpEori1FGi2qpfj7/2GwauEr77pcq24V2bsRvWsL3pCQuatl7SBQ0ushasY+OnE6dj6f0VNqc+Vrw/EVlb/d22lGsJ8cs21xs91fAOESKMe9MUlAHgHp0GKOhpEMuZFpgZn4kCCCB8opkFRvXF6loq99w6qhGHddI04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771326813; c=relaxed/simple;
	bh=3iu/q4GW+tnQIqBPJBLifKRgjcKYhwQbvfC57/wH+YY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/phNGbBlKBqcjn8rOYmLAZ6PvV1tDf7lnGw+cT9EgWFeSDldrdAr+eMCEAgsB7x9pZuunMmH/Fss0Q204ZnApi3WqRPEhgW9eIIsr8aA5vmr7lBwT9gwNiDBXm0z20EAHxw/WUAQOhLXq8VceCWrqLObc7671hvGrU3AdRQ3l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePtPvVGJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241D7C19423
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 11:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771326813;
	bh=3iu/q4GW+tnQIqBPJBLifKRgjcKYhwQbvfC57/wH+YY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ePtPvVGJKDnVraEkaX3C9wNR3FE6A6oCkpZw2ew5l3YiyFlhor8g+e/Y9bEAWhClA
	 5R7NJJsinhgj7OvS+zuvgwaf2UY8k6Wa0B1kBhMcXJ+vi+h6hvV7SqqdUIkJWDJNPh
	 /cRGzBLOQhdDdYt5bFqzqtp8ncA4MMhsVUZExw0iLffqqLwbzHV5HvnC3F/Qc5jE+J
	 gNWt5TxHXTb2Vwr5zVaUv8xuNuYGFukdIOf8gNSkuNjqK80PmfTzoqBKkS4+YTg+OP
	 swj9B+7STn17FlSvffa91YxkaBHheUlCLzv1jj370l3Pnbg1KAIpuOKqb72WRo0uGc
	 gdM0lTAJ2mxPA==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8845cb5862so528070066b.3
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 03:13:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVCmOZDXlgXS6u8/btIteGLFxdVK1Iq/rS2YM1BnvUxgkfAvO/7WQhq/iBKQKFFrrbAphZdC8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB8YlFuEIMVu3hkdqJaa7/8SQJU40MQnEBGafs52+ki6SkOBYg
	Inf65PaVdE/x0jtedl5ERsrdTGuUYnLtVzG/atu6iEFu1kZ54Y5EdcJpzfEuxJGTEddoHI0D6Bu
	VbqFpueyPCqc0/z+GVPTJ5PYPExUHY1Y=
X-Received: by 2002:a17:907:d7c9:b0:b88:7568:26d5 with SMTP id
 a640c23a62f3a-b8fb4217424mr819613966b.27.1771326811700; Tue, 17 Feb 2026
 03:13:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216142550.1479337-1-chenhuacai@loongson.cn> <2026021735-scorebook-cheese-25d3@gregkh>
In-Reply-To: <2026021735-scorebook-cheese-25d3@gregkh>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 17 Feb 2026 19:13:30 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Ahx-9bL=KQwRptiMp0nGUTOv8iqc9C=jhpSBjnFm+TQ@mail.gmail.com>
X-Gm-Features: AaiRm50ITKBTzTitlZbRvhEHmlaH2gFm9cxghaT_p3mMZ4P7vBMLkp1dSniWH3U
Message-ID: <CAAhV-H4Ahx-9bL=KQwRptiMp0nGUTOv8iqc9C=jhpSBjnFm+TQ@mail.gmail.com>
Subject: Re: [PATCH V2 for 6.6 & 6.12] LoongArch: Rework KASAN initialization
 for PTW-enabled systems
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Sasha Levin <sashal@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-216784-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Queue-Id: 3552E14B37C
X-Rspamd-Action: no action

Hi, Greg,

On Tue, Feb 17, 2026 at 7:06=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Feb 16, 2026 at 10:25:50PM +0800, Huacai Chen wrote:
> > From: Tiezhu Yang <yangtiezhu@loongson.cn>
> >
> > commit 5ec5ac4ca27e4daa234540ac32f9fc5219377d53 upstream.
> >
> > kasan_init_generic() indicates that kasan is fully initialized, so it
> > should be put at end of kasan_init().
> >
> > Otherwise bringing up the primary CPU failed when CONFIG_KASAN is set
> > on PTW-enabled systems, here are the call chains:
> >
> >     kernel_entry()
> >       start_kernel()
> >         setup_arch()
> >           kasan_init()
> >             kasan_init_generic()
> >
> > The reason is PTW-enabled systems have speculative accesses which means
> > memory accesses to the shadow memory after kasan_init() may be executed
> > by hardware before. However, accessing shadow memory is safe only after
> > kasan fully initialized because kasan_init() uses a temporary PGD table
> > until we have populated all levels of shadow page tables and writen the
> > PGD register. Moving kasan_init_generic() later can defer the occasion
> > of kasan_enabled(), so as to avoid speculative accesses on shadow pages=
.
> >
> > After moving kasan_init_generic() to the end, kasan_init() can no longe=
r
> > call kasan_mem_to_shadow() for shadow address conversion because it wil=
l
> > always return kasan_early_shadow_page. On the other hand, we should kee=
p
> > the current logic of kasan_mem_to_shadow() for both the early and final
> > stage because there may be instrumentation before kasan_init().
> >
> > To solve this, we factor out a new mem_to_shadow() function from curren=
t
> > kasan_mem_to_shadow() for the shadow address conversion in kasan_init()=
.
> >
> > [ Huacai: To backport from upstream to 6.6 & 6.12, kasan_enabled() is
> >           replaced with kasan_arch_is_ready() and kasan_init_generic()
> >           is replaced with "kasan_early_stage =3D false". ]
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  arch/loongarch/mm/kasan_init.c | 77 ++++++++++++++++++----------------
> >  1 file changed, 40 insertions(+), 37 deletions(-)
> >
> > diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/mm/kasan_i=
nit.c
> > index d2681272d8f0..9337380a70eb 100644
> > --- a/arch/loongarch/mm/kasan_init.c
> > +++ b/arch/loongarch/mm/kasan_init.c
> > @@ -42,39 +42,43 @@ static pgd_t kasan_pg_dir[PTRS_PER_PGD] __initdata =
__aligned(PAGE_SIZE);
> >
> >  bool kasan_early_stage =3D true;
> >
> > -void *kasan_mem_to_shadow(const void *addr)
> > +static void *mem_to_shadow(const void *addr)
> >  {
> > -     if (!kasan_arch_is_ready()) {
> > +     unsigned long offset =3D 0;
> > +     unsigned long maddr =3D (unsigned long)addr;
> > +     unsigned long xrange =3D (maddr >> XRANGE_SHIFT) & 0xffff;
> > +
> > +     if (maddr >=3D FIXADDR_START)
> >               return (void *)(kasan_early_shadow_page);
> > -     } else {
> > -             unsigned long maddr =3D (unsigned long)addr;
> > -             unsigned long xrange =3D (maddr >> XRANGE_SHIFT) & 0xffff=
;
> > -             unsigned long offset =3D 0;
> > -
> > -             if (maddr >=3D FIXADDR_START)
> > -                     return (void *)(kasan_early_shadow_page);
> > -
> > -             maddr &=3D XRANGE_SHADOW_MASK;
> > -             switch (xrange) {
> > -             case XKPRANGE_CC_SEG:
> > -                     offset =3D XKPRANGE_CC_SHADOW_OFFSET;
> > -                     break;
> > -             case XKPRANGE_UC_SEG:
> > -                     offset =3D XKPRANGE_UC_SHADOW_OFFSET;
> > -                     break;
> > -             case XKPRANGE_WC_SEG:
> > -                     offset =3D XKPRANGE_WC_SHADOW_OFFSET;
> > -                     break;
> > -             case XKVRANGE_VC_SEG:
> > -                     offset =3D XKVRANGE_VC_SHADOW_OFFSET;
> > -                     break;
> > -             default:
> > -                     WARN_ON(1);
> > -                     return NULL;
> > -             }
> >
> > -             return (void *)((maddr >> KASAN_SHADOW_SCALE_SHIFT) + off=
set);
> > +     maddr &=3D XRANGE_SHADOW_MASK;
> > +     switch (xrange) {
> > +     case XKPRANGE_CC_SEG:
> > +             offset =3D XKPRANGE_CC_SHADOW_OFFSET;
> > +             break;
> > +     case XKPRANGE_UC_SEG:
> > +             offset =3D XKPRANGE_UC_SHADOW_OFFSET;
> > +             break;
> > +     case XKPRANGE_WC_SEG:
> > +             offset =3D XKPRANGE_WC_SHADOW_OFFSET;
> > +             break;
> > +     case XKVRANGE_VC_SEG:
> > +             offset =3D XKVRANGE_VC_SHADOW_OFFSET;
> > +             break;
> > +     default:
> > +             WARN_ON(1);
> > +             return NULL;
> >       }
> > +
> > +     return (void *)((maddr >> KASAN_SHADOW_SCALE_SHIFT) + offset);
> > +}
> > +
> > +void *kasan_mem_to_shadow(const void *addr)
> > +{
> > +     if (kasan_arch_is_ready())
> > +             return mem_to_shadow(addr);
> > +     else
> > +             return (void *)(kasan_early_shadow_page);
> >  }
> >
> >  const void *kasan_shadow_to_mem(const void *shadow_addr)
> > @@ -295,10 +299,8 @@ void __init kasan_init(void)
> >       /* Maps everything to a single page of zeroes */
> >       kasan_pgd_populate(KASAN_SHADOW_START, KASAN_SHADOW_END, NUMA_NO_=
NODE, true);
> >
> > -     kasan_populate_early_shadow(kasan_mem_to_shadow((void *)VMALLOC_S=
TART),
> > -                                     kasan_mem_to_shadow((void *)KFENC=
E_AREA_END));
> > -
> > -     kasan_early_stage =3D false;
> > +     kasan_populate_early_shadow(mem_to_shadow((void *)VMALLOC_START),
> > +                                     mem_to_shadow((void *)KFENCE_AREA=
_END));
> >
> >       /* Populate the linear mapping */
> >       for_each_mem_range(i, &pa_start, &pa_end) {
> > @@ -308,13 +310,13 @@ void __init kasan_init(void)
> >               if (start >=3D end)
> >                       break;
> >
> > -             kasan_map_populate((unsigned long)kasan_mem_to_shadow(sta=
rt),
> > -                     (unsigned long)kasan_mem_to_shadow(end), NUMA_NO_=
NODE);
> > +             kasan_map_populate((unsigned long)mem_to_shadow(start),
> > +                     (unsigned long)mem_to_shadow(end), NUMA_NO_NODE);
> >       }
> >
> >       /* Populate modules mapping */
> > -     kasan_map_populate((unsigned long)kasan_mem_to_shadow((void *)MOD=
ULES_VADDR),
> > -             (unsigned long)kasan_mem_to_shadow((void *)MODULES_END), =
NUMA_NO_NODE);
> > +     kasan_map_populate((unsigned long)mem_to_shadow((void *)MODULES_V=
ADDR),
> > +             (unsigned long)mem_to_shadow((void *)MODULES_END), NUMA_N=
O_NODE);
> >       /*
> >        * KAsan may reuse the contents of kasan_early_shadow_pte directl=
y, so we
> >        * should make sure that it maps the zero page read-only.
> > @@ -329,5 +331,6 @@ void __init kasan_init(void)
> >
> >       /* At this point kasan is fully initialized. Enable error message=
s */
> >       init_task.kasan_depth =3D 0;
> > +     kasan_early_stage =3D false;
> >       pr_info("KernelAddressSanitizer initialized.\n");
> >  }
> > --
> > 2.52.0
> >
> >
>
> Does not apply to 6.6.y, I get the following error:
>
> checking file arch/loongarch/mm/kasan_init.c
> Hunk #1 FAILED at 42.
> Hunk #2 succeeded at 290 (offset -5 lines).
> Hunk #3 succeeded at 301 (offset -5 lines).
> Hunk #4 succeeded at 322 (offset -5 lines).
> 1 out of 4 hunks FAILED
I'm sorry, for 6.6.y it need 139d42ca51018c1d43ab5f35829179f060d1ab31
("LoongArch: Add WriteCombine shadow mapping in KASAN") as a
dependency.

Huacai

