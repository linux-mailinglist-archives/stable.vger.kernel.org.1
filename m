Return-Path: <stable+bounces-17395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0901584210C
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 11:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723711F249D9
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 10:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE85260ECB;
	Tue, 30 Jan 2024 10:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="joRP6Hu5"
X-Original-To: stable@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066EA60B9F
	for <stable@vger.kernel.org>; Tue, 30 Jan 2024 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706610022; cv=none; b=cKxS1DH+pBDVeyzsKaDVQ+d91tXVxCm2/t88x9gDu53pzKJmdyHZ1vRt9lNh5FLuqss8cH7iI5++UYtx6taMaHDPtuqOGkeFCl/OI2Of0UaO0q9Hj25KMw7gLEzqxYfWGBGhhMb36JEKjxsOo4uiOwUNynaujjKFO0setBJxmlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706610022; c=relaxed/simple;
	bh=iHbQQ3MLCCcjMAInoY2a1a8pyT2oDcS0vQnY2cfXPv4=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=mcD/n2zZGaPdjhWrB1wM1e5aTU0LJJ5ZoxBv9/rVDhYwYFskrhFx3pkGQq4AhNADCsKT84SocOwjsN/uI0dVglEOVgr7zua4vD05eJ6Djj+iaTrqHU6OorO5h2U4NChp4Bmhu/wMYFE2LMWPR8JyjY2EtxlvsLiD+q23HLsWopc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=joRP6Hu5; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTPS
	id UbXorR6hyTHHuUlDxrod28; Tue, 30 Jan 2024 10:20:13 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id UlDwrVsi71UTRUlDwr7OK9; Tue, 30 Jan 2024 10:20:12 +0000
X-Authority-Analysis: v=2.4 cv=ZOXEJF3b c=1 sm=1 tr=0 ts=65b8cd5c
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
	bh=QDmJc+5Q+8ZglzAdl2BcnLkXPCIgoF/fTkzgIRxIZk4=; b=joRP6Hu54MNNifryzWu3Xy4rOi
	XQQUmYkYX36/zGnAiAXN+joan8AbUP7d/TLcT7iGP6AKz6Ohi9Jkml6K9Xnp5VsbsViDkkUwVtsQo
	4dnIFm4Ry5vRAoiqkUHIrzsLaKV44kTZ6KcN047a1j2+2/agGw1G+V7A7aOEtZQmZYcKGC2zU4072
	JzxH7zIS5BDPCWzPceeeqaKsXx0K7xeiQrhuDqdwWUuxNlM5LbKn7hblFccNAcubLytXWXgPm0e1+
	P7bt5wfmgPj2luTquSn+EBgrhmrR/h9JbeWzUjW+ClNaFIMgvSFP+NR+lkZWvkZUkxnPPciPIYDYy
	lq5Z9yOA==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:37536 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rUlDt-001IsC-2q;
	Tue, 30 Jan 2024 03:20:09 -0700
Subject: Re: [PATCH 6.7 000/346] 6.7.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240129170016.356158639@linuxfoundation.org>
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <180be0f0-7b95-73e0-45a4-0c5fec11b487@w6rz.net>
Date: Tue, 30 Jan 2024 02:20:07 -0800
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
X-Exim-ID: 1rUlDt-001IsC-2q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:37536
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJTNVOKLI4GawUVtYcvMxno4B6BsDwATEE9MqgywJc30pEFdajHUO84Zu1Wl6n92nl2xrEf0bMHaomsFfxjh0rcMB+eA5fcrSTawc422EvLKITOSXAAA
 7WshXOwRqMF2P76bKuJo8lnDN0WKXLHbxz6vw7agwLeZQQ2/MpmwitH/X5SOWTgoURjaBQLOx40d7Q==

On 1/29/24 9:00 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.3 release.
> There are 346 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 31 Jan 2024 16:59:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


