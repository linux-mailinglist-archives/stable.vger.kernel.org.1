Return-Path: <stable+bounces-86487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65979A0896
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 13:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1381B1C243A1
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 11:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE692076D3;
	Wed, 16 Oct 2024 11:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="XXw6kbgS"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A937015C147
	for <stable@vger.kernel.org>; Wed, 16 Oct 2024 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729078830; cv=none; b=SEFFE2Ni9hE5O2UPWRlDjhvLPZeGRZHS8P1VQHP9wjfAaPm4zP37v7RlDSipyc2z5IHpPMf3TryFvrRLEC06N51AF6ACay9n0+8WPmFM0Tg8K7RmwkGYf85lgtWjvs8A0nCmWHmlJ39nxOb9s8MqzgZQA155YbdqIPVz7Oathl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729078830; c=relaxed/simple;
	bh=0oTOvu1oj59C7ovUOvvQCUJ+3REVF9xlBxZA+LgjNcI=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=FWOQjOE438kQnGkfNJxRceL4/4mzsLzr5CPdwxhtdmz8wMUYm/bLA6FzX6SMAB8ru6FTNFd5vgZhBNsVgOAJgSCPfyiMiP6Bsbvwhf4TGDrj9Eccu3QFq5eYSnJjMtCsMefD1aPmQWarPu8clIf5eL86uN+rXr2Sx3fhRJCe9e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=XXw6kbgS; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
	by cmsmtp with ESMTPS
	id 0wLutJ9KViA1912O6tb1oZ; Wed, 16 Oct 2024 11:40:22 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 12O5trno62Zy012O5tthmu; Wed, 16 Oct 2024 11:40:21 +0000
X-Authority-Analysis: v=2.4 cv=Q4EZ4J2a c=1 sm=1 tr=0 ts=670fa625
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=UiXv1XNBzq_yEhrWseEA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3tnCv/3B6UvQpTXDSatS30ZSZHSuiUQubieRjnJUKKc=; b=XXw6kbgSWn5liVw81xXEfNx2CP
	hzERZNAgWdqz/IZf1eHTmbTeJJJ6aWmMlp49PRWmrN8AHQtdEAvhqQ3tSnLyd7bPl1g5sD+k2YxfO
	/jJrHdq8kqLFv+u0ehSKEYSGz0SaCTDG0nbMWEAiOFFIZr+MtfBp0WKbyxwxA9Gcz/uF7o6PPyEw6
	lvQNVqkZfTfYP2NyLTzTNf33FzCZvrGDO/pEBzBF2/PIyL6UnFBzuUsLZQLViX7TITyUqXr9kYP+T
	NKN353S+d7d3ySW3/ggX5iJ1wx+V9I+fx8u7GHgzYviK05pdTcxdk9fPGUEJDJY3r8u7q2dQfPSk+
	CwT3PXbQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:48078 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1t12O2-000Mug-2x;
	Wed, 16 Oct 2024 05:40:18 -0600
Subject: Re: [PATCH 5.15 000/691] 5.15.168-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20241015112440.309539031@linuxfoundation.org>
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <52532dd8-0191-4ac9-6239-1b278388e5d0@w6rz.net>
Date: Wed, 16 Oct 2024 04:40:16 -0700
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
X-Exim-ID: 1t12O2-000Mug-2x
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:48078
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIPL1aPoYT1PntCcEtPJ0A0VwXget4iEfu7Fo5K5ApEvxFO+PI1dHsOAlbIli5zNwwYNj4zwg9vQj89uYBk/InDhgV0ly8cYmxRyvd2JR82ZITRzYZFx
 zQiCBHsIeoaBOG3SfiPfPvlXZspLZahqTQAl0wCWgSacZmo6K1k1W3NrnxPXvE1p2O1QJpUn7kvvRg==

On 10/15/24 4:19 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.168 release.
> There are 691 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Oct 2024 11:22:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.168-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


