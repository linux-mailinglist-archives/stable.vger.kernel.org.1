Return-Path: <stable+bounces-54725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75936910884
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 16:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 004A1B24235
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 14:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7ABC1ACE9C;
	Thu, 20 Jun 2024 14:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="xpVpg/rH"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9874A1AB535
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894094; cv=none; b=N48L0Ae0ZPY1F1G13JiES07z4rqJXRhKIL6FkDDOH1QmZLhFGfiLSL/X7Jz5J7F60dZr5ilmvwt+0MXHCWAJe9NsriFZ31muhSzBGgC3nikyIiFdOsjYADLlz3bh9wjC4a/1b3vZF+npfCRYWgRzg8Ac3Oo38RyRlHwWZcK0i84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894094; c=relaxed/simple;
	bh=RVThDafy3uo4pg7emhG9LvZxYfFJ576f9DT/KxUruuk=;
	h=Subject:To:Cc:References:From:In-Reply-To:Message-ID:Date:
	 MIME-Version:Content-Type; b=izyJkrs6NNVChKsxRpXe2Wlgf6yI24FxtysC2QGCwyN0xBw5RFcajvrfeU7Rjzvbyp56yr65KKx0mCgSJEmxwMOJ7yVXJYY94G2O05jOPe/RkJsYQMSoyQfdRfHUwPME1CZJzxusZS6g53tqUEDnAwXD3pUCX9edK8kJ8p7EFpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=xpVpg/rH; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id K2PWs2MxRSLKxKIsGsVNMq; Thu, 20 Jun 2024 14:34:52 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id KIsFsekdFsT9BKIsFsCxcU; Thu, 20 Jun 2024 14:34:51 +0000
X-Authority-Analysis: v=2.4 cv=LIutQ4W9 c=1 sm=1 tr=0 ts=66743e0b
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:In-Reply-To:From:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tMc74o+tTpNs+4XE+x0fYcX611m4Lf2fIXT5GrOocLY=; b=xpVpg/rHvOCoLG8blbg2M9c0rj
	8CJpTBvQZarZrZYoltKU1NwXQhcfiNaN98OoTAYqnT9TmPDTU7w2Ud9TyioPvVdrrrybOVXkhwCWD
	h0p77YiUn0Dbyc1ruIH5cd1LVbBhlCJXNAujYO0ZX2aZmjdQUkDhhulY4J/C40GflD8bSz8zhGEaQ
	LOesGHphfKC2Te39nmC9wv6P2b6Qz6Ij6vlDYUGj9Wrk6mIbyPN66ZovQBsy5tHYn7KUH/Wxgt2QJ
	1Hhr8ee2ieFsNzTwSJuv8yx9RPJBf3wPARHiQC4DeCDsbGonemPPRcHRih99x0g6TvaIjBk6lIoXV
	sRsaGQCA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:44958 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sKIsD-001k5i-0L;
	Thu, 20 Jun 2024 08:34:49 -0600
Subject: Re: [PATCH 6.1 000/217] 6.1.95-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240619125556.491243678@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20240619125556.491243678@linuxfoundation.org>
Message-ID: <3e96b216-383f-6e0b-b62f-6fccbe45b0ba@w6rz.net>
Date: Thu, 20 Jun 2024 07:34:46 -0700
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
X-Exim-ID: 1sKIsD-001k5i-0L
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:44958
X-Source-Auth: re@w6rz.net
X-Email-Count: 40
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHdqleNU7iobvtdWXVzMRyOR8gB7AOs0FuXmFfANqReO64PqNki5K+Fzg0lKNOt8vGuWDAaG+vLpHAIptDwmGlmvdiR+rNwSjc1xRzS8S9D0kGBwXdD5
 5Agpys76Hbu0TqZ1mIC9TAu3Wtk9hJJDQIz40mkSR/dXbfsfFkA1ZOOY95BC8oFDTDjtYrBnx7ZkcA==

On 6/19/24 5:54 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.95 release.
> There are 217 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.95-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


