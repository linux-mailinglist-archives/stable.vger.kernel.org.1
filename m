Return-Path: <stable+bounces-177589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCCBB41966
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 10:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A347D189040D
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 08:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B26B2ECE86;
	Wed,  3 Sep 2025 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="oP4oJUu8"
X-Original-To: stable@vger.kernel.org
Received: from omta033.useast.a.cloudfilter.net (omta033.useast.a.cloudfilter.net [44.202.169.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A779D2D29AC
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 08:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889786; cv=none; b=iC7LKCyvYaqpezbHRq8fcLyg92vKQEBUO4WKnMtPHZZv7aXJN65u4BrBeTuV5gnOSm6dq0VBT8+csLg9sf+fycwW/Y0+WUZIKDFcHfDLfSdf8i2wv8BEElxRMtl7Y/ZNyDOus5ViJaz5fXwQGjOcXzvivDC36AnakZfHHK+RIuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889786; c=relaxed/simple;
	bh=8wcxB9gsKzgfR+hJwpbQcWLa/crjgWboYQytgv0SKVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qDTGWGVOHnHLFmX4kvaAXPoQFv/NUSS8GHPiPvINChzDbwiqmhyhrNnhgFyPNXute1vlXuCYYDuZF0bLrQ2/jjpQJE8IwVeflVTz664vCOWouHVz7mHcTIu9MHpmIhN4gMzvq+L5yLa0eI1n1BbmyCP9lJbO7hPIOqJTJt3v7Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=oP4oJUu8; arc=none smtp.client-ip=44.202.169.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id tghou3DTXU1JTtjHyuzBf1; Wed, 03 Sep 2025 08:56:22 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id tjHyuEBIkwbSdtjHyuceW2; Wed, 03 Sep 2025 08:56:22 +0000
X-Authority-Analysis: v=2.4 cv=VODdn8PX c=1 sm=1 tr=0 ts=68b802b6
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=wQHQzwf_Hs2TCVCgcZgA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aeeKAF3PBFlKS0N1RC3x8dkcm9vxicJpkuKAZH7nWGg=; b=oP4oJUu82D18ifLiihjSYQKRqs
	NfTBNNCRcKVOGprX6m2AjBMbsFQ43ZAjPHokA1R/+PhE0gfQIkhjI4mi9Y2FBMUe+vSMtqOlWoZ7s
	RpVYFF7E2kTtdUgsTLnatQhM0Dc7sILeIgaXEfMhK1gj2JVWXV2MiZSBu7ipOQIvQ9NZUI40f3NhD
	o8+miJ+PNPy0lSyvTGe8CLjX8o42vUdXZgc/Lg2yGouU/ow4nTbze+BkOPZpNv5clT6QayPPjBpeg
	Nm9lGVkC/5IljvNVsyJssGSe/5svw+/7wnXNlOaqbVwFUShFYirzB8IjbYwYeblNOmhmi7zlfMBli
	57tYERdg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:59458 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1utjHx-00000000ire-1j36;
	Wed, 03 Sep 2025 02:56:21 -0600
Message-ID: <c50b8153-7e14-49bc-8d54-d4f3f58892cb@w6rz.net>
Date: Wed, 3 Sep 2025 01:56:19 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/95] 6.12.45-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250902131939.601201881@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250902131939.601201881@linuxfoundation.org>
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
X-Exim-ID: 1utjHx-00000000ire-1j36
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:59458
X-Source-Auth: re@w6rz.net
X-Email-Count: 39
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMwaLh2YSw71Q60PR88toSMWR97bHQde6lfSQdSEJAJZeZuLfUjh+3MZRyaG0pPSThuGcpQBWR1uArehgqyuXQq0I0MLvUUQgn12IBP4jXmivLNjAI2x
 fgj/4b1xXhM2JAmd9ZSv6kGSGJp6y0oWdikA3blSNHZbTOIqKiVRsL1f0BlKBjk79+77Vm9gZBfTLA==

On 9/2/25 06:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.45 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Sep 2025 13:19:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.45-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


