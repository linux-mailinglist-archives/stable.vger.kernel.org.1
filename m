Return-Path: <stable+bounces-35531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C03894AB7
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 07:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 767D8B2258F
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 05:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50F41805A;
	Tue,  2 Apr 2024 05:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="lwmvRiPr"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FE5F9DF
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 05:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712034077; cv=none; b=NCCELX/y+7nd0WGLP1hgbPXHMDdk+tK279KSrIdaXTnL5FRgbWXjXxfTEwQEwyrxkmlZtW1oM9JMP78uumZNuV9aEG+/CwWAc37aTaVuBIO1mzkkv78Uyvpzfh3IIVM1WU5IAEgNa86xzDsAQ8tjm5QZpmSeczacd8be2g15Tzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712034077; c=relaxed/simple;
	bh=vxMfyryBymNd51hdP9pp3Co4EevWHdFF4z4pYAFAPU4=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=OoLTtiSRog0NYG1IMJz9QQBJQnEev3EZqaunY2UUEzxqltJXsqU7LpL873OdYhm/EthbWvkb3uSNetacqORAolIWloSleAWspZ7aZSXN4SgMEmUzTGr5ymeohtGmqUwnf12yg86dVKLpwiobB7T0e9d5zqcD8ToLrpm9RpwGfNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=lwmvRiPr; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id rK6Mr33b1PM1hrWGiria4y; Tue, 02 Apr 2024 05:01:08 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id rWGhr70clYakKrWGhrwI7n; Tue, 02 Apr 2024 05:01:07 +0000
X-Authority-Analysis: v=2.4 cv=a4T79lSF c=1 sm=1 tr=0 ts=660b9113
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5oy+DDncNRRfUO3SI1ew6LFJx9MNBFIdpIU5chQzpbU=; b=lwmvRiPrOgg0KyQh1uYZOnyjlT
	KOFhEhHWi15KgOPIU5CZzlNY3T/KLZVPio23IJSmnxtsS68yacUS5Okz8NjmBKAltIBgSC46d8jsw
	Km9ZEACpNmufI/a+N3w4GeVNRzyenpBDgUAOgf9YOu8567cJ7c765PBD7tnXQNCNZNPffd3f1L/Zp
	1V0zoYsbS7McraPaAthuPjgTpFBabcuZkvUHdbLc7iF0TqB0YYVBgdczJWIhMsgYSrQiZBiLU6XVS
	0i7Nbg/xQXHnhqXIoFz4oF/PNGxLkY/9r48I8LudymixthHAwgTpe1fvEJSc2FQU1gKmu5sAs3Q94
	wO9H3Fkw==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:55178 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rrWGe-001nmT-2T;
	Mon, 01 Apr 2024 23:01:04 -0600
Subject: Re: [PATCH 6.8 000/399] 6.8.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240401152549.131030308@linuxfoundation.org>
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <5400491d-e467-8a12-d7fb-6581efe86e1b@w6rz.net>
Date: Mon, 1 Apr 2024 22:01:02 -0700
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
X-Source-IP: 98.207.139.8
X-Source-L: No
X-Exim-ID: 1rrWGe-001nmT-2T
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:55178
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfG1bIPG8Uqf3fbY2SGubDOfWhZgItdoav2VqG2aBwQ7Kc0ZtPDLR0P39FUMBAG6v03r/6Hpe/Ejv1qeDJ5uIEj3hr7dxfkqCDA4ElYOHwlklQgFbPbEP
 rIe0dtxju6rx3Yetg+5uodQJ4FZdNIcdpDurnqecjMASp6dmmkiT2r6TtqczhA4nAj+Mtr6e3pKWfg==

On 4/1/24 8:39 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.3 release.
> There are 399 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


