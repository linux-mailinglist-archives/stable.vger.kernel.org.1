Return-Path: <stable+bounces-90151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA6A9BE6F2
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 887CCB2556A
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B2F1DF722;
	Wed,  6 Nov 2024 12:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="q62i/63o"
X-Original-To: stable@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921901DF24C;
	Wed,  6 Nov 2024 12:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894922; cv=none; b=D3epH6eDHg3cbPUw7KxgewaTaVOWoRMBotdHov7AKsMgZaOejD818vx2JaFgSqUqUD6gjiP56mJSGPUbl28y7dIs+ChwMseN+/twrQHBA3GH1npUCzT8KwTPuacXP6WnMNtMHcFoojS6a+gGIyriU0VhZukyjn/agPeCabvFC3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894922; c=relaxed/simple;
	bh=4EdajbeLaLBdqCivv+WYhCw/kuZ3B/enGg7P0ePCmf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSdC5U89rPPaztTrXiKTg13JEGeH4/MCdU1n0GQMvQHf5ZbzP86YXs0ek00LOQsu92zhsIwo5Nq6nqK7ne9vSr+mFPEfthntDbTK0Mpb4S5O+y4nOmcZpnSeXjyJXXTnTkd0djMRYCws0ZyI7tGQHuhRVA6G3Jff5YKy971P+yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=q62i/63o; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.96] (p5de457db.dip0.t-ipconnect.de [93.228.87.219])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 2A68A2FC004A;
	Wed,  6 Nov 2024 13:08:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1730894916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/30wpGdyfSTLtV/rbRbi/mdTrhXhrq63YfJCVlalxw=;
	b=q62i/63ovV3cLnGYzcJK91S9wP3aR2vjXDj9PYFBx50kBnoc/dYmY7r+7PVQ03EKuD5SVz
	bWXzplSp/1LcVWk0rhbsILQTpUCTSfd9Wq5DVy9ZsEVaTtM5hcLxj7FjGOSDlyAVjpbEap
	c8scNJ38uxBrBZo5zCIb/y+O4Cmot4Y=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <d71bdeaf-b137-4826-8926-da9da1904232@tuxedocomputers.com>
Date: Wed, 6 Nov 2024 13:08:36 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: Patch "ALSA: hda/realtek: Fix headset mic on TUXEDO
 Gemini 17 Gen3" failed to apply to v6.1-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, cs@tuxedo.de, Takashi Iwai <tiwai@suse.de>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241106021124.182205-1-sashal@kernel.org>
 <dc0af563-59d2-4176-ad15-fa93cf5c99d2@tuxedocomputers.com>
 <a7ab1da8-5fe8-4f46-bf18-bfc8d6fa3e6f@tuxedocomputers.com>
 <ZytaejmvQo3NkUrP@sashalap>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <ZytaejmvQo3NkUrP@sashalap>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Am 06.11.24 um 13:00 schrieb Sasha Levin:
> On Wed, Nov 06, 2024 at 10:23:14AM +0100, Werner Sembach wrote:
>> Am 06.11.24 um 10:19 schrieb Werner Sembach:
>>> Hi,
>>>
>>> Am 06.11.24 um 03:11 schrieb Sasha Levin:
>>>> The patch below does not apply to the v6.1-stable tree.
>>>> If someone wants it applied there, or to any other stable or longterm
>>>> tree, then please email the backport, including the original git commit
>>>> id to <stable@vger.kernel.org>.
>>>
>>> Applying 33affa7fb46c0c07f6c49d4ddac9dd436715064c (ALSA: hda/realtek: Add 
>>> quirks for some Clevo laptops) first and then 
>>> 0b04fbe886b4274c8e5855011233aaa69fec6e75 (ALSA: hda/realtek: Fix headset mic 
>>> on TUXEDO Gemini 17 Gen3) and e49370d769e71456db3fbd982e95bab8c69f73e8 
>>> (ALSA: hda/realtek: Fix headset mic on TUXEDO Stellaris 16 Gen6 mb1) makes 
>>> everything work without alteration.
>>>
>>> The first one is just missing the cc stable tag, probably by accident.
>>>
>>> Should I alter the 2nd and 3rd commit or should I send a patchset that 
>>> includes the first one?
>>
>> Sorry just realized that for 5.15 it's a different patch that is missing for 
>> e49370d769e71456db3fbd982e95bab8c69f73e8 to cleanly apply
>>
>> I will just alter the patches
>
> It applies, but fails to build:
>
> In file included from sound/pci/hda/patch_realtek.c:21:
> sound/pci/hda/patch_realtek.c:9530:59: error: 'ALC2XX_FIXUP_HEADSET_MIC' 
> undeclared here (not in a function); did you mean 'ALC283_FIXUP_HEADSET_MIC'?
>  9530 |         SND_PCI_QUIRK(0x1d05, 0x1387, "TongFang GMxIXxx", 
> ALC2XX_FIXUP_HEADSET_MIC),
>       | ^~~~~~~~~~~~~~~~~~~~~~~~
> ./include/sound/core.h:465:50: note: in definition of macro 'SND_PCI_QUIRK'
>   465 |         {_SND_PCI_QUIRK_ID(vend, dev), .value = (val), .name = (xname)}
>       |                                                  ^~~
> make[3]: *** [scripts/Makefile.build:289: sound/pci/hda/patch_realtek.o] Error 1
>
I'm sorry I did not double check if the define exists ins 6.1.

Considering that it's a fairly new device it's reasonable enough to assume that 
it's probably not run with the 6.1 kernel and so I don't want to blow up the 
patch to much. So just forget about it and sorry again that I caused you extra work.

Kind regards,

Werner Sembach


