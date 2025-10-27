Return-Path: <stable+bounces-191318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 382CAC114B6
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 20:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3346E467715
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8489315789;
	Mon, 27 Oct 2025 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R5jhvjI2"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C81A2D97A6
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 19:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761595080; cv=none; b=ugij14jzG3Fqc8W1VPTCEmrvun9imHrtNGeEz5pKi2bazxjQqhp3mDQ9BKOo5UPcB0f/6OngRFhVrKRouXufrm9OkIsQZy6FkjhgQ4lP13wWJ2DrQfsCBjfgUgLwybdKBk7/dYuF+LqDD+Fm4t/wTsUDxHWhTNgan6DSAMImBRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761595080; c=relaxed/simple;
	bh=3uqE98Bb5YTB1wH+b5+ZFqSfmfvTk/0fgO+sMvaAa8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dvhaGXHPDMW3YsCI5guzl5EeGgirkM4dj/TFuyYssgMen7g8ZQLwhkj42wViAvuZC45UmBqxb7dFJ+GipgGLa5VciwpcZo3159DGLF0LIucFFR/xcmIeAZM/lQOxnPgdd+iK8q0ARSORML7JtqTZKUuNqamdJkLuZT+4rHqLLvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R5jhvjI2; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <eb749233-0342-49a9-a41b-6d18239eb1d9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761595076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2+G+nasBC3jhxtT7KXEPZymKlMWjpHoUogw8SupcDt0=;
	b=R5jhvjI2imvi4D/zszJUbbWCLGeIvULnw4as9CgNbJB3NmYk1Tk+7nHYaMrUQbTgr1cMhL
	l8S3oPaIJC+yLkPfEc1Ga4NCEkLvDw1GqzhWTG8I0wMswvtzFJ30HXk2A13hrujeW0h8Pc
	miaf3sxiCGDT8NiXBdW1ggYwUlYyZo8=
Date: Mon, 27 Oct 2025 12:57:52 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 2/2] ALSA: hda/realtek: Add match for ASUS Xbox Ally
 projects
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Baojun Xu <baojun.xu@ti.com>,
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251026191635.2447593-1-lkml@antheas.dev>
 <20251026191635.2447593-2-lkml@antheas.dev>
 <CAGwozwEwPj9VRRo2U50ccg=_qSM7p-1c_hw2y=OYA-pFc=p13w@mail.gmail.com>
 <35A5783A-CA60-4B10-8C7B-5820B65307FE@linux.dev>
 <CAGwozwFtah66p=5oy9rf5phVGdDTiWg0WuJBT3qGpWdP3A62Pg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
In-Reply-To: <CAGwozwFtah66p=5oy9rf5phVGdDTiWg0WuJBT3qGpWdP3A62Pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/27/25 1:23 AM, Antheas Kapenekakis wrote:
> On Mon, 27 Oct 2025 at 07:02, Matthew Schwartz
> <matthew.schwartz@linux.dev> wrote:
>>
>>
>>
>>> On Oct 26, 2025, at 12:19 PM, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>>>
>>> On Sun, 26 Oct 2025 at 20:16, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>>>>
>>>> Bind the realtek codec to TAS2781 I2C audio amps on ASUS Xbox Ally
>>>> projects. While these projects work without a quirk, adding it increases
>>>> the output volume significantly.
>>>
>>> Also, if you can upstream the firmware files:
>>> TAS2XXX13840.bin
>>> TAS2XXX13841.bin
>>> TAS2XXX13940.bin
>>> TAS2XXX13941.bin
>>
>> This is the firmware at [1], correct? I’m testing the series with that firmware on my ROG Xbox Ally X, and I found something interesting.
>>
>> By default, with just your kernel patches and the firmware files hosted at [1], my unit is loading:
>>
>> tas2781-hda i2c-TXNW2781:00-tas2781-hda.0: Loaded FW: TAS2XXX13840.bin, sha256: 58cffa36ae23a2d9b2349ecb6c1d4e89627934cd79218f6ada06eaffe6688246
>>
>> However, with this firmware file,  TAS2XXX13840.bin, there is significant audio clipping above 75% speaker level on my individual unit.
>>
>> Then, I tried renaming the other firmware file, TAS2XXX13841.bin, into TAS2XXX13840.bin. Now my unit is loading:
>>
>> tas2781-hda i2c-TXNW2781:00-tas2781-hda.0: Loaded FW: TAS2XXX13840.bin, sha256: 0fda76e7142cb455df1860cfdb19bb3cb6871128b385595fe06b296a070f4b8c
>>
>> With this firmware file, audio is perfect all the way to 100% speaker level.
>>
>> If I recall, there have been other ASUS products that required matching amplifier hardware with firmware correctly, right? It looks like this might be another case of since it seems my unit is loading the wrong firmware for its amplifiers.
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

Seems like there have been other reports similar to mine on Xbox Ally X, where flipping the firmware files by renaming them fixes sound issues for them.

@TI, Maybe something is different with the conditional logic for the ROG Xbox Ally X? The current GPIO-detected speaker_id doesn't always correspond to the correct firmware choice on this model it seems.

> 
> Antheas
> 
>> Matt
>>
>> [1]: https://github.com/hhd-dev/hwfirm
>>
>>>
>>> That would be great :)
>>>
>>> Antheas
>>>
>>>> Cc: stable@vger.kernel.org # 6.17
>>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
>>>> ---
>>>> sound/hda/codecs/realtek/alc269.c | 2 ++
>>>> 1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
>>>> index 8ad5febd822a..d1ad84eee6d1 100644
>>>> --- a/sound/hda/codecs/realtek/alc269.c
>>>> +++ b/sound/hda/codecs/realtek/alc269.c
>>>> @@ -6713,6 +6713,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
>>>>        SND_PCI_QUIRK(0x1043, 0x12f0, "ASUS X541UV", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
>>>>        SND_PCI_QUIRK(0x1043, 0x1313, "Asus K42JZ", ALC269VB_FIXUP_ASUS_MIC_NO_PRESENCE),
>>>>        SND_PCI_QUIRK(0x1043, 0x1314, "ASUS GA605K", ALC285_FIXUP_ASUS_GA605K_HEADSET_MIC),
>>>> +       SND_PCI_QUIRK(0x1043, 0x1384, "ASUS RC73XA", ALC287_FIXUP_TXNW2781_I2C),
>>>> +       SND_PCI_QUIRK(0x1043, 0x1394, "ASUS RC73YA", ALC287_FIXUP_TXNW2781_I2C),
>>>>        SND_PCI_QUIRK(0x1043, 0x13b0, "ASUS Z550SA", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
>>>>        SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
>>>>        SND_PCI_QUIRK(0x1043, 0x1433, "ASUS GX650PY/PZ/PV/PU/PYV/PZV/PIV/PVV", ALC285_FIXUP_ASUS_I2C_HEADSET_MIC),
>>>> --
>>>> 2.51.1
>>>>
>>>>
>>>
>>>
>>
>>
> 


