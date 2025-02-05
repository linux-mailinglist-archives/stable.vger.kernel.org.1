Return-Path: <stable+bounces-112279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3239CA28402
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 06:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87F623A4BC3
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 05:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E11221D86;
	Wed,  5 Feb 2025 05:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="B+dL7N63"
X-Original-To: stable@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FF821C180;
	Wed,  5 Feb 2025 05:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.241.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738735192; cv=none; b=jE393QtzvyG+35qjH2nZdxFE5kWcPfYiAoSKAN2wYsmyIRmz3TwkZXRsO6rM8M49RL0yzPIGymv2HVAgd6BqqN2t+C/iknI9ZH91acIUEaNVV3K9WlLmlLzZprmaqg5txAn++eZfur5j+m9DBNQZSecqKW2pt0AMKZO2ALBKgEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738735192; c=relaxed/simple;
	bh=lMlSGn6f5axZQbtd0v8R34NIoyp+US5nWf53BEGR6e8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WwT0NgVjiYiMpK9XGvlt6Dl5jM7nkchgKBnNAgj8QVBbJWuvkjmHLCvsHJxMTO+gLRCn1Sw3/0edpj7nfxxBs1VeVfY439MQpEKbr1EWVGd8Vrk60qs3PJycrGUz+hTtskMpdedAtSCV24CGYePIdzo+zXaG2xTv6RvtKLozEMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=B+dL7N63; arc=none smtp.client-ip=159.100.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.119.157])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 30EEA20063;
	Wed,  5 Feb 2025 05:59:42 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay3.mymailcheap.com (Postfix) with ESMTPS id 40F623E94E;
	Wed,  5 Feb 2025 05:59:34 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id D7628400CC;
	Wed,  5 Feb 2025 05:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1738735173; bh=lMlSGn6f5axZQbtd0v8R34NIoyp+US5nWf53BEGR6e8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B+dL7N63Xde0M11M9aBrJl4MlW0q+IwgQDyKJ68PezxqVg8DthaIhOrYgjpzPbFQf
	 lhJfPI7V+J1O6cBHRWOEHAKMA7S8/AHoGLkdItj9TGlckSvXQ9NCZ8ak8Epto/cJ+a
	 bjXLOO/MyykjiQg+TL+NuaPvb3j97L79KErpuoMY=
