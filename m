Return-Path: <stable+bounces-235697-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id foU3GWMR2mlAyQgAu9opvQ
	(envelope-from <stable+bounces-235697-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 11:16:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9169F3DF203
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 11:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B2AF301589B
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 09:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ACE2E4257;
	Sat, 11 Apr 2026 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZvHhTpy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8956CCA52
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775898973; cv=none; b=FVHcAQANuI9GEuhh5dKqMyKvfoUQ3hCYqF2vV3gsSQUN5L4pE9LKvDfibV4HaWDRFAFiB7PLYnswiQtOgxN+/6UeZ9mEm5VJKHoiZ470tulzVnA6a9UllMzNVq8QqO82jnEHn3UUSxfqk0vyPJUY3/EgQIBs7VhK3s7gR1BJquo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775898973; c=relaxed/simple;
	bh=7GboR0y2SpiDT88pAnxNKZZ01hYbTlXaj65NGPOWs1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3HBz2OWaDjna/DMVRCYuQHGzkzAca8TDgZkG6HPeu9G7uvt5/+xuKolZcA325fH3Qa/NNq5cYFbxxj6hv1f8jHB9uoVJAtlNBSS9hRLFjqNU5+gK23pfxcjONQH3Ze5t0u+ad/47SpaYP0Q8qVJvmTk8tmk6gDaoD9UQuvrPww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZvHhTpy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0C2C2BCB0
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 09:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775898973;
	bh=7GboR0y2SpiDT88pAnxNKZZ01hYbTlXaj65NGPOWs1A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QZvHhTpyM4luFhDVo5ARCAQPO9FkbFVqfjKu6ejkOMCwvhYG2pFK86quidEZQBymq
	 3X1zoJ0SJJMfhhvMKuZsYtFnUUdii6D9+Vvd1J0k+QXrnH0Jh4X/grTDm2JZuSngol
	 H6egIsOMoD0OBQXBhXV0zVNzqRux9uOkOIas2HvtJt7hxzNSs+jxjGBw5LmuQ4kwKr
	 H5P+E4fn6YliotaF/dwJg9Be4EMV8kuFowlq4aZM+JNn34DInTuTBIX049U8LfG/0W
	 cfLO2eQJ9A5z+CGsgmMPBs87iS3UA1s96AevSfsA0ylYqk8/2918XBSmDWwyTXEGcp
	 ghGvxkgqcdKvA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9358bc9c50so393040466b.1
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 02:16:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTeTp0H0o/+V9C4nr6mm4oznFHuON9Z9amDP0x1LjAyk/5vrD8oRITnDHJjlNqjzRzHBNpOuw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz94Z5icEcfcD+PNjMg9F4F197tKEUiuGX7BNOMRm12x9OeXwjI
	HF/2MMPleCkQo+X8J9L32m9c+NtE1eug8QuMcF80fgV+P6N2Cc7GJweZsPJxjjXvHNxjrqa8NrV
	ABdYodYW4G2RwngWDJkwgk8o2DrPVoTs=
X-Received: by 2002:a17:906:5184:20b0:b98:36cd:7e11 with SMTP id
 a640c23a62f3a-b9d7277c0c4mr275009166b.45.1775898971793; Sat, 11 Apr 2026
 02:16:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410013053.3877-1-dongtai.guo@linux.dev> <871pgm2700.ffs@tglx>
In-Reply-To: <871pgm2700.ffs@tglx>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 11 Apr 2026 17:16:16 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5dkdG+Gx8z8KyBND052yNxdc0s4eCw=0mtFhdm9G-oyw@mail.gmail.com>
X-Gm-Features: AQROBzC7LcPGobBczQ2QVZoP6lG9dpzjZNjcvo1rmVnhbsobqSEVtPTla39wpSQ
Message-ID: <CAAhV-H5dkdG+Gx8z8KyBND052yNxdc0s4eCw=0mtFhdm9G-oyw@mail.gmail.com>
Subject: Re: [PATCH 1/1] irqchip/loongson-pch-pic: Fix vec_count reading for
 32-bit and 64-bit
To: Thomas Gleixner <tglx@kernel.org>
Cc: George Guo <dongtai.guo@linux.dev>, jiaxun.yang@flygoat.com, 
	linux-kernel@vger.kernel.org, George Guo <guodongtai@kylinos.cn>, 
	stable@vger.kernel.org, Kexin Liu <liukexin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235697-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: 9169F3DF203
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 11:02=E2=80=AFPM Thomas Gleixner <tglx@kernel.org> =
wrote:
>
> On Fri, Apr 10 2026 at 09:30, George Guo wrote:
> > From: George Guo <guodongtai@kylinos.cn>
> >
> > Commit 0370a5e740f2 ("irqchip/loongson-pch-pic: Adjust irqchip driver f=
or
> > 32BIT/64BIT") changed vec_count reading from readq() to readl() to supp=
ort
> > both 32-bit and 64-bit platforms. However, on virtual 64-bit platforms
> > (QEMU 8.2.0) this causes incorrect vec_count value, leading to panic:
>
> Is this problem limited to qemu?
I think it is a qemu bug rather than a kernel bug. Since qemu 8.2.0 is
old, I suggest use qemu 10.2.0 to test.


Huacai

>
> > WARNING: drivers/acpi/irq.c:63 at acpi_register_gsi+0xe8/0x108
> > Call Trace:
> > [<900000000024c634>] show_stack+0x64/0x188
> > [<9000000000245154>] dump_stack_lvl+0x6c/0x9c
>
> Please trim your backtrace as documented:
>
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#ba=
cktraces
>
> > @@ -343,7 +343,12 @@ static int pch_pic_init(phys_addr_t addr, unsigned=
 long size, int vec_base,
> >               priv->table[i] =3D PIC_UNDEF_VECTOR;
> >
> >       priv->ht_vec_base =3D vec_base;
> > -     priv->vec_count =3D ((readl(priv->base + 4) >> 16) & 0xff) + 1;
> > +
> > +     if (IS_ENABLED(CONFIG_64BIT))
> > +             priv->vec_count =3D ((readq(priv->base) >> 48) & 0xff) + =
1;
> > +     else
> > +             priv->vec_count =3D ((readl(priv->base + 4) >> 16) & 0xff=
) + 1;
>
> This does not make sense at all.
>
>      readl(base + 4) >> 16
>
> is fully equivalent to
>
>      readq(base) >> 48
>
> on a little endian machine, no?
>
> This needs a better explanation in the change log about the root cause
> and why this is the correct solution to fix the problem.
>
> If there is no other solution then this needs a big fat comment in the
> code explaining the reason. Otherwise the next AI agent will notice the
> equivalence and people will send cleanup patches....
>
> Thanks,
>
>         tglx

