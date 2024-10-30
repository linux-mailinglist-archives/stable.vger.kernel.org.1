Return-Path: <stable+bounces-89283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 880219B5937
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 02:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6531F23F2B
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 01:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D508613B29F;
	Wed, 30 Oct 2024 01:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="4oKk2alN"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C9B1917F4
	for <stable@vger.kernel.org>; Wed, 30 Oct 2024 01:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730252368; cv=none; b=cNJfxNk5vjMDs6JHUFB3Qe5AZtK9QWIosOkV7Dkm8Q6psEv7UR/n5ZHgbIjbmZA9g0lcwpn1HuoCOhrvRCNnnfpdWKUwenn1fJMgUKt/AGSJZMbGQPWyP1KIEhoEcVjbTZWkFrb4hOe5zGAcCMqi2ovoJAzxXcApYS3Kwzfe2w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730252368; c=relaxed/simple;
	bh=4TEjeKATJgx/DsL1fZt+CskwoERCXkvbkcO7a6U9qb8=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=TxT9npUgFv9T0KWjDGmYK6rPAkEpRrRR+S3f9lLVMJeD7l0iNdSl6NRgbkrhWbjbAs/SRy4D9n+4RNQrjP6FLt3umD9lB+n75AjKODdEw0szSsxnt7kYMFe1RX2lPJebshPJzm9jcvSCtBYVb9dlSuxOsUn8Juopu9GRjOzq1is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=4oKk2alN; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id 5PoqtUXe1vH7l5xg8tb7HX; Wed, 30 Oct 2024 01:39:20 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 5xg7tfuL2827n5xg8tXvvN; Wed, 30 Oct 2024 01:39:20 +0000
X-Authority-Analysis: v=2.4 cv=GeTcnhXL c=1 sm=1 tr=0 ts=67218e48
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=4Na9fpYnh4hjKbwFJnwA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RO0CwdqMBMddgOUS/JMZTYpGLtRnrUN9C4iHgeaf0gU=; b=4oKk2alNMXmT55eA48NseU5gQr
	63UePdPPzgGV5AfkRwmRhEBzNezhlEiOC7cHJy+jyqXyyBn9+whtE/WKOaFkqwbOqF07eRtM43mSu
	Ij9xdY+QHZA5d/ZKxQoKamvhWBHq0nMwjc3DJ6w5vuMffvl5ZXp30XgmM3PSy3U9YuPQ4GqXNXwqU
	X3s74ZfwusVcoj2g+41GdTrfsjJTEwzFIUHb9ab9MR0Pev29KgIYpCyL2krxaxwqUUZdFpZif5tOV
	4GtbPgQb1zEA0zqWZdCaZZsvvLnw6z5xA4uC0101PrdhlspMOXRK6DcfMbgIHeyOGi8VzUwd957sx
	xOuTwnPw==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:36544 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1t5xg5-001Itz-0O;
	Tue, 29 Oct 2024 19:39:17 -0600
Subject: Re: [PATCH 6.1 000/137] 6.1.115-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20241028062258.708872330@linuxfoundation.org>
In-Reply-To: <20241028062258.708872330@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <023c325b-f0de-f929-dba3-784f81b58b50@w6rz.net>
Date: Tue, 29 Oct 2024 18:39:14 -0700
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
X-Exim-ID: 1t5xg5-001Itz-0O
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:36544
X-Source-Auth: re@w6rz.net
X-Email-Count: 40
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOlD5Gr6xDQsxdERQVfD9tEsSPD6atu9pipxJyeFFqv50p+G2JBwTrH1BECGwjw0TpAWyfXamoqpk5AU5C/DgFgwLpkBdEe3S2Cgnykk0+B1cZMiucAQ
 nORFW5BPSvn7W7pagm/DfitgxD3BysGaTx1zigcG62BMcKedBA4KsS6F3CoIiuP6wqh/VURgL2W7Vw==

On 10/27/24 11:23 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.115 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 30 Oct 2024 06:22:39 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.115-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


