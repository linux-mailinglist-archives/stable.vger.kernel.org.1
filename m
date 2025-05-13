Return-Path: <stable+bounces-144152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C494AB5092
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 11:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D840862470
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 09:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFCD23E344;
	Tue, 13 May 2025 09:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="yEgiPzt7"
X-Original-To: stable@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDABA1E9B20
	for <stable@vger.kernel.org>; Tue, 13 May 2025 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130256; cv=none; b=HZle1IgMReGXaIvyYObkp3IKBUV9UWwFZqDDYcNJ58FUyP8FT26UcK0a/mc+2cpMi1Kfw8am8o5xBs7Cb2ctd5d1Fxj61rNuWAlJw0OBvA+E0M+aG5mWuuxvG30ebsMi/+FrDZLv0B/MHgPwEWzjpmqhdnvnKMRWToZyXJwGByA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130256; c=relaxed/simple;
	bh=JdAZyvEfFv+b3xCHhPfd7LcKXAFu9fTO6LCfNdrPf1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MgxNyodyyI3dryDZ//BcLt1TK9Adk1FdQEQ3SaP/VkIIUaCzsN1uIFW6gW5cvozbvYvHN7VxBl4gtWKOKVcYq9yo0AveBX06q1wysMGF15p71+QkVDxuIEsBOWI6emfycuR4jNFg//icYpAO1louFXJT+X5TV5eZMWXTl5XwWko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=yEgiPzt7; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id EiIKuF6enVkcREmOCuTwKD; Tue, 13 May 2025 09:57:32 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id EmOCuEzZojrgqEmOCu2h0D; Tue, 13 May 2025 09:57:32 +0000
X-Authority-Analysis: v=2.4 cv=PK7E+uqC c=1 sm=1 tr=0 ts=6823178c
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3LSEtfVInsQZ+YidTGzY/S0vZoyti6cDV9ARJoZIG8w=; b=yEgiPzt7AiD03xiK+RpDOVWQ1c
	821DDlHxcvGfMLdPsb79yLyZFlZ0LO2pMT7+X7sJ1T4/kuvJ95gdu7eEYrEPMXTLaxvItWaCNiPd5
	GRZehdXG1PYNg9gNxz3+PWp9/5UiYhE8Pes+9sN9vUmEuLIMQuIwqTTNtJkPxD9Hp7hRznG6uWWE+
	VO+b5qOA4gG+c66hc0sWMcrD8hV1xxcjmZGqUuJdWrF+3xXDcq750wJ/n1WWCrXnF2C2ms5cfwceU
	/vSIMCh/evktmyQXJM+waxTGhLA7HUV84+eKyaF++LyfFchTLnTnTJtHF2q1AMFAHfyY+xF1wvW9Y
	zywgKafw==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:40850 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uEmOB-00000003MnA-0Cyf;
	Tue, 13 May 2025 03:57:31 -0600
Message-ID: <5e868efd-e6bc-4577-b6c8-9bce69027a97@w6rz.net>
Date: Tue, 13 May 2025 02:57:28 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/113] 6.6.91-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250512172027.691520737@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250512172027.691520737@linuxfoundation.org>
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
X-Exim-ID: 1uEmOB-00000003MnA-0Cyf
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:40850
X-Source-Auth: re@w6rz.net
X-Email-Count: 56
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfD+sBLQN+sQLD8JtR4ZOWMeLdeSxTPJ+/bKHAa5kszoT0hpbcfAq3DZs9VnA/ym3oMUIVw8JjhQXR2ld5RH6/WtlMpq77hSTq2jonRH9BNFTrVxYTadI
 fbDPAh6F6iPupTJquEHjmD5RwiloDAiLeaHBv22rAGHjhFCB3A7Jua2qDK5alx7awYn9GxC2mbA57A==

On 5/12/25 10:44, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.91 release.
> There are 113 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 14 May 2025 17:19:58 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.91-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