Received: from [172.23.33.41] (unknown [103.152.35.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 616654050D;
	Wed,  5 Feb 2025 05:59:29 +0000 (UTC)
Message-ID: <6838de5f-2984-4722-9ee5-c4c62d13911b@aosc.io>
Date: Wed, 5 Feb 2025 13:59:24 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: core: Enable root_hub's remote wakeup for wakeup
 sources
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Huacai Chen <chenhuacai@kernel.org>, Huacai Chen
 <chenhuacai@loongson.cn>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Kexy Biscuit <kexybiscuit@aosc.io>
References: <20250131100630.342995-1-chenhuacai@loongson.cn>
 <2f583e59-5322-4cac-aaaf-02163084c32c@rowland.harvard.edu>
 <CAAhV-H7Dt1bEo8qcwfVfcjTOgXSKW71D19k3+418J6CtV3pVsQ@mail.gmail.com>
 <fbe4a6c4-f8ba-4b5b-b20f-9a2598934c42@rowland.harvard.edu>
 <61fecc0b-d5ac-4fcb-aca7-aa84d8219493@rowland.harvard.edu>
 <2a8d65f4-6832-49c5-9d61-f8c0d0552ed4@aosc.io>
 <06c81c97-7e5f-412b-b6af-04368dd644c9@rowland.harvard.edu>
Content-Language: en-US
From: Mingcong Bai <jeffbai@aosc.io>
In-Reply-To: <06c81c97-7e5f-412b-b6af-04368dd644c9@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Queue-Id: D7628400CC
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.10 / 10.00];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_SOME(0.00)[]

Hi Alan,

在 2025/2/4 00:15, Alan Stern 写道:
> On Tue, Feb 04, 2025 at 12:01:37AM +0800, Mingcong Bai wrote:
>> Hi Alan, Huacai,
>>
>> <snip>
>>
>>> I just tried running the experiment on my system.  I enabled wakeup for
>>> the mouse device, made sure it was disabled for the intermediate hub and
>>> the root hub, and made sure it was enabled for the host controller.
>>> (Those last three are the default settings.)  Then I put the system in
>>> S3 suspend by writing "mem" to /sys/power/state, and when the system was
>>> asleep I pressed one of the mouse buttons -- and the system woke up.
>>> This was done under a 6.12.10 kernel, with an EHCI host controller, not
>>> xHCI.
>>>
>>> So it seems like something is wrong with your system in particular, not
>>> the core USB code in general.  What type of host controller is your
>>> mouse attached to?  Have you tested whether the mouse is able to wake up
>>> from runtime suspend, as opposed to S3 suspend?
>>>
>>
>> Just to chime in with my own test results. I was looking at this with Huacai
>> a few days back and we suspected that this had something to do with
>> particular systems, as you have found; we also suspected that if a keyboard
>> was connected to a non-xHCI controller, it would fail to wake up the system.
>>
>> I conducted a simple experiment on my Lenovo ThinkPad X200s, which does not
>> come with any USB 3.0 port. Here are my findings:
> 
> What sort of USB controller does the X200s have?  Is the controller
> enabled for wakeup?
> 
> What happens with runtime suspend rather than S3 suspend?

It has the Intel Corporation 82801I (ICH9 Family) USB UCHI/USB2 EHCI 
controller with PCI IDs 17aa:20f0/17aa:20f1. The hub is a Genesys Logic, 
Inc. Hub with an ID of 05e3:0610 - this is an xHCI hub.

Sorry but the record here is going to get a bit messy... But let's start 
with a kernel with Huacai's patch.

=== Kernel + Huacai's Patch ===

1. If I plug in the external keyboard via the hub, 
/sys/bus/usb/devices/usb1, power/state is set to enabled. For the hub, 
corresponding to usb1/1-1, power/wakeup is set to disabled.

2. If I plug the keyboard directly into the chassis, usb1/power/wakeup 
is set to disabled, but usb1/1-1/power/wakeup is set to enabled.

The system wakes up via external keyboard plugged directly into the 
chassis **or** the hub either way, regardless if I used S3 or runtime 
suspend (which I assume to be echo freeze > /sys/power/state).

=== Kernel w/o Huacai's Patch ===

The controller where I plugged in the USB hub, /sys/bus/usb/devices/usb1 
and the hub, corresponding to usb1/1-1, their power/wakeup entries are 
both set to disabled. Same for when I have the patch applied.

However, if I plug the external keyboard into the chassis, it would fail 
to wakeup regardless of S3/runtime suspend (freeze). If I plug the 
external keyboard via that USB Hub though, it would wake up the machine. 
The findings are consistent between S3/freeze.

> 
>> 1. With upstream code, the system would not wake up with neither the
>> internal nor the external keyboards. One exception being the Fn key on the
>> internal keyboard, which would wake up the system (but I suspect that this
>> is EC behaviour). This behaviour is consistent across any USB port on the
>> laptop and, regardless if the external keyboard was connected to the laptop
>> itself or via a hub.
>>
>> 2. With Huacai's code, I was able to wake up the laptop with an external
>> keyboard in all the scenarios listed in (1). The internal keyboard still
>> failed to wake up the system unless I strike the Fn key.
>>
>> I should note, however, that the internal keyboard is not connected via USB
>> so it's probably irrelevant information anyway.
>>
>> As for mice, it seems that the kernel disables wake-up via USB mice and
>> enables wake-up via USB keyboards. This is also consistent with your
>> findings.
> 
> Yes, and of course you can manually change the default wakeup settings
> whenever you want.
> 
> Alan Stern

Best Regards,
Mingcong Bai

