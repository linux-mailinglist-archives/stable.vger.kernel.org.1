Return-Path: <stable+bounces-189938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3024AC0C52E
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 09:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9B64B3473AC
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 08:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C185B2E8E10;
	Mon, 27 Oct 2025 08:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="f4jNIdl4"
X-Original-To: stable@vger.kernel.org
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C575229DB86
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 08:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554080; cv=none; b=Ueydipk00uZtnOWUcnQSR6Dghu2sVKXr/Jw8lEz+rOnSM+iOjzJWrP9HNJHi+lFm5Xo8HMHxeiPkaJ6Z7lgSNxY81tmByHvyUPfZdbVcAWwVwuGq2QZAxq1DB2KeYmrYtWhkdy2tP4uv3xvsVxnVyzw9OCaLuvIztm3f3uTZZWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554080; c=relaxed/simple;
	bh=C6DuS6khdSzTLBc1qnT3CBBz4b9mTwrsccfpDKu/4lE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EhxBn96EIyctuhluSKsgpOgQrpIHwNHe9dVAnBbHMrsGOogUMjjqaGJH/eGo4fbzuQgDmGx5Q0ltQkFcONz+M4ZLNGMAMlCrTC2hwq3Gy0s3i4NYixrSTLwpzD6/WsElFAfMUzH4cKtSfUHLdyJW391HTH14AJFBC2k2c6qsvWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=f4jNIdl4; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id D369B42933
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 10:34:35 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 0C6644265F
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 10:34:35 +0200 (EET)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 599341FE9DE
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 10:34:34 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1761554074;
	bh=o245JY/HeDSM3dcCLVqmKK/Oj4MHPHb0LGkJmADaEF0=;
	h=Received:From:Subject:To;
	b=f4jNIdl4vgTkEf+5N/Lr8mUrntKmwfvAfWZqcQe52+bZHN5/zO8zk0gsS5yYgnrAG
	 cIN0Q1kjnngC9nW73CSeOxn/FoDLvT2b5FbUjN4aj7dNTLnbDJNzxdTy+msCQlsQyi
	 IgA746qtHvXf3Hcxacb8dx2e5vs9j74PKyKa+jSd50GZqf5RLtuFlS2mm+KtZauwnx
	 o0rg1Yf4ozNf75hFGcoEurujQ36Z2o4JHY89y2TrUYmpijUkG1YRts98mRT6cgVOOb
	 jTBwVfj0o5l5WTBj6pccZvLPPI9hIM0sJbXuN1UJMpjMDElAMPO9Be/s7iwtX9FywD
	 p7AAUfqsfWs/g==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.179) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f179.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-3761e5287c9so52079291fa.2
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 01:34:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ+GnOeLA3I5ChQfERfQbLlshGofvE3TAON2dUVo5fUnXE8jBiOeRdg3VfQ56eAEzUs375bXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6/7eI6hDJ694AELQfymATe0OqG71uDV27PWDrEIxE7fOXhicx
	cUnWM9E/TjgJ6NSKXxpP2oHHQYEO+Ma7SCrgddGFG+OT4Y2JgDdgSGK2GDzhthh+OhfdurKWXrY
	hmcBjDqQ/qITa+fKPqd4HX+SJ5xLFiY0=
X-Google-Smtp-Source: 
 AGHT+IH0CBaIS6dsKE6LFWhp6Pd2Rr/eQNT5RTffVCMTh2qW4zMR0Pd9VQ9fUchPl9B2w9m99WZ7CniJpzj8vao/+yk=
X-Received: by 2002:a2e:a801:0:b0:36c:7a76:d17a with SMTP id
 38308e7fff4ca-3779782d1e8mr108927001fa.9.1761554073908; Mon, 27 Oct 2025
 01:34:33 -0700 (PDT)
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
 <CAGwozwFtah66p=5oy9rf5phVGdDTiWg0WuJBT3qGpWdP3A62Pg@mail.gmail.com>
In-Reply-To: 
 <CAGwozwFtah66p=5oy9rf5phVGdDTiWg0WuJBT3qGpWdP3A62Pg@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 27 Oct 2025 09:34:21 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwE0gu1f+EQ9_xN_hQj3OCRRNd8t3F0BpDau9V8Au04Tqg@mail.gmail.com>
X-Gm-Features: AWmQ_bm85B0TDchtQOOa1HpwV5i2MowPnQPS2FAHdClALsEjFj_SH97joL4-pYM
Message-ID: 
 <CAGwozwE0gu1f+EQ9_xN_hQj3OCRRNd8t3F0BpDau9V8Au04Tqg@mail.gmail.com>
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
 <176155407460.33163.8379052739084380287@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Mon, 27 Oct 2025 at 09:23, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>
