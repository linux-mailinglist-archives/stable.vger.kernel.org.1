Return-Path: <stable+bounces-128360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DA1A7C763
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 04:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36AA318987EC
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 02:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8131E381AF;
	Sat,  5 Apr 2025 02:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="ygtPOiZy"
X-Original-To: stable@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0770366
	for <stable@vger.kernel.org>; Sat,  5 Apr 2025 02:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743820020; cv=none; b=anx5zsnsgGZoN7Shs+NWZ/Yv+bW4eB9Kqfk0avZZkxslDOu9j1Hzlde2pZiLRc4pSWOj1BiDdsg/Yr1daYvw0RPICs+WqOvS1iJTwnIc4yM4iLXPgPfPbyZzonps8sKm9FfQnF/1ugqFvoJxyUYOJHeQWtXTT91D+HjeVPR8QXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743820020; c=relaxed/simple;
	bh=WxH0jTt6iSqU3+h6wFGib2vUiMdKvXTc/JsHrMUbre8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTAlbGb2gm8UIXDtaSNvCf2dvaBK/inQ7hOjbxlabqBsSVfrAVyTcUuzRDcaiJxsb6gDQ07LEhdsG8ZDO2xI+jXvmF8d1jqSbTN0SAnW7oyLLGV5jECkMeXklvrpccJGMpg2EhHSI7JOwIaP5rVKR3HOSd3iZOuAtbgGTxQaAOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=ygtPOiZy; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id 0XhcuxEzUMETl0tFIu98kK; Sat, 05 Apr 2025 02:26:56 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 0tFHuo3YhYhzZ0tFIuTSE7; Sat, 05 Apr 2025 02:26:56 +0000
X-Authority-Analysis: v=2.4 cv=fK8/34ae c=1 sm=1 tr=0 ts=67f094f0
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=CTIpb7JmY0c5bVNJeN8A:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fO12TMZjn73ITDDp+NrD9+Y8VZ+9xez+Umj23sxOTbU=; b=ygtPOiZyUh3I902u8YjZgBEfKH
	G/RifDwbLMxQG32Ebszi95/kYysFUcumUZF6bxd8L2lZK/7B6YMay5dLajIFP1Aw5nrj3IvpxpCoH
	cwrSQsdQh49C6PwFlB3KGKmoGK6taG992JKPrZ8XLXuk65zFqALmaFCLzgORDBfUSRLaTUKqNTEYu
	k2TX01BIcBVmX1Jb7dbmmyLkCvowYF4aMqjmKlCCnOYRdpPUn9flqYWjZhO36T5Z0Lisb4R0O8Gz8
	PSepdckeFCSkjp8cjqw7TtUJ9TbU6oVJMLphO2eGr7zeib0sTK4VVYoYW6sRSzlYtojtW6dHh9tE7
	puN49lDA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:55270 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1u0tFF-00000001bb1-33Qt;
	Fri, 04 Apr 2025 20:26:53 -0600
Message-ID: <4d95e502-3dc1-40bc-b7e7-2aa8a26874e6@w6rz.net>
Date: Fri, 4 Apr 2025 19:26:50 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/26] 6.6.86-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250403151622.415201055@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250403151622.415201055@linuxfoundation.org>
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
X-Exim-ID: 1u0tFF-00000001bb1-33Qt
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:55270
X-Source-Auth: re@w6rz.net
X-Email-Count: 75
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHQ8gKGx3tiwLlNxTZE3GGtzn+ktWwDy2AaJw6D/gEXjTZQQuR3Lgk8NTG9cD97T/PXcrWFrydlU6Ya0J5962IrlZhK0iz4Nwa+/2Pyyrr4L9UKmoApM
 oYtPlnAbjg/EUUYjuM1WSNyjWTerPzK++xtF1R4DkSidnVPwpSb3nODQhdwGF/oDGdtA8NIWGqx1nA==

On 4/3/25 08:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.86 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 05 Apr 2025 15:16:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.86-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


