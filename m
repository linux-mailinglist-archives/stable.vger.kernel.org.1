Return-Path: <stable+bounces-123184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EA4A5BD6F
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 11:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEF077AA02A
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 10:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8F42309BD;
	Tue, 11 Mar 2025 10:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="v38GcD+o"
X-Original-To: stable@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DA623099C
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 10:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687985; cv=none; b=tN0z5ikLLcm/oAAQNYuwmlgrFdB7G8I3m38tygOBx4P5uyDZ+lH5QASRhLl1pDGAGs3k9mCxtCsnxyaSR56D5M/XuUex2UZkIjx+BCde1DBqXgsM1SR3iw+pu/Nkcm4kM7nWiblchwwvAPJLWaty99TQNSi8NVm5AknEalncl3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687985; c=relaxed/simple;
	bh=eKZ21sAfzTBNzYWki/MIvFoXRYxeTYoWGzwrhM4B4YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aC7p8tBPg6kQcEwQf+Hm34N33Ivwjo3jDKSmA5SQYsax0zCxAzQfpjU302YrnYovDet0avJMN1Rn3s17OxdEStGt+B6rp1cb+n1WZzCtXwA8WX89HFLJ3lIFqI4t5/Y2elvQTZt3bKAr0r/LqidwEeLIOOiVzPd37p2bbiUNS40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=v38GcD+o; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
	by cmsmtp with ESMTPS
	id reoltO5ihXshwrwbdtZGGg; Tue, 11 Mar 2025 10:13:02 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id rwbdtVmDKsTV2rwbdtR4dX; Tue, 11 Mar 2025 10:13:01 +0000
X-Authority-Analysis: v=2.4 cv=GquJ+V1C c=1 sm=1 tr=0 ts=67d00cad
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=c9ZH/a8/3JJBb4/soWP2O1bASmEOVWhEZDkVB/Rb6R8=; b=v38GcD+oSGsQ0DQwnq3R/bbbPn
	dhUusb3SXIcH/Y1rFzkkgUoUTkB8jyADUWx/Xp9dZbXjvfdJmGgUePl7BJgcp6+zcbU5pkltkbiTm
	bEqsvl/3AkzjO+3U1kHQlgB5+5wu0FAjt3tEFUgwAJMfoKO6F9bwxJwKa86aKRaDigPxhvQ4Yg4Jk
	vIY+1zBLRu+3aj44ngGSLqYAzRtsN0UoKuzm+c0kw6pW1vr2xb67I/h9ZZCTUMm7AwM1qhLzdy0LK
	/I9gZAMOzYZ9h13X5FfKTuWU3Xv8IQw+o9raQrDMmngbbdNYtsTAVdgAIYFqRx/Co1qsxxvNzmGqU
	QZLhwriA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:41848 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1trwbb-00000001VIl-0O7N;
	Tue, 11 Mar 2025 04:12:59 -0600
Message-ID: <c958fd6f-9381-4571-a1be-b2080122f78f@w6rz.net>
Date: Tue, 11 Mar 2025 03:12:55 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/145] 6.6.83-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250310170434.733307314@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250310170434.733307314@linuxfoundation.org>
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
X-Exim-ID: 1trwbb-00000001VIl-0O7N
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:41848
X-Source-Auth: re@w6rz.net
X-Email-Count: 37
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNQ8stXlCE06/SjkE/yxpPcNgc9+bzJ9UlLUv12sGwtZhms/r5CPSd9c8nPtiVVjHirK6ip7hEqaXelMMDDIt9ctXnHYK7uDJ/ge/B+8G3asvS10+5hW
 0EVbAJKQ0cqPvLXNRPBsXFCOUvGaVTZB6o5OQEGUQBPHzQGKg9IYBBXXKJra6J3iA+ZqJ4CoiyTNuQ==

On 3/10/25 10:04, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.83 release.
> There are 145 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 12 Mar 2025 17:04:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.83-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


