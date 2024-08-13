Return-Path: <stable+bounces-67540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F859950D34
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 21:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4D73B28FB9
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 19:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB60C5589A;
	Tue, 13 Aug 2024 19:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="sYZ5UOyP"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90162200AE
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 19:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723577699; cv=none; b=s63DDyF6hOxpGKHG0Qnotejr/1hK9J/P+Zra0v6yazVLP9F0e578WxyKM72t+X1KI/7ArmRVpoRfEPA6MNf06nAC0/0kmtJ8rj4WbZ4S5SslI3MxY5lRzpyoWaLdvyno74mIiBw61SWJxTtUJ/MAewA1bzF/hsGE5Dygx7IKnyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723577699; c=relaxed/simple;
	bh=ZFFkBemZYXMfJTrJ16nlNa4G5C16bXE4SMid+vvHNdc=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=lclDx7XGun9DdVs1+zPSrD2BffdEdL7jfwOhHa8BiMWe/HrOJkzGm1vGIHTURhE/l2MUMDHkYsssS1eSvh8wYbV86fEZpmBi8QZUY+JEEEruPSfXmQdkXX8voFsKDEPSZHBG3lgKHwvtxRoyuwzJ4TpQne1HNPcDgj5wknmhORA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=sYZ5UOyP; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
	by cmsmtp with ESMTPS
	id dupnsCOAFumtXdxIBsttgU; Tue, 13 Aug 2024 19:34:51 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id dxIAslhrCZlJQdxIAss8q9; Tue, 13 Aug 2024 19:34:51 +0000
X-Authority-Analysis: v=2.4 cv=DMBE4DNb c=1 sm=1 tr=0 ts=66bbb55b
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=VwQbUJbxAAAA:8 a=HaFmDPmJAAAA:8
 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YHV3n6B+AhcPJnlvCudd1fzr/iCQeRxv0rk4qWODO3s=; b=sYZ5UOyPcx+lQkLayrTohl2TvJ
	s35xpT0cMcWSKsR+sVbWJlXqhAVXE9jNmP2GYera70Nc8dvHSDbkcf0VacSLeZFTsIVA82SW8LS2h
	wsgPygo2n+vSiQQVz3ybmXxiBdGxwOVVnk8Lo7QEpTwPvy/EmioL6o53M5GGpbBkLy+yMazroxYZC
	+VbVUNO/j72OUqCMUssqsFJ06cQ0ydS5pCj7zQv+BRNuCnJiIowogiPoT3OtvQ7IFEQ7SurrK6qXD
	KVDPiFmHlBXr9H3rWbGd5hdhirkAmGjdzfixSr1gTrZGcK/9KMafv2oV3tGtUyX1Ea+n1jHieKUf5
	UtP2/wyw==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:34476 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sdxI4-0004QF-3A;
	Tue, 13 Aug 2024 13:34:45 -0600
Subject: Re: [PATCH 6.10 000/263] 6.10.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240812160146.517184156@linuxfoundation.org>
In-Reply-To: <20240812160146.517184156@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <7733e3df-dec4-4b3a-ca4c-0a375462f37b@w6rz.net>
Date: Tue, 13 Aug 2024 12:34:38 -0700
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
X-Exim-ID: 1sdxI4-0004QF-3A
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:34476
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCVqdFqVZp0XHzSe/oHrTckPVanhhmYJZmiMB0L3I2HC5loKSNXIde6GzRUkKh2lTz5LCtgjTkvadeqae7h8hVew5VmPdjY3C+mLuzbO4bEREXeVnbTg
 V5GiFxIu1qjBiS6XgO3VqSSBCYT1HApZDanKUXJG+zNLRrgP5KiWm+OQR10B+zVI+E090vLh+eBLig==

On 8/12/24 9:00 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.5 release.
> There are 263 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 14 Aug 2024 16:00:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


