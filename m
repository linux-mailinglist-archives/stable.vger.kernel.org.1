Return-Path: <stable+bounces-76161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADAF97975F
	for <lists+stable@lfdr.de>; Sun, 15 Sep 2024 17:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF1C1C20AF3
	for <lists+stable@lfdr.de>; Sun, 15 Sep 2024 15:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B801C6F78;
	Sun, 15 Sep 2024 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="sBEWH2mF"
X-Original-To: stable@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF6417BBE
	for <stable@vger.kernel.org>; Sun, 15 Sep 2024 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726412507; cv=none; b=M9ZopJIPWYjPDkidxhAoPekmbYzkD4ixjEwHab2Ox/BZkh5eqVsDrnRjZre2yXgXrrE/0tRKOhZbpGkoRqItv/jqvJVwjSUf1fS6dB7DMunoeBXLCW2bdCenETNa7fOoqK9/vUxz92UJ4Tqeb/0+g+9Rk4zelCGZueb1SzHb6YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726412507; c=relaxed/simple;
	bh=mJkmRu67wu2FBYJDd5gC0HWoGDWeWC00r79enZB3UsE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Uwcfyw4e75svDeKJH7JAAIWKZ61UGuxloxIWjv7nsadBXi1se4LLWqy6D1iJWPixB61zwcswuE1ja64KPre66ba/nOGi903sJeWEbuTigTHtK0c3KuowCYWK3ofxpPuQLCPH31awX72aC+4XfAEnBrToHEZKLp15jfnXv8Jka98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=sBEWH2mF; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTPS
	id pRl0soPvdVpzppqkssJRLR; Sun, 15 Sep 2024 15:01:38 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id pqkrsw3fhD1F3pqkrsnYQL; Sun, 15 Sep 2024 15:01:37 +0000
X-Authority-Analysis: v=2.4 cv=Ffoxxo+6 c=1 sm=1 tr=0 ts=66e6f6d1
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=laDfMnwPvlV8RbZy:21 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7vwVE5O1G3EA:10
 a=VwQbUJbxAAAA:8 a=LNEQrawzAAAA:8 a=uS7RAPvdmta9kbX28JEA:9 a=QEXdDO2ut3YA:10
 a=TG63qu3eEmdwY2BC5db5:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
	Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=UnrjJPh4oBGo9hXxo17DCGW3tolqp1s9+4N/VKQBb1I=; b=sBEWH2mFf31UaTOst8w0wQTKTX
	46utWePy0mEV5qGlJ+W4MoQUtssnVRl4iiFX5IvbVAui6DancHXyRZXMlMp1Kvz0mn3JeE+e+LJEq
	xcIdkbS4HO0rGZUyAj1K8b3F1kAdor/qBHTDG4K+ldn48FfzTDrASgZXX/s4hK+x1SOOVB9CYUSzJ
	6bpkZJt7pZ7lQFaSbGWmDDBXIUe+jq64zZe0m0X3fv45D/CgHDt6JcPc3WYT6ad9cldl13P//cB/3
	pLSSG6o3E78ndcJn2XFwxWMSJt+cBwNoCQruyxLGGXiir4NKICMzjXnh0iKZa5yOFis3ets8sgjzy
	dZrfpcKA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:40524 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1spqkp-003TXC-0U;
	Sun, 15 Sep 2024 09:01:35 -0600
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
From: Ron Economos <re@w6rz.net>
Message-ID: <148a908f-e2e2-6001-510e-73aef81d07b5@w6rz.net>
Date: Sun, 15 Sep 2024 08:01:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2024091501-dreamland-driveway-e0c3@gregkh>
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
X-Exim-ID: 1spqkp-003TXC-0U
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:40524
X-Source-Auth: re@w6rz.net
X-Email-Count: 3
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfL3xPntX1h26E8CPcFxYnu1HK6fvqcJ7zDl9RkCn9qcyGJcSkj7drDISprDLLwYiAK2roc10/uVqPqps+TLs2dtOS3BOoPqmIk6C2UyQxiYfOC0XHbl1
 YYo889uLu+seMj40EHTtK8/rr5yKa4FeJr11Gy7sTO+8m+cOzQbakBl38eqjU6UorUNbfC+vLXL+ag==

