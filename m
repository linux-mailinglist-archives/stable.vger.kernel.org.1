Return-Path: <stable+bounces-158340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCA9AE5F3E
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 10:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 619DD7B37EE
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 08:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D184C25744F;
	Tue, 24 Jun 2025 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="dgIMN4Gh"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801D62571BF
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753763; cv=none; b=WewFpoOQbueXfPsWhZ/w2LTi4vFwCmZl021lD0yF4JKwHSnk1zY1SynjOtgAu+Enxmnanh3J+LqSIuRfnNraEfYtl0C6fWK6+NacBbnmakpoFuIiJtLQQaDlByK4OdZ1wxxWPbNxSQaHISmSiZ25cvsk/wZqiapCIdP/Ho6MNhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753763; c=relaxed/simple;
	bh=QO0Mf2U6JVrx6SZU1oafEghV15ZUc9oWhEPBNQSJwNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H/Oq2lRHULwpMjeXqY6/56nyIrSqvtnsMwNhp+jzLNO44h3GQnclVsrsHUFooTXj/6b+P2XKi9PigppL9GJLBWUIweKK4AxaL2AXHovgYSn11Ecn2dowph0PySe8Gnno0fpa80ie/i7FnCc2HhtxtxI8fs+RQwJz+t0ZogTGRvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=dgIMN4Gh; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id TtI1uzHhnbmnlTz1ruvPkU; Tue, 24 Jun 2025 08:29:19 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id Tz1ru1EGnJ4PgTz1ruhOD4; Tue, 24 Jun 2025 08:29:19 +0000
X-Authority-Analysis: v=2.4 cv=ZaLWNdVA c=1 sm=1 tr=0 ts=685a61df
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=s5aijZbevkh5I9aHuEFr2NCgAbJYae6Xa9A1uqToXKA=; b=dgIMN4GhQMw8kVT+V6ldYNFqXc
	flVjHLXXrdGL4R9JNJqD86keuZHfqVdIbRp/cHPSLwZGTywX7DT3mzO2H5+/CFbjn3VN9saYKAZSX
	wtX42MJVWiNV3OIxBzBV6JaSBEO4ahIgBpCHGc5NJezsTGm5zkveYG7B6oBB7uhE/H3ziOm0iZij1
	YttPyy2TcOXqi9goLfxEIIwQVKMgW0A1vl8RN9nW7RuUwMohk3ATvoww6tS6UqkUqW5CzDuMUDob+
	XmM15J3QtThw+2SAgig1DmRVsu1i/wGN3K0C4X3QuUHtz+L6WE2xsVYCylsUWWy/ofzh879J2uDtP
	zs90qVEQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:42752 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uTz1o-00000002M7p-1iBZ;
	Tue, 24 Jun 2025 02:29:16 -0600
Message-ID: <ba750bc8-976f-47ac-8d62-b7577069fa62@w6rz.net>
Date: Tue, 24 Jun 2025 01:29:12 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/508] 6.1.142-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250623130645.255320792@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
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
X-Exim-ID: 1uTz1o-00000002M7p-1iBZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:42752
X-Source-Auth: re@w6rz.net
X-Email-Count: 75
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJQyAPUM80UUSBBHhZ4SUbeuGb0dz4q78oxF6VRoQY/3l9tPyFPJ77z6SYyDMXDUBn0YUGupNJXrxRf2NyUHfR2Z8FGFAPSjD7MYKFzct+PxA/H/WlF9
 4to6G/KvggkDL34yVwIIT4gDZG1S5csLS+gk6S+OL4yhX/T5gjyKRsD6Ali3favAnPE79oGbje8RJA==

On 6/23/25 06:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.142 release.
> There are 508 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 25 Jun 2025 13:05:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.142-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


