Return-Path: <stable+bounces-76163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F4597976F
	for <lists+stable@lfdr.de>; Sun, 15 Sep 2024 17:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD734281EBF
	for <lists+stable@lfdr.de>; Sun, 15 Sep 2024 15:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AD41C7B82;
	Sun, 15 Sep 2024 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="lM9iMxdY"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A586543ABD
	for <stable@vger.kernel.org>; Sun, 15 Sep 2024 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726413483; cv=none; b=YXwfOrLwHuMhBcEslxdH+z44hO5tiKmOzVnanNHwtT1graGoUl+mw7XeYteibz308rgBMnz3p8Vku6sOZne8ThiW0uy3yR1iJZlUOWv5opXFocWHgj0roqBTGBD7xTJCDnZ9joWNtSiM60L1ja3wba+i8v4VrEYVsHjqrQsQHlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726413483; c=relaxed/simple;
	bh=FAke71PPV7UuLEIn2+Pxo8DEvEn3mFVw7hUfXfbdXa0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kHXYmYy+PiRdLUCNWUNUnFQxlUp972wTwrV/UkRzqJsseuvpwuJfETbYWOy9bBCPmu7pUllsIIt8eKKhj+MLcqcWOZH78D7QAx6UwIiP7EXAgYDsd3I6eCXpCVnSOmFrLSZfSTlzthdsHGjeBcX/7njQ1l40GHHWm1CQaQwNbiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=lM9iMxdY; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id pfxas6fbliA19pr0dsoAiw; Sun, 15 Sep 2024 15:17:55 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id pr0cs3CPtV2ivpr0cs9s15; Sun, 15 Sep 2024 15:17:54 +0000
X-Authority-Analysis: v=2.4 cv=OLns3jaB c=1 sm=1 tr=0 ts=66e6faa2
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=laDfMnwPvlV8RbZy:21 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7vwVE5O1G3EA:10
 a=VwQbUJbxAAAA:8 a=LNEQrawzAAAA:8 a=RTMV0P7I31P55PDG7BsA:9 a=QEXdDO2ut3YA:10
 a=TG63qu3eEmdwY2BC5db5:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
	Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=M/hzHkagkLCx05LIwxZKR37UEX0vUREPGxIXtLaSYoQ=; b=lM9iMxdY9vhvE1CpHhXUVSmrK9
	t+6Bsrvn/dfzK8Gu92InMhakFiPjiPx7ymDIvlsPraYhz9OcN4syFjzVSvoZQ13Up+RHGZgQQ+/Ey
	oIFS8zad69UfQCURS6W90pLbuCJjIeFrVG4rgBv+zLjt4t5E2ti6d36cnCHZ0TpSWVftyd9kyvrio
	Vx/f37mvwzIsKtH66oek0ntIsGnpH0ceVgSCu5gDUglgsjvYBmmr7iTIpAgKfD4dkcCyfin6BDPk0
	Csj0a6nH1uycwSS6TfCq/3LWc7es2GR3LDXhrndV7QEEkZHTTHxczEgh593veVSxM/q4HWUN2X7qE
	Roz8bZEw==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:40532 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1spr0a-003ZYE-2P;
	Sun, 15 Sep 2024 09:17:52 -0600
Subject: Re: Patch "riscv: dts: starfive: jh7110-common: Fix lower rate of
 CPUfreq by setting PLL0 rate to 1.5GHz" has been added to the 6.10-stable
 tree
To: Greg KH <greg@kroah.com>
Cc: Xingyu Wu <xingyu.wu@starfivetech.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>,
 Sasha Levin <sashal@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>,
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Hal Feng <hal.feng@starfivetech.com>
References: <20240913141134.2831322-1-sashal@kernel.org>
 <NTZPR01MB0956F268E07BAE72F3A133DE9F662@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <2024091451-partake-dyslexia-e238@gregkh>
 <NTZPR01MB0956BF9AAE1FCAAF71C810A69F662@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <2024091445-underwent-rearview-24be@gregkh>
 <NTZPR01MB0956C2EF430930E4DB2C35BE9F662@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <59b65d17-7dce-ef5d-41ba-2c04656fb2e8@w6rz.net>
 <2024091501-dreamland-driveway-e0c3@gregkh>
 <148a908f-e2e2-6001-510e-73aef81d07b5@w6rz.net>
 <2024091557-contents-mobster-f2c3@gregkh>
From: Ron Economos <re@w6rz.net>
Message-ID: <3acc9ffe-9468-54e4-96a4-9d2bc852d99d@w6rz.net>
Date: Sun, 15 Sep 2024 08:17:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2024091557-contents-mobster-f2c3@gregkh>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.223.253.157
X-Source-L: No
X-Exim-ID: 1spr0a-003ZYE-2P
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:40532
X-Source-Auth: re@w6rz.net
X-Email-Count: 16
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFXu8qUWH8mGC2bbbooozJfBUEOL5sbkk2K4WZ/DlOSAf7tZ2IVxES+TdhdJkS2+6bIHLJT+2qzpw1NaYijRoIlIlscIpAqmpsTRhcD0xZeYtJ8Rk87v
 OTxW0lMpAgkGji/60MahPqllKJcOWo265WOfx3cT+96QECRzFRqhBwjP2uPvxdNNJUxswbWeFg/EyQ==

