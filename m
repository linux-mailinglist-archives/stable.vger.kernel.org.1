Return-Path: <stable+bounces-106066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAA19FBC7C
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 11:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22BF11886EA8
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 10:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C02B1B6D02;
	Tue, 24 Dec 2024 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="rCf98Mli"
X-Original-To: stable@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5CD18FC92
	for <stable@vger.kernel.org>; Tue, 24 Dec 2024 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735036238; cv=none; b=ijvGrRnO5UTO1yqFNxMNZqftACEfMMrKuLFz+BO7lf/cWWe2rvRb5gZ/aZVZtEl+s3EZO1AAAVwUOk2PSTHoJ7akbfgP+4SB5kpLHov4v2UdcIRGfAiuYGM4cgYhIbWZu2oI4FQEr9QS/unrBFLF4IGutMCEoU36kMzyRWiNJFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735036238; c=relaxed/simple;
	bh=UECQQM4270OQKlYDyGVADEYhY8C90fPmxFK4tNiK3Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GKU6ABfAZ+hbid6o78HNnCwc/6H0+4k4dRGhPPwTDtKLTSS7fMTGz1riFHoFFSaFuQ6Ad18qTFLJZS80uz+im7Q/O/O+Bgeg/pGHpw7pkyZgPKrrOevJmeOSjZ1W15wI1UGUvpsd2b5fsgtzSHDsqnuvIHljpnZdKLR5Bkh6uBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=rCf98Mli; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id PxxitoN9mjMK7Q2BJt6gSl; Tue, 24 Dec 2024 10:30:29 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id Q2BItEPwijcdmQ2BItn8eu; Tue, 24 Dec 2024 10:30:29 +0000
X-Authority-Analysis: v=2.4 cv=DrWd+3/+ c=1 sm=1 tr=0 ts=676a8d45
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lO6PB+swH4rGeolG2a1mFmdAYcsiEgNCn4V6FTGygHg=; b=rCf98Mli64ZlKvx4gAYeVqm+Tp
	Pn7IWntMA4VI9LRvlBdiIJ5JK+RxrH33+JTVO20BO+sWBSv1IB8r+bTT8ischpNmtCiUsxdbl/ZOF
	yMCj91ifJ54TOemPBznYunopX6xrxQDCzw3xugNgrXRIRcqHw4Q/mrB+Cml1T2T0Y7DMXUoBC+C21
	rhGRv/Dv0r8wjhwFlrbVSuOR0ajpLcisrH/GbAlcdjwA8ltTysfQqIQo9Mzv3f5DPU9t6WVv0NVxL
	KenC2FTrj/3t3urd02MM8N9EbwJvkapN4oE4kWU4j3tjR4254x9fME1YfJ1LOXBI3X3GHH1TPI79E
	PwSYdYKA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:57086 helo=[10.0.1.115])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tQ2BH-002VTm-1o;
	Tue, 24 Dec 2024 03:30:27 -0700
Message-ID: <13394971-92c4-4bb0-ad01-b1d9e697c53f@w6rz.net>
Date: Tue, 24 Dec 2024 02:30:25 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/83] 6.1.122-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241223155353.641267612@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20241223155353.641267612@linuxfoundation.org>
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
X-Exim-ID: 1tQ2BH-002VTm-1o
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.115]) [73.223.253.157]:57086
X-Source-Auth: re@w6rz.net
X-Email-Count: 56
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGKUqaJJ6PhBU0TLEO0xtPNtGzByfUxlAyJd4X7VyXU4K7BTM+Sxy3IDJSPWlA61fMtd8YWVoxUf4CVyfopygwp2eurvlMuAg7duLOcN9cjUZ7aK5tnG
 ccO/J4oIhsKFGXsh0K9S6n+ziI7VLP5GD1g8g9uVfTTahQqSFiXZfyjLZr3r/4mJjcNi6BrzFmUXwA==

On 12/23/24 07:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.122 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 27 Dec 2024 15:53:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.122-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


