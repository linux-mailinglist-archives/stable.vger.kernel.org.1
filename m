Return-Path: <stable+bounces-35533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3C4894AC2
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 07:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1CAC1F23753
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 05:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF8C182C3;
	Tue,  2 Apr 2024 05:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="DzT0D7dK"
X-Original-To: stable@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7365917C95
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 05:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712034653; cv=none; b=UjRvpLFK1aLVhYi88m2Pi6GfO1ZVQnf76hYZHCsHryCgASWdQ60r6fe9to1TXV3t9fZltZwN7hwOVKCS/ncXWa+fdgzG8UJ0qtKnv4a8cUVT3Rxih7m3BgiHjNKjOEjcrHggNMJ/mI1EuKFG+a/KbxViukOH/KzbwBSJyFEDTJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712034653; c=relaxed/simple;
	bh=ucHI+h0QKrsfQJZtrnHjksCf4dCj9ZlxAFIgimGve3E=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=W4Bjyes75KgGPCdYr4YfLZ9RjeV8C83O4bXx+aA+Z3iLMVjnN10wAqO6PGOTazFL8Ai4yRkUjxcm0FwskYJaY8l6oj+kqTq4E/VZ27K9fU9I/kBODkqU4YRiFoRVJKWEZgFG/M4mdkytGfJ8lG60P/7rvy00LaLKHNdGwK73zXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=DzT0D7dK; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id rWPrr1SPMs4yTrWPzrzHtD; Tue, 02 Apr 2024 05:10:43 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id rWPxrulaxd4oerWPxrfDqE; Tue, 02 Apr 2024 05:10:41 +0000
X-Authority-Analysis: v=2.4 cv=aYKqngot c=1 sm=1 tr=0 ts=660b9353
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=9UvB61DyQ3Ym7K8-slIA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FpV/3ClAKOxmgVoq0icnKK8oa8JjVBeRg9PeFMRZpl0=; b=DzT0D7dKQ5ikZAtXnW7uX926jC
	vrZibmZysPJWCkVRRnHnz+FRrTQ+Td1uW+QjwTrKQDKQIvjG0oHgBHqN1IwNXw8YAOWV+9Zm0mQne
	5LLpZsdS+YbVcW601+yfnKk0gVg1RHn9HI3qCSMoU4ETYS6U0g6d4MuOnWBQZIYdYX3wPf8eLV50n
	ZXsU5w2NjJNgGvmn0gLFa8AeP+ztJyyaltlj6CsuId4B6WLZZ5JCgiWizkVRLkjhR9lcaMNF0bUlH
	aaTlWzq0CX2nMUjDf41z8J0EUOZ7tMrAbLMHS216qbsnJPUZUD13oZwEaBjoGMsGciEu9fEE7oinV
	r2iOWSeA==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:55186 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rrWKr-001slT-1j;
	Mon, 01 Apr 2024 23:05:25 -0600
Subject: Re: [PATCH 6.7 000/432] 6.7.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240401152553.125349965@linuxfoundation.org>
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <52cdea78-7bee-5a9b-cd5e-a5f77b39da30@w6rz.net>
Date: Mon, 1 Apr 2024 22:05:23 -0700
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
X-Exim-ID: 1rrWKr-001slT-1j
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:55186
X-Source-Auth: re@w6rz.net
X-Email-Count: 21
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMs9GWV/OpxtfrMqcb+c24kQyAlTVEE8LoAEE71hwTysDu9ow29hgDblmRO4I6eWqYhZYuxfNmkZtuwRpJwqvaVO4uCYmIE6JBRdL/yyEwauWB24VhIW
 R60XooUgaT77UYxyVstJXAbJxto8A4eURvDytrYi9WA+BU6rZBJRk9oVTy5oJmbuBsSmOy5NMQ/8VQ==

On 4/1/24 8:39 AM, Greg Kroah-Hartman wrote:
> Note, this will be the LAST 6.7.y kernel release.  After this one it
> will be end-of-life.  Please move to 6.8.y now.
>
> ------------------------------------------
>
> This is the start of the stable review cycle for the 6.7.12 release.
> There are 432 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


