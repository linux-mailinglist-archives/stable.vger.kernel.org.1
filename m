Return-Path: <stable+bounces-145734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED46ABE92A
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 03:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1BC4E0506
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 01:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F521A705C;
	Wed, 21 May 2025 01:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="t39CQtSl"
X-Original-To: stable@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4530A1A5B88
	for <stable@vger.kernel.org>; Wed, 21 May 2025 01:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747791229; cv=none; b=lt+9kB9SwKLT729GzezWo4YmQ0FofM2MAw/tlByxxYxHxKuo+u1NW2xNSeP+6oT7ENGugacsFu1euLNTbDxgNINve4KdPy69dyqKoFCnZlE38Y3/TJ22HaRHL94+u6xdvvMXwaHCIB+S1olQJjXZA4UHDt4Gh+V+JWkn5NAcfh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747791229; c=relaxed/simple;
	bh=hBh9qLI3K8PS/2/EnhaW+9jUNhOWqX+NYqd4U1aSDfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qr3n+hReP/+qYAWpTFnQBbg2blUtocxqp2WPzs05/ZAfPkH52pesTMPyZI01dJ0bvgyllCU1ae36uMa1jbvjoy48I3MDwFgBwNXcuXx3adD91hcMfHfJEcrrXo7e/ye5dnjiTVrXWl1LYvhJeushgtzGXdM6UG/La9EWaUEJQNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=t39CQtSl; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
	by cmsmtp with ESMTPS
	id HN3ruMN5oXshwHYL4urrYP; Wed, 21 May 2025 01:33:46 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id HYL3ufBjKSPIxHYL3uIGlY; Wed, 21 May 2025 01:33:46 +0000
X-Authority-Analysis: v=2.4 cv=MdZquY/f c=1 sm=1 tr=0 ts=682d2d7a
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=qfBMeBQ8Qh9mIwLNFBIA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZUUl1Q2Ujx1WAESjDQJEJxzYwXq3TlPTKP6mn2oqggo=; b=t39CQtSliwSqW/5xQX/v7XV2Tl
	yt9OgZCjoDursD+dAh19S6b1FurEP8OLB71uATymHqKO+0UbrzWah6Ij2XqlHTNyWuQY/NzS6+B2V
	C7T5nsXEgGgOaf4bIrtRidXeap8HSZD/fEA/EeJzB+okB4fQKaccvWxn3rcbW720wXDDzDl508pUC
	xYQ4+0ybc3bR+uACvybeWNm+vpSdyGmETC1YU2y6c7fJCzBkJ38YBF9XcUWt8OdPaa+I8n8ajkb7H
	WRjwH/M9pDQ+/qVcmcBe9GWq8QW06TOmJ9pgaJHVaQz8VkFD3o8TwEfEd1sCJHLDwU8U6PDFttlrh
	QeRP6oeg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:38488 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uHYL1-00000000tT5-2Vti;
	Tue, 20 May 2025 19:33:43 -0600
Message-ID: <d9ba98ca-a37b-4683-b806-d157a7ba3699@w6rz.net>
Date: Tue, 20 May 2025 18:33:40 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/143] 6.12.30-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250520125810.036375422@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250520125810.036375422@linuxfoundation.org>
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
X-Exim-ID: 1uHYL1-00000000tT5-2Vti
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:38488
X-Source-Auth: re@w6rz.net
X-Email-Count: 37
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGdF88/oxDJFfpTtOBfj4pINHWGOK32E7ftAfTv4kMaD2WUZ6uF+iFeLz2X0Ufmy8jFhPUurJykCQoDKUlzrkpYqIqLwkRTSGANzpgc4nXyAkD6XivJs
 9PBGB+N1sYIRYvPt9N0TIZgNRSwfseg+14cNv3uyurjn0DgS/PNMuTjGW/IVfFac8prjYFo3Bez4eQ==

On 5/20/25 06:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.30 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 22 May 2025 12:57:37 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.30-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


