Return-Path: <stable+bounces-106624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F619FF21B
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 23:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE9E3A2851
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 22:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D691B0421;
	Tue, 31 Dec 2024 22:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="ql4830gl"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D8618C31
	for <stable@vger.kernel.org>; Tue, 31 Dec 2024 22:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735685290; cv=none; b=HkFwTgUfIWCYjr7aL7wAOMJ5eOcGuk1tYkOz2ZQCDoZnsSlrNhTKBSoi2imRgFSflnQBaDRuGmDVI2UlFmDpr0Rlu4DAaY5vtLc8OKijjQIiyDRt5PB1yEZnsePzhDJkxexo9hgubC5qkennJ2ton/D1fF2l2NEoqFZzBYdHYSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735685290; c=relaxed/simple;
	bh=ldD3Ex/nP54DPw8XWFFM1nM4Potu73EVEnZpYcTzJuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZizWDdV+allzlCnFdY0+X7Rh1aIp+92KPgMzHYmzBkGgcdoKbNHOTIwGrEa77bHQPDcUyv59EyT+rD7GSUsdVhKaro2V2z8CPzT1zl/3ifzMDuZSztlU9YpVR1++s9VirBxpib+3HF3EZBJYaqtDWhNivkYP3IjfPW8fP9TCkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=ql4830gl; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id SgmJtp9PvxoE1Sl1ut8jM6; Tue, 31 Dec 2024 22:48:02 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id Sl1ttriKhmNYjSl1ttK52P; Tue, 31 Dec 2024 22:48:01 +0000
X-Authority-Analysis: v=2.4 cv=fb9myFQF c=1 sm=1 tr=0 ts=677474a1
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=Gra185UJkbK6XodgLF8A:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/iYSCOeQVm4e3J+0YuhiG+9mzCyeLFw7mN7X6ytqPs4=; b=ql4830glKa178NZ5tLwtCopLtL
	a2cBtCEUF4FnIAi/L9v43kuCUTzmpHvJiMj2mZSGuAO2Ur4eYy2w1khICYhzg3cWtpCfi0xZbTFtC
	hq0pCchESwk7ECoBXz/bQIOY3ztJAeW76wb/P2UTuAjz5sicMovFuRRxrmDclZmPFRN2mmZxxrwp+
	JQinBuudHgH1F2TebmDCRoWowD7w4s5dCcKWzzBstsBKueqnJDu8gqwt27z1zIO6dlsrkzvdHr+tT
	rtQujQe4hMTHcpLwVbtO7+omqC8+L96Zp/AP/3dStN+zaverxC0xta8Zp5rdQIzwlqzNSSDRNX4OV
	mmc5NrSw==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:45478 helo=[10.0.1.115])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tSl1s-002hPo-0o;
	Tue, 31 Dec 2024 15:48:00 -0700
Message-ID: <9cfa5878-5a23-417d-b24e-49547e53311f@w6rz.net>
Date: Tue, 31 Dec 2024 14:47:57 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/114] 6.12.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241230154218.044787220@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20241230154218.044787220@linuxfoundation.org>
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
X-Exim-ID: 1tSl1s-002hPo-0o
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.115]) [73.223.253.157]:45478
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfA51G9Onw+XxGDHWsXLMgc2WFoH3w0ah2Khk2mSWGSLLRFEQL8lVuP/ZTCyLwz8YgbqiT4Ye0zz4L7fNK6AFo92e5s/6DJxyQpfah7yR8l3tz6m6Aa37
 K3aCR3AnD8gaS2wZZOe93kYFWloS/Ggy6N0pT3pt/l6AV1yvxcDUhI904IZZjpvCxXwDsK3GlazTeQ==

On 12/30/24 07:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.8 release.
> There are 114 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 01 Jan 2025 15:41:48 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


