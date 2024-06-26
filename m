Return-Path: <stable+bounces-55844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C6C91816B
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 14:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E9EE1F21E28
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 12:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3068817E918;
	Wed, 26 Jun 2024 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="yKDj76/K"
X-Original-To: stable@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D264A1E51D
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719406302; cv=none; b=KoshQeajP30nZhWXQbYszoGbt1v6sQmgcTix2vOP9bUc+SszRxAwsVzI/JqlBGU4ihT2dMz0AHfN54Vdaq9s0TxicCoi0xWjOq2VYet2H8aU9w87v+qOb82aWxZ+rBhFmAIe0k4V/HP0Ap9SLDoVEoit+qCiNthnb3DgaUugCSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719406302; c=relaxed/simple;
	bh=R/qqw2Xg5iB28RKOwAp2AWcbCKdP/ujxQsUO8wkXmJo=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=t30yk9DnBqHxZrVowPbYxXRorrRXFIdTxb1zW6YiOL1mZifiivPhIDtwn2ticTQmfhDSM7vod+B4mCVN+lYmZvfCyg25forFUiWrJwkktNJ+OH0iLOMkWaXabMZW+MS66+OfmTGqQvGRSKgF/94CHfbJd9858RF/XVgbiErnWmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=yKDj76/K; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id MN4hsHUROjfBAMS7Zsv9GB; Wed, 26 Jun 2024 12:51:33 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id MS7YsfKsBGDpmMS7YsQcmQ; Wed, 26 Jun 2024 12:51:33 +0000
X-Authority-Analysis: v=2.4 cv=A69qPbWG c=1 sm=1 tr=0 ts=667c0ed5
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=nIAznLeY9BhABaY2-0MA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iv/ceOa6CGfDYsNcqElj7D/zm1wxvv47rg90XcoyAgQ=; b=yKDj76/KGw3X2ZfQEQc7NZJQTn
	lXEA+3bw+VxWHxxwrbOcP0yM/eaGQzHuptzdrEGtTZm3NmDB2zmBp6XCajhifb+TwfbBJ8Qo+w9lN
	TARN1QZZjHYrnMXIUch3l5301dSxQEB/9caGtQJDJdDCUtdMeF76s9CUXSH1mdS1ZvrmpgmsD9a2O
	lveu7NTEpVC8KXkU6xicfkcQLGmXb5KZhK55SfT3+odFDlMFud79DDZkt1DAfDO+3HI9cE6rCvrzE
	YiGK7a+ICA4G6zKtsbj6WGO3wtJkXQ/WlyPadQxblkd+xlPjyVDUCyMiroZ19sWsj3z9QdmuXRc0+
	OqduJgsA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:45940 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sMS7T-002scD-2m;
	Wed, 26 Jun 2024 06:51:27 -0600
Subject: Re: [PATCH 6.1 000/131] 6.1.96-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240625085525.931079317@linuxfoundation.org>
In-Reply-To: <20240625085525.931079317@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <e1e4a459-6ca9-1113-061a-cb0a546ac987@w6rz.net>
Date: Wed, 26 Jun 2024 05:51:22 -0700
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
X-Exim-ID: 1sMS7T-002scD-2m
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:45940
X-Source-Auth: re@w6rz.net
X-Email-Count: 40
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfByM2sh8DYyirjIQupM551+z3u3V7ENok8SXtpqa6Hf6HHmSKGr1D0POAFL2VW3Znj4qcXfewVRZ/Cl72MZvXNtxiPBvFIgNtIbmh31L0TQn/T6HmDJw
 GTwqS7a5hzoIsoxe4zyot0VNgZHBHk760QXV4ZJHXFYW5oRi5ZxTFWYoihUD3Au/d2eixGPbPd1tEQ==

On 6/25/24 2:32 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.96 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Jun 2024 08:54:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.96-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


