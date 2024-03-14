Return-Path: <stable+bounces-28205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FD187C4C8
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 22:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC4F1C213BA
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 21:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955A776038;
	Thu, 14 Mar 2024 21:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="C+QY9KBu"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3D67351E
	for <stable@vger.kernel.org>; Thu, 14 Mar 2024 21:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710452111; cv=none; b=lxAaMC0en/BFjj8h5ZdLwMQwHedIoHXmr4j8mGare9OpEFMIBxX/78lIXvbK8Zd2fcxeOUlUBaX6lvBUgtPOMIAfxOkkXpU0bdsi07wb6ZnbeTF61QM89ocE21Pgy839eZ7TmRb63qJDMSwngrfXqdxMembk7Yvr4QzUARPUU48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710452111; c=relaxed/simple;
	bh=1HwOnLhbE1EX5RXbt4m2P2RGUpTCJCjEPOzqchsraes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uqo6o4gnNpGY6HlbiZltodVJ2ul/ugMbQFhpeXftsHdhiKHboLUdjs6diSb/2vtK7qTiagVLimQSnuRM3Hou5Rs5MfL6vI1jbPTYDBP3sGXbIDq4K44Ilhicj8Bq7bKCK63OQSNc/gWp1a5wowd487EaTgqlEAqT+RhNH4a8ZD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=C+QY9KBu; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1710452100; x=1711056900; i=deller@gmx.de;
	bh=+3qZJvJwBjXr+dyldu9Rw7wIWm5BerwNmpYPGWgFr4o=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=C+QY9KBuan3/Xesngs45/NJTghg52OWTd79MReoImrdV7GuW21c5zMQ1afG/sFBh
	 yYykskDYwlVJnuzbT+vPRskXNQgNno8hq6skEVeocQ6AlZTHYOEq3Oug58nciYXJU
	 kOXM41hKW19AYM7dXHN9vB40eb4knrLVQJjCqd8zeI9SBT67+75FX4uzm8NIwPLG5
	 /YrDZ8zllbK1OmOSAoIevK2RJy1MXeo5WRtFVfkn42GHc9ijPju/tKaptzgGdmX1l
	 7vwVTjv6JOzQnWIBYKO373JwQh9OSzwcZI6FbIrzfP8I99l7hTihvEQp0HDyZCCM8
	 JJ0ojACcWkZ/ZFwziw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.150.248]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mzhj9-1qpUkn2PhJ-00vg6b; Thu, 14
 Mar 2024 22:35:00 +0100
Message-ID: <77fd3622-8b01-418f-9dab-2ab23a3a844e@gmx.de>
Date: Thu, 14 Mar 2024 22:34:59 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bachefs stable patches [was dddd]
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Helge Deller <deller@kernel.org>
References: <ZfLGOK954IRvQIHE@carbonx1>
 <vubxxvlsgyzzn64ffdvhhdv75d5fal5jh5xew7mf7354cddykz@45w6b2wvdlie>
 <ed1eda66-8d67-4661-b50f-f2b152928bf3@gmx.de>
 <2vpsaj7bwn5yvpyerexgga3m22wvqfom32hbc3cics4vrs6lbm@gc47zhr756sr>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <2vpsaj7bwn5yvpyerexgga3m22wvqfom32hbc3cics4vrs6lbm@gc47zhr756sr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lrZTl56NM4YWYhnFx3dWh/FmcAOLWtA/e6krY+ZmT7A6rgkMzT9
 lpWT4ko9S7pBV0lJwM9oaG0BTQBcRFUoMLcM4QW4rmmxbeNcIPKvlSmDDJZ6RcRQ5tjC2QB
 v72C/6zAaxixwXGTwzmbVI9zvwtKD/b4pQOqTnXUI0tA/muTtOrX/8xgPT9GnFoR4KohQS5
 kVHLoXgPrKb7KIrmwS9hw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SL1C4d7j9cY=;GVJTq1IOudbY0/iLRCg/wVCihcf
 IwkwcHfrXuOHeHm09tSG/iBTQDDydhM3nq5HJMjisxnO+otVKyCrk28oe5E8Ecij50s1vgQzg
 2PO7wVPIb+Xdkp2JDLSWEBv9PM6jHKIQvXl0pm/DSZ/YCOCgK9KP03QblVGTpeA9pwz+6BhwY
 OypJhaybrzwUrZpNBVYQesHonpUH4pUJDXey9Uf7h6qhk4vqE8ssQsprqjLkS5iNnjtckS0bT
 N1De5RLaYiGSZ2g1V1eXPWuRl84vVY9o3mL39L2VzCOu3P3ZiB5jaxYR16i/8U0Pe2gDOJvhM
 rojv33pnd7I4mdRZloLC/WJZ/musgT98ZeZy+piv4oVROfeXKrHt5zL5477jUhtFVxxHx3H/E
 NpgH5C6F1f039f79tCTbqjfyCoG4JTSJ6ELwWnApnf+JAY1K7PkOzMDqskNjxhruqFUGUgbFu
 2AXHhHTi087V2GoNMVxB78M0DURyOKLOnG9QA2Gui/e/hsP+CBcOszwqym6Fbsy9Q4GvOtqGb
 Bcsq4hSHwuykAXv7Bp5DfS+y6IiKjXyPnKQf7iOVouyoqtN+9DAanJqACdwGxsGjtHh3IFyHs
 VfHDhbMIplFS7Bf2W15MPXTtxGFCdJGG661Mjbgu1gRwt6v8mDwBftLO3jGhzETArOuzZqWSR
 JSwcGn21bVvwH1PueqyFjZc3XzCVJB4plHi8hh2EKlx9ELG9Cq2D3FaAApOcivKW0e9kQ1gfp
 5+dWMTihArfbCknNFvyeQVBOVac3/9Z0FDAdSmRBwkPfSuA1t2KKoRuWrMoG0XLvzxoevR90l
 Gusp6q/gAIDy/wHhYh46+ZbJ9VYKaYcEG1JKZOz59M2m0=

On 3/14/24 20:08, Kent Overstreet wrote:
> On Thu, Mar 14, 2024 at 01:57:51PM +0100, Helge Deller wrote:
>> (fixed email subject)
>> On 3/14/24 10:46, Kent Overstreet wrote:
>>> On Thu, Mar 14, 2024 at 10:41:12AM +0100, Helge Deller wrote:
>>>> Dear Greg & stable team,
>>>>
>>>> could you please queue up the patch below for the stable-6.7 kernel?
>>>> This is upstream commit:
>>>> 	eba38cc7578bef94865341c73608bdf49193a51d
>>>>
>>>> Thanks,
>>>> Helge
>>>
>>> I've already sent Greg a pull request with this patch - _twice_.
>>
>> OIC.
>> You and Greg had some email exchange :-)
>>
>> Greg, I'm seeing kernel build failures in debian with kernel 6.7.9
>> and the patch mentioned above isn't sufficient.
>>
>> Would you please instead pull in those two upstream commits (in this or=
der) to fix it:
>> 44fd13a4c68e87953ccd827e764fa566ddcbbcf5  ("bcachefs: Fixes for rust bi=
ndgen")
>
> You'll have to explain what this patch fixes, it shouldn't be doing
> anything when building in the kernel (yet; it will when we've pulled our
> Rust code into the kernel).

Right. It doesn't actually do anything in the kernel (which is good), but
it's logically before patch eba38cc7578bef94865341c73608bdf49193a51d
and is required so that eba38cc7578bef94865341c73608bdf49193a51d cleanly
applies.

Helge

