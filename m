Return-Path: <stable+bounces-269325-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cUf4GtEwP2qFPwkAu9opvQ
	(envelope-from <stable+bounces-269325-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 04:09:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B46146D0C66
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 04:09:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=pobox.com header.s=fm3 header.b=dTHNb1b2;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="T yNiBsl";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269325-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269325-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=pobox.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C053F303011B
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 02:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B495F2609E3;
	Sat, 27 Jun 2026 02:09:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1685B3C2D;
	Sat, 27 Jun 2026 02:09:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782526156; cv=none; b=GgKvtet4V+ykF5mclc9+RiK5juPNBybpUlbZNGovNQV/LrmQkS53uN0o4ujIlXCkDUQf1ziDjmCuCCBMEOTc29+ts41997b/NI00lDCWEvT+KTKqkyqQb6GulI2CWJhxzU0RQBjS/tzz9Hy7bYPJAKx9e4O40cS8fmKeAx5DW2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782526156; c=relaxed/simple;
	bh=xc523TpNaRxZ0a2q6Dqxl82/IUuuCb5gBZuAQ4JKHvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EgjVvWzARWdA5B9iNgDY8eSn+YVysoPVFJereBmP4K4H2VwfmWjENTYT0GpSRxM4kqHeoal47ZOZrOgisQTER+GhJV+w73WFN3HSye/Ofuav147CatKf8Fm0etZBgqB6uYhRLrEuusTGPyFcv0Io98tPcX6qF70HsHxxa1Cz8d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dTHNb1b2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TyNiBsl2; arc=none smtp.client-ip=202.12.124.149
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E5CAC1D000EB;
	Fri, 26 Jun 2026 22:09:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 26 Jun 2026 22:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1782526153;
	 x=1782612553; bh=3Pa5zEM92HyM1T41T1AW2m2CCTSjA07fzigzH2WHbfs=; b=
	dTHNb1b2V3O/kvFPNW7UMf2eL0S8v/FPe3/5zHsQpT+Zr+Trj6a8fbXxS+RcL9iG
	PwV3UJ6/MMWna8evcrRg0WQF76VezaAeP8UHW76zMxG4keVzCilgdCuCXrX7tO9X
	6zOOBv5WK8wcZ5UBk28hlLZWaZoyTC3yf7mdOwCt/sclATPOEmjZ7fIdVAT/hzes
	OeXIs2YJ0AW6qawZTaUB0+AFv9gY13mSO3ycGNZ1q6Pn5quu9KhXxpG7AArKKBWh
	rlLVnaPMbDIA3tBLrc8wN1MQZO2ZRsHg6DT/tVXfIYBNaCC9FKLFVFsFqvQ83xtQ
	7PYqzEXCnN+Gw7fErwjYAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782526153; x=
	1782612553; bh=3Pa5zEM92HyM1T41T1AW2m2CCTSjA07fzigzH2WHbfs=; b=T
	yNiBsl2SVozVU0/CROmGx0V4I/AWq4dftdlhnlTf4SJGde3V53AjmLibo78eGRlH
	//c7Bd0qN0+CfAb1Rj06mzVjyhhbA4ZXJw1xeFhVfyL8QpKenFwmNDVN+p1kn115
	Qo4sNtlTFk4CKP0djffBD4aE1pxIjEeyMX58Cdc8Ic/CPKMSJjwiZ7waP8d3tF4L
	Kj++LC5KkLgLgB3Ufv9gmHWv90dzrUe27ve+Sbmpx3vM63Xwou2sR4LI+H1TganK
	O1UrjyieV7XzrSDsdnpwoDzcNZPcFrsfTHNbqCk/G32IYsVOA5MPxAlnx838QxXT
	9+MuLTitOrOY1vsDl/DoA==
X-ME-Sender: <xms:yDA_amI0OPEu9b6U0YHyYCcB73csCMCmy9bfI6Fdz2sgvPYUi1g9SA>
    <xme:yDA_augNZUTuQgpSQXDn_a7ICg_v491XNgKkmawwc1SdeptSymcZ44oACf9UjjJ61
    oDdTGbB_i7mC123qwrkcaKYp_fPv1MCzxvhwuXAOjh3Ws8NeDGqWlw>
X-ME-Received: <xmr:yDA_an1pH2qol2eV8CnpCbZd1O404NZu3zeeiBcYZ3nv7IWCW9KKR63_xMrYTgu26HDCXvev-x67ZmsaksPUxYVRPn1XkPkt>
X-ME-Proxy-Cause: dmFkZTEKfx6Lj4Q98wruIK3Oi/KuV5DUYANUXSX/wfJBDERYwCBLeUVhwIwgv9qwnOQ1nU
    6g+BG/mZK9tBGZjQ5ugZMIODaaywLEDDK6Vk3yeRDTS98dPN4X5PcalPIdKXaHf7TddD5G
    wCaw5ZLtuLvyun7QbuQjhaCByIe0udRcFDa8KvI6jqrdboieBad7HyOYelYaD/Qf9QgRkJ
    yb8I49RFiWq/YqF5MbUjOITG6PeK95Vl82kZ/4zwOkrNSizQyYQoePy/lv12xFuGNNBN3O
    GS6EuUTqAAekWKgbRsHjmaXWJXHk/hk3i94UZOD1YOa6hr9yBm0kjFQaXVcWk7m9xUc3Vs
    fqAgeO8353raIR2psHFzFoUxPM8cdxPSVqxJIWvYkKytXCbCmnhcOGu3sU9TbM36UYmN6F
    vafPzmgjWlVLKbjNbpgH0+9Xgi7ppequxDvzwP+qOkV5TlMiTYCDtfzgdXoETc/xyFeFe2
    Gb3T/oQ3E6x9uHbaH+MpEy/P4tCUcs2YqX1Ue87s14eL49yrNCgy3DDC5IjUisbgoZyXzR
    XWDkhUKHm0kFgoZnO1rog4HGQAPaEBHscPcvRIKv+ufEGq/hlT+MhfF2Cr/YHq+/9IGxWR
    5k+C0yiXjrhJ551lNs8yLL18Hu+B3UOkWNN17+XkJXRyFilrncZAS3VQlhww
X-ME-Proxy: <xmx:yDA_anbpM6unxMQuPtVbkxllPdnRLcKJZogL5jP2B-G9w9ktxmPXpg>
    <xmx:yDA_ashv0bDf5YXys89RynWZIujii9U7B29MkbLZcNHtwjT713a-XQ>
    <xmx:yDA_avjvtZoHEW1f9Erx5fii5ULrdvbrdX9lBQrIeaBjiztIG20aaw>
    <xmx:yDA_ahCa1eOSziZcZjTACJfM6CwhZzdEQflBqiqsev1qemmpyZFg5A>
    <xmx:yTA_apAJ6sE1_9E-08oIDgK4sphJfd3Ha7k2YGbwdMSZHtIakjcml_3T>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jun 2026 22:09:09 -0400 (EDT)
Message-ID: <2b4c3bdb-5dcd-4834-9ee1-5a9a75ab4815@pobox.com>
Date: Fri, 26 Jun 2026 19:09:08 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 7.1 00/21] 7.1.2-rc1 review
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260625125613.243729608@linuxfoundation.org>
 <b7bd471b-e9da-4bfc-ad1d-24b378bd1e44@pobox.com>
 <aj7RmyBck8EkPn_s@google.com>
 <ab7df7bf-1b30-40c0-9463-a469abfa2bda@pobox.com>
 <aj7r1Eqt2SEnWsMZ@google.com>
 <626fc564-6f4b-430d-92f3-653981e3dcdd@pobox.com>
 <aj8WEfam__6fnNuM@google.com>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <aj8WEfam__6fnNuM@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pobox.com,none];
	R_DKIM_ALLOW(-0.20)[pobox.com:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269325-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dmitry.torokhov@gmail.com,m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:linux@roeck-us.net,m:shuah@kernel.org,m:patches@kernelci.org,m:lkft-triage@lists.linaro.org,m:pavel@nabladev.com,m:jonathanh@nvidia.com,m:f.fainelli@gmail.com,m:sudipm.mukherjee@gmail.com,m:rwarsow@gmx.de,m:conor@kernel.org,m:hargar@microsoft.com,m:broonie@kernel.org,m:achill@achill.org,m:sr@sladewatkins.com,m:dmitrytorokhov@gmail.com,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[barryn@pobox.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[barryn@pobox.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[pobox.com:+,messagingengine.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,messagingengine.com:dkim,pobox.com:dkim,pobox.com:email,pobox.com:mid,pobox.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B46146D0C66

On 6/26/26 5:31 PM, Dmitry Torokhov wrote:
> On Fri, Jun 26, 2026 at 03:23:12PM -0700, Barry K. Nathan wrote:
>> On 6/26/26 2:17 PM, Dmitry Torokhov wrote:
>>> On Fri, Jun 26, 2026 at 01:41:38PM -0700, Barry K. Nathan wrote:
>>>> On 6/26/26 12:56 PM, Dmitry Torokhov wrote:
>>>>> Hi Barry,
>>>>>
>>>>> On Fri, Jun 26, 2026 at 10:56:21AM -0700, Barry K. Nathan wrote:
>>>>>> (cc Dmitry Torokhov because this is related to two of your commits)
>>>>>>
>>>>>> On 6/25/26 6:03 AM, Greg Kroah-Hartman wrote:
>>>>>>> This is the start of the stable review cycle for the 7.1.2 release.
>>>>>>> There are 21 patches in this series, all will be posted as a response
>>>>>>> to this one.  If anyone has any issues with these being applied, please
>>>>>>> let me know.
>>>>>>>
>>>>>>> Responses should be made by Sat, 27 Jun 2026 12:54:50 +0000.
>>>>>>> Anything received after that time might be too late.
>>>>>>>
>>>>>>> The whole patch series can be found in one patch at:
>>>>>>> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.2-rc1.gz
>>>>>>> or in the git tree and branch at:
>>>>>>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
>>>>>>> and the diffstat can be found below.
>>>>>>>
>>>>>>> thanks,
>>>>>>>
>>>>>>> greg k-h
>>>>>>>
>>>>>> Unfortunately, 7.1.2-rc1 breaks the Synaptics touchpad on my Lenovo
>>>>>> ThinkPad T14 Gen 1 -- the pointer no longer moves when I touch the
>>>>>> touchpad. Potentially relevant line from dmesg:
>>>>>>
>>>>>> rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics, product: TM3471-020, fw id: 3972349
>>>>>>
>>>>>>> Dmitry Torokhov<dmitry.torokhov@gmail.com>
>>>>>>>         Input: rmi4 - refactor register descriptor parsing
>>>>>>>
>>>>>>> Dmitry Torokhov<dmitry.torokhov@gmail.com>
>>>>>>>         Input: rmi4 - fix register descriptor address calculation
>>>>>>>> Both of these patches seem bad in my testing. Either one, individually,
>>>>>> causes the pointer to no longer move when I touch the touchpad. If I
>>>>>> revert both of them, then my touchpad works again.
>>>>>>
>>>>>> I have not yet tested 7.0.14-rc1 or 6.18.37-rc1. However, the problem
>>>>>> also reproduces on current mainline as of this writing (commit
>>>>>> 51cb1aa1250c36269474b8b6ca6b6319e170f5a5).
>>>>> Could you please try applying this debug patch and send me dmesg?
>>>> Sure, I applied the patch on top of mainline, and the dmesg output is
>>>> below.
>>> Thank you! So I messed up and "Input: rmi4 - fix register descriptor
>>> address calculation" is totally wrong.
>>>
>>> Can you please revert it (keeping the debug patch) and try booting again
>>> and if the touchpad still does not work post the dmesg again.
>>>
>>> Thanks!
>>
>> I did the revert, while keeping the debug patch. With this kernel, the
>> touchpad still doesn't work for me, so here's the new dmesg.
> 
> Thank you. It looks like the firmware is a bit sloppy and the new
> tightened checks are tripping on it. Please try this patch:
> 
> 
> Input: rmi4 - tolerate short register descriptor structure
> 
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Some touchpads (e.g. ThinkPad T14 Gen 1) have buggy firmware that reports
> a register descriptor structure size that is too small for the number of
> registers it claims to have in the presence map. The remaining bytes in
> the structure are 0, which with the new strict bounds checking causes the
> parser to fail with -EIO, aborting the device probe.
> 
> Tolerate such short reads by dropping the remaining (unparseable or
> 0-size) registers from the list instead of failing the probe,
> preventing the driver from trying to use them.
> 
> Fixes: 0adb483fbf2d ("Input: rmi4 - refactor register descriptor parsing")
> Reported-by: Barry K. Nathan <barryn@pobox.com>
> Cc: stable@vger.kernel.org
> Assisted-by: Antigravity:gemini-3.5-flash
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Yes, this worked! To be clear, what I did (and what I'm successfully
running now) is:

1. Start with mainline as of commit 51cb1aa1250c36269474b8b6ca6b6319e170f5a5
2. Then revert a98518e72439fd42cbfe641c2896543cb088e3d1
    ("Input: rmi4 - fix register descriptor address calculation")
3. Then apply the new patch
    ("Input: rmi4 - tolerate short register descriptor structure")

If there's anything else I need to test or anything else you want me
to try, please let me know. Thank you!

-- 
-Barry K. Nathan  <barryn@pobox.com>

