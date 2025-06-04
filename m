Return-Path: <stable+bounces-151435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AC1ACE0B2
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 16:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A22153A81E7
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 14:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10DB290DBE;
	Wed,  4 Jun 2025 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="T307lBYR"
X-Original-To: stable@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592FA32C85;
	Wed,  4 Jun 2025 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749048452; cv=none; b=lWdO25OoMaT0SYOBk334IST7FocdeUTFIgI1SYDsRy4hqIvR12olWjMEucfTGDgVMpbxQWc4VGvgdiJVtuZwMSR3Vn5C8v+ZzEGh8TrmPezJb71phfkF/lRjwtNhNss9K3hF8AjEv2YtSwBn9hXLDu4CWhP6ZrpCv9mzNs4Z/bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749048452; c=relaxed/simple;
	bh=s794wOPYqmOh7ctoNUyErF6+1Cjz5YD1viu4ZG67VJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2vPbDu5lr2BXzIYv/aoMSBNPfpZxOKzmgVsKImAutUt6gN3byonfFlArVxbYLsR7PKtt65WVcA3AA9CucNvQJ9VeMWWb3iznntvVN6IGWxXlclPQGyFTnmjR/EB2ohyQbHuFw0Ht0RSKEW792vqZJoFakmee6wryGBRNSrE6Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=T307lBYR; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7B67E25B4D;
	Wed,  4 Jun 2025 16:47:22 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RreaCiUezlfL; Wed,  4 Jun 2025 16:47:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1749048441; bh=s794wOPYqmOh7ctoNUyErF6+1Cjz5YD1viu4ZG67VJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T307lBYRQTcYkHnp2ZEUgWq5m45CBUmBiHKIlJr6GlPmZhzr9eXYbYqSgI9qcpR02
	 K/Zk4jx4VhlVeQ3bmSICTsxUkv1rSLLccFFKWnGTSGoBijsz0itN98J7Pf0rZqumPZ
	 goDh9JE1DdcTK8/gfqhNUr2boSpAqjIk6gVqxVrnXLLobKH4QWBVa2XTQ2LRsGdC0c
	 +a1IiNexXnEbBg89XR7hWb3bMY0v81Srw+/MHlWNmBdlVoftd6Tro+KU4AiZlDxLT4
	 2qfCjJ4ij0RRO7kJ4y1ML2c2BjZNfUeAOHymok4j3Z//n10b3FSMAFSZPZ3Glib5IC
	 0rS/TToWSo/eQ==
Date: Wed, 4 Jun 2025 14:47:04 +0000
From: Yao Zi <ziyao@disroot.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Jianmin Lv <lvjianmin@loongson.cn>, WANG Xuerui <kernel@xen0n.name>,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] platform/loongarch: laptop: Get brightness setting
 from EC on probe
Message-ID: <aEBcaDvEKZVO77FY@pie.lan>
References: <20250531113851.21426-1-ziyao@disroot.org>
 <20250531113851.21426-2-ziyao@disroot.org>
 <CAAhV-H7pvaz5N0-EfvhDNHAXJtR13p9Xi5hfgDxOpeXi9zMbTQ@mail.gmail.com>
 <aD6Zz8L9WJRXvwaW@pie.lan>
 <CAAhV-H6j1OT9D8ZBtyEP=Mu5+m=t0ebUvuC=gVeNsoPizwK1TQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H6j1OT9D8ZBtyEP=Mu5+m=t0ebUvuC=gVeNsoPizwK1TQ@mail.gmail.com>

On Wed, Jun 04, 2025 at 09:56:20PM +0800, Huacai Chen wrote:
> On Tue, Jun 3, 2025 at 2:44 PM Yao Zi <ziyao@disroot.org> wrote:
> >
> > On Tue, Jun 03, 2025 at 12:11:48PM +0800, Huacai Chen wrote:
> > > On Sat, May 31, 2025 at 7:39 PM Yao Zi <ziyao@disroot.org> wrote:
> > > >
> > > > Previously 1 is unconditionally taken as current brightness value. This
> > > > causes problems since it's required to restore brightness settings on
> > > > resumption, and a value that doesn't match EC's state before suspension
> > > > will cause surprising changes of screen brightness.
> > > laptop_backlight_register() isn't called at resuming, so I think your
> > > problem has nothing to do with suspend (S3).
> >
> > It does have something to do with it. In loongson_hotkey_resume() which
> > is called when leaving S3 (suspension), the brightness is restored
> > according to props.brightness,
> >
> >         bd = backlight_device_get_by_type(BACKLIGHT_PLATFORM);
> >         if (bd) {
> >                 loongson_laptop_backlight_update(bd) ?
> >                 pr_warn("Loongson_backlight: resume brightness failed") :
> >                 pr_info("Loongson_backlight: resume brightness %d\n", bd->props
> > .brightness);
> >         }
> >
> > and without this patch, props.brightness is always set to 1 when the
> > driver probes, but actually (at least with the firmware on my laptop)
> > the screen brightness is set to 80 instead of 1 on cold boot, IOW, a
> > brightness value that doesn't match hardware state is set to
> > props.brightness.
> >
> > On resumption, loongson_hotkey_resume() restores the brightness
> > settings according to props.brightness. But as the value isn't what is
> > used by hardware before suspension. the screen brightness will look very
> > different (1 v.s. 80) comparing to the brightness before suspension.
> >
> > Some dmesg proves this as well, without this patch it says
> >
> >         loongson_laptop: Loongson_backlight: resume brightness 1
> >
> > but before suspension, reading
> > /sys/class/backlight/loongson3_laptop/actual_brightness yields 80.
> OK, that makes sense. But the commit message can still be improved, at
> least replace suspension/resumption with suspend/resume. You can grep
> them at Documentation/power.

Oops, thanks for the hint. Seems suspend/resume are wider used, and I
will reword the commit message in v2 :)

> Huacai

Regards,
Yao Zi

> >
> > > But there is really a problem about hibernation (S4): the brightness
> > > is 1 during booting, but when switching to the target kernel, the
> > > brightness may jump to the old value.
> > >
> > > If the above case is what you meet, please update the commit message.
> > >
> > > Huacai
> >
> > Thanks,
> > Yao Zi
> >
> > > >
> > > > Let's get brightness from EC and take it as the current brightness on
> > > > probe of the laptop driver to avoid the surprising behavior. Tested on
> > > > TongFang L860-T2 3A5000 laptop.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: 6246ed09111f ("LoongArch: Add ACPI-based generic laptop driver")
> > > > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > > > ---
> > > >  drivers/platform/loongarch/loongson-laptop.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/platform/loongarch/loongson-laptop.c b/drivers/platform/loongarch/loongson-laptop.c
> > > > index 99203584949d..828bd62e3596 100644
> > > > --- a/drivers/platform/loongarch/loongson-laptop.c
> > > > +++ b/drivers/platform/loongarch/loongson-laptop.c
> > > > @@ -392,7 +392,7 @@ static int laptop_backlight_register(void)
> > > >         if (!acpi_evalf(hotkey_handle, &status, "ECLL", "d"))
> > > >                 return -EIO;
> > > >
> > > > -       props.brightness = 1;
> > > > +       props.brightness = ec_get_brightness();
> > > >         props.max_brightness = status;
> > > >         props.type = BACKLIGHT_PLATFORM;
> > > >
> > > > --
> > > > 2.49.0
> > > >
> > > >
> 

