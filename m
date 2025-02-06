Return-Path: <stable+bounces-114053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C95BA2A4DA
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 10:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691403A47FD
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 09:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B4B225793;
	Thu,  6 Feb 2025 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="wwTXI15w"
X-Original-To: stable@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C0D226160
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 09:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834971; cv=none; b=HEAAAgP2PMtpd5HPiaNOLaKGfNkWRKgS0AlU9tAY5Nz2xxW8kYXpAUEKjfS6WFLRtIk7xsYgM1c/tZPtaVmPPKVev/XCZ1ZXeBdhijoGbvzGbnA93rT24ucryYeFA6vtQSkAyNpRpQ/iUASJgysMBgLhQjc7bCyh0WSvJeZPAPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834971; c=relaxed/simple;
	bh=Wb2o0iIk7n5coEs9u6nS5KfJtSXUqf9HGkVWV97rNYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FRlOwIY2F9js99Q1GKIPN84c1ih6dAkUtGJBkmIVPbFSsNquy6BFkvjRg6PlPP+nOjptkZnHA4cWTWyljFtK+IfD+SB1TABSxgmGqmD34OJXWlYXt0la5YiK2UyDhXJJDIyaTrnaWUZ/pG9R3N5Yb+OXS3vRsTmXk9Z0pncE7WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=wwTXI15w; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTPS
	id fjqct0U3WMETlfyPItVykU; Thu, 06 Feb 2025 09:42:48 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id fyPHt6IoQ5pd3fyPHtLpXH; Thu, 06 Feb 2025 09:42:48 +0000
X-Authority-Analysis: v=2.4 cv=Ab23HWXG c=1 sm=1 tr=0 ts=67a48418
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vJMK8iCg2oMBunpgPvbScNcRC3FGUvorAxkIzeCDGE4=; b=wwTXI15w1PeBiN9wDaU7rTukFA
	u7PSInqABduKzGmG5cLgkBLnYGoDFEV7G5ObF1jo3PRJBbZ6WDeccYH0U34trJorrJPIS07WJOD86
	B2Cvlh8/7zSi3rwTaCQHNAsxF9RtaYNt1l6ATPqBZCZRD6Hmvy2lw8Wlmu1XrKghZBTKQcnh4mwDK
	CsdO8AfLOR2VyOTYvM3yykM3h7BS4dJWChYcGw/nINWJd4cHwNk55TQQlmxrMKpstEPFjWbBueR73
	gS1qNnVD9Wu5oE/C/Teq/hJ5XHluvqB0J40afRWhJmj5ZH9SCD3Z4z6TYVNXLL0hSP+kwx15xvCfB
	b9L6RMLQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:33754 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tfyPG-001mRg-1h;
	Thu, 06 Feb 2025 02:42:46 -0700
Message-ID: <75721b89-078b-436b-9753-981d49eb3534@w6rz.net>
Date: Thu, 6 Feb 2025 01:42:44 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/590] 6.12.13-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250205134455.220373560@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
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
X-Exim-ID: 1tfyPG-001mRg-1h
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:33754
X-Source-Auth: re@w6rz.net
X-Email-Count: 37
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJC4OHpadcvow7yfIuwk5BhP6JCJVSaCNKLJqV4Qe5lkfcqQajzHynjLZtT4WOFs5/eSQbezO5e+XzyipPIZytBlc/fNTp1Mqy8KtptOvV4EiV7itPin
 /gcVRlSIDRgT8JKsQraYmdCzVOvyFQr1xC0lKjFMtOoul33DvmRqO7uP2CO/dWhHCyJU7riB8Sauxw==

On 2/5/25 05:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.13 release.
> There are 590 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 07 Feb 2025 13:43:01 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


