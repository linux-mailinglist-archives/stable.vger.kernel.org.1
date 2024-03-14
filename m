Return-Path: <stable+bounces-28210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A0787C51D
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 23:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2FD1F21EB8
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 22:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B64476038;
	Thu, 14 Mar 2024 22:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="Q3Lv9oTP"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3221A38EE
	for <stable@vger.kernel.org>; Thu, 14 Mar 2024 22:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710455138; cv=none; b=gROEcYd+2dReAff1ns48SuyCJyRFU0gyuuYq174vZ1y0ymk3MvJHwzUWRvqF80bHnUHRM2ptROFqIGtKO48e1oCjBAt9o8TlehaU4tv3SDb4cLWkbC6q0fV2E8o+PAp5rX51fxNpI5f/WgFRa2EuPo5F/DA35mYD2v7hURQoPU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710455138; c=relaxed/simple;
	bh=AHXvtGcJtqF7sRTD+bttuVvgPyStSkcBGp2Kl3Kx9v0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKhY+/vo0LHRWhOiUeUCt5HZNk/3ReTg790UDpnOa0soeWETMIhDk4ydug3mC3HbZwrUBrooRpiphpDLeb6eFs3zEshZcwWfQUyVBoQboliJg3ZhRMdaEd0l84Uzkj44+n1AdR7+sUpLiLGfLBt/bt0PPjT8c0M+KtF+DIwdOlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=Q3Lv9oTP; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1710455129; x=1711059929; i=deller@gmx.de;
	bh=tc8k+1z/nhZwLDmJizuygyaYVnHtGGEINTXgpqre2U8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Q3Lv9oTP7GPSfCxGjOYbw9cmOfp0Y7sETRSozJdse7Gm8BqM9dmXpUVGmbHQE9Kp
	 3zbPNXdACbfAijpDX65mGgIRtPIoKg5S0uwDLH0IWH49GKAUAiwDYOpPhY6V1zK6L
	 pKQ7LfKfRGDkQE56MFT0mm+ZDfXEAY3GcJQSYq5sGAiUIE9Y2HcJARjtlFpUDzg2W
	 h74CFBTeGYhFUKTAPwI+Ctt0zMtfYDa1Mr21AOk/AfDtxC6/YHYgKMJHtE4WqER3p
	 Q7lzCkGqzTCBQNJq5pDSOl1Hd7IIPxwjHpobzEW+SfIzKPOL+rQ/bnLSKxo9TRhfr
	 OneG7FODS1J0a3Os9g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.150.248]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M26vL-1rmoFs0aMb-002ZBn; Thu, 14
 Mar 2024 23:25:29 +0100
