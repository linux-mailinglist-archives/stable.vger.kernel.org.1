Return-Path: <stable+bounces-169461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF620B2559E
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 23:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7FBF3B31AE
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 21:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51232BF3F3;
	Wed, 13 Aug 2025 21:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Y9IKNL0t"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A73128B3F8
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 21:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120829; cv=none; b=dQJSRqXa2NfHrBNd3ym9FwHataUTq5vkQwN8pobaVAJLlPc7MFQfVIaygJHZFIn3BEd6rmg9ZGZMFsPaVHaBA6XIGE/LTmHqHNk3/teYtnk4nNfH0x4xvX4B8KtXOwf836hKOaKSB/k0qnN/JcW4v1IT3HVDmkD4kkAlVFSmTk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120829; c=relaxed/simple;
	bh=Mg63cs772RqnhIq2vwerB4/Y91td59Qhe5bhLUdPH7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aqt8dh3F6BVsV02nNdol9ek+c2sNkdylQoaIHudEu4ChHjUZjt8Ro3gCmJ59UTu2IUg4RHGkwG/JjDitErEy53kgMrQ8euy2EZFK5CQDaA1kKVUn92qsA8oxS4B57JkWfP0YNvaCzRC/ERxuGwTFpYFnxRsnCI0psU0sSjU8Ixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Y9IKNL0t; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id mB6RukBTP1jt6mJ6QunQNl; Wed, 13 Aug 2025 21:33:46 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id mJ6Pu3KcCCNkwmJ6QuDtTu; Wed, 13 Aug 2025 21:33:46 +0000
X-Authority-Analysis: v=2.4 cv=QO1oRhLL c=1 sm=1 tr=0 ts=689d04ba
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=KUZh0rxr2sLgifp9wg4A:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Z9EKTWrWjaLGTQENGfIM0r1lMIFLbySXXr287IS0AEA=; b=Y9IKNL0tPKGvOq+XZEVSc3/Bto
	kI+ISTnBVHTy1+OtofddX1jWbpk0IYgyQiPcEqbLjVWgwVvu+yRNRs6uwlyV6Q+t8e7LvOfAnuYD0
	9VCnioEMkeDjElFghwwDjaPYfkG0vT+7bFt87kOWVHRZqY7syGydeR8uPoc3YMqgu6FRecTZrWM+4
	SROlP53s8OUmPMrgg/7TdGoxazbqdeNIlqQktgJbv+/0uM2U3u6bROp1QlYP7YpHZjjTCzxgh2iwZ
	jj71x8xJAQclh3qqQRN0+W7rpe7aqUY8TrB3rvql195wrBKRrOH+V7+jWOH3t/JG/9v/+SmraGCW/
	CrmnUZHw==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:50098 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1umJ6O-00000001u49-32ql;
	Wed, 13 Aug 2025 15:33:44 -0600
Message-ID: <4a3e2afd-41da-4dca-ad13-3f910467e072@w6rz.net>
Date: Wed, 13 Aug 2025 14:33:41 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 000/480] 6.15.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250812174357.281828096@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.223.253.157
X-Source-L: No
X-Exim-ID: 1umJ6O-00000001u49-32ql
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:50098
X-Source-Auth: re@w6rz.net
X-Email-Count: 39
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOxwQAbqoTNGJDoxNj9jXzC4h+/GJwxl+zAyM7FLG8ys1LACQ+mwI+WYNZpR7/PrqpGCbnF+HW2TrpR4znvgkH2ZmJAhN1HpqFubD8pVe6awZoMpbnjz
 zs+Yr58+E6Pv5WHXPDLAXzFuI9HpZhk6c0r+MCUoARAROONaN75PMqqXZCyZpUuaDzjr+pB+yGFgHQ==

On 8/12/25 10:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.10 release.
> There are 480 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Aug 2025 17:42:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


