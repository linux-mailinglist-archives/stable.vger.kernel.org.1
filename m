Return-Path: <stable+bounces-90091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E4F9BE257
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 10:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 992C11C2102D
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 09:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105F21DB34E;
	Wed,  6 Nov 2024 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="MAfoJycb"
X-Original-To: stable@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F60A1DA622;
	Wed,  6 Nov 2024 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885001; cv=none; b=ov7OrBpz5jGRNW/1PJqtaP6YQtGwl3lLrNRbaQWnRzuubdLDG0bHwQr4D5dm7nOGFgKPx84Bt9xqOOCQyULG0NoThdezUTDTZAVZhLWgLszXd9Zwjo9v7htpsfkCHlAzFTCGOD9fv46KjXeOqwQ68WHYI1Yu7Q8PYMWJmBFboV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885001; c=relaxed/simple;
	bh=m1N+5jyQ67HSah3rKgOgWZVkkGqLOIgklCq6QXJ6uzQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IvV7aOjhCAmNrIrFegayLn5/koeHPJbHgnLqFmNCMJBTqdkLWHxsznRl9x0MPpnfsFmuUXxawEuUZBKPeOQXNnJ39GeZm7Po8Ba6NLEA8Bxj2VB6qT5GH3uqHTbcUJwctdbBNbYm9ztcWGii42iw8UIj9xbuXukw8+cykoBO0ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=MAfoJycb; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.96] (p5de457db.dip0.t-ipconnect.de [93.228.87.219])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 0742B2FC0050;
	Wed,  6 Nov 2024 10:23:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1730884995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=anTqZfKLitYWHQoCE04uHclcVRN2RSOQREYPJyYJsT8=;
	b=MAfoJycb5veaN9VjpA6wtgrjwUpGXNXChtLgNRJvyQw1PnQQWdtUAGTmp58yZhOw+Vi+G5
	8KgO9i/sOrCQInliAVNwZ4IRy0QYHR3GBe5lmQHIv1YqkomG8KsRA7OQHp3QMSSBMW1Oxm
	1OnswIwPpLXbJnsihWyHJX/AAXqUsOo=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <a7ab1da8-5fe8-4f46-bf18-bfc8d6fa3e6f@tuxedocomputers.com>
Date: Wed, 6 Nov 2024 10:23:14 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: Patch "ALSA: hda/realtek: Fix headset mic on TUXEDO
 Gemini 17 Gen3" failed to apply to v6.1-stable tree
From: Werner Sembach <wse@tuxedocomputers.com>
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, cs@tuxedo.de
Cc: Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241106021124.182205-1-sashal@kernel.org>
 <dc0af563-59d2-4176-ad15-fa93cf5c99d2@tuxedocomputers.com>
Content-Language: en-US
In-Reply-To: <dc0af563-59d2-4176-ad15-fa93cf5c99d2@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 06.11.24 um 10:19 schrieb Werner Sembach:
> Hi,
>
> Am 06.11.24 um 03:11 schrieb Sasha Levin:
>> The patch below does not apply to the v6.1-stable tree.
>> If someone wants it applied there, or to any other stable or longterm
>> tree, then please email the backport, including the original git commit
>> id to <stable@vger.kernel.org>.
>
> Applying 33affa7fb46c0c07f6c49d4ddac9dd436715064c (ALSA: hda/realtek: Add 
> quirks for some Clevo laptops) first and then 
> 0b04fbe886b4274c8e5855011233aaa69fec6e75 (ALSA: hda/realtek: Fix headset mic 
> on TUXEDO Gemini 17 Gen3) and e49370d769e71456db3fbd982e95bab8c69f73e8 (ALSA: 
> hda/realtek: Fix headset mic on TUXEDO Stellaris 16 Gen6 mb1) makes everything 
> work without alteration.
>
> The first one is just missing the cc stable tag, probably by accident.
>
> Should I alter the 2nd and 3rd commit or should I send a patchset that 
> includes the first one?

Sorry just realized that for 5.15 it's a different patch that is missing for 
e49370d769e71456db3fbd982e95bab8c69f73e8 to cleanly apply

I will just alter the patches

>
> Kind regards,
>
> Werner Sembach
>
>>
>> Thanks,
>> Sasha
>>
>> ------------------ original commit in Linus's tree ------------------
>>
>>  From 0b04fbe886b4274c8e5855011233aaa69fec6e75 Mon Sep 17 00:00:00 2001
>> From: Christoffer Sandberg <cs@tuxedo.de>
>> Date: Tue, 29 Oct 2024 16:16:52 +0100
>> Subject: [PATCH] ALSA: hda/realtek: Fix headset mic on TUXEDO Gemini 17 Gen3
>>
>> Quirk is needed to enable headset microphone on missing pin 0x19.
>>
>> Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> Cc: <stable@vger.kernel.org>
>> Link: https://patch.msgid.link/20241029151653.80726-1-wse@tuxedocomputers.com
>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>> ---
>>   sound/pci/hda/patch_realtek.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
>> index 7f4926194e50f..e06a6fdc0bab7 100644
>> --- a/sound/pci/hda/patch_realtek.c
>> +++ b/sound/pci/hda/patch_realtek.c
>> @@ -10750,6 +10750,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>>       SND_PCI_QUIRK(0x1558, 0x1404, "Clevo N150CU", 
>> ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
>>       SND_PCI_QUIRK(0x1558, 0x14a1, "Clevo L141MU", 
>> ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
>>       SND_PCI_QUIRK(0x1558, 0x2624, "Clevo L240TU", 
>> ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
>> +    SND_PCI_QUIRK(0x1558, 0x28c1, "Clevo V370VND", ALC2XX_FIXUP_HEADSET_MIC),
>>       SND_PCI_QUIRK(0x1558, 0x4018, "Clevo NV40M[BE]", 
>> ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
>>       SND_PCI_QUIRK(0x1558, 0x4019, "Clevo NV40MZ", 
>> ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
>>       SND_PCI_QUIRK(0x1558, 0x4020, "Clevo NV40MB", 
>> ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),

