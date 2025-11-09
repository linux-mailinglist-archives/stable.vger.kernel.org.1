Return-Path: <stable+bounces-192832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9B5C43AB0
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 10:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4873C3B226A
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 09:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7F725C6E2;
	Sun,  9 Nov 2025 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="JGb/aHDe"
X-Original-To: stable@vger.kernel.org
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28245283C82
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 09:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762680355; cv=none; b=cfZfTw8NqLVSLejIpOP8KRqCe4Oj27SwXsYmeOUsfF9P2xAPllsjKaC9ZVXi/eYdxpXHyU97Gv1FG7n3oNxrZv3slyhbOp2YVeEUAFMJywWUpmHHYP1lelE13xANxOixV4hTo57xwxKF9Jx/WY5+jUm43Jr2fWEi9HxQGZ+CbdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762680355; c=relaxed/simple;
	bh=fMR63XBK9ZlriTE0ZDeJLOmInWjWXLWqMngtqubhF24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LkATBFN3KOJijZp+njM0lekND4l0886vLdL/uj72Z+sSnrAfEBtYsctG8ayA1kOlEDtMixNSu1wC2AHJEYf8eOErcWuA+9soOsYo+a/eIAZR65ZlwAJyXYiq67C1f4l/bK3TFIaOzGEAYY4z84DoGAY4DxqKtTiXvf+yR5lmRHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=JGb/aHDe; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 90DE2BCF39
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 11:19:40 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 9A4CEBDA81
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 11:19:39 +0200 (EET)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 198FC201C36
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 11:19:39 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1762679979;
	bh=aHykRTlntzOAtSbrXc2NFUXApwbab2EgevFPlL/otC4=;
	h=Received:From:Subject:To;
	b=JGb/aHDepfxqrZ1EN0b71HRAfduGqFJLCi1tQ3AF7IPBlZUHl0IMomdnLk9ih05ge
	 igACdFXxFmsxa5iuYp1Y7PwMiqjuzRwdBugfNXKQtU5lWeVsUmkcRu1mGVbe8RRk7C
	 YD81UNs6SWZ52Hnp3ABkRPa0CKAo0kTHdmWCethufIv0cFE2UKSUpoEryO9IOHVMTn
	 LlI1shI70Jec4V0/N/NyjG6rag1ZjfAED46RPime0yAw0aZt1D+BFzJ2b1exPmDfj+
	 MhkzLYDGHF7kzpvv0M9hbZiYU1HiWzInMCMCVTdHT1km3VZEP2oiWLtuCMmEAQMT7o
	 VMR2QA9N0kxKQ==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.169) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f169.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-3737d09d123so25855811fa.2
        for <stable@vger.kernel.org>; Sun, 09 Nov 2025 01:19:39 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWLFvcGhlLBxc0uTjzVDHL7oVXgePqG6e+MswJEyGCEoZyEAnKfNiHdr+Rtdky6v5sahEHqtMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YznBURymLxHVSuTDWddpU3SvN7nMRRQ5KleCtrGcED6pJ7e683d
	pkcZiwe/86ThofaCPn6DpexuHmuyRDnlTKvJ0Srzss64t5JzGUSYgVDbMkUamkO0JTjQcqJNf8j
	g4+MQ1uej2PRUFbO5oysxUpA0wSaavhU=
X-Google-Smtp-Source: 
 AGHT+IGfOzfusw+YUcgI7nYoTAG/l7L87WbQXvWz1J5w/4xf6lmp0H1CggvyuL0ow/5G8QOuuYYtSsSGpmyEH4rSRT4=
X-Received: by 2002:a05:651c:2542:10b0:36e:93a3:979d with SMTP id
 38308e7fff4ca-37a7b1bc4a1mr11465251fa.19.1762679978426; Sun, 09 Nov 2025
 01:19:38 -0800 (PST)
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
 <CAGwozwEErv_cLxsP93n0oj20E03oPOk9-5v31mVnf_Adwjkwgg@mail.gmail.com>
In-Reply-To: 
 <CAGwozwEErv_cLxsP93n0oj20E03oPOk9-5v31mVnf_Adwjkwgg@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sun, 9 Nov 2025 10:19:27 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwH_eUqErMsmyBsC6eMFTaHTbukkX68ZJO4MUqa_StiNUg@mail.gmail.com>
