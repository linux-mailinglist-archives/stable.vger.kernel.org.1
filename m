Return-Path: <stable+bounces-154632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC17ADE3A1
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 08:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F004F3AAB8A
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 06:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CB4207E1D;
	Wed, 18 Jun 2025 06:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="nQ0NBEVA"
X-Original-To: stable@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB44B1A316E
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 06:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750228043; cv=none; b=E06fxP/eq7SHtdjX0NNw0GxyCYvNsysBzUSO7t//MTNu+rGl1BxptR+QBBxPDWNXgmNuAvzqtCA7batzkZO82ww/CCNjXgp3kLLffTDUOVOpakAGgls6zg9lwIjRpzrJvqCsXeGojObZXo4e+9Gjd6Pk0R6hs+fbAW8dwm8lZe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750228043; c=relaxed/simple;
	bh=jT5t7In/Mh5kMN/cJpd9vTD2TL0T6p+70Ojq+BbGMJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c09g4JOTBRYiAAK7KXmE+8lo3z8YWNN+hLvxlwCnXxfc+zyfV1oRJL5V7pQYsOq5wc6xvKFumORBzhoPPUVFBXo47Tib3eEfxp1h8yruFm9AOayidjVQFnNm61YLRO07Md/OR5W0wXjXCIJYhNdOagcZBDib34pFcY3SKhGy36o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=nQ0NBEVA; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id RWCUuuPQxVkcRRmGOuP7oF; Wed, 18 Jun 2025 06:27:12 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id RmGNu4Du71vNyRmGOuJOrE; Wed, 18 Jun 2025 06:27:12 +0000
X-Authority-Analysis: v=2.4 cv=VMQWnMPX c=1 sm=1 tr=0 ts=68525c40
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=9V_ThoJpMYiMRsW8ZnoA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ovsVyXlZ2uFh6aIMBSJpvguncr/vAEivGhIDoMDyHU0=; b=nQ0NBEVAGk9obx8/AN0FvXnWhF
	xomdfw++bdp6cQrMJuNNvol3kA8EpBPluEfhbaFNPAniCH5oG+q46t+APp1k8qTKt3xUiky95uWTV
	QpbJ9LEETsvMBMIjCAWPXFz0tK49+0Oe2++pqRsba7+W0D8KMU2LlIq8yb+yE6CBaxsN/OR6N92lP
	n5OVBE1twZHUB/6wRPQu8pcWYkjHSmBL3MN8LFd7TUXNAGivSsSMZDueYwwpSwnfxoSEAkp7QkJHL
	NHcItc1WdvdIpVwamiOfyBde7YM5JieLWclUTgiYqF5VFbufkgki29fn/W+0EYRceFavyhouJS7Eb
	J3xXmZ0g==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:41416 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uRmGL-00000002tAm-0VOu;
	Wed, 18 Jun 2025 00:27:09 -0600
Message-ID: <0bf88ea6-4ab2-4b7a-bc49-45360f2b6e94@w6rz.net>
Date: Tue, 17 Jun 2025 23:27:05 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/512] 6.12.34-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250617152419.512865572@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
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
X-Exim-ID: 1uRmGL-00000002tAm-0VOu
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:41416
X-Source-Auth: re@w6rz.net
X-Email-Count: 37
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHnQzXNNepZ4c9LdwMvF3hKvPYyjZy6F8FaGmswMwfQfpzzuubA+/xzansAUdLne/luLZo6lH6cWLagWgB1Iqdd8GOtBlvfVTG67f4vl+GLjf8J1EskJ
 I73Lo6+F66676xeGZO1gfRZleFSCz/6m8XMWD4MJxUb8hsjLzU5dOiHKsrtuYo3+WUeh2y0PKANNPQ==

On 6/17/25 08:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.34 release.
> There are 512 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 19 Jun 2025 15:22:45 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.34-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


