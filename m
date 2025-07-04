Return-Path: <stable+bounces-160141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D83AF8776
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 07:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02721C4847D
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 05:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0AF20F063;
	Fri,  4 Jul 2025 05:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="yA9lgoBL"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE1A20E023
	for <stable@vger.kernel.org>; Fri,  4 Jul 2025 05:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751608382; cv=none; b=VeNFBaI+bbpq4So6ZptKoTdnVLM+cbYEKs6T2Qon1Uzln/cvDkDr+WABoylYrmymlw2j7sb5dRLDHuQCf19ATVxbe2Inea/aR/OtBswupgkE4DClM7a3NatZLVCb6Q5zn9TmwiQW159oyjYfLXMbSvA5ko/yJECrsy4XctBjYZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751608382; c=relaxed/simple;
	bh=rA4LBDewxvPyjFV5f8OYkZ7aP5FZ1aARUOL3n/eDFb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BO98Vu/sgT0R71aUREhLU8MHC+MvK8Q+ImJ31p/2YZNlfeLzYXXh6KkDtzkbThfxmeJ/bt31BI9wKvooDa1D9L/ekcOlYzccIV1hHEtUcU8K8CbdNzNJh19Au5NOV7dyHI+LIdZLrkZjg5h1nwuMRUSjKQepI15BiQqhv5/l3pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=yA9lgoBL; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id XQsduhnhFbmnlXZKUuHFoO; Fri, 04 Jul 2025 05:51:22 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id XZKTuVMMIn1UKXZKUuOFMD; Fri, 04 Jul 2025 05:51:22 +0000
X-Authority-Analysis: v=2.4 cv=UIcWHzfy c=1 sm=1 tr=0 ts=68676bda
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=ZJCAKeS_rTr8ZDEThcMA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=O9MMJkEsR1KX+OJ9KCLO9TodMSMz2wW/Kp46ei93ju8=; b=yA9lgoBLNBZ0ejKSWPAEj13tkT
	xmrj+Yy9lqFly1B/TrFac5lJrA2Km//8QSBEwgldGZW4oraWoHHnV4CCInadGR5iRNdCEmAzr9whs
	QRZs3Y3iMYina+DaDMbk5qRIwmV/Yb3RoiFnXUCjfmOXOYnm0bXU1ypEv1bdxdOSLP+q4EJBDE70V
	heDCyD/WqbIPTq3sFTiJeEEzKhjXcFIN9ihsvKXn1IINuEt0zFrr3utrr5CobUnWT/+rIfFjeCmu1
	8Y9xKhmnCxWvIv+l/viwJA9LWbPDSW1c4qqS7Ov3HXXaqumlGuCsILLO2ZwAdyYP8v0t5fc8sl45X
	0XjrApJQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:33296 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uXZKR-00000000mGp-1H4y;
	Thu, 03 Jul 2025 23:51:19 -0600
Message-ID: <d984a233-edfe-4748-bc07-0c32f8d27458@w6rz.net>
Date: Thu, 3 Jul 2025 22:51:11 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 000/263] 6.15.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250703144004.276210867@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250703144004.276210867@linuxfoundation.org>
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
X-Exim-ID: 1uXZKR-00000000mGp-1H4y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:33296
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHk8mYwIwCd2f0qE8NlDOrGYrF58kXfgwNhdxCEXmpOyixDMKSYc8dWFoBuYvcyEERAeLf60/tVErOtVbNQlrToiqq4MBH7NkT4ynE9nI/UdMitVjRes
 J69u6I11Mi3C5KA/eOSjAQ5os2vhtUKqkT7h3jDdCNpqo+L/MLYLQ6p45YD848tn9UTx/Ks6YRLGfw==

On 7/3/25 07:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.5 release.
> There are 263 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 05 Jul 2025 14:39:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