Message-ID: <96db0a2e-ba5d-4d78-be69-14414d6bb5ca@gmx.de>
Date: Thu, 14 Mar 2024 23:25:28 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bachefs stable patches [was dddd]
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Helge Deller <deller@kernel.org>
References: <ZfLGOK954IRvQIHE@carbonx1>
 <vubxxvlsgyzzn64ffdvhhdv75d5fal5jh5xew7mf7354cddykz@45w6b2wvdlie>
 <ed1eda66-8d67-4661-b50f-f2b152928bf3@gmx.de>
 <2vpsaj7bwn5yvpyerexgga3m22wvqfom32hbc3cics4vrs6lbm@gc47zhr756sr>
 <77fd3622-8b01-418f-9dab-2ab23a3a844e@gmx.de>
 <rgwqmfpfcpcnmoma5by4qf6c5ehugdz2uijkffdwq2cdhingqy@7676cbvj34vl>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <rgwqmfpfcpcnmoma5by4qf6c5ehugdz2uijkffdwq2cdhingqy@7676cbvj34vl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:14mCttMTwIKvICV4o/xP+PLvDcLqExy8U2LlBjFQ+9iKdvyj0LJ
 uE8lZKeegYf+Gu2ys/ZqQh/AZIlr6ZBcBbNEKim90Ckqm2SL1YXjy+5VyVoY9SDLFytqvXG
 4AyX5xyNTdNpCZfLlPhp41Zr7iWUjo/wBXe4dXbIT7bcyfGJY5a8zA86QXpF73cetXSWCUH
 9fhBTxmvMMOvRDUlURq3A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AVvJFo7UST4=;OCI/HBQF/7Dy82SkJ+/i/U/ICgu
 2TaLw03iXh99tKzDF9DDlcW6np+ZUzUJ3itpmkS1nH79ifyTS0bzIXRfgLANqPOYgJBkJCDgE
 WXt9nClQe1heLx2QXXxyxyS73NIeJpxWc56Wt7rdppPfpM4FhZGlDOp/JQqflk57k1CN8k+U7
 YJ4qPig+08uBX9Tfudc/4j4Y2vQmTyo8edTq/mZaAD7FZvRv5Hum2aoz6n+aFRjcigBdIlkRd
 oNyhZ5S+yhFFBh+AOvGwLoVJBnEjwiXyVxEpqHy3B9gid9ZIQS8BbNojt/Y1FbGp66adK7fjm
 DWdUcfaqOjV8w0zXRLg2JGtHzc7pQ1lElM12dTwyXXldEhAROMln2s2jhbUSagA1uWSU3IhUU
 f6/VIihyFP0HDtFa+1nE7Jk3owtpBIY7mp8TtuEWCC3pP0fLWDQbQhy1aPXf90GjcjNjFi/fb
 hv37zA2OwmPZXSnkBM+3++AU1XAac8/RdTSb6rX+EHudcs/yVeU7pFKGskFGqTS1rGC4vzvdg
 9g/bP8V2oOsPGtEDZ1iJ/uGFprDMN6LOt0gyWwzGsMvQuwKZhahDL56vl9LnnV5dq5TrExIsh
 XEuuvL6dlZk2/iPylALKAlCwyMMISlq97KZ/geJZ25yNO/ggO8gc9PpZD7xRKJ3Qc0BdS0Qq8
 BDMBcZztkTQP3nlaiPVNozB98HbEX9NaCn1l9jdjbksGJqd5Nzp95lC+Trhw+5aoSAZC7KQAw
 mg2tcnJeLga6lwdWI6H0g0vGHjc3hPoRQHWng+KgE9edkGMj15EyYFmGalOXkHZqW2Qkj3w4P
 huOctDcKENEzGCA5rdsvR7zyreMTV4999FJEVqanaQmkw=

On 3/14/24 23:19, Kent Overstreet wrote:
> On Thu, Mar 14, 2024 at 10:34:59PM +0100, Helge Deller wrote:
>> On 3/14/24 20:08, Kent Overstreet wrote:
>>> On Thu, Mar 14, 2024 at 01:57:51PM +0100, Helge Deller wrote:
>>>> (fixed email subject)
>>>> On 3/14/24 10:46, Kent Overstreet wrote:
>>>>> On Thu, Mar 14, 2024 at 10:41:12AM +0100, Helge Deller wrote:
>>>>>> Dear Greg & stable team,
>>>>>>
>>>>>> could you please queue up the patch below for the stable-6.7 kernel=
?
>>>>>> This is upstream commit:
>>>>>> 	eba38cc7578bef94865341c73608bdf49193a51d
>>>>>>
>>>>>> Thanks,
>>>>>> Helge
>>>>>
>>>>> I've already sent Greg a pull request with this patch - _twice_.
>>>>
>>>> OIC.
>>>> You and Greg had some email exchange :-)
>>>>
>>>> Greg, I'm seeing kernel build failures in debian with kernel 6.7.9
>>>> and the patch mentioned above isn't sufficient.
>>>>
>>>> Would you please instead pull in those two upstream commits (in this =
order) to fix it:
>>>> 44fd13a4c68e87953ccd827e764fa566ddcbbcf5  ("bcachefs: Fixes for rust =
bindgen")
>>>
>>> You'll have to explain what this patch fixes, it shouldn't be doing
>>> anything when building in the kernel (yet; it will when we've pulled o=
ur
>>> Rust code into the kernel).
>>
>> Right. It doesn't actually do anything in the kernel (which is good), b=
ut
>> it's logically before patch eba38cc7578bef94865341c73608bdf49193a51d
>> and is required so that eba38cc7578bef94865341c73608bdf49193a51d cleanl=
y
>> applies.
>
> yeah I just fixed the merge conflict

Where did you fixed it?
Those two patches are already upstream, and ideally should go downstream a=
s-is...

Helge

