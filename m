Return-Path: <stable+bounces-216791-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKwsNJxflGnODAIAu9opvQ
	(envelope-from <stable+bounces-216791-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 13:31:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 328B114BFC6
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 13:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F1603043038
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 12:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C4F343D78;
	Tue, 17 Feb 2026 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6Py2Ljr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A4E343216
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 12:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771331431; cv=none; b=Ilb3inNy0juqfFxwqoWr3EGRqPNhg7qvGGQFuwSYEm/6x8lD1jAGGjJOg21zYPmmofLUjvUwb8Nn+YMTWBfI4ZG3xijLlvksiv5inA9VUs07FYzdV4d3khrHOn2rEF5ddKTrjbplXQU3sravxHg+SBtQLqtpe2XeVJhoucRw2Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771331431; c=relaxed/simple;
	bh=uwW/4nuPmJHfCaSafrasq3hc35JWexn0nD90dw3jeTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AEo6gCMeqMF9erETfI9i1cWE0BIUK1sv3x012PcNF3x71B3ri0TMJppSu4LroWOPb3wlJ6Dnh7cvVU5BXmzDdygnXEctBqOwFsBpgRp3Mboi6k8bGq9qk/2MteaGJHFjBjkG8bExpFjXI+qRPbPMktE+UZXYTxXOtKAaFpH7yV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6Py2Ljr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F58C19425
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 12:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771331431;
	bh=uwW/4nuPmJHfCaSafrasq3hc35JWexn0nD90dw3jeTM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h6Py2LjrLmKdNsSjmljLiA7MdV5ZV+vORnQk7UlS+CJqn2mx//V7whDW31bpyIWY0
	 CA+lkur3l8sBgI6aYlgr2+B1VVFqI/VZx7WHx2IinFBIrtypB9CGJKmEQZD6X56NGT
	 zULnn5D41DqJ6RxV+miSPfuGn1MMI/h7dbIW9RQ4A61kH8xXKEhFzZcUWG7ZQIANI3
	 u7dK4+HzZlk80l7y5lqm5ZHIE7kwl4p14SueMPb6/Gg7czxn4ExipDYRextDJi5Ecu
	 IzX1ZvRTlS8ZrJsvi0plxsodXzfr2pv0hxNfO9MQQfVorrgDS1SDV6sknc/iE/3EuF
	 ywAPbPeys8Ybg==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-65a3527c5easo5925479a12.0
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 04:30:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWNyUAfbWo7PYizph8/4kylmNVp32LIM3MMJsnbWsp1wO+NvZuGdSsBJn7EeVU2VYA0UoB4L3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf9q94YcM7aL4doLxhDoHynco9HkjqMXoVy0fdQpZfUigMs6sL
	kyk2I7GbeltE6h6/VIuEBOkNTQVv9h4atYNwZRMLScfqE3Ah7xYzmLvuF+T1pnWpW1wwAEVSc3X
	LN+QoGXRqQr2+CaKfXf4ILHHq05qxVXA=
X-Received: by 2002:a05:6402:270c:b0:658:bf8d:c92b with SMTP id
 4fb4d7f45d1cf-65bb13c6924mr6205089a12.31.1771331429490; Tue, 17 Feb 2026
 04:30:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216142550.1479337-1-chenhuacai@loongson.cn>
 <2026021735-scorebook-cheese-25d3@gregkh> <CAAhV-H4Ahx-9bL=KQwRptiMp0nGUTOv8iqc9C=jhpSBjnFm+TQ@mail.gmail.com>
 <2026021714-sponge-causation-aef3@gregkh>
In-Reply-To: <2026021714-sponge-causation-aef3@gregkh>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 17 Feb 2026 20:30:27 +0800
X-Gmail-Original-Message-ID: <CAAhV-H40mTDXhz3wXJimutAGLbME+EkqFpQ-Ab-14FK=6n-PYQ@mail.gmail.com>
X-Gm-Features: AaiRm51tM-BaLPYqo2lO8Pzb3N1RtDJipaksRvfb23PDpm4cfWCxLIbmAPYp7ik
Message-ID: <CAAhV-H40mTDXhz3wXJimutAGLbME+EkqFpQ-Ab-14FK=6n-PYQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216791-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,loongson.cn:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 328B114BFC6
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 7:24=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Feb 17, 2026 at 07:13:30PM +0800, Huacai Chen wrote:
> > Hi, Greg,
> >
> > On Tue, Feb 17, 2026 at 7:06=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Feb 16, 2026 at 10:25:50PM +0800, Huacai Chen wrote:
> > > > From: Tiezhu Yang <yangtiezhu@loongson.cn>
> > > >
> > > > commit 5ec5ac4ca27e4daa234540ac32f9fc5219377d53 upstream.
> > > >
> > > > kasan_init_generic() indicates that kasan is fully initialized, so =
it
> > > > should be put at end of kasan_init().
> > > >
> > > > Otherwise bringing up the primary CPU failed when CONFIG_KASAN is s=
et
> > > > on PTW-enabled systems, here are the call chains:
> > > >
> > > >     kernel_entry()
> > > >       start_kernel()
> > > >         setup_arch()
> > > >           kasan_init()
> > > >             kasan_init_generic()
> > > >
> > > > The reason is PTW-enabled systems have speculative accesses which m=
eans
> > > > memory accesses to the shadow memory after kasan_init() may be exec=
uted
> > > > by hardware before. However, accessing shadow memory is safe only a=
fter
> > > > kasan fully initialized because kasan_init() uses a temporary PGD t=
able
> > > > until we have populated all levels of shadow page tables and writen=
 the
> > > > PGD register. Moving kasan_init_generic() later can defer the occas=
ion
> > > > of kasan_enabled(), so as to avoid speculative accesses on shadow p=
ages.
> > > >
> > > > After moving kasan_init_generic() to the end, kasan_init() can no l=
onger
> > > > call kasan_mem_to_shadow() for shadow address conversion because it=
 will
> > > > always return kasan_early_shadow_page. On the other hand, we should=
 keep
> > > > the current logic of kasan_mem_to_shadow() for both the early and f=
inal
> > > > stage because there may be instrumentation before kasan_init().
> > > >
> > > > To solve this, we factor out a new mem_to_shadow() function from cu=
rrent
> > > > kasan_mem_to_shadow() for the shadow address conversion in kasan_in=
it().
> > > >
> > > > [ Huacai: To backport from upstream to 6.6 & 6.12, kasan_enabled() =
is
> > > >           replaced with kasan_arch_is_ready() and kasan_init_generi=
c()
> > > >           is replaced with "kasan_early_stage =3D false". ]
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > ---
> > > >  arch/loongarch/mm/kasan_init.c | 77 ++++++++++++++++++------------=
----
> > > >  1 file changed, 40 insertions(+), 37 deletions(-)
> > > >
> > > > diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/mm/kas=
an_init.c
> > > > index d2681272d8f0..9337380a70eb 100644
> > > > --- a/arch/loongarch/mm/kasan_init.c
> > > > +++ b/arch/loongarch/mm/kasan_init.c
> > > > @@ -42,39 +42,43 @@ static pgd_t kasan_pg_dir[PTRS_PER_PGD] __initd=
ata __aligned(PAGE_SIZE);
> > > >
> > > >  bool kasan_early_stage =3D true;
> > > >
> > > > -void *kasan_mem_to_shadow(const void *addr)
> > > > +static void *mem_to_shadow(const void *addr)
> > > >  {
> > > > -     if (!kasan_arch_is_ready()) {
> > > > +     unsigned long offset =3D 0;
> > > > +     unsigned long maddr =3D (unsigned long)addr;
> > > > +     unsigned long xrange =3D (maddr >> XRANGE_SHIFT) & 0xffff;
> > > > +
> > > > +     if (maddr >=3D FIXADDR_START)
> > > >               return (void *)(kasan_early_shadow_page);
> > > > -     } else {
> > > > -             unsigned long maddr =3D (unsigned long)addr;
> > > > -             unsigned long xrange =3D (maddr >> XRANGE_SHIFT) & 0x=
ffff;
> > > > -             unsigned long offset =3D 0;
> > > > -
> > > > -             if (maddr >=3D FIXADDR_START)
> > > > -                     return (void *)(kasan_early_shadow_page);
> > > > -
> > > > -             maddr &=3D XRANGE_SHADOW_MASK;
> > > > -             switch (xrange) {
> > > > -             case XKPRANGE_CC_SEG:
> > > > -                     offset =3D XKPRANGE_CC_SHADOW_OFFSET;
> > > > -                     break;
> > > > -             case XKPRANGE_UC_SEG:
> > > > -                     offset =3D XKPRANGE_UC_SHADOW_OFFSET;
> > > > -                     break;
> > > > -             case XKPRANGE_WC_SEG:
> > > > -                     offset =3D XKPRANGE_WC_SHADOW_OFFSET;
> > > > -                     break;
> > > > -             case XKVRANGE_VC_SEG:
> > > > -                     offset =3D XKVRANGE_VC_SHADOW_OFFSET;
> > > > -                     break;
> > > > -             default:
> > > > -                     WARN_ON(1);
> > > > -                     return NULL;
> > > > -             }
> > > >
> > > > -             return (void *)((maddr >> KASAN_SHADOW_SCALE_SHIFT) +=
 offset);
> > > > +     maddr &=3D XRANGE_SHADOW_MASK;
> > > > +     switch (xrange) {
> > > > +     case XKPRANGE_CC_SEG:
> > > > +             offset =3D XKPRANGE_CC_SHADOW_OFFSET;
> > > > +             break;
> > > > +     case XKPRANGE_UC_SEG:
> > > > +             offset =3D XKPRANGE_UC_SHADOW_OFFSET;
> > > > +             break;
> > > > +     case XKPRANGE_WC_SEG:
> > > > +             offset =3D XKPRANGE_WC_SHADOW_OFFSET;
> > > > +             break;
> > > > +     case XKVRANGE_VC_SEG:
> > > > +             offset =3D XKVRANGE_VC_SHADOW_OFFSET;
> > > > +             break;
> > > > +     default:
> > > > +             WARN_ON(1);
> > > > +             return NULL;
> > > >       }
> > > > +
> > > > +     return (void *)((maddr >> KASAN_SHADOW_SCALE_SHIFT) + offset)=
;
> > > > +}
> > > > +
> > > > +void *kasan_mem_to_shadow(const void *addr)
> > > > +{
> > > > +     if (kasan_arch_is_ready())
> > > > +             return mem_to_shadow(addr);
> > > > +     else
> > > > +             return (void *)(kasan_early_shadow_page);
> > > >  }
> > > >
> > > >  const void *kasan_shadow_to_mem(const void *shadow_addr)
> > > > @@ -295,10 +299,8 @@ void __init kasan_init(void)
> > > >       /* Maps everything to a single page of zeroes */
> > > >       kasan_pgd_populate(KASAN_SHADOW_START, KASAN_SHADOW_END, NUMA=
_NO_NODE, true);
> > > >
> > > > -     kasan_populate_early_shadow(kasan_mem_to_shadow((void *)VMALL=
OC_START),
> > > > -                                     kasan_mem_to_shadow((void *)K=
FENCE_AREA_END));
> > > > -
> > > > -     kasan_early_stage =3D false;
> > > > +     kasan_populate_early_shadow(mem_to_shadow((void *)VMALLOC_STA=
RT),
> > > > +                                     mem_to_shadow((void *)KFENCE_=
AREA_END));
> > > >
> > > >       /* Populate the linear mapping */
> > > >       for_each_mem_range(i, &pa_start, &pa_end) {
> > > > @@ -308,13 +310,13 @@ void __init kasan_init(void)
> > > >               if (start >=3D end)
> > > >                       break;
> > > >
> > > > -             kasan_map_populate((unsigned long)kasan_mem_to_shadow=
(start),
> > > > -                     (unsigned long)kasan_mem_to_shadow(end), NUMA=
_NO_NODE);
> > > > +             kasan_map_populate((unsigned long)mem_to_shadow(start=
),
> > > > +                     (unsigned long)mem_to_shadow(end), NUMA_NO_NO=
DE);
> > > >       }
> > > >
> > > >       /* Populate modules mapping */
> > > > -     kasan_map_populate((unsigned long)kasan_mem_to_shadow((void *=
)MODULES_VADDR),
> > > > -             (unsigned long)kasan_mem_to_shadow((void *)MODULES_EN=
D), NUMA_NO_NODE);
> > > > +     kasan_map_populate((unsigned long)mem_to_shadow((void *)MODUL=
ES_VADDR),
> > > > +             (unsigned long)mem_to_shadow((void *)MODULES_END), NU=
MA_NO_NODE);
> > > >       /*
> > > >        * KAsan may reuse the contents of kasan_early_shadow_pte dir=
ectly, so we
> > > >        * should make sure that it maps the zero page read-only.
> > > > @@ -329,5 +331,6 @@ void __init kasan_init(void)
> > > >
> > > >       /* At this point kasan is fully initialized. Enable error mes=
sages */
> > > >       init_task.kasan_depth =3D 0;
> > > > +     kasan_early_stage =3D false;
> > > >       pr_info("KernelAddressSanitizer initialized.\n");
> > > >  }
> > > > --
> > > > 2.52.0
> > > >
> > > >
> > >
> > > Does not apply to 6.6.y, I get the following error:
> > >
> > > checking file arch/loongarch/mm/kasan_init.c
> > > Hunk #1 FAILED at 42.
> > > Hunk #2 succeeded at 290 (offset -5 lines).
> > > Hunk #3 succeeded at 301 (offset -5 lines).
> > > Hunk #4 succeeded at 322 (offset -5 lines).
> > > 1 out of 4 hunks FAILED
> > I'm sorry, for 6.6.y it need 139d42ca51018c1d43ab5f35829179f060d1ab31
> > ("LoongArch: Add WriteCombine shadow mapping in KASAN") as a
> > dependency.
>
> That worked, thanks!
Oh, I'm very very sorry, 8e02c3b782ec64343f3cccc8dc5a8be2b379e80b
("LoongArch: Add writecombine support for DMW-based ioremap()") should
also be a dependency, otherwise there will be build errors.

Huacai

