Return-Path: <stable+bounces-21840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F55785D84E
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E699A2848D6
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 12:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0DC69D28;
	Wed, 21 Feb 2024 12:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="qPMPmOuq"
X-Original-To: stable@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BBB69945
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519948; cv=none; b=aBIX2PG1XrRDifffTBaqhphqMAiKbPU2i2avI/9s40++yHJK4vwTwYvVU2ca9FH/SXCnSpdYBr2y1fYdNYolukNZa4xCRFaFhcQEfTZB89IGiNbht43ti/heN5RS9yxf0DtVbP7ADt3AKkeCJVOnuKswJPVJQvauNJyxMA6bsxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519948; c=relaxed/simple;
	bh=YfrhMTVoCpaOCwGuwxadanUe9z7a5TmiWwldvqLyFq8=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=jZbX1sVuBWQTtChpyECt1LiKuFPlCPSIgxjBFopBdd3W+Ol3ZURkV5AGGy0zHME1E9AbyjkgGqEdb+ZIRYnslFdyd6scxIDkYfT8syMpDk0YnI5ZmAlOTmNTgcx0FyzY36dTYJa8b2u7rX1xDAIkVumjJozIIiLhaK05GipiYyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=qPMPmOuq; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id cjF4ruCJRpUFLcm5CrILuj; Wed, 21 Feb 2024 12:52:19 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id cm5BrvMbse0nBcm5CryyTH; Wed, 21 Feb 2024 12:52:18 +0000
X-Authority-Analysis: v=2.4 cv=Qr5Y30yd c=1 sm=1 tr=0 ts=65d5f202
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=L9Sf91wUQ-ZH2L_8bsYA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yNckihx7BDHuMnmfBTKPKPzdPGsXM9jOTwLQjrapyJU=; b=qPMPmOuq8Aq+OObKJg0c7Tl18b
	/jshCO8TL1KkT6vwdoDTjerFv6oCSqyOf6GkGP5fDEb05Gn5WZOsFCe1X0dfZvU2i05vQlcB9ybH9
	lH1r1YbMGQE6D64gyiWeo+4Y0numuLwIfLSMZxyCGuS7ffkeHafju2rTbSudfPuO9zbLM8v09IloZ
	z89FMrN5zaen8rndZ2FnKG7uqtnUY8hMx0xz14TzPBy/QBq+MmLNYcTIduhaMBUfh3dtVP+Fr6LBr
	iQmhUIA0UZUXjrq8UHWv91y9sB0JSA2whWMEophOC7PG6nMukn56ivTOCWdN1iuVFeXONU84aCtOl
	QwD0dQWA==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:47092 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rcm59-002mw4-2O;
	Wed, 21 Feb 2024 05:52:15 -0700
Subject: Re: [PATCH 6.7 000/309] 6.7.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240220205633.096363225@linuxfoundation.org>
In-Reply-To: <20240220205633.096363225@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <11360706-9148-30d3-a4ea-84dc6478cd45@w6rz.net>
Date: Wed, 21 Feb 2024 04:52:13 -0800
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
X-Exim-ID: 1rcm59-002mw4-2O
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:47092
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJDZsw3PdoGhfx6LZxEFYBVWp2K/9xRuc1IbJhJn56fahDz5wjuduK+Imewwd1kAfSXriXAP4bM7umF9jz6IfBNzeWRC1BeL7TscpHUWprI0W3MQb4dp
 SHOPhFxkplm4fmUat1hnAf0K8qCRSGHiY/sIiP/PjGosQ5Sig4ltw8f8pQcKBsmUrp+7VUbQfiZHGg==

On 2/20/24 12:52 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.6 release.
> There are 309 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 22 Feb 2024 20:55:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


