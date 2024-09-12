Return-Path: <stable+bounces-75919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE0A975DDE
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 02:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 719FD285511
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 00:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C6B80B;
	Thu, 12 Sep 2024 00:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="UOGZIMEp"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDBB383
	for <stable@vger.kernel.org>; Thu, 12 Sep 2024 00:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726099990; cv=none; b=TJ62ngjhbwwcCaxprL1s3FqVf3dPsheSp+pTtZttfjTI5TiaYV9CBruAvKNQl+1Xs2Tc/AQYoMmYhvn5BLAU2lfmuze+RxI9BhedEkcr1hDakZVXDC0tNDBoRGl2y/j9pVxEU0LtV2JnoW/ZiidNKkWcpzuqn+yQZzJyQskBevE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726099990; c=relaxed/simple;
	bh=0jN5Jl4+HEZ5nZ+VPVRTwXVfctircjGNX3+eQKScwCk=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=OCpCsShL7Q0FocdnhQMuo5rbOoWLqQ7PqqNIo/d2LwEeyze9AtQmvqO+zfnzquTtjbPINCZsU7calUQl23LYoMjhz5I9UaiL3iqa7x7Sh3rAcQp+hK+kvPTM/TQ/Hy9kel4DsL4mv1eGu/ZESNZ6rGhA+6KJGqvYpAcngSJpkG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=UOGZIMEp; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id oUdCs9Qb1umtXoXSIsOUos; Thu, 12 Sep 2024 00:13:02 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id oXSHsxG6OkvhOoXSHsfXTV; Thu, 12 Sep 2024 00:13:01 +0000
X-Authority-Analysis: v=2.4 cv=ILYECBvG c=1 sm=1 tr=0 ts=66e2320d
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=BU-0VEHJLDsOG5B_DZEA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JPLc/+XFHTUsd4uq9z5D52CThg3h/IkwE9EbBHWYsaY=; b=UOGZIMEpdq226U9lvxOVjcQpR2
	MEVSmFJ6cTCo7R/8yB4sDgqLoCoN/v+NPMprOTpd0TVhQBo+beEP1MOjpix+tk0ZVeUquh9usi5D6
	TgfFCg/nweeeqHOUM48OdKYvYfDl710zYVZsyUH6kbOdpwi12BeAr6OuNddPdhfVed7J3EwTVgSdA
	84+1+JCVgWoEqgglo1gxqLTrB+T3fO0Y3mutU1dy+4EXSfo8U8DzEsM3HHAi98vsFppN7GAveZ5at
	R4cCJMb9VRbWm6eYkPSkCIyUrcaxnQ3RxO2erYCd4Q1iP7uknfByntOLhFaVlwo/N/fKGbl4H+e/Y
	ukMYvKtA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:39864 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1soXSE-002xLQ-2D;
	Wed, 11 Sep 2024 18:12:58 -0600
Subject: Re: [PATCH 6.10 000/375] 6.10.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240910092622.245959861@linuxfoundation.org>
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <7b91734a-8a33-b5d0-2a32-3bca06f1c1bd@w6rz.net>
Date: Wed, 11 Sep 2024 17:12:56 -0700
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
X-Exim-ID: 1soXSE-002xLQ-2D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:39864
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfObzVkO5FOuXin+05GI70mIFqWv39l7MTkk2vhTL4pkZyk0iUdYJ6lHZe3zneyCupnfgTX+g8umYD/oQbiBPkrP4u8F9IyGKuM9K287Op3sYI0w61jom
 F2V5Il80QdTXq5Asrt987XDhq2xq23VDNhFOUTgrcr22xCNzOu7jCOZDmj3yiJuB1UZoYmD5WsZ70w==

On 9/10/24 2:26 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.10 release.
> There are 375 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 12 Sep 2024 09:25:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


