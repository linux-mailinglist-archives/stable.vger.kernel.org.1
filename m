Return-Path: <stable+bounces-192074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EA0C29409
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 18:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4353B347798
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 17:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834792DEA77;
	Sun,  2 Nov 2025 17:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="OuZo8iME"
X-Original-To: stable@vger.kernel.org
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFB42DF151
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762104854; cv=none; b=OaGWnvYt0r59IBs4lzeaGj2el6fME5y3VNIDzQaK5Gw37h5mQXPX8mKy1RkG/cH+tj9bvbwKj5IiSK9+XfDQpwF6DZbR8fFE6hTQSCnwdrEK+NSwFo6R7cOk1yLwBIPA45jYqsMeEyyFihO0trZgkPEma5LPjJY8ZpfnOHZVUSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762104854; c=relaxed/simple;
	bh=csvdvzB/2xawTZMXb5SbTVOQRr38OXUL2bB899eOBkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWfONYjpiFbGo8kWLS2KJSdztby1cafIXe+gCZbIwzROfvUFdpqSSQtL3ptjQQM3OISmdFLzJY6r5cAYJTgELbt5vgtKhm5ncNGbP5Dxyh9b4evD/rCdLVKnMVoMbZ/lPWHMruZlOFnU2L7RV9dNNCKZZB5pfgeLsEpTeOC79TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=OuZo8iME; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id C75F83F629
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 19:33:57 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 8DA053F7E0
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 19:33:56 +0200 (EET)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id B5E8C1FE172
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 19:33:55 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1762104836;
	bh=/ecRt3m8g8LRRa0zGfDiPLHt9Ca2vaZbSX8HFFw3eck=;
	h=Received:From:Subject:To;
	b=OuZo8iMEnWB2+fTxsE6ooo+mS95fB89Q+SxirQpGyS1TANOcTmB/u/Rmhb6kkUb5/
	 jTXndMN7wlFBuSmLlsFf6VqhrtWiJ8SZFZLgPDdL3n2cbsUFZHz3v9l3uBtD+AjgLr
	 qBHhctzLXP4OAOI4iZkpZc5vxnZSDzCWZXJHIXeQqlz4kDYOPT94El+ZWzEX/vzGJ5
	 z/2chESE0nOEbxl777vVQDG1b3uP3nBfu7dNX1aYpOZVfcPGLw2XhBbfEpTMeyqw4j
	 d9L1QThCNL6D6BU8kZRGW9Zb2HCnyx4fq0Uu4L2U9zi2Iyy56Sx9XIAybBd3t3zFEt
	 8F3uMcN4ifopg==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.171) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f171.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f171.google.com with SMTP id
 38308e7fff4ca-37a2d9cf22aso9953171fa.1
        for <stable@vger.kernel.org>; Sun, 02 Nov 2025 09:33:55 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVoeeQrBzuQPbRppaCK/KHFxT8/zS5tFySRk+6psplQ6la7CauN1lZYu3nloBdV1ooekuIhki8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn38/aqU0jVL9ddYSWterRJB1gE46HI0xcT0W5pQfK7CwZPaMD
	dnySmGDV04OP7fhGxNI6ikmoZRUQtqdfNe8vqgJuinWSyU3NofO7HnCVpWzilbyiaRiIs5YrCG0
	jUcV+upPwXWZYBT5ZX/DrxZogmgsOS2o=
X-Google-Smtp-Source: 
 AGHT+IEGlHjrKlW8BbNvyBrM2cKx8XMFsCM4baG3D7IPUoKbq0P8QCIFfSjxzfeimt+tSsmI7Gcle+nvMES8ubT3qWY=
X-Received: by 2002:a05:651c:409b:b0:378:cddd:ca69 with SMTP id
 38308e7fff4ca-37a18de650fmr21154871fa.18.1762104835171; Sun, 02 Nov 2025
 09:33:55 -0800 (PST)
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
 <eb749233-0342-49a9-a41b-6d18239eb1d9@linux.dev>
 <CAGwozwEKzurj7qeAnzvWjJbf03da70ij5DtOJ7svZaoJ7vK=aA@mail.gmail.com>
