Return-Path: <stable+bounces-47604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1CF8D2805
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 00:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B20728D88A
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 22:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29D413E041;
	Tue, 28 May 2024 22:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="3UR0cSg3"
X-Original-To: stable@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF60EC8FF
	for <stable@vger.kernel.org>; Tue, 28 May 2024 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716935383; cv=none; b=O4P7rWq35DzSPEHm7GvK8q0RXzfiVvQhPVHV+TOHxAhVraZHUE73A49PYhrzVMX0ZLSc7WpWIVgqiPw3hR09DX3n7dOkMl5x5/+kjLEYWt77AiK0cy8ropUhrq11Gftj/Dtxjvi2zALj6kW9iyasHdK/CiZvIPQCINmpxh6IIx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716935383; c=relaxed/simple;
	bh=3PSMdRc2GYQXLEXyrtlPCeK3+/YRoIdpHNK1yA7qziw=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=S0hSlN9ZqX6JIYfM9cOTHoC+odXb98h5okp53gmQstR5WE4S8UUktspdqdZEWIG/1L03U8rwRnW1etJEucq4xZwhO8GFNu6/fYSSB0CJ6W+/lCtMCO+g5TbLSOiD70YdVnHQTymFy8X/XeTS8S0Woaqck2LQ57Zn9K+hjbLMKvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=3UR0cSg3; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id C30NsIySnkQe8C5K2svgNP; Tue, 28 May 2024 22:29:34 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id C5K1sX49Hd4oeC5K1sjYks; Tue, 28 May 2024 22:29:34 +0000
X-Authority-Analysis: v=2.4 cv=aYKqngot c=1 sm=1 tr=0 ts=66565ace
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=TpHVaj0NuXgA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RV1HSAld4XasM5qDE1TJAA5pVr1f7rOPxzGKw/dDO6o=; b=3UR0cSg3fADhp4jR0DnaJ3TfHu
	l4OdzysqcHrrxLhBTH6rCuHRKwoM+GENxkrX2ChQUes3m95zU03zy0uTQOtSGDDtYnlbMvYMQZsQm
	GQYNS82ibnicB48HKq7JyKRlEV34k20pZ6wBtRN5gsGOMZG11cgHMmRSbrzD4C//XmDaFfxVGozZd
	TTzQh/KjZC8hD2k5lNTJJH5kjo32WHD0lbOR/a1569TnsXUgUXffOIzwbGv0JqnSaW5BkU+MboEZ5
	swCD1IAZjYCLrbCqZumxGwqU4JnyJJj5yOdt0MYhyFdK6i81smkPawqmeM1oA4QKSgBVYfKdiYAB3
	RHTDFvFw==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:40674 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sC5Jz-002mRu-21;
	Tue, 28 May 2024 16:29:31 -0600
Subject: Re: [PATCH 6.8 000/493] 6.8.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240527185626.546110716@linuxfoundation.org>
In-Reply-To: <20240527185626.546110716@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <1c94d83b-9f20-dfc4-46a5-46089ebb6b00@w6rz.net>
Date: Tue, 28 May 2024 15:29:29 -0700
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
X-Source-IP: 98.207.139.8
X-Source-L: No
X-Exim-ID: 1sC5Jz-002mRu-21
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:40674
X-Source-Auth: re@w6rz.net
X-Email-Count: 21
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfK1Shw6g1FewAK4gRwn5FEmpCorVMgA/j7nPL604cDxTVoBjTsvofWUAPCughOdbqQIA4Iy0M6qeR80A00z4/hdoKEKtGwGERtM3yE4Fbr5u3M5C++Pv
 ICKfuExan+kWKoXYmS/FIDcrB0dZf3lDje3yt2UkzyzPgoRIHThiMjbbCP6a0+AdlpJF/6F3MeL5HA==

On 5/27/24 11:50 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.12 release.
> There are 493 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 May 2024 18:53:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


