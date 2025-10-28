Return-Path: <stable+bounces-191526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B22AC16244
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 18:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C03E188A84F
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 17:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B695E25A633;
	Tue, 28 Oct 2025 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="BQhwnOat"
X-Original-To: stable@vger.kernel.org
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDB0221F20
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 17:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761672482; cv=none; b=TtGoLNQ0JiF0yCulubaopx2NWW24tmi9ciJYCTU8dsK2xj0u6AM07F3bh3LVNbm3WkccRI6alwXrTKhsKS5x4a6aUOz5EaTXIt7TRy9X4SzdTJsqLk4semmlQSptOQh5FzY7wJbRmG5vsd6lyeg5uto84ahAOU6C9hie9cYnAw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761672482; c=relaxed/simple;
	bh=8wquMDkIHq4Im1b0jco8M/fwii9bGnFoFZqwSeh30y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+jvJB4laJLrxr9B7TMDw2qvZeX8amgVEtVEvSDhXPygaCYSAC0wKOABL2z+Y7WiUb3yBsZnvIAtqrrcJOxfUXGspog+crVVRZKOSIvixgh0OCFh4x/uXzJVdn13mDORI70OYvZlxFeNWgl/e7Y9XDeev3C66rVNttpWZ1tp4FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=BQhwnOat; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id B02C3C880E
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 19:27:56 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id C9D38C883B
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 19:27:55 +0200 (EET)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 3D7CF2008B5
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 19:27:55 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1761672475;
	bh=HU9UoBsZbHguHWD5/Van7BmfUQKq6GqEPH0N/82zYvQ=;
	h=Received:From:Subject:To;
	b=BQhwnOatw1kLAiaQJ6jtAwF2QeaEVFSFyS392xlqu3AOp6q9Wli1zQDmjClVyK+/P
	 11yku91Pz19J5QF4QW9+b+yGNXJJm4PTA/X3nhoGjMQPJ9Msrntsmjy8jPqN0P8j3C
	 I/x98a++fMQDYJsiCwjI/fTFYLtFaheD45Kp0G4kFKcDUGdAaZVl/syfeKwyPb73MY
	 FQHWX+dNqyc6MAszrmHUJa5gnr/lTf2bTrbxCJ2+6Qpg48SwE0fH97u4RKRUkBXrFE
	 JNKRJ8Jb3k2UjsPfIkTvnvR2JFCoVeXDsYT1HA1pOjZa6AAZpe4vjjr4UiYmd79uB4
	 Lhe4UsdKoHLsQ==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.167.42) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lf1-f42.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-59303607a3aso4339636e87.0
        for <stable@vger.kernel.org>; Tue, 28 Oct 2025 10:27:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXY9mMyEu2S6oBJd7k6aZpKTvaoxTUPHHWl1IFm4UDPeQQvMhghRqVjmIVXZLGSlOkPiJf1vfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9vWBU0wQvBxNa8Fw7ARNGoQdIFX2VWWynoTzoxuiOr3BmJzpf
	aV864D9KqojwKIme7bGYiOrhRNo7+HabMEoyqSaobMghNFehaJI0LtS8U7aI1DHeamqN/KngJJX
	cos3138v8IUafo70lFVPC/J6U+7S8zzM=
X-Google-Smtp-Source: 
 AGHT+IHy0bQSvjL9vt4t1fRebvpa51jhls+H0tpgM+NyIsSmCqYDEqgqrovCxhPw24e+mMwJk/l4HHRkUnBcqxQWKzA=
X-Received: by 2002:a2e:a805:0:b0:376:2802:84ce with SMTP id
 38308e7fff4ca-37a052f8c58mr653481fa.47.1761672474783; Tue, 28 Oct 2025
 10:27:54 -0700 (PDT)
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
In-Reply-To: <eb749233-0342-49a9-a41b-6d18239eb1d9@linux.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 28 Oct 2025 18:27:42 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwEKzurj7qeAnzvWjJbf03da70ij5DtOJ7svZaoJ7vK=aA@mail.gmail.com>
X-Gm-Features: AWmQ_bkSaMOjigM12P8qgnp_UJNXlYwcZ6Aw14wC6rOeZBYojHWBPQG5b2veNn0
Message-ID: 
 <CAGwozwEKzurj7qeAnzvWjJbf03da70ij5DtOJ7svZaoJ7vK=aA@mail.gmail.com>
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
 <176167247545.3088139.17026513391022362802@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Mon, 27 Oct 2025 at 20:58, Matthew Schwartz