On 9/15/24 6:22 AM, Greg KH wrote:
> On Sat, Sep 14, 2024 at 03:32:33AM -0700, Ron Economos wrote:
>> On 9/14/24 3:04 AM, Xingyu Wu wrote:
>>> On 14/09/2024 17:37, Greg KH wrote:
>>>> On Sat, Sep 14, 2024 at 09:24:44AM +0000, Xingyu Wu wrote:
>>>>> On 14/09/2024 16:51, Greg KH wrote:
>>>>>> On Sat, Sep 14, 2024 at 08:01:44AM +0000, Xingyu Wu wrote:
>>>>>>> On 13/09/2024 22:12, Sasha Levin wrote:
>>>>>>>> This is a note to let you know that I've just added the patch
>>>>>>>> titled
>>>>>>>>
>>>>>>>>       riscv: dts: starfive: jh7110-common: Fix lower rate of
>>>>>>>> CPUfreq by setting PLL0 rate to 1.5GHz
>>>>>>>>
>>>>>>>> to the 6.10-stable tree which can be found at:
>>>>>>>>       http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-
>>>>>>>> queue.git;a=summary
>>>>>>>>
>>>>>>>> The filename of the patch is:
>>>>>>>>        riscv-dts-starfive-jh7110-common-fix-lower-rate-of-c.patch
>>>>>>>> and it can be found in the queue-6.10 subdirectory.
>>>>>>>>
>>>>>>>> If you, or anyone else, feels it should not be added to the
>>>>>>>> stable tree, please let <stable@vger.kernel.org> know about it.
>>>>>>>>
>>>>>>> Hi Sasha,
>>>>>>>
>>>>>>> This patch only has the part of DTS without the clock driver patch[1].
>>>>>>> [1]:
>>>>>>> https://lore.kernel.org/all/20240826080430.179788-2-xingyu.wu@star
>>>>>>> five
>>>>>>> tech.com/
>>>>>>>
>>>>>>> I don't know your plan about this driver patch, or maybe I missed it.
>>>>>>> But the DTS changes really needs the driver patch to work and you
>>>>>>> should add
>>>>>> the driver patch.
>>>>>>
>>>>>> Then why does the commit say:
>>>>>>
>>>>>>>>       Fixes: e2c510d6d630 ("riscv: dts: starfive: Add cpu scaling
>>>>>>>> for
>>>>>>>> JH7110 SoC")
>>>>>> Is that line incorrect?
>>>>>>
>>>>> No, this patch can also fix the problem.
>>>>> In that patchset, the patch 2 depended on patch 1,  so I added the Fixes tag in
>>>> both patches.
>>>>
>>>> What is the commit id of the other change you are referring to here?
>>>>
>>> This commit id is the bug I'm trying to fix. The Fixes tag need to add it.
>>>
>>> Thanks,
>>> Xingyu Wu
>>>
>> I think Greg is looking for this:
>>
>> commit 538d5477b25289ac5d46ca37b9e5b4d685cbe019
>>
>> clk: starfive: jh7110-sys: Add notifier for PLL0 clock
> That commit is already in the following releases:
> 	6.6.51 6.10.10
> so what are we supposed to be doing here?
>
> confused,
>
> greg k-h
>
Sorry, I didn't check to see if it was already in releases. So the 6.10 
queue is fine as is.

However, these two patches go together, so the 6.6 queue should also 
have 61f2e8a3a94175dbbaad6a54f381b2a505324610 "riscv: dts: starfive: 
jh7110-common: Fix lower rate of CPUfreq by setting PLL0 rate to 1.5GHz" 
added to it.

Does that make sense?



