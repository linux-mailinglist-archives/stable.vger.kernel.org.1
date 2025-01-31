Return-Path: <stable+bounces-111818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A003A23EAA
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 14:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8821E7A3A95
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 13:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F901C5F29;
	Fri, 31 Jan 2025 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="nHxwJKs5"
X-Original-To: stable@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281671C54BE
	for <stable@vger.kernel.org>; Fri, 31 Jan 2025 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738331531; cv=none; b=fgJwJK/7nwQM7F47UxcQYNbP9yelDW6RxVgQuMt66KiRV3RJuZwJW62S3NWUhQRnCgoyDCI1cgAPsHCs/aUoNHacY7bxOVHLywoqZ5doUbib3QNFEMq5Ur4BKnE4haHxVqnblVY9oGULgDnGrmAR1Q7840/pAMvcSwRm5tzcMMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738331531; c=relaxed/simple;
	bh=3yG6vF3BhAGzPGU/excw3Et8DTba1mIHbAF880jDHtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pbeOZTCHil7Fb1sSMd6tPO59A5SPpX8QEsy7r9nIc1IvpxWXaWTQBpYTXfrObcB+/qS3LS2iSGkYAOdaVAekIJExwyzmtzi2sDVptkpFyigtrgGZYPmR0k9vQ9k2hh7NvxPe8kZHQBqy0RHS82/ZtMLHMnwIsR4idaVjCODIZwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=nHxwJKs5; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id df49tiwXy1T3hdrRIte80Y; Fri, 31 Jan 2025 13:52:08 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id drRHtsqGvCvIedrRHtjzCR; Fri, 31 Jan 2025 13:52:07 +0000
X-Authority-Analysis: v=2.4 cv=fK8/34ae c=1 sm=1 tr=0 ts=679cd587
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=gyRQ9LoAd9Ap2MThexAA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=u4ji1XhLeH5/mG0e96444tmc79AQZ0/wdJHGHUCYjDo=; b=nHxwJKs56LWuSMbXbSMLyhWpBH
	+2OzxmfgQKZwpmFzk9939mYNmn7scqc9FY7sBL77gIKxq2Cs2+G30x2Y5CMD4fPtKEML65hh8xwpU
	LwSncBf7SZfAIPMqr0Hb0/9BokkQaX5CIhhEw7glSLnO9wYtFN9PWnCFGnt7XBQO5yyJU9IRBwKSP
	SqTrAxzW2h+ruUb3t3MMRkyuCudBosIhq/7KW87mbOJfdLG72mWG0a6Zm0TmdwmIjxyVy/K5xPqP+
	Kv2Thg1LgqOPFnl28tRPZ0Pr9HTHBf8irigOfTPBo7F5ODlnl/AWBfV6AqfIJpPXaEvCPxu8lZ6ry
	RdqSf6+g==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:45612 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tdrRG-0014XI-0z;
	Fri, 31 Jan 2025 06:52:06 -0700
Message-ID: <d47bf7ff-e870-4e12-b6c4-c47817e5da5c@w6rz.net>
Date: Fri, 31 Jan 2025 05:52:04 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/43] 6.6.75-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250130133458.903274626@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250130133458.903274626@linuxfoundation.org>
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
X-Exim-ID: 1tdrRG-0014XI-0z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:45612
X-Source-Auth: re@w6rz.net
X-Email-Count: 56
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOeKSUvdkL6ovD18biYk2M7G3xYOIQd6NI/pYGjTYLlT1yeALJeZgxCpdw3To+dqOTjk5ajkpl3sKGHPcjp7Ac0a48pXms3Qh/tNj6wrnaRwI54NRWu1
 dnJihdKnaZERAnGRU8BPAXE/DksH2/zs6ViRhpdntIG9YkQXbjPSsR3dqfDUVYj9pwOcW4a3t18X1g==

On 1/30/25 05:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.75 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 01 Feb 2025 13:34:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.75-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