<matthew.schwartz@linux.dev> wrote:
>
> On 10/27/25 1:23 AM, Antheas Kapenekakis wrote:
> > On Mon, 27 Oct 2025 at 07:02, Matthew Schwartz
> > <matthew.schwartz@linux.dev> wrote:
> >>
> >>
> >>
> >>> On Oct 26, 2025, at 12:19=E2=80=AFPM, Antheas Kapenekakis <lkml@anthe=
as.dev> wrote:
> >>>
> >>> On Sun, 26 Oct 2025 at 20:16, Antheas Kapenekakis <lkml@antheas.dev> =
wrote:
> >>>>
> >>>> Bind the realtek codec to TAS2781 I2C audio amps on ASUS Xbox Ally
> >>>> projects. While these projects work without a quirk, adding it incre=
ases
> >>>> the output volume significantly.
> >>>
> >>> Also, if you can upstream the firmware files:
> >>> TAS2XXX13840.bin
> >>> TAS2XXX13841.bin
> >>> TAS2XXX13940.bin
> >>> TAS2XXX13941.bin
> >>
> >> This is the firmware at [1], correct? I=E2=80=99m testing the series w=
ith that firmware on my ROG Xbox Ally X, and I found something interesting.
> >>
> >> By default, with just your kernel patches and the firmware files hoste=
d at [1], my unit is loading:
> >>
> >> tas2781-hda i2c-TXNW2781:00-tas2781-hda.0: Loaded FW: TAS2XXX13840.bin=
, sha256: 58cffa36ae23a2d9b2349ecb6c1d4e89627934cd79218f6ada06eaffe6688246
> >>
> >> However, with this firmware file,  TAS2XXX13840.bin, there is signific=
ant audio clipping above 75% speaker level on my individual unit.
> >>
> >> Then, I tried renaming the other firmware file, TAS2XXX13841.bin, into=
 TAS2XXX13840.bin. Now my unit is loading:
> >>
> >> tas2781-hda i2c-TXNW2781:00-tas2781-hda.0: Loaded FW: TAS2XXX13840.bin=
, sha256: 0fda76e7142cb455df1860cfdb19bb3cb6871128b385595fe06b296a070f4b8c
> >>
> >> With this firmware file, audio is perfect all the way to 100% speaker =
level.
> >>
> >> If I recall, there have been other ASUS products that required matchin=
g amplifier hardware with firmware correctly, right? It looks like this mig=
ht be another case of since it seems my unit is loading the wrong firmware =
for its amplifiers.
> >
> > The original Ally X had a similar setup, yes.
> >
> > First patch might not be perfect and your speaker pin might be 1. My
> > Xbox Ally's pin is 1. It loads:
> > Loaded FW: TAS2XXX13941.bin, sha256:
> > 0fda76e7142cb455df1860cfdb19bb3cb6871128b385595fe06b296a070f4b8c
> >
> > And it sounds loud and crisp. So the pin is read.
> >
> > I had multiple users verify the X works, but perhaps it is not perfect
> > yet. Make sure you are not using a dsp that might be interfering
>
> Seems like there have been other reports similar to mine on Xbox Ally X, =
where flipping the firmware files by renaming them fixes sound issues for t=
hem.
>
> @TI, Maybe something is different with the conditional logic for the ROG =
Xbox Ally X? The current GPIO-detected speaker_id doesn't always correspond=
 to the correct firmware choice on this model it seems.

Yeah, it seems that specifically on the Xbox Ally X, the firmwares are
swapped around? What could be the case for that?

I had three users with popping and dropped audio swap the firmware on
their X and they said the other one fixed it. And another two without
issues swapping the firmware and saying it does not make a
quantifiable change.

Antheas


Antheas

> >
> > Antheas
> >
> >> Matt
> >>
> >> [1]: https://github.com/hhd-dev/hwfirm
> >>
> >>>
> >>> That would be great :)
> >>>
> >>> Antheas
> >>>
> >>>> Cc: stable@vger.kernel.org # 6.17
> >>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> >>>> ---
> >>>> sound/hda/codecs/realtek/alc269.c | 2 ++
> >>>> 1 file changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/re=
altek/alc269.c
> >>>> index 8ad5febd822a..d1ad84eee6d1 100644
> >>>> --- a/sound/hda/codecs/realtek/alc269.c
> >>>> +++ b/sound/hda/codecs/realtek/alc269.c
> >>>> @@ -6713,6 +6713,8 @@ static const struct hda_quirk alc269_fixup_tbl=
[] =3D {
> >>>>        SND_PCI_QUIRK(0x1043, 0x12f0, "ASUS X541UV", ALC256_FIXUP_ASU=
S_MIC_NO_PRESENCE),
> >>>>        SND_PCI_QUIRK(0x1043, 0x1313, "Asus K42JZ", ALC269VB_FIXUP_AS=
US_MIC_NO_PRESENCE),
> >>>>        SND_PCI_QUIRK(0x1043, 0x1314, "ASUS GA605K", ALC285_FIXUP_ASU=
S_GA605K_HEADSET_MIC),
> >>>> +       SND_PCI_QUIRK(0x1043, 0x1384, "ASUS RC73XA", ALC287_FIXUP_TX=
NW2781_I2C),
> >>>> +       SND_PCI_QUIRK(0x1043, 0x1394, "ASUS RC73YA", ALC287_FIXUP_TX=
NW2781_I2C),
> >>>>        SND_PCI_QUIRK(0x1043, 0x13b0, "ASUS Z550SA", ALC256_FIXUP_ASU=
S_MIC_NO_PRESENCE),
> >>>>        SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_=
FIXUP_ASUS_ZENBOOK),
> >>>>        SND_PCI_QUIRK(0x1043, 0x1433, "ASUS GX650PY/PZ/PV/PU/PYV/PZV/=
PIV/PVV", ALC285_FIXUP_ASUS_I2C_HEADSET_MIC),
> >>>> --
> >>>> 2.51.1
> >>>>
> >>>>
> >>>
> >>>
> >>
> >>
> >
>
>