X-Gm-Features: AWmQ_bl5Uaf_UCaGYstqmpIABlhX1nm-ar13zvwpx-n5Vra34-2Z1DaJUiS1MDw
Message-ID: 
 <CAGwozwH_eUqErMsmyBsC6eMFTaHTbukkX68ZJO4MUqa_StiNUg@mail.gmail.com>
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
 <176267997931.738720.18333834369523509104@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Sun, 2 Nov 2025 at 18:33, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>
> On Tue, 28 Oct 2025 at 18:27, Antheas Kapenekakis <lkml@antheas.dev> wrot=
e:
> >
> > On Mon, 27 Oct 2025 at 20:58, Matthew Schwartz
> > <matthew.schwartz@linux.dev> wrote:
> > >
> > > On 10/27/25 1:23 AM, Antheas Kapenekakis wrote:
> > > > On Mon, 27 Oct 2025 at 07:02, Matthew Schwartz
> > > > <matthew.schwartz@linux.dev> wrote:
> > > >>
> > > >>
> > > >>
> > > >>> On Oct 26, 2025, at 12:19=E2=80=AFPM, Antheas Kapenekakis <lkml@a=
ntheas.dev> wrote:
> > > >>>
> > > >>> On Sun, 26 Oct 2025 at 20:16, Antheas Kapenekakis <lkml@antheas.d=
ev> wrote:
> > > >>>>
> > > >>>> Bind the realtek codec to TAS2781 I2C audio amps on ASUS Xbox Al=
ly
> > > >>>> projects. While these projects work without a quirk, adding it i=
ncreases
> > > >>>> the output volume significantly.
> > > >>>
> > > >>> Also, if you can upstream the firmware files:
> > > >>> TAS2XXX13840.bin
> > > >>> TAS2XXX13841.bin
> > > >>> TAS2XXX13940.bin
> > > >>> TAS2XXX13941.bin
> > > >>
> > > >> This is the firmware at [1], correct? I=E2=80=99m testing the seri=
es with that firmware on my ROG Xbox Ally X, and I found something interest=
ing.
> > > >>
> > > >> By default, with just your kernel patches and the firmware files h=
osted at [1], my unit is loading:
> > > >>
> > > >> tas2781-hda i2c-TXNW2781:00-tas2781-hda.0: Loaded FW: TAS2XXX13840=
.bin, sha256: 58cffa36ae23a2d9b2349ecb6c1d4e89627934cd79218f6ada06eaffe6688=
246
> > > >>
> > > >> However, with this firmware file,  TAS2XXX13840.bin, there is sign=
ificant audio clipping above 75% speaker level on my individual unit.
> > > >>
> > > >> Then, I tried renaming the other firmware file, TAS2XXX13841.bin, =
into TAS2XXX13840.bin. Now my unit is loading:
> > > >>
> > > >> tas2781-hda i2c-TXNW2781:00-tas2781-hda.0: Loaded FW: TAS2XXX13840=
.bin, sha256: 0fda76e7142cb455df1860cfdb19bb3cb6871128b385595fe06b296a070f4=
b8c
> > > >>
> > > >> With this firmware file, audio is perfect all the way to 100% spea=
ker level.
> > > >>
> > > >> If I recall, there have been other ASUS products that required mat=
ching amplifier hardware with firmware correctly, right? It looks like this=
 might be another case of since it seems my unit is loading the wrong firmw=
are for its amplifiers.
> > > >
> > > > The original Ally X had a similar setup, yes.
> > > >
> > > > First patch might not be perfect and your speaker pin might be 1. M=
y
> > > > Xbox Ally's pin is 1. It loads:
> > > > Loaded FW: TAS2XXX13941.bin, sha256:
> > > > 0fda76e7142cb455df1860cfdb19bb3cb6871128b385595fe06b296a070f4b8c
> > > >
> > > > And it sounds loud and crisp. So the pin is read.
> > > >
> > > > I had multiple users verify the X works, but perhaps it is not perf=
ect
> > > > yet. Make sure you are not using a dsp that might be interfering
> > >
> > > Seems like there have been other reports similar to mine on Xbox Ally=
 X, where flipping the firmware files by renaming them fixes sound issues f=