In-Reply-To: 
 <CAGwozwEKzurj7qeAnzvWjJbf03da70ij5DtOJ7svZaoJ7vK=aA@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sun, 2 Nov 2025 18:33:43 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwEErv_cLxsP93n0oj20E03oPOk9-5v31mVnf_Adwjkwgg@mail.gmail.com>
X-Gm-Features: AWmQ_bnTPDss_CEbonmSuzDG7b2Mn6vqtAhYXIVulFyiLqPKqfnnMiKOPfzjs_A
Message-ID: 
 <CAGwozwEErv_cLxsP93n0oj20E03oPOk9-5v31mVnf_Adwjkwgg@mail.gmail.com>
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
 <176210483597.1725082.5867876194630745908@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Tue, 28 Oct 2025 at 18:27, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>
> On Mon, 27 Oct 2025 at 20:58, Matthew Schwartz
> <matthew.schwartz@linux.dev> wrote:
> >
> > On 10/27/25 1:23 AM, Antheas Kapenekakis wrote:
> > > On Mon, 27 Oct 2025 at 07:02, Matthew Schwartz
> > > <matthew.schwartz@linux.dev> wrote:
> > >>
> > >>
> > >>
> > >>> On Oct 26, 2025, at 12:19=E2=80=AFPM, Antheas Kapenekakis <lkml@ant=
heas.dev> wrote:
> > >>>
> > >>> On Sun, 26 Oct 2025 at 20:16, Antheas Kapenekakis <lkml@antheas.dev=
> wrote:
> > >>>>
> > >>>> Bind the realtek codec to TAS2781 I2C audio amps on ASUS Xbox Ally
> > >>>> projects. While these projects work without a quirk, adding it inc=
reases
> > >>>> the output volume significantly.
> > >>>
> > >>> Also, if you can upstream the firmware files:
> > >>> TAS2XXX13840.bin
> > >>> TAS2XXX13841.bin
> > >>> TAS2XXX13940.bin
> > >>> TAS2XXX13941.bin
> > >>
> > >> This is the firmware at [1], correct? I=E2=80=99m testing the series=
 with that firmware on my ROG Xbox Ally X, and I found something interestin=
g.
> > >>
> > >> By default, with just your kernel patches and the firmware files hos=
ted at [1], my unit is loading:
> > >>
> > >> tas2781-hda i2c-TXNW2781:00-tas2781-hda.0: Loaded FW: TAS2XXX13840.b=
in, sha256: 58cffa36ae23a2d9b2349ecb6c1d4e89627934cd79218f6ada06eaffe668824=
6
> > >>
> > >> However, with this firmware file,  TAS2XXX13840.bin, there is signif=
icant audio clipping above 75% speaker level on my individual unit.
> > >>
> > >> Then, I tried renaming the other firmware file, TAS2XXX13841.bin, in=
to TAS2XXX13840.bin. Now my unit is loading:
> > >>
> > >> tas2781-hda i2c-TXNW2781:00-tas2781-hda.0: Loaded FW: TAS2XXX13840.b=
in, sha256: 0fda76e7142cb455df1860cfdb19bb3cb6871128b385595fe06b296a070f4b8=
c
> > >>
> > >> With this firmware file, audio is perfect all the way to 100% speake=
r level.
> > >>
> > >> If I recall, there have been other ASUS products that required match=
ing amplifier hardware with firmware correctly, right? It looks like this m=
ight be another case of since it seems my unit is loading the wrong firmwar=
e for its amplifiers.
> > >
> > > The original Ally X had a similar setup, yes.
> > >
> > > First patch might not be perfect and your speaker pin might be 1. My
> > > Xbox Ally's pin is 1. It loads:
> > > Loaded FW: TAS2XXX13941.bin, sha256:
> > > 0fda76e7142cb455df1860cfdb19bb3cb6871128b385595fe06b296a070f4b8c
> > >
> > > And it sounds loud and crisp. So the pin is read.
> > >
> > > I had multiple users verify the X works, but perhaps it is not perfec=
t
> > > yet. Make sure you are not using a dsp that might be interfering
> >
> > Seems like there have been other reports similar to mine on Xbox Ally X=
, where flipping the firmware files by renaming them fixes sound issues for=
 them.