On 9/15/24 8:10 AM, Greg KH wrote:
> On Sun, Sep 15, 2024 at 08:01:33AM -0700, Ron Economos wrote:
>> On 9/15/24 6:22 AM, Greg KH wrote:
>>> On Sat, Sep 14, 2024 at 03:32:33AM -0700, Ron Economos wrote:
>>>> On 9/14/24 3:04 AM, Xingyu Wu wrote:
>>>>> On 14/09/2024 17:37, Greg KH wrote:
>>>>>> On Sat, Sep 14, 2024 at 09:24:44AM +0000, Xingyu Wu wrote:
>>>>>>> On 14/09/2024 16:51, Greg KH wrote:
>>>>>>>> On Sat, Sep 14, 2024 at 08:01:44AM +0000, Xingyu Wu wrote:
>>>>>>>>> On 13/09/2024 22:12, Sasha Levin wrote:
>>>>>>>>>> This is a note to let you know that I've just added the patch
>>>>>>>>>> titled
>>>>>>>>>>
>>>>>>>>>>        riscv: dts: starfive: jh7110-common: Fix lower rate of
>>>>>>>>>> CPUfreq by setting PLL0 rate to 1.5GHz
>>>>>>>>>>
>>>>>>>>>> to the 6.10-stable tree which can be found at:
>>>>>>>>>>        http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-
>>>>>>>>>> queue.git;a=summary
>>>>>>>>>>
>>>>>>>>>> The filename of the patch is:
>>>>>>>>>>         riscv-dts-starfive-jh7110-common-fix-lower-rate-of-c.patch
>>>>>>>>>> and it can be found in the queue-6.10 subdirectory.
>>>>>>>>>>
>>>>>>>>>> If you, or anyone else, feels it should not be added to the
>>>>>>>>>> stable tree, please let <stable@vger.kernel.org> know about it.
>>>>>>>>>>
>>>>>>>>> Hi Sasha,
>>>>>>>>>
>>>>>>>>> This patch only has the part of DTS without the clock driver patch[1].
>>>>>>>>> [1]:
>>>>>>>>> https://lore.kernel.org/all/20240826080430.179788-2-xingyu.wu@star
>>>>>>>>> five
>>>>>>>>> tech.com/
>>>>>>>>>
>>>>>>>>> I don't know your plan about this driver patch, or maybe I missed it.
>>>>>>>>> But the DTS changes really needs the driver patch to work and you
>>>>>>>>> should add
>>>>>>>> the driver patch.
>>>>>>>>
>>>>>>>> Then why does the commit say:
>>>>>>>>
>>>>>>>>>>        Fixes: e2c510d6d630 ("riscv: dts: starfive: Add cpu scaling
>>>>>>>>>> for
>>>>>>>>>> JH7110 SoC")
>>>>>>>> Is that line incorrect?
>>>>>>>>
>>>>>>> No, this patch can also fix the problem.
>>>>>>> In that patchset, the patch 2 depended on patch 1,  so I added the Fixes tag in
>>>>>> both patches.
>>>>>>
>>>>>> What is the commit id of the other change you are referring to here?
>>>>>>
>>>>> This commit id is the bug I'm trying to fix. The Fixes tag need to add it.
>>>>>
>>>>> Thanks,
>>>>> Xingyu Wu
>>>>>
>>>> I think Greg is looking for this:
>>>>
>>>> commit 538d5477b25289ac5d46ca37b9e5b4d685cbe019
>>>>
>>>> clk: starfive: jh7110-sys: Add notifier for PLL0 clock
>>> That commit is already in the following releases:
>>> 	6.6.51 6.10.10
>>> so what are we supposed to be doing here?
>>>
>>> confused,
>>>
>>> greg k-h
>>>
>> Sorry, I didn't check to see if it was already in releases. So the 6.10
>> queue is fine as is.
>>
>> However, these two patches go together, so the 6.6 queue should also have
>> 61f2e8a3a94175dbbaad6a54f381b2a505324610 "riscv: dts: starfive:
>> jh7110-common: Fix lower rate of CPUfreq by setting PLL0 rate to 1.5GHz"
>> added to it.
> Given that the file arch/riscv/boot/dts/starfive/jh7110-common.dtsi is
> not in the 6.6.y kernel tree, are you sure about this?  If so, where
> should it be applied to instead?
>
> thanks,
>
> greg k-h

Doh, the patch was rebased, so it won't apply to 6.6. The good news is 
that not applying it won't break anything, it just renders the other 
patch to have no effect (the board still runs at 1 GHz instead of 1.5 GHz).

So in the end, there's nothing to do.



