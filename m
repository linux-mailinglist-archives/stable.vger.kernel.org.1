Return-Path: <stable+bounces-151416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 627B3ACDFA6
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 15:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53B4E7AA842
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 13:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2034C28F935;
	Wed,  4 Jun 2025 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tX5i7gfV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C0A28F51C;
	Wed,  4 Jun 2025 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749045393; cv=none; b=PnCREEZBGB/AGsaDf42HMxxrSRcZkHvwd69RSKhEptc0MgBz73GvRvi+NxsoflcFv/07EkRytW2tfgPtRyKn0flZPAPlmDRl43g2UUB+gkWQjo1I6w5EIKWXIb46GagCSl1/B/i7nkrIgYfkisMqI3i+MmrBZYDHAV/GsIfcEhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749045393; c=relaxed/simple;
	bh=hNaIjnP9UQIXqs9XzN5BySAC1EeT1gYOVTmbEjhso3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fpr7W71uQk4b1q2yYmq6aq0qNjzwpwnobambXLbnpYCHy7rgq2NsVAdds21iMltq4IV3UHHH+lwh1MU11/H7yRw0HDv4Nb0PbEM+v8EaP23O9KP3g2B+ruU3ZCpxP4j3uiYUhdDMCK02MyrHBj2dk9DTLNVxuRmvgSEU0ZEEs+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tX5i7gfV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF15C4CEE7;
	Wed,  4 Jun 2025 13:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749045393;
	bh=hNaIjnP9UQIXqs9XzN5BySAC1EeT1gYOVTmbEjhso3w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tX5i7gfV/An0o+OVPNY+A2Ngdo4eZD2cKGN+XVYmr9KtKpr9kxuomMtKfA5+gFeSG
	 vygJBmnirp8AaBVUBkv8sNJ4daJQH/AQewxPpMagVRCCZ4YhHozBbU+JFrQsNdC+wz
	 cYn8FcZt2f3YQuPIpnj4M9q1IOXthHh+6YaKN0A6U2ZtTMlTw6bUmfncjC9TdyIbas
	 8uziFl4hKDealqfUt2A1E3lpMlCMij9e/QYRBfCFiTy+rTxYzq1v78cdgvFPsZ+71p
	 O0c1mF/9UsdfBEu0Vk+AWQAgAiAIhw7HBgnhcr5K56huHTHvGaA0JoS1HQz03hvVlq
	 ViYwVV0wdUHHg==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so1078173a12.3;
        Wed, 04 Jun 2025 06:56:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV0TAmQvHclJDNFYcmErt93y0zHKbwQE2lWS2XNA6Kam4hK6umsvMwzuMzj+gy1W0ud+C0jJVX1Q99a1mw=@vger.kernel.org, AJvYcCVJQQvlR8JiVlclaA2SdbNRY6R3slOewrKmWhDsPay5hK+siid+ec58pqOiOudfaWxhVsmvhE3U@vger.kernel.org
X-Gm-Message-State: AOJu0YwUu2aay2ZLMgqmeeFm8OYwLpp64pPRc0JB7gP8dKFBJOXyYep5
	jAs3OwZiAxgRg1IpJYTJwKWLLrxyt4Fd39UCVwlsVrywJn7b6AswAz/wVmaJWlfwCUn9o1oxrby
	4vn2Fs5c1TaJzXgmQYfUVViZPGqoMfX0=
X-Google-Smtp-Source: AGHT+IEpDdOfH7JSv9qoSDGd0z3t6ymqMnmQbNlmw+p25nqvJV9s6gLViUbiEfnbyljEN/038PRobbX/6ph/Dv/+ZLM=
X-Received: by 2002:a05:6402:524d:b0:607:1b7a:b989 with SMTP id
 4fb4d7f45d1cf-6071b7abda8mr281358a12.12.1749045391972; Wed, 04 Jun 2025
 06:56:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250531113851.21426-1-ziyao@disroot.org> <20250531113851.21426-2-ziyao@disroot.org>
 <CAAhV-H7pvaz5N0-EfvhDNHAXJtR13p9Xi5hfgDxOpeXi9zMbTQ@mail.gmail.com> <aD6Zz8L9WJRXvwaW@pie.lan>
