Return-Path: <stable+bounces-12277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 015A8832C44
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 16:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9661F1F250A1
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 15:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E1854BC1;
	Fri, 19 Jan 2024 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="2gmX27eG"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045B354F96
	for <stable@vger.kernel.org>; Fri, 19 Jan 2024 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705677838; cv=none; b=RmxT+janPqhW0V809fs6GDIEtCd7AuiPWqE1S+u410VDD9DiQZfUJcoHygstt5gmQJ0rZUVkotmLNssOw1hyasoMuTV+Inq2oWg6ZLyUUgyyccTkMGhmdpJ3ZN5nEjsw/wedrymVzC5vNX1dz6L5UPDXWJiC1gBJw8Ko2qdJ4jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705677838; c=relaxed/simple;
	bh=e2xv8wT/zdAPPJhwgsWSMFq+000fGpNfwN0B4aBITN4=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=cZYVrlM50WcYSLN4NGb2Sh8pSTAIIcrFwSG8WOh1gbwYZizy/seIWJJ56hu+MPF4rLhzWyTF7GxbQsrHuQlF4xG3K1GAN0zBw+R+EpZ/gC84/iWi7PWIeyN2iwTSMkEJrDly1zLJfH1gvXUMUZJDDfgAN5atbbG+vMbsnjldKPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=2gmX27eG; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTPS
	id QnYxrlEdzoMN9QqiprW1Td; Fri, 19 Jan 2024 15:23:55 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id QqinrA7mA1UTRQqinr23Q0; Fri, 19 Jan 2024 15:23:54 +0000
X-Authority-Analysis: v=2.4 cv=ZOXEJF3b c=1 sm=1 tr=0 ts=65aa940a
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HUpHO/TnrX9iXhkwI1KHKR3F/ekrXMrA0ZSIqYQFN4w=; b=2gmX27eGhuMKOrUsLiKOjuyfAY
	owdjIQLj4zBrmYXCo7OQhJYrNEsx/gtXMLGcIBixcfhJ/EDMP1nPE05US/NAPXjMqE8Y7b9tVhV8Y
	O/eDz10eLA5l2loN0rdZslzHTEF5cXR00pHWVmBKmGf9UC+h1ihvlayCUWr5/uOBfI2ak1PF8RCti
	FcMibtjI7uS2j+1vkQ52alod1vD36Lc+G8QB7BVvhOrFk5JtYYXtwIsY+Iyrn9gxPs6jcLivESb7F
	oXiI2x8NfzG/s9zaixHISJTlH0AEU5x+0dfatbYSpDooTMraxWgTbhd1SAaRpA/FjC/HrhJ9Bx6ac
	qzQMyqeQ==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:35932 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rQqil-001akm-0o;
	Fri, 19 Jan 2024 08:23:51 -0700
Subject: Re: [PATCH 6.6 000/150] 6.6.13-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240118104320.029537060@linuxfoundation.org>
In-Reply-To: <20240118104320.029537060@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <02f6279e-f081-5fc8-acd1-0ad3f4ae2981@w6rz.net>
Date: Fri, 19 Jan 2024 07:23:48 -0800
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
X-Exim-ID: 1rQqil-001akm-0o
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:35932
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfP1m1dYwuFR2/Q5pxJRoS6eidWwdRRXQW3/NutpGGZPMlTLXbZ3Kt0ttn+4Uf/cqyMt7tTPVvxiJ7OSk4y8tIGbHapUPGGvUd12k7bZQXIUxX7Bm/Gy8
 x4xalF26wtqW4a6amrWalNrXSNwCoLXpgAQkmLOwtVKqtYAzJIGxDmV81XX1tNxEO5mRZ3XfGMpurg==

On 1/18/24 2:47 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.13 release.
> There are 150 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


