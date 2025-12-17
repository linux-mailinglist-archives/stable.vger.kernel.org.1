Return-Path: <stable+bounces-202835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4869ECC7DB3
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 14:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 395F83041E0A
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 13:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EFC365A15;
	Wed, 17 Dec 2025 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eh4tKIaB"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5168F365A0A
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 13:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765978294; cv=none; b=tRFTmTqBQ9agymmulMN/Vzodzjq/BsGKeSiEkimtjpjZP9P+ZYwcrKxXq0mApTjPGqMYDarIVER+FdAfBleNmufQ1E7PBHuB0XhkA09jVvmXaC3mEPpQ6pOWKlqvEpSeQPnuxYMhaoXGA+N8y930euWQYK0aK8KieW/fJYe6ye4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765978294; c=relaxed/simple;
	bh=jycgeTIPRUelVsfSx9vLjCr+REC0QC2bdOaCtVo3H7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n3r4u1ZlbPkJ6xnfAwg3WZvMPnJ7rI9H+Pfk5TfIQRvme/bV32Er/sbyxyl2AFGTv4Jp/XgtcRcdXEC598Mklwwh4s8K1n+yWjE/DtAtrYqT5WHGqAVSmM6coVVY4Dbi0OTiXVPpYQrfWdfbDWkP0Ny4TflxF3guvoZZXUJCGXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eh4tKIaB; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5dfc6be7df3so2035463137.0
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 05:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765978291; x=1766583091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNghk58lu6EKY1gO4PCRKN9LOFQqETUIv+rpFpVF+lA=;
        b=eh4tKIaBhitrB+VS13PRMS6eda0AcQ+xv7kULhYVXrTfvx/lIql2jVmzhpjR/f+R1o
         woFoIYKCQOnEuJqNHQbZh4Tsuw0Tk/8pRjV6m+u1SeprznbH4CIOeMO35r9AdTOcdhKw
         LuyDRO99BqWMSdN7tBnqNvV0IiD6B1LgDhIF+xhW/StQ7ZzRg9AgnHFVx8qJlrYGcvJT
         ILmQIXxmGtOshgFwRhguz7n/xj1Ww/8mxs5Pg92P+jhwBnxD31ZGvwlwh+5RG/a2z9we
         r7hn382XxGMOwzYLvwOEnfnkkNsJnhtL88RcJoJtHJNDljFHdi+LBPzWvYA+L58Qlqx0
         pEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765978291; x=1766583091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BNghk58lu6EKY1gO4PCRKN9LOFQqETUIv+rpFpVF+lA=;
        b=UFf7peh0lzumzYvuqeBN4BMKznPUppfCIflZoO8dyctlv1GjKMRTrnCihC44LmrSZ2
         Pao6yj08v9HvDjwyLG4aqEZ5/mEpJXCjWFGONRMb2jCtcgclN4RGfBgWgoZRL3O1SFwx
         sTsrwk6fbhFng1vaCKaHnChUl4t3mNqoxqUQf96+ZsvvVsBjI/rmgYiTHCn1Msv9kcJO
         TUjI6Vw0KCor/+oCk32jNbrulFUepI4sO6QaCaJlUrxxqaVhZMvISzA1O4t29dglesVs
         GorHPXzE6nQjH07BOjZ++wXZ9eyk3BxxvVF/abrnQFasTfgcB2qoDtByX9PX0EBB+c0l
         0zXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsx6VI4e3JWnpO+wLw6Pxqv7j5E4Gee5AQdFx1V5KWqB9fGvb4hiN/CJUee/A0QCPWqzKWN1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsMtprRQTQ110UMzOXovD2gQGL7rY40kn7Lr1mCGtUKmSk/BKH
	NqUTrNN0QwlVytzcvf2TFGUsTFdl+zOs7wMDpXO4SoisUF7D9VI3DYArt6+ebxV2C0bGIXoonT4
	i/xA0Ab3cWQCyq2EezUP6+xKsY+ZudBY=
