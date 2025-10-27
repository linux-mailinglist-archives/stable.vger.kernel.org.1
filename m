Return-Path: <stable+bounces-189937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6521EC0C481
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 09:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0354834039A
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 08:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDDC2E7198;
	Mon, 27 Oct 2025 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="bB/HPKJS"
X-Original-To: stable@vger.kernel.org
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166FC2E716A
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 08:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553405; cv=none; b=U56LwxlkHzzY50rMJ094TI5pJt97M1kZdN1sFp3XT7zYr4x5xntRf6K3D8tPTGWyv2qJDV9UTaD4bNw5POKVdZ6Mzkmz/RHeyl9F2DRHtRSR6b1KipqK5QVQRZ8MANaQ+kvzgD7AN1MC9b1fpD8BVeYrHQBBRYah+DQdqPXgWMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553405; c=relaxed/simple;
	bh=YEp7967Xa/06BcL8MWfSkzpGtDo5NycWkfludFawSnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLEUOGmEWc+YsumCLzdQuiVK0zw3PfzWel/cJmwin119vZpqu/vc9SB//9kkusX18ZWg3TWNCNVjLPutMGNL5oioGHv8S/ZyupyK3CcesUtRaVj2/pgMMMpDKHLnCG17lJaG5OQZYSgJ5oYJXos41OqRyCtyLz8WYtjtO4JRnps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=bB/HPKJS; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 26256BDBB0
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 10:23:20 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 4087FBDB5B
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 10:23:19 +0200 (EET)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id BA7431FE8BD
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 10:23:18 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1761553399;
	bh=C4ndRWKnTrO/9RTcVK/h8dR1CxyvCTlmymVM5anKv60=;
	h=Received:From:Subject:To;
	b=bB/HPKJS93VrBDAV322HjTlJPtxdaPhP7iEjM2vFrwfBMJ+HpdwHMq0LEveT1ZDdt
	 dI8Kc7idrzR9GlhJuK/hbdgfHDFHwzHbYOVILUpp0HZ8KbN5KTwoV/8OpGRzQDb/pU
	 uQIo9ZkAFyND36ogE7mwaKgpyCSz5SmEmkx0hu7rwQyEg6SsYpcDGwzuPAREE50XXb
	 XOIlKX+WbrlMi1RdZAVRsTgVRBhUgk+SZm6BJH5cdyhNph6ph5b+sgLYBiJGW06o3x
	 bgzW95ITuAtpeQTOVBpglYnBzLuN78/FDxSVm0SnTocPXIUcI3wRgSzSg4Dh1mcVfc
	 NGreIgpmUYqlQ==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.175) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f175.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-378d6fa5aebso48215961fa.2
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 01:23:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCV0DLieJho+zIzqf+DQ4OG28Sg3TTmEE9EMg67576w05DqwoqHy5KR1e39fVDn9ydFzjpy0vRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrh/h1be0fal0caHAtpW2K3UUGpRyxq/r6gwUgbF/LKOzBe0t8
	QKwuop2mvjZJEqUQZNUIA51aWeC5rnIrBOAIap1nJTXG2UBqzCG9kKYMlY3QioxbcWIKywcZJDS
	vkEtEWISecp7AZVajBXWRA0VSZkiCW0Q=
X-Google-Smtp-Source: 
 AGHT+IFnw5YlPbs4UT/rVayD1Wc1YYfwG3Rn1tmxpyQFWkATDUzZX/lTIZZ0JQb5sEz2HZuizVHTAKbpJEc+9L01NiY=
X-Received: by 2002:a2e:b8c5:0:b0:378:e84c:d15d with SMTP id
 38308e7fff4ca-378e84cf802mr29244341fa.12.1761553398209; Mon, 27 Oct 2025
 01:23:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026191635.2447593-1-lkml@antheas.dev>
 <20251026191635.2447593-2-lkml@antheas.dev>
 <CAGwozwEwPj9VRRo2U50ccg=_qSM7p-1c_hw2y=OYA-pFc=p13w@mail.gmail.com>
 <35A5783A-CA60-4B10-8C7B-5820B65307FE@linux.dev>
In-Reply-To: <35A5783A-CA60-4B10-8C7B-5820B65307FE@linux.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 27 Oct 2025 09:23:05 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwFtah66p=5oy9rf5phVGdDTiWg0WuJBT3qGpWdP3A62Pg@mail.gmail.com>
X-Gm-Features: AWmQ_bmcMAbS2COtf6aWdSaATJGAcXDZABokpndxSIpaBG3ZNqKN57EWd_EDXE4
Message-ID: 
 <CAGwozwFtah66p=5oy9rf5phVGdDTiWg0WuJBT3qGpWdP3A62Pg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] ALSA: hda/realtek: Add match for ASUS Xbox Ally
 projects
To: Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Baojun Xu <baojun.xu@ti.com>,
	Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <176155339896.4187886.4862429391053939374@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Mon, 27 Oct 2025 at 07:02, Matthew Schwartz
