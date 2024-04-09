Return-Path: <stable+bounces-37836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6C089D0F8
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 05:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB421C2410B
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 03:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1CE54BCA;
	Tue,  9 Apr 2024 03:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="sn71H8Ti"
X-Original-To: stable@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6506548F9
	for <stable@vger.kernel.org>; Tue,  9 Apr 2024 03:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632816; cv=none; b=a3WWBv832+IadHWcp3pq2kGa3i4A2fwWe1jCfs7Kf4D5i5AxXL0TKd2aJgPRCmdCStqZxrh+EEkZBEf/uWF14zP7BfRLkZf6e/1NAuq6Lx/YQzxRI3XKYUNK4q512/GJ5PO/Febc5+m9Te53CclHhiYQfJsyyOGD6ZYAOoW8N14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632816; c=relaxed/simple;
	bh=zfBNbb8TrnQTdLQDPS1GKKwODIujhLMGadxCrTZDCdA=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=pAm6AjOJy8l/PGMS1S9h2WD3phxTvIkvMiBtaFQnOyF4jLnjkd2F2SdaoPRa95bV8mMfze5rhyTQSosgkW+5oMjR3f3MiXth93iWtHb+ZzI1KG/E0ZUtVKIJ7e5L0kcXHkAV8KVii/Adrut5YkzBPXiAQruJUXKjNmvM2xhRTRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=sn71H8Ti; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
	by cmsmtp with ESMTPS
	id trB4riYUWs4yTu21nr9Pkt; Tue, 09 Apr 2024 03:20:07 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id u21mrUfKYWqfju21nrJNWz; Tue, 09 Apr 2024 03:20:07 +0000
X-Authority-Analysis: v=2.4 cv=GsNE+F1C c=1 sm=1 tr=0 ts=6614b3e7
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
	bh=CJMi/Tnoal97D64JcUAlD29irEPkjmoW3B52pAAlfXk=; b=sn71H8TixRVoYLUuC7/ACfKZFP
	50tqCU0j4/TboCbbapbvD8H6TUNUk+uOP4yNaUAv1wr8b3ExpU6jhYwMow8NFqOB6wvQOb7X4jTU/
	LZ7AlWU7KDA6wP2aIPzRhphxFRLnJRXp19dFKa/h9zgIlWCQmsCj/gXA2ODOKEv8xFmU9i95H4l7M
	QriMbbrYJ8XMWATwY6losxFVTSBA9LobaIVCr5SISlvqwb7tFDMXQp/cy5Iq3JrXib3Nw9l2g3XqH
	z0G4r5Yi++4GUxxw/0u8j8TAFAskaKPnbGStZrmgdGvvbAO2b67McbwqM5MGVB2Cm7T6+CFuVk6Dc
	O4Gsh5CQ==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:56506 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1ru21k-003Eap-2r;
	Mon, 08 Apr 2024 21:20:04 -0600
Subject: Re: [PATCH 6.1 000/138] 6.1.85-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240408125256.218368873@linuxfoundation.org>
In-Reply-To: <20240408125256.218368873@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <23256c30-b49d-04e8-7824-c727ef63ecfc@w6rz.net>
Date: Mon, 8 Apr 2024 20:19:58 -0700
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
X-Exim-ID: 1ru21k-003Eap-2r
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:56506
X-Source-Auth: re@w6rz.net
X-Email-Count: 40
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHhksTurcmadQyJCmtO5uGDbII618wwIkTIuMCErb3O8jWHT5SQzVMaja1Y2qYLLNtWbgV832ppkKt2qZiq5Z8MeSX+Rs73rEqJatgaQ086ZzNjWO+av
 bcFbwNm1sY0ZeeEqqAEXDyoUjCAUaQdmrExMu7aGNMohXLv+AZIxuK3ho/51K9WdlsLe58pNGAK49A==

On 4/8/24 5:56 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.85 release.
> There are 138 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.85-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


