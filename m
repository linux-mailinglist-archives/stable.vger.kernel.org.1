Return-Path: <stable+bounces-106063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3CE9FBC20
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 11:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08886168D17
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 10:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A091B2180;
	Tue, 24 Dec 2024 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="o3mcNWAc"
X-Original-To: stable@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C05518FDD8
	for <stable@vger.kernel.org>; Tue, 24 Dec 2024 10:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735035382; cv=none; b=h2ohngPCOd4gpxmIbhqwxOyx+b2UKpFveedkenNjWegsvJrCDL9EM+jlvC6L8nZKPmb53eGXip+ufMb4GG91/aMNwVh1Kz5XCT2JLknlj+0zW/8+ctk2RBVZsX9gqhXptxYjIbCa5dIPgV1zr6/Cr/PPewGlZeOMjqlRmJMbQ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735035382; c=relaxed/simple;
	bh=1uASdSnQlPEPsjzcpi1ZN+8O6LUCqdymG8K2zGwCuA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HjhNWny2TvgTorhcrwrWjgeir1KEJ6PC//Vhgy861WazmlC867kK02PbJr50oC0vfILpM1/36MpkLJLIWB+X6iluCTRe3MlqMBWzdpHOvisutLwmneNcp3sSe3lPuT1gb0/5jnBi2uxqcgnBMM59nyZmio6kuff2RwnbJ4++Q98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=o3mcNWAc; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id PyjEtUJ6BqvuoQ1xVtihXu; Tue, 24 Dec 2024 10:16:13 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id Q1xUtTxj6EfeeQ1xUtkce2; Tue, 24 Dec 2024 10:16:13 +0000
X-Authority-Analysis: v=2.4 cv=VsElAf2n c=1 sm=1 tr=0 ts=676a89ed
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9xsrzLQQd9IFNql683FgryzmtC9f7xBWUezFFUfyfqo=; b=o3mcNWAcuLBynXWReSm//d6+uK
	E2br2cF9w6ftfjnnbBseIz5IUoM283jPhg9IpPlYFW9BgQsD9TX/RrF0f1E81wurDvcf6ijl/UQGY
	0MBfgLxtLp+2ArWANn1XZZU8m/HEFAQKtz6JJPllYXkxx5kx7w7O7n7nsxqJwYx5dEZjVOyjF2POm
	KzYYOb23UKRWCn80qkajirxJdWjpHUnaaJZXkxWKwoMqCagndk+As7SVEVTLOKRW865QQ1GwS5oHR
	UvUfLrsB5D35h+xjZduhr822r4czI0bUHRRexdQ2bHt8+F6nE7JgoNLMrWei6ta0p70oai+XVal4t
	tpjeiy1Q==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:53926 helo=[10.0.1.115])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tQ1xT-002Psk-23;
	Tue, 24 Dec 2024 03:16:11 -0700
Message-ID: <2eaf702f-5080-4c42-8a23-41359b90add7@w6rz.net>
Date: Tue, 24 Dec 2024 02:16:09 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/160] 6.12.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241223155408.598780301@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20241223155408.598780301@linuxfoundation.org>
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
X-Exim-ID: 1tQ1xT-002Psk-23
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.115]) [73.223.253.157]:53926
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKP3Tft1DKWbwr7HXqljX9VgL4qNx3cP9dWO7J1l9d7aDpTDl479MtLyr+Pd6tDeMqgp0A1x9UJAT2/kQr19V/u1Lvi4N7CpQ8Ea7IZUyPNZrTC5x5/y
 fyuZnZJL7vvV/l7R/5VRb5Qtjw8neEGEIQFR3ejuiQ/Et1c3E4mDrTFuVZsJ3Dr9yCHLf0KEzcXWHw==

On 12/23/24 07:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.7 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 27 Dec 2024 15:53:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


