Return-Path: <stable+bounces-17443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F669842D02
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 20:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49F8AB26CB1
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 19:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF467B3F1;
	Tue, 30 Jan 2024 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="GSlmp0QG"
X-Original-To: stable@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38187B3EF
	for <stable@vger.kernel.org>; Tue, 30 Jan 2024 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643428; cv=none; b=T89tw95C2JsWMK7HISNEn+NMdoHldZwBRc+Ht3lweZXvF5hbD4vnMIKxywjW6mUrvSFUSCyrbaNnZE9gweYnJn7y73FoI1Ji2lvdSYFXIisPDpkuO3Xid9/UqAnrHQSHaBBg07y3CFS24HlfZML+AP6f1BC5SJccuVkIbxlJ+5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643428; c=relaxed/simple;
	bh=z7e0oDXwsPNLDHSaB2dgT/ViOWFl8x0haXBLj3tiw7s=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=WCqSSjx3jy+0wx+tNAcX4uY7k7yiFeDoUDA/WRRl36UQLPi06c3L+vQyfjQjLRXiczy4LxfO4K9jFABaVfnUqGiPT9T8TuhgYlULQyn7v1PJDbTViernVGjto0bo7k7JlKwc1ON06N8ZiSslSzuqIXJcRcdpMHn2HxZivLpq3kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=GSlmp0QG; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id UsJJrTTie9gG6UttJrPkWx; Tue, 30 Jan 2024 19:35:29 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id UttIrVhz5JLOTUttJrBDws; Tue, 30 Jan 2024 19:35:29 +0000
X-Authority-Analysis: v=2.4 cv=SNhR6cjH c=1 sm=1 tr=0 ts=65b94f81
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AQD6Ng23BqyD0esAEoD4EqxZkZYqG4sWmfNes1vPuI8=; b=GSlmp0QGd3yPl80AiGn2W7G/uw
	zwDPJqWPTM2t5+WtIrQaZCOKobH8GsDaqyzVwmwISzghJ1x0jBxSusWy5VdY6KeVzh5X0XlkgrOgb
	k7MxKUZjU1aX/5ioSAa0j1jfGvQ568lGwolKC4y9ayHe2XDbvanze8x55GFHddsDKLgsUvDJlItz7
	FYHnz9AeACCujy9wvmEV3W7ZCRJL6GKBavwEdksubk9Co2Lr/EojCeSsr+016jLj/td3DRKKJOUAc
	prOUycwMwtIAtWI9OnAcIdQD/EcNvT/NePoRNouCYtcYn0dqVWzCx5tZOm87Dhv3b4k95vGcQcxDd
	ry/VXgkA==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:37610 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rUttG-000EDS-0E;
	Tue, 30 Jan 2024 12:35:26 -0700
Subject: Re: [PATCH 6.6 000/331] 6.6.15-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240129170014.969142961@linuxfoundation.org>
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <7e9cd7e6-af54-5c1b-ef36-d14aedf13194@w6rz.net>
Date: Tue, 30 Jan 2024 11:35:23 -0800
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
X-Exim-ID: 1rUttG-000EDS-0E
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:37610
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCzD1N4hp/+I8TsNnEHpLauZakyNR/f3jbqYkNFU9pRRm62ZMYg57zT3IoLz0SYCGGV77omGFCdupzWhvNOFDLbm9eK8wPwcJYP/EdgGEk4CXZH9aYGK
 Y3YVDu38g9koX65gacRbruZ8q1K4dqgYxGwW1zojRW1vbajIWSs32WvMQDTVGbnFPDcVAMtJgJKZEA==

On 1/29/24 9:01 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.15 release.
> There are 331 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 31 Jan 2024 16:59:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.15-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


