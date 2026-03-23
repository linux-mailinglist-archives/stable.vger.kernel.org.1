Return-Path: <stable+bounces-227911-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8E+4ILr3wGkwPAQAu9opvQ
	(envelope-from <stable+bounces-227911-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 09:20:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9EE2EE35D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 09:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10A59301829F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 08:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808DC370D4B;
	Mon, 23 Mar 2026 08:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhDE9D+5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CCC36EA90
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 08:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253693; cv=none; b=E6QpvsfT2rq6CenxuaCDLDK793qRqj7OwDt10EXBf0rzdKiNrlrcY4NOsl+QwZ/60Uc53JkAgD//zLewn+y2cu/ShfkHj8vZchmQ+tsuJSpGflqc3012A+Vsg6PQI/M3W8y5IWrcmMvGFXZa0xnveDCzK1/S7H/Pt2REqIhC+EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253693; c=relaxed/simple;
	bh=um5I7PVdJmAcpOBqS9KqVvbKn8LuqGYxZ7PJq9Mle4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PawhSeH+14TK541srjGT2wXVsTPKazFhlRqqXtT7n2MldHhPOikAfC0v+MtJOrnZSlhK5pUUy3Xg96vSoPM0u2WAYYMikdEe6qXvp5n+53fLp/CvMPOhs+vSOIHghIAhv9PcYiLiw2g9/pebUx62QhduO5rztS1kTqDBwgSI14c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhDE9D+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F236C2BCC4
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 08:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774253693;
	bh=um5I7PVdJmAcpOBqS9KqVvbKn8LuqGYxZ7PJq9Mle4M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rhDE9D+529V/peOH4XoD+v8lUBUgXtBn7LVp+RSetNM+z1+KiY9Yybld3XCnbZeQd
	 5U2ZXFoWCwNtHBbL7nGSa0wqe8cOOkHCEoEbC0NtOAoVAXMZeyu7tF3chyeFg+IMKK
	 +2T8WH5/a9xwttY3o8fvqU40cUHLC1UxE43DpOWltfK1/49vngJRxiqwatgkC47tAG
	 eP9NJvZSsdEQniVhq4PWKhgOa3MRupERDXQYCYQo1LJOqmaD8z5K/g2I3cHr7qVwSX
	 nFK7Yv3qxl0P0aSR9EjcU2S2AFYlyaOxsvf4q0pmvpA82TJ1DyBhGfgNShEwby2Ni8
	 LIlu6OyfteLjA==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b9841aecf72so278212466b.2
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 01:14:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWOc5UfxrPPUCArWf7VpGZkdqb7FI1m8JAJtRYV8BiIuJeNL40MckNdH/7zC4/BIh6XfNS8BXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9g0nv7F43RsYxDPFVGQGp/iocgYQXdMehqWlJp237UfK+CpUT
	88777JKGDbeamB44Y/Uld2DOIWA6TCY+iCBCeIGLTTplDBb74uPXxY47muqDUAQpnOF+YIZnXAT
	TOLaQYrlpKTFjHiOQDU9lPVPjX/h7idA=
X-Received: by 2002:a17:907:3d92:b0:b98:528b:8466 with SMTP id
 a640c23a62f3a-b98528b968emr440416066b.55.1774253691422; Mon, 23 Mar 2026
 01:14:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322135346.3720577-1-chenhuacai@loongson.cn>
 <676198e5-78e4-ab41-e447-4a9d24655890@loongson.cn> <CAAhV-H7rFtju3k=NYkAy6-O7f8U=CTNiryu2_Kr57pScjeH-yQ@mail.gmail.com>
 <696c5177-4a89-f0d0-c305-c1581e72aa3d@loongson.cn>
In-Reply-To: <696c5177-4a89-f0d0-c305-c1581e72aa3d@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 23 Mar 2026 16:14:47 +0800
X-Gmail-Original-Message-ID: <CAAhV-H43BrbWseejgrmtsBRbkbsMVOX0FaHvYOXfr-R9Y2g1Fw@mail.gmail.com>
X-Gm-Features: AQROBzDUycA1vsWu2w015owAiI9fl2vqafZwY0vvqKec19L_lw2O20wJPIfxQRY
Message-ID: <CAAhV-H43BrbWseejgrmtsBRbkbsMVOX0FaHvYOXfr-R9Y2g1Fw@mail.gmail.com>
Subject: Re: [PATCH 1/2] LoongArch: KVM: Make kvm_get_vcpu_by_cpuid() more robust
To: Bibo Mao <maobibo@loongson.cn>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org, 
	Aurelien Jarno <aurel32@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
	TAGGED_FROM(0.00)[bounces-227911-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,loongson.cn:email]
X-Rspamd-Queue-Id: DA9EE2EE35D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 3:59=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
>
>
> On 2026/3/23 =E4=B8=8B=E5=8D=883:08, Huacai Chen wrote:
> > On Mon, Mar 23, 2026 at 11:16=E2=80=AFAM Bibo Mao <maobibo@loongson.cn>=
 wrote:
> >>
> >>
> >>
> >> On 2026/3/22 =E4=B8=8B=E5=8D=889:53, Huacai Chen wrote:
> >>> kvm_get_vcpu_by_cpuid() takes a cpuid parameter whose type is int, so
> >>> cpuid can be negative. Let kvm_get_vcpu_by_cpuid() return NULL for th=
is
> >>> case so as to make it more robust.
> >>>
> >>> This fix an out-of-bounds access to kvm_arch::phyid_map::phys_map[].
> >>>
> >>> Cc: <stable@vger.kernel.org>
> >>> Fixes: 73516e9da512adc ("LoongArch: KVM: Add vcpu mapping from physic=
al cpuid")
> >>> Reported-by: Aurelien Jarno <aurel32@debian.org>
> >>> Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1131431
> >>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> >>> ---
> >>>    arch/loongarch/kvm/vcpu.c | 3 +++
> >>>    1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> >>> index 8ffd50a470e6..831f381a8fd1 100644
> >>> --- a/arch/loongarch/kvm/vcpu.c
> >>> +++ b/arch/loongarch/kvm/vcpu.c
> >>> @@ -588,6 +588,9 @@ struct kvm_vcpu *kvm_get_vcpu_by_cpuid(struct kvm=
 *kvm, int cpuid)
> >>>    {
> >>>        struct kvm_phyid_map *map;
> >>>
> >>> +     if (cpuid < 0)
> >>> +             return NULL;
> >>> +
> >>>        if (cpuid >=3D KVM_MAX_PHYID)
> >>>                return NULL;
> >>>
> >>>
> >>
> >> if (cpuid < 0 || cpuid >=3D KVM_MAX_PHYID)?
> >> however both are OK for me.
> > I use a similar style as kvm_get_vcpu_by_id(). :)
> >
> > But there is another warning which can't be solved by this series (and
> > I doubt whether it can be solved unless revert 01a8e68396a6d51f5b).
> > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1131431
>
> what is the kernel config file with bug
>     https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1131431
I don't know exactly, but it needs CONFIG_FORTIFY_SOURCE.

Huacai

>
> kvm_eiointc_regs_access() seems has problem, it need convert to void *
> before arithmetic operation. I do not know whether this patch can solve
> this bug.
>
> diff --git a/arch/loongarch/kvm/intc/eiointc.c
> b/arch/loongarch/kvm/intc/eiointc.c
> index d2acb4d09e73..71bd67b57338 100644
> --- a/arch/loongarch/kvm/intc/eiointc.c
> +++ b/arch/loongarch/kvm/intc/eiointc.c
> @@ -472,34 +472,34 @@ static int kvm_eiointc_regs_access(struct
> kvm_device *dev,
>          switch (addr) {
>          case EIOINTC_NODETYPE_START ... EIOINTC_NODETYPE_END:
>                  offset =3D (addr - EIOINTC_NODETYPE_START) / 4;
> -               p =3D s->nodetype + offset * 4;
> +               p =3D (void *)s->nodetype + offset * 4;
>                  break;
>          case EIOINTC_IPMAP_START ... EIOINTC_IPMAP_END:
>                  offset =3D (addr - EIOINTC_IPMAP_START) / 4;
> -               p =3D &s->ipmap + offset * 4;
> +               p =3D (void *)&s->ipmap + offset * 4;
>                  break;
>          case EIOINTC_ENABLE_START ... EIOINTC_ENABLE_END:
>                  offset =3D (addr - EIOINTC_ENABLE_START) / 4;
> -               p =3D s->enable + offset * 4;
> +               p =3D (void *)s->enable + offset * 4;
>                  break;
>          case EIOINTC_BOUNCE_START ... EIOINTC_BOUNCE_END:
>                  offset =3D (addr - EIOINTC_BOUNCE_START) / 4;
> -               p =3D s->bounce + offset * 4;
> +               p =3D (void *)s->bounce + offset * 4;
>                  break;
>          case EIOINTC_ISR_START ... EIOINTC_ISR_END:
>                  offset =3D (addr - EIOINTC_ISR_START) / 4;
> -               p =3D s->isr + offset * 4;
> +               p =3D (void *)s->isr + offset * 4;
>                  break;
>          case EIOINTC_COREISR_START ... EIOINTC_COREISR_END:
>                  if (cpu >=3D s->num_cpu)
>                          return -EINVAL;
>
>                  offset =3D (addr - EIOINTC_COREISR_START) / 4;
> -               p =3D s->coreisr[cpu] + offset * 4;
> +               p =3D (void *)s->coreisr[cpu] + offset * 4;
>                  break;
>          case EIOINTC_COREMAP_START ... EIOINTC_COREMAP_END:
>                  offset =3D (addr - EIOINTC_COREMAP_START) / 4;
> -               p =3D s->coremap + offset * 4;
> +               p =3D (void *)s->coremap + offset * 4;
>                  break;
>          default:
>                  kvm_err("%s: unknown eiointc register, addr =3D %d\n",
> __func__, addr);
>
>
> Regards
> Bibo Mao
> >
> > Huacai
> >
> >>
> >> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
> >>
>
>

