Return-Path: <stable+bounces-112040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C34A25F6F
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 17:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33CFC165614
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 16:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F02020A5EA;
	Mon,  3 Feb 2025 16:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="llkPPiKM"
X-Original-To: stable@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0498CF9D6;
	Mon,  3 Feb 2025 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.241.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738598526; cv=none; b=TY6x8kzcdmeHbpsMp5OaT1qMx8ccHWLa9/Ve51hHhftfXh9TEUHXoFuq14iSMmGSMUk7sBDu3Cr0HEufd/yG45WXBe/VkAYqi+mjbkM40UTutVFRta93m42gagYWLl5YPxb/QHGOC7O1QSu34sbbHSvHgryCeVkYtYdnrtVhHo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738598526; c=relaxed/simple;
	bh=0BO6nTPiaF2yJwm7N18DYBlR9j/wUMubC5MhYK//OIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iI99w1H4teYLxsRSqca1s8c7biPCim8wQrRHFRkj8gOi3Sl6Q679m8EUYgMCusXXKLnTrYiqjji7pABZlWZjmHNMRmoZ0juCLNZeL5CTLg0maXKvZ4IKH/u2qJqfBJ2bT8JDJ9Wuue9uavG68TXDnXMitBlopXEctN4fAOPaHbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=llkPPiKM; arc=none smtp.client-ip=159.100.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.154])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id E0E3E20063;
	Mon,  3 Feb 2025 16:01:55 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay4.mymailcheap.com (Postfix) with ESMTPS id A3795203E1;
	Mon,  3 Feb 2025 16:01:47 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id 32777400CC;
	Mon,  3 Feb 2025 16:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1738598507; bh=0BO6nTPiaF2yJwm7N18DYBlR9j/wUMubC5MhYK//OIQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=llkPPiKMfS3N8Y6Bi1Iv2LuyXupvhf2JT+QDJMVVO9Us0/sPYC6ShmvT2qQ/cIGW7
	 VRSE+GbN3Zy5GstMCy0KzCfKqED63RfPiKXDe75cWhAhl6TID3AZ1iLu4LRuSVwTZS
	 jEMrtYJ6wLEu/ki6K6M8+6Ck2LOVi33VhdMF9QLI=
Received: from [172.29.0.1] (unknown [203.175.14.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id A7AB140515;
	Mon,  3 Feb 2025 16:01:42 +0000 (UTC)
Message-ID: <2a8d65f4-6832-49c5-9d61-f8c0d0552ed4@aosc.io>
Date: Tue, 4 Feb 2025 00:01:37 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: core: Enable root_hub's remote wakeup for wakeup
 sources
To: Alan Stern <stern@rowland.harvard.edu>,
 Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Kexy Biscuit <kexybiscuit@aosc.io>
References: <20250131100630.342995-1-chenhuacai@loongson.cn>
 <2f583e59-5322-4cac-aaaf-02163084c32c@rowland.harvard.edu>
 <CAAhV-H7Dt1bEo8qcwfVfcjTOgXSKW71D19k3+418J6CtV3pVsQ@mail.gmail.com>
 <fbe4a6c4-f8ba-4b5b-b20f-9a2598934c42@rowland.harvard.edu>
 <61fecc0b-d5ac-4fcb-aca7-aa84d8219493@rowland.harvard.edu>
Content-Language: en-US
From: Mingcong Bai <jeffbai@aosc.io>
In-Reply-To: <61fecc0b-d5ac-4fcb-aca7-aa84d8219493@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Queue-Id: 32777400CC
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

Hi Alan, Huacai,

<snip>

> I just tried running the experiment on my system.  I enabled wakeup for
> the mouse device, made sure it was disabled for the intermediate hub and
> the root hub, and made sure it was enabled for the host controller.
> (Those last three are the default settings.)  Then I put the system in
> S3 suspend by writing "mem" to /sys/power/state, and when the system was
> asleep I pressed one of the mouse buttons -- and the system woke up.
> This was done under a 6.12.10 kernel, with an EHCI host controller, not
> xHCI.
> 
> So it seems like something is wrong with your system in particular, not
> the core USB code in general.  What type of host controller is your
> mouse attached to?  Have you tested whether the mouse is able to wake up
> from runtime suspend, as opposed to S3 suspend?
> 

Just to chime in with my own test results. I was looking at this with 
Huacai a few days back and we suspected that this had something to do 
with particular systems, as you have found; we also suspected that if a 
keyboard was connected to a non-xHCI controller, it would fail to wake 
up the system.

I conducted a simple experiment on my Lenovo ThinkPad X200s, which does 
not come with any USB 3.0 port. Here are my findings:

1. With upstream code, the system would not wake up with neither the 
internal nor the external keyboards. One exception being the Fn key on 
the internal keyboard, which would wake up the system (but I suspect 
that this is EC behaviour). This behaviour is consistent across any USB 
port on the laptop and, regardless if the external keyboard was 
connected to the laptop itself or via a hub.

2. With Huacai's code, I was able to wake up the laptop with an external 
keyboard in all the scenarios listed in (1). The internal keyboard still 
failed to wake up the system unless I strike the Fn key.

I should note, however, that the internal keyboard is not connected via 
USB so it's probably irrelevant information anyway.

As for mice, it seems that the kernel disables wake-up via USB mice and 
enables wake-up via USB keyboards. This is also consistent with your 
findings.

Best Regards,
Mingcong Bai

> Alan Stern
> 

