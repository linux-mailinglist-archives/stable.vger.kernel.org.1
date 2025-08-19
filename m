Return-Path: <stable+bounces-171757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 242C9B2BE69
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 12:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D54E27BDC76
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 10:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4508B31CA6E;
	Tue, 19 Aug 2025 10:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="RIEa/OVG"
X-Original-To: stable@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBCA31AF17
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597867; cv=none; b=T0/uOxU+MozIV4dl4JeOScF/ZF/OXRoR8ekpmF5LgQ3xkK4mS8tOIvZ29++ClJaXk2JQPQGm6ozW093xyerVw6JNiaTFf9kaEZjr+fNIlZA7gFOMUkeLC0roL3FGxZX7EV71y4hkpIgageXvL6GpBK7Ou/Avl/U4uHPmqZfE4xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597867; c=relaxed/simple;
	bh=hlJs2knitb1lARST0gkSxsBtUoXWm4wfC8UP8JL7gsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RLY+upjv7UDp4EXpUttTrliqJAgXTL/TO/zDkoEsbP+1uF5g7KXOUN0pApEyDBmdtK8RKDNfA87nf5v12UvCb2IbLFd27RozYHzyuq3N5RlXb3ZwoPAimtnp9K71W0Hg4+oIZjKRDZiwE9GQQ4ved+8bhHrMv4cJEq4hKA03w50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=RIEa/OVG; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6005b.ext.cloudfilter.net ([10.0.30.162])
	by cmsmtp with ESMTPS
	id o9lkuAYXDcOgkoJCUuGOUl; Tue, 19 Aug 2025 10:04:18 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id oJCMu7hjcgahDoJCNuPMB9; Tue, 19 Aug 2025 10:04:11 +0000
X-Authority-Analysis: v=2.4 cv=faKty1QF c=1 sm=1 tr=0 ts=68a44c21
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Zx/jWLPsUjbk4SBooCzjauSYqfhONLohftEAL4RH0So=; b=RIEa/OVGX3YEwQhQ6D3CfSivHt
	pDUeKibg3N9gVpPdaYM/4Eju1KYB6VgXnWzbGxUwucKrOcccuEJNfySR7atHoUTMyZWYWf1jSiqg/
	S1idIOpSsRjQiygS/V3mWUsavxYe5nERf38TLuiW6lP9yRv5kuUInjldkrVud5r97tCzr3nSLWz4R
	nn744gG30mhz2q4IJdhmbo2N54V/gpj98MDVQFgQL/tTIMJ7dPIf53Sf75R/lXfz3k2GMdpK/SAzu
	ap4g7H8bRZWGBmZwdCkrVHAMq2ex4H/qreguWRuy8RHtfHA1fZbmtoWUSFNq5u9rA4gKzxOO3/hfE
	92pxYGZg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:33660 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uoJCL-00000001zF3-2rZe;
	Tue, 19 Aug 2025 04:04:09 -0600
Message-ID: <c3dcd0ff-beac-45f6-919c-9f58a7d65d7b@w6rz.net>
Date: Tue, 19 Aug 2025 03:04:07 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 000/570] 6.16.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250818124505.781598737@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
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
X-Exim-ID: 1uoJCL-00000001zF3-2rZe
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:33660
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHXGcGetZAGv6gN/IFT3BVmqPXj6j7CdSE8pf9hDoE9MUmj362BUitJqwugwacnMywF5xe3+H9wcz1Nx6GEzKy/KSlGZFen9BAoFP+2xX+AAE6zIMvye
 hog0QOqdL6IU0Z5aup3gc/MdJ35f5BYZZZq0uuTvUk8NLLGfQ3XUt6HQ5dmX6MIk4qAD0jKDcsXVsw==

On 8/18/25 05:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.2 release.
> There are 570 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 20 Aug 2025 12:43:43 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