> On Mon, 27 Oct 2025 at 07:02, Matthew Schwartz
> <matthew.schwartz@linux.dev> wrote:
> >
> >
> >
> > > On Oct 26, 2025, at 12:19=E2=80=AFPM, Antheas Kapenekakis <lkml@anthe=
as.dev> wrote:
> > >
> > > On Sun, 26 Oct 2025 at 20:16, Antheas Kapenekakis <lkml@antheas.dev> =
wrote:
> > >>
> > >> Bind the realtek codec to TAS2781 I2C audio amps on ASUS Xbox Ally
> > >> projects. While these projects work without a quirk, adding it incre=
ases
> > >> the output volume significantly.
> > >
> > > Also, if you can upstream the firmware files:
> > > TAS2XXX13840.bin
> > > TAS2XXX13841.bin
> > > TAS2XXX13940.bin
> > > TAS2XXX13941.bin
> >
> > This is the firmware at [1], correct? I=E2=80=99m testing the series wi=
th that firmware on my ROG Xbox Ally X, and I found something interesting.
> >
> > By default, with just your kernel patches and the firmware files hosted=
 at [1], my unit is loading:
> >
> > tas2781-hda i2c-TXNW2781:00-tas2781-hda.0: Loaded FW: TAS2XXX13840.bin,=
 sha256: 58cffa36ae23a2d9b2349ecb6c1d4e89627934cd79218f6ada06eaffe6688246
> >
> > However, with this firmware file,  TAS2XXX13840.bin, there is significa=
nt audio clipping above 75% speaker level on my individual unit.
> >
> > Then, I tried renaming the other firmware file, TAS2XXX13841.bin, into =
TAS2XXX13840.bin. Now my unit is loading:
> >
> > tas2781-hda i2c-TXNW2781:00-tas2781-hda.0: Loaded FW: TAS2XXX13840.bin,=
 sha256: 0fda76e7142cb455df1860cfdb19bb3cb6871128b385595fe06b296a070f4b8c
> >
> > With this firmware file, audio is perfect all the way to 100% speaker l=
evel.
> >
> > If I recall, there have been other ASUS products that required matching=
 amplifier hardware with firmware correctly, right? It looks like this migh=
t be another case of since it seems my unit is loading the wrong firmware f=
or its amplifiers.
>
> The original Ally X had a similar setup, yes.
>
> First patch might not be perfect and your speaker pin might be 1. My
> Xbox Ally's pin is 1. It loads:
> Loaded FW: TAS2XXX13941.bin, sha256:
> 0fda76e7142cb455df1860cfdb19bb3cb6871128b385595fe06b296a070f4b8c
>
> And it sounds loud and crisp. So the pin is read.
>
> I had multiple users verify the X works, but perhaps it is not perfect
> yet. Make sure you are not using a dsp that might be interfering
>
> Antheas
>
> > Matt
> >
> > [1]: https://github.com/hhd-dev/hwfirm

[1] is straight from the windows driver with no renaming

> > >
> > > That would be great :)
> > >
> > > Antheas
> > >
> > >> Cc: stable@vger.kernel.org # 6.17
> > >> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > >> ---
> > >> sound/hda/codecs/realtek/alc269.c | 2 ++
> > >> 1 file changed, 2 insertions(+)
> > >>
> > >> diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/re=
altek/alc269.c
> > >> index 8ad5febd822a..d1ad84eee6d1 100644
> > >> --- a/sound/hda/codecs/realtek/alc269.c
> > >> +++ b/sound/hda/codecs/realtek/alc269.c
> > >> @@ -6713,6 +6713,8 @@ static const struct hda_quirk alc269_fixup_tbl=
[] =3D {
> > >>        SND_PCI_QUIRK(0x1043, 0x12f0, "ASUS X541UV", ALC256_FIXUP_ASU=
S_MIC_NO_PRESENCE),
> > >>        SND_PCI_QUIRK(0x1043, 0x1313, "Asus K42JZ", ALC269VB_FIXUP_AS=
US_MIC_NO_PRESENCE),
> > >>        SND_PCI_QUIRK(0x1043, 0x1314, "ASUS GA605K", ALC285_FIXUP_ASU=
S_GA605K_HEADSET_MIC),
> > >> +       SND_PCI_QUIRK(0x1043, 0x1384, "ASUS RC73XA", ALC287_FIXUP_TX=
NW2781_I2C),
> > >> +       SND_PCI_QUIRK(0x1043, 0x1394, "ASUS RC73YA", ALC287_FIXUP_TX=
NW2781_I2C),
> > >>        SND_PCI_QUIRK(0x1043, 0x13b0, "ASUS Z550SA", ALC256_FIXUP_ASU=
S_MIC_NO_PRESENCE),
> > >>        SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_=
FIXUP_ASUS_ZENBOOK),
> > >>        SND_PCI_QUIRK(0x1043, 0x1433, "ASUS GX650PY/PZ/PV/PU/PYV/PZV/=
PIV/PVV", ALC285_FIXUP_ASUS_I2C_HEADSET_MIC),
> > >> --
> > >> 2.51.1
> > >>
> > >>
> > >
> > >
> >
> >


