Return-Path: <stable+bounces-73813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EF696FDE8
	for <lists+stable@lfdr.de>; Sat,  7 Sep 2024 00:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E959B27266
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 22:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655C315B0E5;
	Fri,  6 Sep 2024 22:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="DXqNCius"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3AC15AD83
	for <stable@vger.kernel.org>; Fri,  6 Sep 2024 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725661147; cv=none; b=PuF47MojSSApGVHiC4ukSdyMF4mODjmv4om2SDDI7Q/fyaVt8aEY8Hq5q8qODjdZqzYBYaaEvx42yjjHH9CuYM02C+hppz1jVJGZ3KnmL4lvFZGt+YvNG4FDCnLD+wVyr4/G5oMrcyBH1QKWnxkKGQ6126mKBHrJwFP5cdtqbm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725661147; c=relaxed/simple;
	bh=wdO9ZZw+a3Svlepwm2sOo0Qrl/SinTrjpnoUCOM0w6w=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=JZiF3IldUhI1AyIgrnHbMbNUf8trdSaHuWtKvaRaE5V8PktKIim/YKOvnAgpnzcST2bWfgA0Z00V5Ym05pqwA1hKObh+7mU1BQzyAhCMcNSEXYwzkJkF3TjHhxp1nsIRVh1RjerGDpWf16rDDavt8bWtlZO8ze99n1c5zwCvOoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=DXqNCius; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id mdY7sZTT7iA19mhIAsnUEy; Fri, 06 Sep 2024 22:18:58 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id mhI9sCGhjO7CrmhI9s1o4u; Fri, 06 Sep 2024 22:18:57 +0000
X-Authority-Analysis: v=2.4 cv=Pco0hThd c=1 sm=1 tr=0 ts=66db7fd1
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=9s_CLuLT88mpKrREZRYA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=W7RrPQYON4XjwYXcMB7R510ENbtkdUVss5oOseomJ1M=; b=DXqNCiusri8bPB1KdMMFb+IJQs
	x317kprRjrCqD6PUpwWPKAwwEsVr23Q1+dMYeaxDisC/H5OZnMzlqL3B0AlYCVcVFJZhqMcEivdTC
	UfbvkOuW+cb+0DB4qaUdWk1JHuQJhfXjM8hOtvSZ3RKnwqD14L0mi40rgGkJ+92uFFMcUBkz2kYfe
	aM9hv6OICm7qz5i39GJA8rXiP39A1+4NFwiMA/SRZCpAh6E3XaWZ/HcEfo+MTaC4bcrgkfYDQwplW
	18L+6OrV8zT1nIzRbeyq9ZTJdU0QGhZ4RmcLOHgsLmiyQvuTHcevxWQZv4Irn4dyOHdI7LpyrThdq
	CdPNr55A==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:38790 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1smhI6-000VpV-2B;
	Fri, 06 Sep 2024 16:18:54 -0600
Subject: Re: [PATCH 6.10 000/183] 6.10.9-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240905163542.314666063@linuxfoundation.org>
In-Reply-To: <20240905163542.314666063@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <bfeaf2a7-1bc5-69ed-2004-388d3c9f4130@w6rz.net>
Date: Fri, 6 Sep 2024 15:18:52 -0700
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
X-Source-IP: 73.223.253.157
X-Source-L: No
X-Exim-ID: 1smhI6-000VpV-2B
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:38790
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOiMp3hL4QSoedrbWlcSGX891jPKiagSHQEwBYjeBa2mmy9exT5x71aFtX0n3mbQYoPVKWAuVVxjFqxS8wHHfZItDFb74Oz3SuoxaQGmy4K5G1DU4Rao
 +UfryxK0KjMH0mohuFnSwWhEpAYexcI44ZVfE8p6DvnOcsqdai8h6Zombln2LE2wl4MG2qy7o0w53w==

On 9/5/24 9:36 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.9 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 07 Sep 2024 16:35:01 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.9-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


