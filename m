Return-Path: <stable+bounces-76625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C9597B5D4
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 00:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6685C1C23671
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 22:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCAB178363;
	Tue, 17 Sep 2024 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="0gdo2dg0"
X-Original-To: stable@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026E015B0E4
	for <stable@vger.kernel.org>; Tue, 17 Sep 2024 22:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726612568; cv=none; b=a9AR6xUjk0ob/zsZWB3vDIZpOaiIMhLIW3o6KQvywzv8/u7WWb9FtUjUnAxf4q09nj70ABR9FZvImczr/q3ffglzcNm1fSrUX+AB2/ULPpAvyZHuugB9aM0g3nRgiOQWgwt2bL1GTalfxd5hCpoBuVkNrRebJ1ot3sviHVbFD3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726612568; c=relaxed/simple;
	bh=2bDQP7S//fogLrmV+eMq733HDn4b0PxImDdGI3TPC3U=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=ieHEQetYGFlnvJ7MFuilbEEdlyMzDmItsSHX0XMyiaaa/L6C5AYAhaeZBJKsiQBu/b76yrPcv+0e0LGDh9vZqppbZkEAvKPM4goGRn56W1WMUdKuErSmXxBBixsZYW1U8Erc6G7R5wD8M5N4flLNb2qYnHu8tLhTHHFC6E8ZYZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=0gdo2dg0; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id qgSrs0T4wVpzpqgnesbkEj; Tue, 17 Sep 2024 22:35:58 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id qgndsnbKwX56wqgnes7gDT; Tue, 17 Sep 2024 22:35:58 +0000
X-Authority-Analysis: v=2.4 cv=MY6nuI/f c=1 sm=1 tr=0 ts=66ea044e
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ux/Aggi7SgwHm7HJVvjhs5iqhx3neIkukFJ6DnBN0DM=; b=0gdo2dg0TlC/axVYWyxNSiObRt
	S8zHv5kaasIpzW6L2isJDxQEE80ScM6ZtoxIIiUbkpekTPkXbWd8GE04x2rNHrjBrTkOQTdI53vqu
	mPBHjKEslQV6Zn5iNU5GmV5L1o6z0QSEJlZBFC66P7Wx7ww8L6f0fG+U9VEUEKfaqDDjReRItfVgQ
	dA7fz+PUbVJ4VOtZDvlFAe0smqja2KrX1FXY6EmUFuXIG0KxPIyCukQBTWpl8Y8QG4q7mFdGmhjHo
	JjdRpF/UEnvEeWgaebfKHPwx9390dkvo4ugR1kAP5deAjWFfNpZVEdAqJc6WTKcZ/rl9CE0GzbnJ1
	aC9BbrYQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:41180 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sqgnb-001YYk-2T;
	Tue, 17 Sep 2024 16:35:55 -0600
Subject: Re: [PATCH 6.6 00/91] 6.6.52-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240916114224.509743970@linuxfoundation.org>
In-Reply-To: <20240916114224.509743970@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <f2f8f307-b883-d2d3-1be2-19d5e08155e9@w6rz.net>
Date: Tue, 17 Sep 2024 15:35:53 -0700
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
X-Exim-ID: 1sqgnb-001YYk-2T
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:41180
X-Source-Auth: re@w6rz.net
X-Email-Count: 21
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPeSvRAphV14RZfhdGpMBFmH93S1RZWzrSrDuG+DzGQYrZpBne73O1Xb7RWaumoYZGIEIW8rRNLUncbnAPASlqFi/TNJqCT6j8Do8FdtZHyTdBlswFwC
 DmPOVTi12x/r3854vAbOD/JnrL2lue7x5qrqnBAddoeLfnAKjSOz10EInoaUsc5MgnI3hJBv0Oxrgg==

On 9/16/24 4:43 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.52 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 18 Sep 2024 11:42:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.52-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