X-Gm-Gg: AY/fxX6TvAuHQYDZ7vPJ26Vl6hSj/388wT5O9vdWKSqRMqtCH7eZXXJcacVRVYr/wtA
	pMjpSY/8mLX4qbHIL7FBkZiq9ww/NUvSYUPwcRU1Pi5aCBeUgemHNebNKTlq6FgLxdUye8b+bXt
	FFi3FYCJx+GU2vbOAI8Npuv6pwT6LbyAgMhontN+VkAnTphOee0oGGaJpARL8gMm9Zc6scld57i
	/oE3DHriboqspxbGBzm4tttmtkYNsovbyLP+IOJB3FHv6SsoAEeGw5+EfokcxukxuLTdsN7
X-Google-Smtp-Source: AGHT+IF/RmZlsXBF8hckJJ3l3l7LOEf+arY6XU1Qvxr5gDxcbn1oCOjTWXewkgwQJOh1xVL1oX4CY3dHBu2MXWxp/GM=
X-Received: by 2002:a05:6102:5e8c:b0:5df:b085:835a with SMTP id
 ada2fe7eead31-5e82780a8b6mr6164102137.30.1765978291110; Wed, 17 Dec 2025
 05:31:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251207072532.518547-1-lgs201920130244@gmail.com> <dc2a9d7b-0495-4365-8353-b51dc0526b74@gmx.de>
In-Reply-To: <dc2a9d7b-0495-4365-8353-b51dc0526b74@gmx.de>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 17 Dec 2025 21:31:17 +0800
X-Gm-Features: AQt7F2oNGE4vDCt1x87bQ5Y-ln407hzaW-GpOBdtgYUtfFCIE4EPnrzb5daGr-A
Message-ID: <CANUHTR8O5Sn+c3KU7fithYhJYiXF3Th6QOfo_=_+MU9Q7ZnZUg@mail.gmail.com>
Subject: Re: [PATCH] riva/fbdev: fix divide error in nv3_arb()
To: Helge Deller <deller@gmx.de>
Cc: Antonino Daplas <adaplas@gmail.com>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Helge,

thanks for your comments.

mclk_khz is derived from the PRAMDAC MCLK PLL and then passed into the
NV3 arbitration code. In nv3_arb() it is used as a divisor, so a zero
value will always be fatal.

For this fix I tried to keep it small and safe for stable. Putting the
guard in nv3_arb() makes sure we never hit a divide-by-zero no matter
how we got there. It also keeps the change local to the code that
actually needs the invariant mclk_khz !=3D 0.

Adding checks in rivafb_set_par() (or other callers in the trace)
would either duplicate validation in places that do not compute
mclk_khz, or require pushing error handling through several layers.

About initializing mclk_khz to some default: I would rather not guess
a clock. A made-up value can lead to wrong FIFO arbitration settings.
If arbitration cannot be computed, bailing out and using the existing
conservative fallback is safer.

I agree it could be worth adding earlier validation of the PLL-derived
clock as a follow-up. For the stable fix, I prefer the minimal guard
at the division site.

Best regards,
Guangshuo

