Return-Path: <stable+bounces-171758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AE7B2BE93
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 12:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E2491886738
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 10:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2940331E0F1;
	Tue, 19 Aug 2025 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="He23El2/"
X-Original-To: stable@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D903451D3
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598311; cv=none; b=k1vHkXMiIaHNxl2niVz5lmg/uLqtFXHq3NMkBb3nZJUsdjbce3/2r5pQnzF1u+bAj5IUoPvlT1WZpv4y9foIEzvUq/dWOioMpjXRYCsXUJLY5XolVytIyWR26DJl7TowY6OsovKQaCE2+wECVnLGiYtq76jcvypv+YLS7+Qi1+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598311; c=relaxed/simple;
	bh=qGOeN9G0GOVrGg/LZcsAF/tb0ZSoRNGCrLQuN4OaQ5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aYUdDXJXnbxY/tgaAvacC9P0IxlP2G+/TAoNu/hi9hRoHLLgDA9BFgNmYyXKM3kNc3SQ/1i9LzKB/ZmRwV4OreaDw5CVDbh9V888jlhZd4SogKCBcsjtMhAnOQ1HNAhtlXo9cBixmcquCvgSeD1O2ncktJANGlIzPz/vQ/YsYFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=He23El2/; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id oJIWujWtW3e9eoJJfuA5IA; Tue, 19 Aug 2025 10:11:43 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id oJJduch7JXZDSoJJdurphR; Tue, 19 Aug 2025 10:11:42 +0000
X-Authority-Analysis: v=2.4 cv=SdD3duRu c=1 sm=1 tr=0 ts=68a44ddf
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
	bh=zkcltEHC+5PUp5pdWSPG1bQNOG7bmN5S7wIPvuz9Rs0=; b=He23El2/cA5tokK12YA8w3E2qC
	mqwOs6/URs1tavdxypbINjCtTUbr5ADhhg1iJISfyX2fKmwBbQplwBDxVtVT4wlF62iLRoHlKxm1/
	sRyC5Nh9lS6xRyX3N/ERgogjUJS6dcb/pMNRtpV+T1A5CWegsKdzXEPxDthMky+TdoOdzB0bncV8i
	AaQTpay+5OLlqZydsiu7zIx0Re2/LrZ+0BPiZBu/P47WYphU37xrAs7zAY1ati9On/0z0QXj9taWS
	Ba4eT5/MOl8mXqOQFzd3HTy8eC0ueL/JL7b/Ghkz/y+N2TMPD4Twv5lPpAwGX671ANvk1Gg0E9eLn
	1PgxGfpg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:59336 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uoJJc-000000022WE-2M3v;
	Tue, 19 Aug 2025 04:11:40 -0600
Message-ID: <0982571c-d1c6-4475-a0b1-dd045db2b96f@w6rz.net>
Date: Tue, 19 Aug 2025 03:11:38 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 000/515] 6.15.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250818124458.334548733@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250818124458.334548733@linuxfoundation.org>
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
X-Exim-ID: 1uoJJc-000000022WE-2M3v
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:59336
X-Source-Auth: re@w6rz.net
X-Email-Count: 39
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGP2JxSnf3D9o+HhLYSZ+0MgCvEzsf1s/tKxqZnVvdSHJCLt6sItKvyNUd9Bmm4t2Lp3XjljDLfpMysCQQyFXepFFbmp0+fWEiJ67Y992boc3RzBucIU
 qDS1sQloMxYGVQiKsZTjT0+3Z9Khs6eD0LkVGkPvUR0x4roLLiffJlqx0v6LLmuFWYZcbMNXVUKzQg==

On 8/18/25 05:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.11 release.
> There are 515 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 20 Aug 2025 12:43:43 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


