Return-Path: <stable+bounces-116579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB791A382FF
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 13:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3A4818853E8
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 12:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C5C21A453;
	Mon, 17 Feb 2025 12:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pelago.org.uk header.i=@pelago.org.uk header.b="NFSkMLLO"
X-Original-To: stable@vger.kernel.org
Received: from mx2.mythic-beasts.com (mx2.mythic-beasts.com [46.235.227.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9871219EAD;
	Mon, 17 Feb 2025 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739795300; cv=none; b=NTULfNuds/Iq1Zbgx7eCGMAz7jNWojrRjY0xcBStV8fwgaHDyVq0D8qGXUAxMWJmI7UKPtq+zSjQkjZrek55sOL3J6TSbnx9R6gPSe8yJOT+q6Gizf/YvNRC/my3Tk7LE+4CTeEVZ6zB528j8tkSlBSorp5dXknlYqX8lmornqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739795300; c=relaxed/simple;
	bh=RvlUp0pIHgqWEN8J+3t45WxbRXgImYVMQcmeJ+Avtdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PlLW1H/PGT6V37xONEWNy9ZhzWeRZZtREuqI6A0KMwY6oV403U8r6KRD2hZx5Q7p1fgPTjTsPfJMr/PzzF388cEZskmUo5EwCjt8jxbUSq9SK8GF7uxgtbqAv2cxGW7y0F8dF/lYOEXgXXfzWo5UFp531xp8aHkCAfuGq7x602I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pelago.org.uk; spf=pass smtp.mailfrom=pelago.org.uk; dkim=pass (2048-bit key) header.d=pelago.org.uk header.i=@pelago.org.uk header.b=NFSkMLLO; arc=none smtp.client-ip=46.235.227.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pelago.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pelago.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=pelago.org.uk; s=mythic-beasts-k1; h=From:To:Subject:Date;
	bh=o8Ww5RMDvSBbJqnbwfQK+oljKxs5sRZoy/vOcaUCC9c=; b=NFSkMLLOX7IWSwmNiuJt5tLqgQ
	tSYbCr1NpHDvkB/gbr08oiKH6Qwc2DNZeRX3JpXVPlHi8mererYc+0JF5Xwmmn0HuV+N1sUIV6vjz
	rIEFSJoKOYcRIAlh+faLg14KTIKP5Z60YPUUo+xz8ysEF7bQSBRbkC5U2Z/jUhJMEFj0QfUDK748s
	u6zsKacaCF9mbsoBW7lm7+q6FNtPF3ewvPiywFzBr5X0TColYKrdkQhlGjrcHP3GqqJ+vhEv8vETH
	3Id2RQUDTW2WNcXAR0VDPZwPEpofyFZAPJ5CZvESM4CYI2nWcvhqJ6kZZwJmGHV9ZC0sw4MeOh5C2
	8ZWePZzQ==;
Received: by mailhub-hex-d.mythic-beasts.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <john-linux@pelago.org.uk>)
	id 1tk0ER-00589X-Oz; Mon, 17 Feb 2025 12:28:16 +0000
Message-ID: <c8556845-7d12-46aa-ab28-138da8903583@pelago.org.uk>
Date: Mon, 17 Feb 2025 12:28:15 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ALSA: hda/conexant: Add quirk for HP ProBook 450 G4
 mute LED
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <2fb55d48-6991-4a42-b591-4c78f2fad8d7@pelago.org.uk>
 <877c5o92sg.wl-tiwai@suse.de>
From: John Veness <john-linux@pelago.org.uk>
Content-Language: en-GB
In-Reply-To: <877c5o92sg.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 0

On 17/02/2025 12:25, Takashi Iwai wrote:
> On Mon, 17 Feb 2025 13:15:50 +0100,
> John Veness wrote:
>>
>> Allows the LED on the dedicated mute button on the HP ProBook 450 G4
>> laptop to change colour correctly.
>>
>> Signed-off-by: John Veness <john-linux@pelago.org.uk>
>> ---
>> Re-submitted with correct tabs (I hope!)
> 
> Now the patch is cleanly applicable, so I took now.
> But, the Cc-to-stable should have been put in the patch itself (around
> your Signed-off-by line).  I put it locally.

Whoops, I just submitted a v3 to fix the stable CC, after "kernel test
robot" alerted me. I hope that doesn't mess things up.

John

> thanks,
> 
> Takashi
> 
>>
>>  sound/pci/hda/patch_conexant.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
>> index 4985e72b9..34874039a 100644
>> --- a/sound/pci/hda/patch_conexant.c
>> +++ b/sound/pci/hda/patch_conexant.c
>> @@ -1090,6 +1090,7 @@ static const struct hda_quirk cxt5066_fixups[] = {
>>  	SND_PCI_QUIRK(0x103c, 0x814f, "HP ZBook 15u G3", CXT_FIXUP_MUTE_LED_GPIO),
>>  	SND_PCI_QUIRK(0x103c, 0x8174, "HP Spectre x360", CXT_FIXUP_HP_SPECTRE),
>>  	SND_PCI_QUIRK(0x103c, 0x822e, "HP ProBook 440 G4", CXT_FIXUP_MUTE_LED_GPIO),
>> +	SND_PCI_QUIRK(0x103c, 0x8231, "HP ProBook 450 G4", CXT_FIXUP_MUTE_LED_GPIO),
>>  	SND_PCI_QUIRK(0x103c, 0x828c, "HP EliteBook 840 G4", CXT_FIXUP_HP_DOCK),
>>  	SND_PCI_QUIRK(0x103c, 0x8299, "HP 800 G3 SFF", CXT_FIXUP_HP_MIC_NO_PRESENCE),
>>  	SND_PCI_QUIRK(0x103c, 0x829a, "HP 800 G3 DM", CXT_FIXUP_HP_MIC_NO_PRESENCE),
>> -- 
>> 2.48.1