Helge Deller <deller@gmx.de> =E4=BA=8E2025=E5=B9=B412=E6=9C=889=E6=97=A5=E5=
=91=A8=E4=BA=8C 06:02=E5=86=99=E9=81=93=EF=BC=9A
>
> On 12/7/25 08:25, Guangshuo Li wrote:
> > A userspace program can trigger the RIVA NV3 arbitration code by
> > calling the FBIOPUT_VSCREENINFO ioctl on /dev/fb*. When doing so,
> > the driver recomputes FIFO arbitration parameters in nv3_arb(), using
> > state->mclk_khz (derived from the PRAMDAC MCLK PLL) as a divisor
> > without validating it first.
> >
> > In a normal setup, state->mclk_khz is provided by the real hardware
> > and is non-zero. However, an attacker can construct a malicious or
> > misconfigured device (e.g. a crafted/emulated PCI device) that exposes
> > a bogus PLL configuration, causing state->mclk_khz to become zero.
> > Once nv3_get_param() calls nv3_arb(), the division by state->mclk_khz i=
n
> > the gns calculation causes a divide error and crashes the kernel.
> >
> > Fix this by checking whether state->mclk_khz is zero and bailing out be=
fore doing the division.
> >
> > The following log reveals it:
> >
> > rivafb: setting virtual Y resolution to 2184
> > divide error: 0000 [#1] PREEMPT SMP KASAN PTI
> > CPU: 0 PID: 2187 Comm: syz-executor.0 Not tainted 5.18.0-rc1+ #1
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-=
59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> > RIP: 0010:nv3_arb drivers/video/fbdev/riva/riva_hw.c:439 [inline]
> > RIP: 0010:nv3_get_param+0x3ab/0x13b0 drivers/video/fbdev/riva/riva_hw.c=
:546
> > Code: c1 e8 03 42 0f b6 14 38 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84=
 d2 0f 85 b7 0e 00 00 41 8b 46 18 01 d8 69 c0 40 42 0f 00 99 <41> f7 fc 48 =
63 c8 4c 89 e8 48 c1 e8 03 42 0f b6 14 38 4c 89 e8 83
> > RSP: 0018:ffff888013b2f318 EFLAGS: 00010206
> > RAX: 0000000001d905c0 RBX: 0000000000000016 RCX: 0000000000040000
> > RDX: 0000000000000000 RSI: 0000000000000080 RDI: ffff888013b2f6f0
> > RBP: 0000000000000002 R08: ffffffff82226288 R09: 0000000000000001
> > R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> > R13: ffff888013b2f4d8 R14: ffff888013b2f6d8 R15: dffffc0000000000
> > Call Trace:
> >    nv3CalcArbitration.constprop.0+0x255/0x460 drivers/video/fbdev/riva/=
riva_hw.c:603
> >    nv3UpdateArbitrationSettings drivers/video/fbdev/riva/riva_hw.c:637 =
[inline]
> >    CalcStateExt+0x447/0x1b90 drivers/video/fbdev/riva/riva_hw.c:1246
> >    riva_load_video_mode+0x8a9/0xea0 drivers/video/fbdev/riva/fbdev.c:77=
9
> >    rivafb_set_par+0xc0/0x5f0 drivers/video/fbdev/riva/fbdev.c:1196
>
> Doesn't it make sense to check mclk_khz (or the various variables which
> lead to mclk_khz) in rivafb_set_par() or any of the other functions menti=
oned
> in this trace?
> If in doubt, mclk_khz could be initialized to a sane value?
>
> Helge
>
>
> >    fb_set_var+0x604/0xeb0 drivers/video/fbdev/core/fbmem.c:1033
> >    do_fb_ioctl+0x234/0x670 drivers/video/fbdev/core/fbmem.c:1109
> >    fb_ioctl+0xdd/0x130 drivers/video/fbdev/core/fbmem.c:1188
> >    __x64_sys_ioctl+0x122/0x190 fs/ioctl.c:856
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >   drivers/video/fbdev/riva/riva_hw.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/video/fbdev/riva/riva_hw.c b/drivers/video/fbdev/r=
iva/riva_hw.c
> > index 8b829b720064..d70c6c4d28e8 100644
> > --- a/drivers/video/fbdev/riva/riva_hw.c
> > +++ b/drivers/video/fbdev/riva/riva_hw.c
> > @@ -436,6 +436,9 @@ static char nv3_arb(nv3_fifo_info * res_info, nv3_s=
im_state * state,  nv3_arb_in
> >       vmisses =3D 2;
> >       eburst_size =3D state->memory_width * 1;
> >       mburst_size =3D 32;
> > +     if (!state->mclk_khz)
> > +             return (0);
> > +
> >       gns =3D 1000000 * (gmisses*state->mem_page_miss + state->mem_late=
ncy)/state->mclk_khz;
> >       ainfo->by_gfacc =3D gns*ainfo->gdrain_rate/1000000;
> >       ainfo->wcmocc =3D 0;
>