In-Reply-To: <aD6Zz8L9WJRXvwaW@pie.lan>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 4 Jun 2025 21:56:20 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6j1OT9D8ZBtyEP=Mu5+m=t0ebUvuC=gVeNsoPizwK1TQ@mail.gmail.com>
X-Gm-Features: AX0GCFvuz6tVp6jU6zQuxGpjxaWdrfNqx3hl5IIjC66LsSXVYjnimt4J7d3OKdw
Message-ID: <CAAhV-H6j1OT9D8ZBtyEP=Mu5+m=t0ebUvuC=gVeNsoPizwK1TQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/loongarch: laptop: Get brightness setting
 from EC on probe
To: Yao Zi <ziyao@disroot.org>
Cc: Jianmin Lv <lvjianmin@loongson.cn>, WANG Xuerui <kernel@xen0n.name>, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 2:44=E2=80=AFPM Yao Zi <ziyao@disroot.org> wrote:
>
> On Tue, Jun 03, 2025 at 12:11:48PM +0800, Huacai Chen wrote:
> > On Sat, May 31, 2025 at 7:39=E2=80=AFPM Yao Zi <ziyao@disroot.org> wrot=
e:
> > >
> > > Previously 1 is unconditionally taken as current brightness value. Th=
is
> > > causes problems since it's required to restore brightness settings on
> > > resumption, and a value that doesn't match EC's state before suspensi=
on
> > > will cause surprising changes of screen brightness.
> > laptop_backlight_register() isn't called at resuming, so I think your
> > problem has nothing to do with suspend (S3).
>
> It does have something to do with it. In loongson_hotkey_resume() which
> is called when leaving S3 (suspension), the brightness is restored
> according to props.brightness,
>
>         bd =3D backlight_device_get_by_type(BACKLIGHT_PLATFORM);
>         if (bd) {
>                 loongson_laptop_backlight_update(bd) ?
>                 pr_warn("Loongson_backlight: resume brightness failed") :
>                 pr_info("Loongson_backlight: resume brightness %d\n", bd-=
>props
> .brightness);
>         }
>
> and without this patch, props.brightness is always set to 1 when the
> driver probes, but actually (at least with the firmware on my laptop)
> the screen brightness is set to 80 instead of 1 on cold boot, IOW, a
> brightness value that doesn't match hardware state is set to
> props.brightness.
>
> On resumption, loongson_hotkey_resume() restores the brightness
> settings according to props.brightness. But as the value isn't what is
> used by hardware before suspension. the screen brightness will look very
> different (1 v.s. 80) comparing to the brightness before suspension.
>
> Some dmesg proves this as well, without this patch it says
>
>         loongson_laptop: Loongson_backlight: resume brightness 1
>
> but before suspension, reading
> /sys/class/backlight/loongson3_laptop/actual_brightness yields 80.
OK, that makes sense. But the commit message can still be improved, at
least replace suspension/resumption with suspend/resume. You can grep
them at Documentation/power.

Huacai

>
> > But there is really a problem about hibernation (S4): the brightness
> > is 1 during booting, but when switching to the target kernel, the
> > brightness may jump to the old value.
> >
> > If the above case is what you meet, please update the commit message.
> >
> > Huacai
>
> Thanks,
> Yao Zi
>
> > >
> > > Let's get brightness from EC and take it as the current brightness on
> > > probe of the laptop driver to avoid the surprising behavior. Tested o=
n
> > > TongFang L860-T2 3A5000 laptop.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 6246ed09111f ("LoongArch: Add ACPI-based generic laptop driver=
")
> > > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > > ---
> > >  drivers/platform/loongarch/loongson-laptop.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/platform/loongarch/loongson-laptop.c b/drivers/p=
latform/loongarch/loongson-laptop.c
> > > index 99203584949d..828bd62e3596 100644
> > > --- a/drivers/platform/loongarch/loongson-laptop.c
> > > +++ b/drivers/platform/loongarch/loongson-laptop.c
> > > @@ -392,7 +392,7 @@ static int laptop_backlight_register(void)
> > >         if (!acpi_evalf(hotkey_handle, &status, "ECLL", "d"))
> > >                 return -EIO;
> > >
> > > -       props.brightness =3D 1;
> > > +       props.brightness =3D ec_get_brightness();
> > >         props.max_brightness =3D status;
> > >         props.type =3D BACKLIGHT_PLATFORM;
> > >
> > > --
> > > 2.49.0
> > >
> > >

