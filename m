Return-Path: <stable+bounces-57986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5788E926A15
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 23:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224C11C219B0
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 21:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0557D136678;
	Wed,  3 Jul 2024 21:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="lbAFnwpk"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20522BB13
	for <stable@vger.kernel.org>; Wed,  3 Jul 2024 21:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720041380; cv=none; b=tRZ5igr1nRJto0njRG5xJybQUe/d7PoRKOxUCeabHg2XC7H/dmSt6sgJXS0YURhs2bYpgLNbaBZTqk+zLkVqU+Wiv5c/EJ07owic/xNlPhU9/qfBn7hgpQOIIg5fZuOrBk+O0VPSRxaujmB5Vd9gSVyH4zfKI2+rnaKr39bmi/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720041380; c=relaxed/simple;
	bh=voYrdbPdDbhbmyIRqBPJntYOUm0DARjxPxAKwX76mmY=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=aW68vAd5jzYokeRp04338anXE97FJ0MA6CM4+KYDw4mG0rt7ANhv7zmAr22Vs9G7sTms+pt1TjTeV1TYpfqDXR/epPqboKXHq6mUEE3l4ZbDatOTfg0tCyvY9J4R7xinH6gDEHhVhMsQ5neSJEXpWH2h5jBQg21up2tcEE10OgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=lbAFnwpk; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id P0DksXiYrAidIP7JJskj8Y; Wed, 03 Jul 2024 21:14:41 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id P7JIsdM62DweaP7JJsltI1; Wed, 03 Jul 2024 21:14:41 +0000
X-Authority-Analysis: v=2.4 cv=BcYT0at2 c=1 sm=1 tr=0 ts=6685bf41
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=dM-kR4knkKEf_V6v5WMA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/aQwcjusGogKCbZOLVYA3pnyiVRW4FVkyjTbotPvRUU=; b=lbAFnwpkySI/+O1dIHLGZzLlEl
	PiahoqkFhxJAvLRB6k4z+kcZC+ugWbbxIj1I+9y7PMxFxqBkhx0QxPCNgKjxX9ljsvq8T/fPskKBk
	V27mo2vKwM4e8fNhdNMTI5TQqow5MeXKJrSV8MARKdSB+uAY5vxFF9H0CtWrBsN8wcuSYBESdBvry
	X6kaDkHeCJcnOfNE/VG2jI62uxCieY3XtFOompEZHVghDPXjU69Lpu0tSnOrCY1AM6utw+u+As3yQ
	on2p/u6wS1AahO+p+Hu7OBoaCdmmZsRJtTI7RlDR7/0DilpNZtJxiyp2huQcnChRhv5V6fM01kl6/
	qcZw2zQA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:46966 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sP7JD-003a5K-2X;
	Wed, 03 Jul 2024 15:14:35 -0600
Subject: Re: [PATCH 6.9 000/222] 6.9.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240702170243.963426416@linuxfoundation.org>
In-Reply-To: <20240702170243.963426416@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <e0dbcee2-747b-7e83-f552-a2e8b07bcacc@w6rz.net>
Date: Wed, 3 Jul 2024 14:14:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
X-Exim-ID: 1sP7JD-003a5K-2X
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:46966
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfE5ME0vn3GYdy4y4YYxscL2ImmUbjRV8aP7J94w6WyyB3DQ02F8bX6CDxitznv4QtvJ98TAWh+GYVSLT3vdLpAWHFPVS4riCOnUh5Uz663WhdXcmjWnI
 RQdQ3spEC4RYnD6c3/TMi03pFnBAu448h10nA/6M0qa4F2Nwl4mIUzyqlPP6mWr8fL14KuSoS8tzmg==

On 7/2/24 10:00 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.8 release.
> There are 222 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Jul 2024 17:01:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


