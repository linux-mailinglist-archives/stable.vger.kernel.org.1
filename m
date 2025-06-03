Return-Path: <stable+bounces-150657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 934FBACC148
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 09:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF465188EEE9
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 07:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEC3269AEE;
	Tue,  3 Jun 2025 07:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="3Oq7utmA"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A652698BC
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 07:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748936293; cv=none; b=te9cULVH7134Uw7eBtLb+cCtZ6av8hu/r5DZytfnDclUmyP271EgXLfJxxOOpkWDtH0IfxZkrNGHF/oQttvobo503wtm/lOF49Qk4zwnZOPij7C/J7g4JkXim0N0o11UHVm6WDQHgjQSlUBLRviNratajOE99T2dVB6a/PDBpIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748936293; c=relaxed/simple;
	bh=7nVt3w4p1o3mjt7x8RufK+aUTjrN+RF9zLJ5jUQ6y2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hK/PFaHr0/G7jTB0JujVKimm7kbo+Toa4W4Vlujqrqm8SGtWsVuugiwRKAUknLj1ASTTVV4tEAFLVCOAYZdQy6InGZAEBtsrYoGdB96CKh91p+NR34JmTUgdKX5KO8jXHl5dztRrWSaXL1SkCbNrM4CNqUNeUddPp70K9wTds/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=3Oq7utmA; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id MCamum6mxzZPaMMCIuQUZv; Tue, 03 Jun 2025 07:36:34 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id MMCHuAekP3IrfMMCHu7UG0; Tue, 03 Jun 2025 07:36:33 +0000
X-Authority-Analysis: v=2.4 cv=PL4J++qC c=1 sm=1 tr=0 ts=683ea602
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
	bh=g83IcY5HwzeWhU3vm9ECHkO0qi3uL+hiwq6xDG14FJQ=; b=3Oq7utmAJMokZq9OKm1xegSOhK
	pulAVIFneSZ2kc9EE8mD9IN5DVaQWIKXOH7ffXUCbGlx8evqiWlyMIQaHEjVlW79+IqUJSx7vcYV6
	prRJwYMihMAX23WQdLRT+iehmOyGKEEUVIzu8zL1ZTHu8G7APSwdl+X27n1JRqNu3x7aykXpxNbAt
	bIZENq3tccs7JzuJXce1M047n0ts+rSsstTcodsm6Dhe72YTqlAFlmkDNhmTCZLEmfJekjGLDCrPo
	P+n2T3SBAgcC2s3sMQD4gwYy1bdJdpN1msIOyWIyS17qRjs69ydR8qMxiqilsiqdxppWApR1zkIqg
	rLXJFzPQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:48122 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uMMCF-00000002Urs-1zGk;
	Tue, 03 Jun 2025 01:36:31 -0600
Message-ID: <5979fd97-361e-41d6-80e5-f793a481b6c7@w6rz.net>
Date: Tue, 3 Jun 2025 00:36:28 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/55] 6.12.32-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250602134238.271281478@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250602134238.271281478@linuxfoundation.org>
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
X-Exim-ID: 1uMMCF-00000002Urs-1zGk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:48122
X-Source-Auth: re@w6rz.net
X-Email-Count: 75
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMTSAMMCZg5Mjh/OR4Y3IZ8SKchKg+DoqxRzySKqiROXks0aTSSRv+XzRy/tivU2yse6b1Kr6vfAW6kUTnx918JQHVG839qx7g9YeABVJHlvwgzdNPQh
 TnLIm9QiiXeSvm1YbSYTdmIhhKijru9utFZh/0NRJGTDyV7pQpqI9Ki1TV4EDCF9ny8sm4icrALKwA==

On 6/2/25 06:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.32 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.32-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