or them.
> > >
> > > @TI, Maybe something is different with the conditional logic for the =
ROG Xbox Ally X? The current GPIO-detected speaker_id doesn't always corres=
pond to the correct firmware choice on this model it seems.
> >
> > Yeah, it seems that specifically on the Xbox Ally X, the firmwares are
> > swapped around? What could be the case for that?
> >
> > I had three users with popping and dropped audio swap the firmware on
> > their X and they said the other one fixed it. And another two without
> > issues swapping the firmware and saying it does not make a
> > quantifiable change.
>
> Update on this. Users with a pin value of 1 are happy with the 1
> firmware. Users with a value of 0 are not happy with TAS2XXX13840 and
> TAS2XXX13841 works better for them. Moreover, users of the 1 firmware
> are not happy with the 0 firmware.
>
> This is just on the Ally X, on the normal Ally there are no issues.
>
> So there is an issue with TAS2XXX13840 on the linux side, TAS2XXX13841
> is correctly selected.

Hi, can I get a small bump on this?

Baojun can you comment on the first patch? The fix works properly
during our testing.

Both patches do.

It seems there is a problem with firmware file TAS2XXX13840 and
devices that select it. Those devices work fine with TAS2XXX13841 and
we replaced 0 with it for now, all of them do. The problem with it is
that the speakers clip on and off above 80% volume when TAS2XXX13840
is loaded.

Unfortunately I do not have an affected X unit, only a non-X one that
works fine with the 13941 project. Mat does and he could do some
testing.


> Antheas
>
> > Antheas
> >
> >
> > Antheas
> >
> > > >
> > > > Antheas
> > > >
> > > >> Matt
> > > >>
> > > >> [1]: https://github.com/hhd-dev/hwfirm
> > > >>
> > > >>>
> > > >>> That would be great :)
> > > >>>
> > > >>> Antheas
> > > >>>
> > > >>>> Cc: stable@vger.kernel.org # 6.17
> > > >>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > > >>>> ---
> > > >>>> sound/hda/codecs/realtek/alc269.c | 2 ++
> > > >>>> 1 file changed, 2 insertions(+)
> > > >>>>
> > > >>>> diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codec=
s/realtek/alc269.c
> > > >>>> index 8ad5febd822a..d1ad84eee6d1 100644
> > > >>>> --- a/sound/hda/codecs/realtek/alc269.c
> > > >>>> +++ b/sound/hda/codecs/realtek/alc269.c
> > > >>>> @@ -6713,6 +6713,8 @@ static const struct hda_quirk alc269_fixup=
_tbl[] =3D {
> > > >>>>        SND_PCI_QUIRK(0x1043, 0x12f0, "ASUS X541UV", ALC256_FIXUP=
_ASUS_MIC_NO_PRESENCE),
> > > >>>>        SND_PCI_QUIRK(0x1043, 0x1313, "Asus K42JZ", ALC269VB_FIXU=
P_ASUS_MIC_NO_PRESENCE),
> > > >>>>        SND_PCI_QUIRK(0x1043, 0x1314, "ASUS GA605K", ALC285_FIXUP=
_ASUS_GA605K_HEADSET_MIC),
> > > >>>> +       SND_PCI_QUIRK(0x1043, 0x1384, "ASUS RC73XA", ALC287_FIXU=
P_TXNW2781_I2C),
> > > >>>> +       SND_PCI_QUIRK(0x1043, 0x1394, "ASUS RC73YA", ALC287_FIXU=
P_TXNW2781_I2C),
> > > >>>>        SND_PCI_QUIRK(0x1043, 0x13b0, "ASUS Z550SA", ALC256_FIXUP=
_ASUS_MIC_NO_PRESENCE),
> > > >>>>        SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC26=
9VB_FIXUP_ASUS_ZENBOOK),
> > > >>>>        SND_PCI_QUIRK(0x1043, 0x1433, "ASUS GX650PY/PZ/PV/PU/PYV/=
PZV/PIV/PVV", ALC285_FIXUP_ASUS_I2C_HEADSET_MIC),
> > > >>>> --
> > > >>>> 2.51.1
> > > >>>>
> > > >>>>
> > > >>>
> > > >>>
> > > >>
> > > >>
> > > >
> > >
> > >


