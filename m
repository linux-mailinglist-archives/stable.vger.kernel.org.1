Return-Path: <stable+bounces-71438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A889962FE7
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 20:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADE821C24A69
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 18:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A1C1ABEA0;
	Wed, 28 Aug 2024 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="b1o9T3fT"
X-Original-To: stable@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5BE1553A2
	for <stable@vger.kernel.org>; Wed, 28 Aug 2024 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869498; cv=none; b=AoNgfX/RnMeYTzNe2BaCeZzCF3xgRZLJw+cT1Fag9/gMBzluiSKNWZDmltX06CQaex8kSU6p4YDdpePYgxH/BqJPINd76JN/0ZerSi4bLwDml9ox2clW1x3vvbx98hvjuawb5SENLKIvaLhEOdF6R5Jhs1LBSG+9VvPVtf+HsKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869498; c=relaxed/simple;
	bh=JZQyHkKGKaDjs+iuMPlUS8vcpRWvOGmT1HsxA5FrRJM=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=HDZQggyqLEXw7iMTn60Yv2pe0FNNoLArfM+C2+Z0NT9Vi2dLUCoBqUhQ4v9MRZjVNWluo/5UT84o6p5VfNHHaysOadNb7krPKx1EU4j1IgbVI4EjpOOkamGr2sI7wETqAm3lp/4JkenZAoPZTFgmayhTwNPWM0PqH4Ye0cOmwdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=b1o9T3fT; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id jC88sft2jnNFGjNListrz0; Wed, 28 Aug 2024 18:24:55 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id jNLhsBYz2eN39jNLhsfhkk; Wed, 28 Aug 2024 18:24:54 +0000
X-Authority-Analysis: v=2.4 cv=JrX3rt4C c=1 sm=1 tr=0 ts=66cf6b76
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=pvbMRhK_gA1k-AccEgoA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0Mz/fo9T66swlgzJnoztxETkSOMafekBx6OnoI658Zw=; b=b1o9T3fTXG8GATLWPjVgqj8cfK
	/0zH1r/QQmn/tctpJmAYH1Epy56I6I6M4TFqJB8fgaspiKaisA0ZhdKCwFP0cX4Ipl3LI8BJ3rfGE
	OzidpG5wGFC1U1PUgH4QLp9s+fKRjazTYwDzgZXMsR41aGFSy+uZONp+8xWaei4RQnkl0xCnsOsCq
	ctaXNqLSkVOAttb7aFaUDJ+orihO3oQzfPGnlhiQQfJWUPFRFjRSCY8PV+/ZaLnFeufT7uKeGYLyh
	bYfrXwZAzgQ68b53v0QDvGbby4IUGJX36VrWhfzzxolc3Xn2z3bOFMTV4FGP0cmP3WnJoRa0h6Qrz
	l/8mge/A==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:37106 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sjNLb-001Lij-04;
	Wed, 28 Aug 2024 12:24:47 -0600
Subject: Re: [PATCH 6.1 000/321] 6.1.107-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240827143838.192435816@linuxfoundation.org>
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <4b745682-852e-bbbd-007a-04fd08ece60d@w6rz.net>
Date: Wed, 28 Aug 2024 11:24:41 -0700
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
X-Exim-ID: 1sjNLb-001Lij-04
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:37106
X-Source-Auth: re@w6rz.net
X-Email-Count: 40
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOwpTOM3Xl4B+QiuCi7Oc2ei3wzoa5HIO6pjbPD95ixhWsyjY4puqbHolmx3jEYkbQA9kMTwgTfXSl+7YgWE2CTgqnuZZHET0hM9pGE3LfR5iqR5h0eg
 GZDuf5NGKgQDax+v124sKaDaex7ZFMuueVPoX+e6Z3bFubhZBuy6H6zQeja31xHcvda6umGfxgf+yg==

On 8/27/24 7:35 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.107 release.
> There are 321 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 Aug 2024 14:37:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.107-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


