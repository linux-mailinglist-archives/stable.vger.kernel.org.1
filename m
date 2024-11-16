Return-Path: <stable+bounces-93624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C84A39CFC56
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 03:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708581F22B19
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 02:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770B32AE8B;
	Sat, 16 Nov 2024 02:10:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cosmicgizmosystems.com (cosgizsys.com [63.249.102.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815EE33EC;
	Sat, 16 Nov 2024 02:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.249.102.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731723025; cv=none; b=DbHm462GoCvdUG7NeqeP6S0yuKAPbB6uF4HDcQBHva7HbWMzNWgDyESCGKqFbiT6h/N1kk5LfC+ur+wyJ26zjtzYtGunfMBbBxCuCbjoPf4mBjAhh1GF2zgFL2XYvNsdSEkFzur5a9qjKnZWsssNk1lKz0eyqll6o/VY7lei83o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731723025; c=relaxed/simple;
	bh=5v8HwQRVQlq3aD3asA+KsArcbUCWwhUDpDFKqBUyJ4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vzv7SETISRFggrLtfpfqPdYxE7TO1dofc9zL//ZPyDSxfv0jlNDm3qwXbOGoXfM/PzY2TvK2YoA4X3z0UB9EWNSC6FbkkOS9hr/58ppMn4/kyzzWyPKpLSIySz/mblLLESoL1tXEtuzZS4hrSBba9IzX3JM8DvuuYwvYEnY1cg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cosmicgizmosystems.com; spf=pass smtp.mailfrom=cosmicgizmosystems.com; arc=none smtp.client-ip=63.249.102.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cosmicgizmosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cosmicgizmosystems.com
Received: from [10.0.0.101] (c-73-190-111-195.hsd1.wa.comcast.net [73.190.111.195])
	by host11.cruzio.com (Postfix) with ESMTPSA id 1D289223C812;
	Fri, 15 Nov 2024 18:10:16 -0800 (PST)
Message-ID: <50e6f713-0fdd-45bf-94c6-6241e008b683@cosmicgizmosystems.com>
Date: Fri, 15 Nov 2024 18:10:15 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: usb-audio: Fix control names for Plantronics/Poly
 Headsets
To: Takashi Iwai <tiwai@suse.de>,
 Terry Junge <linuxhid@cosmicgizmosystems.com>
Cc: Wade Wang <wade.wang@hp.com>, perex@perex.cz, tiwai@suse.com, kl@kl.wtf,
 wangdicheng@kylinos.cn, k.kosik@outlook.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241114061553.1699264-1-wade.wang@hp.com>
 <87plmythnv.wl-tiwai@suse.de>
 <4717b9c4-8d9f-40d8-903e-68be30ac7d82@cosmicgizmosystems.com>
 <87jzd4syc2.wl-tiwai@suse.de>
Content-Language: en-US
From: Terry Junge <linuxsound@cosmicgizmosystems.com>
In-Reply-To: <87jzd4syc2.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/15/24 12:19 AM, Takashi Iwai wrote:
> On Thu, 14 Nov 2024 19:44:52 +0100,
> Terry Junge wrote:
>>
>> Thanks Takashi,
>>
>> On 11/13/24 11:10 PM, Takashi Iwai wrote:
>>> On Thu, 14 Nov 2024 07:15:53 +0100,
>>> Wade Wang wrote:
>>>>
>>>> Add a control name fixer for all headsets with VID 0x047F.
>>>>
>>>> Signed-off-by: Terry Junge <linuxhid@cosmicgizmosystems.com>
>>>> Signed-off-by: Wade Wang <wade.wang@hp.com>
>>>
>>> Thanks for the patch, but from the description, it's not clear what
>>> this patch actually does.  What's the control name fixer and how it
>>> behaves?
>>
>> It will be better described in the v2 patch.
>>
>> It modifies names like
>>
>> Headset Earphone Playback Volume
>> Headset Microphone Capture Switch
>> Receive Playback Volume
>> Transmit Capture Switch
>>
>> to
>>
>> Headset Playback Volume
>> Headset Capture Switch
>>
>> so user space will bind to the headset's audio controls.
> 
> OK, that makes sense.  I suppose that both "Headset Earphone Playback
> Volume" and "Receive Playback Volume" don't exist at the same time,
> right?

Yes, that is correct. No device will have both.

Terry


