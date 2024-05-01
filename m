Return-Path: <stable+bounces-42856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2B48B8700
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 10:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4909EB20ECB
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 08:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D93A50277;
	Wed,  1 May 2024 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="K91ALAuM"
X-Original-To: stable@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D0B4F881
	for <stable@vger.kernel.org>; Wed,  1 May 2024 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714552803; cv=none; b=B/+DvHHdg8M4i68kIyJVS9wtQcMjvLIf0KnDvkGjtyzwMATPOO37/yeRsNhIV6Ov2BnaPYr9aQ8q9HWK4SbwrteqqB4cjC+Gy/RFHRg6GtYI7AE8Az4V83Rw5a0CARgzrDUUFl5Ggk3XwZ1RHAdvc29yTnt23D7+Z/UpIxubjJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714552803; c=relaxed/simple;
	bh=x6ft1Jcm0EILoaZgPxFyo7LXrsSW7LCHzJthY52Vju0=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=VVp9Hp5/imyi5zxbNc86Qqcw1ZaXexJBoxx+L85nLcJC6OeJ7Xl4arlFOdOJf5DdNiaEWEqqlYnir86mcOCozruwXKhnKZ47CY6I2NIUoA4q2yrxHL2xQEVzn4WFLZYXjWKq3yHZ2vO8uOkl5tuLdeVbQaE1Xv/mBDxtWwhTc/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=K91ALAuM; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTPS
	id 22gRs1q53Sqsh25VKs8O4A; Wed, 01 May 2024 08:39:54 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 25VJsI3FKHHoA25VJskQdO; Wed, 01 May 2024 08:39:53 +0000
X-Authority-Analysis: v=2.4 cv=dskQCEg4 c=1 sm=1 tr=0 ts=6631ffd9
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=TpHVaj0NuXgA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=w3vtCogE_fj71Z-Hq2MA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JTzrG8j/85Ys+IsaNyR0AG//KA4Y+7q9PmrPfJY2WQ4=; b=K91ALAuMMVaZe7uKu8LQvMR2f2
	IdgNiId7VFMqQmfxoPqn3HPwAxMiVfqWYSh0iI4c3+fIQuEjlpce4+5shUxSVgo/t5gkkfoahGi3Y
	v2XN6JxBX4RAKgVHnwA107yGSK5LUYl7e12u3cPE4zgIMNx7pmdnMT8jWPKpwQ+m7HT3ddaczPCsb
	krwCAgkyDRCzabPH5EQCw6t4pB48AC/rjsIzHEqU/6dh1Oy9QzRj3h06voGgXsAo5kkjuiE8ecxRq
	UgJ6Zyo9pZxCoPwB01hWlfEkbgeLyURgs3KT8qT1If7ntknwOZBQ/CD9TXR9rybV4mx5K8xhl+QWE
	+ArBgRvw==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:60594 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1s25VG-0014DE-0h;
	Wed, 01 May 2024 02:39:50 -0600
Subject: Re: [PATCH 6.6 000/186] 6.6.30-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240430103058.010791820@linuxfoundation.org>
In-Reply-To: <20240430103058.010791820@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <7377e030-7c7b-7d7f-d823-2ac5d1bd06f8@w6rz.net>
Date: Wed, 1 May 2024 01:39:46 -0700
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
X-Exim-ID: 1s25VG-0014DE-0h
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:60594
X-Source-Auth: re@w6rz.net
X-Email-Count: 21
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFuN+CkxkK00th27+ij0vw3JwS5YsHKzzxjM/GDQC59vQY/7jN14aHeJfONBy9CpTh7XyGr/WGqBNj2MI8uWmg7+wvk994lvt6t63qhVuN6u67DNnxwY
 lJKWwv0zTaR8b7dqvr5WM8BOT9Dp2Kb0R86sMdBiE7cx7xa9GCuazkhZ7wn4X6tIANcIch6NlFTIZA==

On 4/30/24 3:37 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.30 release.
> There are 186 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.30-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