> >
> > @TI, Maybe something is different with the conditional logic for the RO=
G Xbox Ally X? The current GPIO-detected speaker_id doesn't always correspo=
nd to the correct firmware choice on this model it seems.
>
> Yeah, it seems that specifically on the Xbox Ally X, the firmwares are
> swapped around? What could be the case for that?
>
> I had three users with popping and dropped audio swap the firmware on
> their X and they said the other one fixed it. And another two without
> issues swapping the firmware and saying it does not make a
> quantifiable change.

Update on this. Users with a pin value of 1 are happy with the 1
firmware. Users with a value of 0 are not happy with TAS2XXX13840 and
TAS2XXX13841 works better for them. Moreover, users of the 1 firmware
are not happy with the 0 firmware.

This is just on the Ally X, on the normal Ally there are no issues.

So there is an issue with TAS2XXX13840 on the linux side, TAS2XXX13841
is correctly selected.

Antheas

> Antheas
>
>
> Antheas
>
> > >
> > > Antheas
> > >
> > >> Matt
> > >>
> > >> [1]: https://github.com/hhd-dev/hwfirm
> > >>
> > >>>
> > >>> That would be great :)
> > >>>
> > >>> Antheas
> > >>>
> > >>>> Cc: stable@vger.kernel.org # 6.17
> > >>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > >>>> ---
> > >>>> sound/hda/codecs/realtek/alc269.c | 2 ++
> > >>>> 1 file changed, 2 insertions(+)
> > >>>>
> > >>>> diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/=
realtek/alc269.c
> > >>>> index 8ad5febd822a..d1ad84eee6d1 100644
> > >>>> --- a/sound/hda/codecs/realtek/alc269.c
> > >>>> +++ b/sound/hda/codecs/realtek/alc269.c
> > >>>> @@ -6713,6 +6713,8 @@ static const struct hda_quirk alc269_fixup_t=
bl[] =3D {
> > >>>>        SND_PCI_QUIRK(0x1043, 0x12f0, "ASUS X541UV", ALC256_FIXUP_A=
SUS_MIC_NO_PRESENCE),
> > >>>>        SND_PCI_QUIRK(0x1043, 0x1313, "Asus K42JZ", ALC269VB_FIXUP_=
ASUS_MIC_NO_PRESENCE),
> > >>>>        SND_PCI_QUIRK(0x1043, 0x1314, "ASUS GA605K", ALC285_FIXUP_A=
SUS_GA605K_HEADSET_MIC),
> > >>>> +       SND_PCI_QUIRK(0x1043, 0x1384, "ASUS RC73XA", ALC287_FIXUP_=
TXNW2781_I2C),
> > >>>> +       SND_PCI_QUIRK(0x1043, 0x1394, "ASUS RC73YA", ALC287_FIXUP_=
TXNW2781_I2C),
> > >>>>        SND_PCI_QUIRK(0x1043, 0x13b0, "ASUS Z550SA", ALC256_FIXUP_A=
SUS_MIC_NO_PRESENCE),
> > >>>>        SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269V=
B_FIXUP_ASUS_ZENBOOK),
> > >>>>        SND_PCI_QUIRK(0x1043, 0x1433, "ASUS GX650PY/PZ/PV/PU/PYV/PZ=
V/PIV/PVV", ALC285_FIXUP_ASUS_I2C_HEADSET_MIC),
> > >>>> --
> > >>>> 2.51.1
> > >>>>
> > >>>>
> > >>>
> > >>>
> > >>
> > >>
> > >
> >
> >


