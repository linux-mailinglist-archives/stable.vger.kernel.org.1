Return-Path: <stable+bounces-183387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F024CBB9211
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 23:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01383B1AE9
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 21:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A324286402;
	Sat,  4 Oct 2025 21:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="0DfeYr56"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DEC18A6A5
	for <stable@vger.kernel.org>; Sat,  4 Oct 2025 21:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759612848; cv=none; b=uZ4i2Ct9hjYbB6d8CI+rq3MVruRp9pWqsL3yadrS40DJ9yWMil3iGKFMd3VhCRymufKBGVSodHx8oWN0PPpQ0p3a+VZiq362zWXlTLIjNBdxdZFP8gV9c+6qlSEzsahZ7ehP68BmKcRUcjcp0SN8ibXcceuFMviLYHS4vOwX7tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759612848; c=relaxed/simple;
	bh=COLxfDyHpjGR3dBeC7gJMCb+6mGu+U7P/OGkDjUNmME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VMAHrQnB6Tfy6QesH89W9cHgwcc9cxU/sj8uxdku68VnplL6m+WlhYlotXzf31UWaVcfgFAWOO3mST6cmmyq8pDEEy9XNtu9LSEG1fsBQxlVnlmiGLt4hx2i2nUObt5r881MAcuteD7QyQ2SsNp+qVkecKwpUPpcov1HNAITDt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=0DfeYr56; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id 58KYvxRbBeNqi59gFveilG; Sat, 04 Oct 2025 21:20:39 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 59gFv5cc0p0Hq59gFvXFTD; Sat, 04 Oct 2025 21:20:39 +0000
X-Authority-Analysis: v=2.4 cv=H/nbw/Yi c=1 sm=1 tr=0 ts=68e18fa7
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fDHG7mFvgcZnLnLDiW3pDEXNbsGY4vBmEK3sYL6MFY4=; b=0DfeYr56wPZNna9g7pNnNSn1/J
	M1LoXG/8x4jiF134Bbm5X3mrQoBeAEWzzl7vS9QzE8RmtgoremMyDxd3tZhuAGEnTnYZM3EqrPdmJ
	iz5imjhTf6SxYSlRUvUkIE+I/da+qBOchBqht5LljSQm31vqlRV2UJbY22qofdkCbH3+DDVZh6cmm
	yMIxM7ZACb+yb1dx9NXi4dWNfX/yKeX3ZoRTf5p2xC8oEOPzPin2Igq6P9tY62JzJlytaA4RCKQAV
	QYO47GmDmStIzgLK/f8lKoiAuP0q+PBHCjOiKBzXUnsZ/S6bo9fWteerI8MNXN6llJjVFH7VXt9hb
	2bJTW+Hg==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:49978 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1v59gE-00000003q9C-1sDd;
	Sat, 04 Oct 2025 15:20:38 -0600
Message-ID: <3cd6ebc1-b89c-4db0-b234-3b474a53cf62@w6rz.net>
Date: Sat, 4 Oct 2025 14:20:36 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/10] 6.12.51-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251003160338.463688162@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251003160338.463688162@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.92.56.26
X-Source-L: No
X-Exim-ID: 1v59gE-00000003q9C-1sDd
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:49978
X-Source-Auth: re@w6rz.net
X-Email-Count: 56
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPcL2aE5gkFK4VxiMGK/N5aTO6oT2ZH86/vDDq1WMZoJQ6dsQyBbCwh2CQDAOVpnfCksCCqQhfzcfUhVCXxEUU2QYemnnnR8nydvvrGVePZwt0jHzcks
 we7xE8ETePL12vI9Qdg5TOiqLjoCZzo4LOd7fPZKBaNjdjNVeEEE4A3X7BCXAgF4ldhuxzn4K+0Reg==

On 10/3/25 09:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.51 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.51-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


