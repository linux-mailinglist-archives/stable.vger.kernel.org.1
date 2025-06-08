Return-Path: <stable+bounces-151872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65623AD110C
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 07:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735223AA50E
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 05:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E55D1D63FC;
	Sun,  8 Jun 2025 05:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="qFuApsrQ"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E195A28F5
	for <stable@vger.kernel.org>; Sun,  8 Jun 2025 05:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749361489; cv=none; b=VZPmi0DcjGFZ5HMVq13HzGxYP5HUC5RkStLtY7DKcQyV10HZdhSfeq/R4Ar5/G79/ToQ7nviA7D6H1NC/+NS81fCR/sb6MABGVArb6Le22fSSrBJpcAIUfLCRhRFh0Zcdgt9DDmiXIvIUZAq+YoC3ocwXy82JhcjnCyQnQhHuQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749361489; c=relaxed/simple;
	bh=he30Ib85VAnAsoGNDOxjJk9AUCkezUCAMpzDOBviUMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKYtgJI/Uk7NXQ4d7HNKCrb1294y8MqQYlbxPC9f6H3J8UjLotTYHzQkWqS/E4tCtKE9dA7OLije4zIBbaXplX7dP29Qf1hF5gZQgneYBGsUOANUXsKObAUZthghBcy1AXJEfftJV0mAfhM+zz8UoceeCr3EgXO+HkS1VCRN8WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=qFuApsrQ; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id O88auoDCgbmnlO8pkuq327; Sun, 08 Jun 2025 05:44:40 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id O8pku0vMWRlrsO8pkuZnRl; Sun, 08 Jun 2025 05:44:40 +0000
X-Authority-Analysis: v=2.4 cv=Qamtvdbv c=1 sm=1 tr=0 ts=68452348
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
	bh=gwYtn/RgJQHtHKUEvvPmFcfQKmiVhVAiycsArv7TLPo=; b=qFuApsrQeYd9fEtCP+RK+VLJUU
	0lTqFN1QvSo6ya6KgOJENszJMljo5CM2odJ91cSPlJax/jGJJtu/h4V0PLjIPimXHhI7QBdcnKWEk
	jguyPx3oMHSUK4WOUnSm8TcrqUU5jBxHhxaJ1VkH1SSaxnYkP7YwMdLnjVG4ZY+Xwj2LuFkxIa2Ua
	BhpffJA3X+kg2uHlN5Z/iolA2inupfOoj3mYXVAV4BKYwWLHmUT7qBdM/ao+j6LTFMfEDESwardxB
	Ii7yd6hsudUCxyXqZHVzveDXhfj9yqCUPmYU1+2KqrYhCc04Eej4MmOOGiLeCX4qHOBYcmSnji/dr
	OKQMNmAA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:37720 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uO8pi-00000003RHs-0bFf;
	Sat, 07 Jun 2025 23:44:38 -0600
Message-ID: <ded57af5-8332-410d-8b5c-a72b8f83fc3b@w6rz.net>
Date: Sat, 7 Jun 2025 22:44:34 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 00/24] 6.14.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250607100717.706871523@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250607100717.706871523@linuxfoundation.org>
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
X-Exim-ID: 1uO8pi-00000003RHs-0bFf
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:37720
X-Source-Auth: re@w6rz.net
X-Email-Count: 37
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAhIK7LPwcAwXaxUxtq67jTb4zuPrEN4UpHl88cCM0llPTtsZa4Axg+UmGmiKMFvSRxU65/2fiJ5HWPqsFOQTLQWZhtyuk0MgoORR1mfgLaTIsTkLo7J
 xjZxD1JKnv45hQsD4lm3+l8Q0E9bCMNzzHUyI9o0ICevI1fZD1e/3QLMEFDSvU2hCpGkRKoznnWUcg==

On 6/7/25 03:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.11 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 09 Jun 2025 10:07:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