<matthew.schwartz@linux.dev> wrote:
>
>
>
> > On Oct 26, 2025, at 12:19=E2=80=AFPM, Antheas Kapenekakis <lkml@antheas=
.dev> wrote:
> >
> > On Sun, 26 Oct 2025 at 20:16, Antheas Kapenekakis <lkml@antheas.dev> wr=
ote:
> >>
> >> Bind the realtek codec to TAS2781 I2C audio amps on ASUS Xbox Ally
> >> projects. While these projects work without a quirk, adding it increas=
es
> >> the output volume significantly.
> >
> > Also, if you can upstream the firmware files:
> > TAS2XXX13840.bin
> > TAS2XXX13841.bin
> > TAS2XXX13940.bin
> > TAS2XXX13941.bin
>
> This is the firmware at [1], correct? I=E2=80=99m testing the series with=
 that firmware on my ROG Xbox Ally X, and I found something interesting.
>
> By default, with just your kernel patches and the firmware files hosted a=
t [1], my unit is loading:
>
> tas2781-hda i2c-TXNW2781:00-tas2781-hda.0: Loaded FW: TAS2XXX13840.bin, s=
ha256: 58cffa36ae23a2d9b2349ecb6c1d4e89627934cd79218f6ada06eaffe6688246
>
> However, with this firmware file,  TAS2XXX13840.bin, there is significant=
 audio clipping above 75% speaker level on my individual unit.
>
> Then, I tried renaming the other firmware file, TAS2XXX13841.bin, into TA=
S2XXX13840.bin. Now my unit is loading:
>
> tas2781-hda i2c-TXNW2781:00-tas2781-hda.0: Loaded FW: TAS2XXX13840.bin, s=
ha256: 0fda76e7142cb455df1860cfdb19bb3cb6871128b385595fe06b296a070f4b8c
>
> With this firmware file, audio is perfect all the way to 100% speaker lev=
el.
>
> If I recall, there have been other ASUS products that required matching a=
mplifier hardware with firmware correctly, right? It looks like this might =
be another case of since it seems my unit is loading the wrong firmware for=
 its amplifiers.

The original Ally X had a similar setup, yes.

First patch might not be perfect and your speaker pin might be 1. My
Xbox Ally's pin is 1. It loads:
Loaded FW: TAS2XXX13941.bin, sha256:
0fda76e7142cb455df1860cfdb19bb3cb6871128b385595fe06b296a070f4b8c

And it sounds loud and crisp. So the pin is read.

I had multiple users verify the X works, but perhaps it is not perfect
yet. Make sure you are not using a dsp that might be interfering

Antheas

> Matt
>
> [1]: https://github.com/hhd-dev/hwfirm
>
> >
> > That would be great :)
> >
> > Antheas
> >
> >> Cc: stable@vger.kernel.org # 6.17
> >> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> >> ---
> >> sound/hda/codecs/realtek/alc269.c | 2 ++
> >> 1 file changed, 2 insertions(+)
> >>
> >> diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/real=
tek/alc269.c
> >> index 8ad5febd822a..d1ad84eee6d1 100644
> >> --- a/sound/hda/codecs/realtek/alc269.c
> >> +++ b/sound/hda/codecs/realtek/alc269.c
> >> @@ -6713,6 +6713,8 @@ static const struct hda_quirk alc269_fixup_tbl[]=
 =3D {
> >>        SND_PCI_QUIRK(0x1043, 0x12f0, "ASUS X541UV", ALC256_FIXUP_ASUS_=
MIC_NO_PRESENCE),
> >>        SND_PCI_QUIRK(0x1043, 0x1313, "Asus K42JZ", ALC269VB_FIXUP_ASUS=
_MIC_NO_PRESENCE),
> >>        SND_PCI_QUIRK(0x1043, 0x1314, "ASUS GA605K", ALC285_FIXUP_ASUS_=
GA605K_HEADSET_MIC),
> >> +       SND_PCI_QUIRK(0x1043, 0x1384, "ASUS RC73XA", ALC287_FIXUP_TXNW=
2781_I2C),
> >> +       SND_PCI_QUIRK(0x1043, 0x1394, "ASUS RC73YA", ALC287_FIXUP_TXNW=
2781_I2C),
> >>        SND_PCI_QUIRK(0x1043, 0x13b0, "ASUS Z550SA", ALC256_FIXUP_ASUS_=
MIC_NO_PRESENCE),
> >>        SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FI=
XUP_ASUS_ZENBOOK),
> >>        SND_PCI_QUIRK(0x1043, 0x1433, "ASUS GX650PY/PZ/PV/PU/PYV/PZV/PI=
V/PVV", ALC285_FIXUP_ASUS_I2C_HEADSET_MIC),
> >> --
> >> 2.51.1
> >>
> >>
> >
> >
>
>


